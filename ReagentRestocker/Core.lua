--[[
The MIT License

Copyright (c) 2009

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

-- Grab AddOn info, place into its own environment. ----------------------------
local addonName, addonTable = ...;

local oldEnv = getfenv();

addonTable.BANK_CONTAINER=BANK_CONTAINER
addonTable.NUM_BAG_SLOTS=NUM_BAG_SLOTS
addonTable.NUM_BANKBAGSLOTS=NUM_BANKBAGSLOTS

setfenv(1,addonTable)
dprint("Loading " .. addonName)
--include("BLIZZARD");

-- Custom print function from a separate project. ------------------------------

--print("Loading Reagent Restocker");

printedG=true;

local g = _G.CreateFrame("frame")

function RegisterEvent(eventName)
	g:RegisterEvent(eventName)
end

g:SetScript("OnEvent", function(self, name, ...)
	ReagentRestocker[name](self, ...)
end)

addonTable.RegisterEvent = RegisterEvent

function jprint(...)
	rprint(0,...);
end

local function RegisterChatCommand(self, command, func)
	local name="REAGENTRESTOCKER_" .. string.upper(command)
	_G["SLASH_"..name.."1"]="/"..command
	SlashCmdList[name]=func
end


-- Vars -------------------------------------------------------------------
--ReagentRestocker = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0","AceEvent-2.0")
--ReagentRestocker = LibStub("AceAddon-3.0"):NewAddon("Reagent Restocker", "AceEvent-3.0","AceConsole-3.0");
ReagentRestocker = LibStub("AceAddon-3.0"):NewAddon("Reagent Restocker");

ReagentRestocker.RegisterChatCommand = RegisterChatCommand

-- Load Periodic Table, if available.
PT = LibStub("LibPeriodicTable-3.1", true)

local moduleName = 'ReagentRestocker'

-- Item property labels
ITEM_NAME = "item_name"
ITEM_LINK = "1"
ITEM_RARITY = "2"
ITEM_LEVEL = "3"
ITEM_MIN_LEVEL = "4"
ITEM_TYPE = "5"
ITEM_SUB_TYPE = "6"
ITEM_STACK_COUNT = "7"
ITEM_EQUIP_LOC = "8"
ITEM_TEXTURE = "9"
ITEM_SELL_PRICE="item_sell"
QUANTITY_TO_STOCK = "qty"
LOW_WARNING="low_warning"

-- Shared variables
local LockedBagSlotIDList = {}

local TransactionLock = false

-- Events waiting to be performed
local QueuedActions = {}

-- Static variables
SHOPPING_TYPE = "shopping"
SELLING_TYPE = "selling"

-- Event IDs
--PLAYER_MONEY_EVENT = "PLAYER_MONEY"
--ITEM_LOCK_CHANGED_EVENT = "ITEM_LOCK_CHANGED"
--MERCHANT_SHOW_EVENT = "MERCHANT_SHOW"
--MERCHANT_UPDATE_EVENT = "MERCHANT_UPDATE"
--BANKFRAME_OPENED_EVENT = "BANKFRAME_OPENED"
--GUILDBANKFRAME_OPENED_EVENT = "GUILDBANKFRAME_OPENED"
--VARIABLES_LOADED_EVENT = "VARIABLES_LOADED"
--BAG_UPDATE_EVENT = "BAG_UPDATE"
--PLAYER_LEAVING_WORLD_EVENT = "PLAYER_LEAVING_WORLD"
--PLAYER_ENTERING_WORLD_EVENT = "PLAYER_ENTERING_WORLD"
--BAG_UPDATE_COOLDOWN_EVENT = "BAG_UPDATE_COOLDOWN"
--UPDATE_INVENTORY_DURABILITY_EVENT = "UPDATE_INVENTORY_DURABILITY"

--=========--
-- Helpers --
--=========--

local map = table.foreach


-- Returns the "difference" between two tables with numerical values
local function tDiff(ta, tb, onlyInA)
	local diff = {}
	for k,v in pairs(ta) do
		if tb[k] then
			diff[k] = ta[k] - tb[k]
		else
			diff[k] = ta[k]
		end
	end
	if not onlyInA then
		for k,v in pairs(tb) do
			if not diff[k] then -- Don't use keys we've already used; also, anything in a is already in diff
				diff[k] = -1 * tb[k]		
			end
		end
	end
	return diff
end

-- Returns true if the provided item info indicates the item should be included in the offset list for bank stocking
local function bankOffset(itemID, qty)
	if qty > 0 then 
		return ReagentRestockerDB.Options.PullFromBank
	else
		return ReagentRestockerDB.Options.OverstockToBank
	end
end

-- Returns the number of all items table t; #<table> returns array count only
local function tcount(t)
	local i = 0
	map(t,function () i = i + 1; end)
	return i
end

-- Returns true if item is a value in the table; false otherwise
local function inT(tab,item)
	for _,v in pairs(tab) do
		if v == item then
			return true
		end
	end
	return false
end

-- Returns a string representation of a price (in copper)
local function nCTS(price)
	if price < 100 then
		return price .. "|cFFB87333c|r"
	elseif price < 10000 then
		return price/100 .. "|cFFC0C0C0s|r"
	else
		return ceil(price/100 - 0.005)/100 .. "|cFFCDAD00g|r"
	end
end

-- Returns a string representation of a table
local function strT (tab)
	if type(tab) == type({}) then
		local mystr = ""
		for k,v in pairs(tab) do
			mystr = mystr .. "[" .. tostring(k) .. " = '" .. strT(v) .. "']"
		end
		return mystr
	else
		return tostring(tab)
	end
end

-- Returns the item id of parsed from the provided item link
-- WARNING: Starting with Mists, there is also Hbattlepet in addition to Hitem,
-- so this may return nil!
function getIDFromItemLink(itemLink)
	local itemID
	if itemLink then
		itemID = tonumber(string.match(itemLink, "|c[0-9a-fA-F]+|Hitem:([0-9]+):.*"))
		if itemID then
			return itemID
		else
			-- If not battle pet, report an API change.
			if tonumber(string.match(itemLink, "|c[0-9a-fA-F]+|Hbattlepet:([0-9]+):.*")) == nil then
				dprint(string.match(itemLink, "|c[0-9a-fA-F]+|(H%a+):.*"))
				error("New itemID type found: ".. string.match(itemLink, "|c[0-9a-fA-F]+|(H%a+):.*") ..". Please report to author.")
			end
		end
	end
end

-- Returns the item name from the provided item link
function getNameFromItemLink(itemLink)
	return string.match(itemLink, ".+%[([^%]]+)%].+")
end

-- Returns true if the 'clue' is found in the item name
function isItemNameInLink(clue,link)
	-- Remember to escape any -s in the string
		return string.find(string.lower(clue),string.gsub(string.lower(getNameFromItemLink(link)),"-","%%-"))
end

-- Returns a table array containing the bag IDs for bank bags
function getBankBagIDList()
	local bankBagIDList = {}
	
	-- Add the bank container
	table.insert(bankBagIDList, BANK_CONTAINER)
	
	-- Add the remaining bags
	for bagID=NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		table.insert(bankBagIDList, bagID)
	end
	
	return bankBagIDList
end

-- Returns a table array containing the bag IDs for player bags
function getPlayerBagIDList()
	return {0,1,2,3,4}
end

-- Prints the message if messages are enabled
function ReagentRestocker:say(msg)
	if not ReagentRestockerDB.Options.QuietMode and msg ~= "" then
		print(tostring(msg))
	end
end

-- Returns reputation name based on value.
function getReputationName(number)
	if number == 1 then
		return "Hated"
	elseif number == 2 then
		return "Hostile"
	elseif number == 3 then
		return "Unfriendly"
	elseif number == 4 then
		return "Neutral"
	elseif number == 5 then
		return "Friendly"
	elseif number == 6 then
		return "Honored"
	elseif number == 7 then
		return "Revered"
	elseif number == 8 then
		return "Exalted"
	else
		error(number .. " is not a valid reputation.")
	end
end

--========================--
-- Reagent Restocker Core --
--========================--

-- If the items in cache, update the stored values and return it; otherwise, return what is in cache, if it exists; otherwise return nil
function ReagentRestocker:safeGetItemInfo(itemID)
	
	-- With battle pets now in play, itemID can be nil sometimes . . .
	if itemID == nil then
		return nil
	end
	
	if ReagentRestockerDB.Items == nil then
		error("FATAL: Items database does not exist.")
	end
	
	if ReagentRestockerDB.Items[itemID] then

		if ReagentRestockerDB.Items[itemID].tocversion == nil then -- Store TOC version, so we know when database is out of date
			local _, _, _, tocversion = GetBuildInfo()
			ReagentRestockerDB.Items[itemID].tocversion = tocversion
		end
		
		if not _G.GetItemInfo(itemID) then
			local _, _, _, tocversion = GetBuildInfo()
			if ReagentRestockerDB.Items[itemID].tocversion ~= tocversion then
				-- Item may have been deleted from WoW
				return ReagentRestockerDB.Items[itemID].item_name.." (outdated)",ReagentRestockerDB.Items[itemID][ITEM_LINK],ReagentRestockerDB.Items[itemID][ITEM_RARITY],ReagentRestockerDB.Items[itemID][ITEM_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_MIN_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_TYPE],ReagentRestockerDB.Items[itemID][ITEM_SUB_TYPE],ReagentRestockerDB.Items[itemID][ITEM_STACK_COUNT],ReagentRestockerDB.Items[itemID][ITEM_EQUIP_LOC],ReagentRestockerDB.Items[itemID][ITEM_TEXTURE],ReagentRestockerDB.Items[itemID][ITEM_SELL_PRICE]
			else
				-- Item is current, but server has been reset (usually Tuesdays)
				return ReagentRestockerDB.Items[itemID].item_name,ReagentRestockerDB.Items[itemID][ITEM_LINK],ReagentRestockerDB.Items[itemID][ITEM_RARITY],ReagentRestockerDB.Items[itemID][ITEM_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_MIN_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_TYPE],ReagentRestockerDB.Items[itemID][ITEM_SUB_TYPE],ReagentRestockerDB.Items[itemID][ITEM_STACK_COUNT],ReagentRestockerDB.Items[itemID][ITEM_EQUIP_LOC],ReagentRestockerDB.Items[itemID][ITEM_TEXTURE],ReagentRestockerDB.Items[itemID][ITEM_SELL_PRICE]
			end
		else
			local _, _, _, tocversion = GetBuildInfo()
			ReagentRestockerDB.Items[itemID].item_name,ReagentRestockerDB.Items[itemID][ITEM_LINK],ReagentRestockerDB.Items[itemID][ITEM_RARITY],ReagentRestockerDB.Items[itemID][ITEM_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_MIN_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_TYPE],ReagentRestockerDB.Items[itemID][ITEM_SUB_TYPE],ReagentRestockerDB.Items[itemID][ITEM_STACK_COUNT],ReagentRestockerDB.Items[itemID][ITEM_EQUIP_LOC],ReagentRestockerDB.Items[itemID][ITEM_TEXTURE],ReagentRestockerDB.Items[itemID][ITEM_SELL_PRICE] = _G.GetItemInfo(itemID)
			ReagentRestockerDB.Items[itemID].tocversion = tocversion -- Update toc version
			if RRGlobal ~= nil and RRGlobal.Options.UseCache then RRGlobal.ItemCache[itemID]=ReagentRestockerDB.Items[itemID] end
			return ReagentRestockerDB.Items[itemID].item_name,ReagentRestockerDB.Items[itemID][ITEM_LINK],ReagentRestockerDB.Items[itemID][ITEM_RARITY],ReagentRestockerDB.Items[itemID][ITEM_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_MIN_LEVEL],ReagentRestockerDB.Items[itemID][ITEM_TYPE],ReagentRestockerDB.Items[itemID][ITEM_SUB_TYPE],ReagentRestockerDB.Items[itemID][ITEM_STACK_COUNT],ReagentRestockerDB.Items[itemID][ITEM_EQUIP_LOC],ReagentRestockerDB.Items[itemID][ITEM_TEXTURE],ReagentRestockerDB.Items[itemID][ITEM_SELL_PRICE]
		end
	elseif RRGlobal ~= nil and RRGlobal.Options.UseCache and RRGlobal.ItemCache[itemID] then
	
		if RRGlobal.ItemCache[itemID].tocversion == nil then
			local _, _, _, tocversion = GetBuildInfo()
			RRGlobal.ItemCache[itemID].tocversion = tocversion
		end
		
		if not _G.GetItemInfo(itemID) then
			local _, _, _, tocversion = GetBuildInfo()
			if RRGlobal.ItemCache[itemID].tocversion ~= tocversion then
				-- Item may have been deleted from WoW
				return RRGlobal.ItemCache[itemID].item_name.." (outdated)",RRGlobal.ItemCache[itemID][ITEM_LINK],RRGlobal.ItemCache[itemID][ITEM_RARITY],RRGlobal.ItemCache[itemID][ITEM_LEVEL],RRGlobal.ItemCache[itemID][ITEM_MIN_LEVEL],RRGlobal.ItemCache[itemID][ITEM_TYPE],RRGlobal.ItemCache[itemID][ITEM_SUB_TYPE],RRGlobal.ItemCache[itemID][ITEM_STACK_COUNT],RRGlobal.ItemCache[itemID][ITEM_EQUIP_LOC],RRGlobal.ItemCache[itemID][ITEM_TEXTURE],RRGlobal.ItemCache[itemID][ITEM_SELL_PRICE]
			else
				return RRGlobal.ItemCache[itemID].item_name,RRGlobal.ItemCache[itemID][ITEM_LINK],RRGlobal.ItemCache[itemID][ITEM_RARITY],RRGlobal.ItemCache[itemID][ITEM_LEVEL],RRGlobal.ItemCache[itemID][ITEM_MIN_LEVEL],RRGlobal.ItemCache[itemID][ITEM_TYPE],RRGlobal.ItemCache[itemID][ITEM_SUB_TYPE],RRGlobal.ItemCache[itemID][ITEM_STACK_COUNT],RRGlobal.ItemCache[itemID][ITEM_EQUIP_LOC],RRGlobal.ItemCache[itemID][ITEM_TEXTURE],RRGlobal.ItemCache[itemID][ITEM_SELL_PRICE]
			end
		else
			local _, _, _, tocversion = GetBuildInfo()
			RRGlobal.ItemCache[itemID].item_name,RRGlobal.ItemCache[itemID][ITEM_LINK],RRGlobal.ItemCache[itemID][ITEM_RARITY],RRGlobal.ItemCache[itemID][ITEM_LEVEL],RRGlobal.ItemCache[itemID][ITEM_MIN_LEVEL],RRGlobal.ItemCache[itemID][ITEM_TYPE],RRGlobal.ItemCache[itemID][ITEM_SUB_TYPE],RRGlobal.ItemCache[itemID][ITEM_STACK_COUNT],RRGlobal.ItemCache[itemID][ITEM_EQUIP_LOC],RRGlobal.ItemCache[itemID][ITEM_TEXTURE],RRGlobal.ItemCache[itemID][ITEM_SELL_PRICE] = _G.GetItemInfo(itemID)
			RRGlobal.ItemCache[itemID].tocversion = tocversion -- Update toc version
			return RRGlobal.ItemCache[itemID].item_name,RRGlobal.ItemCache[itemID][ITEM_LINK],RRGlobal.ItemCache[itemID][ITEM_RARITY],RRGlobal.ItemCache[itemID][ITEM_LEVEL],RRGlobal.ItemCache[itemID][ITEM_MIN_LEVEL],RRGlobal.ItemCache[itemID][ITEM_TYPE],RRGlobal.ItemCache[itemID][ITEM_SUB_TYPE],RRGlobal.ItemCache[itemID][ITEM_STACK_COUNT],RRGlobal.ItemCache[itemID][ITEM_EQUIP_LOC],RRGlobal.ItemCache[itemID][ITEM_TEXTURE],RRGlobal.ItemCache[itemID][ITEM_SELL_PRICE]
		end
	
	else
		return _G.GetItemInfo(itemID)
	end
end

function ReagentRestocker:getSellPrice(itemID)
	_,_,_,_,_,_,_,_,_,_,price=ReagentRestocker:safeGetItemInfo(itemID);
	return price;
end

-- Given an item's name, return the item's ID if it is found; nil on failure
function ReagentRestocker:discoverItemID(itemClue)
	-- Look in the player's backpack/bank
	local bagIDList = {}
	map(getBankBagIDList(),function (_,bagID) table.insert(bagIDList,bagID) end)
	map(getPlayerBagIDList(),function (_,bagID) table.insert(bagIDList,bagID) end)
	for _,bagID in pairs(bagIDList) do
		for bagSlotID=1,_G.GetContainerNumSlots(bagID) do
			currentItemLink = _G.GetContainerItemLink(bagID,bagSlotID)
			if currentItemLink then 
				if isItemNameInLink(itemClue,currentItemLink) then
					return getIDFromItemLink(currentItemLink)
				end
			end
		end
	end
	
	-- Look in the merchant window, if it is open
	if _G.GetMerchantNumItems() then
		for i=1, _G.GetMerchantNumItems() do
			currentItemLink = _G.GetMerchantItemLink(i)
			if currentItemLink then
				if isItemNameInLink(itemClue,currentItemLink) then
					return getIDFromItemLink(currentItemLink)
				end	
			end
		end
	end
	
	-- Look in the items list
	for itemID,data in pairs(ReagentRestockerDB.Items) do
		_, currentItemLink = self:safeGetItemInfo(itemID)
		if currentItemLink then
			if isItemNameInLink(itemClue,currentItemLink) then
				return getIDFromItemLink(currentItemLink)
			end	
		end				
	end
	
	-- If we don't find the item, return nil
	return nil
end

-- Adds a value to the ReagentRestockerDB.Items table
function ReagentRestocker:addToItems(itemID, var, value, list)
	local _, _, _, tocversion = GetBuildInfo();

	if not ReagentRestockerDB.Items[itemID] then
		ReagentRestockerDB.Items[itemID] = {}
		ReagentRestockerDB.Items[itemID]["tags"]={}
		ReagentRestockerDB.Items[itemID]["tocversion"] = tocversion
	end
	
	if ReagentRestockerDB.Items[itemID]["tags"]==nil then
		ReagentRestockerDB.Items[itemID]["tags"]={}
	end
	
	ReagentRestockerDB.Items[itemID][var] = value
	self:safeGetItemInfo(itemID)
	if list ~= nil then
		tagObject(list, itemID)
	end
	
end 

-- Add an item to the shopping list with a starting value of 0
function ReagentRestocker:addItemToShoppingList(reagent)
	self:addItemToList(reagent, "Buy")
end

-- Add an item to the selling list
function ReagentRestocker:addItemToSellingList(reagent)
	self:addItemToList(reagent, "Sell")
end

-- Add an item to a generic list
-- safeGetItemInfo
function ReagentRestocker:addItemToList(reagent, list)
	if list == nil then error("List cannot be nil!") end
	
	if type(reagent)=="number" then
		self:addToListByID(reagent,0,list)
	elseif type(reagent)=="string" then
		itemID=nil
		
		-- Try to get from WoW
		
		_, itemLink = ReagentRestocker:safeGetItemInfo(reagent) -- Not found in a cache, try to get the item from WoW
		if itemLink then
			return self:addToListByID(getIDFromItemLink(itemLink),0,list)
		end
		
		-- Find item in database.
		for k, v in pairs(ReagentRestockerDB.Items) do
			if v.item_name==reagent then
				itemID = k
				dprint("Found in db as "..k)
			end
		end
		
		if itemID~=nil then
			self:addToListByID(itemID,0,list)
		-- Try the cache (and make sure it exists first! It may be disabled!)
		elseif RRGlobal~= nil then
			for k, v in pairs(RRGlobal.ItemCache) do
				if v.item_name==reagent then
					itemID = k
					dprint("Found in cache as "..k)
				end

			end
			
			if itemID~=nil then
				self:addToListByID(itemID,0,list)
			else
				-- Item not found.
				return nil
			end
		else
			-- Item not found.
			return nil
		end
	else
		error("Invalid item type.")
	end
end

function findItemFromName(name)
	-- Find item from name
	--for (k, v) in pairs(ReagentRestockerDB.Items) do
		
	--end
end

-- Remove an item from a list
function ReagentRestocker:removeItemFromList(reagent, list)
	-- If no lists are indicated, remove it from the database. Otherwise, remove
	-- it from the specified list.
	if list==nil then
		removeAllTags(reagent);
		ReagentRestockerDB.Items[reagent] = nil;
	else
		untagObject(list, reagent);
		
		-- TODO: Removing from the list completely is required for now.
		-- The selling and buying lists are not tagged, so right now if all
		-- of the tags are removed, it gets moved to one of them!
		ReagentRestockerDB.Items[reagent] = nil;
	end	
	--ReagentRestocker:synchronizeOptionsTable();
end

-- Returns a table of the form {itemID = qtyOff}, indicating how far "off" the player's current stock of items is from "ideal"
function ReagentRestocker:getOffsetList(filter)
	local sl = {}
	for itemID, data in pairs (ReagentRestockerDB.Items) do
		if (data[QUANTITY_TO_STOCK]~= nil and ReagentRestocker:listType(itemID) == SHOPPING_TYPE) then
			if not filter then
				sl[itemID] = data[QUANTITY_TO_STOCK] - ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID)
			else
				local count = data[QUANTITY_TO_STOCK] - ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID)
				if filter(itemID,count) then
					sl[itemID] = count				
				end
			end			
		end
	end
	return sl
end

-- Returns shoppping if the item ID is on the shopping list; selling if it is on the selling list; nil if it is not on any list
function ReagentRestocker:listType(itemID)
	if not ReagentRestockerDB.Items[itemID] then
		return nil
	else
			if hasTag(itemID, "Buy") then
				return SHOPPING_TYPE
			elseif hasTag(itemID, "Sell") then
				return SELLING_TYPE
			else
				return nil;
			end
	end
end

-- Attempts to add an item to the appropriate list
function ReagentRestocker:addToList(reagent,qty)

	error("This one shouldn't be called.")
	-- Make sure something was entered
	if (reagent == "") then
		self:say("Please enter an item name.")
	else
		-- Attempt to find the item; if we do, add it to items
		local itemID
		if type(reagent) == type(1) then
			itemID = reagent
		else
			itemID = self:discoverItemID(reagent)
		end
		
		if itemID then
			local _, itemLink = self:safeGetItemInfo(itemID)
			if ReagentRestockerDB.Items[itemID] then
				-- The item already exists in the item list
				self:say(string.format("%s is already on your %s list.", itemLink, self:listType(itemID)))
			else
				self:addToItems(itemID, QUANTITY_TO_STOCK, qty)
				local msg = string.format("%s has been added to your %s list.", itemLink, self:listType(itemID))
				if listType == SHOPPING_TYPE then
					msg = msg .. "  |cffff8000You must choose a stock quantity before ReagentRestocker will purchase this item.|r"
				end
				self:say(msg)
			end
		else
			self:say(string.format("Reagent Restocker cannot find %q; try adding it when you have the item in your bags, bank, or while visiting a vendor selling it.", reagent))
		end
		
		-- Now that the list is changed, update the options with the changes
		--self:synchronizeOptionsTable()
		
	end

	-- Turn off notifier, since the user performed an action
	ReagentRestockerDB.Options.UnusedNotification = false
end

-- Attempts to add an item to the appropriate list
-- If "list"==nil, than add to one of old lists.
function ReagentRestocker:addToListByID(itemID,qty,list)
	if list == nil then error("List cannot be nil!") end
		if itemID then
			local _, itemLink = self:safeGetItemInfo(itemID)
			if ReagentRestockerDB.Items[itemID] then
				-- The item already exists in the item list
				if list == nil then
					self:say(string.format("%s is already on your %s list.", itemLink, self:listType(itemID)))
				else
					self:say(string.format("%s is already on your %s list.", itemLink, list))
				end
			else
				self:addToItems(itemID, QUANTITY_TO_STOCK, qty, list)
				local msg=""
				if list == nil then
					msg = string.format("%s has been added to your %s list.", itemLink, self:listType(itemID))
				else
					msg = string.format("%s has been added to your %s list.", itemLink, list)
				end
				if listType == SHOPPING_TYPE then
					msg = msg .. "  |cffff8000You must choose a stock quantity before ReagentRestocker will purchase this item.|r"
				end
				self:say(msg)
			end
		else
			self:say("Item not found; try adding it when you have the item in your bags, bank, or while visiting a vendor selling it.")
		end
		
		-- Now that the list is changed, update the options with the changes
		--self:synchronizeOptionsTable()

	-- Turn off notifier, since the user performed an action
	ReagentRestockerDB.Options.UnusedNotification = false
end

-- Locks out transactions to avoid multi-click problems; returns true if the transaction is has been locked; false if it is already locked
function ReagentRestocker:lockTransaction(sec)
	if not TransactionLock then
		TransactionLock = time()
		self:queueAction(function() return time() > TransactionLock + sec end, function() TransactionLock = false end)
		return true
	else
		-- It is already locked
		return false
	end
end

-- Prints a message letting the player know usage
function ReagentRestocker:notifyPlayer()
	if (tcount(ReagentRestockerDB.Items) == 0 and ReagentRestockerDB.Options.UnusedNotification) then
		self:say("Your Shopping List is currently empty.  |cffff8000Type /rr to get started (and get rid of this annoying message).|r")
	end
end

-- Check waters for possible upgrades and upgrades them.
function checkWaters()
	if ReagentRestockerDB.Options.UpgradeWater == false then return end
	
	local waters = {159, 1179, 1205, 1708, 1645, 8766, 28399, 27860, 33444, 33445, 58256, 58257}
	playerLevel = _G.UnitLevel("player")
	
	--playerLevel = 20 -- For debugging
	
	currentWaterLevel = 0
	maxWaterID = 159
	
	-- Get water levels
	for _, id in pairs(waters) do
		_, _, _, _, waterLevel = ReagentRestocker:safeGetItemInfo(id)
		
		-- Find max water player can use
		if waterLevel and waterLevel <= playerLevel and waterLevel >= currentWaterLevel then
			maxWaterID = id
			currentWaterLevel = waterLevel
		end
	end
	_, _, _, _, waterLevelz = ReagentRestocker:safeGetItemInfo(maxWaterID)
	
	for k, v in pairs(ReagentRestockerDB.Items) do
		for k2, v2 in pairs(waters) do
			if v2 == k and v2 ~= maxWaterID and hasTag(k, "Buy") then
				-- upgrade
				amount = ReagentRestockerDB.Items[k].qty
				old_item_name=ReagentRestockerDB.Items[k].item_name
				low_warn = ReagentRestockerDB.Items[k].low_warning
				ReagentRestocker:removeItemFromList(k, "Buy")
				
				ReagentRestocker:addItemToList(maxWaterID, "Buy")
				ReagentRestockerDB.Items[maxWaterID].qty = amount
				ReagentRestockerDB.Items[maxWaterID].low_warning = low_warn
				
				if ReagentRestockerDB.Items[maxWaterID] ~= nil and ReagentRestockerDB.Items[maxWaterID].item_name~=nil then
					print("Reagent Restocker: Upgraded "..old_item_name.." to "..ReagentRestockerDB.Items[maxWaterID].item_name..".")
				else
					print("Reagent Restocker: Upgraded "..old_item_name.." to unknown water with ID "..maxWaterID..".")
				end
			end
		end
	end
end


--======================--
-- Merchant Interaction --
--======================--

-- Handles auto-population of the selling list; adds new items in the buyback list to the selling list, if appropriate
function ReagentRestocker:MERCHANT_UPDATE()
	ReagentRestocker:triggerAction(MERCHANT_UPDATE_EVENT)
	
	if ReagentRestockerDB.Options.AutoPopulate then
		for i=1,_G.GetNumBuybackItems() do
			local itemLink = _G.GetBuybackItemLink(i)
			if itemLink then 
				local itemID = getIDFromItemLink(itemLink)
				if not ReagentRestockerDB.Items[itemID] then
					-- Doesn't apply this rule to blue or better items; also doesn't apply to items that are to be sold
					local _, _, rarity = ReagentRestocker:safeGetItemInfo(itemID)			
					if rarity < 3 and not ReagentRestocker:isToBeSold(itemID) then
						ReagentRestocker:addItemToSellingList(itemID)
					end
				end
			end
		end
	end
	
	--_G.collectgarbage()
	--createStockButtons()
end

local stockButtons = {};
for i=1,_G.MERCHANT_ITEMS_PER_PAGE,1 do
--	stockButtons[i] = _G.CreateFrame("Button", "stockButton"..i, _G["MerchantItem"..i], "UIPanelButtonTemplate");
--	stockButtons[i]:RegisterForClicks("LeftButtonUp");
end

local stockAmount = _G.CreateFrame("Frame", nil, UIParent);
stockAmount:SetPoint("TOPLEFT", _G.MerchantFrame, "TOPRIGHT", 0, 0);
stockAmount:SetWidth(290);
stockAmount:SetPoint("TOPLEFT", _G.MerchantFrame, "TOPRIGHT", 0, 0);
stockAmount:SetBackdrop({
	bgFile=[[Interface\Tooltips\UI-Tooltip-Background]],
	edgeFile=[[Interface\Tooltips\UI-Tooltip-Border]],
	tile=true, tileSize=16, edgeSize=16,
	insets={left=4, right=4, top=4, bottom=4}
})
stockAmount:SetBackdropColor(.75, .75, .75);
stockAmount:SetBackdropBorderColor(1, 1, 1, 1);

local confirmString=stockAmount:CreateFontString();
confirmString:SetPoint("TOPLEFT", stockAmount, "TOPLEFT", 5, -5)
confirmString:SetWidth(280);
confirmString:SetFontObject(_G.GameFontNormal);
confirmString:SetText(" ");
confirmString:Show();

stockAmount:SetHeight(confirmString:GetStringHeight()+40);

local closeButton = _G.CreateFrame("Button", nil, stockAmount, "UIPanelCloseButton");
closeButton:SetPoint("TOPRIGHT", 0, 0);
closeButton:Show();
closeButton:RegisterForClicks("LeftButtonUp");
closeButton:SetScript("OnClick", function (self, button, down)
	stockAmount:Hide()
end)
stockAmount:Hide()

--local showRR = _G.CreateFrame("Button", "showRR", stockAmount, "UIPanelButtonTemplate");
--showRR:SetText("Manage lists");
--showRR:SetWidth(200)
--showRR:SetHeight(20)
--showRR:SetPoint("BOTTOMLEFT", 10, 10);
--showRR:Show();
--showRR:RegisterForClicks("LeftButtonUp");
--showRR:SetScript("OnClick", function (self, button, down)
--	stockAmount:Hide();
--	ReagentRestocker:showFrame();
--end)

-- Hook merchant frame updates so I can detect page changes.
oldMerchUpdate = _G.MerchantFrame_Update;

function createStockButtons()

	oldMerchUpdate();
	-- Based on Blizzard's code.
	for i=1,_G.MERCHANT_ITEMS_PER_PAGE,1 do
		local index = (((_G.MerchantFrame.page - 1) * _G.MERCHANT_ITEMS_PER_PAGE) + i);
		if _G.GetMerchantItemLink(index) ~= nil and _G.MerchantFrame.selectedTab == 1 then
			stockButtons[i]:SetText("+");
			stockButtons[i]:SetWidth(16)
			stockButtons[i]:SetHeight(15)
			stockButtons[i]:SetPoint("TOPRIGHT", -4, -4);
			-- Humm, could be useful info .  ..
			
			name, texture, price, quantity, numAvailable, isUsable, extendedCost = _G.GetMerchantItemInfo(index);
			
			stockButtons[i].item = getIDFromItemLink(_G.GetMerchantItemLink(index));
			stockButtons[i].itemName = name;
			stockButtons[i]:SetScript("OnClick", function (self, button, down)
				-- For now, buy 1 item
				--derror(self)
				ReagentRestocker:addItemToShoppingList(self.item);
				confirmString:SetText(self.itemName.." added to list.");
				stockAmount:Show();

			end)
			stockButtons[i]:Show();
		else
			stockButtons[i]:Hide();
		end
	end

end

--_G.MerchantFrame_Update = createStockButtons;

SubscribeWOWEvent("MERCHANT_SHOW",
function()
	dprint("MERCHANT_SHOW")
	--processQueueItem()
	--triggerAction(MERCHANT_SHOW)
	ReagentRestocker:MERCHANT_SHOW()
end)

-- Handles auto-purching, -selling, and -repairing when the vendor window is opened
function ReagentRestocker:MERCHANT_SHOW()

	--createStockButtons();
	
	-- Check water for upgrades
	checkWaters()
	
	ReagentRestocker:triggerAction(MERCHANT_SHOW_EVENT)

	--if not ReagentRestocker:lockTransaction(2) then
	--	ReagentRestocker:say("You are attempting to begin too many transactions in a short time; ignoring ...")
	--	return
	--end	
		
	-- Remind the player how to open RR
	ReagentRestocker:notifyPlayer()
	
	-- Do the purchasing, selling, and repairing
	local endMoney, msgs, soldItemsInfo, queueReport = _G.GetMoney(), {}, {}, false

	-- prepare receipts
	if ReagentRestockerDB.Receipts == nil and ReagentRestockerDB.Options.KeepReceipts then
		ReagentRestockerDB.Receipts = {}
	end
	
	if not ReagentRestockerDB.Options.KeepReceipts and ReagentRestockerDB.Receipts ~= nil then
		ReagentRestockerDB.Receipts = nil
		--_G.collectgarbage()
	end

	if ReagentRestockerDB.Options.AutoBuy and ReagentRestocker:isReagentVendor() then
		local cost, msg = ReagentRestocker:buy()
		--endMoney = endMoney - cost
		table.insert(msgs,msg)
		if cost > 0 then queueReport = true; end
	end
	
	if ReagentRestockerDB.Options.AutoRepair and _G.CanMerchantRepair() then
		local cost, msg = ReagentRestocker:repair()
		--endMoney = endMoney - cost
		table.insert(msgs,msg)
		-- TODO - Potential bug: Cost can be 0 if guild bank repair occured, but transction is occuring
		if cost > 0 then queueReport = true; end
	end
	
	if ReagentRestockerDB.Options.AutoSell then
		endMoney = _G.GetMoney()
		soldItemsInfo = ReagentRestocker:sell()
	end
	
	--table.insert(msgs,string.format("Sold items for a profit of %s.",nCTS(GetMoney() - endMoney)));
	-- If we're waiting on a transaction to complete, let the player know
	if not queueReport and #soldItemsInfo == 0 then
		--self:say("Working, please wait ...")
		--if (GetMoney() - endMoney) > 0 then table.insert(msgs,string.format("Sold items for a profit of %s.",nCTS(GetMoney() - endMoney))); end
		
		-- Dunno why we have receipt code here?
		--table.insert(msgs,"==== RECEIPT ====");
		--ReagentRestocker:say(table.concat(msgs))
		--table.insert(msgs,"=================");
	else
		ReagentRestocker:say("Working, please wait ...")
		ReagentRestocker:queueAction(
			function() return ReagentRestocker:areSlotsUnlocked(soldItemsInfo); end,
			function() 
				table.insert(msgs,"==== RECEIPT ====");
				if #soldItemsInfo > 0 then
					for k, y in pairs(soldItemsInfo) do
						if soldItemsInfo[k][5] == true then
							table.insert(msgs,"Sold " .. soldItemsInfo[k][4] .. "x " .. soldItemsInfo[k][6] .. ".");
						else
							--dprint(soldItemsInfo[k][4]);
							--dprint(soldItemsInfo[k][6]);
							table.insert(msgs,"Destroyed " .. soldItemsInfo[k][4] .. "x " .. soldItemsInfo[k][6] .. ".");
						end
					end
					
					if _G.GetMoney() - endMoney > 0 then
						table.insert(msgs,string.format("Sold " .. #soldItemsInfo .. " items for a profit of %s.",nCTS(_G.GetMoney() - endMoney)));
					end
				else
					table.insert(msgs,"\n= No items sold =\n");
				end
				-- Show receipt in a new frame.
				table.insert(msgs,"=================");
				local receiptFrame = _G.CreateFrame("Frame", nil, UIParent);
				receiptFrame:SetWidth(290);
				receiptFrame:SetPoint("TOPLEFT", _G.MerchantFrame, "TOPRIGHT", 0, 0);
				receiptFrame:SetBackdrop({
					bgFile=[[Interface\Tooltips\UI-Tooltip-Background]],
					edgeFile=[[Interface\Tooltips\UI-Tooltip-Border]],
					tile=true, tileSize=16, edgeSize=16,
					insets={left=4, right=4, top=4, bottom=4}
				})
				receiptFrame:SetBackdropColor(.75, .75, .75);
				receiptFrame:SetBackdropBorderColor(1, 1, 1, 1);
				
				receiptString=receiptFrame:CreateFontString();
				receiptString:SetPoint("TOPLEFT", receiptFrame, "TOPLEFT", 5, -5)
				receiptString:SetWidth(280);
				receiptString:SetFontObject(_G.GameFontNormal);
				receiptString:SetText(table.concat(msgs," "));
				--receiptString:Show();
				
				receiptFrame:SetHeight(receiptString:GetStringHeight()+10);
				
				local closeButton = _G.CreateFrame("Button", nil, receiptFrame, "UIPanelCloseButton");
				--closeButton:SetText("X");
				--closeButton:SetWidth(20)
				--closeButton:SetHeight(20)
				closeButton:SetPoint("TOPRIGHT", 0, 0);
				--closeButton:Show();
				closeButton:RegisterForClicks("LeftButtonUp");
				closeButton:SetScript("OnClick", function (self, button, down)
					receiptFrame:Hide()
				end)
				
				receiptFrame:Hide()
				
				
				if ReagentRestockerDB.Options.KeepReceipts then
					-- TODO: Receipts code here.
				end
				
				--self:say(table.concat(msgs," "));
				for i, v in pairs(msgs) do
					ReagentRestocker:say(v);
				end
			end,
			PLAYER_MONEY_EVENT
		);
	end
	
end

-- Purchases as close to as possible the specified quantity of the item
function ReagentRestocker:purchaseItems(itemID, toBuy)
	local itemIndex
	for i=1,_G.GetMerchantNumItems() do
		local merchantItem = _G.GetMerchantItemLink(i)
		if merchantItem then
			if getIDFromItemLink(_G.GetMerchantItemLink(i)) == itemID then
				itemIndex = i
				break
			end
		end
	end
	
	if not itemIndex then
		return
	end
	
	-- Purchases only allow for 1 stack at maximum per "click"; iteratively buy stacks, then buy the last bit if any remain
	local _, _, _, _, _, _, _, itemStackSize = self:safeGetItemInfo(itemID)
	local _, _, _, qtyPerPurchase = _G.GetMerchantItemInfo(itemIndex)
	
	local _, _, _, tocversion = GetBuildInfo();
	if tocversion >= 40000 then
		-- BuyMerchantItem behavior changes in Cataclysm
		-- It now always buys the amount listed, and not the number of stacks. 
		-- Although it appears to be rounded up to the stack size :(.
		while toBuy > itemStackSize do
			_G.BuyMerchantItem(itemIndex, floor(itemStackSize))
			toBuy = toBuy - itemStackSize
		end
		if toBuy > 0 then
			_G.BuyMerchantItem(itemIndex, floor(toBuy))
		end
		
	else
	
		while toBuy > itemStackSize do
			_G.BuyMerchantItem(itemIndex, floor(itemStackSize/qtyPerPurchase))
			toBuy = toBuy - itemStackSize
		end
		if toBuy > 0 then
			_G.BuyMerchantItem(itemIndex, floor(toBuy/qtyPerPurchase))
		end
	end
end	

MyScanningTooltip = _G.CreateFrame( "GameTooltip", "MyScanningTooltip", nil, "GameTooltipTemplate" ); -- Tooltip name cannot be nil
MyScanningTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );

-- Returns true if the item is able to be sold and if preferences dictate it should be; false otherwise
function ReagentRestocker:isToBeSold(itemID)

	-- Can't sell it if we don't know what it is.
	if self:safeGetItemInfo(itemID) == nil then
		return false
	end
	
	local _, itemLink, quality = self:safeGetItemInfo(itemID)
	if ReagentRestockerDB.Items[itemID] ~= nil then
		--dprint("Item name: " .. ReagentRestockerDB.Items[itemID]["0"])
		--dprint("Sell price: " .. nCTS(ReagentRestocker:getSellPrice(itemID)))
	end
		--[[
		 IF:
		 	--We are automatically selling greys and it is in fact a grey, or
			--It's on the selling list
			
			-and it can be sold.
			
			Then sell it.
		]]--

		--Don't sell BoE, Soulbound items if the user doesn't want them sold.
--		if itemLink then
--			-- Experimental tooltip scanning, mostly borrowed form WoWWiki
--			--MyScanningTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
--
--			MyScanningTooltip:ClearLines()
--
--			if bagID == _G.BANK_CONTAINER then
--				MyScanningTooltip:SetInventoryItem("player", _G.BankButtonIDToInvSlotID(bagSlotID));
--			elseif bagID == _G.KEYRING_CONTAINER then
--				MyScanningTooltip:SetInventoryItem("player", _G.KeyRingButtonIDToInvSlotID(bagSlotID));
--			else
--				MyScanningTooltip:SetBagItem(bagID, bagSlotID);
--			end
--			
--			if tooltipsContain(MyScanningTooltip, _G.ITEM_BIND_ON_EQUIP, MyScanningTooltip:GetRegions()) and ReagentRestockerDB.Options.KeepBindOnEquip then
--				--dprint(ReagentRestockerDB.Items[itemID].item_name .. " is BOE")
--				return false
--			end
--			
--			if tooltipsContain(MyScanningTooltip, _G.ITEM_SOULBOUND, MyScanningTooltip:GetRegions()) and ReagentRestockerDB.Options.KeepSoulbound then
--				--dprint(ReagentRestockerDB.Items[itemID].item_name .. " is Soulbound")
--				return false
--			end
--			
--			if itemID == 66933 then dprint(itemID .. " wasn't identified as junk") end
--		end

		local sellConsumable = false;
		
		-- Check periodic table for food and water, if possible.
		if PT ~= nil then
			if PT:ItemInSet(itemID, "Consumable.Water") and ReagentRestockerDB.Options.AutoSellWater then
				sellConsumable = true;
			end

			if PT:ItemInSet(itemID, "Consumable.Food.Edible") and ReagentRestockerDB.Options.AutoSellFood then
				sellConsumable = true;
			end
		else
			-- Unfortunately, without a lot of extra code to check every single
			-- piece of food and water in the game, we can't distinguish
			-- between food and water. I've decided that the user will simply
			-- have to install the Periodic Table library (or an addon that has
			-- it) in order to have separate food and water options.
			local name, _, _, _, _, itemType, itemSubType = self:safeGetItemInfo(itemID)
			
			if itemType == "Consumable" and itemSubType == "Food & Drink" and ReagentRestockerDB.Options.AutoSellFoodWater then
				sellConsumable = true;
			end
		end
		
	if ((quality ~= nil and ReagentRestockerDB.Options.AutoSellQuality and quality <= ReagentRestockerDB.Options.AutoSellQualityLevel)
			or (self:listType(itemID) == SELLING_TYPE)
			or (ReagentRestockerDB.Options.AutoSellUnusable and ReagentRestocker:isUseless(itemID) and quality <= ReagentRestockerDB.Options.UnusableQualityLevel)
			or (sellConsumable) 
			) and ReagentRestocker:getSellPrice(itemID) > 0 then
		
		-- Except when it's on the exception or buying list.
		if (type(ReagentRestockerDB.Items[itemID]) ~= "nil" and
		type(ReagentRestockerDB.Items[itemID].tags) ~= "nil" and
		ReagentRestockerDB.Items[itemID].tags.Exception ~= nil) or
		self:listType(itemID)==SHOPPING_TYPE
		then
			--dprint(itemID .. "isToBeSold returning false")
			return false
		end
		dprint(itemID .. "isToBeSold returning true")
		return true
	else
		--dprint("isToBeSold returning false")
		return false
	end
end

function ReagentRestocker:isUseless(itemID)
	-- Useless items - armor you can't wear, weapons you can't use
	
	-- What class are we?
	_, myClass = _G.UnitClass("player");
	
	local name, _, _, _, _, itemType, itemSubType = self:safeGetItemInfo(itemID)
	
	if itemType==nil then return false end;

	-- Sorted by class
	-- NOTE: I don't know if any of this is affected by dual wielding.
	
	if myClass=="DEATHKNIGHT" then
		if itemType=="Armor" and itemSubType=="Shields" then return true end;
		if itemType=="Weapon" then
			if itemSubType=="Daggers" then return true end;
			if itemSubType=="Fist Weapons" then return true end;
			if itemSubType=="Staves" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
			if itemSubType=="Wands" then return true end;
		end
	end
	
	if myClass=="DRUID" then
		if itemType=="Armor" then
			if itemSubType=="Shields" then return true end;
			if itemSubType=="Plate" then return true end;
			if itemSubType=="Mail" then return true end;
		end
		if itemType=="Weapon" then
			if itemSubType=="One-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Axes" then return true end;
			if itemSubType=="One-Handed Swords" then return true end;
			if itemSubType=="Two-Handed Swords" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
			if itemSubType=="Wands" then return true end;
		end
	end

	if myClass=="HUNTER" then
		if itemType=="Armor" then
			if itemSubType=="Shields" then return true end;
			if itemSubType=="Plate" then return true end;
		end
		
		if itemType=="Weapon" then
			if itemSubType=="One-Handed Maces" then return true end;
			if itemSubType=="Two-Handed Maces" then return true end;
			if itemSubType=="Wands" then return true end;
		end
	end

	if myClass=="MAGE" then
		if itemType=="Armor" then
			if itemSubType=="Shields" then return true end;
			if itemSubType=="Plate" then return true end;
			if itemSubType=="Mail" then return true end;
			if itemSubType=="Leather" then return true end;
		end
		if itemType=="Weapon" then
			if itemSubType=="One-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Swords" then return true end;
			if itemSubType=="One-Handed Maces" then return true end;
			if itemSubType=="Two-Handed Maces" then return true end;
			if itemSubType=="Polearms" then return true end;
			if itemSubType=="Fist Weapons" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
		end
	end

	if myClass=="PALADIN" then
		-- They can wear any armor.
		
		if itemType=="Weapon" then
			if itemSubType=="Daggers" then return true end;
			if itemSubType=="Staves" then return true end;
			if itemSubType=="Fist Weapons" then return true end;
			if itemSubType=="Staves" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
			if itemSubType=="Wands" then return true end;
		end
	end
	
	if myClass=="PRIEST" then
		if itemType=="Armor" then
			if itemSubType=="Shields" then return true end;
			if itemSubType=="Plate" then return true end;
			if itemSubType=="Mail" then return true end;
			if itemSubType=="Leather" then return true end;
		end
		if itemType=="Weapon" then
			if itemSubType=="One-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Axes" then return true end;
			if itemSubType=="One-Handed Swords" then return true end;
			if itemSubType=="Two-Handed Swords" then return true end;
			if itemSubType=="Two-Handed Maces" then return true end;
			if itemSubType=="Polearms" then return true end;
			if itemSubType=="Fist Weapons" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
		end
	end

	if myClass=="ROGUE" then
		if itemType=="Armor" then
			if itemSubType=="Shields" then return true end;
			if itemSubType=="Plate" then return true end;
			if itemSubType=="Mail" then return true end;
		end
		if itemType=="Weapon" then
			if itemSubType=="Two-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Swords" then return true end;
			if itemSubType=="Two-Handed Maces" then return true end;
			if itemSubType=="Polearms" then return true end;
			if itemSubType=="Staves" then return true end;
			if itemSubType=="Wands" then return true end;
		end
	end

	if myClass=="SHAMAN" then
		if itemType=="Armor" then
			if itemSubType=="Plate" then return true end;
		end
		if itemType=="Weapon" then
			if itemSubType=="One-Handed Swords" then return true end;
			if itemSubType=="Two-Handed Swords" then return true end;
			if itemSubType=="Polearms" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
			if itemSubType=="Wands" then return true end;
		end
	end
	
	if myClass=="WARLOCK" then
		if itemType=="Armor" then
			if itemSubType=="Shields" then return true end;
			if itemSubType=="Plate" then return true end;
			if itemSubType=="Mail" then return true end;
			if itemSubType=="Leather" then return true end;
		end
		if itemType=="Weapon" then
			if itemSubType=="One-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Axes" then return true end;
			if itemSubType=="Two-Handed Swords" then return true end;
			if itemSubType=="One-Handed Maces" then return true end;
			if itemSubType=="Two-Handed Maces" then return true end;
			if itemSubType=="Polearms" then return true end;
			if itemSubType=="Fist Weapons" then return true end;
			if itemSubType=="Bows" then return true end;
			if itemSubType=="Crossbows" then return true end;
			if itemSubType=="Guns" then return true end;
			if itemSubType=="Thrown" then return true end;
		end
	end
	
	if myClass=="WARRIOR" then
		if itemType=="Armor" then
		-- They can wear any armor. TODO: Weapons.
		end

		-- Warriors can use any weapon except the wands O.O
		if itemType=="Weapon" then
			if itemSubType=="Wands" then return true end;
		end
	end

	-- By default, better safe than sorry.
	return false;
	
end

function ReagentRestocker:isToBeDestroyed(itemID)
	if ReagentRestockerDB.Options.AutoDestroyGrays == true then
		local _, _, quality = self:safeGetItemInfo(itemID)
		--[[
		 IF:
		 	--We are automatically destroying greys and it is in fact a grey, or
			--It's on the selling list
			
			-and it can't be sold.
			
			Then destroy it.
		]]--
			if ((ReagentRestockerDB.Options.AutoDestroyGrays and quality == 0) or (self:listType(itemID) == SELLING_TYPE)) and ReagentRestocker:getSellPrice(itemID) == 0 then
				-- Except when it's on the exception list.
				if type(ReagentRestockerDB.Items[itemID]) ~= "nil" and
				type(ReagentRestockerDB.Items[itemID].tags) ~= "nil" and
				ReagentRestockerDB.Items[itemID].tags.Exception ~= nil then
					return false
				end
				return true
			else
				return false
			end
	else
		-- Never detroy if we don't have the option on.
		return false
	end
end

-- Returns true if the merchant sells items on the player's shopping list; false otherwise
function ReagentRestocker:isReagentVendor()
	for i=1,_G.GetMerchantNumItems() do
		local merchantItem = _G.GetMerchantItemLink(i)
		if merchantItem then
			if (self:listType(getIDFromItemLink(merchantItem)) == SHOPPING_TYPE) then
				return true
			end
		end
	end	
	return false
end

-- Repairs the character's equipment, if necessary; returns the cost and a report string

-- TODO: Made more complex than needed when fixing bugs, simplify!
function ReagentRestocker:repair()
	dprint("GUILD LEVEL" .. _G.GetGuildLevel())
	
	if _G.CanMerchantRepair() then
		local msg, cost = "", _G.GetRepairAllCost()
		
		if ReagentRestockerDB.Options.RepairDiscount and not self:meetsDiscountRequirements() and cost > 0 then
			print("This vendor does not have " .. getReputationName(ReagentRestockerDB.Options.Reputation) .. " or better reputation; your items will not be repaired.")
			return 0, "This vendor does not have " .. getReputationName(ReagentRestockerDB.Options.Reputation) .. " or better reputation; your items will not be repaired."
		end		
		
		-- Warn the player if he's not capable of making guild bank repairs
		if not _G.CanGuildBankRepair() and ReagentRestockerDB.Options.UseGuildBankFunds then
			msg = "You are not authorized to make repairs via the guild bank."
		end
	
		-- Do the repairing
		if cost > 0 then
			if _G.CanGuildBankRepair() and ReagentRestockerDB.Options.UseGuildBankFunds then

				-- Shamelessly borrowed from Blizzard's own code for the merchant frame . . .
				local repairAllCost, canRepair = _G.GetRepairAllCost();

				-- Guild bank repair failed
				if repairAllCost > _G.GetGuildBankMoney() or (not canRepair) then
					quickDialog("Unable to use guild bank funds to repair. Do you want to use your own money?",
						function()
							dprint("OK");
							_G.RepairAllItems()
							msg = msg .. string.format("Your gear has been repaired, costing you %s.", nCTS(cost))
						end, function()
							dprint("CANCEL");
							return 0, "Not repaired.";
						end, "Use my money", "Don't repair");
				else
					_G.RepairAllItems(1)
					msg = msg .. string.format("Your gear has been repaired using the guild bank's funds, costing it %s.", nCTS(cost))
				end

			elseif _G.GetRepairAllCost() <= _G.GetMoney() then
				msg = msg .. string.format("Your gear has been repaired, costing you %s.", nCTS(cost))
				_G.RepairAllItems()
			elseif _G.GetRepairAllCost() > _G.GetMoney() then
				msg = msg .. string.format("Insufficient funds to repair (%s required).", nCTS(cost))
				cost = 0
			end
		else
			msg = "You are already fully repaired."
			cost = 0
		end
		
		return cost, msg
	else
		return 0, "This merchant cannot repair gear."
	end
end

-- Buys the necessary reagents based on those that are currently in the player's inventory; returns the cost and a reporting string
function ReagentRestocker:buy()
	-- Keep track of what items will actually be bought
	local buyingList, cost, shoppingList = {}, 0, self:getOffsetList()
	
	-- Grab only the items that we need from the shopping list
	map(shoppingList, function(itemID,qty) if qty < 1 then shoppingList[itemID] = nil; end end)
	
	-- Look through all of the merchant's items
	for i=1,_G.GetMerchantNumItems() do
		local merchantItem = _G.GetMerchantItemLink(i)
		if merchantItem then
			local itemID = getIDFromItemLink(merchantItem)
			local numDesired = shoppingList[itemID]
			local _, _, itemPrice, qtyPerPurchase, itemQtyAvailable = _G.GetMerchantItemInfo(i)
			if numDesired then
				local buyQty
				if itemQtyAvailable == -1 then -- Unlimited quantity
					buyQty = numDesired
				else -- Limited quantity; take at most the number that are available
					buyQty = min(numDesired, itemQtyAvailable)
				end
				-- Round down to quantity to an integer multiple of the quantity in which they can be purchased (some items can't be purchased 1 by 1)
				if ReagentRestockerDB.Options.NotOverstock then
					buyingList[itemID] = floor(buyQty/qtyPerPurchase)*qtyPerPurchase
				else
					buyingList[itemID] = ceil(buyQty/qtyPerPurchase)*qtyPerPurchase
				end
				cost = cost + (buyingList[itemID]/qtyPerPurchase) * itemPrice
			end
		end
	end
	
	-- Filter out useless purchases
	for k,v in pairs(buyingList) do
		if v == 0 then
			buyingList[k] = nil
		end
	end
	
	-- Is there actually anything to be purchased?
	if tcount(buyingList) == 0 then
		return 0, "Already stocked on this vendor's items."
	end	
	
	-- Make sure the player has enough money
	if cost > _G.GetMoney() then
		return 0, string.format("Insufficient funds to purchase reagents (%s required).",nCTS(cost))
	end
	
	-- Only buy items that cost money
	if cost == 0 then
		return 0, string.format("Buying items that use alternative currencies is not supported.",nCTS(cost))
	end
	
	-- Make sure the vendor is offering the appropriate discount
	if not self:meetsDiscountRequirements() then
		print("This vendor does not have " .. getReputationName(ReagentRestockerDB.Options.Reputation) .. " or better reputation; no items will be purchased.")
		return 0, "This vendor does not have " .. getReputationName(ReagentRestockerDB.Options.Reputation) .. " or better reputation; no items will be purchased."
	end
		
	-- Purchase the items
	for itemID,qty in pairs(buyingList) do
		self:purchaseItems(itemID,qty)
	end
	
	-- Builds a readable list of strings and quantities
	local purchasedItemLinkList = {}
	map(buyingList,function(itemID,qty) local _, l = self:safeGetItemInfo(itemID); table.insert(purchasedItemLinkList,string.format("%d %s",qty,l)); end)
	
	-- Build the message to report
	return cost, string.format("Purchased %s, costing a total of %s.",table.concat(purchasedItemLinkList,", "),nCTS(cost))
end

local regions;

-- Require regions from {tooltip:GetRegions()} to save memory
function tooltipsContain(tooltip, string, ...)
	-- initialize outside loop to prevent creating losts of copies that take lots of memory.
	local text;
	local region;
	
    for i = 1, select("#", ...) do
        region = select(i, ...)

        if region and region:GetObjectType() == "FontString" then
            text = region:GetText() -- string or nil
            if text ~= nil then
            	dprint("TEXT: " .. text .. " Looking for: " .. string)
            	if string.find(text, string)~=nil then
					return true
				end
            end
        end
    end
    return false
end

local regions;

-- Sells the appropriate item from the player's inventory; returns list of items sold
function ReagentRestocker:sell()
	local soldItemsInfo = {} -- {bagID, bagSlotID} list
	local itemLink;
	for _,bagID in pairs(getPlayerBagIDList()) do
		for bagSlotID=1,GetContainerNumSlots(bagID) do
			itemLink = GetContainerItemLink(bagID,bagSlotID)
			if itemLink then
			
				-- Cache Item ID, see if that helps performance
				local itemID = getIDFromItemLink(itemLink);
				
				-- If if can and should be sold, sell it
				if self:isToBeSold(itemID) then
					local _, qty = GetContainerItemInfo(bagID, bagSlotID)
					UseContainerItem(bagID,bagSlotID)
					
					-- Bag ID, BagSlot ID, Item link, quantity, (true=sold, false=destroyed), item name.
					table.insert(soldItemsInfo,{bagID,bagSlotID,itemID,qty,true, getNameFromItemLink(itemLink)})

				-- If if can and should be destroyed, destroy it
				elseif self:isToBeDestroyed(itemID) then
					local _, qty = GetContainerItemInfo(bagID, bagSlotID)
					dprint("Destroy" .. itemLink);
					_G.PickupContainerItem(bagID, bagSlotID);
					quickDialog("Do you really want to destroy " .. getNameFromItemLink(itemLink) .. "?\nWARNING: Destroyed items cannot be recovered.",
						function()
							dprint("OK");
							_G.DeleteCursorItem();
							self:say(getNameFromItemLink(itemLink) .. " destroyed!")
						end, function()
							dprint("CANCEL");
							_G.ClearCursor();
						end, "Destroy", "Keep");
				end
				
			end

		end

	end
	return soldItemsInfo
end

-- Returns true if the player has required reputation with current merchant window; false otherwise
function ReagentRestocker:meetsDiscountRequirements()
	-- Return true if the available discount is anywhere from required to 20%
	if _G.UnitReaction("target", "player") >= ReagentRestockerDB.Options.Reputation then
		return true
	end
	return false
end

-- Returns the integer percentage that the merchant is offering
function ReagentRestocker:getMerchantDiscount()
	error("getMerchantDiscount is no longer available. Use UnitReaction instead.") -- _G.UnitReaction("target", "player")
end

--function ReagentRestocker:getMerchantReputation()

--	local guildPerk = 1;
	
--	if _G.GetGuildLevel() >= 24 then
--		guildPerk = 0.9 -- TODO: I just reverted this because stuff was breaking, 
						--need to find a better way to calculate faction
						--discount, taking into account the guild level 24
						--"Bartering" perk.
--	else
--		guildPerk = 1
--	end

	-- Test code that is hopefully more accurate at getting the discount
--	local reaction = _G.UnitReaction("target", "player")
	
--	if reaction then
--		return reaction-4;
--	end
	
	-- The old code is below
	
	-- Helper: Returns true if removing the discount from the price results in more 0s than the original price
--	local isDiscounted = function (price, discountPercent)
--		-- Helper: Returns the number of 0s in the [decimal] number
--		local numZeroes = function (num)
--			local zeroCount = 0
--			while floor(num/10) == num/10 and num > 9 do
--				num = num/10
--				zeroCount = zeroCount + 1
--			end
--			
--			return zeroCount
--		end
--		
--		return numZeroes(price) < numZeroes(floor(price/(1 - discountPercent/100) + 0.5))
--	end
--
--	local merchantPriceList = {}
--	for i=1, _G.GetMerchantNumItems() do
--		local _, _, price = _G.GetMerchantItemInfo(i)
--		if price then
--			table.insert(merchantPriceList,price)
--		end
--	end	
--
--	-- Check every multiple of 5% from under the required discount (or lower) to 20%
--	for discountPercent = floor(ReagentRestockerDB.Options.RequiredDiscount/5)*5, 20, 1 do
--		local numDiscounted = 0
--		for _,price in ipairs(merchantPriceList) do
--			if isDiscounted(price, discountPercent) then
--				numDiscounted = numDiscounted + 1
--			end
--		end
--		
--		if (0.4 < numDiscounted/#merchantPriceList) then
--			return discountPercent*guildPerk
--		end
--	end
	
	-- At this point, can't assess discount; assume no discount
--	return 0
--end

function ReagentRestocker:getVersion()
	return GetAddOnMetadata(addonName, "Version");
end

-- WARNING: Completely untested!!!!
--TODO: untested
function ReagentRestocker:deleteItem(item)
		ReagentRestockerDB.Items[item] = nil;
		dataobj=nil;
		--ReagentRestocker:synchronizeOptionsTable();
		refreshShoppingList();
		selectTree:RefreshTree();
end

--========--
-- Events --
--========--

function ReagentRestocker:ADDON_LOADED()

--function ReagentRestocker:OnInitialize()
	--self:RegisterEvent("MERCHANT_SHOW")	-- Buying and selling items
	self:RegisterEvent("MERCHANT_UPDATE")	-- Adding items to selling list
	--self:RegisterEvent(BANKFRAME_OPENED_EVENT)	-- Initiate bank transfers
	self:RegisterEvent("VARIABLES_LOADED")	-- Initializing variables
	self:RegisterEvent("ITEM_LOCK_CHANGED")	-- Queued events
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("BAG_UPDATE")
--	self:RegisterEvent(PLAYER_LEAVING_WORLD_EVENT) -- Player leaving world (stop updating bag info).
--	self:RegisterEvent(BAG_UPDATE_COOLDOWN_EVENT) -- Bags ready to start updating.
--	self:RegisterEvent(UPDATE_INVENTORY_DURABILITY_EVENT)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	--self:RegisterEvent("GUILDBANKFRAME_OPENED")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	
	-- Try to detect Raid Roll, and do not override its slash command if it has set one.
	if RaidRollHasLoaded ~= true then
		ReagentRestocker:RegisterChatCommand("rr", function ()
			addonTable.oldEnv = getfenv()
			setfenv(1,addonTable)
		
			ReagentRestockerDB.Options.UnusedNotification = false;
			ReagentRestocker:showFrame();
		
			-- Return to old environment, whatever it is.
			setfenv(1, oldEnv);
		end)
	end

	-- Always register /rrstock and /reagentrestocker.
	ReagentRestocker:RegisterChatCommand("rrstock", function ()
		addonTable.oldEnv = getfenv()
		setfenv(1,addonTable)

		ReagentRestockerDB.Options.UnusedNotification = false;
		ReagentRestocker:showFrame();
	
		-- Return to old environment, whatever it is.
		setfenv(1, oldEnv);
	end)

	ReagentRestocker:RegisterChatCommand("reagentrestocker", function ()
		addonTable.oldEnv = getfenv()
		setfenv(1,addonTable)

		ReagentRestockerDB.Options.UnusedNotification = false;
		ReagentRestocker:showFrame();

		-- Return to old environment, whatever it is.
		setfenv(1, oldEnv);
	end)

	ReagentRestocker:RegisterChatCommand("rrbuy", function(input) ReagentRestocker:addItemToList(input, "Buy") end );
	ReagentRestocker:RegisterChatCommand("rrsell", function(input) ReagentRestocker:addItemToList(input, "Sell") end );

	--LibStub("AceConfig-3.0"):RegisterOptionsTable("Reagent Restocker", Menu);
	
	--dprint("Connected to Ace.");
	
end

-- Adds an action to action queue
function ReagentRestocker:queueAction(evaluator, action, eventID)
	table.insert(QueuedActions,{evaluator,action,eventID})
end

function ReagentRestocker:triggerAction(eventID)
	--dprint(string.format("A [%s] event has been triggered.",tostring(eventID)))

	for i=#QueuedActions,1,-1 do
		-- Only run the action if the correct eventID is specified -or- if there is no event specified
		if not QueuedActions[i][3] or QueuedActions[i][3] == eventID then
			if QueuedActions[i][1]() then
				-- If the evaluator for an action is true, then its associated action is performed; then the action is deleted			
				local theAction = QueuedActions[i][2]
				table.remove(QueuedActions,i)
				theAction()
			end			
		end
	end
end

function ReagentRestocker:PLAYER_MONEY()
	--ReagentRestocker:triggerAction(PLAYER_MONEY_EVENT)
end

function ReagentRestocker:BAG_UPDATE()
	--ReagentRestocker:triggerAction(BAG_UPDATE_EVENT)
end

function ReagentRestocker:ITEM_LOCK_CHANGED(bagID, bagSlotID)
	--ReagentRestocker:triggerAction(ITEM_LOCK_CHANGED_EVENT)	
end


function ReagentRestocker:PLAYER_ENTERING_WORLD()
	playerEnteredTime=_G.GetTime();
end

RegisterEvent("ADDON_LOADED")

addonTable.ReagentRestocker=ReagentRestocker
dprint("Core.lua loaded");
setfenv(1, oldEnv);

-- Expose some of RR's functions to a public API.
ReagentRestocker=addonTable.ReagentRestocker

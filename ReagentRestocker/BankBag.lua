--==========--
-- Bank/Bags --
--==========--

local addonName, addonTable = ...;
local oldEnv = getfenv();
setfenv(1,addonTable);

TYPE_BAGS		= 0 -- includes backpack
TYPE_KEYS		= 1 -- probably not needed
TYPE_BANK		= 2
TYPE_GUILDBANK	= 3

-- SubscribeWOWEvent(eventName, eventAction)

SubscribeWOWEvent("BANKFRAME_OPENED",
function()
	dprint("BANKFRAME_OPENED")
	--ReagentRestocker:triggerAction(BANKFRAME_OPENED_EVENT)
	
	-- TODO: Check source, destination, and amount that needs to be moved.
	-- Use:
--		ReagentRestockerDB.Options.PullFromBank = false
--		ReagentRestockerDB.Options.OverstockToBank = false
--		ReagentRestockerDB.Options.PullFromGuildBank = false
--		ReagentRestockerDB.Options.OverstockToGuildBank = false

	if ReagentRestockerDB.Options.PullFromBank or ReagentRestockerDB.Options.OverstockToBank then

		-- Call moveItems in the addonTable environment.	
		--local oldEnv = _G.getfenv();
		--setfenv(1,addonTable);
		
	
		if ReagentRestockerDB.Options.PullFromBank then
			
			--TODO: Make sure this is right.
			-- If no items in buy list, then don't bother. 
			if getAllObjsWithTag("Buy") ~= nil then
		
				-- Pull items from bank into inventory as needed
				
				-- Get ItemIDs from buying list
				for k, v in pairs(getAllObjsWithTag("Buy")) do
					inventoryTable = scanForItem(TYPE_BAGS, k)
					
					-- Now we have a table of {bag, slot, itemCount} triples in inventoryTable.
					-- Let's count them.
					local countBags = 0
					for key, val in pairs(inventoryTable) do
						countBags = countBags + val[3]
					end
					
					-- Now to get items in bank
					countBank = 0
					bankTable = scanForItem(TYPE_BANK, k)
					local countBank = 0
					for key, val in pairs(bankTable) do
						countBank = countBank + val[3]
					end
					
					dprint("Amount in bank: " .. countBank .. " Amount in bags: " .. countBags .. " ID: " .. k)
					
					-- Get how many we want
					
					desired = ReagentRestockerDB.Items[k].qty
					
					if desired == nil then error("Corrupt database: " .. k .. " is a buyable item with no buy quantity.") end
	
					moveAmount = desired - countBags
					if countBank < moveAmount then moveAmount = countBank end
					
					if countBags < desired and countBank > 0 and moveAmount > 0 then
						dprint("MOVING "..k .. ", amount " .. moveAmount)
						queueAction(nil, function(...) moveItems(...) end, nil, "moveItems (1)", {TYPE_BANK, TYPE_BAGS, k, moveAmount})
					end
				end
			end
			
		end
		
		if ReagentRestockerDB.Options.OverstockToBank then
			--TODO: Make sure this is right.
			-- If no items in buy list, then don't bother. 
			if getAllObjsWithTag("Buy") ~= nil then
	
	
				-- Put overflow into bank as needed
				
				-- Get ItemIDs from buying list
				for k, v in pairs(getAllObjsWithTag("Buy")) do
					inventoryTable = scanForItem(TYPE_BAGS, k)
					
					-- Now we have a table of {bag, slot, itemCount} triples in inventoryTable.
					-- Let's count them.
					local countBags = 0
					for key, val in pairs(inventoryTable) do
						countBags = countBags + val[3]
					end
					
					-- Now to get items in bank
					countBank = 0
					bankTable = scanForItem(TYPE_BANK, k)
					local countBank = 0
					for key, val in pairs(bankTable) do
						countBank = countBank + val[3]
					end
					
					--print("Amount in bank: " .. countBank .. " Amount in bags: " .. countBags .. " ID: " .. k)
					
					-- Get how many we want
					desired = ReagentRestockerDB.Items[k].qty
					
					--moveAmount = countBags - desired
					--if countBank < moveAmount then moveAmount = countBank end
					
					if countBags > desired then
					queueAction(nil, function(...) moveItems(...) end, nil, "moveItems (2)", {TYPE_BAGS, TYPE_BANK, k, countBags - desired})
					end
				end
			end
			
		end
		
		
		--moveItems(TYPE_BAGS, TYPE_BANK, 34721, 5)
		--setfenv(1, oldEnv);
		--	if not self:lockTransaction(2) then
		--		self:say("You are attempting to begin too many transactions in a short time; ignoring ...")
		--		return
		--	end
	
		--	if self:recursiveMove(self:getOffsetList(bankOffset),getPlayerBagIDList(),getBankBagIDList(), TYPE_BAGS, TYPE_BANK) then
		--		self:say("Working, please wait ...")
		--	end
		triggerAction()
	end
end)

--RegisterEvent("BANKFRAME_OPENED")

-- Disabled until I've figured out how to do guild bank stuff properly.

SubscribeWOWEvent("GUILDBANKFRAME_OPENED",
function()
	--ReagentRestocker:triggerAction(GUILDBANKFRAME_OPENED_EVENT)
	
	--print("GBANK!!")
	
	if ReagentRestockerDB.Options.PullFromGuildBank or ReagentRestockerDB.Options.OverstockToGuildBank then
		
		-- Call moveItems in the addonTable environment.	
		local oldEnv = _G.getfenv();
		setfenv(1,addonTable);
		
	
		if ReagentRestockerDB.Options.PullFromGuildBank then
			-- Pull items from bank into inventory as needed
			
			-- Get ItemIDs from buying list
			for k, v in pairs(getAllObjsWithTag("Buy")) do
				inventoryTable = scanForItem(TYPE_BAGS, k)
				
				-- Now we have a table of {bag, slot, itemCount} triples in inventoryTable.
				-- Let's count them.
				local countBags = 0
				for key, val in pairs(inventoryTable) do
					countBags = countBags + val[3]
				end
				
				-- Now to get items in bank
				countBank = 0
				bankTable = scanForItem(TYPE_GUILDBANK, k)
				local countBank = 0
				for key, val in pairs(bankTable) do
					countBank = countBank + val[3]
				end
				
				--print("Amount in bank: " .. countBank .. " Amount in bags: " .. countBags .. " ID: " .. k)
				
				-- Get how many we want
				desired = ReagentRestockerDB.Items[k].qty
				
				moveAmount = desired - countBags
				if countBank < moveAmount then moveAmount = countBank end

				if countBags < desired and countBank > 0 and moveAmount > 0 then
				queueAction(nil, function(...) moveItems(...) end, nil, "moveItems (3)", {TYPE_GUILDBANK, TYPE_BAGS, k, moveAmount})
				end
			end
			
		end
		
		if ReagentRestockerDB.Options.OverstockToGuildBank then
			-- Put overflow into bank as needed
			
			-- Get ItemIDs from buying list
			for k, v in pairs(getAllObjsWithTag("Buy")) do
				inventoryTable = scanForItem(TYPE_BAGS, k)
				
				-- Now we have a table of {bag, slot, itemCount} triples in inventoryTable.
				-- Let's count them.
				local countBags = 0
				for key, val in pairs(inventoryTable) do
					countBags = countBags + val[3]
				end
				
				-- Now to get items in bank
				countBank = 0
				bankTable = scanForItem(TYPE_GUILDBANK, k)
				local countBank = 0
				for key, val in pairs(bankTable) do
					countBank = countBank + val[3]
				end
				
				--print("Amount in guild bank: " .. countBank .. " Amount in bags: " .. countBags .. " ID: " .. k)
				
				-- Get how many we want
				desired = ReagentRestockerDB.Items[k].qty
				
				--moveAmount = countBags - desired
				--if countBank < moveAmount then moveAmount = countBank end

				if countBags > desired then
					--print("trying to move ID " .. k)
					queueAction(nil, function(...) moveItems(...) end, nil, "moveItems (4)", {TYPE_BAGS, TYPE_GUILDBANK, k, countBags - desired})
				end
			end
		end
		
		--moveItems(TYPE_BAGS, TYPE_BANK, 34721, 5)
		setfenv(1, oldEnv);
		
			--if not self:lockTransaction(2) then
			--	self:say("You are attempting to begin too many transactions in a short time; ignoring ...")
			--	return
			--end
			
			--if self:recursiveMove(self:getOffsetList(bankOffset),getPlayerBagIDList(),getBankBagIDList(), TYPE_BAGS, TYPE_BANK) then
			--	self:say("Working, please wait ...")
			--end
			
	triggerAction()
	end
end)

-- Returns true if the item in the specified slot is locked; false otherwise
function ReagentRestocker:isSlotUnlocked(bagID,bagSlotID)
	local _, _, isLocked = GetContainerItemInfo(bagID, bagSlotID)
	return not isLocked
end

-- Returns true if all of the items in the specified slot are unlocked; false otherwise
function ReagentRestocker:areSlotsUnlocked(bagIDSlotPairs)
	for i=1,#bagIDSlotPairs do
		if not self:isSlotUnlocked(bagIDSlotPairs[i][1],bagIDSlotPairs[i][2]) then
			return false
		end
	end

	return true
end

-- Returns the number of the specified item in the specified bag
function ReagentRestocker:countItemInBag(bagID,itemID)
	local count = 0
	for bagSlotID=1,GetContainerNumSlots(bagID) do
		local itemLink = GetContainerItemLink(bagID,bagSlotID)
		if itemLink then	
			if getIDFromItemLink(itemLink) == itemID then	
				local _, slotCount = GetContainerItemInfo(bagID,bagSlotID)
					count = count + slotCount
			end
		end
	end
	
	return count
end

-- Returns the number of the specified item in the specified bags
function ReagentRestocker:countItemInBags(bagIDList,itemID)
	local count = 0
	for _,bagID in pairs(bagIDList) do
		count = count + self:countItemInBag(bagID,itemID)
	end
	
	return count
end

-- Attempts to safely move an item from one slot to another; splitting often causes problems unless it is 100% necessary
function ReagentRestocker:safeContainerMove(fromBagID, fromBagSlotID, toBagID, toBagSlotID, qty, fromType, toType) -- added isGuildBank because guild banks do things a bit differently :(.

	local sourceStackCount, destStackCount, destStackableCount

	if fromType == TYPE_GUILDBANK then
		_, sourceStackCount = _G.GetGuildBankItemInfo(fromBagID,fromBagSlotID)
	else
		_, sourceStackCount = GetContainerItemInfo(fromBagID,fromBagSlotID)
	end
	
	if toType == TYPE_GUILDBANK then
		_, destStackCount = GetGuildBankItemInfo(toBagID,toBagSlotID)
	else
		_, destStackCount = GetContainerItemInfo(toBagID,toBagSlotID)
	end
	
	if not sourceStackCount then sourceStackCount = 0 end
	if not destStackCount then destStackCount = 0 end			
	
	local doMoveVar = false -- OOPS! doMove is also a function, avoid name clashes!
	if destStackCount > 0 then
		if toType==TYPE_GUILDBANK then
			_, _, _, _, _, _, _, destStackableCount = self:safeGetItemInfo(getIDFromItemLink(GetGuildBankItemLink(toBagID,toBagSlotID)))
		else
			_, _, _, _, _, _, _, destStackableCount = self:safeGetItemInfo(getIDFromItemLink(GetContainerItemLink(toBagID,toBagSlotID)))
		end
		
		if destStackCount + qty >= destStackableCount then
			doMoveVar = true
		end
	end
	
	_G.ClearCursor()
	if sourceStackCount > qty and not doMoveVar then
		if fromType == TYPE_GUILDBANK then
			_G.SplitGuildBankItem(fromBagID,fromBagSlotID,qty)
		else
			_G.SplitContainerItem(fromBagID,fromBagSlotID,qty)
		end
	else
		if fromType == TYPE_GUILDBANK then
			_G.PickupGuildBankItem(fromBagID,fromBagSlotID)
		else
			_G.PickupContainerItem(fromBagID,fromBagSlotID)
		end
	end
	
	if toType == TYPE_GUILDBANK then
		_G.PickupGuildBankItem(toBagID,toBagSlotID)
		ClearCursor()
	else
		_G.PickupContainerItem(toBagID,toBagSlotID)
	end
end

-- Attempts to move items from one baglist to another, based on shopping list
function ReagentRestocker:recursiveMove(startOffsetList, fromBags, toBags, fromType, toType)  -- added isGuildBank because guild banks do things a bit differently :(.
	dprint("recursiveMove called.")
	-- Attempt to find an appropriate move
	local offsetList = self:getOffsetList(bankOffset)
	local fromBagID, fromBagSlotID, toBagID, toBagSlotID, qty, itemID, newFromType, newToType = self:findNecessaryMove(offsetList,fromBags,toBags,fromType,toType)
	if fromBagID then -- If there is one, perform the move, and queue up another recursiveMove
		self:safeContainerMove(fromBagID, fromBagSlotID,toBagID, toBagSlotID, qty, newFromType, newToType)
		local pSSC, pDSC -- strangely named variables by the original author
		-- pSSC = item "from" count from GetContainerItemInfo
		-- pDSC = item "to" count from GetContainerItemInfo 
		-- Guessing "S" is "source," "D" is "destination"
		
		-- SC = some count?
		
		-- Slot Count?
		
		-- Note to future devs: Always comment your code, especially abbreviations!
		
		if fromType ~= TYPE_GUILDBANK then 
			_, pSSC = GetContainerItemInfo(fromBagID,fromBagSlotID)
		else
			_, pSSC = GetGuildBankItemInfo(fromBagID,fromBagSlotID)

		end
		
		if toType ~= TYPE_GUILDBANK then
			_, pDSC = GetContainerItemInfo(toBagID,toBagSlotID)
		else
			_, pDSC = GetGuildBankItemInfo(toBagID,toBagSlotID)
		end
		
		queueAction(
			function()
				local sSC, dSC
				if fromType ~= TYPE_GUILDBANK then 
					_, sSC = GetContainerItemInfo(fromBagID,fromBagSlotID)
				else
					_, sSC = GetGuildBankItemInfo(fromBagID,fromBagSlotID)
				end
				
				if toType ~= TYPE_GUILDBANK then 
					_, dSC = GetContainerItemInfo(toBagID,toBagSlotID)
				else
					_, dSC = GetGuildBankItemInfo(toBagID,toBagSlotID)
				end
				
				return self:areSlotsUnlocked({{fromBagID, fromBagSlotID},{toBagID, toBagSlotID}}) and pSSC ~= sSC and pDSC ~= dSC
			end,
			function() 
				self:recursiveMove(startOffsetList, fromBags, toBags, fromType, toType)
			end
			, nil, "??"
			)
		return true
	else -- If there isn't one, return false, and report our findings from movesThusFar
		local withdrawList, depositList, msgs = {}, {}, {} 
		for itemID, qty in pairs(tDiff(startOffsetList, offsetList)) do
			local _, itemLink = self:safeGetItemInfo(itemID)
			if qty > 0 then table.insert(depositList,string.format("%d %s",qty,itemLink)); else if qty < 0 then table.insert(withdrawList,string.format("%d %s",-1*qty,itemLink)); end end
		end		
		if #withdrawList == 0 and #depositList == 0 then
			self:say("No bank transactions are necessary.")
		else	
			if #withdrawList > 0 then 
				table.insert(msgs,string.format("Deposited %s.",table.concat(withdrawList,", ")))
			end
			if #depositList > 0 then
				table.insert(msgs,string.format("Withdrew %s.",table.concat(depositList,", ")))
			end
			self:say(table.concat(msgs,"  "))
		end
	end
end

-- Returns a necessary move; nil if there are none
function ReagentRestocker:findNecessaryMove(offsetList, fromBags, toBags, fromType, toType)
	dprint("findNecessaryMove called.")
	map(offsetList,function(itemID, qty) if qty == 0 then offsetList[itemID] = nil; end end)
	for itemID, qty in pairs(offsetList) do
		local lFromBags, lToBags, lfromType, ltoType = fromBags, toBags, fromType, toType
		if qty < 0 then -- We are moving FROM the TOBAGS to TO the FROMBAGS, so switch 'em
			lToBags, lFromBags, ltoType, lfromType, qty = fromBags, toBags, lfromType, ltoType, -1*qty
		end
		local fromBagID, fromBagSlotID, fromQty = self:findOptimalItemsToMove(lToBags, itemID, ltoType)
		if fromBagID then -- fromBagID will be nil if fOITM was unsuccessful
			local toBagID, toBagSlotID, toQty = self:findOptimalDestinationInBags(lFromBags, itemID, lfromType)
			if toBagID then -- toBagID will be nil if fODIB was unsuccessful
				return fromBagID, fromBagSlotID, toBagID, toBagSlotID, min(fromQty, toQty, qty), itemID, lfromType, ltoType			
			end
		end
	end
	return nil
end

-- Returns the location and quantity of an item that should be moved; nil if there are none
function ReagentRestocker:findOptimalItemsToMove(bagIDList, itemID, bagType)
	dprint("findOptimalItemsToMove called.")
	-- Find the optimal bag to remove the item from (least of that item)
	local itemInBagCountList = {}
	map(bagIDList,function(_,bagID) local count = self:countItemInBag(bagID,itemID, bagType); if count > 0 then table.insert(itemInBagCountList,{bagID,count}); end end)
	table.sort(itemInBagCountList,	function(x, y) if (x[2] ~= y[2]) then return x[2] < y[2]; else return (x[1] > y[1]); end end)
	
	if bagType == TYPE_BAGS or bagType == TYPE_BANK then
	
		for _, data in pairs(itemInBagCountList) do
			local bagSlotItemCount = {}
			for bagSlotID=1,GetContainerNumSlots(data[1]) do
				local itemLink = GetContainerItemLink(data[1], bagSlotID)
				if itemLink then
					local _, itemCount = GetContainerItemInfo(data[1], bagSlotID)
					local sourceItemID = getIDFromItemLink(itemLink)
					if sourceItemID == itemID then
						table.insert(bagSlotItemCount,{bagSlotID,itemCount})
					end
				end
			end
			-- Find the slot with the lowest value and return it
			table.sort(bagSlotItemCount, function(x,y) return x[2] < y[2]; end)
			for i=1,#bagSlotItemCount do
				return data[1], bagSlotItemCount[i][1], bagSlotItemCount[i][2]
			end
		end
	elseif bagType == TYPE_GUILDBANK then
		for _, data in pairs(itemInBagCountList) do
			local bagSlotItemCount = {}
			for bagSlotID=1,98 do  -- Guild banks always have 98 items.
				local itemLink = GetGuildBankItemLink(data[1], bagSlotID)
				if itemLink then
					local _, itemCount = GetGuildBankItemInfo(data[1], bagSlotID)
					local sourceItemID = getIDFromItemLink(itemLink)
					if sourceItemID == itemID then
						table.insert(bagSlotItemCount,{bagSlotID,itemCount})
					end
				end
			end
			-- Find the slot with the lowest value and return it
			table.sort(bagSlotItemCount, function(x,y) return x[2] < y[2]; end)
			for i=1,#bagSlotItemCount do
				return data[1], bagSlotItemCount[i][1], bagSlotItemCount[i][2]
			end
		end
		
	end
	return nil
end

-- Returns the "optimal" slot in the bags for the item to be placed and the number that can be moved there; nil if impossible
function ReagentRestocker:findOptimalDestinationInBags(bagIDList, itemID)
	dprint("findOptimalDestinationInBags called.")
	-- First, find the optimal bag to place the item in (the once with the most of it)
	local itemInBagCountList = {}
	map(bagIDList,function(_,bagID) table.insert(itemInBagCountList,{bagID,self:countItemInBag(bagID,itemID)}); end)
	table.sort(itemInBagCountList,	function(x, y) if (x[2] ~= y[2]) then return x[2] > y[2]; else return (x[1] < y[1]); end end)
	for _, data in pairs(itemInBagCountList) do
		-- TODO: We're mostly avoiding special bag types
		if data[2] > 0 or not self:isSpecialBagType(data[1]) then
			local bagID, bagSlotID, qty = self:findOptimalDestinationInBag(data[1],itemID)
			if bagID then -- bagID is nil if fODIB returns a negative result (no space)
				return data[1], bagSlotID, qty
			end
		end
	end
	return nil
end

-- Returns the "optimal" slot in the bag for the item to be placed and the number that can be moved there; nil if impossible
function ReagentRestocker:findOptimalDestinationInBag(bagID, sourceItemID)
	dprint("findOptimalDestinationInBag called.")

	-- First, look for any stacks of the item that are not full
	local _, _, _, _, _, _, _, itemStackSize = self:safeGetItemInfo(sourceItemID)
	local slotStatusList, OPEN, CLOSED, SAME = {}, 0, -1, 1
	for bagSlotID=1,GetContainerNumSlots(bagID) do
		local itemLink = GetContainerItemLink(bagID, bagSlotID)
		if itemLink then
			local _, itemCount = GetContainerItemInfo(bagID, bagSlotID)
			local itemID = getIDFromItemLink(itemLink)
			if sourceItemID == itemID then
				slotStatusList[bagSlotID] = SAME
				if itemCount < itemStackSize then
					return bagID, bagSlotID, itemStackSize - itemCount
				end
			else
				slotStatusList[bagSlotID] = CLOSED
			end
		else
			slotStatusList[bagSlotID] = OPEN
		end
	end
	
	-- No un-full stacks were found; look for a pattern in the full ones
	local emptySlotList, sameItemSlotList, hopSizeList, bestDiffVal = {}, {}, {}, 1
	map(slotStatusList,function(slotID, status) if status == SAME then table.insert(sameItemSlotList,slotID); end end)
	map(slotStatusList,function(slotID, status) if status == OPEN then table.insert(emptySlotList,slotID); end end)
	
	-- If there are no empty slots, return nil
	if #emptySlotList == 0 then
		return
	end
	
	if #sameItemSlotList > 1 then
		-- We have more than 1 stack of the item in the bag; find the modal difference in slot IDs
		for i=1,#sameItemSlotList-1 do
			local diff = abs(sameItemSlotList[i+1] - sameItemSlotList[i])
			if hopSizeList[diff] then
				hopSizeList[diff] = hopSizeList[diff] + 1
			else
				hopSizeList[diff] = 1	
			end
		end
		local bestDiffCount = 0
		map(hopSizeList, function (diffVal, diffCount) if diffCount > bestDiffCount then bestDiffVal = diffVal; bestDiffCount = diffCount; end end)
	end
	
	-- Look in each slot "diff" away from the slot in which the same item exists; if it is available, use it
	for _, slot in pairs(sameItemSlotList) do
		if inT(emptySlotList,slot-bestDiffVal) then
			return bagID, slot-bestDiffVal, itemStackSize
		elseif inT(emptySlotList,slot+bestDiffVal) then
			return bagID, slot+bestDiffVal, itemStackSize		
		end
	end
	
	-- No good places to put the item; just return the [at least] one we know exists
	return bagID, emptySlotList[1], itemStackSize
end

-- Returns true if the bag is of a special bag type; false otherwise
function ReagentRestocker:isSpecialBagType(bagID)
	-- Every item can go in the backpack (0) or bank slots (-1)
	if bagID == 0 or bagID == -1 then
		return false
	end

	local inventoryID = _G.ContainerIDToInventoryID(bagID)
	local itemLink = _G.GetInventoryItemLink("player",inventoryID)

	-- If there's no bag, it's not compatible
	if not itemLink then
		return true
	end
	
	local _, _, _, _, _, _, itemSubType = self:safeGetItemInfo(getIDFromItemLink(itemLink))
	
	-- No way to check the type without localizing; if the name is long, it's a special bag, so NO
	if strlen(itemSubType) < 8 then	
		return false
	else		
		return true
	end
end

--------------------------------------------------------------------------------
-- Decision time: Should I rewrite the restocking code to allow me to use guild
-- bank stuff?

-- Decision: I'm at least gonna try. The current code is simply not in good
-- enough shape to do it easily.
--------------------------------------------------------------------------------

-- Item movement is pick up / place down based, let's not fight that.

-- No, I'm just gonna do it another way. Picking up/ placing flopped, turned
--out to be unreliable, got a new method that is a lot more KISS. 

-- Returns amount that will be picked up
function pickupItem(location, bag, slot, itemID, amount)

	local returnAmount = 0
	
	-- Clear anything that may be already on the cursor.
	_G.ClearCursor()

	
	dprint("pickupItem called, picking up from bag " .. bag .. " slot " .. slot .. ", amount " .. amount)
	--print("Picking up ID " .. itemID .. " from " .. locationString(location))
	local itemCount, locked
	if location == TYPE_GUILDBANK then
		_, itemCount, locked = GetGuildBankItemInfo(fromBag, fromSlot)
		if not locked then
			if itemCount > amount and itemCount > 1 then
				-- need to split the stack
				_G.SplitGuildBankItem(bag, slot, amount)
				returnAmount = amount
			else
				-- pick up the whole thing
				_G.PickupGuildBankItem(bag, slot)
				returnAmount = itemCount
			end
		else
			--returnAmount = amount
			--queuePickup(location, bag, slot, itemID, amount)
			--queueAction(nil, function() pickupItem(location, bag, slot, itemID, amount) end, nil, "pickupItem (1)")
			--pickupItem(v[2], v[3], v[4], v[5], v[6])
			return 0;
		end
	else
		_, itemCount, locked, _, _, _, link = GetContainerItemInfo(fromBag, fromSlot)
		
		if itemCount == nil then error("Cannot find item ID " .. itemID .. " in bag " .. bag .. " slot " .. slot) end
		
		if not locked then
			if itemCount > amount and itemCount > 1 then
				-- need to split the stack
				dprint("Splitting " .. amount .. " of type " .. link .. ", bag number " .. bag .. ", slot " .. slot .. ", ItemID " .. itemID .. ", and we have " .. itemCount .. " items to split from.")
				_G.SplitContainerItem(bag, slot, amount) 
				returnAmount = amount
			else
				-- pick up the whole thing
				_G.PickupContainerItem(bag, slot)
				returnAmount = itemCount
			end
		else
			--error("BOO")
			--returnAmount = amount
			--queuePickup(location, bag, slot, itemID, amount)
			--queueAction(nil, function() pickupItem(location, bag, slot, itemID, amount) end, nil, "pickupItem (2)")
			
			--dprint("dis amount: " .. amount .. " ret amt: " .. returnAmount)
			return 0
		end
	end
	
	if returnAmount == 0 then error("amount: "  .. amount .. " itemCount: " .. itemCount) end
	--coroutine.yield()
	return returnAmount
end

moveQueue = {}

-- Item is locked, queue it to be picked up later.
--function queuePickup(location, bag, slot, itemID, amount)
--	--print("Pickup LOCKED")
--	dprint("(moveQueue) Item added via queuePickup.")
--	tinsert(moveQueue, {"pickup", location, bag, slot, itemID, amount})
--	processQueueItem()
--end


-- Puts item in location.
-- Returns false on failure.
function placeItem(location, bag, slot, itemID)
-- Behavior notice: When placing an item in a slot, WoW will try to fill it up
-- as much as possible. If there is too much for the slot, then WoW will leave
-- the rest unmoved.
	--dprint("Placing ID " .. itemID .. " in " .. locationString(location))
	dprint("placeItem called")
	
	_, zitemCount, zlocked, _, _, _, zlink = GetContainerItemInfo(toBag, toSlot)
	
	-- Not actually an error, we could just be adding to a stack.
	--if zlink ~= nil then
	--	error("There are " .. zitemCount .. " " .. zlink .. "s in the slot we are trying to place something in . . . .")
	--end
	
	local itemCount, locked
	if location == TYPE_GUILDBANK then
		_, itemCount, locked = _G.GetGuildBankItemInfo(bag, slot)
		if locked == nil and _G.CursorHasItem() then -- Make sure we have an item to place
			_, _, iName = _G.GetCursorInfo()
			dprint("Cursor has " .. iName)
			_G.PickupGuildBankItem(bag, slot)
		else
			--_G.PickupGuildBankItem(bag, slot)
			--error("bad place")
			--dprint("queueing place")
			--queuePlace(location, bag, slot, itemID)
			--queueAction(nil, function() placeItem(location, bag, slot, itemID) end, nil, "placeItem (1)")
			dprint("locked(1)")
			return false
		end
	else
		_, itemCount, locked = GetContainerItemInfo(bag, slot)
		if locked == nil and _G.CursorHasItem() then -- Make sure we have an item to place
			_, _, iName = _G.GetCursorInfo()
			dprint("Cursor has " .. iName)
			_G.PickupContainerItem(bag, slot)
			dprint("placing item into bag " .. bag .. " slot " .. slot)
		else
			--_G.PickupContainerItem(bag, slot)
			--error("bad place")
			--dprint("queueing place")
			--queuePlace(location, bag, slot, itemID)
			--queueAction(nil, function() placeItem(location, bag, slot, itemID) end, nil, "placeItem (2)")
			dprint("locked(2)")
			--error("locked(2)")
			return false
		end
	end
	
	-- Item still on cursor? Queue it and try again.
	--if _G.CursorHasItem() then
		--error("BAG: " .. bag .. " SLOT: " .. slot)
		--queuePlace(location, bag, slot, itemID)
	--end
	return true
end

-- Item is locked, queue it to be placed later.
function queuePlace(location, bag, slot, itemID)
	--print("Placement LOCKED")
	dprint("(moveQueue) Item added via queuePlace.")
	tinsert(moveQueue, {"place", location, bag, slot, itemID})
	--processQueueItem()
	--triggerAction()
end

-- Any time a lock changes, see if we can do what we wanted to do while it was
-- locked.
SubscribeWOWEvent("ITEM_LOCK_CHANGED",
function()
	dprint("ITEM_LOCK_CHANGED")
	--processQueueItem()
	triggerAction(ITEM_LOCK_CHANGED)
end)

-- DISABLED IN AN ATTEMPT TO MAKE MORE RELIABLE
SubscribeWOWEvent("BAG_UPDATE",
function()
	dprint("BAG_UPDATE")
	--processQueueItem()
	--triggerAction(BAG_UPDATE)
end)

-- DISABLED IN AN ATTEMPT TO MAKE MORE RELIABLE
SubscribeWOWEvent("PLAYER_MONEY",
function()
	dprint("PLAYER_MONEY")
	--processQueueItem()
	--triggerAction(PLAYER_MONEY)
end)

-- Move item from one location to another.
function moveItems(fromLocation, toLocation, itemID, amount)

	if amount <= 0 then error("Can't move " .. amount .. " of itemID " .. itemID .. ".") end

	dprint("moveItems called, we will be moving " .. amount .. " of " .. itemID .. ".")

	local firstAmount = amount
	local freeSlots = scanForOpenSlots(toLocation, itemID)
	local itemList = scanForItem(fromLocation, itemID)
	local name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = _G.GetGuildBankTabInfo(1)

	--print("outside loop")
	--print("amount " .. amount)
	--print("#freeslots " .. #freeSlots)
	--print("#itemList " .. #itemList)
	
	-- NOTE: Either the source or the destination is ALWAYS one of your bags.
	-- Take advantage of that to simplify things. Also, stick with KISS!
	-- My first attempt to rewrite this code was totally overthought and
	-- a total wreck.
	
	-- Thanks to Steelfistv in the forums for coming up with macros that
	-- could be easily adapted to use with this addon.
	
	
	-- Make sure we have enough to move. If not, move what we can.
	--[[numCanMove = getItemAmount(fromLocation, fromBag, fromSlot)
	if numCanMove < amount then
		amount = numCanMove
	end
	
	if fromLocation == TYPE_GUILDBANK then
		for b=1,GetNumGuildBankTabs() do
			for s=1,98 do
				local n=GetGuildBankItemLink(b,s)
				if n and strfind(n,"Glyph")then
				print("Withdrawing "..n)
				AutoStoreGuildBankItem(b,s)
				end
			end
		end
	elseif fromLocation == TYPE_BANK then
		-- from bank to bags
		for s=1,28 do
			n=GetContainerItemLink(BANK_CONTAINER,s)
			if n and strfind(n,"Glyph") then
				print("Withdrawing "..n)
				UseContainerItem(BANK_CONTAINER,s)
			end
		end
	else
		-- From bags to bank
		for b=0,4 do
			for s=1,GetContainerNumSlots(b) do
				local n=GetContainerItemLink(b,s)
				if n and strfind(n,"Glyph")then
					print("Depositing "..n)
					UseContainerItem(b,s)
				end
			end
		end
	end]]--
	
	
	-- Can't do these inside the loop! Doesn't update until control is passed back to WoW.
	freeSlots = scanForOpenSlots(toLocation, itemID)
	itemList = scanForItem(fromLocation, itemID)

	--while amount > 0 and #freeSlots > 0 and #itemList > 0 do
	if amount > 0 and #freeSlots > 0 and #itemList > 0 then
	

		dprint("amount: " .. amount .. " Free slots: " .. #freeSlots .. " itemList: " .. #itemList)
		name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = _G.GetGuildBankTabInfo(1)
		
		--print("Remaining withdrawls: " .. remainingWithdrawals)
		if(fromLocation == TYPE_GUILDBANK and remainingWithdrawls <= 1) then
			print("Not using any more bank withdrawls")
			return;
		end
	
		fromBag = itemList[#itemList][1]
		fromSlot = itemList[#itemList][2]
		fromAmount = itemList[#itemList][3]
		
		toBag = freeSlots[#freeSlots][1]
		toSlot = freeSlots[#freeSlots][2]
		
		--if toSlot == 0 then error("gadhgiklsdj") end

		--rprint(4, freeSlots)
		--print("toSlot " .. toSlot)

		--print("trying to move ID " .. itemID .. " from " .. locationString(fromLocation) .. " to " .. locationString(toLocation))
		
		amount = amount - doMove(fromLocation, fromBag, fromSlot, toLocation, toBag, toSlot, amount, itemID)
		freeSlots[#freeSlots] = nil
		--if getItemAmount(fromLocation, fromBag, fromSlot) <=0 then
			itemList[#itemList] = nil
		--else
			--itemList[#itemList] == ??
		--end
		-- Re-queue if we still have items left
		if amount > 0 then
			queueAction(nil, function(...) moveItems(...) end, BAG_UPDATE, "moveItems (re-queued)", {fromLocation, toLocation, itemID, amount})
			amount = 0
		end		
	end
	

	
end

-- Performs a single move. Returns the number of items actually moved.
function doMove(fromLocation, fromBag, fromSlot, toLocation, toBag, toSlot, amount, itemID)

	dprint("doMove called, will be moving " .. amount .. " of " .. itemID)
	if fromLocation == toLocation then error("can't move something to the same place.") end

	-- Check if the slots are locked
	--local _, _, isFromLocked = GetContainerItemInfo(fromBag, fromSlot)
	--local _, _, isToLocked = GetContainerItemInfo(toBag, toSlot)
	
	--if isFromLocked or isToLocked then
	--	return 0 -- It's locked, don't even try to move.
	--end
	

	--beforeCount = getItemAmount(fromLocation, fromBag, fromSlot)
	
	local _, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)
	local texture, itemCount, locked, link

	--print("amount " .. amount)
	
	-- Get the amount of the item initially in the from location.
	if fromLocation == TYPE_GUILDBANK then
		texture, itemCount, locked, _, _, _, link = GetGuildBankItemInfo(fromBag, fromSlot)
	else
		texture, itemCount, locked, _, _, _, link = GetContainerItemInfo(fromBag, fromSlot)
	end
	
	local name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = _G.GetGuildBankTabInfo(1)
	
	if (fromLocation == TYPE_GUILDBANK or toLocation == TYPE_GUILDBANK) and (remainingWithdrawals <= 1) then
		print("You have one or less withdrawls left. Reagent Restocker will not use the last withdrawl for automatic processing.")
	else
		noQueue = true
		movedCount = pickupItem(fromLocation, fromBag, fromSlot, itemID, amount)
		placedSucceeded = placeItem(toLocation, toBag, toSlot, itemID)
		noQueue = false
		
		if placedSucceeded == false then
			dprint("placement failed.")
			movedCount = 0
		end
	end


	if fromLocation == TYPE_GUILDBANK then
		_, newCount, _, _, _, _, _ = GetGuildBankItemInfo(fromBag, fromSlot)
	else
		_, newCount, _, _, _, _, _ = GetContainerItemInfo(fromBag, fromSlot)
	end

	--afterCount = getItemAmount(fromLocation, fromBag, fromSlot)
	
	--return  beforeCount - afterCount
	dprint("amount moved: " .. movedCount)	
	return movedCount
	--return afterCount
end

function locationString(location)
	if location == TYPE_GUILDBANK then return "guild bank"
	elseif location == TYPE_BAGS then return "bags"
	elseif location == TYPE_BANK then return "bank"
	else return "unknown" end
end

function getItemAmount(location, bag, slot)
	dprint("getItemAmount called")

	local amount
	if fromLocation == TYPE_GUILDBANK then
		_, amount, _, _, _, _, _ = GetGuildBankItemInfo(bag, slot)
	else
		_, amount, _, _, _, _, _ = GetContainerItemInfo(bag, slot)
	end
	return amount
end

-- Scan for open slots for item. if itemID is used, then look for incomplete
-- stacks.
-- Returns a table with pairs of available slots in {bagID, slot, count} format.
-- count is the number of items in the slot.
function scanForOpenSlots(location, itemID)
	dprint("scanForOpenSlots called")

	local openStacks = {}
	local emptySlots = {}
	local texture, itemCount, locked, link

	if location == TYPE_GUILDBANK then
		curTab =  _G.GetCurrentGuildBankTab( )
		--print("# GB tabs: " .. _G.GetNumGuildBankTabs() .. " Current tab: " .. curTab)
		_G.QueryGuildBankTab( _G.GetCurrentGuildBankTab( ) or 1 )  -- Thanks ArkInventory . . .
--		for bag=1,_G.GetNumGuildBankTabs() do
--		for bag=1,1 do
		bag=1
			local name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = _G.GetGuildBankTabInfo( bag )

		--_G.QueryGuildBankTab(bag) 
			-- Make sure we're only checking slots the player can access
			local canView, canDeposit, stacksPerDay = _G.GetGuildBankTabPermissions(bag)
			
			if _G.IsGuildLeader() or canView or canDeposit or isViewable then
				-- Guild Bank currently always has 98 items.
				for item=1,98 do
					texture, itemCount, locked, _, _, _, link = _G.GetGuildBankItemInfo(bag, item)
					if link ~= nil then 
						ID = getIDFromItemLink(link)
					else
						-- Nothing in the slot. Therefore, it's empty.
						table.insert(emptySlots, {bag, item, 0})
					end

					if itemCount ~=nil and itemID ~= nil and ID ~= nil and itemID == ID and locked==nil then
						_, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)

						-- For some odd reason, we still have to check itemCount for being nil?
						if itemID ~= nil and itemCount < itemStackSize then
							table.insert(openStacks, {bag, item, itemCount})
						end
					end
					
					if itemCount == 0 then
						table.insert(emptySlots, {bag, item, 0})
					end
					
				end
			end
		--end
	elseif location == TYPE_BAGS then
		--print("BAGS")
		for bag=0,NUM_BAG_SLOTS do
			for item=1,GetContainerNumSlots(bag) do
				texture, itemCount, locked, _, _, _, link = GetContainerItemInfo(bag, item)
				if link ~= nil then 
					ID = getIDFromItemLink(link)
				else
					-- Nothing in the slot. Therefore, it's empty.
					table.insert(emptySlots, {bag, item, 0})
				end

				if itemCount ~=nil and itemID ~= nil and ID ~= nil and itemID == ID and locked==nil then
					_, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)

					-- For some odd reason, we still have to check itemCount for being nil?
					if itemID ~= nil and itemCount < itemStackSize then
						table.insert(openStacks, {bag, item, itemCount})
						
						--print("TINSERT");
					end
				end
				
				if itemCount == 0 then
					table.insert(emptySlots, {bag, item, 0})
				end
				
			end
		end
	elseif location == TYPE_BANK then

		for bag=NUM_BAG_SLOTS+1,NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
			for item=1,GetContainerNumSlots(bag) do
				texture, itemCount, locked, _, _, _, link = GetContainerItemInfo(bag, item)
				
				
				if link ~= nil then 
					ID = getIDFromItemLink(link)
				else
					-- Nothing in the slot. Therefore, it's empty.
					table.insert(emptySlots, {bag, item, 0})
				end

				if itemCount ~=nil and itemID ~= nil and ID ~= nil and itemID == ID and locked==nil then
					--print(itemCount)
					_, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)
					
					-- For some odd reason, we still have to check itemCount for being nil?
					if itemCount ~= nil and itemCount < itemStackSize then
						table.insert(openStacks, {bag, item, itemCount})
					end
				end
				
				if itemCount == 0 then
					table.insert(emptySlots, {bag, item, 0})
				end
				
			end
		end
	elseif location == TYPE_KEYS then
		error("Reagent Restocker does not manage keys.");
	else
		error("Reagent Restocker does not recognize location " .. location .. " of type " .. type(location) .. ".")
	end
	
	returnTable={}
	position = 1

	for k, v in pairs(emptySlots) do
		returnTable[position] = v
		position = position + 1
	end
	
	if itemID ~= nil then --and ID ~= nil and itemID == ID then
		--print("OPEN STACKS")
		
		-- sort
		if openStacks ~= nil then
			table.sort(openStacks, 
				function(a, b)
				return a[3] < b[3]
			end)
		end
		
		
		for k, v in pairs(openStacks) do
			returnTable[position] = v
			position = position + 1
		end
	end
	
	
	--print("NUM ITEMS: " .. #returnTable)
	--return emptySlots
	return returnTable
	
end

-- Scans for an item in a location
-- Returns a table of lists containing the bag, slot, and amount
function scanForItem(location, itemID)
	dprint("scanForItem called")

	local itemList = {}
	if location == TYPE_GUILDBANK then
		--for bag=0,_G.GetNumGuildBankTabs() do
		bag=1
			-- Make sure we're only checking slots the player can access
			canView = _G.GetGuildBankTabPermissions(bag)
			local name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = _G.GetGuildBankTabInfo( bag )
			if _G.IsGuildLeader() or canView or isViewable then
				-- Guild Bank currently always has 98 items.
				for item=0,98 do
					texture, itemCount, locked, _, _, _, link = _G.GetGuildBankItemInfo(bag, item)
					if link ~= nil then ID = getIDFromItemLink(link) end
					
					if itemID ~= nil and ID ~= nil and itemID == ID and locked==nil and itemCount ~= nil then
						--print("bag " .. bag .. " slot " .. slot .. " itemCount " .. itemCount)
						table.insert(itemList, {bag, slot, itemCount})
					end
				end
			end
		--end
	elseif location == TYPE_BAGS then
		for bag=0,NUM_BAG_SLOTS do
			if bag > 0 then
				local bagLink=_G.GetInventoryItemLink("player", _G.ContainerIDToInventoryID(bag))
				_, _, _, _, _, _, itemSubType =  _G.GetItemInfo(bagLink)
			else
				itemSubType = "Bag" -- Trying to get the bag type of the backpack just results in an error. Don't even try.
			end
			if itemSubType == "Bag" then -- Only try to put items in non-special bag types.
				-- TODO: Ideally, we could detect the item type and try to put the item in the proper bag type.
				for item=0,GetContainerNumSlots(bag) do
					texture, itemCount, locked, _, _, _, link = GetContainerItemInfo(bag, item)
					if link ~= nil then ID = getIDFromItemLink(link) end
	
					--if itemID ~= nil and ID ~= nil  then print("bag " .. bag .. " item " .. item .. " itemID " .. itemID .. " ID " .. ID) end
					if itemID ~= nil and ID ~= nil and itemID == ID and locked==nil and itemCount ~= nil then
	
						_, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)
						--print("bag " .. bag .. " item " .. item .. " itemCount " .. itemCount)
						table.insert(itemList, {bag, item, itemCount})
					end
				end
			end
		end
	elseif location == TYPE_BANK then
		--bank
		bag=BANK_CONTAINER
		for item=0,GetContainerNumSlots(bag) do
			texture, itemCount, locked, _, _, _, link = GetContainerItemInfo(bag, item)
			if link ~= nil then ID = getIDFromItemLink(link) end
			
			if itemID ~= nil and ID ~= nil and itemID == ID and locked==nil and itemCount ~= nil then
				_, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)
				--print("bag " .. bag .. " item " .. item .. " itemCount " .. itemCount)
				table.insert(itemList, {bag, item, itemCount})
			end
		end
		-- Bags in bank
		for bag=NUM_BAG_SLOTS+1,NUM_BAG_SLOTS+_G.GetNumBankSlots() do
			local bagLink=_G.GetInventoryItemLink("player", _G.ContainerIDToInventoryID(bag))
			_, _, _, _, _, _, itemSubType =  _G.GetItemInfo(bagLink)
			if itemSubType == "Bag" then -- Only try to put items in non-special bag types.
				for item=0,GetContainerNumSlots(bag) do
					texture, itemCount, locked, _, _, _, link = GetContainerItemInfo(bag, item)
					if link ~= nil then ID = getIDFromItemLink(link) end
					
					if itemID ~= nil and ID ~= nil and itemID == ID and locked==nil and itemCount ~= nil then
						_, _, _, _, _, _, _, itemStackSize = ReagentRestocker:safeGetItemInfo(itemID)
						--print("bag " .. bag .. " item " .. item .. " itemCount " .. itemCount)
						table.insert(itemList, {bag, item, itemCount})
					end
				end
			end
		end
	elseif location == TYPE_KEYS then
		error("Reagent Restocker does not manage keys.");
	else
		error("Reagent Restocker does not recognize location " .. location .. " of type " .. type(location) .. ".")
	end
	
	table.sort(itemList, function(item1, item2) return item1[3] < item2[3] end)
	return itemList
end

--== Queue functions  ==--

-- At first, I didn't think it was necessary, but it appears WoW is very picky
-- at not allowing too many transactions in a single game "tick". So I'm putting
-- this back in.

QueuedActions = {}

-- eventID optional, will trigger on any event if it's left out.
-- args is arguments for called event.
function queueAction(evaluator, action, eventID, name, args)
	dprint("QueueAction called.")
	--dprint("(QueuedActions) Action queued.")
	--print(type(...))
	table.insert(QueuedActions,{evaluator,action,eventID, name, ["args"]=args})
end

-- Allow us to disable the queue at certain times.
noQueue = false

function triggerAction(eventID)
	dprint("triggerAction called.")
	if QueuedActions and noQueue == false then
		-- self:say(string.format("A [%s] event has been triggered.",tostring(eventID)))
		--dprint("(QueuedActions) triggerAction.")

		i=#QueuedActions

		-- Only run the action if the correct eventID is specified -or- if there is no event specified
		if i>0 and (not QueuedActions[i][3] or QueuedActions[i][3] == eventID) then

			if QueuedActions[i][1]==nil then
				QueuedActions[i][1] = function() return true; end -- if no evaluation, make one that is always true
			end

			if QueuedActions[i][1]() then
				-- If the evaluator for an action is true, then its associated action is performed; then the action is deleted
				local theAction = QueuedActions[i][2]
				if QueuedActions[i][4] then
					dprint("Running an action named ".. QueuedActions[i][4] .." in the queue.")
				else
					dprint("Running an action in the queue.")
				end
				
				if QueuedActions[i].args~=nil then
				theAction(unpack(QueuedActions[i].args))
				else
					theAction()
				end
				table.remove(QueuedActions,i)
			end
		end
	end
end

-- Processes picking up and placing items. Returns the number of items left in the list.
function processQueueItem()
	dprint("(moveQueue) processing queue.")
	if #moveQueue == 0 then return 0 end 

	dprint("queued action triggered.")
	
	local v = tremove(moveQueue, 1)

	if v[1]=="pickup" then
		pickupItem(v[2], v[3], v[4], v[5], v[6])
	else
		placeItem(v[2], v[3], v[4], v[5])
	end
	
	
	return #moveQueue

	--location, bag, slot, itemID, amount
end

-- Special bag names:
-- Herb Bag
-- Enchanting Bag
-- Engineering Bag
-- Gem Bag??
-- Mining Bag
-- Leatherworking bag??
-- Inscription Bag
-- Tackle Box

setfenv(1, oldEnv);
ReagentRestockerDB=addonTable.ReagentRestockerDB


-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Util = TSM.Banking:NewPackage("Util")
local TempTable = TSM.LibTSMUtil:Include("BaseType.TempTable")
local Group = TSM.LibTSMTypes:Include("Group")
local BagTracking = TSM.LibTSMService:Include("Inventory.BagTracking")
local WarbankTracking = TSM.LibTSMService:Include("Inventory.WarbankTracking")
local Guild = TSM.LibTSMService:Include("Guild")
local private = {}



-- ============================================================================
-- Module Functions
-- ============================================================================

function Util.BagIterator(autoBaseItems)
	local query = BagTracking.CreateQueryBags()
		:OrderBy("slotId", true)
	if autoBaseItems then
		query:VirtualField("autoBaseItemString", "string", Group.TranslateItemString, "itemString")
			:Select("bag", "slot", "autoBaseItemString", "quantity")
	else
		query:Select("bag", "slot", "itemString", "quantity")
	end
	if TSM.Banking.IsGuildBankOpen() then
		query:Equal("isBound", false)
	end
	return query:IteratorAndRelease()
end

function Util.OpenBankIterator(autoBaseItems)
	if TSM.Banking.IsGuildBankOpen() then
		local query = Guild.NewIndexQuery()
		if autoBaseItems then
			query:VirtualField("autoBaseItemString", "string", Group.TranslateItemString, "itemString")
				:Select("tab", "slot", "autoBaseItemString", "quantity")
		else
			query:Select("tab", "slot", "itemString", "quantity")
		end
		return query:IteratorAndRelease()
	elseif TSM.Banking.IsWarBankOpen() then
		local query = WarbankTracking.CreateQuerySlot()
			:OrderBy("slotId", true)
		if autoBaseItems then
			query:VirtualField("autoBaseItemString", "string", Group.TranslateItemString, "itemString")
				:Select("bag", "slot", "autoBaseItemString", "quantity")
		else
			query:Select("bag", "slot", "itemString", "quantity")
		end
		return query:IteratorAndRelease()
	else
		local query = BagTracking.CreateQueryBank()
			:OrderBy("slotId", true)
		if autoBaseItems then
			query:VirtualField("autoBaseItemString", "string", Group.TranslateItemString, "itemString")
				:Select("bag", "slot", "autoBaseItemString", "quantity")
		else
			query:Select("bag", "slot", "itemString", "quantity")
		end
		return query:IteratorAndRelease()
	end
end

function Util.PopulateGroupItemsFromBags(items, groups, getNumFunc, ...)
	local itemQuantity = TempTable.Acquire()
	for _, _, _, itemString, quantity in Util.BagIterator(true) do
		if private.InGroups(itemString, groups) then
			itemQuantity[itemString] = (itemQuantity[itemString] or 0) + quantity
		end
	end
	for itemString, numHave in pairs(itemQuantity) do
		local numToMove = getNumFunc(itemString, numHave, ...)
		if numToMove > 0 then
			items[itemString] = numToMove
		end
	end
	TempTable.Release(itemQuantity)
end

function Util.PopulateGroupItemsFromOpenBank(items, groups, getNumFunc, ...)
	local itemQuantity = TempTable.Acquire()
	for _, _, _, itemString, quantity in Util.OpenBankIterator(true) do
		if private.InGroups(itemString, groups) then
			itemQuantity[itemString] = (itemQuantity[itemString] or 0) + quantity
		end
	end
	for itemString, numHave in pairs(itemQuantity) do
		local numToMove = getNumFunc(itemString, numHave, ...)
		if numToMove > 0 then
			items[itemString] = numToMove
		end
	end
	TempTable.Release(itemQuantity)
end

function Util.PopulateItemsFromBags(items, getNumFunc, ...)
	local itemQuantity = TempTable.Acquire()
	for _, _, _, itemString, quantity in Util.BagIterator(true) do
		itemQuantity[itemString] = (itemQuantity[itemString] or 0) + quantity
	end
	for itemString, numHave in pairs(itemQuantity) do
		local numToMove = getNumFunc(itemString, numHave, ...)
		if numToMove > 0 then
			items[itemString] = numToMove
		end
	end
	TempTable.Release(itemQuantity)
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.InGroups(itemString, groups)
	local groupPath = Group.GetPathByItem(itemString)
	-- TODO: support the base group
	return groupPath and groupPath ~= Group.GetRootPath() and groups[groupPath]
end

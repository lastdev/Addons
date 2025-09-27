local lib, oldMinor = LibStub:NewLibrary("LibBankTabSuitableItems-1.0", 3)
if not lib then return end

--[[
The C_Bank APIs mostly require that you be *at the bank* to use
them. Basically everything in this will return nil if the data wasn't
avaialble. 
--]]

local flags = {
	-- Enum.BagSlotFlags.DisableAutoSort,
	Enum.BagSlotFlags.ClassEquipment,
	Enum.BagSlotFlags.ClassConsumables,
	Enum.BagSlotFlags.ClassProfessionGoods,
	Enum.BagSlotFlags.ClassJunk,
	Enum.BagSlotFlags.ClassQuestItems,
	-- Enum.BagSlotFlags.ExcludeJunkSell,
	Enum.BagSlotFlags.ClassReagents,
	Enum.BagSlotFlags.ExpansionCurrent,
	Enum.BagSlotFlags.ExpansionLegacy
}

local flagNames = tInvert(Enum.BagSlotFlags)

local itemRestrictions = Flags_CreateMask(unpack(flags))
local expansionRestrictions = Flags_CreateMask(
	Enum.BagSlotFlags.ExpansionCurrent,
	Enum.BagSlotFlags.ExpansionLegacy
)

local classMap = {
	[Enum.BagSlotFlags.ClassEquipment] = {
		Enum.ItemClass.Weapon,
		Enum.ItemClass.Armor,
		Enum.ItemClass.Gem, -- TEST
		Enum.ItemClass.Projectile, -- obsolete
		Enum.ItemClass.Quiver, -- obsolete
	},
	[Enum.BagSlotFlags.ClassConsumables] = {
		Enum.ItemClass.Consumable
	},
	[Enum.BagSlotFlags.ClassProfessionGoods] = {
		Enum.ItemClass.Profession, -- TEST
		Enum.ItemClass.Tradegoods,
		Enum.ItemClass.ItemEnhancement, -- TEST
		Enum.ItemClass.Recipe, -- TEST
		Enum.ItemClass.Glyph, -- TEST
	},
	[Enum.BagSlotFlags.ClassJunk] = {
		Enum.ItemClass.Miscellaneous, -- TEST
		Enum.ItemClass.Battlepet, -- TEST
		Enum.ItemClass.WoWToken, -- TEST
		Enum.ItemClass.Key, -- TEST
		Enum.ItemClass.Container, -- TEST
		Enum.ItemClass.CurrencyTokenObsolete, -- TEST
		Enum.ItemClass.PermanentObsolete, -- TEST
	},
	[Enum.BagSlotFlags.ClassQuestItems] = {
		Enum.ItemClass.Questitem,
	},
	[Enum.BagSlotFlags.ClassReagents] = {
		-- Does this also need to test the isCraftingReagent return from GetItemInfo?
		Enum.ItemClass.Reagent, -- TEST
	},
}

--- Does the *specific* item fit the rules for the tab?
-- @param itemLocation ItemLocation
-- @param tabID Enum.BagIndex
-- @param bankType Enum.BankType optional
-- @return Whether the specific item is suitable for a given tab
function lib:IsItemLocationSuitableForTab(itemLocation, tabID, bankType)
	bankType = bankType or self:GetBankTypeForTab(tabID)
	-- print("IsItemLocationSuitableForTab", C_Item.GetItemLink(itemLocation), itemLocation:GetBagAndSlot())
	if not C_Bank.CanViewBank(bankType) then
		return
	end
	if not C_Bank.IsItemAllowedInBankType(bankType, itemLocation) then
		-- print("Not allowed in bank type", bankType)
		return false
	end
	return self:IsItemSuitableForTab(C_Item.GetItemID(itemLocation), tabID, bankType)
end

--- Does the item fit the rules for the tab?
-- @param itemInfo Any valid argument for GetItemInfoInstant
-- @param tabID Enum.BagIndex
-- @param bankType Enum.BankType optional
-- @return Whether the item is appropriate; if nil, the data wasn't fetchable
function lib:IsItemSuitableForTab(itemInfo, tabID, bankType)
	-- See: https://warcraft.wiki.gg/wiki/API_C_Bank.FetchPurchasedBankTabData
	-- print("IsItemSuitableForTab", itemInfo, bankType, tabID)
	local data = self:GetTabData(tabID, bankType)
	if not (data and data.depositFlags) then return end
	local depositFlags = data.depositFlags
	if not FlagsUtil.IsAnySet(depositFlags, itemRestrictions) then
		-- There are no restrictions, so it must be fine
		-- print(true, "no restrictions")
		return true
	end
	-- From here the item needs to affirmatively match the restrictions
	local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = C_Item.GetItemInfoInstant(itemInfo)
	if not itemID then
		-- print(nil, "no item data")
		return
	end

	for flag, itemClasses in pairs(classMap) do
		-- print("Considering item class", flag, flagNames[flag], classID, itemType, itemSubType, FlagsUtil.IsSet(depositFlags, flag), tContains(itemClasses, classID))
		if FlagsUtil.IsSet(depositFlags, flag) then
			if tContains(itemClasses, classID) then
				-- print(true, "item class flag set", flag, classID, itemType)
				return true
			end
			if flag == Enum.BagSlotFlags.ClassReagents and select(17, GetItemInfo(itemInfo)) then
				return true
			end
		end
	end

	if FlagsUtil.IsAnySet(depositFlags, expansionRestrictions) then
		local expansionID = select(15, C_Item.GetItemInfo(itemInfo))
		if FlagsUtil.IsSet(depositFlags, Enum.BagSlotFlags.ExpansionCurrent) then
			-- print(expansionID == LE_EXPANSION_LEVEL_CURRENT, "item current-expansion flag set", expansionID)
			return expansionID == LE_EXPANSION_LEVEL_CURRENT
		end
		-- print(expansionID ~= LE_EXPANSION_LEVEL_CURRENT, "item previous-expansion flag set", expansionID)
		return expansionID ~= LE_EXPANSION_LEVEL_CURRENT
	end
	-- print(false, "complete fallthrough")
	return false
end

do
	local numFlags = setmetatable({}, {__index=function(self, num)
		local count = 0
		for _, flag in ipairs(flags) do
			if FlagsUtil.IsSet(num, flag) then
				count = count + 1
			end
		end
		self[num] = count
		return count
	end,})

	--- Get a consistent key for the restrictions on the tab
	-- @param tabID Enum.BagIndex
	-- @param bankType Enum.BankType optional
	-- @return key|nil
	-- @return numFlagsSet
	function lib:BuildKeyForTab(tabID, bankType)
		local data = self:GetTabData(tabID, bankType)
		if not (data and data.depositFlags) then return end
		local depositFlags = data.depositFlags
		return bit.band(depositFlags, itemRestrictions), numFlags[depositFlags]
	end
end

--- Get the API data for a tab
-- @param tabID Enum.BagIndex
-- @param bankType Enum.BankType optional
-- @return BankTabData|nil
-- @return tabIndex
-- @return numTabs
-- @return Enum.BankType
function lib:GetTabData(tabID, bankType)
	-- This API will only return values when the bank is open
	bankType = bankType or self:GetBankTypeForTab(tabID)
	if not (bankType and C_Bank.CanViewBank(bankType)) then return end
	local data = C_Bank.FetchPurchasedBankTabData(bankType)
	if not (data and #data > 0) then return end

	for i, tab in ipairs(data) do
		if tab.ID == tabID then
			return tab, i, #data, bankType
		end
	end
	-- If we reached here, you either have no purchased tabs of the correct
	-- type, or data wasn't loaded fully somehow
	return nil, nil, #data, bankType
end

do
	local tabIDToBankType = {}
	if Enum.BagIndex.AccountBankTab_1 then
		tabIDToBankType[Enum.BagIndex.AccountBankTab_1] = Enum.BankType.Account
		tabIDToBankType[Enum.BagIndex.AccountBankTab_2] = Enum.BankType.Account
		tabIDToBankType[Enum.BagIndex.AccountBankTab_3] = Enum.BankType.Account
		tabIDToBankType[Enum.BagIndex.AccountBankTab_4] = Enum.BankType.Account
		tabIDToBankType[Enum.BagIndex.AccountBankTab_5] = Enum.BankType.Account
	end
	if Enum.BagIndex.CharacterBankTab_1 then
		tabIDToBankType[Enum.BagIndex.CharacterBankTab_1] = Enum.BankType.Character
		tabIDToBankType[Enum.BagIndex.CharacterBankTab_2] = Enum.BankType.Character
		tabIDToBankType[Enum.BagIndex.CharacterBankTab_3] = Enum.BankType.Character
		tabIDToBankType[Enum.BagIndex.CharacterBankTab_4] = Enum.BankType.Character
		tabIDToBankType[Enum.BagIndex.CharacterBankTab_5] = Enum.BankType.Character
		tabIDToBankType[Enum.BagIndex.CharacterBankTab_6] = Enum.BankType.Character
	end
	--- Work out the bankType from a tabID
	-- @param Enum.BagIndex
	-- @return Enum.BankType|nil
	function lib:GetBankTypeForTab(tabID)
		if not tabIDToBankType[tabID] then
			-- Really, this is future-proofing
			for _, bankType in pairs(Enum.BankTypes) do
				local data = self:GetTabData(tabID, bankType)
				if data then
					tabIDToBankType[tabID] = bankType
					break
				end
			end
		end
		return tabIDToBankType[tabID]
	end
end

-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Conversions = TSM.Init("Service.Conversions") ---@class Service.Conversions
local Conversion = TSM.LibTSMTypes:Include("Item.Conversion")
local MillData = TSM.LibTSMData:Include("Mill")
local ProspectData = TSM.LibTSMData:Include("Prospect")
local TransformData = TSM.LibTSMData:Include("Transform")
local VendorTradeData = TSM.LibTSMData:Include("VendorTrade")
local DisenchantData = TSM.LibTSMData:Include("Disenchant")
local ItemInfo = TSM.LibTSMService:Include("Item.ItemInfo")
local private = {}
local DISENCHANT_CLASS_ID_LOOKUP = {
	[DisenchantData.ITEM_CLASSES.ARMOR] = Enum.ItemClass.Armor,
	[DisenchantData.ITEM_CLASSES.WEAPON] = Enum.ItemClass.Weapon,
	[DisenchantData.ITEM_CLASSES.PROFESSION] = Enum.ItemClass.Profession,
}



-- ============================================================================
-- Module Loading
-- ============================================================================

Conversions:OnModuleLoad(function()
	private.FetchItemInfo(MillData.Get())
	private.FetchItemInfo(ProspectData.Get())
	private.FetchItemInfo(TransformData.Get())
	private.FetchItemInfo(VendorTradeData.Get())
	for itemString in pairs(DisenchantData.Get()) do
		ItemInfo.FetchInfo(itemString)
	end
end)



-- ============================================================================
-- Module Functions
-- ============================================================================

function Conversions.GetDisenchantTargetItemSourceInfo(targetItemString, classId, quality, itemLevel, expansion)
	local amountOfMats, matRate, minAmount, maxAmount, requiredSkill = nil, nil, nil, nil, nil
	local data = Conversion.GetDisenchantData(targetItemString)
	for _, info in ipairs(data.sourceInfo) do
		local sourceClassId = DISENCHANT_CLASS_ID_LOOKUP[info.class]
		assert(sourceClassId)
		if sourceClassId == classId and info.quality == quality and itemLevel >= info.minItemLevel and itemLevel <= info.maxItemLevel and (not expansion or expansion == data.expansion) then
			amountOfMats = info.amountOfMats
			matRate = info.matRate
			minAmount = info.minAmount
			maxAmount = info.maxAmount
			requiredSkill = info.requiredSkill
		end
	end
	return amountOfMats, matRate, minAmount, maxAmount, requiredSkill
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.FetchItemInfo(data)
	for targetItemString, items in pairs(data) do
		ItemInfo.FetchInfo(targetItemString)
		for sourceItemString in pairs(items) do
			ItemInfo.FetchInfo(sourceItemString)
		end
	end
end

local _, Addon = ...
local L = Addon:GetLocale()


local ItemProperties = {}
local itemPropertiesList = nil
local itemproperties = nil
local IS_RETAIL = nil
local IS_CLASSIC = nil
local Interop = Addon.Systems.Interop

--[[ Retrieve our depenedencies ]]
function ItemProperties:GetDependencies()
    return { "info", "savedvariables", "profile", "interop"}
end


function ItemProperties:Startup(register)
    -- Populate the property list
    itemPropertiesList = self:GetPropertyList()

    -- We will do simple checks here because this code executes a lot
    -- So we will minimize function calls that are not necessary
    IS_RETAIL = Addon.Systems.Info.IsRetailEra
    IS_RETAIL_NEXT = Addon.Systems.Info.IsRetailNext
    IS_CLASSIC = Addon.Systems.Info.IsClassicEra
    itemproperties = self
    
    register({
        "GetPropertyDocumentation",
        "GetPropertyList",
        "GetPropertyType",
        "GetPropertyDefault",
        "IsPropertyHidden",
        })
end

--[[ Shutdown our system ]]
function ItemProperties:Shutdown()
end

-- Because Blizzard doesn't make this easy.
local transmog_invtypes = {
    INVTYPE_HEAD = true,
    INVTYPE_SHOULDER = true,
    INVTYPE_BODY = true,
    INVTYPE_CHEST = true,
    INVTYPE_WAIST = true,
    INVTYPE_LEGS = true,
    INVTYPE_FEET = true,
    INVTYPE_WRIST = true,
    INVTYPE_HAND = true,
    INVTYPE_WEAPON = true,
    INVTYPE_SHIELD = true,
    INVTYPE_RANGED = true,
    INVTYPE_CLOAK = true,
    INVTYPE_2HWEAPON = true,
    INVTYPE_TABARD = true,
    INVTYPE_ROBE = true,
    INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true,
    INVTYPE_HOLDABLE = true,
    INVTYPE_THROWN = true,
    INVTYPE_RANGEDRIGHT = true,
}

local function isTransmogEquipment(invtype)
    if not invtype then return false end
    return transmog_invtypes[invtype] or false
end

local function doGetItemProperties(itemObj)


    -- Empty item detection. Have to do this since there's very strange behavior for determining
    -- this with the API for items we don't own.
    if itemObj:IsItemEmpty() then

        return nil
    end

    local location = itemObj:GetItemLocation() or false
    local guid = itemObj:GetItemGUID() or false
    if not guid then

        return nil
    end

    -- If it's bag and slot then the count can be retrieved, if it isn't
    -- then it must be an inventory slot, which means 1.
    local count = 1
    if location and location:HasAnyLocation() then
        count = C_Item.GetStackCount(location) or 1
    end

    -- Create a new item with defaults
    local item = Addon.DeepTableCopyNoMeta(itemPropertiesList)

    -- Item may not be loaded, need to handle this in a non-hacky way.
    item.GUID = guid or false
    item.Link = itemObj:GetItemLink()
    item.Count = count

    -- Get more id and cache GetItemInfo, because we aren't bad.
    local getItemInfo = {Addon:GetItemInfo(item.Link)}

    -- Safeguard to make sure GetItemInfo returned something. If not bail.
    -- This will happen if we get this far with a Keystone, because Keystones aren't items. Go figure.
    if #getItemInfo == 0 then return nil end

    -- Item GUID is required for tooltip to be valid.
    if not item.GUID then return nil end

    -- Populate tooltip and surface args.
    local tooltipdata = nil
    if IS_RETAIL then
        tooltipdata = C_TooltipInfo.GetItemByGUID(item.GUID)

        -- TooltipUtil.SurfaceArgs removed in 11.0
        -- Does not appear necessary in order for data to be
        -- available.
        if not Addon.Systems.Info.IsRetailNext then
            TooltipUtil.SurfaceArgs(tooltipdata)
            for _, line in ipairs(tooltipdata.lines) do
                TooltipUtil.SurfaceArgs(line)
            end
        end
    end

    -- Copy in case they reuse or change the tooltip data between scan and evaluation.
    item.TooltipData = Addon.DeepTableCopy(tooltipdata)

    -- Get the effective item level.
    item.Level = Addon:GetDetailedItemLevelInfo(item.Link)

    -- Rip out properties from GetItemInfo
    item.Id = itemObj:GetItemID()
    item.Name = getItemInfo[1]
    item.Quality = getItemInfo[3]
    item.EquipLoc = getItemInfo[9]          -- This is a non-localized string identifier. Wrap in _G[""] to localize.
    item.EquipLocName = _G[item.EquipLoc] or ""
    item.Type = getItemInfo[6]              -- Note: This is localized, TypeId better to use for rules.
    item.MinLevel = getItemInfo[5]
    item.TypeId = getItemInfo[12]
    item.SubType = getItemInfo[7]           -- Note: This is localized, SubTypeId better to use for rules.
    item.SubTypeId = getItemInfo[13]
    item.BindType = getItemInfo[14]
    item.StackSize = getItemInfo[8]
    item.UnitValue = getItemInfo[11] or 0
    item.TotalValue = item.UnitValue * item.Count
    item.UnitGoldValue = math.floor(item.UnitValue / 10000)
    item.TotalGoldValue = math.floor(item.TotalValue / 10000)
    item.IsCraftingReagent = getItemInfo[17] or false
    item.IsUnsellable = not item.UnitValue or item.UnitValue == 0
    item.ExpansionPackId = getItemInfo[15]  -- May be useful for a rule to vendor previous ex-pac items, but doesn't seem consistently populated

    if IS_RETAIL then item.IsAzeriteItem = (getItemInfo[15] == 7) and C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(item.Id) end
    item.InventoryType = itemObj:GetInventoryType()
    if IS_RETAIL then 
        -- Do we care about conduits anymore? Maybe for selling or destroying old ones.
        if location and location:HasAnyLocation() then
            item.IsConduit = C_Item.IsItemConduit(location) or false
        end
    end

    -- Add Bag and Slot information. Initialize to -1 so rule writers can identify them.
    item.IsBagAndSlot = location and location:IsBagAndSlot()
    if item.IsBagAndSlot then
        item.Bag, item.Slot = location:GetBagAndSlot()
    end

    item.HasUseAbility = Addon:IsUsableItem(item.Id)
    item.IsEquipment = Addon:IsEquippableItem(item.Id)
    if IS_RETAIL then item.IsProfessionEquipment = item.IsEquipment and item.TypeId == 19 end
    item.IsEquipped = location and location:IsEquipmentSlot()
    if IS_RETAIL then item.IsTransmogEquipment = isTransmogEquipment(item.EquipLoc) end
    if IS_RETAIL then item.IsUpgradeable = location and C_ItemUpgrade.CanUpgradeItem(location) end

    -- Get soulbound information
    if location and C_Item.IsBound(location) then
        -- IsBound returns true for both Account Bound and Soulbound
        -- We must check for both types.
        -- First check if it's soulbound. If it is soulbound then it cannot be
        if itemproperties:IsItemAccountBoundInTooltip(tooltipdata) then
            item.IsWarbound = true
            item.IsAccountBound = true
        else
            -- If it is bound but not account bound it must be soulbound.
            item.IsSoulbound = true
        end
    else
        if item.BindType == 2 then
            item.IsBindOnEquip = true
            if IS_RETAIL_NEXT and C_Item.IsBoundToAccountUntilEquip(location) then
                item.IsWarboundUntilEquip = true
                -- For rule simplicity, we will treat WarboundUntilEquip the same as Warbound
                -- Technically it is both warbound and bind on equip.
                item.IsWarbound = true
            end
        elseif item.BindType == 3 then
            item.IsBindOnUse = true
        end
    end

    if IS_RETAIL then
        -- Determine if this item is cosmetic. Blizzard Cosmetic check doesn't count every type of cosmetic
        -- we have seen, so we will use tooltip to ensure it is actually a Cosmetic as the Player sees it.
        if tooltipdata and item.IsEquipment and itemproperties:IsItemCosmeticInTooltip(tooltipdata) then
            item.IsCosmetic = true
        end

        -- This will detect usable items by the player class, for example, armor they can wear, tokens they can use, etc.
        item.IsUsable = C_PlayerInfo.CanUseItem(item.Id)
        item.IsEquippable = item.IsUsable and item.IsEquipment

        -- Transmog identification
        local appearanceId, sourceId = C_TransmogCollection.GetItemInfo(item.Link)
        if (appearanceId and sourceId and appearanceId ~= 0) then
            item.HasAppearance = true
            item.AppearanceId = appearanceId
            item.SourceId = sourceId

            -- Optimization - if the item is Soulbound then nothing else matters.
            -- Soulbound items have their appearances learned immediately.
            -- We don't need to even bother checking appearance collection because if it could
            -- have been collected it would have been, and the item is safe to vendor
            -- or destroy.
            if not item.IsAppearanceCollected and item.IsSoulbound then
                if Addon.IsDebug then
                    item.TransmogInfoSource = "Soulbound"
                end
                item.IsAppearanceCollected = true
            end

            -- If it isn't soulbound, try exact item matching the source. If we have the source, we're done.
            local hasSource = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(item.SourceId)
            if hasSource then
                if Addon.IsDebug then
                    item.TransmogInfoSource = "ItemModifiedAppearance"
                end
                item.IsAppearanceCollected = true
            else
                -- No exact source, so check alternate sources.
                local sources = C_TransmogCollection.GetAppearanceSources(item.AppearanceId)
                if sources then
                    for k, source in pairs(sources) do
                        if source and source.isCollected then
                            if Addon.IsDebug then
                                item.TransmogInfoSource = "GetAppearanceSources"
                            end
                            item.IsAppearanceCollected = true
                            break;
                        end
                    end
                end
            end

            -- If source lookup did not work, fall back on PlayerHasTransmog
            -- This is typical for Cosmetic items which will return nil for the first two checks.
            -- This may also detect some non-usable transmogs as having been collected already.
            if not item.IsAppearanceCollected then
                if Addon.IsDebug then
                    item.TransmogInfoSource = "PlayerHasTransmogByItemInfo"
                end
                item.IsAppearanceCollected = C_TransmogCollection.PlayerHasTransmogByItemInfo(item.Link)
            end
        end

        item.IsUnknownAppearance = item.HasAppearance and not item.IsAppearanceCollected

        -- Get Crafted Quality for Dragonflight professions.
        -- There is also a Reagent Quality but every instance I have found for that it is identical.
        -- We will just use the one for now unless there is need to add the differentiation.
        item.CraftedQuality = C_TradeSkillUI.GetItemCraftedQualityByItemInfo(item.Link)
        if not item.CraftedQuality then item.CraftedQuality = 0 end

        -- Determine if this is a toy.
        -- Toys are typically type 15 (Miscellaneous), but sometimes 0 (Consumable), and the subtype is very inconsistent.
        -- Toybox API could confirm toy status but is sometimes not available, so we cannot use it.
        -- Toybox may be some sort of on-demand loaded component.
        item.IsToy = false
        local isToy = {C_ToyBox.GetToyInfo(item.Id)}
        if tooltipdata and item.TypeId == 15 or item.TypeId == 0 then
            if itemproperties:IsItemToyInTooltip(tooltipdata) then
                item.IsToy = true
            end
        end

        item.IsPet = false
        if item.TypeId == 15 and item.SubTypeId == 2 then
            local petInfo = {C_PetJournal.GetPetInfoByItemID(item.Id)}
            if #petInfo > 0 then
                item.IsPet = true
                item.PetName = petInfo[1] or ""
                item.PetType = petInfo[3] or 0
                item.IsPetTradeable = petInfo[9] or 0
                item.PetSpeciesId = petInfo[13] or 0
                if item.PetSpeciesId > 0 then
                    local petCount, petMax = C_PetJournal.GetNumCollectedInfo(item.PetSpeciesId)
                    item.PetCount = petCount or 0
                    item.PetLimit = petMax or 0
                    item.IsPetCollectable = item.PetCount < item.PetLimit
                end
            end
        end

        -- Determine if this is an already-collected item, which should only be items with a
        -- use action. Note Cosmetics may not show up as having a use ability, even though
        -- they have a use ability.
        item.IsAlreadyKnown = false
        if tooltipdata and item.HasUseAbility then
            if itemproperties:IsItemAlreadyKnownInTooltip(tooltipdata) then
                item.IsAlreadyKnown = true
            end
        end
    end

    if not IS_RETAIL then
        -- Old tooltip import for Classic
        -- Import the tooltip text as item properties for custom rules.
        item.TooltipLeft = itemproperties:ImportTooltipTextLeft(location)
        item.TooltipRight = itemproperties:ImportTooltipTextRight(location)
    end

    return item, count
end

-- Item Property external caller.

-- Existing functionality which uses what we had before
function ItemProperties:GetItemProperties(arg1, arg2)
    -- Item GUID passed in
    if type(arg1) == "string" then
        return self:GetItemPropertiesFromGUID(arg1)
    end

    -- Location directly passed in
    if type(arg1) == "table" then
        return self:GetItemPropertiesFromLocation(arg1)
    end

    -- Bag and Slot passed in
    if type(arg1) == "number" and type(arg2) == "number" then
        return self:GetItemPropertiesFromBagAndSlot(arg1, arg2)
    end


    return nil
end

-- From Bag & Slot - Both bag and slot must be numbers and both passed in.
function ItemProperties:GetItemPropertiesFromBagAndSlot(bag, slot)
    if not bag or not slot then return nil end
    return doGetItemProperties(Item:CreateFromBagAndSlot(bag, slot))
end

-- From GUID - This is the best way to get an item.
function ItemProperties:GetItemPropertiesFromGUID(guid)
    if not guid then return nil end
    return doGetItemProperties(Item:CreateFromItemGUID(guid))
end

-- From Tooltip
function ItemProperties:GetItemPropertiesFromTooltip()
    if IS_RETAIL then
        local tooltipData = GameTooltip:GetTooltipData()
        if not tooltipData then return nil end
        if tooltipData.guid then
            return self:GetItemPropertiesFromGUID(tooltipData.guid)
        end
    else
        -- Classic, we dont have GUID from tooltip, use location instead.
        return self:GetItemPropertiesFromLocation(Addon:GetTooltipItemLocation())
    end
    return nil
end

-- From Location
function ItemProperties:GetItemPropertiesFromLocation(location)
    if not location or not Interop:IsLocationValid(location) then return nil end
    return doGetItemProperties(Item:CreateFromItemLocation(location))
end

-- From Link - Not a great choice, GUID is best.
function ItemProperties:GetItemPropertiesFromItemLink(itemLink)
    if not itemLink then return nil end
    return doGetItemProperties(Item:CreateFromItemLink(itemLink));
end

-- From Equipment Slot
function ItemProperties:GetItemPropertiesFromEquipmentSlot(equip)
    if not equip then return nil end
    return doGetItemProperties(Item:CreateFromEquipmentSlot(equip))
end

-- From Item object directly
function ItemProperties:GetItemPropertiesFromItem(item)

    if not item then return nil end
    return doGetItemProperties(item)
end


Addon.Systems.ItemProperties = ItemProperties

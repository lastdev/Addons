local _, Addon = ...
local L = Addon:GetLocale()


--[[
    Format is the following

    PropertyName = { 
        Default = value, -- Whatever the type is
        Hide = number, -- 0 = always show, 1 = always hide, 2 = show if value is not default
        Parent = string -- nil = no parent, string = name of parent property
        Type = string, -- the type
        Supported = {
            Retail = boolean,
            Classic = boolean,
            RetailNext = boolean,       -- Whenever next version of retail is on PTR or Beta
            ClassicNext = boolean,      -- Whenever next version of classic is on PTR or Beta
        }
    }

    Documentation is separately tracked.

]]

local ITEM_PROPERTIES = {
    -- Core properties
    -- GUID is intentionally defaulted to false. If we dont have it, we dont have item properties.
    GUID                    = { Default=false,  Hide=1,  Category="General",    Parent=nil,                   Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Link                    = { Default="",     Hide=1,  Category="General",    Parent=nil,                   Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Count                   = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Name                    = { Default="",     Hide=0,  Category="General",    Parent=nil,                   Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Id                      = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },

    -- Location properties
    IsBagAndSlot            = { Default=false,  Hide=0,  Category="Location",   Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Bag                     = { Default=-1,     Hide=0,  Category="Location",   Parent="IsBagAndSlot",        Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Slot                    = { Default=-1,     Hide=0,  Category="Location",   Parent="IsBagAndSlot",        Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsEquipped              = { Default=false,  Hide=0,  Category="Location",   Parent="IsEquipment",         Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    EquipLoc                = { Default="",     Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    EquipLocName            = { Default="",     Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },

    -- Base properties
    Level                   = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    MinLevel                = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Quality                 = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    Type                    = { Default="",     Hide=0,  Category="Type",       Parent=nil,                   Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    TypeId                  = { Default=0,      Hide=0,  Category="Type",       Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    SubType                 = { Default="",     Hide=0,  Category="Type",       Parent=nil,                   Type="string",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    SubTypeId               = { Default=0,      Hide=0,  Category="Type",       Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    StackSize               = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    UnitValue               = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsCraftingReagent       = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    HasUseAbility           = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsEquipment             = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    ExpansionPackId         = { Default=0,      Hide=0,  Category="Type",       Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    InventoryType           = { Default=0,      Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsConduit               = { Default=false,  Hide=2,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsAzeriteItem           = { Default=false,  Hide=2,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    CraftedQuality          = { Default=0,      Hide=2,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsUsable                = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsUpgradeable           = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },

    -- Derived base properties - not given directly by Blizzard
    UnitGoldValue           = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    TotalValue              = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    TotalGoldValue          = { Default=0,      Hide=0,  Category="General",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsUnsellable            = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsProfessionEquipment   = { Default=false,  Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsEquippable            = { Default=false,  Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsPet                   = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },

    -- Bind properties
    BindType                = { Default=0,      Hide=0,  Category="Binding",    Parent=nil,                   Type="number",     Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsSoulbound             = { Default=false,  Hide=0,  Category="Binding",    Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsBindOnEquip           = { Default=false,  Hide=0,  Category="Binding",    Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsBindOnUse             = { Default=false,  Hide=0,  Category="Binding",    Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsWarbound              = { Default=false,  Hide=0,  Category="Binding",    Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },
    IsWarboundUntilEquip    = { Default=false,  Hide=0,  Category="Binding",    Parent=nil,                   Type="boolean",    Supported={ Retail=false, Classic=false, RetailNext=true, ClassicNext=false } },

    -- Transmog properties
    IsTransmogEquipment     = { Default=false,  Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsAppearanceCollected   = { Default=false,  Hide=0,  Category="Transmog",   Parent="HasAppearance",       Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    HasAppearance           = { Default=false,  Hide=0,  Category="Transmog",   Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsUnknownAppearance     = { Default=false,  Hide=0,  Category="Transmog",   Parent="HasAppearance",       Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    AppearanceId            = { Default=0,      Hide=0,  Category="Transmog",   Parent="HasAppearance",       Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    SourceId                = { Default=0,      Hide=0,  Category="Transmog",   Parent="HasAppearance",       Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },

    -- Tooltip-derived Properties (excluding IsAccountBound)
    IsCosmetic              = { Default=false,  Hide=0,  Category="Equipment",  Parent="IsEquipment",         Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsAlreadyKnown          = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsToy                   = { Default=false,  Hide=0,  Category="Type",       Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },

    -- Pet properties
    PetName                 = { Default="",     Hide=0,  Category="Pet",        Parent="IsPet",               Type="string",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    PetType                 = { Default=0,      Hide=0,  Category="Pet",        Parent="IsPet",               Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsPetTradeable          = { Default=false,  Hide=0,  Category="Pet",        Parent="IsPet",               Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    PetSpeciesId            = { Default=0,      Hide=0,  Category="Pet",        Parent="IsPet",               Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    PetCount                = { Default=0,      Hide=0,  Category="Pet",        Parent="IsPet",               Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    PetLimit                = { Default=0,      Hide=0,  Category="Pet",        Parent="IsPet",               Type="number",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
    IsPetCollectable        = { Default=false,  Hide=0,  Category="Pet",        Parent="IsPet",               Type="boolean",    Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },

    -- Aliased properties for compat (hidden)
    IsAccountBound          = { Default=false,  Hide=1,  Category="Binding",    Parent=nil,                   Type="boolean",    Supported={ Retail=true, Classic=true, RetailNext=true, ClassicNext=true } },

    -- Deprecated Properties for old Tooltip scanning in classic
    TooltipLeft             = { Default=nil,    Hide=1,  Category="System",     Parent=nil,                   Type="table",     Supported={ Retail=false, Classic=true, RetailNext=false, ClassicNext=true } },
    TooltipRight            = { Default=nil,    Hide=1,  Category="System",     Parent=nil,                   Type="table",     Supported={ Retail=false, Classic=true, RetailNext=false, ClassicNext=true } },

    -- Used for data only
    TooltipData             = { Default=nil,    Hide=1,  Category="System",     Parent=nil,                   Type="table",     Supported={ Retail=true, Classic=false, RetailNext=true, ClassicNext=false } },
}

-- Property info accessors
function Addon.Systems.ItemProperties:IsPropertyDefined(name)

    return not not ITEM_PROPERTIES[name]
end

function Addon.Systems.ItemProperties:GetPropertyType(name)


    return ITEM_PROPERTIES[name].Type
end

function Addon.Systems.ItemProperties:GetPropertyCategory(name)


    return ITEM_PROPERTIES[name].Category
end

function Addon.Systems.ItemProperties:GetPropertyParent(name)


    return ITEM_PROPERTIES[name].Parent
end

function Addon.Systems.ItemProperties:GetPropertyDefault(name)


    return ITEM_PROPERTIES[name].Default
end

function Addon.Systems.ItemProperties:IsPropertyHidden(name)


    return ITEM_PROPERTIES[name].Hide
end

function Addon.Systems.ItemProperties:IsPropertySupported(name)


    return ITEM_PROPERTIES[name].Supported[Addon.Systems.Info.ReleaseName]
end

-- Creates a list of properties that are supported on the current platform.
-- Also sets the table as read-only so don't try modifying.
local propertyList = nil
function Addon.Systems.ItemProperties:GetPropertyList()
    if propertyList then return propertyList end
    propertyList = {}
    local releaseName = Addon.Systems.Info.ReleaseName
    for k, v in pairs(ITEM_PROPERTIES) do
        if v.Supported[releaseName] then
            propertyList[k] = v.Default
        else

        end
    end
    return propertyList
end

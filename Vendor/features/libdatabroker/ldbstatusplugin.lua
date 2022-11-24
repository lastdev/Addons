local AddonName, Addon = ...
local L = Addon:GetLocale()


-- Feature Definition
local LDBStatusPlugin = {
    NAME = "LDBStatusPlugin",
    VERSION = 1,
    DEPENDENCIES = { 
        "LibDataBroker",
    },
}

local ldbstatusplugin = nil

-- Local data for the plugin
local totalCount = 0
local sellValue = 0
local sellCount = 0
local deleteCount = 0
local totalCountStr = ""
local sellCountStr = ""
local sellValueStr = ""
local deleteCountStr = ""
local sellItems = {}
local deleteItems = {}
local function updateStats()
    totalCount, sellValue, sellCount, deleteCount, sellItems, deleteItems = Vendor.GetEvaluationStatus()
    totalCountStr = tostring(totalCount)
    sellCountStr = tostring(sellCount)
    deleteCountStr = tostring(deleteCount)
    sellValueStr = Addon:GetPriceString(sellValue)

    if ldbstatusplugin then
        ldbstatusplugin.text = HIGHLIGHT_FONT_COLOR_CODE .. totalCountStr .. FONT_COLOR_CODE_CLOSE .. "  " .. sellValueStr

    end
end

local DATAOBJECT_NAME = AddonName
local ldb_plugin_definition = {
    type = "data source",
    text = "Updating...",
	label = L.ADDON_NAME,
    icon = "Interface\\Icons\\Achievement_Boss_Zuldazar_TreasureGolem",
    OnClick = function(self, button)

        if button == "RightButton" then
            -- Right click -> Open Profiles
            Vendor.ShowProfiles()
        else
            -- Left click -> Open Rules
            Vendor.ShowRules()
        end
    end,
    OnTooltipShow = function(self)
        -- TODO: Build this a bit more efficiently.

        self:AddLine(L.LDB_BUTTON_TOOLTIP_TITLE, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
        self:AddDoubleLine(L.LDB_BUTTON_TOOLTIP_VALUE, sellValueStr)
        self:AddLine(" ")
        self:AddDoubleLine(L.LDB_BUTTON_TOOLTIP_TOSELL, sellCountStr)
        self:AddLine("    "..table.concat(sellItems, "\n    "))
        self:AddLine(" ")
        self:AddDoubleLine(L.LDB_BUTTON_TOOLTIP_TODESTROY, deleteCountStr)
        self:AddLine("    "..table.concat(deleteItems, "\n    "))
    end,
}

function LDBStatusPlugin:CreateLDBDataObject()
    if ldbstatusplugin then return end

    local ldb = Addon:GetFeature("LibDataBroker")
    if (not ldb or not ldb:IsLDBAvailable()) then

        return
    end

    ldbstatusplugin = ldb:CreateLDBDataObject(DATAOBJECT_NAME, ldb_plugin_definition)

end

function LDBStatusPlugin:GetDataObjectName()
    return DATAOBJECT_NAME
end

function LDBStatusPlugin:Update()

    updateStats()
end

function LDBStatusPlugin:OnInitialize()

    self:CreateLDBDataObject()
    Addon:RegisterCallback(Addon.Events.EVALUATION_STATUS_UPDATED, self, self.Update)

    -- This will set default values for the plugin data.
    updateStats()
end

Addon.Features.LDBStatusPlugin = LDBStatusPlugin
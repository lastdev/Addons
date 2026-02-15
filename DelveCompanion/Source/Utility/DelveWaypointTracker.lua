local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

local BOUNTIFUL_ICON_SEQUENCE = "|A:delves-bountiful:24:24|a"
local TOM_TOM_WAYPOINT_DISTANCE_CLEAR = 10
local MPE_DELVE_REGULAR_ATLAS_NAME = "delves-regular"
local MPE_DELVE_BOUNTIFUL_ATLAS_NAME = "delves-bountiful"
--#endregion

---@class (exact) DelveWaypointTracker
---@field isActive boolean Whether player has an active waypoint to a Delve.
---@field VerifyInput fun(self: DelveWaypointTracker) : boolean
---@field Update fun(data: DelveData)
---@field private SetState fun(self: DelveWaypointTracker, state: boolean)
---@field private Activate fun(data: DelveData)
---@field private Clear fun(data: DelveData)
DelveCompanion_DelveWaypointMixin = {}

--#region TomTom tracking

---@param tomtomWaypoint table
local function ClearTomTomWaypoint(tomtomWaypoint)
    if not DelveCompanion.Variables.tomTomAvailable then
        return
    end

    TomTom:RemoveWaypoint(tomtomWaypoint)
end

---@param delveData DelveData
local function SetTomTomWaypoint(delveData)
    if not DelveCompanion.Variables.tomTomAvailable then
        return
    end

    local mapInfo = C_Map.GetMapInfo(delveData.config.uiMapID)
    local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapInfo.parentMapID, delveData.poiID)

    -- Blizzard removes Nemesis Delves' POI from Map with the season change. They can still be entered but their POIInfo cannot be retrieved from API.
    -- To set a waypoint, coordinates from the Config are used.
    local posX, posY = -1, -1
    if poiInfo then
        posX = poiInfo.position.x
        posY = poiInfo.position.y
    else
        posX = delveData.config.coordinates.x / 100
        posY = delveData.config.coordinates.y / 100
    end

    local callbacks = TomTom:DefaultCallbacks({})
    callbacks.distance[TOM_TOM_WAYPOINT_DISTANCE_CLEAR] = function(...)
        ClearTomTomWaypoint(delveData.tomtom)
    end

    local options = {
        title = delveData.delveName,
        from = Lockit.UI_ADDON_NAME,
        persistent = false,
        callbacks = callbacks
    }

    delveData.tomtom = TomTom:AddWaypoint(
        mapInfo.parentMapID,
        posX, posY,
        options)
end

---@param tomtomWaypoint table?
---@return boolean state -- Whether SuperTrack is active for a Delve
local function CheckTomTomWaypoint(tomtomWaypoint)
    if not DelveCompanion.Variables.tomTomAvailable or not tomtomWaypoint then
        return false
    end

    if TomTom:IsValidWaypoint(tomtomWaypoint) then
        return true
    else
        ClearTomTomWaypoint(tomtomWaypoint)
        return false
    end
end
--#endregion

--#region SuperTrack tracking

---@param poiID number -- Delve POI ID
---@return boolean -- Whether SuperTrack is active for a Delve
local function CheckSuperTrackPin(poiID)
    if C_SuperTrack.IsSuperTrackingAnything() then
        local type, typeID = C_SuperTrack.GetSuperTrackedMapPin()

        if type == Enum.SuperTrackingMapPinType.AreaPOI and typeID == poiID then
            return true
        else
            return false
        end
    else
        return false
    end
end
--#endregion

--#region MapPinEnhanced tracking

-- TODO: replace if MPE provides it via API
local function GetMPEStoredPins()
    return MapPinEnhancedDB.storedPins
end

---@param delveData DelveData
local function CheckMPEWaypoint(delveData)
    local pins = GetMPEStoredPins()

    if pins == nil or #pins == 0 then
        return false
    end

    for _, value in ipairs(pins) do
        ---@type pinData
        local pin = value

        if pin.title == delveData.delveName and (pin.texture == MPE_DELVE_REGULAR_ATLAS_NAME or pin.texture == MPE_DELVE_BOUNTIFUL_ATLAS_NAME) then
            return true
        end
    end

    return false
end

---@param delveData DelveData
local function AddMPEWaypoint(delveData)
    local parentMapID = C_Map.GetMapInfo(delveData.config.uiMapID).parentMapID

    local posX, posY = -1, -1
    if delveData.config.coordinates then
        posX = delveData.config.coordinates.x
        posY = delveData.config.coordinates.y
    else
        local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(parentMapID, delveData.poiID)
        posX = poiInfo.position.x
        posY = poiInfo.position.y
    end

    ---@class pinData From MapPinEnhanced -> pinFactory.lua
    ---@field mapID number
    ---@field x number x coordinate between 0 and 1
    ---@field y number y coordinate between 0 and 1
    ---@field setTracked boolean? set to true to autotrack this pin on creation
    ---@field title string? title of the pin
    ---@field texture string? an optional texture to use for the pin this will override the color
    ---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
    ---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
    ---@field lock boolean? if true, the pin will be not be removed automatically when it has been reached
    ---@field order number? the order of the pin: the lower the number, the higher the pin will be displayed on the tracker -> if not set, the pin will be displayed at the end of the tracker
    local pinData = {
        mapID = parentMapID,
        x = posX,
        y = posY,
        title = delveData.delveName,
        texture = delveData.isBountiful and MPE_DELVE_BOUNTIFUL_ATLAS_NAME or MPE_DELVE_REGULAR_ATLAS_NAME,
        usesAtlas = true,
        setTracked = true
    }

    MapPinEnhanced:AddPin(pinData)
end
--#endregion

--- Set tracker methods depending on the selected [tracking type](lua://WaypointTrackingType).
---@param self DelveWaypointTracker
function DelveCompanion_DelveWaypointMixin:Prepare()
    self.Update = function(data)
        local state = false

        if DelveCompanionAccountData.trackingType == DelveCompanion.Definitions.WaypointTrackingType.tomtom then
            state = CheckTomTomWaypoint(data.tomtom)
            if state == false then
                data.tomtom = nil
            end
        elseif DelveCompanionAccountData.trackingType == DelveCompanion.Definitions.WaypointTrackingType.mpe then
            state = CheckMPEWaypoint(data)
        else
            state = CheckSuperTrackPin(data.poiID)
        end

        self:SetState(state)
    end

    self.Activate = function(data)
        if DelveCompanionAccountData.trackingType == DelveCompanion.Definitions.WaypointTrackingType.tomtom then
            SetTomTomWaypoint(data)
        elseif DelveCompanionAccountData.trackingType == DelveCompanion.Definitions.WaypointTrackingType.mpe then
            AddMPEWaypoint(data)
        else
            C_SuperTrack.SetSuperTrackedMapPin(Enum.SuperTrackingMapPinType.AreaPOI, data.poiID)
        end

        self:SetState(true)
    end

    self.Clear = function(data)
        if DelveCompanionAccountData.trackingType == DelveCompanion.Definitions.WaypointTrackingType.tomtom then
            ClearTomTomWaypoint(data.tomtom)
        elseif DelveCompanionAccountData.trackingType == DelveCompanion.Definitions.WaypointTrackingType.mpe then
            -- TODO: Add a method when new MPE API arrives.
            return
        else
            C_SuperTrack.ClearSuperTrackedMapPin()
        end

        self:SetState(false)
    end
end

---@param self DelveWaypointTracker
---@param state boolean
function DelveCompanion_DelveWaypointMixin:SetState(state)
    self.isActive = state
end

---@param self DelveWaypointTracker
function DelveCompanion_DelveWaypointMixin:VerifyInput()
    return IsShiftKeyDown()
end

---@param self DelveWaypointTracker
---@param delveData DelveData
function DelveCompanion_DelveWaypointMixin:ToggleTracking(delveData)
    if not delveData then
        return
    end

    if self.isActive then
        self.Clear(delveData)
    else
        self.Activate(delveData)
    end
end

---@param self DelveWaypointTracker
---@param owner Frame
---@param anchor TooltipAnchor
---@param delveData DelveData
function DelveCompanion_DelveWaypointMixin:DisplayDelveTooltip(owner, anchor, delveData)
    if not delveData then
        return
    end

    local tooltip = GameTooltip
    tooltip:SetOwner(owner, anchor)
    tooltip:ClearLines()

    local iconsSequence = ""

    if delveData.isBountiful then
        iconsSequence = string.join("", iconsSequence, BOUNTIFUL_ICON_SEQUENCE)
    end

    -- Title + icons
    GameTooltip_AddColoredDoubleLine(tooltip,
        delveData.delveName, iconsSequence,
        _G["NORMAL_FONT_COLOR"], _G["NORMAL_FONT_COLOR"],
        true)
    -- Parent map
    GameTooltip_AddHighlightLine(tooltip, delveData.parentMapName, true)
    -- Active story + completion state
    do
        if delveData.storyVariant ~= nil then
            local completionText = delveData.isStoryCompleted and Lockit.UI_DELVE_STORY_VARIANT_COMPLETED_SEQUENCE or
                Lockit.UI_DELVE_STORY_VARIANT_NOT_COMPLETED_SEQUENCE
            local completionColor = delveData.isStoryCompleted and _G["DIM_GREEN_FONT_COLOR"]
                or _G["WARNING_FONT_COLOR"]
            GameTooltip_AddColoredDoubleLine(tooltip, delveData.storyVariant, completionText,
                _G["NORMAL_FONT_COLOR"], completionColor, true)
        end
    end

    GameTooltip_AddBlankLineToTooltip(tooltip)

    -- Tracking instruction
    do
        if self.isActive then
            GameTooltip_AddHighlightLine(tooltip, Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT, true)

            if DelveCompanionAccountData.trackingType ~= DelveCompanion.Definitions.WaypointTrackingType.mpe then
                GameTooltip_AddInstructionLine(tooltip, Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION, true)
            else
                -- TODO: Remove when new MPE API arrives.
                GameTooltip_AddNormalLine(tooltip, Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE, true)
            end
        else
            GameTooltip_AddInstructionLine(tooltip, Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION, true)
        end
    end

    tooltip:Show()
end

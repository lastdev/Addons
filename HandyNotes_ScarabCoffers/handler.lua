local myname, ns = ...

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon(myname, "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale(myname, true)
ns.HL = HL

local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local DEFAULT_LABEL = "Scarab Coffer"

local icon_cache = {}
local function poi_texture(poi)
    if not icon_cache[poi] then
        local left, right, top, bottom = GetPOITextureCoords(poi)
        icon_cache[poi] = {
            icon = [[Interface\Minimap\POIIcons]],
            tCoordLeft = left,
            tCoordRight = right,
            tCoordTop = top,
            tCoordBottom = bottom,
            r = 1, g = 1, b = 1,
        }
    end
    return icon_cache[poi]
end
local function atlas_texture(atlas, scale)
    if not icon_cache[atlas] then
        atlas = C_Texture.GetAtlasInfo(atlas)
        icon_cache[atlas] = {
            icon = atlas.file,
            tCoordLeft = atlas.leftTexCoord, tCoordRight = atlas.rightTexCoord, tCoordTop = atlas.topTexCoord, tCoordBottom = atlas.bottomTexCoord,
            scale = scale or 1,
        }
    end
    return icon_cache[atlas]
end

local function work_out_texture(point)
    if point.atlas then
        return atlas_texture(point.atlas)
    end
    if point.poi then
        return poi_texture(point.poi)
    end
    if point.npc then
        return atlas_texture("DungeonSkull", 1.5)
    end
    return atlas_texture("mythicplus-chest-silver")
end

local get_point_info = function(point)
    if point then
        return point.label or DEFAULT_LABEL, work_out_texture(point), point.scale
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(ns.points[uiMapID] and ns.points[uiMapID][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        tooltip:AddLine(point.label or DEFAULT_LABEL)
        if point.quest and not IsQuestFlaggedCompleted(point.quest) then
            tooltip:AddLine(NEED, 1, 0, 0)
        end
        if point.note then
            tooltip:AddLine(point.note, nil, nil, nil, true)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, ns.points[uiMapID] and ns.points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
end

local function createWaypoint(button, uiMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapID, x, y, {
            title = get_point_info_by_coord(uiMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function hideNode(button, uiMapID, coord)
    ns.hidden[uiMapID][coord] = true
    HL:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        wipe(info)
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "HandyNotes - " .. myname:gsub("HandyNotes_", "")
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            if TomTom then
                -- Waypoint menu item
                info.text = "Create waypoint"
                info.notCheckable = 1
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            -- Hide menu item
            info.text         = "Hide node"
            info.notCheckable = 1
            info.func         = hideNode
            info.arg1         = currentZone
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            -- Close menu item
            info.text         = "Close"
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end
    local HL_Dropdown = CreateFrame("Frame", myname.."DropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        if button == "RightButton" and not down then
            currentZone = uiMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
end

do
    local currentZone
    -- This is a custom iterator we use to iterate over every node in a given zone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and not ns.hidden[currentZone][state] then
                local label, icon, scale = get_point_info(value)
                scale = (scale or 1) * (icon and icon.scale or 1) * ns.db.icon_scale
                return state, nil, icon, scale, ns.db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        currentZone = uiMapID
        return iter, ns.points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New(myname.."DB", ns.defaults)
    ns.db = self.db.profile
    ns.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB(myname:gsub("HandyNotes_", ""), HLHandler, ns.options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", myname:gsub("HandyNotes_", ""))
end

function HL:LOOT_CLOSED()
    self:Refresh()
end

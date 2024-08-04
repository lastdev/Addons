----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, ns = ...

local addon = LibStub("AceAddon-3.0"):NewAddon(FOLDER_NAME, "AceEvent-3.0")
local AceDB = LibStub("AceDB-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HBD = LibStub('HereBeDragons-2.0')
local L = LibStub("AceLocale-3.0"):GetLocale(FOLDER_NAME)
ns.locale = L

_G.HandyNotes_CovenantSanctum = addon

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted
local constantsicon = ns.constants.icon

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local sanctum_feature   = L["handler_tooltip_sanctum_feature"]
local TNRank            = L["handler_tooltip_TNTIER"]

----------------------------------------------------------------------------------------------------
--------------------------------------------GET NPC NAMES-------------------------------------------
----------------------------------------------------------------------------------------------------

local NPClinkSanctum = CreateFrame("GameTooltip", "NPClinkSanctum", UIParent, "GameTooltipTemplate")
local function GetCreatureNameByID(id)
    if (not id) then return end

	NPClinkSanctum:SetOwner(UIParent, "ANCHOR_NONE")
	NPClinkSanctum:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
    local name      = _G["NPClinkSanctumTextLeft1"]:GetText()
    local sublabel  = _G["NPClinkSanctumTextLeft2"]:GetText()
    return name, sublabel
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(node)
    local icon_key = node.icon

    if (icon_key and constantsicon[icon_key]) then
        return constantsicon[icon_key]
    end
end

local function GetIconScale(icon)
    -- anvil npcs are vendors
    if (icon == "anvil") then
        return ns.db["icon_scale_vendor"]
    end

    return ns.db["icon_scale_"..icon] or ns.db["icon_scale_others"]
end

local function GetIconAlpha(icon)
    -- anvil npcs are vendors
    if (icon == "anvil") then
        return ns.db["icon_alpha_vendor"]
    end

    return ns.db["icon_alpha_"..icon] or ns.db["icon_alpha_others"]
end

local GetNodeInfo = function(node)
    local icon
    if (node) then
        local label = GetCreatureNameByID(node.npc) or node.label or UNKNOWN
        local portal_red = ns.constants.icon["portal_red"]

        if (node.icon == "portal" and node.sanctumtalent) then
            local TALENT = C_Garrison.GetTalentInfo(node.sanctumtalent)
            icon = TALENT["researched"] and SetIcon(node) or portal_red
        else
            icon = SetIcon(node)
        end
        return label, icon, node.icon, node.scale, node.alpha
    end
end

local GetNodeInfoByCoord = function(uMapID, coord)
    return GetNodeInfo(ns.DB.nodes[uMapID] and ns.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, node)

    if (node) then
        if (node.npc) then
            local name, sublabel = GetCreatureNameByID(node.npc)
            if (name) then
                tooltip:AddLine(name)
            end
            if (sublabel) then
                tooltip:AddLine(sublabel,1,1,1)
            end
        end
        if (node.label) then
            tooltip:AddLine(node.label)
        end
        if (node.covenant) and node.sanctumtalent then
            local TALENT = C_Garrison.GetTalentInfo(node.sanctumtalent)
            if (not TALENT["researched"]) then
                tooltip:AddLine(requires.." "..sanctum_feature..":", 1) -- red
                tooltip:AddLine(TALENT["name"], 1, 1, 1) -- white
                tooltip:AddTexture(TALENT["icon"], {margin={right=2}})
                tooltip:AddLine("   • "..format(TNRank, TALENT["tier"]+1), 0.6, 0.6, 0.6) -- grey
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, ns.DB.nodes[uMapID] and ns.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
-------------------------------------------PluginHandler--------------------------------------------
----------------------------------------------------------------------------------------------------

local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    SetTooltipByCoord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
    if (self:GetParent() == WorldMapButton) then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local function hideNode(button, uMapID, coord)
    ns.hidden[uMapID][coord] = true
    addon:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if (TomTom) then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = GetNodeInfoByCoord(uMapID, coord),
            from = L["handler_context_menu_addon_name"],
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function addBlizzardWaypoint(button, uMapID, coord)
    local x, y = HandyNotes:getXY(coord)
    local parentMapID = C_Map.GetMapInfo(uMapID)["parentMapID"]
    if (not C_Map.CanSetUserWaypointOnMap(uMapID)) then
        local wx, wy = HBD:GetWorldCoordinatesFromZone(x, y, uMapID)
        uMapID = parentMapID
        x, y = HBD:GetZoneCoordinatesFromWorld(wx, wy, parentMapID)
    end

    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(uMapID, x, y))
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end

--------------------------------------------CONTEXT MENU--------------------------------------------

do
    local currentMapID = nil
    local currentCoord = nil
    local function generateMenu(button, level)
        if (not level) then return end
        if (level == 1) then

            -- Create the title of the menu
            UIDropDownMenu_AddButton({
                isTitle = true,
                text = L["handler_context_menu_addon_name"],
                notCheckable = true
            }, level)

            -- TomTom waypoint menu item
            if (C_AddOns.IsAddOnLoaded("TomTom")) then
                UIDropDownMenu_AddButton({
                    text = L["handler_context_menu_add_tomtom"],
                    notCheckable = true,
                    func = addTomTomWaypoint,
                    arg1 = currentMapID,
                    arg2 = currentCoord
                }, level)
            end

            -- Blizzard waypoint menu item
            UIDropDownMenu_AddButton({
                text = L["handler_context_menu_add_map_pin"],
                notCheckable = true,
                func = addBlizzardWaypoint,
                arg1 = currentMapID,
                arg2 = currentCoord
            }, level)

            -- Hide menu item
            UIDropDownMenu_AddButton({
                text         = L["handler_context_menu_hide_node"],
                notCheckable = true,
                func         = hideNode,
                arg1         = currentMapID,
                arg2         = currentCoord
            }, level)

            -- Close menu item
            UIDropDownMenu_AddButton({
                text         = CLOSE,
                func         = closeAllDropdowns,
                notCheckable = true
            }, level)

        end
    end

    local HL_Dropdown = CreateFrame("Frame", FOLDER_NAME.."DropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        local TomTom = select(2, C_AddOns.IsAddOnLoaded('TomTom'))
        local dropdown = ns.db.easy_waypoint_dropdown

        if (down or button ~= "RightButton") then return end

        if (button == "RightButton" and not down and not ns.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (IsControlKeyDown() and ns.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (not TomTom or dropdown == 1) then
            addBlizzardWaypoint(button, uMapID, coord)
        elseif (TomTom and dropdown == 2) then
            addTomTomWaypoint(button, uMapID, coord)
        else
            addBlizzardWaypoint(button, uMapID, coord)
            if (TomTom) then addTomTomWaypoint(button, uMapID, coord) end
        end
    end
end

do
    local currentMapID = nil
    local function iter(t, prestate)
        if (not t) then return nil end
        local state, value = next(t, prestate)
        while state do
            if (value and ns:ShouldShow(state, value, currentMapID)) then
                local _, icon, iconname, scale, alpha = GetNodeInfo(value)
                    scale = (scale or 1) * GetIconScale(iconname)
                    alpha = (alpha or 1) * GetIconAlpha(iconname)
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end

    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, ns.DB.nodes[uMapID], nil
    end

    function ns:ShouldShow(coord, node, currentMapID)
        if (not ns.db.force_nodes) then
            if (ns.hidden[currentMapID] and ns.hidden[currentMapID][coord]) then
                return false
            end
            -- this will check if any node is for specific covenant
            if (node.covenant and node.covenant ~= C_Covenants.GetActiveCovenantID()) then
                return false
            end
            if (node.icon == "anvil" and not ns.db.show_vendor) then return false end
            if (node.icon == "flightMaster" and not ns.db.show_others) then return false end
            if (node.icon == "innkeeper" and not ns.db.show_innkeeper) then return false end
            if (node.icon == "portal" and (not ns.db.show_portal or C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
            if (node.icon == "mail" and not ns.db.show_mail) then return false end
            if (node.icon == "reforge" and not ns.db.show_reforge) then return false end
            if (node.icon == "renown" and not ns.db.show_renown) then return false end
            if (node.icon == "stablemaster" and not ns.db.show_stablemaster) then return false end
            if (node.icon == "trainer" and not ns.db.show_others) then return false end
            if (node.icon == "vendor" and not ns.db.show_vendor) then return false end
            if (node.icon == "weaponsmith" and not ns.db.show_weaponsmith) then return false end
        end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function addon:OnInitialize()
    self.db = AceDB:New(FOLDER_NAME.."DB", ns.constants.defaults)

    profile = self.db.profile
    ns.db = profile

    global = self.db.global
    ns.global = global

    ns.hidden = self.db.char.hidden

    if (ns.global.dev) then
        ns.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, ns.config.options)
end

function addon:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:ZONE_CHANGED(...)
    addon:Refresh()

    if (ns.global.dev and ns.db.show_prints) then
        print("Covenant Santcum: refreshed after ZONE_CHANGED")
    end
end

function events:ZONE_CHANGED_INDOORS(...)
    addon:Refresh()

    if (ns.global.dev and ns.db.show_prints) then
        print("Covenant Santcum: refreshed after ZONE_CHANGED_INDOORS")
    end
end

function events:QUEST_FINISHED(...)
    addon:Refresh()

    if (ns.global.dev and ns.db.show_prints) then
        print("Covenant Santcum: refreshed after QUEST_FINISHED")
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end
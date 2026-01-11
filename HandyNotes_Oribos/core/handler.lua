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

_G.HandyNotes_Oribos = addon

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted
local constantsicon = ns.constants.icon

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RetrievingData    = L["handler_tooltip_data"]

----------------------------------------------------------------------------------------------------
--------------------------------------------GET NPC NAMES-------------------------------------------
----------------------------------------------------------------------------------------------------

local NPClinkOribos = CreateFrame("GameTooltip", "NPClinkOribos", UIParent, "GameTooltipTemplate")
local function GetCreatureNameByID(id)
    if (not id) then return end

    NPClinkOribos:SetOwner(UIParent, "ANCHOR_NONE")
    NPClinkOribos:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
    local name      = _G["NPClinkOribosTextLeft1"]:GetText()
    local sublabel  = _G["NPClinkOribosTextLeft2"]:GetText()
    return name, sublabel
end

----------------------------------------------------------------------------------------------------
---------------------------------------------PROFESSIONS--------------------------------------------
----------------------------------------------------------------------------------------------------

function addon:CharacterHasProfession(SkillLineID)
    local prof1, prof2 = GetProfessions()
    local ID1 = prof1 and select(7, GetProfessionInfo(prof1))
    local ID2 = prof2 and select(7, GetProfessionInfo(prof2))

    if (ID1 == SkillLineID or ID2 == SkillLineID) then
        return true
    end
    return false
end

local function HasTwoProfessions()
    local prof1, prof2 = GetProfessions()
    if (prof1 and prof2) then
        return true
    end
    return false
end

----------------------------------------------------------------------------------------------------
---------------------------------------FLIGHT MASTER WAYPOINT---------------------------------------
----------------------------------------------------------------------------------------------------

local fmaster_waypoint = 0
local function CreateFlightMasterWaypoint()
    local dropdown = ns.db.fmaster_waypoint_dropdown

    if (dropdown == 1) then
        -- create Blizzard waypoint
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(1550, 47.02/100, 51.16/100))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        fmaster_waypoint = 1
        addon:debugmsg("Create Blizzard")
    elseif (C_AddOns.IsAddOnLoaded("TomTom") and dropdown == 2) then
        -- create TomTom waypoint
        ns.uid = TomTom:AddWaypoint(1671, 61.91/100, 68.78/100, {title = GetCreatureNameByID(162666)})
        fmaster_waypoint = 1
        addon:debugmsg("Create TomTom")
    elseif (dropdown == 3) then
        -- create both waypoints
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(1550, 47.02/100, 51.16/100))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        if (C_AddOns.IsAddOnLoaded("TomTom")) then
            ns.uid = TomTom:AddWaypoint(1671, 61.91/100, 68.78/100, {title = GetCreatureNameByID(162666)})
        end
        fmaster_waypoint = 1
        addon:debugmsg("Create Both")
    end
end

local function RemoveFlightMasterWaypoint()
    local dropdown = ns.db.fmaster_waypoint_dropdown

    if (fmaster_waypoint == 1) then
        if (dropdown == 1) then
            -- remove Blizzard waypoint
            C_Map.ClearUserWaypoint()
            fmaster_waypoint = 0
            addon:debugmsg("Remove Blizzard")
        elseif (C_AddOns.IsAddOnLoaded("TomTom") and dropdown == 2) then
            -- remove TomTom waypoint
            TomTom:RemoveWaypoint(ns.uid)
            fmaster_waypoint = 0
            addon:debugmsg("Remove TomTom")
        elseif (dropdown == 3) then
            -- remove both waypoints
            C_Map.ClearUserWaypoint()
            if (C_AddOns.IsAddOnLoaded("TomTom")) then
                TomTom:RemoveWaypoint(ns.uid)
            end
            fmaster_waypoint = 0
            addon:debugmsg("Remove Both")
        end
    end
end

----------------------------------------------------------------------------------------------------
----------------------------------------------PREPARE-----------------------------------------------
----------------------------------------------------------------------------------------------------

-- workaround to prepare the multilabels with and without notes
-- because the game displays the first line in 14px and
-- the following lines in 13px with a normal for loop.
local function Prepare(label, note)
    local t = {}
    local NOTE

    for i, name in ipairs(label) do

        -- set spell name as label
        if (type(name) == "number") then
            name = C_Spell.GetSpellInfo(name).name
        end

        -- add additional notes
        if (note and note[i]) then
            NOTE = " ("..note[i]..")"
        else
            NOTE = ''
        end

        -- store everything together
        t[i] = name..NOTE
    end

    return table.concat(t, "\n")
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(node)
    local icon_key = node.icon

    if (node.picon) then
        if (ns.db.picons_vendor and (node.icon == "vendor" or node.icon == "anvil")) then
            icon_key = ns.db.use_old_picons and node.picon.."_old" or node.picon
        end

        if (ns.db.picons_trainer and node.icon == "trainer") then
            icon_key = ns.db.use_old_picons and node.picon.."_old" or node.picon
        end
    end

    if (icon_key and constantsicon[icon_key]) then
        return constantsicon[icon_key]
    end
end

local function GetIconScale(icon, picon)
    -- makes the picon smaller
    if (picon ~= nil and ns.db.picons_vendor and (icon == "vendor" or icon == "anvil")) then return ns.db["icon_scale_vendor"] * 0.75 end
    if (picon ~= nil and ns.db.picons_trainer and icon == "trainer") then return ns.db["icon_scale_trainer"] * 0.75 end
    -- anvil npcs are vendors
    if (icon == "anvil") then
        return ns.db["icon_scale_vendor"]
    -- combine the four zone gateway icons
    elseif (icon == "kyrian" or icon == "necrolord" or icon == "nightfae" or icon == "venthyr") then
        return  ns.db["icon_scale_zonegateway"]
    end

    return ns.db["icon_scale_"..icon]
end

local function GetIconAlpha(icon)
    -- anvil npcs are vendors
    if (icon == "anvil") then
        return ns.db["icon_alpha_vendor"]
    -- combine the four zone gateway icons
    elseif (icon == "kyrian" or icon == "necrolord" or icon == "nightfae" or icon == "venthyr") then
        return  ns.db["icon_alpha_zonegateway"]
    end

    return ns.db["icon_alpha_"..icon]
end

local GetNodeInfo = function(node)
    local icon
    if (node) then
        local label = GetCreatureNameByID(node.npc) or node.label or node.multilabel and Prepare(node.multilabel) or UNKNOWN
        if (node.icon == "portal" and node.quest and not IsQuestCompleted(node.quest)) then
            icon = ns.constants.icon["portal_red"]
        else
            icon = SetIcon(node)
        end
        return label, icon, node.icon, node.picon, node.scale, node.alpha -- icon returns the path
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
        if (node.note) then
            tooltip:AddLine("("..node.note..")")
        end
        if (node.multilabel) then
            tooltip:AddLine(Prepare(node.multilabel, node.multinote))
        end
        if (node.quest and not IsQuestCompleted(node.quest)) then
            if (C_QuestLog.GetTitleForQuestID(node.quest) ~= nil) then
                tooltip:AddLine(RequiresQuest..": ["..C_QuestLog.GetTitleForQuestID(node.quest).."] (ID: "..node.quest..")",1,0,0)
            else
                tooltip:AddLine(RetrievingData,1,0,1) -- pink
                C_Timer.After(1, function() addon:Refresh() end) -- Refresh
                -- print("refreshed")
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
    if (C_AddOns.IsAddOnLoaded("TomTom")) then
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
                local _, icon, iconname, piconname, scale, alpha = GetNodeInfo(value)
                    scale = (scale or 1) * GetIconScale(iconname, piconname)
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
            -- this will check if any node is for a specific class
            if (node.class and node.class ~= select(2, UnitClass("player"))) then
                return false
            end
            -- this will check if any node is for a specific faction
            if (node.faction and node.faction ~= select(1, UnitFactionGroup("player"))) then
                return false
            end
            -- this will check if any node is for a specific covenant
            if (node.covenant and node.covenant ~= C_Covenants.GetActiveCovenantID()) then
                return false
            end
            -- this will check if the node is for a specific profession
            if (node.profession and (not addon:CharacterHasProfession(node.profession) and HasTwoProfessions()) and ns.db.show_onlymytrainers and not node.auctioneer) then
                return false
            end
            if (node.icon == "auctioneer" and (not addon:CharacterHasProfession(node.profession) or not ns.db.show_auctioneer)) then return false end
            if (node.icon == "banker" and not ns.db.show_banker) then return false end
            if (node.icon == "barber" and not ns.db.show_barber) then return false end
            if (node.icon == "greatvault" and not ns.db.show_greatvault) then return false end
            if (node.icon == "guildvault" and not ns.db.show_guildvault) then return false end
            if (node.icon == "innkeeper" and not ns.db.show_innkeeper) then return false end
            if (node.icon == "mail" and not ns.db.show_mail) then return false end
            if (node.icon == "portal" and (not ns.db.show_portal or C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
            if (node.icon == "tpplatform" and (not ns.db.show_tpplatform or C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
            if (node.icon == "reforge" and not ns.db.show_reforge) then return false end
            if (node.icon == "stablemaster" and not ns.db.show_stablemaster) then return false end
            if (node.icon == "trainer" and not ns.db.show_trainer) then return false end
            if (node.icon == "portaltrainer" and not ns.db.show_portaltrainer) then return false end
            if (node.icon == "transmogrifier" and not ns.db.show_transmogrifier) then return false end
            if ((node.icon == "vendor" or node.icon == "anvil") and not ns.db.show_vendor) then return false end
            if ((node.icon == "kyrian" or node.icon == "necrolord" or node.icon == "nightfae" or node.icon == "venthyr") and not ns.db.show_zonegateway) then return false end
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
function events:PLAYER_ENTERING_WORLD(...)
    -- MapID is 1550 when you use the Portal to Korthia
    if (C_Map.GetBestMapForUnit("player") == 1550) then
        RemoveFlightMasterWaypoint()
    end
end

function events:ZONE_CHANGED(...)
    addon:Refresh()

    if (C_Map.GetBestMapForUnit("player") == nil) then
        -- occurs during the Shadowlands introduction quest chain in ICC.
        addon:debugmsg("MapID is nil")
        return
    end

    addon:debugmsg("refreshed after ZONE_CHANGED")
    addon:debugmsg("MapID: "..C_Map.GetBestMapForUnit("player"))

    if (C_Map.GetBestMapForUnit("player") == 1671) then
        RemoveFlightMasterWaypoint()
    end
end

function events:ZONE_CHANGED_INDOORS(...)
    addon:Refresh()

    addon:debugmsg("refreshed after ZONE_CHANGED_INDOORS")

    -- Set automatically a waypoint (Blizzard, TomTom or both) to the flightmaster.
    if (ns.db.fmaster_waypoint and C_Map.GetBestMapForUnit("player") == 1671) then
        CreateFlightMasterWaypoint()
    elseif (C_Map.GetBestMapForUnit("player") == 1670) then
        RemoveFlightMasterWaypoint()
    end
end

function events:QUEST_FINISHED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after QUEST_FINISHED")
end

function events:SKILL_LINES_CHANGED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after SKILL_LINES_CHANGED")
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end
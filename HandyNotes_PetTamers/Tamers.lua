---------------------------------------------------------
-- Addon declaration
HandyNotes_PetTamers = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_PetTamers", "AceEvent-3.0")
local HPT = HandyNotes_PetTamers
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_PetTamers", true)

local debugf = tekDebug and tekDebug:GetFrame("PetTamers")
local function Debug(...) if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end end

---------------------------------------------------------
-- Our db upvalue and db defaults
local db
local defaults = {
    profile = {
        icon_scale = 1.5,
        icon_alpha = 1.0,
        show_beaten = true,
    },
}

---------------------------------------------------------
-- Localize some globals
local next = next
local GameTooltip = GameTooltip
local WorldMapTooltip = WorldMapTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo

---------------------------------------------------------
-- Constants

local points = {
    -- [""] = { [] = {, }, },
    -- Kalimdor (6602)
    ["Durotar"] = { [44002880] = {6602, 1}, }, -- Zunta
    ["Barrens"] = { [58605300] = {6602, 2}, }, -- Dagra
    ["Ashenvale"] = { [20202960] = {6602, 3}, }, -- Analynn
    ["StonetalonMountains"] = { [59607160] = {6602, 4}, }, -- Zonya
    ["Desolace"] = { [57204580] = {6602, 5}, }, -- Merda
    ["Feralas"] = { [59604960] = {6602, 6}, }, -- Traitor Gluk
    ["Moonglade"] = { [46006060] = {6602, 7}, }, -- Elena Flutterfly
    ["SouthernBarrens"] = { [39607920] = {6602, 8}, }, -- Cassandra Kaboom
    ["Dustwallow"] = { [53807480] = {6602, 9}, }, -- Grazzle
    ["Felwood"] = { [40005660] = {6602, 10}, }, -- Zoltan
    ["ThousandNeedles"] = { [31803280] = {6602, 11}, }, -- Kela Grimtotem
    ["Winterspring"] = { [65606460] = {6602, 12}, }, -- Stone Cold Trixxy
    -- Eastern Kingdoms (6603)
    ["Elwynn"] = { [41608360] = {6603, 1}, }, -- Julia Stevens
    ["Westfall"] = { [60801860] = {6603, 2}, }, -- Old MacDonald
    ["Redridge"] = { [33205260] = {6603, 3}, }, -- Lindsay
    ["Duskwood"] = { [20204460] = {6603, 4}, }, -- Eric Davidson
    ["StranglethornJungle"] = { [46004060] = {6603, 5}, }, -- Steven Lisbane
    ["TheCapeOfStranglethorn"] = { [51207360] = {6603, 6}, }, -- Bill Buckler
    ["Hinterlands"] = { [62805460] = {6603, 7}, }, -- David Kosse
    ["EasternPlaguelands"] = { [67005240] = {6603, 8}, }, -- Deiza Plaguehorn
    ["SearingGorge"] = { [35602780] = {6603, 9}, }, -- Kortas Darkhammer
    ["BurningSteppes"] = { [25604760] = {6603, 10}, }, -- Durin Darkhammer
    ["SwampOfSorrows"] = { [76604160] = {6603, 11}, }, -- Everessa
    ["DeadwindPass"] = { [40207640] = {6603, 12}, }, -- Lydia Accoste
    -- Outland (6604)
    ["Hellfire"] = { [64204920] = {6604, 1}, }, -- Nicki
    ["Zangarmarsh"] = { [17205060] = {6604, 2}, }, -- Ras'an
    ["Nagrand"] = { [61004940] = {6604, 3}, }, -- Narrok
    ["ShattrathCity"] = { [59007000] = {6604, 4}, }, -- Morulu
    ["ShadowmoonValley"] = { [31004140] = {6604, 5}, }, -- Antari
    -- Northrend (6605)
    ["HowlingFjord"] = { [28603380] = {6605, 1}, }, -- Beegle
    ["CrystalsongForest"] = { [50205900] = {6605, 2}, }, -- Jacob
    ["Dragonblight"] = { [59007700] = {6605, 3}, }, -- Okrut
    ["ZulDrak"] = { [13206680] = {6605, 4}, }, -- Gutretch
    ["IcecrownGlacier"] = { [77401960] = {6605, 5}, }, -- Payne
    -- Pandaria (6606)
    ["TheJadeForest"] = {
        [48005400] = {6606, 1}, -- Hyuna
        [28806300] = {7936, "Whispering Pandaren Spirit"},
    },
    ["ValleyoftheFourWinds"] = { [46004360] = {6606, 2}, }, -- Nishi
    ["Krasarang"] = { [62204580] = {6606, 3}, }, -- Mo'ruk
    ["KunLaiSummit"] = {
        [35807360] = {6606, 4}, -- Yon
        [64809360] = {7936, "Thundering Pandaren Spirit"},
    },
    ["TownlongWastes"] = {
        [36205220] = {6606, 5}, -- Zusshi
        [57004220] = {7936, "Burning Pandaren Spirit"},
    },
    ["DreadWastes"] = {
        [55003760] = {6606, 6}, -- Shu
        [61208760] = {7936, "Flowing Pandaren Spirit"},
    },
    ["ValeofEternalBlossoms"] = { [67604080] = {6606, 7}, }, -- Aki
    -- Cataclysm (7525)
    ["Hyjal"] = { [61203260] = {7525, 1}, }, -- Brok
    ["Deepholm"] = { [49805700] = {7525, 2}, }, -- Bordin
    ["TwilightHighlands"] = { [56605680] = {7525, 3}, }, -- Goz
    ["Uldum"] = { [56604180] = {7525, 4}, }, -- Obalis
}

local icon = {
    icon = select(10, GetAchievementInfo(6620)), -- 6601 is the actual collecting achievement
    tCoordLeft = 0.1,
    tCoordRight = 0.9,
    tCoordTop = 0.1,
    tCoordBottom = 0.9,
}

local get_point_info_by_coord = function(mapFile, coord)
    mapFile = string.gsub(mapFile, "_terrain%d+$", "")
    local point = points[mapFile] and points[mapFile][coord]
    if point then
        local name, beaten, _
        if type(point[2]) == "string" then
            name = point[2]
            beaten = _, _, _, GetAchievementInfo(point[1])
        else
            name, _, beaten = GetAchievementCriteriaInfo(point[1], point[2])
        end
        return name, beaten
    end
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HPTHandler = {}
local info = {}

function HPTHandler:OnEnter(mapFile, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    local label = get_point_info_by_coord(mapFile, coord)
    if label then
        tooltip:SetText(label)
        tooltip:Show()
    end
end

local function createWaypoint(button, mapFile, coord)
    local c, z = HandyNotes:GetCZ(mapFile)
    local x, y = HandyNotes:getXY(coord)
    local label = get_point_info_by_coord(mapFile, coord)
    if TomTom then
        local persistent, minimap, world
        if temporary then
            persistent = true
            minimap = false
            world = false
        end
        TomTom:AddZWaypoint(c, z, x*100, y*100, label, persistent, minimap, world)
    elseif Cartographer_Waypoints then
        Cartographer_Waypoints:AddWaypoint(NotePoint:new(HandyNotes:GetCZToZone(c, z), x, y, label))
    end
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        for k in pairs(info) do info[k] = nil end
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "HandyNotes - PetTamers"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            if TomTom or Cartographer_Waypoints then
                -- Waypoint menu item
                info.disabled     = nil
                info.isTitle      = nil
                info.notCheckable = nil
                info.text = "Create waypoint"
                info.icon = nil
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level);
            end

            -- Close menu item
            info.text         = "Close"
            info.icon         = nil
            info.func         = function() CloseDropDownMenus() end
            info.arg1         = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level);
        end
    end
    local HPT_Dropdown = CreateFrame("Frame", "HandyNotes_PetTamersDropdownMenu")
    HPT_Dropdown.displayMode = "MENU"
    HPT_Dropdown.initialize = generateMenu

    function HPTHandler:OnClick(button, down, mapFile, coord)
        if button == "RightButton" and not down then
            currentZone = string.gsub(mapFile, "_terrain%d+$", "")
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HPT_Dropdown, self, 0, 0)
        end
    end
end

function HPTHandler:OnLeave(mapFile, coord)
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentLevel, currentZone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value then
                local name, beaten = get_point_info_by_coord(currentZone, state)
                if (db.show_beaten or not beaten) then
                    return state, nil, icon, db.icon_scale, db.icon_alpha
                end
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HPTHandler:GetNodes(mapFile, minimap, level)
        mapFile = string.gsub(mapFile, "_terrain%d+$", "")
        currentZone = mapFile
        currentLevel = level
        return iter, points[mapFile], nil
    end
end

---------------------------------------------------------
-- Options table
local options = {
    type = "group",
    name = "PetTamers",
    desc = "PetTamers",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        HPT:SendMessage("HandyNotes_NotifyUpdate", "PetTamers")
    end,
    args = {
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 0,
        },
        icon_scale = {
            type = "range",
            name = "Icon Scale",
            desc = "The scale of the icons",
            min = 0.25, max = 2, step = 0.01,
            order = 20,
        },
        icon_alpha = {
            type = "range",
            name = "Icon Alpha",
            desc = "The alpha transparency of the icons",
            min = 0, max = 1, step = 0.01,
            order = 30,
        },
        show_beaten = {
            type = "toggle",
            name = "Show Beaten",
            desc = "Show tamers after you've beaten them",
            order = 40,
        },
    },
}


---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HPT:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_PetTamersDB", defaults)
    db = self.db.profile
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("PetTamers", HPTHandler, options)
end

function HPT:OnEnable()
    -- self:RegisterEvent("CRITERIA_UPDATE", "Refresh")
    -- self:RegisterEvent("CRITERIA_EARNED", "Refresh")
    -- self:RegisterEvent("CRITERIA_COMPLETE", "Refresh")
    -- self:RegisterEvent("ACHIEVEMENT_EARNED", "Refresh")
end

function HPT:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "PetTamers")
end

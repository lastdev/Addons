---------------------------------------------------------
-- Addon declaration
HandyNotes_DragonGlyphs = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_DragonGlyphs","AceEvent-3.0")
local HL = HandyNotes_DragonGlyphs
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_DragonGlyphs", true)

local debugf = tekDebug and tekDebug:GetFrame("DragonGlyphs")
local function Debug(...) if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end end

---------------------------------------------------------
-- Our db upvalue and db defaults
local db
local defaults = {
    profile = {
        completed = false,
        icon_scale = 1.5,
        icon_alpha = 0.8,
    },
}

---------------------------------------------------------
-- Localize some globals
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo

---------------------------------------------------------
-- Constants

local get_icon
do
    local icon, icon_completed

    get_icon = function(achievement)
        icon = "Interface/AddOns/HandyNotes_DragonGlyphs/icon.blp"
        icon_completed = "Interface/AddOns/HandyNotes_DragonGlyphs/icon_completed.blp"
        return icon
    end
end

local points = {
    -- [mapfile] = { [coord] = { [achievement_id], [criteria_index] } }
    [2022] = { -- The Waking Shore
        [57735498] = {15991}, -- Dragon Glyphs: Crumbling Life Archway -- complete
        [69224632] = {16051}, -- Dragon Glyphs: Dragonheart Outpost -- complete
        [52601748] = {15990}, -- Dragon Glyphs: Life-Binder Observatory Tower -- complete
        [40967187] = {15987}, -- Dragon Glyphs: Obsidian Bulwark -- complete
        [21885148] = {16053}, -- Dragon Glyphs: Obsidian Throne -- complete
        [54467421] = {15988}, -- Dragon Glyphs: Ruby Life Pools -- complete
        [73252054] = {16052}, -- Dragon Glyphs: Scalecracker Peak -- complete
        [75285701] = {15985}, -- Dragon Glyphs: Skytop Observatory -- complete
        [46405214] = {15989}, -- Dragon Glyphs: The Overflowing Spring -- complete
        [74883739] = {15986}, -- Dragon Glyphs: Wingrest Embassy -- complete
        [74345758] = {16668}, -- Dragon Glyphs: Life-Binder Observatory Rostrum -- complete
        [58127863] = {16669}, -- Dragon Glyphs: Flashfrost Enclave -- complete
        [48828664] = {16670}, -- Dragon Glyphs: Rubyscale Outpost -- complete
    },

    [2023] = { -- Ohn'ahran Plains
        [84357767] = {16061}, -- Dragon Glyphs: Dragonsprings Summit -- complete
        [30146128] = {16056}, -- Dragon Glyphs: Emerald Gardens -- complete
        [47277234] = {16059}, -- Dragon Glyphs: Mirror of the Sky -- complete
        [30673614] = {16055}, -- Dragon Glyphs: Nokhudon Hold -- complete
        [57973111] = {16054}, -- Dragon Glyphs: Ohn'ahra's Roost -- complete
        [57118002] = {16060}, -- Dragon Glyphs: Ohn'iri Springs -- complete
        [86463943] = {16062}, -- Dragon Glyphs: Rusza'thar Reach -- complete
        [44616475] = {16058}, -- Dragon Glyphs: Szar Skeleth -- complete
        [29537527] = {16057}, -- Dragon Glyphs: The Eternal Kurgans -- complete
        [61536430] = {16063}, -- Dragon Glyphs: Windsong Rise -- complete
        [80011306] = {16670}, -- Dragon Glyphs: Rubyscale Outpost (technically in Waking Shores) -- complete
        [78362123] = {16671}, -- Dragon Glyphs: Mirewood Fen -- complete
        [70128669] = {16672}, -- Dragon Glyphs: Forkriver Crossing -- complete
    },

    [2024] = { -- The Azure Span
        --[40366646] = {16065}, -- Dragon Glyphs: Azure Archive -- complete (old location)
        [39236297] = {16065}, -- Dragon Glyphs: Azure Archive -- complete (old location)
        [10393587] = {16068}, -- Dragon Glyphs: Brackenhide Hollow -- complete
        [45902577] = {16064}, -- Dragon Glyphs: Cobalt Assembly -- complete
        --[22133670] = {16069}, -- Dragon Glyphs: Drake Eye's Pond -- complete (changed to Creektooth Den)
        [26733168] = {16069}, -- Dragon Glyphs: Creektooth Den -- complete
        [60637003] = {16070}, -- Dragon Glyphs: Imbu -- complete
        [67652913] = {16072}, -- Dragon Glyphs: Kalthraz Fortress -- complete
        [70584627] = {16067}, -- Dragon Glyphs: Lost Ruins -- complete
        [68646039] = {16066}, -- Dragon Glyphs: Ruins of Karnthar -- complete
        --[77603082] = {16073}, -- Dragon Glyphs: Vakthros Summit -- complete (changed to Vakthros Range)
        [72553970] = {16073}, -- Dragon Glyphs: Vakthros Range -- complete
        [53004908] = {16071}, -- Dragon Glyphs: Zelthrak Outpost -- complete
        [36582796] = {16672}, -- Dragon Glyphs: Forkriver Crossing (technically in Ohn'ahran Plains) -- complete
        [56811608] = {16673}, -- Dragon Glyphs: Fallen Course -- complete
    },

    [2025] = { -- Thaldraszus
        [49894035] = {16102}, -- Dragon Glyphs: Algeth'era -- complete
        [35588554] = {16100}, -- Dragon Glyphs: South Hold Gate -- complete
        [46137398] = {16099}, -- Dragon Glyphs: Stormshroud Peak -- complete
        [62414046] = {16104}, -- Dragon Glyphs: Algeth'ar Academy -- complete
        [66028233] = {16098}, -- Dragon Glyphs: Temporal Conflux -- complete
        [72956919] = {16107}, -- Dragon Glyphs: Thaldrazsus Apex -- complete
        [61575662] = {16103}, -- Dragon Glyphs: Tyrhold -- complete
        [41345822] = {16101}, -- Dragon Glyphs: Valdrakken -- complete
        [72425149] = {16106}, -- Dragon Glyphs: Vault of the Incarnates -- complete
        [67101177] = {16105}, -- Dragon Glyphs: Veiled Ossuary -- complete
        [52716742] = {16666}, -- Dragon Glyphs: Gelikyr Overlook -- complete
        [55707221] = {16667}, -- Dragon Glyphs: Passage of Time -- complete
        [37639333] = {16673}, -- Dragon Glyphs: Fallen Course (technically in The Azure Span) -- complete
    },

    [2112] = { -- Valdrakken
        [59253803] = {16101}, -- Dragon Glyphs: Valdrakken -- complete
    },

    --10.0.7
    [2151] = {
        [20569140] = {17399}, -- Dragon Glyphs: Talon's Watch -- complete
        [18381320] = {17398}, -- Dragon Glyphs: Warlord's Perch (probably supposed to be Winglord's Perch?) -- complete (used to be Northwind Point)
        [37693069] = {17405}, -- Dragon Glyphs: Caldera of the Menders -- complete
        [48516897] = {17403}, -- Dragon Glyphs: The Frosted Spine -- complete (used to be War Creche)
        [79553264] = {17401}, -- Dragon Glyphs: Dragonskull Island -- complete
        [62543238] = {17400}, -- Dragon Glyphs: Froststone Peak -- complete (used to be Fragstone Vault)
        [59056508] = {17404}, -- Dragon Glyphs: Talonlord's Perch -- complete
        [77295510] = {17402}, -- Dragon Glyphs: Stormsunder Mountain -- complete

    },

    --10.1.0
    [2133] = {
        [71974840] = {17515}, -- Dragon Glyphs: The Throughway
        [55352784] = {17514}, -- Dragon Glyphs: Slitherdrake Roost
        [47413701] = {17516}, -- Dragon Glyphs: Acidbite Ravine
        [54715458] = {17512}, -- Dragon Glyphs: Loamm
        [41658036] = {17510}, -- Dragon Glyphs: Glimmerogg
        [30454531] = {17513}, -- Dragon Glyphs: Zaqali Caldera
        [48050436] = {17517}, -- Dragon Glyphs: Aberrus Approach
        [62717030] = {17511}, -- Dragon Glyphs: Nal Ks'kol

    },

    --10.2.0
    [2200] = {
        [49956427] = {19301}, -- Dragon Glyphs: Amirdrassil
        [31858062] = {19302}, -- Dragon Glyphs: Whorlwing Basin
        [33794558] = {19298}, -- Dragon Glyphs: Smoldering Copse
        [61677541] = {19303}, -- Dragon Glyphs: Wakeful Vista
        [45494577] = {19300}, -- Dragon Glyphs: Dreamsurge Basin
        [29862119] = {19299}, -- Dragon Glyphs: Cinder Summit
        [21202674] = {19297}, -- Dragon Glyphs: Smoldering Ascent
        [60363013] = {19296}, -- Dragon Glyphs: Eye of Ysera
    },
}

local info_from_coord = function(uiMapId, coord)
    local point = points[uiMapId] and points[uiMapId][coord]
    if point then
        local _, achievement = GetAchievementInfo(point[1])
        return achievement
    end
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapId, coord)
    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    local achievement = info_from_coord(uiMapId, coord)
    if achievement then
        tooltip:SetText(("%s"):format(achievement))
        tooltip:Show()
    end
end

local function createWaypoint(button, uiMapId, coord)
    local x, y = HandyNotes:getXY(coord)
    local achievement = info_from_coord(uiMapId, coord)
    if TomTom then
        local persistent, minimap, world
        if temporary then
            persistent = true
            minimap = false
            world = false
        end
        TomTom:AddWaypoint(uiMapId, x, y, {
            title=achievement,
            persistent=persistent,
            minimap=minimap,
            world=world
        })
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
            info.text         = "HandyNotes - DragonGlyphs"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            if TomTom then
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
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_DragonGlyphsDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapId, coord)
        if button == "RightButton" and not down then
            currentZone = uiMapId
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapId, coord)
    GameTooltip:Hide()
end

do
    local function should_show(achievement)
        if db.completed then return true end

        if select(4,GetAchievementInfo(achievement)) == true then
            return
        end

        -- this implies that we didn't load the data from the server completely... so default to showing it,
        -- and later updates will hopefully fix it
        return true
    end
    -- This is a custom iterator we use to iterate over every node in a given zone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and should_show(value[1], value[2]) then
                local icon = get_icon(value[1])
                Debug("iter step", state, icon, db.icon_scale, db.icon_alpha)
                return state, nil, icon, db.icon_scale, db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapId, minimap)
        return iter, points[uiMapId], nil
    end
end

---------------------------------------------------------
-- Options table
local options = {
    type = "group",
    name = "DragonGlyphs",
    desc = "DragonGlyphs",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        HL:SendMessage("HandyNotes_NotifyUpdate", "DragonGlyphs")
    end,
    args = {
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 0,
        },
        completed = {
            name = "Show completed",
            desc = "Show waypoints for glyphs you've already found?",
            type = "toggle",
            arg = "completed",
            order = 10,
        },
        icon_scale = {
            type = "range",
            name = "Icon Scale",
            desc = "The scale of the icons",
            min = 0.25, max = 2, step = 0.01,
            arg = "icon_scale",
            order = 20,
        },
        icon_alpha = {
            type = "range",
            name = "Icon Alpha",
            desc = "The alpha transparency of the icons",
            min = 0, max = 1, step = 0.01,
            arg = "icon_alpha",
            order = 30,
        },
    },
}


---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_DragonGlyphsDB", defaults)
    db = self.db.profile
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("DragonGlyphs", HLHandler, options)
end

function HL:OnEnable()
    self:RegisterEvent("CRITERIA_UPDATE", "Refresh")
    self:RegisterEvent("CRITERIA_EARNED", "Refresh")
    self:RegisterEvent("CRITERIA_COMPLETE", "Refresh")
    self:RegisterEvent("ACHIEVEMENT_EARNED", "Refresh")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "DragonGlyphs")
end

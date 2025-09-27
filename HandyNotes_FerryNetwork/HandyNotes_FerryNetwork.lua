-- don't load if player isn't alliance
local faction, _ = UnitFactionGroup('player')
if faction ~= 'Alliance' then
    return
end

local HandyNotes_FerryNetwork = LibStub('AceAddon-3.0'):NewAddon('HandyNotes_FerryNetwork', 'AceEvent-3.0')

local HandyNotes = LibStub('AceAddon-3.0'):GetAddon('HandyNotes', true)
if not HandyNotes then return end

local db
local iconDefault = 'Interface\\Addons\\HandyNotes_FerryNetwork\\ferry.tga'
local textDefault = 'Ferry Master'

HandyNotes_FerryNetwork.nodes = {}
local nodes = HandyNotes_FerryNetwork.nodes

nodes[895] = { --Tiragarde Sound
    [42003060] = {'Anglepoint Wharf, Tiragarde Sound', textDefault},
    [54005320] = {'Old Drust Road, Tiragarde Sound', textDefault},
    [63803020] = {'Firebreaker Expedition, Tiragarde Sound', textDefault},
    [66604980] = {'Southwind Station, Tiragarde Sound', textDefault},
    [74204420] = {'Eastpoint Station, Tiragarde Sound', textDefault},

    [49406561] = {'Fletcher\'s Hollow, Drustvar', textDefault},
    [43104924] = {'Fallhaven, Drustvar', textDefault},

    [74922587] = {'Tradewinds Market, Boralus', textDefault},
}
nodes[896] = { --Drustvar
    [69405720] = {'Fletcher\'s Hollow, Drustvar', textDefault},
    [61603660] = {'Fallhaven, Drustvar', textDefault},

    [59551162] = {'Anglepoint Wharf, Tiragarde Sound', textDefault},
    [75214173] = {'Old Drust Road, Tiragarde Sound', textDefault},
    [87761176] = {'Firebreaker Expedition, Tiragarde Sound', textDefault},
    [92443762] = {'Southwind Station, Tiragarde Sound', textDefault},
    [99362897] = {'Eastpoint Station, Tiragarde Sound', textDefault},

    --[99900840] = {'Tradewinds Market, Boralus', textDefault},
}
nodes[1161] = { --Boralus
    [74172480] = {'Tradewinds Market, Boralus', textDefault},

    [26554406] = {'Firebreaker Expedition, Tiragarde Sound', textDefault},
    [68689760] = {'Eastpoint Station, Tiragarde Sound', textDefault},
}
nodes[876] = { --Kul Tiras
    [43115349] = {'Anglepoint Wharf, Tiragarde Sound', textDefault},
    [49716663] = {'Old Drust Road, Tiragarde Sound', textDefault},
    [55615343] = {'Firebreaker Expedition, Tiragarde Sound', textDefault},
    [56986407] = {'Southwind Station, Tiragarde Sound', textDefault},
    [61576106] = {'Eastpoint Station, Tiragarde Sound', textDefault},

    [47457305] = {'Fletcher\'s Hollow, Drustvar', textDefault},
    [43836393] = {'Fallhaven, Drustvar', textDefault},

    [61505050] = {'Tradewinds Market, Boralus', textDefault},
}

local clickedMapFile = nil
local clickedCoord = nil
local isTomTomLoaded = false

local function addTomTomWaypoint(_, uiMapId, coord)
    if isTomTomLoaded then
        local x, y = HandyNotes:getXY(coord)
        local desc = nodes[uiMapId][coord][1];
        TomTom:AddWaypoint(uiMapId, x, y, {
            title = desc,
            persistent = nil,
            minimap = true,
            world = true,
        })
    end
end

local function generateMenu(_, level)
    if (level ~= 1) then return end

    UIDropDownMenu_AddButton({
        isTitle = 1,
        text = 'Ferry Master',
        notCheckable = 1,
    }, 1)

    if isTomTomLoaded == true then
        UIDropDownMenu_AddButton({
            text = 'Add this location to TomTom waypoints',
            func = addTomTomWaypoint,
            arg1 = clickedMapFile,
            arg2 = clickedCoord,
            notCheckable = 1,
        }, 1)
    end

    UIDropDownMenu_AddButton({
        text = CLOSE,
        func = function() CloseDropDownMenus() end,
        arg1 = nil,
        arg2 = nil,
        notCheckable = 1,
    }, 1)
end

local dropdownMenu = CreateFrame('Frame')
dropdownMenu.displayMode = 'MENU'
dropdownMenu.initialize = generateMenu

local function IsFerryMapOpen()
    local uiMapId = WorldMapFrame:GetMapID()
    if(not uiMapId) then
        return false
    end

    for _, TaxiNodeInfo in pairs(C_TaxiMap.GetAllTaxiNodes(uiMapId)) do
        if(TaxiNodeInfo.state == 0) then -- current taxi node
            return (TaxiNodeInfo.textureKitPrefix == 'FlightMaster_Ferry')
        end
    end
    return false
end

function HandyNotes_FerryNetwork:OnClick(button, down, mapFile, coord)
    if button == 'RightButton' and down then
        clickedMapFile = mapFile
        clickedCoord = coord
        ToggleDropDownMenu(1, nil, dropdownMenu, self, 0, 0)
    end
end

function HandyNotes_FerryNetwork:OnEnter(mapFile, coord)
    if (not nodes[mapFile][coord]) then return end

    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then
        tooltip:SetOwner(self, 'ANCHOR_LEFT')
    else
        tooltip:SetOwner(self, 'ANCHOR_RIGHT')
    end

    local text = nodes[mapFile][coord][1] or textDefault
    tooltip:SetText(text)
    local text2 = nodes[mapFile][coord][2] or textDefault
    tooltip:AddLine(text2, nil, nil, nil, true)
    tooltip:Show()
end

function HandyNotes_FerryNetwork:OnLeave()
    GameTooltip:Hide()
end

local options = {
    type = 'group',
    name = 'Ferry Master Network',
    desc = 'Locations of Ferry Masters on Kul Tiras',
    get = function(info) return db[info.arg] end,
    set = function(info, v) db[info.arg] = v; HandyNotes_FerryNetwork:Refresh() end,
    args = {
        desc = {
            name = 'These settings control the look and feel of the icon.',
            type = 'description',
            order = 0,
        },
        icon_scale = {
            type = 'range',
            name = 'Icon Scale',
            desc = 'The scale of the icons',
            min = 0.25, max = 3, step = 0.01,
            arg = 'icon_scale',
            order = 10,
        },
        icon_alpha = {
            type = 'range',
            name = 'Icon Alpha',
            desc = 'The alpha transparency of the icons',
            min = 0, max = 1, step = 0.01,
            arg = 'icon_alpha',
            order = 20,
        },
        showonminimap = {
            type = 'toggle',
            arg = 'showonminimap',
            name = 'Show on Minimap',
            desc = 'Show icons on minimap in addition to world map',
            order = 30,
            width = 'normal',
        },
        showonferrymap = {
            type = 'toggle',
            arg = 'showonferrymap',
            name = 'Show on Ferry Master map',
            desc = 'Show icons on map when talking to a Ferry Master',
            order = 40,
            width = 'normal',
        },
        showonkultirasmap = {
            type = 'toggle',
            arg = 'showonkultirasmap',
            name = 'Show on Kul Tiras map',
            desc = 'Show icons on the continent map',
            order = 50,
            width = 'normal',
        },
    },
}

function HandyNotes_FerryNetwork:OnInitialize()
    local defaults = {
        profile = {
            icon_scale = 1.0,
            icon_alpha = 1.0,
            showonminimap = true,
            showonkultirasmap = true,
            showonferrymap = false,
        },
    }
    db = LibStub('AceDB-3.0'):New('HandyNotes_FerryNetworkDB', defaults, true).profile

    if (C_AddOns.IsAddOnLoaded('TomTom')) then
        isTomTomLoaded = true
    end
    HandyNotes:RegisterPluginDB('HandyNotes_FerryNetwork', self, options)
end

local function iter(t, prestate)
    if not t then return nil end
    local state, value = next(t, prestate)
    while state do
        if (value[1]) then
            local icon = value[3] or iconDefault
            return state, nil, icon, db.icon_scale * 3, db.icon_alpha * 2
        end
        state, value = next(t, state)
    end
end

function HandyNotes_FerryNetwork:GetNodes2(uiMapId, isMinimapUpdate)
    if isMinimapUpdate and not db.showonminimap then return function() end end
    if IsFerryMapOpen() and not db.showonferrymap then return function() end end
    if uiMapId == 876 and not db.showonkultirasmap then return function() end end
    return iter, nodes[uiMapId], nil
end

function HandyNotes_FerryNetwork:Refresh()
    self:SendMessage('HandyNotes_NotifyUpdate', 'HandyNotes_FerryNetwork')
end

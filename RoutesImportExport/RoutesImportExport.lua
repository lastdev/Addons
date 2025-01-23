local LibBase64 = LibStub("LibBase64-1.0")
local AceSerializer = LibStub("AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Routes", false)

local route_zone_args_desc_table = {
    type = "description",
    name = function(info)
        local zone = tonumber(info[2])
        local count = 0

        for route_name, route_table in pairs(Routes.db.global.routes[zone]) do
            if #route_table.route > 0 then
                count = count + 1
            end
        end

        return L["You have |cffffd200%d|r route(s) in |cffffd200%s|r."]:format(count, C_Map.GetMapInfo(zone).name)
    end,
    order = 0,
}

local function normaliseRouteData(routeData)
    routeData.hidden = false
    routeData.looped = 1
    routeData.visible = true
    routeData.selection = {}
    routeData.db_type = {}
    routeData.taboos = {}
    routeData.taboolist = {}

    return routeData
end

local function shallowCopy(from)
    local to = {}
    for k, v in pairs(from) do
        to[k] = v
    end
    return to
end

local function stripSpecialChars(string)
    return string:gsub("[;:+/=-.|]", " ")
end

local function getProjectName(projectId)
    return (projectId == WOW_PROJECT_MAINLINE and "Retail") or (projectId == WOW_PROJECT_CLASSIC and "Classic") or (projectId == WOW_PROJECT_BURNING_CRUSADE_CLASSIC and "TBCC") or (projectId == WOW_PROJECT_WRATH_CLASSIC and "WOTLKC") or (projectId == 14 and "CATA") or "Unknown"
end

local function getProjectLongName(projectId)
    return (projectId == WOW_PROJECT_MAINLINE and "Retail WoW") or (projectId == WOW_PROJECT_CLASSIC and "Classic WoW") or (projectId == WOW_PROJECT_BURNING_CRUSADE_CLASSIC and "Burning Crusade Classic") or (projectId == WOW_PROJECT_WRATH_CLASSIC and "Wrath of the Lich King Classic") or (projectId == 14 and "Cataclysm Classic") or "Unknown WoW Type"
end

local function getProjectId(projectName)
    return (projectName =="Retail" and WOW_PROJECT_MAINLINE) or (projectName == "Classic" and WOW_PROJECT_CLASSIC) or (projectName == "TBCC" and WOW_PROJECT_BURNING_CRUSADE_CLASSIC) or (projectName == "WOTLKC" and WOW_PROJECT_WRATH_CLASSIC) or (projectName == "CATA" and 14)
end

local function serialize(data)
    local projectName = getProjectName(WOW_PROJECT_ID)
    local location = stripSpecialChars(C_Map.GetMapInfo(data.RouteZone).name)
    local name = stripSpecialChars(data.RouteName)

    return string.format("%s:Routes:%s:%s:%s", projectName, name, location, LibBase64.Encode(AceSerializer:Serialize(data)))
end

local function deserialize(exportString)
    local sections = { strsplit(":", exportString) }

    if #sections == 0 then return nil end

    if #sections == 5 and getProjectId(sections[1]) ~= WOW_PROJECT_ID and
        (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or getProjectId(sections[1]) == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID < getProjectId(sections[1])) then
        print(string.format("|cFFFF0a0aThis import string is for %s not %s|r", getProjectLongName(getProjectId(sections[1])), getProjectLongName(WOW_PROJECT_ID)))
        return nil
    end

    return AceSerializer:Deserialize(LibBase64.Decode(sections[#sections]))
end

local function importRouteData(data)
    if data and data.RouteZone and data.RouteKey and data.RouteName and data.RouteData then
        local mapInfo = C_Map.GetMapInfo(data.RouteZone)
        if not mapInfo then return end

        normaliseRouteData(data.RouteData)

        Routes.db.global.routes[data.RouteZone][data.RouteName] = nil
        Routes.db.global.routes[data.RouteZone][data.RouteName] = data.RouteData

        local opts = Routes.options.args.routes_group.args
        zoneKey = tostring(data.RouteZone)
        routeKey = data.RouteKey

        if not opts[zoneKey] then
            local mapName = mapInfo.name

            opts[zoneKey] = {
                type = "group",
                name = mapName,
                desc = L["Routes in %s"]:format(mapName),
                args = {
                    desc = route_zone_args_desc_table,
                },
            }

            Routes.routekeys[data.RouteZone] = {}
        end

        Routes.routekeys[data.RouteZone][routeKey] = data.RouteName
        opts[zoneKey].args[routeKey] = Routes:GetAceOptRouteTable()

        LibStub("AceConfigDialog-3.0"):SelectGroup('Routes', 'routes_group', zoneKey, data.RouteKey)

        print("Route " .. data.RouteName .. " (" .. mapInfo.name .. ") imported succefully" )

        return true
    end

    return false
end

local function importRoute(value)
    if strlen(value) > 0 then
        local routes = { strsplit(";", value) }
        local updated = false
        local zoneKey, routeKey

        for _, route in pairs(routes) do
            route = strtrim(route)

            if strlen(route) > 0 then
                local result, data = deserialize(route)

                if result and data.Routes then
                    for _, currentRoute in pairs(data.Routes) do
                        if importRouteData(currentRoute) then
                            updated = true
                        end
                    end
                elseif result and importRouteData(data) then
                    updated = true
                end
            end
        end

        if updated then
            local AutoShow = Routes:GetModule("AutoShow", true)

            if AutoShow and Routes.db.defaults.use_auto_showhide then
                AutoShow:ApplyVisibility()
            end

            Routes:DrawWorldmapLines()
            Routes:DrawMinimapLines(true)
        end

        return updated
    end
end

local function renameRoute(zone, routeKey, newName)
    local opts = Routes.options.args.routes_group.args
    local zoneKey = tostring(zone)
    local newRouteKey = newName:gsub("%s", "\255")
    local oldName = Routes.routekeys[zone][routeKey]
    local data = Routes.db.global.routes[zone][oldName]

    Routes.db.global.routes[zone][oldName] = nil
    Routes.db.global.routes[zone][newName] = data

    Routes.routekeys[zone][routeKey] = nil
    Routes.routekeys[zone][newRouteKey] = newName

    opts[zoneKey].args[routeKey] = nil
    opts[zoneKey].args[newRouteKey] = Routes:GetAceOptRouteTable()

    local AutoShow = Routes:GetModule("AutoShow", true)

    if AutoShow and Routes.db.defaults.use_auto_showhide then
        AutoShow:ApplyVisibility()
    end

    Routes:DrawWorldmapLines()
    Routes:DrawMinimapLines(true)

    LibStub("AceConfigDialog-3.0"):SelectGroup('Routes', 'routes_group', zoneKey, newRouteKey)
end

local renameGroup = {
    name = "Name",
    type = "input",
    width = "full",
    multiline = false,
    get = function(info)
        return Routes.routekeys[tonumber(info[2])][info[3]]
    end,
    set = function(info, value)
        local zone = tonumber(info[2])
        local routekey = info[3]

        if value ~= Routes.routekeys[zone][routekey] then
            renameRoute(zone, routekey, value)
        end
    end,
    order = 998,
}

local exportGroup = {
    name = "Export",
    type = "input",
    width = "full",
    multiline = true,
    get = function(info)
        local zone = tonumber(info[2])
        local routekey = info[3]
        local name = Routes.routekeys[zone][routekey]
        local route = Routes.db.global.routes[zone][name]
        local data = { RouteZone = zone, RouteKey = routekey, RouteName = name, RouteData = normaliseRouteData(shallowCopy(route)) }

        return serialize(data)
    end,
    set = function(info, value)
        local result, imported = pcall(importRoute, value)
        if not (result and imported) then
            print("|cFFFF0808Incorrect import string")
        end
    end,
    order = 999,
}

local importGroup = {
    name = "Import",
    type = "input",
    width = "full",
    multiline = true,
    set = function(info, value)
        local result, imported = pcall(importRoute, value)
        if not (result and imported) then
            print("|cFFFF0808Incorrect import string")
        end
    end,
    order = 999,
}

local function init(self, event, name)
    if (name ~= "RoutesImportExport") then return end

    Routes:GetAceOptRouteTable().args.info_group.args.rename = renameGroup
    Routes:GetAceOptRouteTable().args.info_group.args.export = exportGroup
    Routes.options.args.routes_group.args.import = importGroup
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", init)
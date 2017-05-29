local UnitPosition, GetPlayerFacing, GetPOITextureCoords, GetCVar = UnitPosition, GetPlayerFacing, GetPOITextureCoords, GetCVar
local pi, cos, sin, abs, tinsert, twipe, print, type, pairs = math.pi, math.cos, math.sin, math.abs, table.insert, table.wipe, print, type, pairs
local Minimap = Minimap

local MinimapRadius = {
    Inside = {
        [0] = 150.0,
        [1] = 120.0,
        [2] = 90.0,
        [3] = 60.0,
        [4] = 40.0,
        [5] = 25.0,
    },
    Outside = {
        [0] = 233.333324,
        [1] = 199.999992,
        [2] = 166.66666,
        [3] = 133.333328,
        [4] = 99.999996,
        [5] = 66.666664,
    }
}

MinimapPOIHandler = CreateFrame("Frame")
MinimapPOIHandler.POIIcons = {}
MinimapPOIHandler.POIPoints = {}
MinimapPOIHandler.POIPointsClosest = {}

MinimapPOIHandler:RegisterEvent("MINIMAP_UPDATE_ZOOM")
MinimapPOIHandler:RegisterEvent("CVAR_UPDATE")
MinimapPOIHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
MinimapPOIHandler:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)

local function GetDistanceToPoint(pointx, pointy, x, y)
    local dX = pointx - x
    local dY = pointy - y
    return (dX * dX + dY * dY) ^ 0.5
end

function MinimapPOIHandler:AddPoint(point)
    if not point.x or not point.y or not point.name then
        print("MinimapPOIHandler:AddPoint failed")
        return
    end
    tinsert(self.POIPoints, point)
    self.needsUpdate = true
end

function MinimapPOIHandler:SetDataSource(data, continents)
    if type(data) ~= "table" then
        print("MinimapPOIHandler:SetDataSource failed")
        return
    end
    self.POIPoints = data
    self.continents = continents
    self.needsUpdate = true
end

function MinimapPOIHandler:SetFilter(filter)
    if type(filter) ~= "function" then
        print("MinimapPOIHandler:SetFilter failed")
        return
    end
    self.filter = filter
    self.needsUpdate = true
end

function MinimapPOIHandler:Enable()
    self:SetScript("OnUpdate", function(self, elapsed) self["UpdateMinimapIcons"](self, elapsed) end)
end

function MinimapPOIHandler:Disable()
    self:SetScript("OnUpdate", nil)
    self:HideIcons()
end

function MinimapPOIHandler:HideIcons()
     for k, v in pairs(self.POIIcons) do
        v:Hide()
    end
end

function MinimapPOIHandler:MINIMAP_UPDATE_ZOOM()
    local curZoom = Minimap:GetZoom()
    if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
        if curZoom < 2 then
            Minimap:SetZoom(curZoom + 1)
        else
            Minimap:SetZoom(curZoom - 1)
        end
    end
    if GetCVar("minimapZoom")+0 == Minimap:GetZoom() then
        self.minimapOutside = true
    else
        self.minimapOutside = false
    end
    Minimap:SetZoom(curZoom)
    self.needsUpdate = true
end

function MinimapPOIHandler:CVAR_UPDATE(event, cvar, value)
    if cvar == "ROTATE_MINIMAP" then
        self.rotateMinimap = value ~= "0"
        self.needsUpdate = true
    end
end

function MinimapPOIHandler:PLAYER_ENTERING_WORLD()
    self.rotateMinimap = GetCVar("rotateMinimap") ~= "0"
    self.needsUpdate = true
end

local function MinimapPOI_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
    local name = MinimapPOIHandler.POIPoints[self.pointid].name
    GameTooltip:SetText(name, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
    GameTooltip:Show()
end

local function MinimapPOI_OnLeave(self)
    GameTooltip:Hide()
end

function MinimapPOIHandler:CreatePOI(index)
    local name = "MinimapPOI"..index
    local poi = CreateFrame("Button", name, Minimap)
    poi:SetHeight(20)
    poi:SetWidth(20)

    poi.Texture = poi:CreateTexture(name.."Texture", "BACKGROUND")
    poi.Texture:SetTexture("Interface\\Minimap\\POIIcons")

    poi.Texture:SetPoint("CENTER", 0, 0)
    poi.Texture:SetHeight(12)
    poi.Texture:SetWidth(12)

    poi:SetScript("OnEnter", MinimapPOI_OnEnter)
    poi:SetScript("OnLeave", MinimapPOI_OnLeave)

    poi.SetIcon = function(self, icon)
        local x1, x2, y1, y2 = GetPOITextureCoords(icon)
        self.Texture:SetTexCoord(x1, x2, y1, y2)
    end

    self.POIIcons[index] = poi

    return poi
end

local function WorldPosToMinimapPos(px, py, x, y, radius)
    local locLeft, locTop, locRight, locBottom = py + radius, px + radius, py - radius, px - radius

    local h, w = abs(locRight - locLeft), abs(locBottom - locTop)
    local sx = (locTop - x) / w
    local sy = (locLeft - y) / h
    local onMap = y < locLeft and y > locRight and x < locTop and x > locBottom
    return sy, sx, onMap
end

function MinimapPOIHandler:GetPOI(index)
    local poi = self.POIIcons[index]
    if not poi then
        poi = self:CreatePOI(index)
    end
    return poi
end

local updateThreshold = 0
local updateThreshold2 = 0

function MinimapPOIHandler:UpdateMinimapIcons(elapsed)
    updateThreshold = updateThreshold + elapsed
    if updateThreshold < 0.05 then return end
    updateThreshold = 0
    local x, y, _, mapID = UnitPosition("player")
    if not x or not y then
        self:HideIcons()
        return
    end
    local facing = GetPlayerFacing()
    local minimapZoom = Minimap:GetZoom()

    -- check if we need to update
    if not self.needsUpdate and self.x == x and self.y == y and self.mapID == mapID and (not self.rotateMinimap or self.facing == facing) and self.minimapZoom == minimapZoom then
        return
    else
        self.x = x
        self.y = y
        self.mapID = mapID
        self.facing = facing
        self.minimapZoom = minimapZoom
        self.needsUpdate = false
    end

    local radius = self.minimapOutside and MinimapRadius.Outside[minimapZoom] or MinimapRadius.Inside[minimapZoom]
    local radiusFix = radius * 0.95
    local diameter = radius * 2
    local mmw, mmh = Minimap:GetSize()
    local xscale = mmw / diameter
    local yscale = mmh / diameter
    local rotation = (2 * pi) - facing

    local index = 0

    updateThreshold2 = updateThreshold2 + elapsed
    if updateThreshold2 > 3 then
        updateThreshold2 = 0
        twipe(self.POIPointsClosest)
        for k, v in pairs(self.POIPoints) do
            if (not self.continents or self.continents[mapID] == v.continent) and GetDistanceToPoint(v.x, v.y, x, y) < diameter then
                self.POIPointsClosest[k] = true
            end
        end
    end

    for k, _ in pairs(self.POIPointsClosest) do
        local v = self.POIPoints[k]
        if not self.filter or self.filter(v, x, y, mapID, radiusFix) then
            index = index + 1
            local poi = self:GetPOI(index)

            poi:SetIcon(v.icon or 197)

            poi.pointid = k

            if self.rotateMinimap then
                local dy, dx = v.x - x, v.y - y
                local sinTheta = sin(rotation)
                local cosTheta = cos(rotation)
                local mx = ((-dx * cosTheta) - (dy * sinTheta)) * xscale
                local my = ((-dx * sinTheta) + (dy * cosTheta)) * yscale
                poi:SetPoint("CENTER", Minimap, "CENTER", mx, my)
            else
                local mx, my = WorldPosToMinimapPos(x, y, v.x, v.y, radius)
                mx = mx * mmw
                my = -my * mmh
                poi:SetPoint("CENTER", Minimap, "TOPLEFT", mx, my)
            end

            poi:Show()
        end
    end

    if #self.POIIcons > index then
        for pindex = index + 1, #self.POIIcons do
            self.POIIcons[pindex]:Hide()
        end
    end
end

-- VendorMapPins.lua
-- Custom map pin system for vendor and profession trainer locations
-- Direct implementation without HereBeDragons complexity

local VendorMapPins = {}
_G.HousingVendorMapPins = VendorMapPins

-- Pin storage
local activePins = {}
local pinPool = {}
local pinCount = 0

-- Icon paths
local VENDOR_ICON = "Interface\\Minimap\\Tracking\\Banker"
local PROFESSION_ICON = "Interface\\Minimap\\Tracking\\Profession"

-- Settings
local function GetPinSize()
    return (_G.HousingDB and _G.HousingDB.mapPinSize) or 20
end

local function IsPinsEnabled()
    if _G.HousingDB and _G.HousingDB.mapPinsEnabled ~= nil then
        return _G.HousingDB.mapPinsEnabled
    end
    return true
end

-- Create a pin frame
local function CreatePin()
    pinCount = pinCount + 1
    local pin = CreateFrame("Frame", "HousingVendorPin" .. pinCount, WorldMapFrame:GetCanvas())
    local size = GetPinSize()
    pin:SetSize(size, size)
    pin:SetFrameStrata("TOOLTIP")

    local texture = pin:CreateTexture(nil, "OVERLAY")
    texture:SetPoint("CENTER")
    texture:SetSize(size, size)
    pin.texture = texture

    -- Make it interactive
    pin:EnableMouse(true)
    pin:SetMouseClickEnabled(true)

    -- Tooltip on hover
    pin:SetScript("OnEnter", function(self)
        if not self.data then return end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        local name = self.data.name or "Unknown"
        local location = self.data.location or ""

        GameTooltip:SetText(name, 1, 1, 1)

        if location and location ~= "" and location ~= "None" then
            GameTooltip:AddLine(location, 0.7, 0.7, 0.7)
        end

        -- Add type
        if self.data.isProfessionTrainer then
            local profName = self.data.professionName or "Profession"
            GameTooltip:AddLine(profName .. " Trainer", 1, 0.82, 0)
        else
            GameTooltip:AddLine("Vendor", 0.5, 0.8, 1)
        end

        -- Add faction
        local faction = self.data.faction
        if faction == "Alliance" or faction == 1 then
            GameTooltip:AddLine("Alliance", 0.25, 0.50, 0.90)
        elseif faction == "Horde" or faction == 2 then
            GameTooltip:AddLine("Horde", 0.85, 0.20, 0.25)
        else
            GameTooltip:AddLine("Neutral", 0.60, 0.58, 0.65)
        end

        -- Add coordinates
        if self.data.coords then
            local coords = self.data.coords
            GameTooltip:AddLine(string.format("%.1f, %.1f", coords.x, coords.y), 0.5, 0.8, 1)
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click to set waypoint", 0.5, 1, 0.5)

        GameTooltip:Show()
    end)

    pin:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    -- Click to set waypoint
    pin:SetScript("OnMouseUp", function(self, button)
        if not self.data then return end

        if button == "LeftButton" or button == "RightButton" then
            local coords = self.data.coords
            local vendorName = self.data.name
            local npcID = self.data.npcID

            local canShowMarker =
                _G.HousingDB and _G.HousingDB.settings and _G.HousingDB.settings.enableVendorMarker and
                _G.HousingVendorMarker and _G.HousingVendorMarker.ShowForVendor and
                coords and coords.mapID and coords.x and coords.y and
                npcID and npcID ~= "None" and npcID ~= "" and tonumber(npcID)

            -- If the vendor marker UI is enabled, use it so the "mark vendor" box (and vendor selection)
            -- updates when clicking map pins.
            if canShowMarker then
                _G.HousingVendorMarker:ShowForVendor(vendorName or "Vendor", npcID, { x = coords.x, y = coords.y, mapID = coords.mapID })
                return
            end

            if _G.HousingWaypointManager and _G.HousingWaypointManager.SetWaypoint then
                local waypointData = {
                    coords = coords,
                    mapID = coords and coords.mapID,
                    vendorName = vendorName,
                    npcID = npcID,
                }
                _G.HousingWaypointManager:SetWaypoint(waypointData)
            end
        end
    end)

    return pin
end

-- Get pin from pool
local function GetPin()
    local pin = table.remove(pinPool)
    if not pin then
        pin = CreatePin()
    end
    -- Always apply current size (pins are pooled and may have old dimensions)
    local size = GetPinSize()
    pin:SetSize(size, size)
    if pin.texture then
        pin.texture:SetSize(size, size)
    end
    return pin
end

-- Release pin back to pool
local function ReleasePin(pin)
    pin.data = nil
    pin:Hide()
    pin:ClearAllPoints()
    table.insert(pinPool, pin)
end

-- Clear all active pins
function VendorMapPins:ClearAllPins()
    for _, pin in ipairs(activePins) do
        ReleasePin(pin)
    end
    wipe(activePins)
end

-- Refresh pin sizes
function VendorMapPins:RefreshPinSize(newSize)
    for _, pin in ipairs(activePins) do
        pin:SetSize(newSize, newSize)
        if pin.texture then
            pin.texture:SetSize(newSize, newSize)
        end
    end
    -- Also update pooled pins so reopening the map uses the new size
    for _, pin in ipairs(pinPool) do
        pin:SetSize(newSize, newSize)
        if pin.texture then
            pin.texture:SetSize(newSize, newSize)
        end
    end
end

-- Position pin on map
local function PositionPin(pin, mapID, x, y)
    local currentMapID = WorldMapFrame:GetMapID()
    if not currentMapID then return false end

    -- Get map info
    local currentMapInfo = C_Map.GetMapInfo(currentMapID)
    if not currentMapInfo then return false end

    -- Don't show on World or Cosmic maps (the very top level)
    if currentMapInfo.mapType == Enum.UIMapType.World or currentMapInfo.mapType == Enum.UIMapType.Cosmic then
        return false
    end

    -- Only show on exact map match (no parent/child for now)
    if mapID ~= currentMapID then
        return false
    end
    
    -- Position the pin
    pin:SetPoint("CENTER", WorldMapFrame:GetCanvas(), "TOPLEFT",
        WorldMapFrame:GetCanvas():GetWidth() * x,
        -WorldMapFrame:GetCanvas():GetHeight() * y)
    pin:Show()
    return true
end

-- Add vendors to map
function VendorMapPins:ShowVendors()
    if not IsPinsEnabled() then
        return
    end

    if not _G.HousingVendorPool then
        return
    end

    if not WorldMapFrame:IsShown() then
        return
    end

    self:ClearAllPins()

    local currentMapID = WorldMapFrame:GetMapID()
    if not currentMapID then
        return
    end

    local vendorCount = 0
    local trainerCount = 0

    -- Add all vendors
    for idx, vendor in ipairs(_G.HousingVendorPool) do
        if vendor.coords and vendor.coords.mapID and vendor.coords.x and vendor.coords.y then
            local vendorMapID = vendor.coords.mapID
            local x = vendor.coords.x / 100
            local y = vendor.coords.y / 100

            local pin = GetPin()
            pin.data = {
                name = vendor.name,
                location = vendor.location,
                coords = vendor.coords,
                faction = vendor.faction,
                expansion = vendor.expansion,
                npcID = vendor.npcID,
                isProfessionTrainer = false,
            }

            pin.texture:SetTexture(VENDOR_ICON)

            if PositionPin(pin, vendorMapID, x, y) then
                table.insert(activePins, pin)
                vendorCount = vendorCount + 1
            else
                ReleasePin(pin)
            end
        end
    end

    -- Add profession trainers
    if _G.HousingProfessionTrainers then
        for professionName, professionData in pairs(_G.HousingProfessionTrainers) do
            if type(professionData.expansions) == "table" then
                for expansionName, factionData in pairs(professionData.expansions) do
                    for factionKey, trainer in pairs(factionData) do
                        if type(trainer) == "table" and trainer.coords and trainer.coords.mapID and trainer.coords.x and trainer.coords.y then
                            local trainerMapID = trainer.coords.mapID
                            local x = trainer.coords.x / 100
                            local y = trainer.coords.y / 100

                            local pin = GetPin()
                            pin.data = {
                                name = trainer.name or "Unknown Trainer",
                                location = trainer.location or "",
                                coords = trainer.coords,
                                faction = factionKey,
                                expansion = expansionName,
                                isProfessionTrainer = true,
                                professionName = professionName,
                            }

                            pin.texture:SetTexture(PROFESSION_ICON)

                            if PositionPin(pin, trainerMapID, x, y) then
                                table.insert(activePins, pin)
                                trainerCount = trainerCount + 1
                            else
                                ReleasePin(pin)
                            end
                        end
                    end
                end
            end
        end
    end

end

-- Enable/disable pins
function VendorMapPins:SetEnabled(enabled)
    if not _G.HousingDB then
        _G.HousingDB = {}
    end
    _G.HousingDB.mapPinsEnabled = enabled

    if enabled then
        self:ShowVendors()
    else
        self:ClearAllPins()
    end
end

-- Set pin size
function VendorMapPins:SetPinSize(size)
    if not _G.HousingDB then
        _G.HousingDB = {}
    end
    _G.HousingDB.mapPinSize = size
    self:RefreshPinSize(size)
end

-- Initialize when map opens
local function OnMapOpened()
    if VendorMapPins and IsPinsEnabled() then
        C_Timer.After(0.2, function()
            VendorMapPins:ShowVendors()
        end)
    end
end

-- Initialize when map closes
local function OnMapClosed()
    if VendorMapPins then
        VendorMapPins:ClearAllPins()
    end
end

-- Hook into WorldMapFrame
local function InitializeMapHooks()
    if not WorldMapFrame then
        return
    end

    WorldMapFrame:HookScript("OnShow", OnMapOpened)
    WorldMapFrame:HookScript("OnHide", OnMapClosed)

    -- Refresh on map changes
    hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
        if VendorMapPins and WorldMapFrame:IsShown() and IsPinsEnabled() then
            C_Timer.After(0.1, function()
                VendorMapPins:ShowVendors()
            end)
        end
    end)
end

-- Initialize
if WorldMapFrame then
    InitializeMapHooks()
else
    C_Timer.After(1, InitializeMapHooks)
end

-- Slash command
SLASH_HVPINS1 = "/hvpins"
SlashCmdList["HVPINS"] = function(msg)
    msg = msg and msg:lower() or ""

    if msg == "on" then
        VendorMapPins:SetEnabled(true)
        print("|cFF8A7FD4HousingVendor:|r Map pins enabled")
    elseif msg == "off" then
        VendorMapPins:SetEnabled(false)
        print("|cFF8A7FD4HousingVendor:|r Map pins disabled")
    elseif msg:match("^size%s+(%d+)") then
        local size = tonumber(msg:match("^size%s+(%d+)"))
        if size and size >= 10 and size <= 50 then
            VendorMapPins:SetPinSize(size)
            print("|cFF8A7FD4HousingVendor:|r Pin size set to " .. size)
        else
            print("|cFF8A7FD4HousingVendor:|r Invalid size (use 10-50)")
        end
    else
        VendorMapPins:ShowVendors()
    end
end

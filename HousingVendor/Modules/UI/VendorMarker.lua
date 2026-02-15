-- Vendor Marker Module
-- Provides a UI to mark vendors with nameplate highlights (works in Midnight/Retail)

local ADDON_NAME, ns = ...
local L = (ns and ns.L) or {}

local VendorMarker = {}
VendorMarker.__index = VendorMarker

local markerFrame = nil
local currentVendorName = nil
local currentNPCID = nil
local currentVendorCoords = nil
local currentOwnsWaypoint = false
local nameplateFrames = {}
local distanceUpdateFrame = nil
local nameplateEventFrame = nil
local StartNameplateTracking, StopNameplateTracking
local debugMode = false  -- Debug mode for nameplate structure logging

local function GetVendorMarkerPositionStore()
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.vendorMarkerPosition then
        HousingDB.vendorMarkerPosition = {}
    end
    return HousingDB.vendorMarkerPosition
end

-- Blue Moon raid marker (standard marker for all vendors)
local RAID_MARKER = {
    color = {0.3, 0.7, 1.0}, -- Light blue
    raidIcon = 5,
    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_5"
}

-- Check if feature is enabled
local function IsEnabled()
    return HousingDB and HousingDB.settings and HousingDB.settings.enableVendorMarker
end

local function IsTomTomIntegrationEnabled()
    return not (HousingDB and HousingDB.settings and HousingDB.settings.useTomTomIntegration == false)
end

local function AcquireTomTom()
    local tt = _G.TomTom
    if tt then
        return tt
    end

    if C_AddOns and C_AddOns.LoadAddOn then
        local loaded = false
        if C_AddOns.IsAddOnLoaded then
            loaded = C_AddOns.IsAddOnLoaded("TomTom")
        end
        if not loaded then
            pcall(function()
                C_AddOns.LoadAddOn("TomTom")
            end)
        end
    elseif LoadAddOn then
        pcall(function()
            LoadAddOn("TomTom")
        end)
    end

    return _G.TomTom
end

local function NormalizeCoord01(v)
    v = tonumber(v)
    if not v then
        return nil
    end
    if v > 1 and v <= 100 then
        return v / 100
    end
    return v
end

local function NormalizeVendorCoords(coords)
    if not coords then
        return nil
    end
    return {
        mapID = tonumber(coords.mapID),
        x = NormalizeCoord01(coords.x),
        y = NormalizeCoord01(coords.y),
    }
end

-- TomTom waypoint UID for vendor marker
local tomtomWaypointUID = nil

-- Calculate distance to vendor using C_Map API (matches TomTom's method)
local function GetTargetNPCID()
    if not UnitGUID then return nil end
    local guid = UnitGUID("target")
    if not guid then return nil end
    local _, _, _, _, _, npcID = strsplit("-", guid)
    return tonumber(npcID)
end

local function GetUnitMapPosition(mapID, unit)
    if not (C_Map and C_Map.GetPlayerMapPosition) then
        return nil
    end
    if not mapID then
        return nil
    end
    local posOk, pos = pcall(C_Map.GetPlayerMapPosition, mapID, unit)
    if not posOk then pos = nil end
    if not pos or not pos.x or not pos.y then
        return nil
    end
    if pos.x == 0 and pos.y == 0 then
        return nil
    end
    return pos
end

local function CalculateDistance(vendorCoords)
    -- If this marker set the active waypoint, use the active waypoint distance so the marker
    -- follows multi-step routing (portal room -> specific portal -> final destination).
    if currentOwnsWaypoint and HousingWaypointManager and HousingWaypointManager.GetActiveWaypointDistance then
        local dist, reason = HousingWaypointManager:GetActiveWaypointDistance()
        if dist then
            return dist
        end
        if reason then
            return nil, reason
        end
    end

    -- If a waypoint is active for this vendor, use it to match TomTom/Blizzard distance.
    if HousingWaypointManager and HousingWaypointManager.GetActiveWaypointDistance and HousingWaypointManager.GetActiveWaypointInfo then
        local info = HousingWaypointManager:GetActiveWaypointInfo()
        local matchesNPC = info and info.npcID and currentNPCID and info.npcID == currentNPCID
        local matchesName = info and info.name and currentVendorName and info.name == currentVendorName
        if matchesNPC or matchesName then
            local dist, reason = HousingWaypointManager:GetActiveWaypointDistance()
            if dist then
                return dist
            end
            if reason then
                return nil, reason
            end
        end
    end

    -- Prefer target-based distance when the target is the selected vendor.
    local targetNPCID = GetTargetNPCID()
    if currentNPCID and targetNPCID and currentNPCID == targetNPCID then
        local mapID = C_Map.GetBestMapForUnit("target") or C_Map.GetBestMapForUnit("player")
        if not mapID then
            return nil, "No map"
        end

        local targetPos = GetUnitMapPosition(mapID, "target")
        local playerPos = GetUnitMapPosition(mapID, "player")
        if not playerPos then
            return nil, "Unknown"
        end
        if not targetPos then
            return nil, "Out of range"
        end

        local tx, ty = targetPos.x * 100, targetPos.y * 100
        local px, py = playerPos.x * 100, playerPos.y * 100
        local dx = px - tx
        local dy = py - ty
        return math.sqrt(dx * dx + dy * dy) * 1.25
    end

    if not vendorCoords or not vendorCoords.x or not vendorCoords.y or not vendorCoords.mapID then
        return nil, "Unknown"
    end

    -- Get player's best map
    local playerMapID = C_Map.GetBestMapForUnit("player")
    if not playerMapID then
        return nil, "No map"
    end

    -- Check if vendor and player are on the same map
    if playerMapID ~= vendorCoords.mapID then
        -- Check if player is in a sub-zone (like a Garrison) of the vendor's zone
        if HousingMapParents and HousingMapParents[playerMapID] == vendorCoords.mapID then
            -- Player is in an instanced sub-zone, show helpful exit message
            local zoneName = nil
            if C_Map and C_Map.GetMapInfo then
                local mapInfo = C_Map.GetMapInfo(vendorCoords.mapID)
                zoneName = mapInfo and mapInfo.name
            end
            return nil, "Exit to " .. (zoneName or "parent zone")
        end
        return nil, "Different zone"
    end

    -- Get player position on the vendor's map
    local playerPos = GetUnitMapPosition(vendorCoords.mapID, "player")
    if not playerPos then
        return nil, "Unknown"
    end

    -- Convert to 0-100 scale (map coords are 0-1)
    local px, py = playerPos.x * 100, playerPos.y * 100
    local vx, vy = vendorCoords.x * 100, vendorCoords.y * 100

    -- Calculate distance (using yard scale factor similar to TomTom)
    local dx = px - vx
    local dy = py - vy
    local distance = math.sqrt(dx * dx + dy * dy) * 1.25  -- Scale factor for yards

    return distance
end

-- Add TomTom waypoint for vendor
local function AddTomTomWaypoint(vendorName, vendorCoords)
    if not IsTomTomIntegrationEnabled() then
        return
    end

    local tt = AcquireTomTom()
    if not tt or not vendorCoords then
        return
    end

    local normalized = NormalizeVendorCoords(vendorCoords)
    if not normalized or not normalized.mapID or not normalized.x or not normalized.y then
        return
    end

    -- Remove existing waypoint
    if tomtomWaypointUID then
        pcall(function()
            tt:RemoveWaypoint(tomtomWaypointUID)
        end)
        tomtomWaypointUID = nil
    end

    -- Add new waypoint (enable TomTom crazy arrow when present)
    if normalized.mapID and normalized.x and normalized.y then
        local ok, uidOrErr = pcall(function()
            return tt:AddWaypoint(normalized.mapID, normalized.x, normalized.y, {
                title = vendorName or "Vendor",
                persistent = false,
                minimap = true,
                world = true,
                crazy = (tt.SetCrazyArrow ~= nil),
                silent = true,
                from = ADDON_NAME,
            })
        end)

        if ok then
            tomtomWaypointUID = uidOrErr
        elseif _G.HousingVendorLog and _G.HousingVendorLog.Info then
            _G.HousingVendorLog:Info("VendorMarker TomTom waypoint failed: " .. tostring(uidOrErr))
        end
    end
end

-- Remove TomTom waypoint
local function RemoveTomTomWaypoint()
    local tt = _G.TomTom
    if tt and tomtomWaypointUID and tt.RemoveWaypoint then
        pcall(function()
            tt:RemoveWaypoint(tomtomWaypointUID)
        end)
        tomtomWaypointUID = nil
    end
end

-- Update distance display
local function FormatDistance(distanceYards)
    local useMeters = HousingDB and HousingDB.settings and HousingDB.settings.vendorMarkerUseMeters
    if useMeters then
        return string.format("%.1f m", distanceYards * 0.9144)
    end
    return string.format("%.1f yd", distanceYards)
end

local function UpdateDistanceDisplay()
    if not markerFrame or not markerFrame:IsShown() or not markerFrame.distanceLabel then
        return
    end

    if not currentVendorCoords then
        markerFrame.distanceLabel:SetText("Distance: Unknown")
        return
    end

    local distance, reason = CalculateDistance(currentVendorCoords)
    if distance then
        markerFrame.distanceLabel:SetText("Distance: " .. FormatDistance(distance))
    else
        markerFrame.distanceLabel:SetText("Distance: " .. (reason or "Unknown"))
    end
end

local function StopDistanceUpdates()
    if not distanceUpdateFrame then
        return
    end
    if distanceUpdateFrame.SetScript then
        distanceUpdateFrame:SetScript("OnUpdate", nil)
    end
    if distanceUpdateFrame.Hide then
        distanceUpdateFrame:Hide()
    end
    distanceUpdateFrame.elapsed = nil
end

local function StartDistanceUpdates()
    if not distanceUpdateFrame then
        distanceUpdateFrame = CreateFrame("Frame")
    end

    if distanceUpdateFrame.Show then
        distanceUpdateFrame:Show()
    end

    distanceUpdateFrame.elapsed = 0
    distanceUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
        -- Auto-stop if the marker UI isn't visible (prevents idle CPU drain).
        if not markerFrame or not markerFrame:IsShown() then
            StopDistanceUpdates()
            return
        end

        self.elapsed = (self.elapsed or 0) + elapsed
        if self.elapsed >= 0.5 then
            self.elapsed = 0
            UpdateDistanceDisplay()
        end
    end)
end

-- Get or create marker storage
local function GetMarkerStorage()
    if not HousingDB.vendorMarkers then
        HousingDB.vendorMarkers = {}
    end
    return HousingDB.vendorMarkers
end

-- Create the vendor marker UI
function VendorMarker:CreateMarkerFrame()
    if markerFrame then
        return markerFrame
    end

    local frame = CreateFrame("Frame", "HousingVendorMarkerFrame", UIParent, "BackdropTemplate")
    frame:SetSize(260, 95)  -- Narrower width
    do
        local pos = HousingDB and HousingDB.vendorMarkerPosition
        if pos and pos.point and pos.relPoint and pos.x and pos.y then
            frame:SetPoint(pos.point, UIParent, pos.relPoint, pos.x, pos.y)
        else
            frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
        end
    end
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relPoint, xOfs, yOfs = self:GetPoint(1)
        if point and relPoint then
            local store = GetVendorMarkerPositionStore()
            store.point = point
            store.relPoint = relPoint
            store.x = xOfs
            store.y = yOfs
        end
    end)
    frame:Hide()

    -- Match the main UI scale.
    if HousingDB and HousingDB.uiScale then
        frame:SetScale(HousingDB.uiScale)
    end

    frame.UpdateTheme = function(self)
        local colors = (HousingTheme and HousingTheme.Colors) or {}
        local bgPrimary = colors.bgPrimary or {0.08, 0.06, 0.12, 0.95}
        local borderPrimary = colors.borderPrimary or {0.35, 0.30, 0.50, 0.8}
        local borderAccent = colors.borderAccent or borderPrimary
        local accentPrimary = colors.accentPrimary or {0.55, 0.65, 0.90, 1.0}
        local textPrimary = colors.textPrimary or {0.92, 0.90, 0.96, 1.0}
        local textSecondary = colors.textSecondary or {0.70, 0.68, 0.78, 1.0}
        local statusError = colors.statusError or {0.90, 0.35, 0.40, 1.0}
        local bgHover = colors.bgHover or {0.22, 0.16, 0.32, 0.95}

        if HousingTheme and HousingTheme.ApplyBackdrop then
            HousingTheme:ApplyBackdrop(self, "mainFrame", "bgPrimary", "borderAccent")
            if self._closeBtn then
                HousingTheme:ApplyBackdrop(self._closeBtn, "button", "bgTertiary", "borderPrimary")
            end
            if self.markBtn then
                HousingTheme:ApplyBackdrop(self.markBtn, "button", "bgTertiary", "borderPrimary")
                if self.markBtn.label then
                    self.markBtn.label:SetTextColor(unpack(textPrimary))
                end
            end
            if self.clearBtn then
                HousingTheme:ApplyBackdrop(self.clearBtn, "button", "bgTertiary", "borderPrimary")
                if self.clearBtn.label then
                    self.clearBtn.label:SetTextColor(unpack(textPrimary))
                end
            end
        else
            if self.SetBackdropColor then
                self:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], bgPrimary[4])
            end
            if self.SetBackdropBorderColor then
                self:SetBackdropBorderColor(borderAccent[1], borderAccent[2], borderAccent[3], borderAccent[4] or 1)
            end
        end

        if self.title then
            self.title:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
        end
        if self.vendorLabel then
            self.vendorLabel:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        end
        if self.distanceLabel then
            self.distanceLabel:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
        end
        if self._closeText then
            self._closeText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        end

        if self._closeBtn and self._closeBtn.SetScript then
            self._closeBtn:SetScript("OnEnter", function(btn)
                if HousingTheme and HousingTheme.ApplyBackdrop then
                    HousingTheme:ApplyBackdrop(btn, "button", "bgHover", "statusError")
                else
                    btn:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4] or 1)
                    btn:SetBackdropBorderColor(statusError[1], statusError[2], statusError[3], statusError[4] or 1)
                end
                if self._closeText then
                    self._closeText:SetTextColor(statusError[1], statusError[2], statusError[3], 1)
                end
            end)
            self._closeBtn:SetScript("OnLeave", function(btn)
                if HousingTheme and HousingTheme.ApplyBackdrop then
                    HousingTheme:ApplyBackdrop(btn, "button", "bgTertiary", "borderPrimary")
                end
                if self._closeText then
                    self._closeText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
                end
            end)
        end
    end

    -- Apply themed backdrop
    if HousingTheme then
        HousingTheme:ApplyBackdrop(frame, "mainFrame", "bgPrimary", "borderAccent")
    else
        frame:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            edgeSize = 2,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        frame:SetBackdropColor(0.08, 0.06, 0.12, 0.95)
        frame:SetBackdropBorderColor(0.55, 0.50, 0.75, 1.0)
    end

    -- Title
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -12)
    title:SetText(L["BUTTON_MARK_VENDOR"] or "Mark Vendor")
    if HousingTheme then
        title:SetTextColor(unpack(HousingTheme.Colors.accentPrimary))
    else
        title:SetTextColor(0.55, 0.65, 0.90, 1.0)
    end
    frame.title = title

    -- Vendor name (below title, full width to show complete name)
    local vendorLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    vendorLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    vendorLabel:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -12, -32)  -- Match left margin
    vendorLabel:SetJustifyH("LEFT")
    vendorLabel:SetText("No vendor selected")
    if HousingTheme then
        vendorLabel:SetTextColor(unpack(HousingTheme.Colors.textPrimary))
    else
        vendorLabel:SetTextColor(0.92, 0.90, 0.96, 1.0)
    end
    frame.vendorLabel = vendorLabel

    -- Mark vendor button (on left, since you mark first)
    local markBtn
    if HousingTheme then
        markBtn = HousingTheme:CreateButton(frame, L["BUTTON_MARK_VENDOR"] or "Mark Vendor", 110, 24)
    else
        markBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        markBtn:SetSize(110, 24)
        markBtn:SetText(L["BUTTON_MARK_VENDOR"] or "Mark Vendor")
    end
    markBtn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 10)
    markBtn:SetScript("OnClick", function()
        VendorMarker:MarkVendor(RAID_MARKER.color, "Blue Moon", RAID_MARKER.raidIcon, RAID_MARKER.texture)
    end)
    frame.markBtn = markBtn

    -- Clear marker button (on right, since you clear after marking)
    local clearBtn
    if HousingTheme then
        clearBtn = HousingTheme:CreateButton(frame, "Clear Marker", 110, 24)
    else
        clearBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        clearBtn:SetSize(110, 24)
        clearBtn:SetText("Clear Marker")
    end
    clearBtn:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 10)
    clearBtn:SetScript("OnClick", function()
        VendorMarker:ClearVendorMarker()
    end)
    frame.clearBtn = clearBtn

    -- Distance label (below vendor name)
    local distanceLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    distanceLabel:SetPoint("TOPLEFT", vendorLabel, "BOTTOMLEFT", 0, -4)
    distanceLabel:SetText("Distance: Calculating...")
    if HousingTheme then
        distanceLabel:SetTextColor(unpack(HousingTheme.Colors.textSecondary))
    else
        distanceLabel:SetTextColor(0.7, 0.7, 0.8, 1.0)
    end
    frame.distanceLabel = distanceLabel

    -- Close button (themed to match)
    local closeBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
    closeBtn:SetSize(20, 20)
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -6, -6)

    -- Apply themed backdrop
    if HousingTheme then
        HousingTheme:ApplyBackdrop(closeBtn, "button", "bgTertiary", "borderPrimary")
    else
        closeBtn:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false,
            edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        closeBtn:SetBackdropColor(0.16, 0.12, 0.24, 0.90)
        closeBtn:SetBackdropBorderColor(0.35, 0.30, 0.50, 0.8)
    end

    -- X text
    local closeText = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    closeText:SetPoint("CENTER", 0, 0)
    closeText:SetText(L["BUTTON_CLOSE_X"] or "X")
    if HousingTheme then
        closeText:SetTextColor(unpack(HousingTheme.Colors.textPrimary))
    else
        closeText:SetTextColor(0.92, 0.90, 0.96, 1.0)
    end

    -- Hover effects
    closeBtn:SetScript("OnEnter", function(self)
        if HousingTheme then
            HousingTheme:ApplyBackdrop(self, "button", "bgHover", "statusError")
            closeText:SetTextColor(unpack(HousingTheme.Colors.statusError))
        else
            self:SetBackdropColor(0.22, 0.16, 0.32, 0.95)
            self:SetBackdropBorderColor(0.90, 0.35, 0.40, 1.0)
            closeText:SetTextColor(0.90, 0.35, 0.40, 1.0)
        end
    end)

    closeBtn:SetScript("OnLeave", function(self)
        if HousingTheme then
            HousingTheme:ApplyBackdrop(self, "button", "bgTertiary", "borderPrimary")
            closeText:SetTextColor(unpack(HousingTheme.Colors.textPrimary))
        else
            self:SetBackdropColor(0.16, 0.12, 0.24, 0.90)
            self:SetBackdropBorderColor(0.35, 0.30, 0.50, 0.8)
            closeText:SetTextColor(0.92, 0.90, 0.96, 1.0)
        end
    end)

    closeBtn:SetScript("OnClick", function()
        RemoveTomTomWaypoint()
        frame:Hide()
    end)

    -- Also remove waypoint when frame is hidden by any means
    frame:SetScript("OnHide", function()
        RemoveTomTomWaypoint()
        StopDistanceUpdates()
        StopNameplateTracking()
    end)

    frame._closeBtn = closeBtn
    frame._closeText = closeText
    frame:UpdateTheme()

    markerFrame = frame
    return frame
end

function VendorMarker:ApplyTheme()
    if markerFrame and markerFrame.UpdateTheme then
        markerFrame:UpdateTheme()
    end
end

-- Show the marker UI for a specific vendor
function VendorMarker:ShowForVendor(vendorName, npcID, coords)
    if not IsEnabled() then
        return
    end

    currentVendorName = vendorName
    currentNPCID = tonumber(npcID)
    currentVendorCoords = NormalizeVendorCoords(coords)
    currentOwnsWaypoint = false

    local frame = self:CreateMarkerFrame()
    if frame.vendorLabel then
        frame.vendorLabel:SetText(vendorName or "Unknown Vendor")
    end

    -- Set waypoint for navigation
    if HousingWaypointManager and HousingWaypointManager.SetWaypoint and coords and coords.mapID and coords.x and coords.y then
        local waypointItem = {
            coords = { x = coords.x, y = coords.y, mapID = coords.mapID },
            mapID = coords.mapID,
            vendorName = vendorName,
            npcID = currentNPCID,
        }
        currentOwnsWaypoint = HousingWaypointManager:SetWaypoint(waypointItem) and true or false
    else
        -- Fallback: TomTom-only waypoint if available
        AddTomTomWaypoint(vendorName, coords)
    end

    -- Start nameplate tracking only while the marker UI is open/active.
    StartNameplateTracking()

    -- Start distance updates
    StartDistanceUpdates()

    UpdateDistanceDisplay()
    frame:Show()
end

function VendorMarker:UpdateDistanceDisplay()
    UpdateDistanceDisplay()
end

-- Mark the vendor with a raid icon
function VendorMarker:MarkVendor(color, colorName, raidIcon, texture)
    if not currentNPCID or not IsEnabled() then
        print("|cFFFF0000HousingVendor:|r Cannot mark vendor - no NPC selected")
        return
    end

    local storage = GetMarkerStorage()
    storage[currentNPCID] = {
        npcID = currentNPCID,
        name = currentVendorName,
        color = color,
        colorName = colorName,
        raidIcon = raidIcon,
        texture = texture,
        timestamp = time()
    }

    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info("Marked " .. (currentVendorName or "vendor") .. " with Blue Moon (icon + colored name)")
    end

    -- Refresh all nameplates to apply both raid marker and name color
    self:RefreshNameplates()
end

-- Clear vendor marker
function VendorMarker:ClearVendorMarker()
    if not currentNPCID then
        return
    end

    local storage = GetMarkerStorage()
    storage[currentNPCID] = nil

    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info("Cleared marker from " .. (currentVendorName or "vendor"))
    end

    -- Refresh nameplates
    self:RefreshNameplates()
end

-- Debug: Print frame structure recursively
local function DebugPrintFrameStructure(frame, indent, maxDepth, currentDepth)
    if not frame or currentDepth > maxDepth then return end

    local prefix = string.rep("  ", currentDepth)
    local frameName = frame:GetName() or "Anonymous"
    local frameType = frame:GetObjectType()

    print(prefix .. frameType .. ": " .. frameName)

    -- Print FontString text if applicable
    if frameType == "FontString" then
        local text = frame:GetText()
        if text then
            print(prefix .. "  -> Text: " .. text)
        end
    end

    -- Print regions (textures, fontstrings, etc)
    local regions = {frame:GetRegions()}
    for _, region in ipairs(regions) do
        if region:IsObjectType("FontString") then
            local text = region:GetText()
            local regionName = region:GetName() or "Anonymous FontString"
            if text then
                print(prefix .. "  FontString (" .. regionName .. "): " .. text)
            end
        end
    end

    -- Recurse into children
    local children = {frame:GetChildren()}
    for _, child in ipairs(children) do
        DebugPrintFrameStructure(child, indent, maxDepth, currentDepth + 1)
    end
end

-- Find name text in nameplate (works with various nameplate addons)
local function FindNameText(nameplate, debugMode)
    if not nameplate then return nil end

    -- DEBUG: Print nameplate structure when debugMode is enabled
    if debugMode then
        print("=== NAMEPLATE STRUCTURE DEBUG ===")
        print("Nameplate name: " .. (nameplate:GetName() or "Anonymous"))
        print("Nameplate type: " .. nameplate:GetObjectType())

        -- Check for known addon-specific properties
        print("Has UnitFrame: " .. tostring(nameplate.UnitFrame ~= nil))
        print("Has PlaterNameplate: " .. tostring(nameplate.PlaterNameplate ~= nil))

        -- Print full structure
        DebugPrintFrameStructure(nameplate, "", 5, 0)
        print("=== END DEBUG ===")
    end

    -- Try different common nameplate structures
    local unitFrame = nameplate.UnitFrame or nameplate

    -- Common paths to find name text
    local paths = {
        {path = unitFrame.name, desc = "Blizzard default (unitFrame.name)"},
        {path = unitFrame.healthBar and unitFrame.healthBar.name, desc = "Blizzard default alt (unitFrame.healthBar.name)"},
        {path = unitFrame.NameText, desc = "Generic addon (unitFrame.NameText)"},
        {path = unitFrame.nameText, desc = "Generic addon (unitFrame.nameText)"},
        {path = unitFrame.Name, desc = "Generic addon (unitFrame.Name)"},
        {path = unitFrame.unitFrame and unitFrame.unitFrame.healthBar and unitFrame.unitFrame.healthBar.name, desc = "Plater nested (unitFrame.unitFrame.healthBar.name)"},
        {path = unitFrame.PlaterOnTopFrame and unitFrame.PlaterOnTopFrame.Name, desc = "Plater on-top (unitFrame.PlaterOnTopFrame.Name)"},
    }

    for _, entry in ipairs(paths) do
        if entry.path and entry.path.SetTextColor then
            if debugMode then
                print("FOUND name text via: " .. entry.desc)
            end
            return entry.path
        end
    end

    -- Plater specific: Check for PlaterNameplate
    if nameplate.PlaterNameplate then
        local plater = nameplate.PlaterNameplate
        if debugMode then
            print("Checking PlaterNameplate structure...")
        end
        if plater.unitFrame and plater.unitFrame.healthBar and plater.unitFrame.healthBar.name then
            if debugMode then
                print("FOUND name text via: PlaterNameplate.unitFrame.healthBar.name")
            end
            return plater.unitFrame.healthBar.name
        end
    end

    -- Try to find by searching children recursively (for unknown addon structures)
    local function SearchForNameText(frame, depth)
        if depth > 4 then return nil end -- Limit recursion depth

        local regions = {frame:GetRegions()}
        for _, region in ipairs(regions) do
            if region:IsObjectType("FontString") then
                local text = region:GetText()
                -- Check if this looks like a name (has text and reasonable length)
                if text and #text > 0 and #text < 100 and region.SetTextColor then
                    if debugMode then
                        print("FOUND name text via recursive search at depth " .. depth .. ": " .. text)
                    end
                    return region
                end
            end
        end

        -- Search children
        local children = {frame:GetChildren()}
        for _, child in ipairs(children) do
            local result = SearchForNameText(child, depth + 1)
            if result then return result end
        end

        return nil
    end

    local result = SearchForNameText(unitFrame, 0)
    if debugMode and not result then
        print("WARNING: Could not find name text in nameplate!")
    end
    return result
end

-- Apply highlight to a nameplate
local function ApplyNameplateHighlight(nameplate, npcID, enableDebug, hasRaidIcon)
    if not nameplate then return end

    local storage = GetMarkerStorage()
    local markerData = storage[npcID]

    -- Get the actual nameplate frame (UnitFrame)
    local unitFrame = nameplate.UnitFrame or nameplate

    -- Find the name text on the nameplate
    local nameText = FindNameText(nameplate, enableDebug or debugMode)

    -- Remove existing raid icon
    if unitFrame.HousingVendorRaidIcon then
        unitFrame.HousingVendorRaidIcon:Hide()
        unitFrame.HousingVendorRaidIcon = nil
    end

    -- Store original color if not already stored
    if nameText and not nameText.HousingVendorOriginalColor then
        local r, g, b, a = nameText:GetTextColor()
        nameText.HousingVendorOriginalColor = {r, g, b, a}
    end

    -- Apply or restore color and custom icon
    if markerData and markerData.color and nameText then
        -- Apply marker color to name text
        nameText:SetTextColor(markerData.color[1], markerData.color[2], markerData.color[3], 1)
        nameText.HousingVendorMarked = true

        -- Add custom icon above nameplate
        if markerData.texture and not unitFrame.HousingVendorRaidIcon then
            local icon = unitFrame:CreateTexture(nil, "OVERLAY")
            icon:SetSize(24, 24)
            icon:SetPoint("BOTTOM", unitFrame, "TOP", 0, 5)
            icon:SetTexture(markerData.texture)
            unitFrame.HousingVendorRaidIcon = icon
        end
    elseif nameText and nameText.HousingVendorOriginalColor and nameText.HousingVendorMarked then
        -- Restore original color
        local orig = nameText.HousingVendorOriginalColor
        nameText:SetTextColor(orig[1], orig[2], orig[3], orig[4])
        nameText.HousingVendorMarked = false
    end
end

-- Note: SetRaidTarget is a protected function and cannot be called by addons.
-- We use custom texture overlays instead (see ApplyNameplateHighlight).

-- Nameplate callback
local function OnNameplateAdded(unit)
    if not IsEnabled() then return end

    local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
    if not nameplate then return end

    local guid = UnitGUID(unit)
    if not guid then return end

    local unitType, _, _, _, _, npcID = strsplit("-", guid)
    npcID = tonumber(npcID)

    if unitType == "Creature" and npcID then
        nameplateFrames[unit] = npcID  -- Store unit token instead of nameplate frame

        -- Check if this NPC should be marked
        local storage = GetMarkerStorage()
        local markerData = storage[npcID]
        if markerData then
            -- Apply name color highlighting and custom icon overlay
            ApplyNameplateHighlight(nameplate, npcID, nil, false)
        end
    end
end

local function OnNameplateRemoved(unit)
    nameplateFrames[unit] = nil
end

StopNameplateTracking = function()
    if not nameplateEventFrame then
        return
    end

    -- Best-effort: restore any visible nameplates we touched.
    for unit, npcID in pairs(nameplateFrames) do
        local nameplate = C_NamePlate and C_NamePlate.GetNamePlateForUnit and C_NamePlate.GetNamePlateForUnit(unit) or nil
        if nameplate then
            ApplyNameplateHighlight(nameplate, npcID, nil, false)
        end
    end

    if nameplateEventFrame.UnregisterAllEvents then
        nameplateEventFrame:UnregisterAllEvents()
    end
    if nameplateEventFrame.SetScript then
        nameplateEventFrame:SetScript("OnEvent", nil)
    end
    nameplateEventFrame = nil

    nameplateFrames = {}
end

StartNameplateTracking = function()
    if nameplateEventFrame then
        return
    end
    if not IsEnabled() then
        return
    end

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    frame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

    frame:SetScript("OnEvent", function(_, event, unit)
        if event == "NAME_PLATE_UNIT_ADDED" then
            OnNameplateAdded(unit)
        elseif event == "NAME_PLATE_UNIT_REMOVED" then
            OnNameplateRemoved(unit)
        end
    end)

    nameplateEventFrame = frame
end

-- Refresh all visible nameplates
function VendorMarker:RefreshNameplates()
    for unit, npcID in pairs(nameplateFrames) do
        local storage = GetMarkerStorage()
        local markerData = storage[npcID]
        local nameplate = C_NamePlate.GetNamePlateForUnit(unit)

        if nameplate then
            -- Apply or remove name color highlighting and custom icon overlay
            ApplyNameplateHighlight(nameplate, npcID, nil, false)
        end
    end
end

-- Initialize nameplate tracking
function VendorMarker:Initialize()
    StartNameplateTracking()
end

function VendorMarker:StopNameplateTracking()
    StopNameplateTracking()
end

-- Toggle debug mode
function VendorMarker:ToggleDebug()
    debugMode = not debugMode
    if debugMode then
        print("|cFF8A7FD4HousingVendor:|r Nameplate debug mode ENABLED - next nameplate added will print structure")
    else
        print("|cFF8A7FD4HousingVendor:|r Nameplate debug mode DISABLED")
    end
    return debugMode
end

-- Debug a specific nameplate now
function VendorMarker:DebugCurrentNameplate()
    -- Find any visible unit to debug
    for unit, npcID in pairs(nameplateFrames) do
        print("|cFF8A7FD4HousingVendor:|r Debugging unit: " .. tostring(unit) .. " (NPC ID: " .. tostring(npcID) .. ")")

        -- Get nameplate for debug structure printing
        local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
        if nameplate then
            FindNameText(nameplate, true)  -- This will print the debug structure
        end

        -- Show marker status
        local storage = GetMarkerStorage()
        local markerData = storage[npcID]
        print("Has HousingVendor marker: " .. tostring(markerData ~= nil))

        return
    end
    print("|cFF8A7FD4HousingVendor:|r No nameplates currently visible")
end

-- Export
_G.HousingVendorMarker = VendorMarker

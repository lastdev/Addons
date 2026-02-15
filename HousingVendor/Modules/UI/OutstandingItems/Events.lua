local _G = _G
local OutstandingItemsUI = _G["HousingOutstandingItemsUI"]
if not OutstandingItemsUI then
    -- This should never happen - OutstandingItemsUI.lua loads before this file
    return
end

-- Validate C_Timer exists (should always be available in retail WoW)
if not C_Timer or not C_Timer.After then
    return
end

local function IsInNonWorldInstance()
    if not IsInInstance then return false end
    local inInstance, instanceType = IsInInstance()
    if inInstance and C_Map and C_Map.GetBestMapForUnit then
        local mapID = C_Map.GetBestMapForUnit("player")
        if mapID == 2351 or mapID == 2352 then
            return false
        end
    end
    return inInstance and instanceType and instanceType ~= "none"
end

local function HidePopupIfShown()
    local popupFrame = OutstandingItemsUI._popupFrame
    if popupFrame and popupFrame.IsShown and popupFrame:IsShown() then
        popupFrame:Hide()
    end
end

-- Get current zone information with fallbacks
function OutstandingItemsUI:GetCurrentZone()
    -- First try C_Map API (most reliable)
    if C_Map and C_Map.GetBestMapForUnit then
        local mapID = C_Map.GetBestMapForUnit("player")
        if mapID then
            local mapInfo = C_Map.GetMapInfo(mapID)
            if mapInfo and mapInfo.name then
                return mapID, mapInfo.name
            end
        end
    end
    
    -- Fallback to GetRealZoneText
    if GetRealZoneText then
        local zoneName = GetRealZoneText()
        if zoneName and zoneName ~= "" then
            return nil, zoneName
        end
    end
    
    -- Last resort: GetZoneText
    if GetZoneText then
        local zoneName = GetZoneText()
        if zoneName and zoneName ~= "" then
            return nil, zoneName
        end
    end
    
    return nil, nil
end

local function EnsureEventFrame()
    local eventFrame = OutstandingItemsUI._eventFrame
    if not eventFrame then
        eventFrame = CreateFrame("Frame")
        OutstandingItemsUI._eventFrame = eventFrame
        OutstandingItemsUI._zoneCheckToken = 0
        OutstandingItemsUI._zoneCheckInFlight = false

        eventFrame:SetScript("OnEvent", function(_, event)
            if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_DIFFICULTY_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "LOADING_SCREEN_DISABLED" then
                if IsInNonWorldInstance() then
                    HidePopupIfShown()
                    return
                end
            end
            -- Debounce zone checks and avoid repeated retry loops (keeps idle CPU near-zero).
            OutstandingItemsUI._zoneCheckToken = (tonumber(OutstandingItemsUI._zoneCheckToken) or 0) + 1
            local token = OutstandingItemsUI._zoneCheckToken

            -- Use longer delays for events that commonly happen during/after loading screens (hearth/portals).
            local delay = 0.2
            if event == "PLAYER_ENTERING_WORLD" then
                delay = 1.0
            elseif event == "LOADING_SCREEN_DISABLED" then
                delay = 0.4
            elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_DIFFICULTY_CHANGED" then
                delay = 0.6
            end

            C_Timer.After(delay, function()
                if token ~= OutstandingItemsUI._zoneCheckToken then
                    return
                end
                if OutstandingItemsUI._zoneCheckInFlight then
                    return
                end
                OutstandingItemsUI._zoneCheckInFlight = true

                local function Done()
                    OutstandingItemsUI._zoneCheckInFlight = false
                end

                local function RunZoneCheckWithRetries()
                    local attempts = 0
                    local maxAttempts = 6
                    local retryDelay = 0.5

                    local function Attempt()
                        if token ~= OutstandingItemsUI._zoneCheckToken then
                            Done()
                            return
                        end

                        attempts = attempts + 1
                        local mapID, zoneName = OutstandingItemsUI:GetCurrentZone()
                        if (not mapID and not zoneName) and attempts < maxAttempts then
                            C_Timer.After(retryDelay, Attempt)
                            return
                        end

                        -- Check if OnZoneChanged method exists
                        if OutstandingItemsUI.OnZoneChanged then
                            OutstandingItemsUI:OnZoneChanged()
                        end
                        Done()
                    end

                    Attempt()
                end

                if HousingDataLoader and HousingDataLoader.EnsureDataLoaded then
                    HousingDataLoader:EnsureDataLoaded(function()
                        if token ~= OutstandingItemsUI._zoneCheckToken then
                            Done()
                            return
                        end
                        RunZoneCheckWithRetries()
                    end)
                else
                    RunZoneCheckWithRetries()
                end
            end)
        end)
    end
    return eventFrame
end

function OutstandingItemsUI:OnZoneChanged()
    if IsInNonWorldInstance() then
        HidePopupIfShown()
        return
    end

    local mapID, zoneName = self:GetCurrentZone()
    local zoneKey = mapID or zoneName

    if not zoneKey then
        return
    end

    local isNewZone = (zoneKey ~= self._currentZoneKey)
    self._currentZoneKey = zoneKey
    
    -- For permanent popup mode, we want to show the popup even if we're in the same zone
    -- BUT only if it's not already visible (prevents constant rebuilding on every zone event)
    local shouldShowPopup = isNewZone
    if HousingDB and HousingDB.settings and HousingDB.settings.permanentZonePopup then
        if isNewZone or not (self._popupFrame and self._popupFrame:IsShown()) then
            shouldShowPopup = true
        end
    end
    
    if not shouldShowPopup then
        return
    end

    if HousingDB and HousingDB.settings and HousingDB.settings.autoFilterByZone then
        if zoneName and HousingFilters and HousingFilters.SetZoneFilter then
            HousingFilters:SetZoneFilter(zoneName, mapID)
        end
    end

    if HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup then
        local shouldShowZonePopup = true
        
        -- For permanent mode, only rebuild if zone changed or popup is not visible
        if not (HousingDB.settings.permanentZonePopup) then
            shouldShowZonePopup = (zoneKey ~= self._lastPopupZoneKey)
        else
            shouldShowZonePopup = isNewZone or not (self._popupFrame and self._popupFrame:IsShown())
        end
        
        if shouldShowZonePopup then
            -- Wait 1 second for data to load, then show popup
            -- NOTE: GetOutstandingItemsForZone handles API safety internally with canCheckCollection flag
            -- When APIs aren't ready, it treats all items as uncollected but still shows vendors
            C_Timer.After(1, function()
                -- Check if the method exists (defensive programming)
                if not self.GetOutstandingItemsForZone then
                    if _G.HousingVendorLog and _G.HousingVendorLog.Warn then
                        _G.HousingVendorLog:Warn("GetOutstandingItemsForZone method not available yet")
                    end
                    return
                end
                
                local outstanding = self:GetOutstandingItemsForZone(mapID, zoneName)
                if outstanding and outstanding.total and outstanding.total > 0 then
                    self._lastPopupZoneKey = zoneKey
                    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
                        _G.HousingVendorLog:Info("Found " .. outstanding.total .. " uncollected items in " .. (zoneName or "this zone"))
                    end
                    self:ShowPopup(zoneName or "Current Zone", outstanding)
                end
            end)
        end
    end
end

function OutstandingItemsUI:StartEventHandlers()
    local frame = EnsureEventFrame()
    if not frame then
        print("|cFFFF4040HousingVendor:|r Failed to create event frame for zone popup")
        return
    end
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    frame:RegisterEvent("LOADING_SCREEN_DISABLED")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")

    -- Mark that events are registered for diagnostic purposes
    self._eventsRegistered = true

    if not self._initialZoneCheckScheduled then
        self._initialZoneCheckScheduled = true
        C_Timer.After(1, function()
            if HousingDataLoader and HousingDataLoader.EnsureDataLoaded then
                HousingDataLoader:EnsureDataLoaded(function()
                    OutstandingItemsUI:OnZoneChanged()
                end)
            else
                OutstandingItemsUI:OnZoneChanged()
            end
        end)
    end

    if not self._initialZoneRetryScheduled then
        self._initialZoneRetryScheduled = true
        C_Timer.After(5, function()
            if HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup then
                OutstandingItemsUI:OnZoneChanged()
            end
        end)
    end
end

function OutstandingItemsUI:StopEventHandlers()
    local frame = self._eventFrame
    if frame then
        frame:UnregisterAllEvents()
    end
    self._initialZoneCheckScheduled = nil
    self._initialZoneRetryScheduled = nil
end

-- Verify the function was added successfully
if not OutstandingItemsUI.StartEventHandlers then
    print("|cFFFF4040HousingVendor:|r CRITICAL: StartEventHandlers not defined after Events.lua loaded!")
end

return OutstandingItemsUI

-- OutstandingItems Sub-module: Event handling
-- Part of HousingOutstandingItemsUI

local _G = _G
local OutstandingItemsUI = _G["HousingOutstandingItemsUI"]
if not OutstandingItemsUI then return end

local function IsInNonWorldInstance()
    if not IsInInstance then return false end
    local inInstance, instanceType = IsInInstance()
    return inInstance and instanceType and instanceType ~= "none"
end

local function HidePopupIfShown()
    local popupFrame = OutstandingItemsUI._popupFrame
    if popupFrame and popupFrame.IsShown and popupFrame:IsShown() then
        popupFrame:Hide()
    end
end

local function EnsureEventFrame()
    local eventFrame = OutstandingItemsUI._eventFrame
    if not eventFrame then
        eventFrame = CreateFrame("Frame")
        OutstandingItemsUI._eventFrame = eventFrame
        OutstandingItemsUI._zoneCheckToken = 0
        OutstandingItemsUI._zoneCheckInFlight = false

        eventFrame:SetScript("OnEvent", function(_, event)
            if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_DIFFICULTY_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
                if IsInNonWorldInstance() then
                    HidePopupIfShown()
                    return
                end
            end
            -- Debounce zone checks and avoid repeated retry loops (keeps idle CPU near-zero).
            OutstandingItemsUI._zoneCheckToken = (tonumber(OutstandingItemsUI._zoneCheckToken) or 0) + 1
            local token = OutstandingItemsUI._zoneCheckToken

            -- TAINT FIX: Use longer delay for PLAYER_ENTERING_WORLD to allow Housing APIs to initialize
            local delay = (event == "PLAYER_ENTERING_WORLD") and 4 or 0.6
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

                if HousingDataLoader and HousingDataLoader.EnsureDataLoaded then
                    HousingDataLoader:EnsureDataLoaded(function()
                        if token ~= OutstandingItemsUI._zoneCheckToken then
                            Done()
                            return
                        end
                        OutstandingItemsUI:OnZoneChanged()
                        Done()
                    end)
                else
                    OutstandingItemsUI:OnZoneChanged()
                    Done()
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

    if zoneKey == self._currentZoneKey then
        return
    end

    self._currentZoneKey = zoneKey

    if HousingDB and HousingDB.settings and HousingDB.settings.autoFilterByZone then
        if zoneName and HousingFilters and HousingFilters.SetZoneFilter then
            HousingFilters:SetZoneFilter(zoneName, mapID)
        end
    end

    if HousingDB and HousingDB.settings and HousingDB.settings.showOutstandingPopup then
        if zoneKey ~= self._lastPopupZoneKey then
            -- Wait 1 second for collection APIs to fully load
            C_Timer.After(1, function()
                local outstanding = self:GetOutstandingItemsForZone(mapID, zoneName)
                if outstanding and outstanding.total and outstanding.total > 0 then
                    self._lastPopupZoneKey = zoneKey
                    print("|cFF8A7FD4HousingVendor:|r Found " .. outstanding.total .. " uncollected items in " .. (zoneName or "this zone"))
                    self:ShowPopup(zoneName or "Current Zone", outstanding)
                end
            end)
        end
    end
end

function OutstandingItemsUI:StartEventHandlers()
    local frame = EnsureEventFrame()
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
end

function OutstandingItemsUI:StopEventHandlers()
    local frame = self._eventFrame
    if frame then
        frame:UnregisterAllEvents()
    end
end

return OutstandingItemsUI

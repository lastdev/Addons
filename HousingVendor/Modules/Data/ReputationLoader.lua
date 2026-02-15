-- Reputation Data Loader
-- Builds lookup tables for reputation/renown-gated items.

local ReputationLoader = {}

-- Public global: itemID -> rep info
_G.HousingVendorItemToFaction = _G.HousingVendorItemToFaction or {}

local function NormalizeLabel(s)
    if not s or s == "" then return nil end
    s = tostring(s)
    s = s:lower()
    s = s:gsub("|c%x%x%x%x%x%x%x%x", "")
    s = s:gsub("|r", "")
    s = s:gsub("|H[^|]*|h", "")
    s = s:gsub("|h", "")
    s = s:gsub("%s+", " ")
    s = s:match("^%s*(.-)%s*$")
    if not s or s == "" then return nil end
    return s
end

local function BuildLabelToFactionID()
    local map = {}
    local repData = _G.HousingReputationData or _G.HousingReputations
    if type(repData) ~= "table" then
        return map
    end

    for factionID, cfg in pairs(repData) do
        if type(cfg) == "table" then
            local label = cfg.label
            local key = NormalizeLabel(label)
            if key then
                map[key] = tostring(cfg.factionID or factionID)
            end
        end
    end

    return map
end

function ReputationLoader:Rebuild()
    local out = {}
    local labelToFactionID = BuildLabelToFactionID()

    -- 1) Legacy path: HousingReputations (if present)
    if _G.HousingReputations then
        for factionID, factionData in pairs(_G.HousingReputations) do
            if factionData and factionData.rewards then
                for _, reward in ipairs(factionData.rewards) do
                    if reward and reward.itemID then
                        out[reward.itemID] = {
                            factionID = factionID,
                            requiredStanding = reward.requiredStanding,
                            faction = factionData.faction,
                            rep = factionData.rep,
                            vendorName = factionData.vendorName,  -- ADD VENDOR NAME for search
                            zoneName = factionData.zone,  -- ADD ZONE NAME for search
                        }
                    end
                end
            end
        end
    end

    -- 2) Current data path: HousingExpansionData vendorDetails (factionID/reputation fields)
    if _G.HousingExpansionData then
        for itemID, itemSources in pairs(_G.HousingExpansionData) do
            local vendorData = itemSources and itemSources.vendor or nil
            local vd = vendorData and vendorData.vendorDetails or nil

            -- NEW FORMAT: Check for factionName/reputationLevel/renownLevel directly on vendor item
            local factionNameNew = vendorData and vendorData.factionName
            local reputationLevelNew = vendorData and vendorData.reputationLevel
            local renownLevelNew = vendorData and vendorData.renownLevel

            -- Determine required standing from new format
            local requiredStanding = nil
            local factionName = nil

            if renownLevelNew and renownLevelNew > 0 then
                -- New format: renownLevel is a number > 0
                requiredStanding = "Renown " .. tostring(renownLevelNew)
                factionName = (factionNameNew and factionNameNew ~= "" and factionNameNew ~= "None") and factionNameNew or nil
            elseif reputationLevelNew and reputationLevelNew ~= "" and reputationLevelNew ~= "None" then
                -- New format: reputationLevel is a string like "Friendly", "Honored", etc.
                requiredStanding = reputationLevelNew
                factionName = (factionNameNew and factionNameNew ~= "" and factionNameNew ~= "None") and factionNameNew or nil
            elseif vd then
                -- Legacy format: vendorDetails.reputation
                requiredStanding = (vd.reputation and vd.reputation ~= "None" and vd.reputation ~= "") and vd.reputation or nil
                factionName = (vd.factionName and vd.factionName ~= "None" and vd.factionName ~= "") and vd.factionName or nil
            end

            -- Store reputation requirement even if we can't resolve factionID
            -- This allows the UI to at least display the requirement text
            if requiredStanding then
                local factionID = nil

                -- Try to get factionID from vendorDetails first (legacy)
                if vd and vd.factionID and vd.factionID ~= "None" and vd.factionID ~= "" then
                    factionID = tostring(vd.factionID)
                end

                -- If no factionID, look up by name
                if not factionID and factionName then
                    local key = NormalizeLabel(factionName)
                    factionID = key and labelToFactionID[key] or nil

                    -- Fallback: optional name -> ID map (Data/FactionIDs.lua)
                    if not factionID and key then
                        if _G.HousingVendorFactionIDsNormalized and _G.HousingVendorFactionIDsNormalized[key] then
                            factionID = tostring(_G.HousingVendorFactionIDsNormalized[key])
                        elseif _G.HousingVendorFactionIDs and factionName and _G.HousingVendorFactionIDs[factionName] then
                            factionID = tostring(_G.HousingVendorFactionIDs[factionName])
                        end
                    end
                end

                local numericFactionID = factionID and tonumber(factionID) or nil
                local repType = nil

                -- If the requirement string says "Renown X", treat as renown.
                if requiredStanding:lower():find("renown", 1, true) then
                    repType = "renown"
                end

                -- Try HousingReputationData first, then fall back to HousingReputations
                if not repType and factionID then
                    if _G.HousingReputationData and _G.HousingReputationData[factionID] then
                        repType = _G.HousingReputationData[factionID].rep
                    elseif _G.HousingReputations and _G.HousingReputations[factionID] then
                        repType = _G.HousingReputations[factionID].rep
                    elseif numericFactionID and _G.HousingReputations and _G.HousingReputations[numericFactionID] then
                        repType = _G.HousingReputations[numericFactionID].rep
                    end
                end

                -- Default repType based on requirement string if we couldn't determine it
                if not repType then
                    if requiredStanding:lower():find("renown", 1, true) then
                        repType = "renown"
                    else
                        repType = "standard"
                    end
                end

                -- Try to get vendor name from HousingReputations data
                local vendorName = nil
                local zoneName = nil
                if numericFactionID and _G.HousingReputations and _G.HousingReputations[numericFactionID] then
                    vendorName = _G.HousingReputations[numericFactionID].vendorName
                    zoneName = _G.HousingReputations[numericFactionID].zone
                elseif factionID and _G.HousingReputations and _G.HousingReputations[factionID] then
                    vendorName = _G.HousingReputations[factionID].vendorName
                    zoneName = _G.HousingReputations[factionID].zone
                end

                -- Prefer vendorDetails if present (works with vendorId-based reputation data)
                if not vendorName and vd and vd.vendorName and vd.vendorName ~= "" and vd.vendorName ~= "None" then
                    vendorName = vd.vendorName
                end
                if not zoneName and vd and vd.location and vd.location ~= "" and vd.location ~= "None" then
                    zoneName = vd.location
                end

                out[itemID] = {
                    factionID = factionID and tostring(factionID) or nil,
                    requiredStanding = requiredStanding,
                    faction = factionName,
                    rep = repType,
                    vendorName = vendorName,  -- ADD VENDOR NAME for search
                    zoneName = zoneName,  -- ADD ZONE NAME for search
                }
            end
        end
    end

    _G.HousingVendorItemToFaction = out
    return out
end

-- Build once at login if data is already present; otherwise DataLoader will call Rebuild after loading data.
pcall(function()
    if _G.HousingAllItems and next(_G.HousingAllItems) ~= nil then
        ReputationLoader:Rebuild()
    end
end)

_G.HousingReputationLoader = ReputationLoader
return ReputationLoader

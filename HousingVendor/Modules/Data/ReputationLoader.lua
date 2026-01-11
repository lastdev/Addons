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
                        }
                    end
                end
            end
        end
    end

    -- 2) Current data path: HousingExpansionData vendorDetails (factionID/reputation fields)
    if _G.HousingExpansionData then
        for itemID, itemSources in pairs(_G.HousingExpansionData) do
            local vd = itemSources and itemSources.vendor and itemSources.vendor.vendorDetails or nil
            if vd then
                local requiredStanding = (vd.reputation and vd.reputation ~= "None" and vd.reputation ~= "") and vd.reputation or nil
                if requiredStanding then
                    local factionID = nil
                    if vd.factionID and vd.factionID ~= "None" and vd.factionID ~= "" then
                        factionID = tostring(vd.factionID)
                    else
                        local key = NormalizeLabel(vd.factionName)
                        factionID = key and labelToFactionID[key] or nil

                        -- Fallback: optional name -> ID map (Data/FactionIDs.lua)
                        if not factionID and key then
                            if _G.HousingVendorFactionIDsNormalized and _G.HousingVendorFactionIDsNormalized[key] then
                                factionID = tostring(_G.HousingVendorFactionIDsNormalized[key])
                            elseif _G.HousingVendorFactionIDs and vd.factionName and _G.HousingVendorFactionIDs[vd.factionName] then
                                factionID = tostring(_G.HousingVendorFactionIDs[vd.factionName])
                            end
                        end
                    end

                    if factionID then
                        local numericFactionID = tonumber(factionID)
                        local repType = nil

                        -- If the requirement string says "Renown X", treat as renown.
                        if requiredStanding:lower():find("renown", 1, true) then
                            repType = "renown"
                        end

                        -- Try HousingReputationData first, then fall back to HousingReputations
                        if not repType then
                            if _G.HousingReputationData and _G.HousingReputationData[factionID] then
                                repType = _G.HousingReputationData[factionID].rep
                            elseif _G.HousingReputations and _G.HousingReputations[factionID] then
                                repType = _G.HousingReputations[factionID].rep
                            elseif numericFactionID and _G.HousingReputations and _G.HousingReputations[numericFactionID] then
                                repType = _G.HousingReputations[numericFactionID].rep
                            end
                        end

                        out[itemID] = {
                            factionID = tostring(factionID),
                            requiredStanding = requiredStanding,
                            faction = (vd.factionName and vd.factionName ~= "None" and vd.factionName ~= "") and vd.factionName or nil,
                            rep = repType,
                        }
                    end
                end
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

-- VendorCostResolver.lua
-- Shared vendor + cost resolution used by both Full UI and Compact UI.

local ADDON_NAME, ns = ...

local VendorCostResolver = {}
VendorCostResolver.__index = VendorCostResolver

local _G = _G
local tonumber = tonumber
local tostring = tostring
local string_format = string.format

local function GetFormatter()
    return ns.CostFormatter or _G.HousingCostFormatter
end

local function GetCatalogData(itemID, opts)
    if opts and opts.catalogData ~= nil then
        return opts.catalogData
    end
    if _G.HousingAPICache and _G.HousingAPICache.GetCatalogData then
        return _G.HousingAPICache:GetCatalogData(itemID)
    end
    if _G.HousingAPI and _G.HousingAPI.GetCatalogData then
        return _G.HousingAPI:GetCatalogData(itemID)
    end
    return nil
end

local function GetVendorInfoFromDecorID(decorID)
    if _G.HousingAPICache and _G.HousingAPICache.GetVendorInfo then
        return _G.HousingAPICache:GetVendorInfo(decorID)
    end
    if _G.HousingAPI and _G.HousingAPI.GetDecorVendorInfo then
        return _G.HousingAPI:GetDecorVendorInfo(decorID)
    end
    return nil
end

function VendorCostResolver:Resolve(item, itemID, opts)
    local id = tonumber(itemID) or (item and tonumber(item.itemID)) or nil
    if not id then
        return nil
    end

    local formatter = GetFormatter()
    if not formatter then
        return {
            vendorName = nil,
            costText = nil,
            costSource = nil,
        }
    end

    local filterVendor = opts and opts.filterVendor or nil
    local catalogData = GetCatalogData(id, opts)

    -- Vendor name resolution (same priority as Full UI).
    local vendorName = nil
    if _G.HousingVendorHelper and _G.HousingVendorHelper.GetVendorName then
        vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor)
    else
        vendorName = item and (item.vendorName or item._apiVendor) or nil
    end
    if (not vendorName or vendorName == "") and catalogData and catalogData.vendor and catalogData.vendor ~= "" then
        vendorName = catalogData.vendor
    end

    -- Cost resolution (same sources as Full UI, but UI-agnostic).
    local costText = nil
    local costSource = nil

    if item and item.cost and item.cost ~= "" then
        costText = formatter:ApplyStaticCostIcons(item.cost, item._staticCostComponents)
        costSource = "static"
    end

    if (not costText or costText == "") and catalogData and catalogData.cost and catalogData.cost ~= "" then
        if formatter.PersistCatalogCost then
            formatter:PersistCatalogCost(id, catalogData.cost)
        end
        costText = formatter:ApplyStaticCostIcons(catalogData.cost, item and item._staticCostComponents)
        costSource = "catalog"
    end

    -- Prefer the most complete cost string (e.g. combined gold + currencies from HousingCostData)
    -- before falling back to enrichment/legacy vendor sources.
    if (not costText or costText == "") and formatter.GetBestCostText then
        local best = formatter:GetBestCostText(item, id)
        if best and best ~= "" then
            costText = best
            costSource = "best"
        end
    end

    if (not costText or costText == "") and _G.HousingDataEnrichment and _G.HousingDataEnrichment.GetVendorInfo then
        local enrichedVendors = _G.HousingDataEnrichment:GetVendorInfo(id)
        if enrichedVendors and #enrichedVendors > 0 then
            local v = enrichedVendors[1]
            if (not vendorName or vendorName == "") and v and v.name and v.name ~= "" then
                vendorName = v.name
            end
            if v and v.price and v.currency and v.price > 0 then
                local raw = (v.currency == "Gold")
                    and string_format("%dgold", v.price)
                    or string_format("%d %s", v.price, tostring(v.currency))
                costText = formatter.ApplyStaticCostIcons and formatter:ApplyStaticCostIcons(raw, item and item._staticCostComponents) or raw
                costSource = "vendor"
            end
        end
    end

    if (not costText or costText == "") and _G.HousingAPI and _G.HousingAPI.GetDecorItemInfoFromItemID then
        local baseInfo = _G.HousingAPI:GetDecorItemInfoFromItemID(id)
        if baseInfo and baseInfo.decorID then
            local vendorInfo = GetVendorInfoFromDecorID(baseInfo.decorID)
            local formatted = formatter.FormatCostFromVendorInfo and formatter:FormatCostFromVendorInfo(vendorInfo) or nil
            if formatted and formatted ~= "" then
                costText = formatted
                costSource = "vendor"
            end
        end
    end

    -- Final fallback: defer to CostFormatter (covers buyPriceCopper, persisted cache, etc).
    if (not costText or costText == "") and formatter.GetBestCostText then
        costText = formatter:GetBestCostText(item, id)
        costSource = costText and (costSource or "best") or costSource
    end

    return {
        vendorName = vendorName,
        costText = costText,
        costSource = costSource,
    }
end

ns.VendorCostResolver = setmetatable({}, VendorCostResolver)
_G.HousingVendorCostResolver = ns.VendorCostResolver

return ns.VendorCostResolver

-- VendorPriceAPI.lua
-- Tracks vendor buy prices for known vendor reagents and caches them in SavedVariables.

local VendorPriceAPI = {}
VendorPriceAPI.__index = VendorPriceAPI

local _G = _G
local CreateFrame = CreateFrame
local pairs = pairs
local tonumber = tonumber
local type = type

local function EnsureCache()
    if not _G.HousingDB then
        _G.HousingDB = {}
    end
    _G.HousingDB.vendorPriceCache = _G.HousingDB.vendorPriceCache or {}
    local cache = _G.HousingDB.vendorPriceCache
    cache.items = cache.items or {}
    cache.updatedAt = cache.updatedAt or 0
    return cache
end

local function GetVendorSourceMap()
    local raw = _G.HousingRawMats
    if type(raw) ~= "table" then
        return nil
    end
    return raw.REAGENT_SOURCES
end

local function IsVendorReagent(itemID)
    local map = GetVendorSourceMap()
    if type(map) ~= "table" then
        return false
    end
    return map[tonumber(itemID)] == "vendor"
end

local function GetBaseVendorPrice(itemID)
    local raw = _G.HousingRawMats
    if type(raw) ~= "table" then
        return nil
    end
    local base = raw.VENDOR_BASE_PRICES
    if type(base) ~= "table" then
        return nil
    end
    local p = tonumber(base[tonumber(itemID)])
    if p and p > 0 then
        return p
    end
    return nil
end

function VendorPriceAPI:GetCachedVendorPrice(itemID)
    local id = tonumber(itemID)
    if not id then
        return nil, nil
    end
    local cache = EnsureCache()
    local price = cache.items and cache.items[id] or nil
    price = tonumber(price)
    if price and price > 0 then
        return price, cache.updatedAt
    end
    return nil, cache.updatedAt
end

-- Returns priceCopper, source ("cache"|"base"|nil)
function VendorPriceAPI:GetVendorPrice(itemID)
    local id = tonumber(itemID)
    if not id then
        return nil, nil
    end
    local cached = self.GetCachedVendorPrice and select(1, self:GetCachedVendorPrice(id)) or nil
    if cached then
        return cached, "cache"
    end
    local base = GetBaseVendorPrice(id)
    if base then
        return base, "base"
    end
    return nil, nil
end

function VendorPriceAPI:Initialize()
    if self._initialized then
        return
    end
    EnsureCache()
    self._listeners = {}

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("MERCHANT_SHOW")
    frame:RegisterEvent("MERCHANT_UPDATE")
    frame:SetScript("OnEvent", function(_, event)
        if event == "MERCHANT_SHOW" or event == "MERCHANT_UPDATE" then
            self:ScanMerchant()
        end
    end)
    self._eventFrame = frame
    self._initialized = true
end

function VendorPriceAPI:RegisterListener(key, callback)
    if not key then return end
    self:Initialize()
    if callback == nil then
        self._listeners[key] = nil
        return
    end
    self._listeners[key] = callback
end

function VendorPriceAPI:NotifyListeners(event, ...)
    if not self._listeners then
        return
    end
    for _, fn in pairs(self._listeners) do
        if type(fn) == "function" then
            pcall(fn, event, ...)
        end
    end
end

function VendorPriceAPI:ScanMerchant()
    self:Initialize()

    if not (_G.MerchantFrame and _G.MerchantFrame:IsShown()) then
        return
    end
    if not (_G.GetMerchantNumItems and _G.GetMerchantItemInfo) then
        return
    end

    local cache = EnsureCache()
    local any = false
    local now = _G.time and _G.time() or 0

    local n = _G.GetMerchantNumItems() or 0
    for i = 1, n do
        local _, _, price, _, _, _, extendedCost = _G.GetMerchantItemInfo(i)
        if extendedCost ~= true then
            local link = _G.GetMerchantItemLink and _G.GetMerchantItemLink(i) or nil
            local id = link and link:match("item:(%d+)")
            id = id and tonumber(id) or nil
            price = tonumber(price)
            if id and price and price > 0 and IsVendorReagent(id) then
                if cache.items[id] ~= price then
                    cache.items[id] = price
                    any = true
                end
            end
        end
    end

    if any then
        cache.updatedAt = now
        self:NotifyListeners("vendor_price_updated", now)
    end
end

_G.HousingVendorPriceAPI = VendorPriceAPI
return VendorPriceAPI


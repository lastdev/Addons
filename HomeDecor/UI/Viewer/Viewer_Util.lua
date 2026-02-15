local ADDON, NS = ...
NS.UI = NS.UI or {}
local View = NS.UI.Viewer
local Util = View.Util

function Util.DB()
    return NS.db and NS.db.profile
end

function Util.Trim(s)
    if type(s) ~= "string" then return "" end
    return (s:gsub("^%s+",""):gsub("%s+$",""))
end

function Util.CopyShallow(t)
    local o = {}
    if type(t) == "table" then
        for k,v in pairs(t) do o[k]=v end
    end
    return o
end

function Util.Clamp(v, lo, hi)
    if v < lo then return lo end
    if v > hi then return hi end
    return v
end

function Util.ClampScroll(sf, content, desired)
    if not sf or not content then return 0 end
    local viewH = sf:GetHeight() or 0
    local maxScroll = math.max(0, (content:GetHeight() or 0) - viewH)
    if desired < 0 then return 0 end
    if desired > maxScroll then return maxScroll end
    return desired
end

function Util.GetItemID(it)
    if not it then return nil end
    local s = it.source
    if s and s.itemID then return s.itemID end
    if it.itemID then return it.itemID end
    if it.vendorItemID then return it.vendorItemID end
    return it.id or it.decorID
end

function Util.Passes(it)
    local db = Util.DB()
    if not db then return true end
    local ui = db.ui or {}
    local FiltersSys = NS.Systems and NS.Systems.Filters
    if FiltersSys and FiltersSys.Passes then
        return FiltersSys:Passes(it, ui, db)
    end
    return true
end

function Util.IsCollectedSafe(it)
    if not it then return false end
    local Collection = NS.Systems and NS.Systems.Collection
    if not Collection or not Collection.IsCollected then return false end

    local ok, res = pcall(Collection.IsCollected, Collection, it)
    if ok and type(res) == "boolean" then return res end

    local id = (it.source and it.source.itemID) or it.vendorItemID or it.id or it.decorID
    local ok2, res2 = pcall(Collection.IsCollected, Collection, id)
    if ok2 and type(res2) == "boolean" then return res2 end

    return false
end

function Util.GetStateSafe(it)
    if not it then return nil end
    local Collection = NS.Systems and NS.Systems.Collection
    if not Collection or not Collection.GetState then return nil end

    local ok, res = pcall(Collection.GetState, Collection, it)
    if ok then return res end

    local id = (it.source and it.source.itemID) or it.vendorItemID or it.id or it.decorID
    local ok2, res2 = pcall(Collection.GetState, Collection, id)
    if ok2 then return res2 end

    return nil
end

function Util.IsDyeable(it)
    if not it then return false end
    Util._dyeableCache = Util._dyeableCache or {}
    local id = it.decorID or it.id or (it.source and (it.source.id or it.source.decorID)) or it.itemID or (it.source and (it.source.itemID or it.source.itemId))
    if not id then return false end
    local cached = Util._dyeableCache[id]
    if cached ~= nil then return cached end

    local info
    if _G.C_HousingCatalog and _G.C_HousingCatalog.GetCatalogEntryInfo then
        local ok, res = pcall(_G.C_HousingCatalog.GetCatalogEntryInfo, id)
        if ok then info = res end
    end

    local dyeable = false
    if type(info) == "table" then
        dyeable = (info.canCustomize == true) or (info.isCustomizable == true) or (info.customizable == true)
    elseif it.canCustomize ~= nil then
        dyeable = it.canCustomize == true
    elseif it.dyeable ~= nil then
        dyeable = it.dyeable == true
    end

    Util._dyeableCache[id] = dyeable
    return dyeable
end

return Util
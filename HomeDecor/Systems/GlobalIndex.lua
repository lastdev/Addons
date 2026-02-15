local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local GI = {}
NS.Systems.GlobalIndex = GI

GI.byCategory = {}
GI.counts = {}
GI.collected = {}
GI._built = false

local Collection = NS.Systems and NS.Systems.Collection

local function norm(cat)
    if cat == "Saved Items" then return "Saved Items" end
    if cat == "PvP" then return "PVP" end
    return cat
end

local function add(cat, decorID)
    if not decorID then return end
    cat = norm(cat)
    GI.byCategory[cat] = GI.byCategory[cat] or {}
    GI.byCategory[cat][decorID] = true
end

local function countSet(set)
    local n = 0
    for _ in pairs(set or {}) do n = n + 1 end
    return n
end

local function countCollected(set)
    local n = 0
    if not Collection or not Collection.IsCollected then return 0 end
    for decorID in pairs(set or {}) do
        if Collection:IsCollected({ decorID = decorID, source = { type = "vendor" } }) then
            n = n + 1
        end
    end
    return n
end

local function buildVendors()
    local vendors = NS.Data and NS.Data.Vendors
    if type(vendors) ~= "table" then return end
    for _, exp in pairs(vendors) do
        for _, zone in pairs(exp or {}) do
            for _, vendor in ipairs(zone or {}) do
                for _, it in ipairs(vendor.items or {}) do
                    add("Vendors", it.decorID)
                end
            end
        end
    end
end

local function walkCategory(cat)
    local data = NS.Data and NS.Data[cat]
    if type(data) ~= "table" then return end

    local function walk(node)
        if type(node) ~= "table" then return end
        if node[1] and node[1].decorID then
            for _, it in ipairs(node) do add(cat, it.decorID) end
            return
        end
        if node.items and type(node.items) == "table" then
            for _, it in ipairs(node.items) do add(cat, it.decorID) end
            return
        end
        for _, v in pairs(node) do walk(v) end
    end

    walk(data)
end

function GI:Build()
    wipe(self.byCategory)
    wipe(self.counts)
    wipe(self.collected)

    buildVendors()
    walkCategory("Achievements")
    walkCategory("Quests")
    walkCategory("Professions")
    walkCategory("Drops")
    walkCategory("Saved Items")
    walkCategory("PVP")

    for cat, set in pairs(self.byCategory) do
        self.counts[cat] = countSet(set)
        self.collected[cat] = countCollected(set)
    end

    self._built = true
end

function GI:Ensure()
    if not self._built then self:Build() end
end

function GI:GetCounts(cat)
    self:Ensure()
    cat = norm(cat)
    return (self.collected[cat] or 0), (self.counts[cat] or 0)
end

return GI
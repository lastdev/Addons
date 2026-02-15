local _, NS = ...
NS.Systems = NS.Systems or {}

local DecorIndex = NS.Systems.DecorIndex or {}
NS.Systems.DecorIndex = DecorIndex

local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end
local tonumber, type, pairs, ipairs = tonumber, type, pairs, ipairs

local function push(map, k, v)
    if not k then return end
    local t = map[k]
    if not t then t = {}; map[k] = t end
    t[#t+1] = v
end

local function reqIDs(it)
    local req = it and it.requirements
    local src = it and it.source
    local ach = req and req.achievement and req.achievement.id
    local qid = req and req.quest and req.quest.id
    if not ach and src and src.type == "achievement" then ach = src.achievementID or src.id end
    if not qid and src and src.type == "quest" then qid = src.questID or src.id end
    return ach, qid
end

local function score(it)
    if type(it) ~= "table" then return 0 end
    local s, req, src = 0, it.requirements, it.source
    if src and src.itemID then s = s + 4 end
    if req and req.quest and req.quest.id then s = s + 2 end
    if req and req.achievement and req.achievement.id then s = s + 1 end
    if src and src.type and src.type ~= "quest" then s = s + 1 end
    return s
end

local function upsert(self, it, expName, zoneName, vendor)
    if type(it) ~= "table" or not it.decorID then return end

    local did = it.decorID
    local e = self[did]

    if not e then
        e = { item = it, vendor = vendor, vendors = nil, expansion = expName, zone = zoneName }
        self[did] = e
    else
        if score(it) > score(e.item) then e.item = it end

        if vendor and e.vendor and e.vendor ~= vendor then
            e.vendors = e.vendors or { e.vendor }
            e.vendors[#e.vendors+1] = vendor
        elseif vendor and not e.vendor then
            e.vendor = vendor
        end

        if not e.expansion then e.expansion = expName end
        if not e.zone then e.zone = zoneName end
    end

    local ach, qid = reqIDs(it)
    if ach then push(self.byAchievement, ach, did) end
    if qid then push(self.byQuest, qid, did) end
end

local function ingestCategory(self, catTbl, sourceType)
    if type(catTbl) ~= "table" then return end
    for expName, zones in pairs(catTbl) do
        if type(zones) == "table" then
            for zoneName, list in pairs(zones) do
                if type(list) == "table" then
                    for _, it in ipairs(list) do
                        if type(it) == "table" and it.decorID then
                            local src = it.source
                            if not src then src = {}; it.source = src end
                            if not src.type and sourceType then src.type = sourceType end
                            upsert(self, it, expName, zoneName, nil)
                        end
                    end
                end
            end
        end
    end
end

function DecorIndex:Build()
    wipe(self)

    self.byAchievement = {}
    self.byQuest = {}
    self.byNPC = {}

    local vendors = NS.Data and NS.Data.Vendors
    if type(vendors) == "table" then
        for expName, expTbl in pairs(vendors) do
            if type(expTbl) == "table" then
                for zoneName, zoneTbl in pairs(expTbl) do
                    if type(zoneTbl) == "table" then
                        for _, vendor in ipairs(zoneTbl) do
                            local items = vendor and vendor.items
                            if type(items) == "table" then
                                local src = vendor.source
                                local npcID = src and tonumber(src.id or src.npcID or src.npcId)
                                local npcList, npcSeen
                                if npcID then
                                    npcList = self.byNPC[npcID]
                                    if not npcList then npcList = {}; self.byNPC[npcID] = npcList end
                                    npcSeen = npcList._seen
                                    if not npcSeen then npcSeen = {}; npcList._seen = npcSeen end
                                end

                                for _, it in ipairs(items) do
                                    if type(it) == "table" and it.decorID then
                                        if npcList and not npcSeen[it.decorID] then
                                            npcSeen[it.decorID] = true
                                            npcList[#npcList+1] = it.decorID
                                        end
                                        upsert(self, it, expName, zoneName, vendor)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    for _, list in pairs(self.byNPC) do
        if type(list) == "table" then list._seen = nil end
    end

    local D = NS.Data or {}
    ingestCategory(self, D.Quests, "quest")
    ingestCategory(self, D.Achievements, "achievement")
    ingestCategory(self, D.Drops, "drop")
    ingestCategory(self, D.Professions, "profession")
    ingestCategory(self, D.PVP or D.PvP, "pvp")
end

return DecorIndex

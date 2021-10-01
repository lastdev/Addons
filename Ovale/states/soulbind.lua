local __exports = LibStub:NewLibrary("ovale/states/soulbind", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.aceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
__imports.returnConstant = __imports.__enginecondition.returnConstant
__imports.__enginedbc = LibStub:GetLibrary("ovale/engine/dbc")
__imports.conduits = __imports.__enginedbc.conduits
local aceEvent = __imports.aceEvent
local aceTimer = __imports.aceTimer
local ipairs = ipairs
local pairs = pairs
local unpack = unpack
local concat = table.concat
local insert = table.insert
local sort = table.sort
local C_Soulbinds = C_Soulbinds
local GetSpellInfo = GetSpellInfo
local returnBoolean = __imports.returnBoolean
local returnConstant = __imports.returnConstant
local conduits = __imports.conduits
__exports.Soulbind = __class(nil, {
    constructor = function(self, ovale, debug)
        self.conduitSpellIdById = {}
        self.conduitId = {}
        self.conduitRank = {}
        self.isActiveConduit = {}
        self.isActiveTrait = {}
        self.debugConduitOptions = {
            type = "group",
            name = "Conduits",
            args = {
                conduits = {
                    type = "input",
                    name = "Conduits",
                    multiline = 25,
                    width = "full",
                    get = function()
                        return self.debugConduits()
                    end
                }
            }
        }
        self.debugSoulbindTraitsOptions = {
            type = "group",
            name = "Soulbind Traits",
            args = {
                soulbindTraits = {
                    type = "input",
                    name = "Soulbind Traits",
                    multiline = 25,
                    width = "full",
                    get = function()
                        return self.debugSoulbindTraits()
                    end
                }
            }
        }
        self.onEnable = function()
            self.module:RegisterEvent("COVENANT_CHOSEN", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("PLAYER_LOGIN", self.onPlayerLogin)
            self.module:RegisterEvent("SOULBIND_ACTIVATED", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("SOULBIND_CONDUIT_COLLECTION_CLEARED", self.onSoulbindConduitCollectionUpdated)
            self.module:RegisterEvent("SOULBIND_CONDUIT_COLLECTION_REMOVED", self.onSoulbindConduitCollectionUpdated)
            self.module:RegisterEvent("SOULBIND_CONDUIT_COLLECTION_UPDATED", self.onSoulbindConduitCollectionUpdated)
            self.module:RegisterEvent("SOULBIND_CONDUIT_INSTALLED", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("SOULBIND_CONDUIT_UNINSTALLED", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("SOULBIND_NODE_LEARNED", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("SOULBIND_NODE_UNLEARNED", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("SOULBIND_NODE_UPDATED", self.onSoulbindDataUpdated)
            self.module:RegisterEvent("SOULBIND_PATH_CHANGED", self.onSoulbindDataUpdated)
            self.onSoulbindConduitCollectionUpdated("onEnable")
        end
        self.onDisable = function()
            self.module:UnregisterEvent("COVENANT_CHOSEN")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_LOGIN")
            self.module:UnregisterEvent("SOULBIND_ACTIVATED")
            self.module:UnregisterEvent("SOULBIND_CONDUIT_COLLECTION_CLEARED")
            self.module:UnregisterEvent("SOULBIND_CONDUIT_COLLECTION_REMOVED")
            self.module:UnregisterEvent("SOULBIND_CONDUIT_COLLECTION_UPDATED")
            self.module:UnregisterEvent("SOULBIND_CONDUIT_INSTALLED")
            self.module:UnregisterEvent("SOULBIND_CONDUIT_UNINSTALLED")
            self.module:UnregisterEvent("SOULBIND_NODE_LEARNED")
            self.module:UnregisterEvent("SOULBIND_NODE_UNLEARNED")
            self.module:UnregisterEvent("SOULBIND_NODE_UPDATED")
            self.module:UnregisterEvent("SOULBIND_PATH_CHANGED")
        end
        self.onPlayerLogin = function(event)
            self.module:ScheduleTimer(self.onPlayerLoginDelayed, 3)
        end
        self.onPlayerLoginDelayed = function()
            local event = "PLAYER_LOGIN"
            self.tracer:debug(event)
            self.onSoulbindConduitCollectionUpdated(event)
            self.onSoulbindDataUpdated(event)
        end
        self.onSoulbindConduitCollectionUpdated = function(event)
            self.tracer:debug(event .. ": Updating conduit collection.")
            for conduitType = 0, 3 do
                local collectionData = C_Soulbinds.GetConduitCollection(conduitType)
                for _, data in ipairs(collectionData) do
                    self.updateConduitData(data.conduitID)
                end
            end
        end
        self.onSoulbindDataUpdated = function(event)
            self.tracer:debug(event .. ": Updating soulbind data.")
            self.isActiveConduit = {}
            self.isActiveTrait = {}
            local soulbindId = C_Soulbinds.GetActiveSoulbindID() or 0
            self.tracer:debug(event .. ": active soulbind = " .. soulbindId)
            if soulbindId ~= 0 then
                local data = C_Soulbinds.GetSoulbindData(soulbindId)
                for _, node in pairs(data.tree.nodes) do
                    local isSelected = node.state == 3
                    local isTrait = node.spellID and node.spellID ~= 0
                    local isConduit = node.conduitID and node.conduitID ~= 0
                    if isTrait then
                        self.isActiveTrait[node.spellID] = isSelected
                    end
                    if isConduit then
                        local id = node.conduitID
                        self.updateConduitData(id)
                        if isSelected then
                            local spellId = self.conduitSpellIdById[id]
                            if spellId then
                                self.isActiveConduit[spellId] = true
                            end
                        end
                    end
                end
            end
        end
        self.updateConduitData = function(id)
            local rank = C_Soulbinds.GetConduitRank(id) or 0
            local spellId = C_Soulbinds.GetConduitSpellID(id, rank)
            if spellId ~= 0 then
                self.conduitSpellIdById[id] = spellId
                self.conduitId[spellId] = id
                self.conduitRank[spellId] = rank
            end
        end
        self.debugConduits = function()
            local output = {}
            for spellId, id in pairs(self.conduitId) do
                local rank = self.conduitRank[spellId]
                local name = GetSpellInfo(spellId)
                if self.isActiveConduit[spellId] then
                    insert(output, name .. ": " .. spellId .. ", id=" .. id .. ", rank=" .. rank .. " (active)")
                else
                    insert(output, name .. ": " .. spellId .. ", id=" .. id .. ", rank=" .. rank)
                end
            end
            sort(output)
            return concat(output, "\n")
        end
        self.debugSoulbindTraits = function()
            local output = {}
            for spellId, isActive in pairs(self.isActiveTrait) do
                local name = GetSpellInfo(spellId)
                if isActive then
                    insert(output, name .. ": " .. spellId .. " (active)")
                else
                    insert(output, name .. ": " .. spellId)
                end
            end
            sort(output)
            return concat(output, "\n")
        end
        self.conduitCondition = function(positionalParameters)
            local id = unpack(positionalParameters)
            local conduitId = self.conduitId[id] or id
            local spellId = self.conduitSpellIdById[conduitId]
            return returnBoolean(self.isActiveConduit[spellId])
        end
        self.conduitRankCondition = function(positionalParameters)
            local id = unpack(positionalParameters)
            local conduitId = self.conduitId[id] or id
            local spellId = self.conduitSpellIdById[conduitId]
            local rank = self.conduitRank[spellId]
            if rank then
                return returnConstant(rank)
            else
                return 
            end
        end
        self.soulbindCondition = function(positionalParameters)
            local spellId = unpack(positionalParameters)
            return returnBoolean(self.isActiveTrait[spellId])
        end
        self.conduitValue = function(atTime, id)
            local conduitId = self.conduitId[id] or id
            local spellId = self.conduitSpellIdById[conduitId]
            local rank = self.conduitRank[spellId]
            if rank then
                local value = conduits[conduitId].ranks[rank]
                return returnConstant(value)
            else
                return 
            end
        end
        debug.defaultOptions.args["conduit"] = self.debugConduitOptions
        debug.defaultOptions.args["soulbindTraits"] = self.debugSoulbindTraitsOptions
        self.module = ovale:createModule("Soulbind", self.onEnable, self.onDisable, aceEvent, aceTimer)
        self.tracer = debug:create(self.module:GetName())
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("conduit", false, self.conduitCondition)
        condition:registerCondition("conduitrank", false, self.conduitRankCondition)
        condition:registerCondition("enabledsoulbind", false, self.soulbindCondition)
        condition:registerCondition("soulbind", false, self.soulbindCondition)
        condition:register("conduitvalue", self.conduitValue, {
            type = "number"
        }, {
            name = "conduit",
            type = "number",
            optional = false
        })
    end,
})

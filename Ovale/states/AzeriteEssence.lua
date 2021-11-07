local __exports = LibStub:NewLibrary("ovale/states/AzeriteEssence", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local aceEvent = __imports.aceEvent
local pairs = pairs
local tostring = tostring
local ipairs = ipairs
local sort = table.sort
local insert = table.insert
local concat = table.concat
local C_AzeriteEssence = C_AzeriteEssence
__exports.OvaleAzeriteEssenceClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug)
        self.essences = {}
        self.debugOptions = {
            azeraitessences = {
                name = "Azerite essences",
                type = "group",
                args = {
                    azeraitessences = {
                        name = "Azerite essences",
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self:debugEssences()
                        end
                    }
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterEvent("AZERITE_ESSENCE_CHANGED", self.handleUpdateEssences)
            self.module:RegisterEvent("AZERITE_ESSENCE_UPDATE", self.handleUpdateEssences)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleUpdateEssences)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("AZERITE_ESSENCE_CHANGED")
            self.module:UnregisterEvent("AZERITE_ESSENCE_UPDATE")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
        self.handleUpdateEssences = function(e)
            self.tracer:debug("UpdateEssences after event %s", e)
            self.essences = {}
            for _, mileStoneInfo in pairs(C_AzeriteEssence.GetMilestones() or {}) do
                if mileStoneInfo.ID and mileStoneInfo.unlocked and mileStoneInfo.slot ~= nil then
                    local essenceId = C_AzeriteEssence.GetMilestoneEssence(mileStoneInfo.ID)
                    if essenceId then
                        local essenceInfo = C_AzeriteEssence.GetEssenceInfo(essenceId)
                        local essenceData = {
                            ID = essenceId,
                            name = essenceInfo.name,
                            rank = essenceInfo.rank,
                            slot = mileStoneInfo.slot
                        }
                        self.essences[essenceId] = essenceData
                        self.tracer:debug("Found essence {ID: %d, name: %s, rank: %d, slot: %d}", essenceData.ID, essenceData.name, essenceData.rank, essenceData.slot)
                    end
                end
            end
        end
        self.module = ovale:createModule("OvaleAzeriteEssence", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create("OvaleAzeriteEssence")
        for k, v in pairs(self.debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    isMajorEssence = function(self, essenceId)
        local essence = self.essences[essenceId]
        if essence then
            return (essence.slot == 0 and true) or false
        end
        return false
    end,
    isMinorEssence = function(self, essenceId)
        return (self.essences[essenceId] ~= nil and true) or false
    end,
    essenceRank = function(self, essenceId)
        local essence = self.essences[essenceId]
        return (essence ~= nil and essence.rank) or 0
    end,
    debugEssences = function(self)
        local output = {}
        local array = {}
        for k, v in pairs(self.essences) do
            insert(array, tostring(v.name) .. ": " .. tostring(k) .. " (slot:" .. v.slot .. " | rank:" .. v.rank .. ")")
        end
        sort(array)
        for _, v in ipairs(array) do
            output[#output + 1] = v
        end
        return concat(output, "\n")
    end,
})

local __exports = LibStub:NewLibrary("ovale/states/runeforge", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
__imports.__enginedbc = LibStub:GetLibrary("ovale/engine/dbc")
__imports.runeforgeBonusId = __imports.__enginedbc.runeforgeBonusId
local aceEvent = __imports.aceEvent
local ipairs = ipairs
local pairs = pairs
local concat = table.concat
local insert = table.insert
local sort = table.sort
local C_LegendaryCrafting = C_LegendaryCrafting
local Enum = Enum
local returnBoolean = __imports.returnBoolean
local runeforgeBonusId = __imports.runeforgeBonusId
__exports.Runeforge = __class(nil, {
    constructor = function(self, ovale, debug, equipment)
        self.equipment = equipment
        self.equippedRuneforgeById = {}
        self.debugRuneforges = {
            type = "group",
            name = "Runeforges",
            args = {
                runeforge = {
                    type = "input",
                    name = "Runeforges",
                    multiline = 25,
                    width = "full",
                    get = function()
                        local powers = C_LegendaryCrafting.GetRuneforgePowers(nil, nil)
                        local output = {}
                        for _, id in pairs(powers) do
                            local spellId, name = self.getRuneforgePowerInfo(id)
                            local bonusId = (spellId and runeforgeBonusId[spellId]) or 0
                            if bonusId ~= 0 then
                                local slot = self.equippedRuneforgeById[bonusId]
                                if slot then
                                    insert(output, "* " .. name .. ": " .. bonusId .. " (" .. slot .. ")")
                                else
                                    insert(output, "  " .. name .. ": " .. bonusId)
                                end
                            end
                        end
                        sort(output)
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterMessage("Ovale_EquipmentChanged", self.handleOvaleEquipmentChanged)
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_EquipmentChanged")
        end
        self.handleOvaleEquipmentChanged = function(event, slot)
            for id, slotName in pairs(self.equippedRuneforgeById) do
                if slotName == slot then
                    self.equippedRuneforgeById[id] = nil
                end
            end
            local quality = self.equipment:getEquippedItemQuality(slot)
            if quality == Enum.ItemQuality.Legendary then
                local powerId = self.getRuneforgePowerId(slot)
                if powerId then
                    local spellId = self.getRuneforgePowerInfo(powerId)
                    if spellId then
                        local bonusId = runeforgeBonusId[spellId]
                        local bonusIds = self.equipment:getEquippedItemBonusIds(slot)
                        for _, id in ipairs(bonusIds) do
                            if bonusId == id then
                                self.tracer:debug(event, "Slot " .. slot .. " has runeforge bonus ID " .. bonusId)
                                self.equippedRuneforgeById[id] = slot
                                break
                            end
                        end
                    end
                end
            end
        end
        self.getRuneforgePowerId = function(slot)
            local location = self.equipment:getEquippedItemLocation(slot)
            if location then
                if C_LegendaryCrafting.IsRuneforgeLegendary(location) then
                    local componentInfo = C_LegendaryCrafting.GetRuneforgeLegendaryComponentInfo(location)
                    return componentInfo.powerID
                end
            end
            return nil
        end
        self.getRuneforgePowerInfo = function(powerId)
            local powerInfo = C_LegendaryCrafting.GetRuneforgePowerInfo(powerId)
            if powerInfo then
                local spellId = powerInfo.descriptionSpellID
                local name = powerInfo.name
                return spellId, name
            end
            return nil, nil
        end
        self.equippedRuneforge = function(positionalParameters)
            local id = positionalParameters[1]
            return returnBoolean(self:hasRuneforge(id))
        end
        debug.defaultOptions.args["runeforge"] = self.debugRuneforges
        self.module = ovale:createModule("OvaleRuneforge", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    hasRuneforge = function(self, id)
        return self.equippedRuneforgeById[id] ~= nil
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("equippedruneforge", false, self.equippedRuneforge)
        condition:registerCondition("runeforge", false, self.equippedRuneforge)
    end,
})

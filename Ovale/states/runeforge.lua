local __exports = LibStub:NewLibrary("ovale/states/runeforge", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local ipairs = ipairs
local kpairs = pairs
local pairs = pairs
local unpack = unpack
local wipe = wipe
local concat = table.concat
local insert = table.insert
local C_LegendaryCrafting = C_LegendaryCrafting
local Enum = Enum
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local oneTimeMessage = __toolstools.oneTimeMessage
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local __Equipment = LibStub:GetLibrary("ovale/states/Equipment")
local inventorySlotNames = __Equipment.inventorySlotNames
__exports.Runeforge = __class(nil, {
    constructor = function(self, ovale, debug, equipment)
        self.equipment = equipment
        self.equippedLegendaryById = {}
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
                        local ids = C_LegendaryCrafting.GetRuneforgePowers(nil)
                        local output = {}
                        for _, v in ipairs(ids) do
                            local runeforgePower = C_LegendaryCrafting.GetRuneforgePowerInfo(v)
                            if runeforgePower then
                                insert(output, v .. ": " .. runeforgePower.name)
                            end
                        end
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.debugLegendaries = {
            type = "group",
            name = "Legendaries",
            args = {
                legendaries = {
                    type = "input",
                    name = "Legendaries",
                    multiline = 25,
                    width = "full",
                    get = function()
                        local output = {}
                        insert(output, "Legendary bonus IDs:")
                        for id in pairs(self.equippedLegendaryById) do
                            insert(output, "    " .. id)
                        end
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
        self.handleOvaleEquipmentChanged = function(event)
            wipe(self.equippedLegendaryById)
            for slot in kpairs(inventorySlotNames) do
                local quality = self.equipment:getEquippedItemQuality(slot)
                if quality == Enum.ItemQuality.Legendary then
                    local bonusIds = self.equipment:getEquippedItemBonusIds(slot)
                    if #bonusIds > 0 then
                        local id = bonusIds[1]
                        self.equippedLegendaryById[id] = true
                    end
                end
            end
        end
        self.equippedRuneforge = function(positionalParameters)
            local id = unpack(positionalParameters)
            if  not isNumber(id) then
                oneTimeMessage(id .. " is not defined in EquippedRuneforge")
                return 
            end
            return returnBoolean(self.equippedLegendaryById[id])
        end
        debug.defaultOptions.args["runeforge"] = self.debugRuneforges
        debug.defaultOptions.args["legendaries"] = self.debugLegendaries
        self.module = ovale:createModule("OvaleRuneforge", self.handleInitialize, self.handleDisable, aceEvent)
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("equippedruneforge", false, self.equippedRuneforge)
        condition:registerCondition("runeforge", false, self.equippedRuneforge)
    end,
})

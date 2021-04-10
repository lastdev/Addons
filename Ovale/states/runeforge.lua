local __exports = LibStub:NewLibrary("ovale/states/runeforge", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local unpack = unpack
local concat = table.concat
local insert = table.insert
local C_LegendaryCrafting = C_LegendaryCrafting
local GetInventoryItemQuality = GetInventoryItemQuality
local GetInventoryItemLink = GetInventoryItemLink
local INVSLOT_FIRST_EQUIPPED = INVSLOT_FIRST_EQUIPPED
local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local oneTimeMessage = __toolstools.oneTimeMessage
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local match = string.match
__exports.Runeforge = __class(nil, {
    constructor = function(self, ovale, debug)
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
                        for id, v in pairs(self.equippedLegendaryById) do
                            insert(output, id .. ": " .. v)
                        end
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterMessage("Ovale_EquipmentChanged", self.updateEquippedItems)
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_EquipmentChanged")
        end
        self.updateEquippedItems = function()
            self.equippedLegendaryById = {}
            for slotId = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED, 1 do
                if GetInventoryItemQuality("player", slotId) == 5 then
                    local newItemLink = match(GetInventoryItemLink("player", slotId), "item:([%-?%d:]+)")
                    if newItemLink then
                        local newLegendaryId = match(newItemLink, "%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:(%d*):")
                        self.equippedLegendaryById[tonumber(newLegendaryId)] = tonumber(slotId)
                    end
                end
            end
        end
        self.equippedRuneforge = function(positionalParameters)
            local bonusItemId = unpack(positionalParameters)
            if  not isNumber(bonusItemId) then
                oneTimeMessage(bonusItemId .. " is not defined in EquippedRuneforge")
                return 
            end
            return returnBoolean(self.equippedLegendaryById[bonusItemId] ~= nil)
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

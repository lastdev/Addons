local __exports = LibStub:NewLibrary("ovale/states/AzeriteArmor", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
__imports.returnConstant = __imports.__enginecondition.returnConstant
local aceEvent = __imports.aceEvent
local wipe = wipe
local pairs = pairs
local tostring = tostring
local ipairs = ipairs
local kpairs = pairs
local sort = table.sort
local insert = table.insert
local concat = table.concat
local C_AzeriteEmpoweredItem = C_AzeriteEmpoweredItem
local GetSpellInfo = GetSpellInfo
local returnBoolean = __imports.returnBoolean
local returnConstant = __imports.returnConstant
local azeriteSlots = {
    headslot = true,
    shoulderslot = true,
    chestslot = true
}
__exports.OvaleAzeriteArmor = __class(nil, {
    constructor = function(self, equipment, ovale, ovaleDebug)
        self.equipment = equipment
        self.traits = {}
        self.output = {}
        self.debugOptions = {
            azeraittraits = {
                name = "Azerite traits",
                type = "group",
                args = {
                    azeraittraits = {
                        name = "Azerite traits",
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self:debugTraits()
                        end
                    }
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterMessage("Ovale_EquipmentChanged", self.handleOvaleEquipmentChanged)
            self.module:RegisterEvent("AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED", self.handleAzeriteEmpoweredItemSelectionUpdated)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handlePlayerEnteringWorld)
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_EquipmentChanged")
            self.module:UnregisterEvent("AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
        self.handleOvaleEquipmentChanged = function(event, slot)
            if azeriteSlots[slot] then
                self:updateTraits()
            end
        end
        self.handleAzeriteEmpoweredItemSelectionUpdated = function()
            self:updateTraits()
        end
        self.handlePlayerEnteringWorld = function()
            self:updateTraits()
        end
        self.azeriteTraitRank = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local value = self:traitRank(spellId)
            return returnConstant(value)
        end
        self.hasAzeriteTrait = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local value = self:hasTrait(spellId)
            return returnBoolean(value)
        end
        self.module = ovale:createModule("OvaleAzeriteArmor", self.handleInitialize, self.handleDisable, aceEvent)
        for k, v in pairs(self.debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("hasazeritetrait", false, self.hasAzeriteTrait)
        ovaleCondition:registerCondition("azeritetraitrank", false, self.azeriteTraitRank)
    end,
    updateTraits = function(self)
        self.traits = {}
        for slot in kpairs(azeriteSlots) do
            local location = self.equipment:getEquippedItemLocation(slot)
            if location ~= nil and C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(location) then
                local allTraits = C_AzeriteEmpoweredItem.GetAllTierInfo(location)
                for _, traitsInRow in pairs(allTraits) do
                    for _, powerId in pairs(traitsInRow.azeritePowerIDs) do
                        local isEnabled = C_AzeriteEmpoweredItem.IsPowerSelected(location, powerId)
                        if isEnabled then
                            local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(powerId)
                            local name = GetSpellInfo(powerInfo.spellID)
                            if self.traits[powerInfo.spellID] then
                                local rank = self.traits[powerInfo.spellID].rank
                                self.traits[powerInfo.spellID].rank = rank + 1
                            else
                                self.traits[powerInfo.spellID] = {
                                    spellID = powerInfo.spellID,
                                    name = name,
                                    rank = 1
                                }
                            end
                            break
                        end
                    end
                end
            end
        end
    end,
    hasTrait = function(self, spellId)
        return (self.traits[spellId] and true) or false
    end,
    traitRank = function(self, spellId)
        if  not self.traits[spellId] then
            return 0
        end
        return self.traits[spellId].rank
    end,
    debugTraits = function(self)
        wipe(self.output)
        local array = {}
        for k, v in pairs(self.traits) do
            insert(array, tostring(v.name) .. ": " .. tostring(k) .. " (" .. v.rank .. ")")
        end
        sort(array)
        for _, v in ipairs(array) do
            self.output[#self.output + 1] = v
        end
        return concat(self.output, "\n")
    end,
})

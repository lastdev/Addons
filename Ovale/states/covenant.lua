local __exports = LibStub:NewLibrary("ovale/states/covenant", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.isString = __imports.__toolstools.isString
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
local aceEvent = __imports.aceEvent
local C_Covenants = C_Covenants
local isNumber = __imports.isNumber
local isString = __imports.isString
local returnBoolean = __imports.returnBoolean
local ipairs = ipairs
local pairs = pairs
local unpack = unpack
local gsub = string.gsub
local lower = string.lower
local concat = table.concat
local insert = table.insert
local covenantNameById = {}
__exports.Covenant = __class(nil, {
    constructor = function(self, ovale, debug)
        self.debugOptions = {
            type = "group",
            name = "Covenants",
            args = {
                covenants = {
                    type = "input",
                    name = "Covenants",
                    multiline = 25,
                    width = "full",
                    get = function()
                        local output = {}
                        for id, name in pairs(covenantNameById) do
                            if self.covenantId == id then
                                insert(output, id .. ": " .. name .. " (active)")
                            else
                                insert(output, id .. ": " .. name)
                            end
                        end
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.onEnable = function()
            self.module:RegisterEvent("COVENANT_CHOSEN", self.onCovenantChosen)
            local id = C_Covenants.GetActiveCovenantID()
            if id then
                self.onCovenantChosen("COVENANT_CHOSEN", id)
            end
        end
        self.onDisable = function()
            self.module:UnregisterEvent("COVENANT_CHOSEN")
        end
        self.onCovenantChosen = function(event, covenantId)
            self.covenantId = covenantId
            local name = self:getCovenant(covenantId)
            self.module:SendMessage("Ovale_CovenantChosen", name)
        end
        self.isCovenantCondition = function(positionalParameters)
            local covenant = unpack(positionalParameters)
            if isNumber(covenant) or isString(covenant) then
                return returnBoolean(self:isCovenant(covenant))
            end
            return returnBoolean(false)
        end
        self.module = ovale:createModule("Covenant", self.onEnable, self.onDisable, aceEvent)
        debug.defaultOptions.args["covenant"] = self.debugOptions
        local ids = C_Covenants.GetCovenantIDs()
        for _, v in ipairs(ids) do
            local covenant = C_Covenants.GetCovenantData(v)
            if covenant and covenant.name and covenant.ID then
                local name = gsub(lower(covenant.name), " ", "_")
                covenantNameById[covenant.ID] = name
            end
        end
    end,
    getCovenant = function(self, covenantId)
        covenantId = covenantId or self.covenantId
        return (covenantId and covenantNameById[covenantId]) or "none"
    end,
    isCovenant = function(self, covenant)
        if isNumber(covenant) then
            return self.covenantId == covenant
        else
            local name = self:getCovenant()
            return name == covenant
        end
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("iscovenant", false, self.isCovenantCondition)
    end,
})

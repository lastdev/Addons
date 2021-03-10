local __exports = LibStub:NewLibrary("ovale/states/covenant", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local C_Covenants = C_Covenants
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local pairs = pairs
local ipairs = ipairs
local unpack = unpack
local gsub = string.gsub
local lower = string.lower
local concat = table.concat
local insert = table.insert
local covenantIdByName = {}
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
                        for k, v in pairs(covenantIdByName) do
                            if self.covenantId == v then
                                insert(output, k .. ": " .. v .. " (active)")
                            else
                                insert(output, k .. ": " .. v)
                            end
                        end
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.onInitialize = function()
            self.module:RegisterEvent("COVENANT_CHOSEN", self.onCovenantChosen)
            self.covenantId = C_Covenants.GetActiveCovenantID()
        end
        self.onDisable = function()
            self.module:UnregisterEvent("COVENANT_CHOSEN")
        end
        self.onCovenantChosen = function(_, covenantId)
            self.covenantId = covenantId
        end
        self.isCovenant = function(positionalParameters)
            local covenant = unpack(positionalParameters)
            if covenant == "none" then
                return returnBoolean(self.covenantId == nil)
            end
            if  not covenant then
                return 
            end
            local id
            if isNumber(covenant) then
                id = covenant
            else
                id = covenantIdByName[covenant]
            end
            return returnBoolean(self.covenantId == id)
        end
        self.module = ovale:createModule("Covenant", self.onInitialize, self.onDisable, aceEvent)
        debug.defaultOptions.args["covenant"] = self.debugOptions
        local ids = C_Covenants.GetCovenantIDs()
        for _, v in ipairs(ids) do
            local covenant = C_Covenants.GetCovenantData(v)
            if covenant and covenant.name and covenant.ID then
                local name = gsub(lower(covenant.name), " ", "_")
                covenantIdByName[name] = covenant.ID
            end
        end
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("iscovenant", false, self.isCovenant)
    end,
})

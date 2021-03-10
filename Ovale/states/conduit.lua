local __exports = LibStub:NewLibrary("ovale/states/conduit", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local unpack = unpack
local C_Soulbinds = C_Soulbinds
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local returnConstant = __enginecondition.returnConstant
local __enginedbc = LibStub:GetLibrary("ovale/engine/dbc")
local conduits = __enginedbc.conduits
__exports.Conduit = __class(nil, {
    constructor = function(self, debug)
        self.debugOptions = {
            type = "group",
            name = "Conduits",
            args = {
                conduits = {
                    type = "input",
                    name = "Conduits",
                    multiline = 25,
                    width = "full",
                    get = function()
                        return ""
                    end
                }
            }
        }
        self.conduit = function(positionalParameters)
            local conduitId = unpack(positionalParameters)
            local soulbindID = C_Soulbinds.GetActiveSoulbindID()
            return returnBoolean(C_Soulbinds.IsConduitInstalledInSoulbind(soulbindID, conduitId))
        end
        self.conduitRank = function(positionalParameters)
            local conduitId = unpack(positionalParameters)
            local data = C_Soulbinds.GetConduitCollectionData(conduitId)
            if  not data then
                return 
            end
            return returnConstant(data.conduitRank)
        end
        self.enabledSoulbind = function(positionalParameters)
            local soulbindId = unpack(positionalParameters)
            return returnBoolean(C_Soulbinds.GetActiveSoulbindID() == soulbindId)
        end
        self.conduitValue = function(atTime, conduitId)
            local data = C_Soulbinds.GetConduitCollectionData(conduitId)
            if  not data then
                return 
            end
            return returnConstant(conduits[conduitId].ranks[data.conduitRank])
        end
        debug.defaultOptions.args["conduit"] = self.debugOptions
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("conduit", false, self.conduit)
        condition:registerCondition("conduitrank", false, self.conduitRank)
        condition:registerCondition("enabledsoulbind", false, self.enabledSoulbind)
        condition:registerCondition("soulbind", false, self.enabledSoulbind)
        condition:register("conduitvalue", self.conduitValue, {
            type = "number"
        }, {
            name = "conduit",
            type = "number",
            optional = false
        })
    end,
})

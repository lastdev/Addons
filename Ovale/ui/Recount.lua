local __exports = LibStub:NewLibrary("ovale/ui/Recount", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.AceLocale = LibStub:GetLibrary("AceLocale-3.0", true)
__imports.Recount = LibStub:GetLibrary("recount", true)
local AceLocale = __imports.AceLocale
local Recount = __imports.Recount
local setmetatable = setmetatable
local GameTooltip = GameTooltip
local dataModes = function(self, data, num)
    if  not data then
        return 0, 0
    end
    local fight = data.Fights[Recount.db.profile.CurDataSet]
    local score
    if fight and fight.ovale and fight.ovaleMax then
        score = (fight.ovale * 1000) / fight.ovaleMax
    else
        score = 0
    end
    if num == 1 then
        return score
    end
    return score, nil
end

local tooltipFuncs = function(self, name)
    GameTooltip:ClearLines()
    GameTooltip:AddLine(name)
end

__exports.OvaleRecountClass = __class(nil, {
    constructor = function(self, ovale, ovaleScore)
        self.ovale = ovale
        self.ovaleScore = ovaleScore
        self.handleInitialize = function()
            if Recount then
                local aceLocale = AceLocale and AceLocale:GetLocale("Recount", true)
                if  not aceLocale then
                    aceLocale = setmetatable({}, {
                        __index = function(t, k)
                            t[k] = k
                            return k
                        end

                    })
                end
                Recount:AddModeTooltip(self.ovale:GetName(), dataModes, tooltipFuncs, nil, nil, nil, nil)
                self.ovaleScore:registerDamageMeter("OvaleRecount", self.receiveScore)
            end
        end
        self.handleDisable = function()
            self.ovaleScore:unregisterDamageMeter("OvaleRecount")
        end
        self.receiveScore = function(name, guid, scored, scoreMax)
            if Recount then
                local source = Recount.db2.combatants[name]
                if source then
                    Recount:AddAmount(source, "ovale", scored)
                    Recount:AddAmount(source, "ovaleMax", scoreMax)
                end
            end
        end
        ovale:createModule("OvaleRecount", self.handleInitialize, self.handleDisable)
    end,
})

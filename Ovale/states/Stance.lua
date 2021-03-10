local __exports = LibStub:NewLibrary("ovale/states/Stance", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local pairs = pairs
local type = type
local wipe = wipe
local concat = table.concat
local insert = table.insert
local sort = table.sort
local GetNumShapeshiftForms = GetNumShapeshiftForms
local GetShapeshiftForm = GetShapeshiftForm
local GetShapeshiftFormInfo = GetShapeshiftFormInfo
local GetSpellInfo = GetSpellInfo
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local druidCatForm = GetSpellInfo(768)
local druidTravelForm = GetSpellInfo(783)
local druidAquaticForm = GetSpellInfo(1066)
local druidBearForm = GetSpellInfo(5487)
local druidMoonkinForm = GetSpellInfo(24858)
local druidFlightForm = GetSpellInfo(33943)
local druidSwiftFlightForm = GetSpellInfo(40120)
local rogueStealth = GetSpellInfo(1784)
local spellNameToStance = {}
if druidCatForm then
    spellNameToStance[druidCatForm] = "druid_cat_form"
end
if druidTravelForm then
    spellNameToStance[druidTravelForm] = "druid_travel_form"
end
if druidAquaticForm then
    spellNameToStance[druidAquaticForm] = "druid_aquatic_form"
end
if druidBearForm then
    spellNameToStance[druidBearForm] = "druid_bear_form"
end
if druidMoonkinForm then
    spellNameToStance[druidMoonkinForm] = "druid_moonkin_form"
end
if druidFlightForm then
    spellNameToStance[druidFlightForm] = "druid_flight_form"
end
if druidSwiftFlightForm then
    spellNameToStance[druidSwiftFlightForm] = "druid_swift_flight_form"
end
if rogueStealth then
    spellNameToStance[rogueStealth] = "rogue_stealth"
end
__exports.stanceName = {
    druid_aquatic_form = true,
    druid_bear_form = true,
    druid_cat_form = true,
    druid_flight_form = true,
    druid_moonkin_form = true,
    druid_swift_flight_form = true,
    druid_travel_form = true,
    rogue_stealth = true
}
local array = {}
local StanceData = __class(nil, {
    constructor = function(self)
        self.stance = 0
    end
})
__exports.OvaleStanceClass = __class(States, {
    constructor = function(self, ovaleDebug, ovale, ovaleProfiler, ovaleData)
        self.ovale = ovale
        self.ovaleData = ovaleData
        self.ready = false
        self.stanceList = {}
        self.stanceId = {}
        self.stance = function(positionalParams, namedParams, atTime)
            local stance = positionalParams[1]
            local boolean = self:isStance(stance, atTime)
            return returnBoolean(boolean)
        end
        self.handleInitialize = function()
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.updateStances)
            self.module:RegisterEvent("UPDATE_SHAPESHIFT_FORM", self.handleUpdateShapeshiftForm)
            self.module:RegisterEvent("UPDATE_SHAPESHIFT_FORMS", self.handleUpdateShapeshiftForms)
            self.module:RegisterMessage("Ovale_SpellsChanged", self.updateStances)
            self.module:RegisterMessage("Ovale_TalentsChanged", self.updateStances)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("PLAYER_ALIVE")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("UPDATE_SHAPESHIFT_FORM")
            self.module:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS")
            self.module:UnregisterMessage("Ovale_SpellsChanged")
            self.module:UnregisterMessage("Ovale_TalentsChanged")
        end
        self.handleUpdateShapeshiftForm = function(event)
            self:shapeshiftEventHandler()
        end
        self.handleUpdateShapeshiftForms = function(event)
            self:shapeshiftEventHandler()
        end
        self.updateStances = function()
            self:createStanceList()
            self:shapeshiftEventHandler()
            self.ready = true
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvaleStance_ApplySpellAfterCast")
            local stance = self.ovaleData:getSpellInfoProperty(spellId, endCast, "to_stance", targetGUID)
            if stance then
                if type(stance) == "string" then
                    stance = self.stanceId[stance]
                end
                self.next.stance = stance
            end
            self.profiler:stopProfiling("OvaleStance_ApplySpellAfterCast")
        end
        States.constructor(self, StanceData)
        self.module = ovale:createModule("OvaleStance", self.handleInitialize, self.handleDisable, aceEvent)
        self.profiler = ovaleProfiler:create(self.module:GetName())
        local debugOptions = {
            stance = {
                name = l["stances"],
                type = "group",
                args = {
                    stance = {
                        name = l["stances"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self:debugStances()
                        end
                    }
                }
            }
        }
        for k, v in pairs(debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("stance", false, self.stance)
    end,
    createStanceList = function(self)
        self.profiler:startProfiling("OvaleStance_CreateStanceList")
        wipe(self.stanceList)
        wipe(self.stanceId)
        local name, stanceName, spellId
        for i = 1, GetNumShapeshiftForms(), 1 do
            _, _, _, spellId = GetShapeshiftFormInfo(i)
            name = GetSpellInfo(spellId)
            if name then
                stanceName = spellNameToStance[name]
                if stanceName then
                    self.stanceList[i] = stanceName
                    self.stanceId[stanceName] = i
                end
            end
        end
        self.profiler:stopProfiling("OvaleStance_CreateStanceList")
    end,
    debugStances = function(self)
        wipe(array)
        for k, v in pairs(self.stanceList) do
            if self.current.stance == k then
                insert(array, v .. " (active)")
            else
                insert(array, v)
            end
        end
        sort(array)
        return concat(array, "\n")
    end,
    getStance = function(self, stanceId)
        stanceId = stanceId or self.current.stance
        return self.stanceList[stanceId]
    end,
    isStance = function(self, name, atTime)
        local state = self:getState(atTime)
        if name and state.stance then
            if type(name) == "number" then
                return name == state.stance
            else
                return name == self:getStance(state.stance)
            end
        end
        return false
    end,
    isStanceSpell = function(self, spellId)
        local name = GetSpellInfo(spellId)
        return  not  not (name and spellNameToStance[name])
    end,
    shapeshiftEventHandler = function(self)
        self.profiler:startProfiling("OvaleStance_ShapeshiftEventHandler")
        local oldStance = self.current.stance
        local newStance = GetShapeshiftForm()
        if oldStance ~= newStance then
            self.current.stance = newStance
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_StanceChanged", self:getStance(newStance), self:getStance(oldStance))
        end
        self.profiler:stopProfiling("OvaleStance_ShapeshiftEventHandler")
    end,
    initializeState = function(self)
        self.next.stance = 0
    end,
    cleanState = function(self)
    end,
    resetState = function(self)
        self.profiler:startProfiling("OvaleStance_ResetState")
        self.next.stance = self.current.stance
        self.profiler:stopProfiling("OvaleStance_ResetState")
    end,
})

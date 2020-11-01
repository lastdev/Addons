local addonName, ns = ...

NugHealth = CreateFrame("Frame", "NugHealth", UIParent)

local NugHealth = NugHealth

NugHealth:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)

NugHealth:RegisterEvent("ADDON_LOADED")

-- local LibCLHealth = LibStub("LibCombatLogHealth-1.0")
local DB_VERSION = 1
local UnitHealth = UnitHealth
local UnitHealthOriginal = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitGetIncomingHeals = UnitGetIncomingHeals
local GetTime = GetTime
local math_min = math.min
local math_max = math.max
local lowhpcolor = false
local showSpikes = true
local isMonk = select(2, UnitClass"player") == "MONK"
local isClassic = select(4,GetBuildInfo()) <= 19999
local GetSpecialization = isClassic and function() return nil end or _G.GetSpecialization

local vengeanceMinRange = 7000
local vengeanceMaxRange = 200000
local vengeanceRedRange = 60000

local staggerMul = 1
local resolveMul = 1
local playerGUID = 0

local defaults = {
    height = 95,
    width = 35,
    absorb_width = 6,
    stagger_width = 10,
    spike_width = 4,
    point = "CENTER",
    relative_point = "CENTER",
    frame = "UIParent",
    classcolor = true,
    healthTexture = "Gradient",
    healthOrientation = "VERTICAL",
    outOfCombatAlpha = 0,
    allSpecs = false,
    healthcolor = { 0.78, 0.61, 0.43 },
    x = 0,
    y = 0,
    showResolve = true,
    showStaggerSpikes = true,
    showResolveSpikes = false,
    resolveLimit = 100,
    staggerLimit = 100,
    useCLH = false,
    lowhpcolor = false,
    lowhpFlash = false,
    hideOutOfCombat = true,
    healthText = false,
    healthTextSize = 13,
    healthTextOffset = 5,
}

local function PercentColor(percent)
    if percent <= 0 then
        return 0, 1, 0
    elseif percent <= 0.5 then
        return percent*2, 1, 0
    elseif percent >= 1 then
        return 1, 0, 0
    else
        return 1, 2 - percent*2, 0
    end
end

function NugHealth.ADDON_LOADED(self,event,arg1)
    if arg1 == "NugHealth" then
        NugHealthDB = NugHealthDB or {}
        ns.SetupDefaults(NugHealthDB, defaults)

        self:Create()

        resolveMul = 100/NugHealthDB.resolveLimit
        staggerMul = 100/NugHealthDB.staggerLimit

        lowhpcolor = NugHealthDB.lowhpcolor
        showSpikes = NugHealthDB.showResolveSpikes
        if isMonk then
            showSpikes = NugHealthDB.showStaggerSpikes
        end

        NugHealth:SPELLS_CHANGED()


        self:RegisterEvent("PLAYER_LOGOUT")
        -- self:RegisterEvent("PLAYER_LOGIN") --registered in :Enable()
        -- self:RegisterEvent("PLAYER_REGEN_ENABLED")
        -- self:RegisterEvent("PLAYER_REGEN_DISABLED")

        self:RegisterEvent("SPELLS_CHANGED")

        SLASH_NUGHEALTH1= "/nughealth"
        SLASH_NUGHEALTH2= "/nhe"
        SlashCmdList["NUGHEALTH"] = self.SlashCmd

		local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
		f:SetScript('OnShow', function(self)
			self:SetScript('OnShow', nil)

			if not NugHealth.optionsPanel then
				NugHealth.optionsPanel = NugHealth:CreateGUI()
			end
		end)
    end
end

function NugHealth.PLAYER_LOGOUT(self, event)
    ns.RemoveDefaults(NugHealthDB, defaults)
end

function NugHealth.PLAYER_LOGIN(self, event)
    -- self:UNIT_MAXHEALTH()
    self:UNIT_HEALTH()
    -- self:UNIT_AURA()
    if InCombatLockdown() or not NugHealthDB.hideOutOfCombat then
        self:Show()
    else
        self:Hide()
    end
end

function NugHealth.SPELLS_CHANGED(self, event)
    local _, class = UnitClass("player")
    local spec = GetSpecialization()
    if  NugHealthDB.allSpecs or
       ((class == "WARRIOR" and spec == 3) or
        (class == "DEATHKNIGHT" and spec == 1) or
        (class == "PALADIN" and spec == 2) or
        (class == "DRUID" and spec == 3) or
        (class == "DEMONHUNTER" and spec == 2) or
        (class == "MONK" and spec == 1))
    then
        self:Enable()
    else
        self:Disable()
    end
end

function NugHealth:Disable()
    self:UnregisterAllEvents()
    self:RegisterEvent("SPELLS_CHANGED")
    self:RegisterEvent("PLAYER_LOGOUT")
    self:SetScript("OnUpdate", nil)
    self:Hide()
    self.isDisabled = true
end

function NugHealth.ResolveOnUpdate(self, time)
    self._elapsed = (self._elapsed or 0) + time
    if self._elapsed < self.timeout then return true end
    self._elapsed = 0

    return self:PLAYER_RESOLVE_UPDATE()
end





local lastStagger
function NugHealth.StaggerOnUpdate(self, time)
    -- if NugHealth.ResolveOnUpdate(self, time) then return end
    local currentStagger = UnitStagger("player")
    --stagger updates like 2 times a second on average,
    if currentStagger ~= lastStagger then
        lastStagger = currentStagger

        return self:PLAYER_STAGGER_UPDATE(currentStagger)
    end
end

local staggerAverageTimeFrame = 15
local staggerHistory = {}
local function GetAverageStagger(timeframe)
    local timeLimit = GetTime() - (timeframe or 10)
    local acc = 0
    local numEntries = 0
    for ts, amount in pairs(staggerHistory) do
        if ts < timeLimit then
            staggerHistory[ts] = nil
        else
            numEntries = numEntries + 1
            acc = acc + amount
        end
    end
    if numEntries == 0 or acc == 0 then return 0 end
    return acc/numEntries
end

function NugHealth:PLAYER_RESOLVE_UPDATE()
    local uhm = UnitHealthMax("player")
    local currentResolve = NugHealth:GatherResolveDamage(5)
    local simpleDP5 = currentResolve/uhm --damage during past 5seconds relative to max health

    -- resolveMul is 100 / resolveLimit setting
    local resolve = simpleDP5 * resolveMul

    -- if showSpikes then
    --     staggerHistory[GetTime()] = currentResolve
    --     local averageResolve = GetAverageStagger(staggerAverageTimeFrame)

    --     local mod = 0
    --     local asp = 0
    --     if averageResolve ~= 0 then
    --         -- just showing difference between current stagger and average stagger
    --         mod = -(currentResolve - averageResolve)/uhm * resolveMul

    --         -- size of deviations multiplied by current Resolve
    --         -- mod = (1-(currentResolve/averageResolve)) * resolve
    --         -- mod = (1-(currentResolve/averageResolve)) * simpleResolve
    --         asp = averageResolve/uhm * resolveMul
    --     end

    --     self.trend:SetMod(mod, asp)
    -- end


    -- self.power:SetValue(resolve)
    -- if resolve == 0 then
    --     self.power:Hide()
    -- else
    --     self.power:Show()
    -- end
    -- self.power:SetColor(PercentColor(resolve*1.5))
    -- self.power:Extend(resolve)

    self.resolve:SetValue(resolve)
    self.resolve:SetStatusBarColor(PercentColor(resolve*1.5))
end

function NugHealth:PLAYER_STAGGER_UPDATE(currentStagger)
    local uhm = UnitHealthMax("player")
    local simpleStagger = (currentStagger/uhm)
    local stagger = simpleStagger * staggerMul


    if showSpikes then
        staggerHistory[GetTime()] = currentStagger
        local averageStagger = GetAverageStagger(staggerAverageTimeFrame)

        local mod = 0
        local asp = 0
        if averageStagger ~= 0 then
            -- just showing difference between current stagger and average stagger
            mod = -(currentStagger - averageStagger)/uhm * staggerMul

            -- unmodified deviations
            -- mod = (1-(currentStagger/averageStagger)) * 0.5

            -- size of deviations multiplied by current stagger
            -- mod = (1-(currentStagger/averageStagger)) * stagger
            -- mod = (1-(currentStagger/averageStagger)) * simpleStagger
            asp = averageStagger/uhm * staggerMul
        end

        self.trend:SetMod(mod, asp)
    end

    if stagger == 0 then
        self.stagger:Hide()
    else
        self.stagger:Show()
        self.stagger:SetValue(stagger)
        self.stagger:SetColor(PercentColor(stagger))
        self.stagger:Extend(stagger)
    end

    if not NugHealthDB.healthText then
        local htext = self.health.text
        if stagger > 0.9 then
            htext:Show()
            htext:SetText(math.floor(simpleStagger*100 + 0.5))
        else
            htext:Hide()
        end
    end
end


-- function NugHealth.UNIT_HEAL_PREDICTION(self, event, unit)
--     local heals, hm = UnitGetIncomingHeals(unit), UnitHealthMax(unit)
--     local h = UnitHealth(unit)
--     -- print(heals, heals/hm)

--     self.incoming:SetValue(heals/hm, h/hm)
-- end

function NugHealth.UNIT_ABSORB_AMOUNT_CHANGED(self, event, unit)
    local a,hm = UnitGetTotalAbsorbs(unit), UnitHealthMax(unit)
    local h = UnitHealth(unit)
    local ch, p = 0, 0
    if hm ~= 0 then
        p = a/hm
        ch = h/hm
    end
    self.absorb:SetValue(p, ch)
    self.absorb2:SetValue(p, ch)
end

function NugHealth:Enable()
    playerGUID = UnitGUID("player")

    NugHealthDB.useCLH = false
    --[[
    if LibCLHealth and NugHealthDB.useCLH then
        self:UnregisterEvent("UNIT_HEALTH")
        UnitHealth = LibCLHealth.UnitHealth
        LibCLHealth.RegisterCallback(self, "COMBAT_LOG_HEALTH", function(event, unit, eventType)
            return NugHealth:UNIT_HEALTH(eventType, unit)
        end)
    else
        self:RegisterUnitEvent("UNIT_HEALTH", "player")
        UnitHealth = UnitHealthOriginal
        if LibCLHealth then
            LibCLHealth.UnregisterCallback(self, "COMBAT_LOG_HEALTH")
        end
    end
    ]]
    self:RegisterUnitEvent("UNIT_HEALTH", "player")
    -- self:RegisterUnitEvent("UNIT_MAXHEALTH", "player")
    if not isClassic then
        self:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "player")
    end
    -- self:RegisterUnitEvent("UNIT_HEAL_PREDICTION", "player")


    if isMonk then
        self.timeout = 0.05
        self:SetScript("OnUpdate", NugHealth.StaggerOnUpdate)
        -- self.power:SetScript("OnUpdate",nil)
        -- self.power:SetMinMaxValues(0,1)
        -- self.power:SetValue(0)
        -- self.power.SetColor = MakeSetColor(0.1)
        -- self.power.auraname = GetSpellInfo(115307)
        -- self.power:SetColor(38/255, 221/255, 163/255)
        -- self.power:Show()

        -- self.power.auraname = GetSpellInfo(215479)
        -- self.power:SetColor(80/255, 83/255, 150/255)
        -- self:RegisterUnitEvent("UNIT_AURA", "player");
    elseif NugHealthDB.showResolve then
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self.timeout = 0.3
        self:SetScript("OnUpdate", NugHealth.ResolveOnUpdate)
    end

    -- if select(2, UnitClass"player") == "WARRIOR" then
    --     self.power.auraname = GetSpellInfo(132404)
    --     self.power:SetColor(80/255, 83/255, 150/255)
    --     self:RegisterUnitEvent("UNIT_AURA", "player");
    -- end

    -- if select(2, UnitClass"player") == "DEMONHUNTER" then
    --     self.power.auraname = GetSpellInfo(203819)
    --     self.power:SetColor(.7, 1, 0)
    --     self:RegisterUnitEvent("UNIT_AURA", "player");
    -- end

    -- if select(2, UnitClass"player") == "DEATHKNIGHT" then
    --     -- self.power.auraname = GetSpellInfo(171049)
    --     -- self.power:SetColor(.7, 0, 0)
    --     -- self:RegisterUnitEvent("UNIT_AURA", "player");
    -- end

    -- if select(2, UnitClass"player") == "PALADIN" then
    --     self.power.auraname = GetSpellInfo(132403)
    --     self.power:SetColor( 226/255, 35/255, 103/255 )
    --     self:RegisterUnitEvent("UNIT_AURA", "player");
    -- end

    -- if select(2, UnitClass"player") == "DRUID" then
    --     self.power.auraname = GetSpellInfo(192081)
    --     self.power:SetColor(.7, .2, .2)
    --     self:RegisterUnitEvent("UNIT_AURA", "player");
    -- end

    -- self:RegisterUnitEvent("UNIT_ATTACK_POWER", "player");
    -- self:RegisterUnitEvent("UNIT_RAGE", "player");

    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:PLAYER_LOGIN()
    self.isDisabled = nil
end

-- function NugHealth.UNIT_AURA(self, event)
--         local name, _,_, count, _, duration, expirationTime, caster, _,_, spellID = UnitAura("player", self.power.auraname, "HELPFUL")

--         if name then
--             self.power.startTime = expirationTime - duration
--             self.power.endTime = expirationTime
--             self.power:SetMinMaxValues(0, duration)
--             self.power:Show()
--         else
--             self.power:Hide()
--         end
-- end

local fgShowMissing = true
local function GetForegroundSeparation(health, healthMax, showMissing)
    if showMissing then
        return (healthMax - health)/healthMax, health/healthMax
    else
        return health/healthMax, health/healthMax
    end
end

local damageEffect = true
function NugHealth.UNIT_HEALTH(self, event)
    -- local h = UnitHealth("player")
    -- local mh = UnitHealthMax("player")
    -- local a = isClassic and 0 or UnitGetTotalAbsorbs("player")
    -- if mh == 0 then return end
    -- local vp = h/mh

    -- self.health:SetValue(vp)
    -- self.health.text:SetText(math.floor(vp*100 + 0.5))
    -- self.absorb:SetValue(a/mh, vp)
    -- self.absorb2:SetValue((h+a)/mh)
    -- if vp >= self.healthlost.currentvalue or not UnitAffectingCombat("player") then
    --     self.healthlost.currentvalue = vp
    --     self.healthlost.endvalue = vp
    --     self.healthlost:SetValue(vp)
    -- else
    --     self.healthlost.endvalue = vp
    -- end
    local unit = "player"
    local h,hm = UnitHealth(unit), UnitHealthMax(unit)
    local shields = UnitGetTotalAbsorbs(unit)
    local healabsorb = UnitGetTotalHealAbsorbs(unit)
    local incomingHeal = UnitGetIncomingHeals(unit)
    if hm == 0 or incomingHeal == nil then return end
    local foregroundValue, perc = GetForegroundSeparation(h, hm, fgShowMissing)
    local state = self.state
    -- state.vHealth = h
    -- state.vHealthMax = hm
    self.health:SetValue(foregroundValue*100)
    self.healabsorb:SetValue(healabsorb/hm, perc)
    self.absorb2:SetValue(shields/hm, perc)
    self.absorb:SetValue(shields/hm, perc)
    self.health.incoming:SetValue(incomingHeal/hm, perc)
    self.health.lost:SetNewHealthTarget(perc, perc)

    if damageEffect then
        local diff = perc - (state.healthPercent or perc)
        local flashes = state.flashes
        if not flashes then
            state.flashes = {}
            flashes = state.flashes
        end

        if diff < -0.02 then -- Damage taken is more than 2%
            local flash = self.flashPool:Acquire()
            local oldPerc = perc + (-diff)
            if self.flashPool:FireEffect(flash, diff, perc, state, oldPerc) then
                flashes[oldPerc] = flash
            end
        elseif diff > 0 then -- Heals
            for oldPerc, flash in pairs(flashes) do
                if perc >= oldPerc then
                    self.flashPool:StopEffect(flash)
                end
            end
        end
    end
    state.healthPercent = perc

    self.health.text:SetText(math.floor(perc*100 + 0.5))

    -- if NugHealthDB.lowhpFlash then
    --     if vp < 0.2 then
    --         self.glowanim:SetDuration(0.2)
    --         if not self.glow:IsPlaying() then
	-- 			if NugHealthDB.lowhpcolor then self.health:SetColor(1,.1,.1) end
    --             self.glowanim.pending_stop = false
    --             self.glow:Play()
    --         end
    --     elseif vp < 0.35 then
    --         self.glowanim:SetDuration(0.4)

    --         if not self.glow:IsPlaying() then
	-- 			if NugHealthDB.lowhpcolor then self.health:SetColor(.9,0,0) end
    --             self.glowanim.pending_stop = false
    --             self.glow:Play()
    --         end
    --     else
    --         if self.glow:IsPlaying() then
	-- 			self.health:RestoreColor()
    --             self.glowanim.pending_stop = true
    --         end
    --     end
    -- end
end

-- function NugHealth.UNIT_MAXHEALTH(self, event)
--     local max = UnitHealthMax("player")
--     self.healthmax = max
--     self.health:SetMinMaxValues(0, max)
--     self.healthlost:SetMinMaxValues(0, max)
--     -- self.power:SetMinMaxValues(0, max)
-- end


local doFadeOut = true
local fadeAfter = 3
local fadeTime = 1
local fader = CreateFrame("Frame", nil, NugHealth)
NugHealth.fader = fader
local HideTimer = function(self, time)
    self.OnUpdateCounter = (self.OnUpdateCounter or 0) + time
    if self.OnUpdateCounter < fadeAfter then return end

    local nhe = NugHealth
    local p = fadeTime - ((self.OnUpdateCounter - fadeAfter) / fadeTime)
    -- if p < 0 then p = 0 end
    -- local ooca = NugHealthDB.outOfCombatAlpha
    -- local a = ooca + ((1 - ooca) * p)
    local pA = NugHealthDB.outOfCombatAlpha
    local rA = 1 - NugHealthDB.outOfCombatAlpha
    local a = pA + (p*rA)
    nhe:SetAlpha(a)
    if self.OnUpdateCounter >= fadeAfter + fadeTime then
        self:SetScript("OnUpdate",nil)
        if nhe:GetAlpha() <= 0.03 then
            nhe:Hide()
        end
        nhe.hiding = false
        self.OnUpdateCounter = 0
    end
end
function NugHealth:StartHiding()
    if (not self.hiding and self:IsVisible())  then
        fader:SetScript("OnUpdate", HideTimer)
        fader.OnUpdateCounter = 0
        self.hiding = true
    end
end

function NugHealth:StopHiding()
    -- if self.hiding then
        fader:SetScript("OnUpdate", nil)
        self:SetAlpha(1)
        self.hiding = false
    -- end
end

function NugHealth.PLAYER_REGEN_DISABLED(self, event)
    self:StopHiding()
    self:Show()
end
function NugHealth.PLAYER_REGEN_ENABLED(self, event)
    if NugHealthDB.hideOutOfCombat then
        -- self:Hide()
        self:StartHiding()
    end
end





local ParseOpts = function(str)
    local t = {}
    local capture = function(k,v)
        t[k:lower()] = tonumber(v) or v
        return ""
    end
    str:gsub("(%w+)%s*=%s*%[%[(.-)%]%]", capture):gsub("(%w+)%s*=%s*(%S+)", capture)
    return t
end
NugHealth.Commands = {
    ["unlock"] = function(v)
        NugHealth:EnableMouse(true)
        NugHealth:Show()
    end,
	["gui"] = function(v)
        local self = NugHealth
		if not self.optionsPanel then
			self.optionsPanel = self:CreateGUI()
		end
		InterfaceOptionsFrame_OpenToCategory (self.optionsPanel)
		InterfaceOptionsFrame_OpenToCategory (self.optionsPanel)
    end,
    ["resolvelimit"] = function(v, silent)
        local num = tonumber(v)
        if not num or num < 5 or num > 300 then
            num = 180
            print('correct range is 5-500')
        end
        NugHealthDB.resolveLimit = num
        resolveMul = 100/NugHealthDB.resolveLimit
        if not silent then print("New resolve limit =", num) end
    end,
    ["staggerlimit"] = function(v, silent)
        local num = tonumber(v)
        if not num or num < 5 or num > 100 then
            num = defaults.staggerLimit
            print('correct range is 10-500')
        end
        NugHealthDB.staggerLimit = num
        staggerMul = 100/NugHealthDB.staggerLimit
        if not silent then print("New stagger limit =", num) end
    end,
    ["classcolor"] = function(v)
        NugHealthDB.classcolor = not NugHealthDB.classcolor
        NugHealth.health:RestoreColor()
    end,
    ["staggerspikes"] = function(v)
        NugHealthDB.showStaggerSpikes = not NugHealthDB.showStaggerSpikes
        showSpikes = NugHealthDB.showResolveSpikes
        if isMonk then
            showSpikes = NugHealthDB.showStaggerSpikes
        end
        if not showSpikes then
            NugHealth.trend:Hide()
        end
    end,
    ["resolvespikes"] = function(v)
        NugHealthDB.showResolveSpikes = not NugHealthDB.showResolveSpikes
        showSpikes = NugHealthDB.showResolveSpikes
        if isMonk then
            showSpikes = NugHealthDB.showStaggerSpikes
        end
        if not showSpikes then
            NugHealth.trend:Hide()
        end
    end,
	["lowhpcolor"] = function(v)
        NugHealthDB.lowhpcolor = not NugHealthDB.lowhpcolor
        lowhpcolor = NugHealthDB.lowhpcolor
    end,

    ["healthcolor"] = function(v)
        ColorPickerFrame:Hide()
        ColorPickerFrame:SetColorRGB(unpack(NugHealthDB.healthcolor))
        ColorPickerFrame.hasOpacity = false
        ColorPickerFrame.previousValues = {unpack(NugHealthDB.healthcolor)} -- otherwise we'll get reference to changed table
        ColorPickerFrame.func = function(previousValues)
            local r,g,b
            if previousValues then
                r,g,b = unpack(previousValues)
            else
                r,g,b = ColorPickerFrame:GetColorRGB();
            end
            NugHealthDB.healthcolor[1] = r
            NugHealthDB.healthcolor[2] = g
            NugHealthDB.healthcolor[3] = b
            NugHealth.health:SetColor(r,g,b)
        end
        ColorPickerFrame.cancelFunc = ColorPickerFrame.func
        ColorPickerFrame:Show()
    end,
    ["lock"] = function(v)
        NugHealth:EnableMouse(false)
        local self = NugHealth
        if InCombatLockdown() or not NugHealthDB.hideOutOfCombat then
            self:Show()
        else
            self:Hide()
        end
    end,

    ["resolve"] = function(v, silent)
        NugHealthDB.showResolve = not NugHealthDB.showResolve
        if not silent then print("show resolve :", NugHealthDB.showResolve) end
        NugHealth:SPELLS_CHANGED()
    end,

    ["allspecs"] = function(v, silent)
        NugHealthDB.allSpecs = not NugHealthDB.allSpecs
        NugHealth:SPELLS_CHANGED()
    end,


    --[[
    ["useclh"] = function(v)
        NugHealthDB.useCLH = not NugHealthDB.useCLH
        if NugHealthDB.useCLH then
            UnitHealth = UnitHealthOriginal
            NugHealth:RegisterUnitEvent("UNIT_HEALTH", "player")
            LibCLHealth.UnregisterCallback(NugHealth, "COMBAT_LOG_HEALTH")
            print("Fast health updates enabled")
        else
            NugHealth:UnregisterEvent("UNIT_HEALTH")
            UnitHealth = LibCLHealth.UnitHealth
            LibCLHealth.RegisterCallback(NugHealth, "COMBAT_LOG_HEALTH", function(event, unit, eventType)
                return NugHealth:UNIT_HEALTH(eventType, unit)
            end)
            print("Fast health updates disabled")
        end
    end,
    ]]
    -- ["set"] = function(v)
        -- local p = ParseOpts(v)
    -- end
}

function NugHealth.SlashCmd(msg)
    local k,v = string.match(msg, "([%w%+%-%=]+) ?(.*)")
    if not k or k == "help" then
        print([[Usage:
          |cff55ffff/nhe unlock|r
          |cff55ff55/nhe lock|r
          |cffffaaaa/nhe gui|r
          |cff55ff22/nhe useclh - use LibCombatLogHealth
          |cff55ff22/nhe classcolor
          |cff55ff22/nhe healthcolor - use custom color
          |cff55ff22/nhe lowhpcolor
          |cff55ff22/nhe resolve - toggle recent dmg taken|r
          |cff55ff22/nhe resolvelimit <5-500> - damage taken in last 5 sec relative to X max health percent
          |cff55ff22/nhe staggerlimit <10-500> - upper limit of stagger bar in player max health percent|r]]
        )
    end
    if NugHealth.Commands[k] then
        NugHealth.Commands[k](v)
    end
end

do
    local damageHistory = {}
    local math_floor = math.floor
    local roundToInteger = function(v) return math_floor(v*10+.1) end

    function NugHealth:COMBAT_LOG_EVENT_UNFILTERED(event)

        local timestamp, eventType, hideCaster,
        srcGUID, srcName, srcFlags, srcFlags2,
        dstGUID, dstName, dstFlags, dstFlags2,
        arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = CombatLogGetCurrentEventInfo()

        if dstGUID == playerGUID then
            local amount
            if(eventType == "SWING_DAMAGE") then --autoattack
                amount = arg1; -- putting in braces will autoselect the first arg, no need to use select(1, ...);
            elseif(eventType == "SPELL_PERIODIC_DAMAGE" or eventType == "SPELL_DAMAGE"
            or eventType == "DAMAGE_SPLIT" or eventType == "DAMAGE_SHIELD") then
                amount = arg4
            elseif(eventType == "ENVIRONMENTAL_DAMAGE") then
                amount = arg2
            -- elseif(eventType == "SPELL_HEAL" or eventType == "SPELL_PERIODIC_HEAL") then
            --     amount = select(4, ...) - select(5, ...) -- heal amount - overheal
            --     if amount == 0 then return end
            elseif(eventType == "SPELL_ABSORBED") then
				amount = arg11 or arg8
            end

            if amount then
				-- ChatFrame4:AddMessage(string.format("DAMAGE: %d", amount))
                local ts = roundToInteger(GetTime())
                if not damageHistory[ts] then
                    damageHistory[ts] = amount
                else
                    damageHistory[ts] = damageHistory[ts] + amount
                end
            end
        end
    end


    local lastCheckTime = 0
    local lastAmount
    function NugHealth:GatherResolveDamage(t)
        local timeframeBorder = roundToInteger(GetTime()-t)
        local acc = 0
        if timeframeBorder == lastCheckTime then return lastAmount end

        for ts, amount in pairs(damageHistory) do
            if ts < timeframeBorder then
                damageHistory[ts] = nil
            else
                acc = acc + amount
            end
        end
        lastCheckTime = timeframeBorder
        lastAmount = acc

        return acc
    end
end


function NugHealth:CreateGUI()
	local opt = {
        type = 'group',
        name = "NugHealth Settings",
        order = 1,
        args = {
			unlock = {
				name = "Unlock",
				type = "execute",
				desc = "Unlock anchor for dragging",
				func = function() NugHealth.Commands.unlock() end,
				order = 1,
			},
			lock = {
				name = "Lock",
				type = "execute",
				desc = "Lock anchor",
				func = function() NugHealth.Commands.lock() end,
				order = 2,
			},
            anchors = {
                type = "group",
                name = " ",
                guiInline = true,
                order = 3,
                args = {
					classColor = {
                        name = "Class Color",
                        type = "toggle",
                        get = function(info) return NugHealthDB.classcolor end,
                        set = function(info, v)
							NugHealthDB.classcolor = not NugHealthDB.classcolor
							NugHealth.health:RestoreColor()
						end,
                        order = 1,
                    },
					customcolor = {
                        name = "Custom Color",
                        type = 'color',
						order = 2,
                        get = function(info)
							local r,g,b = unpack(NugHealthDB.healthcolor)
                            return r,g,b
                        end,
                        set = function(info, r, g, b)
							NugHealthDB.classcolor = false
                            NugHealthDB.healthcolor = {r,g,b}
							NugHealth.health:RestoreColor()
                        end,
                    },
                    lowhpcolor = {
                        name = "Low HP Color",
                        type = "toggle",
                        desc = "Change healthbar color when below 35%",
                        get = function(info) return NugHealthDB.lowhpcolor end,
                        set = function(info, v) NugHealth.Commands.lowhpcolor(v, true) end,
                        order = 3,
                    },
                    resolve = {
                        name = "Resolve",
                        type = "toggle",
                        -- width = "full",
                        desc = "Damage taken in the last 5 sec",
                        get = function(info) return NugHealthDB.showResolve end,
                        set = function(info, v) NugHealth.Commands.resolve(nil, true) end,
                        order = 4,
                    },
                    -- resolveSpikes = {
                    --     name = "Show Resolve Spikes",
                    --     type = "toggle",
                    --     desc = "Shows difference between current resolve and the average for the last 10s",
                    --     get = function(info) return NugHealthDB.showResolveSpikes end,
                    --     set = function(info, v) NugHealth.Commands.resolvespikes() end,
                    --     order = 4.1,
                    -- },
					resolveLimit = {
                        name = "Resolve Limit",
                        type = "range",
						desc = "Damage taken in last 5 sec relative to X max health percent",
						width = "double",
                        get = function(info) return NugHealthDB.resolveLimit end,
                        set = function(info, v)
							NugHealth.Commands.resolvelimit(v, true)
						end,
                        min = 10,
                        max = 500,
                        step = 10,
                        order = 5,
                    },
					staggerSpikes = {
                        name = "Show Stagger Spikes",
                        type = "toggle",
                        -- desc = "Shows difference between current resolve and the average for the last 10s",
                        get = function(info) return NugHealthDB.showStaggerSpikes end,
                        set = function(info, v) NugHealth.Commands.staggerspikes() end,
                        order = 6.1,
                    },
					staggerLimit = {
                        name = "Stagger Limit",
                        type = "range",
						desc = "Upper limit of Monk's Stagger bar in player max health percent",
						width = "double",
                        get = function(info) return NugHealthDB.staggerLimit end,
                        set = function(info, v)
							NugHealth.Commands.staggerlimit(v, true)
						end,
                        min = 20,
                        max = 300,
                        step = 10,
                        order = 7,
                    },

                    hideOutOfCombat = {
                        name = "Hide Out of Combat",
                        type = "toggle",
                        width = "full",
                        get = function(info) return NugHealthDB.hideOutOfCombat end,
                        set = function(info, v)
                            NugHealthDB.hideOutOfCombat = not NugHealthDB.hideOutOfCombat
                            NugHealth:PLAYER_LOGIN()
                        end,
                        order = 7.6,
                    },

                    healthTextSize = {
                        name = "Health Text Size",
                        type = "range",
                        get = function(info) return NugHealthDB.healthTextSize end,
                        set = function(info, v)
                            NugHealthDB.healthTextSize = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 5,
                        max = 30,
                        step = 1,
                        order = 7.7,
                    },
                    healthTextOffset = {
                        name = "Health Text Offset",
                        type = "range",
                        get = function(info) return NugHealthDB.healthTextOffset end,
                        set = function(info, v)
                            NugHealthDB.healthTextOffset = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 0,
                        max = 400,
                        step = 1,
                        order = 7.8,
                    },

                    healthText = {
                        name = "Show Health Percentage",
                        type = "toggle",
                        get = function(info) return NugHealthDB.healthText end,
                        set = function(info, v)
                            NugHealthDB.healthText = not NugHealthDB.healthText
                            NugHealth:Resize()
                        end,
                        order = 7.9,
                    },

                    width = {
                        name = "Width",
                        type = "range",
                        get = function(info) return NugHealthDB.width end,
                        set = function(info, v)
                            NugHealthDB.width = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 10,
                        max = 120,
                        step = 1,
                        order = 8,
                    },
                    height = {
                        name = "Height",
                        type = "range",
                        get = function(info) return NugHealthDB.height end,
                        set = function(info, v)
                            NugHealthDB.height = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 30,
                        max = 250,
                        step = 1,
                        order = 9,
                    },
                    absorb_width = {
                        name = "Absorb Width",
                        type = "range",
                        get = function(info) return NugHealthDB.absorb_width end,
                        set = function(info, v)
                            NugHealthDB.absorb_width = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 2,
                        max = 12,
                        step = 1,
                        order = 10,
                    },
                    stagger_width = {
                        name = "Stagger Width",
                        type = "range",
                        get = function(info) return NugHealthDB.stagger_width end,
                        set = function(info, v)
                            NugHealthDB.stagger_width = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 2,
                        max = 20,
                        step = 1,
                        order = 11,
                    },
                    spike_width = {
                        name = "Spike Width",
                        type = "range",
                        get = function(info) return NugHealthDB.spike_width end,
                        set = function(info, v)
                            NugHealthDB.spike_width = tonumber(v)
                            NugHealth:Resize()
                        end,
                        min = 2,
                        max = 12,
                        step = 1,
                        order = 12,
                    },
                    orientation = {
                        name = "Health Orientation",
                        type = 'select',
                        order = 12.5,
                        values = {
                            ["HORIZONTAL"] = "Horizontal",
                            ["VERTICAL"] = "Vertical",
                        },
                        get = function(info) return NugHealthDB.healthOrientation end,
                        set = function( info, v )
                            NugHealthDB.healthOrientation = v
                            NugHealth:Resize()
                        end,
                    },
                    allSpecs = {
                        name = "Show for all specializations",
                        type = "toggle",
                        width = "full",
                        desc = "not just tanks",
                        get = function(info) return NugHealthDB.allSpecs end,
                        set = function(info, v) NugHealth.Commands.allspecs() end,
                        order = 13,
                    },
                },
            }, --
        },
    }

	local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
    AceConfigRegistry:RegisterOptionsTable("NugHealthOptions", opt)

    local AceConfigDialog = LibStub("AceConfigDialog-3.0")
    local panelFrame = AceConfigDialog:AddToBlizOptions("NugHealthOptions", "NugHealth")

    return panelFrame
end

function ns.MakeSetColor(mul)
    return function(self, r,g,b)
        self:SetStatusBarColor(r,g,b)
        self.bg:SetVertexColor(r*mul,g*mul,b*mul)
    end
end

function ns.SetupDefaults(t, defaults)
    for k,v in pairs(defaults) do
        if type(v) == "table" then
            if t[k] == nil then
                t[k] = CopyTable(v)
            else
                ns.SetupDefaults(t[k], v)
            end
        else
            if t[k] == nil then t[k] = v end
        end
    end
end
function ns.RemoveDefaults(t, defaults)
    for k, v in pairs(defaults) do
        if type(t[k]) == 'table' and type(v) == 'table' then
            ns.RemoveDefaults(t[k], v)
            if next(t[k]) == nil then
                t[k] = nil
            end
        elseif t[k] == v then
            t[k] = nil
        end
    end
    return t
end

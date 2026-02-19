local addonName, ns = ...
---Libraries
local lib = LibStub("FerrozEditModeLib-1.0")
-- Constants
local FRAME_SIZE = 42                    -- Standard action button size
local TEXCOORD_LEFT = 0.08               -- Texture coordinate crop (WeakAura style)
local TEXCOORD_RIGHT = 0.92
local COUNT_FONT_SIZE = 12               -- Font size for charge count
local TIMER_FONT_SIZE = 16               -- Font size for timer text
local PREVIEW_TIMER = 599                -- Realistic preview timer (10-minute cooldown)
local PREVIEW_CHARGES = 3              -- Preview charge count for Edit Mode
local FERROZ_COLOR = CreateColorFromHexString("ff8FB8DD")
local log = lib.Log
local DEFAULT_STATE = {
    height=FRAME_SIZE,
    width=FRAME_SIZE
}

local REBIRTH_SPELL_ID = 20484           -- SpellID for Rebirth spell icon
local FALLBACK_ICON = 136048
local BATTLE_REZ_ICONS = {
    [20484]  = {order=1, label="Rebirth (Druid)"},
    [61999]  = {order=2, label="Raise Allied (Deathknight)"},
    [95750]  = {order=3, label="Soulstone (Warlock)"},
    [391054] = {order=4, label="Intercession (Paladin)"},
}

-- show mode boolean
local showMode = false
-- Test mode variables
local testMode = false
local testCount = PREVIEW_CHARGES
local testExpirationTime = PREVIEW_TIMER  -- 0 = no timer, > 0 = recharging

-- Cache globals for peak performance
local GetTime = GetTime
local math_floor = math.floor
local math_max = math.max
local C_Timer = C_Timer

---------------------------------------------------------
-- MIXINS 
---------------------------------------------------------
BRT_Mixin = {}

-- boolean whether tracker should be visible
function BRT_Mixin:ShouldShowTracker()
    -- Always show in Edit Mode or Test Mode
    if showMode or testMode or self.isEditing then return true end

    -- Check if we are in a Raid or Mythic+
    local _, instanceType = GetInstanceInfo()
    local isMythicPlus = C_ChallengeMode.GetActiveKeystoneInfo() > 0

    -- Return true if in Raid, Mythic+, or a Delve
    return (instanceType == "raid") or isMythicPlus or (instanceType == "scenario")
end
--updates visibility, only happens outside of comat
function BRT_Mixin:UpdateZoneVisibility()
    if InCombatLockdown() then return end
    if not self:ShouldShowTracker() then
        self:Hide()
    else
        self:Show()
    end
end
--updates display when something changes
function BRT_Mixin:UpdateDisplay()
    -- Preview behavior for Edit Mode
    if EditModeManagerFrame and EditModeManagerFrame:IsEditModeActive() then
        return
    end

    -- Test mode: use simulated data
    local chargesTable, currentCharges, startTime, duration = nil,0,0,0
    if testMode then
        currentCharges = testCount
        duration = testExpirationTime
        startTime = GetTime()
    else 
        chargesTable = C_Spell.GetSpellCharges(20484)
        if chargesTable then
            currentCharges = chargesTable.currentCharges or 0
            startTime = chargesTable.cooldownStartTime or 0
            duration = chargesTable.cooldownDuration or 0
        end
    end
    
    if  currentCharges then
        self.countText:SetFormattedText("%d", currentCharges)
        --don't changes visuals (alpha/saturation) to avoid taint
    else
        self.countText:SetFormattedText("%d", 0)
        --don't changes visuals (alpha/saturation) to avoid taint
    end

    if InCombatLockdown() then
        --always show in combat, if the frame is otherwise shown
        self.countText:SetAlpha(1.0)
    else
        --out of combat, only show the charge count if charges > 0.  
        --Since this is secret, and alpha is clamped, this is a workaround for the fact that I can't check currentCharges > 0
        self.countText:SetAlpha(currentCharges)
    end

    -- Update the Cooldown Swipe/Timer
    if startTime and duration then
        --self.cd:SetCooldownFromExpirationTime(startTime, duration)
        self.cd:SetCooldown(startTime, duration)
        self.cd:SetHideCountdownNumbers(false)
        self.cd:SetCountdownAbbrevThreshold(3600)
    else
        self.cd:Clear() -- Stops the visual timer
    end
end

function BRT_Mixin:EditModeStartMock()
    self.countText:SetText(PREVIEW_CHARGES)
    self.cd:SetCooldown(GetTime(), PREVIEW_TIMER)
    self:UpdateZoneVisibility()
end

function BRT_Mixin:EditModeStopMock()
    self.cd:Clear()
    self:UpdateZoneVisibility()
    self:UpdateDisplay() -- Returns to real combat data
end

--frame specific configuration
function BRT_Mixin:UpdateIcon(spellId)
    local spellInfo = C_Spell.GetSpellInfo(spellId or REBIRTH_SPELL_ID)
    local changed = self.icon.spellId ~= spellId
    self.icon.spellId = spellId
    self.icon:SetTexture(spellInfo.iconID or FALLBACK_ICON)
    return changed
end
function BRT_Mixin:GetOrCreateFrameSpecificControls(socket)
    if not self.frameSpecificPlugin then
        local p = CreateFrame("Frame", nil, self, "VerticalLayoutFrame")
        p.fixedWidth = lib.CONFIG_FRAME_WIDTH
        p.spacing = lib.CONFIG_ROW_SPACING 
        self.frameSpecificPlugin = p
        self.extraControls = {}
        lib:AddHR(p)
        self.extraControls.battleRezSpellId = lib:CreateSpellIconSelector(p, "Icon", "battleRezSpellId",BATTLE_REZ_ICONS, lib.CONFIG_ROW_LABEL_WIDTH *2)
        if BRT_Settings then
            local spell = BATTLE_REZ_ICONS[BRT_Settings.battleRezSpellId or REBIRTH_SPELL_ID]
            self.extraControls.battleRezSpellId:SetText(spell and spell.label or "Unknown" )
        end
        p:Layout()
    end
    return self.extraControls, self.frameSpecificPlugin
end

function BRT_Mixin:CommitFrameSpecificFields()
    if not self.workingState then return end
    BRT_Settings.battleRezSpellId = self.workingState.battleRezSpellId
end

function BRT_Mixin:UpdateFromState(state)
    local changed = false
    if state.battleRezSpellId then
        changed = self:UpdateIcon(state.battleRezSpellId) or changed
    end
    return changed
end

function BRT_Mixin:GetFrameSpecificSnapshot()
    return {
        battleRezSpellId = self.icon.spellId ,
    }
end

function BRT_Mixin:OnConfigRefresh(configFrame, state)
    local controls = configFrame.frameSpecificControls
    if controls and controls.battleRezSpellId and state.battleRezSpellId then
        local spell = BATTLE_REZ_ICONS[state.battleRezSpellId]
        self.extraControls.battleRezSpellId:SetText(spell and spell.label or "Unknown")
    end
end

--initialization
local function InitializeBattleRezTracker()
    BRT_Settings = BRT_Settings or {}
    BRT_Settings.layouts = BRT_Settings.layouts or {}
    --Create Frame
    local f = CreateFrame("Frame", "BattleRezTracker", UIParent, "SecureHandlerStateTemplate")
    Mixin(f, BRT_Mixin)
    f:SetSize(FRAME_SIZE, FRAME_SIZE)
    f:SetPoint("CENTER", UIParent, "CENTER")
    f:SetFrameStrata("MEDIUM")
    f:SetClampedToScreen(true)

    --Icon (Rebirth)
    f.icon = f:CreateTexture(nil, "BACKGROUND")
    f.icon:SetAllPoints(f)
    -- Get the icon texture dynamically from the spell data
    f:UpdateIcon(BRT_Settings.battleRezSpellId)
    f.icon:SetTexCoord(TEXCOORD_LEFT, TEXCOORD_RIGHT, TEXCOORD_LEFT, TEXCOORD_RIGHT)

    --Timer Text (Centered)
    f.cd = CreateFrame("Cooldown", nil, f, "CooldownFrameTemplate")
    f.cd:SetFrameLevel(f:GetFrameLevel() + 1)
    f.cd:SetDrawSwipe(false)
    f.cd:SetCountdownAbbrevThreshold(3600)
    f.cd:SetPoint("TOPLEFT", f, "TOPLEFT",0,0)
    f.cd:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",0,6)
    f.cd:SetHideCountdownNumbers(false)

    --Charge Count (Bottom Right)
    f.countText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightOutline")
    f.countText:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
    f.countText:SetFont(f.countText:GetFont(), COUNT_FONT_SIZE, "OUTLINE")

    if lib then
        lib:Register(f, BRT_Settings,DEFAULT_STATE)
    end

    local version = C_AddOns.GetAddOnMetadata(addonName, "Version") or "1.0.0"
    print(FERROZ_COLOR:WrapTextInColorCode("[BattleRezTracker] v" .. version) .. " loaded (/brt)")

    --Event Handling
    f:RegisterEvent("PLAYER_ENTERING_WORLD") 
    f:RegisterEvent("SPELL_UPDATE_CHARGES")  -- Fires when a charge is used or gained
    f:RegisterEvent("PLAYER_REGEN_DISABLED") -- Entering Combat
    f:RegisterEvent("CHALLENGE_MODE_START")  -- Specifically for Mythic+ starts

    f:SetScript("OnEvent", function(self, event)
        self:UpdateDisplay()
    end)

    --initial values for full and dimmed states
    f:SetAttribute("alpha-full", 1.0)
    f:SetAlpha(0.5)

    --handle setting alpha in combat taint free
    RegisterStateDriver(f, "rez-alpha", "[combat] active; inactive")
    f:SetAttribute("_onstate-rez-alpha", [[ 
        local activeAlpha = self:GetAttribute("alpha-full") or 1
        local inactiveAlpha = activeAlpha / 2
        self:SetAlpha(newstate == "active" and activeAlpha or inactiveAlpha)
    ]])


    f.zoneVisibilityManager = CreateFrame("Frame")
    f.zoneVisibilityManager:RegisterEvent("PLAYER_ENTERING_WORLD") 
    f.zoneVisibilityManager:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Leaving Combat
    f.zoneVisibilityManager:RegisterEvent("ZONE_CHANGED_NEW_AREA") -- Triggered when loading into a dungeon/raid
    f.zoneVisibilityManager:RegisterEvent("CHALLENGE_MODE_START")  -- Specifically for Mythic+ starts
    f.zoneVisibilityManager:SetScript("OnEvent", function(self, event)
        f:UpdateZoneVisibility()
    end)
end

-- Slash commands for testing
SLASH_BATTLEREZTRACKER1 = "/brt"
SLASH_BATTLEREZTRACKER2 = "/battlereztracker"
SlashCmdList["BATTLEREZTRACKER"] = function(msg)
    local cmd, arg = msg:match("^(%S*)%s*(.-)$")
    cmd = cmd:lower()
    
    if cmd == "reset" then
        lib:ResetPosition(BattleRezTracker)
        BattleRezTracker:UpdateDisplay()
        print(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Position and Scale have been reset.")
    elseif cmd == "test" then
        testMode = not testMode
        local status = testMode and "ENABLED" or "DISABLED"
        print(string.format(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Test mode %s", status))
        if testMode then
            print(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Use /brt count # to set test charges")
            print(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Use /brt timer # to set test timer (seconds, 0 to clear)")
        end
        BattleRezTracker:UpdateZoneVisibility()
        BattleRezTracker:UpdateDisplay()
    elseif cmd == "show" then
        showMode = not showMode
        local status = showMode and "ENABLED" or "DISABLED"
        print(string.format(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Show mode %s", status))
        BattleRezTracker:UpdateZoneVisibility()
        BattleRezTracker:UpdateDisplay()
    elseif cmd == "refresh" then
        print("force refresh")
        BattleRezTracker:UpdateDisplay()
    elseif cmd == "count" and tonumber(arg) then
        testCount = math_max(0, tonumber(arg))
        print(string.format(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Test charges set to %d", testCount))
        if testMode then
            BattleRezTracker:UpdateDisplay()
        end
    elseif cmd == "timer" and tonumber(arg) then
        local seconds = tonumber(arg)
        testExpirationTime = math_max(0, seconds)
        if testExpirationTime > 0 then
            print(string.format(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Test timer set to %d seconds", testExpirationTime))
        else
            print(FERROZ_COLOR:WrapTextInColorCode("[BRT]:").." Test timer cleared")
        end
        if testMode then
            BattleRezTracker:UpdateDisplay()
        end
    else
        print(FERROZ_COLOR:WrapTextInColorCode("Battle Rez Tracker Commands:"))
        print("  /brt reset - Reset position to center and scale to 1.0")
        print("  /brt show - Toggle show mode (shows even when not in M+ or raid)")
        print("  /brt test - Toggle test mode (simulates battle rez data)")
        print("  /brt count # - Set test charge count (e.g., /brt count 2)")
        print("  /brt timer # - Set test timer in seconds (e.g., /brt timer 300 for 5 min, 0 to clear)")
        BattleRezTracker:UpdateDisplay()
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, name)
    if name == addonName then
        InitializeBattleRezTracker()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

--[[----------------------------------------------------------------------------

  LiteMount/Actions.lua

  Mounting actions.

  Copyright 2011-2020 Mike Battersby

----------------------------------------------------------------------------]]--

--[===[@debug@
if LibDebug then LibDebug() end
--@end-debug@]===]

local function ReplaceVars(list)
    local out = {}
    for _,l in ipairs(list) do
        l = LM_Vars:StrSubVars(l)
        tinsert(out, l)
    end
    return out
end

local FLOWCONTROLS = { }

FLOWCONTROLS['IF'] =
    function (args, env, isTrue)
        table.insert(env.flowControl, isTrue)
    end

FLOWCONTROLS['ELSIF'] =
    function (args, env, isTrue)
        table.remove(env.flowControl)
        table.insert(env.flowControl, isTrue)
    end

FLOWCONTROLS['ELSE'] =
    function (args, env, isTrue)
        local n = #env.flowConrol
        env.flowControl[n] = not env.flowControl[n]
    end

FLOWCONTROLS['END'] =
    function (args, env, isTrue)
        table.remove(env.flowControl)
    end

local ACTIONS = { }

-- Modifies the list of usable mounts so action list lines after this one
-- get the restricted list. Always returns no action.

ACTIONS['Limit'] =
    function (args, env)
        args = ReplaceVars(args)
        table.insert(env.mounts, 1, env.mounts[1]:FilterSearch(unpack(args)))
        LM_Debug(format(" - limit from %d to %d", #env.mounts[2], #env.mounts[1]))
    end

ACTIONS['Endlimit'] =
    function (args, env)
        if #env.mounts == 1 then return end
        table.remove(env.mounts, 1)
    end

local function GetKnownSpell(arg)
    -- You can look up any spell from any class by number so we have to
    -- test numbers to see if we know them
    local spellID = tonumber(arg)
    if spellID and not IsSpellKnown(spellID) then
        return
    end

    -- For names, GetSpellInfo returns nil if it's not in your spellbook
    -- so we don't need to call IsSpellKnown
    local name, _, _, _, _, _, spellID = GetSpellInfo(arg)
    if name and IsUsableSpell(name) then
        return name, spellID
    end
end

ACTIONS['Spell'] =
    function (args, env)
        for _, arg in ipairs(args) do
            LM_Debug(' - trying spell: ' .. tostring(arg))
            local name, id = GetKnownSpell(arg)
            if name and IsUsableSpell(name) and GetSpellCooldown(name) == 0 then
                LM_Debug(" - setting action to spell " .. name)
                return LM_SecureAction:Spell(name, env.unit)
            end
        end
    end

-- In vehicle -> exit it
ACTIONS['LeaveVehicle'] =
    function (args, env)
        --[[
        if UnitOnTaxi("player") then
            LM_Debug(" - setting action to TaxiRequestEarlyLanding")
            return LM_SecureAction:Click(MainMenuBarVehicleLeaveButton)
        elseif CanExitVehicle() then
        ]]
        if CanExitVehicle() then
            LM_Debug(" - setting action to leavevehicle")
            return LM_SecureAction:Macro(SLASH_LEAVEVEHICLE1)
        end
    end

-- Mounted -> dismount
ACTIONS['Dismount'] =
    function (args, env)
        if not IsMounted() then return end

        LM_Debug(" - setting action to dismount")
        return LM_SecureAction:Macro(SLASH_DISMOUNT1)
    end

-- Only cancel forms that we will activate (mount-style ones).
-- See: https://wow.gamepedia.com/API_GetShapeshiftFormID
-- Form IDs that you put here must be cancelled automatically on
-- mounting.

local savedFormName
local restoreFormIDs = {
    [1] = true,     -- Cat Form
    [5] = true,     -- Bear Form
    [31] = true,    -- Moonkin Form
}

-- This is really two actions in one but I didn't want people to have to
-- modify their custom action lists. It should really be CancelForm and
-- SaveForm separately, although then they need to be in that exact order so
-- maybe having them together is better after all.
--
-- Half of the reason this is so complicated is that you can mount up in
-- Moonkin form (but casting Moonkin form dismounts you).

-- Work around a Blizzard bug with calling shapeshift forms in macros in 8.0
-- Breaks after you respec unless you include (Shapeshift) after it.

local function GetSpellNameWithSubtext(id)
    local n = GetSpellInfo(id)
    local s = GetSpellSubtext(id) or ''
    return format('%s(%s)', n, s)
end

ACTIONS['CancelForm'] =
    function (args, env)
        LM_Debug(" - trying CancelForm")

        local curFormIndex = GetShapeshiftForm()
        local curFormID = GetShapeshiftFormID()
        local inMountForm = curFormIndex > 0 and LM_PlayerMounts:GetMountByShapeshiftForm(curFormIndex)

        LM_Debug("- previous form is " .. tostring(savedFormName))

        -- The logic here is really ugly.

        if inMountForm then
            if savedFormName then
                LM_Debug(" - setting action to cancelform + " .. savedFormName)
                return LM_SecureAction:Macro(format("%s\n/cast %s", SLASH_CANCELFORM1, savedFormName))
            end
        elseif IsMounted() and curFormIndex == 0 then
            if savedFormName then
                LM_Debug(" - setting action to dismount + " .. savedFormName)
                return LM_SecureAction:Macro(format("%s\n/cast %s", SLASH_DISMOUNT1, savedFormName))
            end
        elseif curFormID and restoreFormIDs[curFormID] then
            local spellID = select(4, GetShapeshiftFormInfo(curFormIndex))
            local name = GetSpellNameWithSubtext(spellID)
            LM_Debug(" - saving current form " .. tostring(name))
            savedFormName = name
        else
            LM_Debug(" - clearing saved form")
            savedFormName = nil
        end

        if inMountForm and not LM_Options:IsExcludedMount(inMountForm) then
            LM_Debug(" - setting action to cancelform")
            return LM_SecureAction:Macro(SLASH_CANCELFORM1)
        end
    end

-- Got a player target, try copying their mount
ACTIONS['CopyTargetsMount'] =
    function (args, env)
        local unit = env.unit or "target"
        if LM_Options.db.profile.copyTargetsMount and UnitIsPlayer(unit) then
            LM_Debug(format(" - trying to clone %s's mount", unit))
            return LM_PlayerMounts:GetMountFromUnitAura(unit)
        end
    end

ACTIONS['SmartMount'] =
    function (args, env)

        args = ReplaceVars(args)
        local filteredList = env.mounts[1]:FilterSearch(unpack(args))

        LM_Debug(" - filtered list contains " .. #filteredList .. " mounts")

        if next(filteredList) == nil then return end

        filteredList:Shuffle()

        local m

        if LM_Conditions:Check("[submerged]") then
            LM_Debug(" - trying Swimming Mount (underwater)")
            m = filteredList:FilterFind('SWIM')
            if m then return m end
        end

        if LM_Conditions:Check("[flyable]") then
            LM_Debug(" - trying Flying Mount")
            m = filteredList:FilterFind('FLY')
            if m then return m end
        end

        if LM_Conditions:Check("[floating,nowaterwalking]") then
            LM_Debug(" - trying Swimming Mount (on the surface)")
            m = filteredList:FilterFind('SWIM')
            if m then return m end
        end

        LM_Debug(" - trying Running Mount")
        m = filteredList:FilterFind('RUN')
        if m then return m end

        LM_Debug(" - trying Walking Mount")
        m = filteredList:FilterFind('WALK')
        if m then return m end
    end

ACTIONS['Mount'] =
    function (args, env)
        args = ReplaceVars(args)
        local filteredList = env.mounts[1]:FilterSearch(unpack(args))
        LM_Debug(" - filtered list contains " .. #filteredList .. " mounts")
        return filteredList:Random()
    end

ACTIONS['Macro'] =
    function (args, env)
        if LM_Options.db.char.useUnavailableMacro then
            LM_Debug(" - using unavailable macro")
            return LM_SecureAction:Macro(LM_Options.db.char.unavailableMacro, env.unit)
        end
    end

ACTIONS['Script'] =
    function (args, env)
        local macroText = table.concat(args, ' ')
        if SecureCmdOptionParse(macroText) then
            LM_Debug(" - running script line: " .. macroText)
            return LM_SecureAction:Macro(macroText, env.unit)
        end
    end

ACTIONS['CantMount'] =
    function (args, env)
        -- This isn't a great message, but there isn't a better one that
        -- Blizzard have already localized. See FrameXML/GlobalStrings.lua.
        -- LM_Warning("You don't know any mounts you can use right now.")
        LM_Warning(SPELL_FAILED_NO_MOUNTS_ALLOWED)

        LM_Debug(" - setting action to can't mount now")
        return LM_SecureAction:Macro("")
    end

ACTIONS['Combat'] =
    function (args, env)
        LM_Debug(" - setting action to in-combat action")

        if LM_Options.db.char.useCombatMacro then
            return LM_SecureAction:Macro(LM_Options.db.char.combatMacro)
        else
            return LM_SecureAction:Macro(LM_Actions:DefaultCombatMacro())
        end
    end

ACTIONS['Stop'] =
    function (args, env)
        -- return true and set up to do nothing
        return LM_SecureAction:Macro("")
    end

ACTIONS['Use'] =
    function (args, env)
        for _, arg in ipairs(args) do
            local name, bag, slot = SecureCmdItemParse(arg)
            if slot then
                local s, d, e = GetInventoryItemCooldown('player', slot)
                if s == 0 and e == 1 then
                    LM_Debug(' - Setting action to use slot ' .. slot)
                    return LM_SecureAction:Use(slot, env.unit)
                end
            elseif name then
                local itemID = GetItemInfoInstant(name)
                if itemID and IsUsableItem(name) then
                    local s, d, e = GetItemCooldown(itemID)
                    if s == 0 and e == 1 then
                        LM_Debug(' - setting action to use item ' .. name)
                        return LM_SecureAction:Use(name, env.unit)
                    end
                end
            end
        end
    end

_G.LM_Actions = { }

local function GetDruidMountForms()
    local forms = {}
    for i = 1,GetNumShapeshiftForms() do
        local spell = select(5, GetShapeshiftFormInfo(i))
        if spell == LM_SPELL.FLIGHT_FORM or spell == LM_SPELL.TRAVEL_FORM then
            tinsert(forms, i)
        end
    end
    return table.concat(forms, "/")
end

-- This is the macro that gets set as the default and will trigger if
-- we are in combat.  Don't put anything in here that isn't specifically
-- combat-only, because out of combat we've got proper code available.
-- Note that macros are limited to 255 chars, even inside a SecureActionButton.

function LM_Actions:DefaultCombatMacro()

    local mt = "/dismount [mounted]\n"

    local _, playerClass = UnitClass("player")

    if playerClass ==  "DRUID" then
        local forms = GetDruidMountForms()
        local mount = LM_PlayerMounts:GetMountBySpell(LM_SPELL.TRAVEL_FORM)
        if mount and not LM_Options:IsExcludedMount(mount) then
            mt = mt .. format("/cast [noform:%s] %s\n", forms, mount.name)
            mt = mt .. format("/cancelform [form:%s]\n", forms)
        end
    elseif playerClass == "SHAMAN" then
        local mount = LM_PlayerMounts:GetMountBySpell(LM_SPELL.GHOST_WOLF)
        if mount and not LM_Options:IsExcludedMount(mount) then
            local s = GetSpellInfo(LM_SPELL.GHOST_WOLF)
            mt = mt .. "/cast [noform] " .. s .. "\n"
            mt = mt .. "/cancelform [form]\n"
        end
    end

    mt = mt .. "/leavevehicle\n"

    return mt
end

function LM_Actions:GetFlowControlHandler(action)
    return FLOWCONTROLS[action]
end

function LM_Actions:GetHandler(action)
    return ACTIONS[action]
end

function LM_Actions:IsFlowSkipped(env)
    return tContains(env.flowControl, false)
end

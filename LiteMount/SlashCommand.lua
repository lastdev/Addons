--[[----------------------------------------------------------------------------

  LiteMount/SlashCommand.lua

  Chat slash command (/litemount or /lmt) and macro maintenance.

  Copyright 2011 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

local L = LM.Localize

-- https://github.com/Stanzilla/WoWUIBugs/issues/317#issuecomment-1510847497
local MacroName = "LiteMount"
local MacroText = [[
# Auto-created by LiteMount addon, it is safe to delete or edit this macro.
# To re-create it run "/litemount macro"
/lmt savebtn
/click LM_B1
]]

local function CreateOrUpdateMacro()
    local index = GetMacroIndexByName(MacroName)
    if index == 0 then
        index = CreateMacro(MacroName, "ABILITY_MOUNT_MECHASTRIDER", MacroText)
    else
        EditMacro(index, nil, nil, MacroText)
    end
    return index
end

local function IsTrue(x)
    if x == nil or x == false or x == "0" or x == "off" then
        return false
    else
        return true
    end
end

local COMMANDS = {}

COMMANDS[''] =
    function ()
        -- Look, please stop doing this, ok? Nothing good can come of it.
        if not InCombatLockdown() then
            LiteMountOptionsPanel_Open()
        end
    end

-- These are here because I don't export _G.LM except to myself

COMMANDS['dbget'] =
    function (argstr, key)
        if key == nil then return end
        local ftext = string.format("return LM.db.%s", key)
        local f, err = loadstring(ftext)
        if f then
            setfenv(f, { LM = LM })
            local v = f()
            if type(v) == 'table' then
                LM.Print('%s =', key)
                for i, line in ipairs(LM.TableToLines(v)) do
                    LM.Print(line)
                end
            else
                LM.Print("%s = %s", key, tostring(v))
            end
         else
            LM.Print(err)
        end
    end

COMMANDS['dbset'] =
    function (argstr, key, val)
        if key == nil or val == nil then return end
        local f, err = loadstring(string.format("LM.db.%s = %s", key, val))
        if f then
            setfenv(f, { LM = LM })
            f()
        else
            LM.Print(err)
        end
    end

COMMANDS['macro'] =
    function ()
        if not InCombatLockdown() then
            local i = CreateOrUpdateMacro()
            if i then PickupMacro(i) end
        end
    end

COMMANDS['priority'] =
    function (argstr, priority)
        local mount = LM.MountRegistry:GetActiveMount()
        priority = tonumber(priority)
        if mount and priority then
            LM.Options:SetPriority(mount, priority)
            LM.Print("Setting priority of %s to %d.", mount.name, priority)
        end
    end

COMMANDS['location'] =
    function ()
        LM.Print(LOCATION_COLON)
        for _,line in ipairs(LM.Environment:GetLocation()) do
            LM.Print("  " .. line)
        end
    end

COMMANDS['maps'] =
    function (argstr, ...)
        local str = table.concat({ ... }, ' ')
        for _,line in ipairs(LM.Environment:GetMaps(str)) do
            LM.Print(line)
        end
    end

COMMANDS['continents'] =
    function (argstr, ...)
        local str = table.concat({ ... }, ' ')
        for _,line in ipairs(LM.Environment:GetContinents(str)) do
            LM.Print(line)
        end
    end

local function MatchFunc(m, ...)
    if m:MatchesFilters(...) then
        return true
    else
        local n = string.lower(table.concat({ ... }, ' '))
        return string.match(m.name:lower(), n)
    end
end

COMMANDS['mounts'] =
    function (argstr, ...)
        if select('#', ...) == 0 then
            local m = LM.MountRegistry:GetActiveMount()
            if m then m:Dump() end
        else
            local mounts = LM.MountRegistry.mounts:Search(MatchFunc, ...)
            for _,m in ipairs(mounts) do
                m:Dump()
            end
        end
        return true
    end

COMMANDS['group'] =
    function (argstr, action, arg1, arg2)
        if action == "add" and arg1 then
            LM.Options:CreateGroup(arg1)
        elseif action == "del" and arg1 then
            LM.Options:DeleteGroup(arg1)
        elseif action == "rename" and arg1 and arg2 then
            LM.Options:RenameGroup(arg1, arg2)
        elseif action == "list" and arg1 == nil then
            local groups = LM.Options:GetGroupNames()
            LM.Print(table.concat(groups, ' '))
        end
    end

COMMANDS['playermodel'] =
    function ()
        LM.Print("Player model file ID: " .. LM.Environment:GetPlayerModel())
    end

COMMANDS['profile'] =
    function (argstr)
        -- can't use the split args because we need the raw rest of the line
        local profileName = argstr:gsub('^profile%s+', '')
        if profileName and LM.db.profiles[profileName] then
            LM.db:SetProfile(profileName)
            LM.Print("Switching to profile: " .. profileName)
        else
            LM.Print("No profile found with name: " .. profileName)
        end
    end

COMMANDS['xmog'] =
    function (argstr, slotID)
        slotID = tonumber(slotID) or 0
        local tmSlot = TRANSMOG_SLOTS[slotID*100]
        if tmSlot then
            local ok, _, _, _, id = pcall(C_Transmog.GetSlotVisualInfo, tmSlot.location)
            if ok == true then
                LM.Print("Transmog appearance ID for slot %d = %s", slotID, tostring(id))
            else
                LM.Print("Bad transmog slot number: " .. slotID)
            end
        end
    end

COMMANDS['debug'] =
    function (argstr, arg1)
        if IsTrue(arg1) then
            LM.Print(L.LM_DEBUGGING_ENABLED)
            LM.Options:SetOption('debugEnabled', true)
        else
            LM.Print(L.LM_DEBUGGING_DISABLED)
            LM.Options:SetOption('debugEnabled', false)
        end
    end


COMMANDS['uidebug'] =
    function (argstr, arg1)
        if IsTrue(arg1) then
            LM.Print(BUG_CATEGORY5 .. ' ' .. L.LM_DEBUGGING_ENABLED)
            LM.Options:SetOption('uiDebugEnabled', true)
        else
            LM.Print(BUG_CATEGORY5 .. ' ' .. L.LM_DEBUGGING_DISABLED)
            LM.Options:SetOption('uiDebugEnabled', false)
        end
    end

COMMANDS['savebtn'] =
    function ()
        LM.Environment:SaveMouseButtonClicked()
    end

--[==[@debug@
COMMANDS['usable'] =
    function ()
        LM.Developer:Initialize()
        LM.Developer:UpdateUsability()
    end

COMMANDS['pi'] =
    function ()
        LiteMountProfileInspect:Show()
    end

COMMANDS['mockdata'] =
    function ()
        LM.Developer:ExportMockData()
        C_UI.Reload()
    end

COMMANDS['fam'] =
    function (argstr, ...)
        local name = table.concat({ ... }, ' ')
        local families = LM.UIFilter.GetFamilies()
        local newFamily
        if tContains(families, name) then
            newFamily = name
        else
            local currentIndex = 0
            for i, family in ipairs(families) do
                if LM.UIFilter.IsFamilyChecked(family) then
                    currentIndex = i
                    break
                end
            end
            local nextIndex = currentIndex % #families + 1
            newFamily = families[nextIndex]
        end

        LM.UIFilter.SetOtherFilter('HIDDEN', true)
        LM.UIFilter.SetOtherFilter('UNUSABLE', true)
        LM.UIFilter.SetAllFamilyFilters(false)
        LM.UIFilter.SetFamilyFilter(newFamily, true)
        LM.Print(newFamily)
    end

--@end-debug@]==]

local function PrintUsage()
    LM.Print(L.LM_USAGE .. ':')
    LM.Print("  /litemount priority <0-4>")
    LM.Print("  /litemount mounts [<substring>]")
    LM.Print("  /litemount maps [<substring>]")
    LM.Print("  /litemount continents [<substring>]")
    LM.Print("  /litemount location")
    LM.Print("  /litemount macro")
    LM.Print("  /litemount group add <name>")
    LM.Print("  /litemount group del <name>")
    LM.Print("  /litemount group list")
    LM.Print("  /litemount group rename <oldname> <newname>")
    LM.Print("  /litemount playermodel")
    LM.Print("  /litemount profile <profilename>")
    LM.Print("  /litemount xmog <slotnumber>")
end

LM.SlashCommandFunc = function (argstr)
    local args = { strsplit(" ", argstr) }
    local cmd = table.remove(args, 1)

    if COMMANDS[cmd] then
        COMMANDS[cmd](argstr, unpack(args))
        return true
    else
        PrintUsage()
    end

    return true
end

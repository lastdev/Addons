--[[
LittleSnitch
Author: Birckin
Concept, original addon and code for tracking, reporting and hyperlinking spells from: BigBrother by Cryect, mantained by oscarucb
Blizzard Interface Options, Ace code and other interface code from: HandyNotes by Xinhuan
]]

---------------------------------------------------------
-- Addon declaration

LittleSnitch = LibStub("AceAddon-3.0"):NewAddon("LittleSnitch", "AceConsole-3.0", "AceEvent-3.0")
local addon = LittleSnitch
local addonName, vars = ...
local L = LibStub("AceLocale-3.0"):GetLocale("LittleSnitch", false)

-- addon.debug = true

---------------------------------------------------------
-- Options and default values

local db
local defaults = {
    profile = {
        enabled         = true,
        interrupt       = true,
        dispel          = true,
        defensivedispel = true,
        taunt           = true,
        misdirect       = true,
        ccbreak         = true,
        combatres       = true,
        noncombatres    = true,
        output = {
            self          = true,
            party         = false,
            raid          = false,
            guild         = false,
            officers      = false,
            battleground  = false,
            instance      = false,
            -- custom        = false,
            -- customchannel = "",
        },
        grouponly       = true,
        reportself      = true,
        reporttanks     = true,
        showtime        = true,
    },
}
local options = {
    type = "group",
    name = L["LittleSnitch"],
    desc = L["LittleSnitch"],
    args = {
        credits = {
            type  =  "description",
            name  = L["With love by Birckin for High Quality-Zul'jin"],
            width = "full",
            order = 1,
        },
        credits2 = {
            type  =  "description",
            name  = L["Original concept and code from BigBrother by Cryect, mantained by oscarucb"],
            width = "full",
            order = 2,
        },
        sep = {
            type  =  "description",
            name  = " ",
            width = "full",
            order = 3,
        },
        enabled = {
            type = "toggle",
            name = L["Enable LittleSnitch"],
            desc = L["Enable or disable LittleSnitch"],
            order = 1,
            get = function(info) return db.enabled end,
            set = function(info, v)
                db.enabled = v
                if v then LittleSnitch:Enable() else LittleSnitch:Disable() end
            end,
            disabled = false,
            order = 10,
        },
        tracking = {
            type = "group",
            name = L["What to track"],
            desc = L["Set what type of events do you want to track."],
            order = 20,
            get = function(info) return db[info.arg] end,
            set = function(info, v)
                local arg = info.arg
                db[arg] = v
            end,
            disabled = function() return not db.enabled end,
            args = {
                interrupt = {
                    type  = "toggle",
                    name  = L["Interrupt"],
                    desc  = L["Reports when players interrupt mob spell casts."],
                    arg   = "interrupt",
                    width = "full",
                    order = 1,
                },
                dispel = {
                    type  = "toggle",
                    name  = L["Offensive dispel"],
                    desc  = L["Reports when players remove or steal mob buffs."],
                    arg   = "dispel",
                    width = "full",
                    order = 2,
                },
                defensivedispel = {
                    type  = "toggle",
                    name  = L["Defensive dispel"],
                    desc  = L["Reports when players remove a debuff from a friendly player."],
                    arg   = "defensivedispel",
                    width = "full",
                    order = 2,
                },
                taunt = {
                    type  = "toggle",
                    name  = L["Taunt"],
                    desc  = L["Reports when players taunt mobs."],
                    arg   = "taunt",
                    width = "full",
                    order = 3,
                },
                misdirect = {
                    type  = "toggle",
                    name  = L["Misdirect"],
                    desc  = L["Reports who gains misdirection."],
                    arg   = "misdirect",
                    width = "full",
                    order = 4,
                },
                ccbreak = {
                    type  = "toggle",
                    name  = L["CC break"],
                    desc  = L["Reports if and which player breaks crowd control effects (like polymorph, shackle undead, etc.) on enemies."],
                    arg   = "ccbreak",
                    width = "full",
                    order = 5,
                },
                combatres = {
                    type  = "toggle",
                    name  = L["Resurrection - Combat"],
                    desc  = L["Reports when Combat Resurrection is performed."],
                    arg   = "combatres",
                    width = "full",
                    order = 6,
                },
                noncombatres = {
                    type  = "toggle",
                    name  = L["Resurrection - Non-combat"],
                    desc  = L["Reports when Non-combat Resurrection is performed."],
                    arg   = "noncombatres",
                    width = "full",
                    order = 7,
                },
            },
        },
        eventsoutput = {
            type = "group",
            name = L["Events output"],
            desc = L["Set where the output for selected events is sent."],
            order = 21,
            get = function(info) return db.output[info.arg] end,
            set = function(info, v)
                local arg = info.arg
                db.output[arg] = v
            end,
            disabled = function() return not db.enabled end,
            args = {
                self = {
                    type  = "toggle",
                    name  = L["Self"],
                    desc  = L["Reports result only to yourself."],
                    arg   = "self",
                    width = "full",
                    order = 1,
                },
                party = {
                    type  = "toggle",
                    name  = L["Party"],
                    desc  = L["Reports result to your party."],
                    arg   = "party",
                    width = "full",
                    order = 2,
                },
                raid = {
                    type  = "toggle",
                    name  = L["Raid"],
                    desc  = L["Reports result to your raid."],
                    arg   = "raid",
                    width = "full",
                    order = 3,
                },
                guild = {
                    type  = "toggle",
                    name  = L["Guild"],
                    desc  = L["Reports result to guild chat."],
                    arg   = "guild",
                    width = "full",
                    order = 4,
                },
                officer = {
                    type  = "toggle",
                    name  = L["Officer"],
                    desc  = L["Reports result to officer chat."],
                    arg   = "officer",
                    width = "full",
                    order = 5,
                },
                battleground = {
                    type  = "toggle",
                    name  = L["Battleground"],
                    desc  = L["Reports result to your battleground."],
                    arg   = "battleground",
                    width = "full",
                    order = 6,
                },
                instance = {
                    type  = "toggle",
                    name  = L["Instance"],
                    desc  = L["Reports result to LFG/LFR instance group."],
                    arg   = "instance",
                    width = "full",
                    order = 7,
                },
                -- custom = {
                --     type  = "toggle",
                --     name  = L["Custom"],
                --     desc  = L["Reports result to your custom channel."],
                --     arg   = "custom",
                --     order = 8,
                -- },
                -- customchannel = {
                --     type  = "input",
                --     name  = L["Custom channel"],
                --     desc  = L["Name of custom channel to use for output."],
                --     arg   = "customchannel",
                --     order = 9,
                -- },
            }
        },
        other = {
            type = "group",
            name = L["Other settings"],
            desc = L["Set other custom settings."],
            order = 22,
            get = function(info) return db[info.arg] end,
            set = function(info, v)
                local arg = info.arg
                db[arg] = v
            end,
            disabled = function() return not db.enabled end,
            args = {
                grouponly = {
                    type  = "toggle",
                    name  = L["Group members only"],
                    desc  = L["Only reports events about players in my party/raid."],
                    arg   = "grouponly",
                    width = "full",
                    order = 1,
                },
                reportself = {
                    type  = "toggle",
                    name  = L["Report self"],
                    desc  = L["Report events caused by self (except CC breaks, which are always reported)."],
                    arg   = "reportself",
                    width = "full",
                    order = 2,
                },
                reporttanks = {
                    type  = "toggle",
                    name  = L["Report tanks"],
                    desc  = L["Report events caused by tanks."],
                    arg   = "reporttanks",
                    width = "full",
                    order = 3,
                },
                showtime = {
                    type  = "toggle",
                    name  = L["Show time in self"],
                    desc  = L["Shows the time self reports."],
                    arg   = "showtime",
                    width = "full",
                    order = 3,
                },
            },
        },
    },
}

---------------------------------------------------------
-- Core functions

local bit, math, date, string, select, table, time, tonumber, unpack, wipe, pairs, ipairs = 
bit, math, date, string, select, table, time, tonumber, unpack, wipe, pairs, ipairs

local IsInInstance, UnitName, UnitBuff, UnitExists, UnitGUID, GetSpellLink, GetUnitName, GetPlayerInfoByGUID, GetRealZoneText, 
GetNumGroupMembers, IsInGuild, GetTime, UnitGroupRolesAssigned, GetPartyAssignment = 
IsInInstance, UnitName, UnitBuff, UnitExists, UnitGUID, GetSpellLink, GetUnitName, GetPlayerInfoByGUID, GetRealZoneText, 
GetNumGroupMembers, IsInGuild, GetTime, UnitGroupRolesAssigned, GetPartyAssignment
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or GetSpellInfo
local GetSpellLink = C_Spell and C_Spell.GetSpellLink or GetSpellLink
local UnitDebuff = C_TooltipInfo and C_TooltipInfo.GetUnitDebuff or UnitDebuff

local COMBATLOG_OBJECT_RAIDTARGET_MASK, COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_TYPE_NPC, COMBATLOG_OBJECT_TYPE_PET, 
COMBATLOG_OBJECT_TYPE_GUARDIAN, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER = 
COMBATLOG_OBJECT_RAIDTARGET_MASK, COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_TYPE_NPC, COMBATLOG_OBJECT_TYPE_PET, 
COMBATLOG_OBJECT_TYPE_GUARDIAN, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER

local AceEvent = LibStub("AceEvent-3.0")
-- local RL = LibStub("Roster-2.1")

local function convertIDstoNames(spellIDs)
    local result = {}
    local uiversion = select(4, GetBuildInfo())
    local ignoreMissing = {
        [60210] = uiversion >= 40000, -- Freezing Arrow Effect, removed 4.x (replaced with Freezing Trap)
        [59671] = uiversion >= 40000, -- Challenging Howl (Warlock), removed 4.x
    }
    for _, v in ipairs(spellIDs) do
        local spellName = GetSpellInfo(v)
        if (not spellName) then
            if not ignoreMissing[v] then LitteSnitch:Print("MISSING SPELLID: "..v) end
        else
            result[spellName.name] = true
        end
    end
    return result
end

local ccSpellNames = convertIDstoNames(vars.spellData.ccspells)
local ccSafeAuraNames = convertIDstoNames(vars.spellData.ccsafeauras)
local rezSpellNames = convertIDstoNames(vars.spellData.rezSpells)
local brezSpellNames = convertIDstoNames(vars.spellData.brezSpells)
for k, _ in pairs(brezSpellNames) do rezSpellNames[k] = nil end
local misdirectSpellNames = convertIDstoNames(vars.spellData.misdirectSpells)
local tauntSpellNames = convertIDstoNames(vars.spellData.tauntSpells)
local aoetauntSpellNames = convertIDstoNames(vars.spellData.aoetauntSpells)
for k, _ in pairs(aoetauntSpellNames) do tauntSpellNames[k] = nil end

local deathgrip = GetSpellInfo(vars.spellData.deathgrip)

local color = "|cffff8040%s|r"
local outdoor_bg = {}

function addon:SendMessageList(Pre, List, Where)
    if #List > 0 then
        if Where == "SELF" then
            self:Print(string.format(color, Pre..":") .. " " .. table.concat(List, ", "))
        elseif Where == "WHISPER" then
            local theTarget = UnitName("playertarget")
            if theTarget == nil then
                theTarget = UnitName("player")
            end
            SendChatMessage(Pre..": "..table.concat(List, ", "), Where, nil, theTarget)
        else
            SendChatMessage(Pre..": "..table.concat(List, ", "), Where)
        end
    end
end

local petToOwner = {}
addon.petToOwner = petToOwner

local function nospace(str)
    if not str then return "" end
    return str:gsub("%s", "")
end

function addon:IsTank(unit)
    if not unit then return nil end
    return UnitGroupRolesAssigned(unit) == "TANK"
end

local iconlookup = {
    [COMBATLOG_OBJECT_RAIDTARGET1] = "{rt1}",
    [COMBATLOG_OBJECT_RAIDTARGET2] = "{rt2}",
    [COMBATLOG_OBJECT_RAIDTARGET3] = "{rt3}",
    [COMBATLOG_OBJECT_RAIDTARGET4] = "{rt4}",
    [COMBATLOG_OBJECT_RAIDTARGET5] = "{rt5}",
    [COMBATLOG_OBJECT_RAIDTARGET6] = "{rt6}",
    [COMBATLOG_OBJECT_RAIDTARGET7] = "{rt7}",
    [COMBATLOG_OBJECT_RAIDTARGET8] = "{rt8}",
}

local srcGUID, srcname, srcflags, srcRaidFlags,
dstGUID, dstname, dstflags, dstRaidFlags

local SRC = "<<<SRC>>>"
local DST = "<<<DST>>>"
local EMBEGIN = "<<<EM>>>"
local EMEND = "<<</EM>>>"
local function SPELL(id)
    return "<<<SPELL:"..id..">>>"
end

local function SPELLDECODE_helper(s)
    local l
    l = s and GetSpellLink(s)
    if l then return l
    else return GetSpellLink(2382)
    end
end

local function SPELLDECODE(spam)
    return string.gsub(spam, "<<<SPELL:(%d+)>>>", SPELLDECODE_helper)
end

local function iconize(flags, chatoutput)
    local iconflag = bit.band(flags or 0, COMBATLOG_OBJECT_RAIDTARGET_MASK)

    if chatoutput then
        return (iconlookup[iconflag] or "")
    elseif iconflag then
        local check, iconidx = math.frexp(iconflag)
        --iconidx = iconidx - 20
        if check == 0.5 and iconidx >= 1 and iconidx <= 8 then
            return "|Hicon:"..iconflag..":dest|h|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..iconidx..".blp:0|t|h"
        end
    end

    return ""
end

local function unitColor(guid, flags, name)
    local color
    local class = guid and select(3, pcall(GetPlayerInfoByGUID, guid)) -- ticket 34
    if bit.band(flags or 0, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0 then
        color = "ff0000"
    elseif bit.band(flags or 0, COMBATLOG_OBJECT_TYPE_NPC) > 0 then
        color = "6666ff"
    elseif bit.band(flags or 0, COMBATLOG_OBJECT_TYPE_PET) > 0 then
        color = "40ff40"
    elseif bit.band(flags or 0, COMBATLOG_OBJECT_TYPE_GUARDIAN) > 0 then
        color = "40ff40"
    elseif class and RAID_CLASS_COLORS[class] then
        local c = RAID_CLASS_COLORS[class]
        color = string.format("%02x%02x%02x", c.r * 255, c.g * 255, c.b * 255)
    else -- unknown
        color = "666666"
    end
    if bit.band(flags or 0, COMBATLOG_OBJECT_TYPE_PLAYER) then
        name = "\124Hplayer:"..name.."::"..name.."\124h"..name.."\124h"
    end
    return "\124cff"..color..name.."\124r"
end

function addon:unitOwner(petName, petFlags, usecolor)
    if not petName or not petFlags then
        return ""
    end

    if bit.band(petFlags, COMBATLOG_OBJECT_TYPE_PET) == 0 and
    bit.band(petFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) == 0 then
        return ""
    end

    local ownerGUID = petToOwner[petName]
    if not ownerGUID then -- try a refresh
        local g = GetNumGroupMembers()
        local PetOwner = ""
        if g > 0 then 
            for x = 1, g do
                if UnitIsUnit("partypet" .. x, petName) then
                    PetOwner = "partypet" .. x
                    break
                end
            end
        elseif UnitIsUnit("pet", petName) then
            PetOwner = "player"
        end

        if PetOwner == "" then
            return ""
        end

        petToOwner[petName] = UnitGUID(PetOwner)
        ownerGUID = petToOwner[petName]
    end

    local name, realm = select(6, GetPlayerInfoByGUID(ownerGUID))
    name = name or "Unknown"
    if realm and #realm > 0 then
        name = name.."-"..realm
    end
    if usecolor then
        local colored = unitColor(ownerGUID, bit.bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_REACTION_FRIENDLY), name)
        return " <"..colored..">"
    else
        return " <"..name..">"
    end
end

local function SYMDECODE(spam, chatoutput)
    local x = iconize(COMBATLOG_OBJECT_RAIDTARGET7, chatoutput)
    spam = string.gsub(spam, EMBEGIN, x..x..x.." ")
    spam = string.gsub(spam, EMEND, " "..x..x..x)
    local srctxt = srcname or "Unknown"
    local dsttxt = dstname or "Unknown"
    if not chatoutput then
        srctxt = unitColor(srcGUID, srcflags, srctxt)
        dsttxt = unitColor(dstGUID, dstflags, dsttxt)
    end
    local srcowner = addon:unitOwner(srcname, srcflags, not chatoutput)
    local dstowner = addon:unitOwner(dstname, dstflags, not chatoutput)
    srctxt = iconize(srcRaidFlags, chatoutput)..srctxt..srcowner
    dsttxt = iconize(dstRaidFlags, chatoutput)..dsttxt..dstowner
    spam = string.gsub(spam, SRC, srctxt)
    spam = string.gsub(spam, DST, dsttxt)
    return spam
end

local function spamchannel(spam, channel, chanid)
    local output = spam
    output = SPELLDECODE(output)
    output = SYMDECODE(output, true)
    SendChatMessage(output, channel, nil, chanid)
end

local function sendspam(spam, channels, tankunit)
    local channels = channels or db.output
    if not spam then return end

    if tankunit then
        local istank = addon:IsTank(tankunit)
        if istank and not db.reporttanks then
            return
        end
        if not istank and db.reporttanks then
            spam = EMBEGIN..spam..EMEND
        end
    end

    if channels.self then
        local output = SYMDECODE(spam, false)
        output = SPELLDECODE(output)
        local data = SYMDECODE(spam, true)
        local time = time()
        local link = "\124Hplayer::LitteSnitch:"..time..":"..data.."\124h\124cff8888ff[Little Snitch]\124r\124h\124h: "
        if db.showtime then
            print("\124ceeeeeeff"..date("%H:%M:%S", time).."\124r "..link..output)
        else 
            print(link..output)
        end
    end

    local it = select(2, IsInInstance())
    local inbattleground = (it == "pvp")
    local inoutdoorbg = false
    local inarena = (it == "arena")

    local id = outdoor_bg[GetRealZoneText()]
    if id then
        local _, _, isActive = GetWorldPVPAreaInfo(id)
        if isActive then
            inoutdoorbg = true
        end
    end

    -- BG reporting - never spam bg unless specifically requested, and dont spam anyone else
    if inbattleground then
        if channels.battleground then
            spamchannel(spam, "INSTANCE_CHAT")
        end
        return
    elseif inoutdoorbg then
        if channels.battleground then
            spamchannel(spam, "RAID")
        end
        return
    elseif inarena then
        if channels.party or channels.battleground then
            spamchannel(spam, "PARTY")
        end
        return
    end

    -- raid/party reporting
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        if channels.instance then
            spamchannel(spam, "INSTANCE_CHAT")
        end
    elseif IsInRaid() and channels.raid then
        spamchannel(spam, "RAID")
    elseif GetNumGroupMembers() ~= 0 and channels.party then
        spamchannel(spam, "PARTY")
    end

    -- guild reporting - dont spam both channels
    if IsInGuild() and channels.guild then
        spamchannel(spam, "GUILD")
    elseif IsInGuild() and channels.officer then
        spamchannel(spam, "OFFICER")
    end

    -- custom reporting
    -- if channels.custom and channels.customchannel then
    --     local chanid = GetChannelName(channels.customchannel)
    --     if chanid then
    --         spamchannel(spam, "CHANNEL", chanid)
    --     end
    -- end
end

local clickchan = {
    self          = false,
    party         = true,
    raid          = true,
    guild         = false,
    officer       = false,
    battleground  = true,
    instance      = true,
    -- custom        = false,
    -- customchannel = "",
}
hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
    local time, data = string.match(link, "^player::LitteSnitch:(%d+):(.+)$")
    if time then
        data = SPELLDECODE(data)
        data = "["..date("%H:%M:%S", time).."]: "..data
        if ChatEdit_GetActiveWindow() then
            ChatEdit_InsertLink(data)
        else
            sendspam(data, clickchan)
        end
    end
end)

local ccinfo = {
    spellid = {}, -- GUID -> cc spell id
    time = {}, -- GUID -> time when it expires
    dmgspellid = {}, -- GUID -> spell ID that caused damage
    dmgspellamt = {}, -- GUID -> spell ID that caused damage
    dmgunitname = {}, -- GUID -> last unit to damage it
    dmgunitguid = {}, -- GUID -> last unit to damage it
    dmgunitflags = {}, -- GUID -> last unit to damage it
    dmgunitrflags = {}, -- GUID -> last unit to damage it
    postponetime = {}, -- GUID -> time of breakage postponed
}

local function ccinfoClear(dstGUID)
    ccinfo.spellid[dstGUID] = nil
    ccinfo.time[dstGUID] = nil
    ccinfo.dmgspellid[dstGUID] = nil
    ccinfo.dmgspellamt[dstGUID] = nil
    ccinfo.dmgunitname[dstGUID] = nil
    ccinfo.dmgunitguid[dstGUID] = nil
    ccinfo.dmgunitflags[dstGUID] = nil
    ccinfo.dmgunitrflags[dstGUID] = nil
    ccinfo.postponetime[dstGUID] = nil
end

local playersrcmask = bit.bor(bit.bor(COMBATLOG_OBJECT_TYPE_PLAYER,
    COMBATLOG_OBJECT_TYPE_PET),
COMBATLOG_OBJECT_TYPE_GUARDIAN) -- totems

---------------------------------------------------------
-- Main event filtering

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
function addon:COMBAT_LOG_EVENT_UNFILTERED()
    local timestamp, subevent, hideCaster,
    srcGUIDz, srcnamez, srcFlagsz, srcRaidFlagz,
    dstGUIDz, dstnamez, dstFlagsz, dstRaidFlagsz,
    spellID, spellname, spellschool,
    extraspellID = CombatLogGetCurrentEventInfo()

    -- this is so hacky i dont even wanna talk about it
    srcGUID = srcGUIDz
    srcname = srcnamez
    srcflags = srcFlagsz
    srcRaidFlags = srcRaidFlagsz

    dstGUID = dstGUIDz
    dstname = dstnamez
    dstflags = dstFlagsz
    dstRaidFlags = dstRaidFlagsz
    -- super hacky .....

    srcflags = srcflags or 0
    dstflags = dstflags or 0

    if db.grouponly and
    bit.band(srcflags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 and
    bit.band(dstflags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 and
    not ccinfo.spellid[dstGUID] then
        -- print("skipped event from "..(srcname or "nil").." on "..(dstname or "nil"))
        return
    end

    local is_playersrc = bit.band(srcflags, playersrcmask) > 0
    local is_playerdst = bit.band(dstflags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0
    local is_hostiledst = bit.band(dstflags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0

    -- debug stuff here
    if addon.debug then
        print(subevent)
        print((spellname or "nil")..":"..(spellID or "nil")..":"..(subevent or "nil")..":"..
            (srcname or "nil")..":"..(srcGUID or "nil")..":"..(srcflags or "nil")..":"..(srcRaidFlags or "nil")..":"..
            (dstname or "nil")..":"..(dstGUID or "nil")..":"..(dstflags or "nil")..":"..(dstRaidFlags or "nil")..":"..
            "is_playersrc:"..((is_playersrc and "true") or "false")..":"..(extraspellID or "nil"))
    end

    if subevent == "SPELL_SUMMON" and is_playersrc then
        petToOwner[dstname] = srcGUID
        return
    elseif subevent == "UNIT_DIED" or subevent == "UNIT_DESTROYED" then
        petToOwner[dstname] = nil
        return
    end

    if db.ccbreak
    and dstGUID and ccinfo.time[dstGUID]
    and (string.find(subevent, "_DAMAGE") or -- newest direct damage
        (subevent == "SPELL_AURA_APPLIED" -- newest dot application with no prev direct damage
            and (not ccinfo.dmgspellamt[dstGUID] or ccinfo.dmgspellamt[dstGUID] == 0)
            and not ccSpellNames[spellname]
            and not ccSafeAuraNames[spellname]
            and not tauntSpellNames[spellname]
            and not aoetauntSpellNames[spellname]
        )
    )
    and spellID ~= 66070 then -- ignore roots dmg
        local new_dmgspellid, new_dmgspellamt

        if subevent == "SWING_DAMAGE" then
            new_dmgspellid = 6603
            new_dmgspellamt = spellID -- swing damage
        elseif subevent == "SPELL_AURA_APPLIED" then
            new_dmgspellid = spellID
            new_dmgspellamt = 0 -- spelldmg
        else
            new_dmgspellid = spellID
            new_dmgspellamt = extraspellID -- spelldmg
        end

        ccinfo.dmgspellamt[dstGUID] = ccinfo.dmgspellamt[dstGUID] or 0
        if (ccinfo.dmgspellamt[dstGUID] == 0 and new_dmgspellamt > 0) or -- first direct dmg
        (new_dmgspellamt > 0 and -- newer direct dmg overwrites older direct dmg, except
        -- not (addon:IsTank(ccinfo.dmgunitname[dstGUID]) and not addon:IsTank(srcname))) -- non-tanks dont overwrite tanks
        not (addon:IsTank(dstname) and not addon:IsTank(srcname))) -- non-tanks dont overwrite tanks
        then
            ccinfo.dmgspellid[dstGUID] = new_dmgspellid
            ccinfo.dmgspellamt[dstGUID] = new_dmgspellamt
            ccinfo.dmgunitname[dstGUID] = srcname
            ccinfo.dmgunitguid[dstGUID] = srcGUID
            ccinfo.dmgunitflags[dstGUID] = srcflags
            ccinfo.dmgunitrflags[dstGUID] = srcRaidFlags
        end
        if ccinfo.dmgspellamt[dstGUID] > 0 and ccinfo.postponetime[dstGUID] then
            if (GetTime() - ccinfo.postponetime[dstGUID]) < 0.5 then -- this target just broke SPELL_AURA_REMOVED
                subevent = "SPELL_AURA_BROKEN_SPELL"
                extraspellID = spellID
            else -- give up
                subevent = "SPELL_AURA_REMOVED"
            end
            spellID = ccinfo.spellid[dstGUID]
            spellname = GetSpellInfo(spellID)
        end
    elseif db.ccbreak and is_playersrc and is_hostiledst
    and (subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REFRESH")
    and spellID ~= 24131 -- ignore the dot component of wyvern sting
    and ccSpellNames[spellname] then
        local expires
        local now = GetTime()
        db.cctime = db.cctime or {}
        for _, unit in pairs({srcname.."-target", "target", "focus", "mouseover" }) do
            if UnitExists(unit) and UnitGUID(unit) == dstGUID then
                for i = 1, 40 do
                    local name, _, _, _, expires, _, _, _, _, currentSpellId = UnitDebuff(unit, i)              
                    -- expires = select(7, UnitDebuff(unit, spellname))
                
                    if spellID == currentSpellId then
                        -- print('got it: ' .. expires)
                        break
                    end
                end
            end
        end

        local usualtime = db.cctime[spellname]
        if expires then
            local duration = expires - now
            if not usualtime or duration > usualtime then
                db.cctime[spellname] = duration
            end
        else
            expires = now + (usualtime or 60)
            --print("Guessing CC expiration")
        end

        if expires and ( not ccinfo.time[dstGUID] or ccinfo.time[dstGUID] < expires ) then
            -- print(spellname.." applied for "..(expires - now).." sec")
            ccinfoClear(dstGUID)
            ccinfo.time[dstGUID] = expires
            ccinfo.spellid[dstGUID] = spellID
        end
    end

    if db.ccbreak
    and (subevent == "SPELL_AURA_BROKEN" or subevent == "SPELL_AURA_BROKEN_SPELL" or subevent == "SPELL_AURA_REMOVED")
    and is_hostiledst
    and spellID ~= 24131 -- ignore the dot component of wyvern sting
    and ccSpellNames[spellname] then
    -- and not addon:IsTank(srcname) then
        local throttleResetTime = 15;
        local now = GetTime();
        local expired = false

        -- Reset the spam throttling cache if it isn't initialized or
        -- if it's been more than 15 seconds since any CC broke
        if (nil == self.spamCache or (nil ~= self.spamCacheLastTimeMax and now - self.spamCacheLastTimeMax > throttleResetTime)) then
            self.spamCache = {};
            self.spamCacheLastTimeMax = nil;
        end
        
        if spellID == ccinfo.spellid[dstGUID] then
            if ccinfo.time[dstGUID] and (ccinfo.time[dstGUID] - now < 1) then
                expired = true
            elseif spellID == 710 then 
                -- banish can't be broken, don't inspect nearby damage
                -- src indicates caster, not remover
                subevent = "SPELL_AURA_REMOVED"
            elseif ccinfo.time[dstGUID] and (ccinfo.time[dstGUID] - now > 1) and -- poly ended more than a sec early
                ccinfo.dmgspellid[dstGUID] and
                subevent ~= "SPELL_AURA_BROKEN_SPELL" then -- add the missing info
                    subevent = "SPELL_AURA_BROKEN_SPELL"
                    srcname = ccinfo.dmgunitname[dstGUID]
                    srcGUID = ccinfo.dmgunitguid[dstGUID]
                    srcflags = ccinfo.dmgunitflags[dstGUID]
                    srcRaidFlags = ccinfo.dmgunitrflags[dstGUID]
                    extraspellID = ccinfo.dmgspellid[dstGUID]
            elseif subevent == "SPELL_AURA_REMOVED" and not ccinfo.postponetime[dstGUID] and not is_playersrc then
                    -- this is questionable... ?
                    -- src exists but is not reliable (indicates caster, not breaker)
                    -- no dmg seen yet, postpone until next dmg on target
                    -- most likely the next combat event will be SPELL_AURA_BROKEN_SPELL or SPELL_*DAMAGE on it
                ccinfo.postponetime[dstGUID] = now
                return
            end

            ccinfoClear(dstGUID)
        end

        local spam

        if subevent == "SPELL_AURA_BROKEN" then
            spam = (L["%s on %s broken by %s"]):format(SPELL(spellID), DST, SRC)
        elseif subevent == "SPELL_AURA_BROKEN_SPELL" then
            spam = (L["%s on %s broken by %s's %s"]):format(SPELL(spellID), DST, SRC, SPELL(extraspellID))
        elseif expired then
            spam = (L["%s on %s expired"]):format(SPELL(spellID), DST)
        elseif subevent == "SPELL_AURA_REMOVED" then
            spam = (L["%s on %s removed by %s"]):format(SPELL(spellID), DST, SRC)
        end

        -- Should we throttle the spam?
        if self.spamCache[dstGUID] and now - self.spamCache[dstGUID]["lasttime"] < throttleResetTime then
            -- If we've been broken 3 or more times without a 15 second reprieve (spam breakage),
            -- or twice withing 2 seconds (duplicate combat log breakage events)
            -- then supress the spam
            if (self.spamCache[dstGUID]["count"] > 3 or now - self.spamCache[dstGUID]["lasttime"] < 2) then
                spam = nil;
            end

            -- Increment the cache entry
            self.spamCache[dstGUID]["count"] = self.spamCache[dstGUID]["count"] + 1;
            self.spamCache[dstGUID]["lasttime"] = now;
        else
            -- Reset the cache entry
            self.spamCache[dstGUID] = {["count"] = 1, ["lasttime"] = now};
        end
        self.spamCacheLastTimeMax = now;

        if spam then
            local tname = srcname
            if expired or subevent == "SPELL_AURA_REMOVED" then
                tname = nil
            end
            sendspam(spam, nil, tname)
        end

    elseif is_playersrc and not db.reportself then -- rest is all direct player actions (if disabled)
        return
    elseif subevent == "SPELL_CAST_SUCCESS" and misdirectSpellNames[spellname] and db.misdirect then
        sendspam(L["%s cast %s on %s"]:format(SRC, SPELL(spellID), DST), nil, dstname)
    elseif subevent == "SPELL_RESURRECT" then
        if brezSpellNames[spellname] and db.combatres then
            sendspam(L["%s cast %s on %s"]:format(SRC, SPELL(spellID), DST))
        elseif rezSpellNames[spellname] and db.noncombatres then
            -- would like to report at spell cast start, but unfortunately the SPELL_CAST_SUCCESS combat log event for all rezzes has a nil target
            sendspam(L["%s cast %s on %s"]:format(SRC, SPELL(spellID), DST))
        end
    elseif ((subevent == "SPELL_CAST_SUCCESS" and tauntSpellNames[spellname] and spellname ~= deathgrip) or
    (subevent == "SPELL_AURA_APPLIED" and spellname == deathgrip)) and -- trigger off death grip "taunted" debuff, which is not applied with Glyph of Tranquil Grip
    db.taunt and not is_playerdst then
        sendspam(L["%s taunted %s with %s"]:format(SRC, DST, SPELL(spellID)), nil, srcname)
    elseif subevent == "SPELL_AURA_APPLIED" and aoetauntSpellNames[spellname] and db.taunt and not is_playerdst then
        sendspam(L["%s aoe-taunted %s with %s"]:format(SRC, DST, SPELL(spellID)), nil, srcname)
    elseif subevent == "SPELL_MISSED" and (tauntSpellNames[spellname] or aoetauntSpellNames[spellname])
    and not (spellID == vars.spellData.deathgrip and extraspellID == "IMMUNE") -- ignore immunity messages from death grip caused by mobs immune to the movement component
    and not spellID == 2649 -- ignore hunter pet growl
    and db.aunt and not is_playerdst then
        local missType = extraspellID
        sendspam(L["%s taunt FAILED on %s (%s)"]:format(SRC, DST, missType), nil, srcname)
    elseif subevent == "SPELL_INTERRUPT" and db.interrupt then
        sendspam(L["%s interrupted %s casting %s"]:format(SRC, DST, SPELL(extraspellID)))
    elseif subevent == "SPELL_DISPEL" and ((db.dispel and is_hostiledst) or (db.defensivedispel and not is_hostiledst)) then
        local extra = ""
        if spellID and spellID > 0 then
            extra = " ("..SPELL(spellID)..")"
        end
        sendspam(L["%s dispelled %s on %s"]:format(SRC, SPELL(extraspellID or spellID), DST) .. extra)
    elseif subevent == "SPELL_STOLEN" and db.dispel and is_hostiledst then
        sendspam(L["%s stole %s from %s"]:format(SRC, SPELL(extraspellID or spellID), DST))
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function addon:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("LittleSnitchDB", defaults, true)
    self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
    db = self.db.profile

    -- Register options table and slash command
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("LittleSnitch", options)
    self:RegisterChatCommand("littlesnitch", function() LibStub("AceConfigDialog-3.0"):Open("LittleSnitch") end)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LittleSnitch", "LittleSnitch")

    -- Get the option table for profiles
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    options.args.profiles.disabled = options.args.tracking.disabled
end

function addon:OnEnable()
    if not db.enabled then
        self:Disable()
        return
    end

    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    -- self:RegisterEvent("CHAT_MSG_ADDON")

    DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkEnter", function(self, linkData, olink)
        if linkData ~= nil then --TEMP FIX to hide LUA Error.
            if string.match(linkData, "^player::LitteSnitch:") then
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
                GameTooltip:SetText(L["Click to add this event to chat"])
                GameTooltip:Show()
            end
        end --TEMP FIX to hide LUA Error.
    end)

    DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkLeave", function(self, linkData, link)
        GameTooltip:Hide()
        -- if linkData ~= nil then --TEMP FIX to hide LUA Error.
        --     if string.match(linkData, "^player::LitteSnitch:") then
        --         GameTooltip:Hide()
        --     end
        -- end --TEMP FIX to hide LUA Error.
    end)
end

function addon:OnDisable()
end

function addon:OnProfileChanged(event, database, newProfileKey)
    db = database.profile
end

-- HELPERS
--[[
function var_dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' and type(k) ~= 'table' then k = '"'..k..'"' end
            if (type(k) ~= 'table') then
                s = s .. '['..k..'] = ' .. var_dump(v) .. ','
            else
                s = s .. '[<table>] = ' .. var_dump(v) .. ','                
            end
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
]]
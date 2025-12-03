-- Load embedded libraries
local LibStub = LibStub or _G.LibStub
local AceDB = LibStub:GetLibrary("AceDB-3.0")
local AceAddon = LibStub:GetLibrary("AceAddon-3.0")
local AceConfig = LibStub:GetLibrary("AceConfig-3.0")
local AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0")
local icon = LibStub:GetLibrary("LibDBIcon-1.0")
local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
local AceGUI = LibStub:GetLibrary("AceGUI-3.0")

-- Helper function to check WoW version
local function isWow11OrLater()
    local version, build, date, tocversion = GetBuildInfo()
    return tocversion >= 110000
end

-- Assign the appropriate GetSpellInfo function based on the WoW version
local function getSpellInfoFunction()
    if isWow11OrLater() then
        return function(spellID)
            return { name = (C_Spell.GetSpellInfo(spellID) or {}).name }
        end
    else
        return function(spellID)
            return { name = (GetSpellInfo(spellID)) }
        end
    end
end

local GetSpellInfo = getSpellInfoFunction()

local function ensureString(value)
    if type(value) == "table" then
        return tostring(value)
    end
    return value
end

MDH = LibStub("AceAddon-3.0"):NewAddon("MDH", "AceEvent-3.0")
local MDH = MDH
MDH.uc = select(2, UnitClass("player"))
local uc = MDH.uc
if (uc ~= "HUNTER") and (uc ~= "ROGUE") then return end
local LibStub = LibStub
MDH.L = LibStub("AceLocale-3.0"):GetLocale("MisDirectionHelper", true)
local L = MDH.L
local icon = LibStub("LibDBIcon-1.0")
local _G = _G
local MDHText = "MDH"
local channels = {["RAID"] = _G.RAID, ["PARTY"] = _G.PARTY, ["WHISPER"] = _G.WHISPER}
local misdtarget

-- Fetch spell info and store as strings
local imdSpellInfo = GetSpellInfo(34477)
local ittSpellInfo = GetSpellInfo(57934)
local iuaSpellInfo = GetSpellInfo(51672)

local imd = { name = imdSpellInfo and imdSpellInfo.name or "Unknown Spell", id = 34477 }
local itt = { name = ittSpellInfo and ittSpellInfo.name or "Unknown Spell", id = 57934 }
local iua = { name = iuaSpellInfo and iuaSpellInfo.name or "Unknown Spell", id = 51672 }

local hiconinfo = {
    [imd.name] = {"Interface\\Icons\\Ability_Hunter_Misdirection", 151},
}
local hicons = {[151] = imd.name}
local iconm = {
    [151] = "Ability_Hunter_Misdirection",
    [454] = "Ability_Rogue_TricksOftheTrade",
    [457] = "Ability_Rogue_UnfairAdvantage",
}
local riconinfo = {[itt.name] = {"Interface\\Icons\\Ability_Rogue_TricksOftheTrade", 454},}
local ricons = {[454] = itt.name, [457] = iua.name}

local callpet = {
    [1] = { name = (GetSpellInfo(883) or {}).name or "Unknown Spell", id = 883 },
    [2] = { name = (GetSpellInfo(83242) or {}).name or "Unknown Spell", id = 83242 },
    [3] = { name = (GetSpellInfo(83243) or {}).name or "Unknown Spell", id = 83243 },
    [4] = { name = (GetSpellInfo(83244) or {}).name or "Unknown Spell", id = 83244 },
    [5] = { name = (GetSpellInfo(83245) or {}).name or "Unknown Spell", id = 83245 },
}

local dismisspet = { name = (GetSpellInfo(2641) or {}).name or "Unknown Spell", id = 2641 }

local UnitName = UnitName
local GetPartyAssignment = GetPartyAssignment
local UnitGetAvailableRoles = UnitGetAvailableRoles
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitHealthMax = UnitHealthMax
local CreateFont = CreateFont
local InCombatLockdown = InCombatLockdown
local string, unpack, type, select, format = string, unpack, type, select, format
local pairs, ipairs, strsplit, tonumber = pairs, ipairs, strsplit, tonumber
local CreateMacro, EditMacro, GetMacroIndexByName, IsAddOnLoaded = CreateMacro, EditMacro, GetMacroIndexByName, IsAddOnLoaded
local GetNumGroupMembers, GetNumSubgroupMembers, IsInRaid, IsInGroup = GetNumGroupMembers, GetNumSubgroupMembers, IsInRaid, IsInGroup
local GetInstanceInfo, UnitIsGhost, UnitExists, GetSpellLink = GetInstanceInfo, UnitIsGhost, UnitExists, GetSpellLink
local UnitAffectingCombat, UnitInRaid, GetStablePetInfo, UnitIsPlayer = UnitAffectingCombat, UnitInRaid, GetStablePetInfo, UnitIsPlayer
local SendChatMessage, CreateFrame = SendChatMessage, CreateFrame
local GameTooltipText, GameTooltipHeaderText = GameTooltipText, GameTooltipHeaderText

local function set(info, value)
    local key = info[#info]
    
    if type(value) == "table" then
        value = tostring(value)
    end
    
    if key == "theme" then
        MDH.db.profile.theme = value
        MDH:ApplyTheme(value)
    else
        MDH.db.profile[key] = value
    end
end

local function get(info)
    local key = info[#info]
    local value = MDH.db.profile[key]
    if type(value) == "table" then
        value = tostring(value)
    end
    return value
end

local modkeys = {[1] = "shift", [2] = "ctrl", [3] = "alt",}
local modopts = {[1] = _G.SHIFT_KEY, [2] = _G.CTRL_KEY, [3] = _G.ALT_KEY,}

local defaults = {
    profile = {
        minimap = {hide = false},
        cChannel = "PARTY",
        name = "Pet",
        petname = _G.UNKNOWN,
        bAnnounce = nil,
        hicon = 151,
        ricon = 454,
        hname = tostring(imd.name), 
        rname = tostring(itt.name),
        target = "pet",
        target2 = nil,
        target3 = nil,
        name2 = nil,
        clearjoin = nil,
        remind = nil,
        modkey = 1,
        autotank = nil,
        autopet = nil,
        theme = _G.DEFAULT,
    },
    global = { custom = {} },
}

function MDH:MDHLoad()
    if UnitExists("pet") then MDH:MDHgetpet() end
    MDH:MDHEditMacro()
end

function MDH:MDHEditMacro()
    if InCombatLockdown() then return end

    local singlemacro, multiplemacro, macro, macroid
    local spell, id, mname, modkey

    if uc == "HUNTER" then
        spell = imd
        id = MDH.db.profile.hicon or hiconinfo[imd.name][2]
        mname = MDH.db.profile.hname or imd.name
    elseif uc == "ROGUE" then
        spell = itt
        id = MDH.db.profile.ricon or riconinfo[itt.name][2]
        mname = MDH.db.profile.rname or itt.name
    else
        print("Error: Unsupported class")
        return
    end

    modkey = modkeys[MDH.db.profile.modkey]

    mname = ensureString(mname)

    MDH:MDHTextUpdate()

    singlemacro = "#showtooltip\n/use [mod:" .. modkey .. ",@none][@%s,nodead]%s;%s"
    multiplemacro = "#showtooltip\n/use [mod:" .. modkey .. ",@none][btn:1,@%s,nodead][btn:2,@%s,nodead]%s;%s"

    local target = ensureString(MDH.db.profile.target or "target")
    local target2 = ensureString(MDH.db.profile.target2 or "target")

    if MDH.db.profile.target2 then
        macro = format(multiplemacro, target, target2, spell.name, spell.name)
    else
        macro = format(singlemacro, target, spell.name, spell.name)
    end
    
    macroid = GetMacroIndexByName(mname)
    if macroid == 0 then
        CreateMacro(mname, iconm[id], macro, 1, 1)
    else
        EditMacro(macroid, mname, iconm[id], macro)
    end
end

function MDH:MDHChat()
    if IsAddOnLoaded("CastYeller2") or IsAddOnLoaded("CastYeller") then return end
    local chan = MDH.db.profile.cChannel or "RAID"
    local s
    local spelllink = (uc == "HUNTER") and GetSpellLink(35079) or GetSpellLink(57934)
    local msg = format(L["%s casts %s on %s"], UnitName("player"), spelllink, misdtarget)

    if chan == "PARTY" and GetNumSubgroupMembers() ~= 0 then
        if (IsInGroup(_G.LE_PARTY_CATEGORY_INSTANCE)) then chan = "INSTANCE_CHAT" end
        s = true

    elseif chan == "RAID" and IsInRaid() then s = true
    elseif chan == "WHISPER" then if UnitIsPlayer(misdtarget) then s = true end end
    if s then SendChatMessage(msg, chan, nil, misdtarget) end
end

local function createMainPanel()
    local frame = CreateFrame("Frame", "MisdirectionHelperMain")
    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    local version = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    local author = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    local maintainer = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

    title:SetFormattedText("|T%s:%d|t %s", "Interface\\ICONS\\Ability_Hunter_Misdirection", 32, "Misdirection Helper 2")
    title:SetPoint("CENTER", frame, "CENTER", 0, 170)
    
    version:SetPoint("CENTER", frame, "CENTER", 0, 130)
    author:SetText(L["Author"] .. ": Deepac")
    author:SetPoint("CENTER", frame, "CENTER", 0, 100)
    
    maintainer:SetText("Maintainer: Sharpedge_Gaming")
    maintainer:SetPoint("CENTER", frame, "CENTER", 0, 70)
    
    return frame
end

local DELVE_MAP_IDS = {
    [2445] = true,
    [2446] = true,
    [2447] = true,
    [2448] = true,
    [2449] = true,
    [2450] = true,
    [2451] = true,
    [2452] = true,
    [2453] = true,
    [2454] = true,
    [2455] = true,
    [2456] = true,
    [2457] = true,
    [2458] = true,
    [2459] = true,
}



local function IsInDelveEnhanced()
    local mapID = C_Map.GetBestMapForUnit("player")
    if mapID and DELVE_MAP_IDS[mapID] then
        return true
    end
    return false
end

function MDH:EnsurePetDisplay(retries)
    if not MDH.db or not MDH.db.profile then return end
    if MDH.uc ~= "HUNTER" then return end
    if not IsInDelveEnhanced() then return end
    if UnitExists("pet") then
        local petName = UnitName("pet")
        MDH.db.profile.target = "pet"
        MDH.db.profile.name = petName
        MDH.db.profile.petname = petName
        if MDH.MDHEditMacro then MDH:MDHEditMacro() end
        if MDH.MDHTextUpdate then MDH:MDHTextUpdate() end
        if not MDH._delvePetShown then
            print("|cFF33FF99MDH:|r Delve detected – auto-set GUI to pet: " .. (petName or "<unknown>"))
            MDH._delvePetShown = true
        end
    else
        retries = (retries or 0) + 1
        if retries <= 5 then
            C_Timer.After(1, function() self:EnsurePetDisplay(retries) end)
        end
    end
end

-- Call as method:
MDH:EnsurePetDisplay()

--************ THEMES ************
local themelist, customlist
local fontlist = {
    [1] = "MDH",
    [2] = "Arial Narrow",
    [3] = "Morpheus",
    [4] = "Skurri",
    [5] = "Yellowjacket",
	[6] = "Caesar",
	[7] = "Blazed",
	[8] = "Adventure",
	[9] = "Geek",
	[10] = "Fitz",
	[11] = "OldEnglish",
	[12] = "Porky",
	[13] = "Roman",
	[14] = "Star",
	[15] = "SWF!T",
	[16] = "Abaddon",
	[17] = "Bazooka",
	[18] = "Chin",
	[19] = "Lemon",
	[20] = "Mona",
	[21] = "Nightmare",
	[22] = "Righteous",
	[23] = "Typewriter",
	[24] = "United",
	[25] = "Wood",
}
local tmpcopy, tempname, tempdata
local temptheme = {headerfont="MDHHeaderFont",linefont="MDHLineFont",title={1,0,0,1,"ffffff00"},spacer={0,0,1,1},group1={1,0,0,1},group2={0,1,1,1},group3={0,0.8,0.2,1},group4={1,0,1,0,"ffffff00","ffff0033"},group5={1,0,1,1,"ffffff00"}}
MDH.themes = {
    [_G.DEFAULT] = {headerfont = "MyCustomHeaderFont", linefont = "MyCustomLineFont", title = {1,0,0,1,"ffffff00"}, spacer = {0,0,1,1}, group1 = {1,0,0,1}, group2 = {0,1,1,1}, group3 = {0,0.8,0.2,1}, group4 = {1,0,1,0,"ffffff00","ffff0033"}, group5 = {1,0,1,1,"ffffff00"}},
    ["Basic"] = {headerfont = "MyCustomHeaderFont", linefont = "MyCustomLineFont", title = {0,0,0,0,"ffffffff"}, spacer = {0,0,0,0}, group1 = {0,0,0,0}, group2 = {0,0,0,0}, group3 = {0,0,0,0}, group4 = {0,0,0,0,"ffffffff","ffffffff"}, group5 = {0,0,0,0,"ffffffff"}},
    ["ElvUI"] = {headerfont = "ElvUIHeaderFont", linefont = "ElvUILineFont", title = {0,0,0,0,"ff1784d1"}, spacer = {0,0,1,1}, group1 = {0,0,0,0}, group2 = {0,0,0,0}, group3 = {0,0,0,0}, group4 = {0,0,0,0,"ff1784d1","ff778899"}, group5 = {0,0,0,0,"ff1784d1"}},
    ["Dark"] = {
        headerfont = "Friz Quadrata TT",
        linefont = "Arial Narrow",
        title = {0.1, 0.1, 0.1, 1, "ffFFFFFF"}, -- Dark background with white font color
        spacer = {1, 1, 1, 1}, -- White background for spacers
        group1 = {0.1, 0.1, 0.1, 1}, -- Dark background for group1
        group2 = {0.1, 0.1, 0.1, 1}, -- Dark background for group2
        group3 = {0.1, 0.1, 0.1, 1}, -- Dark background for group3
        group4 = {0.1, 0.1, 0.1, 1, "ffFFFFFF", "ffBBBBBB"}, -- Dark background with white and light grey font colors
        group5 = {0.1, 0.1, 0.1, 1, "ffFFFFFF"} -- Dark background with white font color
    },
    ["Vibrant"] = {
        headerfont = "Morpheus",
        linefont = "Skurri",
        title = {0.9, 0.2, 0.2, 1, "ff000000"}, -- Bright red background with black font color
        spacer = {0.2, 0.9, 0.2, 1}, -- Bright green background for spacers
        group1 = {0.2, 0.2, 0.9, 1}, -- Bright blue background for group1
        group2 = {0.9, 0.9, 0.2, 1}, -- Bright yellow background for group2
        group3 = {0.9, 0.2, 0.9, 1}, -- Bright pink background for group3
        group4 = {0.2, 0.9, 0.9, 1, "ff000000", "ff000000"}, -- Bright cyan background with black font colors
        group5 = {0.9, 0.4, 0.2, 1, "ff000000"} -- Bright orange background with black font color
    },
    ["Ocean Breeze"] = {
        headerfont = "Skurri",
        linefont = "Arial Narrow",
        title = {0.2, 0.4, 0.8, 1, "ffFFFFFF"}, -- Cool blue background with white font color
        spacer = {0.4, 0.6, 0.8, 1}, -- Light blue background for spacers
        group1 = {0.2, 0.5, 0.7, 1}, -- Blue background for group1
        group2 = {0.3, 0.6, 0.8, 1}, -- Blue background for group2
        group3 = {0.2, 0.5, 0.7, 1}, -- Blue background for group3
        group4 = {0.4, 0.6, 0.8, 1, "ffFFFFFF", "ffDDDDDD"}, -- Light blue background with white and light grey font colors
        group5 = {0.2, 0.5, 0.7, 1, "ffFFFFFF"} -- Blue background with white font color
    },
    ["Sunset Glow"] = {
        headerfont = "Morpheus",
        linefont = "Friz Quadrata TT",
        title = {0.9, 0.4, 0.2, 1, "ff000000"}, -- Warm orange background with black font color
        spacer = {0.9, 0.2, 0.1, 1}, -- Bright red background for spacers
        group1 = {0.8, 0.3, 0.1, 1}, -- Warm orange background for group1
        group2 = {0.9, 0.4, 0.2, 1}, -- Warm orange background for group2
        group3 = {0.8, 0.3, 0.1, 1}, -- Warm orange background for group3
        group4 = {0.9, 0.2, 0.1, 1, "ff000000", "ff333333"}, -- Bright red background with black and dark grey font colors
        group5 = {0.8, 0.3, 0.1, 1, "ff000000"} -- Warm orange background with black font color
    },
    ["Forest Whisper"] = {
        headerfont = "Arial Narrow",
        linefont = "Skurri",
        title = {0.2, 0.6, 0.2, 1, "ffFFFFFF"}, -- Green background with white font color
        spacer = {0.3, 0.7, 0.3, 1}, -- Light green background for spacers
        group1 = {0.2, 0.5, 0.2, 1}, -- Green background for group1
        group2 = {0.3, 0.7, 0.3, 1}, -- Light green background for group2
        group3 = {0.2, 0.5, 0.2, 1}, -- Green background for group3
        group4 = {0.3, 0.7, 0.3, 1, "ffFFFFFF", "ffDDDDDD"}, -- Light green background with white and light grey font colors
        group5 = {0.2, 0.5, 0.2, 1, "ffFFFFFF"} -- Green background with white font color
    },
    ["Night Sky"] = {
        headerfont = "Morpheus",
        linefont = "Friz Quadrata TT",
        title = {0.1, 0.1, 0.3, 1, "ffFFFFFF"}, -- Dark blue background with white font color
        spacer = {0.2, 0.2, 0.5, 1}, -- Darker blue background for spacers
        group1 = {0.1, 0.1, 0.4, 1}, -- Dark blue background for group1
        group2 = {0.2, 0.2, 0.5, 1}, -- Darker blue background for group2
        group3 = {0.1, 0.1, 0.4, 1}, -- Dark blue background for group3
        group4 = {0.2, 0.2, 0.5, 1, "ffFFFFFF", "ffCCCCFF"}, -- Darker blue background with white and light purple font colors
        group5 = {0.1, 0.1, 0.4, 1, "ffFFFFFF"} -- Dark blue background with white font color
    },
    ["Candy Pop"] = {
        headerfont = "Skurri",
        linefont = "Arial Narrow",
        title = {0.9, 0.6, 0.6, 1, "ff000000"}, -- Bright pink background with black font color
        spacer = {0.9, 0.9, 0.2, 1}, -- Bright yellow background for spacers
        group1 = {0.8, 0.4, 0.9, 1}, -- Bright purple background for group1
        group2 = {0.9, 0.6, 0.6, 1}, -- Bright pink background for group2
        group3 = {0.8, 0.4, 0.9, 1}, -- Bright purple background for group3
        group4 = {0.9, 0.9, 0.2, 1, "ff000000", "ff333333"}, -- Bright yellow background with black and dark grey font colors
        group5 = {0.8, 0.4, 0.9, 1, "ff000000"} -- Bright purple background with black font color
    },
    ["Fire Storm"] = {
        headerfont = "Skurri",
        linefont = "Friz Quadrata TT",
        title = {0.8, 0.2, 0.2, 1, "ffFFFFFF"}, -- Fiery red background with white font color
        spacer = {0.9, 0.4, 0.1, 1}, -- Bright orange background for spacers
        group1 = {0.8, 0.3, 0.1, 1}, -- Warm orange background for group1
        group2 = {0.8, 0.2, 0.2, 1}, -- Fiery red background for group2
        group3 = {0.9, 0.4, 0.1, 1}, -- Bright orange background for group3
        group4 = {0.8, 0.3, 0.1, 1, "ffFFFFFF", "ffDDDDDD"}, -- Warm orange background with white and light grey font colors
        group5 = {0.8, 0.2, 0.2, 1, "ffFFFFFF"} -- Fiery red background with white font color
    },
    ["Tropical Rain"] = {
        headerfont = "Arial Narrow",
        linefont = "Skurri",
        title = {0.3, 0.8, 0.3, 1, "ff000000"}, -- Vibrant green background with black font color
        spacer = {0.1, 0.5, 0.1, 1}, -- Dark green background for spacers
        group1 = {0.3, 0.8, 0.3, 1}, -- Vibrant green background for group1
        group2 = {0.4, 0.9, 0.4, 1}, -- Light green background for group2
        group3 = {0.1, 0.5, 0.1, 1}, -- Dark green background for group3
        group4 = {0.3, 0.8, 0.3, 1, "ff000000", "ff333333"}, -- Vibrant green background with black and dark grey font colors
        group5 = {0.4, 0.9, 0.4, 1, "ff000000"} -- Light green background with black font color
    },
    ["Royal Purple"] = {
        headerfont = "Morpheus",
        linefont = "Arial Narrow",
        title = {0.5, 0.1, 0.5, 1, "ffFFFFFF"}, -- Deep purple background with white font color
        spacer = {0.8, 0.2, 0.8, 1}, -- Bright purple background for spacers
        group1 = {0.5, 0.1, 0.5, 1}, -- Deep purple background for group1
        group2 = {0.8, 0.2, 0.8, 1}, -- Bright purple background for group2
        group3 = {0.5, 0.1, 0.5, 1}, -- Deep purple background for group3
        group4 = {0.8, 0.2, 0.8, 1, "ffFFFFFF", "ffCCCCCC"}, -- Bright purple background with white and light grey font colors
        group5 = {0.5, 0.1, 0.5, 1, "ffFFFFFF"} -- Deep purple background with white font color
    },
    ["Neon Lights"] = {
        headerfont = "Skurri",
        linefont = "Friz Quadrata TT",
        title = {0.1, 0.9, 0.9, 1, "ff000000"}, -- Bright cyan background with black font color
        spacer = {0.2, 0.7, 0.7, 1}, -- Teal background for spacers
        group1 = {0.1, 0.8, 0.8, 1}, -- Cyan background for group1
        group2 = {0.2, 0.9, 0.9, 1}, -- Bright cyan background for group2
        group3 = {0.2, 0.7, 0.7, 1}, -- Teal background for group3
        group4 = {0.1, 0.9, 0.9, 1, "ff000000", "ff333333"}, -- Bright cyan background with black and dark grey font colors
        group5 = {0.1, 0.8, 0.8, 1, "ff000000"} -- Cyan background with black font color
    },
    ["Candy Pop"] = {
        headerfont = "Skurri",
        linefont = "Arial Narrow",
        title = {0.9, 0.6, 0.6, 1, "ff000000"}, -- Bright pink background with black font color
        spacer = {0.9, 0.9, 0.2, 1}, -- Bright yellow background for spacers
        group1 = {0.8, 0.4, 0.9, 1}, -- Bright purple background for group1
        group2 = {0.9, 0.6, 0.6, 1}, -- Bright pink background for group2
        group3 = {0.8, 0.4, 0.9, 1}, -- Bright purple background for group3
        group4 = {0.9, 0.9, 0.2, 1, "ff000000", "ff333333"}, -- Bright yellow background with black and dark grey font colors
        group5 = {0.8, 0.4, 0.9, 1, "ff000000"} -- Bright purple background with black font color
    },
    ["Electric Blue"] = {
        headerfont = "Morpheus",
        linefont = "Friz Quadrata TT",
        title = {0.2, 0.4, 0.9, 1, "ffFFFFFF"}, -- Electric blue background with white font color
        spacer = {0.3, 0.5, 1, 1}, -- Bright blue background for spacers
        group1 = {0.2, 0.4, 0.9, 1}, -- Electric blue background for group1
        group2 = {0.3, 0.5, 1, 1}, -- Bright blue background for group2
        group3 = {0.2, 0.4, 0.9, 1}, -- Electric blue background for group3
        group4 = {0.3, 0.5, 1, 1, "ffFFFFFF", "ffCCCCFF"}, -- Bright blue background with white and light purple font colors
        group5 = {0.2, 0.4, 0.9, 1, "ffFFFFFF"} -- Electric blue background with white font color
    },
    ["Bold Red"] = {
        headerfont = "Skurri",
        linefont = "Arial Narrow",
        title = {0.8, 0.2, 0.2, 1, "ffFFFFFF"}, -- Bold red background with white font color
        spacer = {0.9, 0.1, 0.1, 1}, -- Bright red background for spacers
        group1 = {0.8, 0.2, 0.2, 1}, -- Bold red background for group1
        group2 = {0.9, 0.1, 0.1, 1}, -- Bright red background for group2
        group3 = {0.8, 0.2, 0.2, 1}, -- Bold red background for group3
        group4 = {0.9, 0.1, 0.1, 1, "ffFFFFFF", "ffDDDDDD"}, -- Bright red background with white and light grey font colors
        group5 = {0.8, 0.2, 0.2, 1, "ffFFFFFF"} -- Bold red background with white font color
    },
    ["Vivid Green"] = {
        headerfont = "Arial Narrow",
        linefont = "Skurri",
        title = {0.2, 0.9, 0.2, 1, "ff000000"}, -- Vivid green background with black font color
        spacer = {0.3, 0.9, 0.3, 1}, -- Bright green background for spacers
        group1 = {0.2, 0.8, 0.2, 1}, -- Vivid green background for group1
        group2 = {0.3, 0.9, 0.3, 1}, -- Bright green background for group2
        group3 = {0.2, 0.8, 0.2, 1}, -- Vivid green background for group3
        group4 = {0.3, 0.9, 0.3, 1, "ff000000", "ff333333"}, -- Bright green background with black and dark grey font colors
        group5 = {0.2, 0.8, 0.2, 1, "ff000000"} -- Vivid green background with black font color
    },
    ["Sunny Yellow"] = {
        headerfont = "Skurri",
        linefont = "Arial Narrow",
        title = {0.9, 0.9, 0.2, 1, "ff000000"}, -- Bright yellow background with black font color
        spacer = {0.9, 0.9, 0.4, 1}, -- Light yellow background for spacers
        group1 = {0.9, 0.9, 0.2, 1}, -- Bright yellow background for group1
        group2 = {0.9, 0.9, 0.4, 1}, -- Light yellow background for group2
        group3 = {0.9, 0.9, 0.2, 1}, -- Bright yellow background for group3
        group4 = {0.9, 0.9, 0.4, 1, "ff000000", "ff333333"}, -- Light yellow background with black and dark grey font colors
        group5 = {0.9, 0.9, 0.2, 1, "ff000000"} -- Bright yellow background with black font color
    }
}

local function GetTTFont(font)
    local pos = string.find(font, "Header") or string.find(font, "Line")
    if not pos then return nil end
    local name = string.sub(font, 1, pos - 1)
    for k, v in pairs(fontlist) do
        if v == name then
            return k
        end
    end
    return nil
end

function MDH:MDHTextUpdate() MDH.dataObject.text = MDH:TTText("both") end

local function stringify(array)
    local out = ""
    for _, v in ipairs(array) do out = out .. v .. ";" end
    out = string.sub(out, 1, string.len(out) - 1)
    return out
end

local function encodeTheme(theme)
    local encoded = "1" .. GetTTFont(theme.headerfont) .. ":2" .. GetTTFont(theme.linefont)
    local keys = {["title"] = 3, ["spacer"] = 4, ["group1"] = 5, ["group2"] = 6, ["group3"] = 7, ["group4"] = 8, ["group5"] = 9}
    for k, v in pairs(theme) do 
        if k ~= "headerfont" and k ~= "linefont" then 
            encoded = encoded .. ":" .. keys[k] .. stringify(v) 
        end 
    end
    return encoded
end

local function destringify(val)
    local vals = {strsplit(";", val)}
    if vals[6] then 
        return vals[1], vals[2], vals[3], vals[4], vals[5], vals[6]
    elseif vals[5] then 
        return vals[1], vals[2], vals[3], vals[4], vals[5]
    else 
        return vals[1], vals[2], vals[3], vals[4] 
    end
end

function MDH:decodeTheme(encoded)
    local keys = {[3] = "title", [4] = "spacer", [5] = "group1", [6] = "group2", [7] = "group3", [8] = "group4", [9] = "group5"}
    local vals = {strsplit(":", encoded)}
    local ord, v2
    for _, v in ipairs(vals) do
        ord = tonumber(string.sub(v, 1, 1))
        if ord == 1 then 
            temptheme.headerfont = fontlist[tonumber(string.sub(v, 2, 2))] .. "HeaderFont"
        elseif ord == 2 then 
            temptheme.linefont = fontlist[tonumber(string.sub(v, 2, 2))] .. "LineFont"
        else 
            temptheme[keys[ord]] = {destringify(string.sub(v, 2))} 
        end
    end
end

local function validateThemeName(info, value)
    local out
    local val = MDH:trim(value or "")
    if val == "" then out = L["Please enter a valid theme name"] end
    if MDH.themes[value] then out = L["Theme name already in use"] end
    if out then MDH:ShowError(out); tempname = nil end
    return out or true
end

local function updateThemeList()
    themelist, customlist = {}, {}
    for k, v in pairs(MDH.themes) do 
        themelist[k] = k 
    end
    for k, v in pairs(MDH.db.global.custom) do
        local editedName = k .. " (edited)"
        customlist[editedName] = editedName
        themelist[editedName] = editedName
    end
end

local function saveTheme()
    if type(validateThemeName(nil, tempname)) ~= "boolean" then return end
    MDH.db.global.custom[tempname] = temptheme
    local editedName = tempname .. " (edited)"
    MDH.themes[editedName] = temptheme
    updateThemeList()
    tempname = nil
    tempdata = nil
    MDH:ShowError(L["Theme saved"])
end

local function editTheme()
    local actualName = tempname:gsub(" %(edited%)", "")
    MDH.db.global.custom[actualName] = temptheme
    local editedName = actualName .. " (edited)"
    MDH.themes[editedName] = temptheme
    updateThemeList()
    tempname = nil
    MDH:ShowError(L["Theme saved"])
end

local function deleteTheme()
    if not tempname then MDH:ShowError(L["Please enter a valid theme name"]); return end
    local actualName = tempname:gsub(" %(edited%)", "")
    if MDH.db.profile.theme == actualName .. " (edited)" then 
        MDH.db.profile.theme = _G.DEFAULT 
    end
    MDH.db.global.custom[actualName] = nil
    MDH.themes[actualName .. " (edited)"] = nil
    updateThemeList()
    tempname = nil
    MDH:ShowError(L["Theme deleted"])
end

local function checkThemes()
    for k in pairs(MDH.db.global.custom) do if k then return false end end
    return true
end

function MDH:OnInitialize()
    local AceConfig = LibStub("AceConfig-3.0")
    local AceConfigDialog = LibStub("AceConfigDialog-3.0")
    local AceDBOptions = LibStub("AceDBOptions-3.0")
    local mainPanel = createMainPanel()
    local optionsTable, themesTable
    local k, v
    
    self.db = AceDB:New("MisdirectionHelperDB", defaults, true)
    MDH.db = LibStub("AceDB-3.0"):New("MisDirectionHelperDB", defaults)
    optionsTable = {
        type = "group",
        name = _G.MAIN_MENU,
        inline = false,
        args = {
            showMinimapIcon = {
                order = 1,
                type = "toggle",
                width = "full",
                name = L["Minimap Icon"],
                desc = L["Toggle Minimap icon"],
                get = function() return not MDH.db.profile.minimap.hide end,
                set = function(info, value)
                    MDH.db.profile.minimap.hide = not value
                    if value then icon:Show("MisdirectionHelper")
                    else icon:Hide("MisdirectionHelper") end
                end,
            },
            clearleave = {
                order = 2,
                type = "toggle",
                width = "full",
                name = L["Clear when joining group"],
                desc = L["Clear both targets when joining a raid / party"],
                get = function() return MDH.db.profile.clearjoin end,
                set = function(info, value)
                    MDH.db.profile.clearjoin = value
                    if value then MDH:RegisterEvent("GROUP_ROSTER_UPDATE")
                    else MDH:UnregisterEvent("GROUP_ROSTER_UPDATE") end
                end,
            },
            autotank = {
                order = 2,
                type = "toggle",
                width = "full",
                name = L["Set to tank when joining party"],
                desc = L["Set the target to the main tank when joining a party. May not pick the right character if roles have not been set."],
                get = function() return MDH.db.profile.autotank end,
                set = function(info, value)
                    MDH.db.profile.autotank = value
                    if value then MDH:RegisterEvent("GROUP_ROSTER_UPDATE")
                    else MDH:UnregisterEvent("GROUP_ROSTER_UPDATE") end
                end,
            },
            autopet = {
                order = 3,
                type = "toggle",
                width = "full",
                name = L["Set to pet when leaving party"],
                desc = L["Set the target to your pet when leaving a party"],
                get = function() return MDH.db.profile.autopet end,
                set = function(info, value)
                    MDH.db.profile.autopet = value
                    if value then MDH:RegisterEvent("GROUP_ROSTER_UPDATE")
                    else MDH:UnregisterEvent("GROUP_ROSTER_UPDATE") end
                end,
            },
            remind = {
                order = 4,
                type = "toggle",
                width = "full",
                name = L["Show reminder"],
                desc = L["Display a reminder to set targets on entering an instance / raid"],
                get = function() return MDH.db.profile.remind end,
                set = function(info, value)
                    MDH.db.profile.remind = value
                    if value then MDH:RegisterEvent("ZONE_CHANGED_NEW_AREA")
                    else MDH:UnregisterEvent("ZONE_CHANGED_NEW_AREA") end
                end,
            },
            buffmessage = {
                order = 5,
                type = "toggle",
                name = L["Buff Alert"],
                desc = L["Toggle Misdirection Applied Announcement"],
                get = function() return MDH.db.profile.bAnnounce end,
                set = function(info, value) MDH.db.profile.bAnnounce = value end,
            },
            cChannel = {
                type = "select",
                name = L["Buff Channel"],
                desc = L["Select Channel for Buff Announcements"],
                hidden = function() return not MDH.db.profile.bAnnounce end,
                order = 6,
                get = function() return MDH.db.profile.cChannel end,
                set = function(info, value) MDH.db.profile.cChannel = value end,
                values = channels,
            },
            spacer1 = {
                order = 7,
                type = "description",
                name = "\n",
            },
            hicon = {
                type = "select",
                name = L["Misdirection macro icon"],
                order = 8,
                hidden = function() return uc == "ROGUE" end,
                get = function() return MDH.db.profile.hicon or hiconinfo[imd.name][2] end,
                set = function(info, value)
                    MDH.db.profile.hicon = value
                    MDH:MDHEditMacro()
                end,
                values = hicons,
            },
            ricon = {
                type = "select",
                name = L["Tricks of the Trade macro icon"],
                order = 9,
                hidden = function() return uc == "HUNTER" end,
                get = function() return MDH.db.profile.ricon or riconinfo[itt.name][2] end,
                set = function(info, value)
                    MDH.db.profile.ricon = value
                    MDH:MDHEditMacro()
                end,
                values = ricons,
            },
            bkey = {
                type = "select",
                name = L["Macro bypass key"],
                order = 10,
                get = function() return MDH.db.profile.modkey end,
                set = function(info, value)
                    MDH.db.profile.modkey = value
                    MDH:MDHEditMacro()
                end,
                values = modopts,
            },
            hmname = {
                type = "input",
                name = L["Macro name"],
                width = "double",
                order = 11,
                desc = L["Name to use for the macro"],
                get = function() return MDH.db.profile.hname end,
                set = function(info, value)
                    MDH.db.profile.hname = value
                    MDH:MDHEditMacro()
                end,
                hidden = function() return uc == "ROGUE" end,
            },
            rmname = {
                type = "input",
                name = L["Macro name"],
                desc = L["Name to use for the macro"],
                order = 12,
                width = "double",
                get = function() return MDH.db.profile.rname end,
                set = function(info, value)
                    MDH.db.profile.rname = value
                    MDH:MDHEditMacro()
                end,
                hidden = function() return uc == "HUNTER" end,
            },
        },
    }

    themesTable = {
        type = "group",
        name = L["Themes"],
        inline = false,
        args = {
            selecttheme = {
                order = 1,
                type = "group",
                name = L["Select"],
                inline = false,
                args = {
                    selection = {
                        order = 1,
                        type = "select",
                        name = L["Select"],
                        get = function() return MDH.db.profile.theme or themelist[1] end,
                        set = function(info, value)
                            MDH.db.profile.theme = value
                            MDH:ApplyTheme(value)
                        end,
                        values = function() return themelist end,
                    },
                },
            },
            createtheme = {
                order = 2,
                type = "group",
                name = _G.BATTLETAG_CREATE,
                inline = false,
                args = {
                    themename = {
                        order = 1,
                        type = "input",
                        name = L["Theme name"],
                        get = function() return tempname end,
                        set = function(info, value) tempname = value end,
                        validate = validateThemeName,
                    },
                    themecopy = {
                        order = 1.5,
                        type = "select",
                        name = L["Copy theme"],
                        get = function() return tmpcopy end,
                        set = function(info, value)
                            temptheme = MDH:deepcopy(MDH.themes[value])
                            tmpcopy = value
                        end,
                        values = function() return themelist end,
                    },
                    spacer1 = {
                        order = 2,
                        type = "description",
                        width = "full",
                        name = "",
                    },
                    header1 = {
                        order = 3,
                        type = "header",
                        name = L["Fonts"],
                    },
                    headerfont = {
                    order = 4,
                    type = "select",
                    name = L["Header font"],
                    values = fontlist,
                    get = function() return GetTTFont(temptheme.headerfont) end,
                    set = function(info, val) temptheme.headerfont = fontlist[val] .. "HeaderFont" end,
                    },
                    spacer2 = {
                        order = 4.5,
                        type = "description",
                        width = "full",
                        name = "",
                    },
                    linefont = {
                    order = 5,
                    type = "select",
                    name = L["Line font"],
                    values = fontlist,
                    get = function() return GetTTFont(temptheme.linefont) end,
                    set = function(info, val) temptheme.linefont = fontlist[val] .. "LineFont" end,
                    },
                    spacer3 = {
                        order = 5.5,
                        type = "description",
                        width = "full",
                        name = "",
                    },
                    header2 = {
                        order = 6,
                        type = "header",
                        name = _G.BACKGROUND,
                    },
                    title = {
                        order = 6.5,
                        type = "color",
                        hasAlpha = true,
                        name = L["Header"],
                        get = function() return temptheme.title[1], temptheme.title[2], temptheme.title[3], temptheme.title[4] end,
                        set = function(info, r, g, b, a) temptheme.title[1] = r; temptheme.title[2] = g; temptheme.title[3] = b; temptheme.title[4] = a end,
                    },
                    group1 = {
                        order = 7,
                        type = "color",
                        hasAlpha = true,
                        name = L["'Set' options"],
                        get = function() return temptheme.group1[1], temptheme.group1[2], temptheme.group1[3], temptheme.group1[4] end,
                        set = function(info, r, g, b, a) temptheme.group1[1] = r; temptheme.group1[2] = g; temptheme.group1[3] = b; temptheme.group1[4] = a end,
                    },
                    group2 = {
                        order = 8,
                        type = "color",
                        hasAlpha = true,
                        name = L["Enter Player Name"],
                        get = function() return temptheme.group2[1], temptheme.group2[2], temptheme.group2[3], temptheme.group2[4] end,
                        set = function(info, r, g, b, a) temptheme.group2[1] = r; temptheme.group2[2] = g; temptheme.group2[3] = b; temptheme.group2[4] = a end,
                    },
                    group3 = {
                        order = 9,
                        type = "color",
                        hasAlpha = true,
                        name = L["Clear Target"],
                        get = function() return temptheme.group3[1], temptheme.group3[2], temptheme.group3[3], temptheme.group3[4] end,
                        set = function(info, r, g, b, a) temptheme.group3[1] = r; temptheme.group3[2] = g; temptheme.group3[3] = b; temptheme.group3[4] = a end,
                    },
                    group4 = {
                        order = 11,
                        type = "color",
                        hasAlpha = true,
                        name = L["Left/Right Click"],
                        get = function() return temptheme.group4[1], temptheme.group4[2], temptheme.group4[3], temptheme.group4[4] end,
                        set = function(info, r, g, b, a) temptheme.group4[1] = r; temptheme.group4[2] = g; temptheme.group4[3] = b; temptheme.group4[4] = a end,
                    },
                    group5 = {
                        order = 12,
                        type = "color",
                        hasAlpha = true,
                        name = L["Information"],
                        get = function() return temptheme.group5[1], temptheme.group5[2], temptheme.group5[3], temptheme.group5[4] end,
                        set = function(info, r, g, b, a) temptheme.group5[1] = r; temptheme.group5[2] = g; temptheme.group5[3] = b; temptheme.group5[4] = a end,
                    },
                    header3 = {
                        order = 13,
                        type = "header",
                        name = L["Text"],
                    },
                    title1text = {
                        order = 14,
                        type = "color",
                        name = L["Header"],
                        get = function() return MDH:HexToRGBA(temptheme.title[5]) end,
                        set = function(info, r, g, b, a) temptheme.title[5] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    group4text = {
                        order = 15,
                        type = "color",
                        name = L["Left/Right Click"],
                        get = function() return MDH:HexToRGBA(temptheme.group4[5]) end,
                        set = function(info, r, g, b, a) temptheme.group4[5] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    group4target = {
                        order = 16,
                        type = "color",
                        name = L["Left/Right Click target"],
                        get = function() return MDH:HexToRGBA(temptheme.group4[6]) end,
                        set = function(info, r, g, b, a) temptheme.group4[6] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    group5text = {
                        order = 17,
                        type = "color",
                        name = L["Information"],
                        get = function() return MDH:HexToRGBA(temptheme.group5[5]) end,
                        set = function(info, r, g, b, a) temptheme.group5[5] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    header3 = {
                        order = 17.1,
                        type = "header",
                        name = L["Dividers"],
                    },
                    divider = {
                        order = 17.2,
                        type = "color",
                        name = L["Dividers"],
                        get = function() return temptheme.spacer[1], temptheme.spacer[2], temptheme.spacer[3], temptheme.spacer[4] end,
                        set = function(info, r, g, b, a) temptheme.spacer[1] = r; temptheme.spacer[2] = g; temptheme.spacer[3] = b; temptheme.spacer[4] = a end,
                    },
                    spacer3 = {
                        order = 17.5,
                        type = "description",
                        width = "full",
                        name = "\n",
                    },
                    savebutton = {
                        order= 18,
                        type = "execute",
                        name = _G.SAVE,
                        disabled = function() return tempname == nil end,
                        func = saveTheme,
                    },
                },
            },
            edittheme = {
                order = 3,
                type = "group",
                name = L["Edit"],
                inline = false,
                args = {
                    themename = {
                        order = 1,
                        type = "select",
                        name = L["Select"],
                        get = function() return tempname end,
                        set = function(info, value) 
                            tempname = value 
                            local actualName = value:gsub(" %(edited%)", "")
                            temptheme = MDH:deepcopy(MDH.themes[actualName] or MDH.db.global.custom[actualName])
                        end,
                        values = function() return themelist end,
                    },
                    spacer1 = {
                        order = 2,
                        type = "description",
                        width = "full",
                        name = "",
                    },
                    header1 = {
                        order = 3,
                        type = "header",
                        name = L["Fonts"],
                        hidden = function() return tempname == nil end,
                    },
                    headerfont = {
                        order = 4,
                        type = "select",
                        name = L["Header font"],
                        values = fontlist,
                        hidden = function() return tempname == nil end,
                        get = function() return GetTTFont(temptheme.headerfont) end,
                        set = function(info, val) temptheme.headerfont = fontlist[val] .. "HeaderFont" end,
                    },
                    spacer2 = {
                        order = 4.5,
                        type = "description",
                        width = "full",
                        name = "",
                    },
                    linefont = {
                        order = 5,
                        type = "select",
                        name = L["Line font"],
                        values = fontlist,
                        hidden = function() return tempname == nil end,
                        get = function() return GetTTFont(temptheme.linefont) end,
                        set = function(info, val) temptheme.linefont = fontlist[val] .. "LineFont" end,
                    },
                    spacer3 = {
                        order = 5.5,
                        type = "description",
                        width = "full",
                        name = "",
                    },
                    header2 = {
                        order = 6,
                        type = "header",
                        name = _G.BACKGROUND,
                        hidden = function() return tempname == nil end,
                    },
                    title = {
                        order = 6.5,
                        type = "color",
                        hasAlpha = true,
                        name = L["Header"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.title[1], temptheme.title[2], temptheme.title[3], temptheme.title[4] end,
                        set = function(info, r, g, b, a) temptheme.title[1] = r; temptheme.title[2] = g; temptheme.title[3] = b; temptheme.title[4] = a end,
                    },
                    group1 = {
                        order = 7,
                        type = "color",
                        hasAlpha = true,
                        name = L["'Set' options"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.group1[1], temptheme.group1[2], temptheme.group1[3], temptheme.group1[4] end,
                        set = function(info, r, g, b, a) temptheme.group1[1] = r; temptheme.group1[2] = g; temptheme.group1[3] = b; temptheme.group1[4] = a end,
                    },
                    group2 = {
                        order = 8,
                        type = "color",
                        hasAlpha = true,
                        name = L["Enter Player Name"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.group2[1], temptheme.group2[2], temptheme.group2[3], temptheme.group2[4] end,
                        set = function(info, r, g, b, a) temptheme.group2[1] = r; temptheme.group2[2] = g; temptheme.group2[3] = b; temptheme.group2[4] = a end,
                    },
                    group3 = {
                        order = 9,
                        type = "color",
                        hasAlpha = true,
                        name = L["Clear Target"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.group3[1], temptheme.group3[2], temptheme.group3[3], temptheme.group3[4] end,
                        set = function(info, r, g, b, a) temptheme.group3[1] = r; temptheme.group3[2] = g; temptheme.group3[3] = b; temptheme.group3[4] = a end,
                    },
                    group4 = {
                        order = 11,
                        type = "color",
                        hasAlpha = true,
                        name = L["Left/Right Click"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.group4[1], temptheme.group4[2], temptheme.group4[3], temptheme.group4[4] end,
                        set = function(info, r, g, b, a) temptheme.group4[1] = r; temptheme.group4[2] = g; temptheme.group4[3] = b; temptheme.group4[4] = a end,
                    },
                    group5 = {
                        order = 12,
                        type = "color",
                        hasAlpha = true,
                        name = L["Information"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.group5[1], temptheme.group5[2], temptheme.group5[3], temptheme.group5[4] end,
                        set = function(info, r, g, b, a) temptheme.group5[1] = r; temptheme.group5[2] = g; temptheme.group5[3] = b; temptheme.group5[4] = a end,
                    },
                    header3 = {
                        order = 13,
                        type = "header",
                        name = L["Text"],
                        hidden = function() return tempname == nil end,
                    },
                    title1text = {
                        order = 14,
                        type = "color",
                        name = L["Header"],
                        hidden = function() return tempname == nil end,
                        get = function() return MDH:HexToRGBA(temptheme.title[5]) end,
                        set = function(info, r, g, b, a) temptheme.title[5] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    group4text = {
                        order = 15,
                        type = "color",
                        name = L["Left/Right Click"],
                        hidden = function() return tempname == nil end,
                        get = function() return MDH:HexToRGBA(temptheme.group4[5]) end,
                        set = function(info, r, g, b, a) temptheme.group4[5] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    group4target = {
                        order = 16,
                        type = "color",
                        name = L["Left/Right Click target"],
                        hidden = function() return tempname == nil end,
                        get = function() return MDH:HexToRGBA(temptheme.group4[6]) end,
                        set = function(info, r, g, b, a) temptheme.group4[6] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    group5text = {
                        order = 17,
                        type = "color",
                        name = L["Information"],
                        hidden = function() return tempname == nil end,
                        get = function() return MDH:HexToRGBA(temptheme.group5[5]) end,
                        set = function(info, r, g, b, a) temptheme.group5[5] = MDH:RGBAToHex(r, g, b, a) end,
                    },
                    header3 = {
                        order = 17.1,
                        type = "header",
                        name = L["Dividers"],
                        hidden = function() return tempname == nil end,
                    },
                    divider = {
                        order = 17.2,
                        type = "color",
                        name = L["Dividers"],
                        hidden = function() return tempname == nil end,
                        get = function() return temptheme.spacer[1], temptheme.spacer[2], temptheme.spacer[3], temptheme.spacer[4] end,
                        set = function(info, r, g, b, a) temptheme.spacer[1] = r; temptheme.spacer[2] = g; temptheme.spacer[3] = b; temptheme.spacer[4] = a end,
                    },
                    spacer3 = {
                        order = 17.5,
                        type = "description",
                        width = "full",
                        name = "\n",
                    },
                    editbutton = {
                        order= 18,
                        type = "execute",
                        name = _G.SAVE,
                        hidden = function() return tempname == nil end,
                        disabled = function() return tempname == nil end,
                        func = editTheme,
                    },
                },
            },
            deletetheme = {
                order = 4,
                type = "group",
                name = _G.DELETE,
                inline = false,
                disabled = checkThemes,
                args = {
                    themename = {
                        order = 1,
                        type = "select",
                        name = L["Theme name"],
                        get = function() return tempname or customlist[1] end,
                        set = function(info, value) tempname = value end,
                        values = function() return customlist end,
                    },
                    spacer1 = {
                        order = 2,
                        type = "description",
                        width = "full",
                        name = "\n",
                    },
                    deletebutton = {
                        order = 3,
                        type = "execute",
                        name = _G.DELETE,
                        func = deleteTheme,
                    },
                },
            },
        },
    }

    MDH.db.profile.Name = nil
    MDH.db.profile.Petname = nil

    self.db = AceDB:New("MisDirectionHelperDB", defaults, true)

    for k, v in pairs(self.db.global.custom) do
        self.themes[k .. " (edited)"] = v
    end

    local savedTheme = self.db.profile.theme
    if savedTheme then
        self:ApplyTheme(savedTheme)
    end

    -- Register options table using AceConfig
    AceConfig:RegisterOptionsTable("MisdirectionHelperOptions", optionsTable)
    AceConfig:RegisterOptionsTable("MisdirectionHelperThemes", themesTable)
    AceConfig:RegisterOptionsTable("MisdirectionHelperProfiles", AceDBOptions:GetOptionsTable(MDH.db))

    -- Create the main options panel frame
    local mainPanel = CreateFrame("Frame", "MisdirectionHelperOptionsPanel", UIParent)
    mainPanel.name = "Misdirection Helper 2"
    mainPanel:Hide()

    mainPanel.title = mainPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    mainPanel.title:SetPoint("TOPLEFT", 16, -16)
    mainPanel.title:SetText("Misdirection Helper 2")

    mainPanel.instructions = mainPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    mainPanel.instructions:SetPoint("TOPLEFT", mainPanel.title, "BOTTOMLEFT", 0, -8)
    mainPanel.instructions:SetWidth(300)
    mainPanel.instructions:SetJustifyH("LEFT")
    mainPanel.instructions:SetText("Here you can configure Misdirection Helper 2 to your liking.")

    -- Required functions for frames using Settings API
    mainPanel.OnCommit = function() end
    mainPanel.OnDefault = function() end
    mainPanel.OnRefresh = function() end

    -- Register the main panel using the Settings API if available
    if Settings then
        local function RegisterOptionsPanel(panel)
            local category = Settings.GetCategory(panel.name)
            if not category then
                category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
                category.ID = panel.name
                Settings.RegisterAddOnCategory(category)
            end
        end

        RegisterOptionsPanel(mainPanel)
    else
        -- Fallback for older versions without the new Settings API
        InterfaceOptions_AddCategory(mainPanel)
    end

    -- Add options to Blizzard interface options
    AceConfigDialog:AddToBlizOptions("MisdirectionHelperOptions", L["Options"], "Misdirection Helper 2")
    AceConfigDialog:AddToBlizOptions("MisdirectionHelperThemes", L["Themes"], "Misdirection Helper 2")
    AceConfigDialog:AddToBlizOptions("MisdirectionHelperProfiles", L["Profiles"], "Misdirection Helper 2")

    -- Create LDB object
    MDH:CreateLDBObject()
    if icon then icon:Register("MisdirectionHelper", MDH.dataObject, MDH.db.profile.minimap) end
    if (GetNumSubgroupMembers() > 0) or (GetNumGroupMembers() > 0) or (UnitInRaid("player")) then MDH.ingroup = true end

    -- Apply the saved theme on initialization
    MDH:ApplyTheme(MDH.db.profile.theme or _G.DEFAULT)
    updateThemeList()
    MDH:MDHOnload()
end

function MDH:ApplyTheme(themeName)
    local actualName = themeName:gsub(" %(edited%)", "")
    local theme = MDH.themes[actualName] or MDH.db.global.custom[actualName]
    if not theme then return end

    MDH.db.profile.headerfont = theme.headerfont
    MDH.db.profile.linefont = theme.linefont
    MDH:UpdateFonts()
end

function MDH:UpdateFonts()
    local headerFont = MDH.db.profile.headerfont
    local lineFont = MDH.db.profile.linefont

    -- Apply fonts to UI elements
    if MDH.uiElementHeader then
        MDH.uiElementHeader:SetFontObject(MDH.fonts[headerFont].font)
    end
    if MDH.uiElementLine then
        MDH.uiElementLine:SetFontObject(MDH.fonts[lineFont].font)
    end
end

function MDH:OnEnable()
    MDH.fonts = {}
    
    local fonts = {
        MDHHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\MDH.ttf",
        MDHLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\MDH.ttf",
        ArialNHeaderFont = "Fonts\\ARIALN.TTF",
        ArialNLineFont = "Fonts\\ARIALN.TTF",
        MorpheusHeaderFont = "Fonts\\MORPHEUS.TTF",
        MorpheusLineFont = "Fonts\\MORPHEUS.TTF",
        SkurriHeaderFont = "Fonts\\SKURRI.TTF",
        SkurriLineFont = "Fonts\\SKURRI.TTF",
        FrizHeaderFont = "Fonts\\FRIZQT__.TTF",
        FrizLineFont = "Fonts\\FRIZQT__.TTF",
		BlazedHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Blazed.ttf",
        BlazedLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Blazed.ttf",
        CaesarHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Caesar.ttf",
        CaesarLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Caesar.ttf",
        YellowjacketHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Yellowjacket.ttf",
        YellowjacketLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Yellowjacket.ttf",
	    AdventureHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Adventure.ttf",
        AdventureFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Adventure.ttf",
	    FitzHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Fitz.ttf",
        FitzLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Fitz.ttf",
		GeekHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Geek.ttf",
        GeekLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Geek.ttf",
		OldEnglishHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\OldEnglish.ttf",
        OldEnglishLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\OldEnglish.ttf",
		StarHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Star.ttf",
        StarLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Star.ttf",
		RomanHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Roman.ttf",
        RomanLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Roman.ttf",
		AbaddonHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Abaddon.ttf",
        AbaddonLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Abaddon.ttf",
		BazookaHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Bazooka.ttf",
        BazookaLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Bazooka.ttf",
		ChinHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Chin.ttf",
        ChinLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Chin.ttf",
		CoffeeHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Coffee.ttf",
        CoffeeLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Coffee.ttf",
		LemonHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Lemon.ttf",
        LemonLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Lemon.ttf",
		MonaHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Mona.ttf",
        MonaLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Mona.ttf",
		NightmareHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Nightmare.ttf",
        NightmareLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Nightmare.ttf",
		RighteousHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Righteous.ttf",
        RighteousLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Righteous.ttf",
		WoodHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Wood.ttf",
        WoodLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Wood.ttf",
		TypewriterHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Typewriter.ttf",
        TypewriterLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\Typewriter.ttf",
		UnitedHeaderFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\United.ttf",
        UnitedLineFont = "Interface\\AddOns\\MisDirectionHelper2\\Fonts\\United.ttf",
    }

    for name, path in pairs(fonts) do
        local font = CreateFont(name)
        if string.find(name, "Header") then
            font:SetFont(path, 14, "")
        else
            font:SetFont(path, 12, "")
        end
        MDH.fonts[name] = { font = font }
    end

    for k, v in pairs(MDH.db.global.custom) do
        MDH.themes[k] = v
    end
    updateThemeList()
    
    _G.SLASH_MDH_CMD1 = "/mdh"
    _G.SlashCmdList["MDH_CMD"] = function(input)
        InterfaceOptionsFrame_OpenToCategory(MDH.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(MDH.optionsFrame)
    end
end

function MDH:MDHOnload()
    MDH:RegisterEvent("PLAYER_ENTERING_WORLD")
    MDH:RegisterEvent("UNIT_PET")
    MDH:RegisterEvent("UNIT_SPELLCAST_SENT")
    MDH:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    MDH:RegisterEvent("PLAYER_REGEN_DISABLED")
    MDH:RegisterEvent("PLAYER_FOCUS_CHANGED")
	MDH:RegisterEvent("SCENARIO_UPDATE")
    MDH.waitFrame = MDHWaitFrame or CreateFrame("Frame", "MDHWaitFrame")
	if MDH.db.profile.clearleave or MDH.db.profile.autotank then MDH:RegisterEvent("GROUP_ROSTER_UPDATE") end
	if MDH.db.profile.autotank then MDH:RegisterEvent("ROLE_CHANGED_INFORM") end
	if MDH.db.profile.remind then MDH:RegisterEvent("ZONE_CHANGED_NEW_AREA") end
end

local function onUpdate(this, elapsed)
	this.TimeSinceLastUpdate = (this.TimeSinceLastUpdate or 0) + elapsed
	if this.TimeSinceLastUpdate > 1.5 then
		this.TimeSinceLastUpdate = 0
		this:SetScript("OnUpdate", nil)
		MDH:checkParty()
	end
end

function MDH:GROUP_ROSTER_UPDATE()
	MDHWaitFrame.TimeSinceLastUpdate = 0
	MDHWaitFrame:SetScript("OnUpdate", onUpdate)
end

function MDH:ROLE_CHANGED_INFORM() MDH:GROUP_ROSTER_UPDATE() end

function MDH:UpdatePetGUI()
    -- If you use a frame, set the text to the current target/pet
    if MDH.mainPanel and MDH.mainPanel.targetLabel then
        MDH.mainPanel.targetLabel:SetText("Target: " .. (MDH.db.profile.name or "<none>"))
    end
    -- If using LDB, update its text
    if MDH.dataObject then
        MDH:MDHTextUpdate()
    end
end

function MDH:SCENARIO_UPDATE()
    C_Timer.After(0.5, function() self:UpdatePetGUI() end)
end

function MDH:UNIT_PET(event, unit)
    if unit == "player" then
        UpdatePetGUI()
    end
end

function MDH:PLAYER_TARGET_CHANGED()
	if not InCombatLockdown() then
		if MDH.db.profile.target == "target" then
			MDH.db.profile.name = MDH:validateTarget("target")
			MDH:MDHTextUpdate()
		end
	end
end

function MDH:PLAYER_FOCUS_CHANGED()
	if not InCombatLockdown() then
		if MDH.db.profile.target == "focus" then
			MDH.db.profile.name = MDH:validateTarget("focus")
			MDH:MDHTextUpdate()
		end
	end
end

function MDH:PLAYER_ENTERING_WORLD()
    MDH:MDHLoad()
    C_Timer.After(2, function() MDH:EnsurePetDisplay() end) -- CORRECT
end

function MDH:ZONE_CHANGED_NEW_AREA()
    self:EnsurePetDisplay()
    local _, instanceType = GetInstanceInfo()
    if instanceType ~= "none" then
        if MDH.db.profile.remind and not MDH.remind then
            StaticPopup_Show("MDH_REMINDER")
            MDH.remind = true
        end
    else
        MDH.remind = nil
        MDH._delvePetShown = nil
    end
end

--function MDH:SCENARIO_UPDATE()
 --   C_Timer.After(0.5, EnsurePetDisplay)
--end

function MDH:UNIT_PET(event, unit)
    if unit == "player" then
        -- existing pet capture logic...
        EnsurePetDisplay()
    end
end

function MDH:UNIT_PET(event, unitid)
	local pet
	if unitid == "player" and UnitExists("pet") then pet = UnitName("pet")
		if pet ~= MDH.db.profile.petname then MDH:MDHgetpet() end
		if MDH.db.profile.target == "pet" then MDH.db.profile.name = MDH.db.profile.petname
		elseif MDH.db.profile.target2 == "pet" then MDH.db.profile.name2 = MDH.db.profile.petname end
		MDH:MDHTextUpdate()
	end
end

function MDH:UNIT_SPELLCAST_SENT(event, unitid, spell, rank, target, ...)
	if unitid == "player" then
		if uc == "HUNTER" then if spell == imd then misdtarget = target end
		elseif uc == "ROGUE" then if spell == itt then misdtarget = target end end
	end
end

function MDH:UNIT_SPELLCAST_SUCCEEDED(event, unitid, spell, rank, ...)
	local cast, petcall, index
	if unitid == "player" then
		if spell == dismisspet then
			MDH:MDHgetpet()
			MDH:MDHTextUpdate()
			return
		end
		for index, petcall in ipairs(callpet) do
			if spell == petcall then
				MDH.db.profile.petname = select(2, GetStablePetInfo(index))
				
				MDH:MDHTextUpdate()
				return
			end
		end
		if uc == "HUNTER" then if spell == imd then cast = true end
		elseif uc == "ROGUE" then if spell == itt then cast = true end end
		if cast and MDH.db.profile.bAnnounce then MDH:MDHChat() end
	end
end

function MDH:PLAYER_REGEN_DISABLED() if MDH.tooltip then MDH.tooltip:Hide() end end

local function onAccept(this)
	local button = this.button
	local t
	if not UnitAffectingCombat("player") then
		if button == "LeftButton" then
			t = string.lower(this.editBox:GetText() or "")
			MDH.db.profile.target = t
			MDH.db.profile.name = t
		else
			t = string.lower(this.editBox:GetText() or "")
			MDH.db.profile.target2 = t
			MDH.db.profile.name2 = t
		end
		if t == "pet" then
			if button == "LeftButton" then MDH.db.profile.name = MDH.db.profile.petname
			else MDH.db.profile.name2 = MDH.db.profile.petname end
		elseif t == "tank" then MDH:MHDtank(button)
		elseif (t == "target") or (t == "t") then MDH:MHDtarget(button) end
		MDH:MDHEditMacro()
	end
	MDH:MDHShowToolTip()
	this:Hide()
end

StaticPopupDialogs["MDH_GET_PLAYER_NAME"] = {
	text = (uc == "HUNTER") and L["Player to Misdirect to"] or L["Player to cast Tricks of the Trade on"],
	button1 = _G.ACCEPT,
	button2 = _G.CANCEL,
	hasEditBox = 1,
	OnAccept = onAccept,
	EditBoxOnEnterPressed = function(this) onAccept(this:GetParent()) end,
	EditBoxOnEscapePressed = function(this) this:GetParent():Hide()	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["MDH_REMINDER"] = {
	text = L["Set Misdirection Helper's targets!"],
	button1 = _G.OKAY,
	OnAccept = function(this) this:Hide() end,
	timeout = 0,
	whileDead = 0,
	hideOnEscape = 1,
}
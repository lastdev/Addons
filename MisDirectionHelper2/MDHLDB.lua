MDH = LibStub("AceAddon-3.0"):NewAddon("MDH", "AceEvent-3.0")
local MDH = MDH
MDH.uc = select(2, UnitClass("player"))
local uc = MDH.uc
if (uc ~= "HUNTER") and (uc ~= "ROGUE") then return end
local LibStub = LibStub
MDH.L = LibStub("AceLocale-3.0"):GetLocale("MisDirectionHelper",true)
local L = MDH.L
local icon = LibStub("LibDBIcon-1.0")
local _G = _G
local MDHText = "MDH"
local channels = {["RAID"] = _G.RAID, ["PARTY"] = _G.PARTY, ["WHISPER"] = _G.WHISPER}
local misdtarget
local GetSpellInfo = GetSpellInfo
local imd = GetSpellInfo(34477)
local itt = GetSpellInfo(57934)
local iua = GetSpellInfo(51672)
local hiconinfo = {
	[imd] = {"Interface\\Icons\\Ability_Hunter_Misdirection", 151},
}
local hicons = {[151] = imd}
local iconm = {
	[151] = "Ability_Hunter_Misdirection",
	[454] = "Ability_Rogue_TricksOftheTrade",
	[457] = "Ability_Rogue_UnfairAdvantage",
}
local riconinfo = {[itt] = {"Interface\\Icons\\Ability_Rogue_TricksOftheTrade", 454},}
local ricons = {[454] = itt, [457] = iua}
local callpet ={
	[1] = GetSpellInfo(883),
	[2] = GetSpellInfo(83242),
	[3] = GetSpellInfo(83243),
	[4] = GetSpellInfo(83244),
	[5] = GetSpellInfo(83245),
}
local dismisspet = GetSpellInfo(2641)
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

-- GLOBALS: MDH MDHWaitFrame Tukui ElvUI InterfaceOptionsFrame_OpenToCategory StaticPopup_Show GetAddOnMetadata InterfaceOptions_AddCategory

local function set(info, value)
	local key = info[#info]
	MDH.db.profile[key] = value
end

local function get(info)
	local key = info[#info]
	return MDH.db.profile[key]
end

local modkeys = {[1] = "shift",[2] = "ctrl",[3] = "alt",}
local modopts = {[1] = _G.SHIFT_KEY,[2] = _G.CTRL_KEY,[3] = _G.ALT_KEY,}

local defaults = {
	profile = {
		minimap = {hide = false},
		cChannel = "PARTY",
		name = "Pet",
		petname = _G.UNKNOWN,
		bAnnounce = nil,
		hicon = 151,
		ricon = 454,
		hname = "MDH " .. imd,
		rname = "MDH " .. itt,
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

--************ THEMES ************
local themelist, customlist
local fontlist = {[1] = "MDH", [2] = "Arial Narrow", [3] = "Morpheus", [4] = "Skurri"}
local tmpcopy, tempname, tempdata
local temptheme = {headerfont="MDHHeaderFont",linefont="MDHLineFont",title={1,0,0,1,"ffffff00"},spacer={0,0,1,1},group1={1,0,0,1},group2={0,1,1,1},group3={0,0.8,0.2,1},group4={1,0,1,0,"ffffff00","ffff0033"},group5={1,0,1,1,"ffffff00"}}
MDH.themes = {
	[_G.DEFAULT] = {headerfont="MDHHeaderFont",linefont="MDHLineFont",title={1,0,0,1,"ffffff00"},spacer={0,0,1,1},group1={1,0,0,1},group2={0,1,1,1},group3={0,0.8,0.2,1},group4={1,0,1,0,"ffffff00","ffff0033"},group5={1,0,1,1,"ffffff00"}},
	["Basic"] = {headerfont="MDHHeaderFont",linefont="MDHLineFont",title={0,0,0,0,"ffffffff"},spacer={0,0,0,0},group1={0,0,0,0},group2={0,0,0,0},group3={0,0,0,0},group4={0,0,0,0,"ffffffff","ffffffff"},group5={0,0,0,0,"ffffffff"}},
	["ElvUI"] = {headerfont="ElvUIHeaderFont",linefont="ElvUILineFont",title={0,0,0,0,"ff1784d1"},spacer={0,0,1,1},group1={0,0,0,0},group2={0,0,0,0},group3={0,0,0,0},group4={0,0,0,0,"ff1784d1","ff778899"},group5={0,0,0,0,"ff1784d1"}},
}

local function GetTTFont(font)
	local pos = string.find(font, "Header") or string.find(font, "Line")
	local name = string.sub(font, 1, pos - 1)
	local fpos, k, v
	for k, v in pairs(fontlist) do if v == name then fpos = k; break end end
	return fpos
end

--********************************
function MDH:MDHTextUpdate() MDH.dataObject.text = MDH:TTText("both") end

function MDH:MDHLoad()
	if UnitExists("pet") then MDH:MDHgetpet() end
	MDH:MDHEditMacro()
end

function MDH:MDHEditMacro()
	--cannot edit/create macros during combat
	if InCombatLockdown() then return end
	local singlemacro, multiplemacro, macro, macroid, hovermacro
	local spell = imd
	local id = MDH.db.profile.hicon or hiconinfo[imd][2]
	local mname = MDH.db.profile.hname
	local modkey = modkeys[MDH.db.profile.modkey]
	if uc == "ROGUE" then
		spell = itt
		id = MDH.db.profile.ricon or riconinfo[itt][2]
		mname = MDH.db.profile.rname
	end
	MDH:MDHTextUpdate()
	singlemacro = "#showtooltip\n/use [mod:" .. modkey .. ",@none][@%s,nodead]%s;%s"
	multiplemacro = "#showtooltip\n/use [mod:" .. modkey .. ",@none][btn:1,@%s,nodead][btn:2,@%s,nodead]%s;%s"
	--if MDH.db.profile.target3 then
		--singlemacro = "#showtooltip\n/use [@mouseover,nodead]%s\n/use [mod:" .. modkey .. ",@none][@%s,nodead]%s;%s"
		--multiplemacro = "#showtooltip\n/use [@mouseover,nodead]%s\n/use [mod:" .. modkey .. ",@none][btn:1,@%s,nodead][btn:2,@%s,nodead]%s;%s"
	--end
	if MDH.db.profile.target2 then macro = format(multiplemacro, MDH.db.profile.target or "target", MDH.db.profile.target2 or "target", spell, spell)
	else macro = format(singlemacro, MDH.db.profile.target or "target", spell, spell) end
	macroid = GetMacroIndexByName(mname)
	if macroid == 0 then CreateMacro(mname , iconm[id], macro, 1, 1)
	else EditMacro(macroid, mname , iconm[id], macro) end
end

function MDH:MDHChat()
	if IsAddOnLoaded("CastYeller2") or IsAddOnLoaded("CastYeller") then return end
	--local msg = format((uc == "HUNTER") and L["%s Misdirects to %s"] or L["%s casts Tricks of the Trade on %s"], UnitName("player"), misdtarget)
	local chan = MDH.db.profile.cChannel or "RAID"
	local s
	local spelllink = (uc == "HUNTER") and GetSpellLink(35079) or GetSpellLink(57934)
	local msg = format(L["%s casts %s on %s"], UnitName("player"), spelllink, misdtarget)
	--LFD fix courtesy of Eincrou
	--*****
	if chan == "PARTY" and GetNumSubgroupMembers() ~= 0 then
		if (IsInGroup(_G.LE_PARTY_CATEGORY_INSTANCE)) then chan = "INSTANCE_CHAT" end
		s = true
	--*****
	--if chan == "PARTY" and GetNumSubgroupMembers() ~= 0 then s = true
	elseif chan == "RAID" and IsInRaid() then s = true
	elseif chan == "WHISPER" then if UnitIsPlayer(misdtarget) then s = true end end
	if s then SendChatMessage(msg, chan, nil, misdtarget) end
end

--First visible options frame
local function createMainPanel()
	local frame = CreateFrame("Frame", "MisdirectionHelperMain")
	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	local version = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	local author = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetFormattedText("|T%s:%d|t %s", "Interface\\ICONS\\Ability_Hunter_Misdirection", 32, "Misdirection Helper 2")
	title:SetPoint("CENTER", frame, "CENTER", 0, 170)
	version:SetText(_G.GAME_VERSION_LABEL .. " " .. GetAddOnMetadata("MisdirectionHelper2", "Version"))
	version:SetPoint("CENTER", frame, "CENTER", 0, 130)
	author:SetText(L["Author"] .. ": Deepac")
	author:SetPoint("CENTER", frame, "CENTER", 0, 100)
	return frame
end

local function stringify(array)
	local out = ""
	for _, v in ipairs(array) do out = out .. v .. ";" end
	out = string.sub(out, 1, string.len(out) - 1)
	return out
end

local function encodeTheme(theme)
	local encoded = "1" .. GetTTFont(theme.headerfont) .. ":2" .. GetTTFont(theme.linefont)
	local keys = {["title"] = 3, ["spacer"] = 4, ["group1"] = 5, ["group2"] = 6, ["group3"] = 7, ["group4"] = 8, ["group5"] = 9}
	for k, v in pairs(theme) do if k ~= "headerfont" and k ~= "linefont" then encoded = encoded .. ":" .. keys[k] .. stringify(v) end end
	return encoded
end

local function destringify(val)
	local vals = {strsplit(";", val)}
	if vals[6] then return vals[1], vals[2], vals[3], vals[4], vals[5], vals[6]
	elseif vals[5] then return vals[1], vals[2], vals[3], vals[4], vals[5]
	else return vals[1], vals[2], vals[3], vals[4] end
end

function MDH:decodeTheme(encoded)
	local keys = {[3] = "title", [4] = "spacer", [5] = "group1", [6] = "group2", [7] = "group3", [8] = "group4", [9] = "group5"}
	local vals = {strsplit(":", encoded)}
	local ord, v2
	for _, v in ipairs(vals) do
		ord = tonumber(string.sub(v, 1, 1))
		if ord == 1 then temptheme.headerfont = fontlist[tonumber(string.sub(v, 2, 2))] .. "HeaderFont"
		elseif ord == 2 then temptheme.linefont = fontlist[tonumber(string.sub(v, 2, 2))] .. "LineFont"
		else temptheme[keys[ord]] = {destringify(string.sub(v, 2))} end
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
	for k in pairs(MDH.themes) do themelist[k] = k end
	for k in pairs(MDH.db.global.custom) do customlist[k] = k end
end

local function saveTheme()
	if type(validateThemeName(nil, tempname)) ~= "boolean" then return end
	MDH.db.global.custom[tempname] = temptheme
	MDH.themes[tempname] = temptheme
	updateThemeList()
	tempname = nil
	tempdata = nil
	MDH:ShowError(L["Theme saved"])
end

local function editTheme()
	MDH.db.global.custom[tempname] = temptheme
	MDH.themes[tempname] = temptheme
	tempname = nil
	MDH:ShowError(L["Theme saved"])
end

local function deleteTheme()
	if not tempname then MDH:ShowError(L["Please enter a valid theme name"]); return end
	if MDH.db.profile.theme == tempname then MDH.db.profile.theme = _G.DEFAULT end
	MDH.db.global.custom[tempname] = nil
	MDH.themes[tempname] = nil
	updateThemeList()
	tempname = nil
	MDH:ShowError(L["Theme deleted"])
end

local function checkThemes()
	for k, v in pairs(MDH.db.global.custom) do if k then return false end end
	return true
end

function MDH:OnInitialize()
	local AceConfig = LibStub("AceConfig-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	local AceDBOptions = LibStub("AceDBOptions-3.0")
	local mainPanel = createMainPanel()
	local optionsTable, themesTable
	local k, v

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
				desc = L["Toggle Misdirection Applied Announcment"],
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
				get = function() return MDH.db.profile.hicon or hiconinfo[imd][2] end,
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
				get = function() return MDH.db.profile.ricon or riconinfo[itt][2] end,
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
						set = function(info, value) MDH.db.profile.theme = value end,
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
						set = function(info, value) temptheme = MDH:deepcopy(MDH.themes[value]); tmpcopy = value end,
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
						set = function(info, val) temptheme.headerfont = fontlist[val] .. "LineFont" end,
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
				disabled = checkThemes,
				args = {
					themename = {
						order = 1,
						type = "select",
						name = L["Select"],
						get = function() return tempname end,
						set = function(info, value) tempname = value; temptheme = MDH:deepcopy(MDH.db.global.custom[value]) end,
						values = function() return customlist end,
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
						set = function(info, val) temptheme.headerfont = fontlist[val] .. "LineFont" end,
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
			importtheme = {
				order = 5,
				type = "group",
				name = L["Import"],
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
					importdata = {
						order = 1.5,
						type = "input",
						width = "full",
						name = L["Theme data"],
						get = function() return tempdata end,
						set = function(info, value) tempdata = value end,
					},
					spacer1 = {
						order = 2,
						type = "description",
						width = "full",
						name = "\n",
					},
					importbutton = {
						order = 3,
						type = "execute",
						name = L["Import theme"],
						disabled = function() return tempname == nil or tempdata == nil end,
						func = saveTheme,
					},
				},
			},
			exporttheme = {
				order = 6,
				type = "group",
				name = L["Export"],
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
					exportbutton = {
						order = 3,
						type = "execute",
						name = L["Export theme"],
						disabled = function() return tempname == nil end,
						func = function() MDH:ShowExport(encodeTheme(temptheme)) end,
					},
				},
			},
		},
	}

	--remove old renamed variables
	MDH.db.profile.Name = nil
	MDH.db.profile.Petname = nil
	mainPanel.name = "Misdirection Helper 2"
	InterfaceOptions_AddCategory(mainPanel)
	AceConfig:RegisterOptionsTable("MisdirectionHelperOptions", optionsTable)
	AceConfig:RegisterOptionsTable("MisdirectionHelperThemes", themesTable)
	AceConfig:RegisterOptionsTable("MisdirectionHelperProfiles", AceDBOptions:GetOptionsTable(MDH.db))
	MDH.optionsFrame = AceConfigDialog:AddToBlizOptions("MisdirectionHelperOptions", _G.MAIN_MENU, "Misdirection Helper 2")
	AceConfigDialog:AddToBlizOptions("MisdirectionHelperThemes", L["Themes"], "Misdirection Helper 2")
	AceConfigDialog:AddToBlizOptions("MisdirectionHelperProfiles", L["Profiles"], "Misdirection Helper 2")
	MDH:CreateLDBObject()
	if icon then icon:Register("MisdirectionHelper", MDH.dataObject, MDH.db.profile.minimap) end
	if (GetNumSubgroupMembers() > 0) or (GetNumGroupMembers() > 0) or (UnitInRaid("player")) then MDH.ingroup = true end
	MDH:MDHOnload()
end

function MDH:OnEnable()
	--initialise fonts
	MDH.fonts = {}
	MDH.fonts.MDHHeaderFont = {font=CreateFont("MDHHeaderFont")}
	MDH.fonts.MDHHeaderFont.font:SetFont(GameTooltipHeaderText:GetFont(), 15)
	MDH.fonts.MDHLineFont = {font=CreateFont("MDHLineFont")}
	MDH.fonts.MDHLineFont.font:SetFont(GameTooltipText:GetFont())
	local mdhfont = CreateFont("ElvFont")
	if IsAddOnLoaded("Tukui") then
		local T, C, L = unpack(Tukui)
		if C.Medias then mdhfont:SetFont(C.Medias.Font, 12)
		else mdhfont:SetFont(C.Media.font, 12) end
	elseif IsAddOnLoaded("ElvUI") then
		local E, L, V, P, G, DF = unpack(ElvUI)
		mdhfont:SetFont(E["media"].normFont, 12)
	else mdhfont:SetFont(GameTooltipText:GetFont()) end
	MDH.fonts.ElvUIHeaderFont = {font=mdhfont}
	MDH.fonts.ElvUIHeaderFont.font:SetFont(mdhfont:GetFont(), 14)
	MDH.fonts.ElvUILineFont = {font=mdhfont}
	MDH.fonts.ElvUILineFont.font:SetFont(mdhfont:GetFont(), 12)
	mdhfont = CreateFont("Friz")
	MDH.fonts.FrizHeaderFont = {font=mdhfont}
	MDH.fonts.FrizHeaderFont.font:SetFont("Fonts\\FRIZQT__.TTF", 14)
	MDH.fonts.FrizLineFont = {font=mdhfont}
	MDH.fonts.FrizLineFont.font:SetFont("Fonts\\FRIZQT__.TTF", 12)
	mdhfont = CreateFont("ArialN")
	MDH.fonts.ArialNHeaderFont = {font=mdhfont}
	MDH.fonts.ArialNHeaderFont.font:SetFont("Fonts\\ARIALN.TTF", 14)
	MDH.fonts.ArialNLineFont = {font=mdhfont}
	MDH.fonts.ArialNLineFont.font:SetFont("Fonts\\ARIALN.TTF", 12)
	mdhfont = CreateFont("Skurri")
	MDH.fonts.SkurriHeaderFont = {font=mdhfont}
	MDH.fonts.SkurriHeaderFont.font:SetFont("Fonts\\SKURRI.TTF", 14)
	MDH.fonts.SkurriLineFont = {font=mdhfont}
	MDH.fonts.SkurriLineFont.font:SetFont("Fonts\\SKURRI.TTF", 12)
	mdhfont = CreateFont("Morpheus")
	MDH.fonts.MorpheusHeaderFont = {font=mdhfont}
	MDH.fonts.MorpheusHeaderFont.font:SetFont("Fonts\\MORPHEUS.TTF", 14)
	MDH.fonts.MorpheusLineFont = {font=mdhfont}
	MDH.fonts.MorpheusLineFont.font:SetFont("Fonts\\MORPHEUS.TTF", 12)
	for k, v in pairs(MDH.db.global.custom) do MDH.themes[k] = v end
	updateThemeList()
	_G.SLASH_MDH_CMD1 = "/mdh"
	_G.SlashCmdList["MDH_CMD"] = function(input) InterfaceOptionsFrame_OpenToCategory(MDH.optionsFrame) InterfaceOptionsFrame_OpenToCategory(MDH.optionsFrame) end
end

function MDH:MDHOnload()
	MDH:RegisterEvent("PLAYER_ENTERING_WORLD")
	MDH:RegisterEvent("UNIT_PET")
	MDH:RegisterEvent("UNIT_SPELLCAST_SENT")
	MDH:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	MDH:RegisterEvent("PLAYER_REGEN_DISABLED")
	MDH:RegisterEvent("PLAYER_FOCUS_CHANGED")
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

function MDH:ZONE_CHANGED_NEW_AREA()
	local inInstance = (select(2, GetInstanceInfo()) ~= "none")
	if UnitIsGhost("player") then return end
	if inInstance then
		if MDH.remind then --reminder already set, don't give another one
		else
			StaticPopup_Show("MDH_REMINDER")
			MDH.remind = true
		end
	else MDH.remind = nil end
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

function MDH:PLAYER_ENTERING_WORLD() MDH:MDHLoad() end

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
				--print(spell, MDH.db.profile.petname)
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

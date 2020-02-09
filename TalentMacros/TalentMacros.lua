local ADDON_NAME, TalentMacros = ...
LibStub("AceAddon-3.0"):NewAddon(TalentMacros, ADDON_NAME, "AceEvent-3.0")

-- luacheck: globals InterfaceOptionsFrame_OpenToCategory IconIntroTracker
-- luacheck: globals C_Spell C_SpecializationInfo

local DEFAULT_MACRO = "#showtooltip\n/cast %n"
local CHECK_TEXTURE = " |T" .. _G.READY_CHECK_READY_TEXTURE .. ":0|t"

local MAX_TALENT_TIERS = _G.MAX_TALENT_TIERS
local NUM_TALENT_COLUMNS = _G.NUM_TALENT_COLUMNS
local CLASS_TALENT_LEVELS = _G.CLASS_TALENT_LEVELS


local db = nil
local defaults = {
	profile = {
		macrotext = {},
		advanced = true,
		disablepush = false,
	},
}

local GetOptions
do
	local function get(info)
		local name = info[#info]
		return db.macrotext[info.arg[1]] or DEFAULT_MACRO:gsub("%%n", name)
	end

	local function set(info, value)
		if type(value) == "string" and value:trim() ~= "" then
			db.macrotext[info.arg[1]] = value:sub(1,255)
		else
			db.macrotext[info.arg[1]] = nil
		end
		TalentMacros:UpdateMacros()
	end

	local function desc(info)
		return GetSpellDescription(info.arg[2])
	end

	local function validate(info, value)
		if type(value) == "string" then
			local length = #value
			if length > 255 then
				local error = ("Macro is longer than 255 characters! (%d)"):format(length)
				TalentMacros:Print(error)
				return error
			end
		end
		return true
	end

	function GetOptions()
		local options = {
			type = "group",
			name = ADDON_NAME,
			handler = TalentMacros,
			childGroups = "tab",
			args = {
				notes = {
					type = "description",
					name = GetAddOnMetadata(ADDON_NAME, "Notes") .. "\n",
					fontSize = "medium",
					order = 1,
				},
				create = {
					type = "execute",
					name = "Create Macros",
					desc = ("Create several general macros named t1-t%d and tpvp1-3 that will be updated when you change talents. Do not edit these directly!"):format(MAX_TALENT_TIERS),
					func = "CreateMacros",
					order = 2,
					width = "full",
				},
				disablepush = {
					type = "toggle",
					name = "Disable placing new abilities on your bars",
					desc = "The game will try to add new talents to your main bar if there is room, enabling this option will try to stop that.",
					get = function() return db.disablepush end,
					set = function(info, value)
						db.disablepush = value
						TalentMacros:UpdateFlyin()
					end,
					order = 4,
					width = "double",
				},
				advanced = {
					type = "toggle",
					name = "Enable templates",
					desc = "Allows you to edit the macro text for each talent.\n\nDisable to make all macros simply:\n   #showtooltip\n   /cast Talent Name",
					get = function() return db.advanced end,
					set = function(info, value)
						db.advanced = value
						TalentMacros:UpdateMacros()
					end,
					order = 3,
					-- width = "full",
				},
				advanced_text = {
					type = "description",
					name = "|cffffd200Delete all of the macro text and hit accept to reset to the default text.|r",
					fontSize = "medium",
					order = 5,
					hidden = function() return not db.advanced end,
				},
			},
		}

		if db.advanced then
			local spec = GetActiveSpecGroup(false)
			local _, playerClass = UnitClass("player")
			local talentLevels = CLASS_TALENT_LEVELS[playerClass] or CLASS_TALENT_LEVELS.DEFAULT -- DK and DH gain talents at different levels
			for tier = 1, MAX_TALENT_TIERS do
				local level = talentLevels[tier]
				local group = {
					type = "group",
					name = ("T%d: %d"):format(tier, level),
					order = level,
					args = {},
				}
				options.args[tostring(tier)] = group

				for column = 1, NUM_TALENT_COLUMNS do
					local id, name, iconTexture, selected, _, spellId = GetTalentInfo(tier, column, spec)
					local title = ("|T%s:0:0:0:0:64:64:4:60:4:60|t %s%s"):format(iconTexture, name, selected and CHECK_TEXTURE or "")
					group.desc = group.desc and ("%s\n%s"):format(group.desc, title) or title

					group.args[name] = {
						type = "input",
						name = ("|T%s:18:18:3:0:64:64:4:60:4:60|t %s%s"):format(iconTexture, name, selected and CHECK_TEXTURE or ""),
						desc = desc,
						order = column,
						get = get,
						set = set,
						arg = {id, spellId},
						validate = validate,
						multiline = 5,
						width = "full",
					}

					if not C_Spell.IsSpellDataCached(spellId) then
						C_Spell.RequestLoadSpellData(spellId)
					end
				end
			end

			-- PVP Talents
			local group = {
				type = "group",
				name = _G.PVP,
				order = talentLevels[MAX_TALENT_TIERS] + 1,
				args = {},
			}
			local slotInfo = C_SpecializationInfo.GetPvpTalentSlotInfo(2)
			local available = slotInfo and slotInfo.availableTalentIDs
			if available then
				local selected = {}
				for index, id in next, C_SpecializationInfo.GetAllSelectedPvpTalentIDs() do
					selected[id] = index
				end

				for index, id in ipairs(available) do
					local _, name, icon, _, _, spellId = GetPvpTalentInfoByID(id)
					group.args[name] = {
						type = "input",
						name = ("|T%s:0:0:0:0:64:64:4:60:4:60|t %s%s"):format(icon, name, selected[id] and CHECK_TEXTURE or ""),
						desc = desc,
						order = selected[id] or (10 + index),
						get = get,
						set = set,
						arg = {id, spellId},
						validate = validate,
						multiline = 5,
						width = "full",
					}

					if not C_Spell.IsSpellDataCached(spellId) then
						C_Spell.RequestLoadSpellData(spellId)
					end
				end
			else
				group.disabled = true
			end
			options.args.pvp = group
		end

		return options
	end
end

function TalentMacros:OnInitialize()
	self.db =  LibStub("AceDB-3.0"):New("TalentMacrosDB", defaults)
	LibStub("LibDualSpec-1.0"):EnhanceDatabase(self.db, ADDON_NAME)
	db = self.db.profile

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TalentMacros", GetOptions)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TalentMacros", ADDON_NAME)

	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(TalentMacros.db)
	LibStub("LibDualSpec-1.0"):EnhanceOptions(profiles, self.db)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TalentMacros/Profiles", profiles)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TalentMacros/Profiles", "Profiles", ADDON_NAME)

	SLASH_TALENTMACROS1 = "/talentmacros"
	SLASH_TALENTMACROS2 = "/talentmacro"
	SLASH_TALENTMACROS2 = "/tmacro"
	SlashCmdList["TALENTMACROS"] = function()
		InterfaceOptionsFrame_OpenToCategory(ADDON_NAME)
		InterfaceOptionsFrame_OpenToCategory(ADDON_NAME)
	end

	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateTalentMacros")
	self:RegisterEvent("PLAYER_PVP_TALENT_UPDATE", "UpdatePVPTalentMacros")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:UpdateFlyin()
end

function TalentMacros:Print(...)
	print("|cff33ff99TalentMacros|r:", ...)
end

function TalentMacros:UpdateFlyin()
	if db.disablepush then
		IconIntroTracker:UnregisterEvent("SPELL_PUSHED_TO_ACTIONBAR")
	else
		IconIntroTracker:RegisterEvent("SPELL_PUSHED_TO_ACTIONBAR")
	end
end

function TalentMacros:PLAYER_LOGOUT()
	-- Clean up macros
	for tier = 1, MAX_TALENT_TIERS do
		EditMacro(("t%d"):format(tier), nil, "INV_Misc_QuestionMark", "")
	end
	for slot = 1, 3 do
		EditMacro(("tpvp%d"):format(slot), nil, "INV_Misc_QuestionMark", "")
	end
end

function TalentMacros:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UpdateMacros()
end

function TalentMacros:UpdateMacros()
	self:UpdateTalentMacros()
	self:UpdatePVPTalentMacros()
end

function TalentMacros:UpdateTalentMacros()
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	local spec = GetActiveSpecGroup(false)
	for tier = 1, MAX_TALENT_TIERS do
		local available, selected = GetTalentTierInfo(tier, spec)
		if available and selected ~= 0 then
			local id, name, iconTexture = GetTalentInfo(tier, selected, spec)
			local icon = "INV_Misc_QuestionMark"
			local default = DEFAULT_MACRO:gsub("%%n", name or "")
			local body = db.advanced and db.macrotext[id] or default
			if (body == default and not GetSpellInfo(name)) or not body:find("#show", nil, true) then
				-- use talent icon directly if the talent name isn't a spell or the macro has no #show[tooltip]
				icon = iconTexture
			end
			EditMacro(("t%d"):format(tier), nil, icon, body)
		else
			EditMacro(("t%d"):format(tier), nil, "INV_Misc_QuestionMark", "")
		end
	end
	LibStub("AceConfigRegistry-3.0"):NotifyChange(ADDON_NAME)
end

function TalentMacros:UpdatePVPTalentMacros()
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	for slot = 2, 4 do
		local slotInfo = C_SpecializationInfo.GetPvpTalentSlotInfo(slot)
		local selectedTalentID = slotInfo and slotInfo.selectedTalentID
		if selectedTalentID then
			local id, name, texture = GetPvpTalentInfoByID(selectedTalentID)
			local body = db.advanced and db.macrotext[id] or DEFAULT_MACRO:gsub("%%n", name or "")
			-- XXX Can't check for passives by spell name because the spells don't
			-- exist until they activate and I can't be arsed scan the tooltip
			EditMacro(("tpvp%d"):format(slot-1), nil, texture, body)
		else
			EditMacro(("tpvp%d"):format(slot-1), nil, "INV_Misc_QuestionMark", "")
		end
	end
	LibStub("AceConfigRegistry-3.0"):NotifyChange(ADDON_NAME)
end

function TalentMacros:CreateMacros()
	if InCombatLockdown() then
		self:Print("Unable to create macros while in combat!")
		return
	end

	local count, errors = 0, 0
	for tier = 1, MAX_TALENT_TIERS do
		local name = ("t%d"):format(tier)
		if GetMacroIndexByName(name) == 0 then
			local success = pcall(CreateMacro, name, "INV_Misc_QuestionMark", "", nil, nil)
			if not success then
				errors = errors + 1
			end
		else
			count = count + 1
		end
	end
	for slot = 1, 3 do
		local name = ("tpvp%d"):format(slot)
		if GetMacroIndexByName(name) == 0 then
			local success = pcall(CreateMacro, name, "INV_Misc_QuestionMark", "", nil, nil)
			if not success then
				errors = errors + 1
			end
		else
			count = count + 1
		end
	end
	self:UpdateMacros()

	if count == MAX_TALENT_TIERS + 3 then
		self:Print("Macros already exist!")
	elseif errors == 0 then
		self:Print("Macros created!")
	else
		self:Print("Unable to create all of the macros! (No more general macro space?)")
	end
end

local ADDON_NAME, TalentMacros = ...
LibStub("AceAddon-3.0"):NewAddon(TalentMacros, ADDON_NAME, "AceEvent-3.0")

local DEFAULT_MACRO = "#showtooltip\n/cast %n"
local CHECK_TEXTURE = " |T" .. READY_CHECK_READY_TEXTURE .. ":0|t"

local MAX_TALENT_TIERS = MAX_TALENT_TIERS
local NUM_TALENT_COLUMNS = NUM_TALENT_COLUMNS

local GetTalentDescription
do
	local cache = {}
	local tooltip = CreateFrame("GameTooltip", "TalentMacrosTooltip", nil, "GameTooltipTemplate")
	tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	function GetTalentDescription(id)
		if cache[id] then return cache[id] end
		tooltip:SetTalent(id)
		local _, _, spellId = tooltip:GetSpell()
		cache[id] = GetSpellDescription(spellId)
		return cache[id]
	end
end


local db = nil
local defaults = {
	profile = {
		macrotext = {},
		advanced = true,
	},
}

local function GetOptions()
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
				desc = "Create several general macros named t1-t7 that will be updated when you change talents. Do not edit these directly!",
				func = "CreateMacros",
				disabled = function()
					for tier = 1, MAX_TALENT_TIERS do
						local name = ("t%d"):format(tier)
						if GetMacroIndexByName(name) == 0 then
							return false
						end
					end
					return true
				end,
				order = 2,
				width = "full",
			},
			advanced = {
				type = "toggle",
				name = "Enable templates for each talent",
				desc = "Allows you to edit the macro text for each talent.\n\nDisable to make all macros simply:\n   #showtooltip\n   /cast Talent Name",
				get = function() return db.advanced end,
				set = function(info, value)
					db.advanced = value
					TalentMacros:UpdateMacros()
				end,
				order = 3,
				width = "full",
			},
			advanced_text = {
				type = "description",
				name = "|cffffd200Delete all of the macro text and hit accept to reset to the default text.|r",
				fontSize = "medium",
				hidden = function() return not db.advanced end,
			},
		},
	}

	if db.advanced then
		local spec = GetActiveSpecGroup()
		for tier = 1, MAX_TALENT_TIERS do
			local level = min(100, 15 * tier)
			local group = {
				type = "group",
				name = ("Tier %d: %d"):format(tier, level),
				order = level,
				args = {},
			}
			options.args[tostring(tier)] = group

			for column = 1, NUM_TALENT_COLUMNS do
				local id, name, iconTexture, selected, available = GetTalentInfo(tier, column, spec)
				local title = ("|T%s:0:0:0:0:64:64:4:60:4:60|t %s%s"):format(iconTexture, name, selected and CHECK_TEXTURE or "")
				group.desc = group.desc and ("%s\n%s"):format(group.desc, title) or title

				group.args[name] = {
					type = "input",
					name = ("|T%s:18:18:3:0:64:64:4:60:4:60|t %s%s"):format(iconTexture, name, selected and CHECK_TEXTURE or ""),
					desc = GetTalentDescription(id),
					order = column,
					get = function()
						return db.macrotext[id] or DEFAULT_MACRO:gsub("%%n", name)
					end,
					set = function(info, value)
						if type(value) == "string" and value:trim() ~= "" then
							db.macrotext[id] = value:gsub("%%n", name):sub(1,255)
						else
							db.macrotext[id] = nil
						end
						TalentMacros:UpdateMacros()
					end,
					validate = function(info, value)
						if type(value) == "string" then
							value = value:gsub("%%n", name)
							if #value > 255 then
								local error = ("Macro is longer than 255 characters! (%d)"):format(#value)
								TalentMacros:Print(error)
								return error
							end
						end
						return true
					end,
					multiline = 5,
					width = "full",
				}
			end
		end
	end

	return options
end

function TalentMacros:OnInitialize()
	self.db =  LibStub("AceDB-3.0"):New("TalentMacrosDB", defaults)
	db = self.db.profile

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TalentMacros", GetOptions)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TalentMacros", ADDON_NAME)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TalentMacros/Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(TalentMacros.db))
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TalentMacros/Profiles", "Profiles", ADDON_NAME)
end

function TalentMacros:OnEnable()
	-- upgrade the db
	if not db.version then
		local spec = GetActiveSpecGroup()
		for tier = 1, MAX_TALENT_TIERS do
			for column = 1, NUM_TALENT_COLUMNS do
				local index = (tier - 1) * 3 + column
				if db.macrotext[index] then
					local id = GetTalentInfo(tier, column, spec)
					db.macrotext[id] = db.macrotext[index]
					db.macrotext[index] = nil
				end
			end
		end
		db.version = 1
	end

	self:RegisterEvent("PLAYER_TALENT_UPDATE")

	self:UpdateMacros()
end

function TalentMacros:Print(...)
	print("|cff33ff99TalentMacros|r:", ...)
end

function TalentMacros:PLAYER_TALENT_UPDATE()
	LibStub("AceConfigRegistry-3.0"):NotifyChange(ADDON_NAME)
	self:UpdateMacros()
end

function TalentMacros:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UpdateMacros()
end

function TalentMacros:UpdateMacros()
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	local spec = GetActiveSpecGroup()
	for tier = 1, MAX_TALENT_TIERS do
		for column = 1, NUM_TALENT_COLUMNS do
			local id, name, iconTexture, selected, available = GetTalentInfo(tier, column, spec)
			if selected then
				local body = db.advanced and db.macrotext[id] or DEFAULT_MACRO:gsub("%%n", name)
				EditMacro(("t%d"):format(tier), nil, "INV_Misc_QuestionMark", body)
			end
		end
	end
end

function TalentMacros:CreateMacros()
	if InCombatLockdown() then
		self:Print("Unable to create macros while in combat!")
		return
	end

	local errors = 0
	for tier = 1, MAX_TALENT_TIERS do
		local name = ("t%d"):format(tier)
		if GetMacroIndexByName(name) == 0 then
			local success = pcall(CreateMacro, name, "INV_Misc_QuestionMark", "")
			if not success then
				errors = errors + 1
			end
		end
	end
	self:UpdateMacros()

	if errors == 0 then
		self:Print("Macros created!")
	else
		self:Print("Unable to create all of the macros! (No more general macro space?)")
	end
end

SLASH_TALENTMACROS1 = "/talentmacros"
SLASH_TALENTMACROS2 = "/talentmacro"
SlashCmdList["TALENTMACROS"] = function()
	InterfaceOptionsFrame_OpenToCategory(ADDON_NAME)
	InterfaceOptionsFrame_OpenToCategory(ADDON_NAME)
end


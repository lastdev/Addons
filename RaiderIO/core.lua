local addonName, ns = ...

-- micro-optimization for more speed
local unpack = unpack
local sort = table.sort
local wipe = table.wipe
local floor = math.floor
local lshift = bit.lshift
local rshift = bit.rshift
local band = bit.band
local PAYLOAD_BITS = 13
local PAYLOAD_MASK = lshift(1, PAYLOAD_BITS) - 1
local LOOKUP_MAX_SIZE = floor(2^18-1)

-- default config
local addonConfig = {
	enableUnitTooltips = true,
	enableLFGTooltips = true,
	enableFriendsTooltips = true,
	enableLFGDropdown = true,
	enableWhoTooltips = true,
	enableWhoMessages = true,
	enableGuildTooltips = true,
	enableKeystoneTooltips = true,
	showMainsScore = true,
	showDropDownCopyURL = true,
	showSimpleScoreColors = false,
	showScoreInCombat = true,
	disableScoreColors = false,
	alwaysExtendTooltip = false,
	enableClientEnhancements = true,
	showClientGuildBest = true,
	displayWeeklyGuildBest = false,
	showRaiderIOProfile = true,
	enableProfileModifier = true,
	inverseProfileModifier = false,
	positionProfileAuto = true,
	lockProfile = false,
	profilePoint = {
		["point"] = nil,
		["x"] = 0,
		["y"] = 0
	}
}

-- session
local uiHooks = {}
local profileCache = {}
local configParentFrame
local configButtonFrame
local configHeaderFrame
local configScrollFrame
local configSliderFrame
local configFrame
local dataProviderQueue = {}
local dataProvider

-- client
local clientCharacters = {}
local guildProviderCalled = false
local guildBest = {}

-- tooltip related hooks and storage
local tooltipArgs = {}
local playerTooltip

local tooltipHooks = {
	Wipe = function()
		wipe(tooltipArgs)
		playerTooltip = nil
	end
}

local profileTooltip = CreateFrame("GameTooltip"," profileTooltip", UIParent, "GameTooltipTemplate")

-- player
local PLAYER_FACTION
local PLAYER_REGION

-- db outdated
local IS_DB_OUTDATED = {}
local OUTDATED_DAYS = {}
local OUTDATED_HOURS = {};

-- constants
local CONST_REALM_SLUGS = ns.realmSlugs
local CONST_REGION_IDS = ns.regionIDs
local CONST_SCORE_TIER = ns.scoreTiers
local CONST_SCORE_TIER_SIMPLE = ns.scoreTiersSimple
local CONST_DUNGEONS = ns.dungeons
local CONST_AVERAGE_SCORE = ns.scoreLevelStats
local L = ns.L

-- enum dungeons
-- the for-loop serves two purposes: localize the shortName, and populate the enums
local ENUM_DUNGEONS = {}
local KEYSTONE_INST_TO_DUNGEONID = {}
local DUNGEON_INSTANCEMAPID_TO_DUNGEONID = {}
local LFD_ACTIVITYID_TO_DUNGEONID = {}
for i = 1, #CONST_DUNGEONS do
	local dungeon = CONST_DUNGEONS[i]

	ENUM_DUNGEONS[dungeon.shortName] = i
	KEYSTONE_INST_TO_DUNGEONID[dungeon.keystone_instance] = i
	DUNGEON_INSTANCEMAPID_TO_DUNGEONID[dungeon.instance_map_id] = i

	for _, activity_id in ipairs(dungeon.lfd_activity_ids) do
		LFD_ACTIVITYID_TO_DUNGEONID[activity_id] = i
	end

	dungeon.shortNameLocale = L["DUNGEON_SHORT_NAME_" .. dungeon.shortName] or dungeon.shortName
end

-- colors
local COLOR_WHITE = { r = 1, g = 1, b = 1 }
local COLOR_GREY = { r = 0.62, g = 0.62, b = 0.62 }
local COLOR_GREEN = { r = 0, g = 1, b = 0 }

-- defined constants
local MAX_LEVEL = MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_LEGION]
local OUTDATED_SECONDS = 86400 * 3 -- number of seconds before we start warning about outdated data
local NUM_FIELDS_PER_CHARACTER = 3 -- number of fields in the database lookup table for each character
local FACTION
local REGIONS
local REGIONS_RESET_TIME
local KEYSTONE_AFFIX_SCHEDULE
local KEYSTONE_LEVEL_TO_BASE_SCORE
do
	FACTION = {
		["Alliance"] = 1,
		["Horde"] = 2,
	}

	REGIONS = {
		"us",
		"kr",
		"eu",
		"tw",
		"cn"
	}

	REGIONS_RESET_TIME = {
		1135695600,
		1135810800,
		1135753200,
		1135810800,
		1135810800,
	}

	KEYSTONE_AFFIX_SCHEDULE = {
		9, -- Fortified
		10, -- Tyrannical
		-- {  6,  4,  9 },
		-- {  7,  2, 10 },
		-- {  5,  3,  9 },
		-- {  8, 12, 10 },
		-- {  7, 13,  9 },
		-- { 11, 14, 10 },
		-- {  6,  3,  9 },
		-- {  5, 13, 10 },
		-- {  7, 12,  9 },
		-- {  8,  4, 10 },
		-- { 11,  2,  9 },
		-- {  5, 14, 10 },
	}

	KEYSTONE_LEVEL_TO_BASE_SCORE = {
		[2] = 20,
		[3] = 30,
		[4] = 40,
		[5] = 50,
		[6] = 60,
		[7] = 70,
		[8] = 80,
		[9] = 90,
		[10] = 100,
		[11] = 110,
		[12] = 121,
		[13] = 133,
		[14] = 146,
		[15] = 161,
		[16] = 177,
		[17] = 195,
		[18] = 214,
		[19] = 236,
		[20] = 259,
		[21] = 285,
		[22] = 314,
		[23] = 345,
		[24] = 380,
		[25] = 418,
		[26] = 459,
		[27] = 505,
		[28] = 556,
		[29] = 612,
		[30] = 673,
	}
end

-- easter
local EGG = {
	["eu"] = {
		["Ravencrest"] = {
			["Voidzone"] = "Raider.IO AddOn Author",
		},
		["Sargeras"] = {
			["Isak"] = "Raider.IO Contributor"
		}
	},
	["us"] = {
		["Skullcrusher"] = {
			["Aspyrox"] = "Raider.IO Creator",
			["Ulsoga"] = "Raider.IO Creator",
			["Dynrai"] = "Raider.IO Contributor",
			["Divyn"] = "Raider.IO Contributor",
			["Pepsiblue"] = "#millennialthings",
		},
		["Thrall"] = {
			["Firstclass"] = "Author of mythicpl.us"
		}
	},
}

-- create the addon core frame
local addon = CreateFrame("Frame")

-- utility functions
local RoundNumber
local CompareDungeon
local GetDungeonWithData
local GetTimezoneOffset
local GetRegion
local GetKeystoneLevel
local GetLFDStatus
local GetInstanceStatus
local GetRealmSlug
local GetNameAndRealm
local GetFaction
local GetWeeklyAffix
local GetAverageScore
local GetStarsForUpgrades
local GetGuildFullname
do
	-- bracket can be 10, 100, 0.1, 0.01, and so on
	function RoundNumber(v, bracket)
		bracket = bracket or 1
		return math.floor(v/bracket + ((v >= 0 and 1) or -1 )* 0.5) * bracket
	end

	-- Find the dungeon in CONST_DUNGEONS corresponding to the data in argument
	function GetDungeonWithData(dataName, dataValue)
		for i = 1, #CONST_DUNGEONS do
			if CONST_DUNGEONS[i][dataName] == dataValue then
				return CONST_DUNGEONS[i]
			end
		end
	end

	-- Compare two dungeon first by the keyLevel, then by their short name
	function CompareDungeon(a, b)
		if not a then
			return false
		end

		if not b then
			return true
		end

		if a.keyLevel > b.keyLevel then
			return true
		elseif a.keyLevel < b.keyLevel then
			return false
		end

		if a.fractionalTime > b.fractionalTime then
			return false
		elseif a.fractionalTime < b.fractionalTime then
			return true
		end

		if a.shortName > b.shortName then
			return false
		elseif a.shortName < b.shortName then
			return true
		end

		return false
	end

	-- get timezone offset between local and UTC+0 time
	function GetTimezoneOffset(ts)
		local u = date("!*t", ts)
		local l = date("*t", ts)
		l.isdst = false
		return difftime(time(l), time(u))
	end

	-- gets the current region name and index
	function GetRegion()
		-- use the player GUID to find the serverID and check the map for the region we are playing on
		local guid = UnitGUID("player")
		local server
		if guid then
			server = tonumber(strmatch(guid, "^Player%-(%d+)") or 0) or 0
			local i = CONST_REGION_IDS[server]
			if i then
				return REGIONS[i], i
			end
		end
		-- alert the user to report this to the devs
		DEFAULT_CHAT_FRAME:AddMessage(format(L.UNKNOWN_SERVER_FOUND, addonName, guid or "N/A", GetNormalizedRealmName() or "N/A"), 1, 1, 0)
		-- fallback logic that might be wrong, but better than nothing...
		local i = GetCurrentRegion()
		return REGIONS[i], i
	end

	-- attempts to extract the keystone level from the provided strings
	function GetKeystoneLevel(raw)
		if type(raw) ~= "string" then
			return
		end
		local regexesFindLevel = { "(%d+)%+", "%+%s*(%d+)", "(%d+)%s*%+", "(%d+)" }

		local level = 0;
		for i, regex in ipairs(regexesFindLevel) do
			level = raw:match(regex);
			level = tonumber(level)
			if level and level < 32 then
				break
			end
		end

		if not level or level < 2 then
			return
		end

		return level
	end

	-- detect LFD queue status
	-- returns two objects, first is a table containing queued dungeons and levels, second is a true|false based on if we are hosting ourselves
	-- the first table returns the dungeon directly if we are hosting, since we can only host for one dungeon at a time anyway
	function GetLFDStatus()
		local temp = {}
		-- are we hosting our own keystone group?
		local id, activityID, _, _, name, comment = C_LFGList.GetActiveEntryInfo()
		if id then
			if activityID then
				local index = LFD_ACTIVITYID_TO_DUNGEONID[activityID]
				if index then
					temp.index = index
					temp.dungeon = CONST_DUNGEONS[index]
					temp.level = GetKeystoneLevel(name) or GetKeystoneLevel(comment) or 0
					return temp, true
				end
			end
			return nil, true
		end
		-- scan what we have applied to, if we aren't hosting our own keystone
		local applications = C_LFGList.GetApplications()
		for i = 1, #applications do
			local resultID = applications[i]
			local id, activityID, name, comment, _, _, _, _, _, _, _, isDelisted = C_LFGList.GetSearchResultInfo(resultID)
			if activityID then
				local _, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(resultID)
				-- the application needs to be active for us to count as queued up for it
				if not isDelisted and not pendingStatus and (appStatus == "applied" or appStatus == "invited") then
					local index = LFD_ACTIVITYID_TO_DUNGEONID[activityID]
					if index then
						temp[#temp + 1] = {
							index = index,
							dungeon = CONST_DUNGEONS[index],
							level = GetKeystoneLevel(name) or GetKeystoneLevel(comment) or 0
						}
					end
				end
			end
		end
		-- return only if we have valid results
		if temp[1] then
			return temp, false
		end
	end

	-- detect what instance we are in
	function GetInstanceStatus()
		local _, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
		if instanceType ~= "party" then
			return
		end
		local index = DUNGEON_INSTANCEMAPID_TO_DUNGEONID[instanceMapID]
		if not index then
			return
		end
		local temp = {
			index = index,
			dungeon = CONST_DUNGEONS[index],
			level = 0
		}
		return temp, true, true
	end

	-- retrieves the url slug for a given realm name
	function GetRealmSlug(realm)
		return CONST_REALM_SLUGS[realm] or realm
	end

	-- returns the name, realm and possibly unit
	function GetNameAndRealm(arg1, arg2)
		local name, realm, unit
		if UnitExists(arg1) then
			unit = arg1
			if UnitIsPlayer(arg1) then
				name, realm = UnitName(arg1)
				realm = realm and realm ~= "" and realm or GetNormalizedRealmName()
			end
		elseif type(arg1) == "string" and arg1 ~= "" then
			if arg1:find("-", nil, true) then
				name, realm = ("-"):split(arg1)
			else
				name = arg1 -- assume this is the name
			end
			if not realm or realm == "" then
				if type(arg2) == "string" and arg2 ~= "" then
					realm = arg2
				else
					realm = GetNormalizedRealmName() -- assume they are on our realm
				end
			end
		end
		return name, realm, unit
	end

	-- returns 1 or 2 if the unit is Alliance or Horde, nil if neutral
	function GetFaction(unit)
		if UnitExists(unit) and UnitIsPlayer(unit) then
			local faction = UnitFactionGroup(unit)
			if faction then
				return FACTION[faction]
			end
		end
	end

	-- returns affix ID based on the week
	function GetWeeklyAffix(weekOffset)
		local timestamp = (time() - GetTimezoneOffset()) + 604800 * (weekOffset or 0)
		local timestampWeeklyReset = REGIONS_RESET_TIME[PLAYER_REGION]
		local diff = difftime(timestamp, timestampWeeklyReset)
		local index = floor(diff / 604800) % #KEYSTONE_AFFIX_SCHEDULE + 1
		return KEYSTONE_AFFIX_SCHEDULE[index]
	end

	function GetAverageScore(level)
		if CONST_AVERAGE_SCORE and CONST_AVERAGE_SCORE[level] then
			return CONST_AVERAGE_SCORE[level]
		end
		return nil
	end

	function GetStarsForUpgrades(upgrades, skipPadding)
		local stars = ""
		for q = 1, 3 do
			if 3 - q < upgrades then
				stars = stars .. "+"
			elseif not skipPadding then
				stars = stars .. " "
			end
		end
		if upgrades > 0 then
			return "|cffffcf40" .. stars .. "|r"
		else
			return stars
		end
	end

	function GetGuildFullname(unit)
		local guildName, _, _, guildRealm = GetGuildInfo(unit)

		if not guildName then
			return nil
		end

		if not guildRealm then
			_, guildRealm = GetNameAndRealm(unit)
		end

		return guildName.."-"..guildRealm
	end

end

-- addon functions
local Init
local InitConfig
local ProfileTooltip_SetFrameDraggability -- Needs to be set here to be used in the config
local ProfileTooltip_ShowNearFrame -- Needs to be set here to be used in the config
do
	-- update local reference to the correct savedvariable table
	local function UpdateGlobalConfigVar()
		if type(_G.RaiderIO_Config) ~= "table" then
			_G.RaiderIO_Config = addonConfig
		else
			local defaults = addonConfig
			addonConfig = setmetatable(_G.RaiderIO_Config, {
				__index = function(_, key)
					return defaults[key]
				end
			})
		end
	end

	-- addon config is loaded so we update the local reference and register for future events
	function Init()
		-- update local reference to the correct savedvariable table
		UpdateGlobalConfigVar()

		-- wait for the login event, or run the associated code right away
		if not IsLoggedIn() then
			addon:RegisterEvent("PLAYER_LOGIN")
		else
			addon:PLAYER_LOGIN()
		end

		-- create the config frame
		InitConfig()

		-- purge cache after zoning
		addon:RegisterEvent("PLAYER_ENTERING_WORLD")

		-- detect toggling of the modifier keys (additional events to try self-correct if we locked the mod key by using ALT-TAB)
		addon:RegisterEvent("MODIFIER_STATE_CHANGED")
	end

	-- addon config is loaded so we can build the config frame
	function InitConfig()
		_G.StaticPopupDialogs["RAIDERIO_RELOADUI_CONFIRM"] = {
			text = L.CHANGES_REQUIRES_UI_RELOAD,
			button1 = L.RELOAD_NOW,
			button2 = L.RELOAD_LATER,
			hasEditBox = false,
			preferredIndex = 3,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			OnShow = nil,
			OnHide = nil,
			OnAccept = ReloadUI,
			OnCancel = nil
		}

		configParentFrame = CreateFrame("Frame", addonName .. "ConfigParentFrame", UIParent)
		configParentFrame:SetSize(400, 600)
		configParentFrame:SetPoint("CENTER")

		configHeaderFrame = CreateFrame("Frame", nil, configParentFrame)
		configHeaderFrame:SetPoint("TOPLEFT", 00, -30)
		configHeaderFrame:SetPoint("TOPRIGHT", 00, 30)
		configHeaderFrame:SetHeight(40)

		configScrollFrame = CreateFrame("ScrollFrame", nil, configParentFrame)
		configScrollFrame:SetPoint("TOPLEFT", configHeaderFrame, "BOTTOMLEFT")
		configScrollFrame:SetPoint("TOPRIGHT", configHeaderFrame, "BOTTOMRIGHT")
		configScrollFrame:SetHeight(475)
		configScrollFrame:EnableMouseWheel(true)
		configScrollFrame:SetClampedToScreen(true);
		configScrollFrame:SetClipsChildren(true);
		configScrollFrame:HookScript("OnMouseWheel", function(self, delta)
			local currentValue = configSliderFrame:GetValue()
			local changes = -delta * 20
			configSliderFrame:SetValue(currentValue + changes)
		end)

		configButtonFrame = CreateFrame("Frame", nil, configParentFrame)
		configButtonFrame:SetPoint("TOPLEFT", configScrollFrame, "BOTTOMLEFT", 0, -10)
		configButtonFrame:SetPoint("TOPRIGHT", configScrollFrame, "BOTTOMRIGHT")
		configButtonFrame:SetHeight(50)

		configParentFrame.scrollframe = configScrollFrame

		configSliderFrame = CreateFrame("Slider", nil, configScrollFrame, "UIPanelScrollBarTemplate")
		configSliderFrame:SetPoint("TOPLEFT", configScrollFrame, "TOPRIGHT", -35, -18)
		configSliderFrame:SetPoint("BOTTOMLEFT", configScrollFrame, "BOTTOMRIGHT", -35, 18)
		configSliderFrame:SetMinMaxValues(1, 1)
		configSliderFrame:SetValueStep(1)
		configSliderFrame.scrollStep = 1
		configSliderFrame:SetValue(0)
		configSliderFrame:SetWidth(16)
		configSliderFrame:SetScript("OnValueChanged",
			function (self, value)
				self:GetParent():SetVerticalScroll(value)
			end)

		configParentFrame.scrollbar = configSliderFrame

		configFrame = CreateFrame("Frame", addonName .. "ConfigFrame", configScrollFrame)
		configFrame:SetSize(400, 600) -- resized to proper value below
		configScrollFrame.content = configFrame
		configScrollFrame:SetScrollChild(configFrame)
		configParentFrame:Hide()

		local config

		local function WidgetHelp_OnEnter(self)
			if self.tooltip then
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
				GameTooltip:AddLine(self.tooltip, 1, 1, 1, true)
				GameTooltip:Show()
			end
		end

		local function WidgetButton_OnEnter(self)
			self:SetBackdropColor(0.3, 0.3, 0.3, 1)
			self:SetBackdropBorderColor(1, 1, 1, 1)
		end

		local function WidgetButton_OnLeave(self)
			self:SetBackdropColor(0, 0, 0, 1)
			self:SetBackdropBorderColor(1, 1, 1, 0.3)
		end

		local function Close_OnClick()
			configParentFrame:SetShown(not configParentFrame:IsShown())
		end

		local function Save_OnClick()
			Close_OnClick()
			local reload
			for i = 1, #config.modules do
				local f = config.modules[i]
				local checked1 = f.checkButton:GetChecked()
				local checked2 = f.checkButton2:GetChecked()
				local loaded1 = IsAddOnLoaded(f.addon1)
				local loaded2 = IsAddOnLoaded(f.addon2)
				if checked1 then
					if not loaded1 then
						reload = 1
						EnableAddOn(f.addon1)
					end
				elseif loaded1 then
					reload = 1
					DisableAddOn(f.addon1)
				end
				if checked2 then
					if not loaded2 then
						reload = 1
						EnableAddOn(f.addon2)
					end
				elseif loaded2 then
					reload = 1
					DisableAddOn(f.addon2)
				end
			end
			for i = 1, #config.options do
				local f = config.options[i]
				local checked = f.checkButton:GetChecked()
				local enabled = addonConfig[f.cvar]

				addonConfig[f.cvar] = not not checked

				if ((not enabled and checked) or (enabled and not checked)) then
					if f.needReload then
						reload = 1
					end
					if f.callback then
						f.callback()
					end
				end
			end
			if reload then
				StaticPopup_Show("RAIDERIO_RELOADUI_CONFIRM")
			end

			-- snap Tooltip back to the PVEFrame when auto is turned on
			if addonConfig.positionProfileAuto and PVEFrame:IsShown() then
				ProfileTooltip_ShowNearFrame(PVEFrame, "BACKGROUND")
			end

			-- Draggability of profileTooltip frame
			ProfileTooltip_SetFrameDraggability(not addonConfig.positionProfileAuto and not addonConfig.lockProfile)

			-- Reset profile position to nil
			if addonConfig.positionProfileAuto then
				addonConfig.profilePoint = {
					["point"] = nil,
					["x"] = nil,
					["y"] = nil
				}
			end
		end

		config = {
			modules = {},
			options = {},
			backdrop = {
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			}
		}

		function config.Update(self)
			for i = 1, #self.modules do
				local f = self.modules[i]
				f.checkButton:SetChecked(IsAddOnLoaded(f.addon1))
				f.checkButton2:SetChecked(IsAddOnLoaded(f.addon2))
			end
			for i = 1, #self.options do
				local f = self.options[i]
				f.checkButton:SetChecked(addonConfig[f.cvar] ~= false)
			end
		end

		function config.CreateWidget(self, widgetType, height, parentFrame)
			local widget = CreateFrame(widgetType, nil, parentFrame or configFrame)

			if self.lastWidget then
				widget:SetPoint("TOPLEFT", self.lastWidget, "BOTTOMLEFT", 0, -24)
				widget:SetPoint("BOTTOMRIGHT", self.lastWidget, "BOTTOMRIGHT", 0, -4)
			else
				widget:SetPoint("TOPLEFT", parentFrame or configFrame, "TOPLEFT", 16, 0)
				widget:SetPoint("BOTTOMRIGHT", parentFrame or configFrame, "TOPRIGHT", -40, -16)
			end

			widget.bg = widget:CreateTexture()
			widget.bg:SetAllPoints()
			widget.bg:SetColorTexture(0, 0, 0, 0.5)

			widget.text = widget:CreateFontString(nil, nil, "GameFontNormal")
			widget.text:SetPoint("LEFT", 8, 0)
			widget.text:SetPoint("RIGHT", -8, 0)
			widget.text:SetJustifyH("LEFT")

			widget.checkButton = CreateFrame("CheckButton", "$parentCheckButton1", widget, "UICheckButtonTemplate")
			widget.checkButton:Hide()
			widget.checkButton:SetPoint("RIGHT", -4, 0)
			widget.checkButton:SetScale(0.7)

			widget.checkButton2 = CreateFrame("CheckButton", "$parentCheckButton2", widget, "UICheckButtonTemplate")
			widget.checkButton2:Hide()
			widget.checkButton2:SetPoint("RIGHT", widget.checkButton, "LEFT", -4, 0)
			widget.checkButton2:SetScale(0.7)

			widget.help = CreateFrame("Frame", nil, widget)
			widget.help:Hide()
			widget.help:SetPoint("LEFT", widget.checkButton, "LEFT", -20, 0)
			widget.help:SetSize(16, 16)
			widget.help:SetScale(0.9)
			widget.help.icon = widget.help:CreateTexture()
			widget.help.icon:SetAllPoints()
			widget.help.icon:SetTexture("Interface\\GossipFrame\\DailyActiveQuestIcon")

			widget.help:SetScript("OnEnter", WidgetHelp_OnEnter)
			widget.help:SetScript("OnLeave", GameTooltip_Hide)

			if widgetType == "Button" then
				widget.bg:Hide()
				widget.text:SetTextColor(1, 1, 1)
				widget:SetBackdrop(self.backdrop)
				widget:SetBackdropColor(0, 0, 0, 1)
				widget:SetBackdropBorderColor(1, 1, 1, 0.3)
				widget:SetScript("OnEnter", WidgetButton_OnEnter)
				widget:SetScript("OnLeave", WidgetButton_OnLeave)
			end

			if not parentFrame then
				self.lastWidget = widget
			end
			return widget
		end

		function config.CreatePadding(self)
			local frame = self:CreateWidget("Frame")
			local _, lastWidget = frame:GetPoint(1)
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", lastWidget, "BOTTOMLEFT", 0, -14)
			frame:SetPoint("BOTTOMRIGHT", lastWidget, "BOTTOMRIGHT", 0, -4)
			frame.bg:Hide()
			return frame
		end

		function config.CreateHeadline(self, text, parentFrame)
			local frame = self:CreateWidget("Frame", nil, parentFrame)
			frame.bg:Hide()
			frame.text:SetText(text)
			return frame
		end

		function config.CreateModuleToggle(self, name, addon1, addon2)
			local frame = self:CreateWidget("Frame")
			frame.text:SetText(name)
			frame.addon2 = addon1
			frame.addon1 = addon2
			frame.checkButton:Show()
			frame.checkButton2:Show()
			self.modules[#self.modules + 1] = frame
			return frame
		end

		function config.CreateOptionToggle(self, label, description, cvar, config)
			local frame = self:CreateWidget("Frame")
			frame.text:SetText(label)
			frame.tooltip = description
			frame.cvar = cvar
			frame.needReload = (config and config.needReload) or false
			frame.callback = (config and config.callback) or nil
			frame.help.tooltip = description
			frame.help:Show()
			frame.checkButton:Show()
			self.options[#self.options + 1] = frame
			return frame
		end

		-- customize the look and feel
		do
			local function ConfigFrame_OnShow(self)
				if not InCombatLockdown() then
					if InterfaceOptionsFrame:IsShown() then
						InterfaceOptionsFrame_Show()
					end
					HideUIPanel(GameMenuFrame)
				end
				config:Update()
			end

			local function ConfigFrame_OnDragStart(self)
				self:StartMoving()
			end

			local function ConfigFrame_OnDragStop(self)
				self:StopMovingOrSizing()
			end

			local function ConfigFrame_OnEvent(self, event)
				if event == "PLAYER_REGEN_ENABLED" then
					if self.combatHidden then
						self.combatHidden = nil
						self:Show()
					end
				elseif event == "PLAYER_REGEN_DISABLED" then
					if self:IsShown() then
						self.combatHidden = true
						self:Hide()
					end
				end
			end

			configParentFrame:SetFrameStrata("DIALOG")
			configParentFrame:SetFrameLevel(255)

			configParentFrame:EnableMouse(true)
			configParentFrame:SetClampedToScreen(true)
			configParentFrame:SetDontSavePosition(true)
			configParentFrame:SetMovable(true)
			configParentFrame:RegisterForDrag("LeftButton")

			configParentFrame:SetBackdrop(config.backdrop)
			configParentFrame:SetBackdropColor(0, 0, 0, 0.8)
			configParentFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8)

			configParentFrame:SetScript("OnShow", ConfigFrame_OnShow)
			configParentFrame:SetScript("OnDragStart", ConfigFrame_OnDragStart)
			configParentFrame:SetScript("OnDragStop", ConfigFrame_OnDragStop)
			configParentFrame:SetScript("OnEvent", ConfigFrame_OnEvent)

			configParentFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
			configParentFrame:RegisterEvent("PLAYER_REGEN_DISABLED")

			-- add widgets
			local header = config:CreateHeadline(L.RAIDERIO_MYTHIC_OPTIONS .. "\nVersion: " .. tostring(GetAddOnMetadata(addonName, "Version")), configHeaderFrame)
			header.text:SetFont(header.text:GetFont(), 16, "OUTLINE")

			config:CreateHeadline(L.MYTHIC_PLUS_SCORES)
			config:CreateOptionToggle(L.SHOW_ON_PLAYER_UNITS, L.SHOW_ON_PLAYER_UNITS_DESC, "enableUnitTooltips")
			config:CreateOptionToggle(L.SHOW_IN_LFD, L.SHOW_IN_LFD_DESC, "enableLFGTooltips")
			config:CreateOptionToggle(L.SHOW_IN_FRIENDS, L.SHOW_IN_FRIENDS_DESC, "enableFriendsTooltips")
			config:CreateOptionToggle(L.SHOW_ON_GUILD_ROSTER, L.SHOW_ON_GUILD_ROSTER_DESC, "enableGuildTooltips")
			config:CreateOptionToggle(L.SHOW_IN_WHO_UI, L.SHOW_IN_WHO_UI_DESC, "enableWhoTooltips")
			config:CreateOptionToggle(L.SHOW_IN_SLASH_WHO_RESULTS, L.SHOW_IN_SLASH_WHO_RESULTS_DESC, "enableWhoMessages")

			config:CreatePadding()
			config:CreateHeadline(L.TOOLTIP_CUSTOMIZATION)
			config:CreateOptionToggle(L.SHOW_MAINS_SCORE, L.SHOW_MAINS_SCORE_DESC, "showMainsScore")
			config:CreateOptionToggle(L.ENABLE_SIMPLE_SCORE_COLORS, L.ENABLE_SIMPLE_SCORE_COLORS_DESC, "showSimpleScoreColors")
			config:CreateOptionToggle(L.ENABLE_NO_SCORE_COLORS, L.ENABLE_NO_SCORE_COLORS_DESC, "disableScoreColors")
			config:CreateOptionToggle(L.ALWAYS_SHOW_EXTENDED_INFO, L.ALWAYS_SHOW_EXTENDED_INFO_DESC, "alwaysExtendTooltip")
			config:CreateOptionToggle(L.SHOW_SCORE_IN_COMBAT, L.SHOW_SCORE_IN_COMBAT_DESC, "showScoreInCombat")
			config:CreateOptionToggle(L.SHOW_KEYSTONE_INFO, L.SHOW_KEYSTONE_INFO_DESC, "enableKeystoneTooltips")
			config:CreateOptionToggle(L.SHOW_AVERAGE_PLAYER_SCORE_INFO, L.SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC, "showAverageScore")

			config:CreatePadding()
			config:CreateHeadline(L.TOOLTIP_PROFILE)
			config:CreateOptionToggle(L.SHOW_RAIDERIO_PROFILE, L.SHOW_RAIDERIO_PROFILE_DESC, "showRaiderIOProfile", {["needReload"] = true})
			config:CreateOptionToggle(L.SHOW_LEADER_PROFILE, L.SHOW_LEADER_PROFILE_DESC, "enableProfileModifier")
			config:CreateOptionToggle(L.INVERSE_PROFILE_MODIFIER, L.INVERSE_PROFILE_MODIFIER_DESC, "inverseProfileModifier")
			config:CreateOptionToggle(L.ENABLE_AUTO_FRAME_POSITION, L.ENABLE_AUTO_FRAME_POSITION_DESC, "positionProfileAuto")
			config:CreateOptionToggle(L.ENABLE_LOCK_PROFILE_FRAME, L.ENABLE_LOCK_PROFILE_FRAME_DESC, "lockProfile")

			config:CreatePadding()
			config:CreateHeadline(L.RAIDERIO_CLIENT_CUSTOMIZATION)
			config:CreateOptionToggle(L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS, L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC, "enableClientEnhancements", {["needReload"] = true})
			config:CreateOptionToggle(L.SHOW_CLIENT_GUILD_BEST, L.SHOW_CLIENT_GUILD_BEST_DESC, "showClientGuildBest", {["needReload"] = true})

			config:CreatePadding()
			config:CreateHeadline(L.COPY_RAIDERIO_PROFILE_URL)
			config:CreateOptionToggle(L.ALLOW_ON_PLAYER_UNITS, L.ALLOW_ON_PLAYER_UNITS_DESC, "showDropDownCopyURL")
			config:CreateOptionToggle(L.ALLOW_IN_LFD, L.ALLOW_IN_LFD_DESC, "enableLFGDropdown")

			config:CreatePadding()
			config:CreateHeadline(L.MYTHIC_PLUS_DB_MODULES)
			local module1 = config:CreateModuleToggle(L.MODULE_AMERICAS, "RaiderIO_DB_US_A", "RaiderIO_DB_US_H")
			config:CreateModuleToggle(L.MODULE_EUROPE, "RaiderIO_DB_EU_A", "RaiderIO_DB_EU_H")
			config:CreateModuleToggle(L.MODULE_KOREA, "RaiderIO_DB_KR_A", "RaiderIO_DB_KR_H")
			config:CreateModuleToggle(L.MODULE_TAIWAN, "RaiderIO_DB_TW_A", "RaiderIO_DB_TW_H")

			-- add save button and cancel buttons
			local buttons = config:CreateWidget("Frame", 4, configButtonFrame)
			buttons:ClearAllPoints()
			buttons:SetPoint("TOPLEFT", configButtonFrame, "TOPLEFT", 16, 0)
			buttons:SetPoint("BOTTOMRIGHT", configButtonFrame, "TOPRIGHT", -16, -10)
			buttons:Hide()
			local save = config:CreateWidget("Button", 4, configButtonFrame)
			local cancel = config:CreateWidget("Button", 4, configButtonFrame)
			save:ClearAllPoints()
			save:SetPoint("LEFT", buttons, "LEFT", 0, -12)
			save:SetSize(96, 28)
			save.text:SetText(SAVE)
			save.text:SetJustifyH("CENTER")
			save:SetScript("OnClick", Save_OnClick)
			cancel:ClearAllPoints()
			cancel:SetPoint("RIGHT", buttons, "RIGHT", 0, -12)
			cancel:SetSize(96, 28)
			cancel.text:SetText(CANCEL)
			cancel.text:SetJustifyH("CENTER")
			cancel:SetScript("OnClick", Close_OnClick)

			-- adjust frame height dynamically
			local children = {configFrame:GetChildren()}
			local height = 40
			for i = 1, #children do
				height = height + children[i]:GetHeight() + 2
			end

			configSliderFrame:SetMinMaxValues(1, height - 440)
			configFrame:SetHeight(height)

			-- adjust frame width dynamically (add padding based on the largest option label string)
			local maxWidth = 0
			for i = 1, #config.options do
				local option = config.options[i]
				if option.text and option.text:GetObjectType() == "FontString" then
					maxWidth = max(maxWidth, option.text:GetStringWidth())
				end
			end
			configFrame:SetWidth(160 + maxWidth)
			configParentFrame:SetWidth(160 + maxWidth)

			-- add faction headers over the first module
			local af = config:CreateHeadline("|TInterface\\Icons\\inv_bannerpvp_02:0:0:0:0:16:16:4:12:4:12|t")
			af:ClearAllPoints()
			af:SetPoint("BOTTOM", module1.checkButton2, "TOP", 2, -5)
			af:SetSize(32, 32)
			local hf = config:CreateHeadline("|TInterface\\Icons\\inv_bannerpvp_01:0:0:0:0:16:16:4:12:4:12|t")
			hf:ClearAllPoints()
			hf:SetPoint("BOTTOM", module1.checkButton, "TOP", 2, -5)
			hf:SetSize(32, 32)
		end

		-- add the category and a shortcut button in the interface panel options
		do
			local function Button_OnClick()
				if not InCombatLockdown() then
					configParentFrame:SetShown(not configParentFrame:IsShown())
				end
			end

			local panel = CreateFrame("Frame", configFrame:GetName() .. "Panel", InterfaceOptionsFramePanelContainer)
			panel.name = addonName
			panel:Hide()

			local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
			button:SetText(L.OPEN_CONFIG)
			button:SetWidth(button:GetTextWidth() + 18)
			button:SetPoint("TOPLEFT", 16, -16)
			button:SetScript("OnClick", Button_OnClick)

			InterfaceOptions_AddCategory(panel, true)
		end

		-- create slash command to toggle the config frame
		do
			_G["SLASH_" .. addonName .. "1"] = "/raiderio"
			_G["SLASH_" .. addonName .. "2"] = "/rio"

			local function handler(text)
				if type(text) == "string" then

					-- if the keyword "lock" is present in the command we toggle lock behavior on profile frame
					if text:find("[Ll][Oo][Cc][Kk]") then
						if addonConfig.positionProfileAuto then
							DEFAULT_CHAT_FRAME:AddMessage(L.WARNING_LOCK_POSITION_FRAME_AUTO, 1, 1, 0)
							return
						end

						if addonConfig.lockProfile then
							DEFAULT_CHAT_FRAME:AddMessage(L.UNLOCKING_PROFILE_FRAME, 1, 1, 0)
						else
							DEFAULT_CHAT_FRAME:AddMessage(L.LOCKING_PROFILE_FRAME, 1, 1, 0)
						end
						addonConfig.lockProfile = not addonConfig.lockProfile
						ProfileTooltip_SetFrameDraggability(not addonConfig.lockProfile)
						return
					end

					-- if the keyword "debug" is present in the command we show the query dialog
					local debugQuery = text:match("[Dd][Ee][Bb][Uu][Gg]%s*(.-)$")
					if debugQuery then
						if not ns.DEBUG_UI and ns.DEBUG_INIT then
							ns.DEBUG_INIT()
						end
						if ns.DEBUG_UI then
							if strlenutf8(debugQuery) > 0 then
								ns.DEBUG_UI:Show()
								ns.DEBUG_UI:Search(debugQuery)
							else
								ns.DEBUG_UI:SetShown(not ns.DEBUG_UI:IsShown())
							end
						end
						-- we do not wish to show the config dialog at this time
						return
					end

				end

				-- resume regular routine
				if not InCombatLockdown() then
					configParentFrame:SetShown(not configParentFrame:IsShown())
				end
			end

			SlashCmdList[addonName] = handler
		end
	end
end

-- provider
local AddProvider
local AddClientCharacters
local AddClientGuilds
local GetScore
local GetScoreColor
do
	-- unpack the payload
	local function UnpackPayload(data)
		-- 4294967296 == (1 << 32). Meaning, shift to get the hi-word.
		-- WoW lua bit operators seem to only work on the lo-word (?)
		local hiword = data / 4294967296
		return
			band(data, PAYLOAD_MASK),
			band(rshift(data, PAYLOAD_BITS), PAYLOAD_MASK),
			band(hiword, PAYLOAD_MASK),
			band(rshift(hiword, PAYLOAD_BITS), PAYLOAD_MASK)
	end

	-- search for the index of a name in the given sorted list
	local function BinarySearchForName(list, name, startIndex, endIndex)
		local minIndex = startIndex
		local maxIndex = endIndex
		local mid, current

		while minIndex <= maxIndex do
			mid = floor((maxIndex + minIndex) / 2)
			current = list[mid]
			if current == name then
				return mid
			elseif current < name then
				minIndex = mid + 1
			else
				maxIndex = mid - 1
			end
		end
	end

	local function Split64BitNumber(dword)
		-- 0x100000000 == (1 << 32). Meaning, shift to get the hi-word.
		-- WoW lua bit operators seem to only work on the lo-word (?)
		local lo = band(dword, 0xfffffffff)
		return lo, (dword - lo) / 0x100000000
	end

	-- read given number of bits from the chosen offset with max of 52 bits
	-- assumed that lo contains 32 bits and hi contains 20 bits
	local function ReadBits(lo, hi, offset, bits)
		if offset < 32 and (offset + bits) > 32 then
			-- reading across boundary
			local mask = lshift(1, (offset + bits) - 32) - 1
			local p1 = rshift(lo, offset)
			local p2 = lshift(band(hi, mask), 32 - offset)
			return p1 + p2
		else
			local mask = lshift(1, bits) - 1
			if offset < 32 then
				-- standard read from loword
				return band(rshift(lo, offset), mask)
			else
				-- standard read from hiword
				return band(rshift(hi, offset - 32), mask)
			end
		end
	end

	local function UnpackCharacterData(data1, data2, data3)
		local results = {}
		local lo, hi
		local offset

		--
		-- Field 1
		--
		lo, hi = Split64BitNumber(data1)
		offset = 0

		results.allScore = ReadBits(lo, hi, offset, PAYLOAD_BITS)
		offset = offset + PAYLOAD_BITS

		results.healScore = ReadBits(lo, hi, offset, PAYLOAD_BITS)
		offset = offset + PAYLOAD_BITS

		results.tankScore = ReadBits(lo, hi, offset, PAYLOAD_BITS)
		offset = offset + PAYLOAD_BITS

		results.mainScore = ReadBits(lo, hi, offset, PAYLOAD_BITS)
		offset = offset + PAYLOAD_BITS

		results.isPrevAllScore = not (ReadBits(lo, hi, offset, 1) == 0)
		offset = offset + 1

		--
		-- Field 2
		--
		lo, hi = Split64BitNumber(data2)

		offset = 0
		results.dpsScore = ReadBits(lo, hi, offset, PAYLOAD_BITS)
		offset = offset + PAYLOAD_BITS

		local dungeonIndex = 1
		results.dungeons = {}
		for i = 1, 8 do
			results.dungeons[dungeonIndex] = ReadBits(lo, hi, offset, 5)
			dungeonIndex = dungeonIndex + 1
			offset = offset + 5
		end

		--
		-- Field 3
		--
		lo, hi = Split64BitNumber(data3)

		offset = 0
		while dungeonIndex <= #ns.dungeons do
			results.dungeons[dungeonIndex] = ReadBits(lo, hi, offset, 5)
			dungeonIndex = dungeonIndex + 1
			offset = offset + 5
		end

		local maxDungeonLevel = 0
		local maxDungeonIndex = -1	-- we may not have a max dungeon if user was brought in because of +10/+15 achievement
		for i = 1, #results.dungeons do
			if results.dungeons[i] > maxDungeonLevel then
				maxDungeonLevel = results.dungeons[i]
				maxDungeonIndex = i
			end
		end

		results.maxDungeonLevel = maxDungeonLevel
		results.maxDungeonIndex = maxDungeonIndex

		results.keystoneTenPlus = ReadBits(lo, hi, offset, 8)
		offset = offset + 8

		results.keystoneFifteenPlus = ReadBits(lo, hi, offset, 8)
		offset = offset + 8

		return results
	end

	-- caches the profile table and returns one using keys
	local function CacheProviderData(name, realm, faction, index, data1, data2, data3)
		local cache = profileCache[index]

		-- prefer to re-use cached profiles
		if cache then
			return cache
		end

		-- unpack the payloads into these tables
		payload = UnpackCharacterData(data1, data2, data3)

		-- TODO: can we make this table read-only? raw methods will bypass metatable restrictions we try to enforce
		-- build this custom table in order to avoid users tainting the provider database
		cache = {
			region = dataProvider.region,
			date = dataProvider.date,
			season = dataProvider.season,
			prevSeason = dataProvider.prevSeason,
			name = name,
			realm = realm,
			faction = faction,
			-- current and last season overall score
			allScore = payload.allScore,
			isPrevAllScore = payload.isPrevAllScore,
			mainScore = payload.mainScore,
			-- extract the scores per role
			dpsScore = payload.dpsScore,
			healScore = payload.healScore,
			tankScore = payload.tankScore,
			-- has been enhanced with client data
			isEnhanced = false,
			-- dungeons they have completed
			dungeons = payload.dungeons,
			-- number of keystone upgrades per dungeon
			dungeonUpgrades = {},
			-- fractional time for each dungeon completion
			dungeonTimes = {},
			maxDungeonLevel = payload.maxDungeonLevel,
			maxDungeonUpgrades = 0,
			maxDungeonName = CONST_DUNGEONS[payload.maxDungeonIndex] and CONST_DUNGEONS[payload.maxDungeonIndex].shortName or '',
			maxDungeonNameLocale = CONST_DUNGEONS[payload.maxDungeonIndex] and CONST_DUNGEONS[payload.maxDungeonIndex].shortNameLocale or '',
			keystoneTenPlus = payload.keystoneTenPlus,
			keystoneFifteenPlus = payload.keystoneFifteenPlus,
		}

		-- BFA
		cache.legionScore = RoundNumber(cache.allScore, 10)
		cache.legionMainScore = RoundNumber(cache.mainScore, 10)
		cache.allScore = 0
		cache.isPrevAllScore = false
		cache.mainScore = 0
		cache.dpsScore = 0
		cache.healScore = 0
		cache.tankScore = 0
		cache.maxDungeonLevel = 0
		cache.maxDungeonName = ''
		cache.maxDungeonNameLocale = ''
		cache.keystoneTenPlus = 0
		cache.keystoneFifteenPlus = 0
		for i = 1, #cache.dungeons do
			cache.dungeons[i] = 0
		end

		-- if character exists in the clientCharacters list then override some data with higher precision
		-- TODO: only do this if the clientCharacters data isn't too old compared to regular addon date?
--		if addonConfig.enableClientEnhancements then
		if false then -- DISABLED FOR BFA
			local nameAndRealm = name .. "-" .. realm
			if clientCharacters[nameAndRealm] then
				local keystoneData = clientCharacters[nameAndRealm].mythic_keystone
				cache.isEnhanced = true
				cache.allScore = keystoneData.all.score

				local maxDungeonIndex = 0
				local maxDungeonTime = 999
				local maxDungeonLevel = 0
				local maxDungeonUpgrades = 0

				for i = 1, #keystoneData.all.runs do
					local run = keystoneData.all.runs[i]
					cache.dungeons[i] = run.level
					cache.dungeonUpgrades[i] = run.upgrades
					cache.dungeonTimes[i] = run.fraction

					if (run.level > maxDungeonLevel) or (run.level == maxDungeonLevel and run.fraction < maxDungeonTime) then
						maxDungeonLevel = run.level
						maxDungeonTime = run.fraction
						maxDungeonUpgrades = run.upgrades
						maxDungeonIndex = i
					end
				end

				if maxDungeonIndex > 0 then
					cache.maxDungeonLevel = maxDungeonLevel
					cache.maxDungeonName = CONST_DUNGEONS[payload.maxDungeonIndex] and CONST_DUNGEONS[payload.maxDungeonIndex].shortName or ''
					cache.maxDungeonNameLocale = CONST_DUNGEONS[payload.maxDungeonIndex] and CONST_DUNGEONS[payload.maxDungeonIndex].shortNameLocale or ''
					cache.maxDungeonUpgrades = maxDungeonUpgrades
				end
			end
		end

		-- append additional role information
		cache.isTank, cache.isHealer, cache.isDPS = cache.tankScore > 0, cache.healScore > 0, cache.dpsScore > 0
		cache.numRoles = (cache.tankScore > 0 and 1 or 0) + (cache.healScore > 0 and 1 or 0) + (cache.dpsScore > 0 and 1 or 0)

		-- store it in the profile cache
		profileCache[index] = cache

		-- return the freshly generated table
		return cache
	end

	-- returns the profile of a given character, faction is optional but recommended for quicker lookups
	local function GetProviderData(name, realm, faction)
		-- figure out what faction tables we want to iterate
		local a, b = 1, 2
		if faction == 1 or faction == 2 then
			a, b = faction, faction
		end
		-- iterate through the data
		local db, lu, r, d, base, bucketID, bucket
		for i = a, b do
			db, lu = dataProvider["db" .. i], dataProvider["lookup" .. i]
			-- sanity check that the data exists and is loaded, because it might not be for the requested faction
			if db and lu then
				r = db[realm]
				if r then
					d = BinarySearchForName(r, name, 2, #r)
					if d then
						-- `r[1]` = offset for this realm's characters in lookup table
						-- `d` = index of found character in realm list. note: this is offset by one because of r[1]
						-- `bucketID` is the index in the lookup table that contains that characters data
						base = r[1] + (d - 1) * NUM_FIELDS_PER_CHARACTER - (NUM_FIELDS_PER_CHARACTER - 1)
						bucketID = floor(base / LOOKUP_MAX_SIZE)
						bucket = lu[bucketID + 1]
						base = base - bucketID * LOOKUP_MAX_SIZE
						return CacheProviderData(name, realm, i, i .. "-" .. bucketID .. "-" .. base, bucket[base], bucket[base + 1], bucket[base + 2])
					end
				end
			end
		end
	end

	function AddProvider(data)
		-- make sure the object is what we expect it to be like
		assert(type(data) == "table" and type(data.name) == "string" and type(data.region) == "string" and type(data.faction) == "number", "Raider.IO has been requested to load a database that isn't supported.")
		-- queue it for later inspection
		dataProviderQueue[#dataProviderQueue + 1] = data
	end

	function AddClientCharacters(data)
		-- make sure the object is what we expect it to be like (TODO: check this more deeply?)
		assert(type(data) == "table", "Raider.IO has been requested to load a client database that isn't supported.")
		clientCharacters = data
	end

	function AddClientGuilds(data)
		-- make sure the object is what we expect it to be like (TODO: check this more deeply?)
		assert(type(data) == "table", "Raider.IO has been requested to load a client database that isn't supported.")
		guildBest = data
		guildProviderCalled = true
	end

	-- retrieves the profile of a given unit, or name+realm query
	function GetScore(arg1, arg2, forceFaction)
		if not dataProvider then
			return
		end
		local name, realm, unit = GetNameAndRealm(arg1, arg2)
		if name and realm then
			-- no need to lookup lowbies for a score
			if unit and (UnitLevel(unit) or 0) < MAX_LEVEL then
				return
			end
			return GetProviderData(name, realm, type(forceFaction) == "number" and forceFaction or GetFaction(unit))
		end
	end

	-- returns score color using item colors
	function GetScoreColor(score)
		if score == 0 or addonConfig.disableScoreColors then
			return 1, 1, 1
		end
		local r, g, b = 0.62, 0.62, 0.62
		if type(score) == "number" then
			if not addonConfig.showSimpleScoreColors then
				for i = 1, #CONST_SCORE_TIER do
					local tier = CONST_SCORE_TIER[i]
					if score >= tier.score then
						local color = tier.color
						r, g, b = color[1], color[2], color[3]
						break
					end
				end
			else
				local qualityColor = 0
				for i = 1, #CONST_SCORE_TIER_SIMPLE do
					local tier = CONST_SCORE_TIER_SIMPLE[i]
					if score >= tier.score then
						qualityColor = tier.quality
						break
					end
				end
				r, g, b = GetItemQualityColor(qualityColor)
			end
		end
		return r, g, b
	end
end

-- tooltips
local GetFormattedScore
local GetFormattedRunCount
local AppendGameTooltip
local UpdateAppendedGameTooltip
local AppendAveragePlayerScore
local AddLegionScore
do
	local function sortRoleScores(a, b)
		return a[2] > b[2]
	end

	-- returns score formatted for current or prev season
	function GetFormattedScore(score, isPrevious)
		if isPrevious then
			return score .. " " .. L.PREV_SEASON_SUFFIX
		end
		return score
	end

	-- we only use 8 bits for a run, so decide a cap that we won't show beyond
	function GetFormattedRunCount(count)
		if count > 250 then
			return '250+'
		else
			return count
		end
	end

	function AddLegionScore(tooltip, profile)
		if profile.legionScore and profile.legionScore > 0 and (not profile.legionMainScore or profile.legionMainScore <= profile.legionScore) then
			tooltip:AddDoubleLine(L.LEGION_SCORE, GetFormattedScore(profile.legionScore), 1, 1, 1, 1, 1, 1)
		elseif profile.legionMainScore and (not profile.legionScore or profile.legionMainScore > profile.legionScore) then
			tooltip:AddDoubleLine(L.LEGION_MAIN_SCORE, GetFormattedScore(profile.legionMainScore), 1, 1, 1, 1, 1, 1)
		end
	end

	-- appends score data to a given tooltip
	function AppendGameTooltip(tooltip, arg1, forceNoPadding, forceAddName, forceFaction, focusOnDungeonIndex, focusOnKeystoneLevel)
		local profile = GetScore(arg1, nil, forceFaction)

		-- setup tooltip hook
		if not tooltipHooks[tooltip] then
			tooltipHooks[tooltip] = true
			tooltip:HookScript("OnTooltipCleared", tooltipHooks.Wipe)
			tooltip:HookScript("OnHide", tooltipHooks.Wipe)
		end

		tooltipArgs[2], tooltipArgs[3], tooltipArgs[4], tooltipArgs[5], tooltipArgs[6] = forceNoPadding, forceAddName, forceFaction, focusOnDungeonIndex, focusOnKeystoneLevel

		-- sanity check that the profile exists
		if profile then
			-- HOTFIX: ALT-TAB stickyness
			addon:MODIFIER_STATE_CHANGED(true)

			-- assign the current function args for later use
			playerTooltip = tooltip
			tooltipArgs[1] = arg1

			-- should we show the extended version of the data?
			local showExtendedTooltip = addon.modKey or addonConfig.alwaysExtendTooltip

			-- add padding line if it looks nicer on the tooltip, also respect users preference
			if not forceNoPadding then
				tooltip:AddLine(" ")
			end

			-- show the players name if required by the calling function
			if forceAddName then
				tooltip:AddLine(profile.name .. " (" .. profile.realm .. ")", 1, 1, 1, false)
			end

			if profile.allScore >= 0 then
				tooltip:AddDoubleLine(L.RAIDERIO_MP_SCORE, GetFormattedScore(profile.allScore, profile.isPrevAllScore), 1, 0.85, 0, GetScoreColor(profile.allScore))
			else
				tooltip:AddDoubleLine(L.RAIDERIO_MP_SCORE, L.UNKNOWN_SCORE, 1, 0.85, 0, 1, 1, 1)
			end

			AddLegionScore(tooltip, profile)

			-- choose the best highlight to show:
			-- if user has a recorded run at higher level than their highest
			-- achievement then show that. otherwise, show their highest achievement.
			local highlightStr
			if profile.keystoneFifteenPlus > 0 then
				if profile.maxDungeonLevel < 15 then
					highlightStr = L.KEYSTONE_COMPLETED_15
				end
			elseif profile.keystoneTenPlus > 0 then
				if profile.maxDungeonLevel < 10 then
					highlightStr = L.KEYSTONE_COMPLETED_10
				end
			end

			if not highlightStr and profile.maxDungeonLevel > 0 then
				highlightStr = "+" .. profile.maxDungeonLevel .. " " .. profile.maxDungeonNameLocale
			end

			-- queued/focus highlight variables
			local qHighlightStrSameAsBest, qHighlightStr1, qHighlightStr2

			-- are we focusing on a specific keystone?
			if focusOnDungeonIndex then
				local d = CONST_DUNGEONS[focusOnDungeonIndex]
				local l = profile.dungeons[focusOnDungeonIndex]
				if l > 0 then
					qHighlightStrSameAsBest = profile.maxDungeonName == d.shortName
					qHighlightStr1 = d.shortNameLocale
					qHighlightStr2 = "+" .. l
				end
			end

			local searchLevel = 0

			-- if not, then are we queued for, or hosting a group for a keystone run?
			if not focusOnDungeonIndex then
				local queued, isHosting = GetLFDStatus()
				local waitingInsideDungeon
				-- if no LFD, are we inside a dungeon we'd like to show the score for?
				if not queued or isHosting == nil then
					queued, isHosting, waitingInsideDungeon = GetInstanceStatus()
				end
				if queued and isHosting ~= nil then
					if isHosting then
						-- we are inside dungeon waiting on our group
						if waitingInsideDungeon and (queued.index == 12 or queued.index == 13) then -- we don't know what part of karazhan we are doing
							queued.index = profile.dungeons[12] > profile.dungeons[13] and 12 or 13 -- pick best score (lower or upper)
							queued.dungeon = CONST_DUNGEONS[queued.index] -- adjust the dungeon data we display
						end
						-- we are hosting, so this is the only keystone we are interested in showing
						if profile.dungeons[queued.index] > 0 then
							qHighlightStrSameAsBest = profile.maxDungeonName == queued.dungeon.shortName
							qHighlightStr1 = queued.dungeon.shortNameLocale
							qHighlightStr2 = "+" .. profile.dungeons[queued.index]
							searchLevel = queued.level
						end
					else
						-- at the moment we pick the first queued dungeon and hope the player only queues for one dungeon at a time, not multiple different keys
						if profile.dungeons[queued[1].index] > 0 then
							qHighlightStr1 = queued[1].dungeon.shortNameLocale
							qHighlightStr2 = "+" .. profile.dungeons[queued[1].index]
						end
						-- try and see if the player is queued to something we got score for on this character
						for i = 1, #queued do
							local q = queued[i]
							local l = profile.dungeons[q.index]
							if profile.maxDungeonName == q.dungeon.shortName then
								if l > 0 then
									qHighlightStrSameAsBest = true
									qHighlightStr1 = q.dungeon.shortNameLocale
									qHighlightStr2 = "+" .. l
									searchLevel = q.level
								end
								break
							end
						end
					end
				end
			end

			if highlightStr then
				-- if highlight is same as what we are queued for (best key) then show it as green color to make it stand out
				if qHighlightStrSameAsBest then
					tooltip:AddDoubleLine(L.BEST_RUN, highlightStr, 0, 1, 0, GetScoreColor(profile.allScore))
				else
					-- show the default best run line (it's the best piece of info we have for the player)
					tooltip:AddDoubleLine(L.BEST_RUN, highlightStr, 1, 1, 1, GetScoreColor(profile.allScore))
					-- if we have a best dungeon level to show that is different than the best run, then show it to provide context
					if qHighlightStr1 then
						tooltip:AddDoubleLine(L.BEST_FOR_DUNGEON, qHighlightStr2 .. " " .. qHighlightStr1, 1, 1, 1, GetScoreColor(profile.allScore))
					end
				end
			end

			if profile.keystoneFifteenPlus > 0 then
				tooltip:AddDoubleLine(L.TIMED_15_RUNS, GetFormattedRunCount(profile.keystoneFifteenPlus), 1, 1, 1, GetScoreColor(profile.allScore))
			end

			if profile.keystoneTenPlus > 0 and (profile.keystoneFifteenPlus == 0 or showExtendedTooltip) then
				tooltip:AddDoubleLine(L.TIMED_10_RUNS, GetFormattedRunCount(profile.keystoneTenPlus), 1, 1, 1, GetScoreColor(profile.allScore))
			end

			-- show tank, healer and dps scores (only when the tooltip is extended)
			if showExtendedTooltip then
				local scores = {}

				if profile.tankScore then
					scores[#scores + 1] = { L.TANK_SCORE, profile.tankScore }
				end

				if profile.healScore then
					scores[#scores + 1] = { L.HEALER_SCORE, profile.healScore }
				end

				if profile.dpsScore then
					scores[#scores + 1] = { L.DPS_SCORE, profile.dpsScore }
				end

				sort(scores, sortRoleScores)

				for i = 1, #scores do
					if scores[i][2] > 0 then
						tooltip:AddDoubleLine(scores[i][1], scores[i][2], 1, 1, 1, GetScoreColor(scores[i][2]))
					end
				end
			end

			if addonConfig.showMainsScore and profile.mainScore > profile.allScore then
				tooltip:AddDoubleLine(L.MAINS_SCORE, profile.mainScore, 1, 1, 1, GetScoreColor(profile.mainScore))
			end

			if focusOnKeystoneLevel or searchLevel then
				AppendAveragePlayerScore(tooltip, focusOnKeystoneLevel or searchLevel)
			end

			if IS_DB_OUTDATED[profile.faction] then
				tooltip:AddLine(format(L.OUTDATED_DATABASE, OUTDATED_DAYS[profile.faction]), 1, 1, 1, false)
			end

			local t = EGG[profile.region]
			if t then
				t = t[profile.realm]
				if t then
					t = t[profile.name]
					if t then
						tooltip:AddLine(t, 0.9, 0.8, 0.5, false)
					end
				end
			end

			tooltip:Show()

			return 1
		else
			if focusOnKeystoneLevel then
				AppendAveragePlayerScore(tooltip, focusOnKeystoneLevel, not forceNoPadding)

				tooltip:Show()
				return 1
			end
		end
	end

	-- triggers a tooltip update of the current visible tooltip
	function UpdateAppendedGameTooltip()
		-- sanity check that the args exist
		if not playerTooltip or not playerTooltip:GetOwner() then return end
		-- unpack the args
		local tooltip = playerTooltip
		local arg1, forceNoPadding, forceAddName, forceFaction, focusOnDungeonIndex, focusOnKeystoneLevel = tooltipArgs[1], tooltipArgs[2], tooltipArgs[3], tooltipArgs[4], tooltipArgs[5], tooltipArgs[6]

		-- units only need to SetUnit to re-draw the tooltip properly
		local _, unit = tooltip:GetUnit()
		if unit then
			tooltip:SetUnit(unit)
			return
		end
		-- gather tooltip information
		local o1, o2, o3, o4 = tooltip:GetOwner()
		local p1, p2, p3, p4, p5 = tooltip:GetPoint(1)
		local a1, a2, a3 = tooltip:GetAnchorType()
		-- try to run the OnEnter handler to simulate the user hovering over and triggering the tooltip
		if o1 then
			local oe = o1:GetScript("OnEnter")
			if oe then
				tooltip:Hide()
				oe(o1)
				return
			end
		end
		-- if nothing else worked, attempt to hide, then show the tooltip again in the same place
		tooltip:Hide()
		if o1 then
			o2 = a1
			if p4 then
				o3 = p4
			end
			if p5 then
				o4 = p5
			end
			tooltip:SetOwner(o1, o2, o3, o4)
		end
		if p1 then
			tooltip:SetPoint(p1, p2, p3, p4, p5)
		end
		if not o1 and a1 then
			tooltip:SetAnchorType(a1, a2, a3)
		end
		-- finalize by appending our tooltip on the bottom
		AppendGameTooltip(tooltip, arg1, forceNoPadding, forceAddName, forceFaction, focusOnDungeonIndex, focusOnKeystoneLevel)
	end

	function AppendAveragePlayerScore(tooltip, keystoneLevel, addBlankLine)
--		if addonConfig.showAverageScore then
		if false then -- Wait that a certain amount of run is recorded before displaying it
			local averageScore = GetAverageScore(keystoneLevel)
			if averageScore then
				if addBlankLine then
					tooltip:AddLine(" ")
				end
				tooltip:AddDoubleLine(format(L.RAIDERIO_AVERAGE_PLAYER_SCORE, keystoneLevel), averageScore, 1, 1, 1, GetScoreColor(averageScore))
			end
		end
	end
end

-- RaiderIO Profile
local ProfileTooltip_Update
do
	-- force can either be "player", "target" or not defined
	-- if force == player then always display player's profile
	-- if force == target then always display the active player tooltip
	-- if force is not defined, then the display depends on the modifier and the configuration
	function ProfileTooltip_Update(force)
		if not profileTooltip or not profileTooltip:GetOwner() then
			return
		end

		local arg1, forceNoPadding, forceAddName, forceFaction, focusOnDungeonIndex, focusOnKeystoneLevel = tooltipArgs[1], tooltipArgs[2], tooltipArgs[3], tooltipArgs[4], tooltipArgs[5], tooltipArgs[6]

		-- force player
		if force == "player" then
			arg1 = "player"
		end

		-- force target
		if force ~= "target" then
			if not arg1 then
				arg1 = "player"
			end

			if not addonConfig.enableProfileModifier then
				arg1 = "player"
			else
				if (not addonConfig.inverseProfileModifier and not addon.modKey) or (addonConfig.inverseProfileModifier and addon.modKey) then
					arg1 = "player"
				end
			end
		end

		local profile = GetScore(arg1, nil, forceFaction)

		-- sanity check that the profile exists
		if not profile then
			return
		end

		profileTooltip:ClearLines()

		if arg1 == "player" then
			profileTooltip:AddLine(L.MY_PROFILE_TITLE, 1, 0.85, 0, false)
		else
			profileTooltip:AddLine(L.PLAYER_PROFILE_TITLE, 1, 0.85, 0, false)
		end

		profileTooltip:AddDoubleLine(profile.name, GetFormattedScore(profile.allScore, profile.isPrevAllScore), 1, 1, 1, GetScoreColor(profile.allScore))

		AddLegionScore(profileTooltip, profile)

		if profile.mainScore > profile.allScore then
			profileTooltip:AddDoubleLine(L.MAINS_SCORE, profile.mainScore, 1, 1, 1, GetScoreColor(profile.mainScore))
		end

		profileTooltip:AddLine(" ")
		profileTooltip:AddLine(L.PROFILE_BEST_RUNS, 1, 0.85, 0, false)

		local dungeons = {}
		for dungeonIndex, keyLevel in ipairs(profile.dungeons) do
			table.insert(dungeons, {
				index = dungeonIndex,
				shortName = CONST_DUNGEONS[dungeonIndex].shortNameLocale,
				keyLevel = keyLevel,
				upgrades = profile.dungeonUpgrades[dungeonIndex] or 0,
				fractionalTime = profile.dungeonTimes[dungeonIndex] or 0
			})
		end

		table.sort(dungeons, CompareDungeon)

		for i, dungeon in ipairs(dungeons) do
			local colorDungeonName = COLOR_WHITE
			local colorDungeonLevel = COLOR_WHITE

			local keyLevel = dungeon.keyLevel
			if keyLevel ~= 0 then
				if profile.isEnhanced then
					if dungeon.upgrades == 0 then
						colorDungeonLevel = COLOR_GREY
					end
					keyLevel = GetStarsForUpgrades(dungeon.upgrades) .. keyLevel
				else
					keyLevel = "+" .. keyLevel
				end
			else
				keyLevel = "-"
				colorDungeonLevel = COLOR_GREY
			end

			if focusOnDungeonIndex and focusOnDungeonIndex == dungeon.index then
--				TODO: Add color depending if it's an upgrade or a downgrade
--				if focusOnKeystoneLevel then
--					if dungeon.keyLevel < focusOnKeystoneLevel  then
--						-- green
--						colorDungeonName = { r = 0.12, g = 1, b = 0 }
--						colorDungeonLevel = { r = 0.12, g = 1, b = 0 }
--					elseif dungeon.keyLevel > focusOnKeystoneLevel then
--						-- purple
--						colorDungeonName = { r = 0.78, g = 0, b = 1 }
--						colorDungeonLevel = { r = 0.78, g = 0, b = 1 }
--					else
--						-- blue
--						colorDungeonName = { r = 0, g = 0.51, b = 1 }
--						colorDungeonLevel = { r = 0, g = 0.51, b = 1 }
--					end
--				else
					colorDungeonName = COLOR_GREEN
					colorDungeonLevel = COLOR_GREEN
--				end
			end

			profileTooltip:AddDoubleLine(dungeon.shortName, keyLevel, colorDungeonName.r, colorDungeonName.g, colorDungeonName.b, colorDungeonLevel.r, colorDungeonLevel.g, colorDungeonLevel.b)
		end

		if OUTDATED_DAYS[profile.faction] > 1 then
			profileTooltip:AddLine(" ")
			profileTooltip:AddLine(format(L.OUTDATED_DATABASE, OUTDATED_DAYS[profile.faction]), 0.8, 0.8, 0.8, false)
		elseif OUTDATED_HOURS[profile.faction] > 12 then
			profileTooltip:AddLine(" ")
			profileTooltip:AddLine(format(L.OUTDATED_DATABASE_HOURS, OUTDATED_HOURS[profile.faction]), 0.8, 0.8, 0.8, false)
		end

		profileTooltip:Show()
	end

	function ProfileTooltip_ShowNearFrame(frame, forceFrameStrata, force)
		if not addonConfig.showRaiderIOProfile then
			return
		end

		profileTooltip:SetOwner(frame, "ANCHOR_NONE")
		profileTooltip:ClearAllPoints()
		profileTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")

		profileTooltip:SetFrameStrata(forceFrameStrata or frame:GetFrameStrata())

		ProfileTooltip_Update(force)
	end

	local function ProfileTooltip_OnDragStop(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint()
		addonConfig.profilePoint = {
			["point"] = point,
			["x"] = x,
			["y"] = y
		}
	end

	function ProfileTooltip_SetFrameDraggability(draggable)
		profileTooltip:SetMovable(draggable)
		profileTooltip:EnableMouse(draggable)

		if draggable then
			profileTooltip:RegisterForDrag("LeftButton")
			profileTooltip:SetScript("OnDragStart", profileTooltip.StartMoving)
			profileTooltip:SetScript("OnDragStop", ProfileTooltip_OnDragStop)
		else
			profileTooltip:RegisterForDrag(nil)
			profileTooltip:SetScript("OnDragStart", nil)
			profileTooltip:SetScript("OnDragStop", nil)
		end
	end
end

-- Guild Best
GuildBestMixin = {}
GuildBestRunMixin = {}
GuildSwitchMixin = {}
SwitchGuildBestMixin = {}
do
	function SwitchGuildBestMixin:OnLoad()
		self.text:SetFontObject("GameFontNormalTiny2")
		self.text:SetText(L["CHECKBOX_DISPLAY_WEEKLY"])
		self.text:SetPoint("LEFT", 15, 0)
		self.text:SetJustifyH("LEFT")
		self:SetSize(15, 15)
	end

	function SwitchGuildBestMixin:OnShow()
		self:SetChecked(addonConfig.displayWeeklyGuildBest)
	end

	function GuildBestMixin:SwitchBestRun()
		addonConfig.displayWeeklyGuildBest = not addonConfig.displayWeeklyGuildBest

		self:SetUp(GetGuildFullname("player"))
	end

	function GuildBestMixin:SetUp(guildFullname)
		local bestRuns = guildBest[guildFullname] or {}

		local keyBest = "season_best"
		local title = L["GUILD_BEST_SEASON"]

		if addonConfig.displayWeeklyGuildBest then
			keyBest = "weekly_best"
			title = L["GUILD_BEST_WEEKLY"]
		end

		self.SubTitle:SetText(title)

		self.bestRuns = (bestRuns and bestRuns[keyBest]) or {};

		self:Reset()

		if not self.bestRuns or #self.bestRuns == 0 then
			self.GuildBestNoRun:Show()
			return
		end

		for i, run in ipairs(self.bestRuns) do
			local frame = self.GuildBests[i]

			if (not frame) then
				frame = CreateFrame("Frame", nil, GuildBestFrame, "GuildBestRunTemplate")

				frame:SetPoint("TOP", self.GuildBests[i-1], "BOTTOM")
			end

			frame:SetUp(run)
			frame:Show()
		end
	end

	function GuildBestMixin:Reset()
		self.GuildBestNoRun:Hide()
		self.GuildBestNoRun.Text:SetText(L["NO_GUILD_RECORD"])
		if self.GuildBests then
			for _, frame in ipairs(self.GuildBests) do
				frame:Hide()
			end
		end
	end

	function GuildBestRunMixin:SetUp(runInfo)
		self.runInfo = runInfo

		self.CharacterName:SetText(GetDungeonWithData("id", self.runInfo.zone_id).shortNameLocale)

		self.Level:SetTextColor(COLOR_WHITE.r, COLOR_WHITE.g, COLOR_WHITE.b)
		if self.runInfo.upgrades == 0 then
			self.Level:SetTextColor(COLOR_GREY.r, COLOR_GREY.g, COLOR_GREY.b)
		end
		self.Level:SetText(GetStarsForUpgrades(self.runInfo.upgrades) .. self.runInfo.level)
	end

	function GuildBestRunMixin:OnEnter()
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");

		GameTooltip:SetText(C_ChallengeMode.GetMapUIInfo(GetDungeonWithData("id", self.runInfo.zone_id).keystone_instance), 1, 1, 1);

		local upgradeStr = ""
		if self.runInfo.upgrades > 0 then
			upgradeStr = " (" .. GetStarsForUpgrades(self.runInfo.upgrades, true) .. ")"
		end

		GameTooltip:AddLine(MYTHIC_PLUS_POWER_LEVEL:format(self.runInfo.level) .. upgradeStr, 1, 1, 1);
		GameTooltip:AddLine(self.runInfo.clear_time, 1, 1, 1);

		if self.runInfo.party then
			GameTooltip:AddLine(" ");

			for i, member in ipairs(self.runInfo.party) do
				if (member.name) then
					local classInfo = C_CreatureInfo.GetClassInfo(member.class_id);
					local color = (classInfo and RAID_CLASS_COLORS[classInfo.classFile]) or NORMAL_FONT_COLOR;
					local texture;
					if (member.role == "tank") then
						texture = CreateAtlasMarkup("roleicon-tiny-tank");
					elseif (member.role == "dps") then
						texture = CreateAtlasMarkup("roleicon-tiny-dps");
					elseif (member.role == "healer") then
						texture = CreateAtlasMarkup("roleicon-tiny-healer");
					end

					GameTooltip:AddLine(MYTHIC_PLUS_LEADER_BOARD_NAME_ICON:format(texture, member.name), color.r, color.g, color.b);
				end
			end
		end

		GameTooltip:Show();
	end
end

-- addon events
do
	-- apply hooks to interface elements
	local function ApplyHooks()
		-- iterate backwards, removing hooks as they complete
		for i = #uiHooks, 1, -1 do
			local func = uiHooks[i]
			-- if the function returns true our hook succeeded, we then remove it from the table
			if func() then
				table.remove(uiHooks, i)
			end
		end
	end

	-- an addon has loaded, is it ours? is it some LOD addon we can hook?
	function addon:ADDON_LOADED(event, name)
		-- the addon savedvariables are loaded and we can initialize the addon
		if name == addonName then
			Init()
		end

		-- apply hooks to interface elements
		ApplyHooks()
	end

	local function updateOutdatedDb(faction, date)
		local year, month, day, hours, minutes, seconds = date:match("^(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+).*Z$")
		-- parse the ISO timestamp to unix time
		local ts = time({ year = year, month = month, day = day, hour = hours, min = minutes, sec = seconds })
		-- calculate the timezone offset between the user and UTC+0
		local offset = GetTimezoneOffset(ts)
		-- find elapsed seconds since database update and account for the timezone offset
		local diff = time() - ts - offset
		-- figure out of the DB is outdated or not by comparing to our threshold
		IS_DB_OUTDATED[faction] = diff >= OUTDATED_SECONDS
		OUTDATED_HOURS[faction] = floor(diff/ 3600 + 0.5);
		OUTDATED_DAYS[faction] = floor(diff / 86400 + 0.5);
	end

	-- we have logged in and character data is available
	function addon:PLAYER_LOGIN()
		-- store our faction for later use
		PLAYER_FACTION = GetFaction("player")
		PLAYER_REGION = GetRegion()

		local firstDataProvider = {}

		-- pick the data provider that suits the players region
		for i = #dataProviderQueue, 1, -1 do
			local data = dataProviderQueue[i]
			-- is this provider relevant?
			if data.region == PLAYER_REGION then
				-- Is the provider up to date ?
				updateOutdatedDb(data.faction, data.date)

				-- append provider to the table
				if dataProvider then
					if (firstDataProvider.region ~= data.region or firstDataProvider.faction ~= data.faction) and firstDataProvider.date ~= data.date then
						-- Warning if the data is out of sync between faction
						DEFAULT_CHAT_FRAME:AddMessage(format(L.OUT_OF_SYNC_DATABASE_S, addonName), 1, 1, 0)
					end

					if not dataProvider.db1 then
						dataProvider.db1 = data.db1
					end
					if not dataProvider.db2 then
						dataProvider.db2 = data.db2
					end
					if not dataProvider.lookup1 then
						dataProvider.lookup1 = data.lookup1
					end
					if not dataProvider.lookup2 then
						dataProvider.lookup2 = data.lookup2
					end
				else
					dataProvider = data
					firstDataProvider = {["date"] = data.date, ["region"] = data.region, ["faction"] = data.faction }

					-- debug.lua needs this for querying (also adding the tooltip bit because for now only these two are needed for debug.lua to function...)
					ns.dataProvider = dataProvider
					ns.AppendGameTooltip = AppendGameTooltip
				end
			else
				-- disable the provider addon from loading in the future
				DisableAddOn(data.name)
				-- wipe the table to free up memory
				wipe(data)
			end
			-- remove reference from the queue
			dataProviderQueue[i] = nil
		end

		if IS_DB_OUTDATED[PLAYER_FACTION] then
			DEFAULT_CHAT_FRAME:AddMessage(format(L.OUTDATED_DATABASE_S, addonName, OUTDATED_DAYS[PLAYER_FACTION]), 1, 1, 0)
		end

		-- hide the provider functions from the public API
		_G.RaiderIO.AddProvider = nil
		_G.RaiderIO.AddClientCharacters = nil
	end

	-- we enter the world (after a loading screen, int/out of instances)
	function addon:PLAYER_ENTERING_WORLD()
		-- we wipe the cached profiles in between loading screens, this seems like a good way get rid of memory use over time
		wipe(profileCache)
	end

	-- modifier key is toggled, update the tooltip if needed
	function addon:MODIFIER_STATE_CHANGED(skipUpdatingTooltip)
		-- if we always draw the full tooltip then this part of the code shouldn't be running at all
		if addonConfig.alwaysExtendTooltip and not addonConfig.enableProfileModifier then
			return
		end
		-- check if the mod state has changed, and only then run the update function
		local m = IsModifierKeyDown()
		local l = addon.modKey
		addon.modKey = m
		if m ~= l and skipUpdatingTooltip ~= true then
			UpdateAppendedGameTooltip()
		end
	end
end

-- ui hooks
do
	-- extract character name and realm from BNet friend
	local function GetNameAndRealmForBNetFriend(bnetIDAccount)
		local index = BNGetFriendIndex(bnetIDAccount)
		if index then
			local numGameAccounts = BNGetNumFriendGameAccounts(index)
			for i = 1, numGameAccounts do
				local _, characterName, client, realmName, _, faction, _, _, _, _, level = BNGetFriendGameAccountInfo(index, i)
				if client == BNET_CLIENT_WOW then
					if realmName then
						characterName = characterName .. "-" .. realmName:gsub("%s+", "")
					end
					return characterName, FACTION[faction], tonumber(level)
				end
			end
		end
	end

	-- copy profile link from dropdown menu
	local function CopyURLForNameAndRealm(...)
		local name, realm = GetNameAndRealm(...)
		local realmSlug = GetRealmSlug(realm)
		local url = format("https://raider.io/characters/%s/%s/%s", PLAYER_REGION, realmSlug, name)
		if IsModifiedClick("CHATLINK") then
			local editBox = ChatFrame_OpenChat(url, DEFAULT_CHAT_FRAME)
			editBox:HighlightText()
		else
			StaticPopup_Show("RAIDERIO_COPY_URL", format("%s (%s)", name, realm), url)
		end
	end

	_G.StaticPopupDialogs["RAIDERIO_COPY_URL"] = {
		text = "%s",
		button2 = CLOSE,
		hasEditBox = true,
		hasWideEditBox = true,
		editBoxWidth = 350,
		preferredIndex = 3,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function(self)
			self:SetWidth(420)
			local editBox = _G[self:GetName() .. "WideEditBox"] or _G[self:GetName() .. "EditBox"]
			editBox:SetText(self.text.text_arg2)
			editBox:SetFocus()
			editBox:HighlightText(false)
			local button = _G[self:GetName() .. "Button2"]
			button:ClearAllPoints()
			button:SetWidth(200)
			button:SetPoint("CENTER", editBox, "CENTER", 0, -30)
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide()
		end,
		OnHide = nil,
		OnAccept = nil,
		OnCancel = nil
	}

	-- GameTooltip
	uiHooks[#uiHooks + 1] = function()
		local function OnTooltipSetUnit(self)
			if not addonConfig.enableUnitTooltips then
				return
			end
			if not addonConfig.showScoreInCombat and InCombatLockdown() then
				return
			end
			-- TODO: summoning portals don't always trigger OnTooltipSetUnit properly, leaving the unit tooltip on the portal object
			local _, unit = self:GetUnit()
			AppendGameTooltip(self, unit, nil, nil, GetFaction(unit), nil)
		end
		GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
		return 1
	end

	-- LFG
	uiHooks[#uiHooks + 1] = function()
		if _G.LFGListApplicationViewerScrollFrameButton1 then
			local hooked = {}
			local OnEnter, OnLeave, ProfileTooltip_OnHide
			-- application queue
			function OnEnter(self)
				if not addonConfig.enableLFGTooltips then
					return
				end
				if self.applicantID and self.Members then
					for i = 1, #self.Members do
						local b = self.Members[i]
						if not hooked[b] then
							hooked[b] = 1
							b:HookScript("OnEnter", OnEnter)
							b:HookScript("OnLeave", OnLeave)
						end
					end
				elseif self.memberIdx then
					local fullName = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)
					if fullName then
						local hasOwner = GameTooltip:GetOwner()
						if not hasOwner then
							GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
						end

						local _, activityID, _, title, description = C_LFGList.GetActiveEntryInfo();
						local keystoneLevel = GetKeystoneLevel(title) or GetKeystoneLevel(description) or 0
						AppendGameTooltip(GameTooltip, fullName, not hasOwner, true, PLAYER_FACTION, LFD_ACTIVITYID_TO_DUNGEONID[activityID], keystoneLevel)

						if addonConfig.positionProfileAuto then
							ProfileTooltip_ShowNearFrame(GameTooltip, nil, "target")
						else
							ProfileTooltip_Update("target")
						end

						if not hooked["applicant"] then
							hooked["applicant"] = 1
							GameTooltip:HookScript("OnHide", ProfileTooltip_OnHide)
						end
					end
				end
			end
			function OnLeave(self)
				if self.applicantID or self.memberIdx then
					GameTooltip:Hide()
				end
			end
			function ProfileTooltip_OnHide(self)
				if PVEFrame:IsShown() then
					if addonConfig.positionProfileAuto then
						ProfileTooltip_ShowNearFrame(PVEFrame, "BACKGROUND")
					else
						ProfileTooltip_Update()
					end
				else
					profileTooltip:Hide()
				end
			end
			-- search results
			local function SetSearchEntryTooltip(tooltip, resultID, autoAcceptOption)
				local _, activityID, title, description, _, _, _, _, _, _, _, _, leaderName = C_LFGList.GetSearchResultInfo(resultID)
				if leaderName then
					local keystoneLevel = GetKeystoneLevel(title) or GetKeystoneLevel(description) or 0

					-- Update game tooltip with player info
					AppendGameTooltip(tooltip, leaderName, false, true, PLAYER_FACTION, LFD_ACTIVITYID_TO_DUNGEONID[activityID], keystoneLevel)

					-- RaiderIO Profile
					if addonConfig.positionProfileAuto then
						ProfileTooltip_ShowNearFrame(tooltip)
					else
						ProfileTooltip_Update()
					end

					if not hooked["applicant"] then
						hooked["applicant"] = 1
						GameTooltip:HookScript("OnHide", ProfileTooltip_OnHide)
					end
				end
			end
			hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntryTooltip)

			-- execute delayed hooks
			for i = 1, 14 do
				local b = _G["LFGListApplicationViewerScrollFrameButton" .. i]
				b:HookScript("OnEnter", OnEnter)
				b:HookScript("OnLeave", OnLeave)
			end
			-- UnempoweredCover blocking removal
			do
				local f = LFGListFrame.ApplicationViewer.UnempoweredCover
				f:EnableMouse(false)
				f:EnableMouseWheel(false)
				f:SetToplevel(false)
			end
			return 1
		end
	end

	-- WhoFrame
	uiHooks[#uiHooks + 1] = function()
		local function OnEnter(self)
			if not addonConfig.enableWhoTooltips then
				return
			end
			if self.whoIndex then
				local name, guild, level, race, class, zone, classFileName = GetWhoInfo(self.whoIndex)
				if name and level and level >= MAX_LEVEL then
					local hasOwner = GameTooltip:GetOwner()
					if not hasOwner then
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
					end
					if not AppendGameTooltip(GameTooltip, name, not hasOwner, true, PLAYER_FACTION, nil) and not hasOwner then
						GameTooltip:Hide()
					end
				end
			end
		end
		local function OnLeave(self)
			if self.whoIndex then
				GameTooltip:Hide()
			end
		end
		for i = 1, 17 do
			local b = _G["WhoFrameButton" .. i]
			b:HookScript("OnEnter", OnEnter)
			b:HookScript("OnLeave", OnLeave)
		end
		return 1
	end

	-- FriendsFrame
	uiHooks[#uiHooks + 1] = function()
		local function OnEnter(self)
			if not addonConfig.enableFriendsTooltips then
				return
			end
			local fullName, faction, level
			if self.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local bnetIDAccount = BNGetFriendInfo(self.id)
				fullName, faction, level = GetNameAndRealmForBNetFriend(bnetIDAccount)
			elseif self.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				fullName, level = GetFriendInfo(self.id)
				faction = PLAYER_FACTION
			end
			if fullName and level and level >= MAX_LEVEL then
				GameTooltip:SetOwner(FriendsTooltip, "ANCHOR_BOTTOMRIGHT", -FriendsTooltip:GetWidth(), -4)
				if not AppendGameTooltip(GameTooltip, fullName, true, true, faction, nil) then
					GameTooltip:Hide()
				end
			else
				GameTooltip:Hide()
			end
		end
		local function FriendTooltip_Hide()
			if not addonConfig.enableFriendsTooltips then
				return
			end
			GameTooltip:Hide()
		end
		local buttons = FriendsFrameFriendsScrollFrame.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			button:HookScript("OnEnter", OnEnter)
		end
		hooksecurefunc("FriendsFrameTooltip_Show", OnEnter)
		hooksecurefunc(FriendsTooltip, "Hide", FriendTooltip_Hide)
		return 1
	end

	-- Blizzard_GuildUI
	uiHooks[#uiHooks + 1] = function()
		if _G.GuildFrame then
			local function OnEnter(self)
				if not addonConfig.enableGuildTooltips then
					return
				end
				if self.guildIndex then
					local fullName, _, _, level = GetGuildRosterInfo(self.guildIndex)
					if fullName and level >= MAX_LEVEL then
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
						if not AppendGameTooltip(GameTooltip, fullName, true, false, PLAYER_FACTION, nil) then
							GameTooltip:Hide()
						end
					end
				end
			end
			local function OnLeave(self)
				if self.guildIndex then
					GameTooltip:Hide()
				end
			end
			for i = 1, 16 do
				local b = _G["GuildRosterContainerButton" .. i]
				b:HookScript("OnEnter", OnEnter)
				b:HookScript("OnLeave", OnLeave)
			end
			return 1
		end
	end

	-- Blizzard_Communities
	uiHooks[#uiHooks + 1] = function()
		if _G.CommunitiesFrame then
			local function OnEnter(self)
				if not addonConfig.enableGuildTooltips then
					return
				end
				local info = self:GetMemberInfo()
				if not info or (info.clubType ~= Enum.ClubType.Guild and info.clubType ~= Enum.ClubType.Character) then
					return
				end
				if info.name and (info.level or MAX_LEVEL) >= MAX_LEVEL then
					local hasOwner = GameTooltip:GetOwner()
					if not hasOwner then
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
					end
					if not AppendGameTooltip(GameTooltip, info.name, not hasOwner, nil, PLAYER_FACTION, nil) and not hasOwner then
						GameTooltip:Hide()
					end
				end
			end
			local function OnLeave(self)
				GameTooltip:Hide()
			end
			for _, b in pairs(CommunitiesFrame.MemberList.ListScrollFrame.buttons) do
				b:HookScript("OnEnter", OnEnter)
				b:HookScript("OnLeave", OnLeave)
			end
			return 1
		end
	end

	-- ChatFrame (Who Results)
	uiHooks[#uiHooks + 1] = function()
		local function pattern(pattern)
			pattern = pattern:gsub("%%", "%%%%")
			pattern = pattern:gsub("%.", "%%%.")
			pattern = pattern:gsub("%?", "%%%?")
			pattern = pattern:gsub("%+", "%%%+")
			pattern = pattern:gsub("%-", "%%%-")
			pattern = pattern:gsub("%(", "%%%(")
			pattern = pattern:gsub("%)", "%%%)")
			pattern = pattern:gsub("%[", "%%%[")
			pattern = pattern:gsub("%]", "%%%]")
			pattern = pattern:gsub("%%%%s", "(.-)")
			pattern = pattern:gsub("%%%%d", "(%%d+)")
			pattern = pattern:gsub("%%%%%%[%d%.%,]+f", "([%%d%%.%%,]+)")
			return pattern
		end
		local function sortRoleScores(a, b)
			return a[2] > b[2]
		end
		local FORMAT_GUILD = "^" .. pattern(WHO_LIST_GUILD_FORMAT) .. "$"
		local FORMAT = "^" .. pattern(WHO_LIST_FORMAT) .. "$"
		local nameLink, name, level, race, class, guild, zone
		local repl, text, profile
		local function score(profile)
			text = ""

			if profile.allScore > 0 then
				text = text .. (L.RAIDERIO_MP_SCORE_COLON):gsub("%.", "|cffFFFFFF|r.") .. GetFormattedScore(profile.allScore, profile.isPrevAllScore) .. ". "
			end

			-- show the mains season score
			if addonConfig.showMainsScore and profile.mainScore > profile.allScore then
				text = text .. "(" .. L.MAINS_SCORE_COLON .. profile.mainScore .. "). "
			end

			-- show tank, healer and dps scores
			local scores = {}

			if profile.tankScore then
				scores[#scores + 1] = { L.TANK, profile.tankScore }
			end

			if profile.healScore then
				scores[#scores + 1] = { L.HEALER, profile.healScore }
			end

			if profile.dpsScore then
				scores[#scores + 1] = { L.DPS, profile.dpsScore }
			end

			sort(scores, sortRoleScores)

			for i = 1, #scores do
				if scores[i][2] > 0 then
					if i > 1 then
						text = text .. ", "
					end
					text = text .. scores[i][1] .. ": " .. scores[i][2]
				end
			end

			return text
		end
		local function filter(self, event, text, ...)
			if addonConfig.enableWhoMessages and event == "CHAT_MSG_SYSTEM" then
				nameLink, name, level, race, class, guild, zone = text:match(FORMAT_GUILD)
				if not zone then
					guild = nil
					nameLink, name, level, race, class, zone = text:match(FORMAT)
				end
				if level then
					level = tonumber(level) or 0
					if level >= MAX_LEVEL then
						if guild then
							repl = format(WHO_LIST_GUILD_FORMAT, nameLink, name, level, race, class, guild, zone)
						else
							repl = format(WHO_LIST_FORMAT, nameLink, name, level, race, class, zone)
						end
						profile = GetScore(nameLink, nil, PLAYER_FACTION)
						if profile then
							repl = repl .. " - " .. score(profile)
						end
						return false, repl, ...
					end
				end
			end
			return false
		end
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", filter)
		return 1
	end

	-- DropDownMenu (Units and LFD)
	uiHooks[#uiHooks + 1] = function()
		local function CanCopyURL(which, unit, name, bnetIDAccount)
			if UnitExists(unit) then
				return UnitIsPlayer(unit) and UnitLevel(unit) >= MAX_LEVEL,
					GetUnitName(unit, true) or name,
					"UNIT"
			elseif which and which:find("^BN_") then
				local charName, charFaction, charLevel
				if bnetIDAccount then
					charName, charFaction, charLevel = GetNameAndRealmForBNetFriend(bnetIDAccount)
				end
				return charName and charLevel and charLevel >= MAX_LEVEL,
					bnetIDAccount,
					"BN",
					charName,
					charFaction
			elseif name then
				return true,
					name,
					"NAME"
			end
			return false
		end
		local function ShowCopyURLPopup(kind, query, bnetChar, bnetFaction)
			CopyURLForNameAndRealm(bnetChar or query)
		end
		-- TODO: figure out the type of menus we don't really need to show our copy link button
		local supportedTypes = {
			-- SELF = 1, -- do we really need this? can always target self anywhere else and copy our own url
			PARTY = 1,
			PLAYER = 1,
			RAID_PLAYER = 1,
			RAID = 1,
			FRIEND = 1,
			BN_FRIEND = 1,
			GUILD = 1,
			GUILD_OFFLINE = 1,
			CHAT_ROSTER = 1,
			TARGET = 1,
			ARENAENEMY = 1,
			FOCUS = 1,
			WORLD_STATE_SCORE = 1,
			COMMUNITIES_WOW_MEMBER = 1,
			COMMUNITIES_GUILD_MEMBER = 1,
			SELF = 1
		}
		local OFFSET_BETWEEN = -5 -- default UI makes this offset look nice
		local reskinDropDownList
		do
			local addons = {
				{ -- Aurora
					name = "Aurora",
					func = function(list)
						local F = _G.Aurora[1]
						local menu = _G[list:GetName() .. "MenuBackdrop"]
						local backdrop = _G[list:GetName() .. "Backdrop"]
						if not backdrop.reskinned then
							F.CreateBD(menu)
							F.CreateBD(backdrop)
							backdrop.reskinned = true
						end
						OFFSET_BETWEEN = -1 -- need no gaps so the frames align with this addon
						return 1
					end
				},
			}
			local skinned = {}
			function reskinDropDownList(list)
				if skinned[list] then
					return skinned[list]
				end
				for i = 1, #addons do
					local addon = addons[i]
					if IsAddOnLoaded(addon.name) then
						skinned[list] = addon.func(list)
						break
					end
				end
			end
		end
		local custom
		do
			local function CopyOnClick()
				ShowCopyURLPopup(custom.kind, custom.query, custom.bnetChar, custom.bnetFaction)
			end
			local function UpdateCopyButton()
				local copy = custom.copy
				local copyName = copy:GetName()
				local text = _G[copyName .. "NormalText"]
				text:SetText(L.COPY_RAIDERIO_PROFILE_URL)
				text:Show()
				copy:SetScript("OnClick", CopyOnClick)
				copy:Show()
			end
			local function CustomOnEnter(self) -- UIDropDownMenuTemplates.xml#248
				UIDropDownMenu_StopCounting(self:GetParent()) -- TODO: this might taint and break like before, but let's try it and observe
			end
			local function CustomOnLeave(self) -- UIDropDownMenuTemplates.xml#251
				UIDropDownMenu_StartCounting(self:GetParent()) -- TODO: this might taint and break like before, but let's try it and observe
			end
			local function CustomOnShow(self) -- UIDropDownMenuTemplates.xml#257
				local p = self:GetParent() or self
				local w = p:GetWidth()
				local h = 32
				for i = 1, #self.buttons do
					local b = self.buttons[i]
					if b:IsShown() then
						b:SetWidth(w - 32) -- anchor offsets for left/right
						h = h + 16
					end
				end
				self:SetHeight(h)
			end
			local function CustomButtonOnEnter(self) -- UIDropDownMenuTemplates.xml#155
				_G[self:GetName() .. "Highlight"]:Show()
				CustomOnEnter(self:GetParent())
			end
			local function CustomButtonOnLeave(self) -- UIDropDownMenuTemplates.xml#178
				_G[self:GetName() .. "Highlight"]:Hide()
				CustomOnLeave(self:GetParent())
			end
			custom = CreateFrame("Button", addonName .. "CustomDropDownList", UIParent, "UIDropDownListTemplate")
			custom:Hide()
			-- attempt to reskin using popular frameworks
			-- skinType = nil : not skinned
			-- skinType = 1 : skinned, apply further visual modifications (the addon does a good job, but we need to iron out some issues)
			-- skinType = 2 : skinned, no need to apply further visual modifications (the addon handles it flawlessly)
			local skinType = reskinDropDownList(custom)
			-- cleanup and modify the default template
			do
				custom:SetScript("OnClick", nil)
				custom:SetScript("OnEnter", CustomOnEnter)
				custom:SetScript("OnLeave", CustomOnLeave)
				custom:SetScript("OnUpdate", nil)
				custom:SetScript("OnShow", CustomOnShow)
				custom:SetScript("OnHide", nil)
				_G[custom:GetName() .. "Backdrop"]:Hide()
				custom.buttons = {}
				for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
					local b = _G[custom:GetName() .. "Button" .. i]
					if not b then
						break
					end
					custom.buttons[i] = b
					b:Hide()
					b:SetScript("OnClick", nil)
					b:SetScript("OnEnter", CustomButtonOnEnter)
					b:SetScript("OnLeave", CustomButtonOnLeave)
					b:SetScript("OnEnable", nil)
					b:SetScript("OnDisable", nil)
					b:SetPoint("TOPLEFT", custom, "TOPLEFT", 16, -16 * i)
					local t = _G[b:GetName() .. "NormalText"]
					t:ClearAllPoints()
					t:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
					t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
					_G[b:GetName() .. "Check"]:SetAlpha(0)
					_G[b:GetName() .. "UnCheck"]:SetAlpha(0)
					_G[b:GetName() .. "Icon"]:SetAlpha(0)
					_G[b:GetName() .. "ColorSwatch"]:SetAlpha(0)
					_G[b:GetName() .. "ExpandArrow"]:SetAlpha(0)
					_G[b:GetName() .. "InvisibleButton"]:SetAlpha(0)
				end
				custom.copy = custom.buttons[1]
				UpdateCopyButton()
			end
		end
		local function ShowCustomDropDown(list, dropdown, name, unit, which, bnetIDAccount)
			local show, query, kind, bnetChar, bnetFaction = CanCopyURL(which, unit, name, bnetIDAccount)
			if not show then
				return custom:Hide()
			end
			-- assign data for use with the copy function
			custom.query = query
			custom.kind = kind
			custom.bnetChar = bnetChar
			custom.bnetFaction = bnetFaction
			-- set positioning under the active dropdown
			custom:SetParent(list)
			custom:SetFrameStrata(list:GetFrameStrata())
			custom:SetFrameLevel(list:GetFrameLevel() + 2)
			custom:ClearAllPoints()
			if list:GetBottom() >= 50 then
				custom:SetPoint("TOPLEFT", list, "BOTTOMLEFT", 0, OFFSET_BETWEEN)
				custom:SetPoint("TOPRIGHT", list, "BOTTOMRIGHT", 0, OFFSET_BETWEEN)
			else
				custom:SetPoint("BOTTOMLEFT", list, "TOPLEFT", 0, OFFSET_BETWEEN)
				custom:SetPoint("BOTTOMRIGHT", list, "TOPRIGHT", 0, OFFSET_BETWEEN)
			end
			custom:Show()
		end
		local function HideCustomDropDown()
			custom:Hide()
		end
		local function OnShow(self)
			local dropdown = self.dropdown
			if not dropdown then
				return
			end
			if dropdown.Button == _G.LFGListFrameDropDownButton then -- LFD
				if addonConfig.enableLFGDropdown then
					ShowCustomDropDown(self, dropdown, dropdown.menuList[2].arg1)
				end
			elseif dropdown.which and supportedTypes[dropdown.which] then -- UnitPopup
				if addonConfig.showDropDownCopyURL then
					local dropdownFullName
					if dropdown.name then
						if dropdown.server and not dropdown.name:find('-') then
							dropdownFullName = dropdown.name .. '-' .. dropdown.server
						else
							dropdownFullName = dropdown.name
						end
					end
					ShowCustomDropDown(self, dropdown, dropdown.chatTarget or dropdownFullName, dropdown.unit, dropdown.which, dropdown.bnetIDAccount)
				end
			end
		end
		local function OnHide()
			HideCustomDropDown()
		end
		DropDownList1:HookScript("OnShow", OnShow)
		DropDownList1:HookScript("OnHide", OnHide)
		return 1
	end

	-- Keystone Info
	uiHooks[#uiHooks + 1] = function()
		local function OnSetItem(tooltip)
			if not addonConfig.enableKeystoneTooltips then
				return
			end
			local _, link = tooltip:GetItem()
			if type(link) ~= "string" then
				return
			end

			local patterns = {
				"keystone:%d+:(%d+):(%d+):(%d+):(%d+):(%d+)",
				"item:138019:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:(%d+):(%d+):(%d+):(%d+):(%d+)",
				"item:158923:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:.-:(%d+):(%d+):(%d+):(%d+):(%d+)",
			};

			local inst, lvl, a1, a2, a3;
			for _, pattern in ipairs(patterns) do
				inst, lvl, a1, a2, a3 = link:match(pattern)

				if lvl and (tonumber(lvl) or 100) < 100 then
					break
				end
			end

			if not lvl then
				return
			end

			lvl = tonumber(lvl) or 0
			local baseScore = KEYSTONE_LEVEL_TO_BASE_SCORE[lvl]
			if not baseScore then
				return
			end
			tooltip:AddLine(" ")
			tooltip:AddDoubleLine(L.RAIDERIO_MP_BASE_SCORE, baseScore, 1, 0.85, 0, 1, 1, 1)

			AppendAveragePlayerScore(tooltip, lvl)

			inst = tonumber(inst)
			if inst then
				local index = KEYSTONE_INST_TO_DUNGEONID[inst]
				if index then
					local n = GetNumGroupMembers()
					if n <= 5 then -- let's show score only if we are in a 5 man group/raid
						for i = 0, n do
							local unit = i == 0 and "player" or "party" .. i
							local profile = GetScore(unit)
							if profile then
								local level = profile.dungeons[index]
								if level > 0 then
									-- TODO: sort these by dungeon level, descending
									local dungeonName = CONST_DUNGEONS[index] and " " .. CONST_DUNGEONS[index].shortNameLocale or ""
									tooltip:AddDoubleLine(UnitName(unit), "+" .. level .. dungeonName, 1, 1, 1, 1, 1, 1)
								end
							end
						end
					end
				end
			end
			tooltip:Show()
		end
		GameTooltip:HookScript("OnTooltipSetItem", OnSetItem)
		ItemRefTooltip:HookScript("OnTooltipSetItem", OnSetItem)
		return 1
	end

	-- My Profile
	uiHooks[#uiHooks + 1] = function()
		if not addonConfig.showRaiderIOProfile then
			return 1
		end

		local function ProfileTooltip_Show()
			if not profileTooltip:IsShown() then
				ProfileTooltip_ShowNearFrame(PVEFrame, "BACKGROUND", "player")

				if not addonConfig.positionProfileAuto then
					if addonConfig.profilePoint.point ~= nil then
						profileTooltip:ClearAllPoints()
						profileTooltip:SetPoint(addonConfig.profilePoint.point, nil, addonConfig.profilePoint.point, addonConfig.profilePoint.x, addonConfig.profilePoint.y)
					end

					if not addonConfig.lockProfile then
						ProfileTooltip_SetFrameDraggability(true)
					end
				end
			end
		end

		local function ProfileTooltip_Hide()
			profileTooltip:Hide()
		end

		hooksecurefunc(PVEFrame, "Show", ProfileTooltip_Show)
		hooksecurefunc(PVEFrame, "Hide", ProfileTooltip_Hide)
		return 1
	end

	-- Guild Weekly Best
	uiHooks[#uiHooks + 1] = function()
		if not addonConfig.showClientGuildBest or not guildProviderCalled then
			return 1
		end

		if _G.ChallengesFrame then
			local function GuildBest_Show()
				GuildBestFrame:ClearAllPoints()
				GuildBestFrame:SetFrameStrata("HIGH")

				local guildFullname = GetGuildFullname("player")

				if not guildFullname then
					return
				end

				GuildBestFrame:SetUp(guildFullname)

				GuildBestFrame:SetPoint("BOTTOMRIGHT", ChallengesFrame.DungeonIcons[#ChallengesFrame.DungeonIcons], "TOPRIGHT")
				GuildBestFrame:Show()
			end

			local function GuildBest_Hide()
				GuildBestFrame:Hide()
			end

			hooksecurefunc(ChallengesFrame, "Show", GuildBest_Show)
			hooksecurefunc(ChallengesFrame, "Hide", GuildBest_Hide)
			hooksecurefunc(PVEFrame, "Hide", GuildBest_Hide)

			return 1
		end
	end
end

-- API
_G.RaiderIO = {
	-- Calling GetProfile requires either a unit, or you to provide a name and realm, optionally also a faction. (1 = Alliance, 2 = Horde)
	-- RaiderIO.GetProfile(unit)
	-- RaiderIO.GetProfile("Name-Realm"[, nil, 1|2])
	-- RaiderIO.GetProfile("Name", "Realm"[, 1|2])
	GetProfile = GetScore,
	-- Calling GetFaction requires a unit and returns you 1 if it's Alliance, 2 if Horde, otherwise nil.
	-- Calling GetScoreColor requires a Mythic+ score to be passed (a number value) and it returns r, g, b for that score.
	-- RaiderIO.GetScoreColor(1234)
	GetScoreColor = GetScoreColor,

	-- DEPRECATED
	GetScore = GetScore,
}

-- PLEASE DO NOT USE (we need it public for the sake of the database modules)
_G.RaiderIO.AddProvider = AddProvider
_G.RaiderIO.AddClientCharacters = AddClientCharacters
_G.RaiderIO.AddClientGuilds = AddClientGuilds

-- register events and wait for the addon load event to fire
addon:SetScript("OnEvent", function(_, event, ...) addon[event](addon, event, ...) end)
addon:RegisterEvent("ADDON_LOADED")

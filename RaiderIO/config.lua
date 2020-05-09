local addonName, ns = ...

-- constants
local L = ns.L

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
	mplusHeadlineMode = 1,
	useEnglishAbbreviations = false,
	showMainsScore = true,
	showMainBestScore = true,
	showDropDownCopyURL = true,
	showSimpleScoreColors = false,
	showScoreInCombat = true,
	disableScoreColors = false,
	enableClientEnhancements = true,
	showClientGuildBest = true,
	displayWeeklyGuildBest = false,
	showRaiderIOProfile = true,
	hidePersonalRaiderIOProfile = false,
	showRaidEncountersInProfile = true,
	enableProfileModifier = true,
	inverseProfileModifier = false,
	positionProfileAuto = true,
	lockProfile = false,
	showRoleIcons = true,
	profilePoint = { point = nil, x = 0, y = 0 },
	debugMode = false,
}

-- namespace config reference
ns.addonConfig = addonConfig

-- addon config and interface
local Init
do
	local HasConfigUI

	-- Print map info
	local function PrintMaps()
		for i = 1, #ns.dungeons do
			local dgn = ns.dungeons[i]
			local _, _, dungeonSeconds = C_ChallengeMode.GetMapUIInfo(dgn.keystone_instance)
			DEFAULT_CHAT_FRAME:AddMessage(format("%s: %d minutes", dgn.shortName, dungeonSeconds / 60))
		end
	end

	-- update local reference to the correct savedvariable table
	local function UpdateVar()
		if type(_G.RaiderIO_Config) ~= "table" then
			_G.RaiderIO_Config = {}
		end
		-- update namespace reference
		ns.addonConfig = _G.RaiderIO_Config
		-- set metatable with fallback to default config for missing values
		setmetatable(ns.addonConfig, {
			__index = function(_, key)
				return addonConfig[key]
			end
		})
	end

	-- addon config is loaded so we can build the config frame
	local function InitConfig()
		if HasConfigUI then return end
		HasConfigUI = true

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

		local configParentFrame = CreateFrame("Frame", nil, UIParent)
		configParentFrame:SetSize(400, 600)
		configParentFrame:SetPoint("CENTER")

		local configHeaderFrame = CreateFrame("Frame", nil, configParentFrame)
		configHeaderFrame:SetPoint("TOPLEFT", 00, -30)
		configHeaderFrame:SetPoint("TOPRIGHT", 00, 30)
		configHeaderFrame:SetHeight(40)

		local configScrollFrame = CreateFrame("ScrollFrame", nil, configParentFrame)
		configScrollFrame:SetPoint("TOPLEFT", configHeaderFrame, "BOTTOMLEFT")
		configScrollFrame:SetPoint("TOPRIGHT", configHeaderFrame, "BOTTOMRIGHT")
		configScrollFrame:SetHeight(475)
		configScrollFrame:EnableMouseWheel(true)
		configScrollFrame:SetClampedToScreen(true);
		configScrollFrame:SetClipsChildren(true);

		local configButtonFrame = CreateFrame("Frame", nil, configParentFrame)
		configButtonFrame:SetPoint("TOPLEFT", configScrollFrame, "BOTTOMLEFT", 0, -10)
		configButtonFrame:SetPoint("TOPRIGHT", configScrollFrame, "BOTTOMRIGHT")
		configButtonFrame:SetHeight(50)

		configParentFrame.scrollframe = configScrollFrame

		local configSliderFrame = CreateFrame("Slider", nil, configScrollFrame, "UIPanelScrollBarTemplate")
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

		configScrollFrame:HookScript("OnMouseWheel", function(self, delta)
			local currentValue = configSliderFrame:GetValue()
			local changes = -delta * 20
			configSliderFrame:SetValue(currentValue + changes)
		end)

		configParentFrame.scrollbar = configSliderFrame

		local configFrame = CreateFrame("Frame", nil, configScrollFrame)
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
				local enabled = ns.addonConfig[f.cvar]
				ns.addonConfig[f.cvar] = not not checked
				if ((not enabled and checked) or (enabled and not checked)) then
					if f.needReload then
						reload = 1
					end
					if f.callback then
						f.callback()
					end
				end
			end

			for cvar in pairs(config.radios) do
				local radios = config.radios[cvar]
				for i = 1, #radios do
					local f = radios[i]
					local checked = f.checkButton:GetChecked()
					local currentValue = ns.addonConfig[f.cvar]

					if checked then
						ns.addonConfig[f.cvar] = f.valueRadio

						if currentValue ~= f.valueRadio and f.needReload then
							reload = 1
						end
					end
				end
			end
			if reload then
				StaticPopup_Show("RAIDERIO_RELOADUI_CONFIRM")
			end
			ns.FlushTooltipCache()
			ns.PROFILE_UI.SaveConfig()
		end

		config = {
			modules = {},
			options = {},
			radios = {},
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
				f.checkButton:SetChecked(ns.addonConfig[f.cvar] ~= false)
			end
			for cvar in pairs(self.radios) do
				local radios = config.radios[cvar]
				for i = 1, #radios do
					local f = radios[i]

					f.checkButton:SetChecked(f.valueRadio == ns.addonConfig[f.cvar])
				end
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

		function config.CreateToggle(self, label, description, cvar, config)
			local frame = self:CreateWidget("Frame")
			frame.text:SetText(label)
			frame.tooltip = description
			frame.cvar = cvar
			frame.needReload = (config and config.needReload) or false
			frame.callback = (config and config.callback) or nil
			frame.help.tooltip = description
			frame.help:Show()
			frame.checkButton:Show()

			return frame
		end

		function config.CreateOptionToggle(self, label, description, cvar, config)
			local frame = self:CreateToggle(label, description, cvar, config)
			self.options[#self.options + 1] = frame
			return frame
		end

		function config.CreateRadioToggle(self, label, description, cvar, value, config)
			local frame = self:CreateToggle(label, description, cvar, config)

			frame.valueRadio = value

			if self.radios[cvar] == nil then
				self.radios[cvar] = {}
			end

			self.radios[cvar][#self.radios[cvar] +1] = frame

			frame.checkButton:SetScript("OnClick", function ()
				-- Disable unchecking radio (to avoid having nothing chosen)
				if not frame.checkButton:GetChecked() then
					frame.checkButton:SetChecked(true)
				end

				-- Uncheck every other radio for same cvar
				for i = 1, #self.radios[cvar] do
					local f = self.radios[cvar][i]
					if f.valueRadio ~= frame.valueRadio then
						f.checkButton:SetChecked(false)
					end
				end
			end)
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

			config:CreateHeadline(L.CHOOSE_HEADLINE_HEADER)
			config:CreateRadioToggle(L.SHOW_BEST_SEASON, L.SHOW_BEST_SEASON_DESC, "mplusHeadlineMode", 1)
			config:CreateRadioToggle(L.SHOW_CURRENT_SEASON, L.SHOW_CURRENT_SEASON_DESC, "mplusHeadlineMode", 0)
			config:CreateRadioToggle(L.SHOW_BEST_RUN, L.SHOW_BEST_RUN_DESC, "mplusHeadlineMode", 2)

			config:CreatePadding()
			config:CreateHeadline(L.GENERAL_TOOLTIP_OPTIONS)
			config:CreateOptionToggle(L.SHOW_MAINS_SCORE, L.SHOW_MAINS_SCORE_DESC, "showMainsScore")
			config:CreateOptionToggle(L.SHOW_BEST_MAINS_SCORE, L.SHOW_BEST_MAINS_SCORE_DESC, "showMainBestScore")
			config:CreateOptionToggle(L.SHOW_ROLE_ICONS, L.SHOW_ROLE_ICONS_DESC, "showRoleIcons")
			config:CreateOptionToggle(L.ENABLE_SIMPLE_SCORE_COLORS, L.ENABLE_SIMPLE_SCORE_COLORS_DESC, "showSimpleScoreColors")
			config:CreateOptionToggle(L.ENABLE_NO_SCORE_COLORS, L.ENABLE_NO_SCORE_COLORS_DESC, "disableScoreColors")
			config:CreateOptionToggle(L.SHOW_KEYSTONE_INFO, L.SHOW_KEYSTONE_INFO_DESC, "enableKeystoneTooltips")
			config:CreateOptionToggle(L.SHOW_AVERAGE_PLAYER_SCORE_INFO, L.SHOW_AVERAGE_PLAYER_SCORE_INFO_DESC, "showAverageScore")
			config:CreateOptionToggle(L.SHOW_SCORE_IN_COMBAT, L.SHOW_SCORE_IN_COMBAT_DESC, "showScoreInCombat")
			config:CreateOptionToggle(L.USE_ENGLISH_ABBREVIATION, L.USE_ENGLISH_ABBREVIATION_DESC, "useEnglishAbbreviations", {
				callback = function() ns.UpdateConstDungeon() end
			})

			config:CreatePadding()
			config:CreateHeadline(L.CONFIG_WHERE_TO_SHOW_TOOLTIPS)
			config:CreateOptionToggle(L.SHOW_ON_PLAYER_UNITS, L.SHOW_ON_PLAYER_UNITS_DESC, "enableUnitTooltips")
			config:CreateOptionToggle(L.SHOW_IN_LFD, L.SHOW_IN_LFD_DESC, "enableLFGTooltips")
			config:CreateOptionToggle(L.SHOW_IN_FRIENDS, L.SHOW_IN_FRIENDS_DESC, "enableFriendsTooltips")
			config:CreateOptionToggle(L.SHOW_ON_GUILD_ROSTER, L.SHOW_ON_GUILD_ROSTER_DESC, "enableGuildTooltips")
			config:CreateOptionToggle(L.SHOW_IN_WHO_UI, L.SHOW_IN_WHO_UI_DESC, "enableWhoTooltips")
			config:CreateOptionToggle(L.SHOW_IN_SLASH_WHO_RESULTS, L.SHOW_IN_SLASH_WHO_RESULTS_DESC, "enableWhoMessages")

			config:CreatePadding()
			config:CreateHeadline(L.TOOLTIP_PROFILE)
			config:CreateOptionToggle(L.SHOW_RAIDERIO_PROFILE, L.SHOW_RAIDERIO_PROFILE_DESC, "showRaiderIOProfile")
			config:CreateOptionToggle(L.HIDE_OWN_PROFILE, L.HIDE_OWN_PROFILE_DESC, "hidePersonalRaiderIOProfile")
			config:CreateOptionToggle(L.SHOW_RAID_ENCOUNTERS_IN_PROFILE, L.SHOW_RAID_ENCOUNTERS_IN_PROFILE_DESC, "showRaidEncountersInProfile")
			config:CreateOptionToggle(L.SHOW_LEADER_PROFILE, L.SHOW_LEADER_PROFILE_DESC, "enableProfileModifier")
			config:CreateOptionToggle(L.INVERSE_PROFILE_MODIFIER, L.INVERSE_PROFILE_MODIFIER_DESC, "inverseProfileModifier")
			config:CreateOptionToggle(L.ENABLE_AUTO_FRAME_POSITION, L.ENABLE_AUTO_FRAME_POSITION_DESC, "positionProfileAuto")
			config:CreateOptionToggle(L.ENABLE_LOCK_PROFILE_FRAME, L.ENABLE_LOCK_PROFILE_FRAME_DESC, "lockProfile")

			config:CreatePadding()
			config:CreateHeadline(L.RAIDERIO_CLIENT_CUSTOMIZATION)
			config:CreateOptionToggle(L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS, L.ENABLE_RAIDERIO_CLIENT_ENHANCEMENTS_DESC, "enableClientEnhancements", { needReload = true })
			config:CreateOptionToggle(L.SHOW_CLIENT_GUILD_BEST, L.SHOW_CLIENT_GUILD_BEST_DESC, "showClientGuildBest")

			config:CreatePadding()
			config:CreateHeadline(L.COPY_RAIDERIO_PROFILE_URL)
			config:CreateOptionToggle(L.ALLOW_ON_PLAYER_UNITS, L.ALLOW_ON_PLAYER_UNITS_DESC, "showDropDownCopyURL")
			config:CreateOptionToggle(L.ALLOW_IN_LFD, L.ALLOW_IN_LFD_DESC, "enableLFGDropdown")

			local factionHeaderModules = {}
			config:CreatePadding()
			config:CreateHeadline(L.MYTHIC_PLUS_DB_MODULES)
			factionHeaderModules[#factionHeaderModules + 1] = config:CreateModuleToggle(L.MODULE_AMERICAS, "RaiderIO_DB_US_A", "RaiderIO_DB_US_H")
			config:CreateModuleToggle(L.MODULE_EUROPE, "RaiderIO_DB_EU_A", "RaiderIO_DB_EU_H")
			config:CreateModuleToggle(L.MODULE_KOREA, "RaiderIO_DB_KR_A", "RaiderIO_DB_KR_H")
			config:CreateModuleToggle(L.MODULE_TAIWAN, "RaiderIO_DB_TW_A", "RaiderIO_DB_TW_H")

			config:CreatePadding()
			config:CreateHeadline(L.RAIDING_DB_MODULES)
			factionHeaderModules[#factionHeaderModules + 1] = config:CreateModuleToggle(L.MODULE_AMERICAS, "RaiderIO_DB_US_A_R", "RaiderIO_DB_US_H_R")
			config:CreateModuleToggle(L.MODULE_EUROPE, "RaiderIO_DB_EU_A_R", "RaiderIO_DB_EU_H_R")
			config:CreateModuleToggle(L.MODULE_KOREA, "RaiderIO_DB_KR_A_R", "RaiderIO_DB_KR_H_R")
			config:CreateModuleToggle(L.MODULE_TAIWAN, "RaiderIO_DB_TW_A_R", "RaiderIO_DB_TW_H_R")

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
			local height = 70
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
					maxWidth = math.max(maxWidth, option.text:GetStringWidth())
				end
			end
			configFrame:SetWidth(160 + maxWidth)
			configParentFrame:SetWidth(160 + maxWidth)

			-- add faction headers over the first module
			for i = 1, #factionHeaderModules do
				local module = factionHeaderModules[i]
				local af = config:CreateHeadline("|TInterface\\Icons\\inv_bannerpvp_02:0:0:0:0:16:16:4:12:4:12|t")
				af:ClearAllPoints()
				af:SetPoint("BOTTOM", module.checkButton2, "TOP", 2, -5)
				af:SetSize(32, 32)

				local hf = config:CreateHeadline("|TInterface\\Icons\\inv_bannerpvp_01:0:0:0:0:16:16:4:12:4:12|t")
				hf:ClearAllPoints()
				hf:SetPoint("BOTTOM", module.checkButton, "TOP", 2, -5)
				hf:SetSize(32, 32)
			end
		end

		-- add the category and a shortcut button in the interface panel options
		do
			local function Button_OnClick()
				if not InCombatLockdown() then
					configParentFrame:SetShown(not configParentFrame:IsShown())
				end
			end

			local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
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

			_G.StaticPopupDialogs["RAIDERIO_DEBUG_CONFIRM"] = {
				text = ns.addonConfig.debugMode and L.DISABLE_DEBUG_MODE_RELOAD or L.ENABLE_DEBUG_MODE_RELOAD,
				button1 = L.CONFIRM,
				button2 = L.CANCEL,
				hasEditBox = false,
				preferredIndex = 3,
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				OnShow = nil,
				OnHide = nil,
				OnAccept = function ()
					ns.addonConfig.debugMode = not ns.addonConfig.debugMode
					ReloadUI()
				end,
				OnCancel = nil
			}

			local function handler(text)
				if type(text) == "string" then

					-- if the keyword "lock" is present in the command we toggle lock behavior on profile frame
					if text:find("[Ll][Oo][Cc][Kk]") then
						ns.PROFILE_UI.ToggleLock()
						return
					end

					-- if the keyword "debug" is present in the command we toggle debug behavior
					if text:find("[Dd][Ee][Bb][Uu][Gg]") then
						StaticPopup_Show("RAIDERIO_DEBUG_CONFIRM")
						return
					end

					-- if the keyword "search" is present in the command we show the query dialog
					local searchQuery = text:match("[Ss][Ee][Aa][Rr][Cc][Hh]%s*(.-)$")
					if searchQuery then
						if not ns.SEARCH_UI and ns.SEARCH_INIT then
							ns.SEARCH_INIT()
						end
						if ns.SEARCH_UI then
							if strlenutf8(searchQuery) > 0 then
								ns.SEARCH_UI:Show()
								ns.SEARCH_UI:Search(searchQuery)
							else
								ns.SEARCH_UI:SetShown(not ns.SEARCH_UI:IsShown())
							end
						end
						-- we do not wish to show the config dialog at this time
						return
					end

					-- if the keyword "group" is present in the command we show the EXPORT JSON dialog
					if text:find("[Gg][Rr][Oo][Uu][Pp]") then
						if ns.EXPORT_JSON then
							ns.EXPORT_JSON.OpenCopyDialog()
						end
						return
					end

					-- if the keyword "group" is present in the command we show the EXPORT JSON dialog
					if text:find("[Pp][Rr][Ii][Nn][Tt][Mm][Aa][Pp][Ss]") then
						PrintMaps()
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

	-- addon config is loaded so we update the local reference and register for future events
	function Init()
		-- update local reference to the correct savedvariable table
		UpdateVar()

		-- wait for the login event, or run the associated code right away
		if not IsLoggedIn() then
			ns.addon:RegisterEvent("PLAYER_LOGIN")
		else
			ns.addon:PLAYER_LOGIN()
		end

		-- create the config frame
		InitConfig()
	end
end

-- namespace references
ns.CONFIG = {}
ns.CONFIG.Init = Init

local addonName, addon = ...
local L, D, E = addon.locales, addon.data, addon.events;
local SavedVariables = addon.savedVariables
local Charms = addon.charms
local U = { }
addon.U = U
function U.IsCompatibleWith(projectID)
	return WOW_PROJECT_ID == projectID
end
function U.IsClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end
function U.IsRetail()
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end
--todo: Internationalize
addon.supportedMaps = {
	[14]   = {
		name            = "TomCats-ArathiHighlandsRares",
		title           = "TomCat's Tours: Rares of Arathi Highlands",
		zone            = "Arathi Highlands",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00012",
		backgroundColor = { 118 / 255, 18 / 255, 20 / 255, 0.80 }
	},
	[62]   = {
		name            = "TomCats-DarkshoreRares",
		title           = "TomCat's Tours: Rares of Darkshore",
		zone            = "Darkshore",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00006",
		backgroundColor = { 68 / 255, 34 / 255, 68 / 255, 0.80 }
	},
	[1355] = {
		name            = "TomCats-Nazjatar",
		title           = "TomCat's Tours: Nazjatar",
		zone            = "Nazjatar",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00008",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 }
	},
	[1462] = {
		name            = "TomCats-Mechagon",
		title           = "TomCat's Tours: Mechagon",
		zone            = "Mechagon",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00007",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
	},
	[1527] = {
		name            = "TomCats-Nzoth",
		title           = "TomCat's Tours: Uldum",
		zone            = "Uldum",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00018",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
	},
	[1530] = {
		name            = "TomCats-Nzoth",
		title           = "TomCat's Tours: Vale of Eternal Blossoms",
		zone            = "Vale of Eternal Blossoms",
		iconTexture     = "Interface\\AddOns\\TomCats\\images\\00018",
		backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
	},
}
-- Begin interim restart checking code
local function split(inputstr)
	local t = {}
	for str in string.gmatch(inputstr, "([^.]+)") do
		table.insert(t, str)
	end
	return t
end
local function convertVersionToNumber(version)
	local parts = split(version)
	return tonumber(parts[1]) * 1000000 + tonumber(parts[2]) * 1000 + tonumber(parts[3])
end
local addonTOCVersion = convertVersionToNumber(GetAddOnMetadata("TomCats", "version"))
local newFilesSinceVersion = convertVersionToNumber("1.4.0")
if (newFilesSinceVersion > addonTOCVersion) then
	DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Warning: TomCat's Tours requires that you restart WoW in order for the recent update to function properly|r")
end
-- End interim restart checking code
local slashCommandHandlers = { }
local components = { }
local function handleSlashCommand(msg)
	if (msg) then
		if (msg == "") then
			InterfaceOptionsFrame_OpenToCategory(TomCats_Config)
			--todo: Remove the redundant call if Blizzard ever fixes this
			InterfaceOptionsFrame_OpenToCategory(TomCats_Config)
		else
			local func = slashCommandHandlers[string.upper(msg)]
			if (not func) then
				InterfaceOptionsFrame_OpenToCategory(TomCats_Config_Slash_Commands)
				--todo: Remove the redundant call if Blizzard ever fixes this
				InterfaceOptionsFrame_OpenToCategory(TomCats_Config_Slash_Commands)
			else
				func()
			end
		end
	end
end
SLASH_TOMCATS1 = "/TOMCATS"
SlashCmdList["TOMCATS"] = handleSlashCommand
local slashCommandsHtmlHead = "<html>\n<body>\n<h1>Slash Commands</h1>\n<br />\n"
local slashCommandHtmlTemplate = "<h3>%s:</h3>\n<p>/TOMCATS %s</p>\n<br />\n"
local slashCommandsHtmlFoot = "</body>\n</html>"
TomCats.version = "01.05.00"
local function refreshInterfaceControlPanels()
	local slashCommandsHtml = slashCommandsHtmlHead
	local infoText = "Installed Components:\n|cffffffff"
	slashCommandsHtml = slashCommandsHtml .. format(slashCommandHtmlTemplate, "Open the TomCat's Tours Control Panel",
	                                                "")
	for i, component in ipairs(components) do
		if (component.slashCommands) then
			for _, slashCommand in ipairs(component.slashCommands) do
				slashCommandsHtml = slashCommandsHtml .. format(slashCommandHtmlTemplate, slashCommand.desc,
				                                                string.upper(slashCommand.command))
			end
		end
		infoText = infoText .. "   " .. component.name .. " (v" .. component.version .. ")"
		if (i ~= #components) then
			infoText = infoText .. "\n"
		end
	end
	infoText = infoText .. "|r"
	TomCats_Config.InstalledComponents:SetText(infoText)
	slashCommandsHtml = slashCommandsHtml .. slashCommandsHtmlFoot
	TomCats_Config_Slash_Commands.html:SetText(slashCommandsHtml)
end
function TomCats:Register(componentInfo)
	if (componentInfo) then
		if (componentInfo.slashCommands) then
			for _, slashCommand in ipairs(componentInfo.slashCommands) do
				slashCommandHandlers[string.upper(slashCommand.command)] = slashCommand.func
			end
		end
		if (componentInfo.raresLogHandlers) then
			for k, v in pairs(componentInfo.raresLogHandlers) do
				if addon.supportedMaps[k] then
					addon.supportedMaps[k].handlers = v
				end
			end
		end
		table.insert(components, componentInfo)
		refreshInterfaceControlPanels()
	end
end
local linkText = "Visions of N'zoth Rares by TomCat's Tours"
local chatStep = 1
local function playChat()
	PlaySound(SOUNDKIT.TELL_MESSAGE)
	local message
	local link = "|cffff80ff[|cffffff00" .. "TomCat from TomCat's Tours" .. "|cffff80ff]"
	if (chatStep == 1) then
		SavedVariables.account.notifications["NZOTHLAUNCH"] = true
		addon.charm.MinimapLoopPulseAnim:Stop()
		addon.charm:Hide()
		message = "|cffff80ffHi. I hope I am not intruding...I just wanted to say thanks for using my TomCat's Tours addons!|r"
	end
	if (chatStep == 2) then
		message = "|cffff80ffI thought you might be interested in trying my new addon: " .. linkText
	end
	if (chatStep == 3) then
		message = "|cffff80ffPlease check it out, and thanks for the support!"
	end
	DEFAULT_CHAT_FRAME:AddMessage(format(_G["CHAT_WHISPER_GET"] .. message, link))
	chatStep = chatStep + 1
	if (chatStep < 4) then
		C_Timer.After(2 + chatStep, playChat)
	end
end
local function ChangeMap(self)
	WorldMapFrame:SetMapID(self.mapID)
	if WorldMapFrame:IsMaximized() then
		WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:Minimize()
	end
	if not TomCatsRareMapFrame:IsShown() then
		TomCatsRarePanelToggle:OnClick()
	elseif not TomCatsRareMapFrame.RaresFrame:IsShown() then
		TomCatsRareMapFrame.DetailsFrame:Hide()
		TomCatsRareMapFrame.RaresFrame:Show()
	end
end
VignettePinMixin.OnAcquired_Orig = VignettePinMixin.OnAcquired
function VignettePinMixin:OnAcquired(vignetteGUID, vignetteInfo)
	self:OnAcquired_Orig(vignetteGUID, vignetteInfo)
	if vignetteInfo and vignetteInfo.atlasName and (vignetteInfo.atlasName == "VignetteKill" or vignetteInfo.atlasName == "Capacitance-General-WorkOrderCheckmark" or vignetteInfo.atlasName == "VignetteEventElite") then
		self.Texture:SetAtlas(vignetteInfo.atlasName, false)
		self.HighlightTexture:SetAtlas(vignetteInfo.atlasName, false)
		local x, y = self.Texture:GetSize()
		self.Texture:SetSize(x * 0.8, y * 0.8)
		self.HighlightTexture:SetSize(x * 0.8, y * 0.8)
	end
end
local function ADDON_LOADED(_, _, arg1)
	if (arg1 == addonName) then
		addon.events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
		SavedVariables.account.preferences = SavedVariables.account.preferences or { }
		SavedVariables.account.preferences.TomCatsMinimapButton = { position = 3 }
		SavedVariables.account.notifications = SavedVariables.account.notifications or { }
		if ((not SavedVariables.account.notifications["NZOTHLAUNCH"])) then
			--todo: Disable for Classic releases
			local _, _, _, _, reason = GetAddOnInfo("TomCats-Nzoth")
			if (reason and reason == "MISSING") then
				addon.charm = Charms.Create({
					                                name            = "TomCatsMinimapButton",
					                                iconTexture     = "Interface\\AddOns\\TomCats\\images\\00013",
					                                backgroundColor = { 0.0, 0.0, 0.0, 1.0 },
					                                handler_onclick = playChat
				                                })
				addon.charm.tooltip = {
					Show = function(this)
						GameTooltip:ClearLines()
						GameTooltip:SetOwner(this, "ANCHOR_LEFT")
						GameTooltip:SetText("TomCat would like to chat!", 1, 1, 1)
						GameTooltip:AddLine("TomCat's Tours", nil, nil, nil, true)
						GameTooltip:Show()
					end,
					Hide = function()
						GameTooltip:Hide()
					end
				}
				addon.charm.MinimapLoopPulseAnim:Play()
				addon.charm:SetFrameLevel(TOMCATS_LIBS_ICON_LASTFRAMELEVEL + 100)
			else
				SavedVariables.account.notifications["NZOTHLAUNCH"] = true
			end
		end
		SavedVariables.account.tutorials = SavedVariables.account.tutorials or { }
		SavedVariables.character.cvars = SavedVariables.character.cvars or { }
		TomCats_Config.name = "TomCat's Tours"
		InterfaceOptions_AddCategory(TomCats_Config)
		TomCats_Config_Slash_Commands.name = "Slash Commands"
		TomCats_Config_Slash_Commands.parent = "TomCat's Tours"
		InterfaceOptions_AddCategory(TomCats_Config_Slash_Commands)
		refreshInterfaceControlPanels()
		local offset = -36
		local buttonSpacing = -34
		local count = 0
		local mapIDs = { 14, 62, 1355, 1462 }
		for i = 1, #mapIDs do
			local k = mapIDs[i]
			local v = addon.supportedMaps[k]
			local enabled = GetAddOnEnableState(UnitName("player"), v.name)
			if (enabled ~= 0) then
				local rareMapShortcut = Charms.Create({
					                                          name            = "TomCatsWorldmapRaresButton" .. k,
					                                          iconTexture     = v.iconTexture,
					                                          backgroundColor = v.backgroundColor,
					                                          handler_onclick = ChangeMap,
					                                          ignoreSlideBar  = true,
					                                          ignoreSexyMap   = true
				                                          })
				rareMapShortcut:SetParent(WorldMapFrame)
				rareMapShortcut:SetFrameStrata("MEDIUM")
				rareMapShortcut:SetFrameLevel(9999)
				rareMapShortcut:ClearAllPoints()
				rareMapShortcut:SetPoint("TOPRIGHT", WorldMapFrame:GetCanvasContainer(), "TOPRIGHT", -4,
				                         offset + buttonSpacing * count)
				rareMapShortcut.shadow:Show()
				rareMapShortcut.tooltip = {
					Show = function(this)
						GameTooltip:ClearLines()
						GameTooltip:SetOwner(this, "ANCHOR_LEFT")
						GameTooltip:SetText(v.zone, 1, 1, 1)
						GameTooltip:Show()
					end,
					Hide = function()
						GameTooltip:Hide()
					end
				}
				--rareMapShortcut:RegisterForDrag()
				rareMapShortcut.mapID = k
				count = count + 1
			else
				addon.supportedMaps[k] = nil
			end
		end
	end
end
addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
do
	local L = addon.locales
	local U = addon.U
	if U.IsRetail() then
		local supportedMaps, RaresLogFrame_ShowRareDetails
		local DISPLAY_STATE_CLOSED = 1
		local DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG = 2
		local DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG = 3
		local DISPLAY_STATE_OPEN_MAXIMIZED = 4
		local DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG = 5
		local lastDisplayStates = { DISPLAY_STATE_CLOSED, DISPLAY_STATE_CLOSED }
		local function setLastDisplayState(displayState)
			lastDisplayStates[1] = lastDisplayStates[2]
			lastDisplayStates[2] = displayState
		end
		local CREATURE_STATUS = {
			COMPLETE              = 0,
			HIDDEN                = 1,
			UNAVAILABLE           = 2,
			LOOT_ELIGIBLE         = 3,
			BONUS_ROLL_ELIGIBLE   = 4,
			WORLD_QUEST_AVAILABLE = 5
		}
		local function SidePanelToggle_Refresh()
			if TomCatsRareMapFrame:IsShown() or not QuestMapFrame:IsShown() then
				WorldMapFrame.SidePanelToggle.OpenButton:Show()
				WorldMapFrame.SidePanelToggle.CloseButton:Hide()
			else
				WorldMapFrame.SidePanelToggle.OpenButton:Hide()
				WorldMapFrame.SidePanelToggle.CloseButton:Show()
			end
		end
		TomCatsRareLogMixin = {}
		function TomCatsRareLogMixin:InitLayoutIndexManager()
			self.layoutIndexManager = CreateLayoutIndexManager()
			self.layoutIndexManager:AddManagedLayoutIndex("RaresLog", QUEST_LOG_WAR_CAMPAIGN_LAYOUT_INDEX + 1)
			self.RaresFrame.Contents.Separator:Show()
			self.RaresFrame.Contents.StoryHeader:Show()
			self.RaresFrame.Contents.Notice.Text:SetText(
					"New features being developed constantly. Be sure to update your addons regularly!|r\n\n|cff00ff00Thank you for using TomCat's Tours\n|cffffffffVisit https://twitch.tv/TomCat|r"
			--            "New feature being developed:\n|cffffffffRare Spawn Share (34% of votes)|r\n\n|cff00ff00Round 3 voting has begun!|r\nVote each day on what's next:\n|cffffffffhttps://twitch.tv/TomCat|r"
			)
		end
		local raresLog
		local function CheckForUpdatedRaresLog()
			if raresLog and raresLog.updated then
				TomCatsRareMapFrame:RefreshRaresLog()
				raresLog.updated = nil
			end
		end
		C_Timer.NewTicker(0.2, CheckForUpdatedRaresLog)
		local RareTextColorLookup = {
			[CREATURE_STATUS.COMPLETE]      = { QuestDifficultyColors["standard"], QuestDifficultyHighlightColors["standard"] },
			[CREATURE_STATUS.LOOT_ELIGIBLE] = { QuestDifficultyHighlightColors["header"], QuestDifficultyHighlightColors["difficult"] },
			[CREATURE_STATUS.UNAVAILABLE]   = { QuestDifficultyColors["impossible"], QuestDifficultyHighlightColors["impossible"] },
		}
		local RareButtonLookup = {
			[CREATURE_STATUS.COMPLETE]      = "Complete",
			[CREATURE_STATUS.LOOT_ELIGIBLE] = "Incomplete",
			[CREATURE_STATUS.UNAVAILABLE]   = "Unavailable",
		}
		function TomCatsRareLogTitleButton_OnClick(self)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			TomCatsRareMapFrame.RaresFrame:Hide()
			RaresLogFrame_ShowRareDetails(self.creature)
		end
		function TomCatsRareLogTitleButton_OnMouseDown(self)
			local anchor, _, _, x, y = self.Text:GetPoint()
			self.Text:SetPoint(anchor, x + 1, y - 1)
		end
		function TomCatsRareLogTitleButton_OnMouseUp(self)
			local anchor, _, _, x, y = self.Text:GetPoint()
			self.Text:SetPoint(anchor, x - 1, y + 1)
		end
		local LOOT_NOUN_COLOR = CreateColor(1.0, 0.82, 0.0, 1.0)
		function TomCatsRareLogTitleButton_OnEnter(self)
			local textColor = RareTextColorLookup[self.creature["Status"]][2]
			self.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
			local creature = self.creature
			EmbeddedItemTooltip:ClearAllPoints()
			EmbeddedItemTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 34, 0)
			EmbeddedItemTooltip:SetOwner(self, "ANCHOR_PRESERVE")
			local color = WORLD_QUEST_QUALITY_COLORS[1]
			EmbeddedItemTooltip:SetText(creature["Name"], color.r, color.g, color.b)
			local tooltipWidth = 20 + max(231, EmbeddedItemTooltipTextLeft1:GetStringWidth())
			if (tooltipWidth > UIParent:GetRight() - QuestMapFrame:GetParent():GetRight()) then
				EmbeddedItemTooltip:ClearAllPoints()
				EmbeddedItemTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -34, 0)
				EmbeddedItemTooltip:SetOwner(self, "ANCHOR_PRESERVE")
				EmbeddedItemTooltip:SetText(creature["Name"], color.r, color.g, color.b)
			end
			local footerText = ("|cff00ff00<%s>|r"):format(L["Click to view Creature Details"])
			if (creature["Loot"]) then
				local itemID
				if type(creature["Loot"]) == "table" then
					if creature["Loot"].items then
						itemID = creature["Loot"].items[1]
						if #(creature["Loot"].items) > 1 then
							footerText = ("+ %d more items\n\n" .. footerText):format(#(creature["Loot"].items) - 1)
						end
					end
				else
					itemID = creature["Loot"]
				end
				if itemID then
					GameTooltip_AddBlankLinesToTooltip(EmbeddedItemTooltip, 1)
					GameTooltip_AddColoredLine(EmbeddedItemTooltip, LOOT_NOUN, LOOT_NOUN_COLOR, true)
					EmbeddedItemTooltip_SetItemByID(EmbeddedItemTooltip.ItemTooltip, itemID)
				end
			end
			EmbeddedItemTooltip.BottomFontString:SetText(footerText)
			EmbeddedItemTooltip.BottomFontString:SetShown(true)
			EmbeddedItemTooltip:Show()
		end
		function TomCatsRareLogTitleButton_OnLeave(self)
			local textColor = RareTextColorLookup[self.creature["Status"]][1]
			self.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
			EmbeddedItemTooltip:Hide()
		end
		function TomCatsRareRewardItem_OnEnter(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetItemByID(self:GetID())
			GameTooltip:Show()
		end
		function TomCatsRareRewardItem_OnClick(self)
			if (IsModifiedClick() and self.objectType == "item") then
				local _, itemLink = GetItemInfo(self:GetID())
				HandleModifiedItemClick(itemLink)
			end
		end
		function TomCatsRareLogMixin:RefreshRaresLog()
			self.titleFramePool:ReleaseAll()
			self.poiFramePool:ReleaseAll()
			local lastButton
			if (raresLog) then
				if not raresLog.isSorted then
					raresLog.isSorted = true
					raresLog.creatures_sorted = { }
					local rareNames = { }
					local lookupByName = { }
					for _, v in pairs(raresLog.creatures) do
						local name = v["Name"]
						if not name then
							raresLog.isSorted = false
						else
							table.insert(rareNames, name)
							lookupByName[name] = v
						end
					end
					table.sort(rareNames)
					for _, v in ipairs(rareNames) do
						table.insert(raresLog.creatures_sorted, lookupByName[v])
					end
				end
				for _, creature in pairs(raresLog.creatures_sorted) do
					if creature["Status"] ~= CREATURE_STATUS.HIDDEN then
						local button = self.titleFramePool:Acquire()
						button.creature = creature
						button.Text:SetText(creature["Name"])
						local textColor = RareTextColorLookup[creature["Status"]][1]
						button.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
						button:ClearAllPoints()
						if (lastButton) then
							button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -4)
						else
							button:SetPoint("TOPLEFT", self.RaresFrame.Contents.StoryHeader, "BOTTOMLEFT", 29, -8)
						end
						lastButton = button
						button:Show()
						local poiButton = self.poiFramePool:Acquire()
						poiButton:ClearAllPoints()
						poiButton:SetPoint("LEFT", button, -21, 2)
						poiButton.parent = button
						poiButton:SetFrameLevel(button:GetFrameLevel() + 1)
						poiButton:Show()
						poiButton.creature = creature
						for key, value in pairs(RareButtonLookup) do
							if (key == creature["Status"]) then
								poiButton[value]:Show()
							else
								poiButton[value]:Hide()
							end
						end
					end
				end
			end
		end
		function TomCatsRareLogMixin:Refresh()
			self.RaresFrame.Contents.LogHeader.Text:SetText(L["Rare Creatures Log"])
			self.RaresFrame.Contents.LogHeader:Show()
			self.RaresFrame.Contents.StoryHeader.Text:SetText(C_Map.GetMapInfo(WorldMapFrame:GetMapID())["name"])
			self.layoutIndexManager:Reset()
			self:RefreshRaresLog()
			self.RaresFrame.Contents:Layout()
		end
		function TomCatsRareLogMixin:SetShown()
			if not self:IsShown() then
				self:Show()
				self.DetailsFrame:Hide()
				self.RaresFrame:Show()
				local handlers = supportedMaps[WorldMapFrame:GetMapID()].handlers
				if handlers and handlers.raresLog then
					raresLog = handlers.raresLog()
					raresLog.locationIndex = raresLog.locationIndex or 1
				else
					raresLog = nil
				end
			end
		end
		function TomCatsRareLogMixin:UpdateDisplayState()
			if not WorldMapFrame:IsShown() then
				setLastDisplayState(DISPLAY_STATE_CLOSED)
			elseif QuestMapFrame:IsShown() or QuestMapFrame.DetailsFrame:IsShown() then
				if QuestMapFrame.DetailsFrame:IsShown() then
					self:Hide()
					QuestScrollFrame:Hide()
				else
					if supportedMaps[WorldMapFrame:GetMapID()] and SavedVariables.character.preferQuestLog == nil then
						self:SetShown(true)
						QuestScrollFrame:Hide()
						self:Refresh()
						setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG)
						return
					end
					QuestScrollFrame:Show()
				end
				setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
			else
				if WorldMapFrame:IsMaximized() then
					setLastDisplayState(DISPLAY_STATE_OPEN_MAXIMIZED)
				else
					setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG)
				end
			end
			self:Hide()
		end
		function TomCatsRareMapFrame_OnLoad(self)
			self:InitLayoutIndexManager()
			self.titleFramePool = CreateFramePool("BUTTON", TomCatsRareMapFrame.RaresFrame.Contents,
			                                      "TomCatsRareLogTitleTemplate")
			self.poiFramePool = CreateFramePool("FRAME", TomCatsRareMapFrame.RaresFrame.Contents,
			                                    "TomCatsRarePOITemplate")
		end
		function TomCatsRareMapFrame_OnEvent()
		end
		function TomCatsRareMapFrame_OnHide()
		end
		local lastMapID = 0
		local helpPlate_override
		local function UpdateAll()
			if WorldMapFrame:GetMapID() ~= lastMapID then
				lastMapID = WorldMapFrame:GetMapID()
				if TomCatsRareMapFrame:IsShown() then
					local supportedMap = supportedMaps[WorldMapFrame:GetMapID()]
					if supportedMap then
						local handlers = supportedMaps[WorldMapFrame:GetMapID()].handlers
						if handlers and handlers.raresLog then
							raresLog = handlers.raresLog()
						else
							raresLog = nil
						end
						TomCatsRareMapFrame:Refresh()
					end
				end
			end
			TomCatsRareMapFrame:UpdateDisplayState()
			TomCatsRarePanelToggle:Refresh()
			SidePanelToggle_Refresh()
			if HelpPlate_IsShowing(helpPlate_override) and (WorldMapFrame:IsMaximized() or not WorldMapFrame:IsShown()) then
				HelpPlate_Hide()
			end
		end
		local function RevertToQuestFrameShown(save)
			WorldMapFrame:SetDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
			QuestScrollFrame:Show()
			TomCatsRareMapFrame:Hide()
			TomCatsRarePanelToggle:Refresh()
			SidePanelToggle_Refresh()
			setLastDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
			if save then
				SetCVar("questLogOpen", "1")
			end
		end
		local function Hook_WorldMapFrame_SidePanelToggle()
			if supportedMaps[WorldMapFrame:GetMapID()] then
				SavedVariables.character.preferQuestLog = true
			end
			if (lastDisplayStates[1] == DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG and lastDisplayStates[2] == DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG) or
					(lastDisplayStates[2] == DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG and lastDisplayStates[1] == DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG) then
				RevertToQuestFrameShown(true)
			end
		end
		local function Hook_ToggleQuestLog()
			if lastDisplayStates[2] == DISPLAY_STATE_OPEN_MINIMIZED_WITH_RARE_LOG then
				RevertToQuestFrameShown()
			end
		end
		TomCatsWorldMapRareSidePanelToggleMixin = { }
		function TomCatsWorldMapRareSidePanelToggleMixin:OnClick()
			SavedVariables.character.preferQuestLog = nil
			if (self.OpenButton:IsShown()) then
				WorldMapFrame:SetDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_WITH_LOG)
				QuestScrollFrame:Hide()
				TomCatsRareMapFrame:SetShown(true)
				TomCatsRareMapFrame:Refresh()
				self.OpenButton:Hide()
				self.CloseButton:Show()
				SetCVar("questLogOpen", "1")
			else
				WorldMapFrame:SetDisplayState(DISPLAY_STATE_OPEN_MINIMIZED_NO_LOG)
				TomCatsRareMapFrame:Hide()
				self.OpenButton:Show()
				self.CloseButton:Hide()
				SetCVar("questLogOpen", "0")
			end
			WorldMapFrame.SidePanelToggle.OpenButton:Show()
			WorldMapFrame.SidePanelToggle.CloseButton:Hide()
		end
		function TomCatsWorldMapRareSidePanelToggleMixin:Refresh()
			if WorldMapFrame.SidePanelToggle:IsShown() and supportedMaps[WorldMapFrame:GetMapID()] then
				self:Show()
				if TomCatsRareMapFrame:IsShown() then
					self.OpenButton:Hide()
					self.CloseButton:Show()
				else
					self.OpenButton:Show()
					self.CloseButton:Hide()
				end
			else
				self:Hide()
			end
		end
		local function TryShowTutorial()
			if not SavedVariables.account.tutorials["Rares Log Toggle"] then
				local frame = CreateFrame("FRAME", nil, TomCatsRarePanelToggle,
				                          "TomCatsRareMapFrameTutorialBoxTemplate")
				frame:SetFrameStrata("DIALOG")
				frame:SetFrameLevel(100)
				frame.Text:SetText(L["TUTORIAL_RaresLogToggle"])
				frame.Text:SetSpacing(4)
				SetClampedTextureRotation(frame.Arrow.Arrow, 270)
				SetClampedTextureRotation(frame.Arrow.Glow, 270)
				frame.Arrow:ClearAllPoints()
				frame.Arrow:SetPoint("BOTTOMLEFT", frame, "RIGHT", -4, 4)
				frame.Arrow.Glow:ClearAllPoints()
				frame.Arrow.Glow:SetPoint("CENTER", frame.Arrow.Arrow, "CENTER", 2, 0)
				frame:ClearAllPoints()
				frame:SetPoint("RIGHT", TomCatsRarePanelToggle, "BOTTOMLEFT", -18, 0)
				local newHeight = frame.Text:GetHeight() + 48
				if 100 >= newHeight then
					newHeight = 100
				end
				frame:SetHeight(newHeight)
				frame.CloseButton:SetScript("OnClick", function()
					SavedVariables.account.tutorials["Rares Log Toggle"] = true
					frame:Hide()
				end)
				frame:Show()
			end
		end
		local function AddOverlayFrame(self, templateName, templateType, anchorPoint, relativeFrame, relativePoint,
		                               offsetX, offsetY)
			local frame = CreateFrame(templateType, nil, self, templateName)
			if anchorPoint then
				frame:SetPoint(anchorPoint, relativeFrame, relativePoint, offsetX, offsetY)
			end
			frame.relativeFrame = relativeFrame or self
			return frame
		end
		local function ADDON_LOADED(_, _, arg1)
			if (arg1 == addonName) then
				addon.events.unregisterEvent("ADDON_LOADED", ADDON_LOADED)
				CreateFrame("FRAME", "TomCatsRareMapFrame", WorldMapFrame, "TomCatsRareMapFrameTemplate")
				CreateFrame("FRAME", "TomCatsRareInfoRewardsFrame", nil, "TomCatsRareInfoRewardsFrameTemplate")
				supportedMaps = addon.supportedMaps
				TomCatsRarePanelToggle = AddOverlayFrame(WorldMapFrame, "TomCatsWorldMapRareSidePanelToggleTemplate",
				                                         "BUTTON", "BOTTOMRIGHT", WorldMapFrame:GetCanvasContainer(),
				                                         "BOTTOMRIGHT", -2, 36)
				tinsert(WorldMapFrame.overlayFrames, TomCatsRarePanelToggle)
				TryShowTutorial()
				TomCatsRareMapFrame:SetParent(WorldMapFrame)
				TomCatsRareMapFrame:SetFrameStrata("HIGH")
				TomCatsRareMapFrame:SetFrameLevel(10)
				TomCatsRareMapFrame:ClearAllPoints()
				TomCatsRareMapFrame:SetPoint("TOPRIGHT", -6, -20)
				hooksecurefunc(WorldMapFrame, "SetMapID", UpdateAll)
				hooksecurefunc(WorldMapFrame.SidePanelToggle, "OnClick", Hook_WorldMapFrame_SidePanelToggle)
				hooksecurefunc(WorldMapFrame, "SetDisplayState", UpdateAll)
				hooksecurefunc("QuestMapFrame_ShowQuestDetails", UpdateAll)
				hooksecurefunc("ToggleQuestLog", Hook_ToggleQuestLog)
				hooksecurefunc("HideUIPanel", UpdateAll)
				if WorldMapFrame.SidePanelToggle.OpenButton.isSkinned then
					WorldMapFrame.SidePanelToggle:Hide()
					WorldMapFrame.SidePanelToggle = WorldMapFrame:AddOverlayFrame("WorldMapSidePanelToggleTemplate",
					                                                              "BUTTON", "BOTTOMRIGHT",
					                                                              WorldMapFrame:GetCanvasContainer(),
					                                                              "BOTTOMRIGHT", -2, 1)
					hooksecurefunc(WorldMapFrame.SidePanelToggle, "OnClick", Hook_WorldMapFrame_SidePanelToggle)
				else
					local hooked
					hooksecurefunc(WorldMapFrame.SidePanelToggle.OpenButton:GetNormalTexture(), "SetVertexColor",
					               function()
						               if not hooked then
							               WorldMapFrame.SidePanelToggle:Hide()
							               WorldMapFrame.SidePanelToggle = WorldMapFrame:AddOverlayFrame("WorldMapSidePanelToggleTemplate",
							                                                                             "BUTTON",
							                                                                             "BOTTOMRIGHT",
							                                                                             WorldMapFrame:GetCanvasContainer(),
							                                                                             "BOTTOMRIGHT",
							                                                                             -2, 1)
							               hooksecurefunc(WorldMapFrame.SidePanelToggle, "OnClick",
							                              Hook_WorldMapFrame_SidePanelToggle)
						               end
						               hooked = true
					               end)
				end
			end
		end
		local lastWaypoint
		function TomCatsRareLogEntryIcon_OnClick(self)
			if (TomTom) then
				local playerMapID = C_Map.GetBestMapForUnit("player")
				local pinMapID = WorldMapFrame:GetMapID()
				if (pinMapID == playerMapID) then
					if (lastWaypoint) then
						TomTom:RemoveWaypoint(lastWaypoint)
					end
					local location = self:GetParent().creature["Locations"][raresLog.locationIndex]
					if location then
						lastWaypoint = TomTom:AddWaypoint(WorldMapFrame:GetMapID(), location[1], location[2], {
							title      = self:GetParent().creature["Name"],
							persistent = false,
							minimap    = true,
							world      = true
						})
					end
				end
			end
		end
		local REWARDS_SECTION_OFFSET = 5
		local function RareInfo_ShowRewards(creature)
			local rewardsFrame = TomCatsRareInfoRewardsFrame
			local totalRewards = 1
			local rewardButtons = rewardsFrame.RewardButtons
			for i = totalRewards, #rewardButtons do
				rewardButtons[i]:ClearAllPoints()
				rewardButtons[i]:Hide()
			end
			local rewardsCount = 0
			local lastFrame = rewardsFrame.Header
			local totalHeight = rewardsFrame.Header:GetHeight()
			local buttonHeight = rewardsFrame.RewardButtons[1]:GetHeight()
			rewardsFrame.ArtifactXPFrame:ClearAllPoints()
			rewardsFrame.ArtifactXPFrame:Hide()
			rewardsFrame.ItemChooseText:ClearAllPoints()
			rewardsFrame.ItemChooseText:Hide()
			rewardsFrame.spellRewardPool:ReleaseAll()
			rewardsFrame.followerRewardPool:ReleaseAll()
			rewardsFrame.spellHeaderPool:ReleaseAll()
			rewardsFrame.PlayerTitleText:Hide()
			rewardsFrame.TitleFrame:Hide()
			rewardsFrame.XPFrame:Hide()
			rewardsFrame.MoneyFrame:Hide()
			local loot = creature["Loot"] or {
				items = { }
			}
			if type(loot) ~= "table" then
				loot = {
					items = { loot }
				}
			end
			local numQuestRewards = 0
			if loot.items then
				numQuestRewards = #(loot.items)
			end
			local index
			local baseIndex = 0
			local buttonIndex = 0
			for i = 1, numQuestRewards, 1 do
				buttonIndex = buttonIndex + 1
				index = i + baseIndex
				local questItem = QuestInfo_GetRewardButton(rewardsFrame, i)
				questItem.type = "reward"
				questItem.objectType = "item"
				questItem:SetID(loot.items[i])
				questItem:Show()
				local itemID = loot.items[i]
				local item = Item:CreateFromItemID(itemID)
				item:ContinueOnItemLoad(function()
					questItem.Name:SetText(item:GetItemName())
					questItem.Icon:SetTexture(item:GetItemIcon())
					SetItemButtonQuality(questItem, item:GetItemQuality(), itemID, false)
				end)
				if (buttonIndex > 1) then
					if (mod(buttonIndex, 2) == 1) then
						questItem:SetPoint("TOPLEFT", rewardButtons[index - 2], "BOTTOMLEFT", 0, -2)
						lastFrame = questItem
						totalHeight = totalHeight + buttonHeight + 2
					else
						questItem:SetPoint("TOPLEFT", rewardButtons[index - 1], "TOPRIGHT", 1, 0)
					end
				else
					questItem:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -REWARDS_SECTION_OFFSET)
					lastFrame = questItem
					totalHeight = totalHeight + buttonHeight + REWARDS_SECTION_OFFSET
				end
				rewardsCount = rewardsCount + 1
				lastFrame = questItem
			end
			rewardsFrame.ItemReceiveText:Hide()
			rewardsFrame.MoneyFrame:Hide()
			rewardsFrame.XPFrame:Hide()
			rewardsFrame.SkillPointFrame:Hide()
			rewardsFrame.HonorFrame:Hide()
			rewardsFrame:Show()
			rewardsFrame:SetHeight(totalHeight)
			return rewardsFrame, lastFrame
		end
		function RaresLogFrame_ShowRareDetails(creature)
			local elements = {
				TomCatsQuestInfoTitleHeader, 5, -5,
				TomCatsQuestInfoQuestType, 0, -5,
			}
			local contentWidth = 244
			local parentFrame = TomCatsRareMapFrame.DetailsFrame.ScrollFrame.Contents
			TomCatsQuestInfoTitleHeader:SetText(creature["Name"])
			TomCatsQuestInfoTitleHeader:SetWidth(contentWidth)
			TomCatsQuestInfoQuestType:SetText("|T1121272:20:20:0:2:1024:512:588:620:306:338|t Rare Spawn")
			local description = creature["Description"]
			if description then
				table.insert(elements, TomCatsQuestInfoDescriptionHeader)
				table.insert(elements, 0)
				table.insert(elements, -10)
				table.insert(elements, TomCatsQuestInfoDescriptionText)
				table.insert(elements, 0)
				table.insert(elements, -5)
				TomCatsQuestInfoDescriptionText:SetText(description)
				TomCatsQuestInfoDescriptionText:SetWidth(244)
			else
				TomCatsQuestInfoDescriptionHeader:SetShown(false)
				TomCatsQuestInfoDescriptionText:SetShown(false)
			end
			local lastFrame
			for i = 1, #elements, 3 do
				shownFrame = elements[i]
				shownFrame:SetParent(parentFrame)
				shownFrame:ClearAllPoints()
				if lastFrame then
					shownFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", elements[i + 1], elements[i + 2])
				else
					shownFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", elements[i + 1], elements[i + 2])
				end
				lastFrame = shownFrame
				shownFrame:SetShown(true)
			end
			local rewardsFrame = RareInfo_ShowRewards(creature)
			parentFrame = TomCatsRareMapFrame.DetailsFrame.RewardsFrame
			rewardsFrame:SetParent(parentFrame)
			rewardsFrame:ClearAllPoints()
			rewardsFrame:SetWidth(244)
			rewardsFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 8, -42)
			rewardsFrame:SetShown(true)
			TomCatsRareMapFrame.DetailsFrame.ScrollFrame.ScrollBar:SetValue(0)
			local height
			if (TomCatsRareInfoRewardsFrame:IsShown()) then
				height = TomCatsRareInfoRewardsFrame:GetHeight() + 49
			else
				height = 59
			end
			height = min(height, 275)
			TomCatsRareMapFrame.DetailsFrame.RewardsFrame:SetHeight(height)
			TomCatsRareMapFrame.DetailsFrame.RewardsFrame.Background:SetTexCoord(0, 1, 0, height / 275)
			TomCatsRareMapFrame.DetailsFrame:Show()
		end
		function TomCatsRareMapFrame_ReturnFromRareDetails()
			TomCatsRareMapFrame.RaresFrame:Show()
			TomCatsRareMapFrame.DetailsFrame:Hide()
		end
		addon.events.registerEvent("ADDON_LOADED", ADDON_LOADED)
	end
end
 -- FrameXML.toc:8
 -- FrameXML.toc:11
 -- FrameXML.toc:56
 -- SharedUIPanelTemplates.xml:3
 -- FrameXML.toc:152

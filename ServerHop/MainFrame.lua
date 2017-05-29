-- Populating hopAddon frame


-- mode change


hopAddon.buttonChangeMode = CreateFrame("Button",nil,hopAddon,"UIGoldBorderButtonTemplate")
hopAddon.buttonChangeMode:SetSize(110,21)
hopAddon.buttonChangeMode:SetPoint("TOPLEFT", 30,2)
hopAddon.buttonChangeMode:SetText(HOPADDON_CHANGEMODE)

--[[	 SQUARE VERSION WITHOUT TEXT

hopAddon.buttonChangeMode = CreateFrame("Button","changemodebut",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonChangeMode:SetSize(25,25)
hopAddon.buttonChangeMode:SetPoint("TOPLEFT",27,4)
hopAddon.buttonChangeMode.Icon = hopAddon.buttonChangeMode:CreateTexture("changemodebuttex","OVERLAY")
hopAddon.buttonChangeMode.Icon:SetSize(14,14)
hopAddon.buttonChangeMode.Icon:SetPoint("CENTER",0,0)
hopAddon.buttonChangeMode.Icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")
hopAddon.buttonChangeMode.tooltip = HOPADDON_CHANGEMODE
-- override on enter, onhide event is inside template
hopAddon.buttonChangeMode:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT", 0, -25)
	GameTooltip:SetText(HOPADDON_CHANGEMODE, 1, 1, 1, true)
	GameTooltip:Show()
end)
]]--

-- hop/search mode toggle button
hopAddon.buttonChangeMode:SetScript("OnClick", function(btn)
	FinishCustomSearch()
	HelpPlate_Hide(true)
	hopAddon.favouritesFrame:Hide()
	hopAddon.searchFrame.holderCatFilters:Hide()
	
	if hopAddon.hopFrame:IsShown() then
		hopAddon.hopFrame:Hide()
		hopAddon.searchFrame:Show()
	else
		hopAddon.hopFrame:Show()
		hopAddon.searchFrame:Hide()
	end
	
	PlaySound("igMainMenuOptionCheckBoxOn")
end)



HoppingFrame_HelpPlate = {
	FramePos = { x = 0, y = -20 },
	FrameSize = { width = HOPADDON_WIDTH, height = HOPADDON_HEIGHT },
	[1] = { ButtonPos = { x = 140,  y = 20 }, HighLightBox = { x = 50, y = 0, width = 140, height = 23 },  ToolTipDir = "UP",   ToolTipText = HOPADDON_HOPHELP_1 },
	[2] = { ButtonPos = { x = 200,  y = -15 },  HighLightBox = { x = 15, y = -25, width = 210, height = 24 },  ToolTipDir = "RIGHT",  ToolTipText = HOPADDON_HOPHELP_2 },
	[3] = { ButtonPos = { x = 45,  y = -56},  HighLightBox = { x = 15, y = -50, width = 100, height = 24 },  ToolTipDir = "DOWN",		ToolTipText = HOPADDON_HOPHELP_3 },
	[4] = { ButtonPos = { x = 155,  y = -56 }, HighLightBox = { x = 125, y = -50, width = 100, height = 24 }, ToolTipDir = "DOWN",   ToolTipText = HOPADDON_HOPHELP_4 },
}

SearchingFrame_HelpPlate = {
	FramePos = { x = 0, y = -20 },
	FrameSize = { width = HOPADDON_WIDTH, height = 120 },
	[1] = { ButtonPos = { x = 200,  y = -15 },  HighLightBox = { x = 15, y = -25, width = 210, height = 24 },  ToolTipDir = "RIGHT",  ToolTipText = HOPADDON_SEARCHHELP_1 },
	[2] = { ButtonPos = { x = 200,  y = -40},  HighLightBox = { x = 15, y = -50, width = 210, height = 24 },  ToolTipDir = "RIGHT",		ToolTipText = HOPADDON_SEARCHHELP_2 },
	[3] = { ButtonPos = { x = 95,  y = -75 }, HighLightBox = { x = 5, y = -90, width = 230, height = 20 }, ToolTipDir = "DOWN",   ToolTipText = HOPADDON_SEARCHHELP_3 },
	[4] = { ButtonPos = { x = 95,  y = -120 }, HighLightBox = { x = 5, y = -110, width = 230, height = 60 }, ToolTipDir = "RIGHT",   ToolTipText = HOPADDON_SEARCHHELP_4 },
}


hopAddon.buttonHelp = CreateFrame("Button","helpButton",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonHelp:SetSize(25,25)
hopAddon.buttonHelp:SetPoint("TOPRIGHT",-25,4)
hopAddon.buttonHelp.Icon = hopAddon.buttonHelp:CreateTexture("helpTex","OVERLAY")
hopAddon.buttonHelp.Icon:SetSize(16,16)
hopAddon.buttonHelp.Icon:SetPoint("CENTER",0,0)
hopAddon.buttonHelp.Icon:SetTexture("Interface\\QuestFrame\\QuestTypeIcons")
hopAddon.buttonHelp.Icon:SetTexCoord(unpack(QUEST_TAG_TCOORDS["COMPLETED"]))
-- override on enter, onhide event is inside template
hopAddon.buttonHelp:SetScript("OnClick", function(btn)
	if not HelpPlate_IsShowing(HoppingFrame_HelpPlate) and hopAddon.hopFrame:IsShown() then
		HelpPlate_Show(HoppingFrame_HelpPlate,hopAddon,hopAddon.buttonHelp,true)
	elseif not HelpPlate_IsShowing(SearchingFrame_HelpPlate) and hopAddon.searchFrame:IsShown() then
		HelpPlate_Show(SearchingFrame_HelpPlate,hopAddon,hopAddon.buttonHelp,true)		
	else
		HelpPlate_Hide(true)
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

hopAddon.buttonHelp:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT", 0, -25)
	GameTooltip:SetText(MAIN_HELP_BUTTON_TOOLTIP, 1, 1, 1, true)
	GameTooltip:Show()	
end)

-- close button in the topright corner
hopAddon.closeButton = CreateFrame("Button", nil, hopAddon,"BrowserButtonTemplate")
hopAddon.closeButton:SetSize(25,25)
hopAddon.closeButton:SetPoint("TOPRIGHT",-4,4)
hopAddon.closeButton.Icon = hopAddon.closeButton:CreateTexture(nil,"OVERLAY")
hopAddon.closeButton.Icon:SetSize(14,14)
hopAddon.closeButton.Icon:SetPoint("CENTER",0,0)
hopAddon.closeButton.Icon:SetTexture("Interface\\Buttons\\UI-StopButton")
hopAddon.closeButton:SetScript("OnClick", function(btn)
	hopAddon.favouritesFrame:Hide()
	hopAddon:Hide()
end)

local customOptions = hopAddon.optionsFrame.customSearchOptionsFrame

local function ServerHop_EventSystem(self, event, ...)
	local arg1 = ...
	if event == "ADDON_LOADED" and arg1 == "ServerHop" then	
		if ServerHopPosition ~= nil then
			hopAddon:ClearAllPoints()	
			hopAddon:SetPoint(ServerHopPosition[1],ServerHopPosition[2],ServerHopPosition[3])
			if ServerHopPosition[4] then
				hopAddon:Show()
			end
		end
		
		if ServerHopFavouritesList ~= nil then
			hopAddon.tables.searchFavourites = ServerHopFavouritesList
		end

		
		hopAddon.searchFrame.dropDown.activeValue = 6
		hopAddon.searchFrame.dropDown.text:SetText(C_LFGList.GetCategoryInfo(hopAddon.searchFrame.dropDown.activeValue))
		
		if ServerHopSettings ~= nil then
			SHtankButton.CheckButton:SetChecked(ServerHopSettings[1])
			SHdamagerButton.CheckButton:SetChecked(ServerHopSettings[2])
			SHhealerButton.CheckButton:SetChecked(ServerHopSettings[3])
			customOptions.soundCheckButton:SetChecked(ServerHopSettings[4])
			customOptions.endlessCheckBox:SetChecked(ServerHopSettings[5])
		
			if ServerHopSettings["NON_AUTO_GROUPS"] ~= nil then
				hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:SetChecked(ServerHopSettings["NON_AUTO_GROUPS"])
			end
			
			if hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked() then
				Slider_Enable(hopAddon.optionsFrame.hopSearchOptionsFrame.sliderQueueWait)
				HOPADDON_QUEUE_INTERVAL = 5
			else
				HOPADDON_QUEUE_INTERVAL = 5
			end

			if ServerHopSettings["NON_AUTO_GROUPS_WAIT"] ~= nil then
				hopAddon.optionsFrame.hopSearchOptionsFrame.sliderQueueWait:SetValue(ServerHopSettings["NON_AUTO_GROUPS_WAIT"])
			end
			
			if ServerHopSettings["BLACKLIST_DURATION"] ~= nil then
				hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:SetValue(ServerHopSettings["BLACKLIST_DURATION"])
			end
			
			if ServerHopSettings["STATUS_FRAME"] ~= nil and ServerHopSettings["STATUS_FRAME"] == false then
				hopAddon.optionsFrame.globalOptionsFrame.statusCheckButton:SetChecked(false)
				UIDropDownMenu_DisableDropDown(hopAddon.optionsFrame.globalOptionsFrame.statusFrameDrop)
			end
			if ServerHopSettings["STATUS_FRAME_POSITION"] ~= nil then
				UIDropDownMenu_SetSelectedID(hopAddon.optionsFrame.globalOptionsFrame.statusFrameDrop, ServerHopSettings["STATUS_FRAME_POSITION"])
				UIDropDownMenu_SetText(hopAddon.optionsFrame.globalOptionsFrame.statusFrameDrop, SH_statusFrameDropTable[ServerHopSettings["STATUS_FRAME_POSITION"]])
				
				hopAddon.SH_MoveStatusFrame(ServerHopSettings["STATUS_FRAME_POSITION"])
			end
			if ServerHopSettings["DEFAULT_MODE"] ~= nil and ServerHopSettings["DEFAULT_MODE"] == false then
				hopAddon.hopFrame:Show()
				hopAddon.searchFrame:Hide()
			end
			if ServerHopSettings["FLASH_TASKBAR"] ~= nil and ServerHopSettings["FLASH_TASKBAR"] == false then
				customOptions.taskbarOption:SetChecked(false)
			end
			if ServerHopSettings["HOP_TO_PVP"] ~= nil then
				UIDropDownMenu_SetSelectedID(hopAddon.hopFrame.pvpDrop, ServerHopSettings["HOP_TO_PVP"])
				UIDropDownMenu_SetText(hopAddon.hopFrame.pvpDrop, hopAddon_serverTypeDropTable[ServerHopSettings["HOP_TO_PVP"]])
			end
			if ServerHopSettings["MINIMAP_SETTINGS"] ~= nil then
				hopAddon.var.minimapDB.global.minimap = ServerHopSettings["MINIMAP_SETTINGS"]
				if ServerHopSettings["MINIMAP_SETTINGS"].hide == true then
					hopAddon.optionsFrame.globalOptionsFrame.MinimapCheckButton:SetChecked(false)
					UIDropDownMenu_DisableDropDown(hopAddon.optionsFrame.globalOptionsFrame.minimapStrataDrop)
					hopAddon.var.minimapDB.global.minimap = ServerHopSettings["MINIMAP_SETTINGS"]
					hopAddon.var.minimapDB.global.minimap.hide = false
					hopAddon_MiniMapInit()
					hopAddon.var.minimapDB.global.minimap.hide = true

				else
					hopAddon_MiniMapInit()
				end
			end
			
			if ServerHopSettings["MINIMAP_STRATA"] ~= nil then
				UIDropDownMenu_SetSelectedID(hopAddon.optionsFrame.globalOptionsFrame.minimapStrataDrop, ServerHopSettings["MINIMAP_STRATA"])
				UIDropDownMenu_SetText(hopAddon.optionsFrame.globalOptionsFrame.minimapStrataDrop, SH_minimapStrataDropTable[ServerHopSettings["MINIMAP_STRATA"]])
				if hopAddon.minimap.objects["ServerHop"] then
					hopAddon.minimap.objects["ServerHop"]:SetFrameStrata(SH_minimapStrataDropTable[ServerHopSettings["MINIMAP_STRATA"]])
				end
			end					
			
			if ServerHopSettings["CHAT_NOTIFICATIONS"] ~= nil then
				hopAddon.optionsFrame.globalOptionsFrame.chatNotifButton:SetChecked(ServerHopSettings["CHAT_NOTIFICATIONS"])
			end

			if ServerHopSettings["SHOW_ONLY_MY_ZONE"] ~= nil then
				hopAddon.hopList.OnlyMyZoneCheck:SetChecked(ServerHopSettings["SHOW_ONLY_MY_ZONE"])
			end
		else
			hopAddon_MiniMapInit()	
		end
		
		if ServerHopSettingsGlobal ~= nil then
			if ServerHopSettingsGlobal["HOST_ALERT_ON_ZONE"] ~= nil then
				hopAddon.optionsFrame.hostOptionsFrame.showAlertsZone:SetChecked(ServerHopSettingsGlobal["HOST_ALERT_ON_ZONE"])
			end

			if ServerHopSettingsGlobal["HOST_ALERT_ON_TIME"] ~= nil then
				hopAddon.optionsFrame.hostOptionsFrame.showAlertsTime:SetChecked(ServerHopSettingsGlobal["HOST_ALERT_ON_TIME"])
			end

			if ServerHopSettingsGlobal["HOST_ALERT_DESTINATION"] ~= nil then
				UIDropDownMenu_SetSelectedID(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop, ServerHopSettingsGlobal["HOST_ALERT_DESTINATION"])
				UIDropDownMenu_SetText(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop, SH_hostAlertsDropTable[ServerHopSettingsGlobal["HOST_ALERT_DESTINATION"]])
			end					

		end


	elseif event == "PLAYER_LOGIN" then
		C_LFGList.RequestAvailableActivities();
		hopAddon_GatherPvPRealms(GetCurrentRegion())
		hopAddon:GetZoneList()
		hopAddon.var.currentZone = hopAddon:GetMyZoneID()

		hopAddon_MiniMapAnim()
	elseif event == "PLAYER_LOGOUT" or event == "DISCONNECTED_FROM_SERVER" then
	
		local point, relativeTo, relativePoint, xOfs, yOfs = hopAddon:GetPoint()
		
		ServerHopPosition = {}
		
		ServerHopPosition[1]=point
		ServerHopPosition[2]=xOfs
		ServerHopPosition[3]=yOfs
		ServerHopPosition[4]=hopAddon:IsShown()

		ServerHopSettings = {}
		
		ServerHopSettings[1] = SHtankButton.CheckButton:GetChecked()
		ServerHopSettings[2] = SHdamagerButton.CheckButton:GetChecked()
		ServerHopSettings[3] = SHhealerButton.CheckButton:GetChecked()
		ServerHopSettings[4] = customOptions.soundCheckButton:GetChecked()
		ServerHopSettings[5] = customOptions.endlessCheckBox:GetChecked()
		
		ServerHopSettings["NON_AUTO_GROUPS"] = hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked()
		ServerHopSettings["NON_AUTO_GROUPS_WAIT"] = ceil(hopAddon.optionsFrame.hopSearchOptionsFrame.sliderQueueWait.value)
		ServerHopSettings["BLACKLIST_DURATION"] = hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime.value
		ServerHopSettings["STATUS_FRAME"] = hopAddon.optionsFrame.globalOptionsFrame.statusCheckButton:GetChecked()
		ServerHopSettings["STATUS_FRAME_POSITION"] = UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.globalOptionsFrame.statusFrameDrop)
		ServerHopSettings["DEFAULT_MODE"] = hopAddon.searchFrame:IsShown()
		ServerHopSettings["FLASH_TASKBAR"] = customOptions.taskbarOption:GetChecked()
		ServerHopSettings["HOP_TO_PVP"] = UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.pvpDrop)
		
		local position = hopAddon.var.minimapDB.global.minimap.minimapPos
		local visibility = not hopAddon.optionsFrame.globalOptionsFrame.MinimapCheckButton:GetChecked()
		local arr = {minimapPos = position,hide = visibility, }
		ServerHopSettings["MINIMAP_SETTINGS"] = arr
		ServerHopSettings["MINIMAP_STRATA"] = UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.globalOptionsFrame.minimapStrataDrop)

		ServerHopSettings["CHAT_NOTIFICATIONS"] = hopAddon.optionsFrame.globalOptionsFrame.chatNotifButton:GetChecked()
		
		ServerHopSettingsGlobal = {}
		ServerHopSettingsGlobal["HOST_ALERT_ON_ZONE"] = hopAddon.optionsFrame.hostOptionsFrame.showAlertsZone:GetChecked()
		ServerHopSettingsGlobal["HOST_ALERT_ON_TIME"] = hopAddon.optionsFrame.hostOptionsFrame.showAlertsTime:GetChecked()
		ServerHopSettingsGlobal["HOST_ALERT_DESTINATION"] = UIDropDownMenu_GetSelectedID(hopAddon.optionsFrame.hostOptionsFrame.hostAlertsDrop)

		ServerHopSettings["SHOW_ONLY_MY_ZONE"] = hopAddon.hopList.OnlyMyZoneCheck:GetChecked()

		ServerHopFavouritesList = hopAddon.tables.searchFavourites

	end
	
end


--Events
hopAddon:SetScript("OnEvent", ServerHop_EventSystem)
hopAddon:RegisterEvent("ADDON_LOADED")
hopAddon:RegisterEvent("PLAYER_LOGIN")
hopAddon:RegisterEvent("PLAYER_LOGOUT")
hopAddon:RegisterEvent("DISCONNECTED_FROM_SERVER")
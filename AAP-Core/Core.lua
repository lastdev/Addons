AAP = {}
AAP.Name = UnitName("player")
AAP.Realm = string.gsub(GetRealmName(), " ", "")
AAP.Faction = UnitFactionGroup("player")
AAP.Level = UnitLevel("player")
AAP.Class = {}
AAP.QuestStepList = {}
AAP.Heirlooms = 0
AAP.SweatBuff = {}
AAP.SweatBuff[1] = 0
AAP.SweatBuff[2] = 0
AAP.SweatBuff[3] = 0
AAP.RaceLocale, AAP.Race = UnitRace("player")
AAP.Class[1],AAP.Class[2],AAP.Class[3] = UnitClass("player")
AAP.QuestList = {}
AAP.NPCList = {}
AAP.Gender = UnitSex("player")
AAP.Icons = {}
AAP.MapIcons = {}
AAP.Breadcrums = {}
AAP.ActiveQuests = {}
AAP.RegisterChat = C_ChatInfo.RegisterAddonMessagePrefix("AAPChat")
AAP.LastSent = 0
AAP.GroupListSteps = {}
AAP.GroupListStepsNr = 1
AAP.Version = tonumber(GetAddOnMetadata("AAP-Core", "Version"))
local CoreLoadin = 0
AAP.AfkTimerVar = 0
AAP.QuestListLoadin = 0
AAP.ZoneTransfer = 0
AAP.BookingList = {}
AAP.MapZoneIcons = {}
AAP.MapZoneIconsRed = {}
AAP.SettingsOpen = 0
AAP.InCombat = 0
AAP.ProgressShown = 0
AAP.BookUpdAfterCombat = 0
AAP.QuestListShown = 0
AAP.MapLoaded = 0
AAP.WQActive = 0
AAP.WQSpecialActive = 0
AAP.Dinged60 = 0
AAP.Dinged60nr = 0
AAP.Dinged80 = 0
AAP.Dinged80nr = 0
AAP.Dinged90 = 0
AAP.Dinged90nr = 0
AAP.Dinged100 = 0
AAP.Dinged100nr = 0
AAP.Dinged110 = 0
AAP.Dinged1100nr = 0
AAP.ArrowActive = 0
AAP.ArrowActive_X = 0
AAP.ArrowActive_Y = 0
AAP.MiniMap_X = 0
AAP.MiniMap_Y = 0
AAP.MacroUpdaterVar = {}

local zzloaded, zzreason = LoadAddOn("AAP-Test")
if (zzloaded) then
		AAP.ErrorzFrame = CreateFrame("Frame")
		AAP_ErrorrzInTimer = AAP.ErrorzFrame:CreateAnimationGroup()
		AAP_ErrorrzInTimer.anim = AAP_ErrorrzInTimer:CreateAnimation()
		AAP_ErrorrzInTimer.anim:SetDuration(3)
		AAP_ErrorrzInTimer:SetLooping("REPEAT")
		AAP_ErrorrzInTimer:SetScript("OnLoop", function(self, event, ...)
			print("AAP-Core: Error - Please disable or delete: AAP-Test")
			print("AAP-Core: It will not be used anymore.")
			print("------------------------------------------")
		end)
		AAP_ErrorrzInTimer:Play()
end


function AAP.AutoPathOnBeta(ChoiceZ)
	local ZeMap = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	if (Enum and Enum.UIMapType and Enum.UIMapType.Continent and currentMapId) then
		ZeMap = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	end
	if (ZeMap and ZeMap["mapID"]) then
		ZeMap = ZeMap["mapID"]
	else
		ZeMap = C_Map.GetBestMapForUnit("player")
	end
	if (ChoiceZ == 1 and (ZeMap == 1409 or ZeMap == 1726 or ZeMap == 1727 or ZeMap == 1728) and AAP.Faction == "Alliance") then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
		for CLi = 1, 19 do
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"01-10 Exile's Reach")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(1/8) 10-50 Stormwind")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(2/8) 10-50 Tanaan Jungle")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(3/8) 10-50 Shadowmoon")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(4/8) 10-50 Gorgrond")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(5/8) 10-50 Talador")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(6/8) 10-50 Shadowmoon")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(7/8) 10-50 Talador")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(8/8) 10-50 Spires of Arak")
	elseif (ChoiceZ == 1 and AAP.Level < 50 and AAP.Level > 9 and AAP.Faction == "Alliance") then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
		for CLi = 1, 19 do
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(1/8) 10-50 Stormwind")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(2/8) 10-50 Tanaan Jungle")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(3/8) 10-50 Shadowmoon")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(4/8) 10-50 Gorgrond")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(5/8) 10-50 Talador")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(6/8) 10-50 Shadowmoon")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(7/8) 10-50 Talador")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(8/8) 10-50 Spires of Arak")
	elseif (ChoiceZ == 1 and (ZeMap == 1409 or ZeMap == 1726 or ZeMap == 1727 or ZeMap == 1728) and AAP.Faction == "Horde") then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
		for CLi = 1, 19 do
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"01-10 Exile's Reach")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(1/6) 10-50 Orgrimmar")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(2/6) 10-50 Tanaan Jungle")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(3/6) 10-50 Frostfire Ridge")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(4/6) 10-50 Gorgrond")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(5/6) 10-50 Talador")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(6/6) 10-50 Spires of Arak")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(7-extra) 10-50 Nagrand")
	elseif (ChoiceZ == 1 and AAP.Level < 50 and AAP.Level > 9 and AAP.Faction == "Horde") then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
		for CLi = 1, 19 do
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(1/6) 10-50 Orgrimmar")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(2/6) 10-50 Tanaan Jungle")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(3/6) 10-50 Frostfire Ridge")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(4/6) 10-50 Gorgrond")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(5/6) 10-50 Talador")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(6/6) 10-50 Spires of Arak")
		tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"(7-extra) 10-50 Nagrand")
	elseif (ZeMap == 1409 or ZeMap == 1726 or ZeMap == 1727) then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
	elseif (ChoiceZ == 1) then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
		for CLi = 1, 19 do
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
	elseif (ChoiceZ == 2) then
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
		AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
		for CLi = 1, 19 do
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(59770) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"50 The Maw Intro")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(59773) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"50-50 Oribos (Start-Bastion)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(60056) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"50-52 Bastion (Full)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(57386) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"52 Oribos (Bastion-Maldraxxus)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(59874) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"52-54 Maldraxxus (Full)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(59897) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"54 Oribos (Maldraxxus-Maw)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(61190) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"54-55 The Maw")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(59974) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"55 Oribos (Maw-Maldraxxus)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(60737) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"55-55 Maldraxxus")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(60338) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"56 Oribos (Maldrax-Ardenw)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(58724) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"56-57 Ardenweald (Full)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(57025) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"57 Oribos (Ardenw-Revend)")
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(57689) == false) then
			tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],"57-60 Revendreth (Full)")
		end
	end
	for CLi = 1, 19 do
		if (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]) then
			if (AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]]) then
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
			else
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText(AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi])
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Show()
			end
		else
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
	end
	AAP1[AAP.Realm][AAP.Name]["Settings"]["Beta1"] = 1
	AAP.RoutePlanCheckPos()
	AAP.CheckPosMove()
	AAP.BookingList["UpdateMapId"] = 1
end
function AAP.getContinent()
	if (AAP1["Debug"]) then
		print("Function: AAP.getContinent()")
	end
    local mapID = C_Map.GetBestMapForUnit("player")
	if (mapID == 378) then
		return 378
    elseif(mapID) then
        local info = C_Map.GetMapInfo(mapID)
        if(info) then
            while(info and info['mapType'] and info['mapType'] > 2) do
                info = C_Map.GetMapInfo(info['parentMapID'])
            end
            if(info and info['mapType'] == 2) then
                return info['mapID']
            end
        end
    end
end
BINDING_HEADER_AzerothAutoPilot = "Azeroth Auto Pilot"
BINDING_NAME_AAP_MACRO = "Quest Item 1"
AAP.AfkFrame = CreateFrame("frame", "AAP_AfkFrames", UIParent)
AAP.AfkFrame:SetWidth(190)
AAP.AfkFrame:SetHeight(40)
AAP.AfkFrame:SetPoint("CENTER", UIParent, "CENTER",0,150)
AAP.AfkFrame:EnableMouse(true)
AAP.AfkFrame:SetMovable(true)

local t = AAP.AfkFrame:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.AfkFrame)
AAP.AfkFrame.texture = t

AAP.AfkFrame:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		AAP.AfkFrame:StartMoving();
		AAP.AfkFrame.isMoving = true;
	end
end)
AAP.AfkFrame:SetScript("OnMouseUp", function(self, button)
	if button == "LeftButton" and AAP.AfkFrame.isMoving then
		AAP.AfkFrame:StopMovingOrSizing();
		AAP.AfkFrame.isMoving = false;
	end
end)
AAP.AfkFrame:SetScript("OnHide", function(self)
	if ( AAP.AfkFrame.isMoving ) then
		AAP.AfkFrame:StopMovingOrSizing();
		AAP.AfkFrame.isMoving = false;
	end
end)
AAP.AfkFrame.Fontstring = AAP.AfkFrame:CreateFontString("AAPAFkFont","ARTWORK", "ChatFontNormal")
AAP.AfkFrame.Fontstring:SetParent(AAP.AfkFrame)
AAP.AfkFrame.Fontstring:SetPoint("LEFT", AAP.AfkFrame, "LEFT", 10, 0)
AAP.AfkFrame.Fontstring:SetFontObject("GameFontNormalLarge")
AAP.AfkFrame.Fontstring:SetText("AFK:")
AAP.AfkFrame.Fontstring:SetJustifyH("LEFT")
AAP.AfkFrame.Fontstring:SetTextColor(1, 1, 0)
AAP.AfkFrame:Hide()
local PlayMovie_hook = MovieFrame_PlayMovie

MovieFrame_PlayMovie = function(...)

	if (IsControlKeyDown() or (AAP1[AAP.Realm][AAP.Name]["Settings"]["CutScene"] == 0)) then

		PlayMovie_hook(...)

	else
		print("AAP: "..AAP_Locals["Skipped cutscene"])
		GameMovieFinished()

	end

end
function AAP.AFK_Timer(AAP_AFkTimeh)
	AAP.AfkTimerVar = AAP_AFkTimeh + floor(GetTime())
	AAP.ArrowEventAFkTimer:Play()
end
function AAP.pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
     end
     return iter
end
function AAP.ResetSettings()
	AAP1[AAP.Realm][AAP.Name]["Settings"] = {}
	AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = 150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = -150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = 150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = -150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"] = UIParent:GetScale()
	AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["Hide"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["alpha"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"] = 150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"] = -150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["Hcampleft"] = 150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["Hcamptop"] = -150
	AAP1[AAP.Realm][AAP.Name]["Settings"]["CutScene"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ChooseQuests"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"] = UIParent:GetScale()
	AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandInChoice"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoVendor"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoRepair"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowGroup"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["BannerShow"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowBlobs"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["LockArrow"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"] = 2
	AAP1[AAP.Realm][AAP.Name]["Settings"]["DisableHeirloomWarning"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["MiniMapBlobAlpha"] = 1
	AAP1[AAP.Realm][AAP.Name]["Settings"]["OrderListScale"] = 1
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 0) then
		AAP.OptionsFrame.ShowQListCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.ShowQListCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowGroup"] == 0) then
		AAP.OptionsFrame.ShowGroupCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.ShowGroupCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] == 0) then
		AAP.OptionsFrame.AutoGossipCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.AutoGossipCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoVendor"] == 0) then
		AAP.OptionsFrame.AutoVendorCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.AutoVendorCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoRepair"] == 0) then
		AAP.OptionsFrame.AutoRepairCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.AutoRepairCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] == 0) then
		AAP.OptionsFrame.LockQuestListCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.LockQuestListCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["CutScene"] == 0) then
		AAP.OptionsFrame.CutSceneCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.CutSceneCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] == 0) then
		AAP.OptionsFrame.AutoAcceptCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.AutoAcceptCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] == 0) then
		AAP.OptionsFrame.AutoHandInCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.AutoHandInCheckButton:SetChecked(true)
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandInChoice"] == 0) then
		AAP.OptionsFrame.AutoHandInChoiceCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.AutoHandInChoiceCheckButton:SetChecked(true)
	end
	
	AAP.QuestList.ButtonParent:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"])
	AAP.QuestList.ListFrame:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"])
	AAP.QuestList21:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"])
	AAP.OptionsFrame.QuestListScaleSlider:SetValue(AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"] * 100)
	AAP.OptionsFrame.ArrowScaleSlider:SetValue(AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"] * 100)

	AAP.QuestList.MainFrame:ClearAllPoints()
	AAP.QuestList.MainFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
	AAP.ArrowFrame:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"])
	AAP.ArrowFrameM:ClearAllPoints()
	AAP.ArrowFrameM:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"])
	AAP.ZoneQuestOrder:ClearAllPoints()
	AAP.ZoneQuestOrder:SetPoint("CENTER", UIParent, "CENTER",1,1)
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"] = UIParent:GetScale()
	AAP1[AAP.Realm][AAP.Name]["Settings"]["LockArrow"] = 0
	AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"] = 2
	AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"] = GetScreenWidth() / 2.05
	AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"] = -(GetScreenHeight() / 1.5)
	AAP.ArrowFrame:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"])
	AAP.ArrowFrameM:ClearAllPoints()
	AAP.ArrowFrameM:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"])
	AAP.OptionsFrame.ArrowFpsSlider:SetValue(AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"])
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["LockArrow"] == 0) then
		AAP.OptionsFrame.LockArrowCheckButton:SetChecked(false)
	else
		AAP.OptionsFrame.LockArrowCheckButton:SetChecked(true)
	end
	AAP.OptionsFrame.ArrowScaleSlider:SetValue(AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"] * 100)
end
local function AAP_SlashCmd(AAP_index)
	if (AAP_index == "reset") then
		print("AAP: Resetting Zone.")
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = 1
		AAP.BookingList["UpdateQuest"] = 1
		AAP.BookingList["PrintQStep"] = 1
	elseif (AAP_index == "skip") then
		print("AAP: Skipping QuestStep.")
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
		AAP.BookingList["UpdateQuest"] = 1
		AAP.BookingList["PrintQStep"] = 1
	elseif (AAP_index == "skipcamp") then
		print("AAP: Skipping CampStep.")
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 14
		AAP.BookingList["UpdateQuest"] = 1
		AAP.BookingList["PrintQStep"] = 1
	else
		AAP.SettingsOpen = 1
		AAP.OptionsFrame.MainFrame:Show()
		AAP.RemoveIcons()
		AAP.BookingList["OpenedSettings"] = 1
	end
end
	
AAP.ArrowFrameM = CreateFrame("Button", "AAP_Arrow", UIParent)
AAP.ArrowFrameM:SetHeight(1)
AAP.ArrowFrameM:SetWidth(1)
AAP.ArrowFrameM:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
AAP.ArrowFrameM:EnableMouse(true)
AAP.ArrowFrameM:SetMovable(true)

AAP.ArrowFrame = CreateFrame("Button", "AAP_Arrow", UIParent)
AAP.ArrowFrame:SetHeight(42)
AAP.ArrowFrame:SetWidth(56)
AAP.ArrowFrame:SetPoint("TOPLEFT", AAP.ArrowFrameM, "TOPLEFT", 0, 0)
AAP.ArrowFrame:EnableMouse(true)
AAP.ArrowFrame:SetMovable(true)
AAP.ArrowFrame.arrow = AAP.ArrowFrame:CreateTexture(nil, "OVERLAY")
AAP.ArrowFrame.arrow:SetTexture("Interface\\Addons\\AAP-Core\\Img\\Arrow.blp")
AAP.ArrowFrame.arrow:SetAllPoints()
AAP.ArrowFrame.distance = AAP.ArrowFrame:CreateFontString("ARTWORK", "ChatFontNormal")
AAP.ArrowFrame.distance:SetFontObject("GameFontNormalSmall")
AAP.ArrowFrame.distance:SetPoint("TOP", AAP.ArrowFrame, "BOTTOM", 0, 0)
AAP.ArrowFrame:Hide()
AAP.ArrowFrame:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" and not AAP.ArrowFrameM.isMoving and AAP1[AAP.Realm][AAP.Name]["Settings"]["LockArrow"] == 0 then
		AAP.ArrowFrameM:StartMoving();
		AAP.ArrowFrameM.isMoving = true;
	end
end)
AAP.ArrowFrame:SetScript("OnMouseUp", function(self, button)
	if button == "LeftButton" and AAP.ArrowFrameM.isMoving then
		AAP.ArrowFrameM:StopMovingOrSizing();
		AAP.ArrowFrameM.isMoving = false;
		AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"] = AAP.ArrowFrameM:GetLeft()
		AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"] = AAP.ArrowFrameM:GetTop() - GetScreenHeight()
		AAP.ArrowFrameM:ClearAllPoints()
		AAP.ArrowFrameM:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"])
	end
end)
AAP.ArrowFrame:SetScript("OnHide", function(self)
	if ( AAP.ArrowFrameM.isMoving ) then
		AAP.ArrowFrameM:StopMovingOrSizing();
		AAP.ArrowFrameM.isMoving = false;
		AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"] = AAP.ArrowFrameM:GetLeft()
		AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"] = AAP.ArrowFrameM:GetTop() - GetScreenHeight()
		AAP.ArrowFrameM:ClearAllPoints()
		AAP.ArrowFrameM:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"])
	end
end)

AAP.ArrowFrame.Button = CreateFrame("Button", "AAP_ArrowActiveButton", AAP_ArrowFrame)
AAP.ArrowFrame.Button:SetWidth(85)
AAP.ArrowFrame.Button:SetHeight(17)
AAP.ArrowFrame.Button:SetParent(AAP.ArrowFrame)
AAP.ArrowFrame.Button:SetPoint("BOTTOM", AAP.ArrowFrame, "BOTTOM", 0, -30)
AAP.ArrowFrame.Button:SetScript("OnMouseDown", function(self, button)
	AAP.ArrowFrame.Button:Hide()
	print("AAP: Skipping Waypoint")
	AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
	AAP.ArrowActive_X = 0
	AAP.ArrowActive_Y = 0
	AAP.BookingList["UpdateQuest"] = 1
	AAP.BookingList["PrintQStep"] = 1
end)

local t = AAP.ArrowFrame.Button:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
t:SetAllPoints(AAP.ArrowFrame.Button)
AAP.ArrowFrame.Button.texture = t

AAP.ArrowFrame.Fontstring = AAP.ArrowFrame:CreateFontString("CLSettingsFS2212","ARTWORK", "ChatFontNormal")
AAP.ArrowFrame.Fontstring:SetParent(AAP.ArrowFrame.Button)
AAP.ArrowFrame.Fontstring:SetPoint("CENTER", AAP.ArrowFrame.Button, "CENTER", 0, 0)

AAP.ArrowFrame.Fontstring:SetFontObject("GameFontNormalSmall")
AAP.ArrowFrame.Fontstring:SetText("Skip waypoint")
AAP.ArrowFrame.Fontstring:SetTextColor(1, 1, 0)
AAP.ArrowFrame.Button:Hide()


function AAP.RoutePlanLoadIn()

	if (AAP1["Debug"]) then
		print("Function: AAP.RoutePlanLoadIn()")
	end

	AAP.LoadInOptionFrame = CreateFrame("frame", "AAP_LoadInOptionFrame", UIParent)
	AAP.LoadInOptionFrame:SetWidth(350)
	AAP.LoadInOptionFrame:SetHeight(130)
	AAP.LoadInOptionFrame:SetMovable(true)
	AAP.LoadInOptionFrame:EnableMouse(true)
	AAP.LoadInOptionFrame:SetFrameStrata("LOW")
	AAP.LoadInOptionFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
	local t = AAP.LoadInOptionFrame:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.LoadInOptionFrame)
	AAP.LoadInOptionFrame.texture = t

	AAP.LoadInOptionFrame:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				AAP.LoadInOptionFrame:StartMoving();
				AAP.LoadInOptionFrame.isMoving = true;
			end
	end)
	AAP.LoadInOptionFrame:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and AAP.LoadInOptionFrame.isMoving then
			AAP.LoadInOptionFrame:StopMovingOrSizing();
			AAP.LoadInOptionFrame.isMoving = false;
		end
	end)
	AAP.LoadInOptionFrame:SetScript("OnHide", function(self)
		if ( AAP.LoadInOptionFrame.isMoving ) then
			AAP.LoadInOptionFrame:StopMovingOrSizing();
			AAP.LoadInOptionFrame.isMoving = false;
		end
	end)
	AAP.LoadInOptionFrame["FS"] = AAP.LoadInOptionFrame:CreateFontString("AAP_LoadInOptionFrameFS","ARTWORK", "ChatFontNormal")
	AAP.LoadInOptionFrame["FS"]:SetParent(AAP.LoadInOptionFrame)
	AAP.LoadInOptionFrame["FS"]:SetPoint("TOP",AAP.LoadInOptionFrame,"TOP",0,0)
	AAP.LoadInOptionFrame["FS"]:SetWidth(165)
	AAP.LoadInOptionFrame["FS"]:SetHeight(20)
	AAP.LoadInOptionFrame["FS"]:SetJustifyH("CENTER")
	AAP.LoadInOptionFrame["FS"]:SetFontObject("GameFontNormalLarge")
	AAP.LoadInOptionFrame["FS"]:SetText("AAP: Pick Route")
	AAP.LoadInOptionFrame["B1"] = CreateFrame("Button", "AAP_LoadInOptionFrameButton1", AAP.LoadInOptionFrame, "UIPanelButtonTemplate")
	AAP.LoadInOptionFrame["B1"]:SetWidth(140)
	AAP.LoadInOptionFrame["B1"]:SetHeight(30)
	AAP.LoadInOptionFrame["B1"]:SetText("Speed Run")
	AAP.LoadInOptionFrame["B1"]:SetPoint("TOPLEFT", AAP.LoadInOptionFrame, "TOPLEFT", 20, -35)
	AAP.LoadInOptionFrame["B1"]:SetNormalFontObject("GameFontNormalLarge")
	AAP.LoadInOptionFrame["B1"]:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			AAP.AutoPathOnBeta(1)
			AAP.LoadInOptionFrame:Hide()
		end
	end)
	
	AAP.LoadInOptionFrame["B2"] = CreateFrame("Button", "AAP_LoadInOptionFrameButton2", AAP.LoadInOptionFrame, "UIPanelButtonTemplate")
	AAP.LoadInOptionFrame["B2"]:SetWidth(140)
	AAP.LoadInOptionFrame["B2"]:SetHeight(30)
	AAP.LoadInOptionFrame["B2"]:SetText("All Quests")
AAP.LoadInOptionFrame["B2"]:Hide()
	AAP.LoadInOptionFrame["B2"]:SetPoint("TOPRIGHT", AAP.LoadInOptionFrame, "TOPRIGHT", -20, -35)
	AAP.LoadInOptionFrame["B2"]:SetNormalFontObject("GameFontNormalLarge")
	AAP.LoadInOptionFrame["B2"]:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			AAP.AutoPathOnBeta(2)
			AAP.LoadInOptionFrame:Hide()
		end
	end)
	AAP.LoadInOptionFrame["B3"] = CreateFrame("Button", "AAP_LoadInOptionFrameButton3", AAP.LoadInOptionFrame, "UIPanelButtonTemplate")
	AAP.LoadInOptionFrame["B3"]:SetWidth(140)
	AAP.LoadInOptionFrame["B3"]:SetHeight(30)
	AAP.LoadInOptionFrame["B3"]:SetText("Custom Path")
	AAP.LoadInOptionFrame["B3"]:SetPoint("BOTTOM", AAP.LoadInOptionFrame, "BOTTOM", 0, 25)
	AAP.LoadInOptionFrame["B3"]:SetNormalFontObject("GameFontNormalLarge")
	AAP.LoadInOptionFrame["B3"]:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			AAP.RoutePlan.FG1:Show()
			AAP.LoadInOptionFrame:Hide()
		end
	end)
	



	AAP.RoutePlan = CreateFrame("frame", "AAP.RoutePlanMainFraexg1", UIParent)
	AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
	AAP.RoutePlan:SetWidth(1)
	AAP.RoutePlan:SetHeight(1)
	AAP.RoutePlan:SetMovable(true)
	AAP.RoutePlan:EnableMouse(true)
	AAP.RoutePlan:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1 = CreateFrame("frame", "AAP.RoutePlanMainFramexg1", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1:SetWidth(1)
	AAP.RoutePlan.FG1:SetHeight(1)
	AAP.RoutePlan.FG1:SetMovable(true)
	AAP.RoutePlan.FG1:EnableMouse(true)
	AAP.RoutePlan.FG1:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1:SetPoint("TOPLEFT", AAP.RoutePlan, "TOPLEFT", 0, 0)
	AAP.RoutePlan.FG1:SetScale(0.9)
	
	AAP.RoutePlan.FG1.F22 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame3", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.F22:SetWidth(165)
	AAP.RoutePlan.FG1.F22:SetHeight(275)
	AAP.RoutePlan.FG1.F22:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.F22:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 165, 0)
	local t = AAP.RoutePlan.FG1.F22:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.F22)
	AAP.RoutePlan.FG1.F22.texture = t

	AAP.RoutePlan.FG1.F22:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
				AAP.RoutePlan:ClearAllPoints()
				AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
			end
	end)
	AAP.RoutePlan.FG1.F22:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.F22:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	


	AAP.RoutePlan.FG1.xg2 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame3x2", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.xg2:SetWidth(165)
	AAP.RoutePlan.FG1.xg2:SetHeight(275)
	AAP.RoutePlan.FG1.xg2:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.xg2:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 0, 0)

	local t = AAP.RoutePlan.FG1.xg2:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.xg2)
	AAP.RoutePlan.FG1.xg2.texture = t

	AAP.RoutePlan.FG1.xg2:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
				AAP.RoutePlan:ClearAllPoints()
				AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
			end
	end)
	AAP.RoutePlan.FG1.xg2:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.xg2:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	
	
	
		AAP.RoutePlan.FG1.HelpText = CreateFrame("frame", "AAP.RoutePlanMainFsramex2xxxshlp", AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1.HelpText:SetWidth(250)
		AAP.RoutePlan.FG1.HelpText:SetHeight(20)
		AAP.RoutePlan.FG1.HelpText:SetMovable(true)
		AAP.RoutePlan.FG1.HelpText:EnableMouse(true)
		AAP.RoutePlan.FG1.HelpText:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1.HelpText:SetResizable(true)
		AAP.RoutePlan.FG1.HelpText:SetScale(0.7)
		AAP.RoutePlan.FG1.HelpText:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1.xg2, "BOTTOMLEFT", 20,-15)
		--AAP.RoutePlan.FG1["Fxz"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
		local t = AAP.RoutePlan.FG1.HelpText:CreateTexture(nil,"BACKGROUND")
		t:SetTexture("Interface\\Buttons\\WHITE8X8")
		t:SetAllPoints(AAP.RoutePlan.FG1.HelpText)
		t:SetColorTexture(0.1,0.1,0.4,1)
		AAP.RoutePlan.FG1.HelpText.texture = t
		AAP.RoutePlan.FG1.HelpText.FS = AAP.RoutePlan.FG1.HelpText:CreateFontString("AAP.RoutePlan_Fx3x_FFGs1Shlp","ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1.HelpText.FS:SetParent(AAP.RoutePlan.FG1.HelpText)
		AAP.RoutePlan.FG1.HelpText.FS:SetPoint("TOP",AAP.RoutePlan.FG1.HelpText,"TOP",0,1)
		AAP.RoutePlan.FG1.HelpText.FS:SetWidth(250)
		AAP.RoutePlan.FG1.HelpText.FS:SetHeight(20)
		AAP.RoutePlan.FG1.HelpText.FS:SetJustifyH("CENTER")
		AAP.RoutePlan.FG1.HelpText.FS:SetFontObject("GameFontNormal")
		AAP.RoutePlan.FG1.HelpText.FS:SetText("Right-click or drag to move routes")
	
	
	
	
	AAP.RoutePlan.FG1.F24 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame4", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.F24:SetWidth(165)
	AAP.RoutePlan.FG1.F24:SetHeight(275)
	AAP.RoutePlan.FG1.F24:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.F24:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 495, 0)

	local t = AAP.RoutePlan.FG1.F24:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.F24)
	AAP.RoutePlan.FG1.F24.texture = t

	AAP.RoutePlan.FG1.F24:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
				AAP.RoutePlan:ClearAllPoints()
				AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
			end
	end)
	AAP.RoutePlan.FG1.F24:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.F24:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	
	

	AAP.RoutePlan.FG1.xg3 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame3x3", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.xg3:SetWidth(165)
	AAP.RoutePlan.FG1.xg3:SetHeight(275)
	AAP.RoutePlan.FG1.xg3:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.xg3:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 330, 0)

	local t = AAP.RoutePlan.FG1.xg3:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.xg3)
	AAP.RoutePlan.FG1.xg3.texture = t

	AAP.RoutePlan.FG1.xg3:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
				AAP.RoutePlan:ClearAllPoints()
				AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
			end
	end)
	AAP.RoutePlan.FG1.xg3:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.xg3:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)

	AAP.RoutePlan.FG1.F23 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame13", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.F23:SetWidth(165)
	AAP.RoutePlan.FG1.F23:SetHeight(20)
	AAP.RoutePlan.FG1.F23:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.F23:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 330, 0)

	local t = AAP.RoutePlan.FG1.F23:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.F23)
	AAP.RoutePlan.FG1.F23.texture = t

	AAP.RoutePlan.FG1.F23:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
			end
	end)
	AAP.RoutePlan.FG1.F23:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.F23:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	AAP.RoutePlan.FG1.F23["FS"] = AAP.RoutePlan.FG1.F23:CreateFontString("AAP.RoutePlan_Fxx3x_FFGs1S","ARTWORK", "ChatFontNormal")
	AAP.RoutePlan.FG1.F23["FS"]:SetParent(AAP.RoutePlan.FG1.F23)
	AAP.RoutePlan.FG1.F23["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1.F23,"TOP",0,0)
	AAP.RoutePlan.FG1.F23["FS"]:SetWidth(165)
	AAP.RoutePlan.FG1.F23["FS"]:SetHeight(20)
	AAP.RoutePlan.FG1.F23["FS"]:SetJustifyH("CENTER")
	AAP.RoutePlan.FG1.F23["FS"]:SetFontObject("GameFontNormal")
	AAP.RoutePlan.FG1.F23["FS"]:SetText("Eastern Kingdoms")
	AAP.RoutePlan.FG1.Fx1 = CreateFrame("frame", "AAP.RoutePlanMainFr22amex1", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.Fx1:SetWidth(165)
	AAP.RoutePlan.FG1.Fx1:SetHeight(20)
	AAP.RoutePlan.FG1.Fx1:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.Fx1:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 165, 0)

	local t = AAP.RoutePlan.FG1.Fx1:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.Fx1)
	AAP.RoutePlan.FG1.Fx1.texture = t

	AAP.RoutePlan.FG1.Fx1:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
			end
	end)
	AAP.RoutePlan.FG1.Fx1:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.Fx1:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	AAP.RoutePlan.FG1.Fx1["FS"] = AAP.RoutePlan.FG1.Fx1:CreateFontString("AAP.RoutePlan_Fxx3x_FFGs1Sx1","ARTWORK", "ChatFontNormal")
	AAP.RoutePlan.FG1.Fx1["FS"]:SetParent(AAP.RoutePlan.FG1.Fx1)
	AAP.RoutePlan.FG1.Fx1["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1.Fx1,"TOP",0,0)
	AAP.RoutePlan.FG1.Fx1["FS"]:SetWidth(165)
	AAP.RoutePlan.FG1.Fx1["FS"]:SetHeight(20)
	AAP.RoutePlan.FG1.Fx1["FS"]:SetJustifyH("CENTER")
	AAP.RoutePlan.FG1.Fx1["FS"]:SetFontObject("GameFontNormal")
	AAP.RoutePlan.FG1.Fx1["FS"]:SetText("Kalimdor")




	AAP.RoutePlan.FG1.Fx2x2 = CreateFrame("frame", "AAP.RoutePlanMainFr22amex2x2", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.Fx2x2:SetWidth(165)
	AAP.RoutePlan.FG1.Fx2x2:SetHeight(20)
	AAP.RoutePlan.FG1.Fx2x2:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.Fx2x2:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 495, 0)

	AAP.RoutePlan.FG1.Fx2 = CreateFrame("frame", "AAP.RoutePlanMainFr22amex2", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.Fx2:SetWidth(165)
	AAP.RoutePlan.FG1.Fx2:SetHeight(20)
	AAP.RoutePlan.FG1.Fx2:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.Fx2:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 495, 0)

	local t = AAP.RoutePlan.FG1.Fx2:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.Fx2)
	AAP.RoutePlan.FG1.Fx2.texture = t

	AAP.RoutePlan.FG1.Fx2:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
			end
	end)
	AAP.RoutePlan.FG1.Fx2:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.Fx2:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	AAP.RoutePlan.FG1.Fx2["FS"] = AAP.RoutePlan.FG1.Fx2:CreateFontString("AAP.RoutePlan_Fxx3x_FFGs1Sx1","ARTWORK", "ChatFontNormal")
	AAP.RoutePlan.FG1.Fx2["FS"]:SetParent(AAP.RoutePlan.FG1.Fx2)
	AAP.RoutePlan.FG1.Fx2["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1.Fx2,"TOP",0,0)
	AAP.RoutePlan.FG1.Fx2["FS"]:SetWidth(165)
	AAP.RoutePlan.FG1.Fx2["FS"]:SetHeight(20)
	AAP.RoutePlan.FG1.Fx2["FS"]:SetJustifyH("CENTER")
	AAP.RoutePlan.FG1.Fx2["FS"]:SetFontObject("GameFontNormal")
	AAP.RoutePlan.FG1.Fx2["FS"]:SetText("Shadowlands")



----------------------- SpeedFrame Start ---------------


	AAP.RoutePlan.FG1.F26 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame411", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.F26:SetWidth(165)
	AAP.RoutePlan.FG1.F26:SetHeight(275)
	AAP.RoutePlan.FG1.F26:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.F26:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 660, 0)

	local t = AAP.RoutePlan.FG1.F26:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.F26)
	AAP.RoutePlan.FG1.F26.texture = t

	AAP.RoutePlan.FG1.F26:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
				AAP.RoutePlan:ClearAllPoints()
				AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
			end
	end)
	AAP.RoutePlan.FG1.F26:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.F26:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	AAP.RoutePlan.FG1.F25x3 = CreateFrame("frame", "AAP.RoutePlanMainFr22ameF25x2", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.F25x3:SetWidth(165)
	AAP.RoutePlan.FG1.F25x3:SetHeight(20)
	AAP.RoutePlan.FG1.F25x3:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.F25x3:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 660, 0)
	
	AAP.RoutePlan.FG1.F25 = CreateFrame("frame", "AAP.RoutePlanMainFr22ame3x1", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.F25:SetWidth(165)
	AAP.RoutePlan.FG1.F25:SetHeight(20)
	AAP.RoutePlan.FG1.F25:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.F25:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 660, 0)
	AAP.RoutePlan.FG1.F25:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
				AAP.RoutePlan:ClearAllPoints()
				AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
			end
	end)
	AAP.RoutePlan.FG1.F25:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.F25:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	
	AAP.RoutePlan.FG1.Fx3 = CreateFrame("frame", "AAP.RoutePlanMainFr22amex3", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.Fx3:SetWidth(165)
	AAP.RoutePlan.FG1.Fx3:SetHeight(20)
	AAP.RoutePlan.FG1.Fx3:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.Fx3:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 660, 0)

	local t = AAP.RoutePlan.FG1.Fx3:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.Fx3)
	AAP.RoutePlan.FG1.Fx3.texture = t

	AAP.RoutePlan.FG1.Fx3:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
			end
	end)
	AAP.RoutePlan.FG1.Fx3:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.Fx3:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	AAP.RoutePlan.FG1.Fx3["FS"] = AAP.RoutePlan.FG1.Fx3:CreateFontString("AAP.RoutePlan_Fxx3x_FFGs1Sx3","ARTWORK", "ChatFontNormal")
	AAP.RoutePlan.FG1.Fx3["FS"]:SetParent(AAP.RoutePlan.FG1.Fx3)
	AAP.RoutePlan.FG1.Fx3["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1.Fx3,"TOP",0,0)
	AAP.RoutePlan.FG1.Fx3["FS"]:SetWidth(165)
	AAP.RoutePlan.FG1.Fx3["FS"]:SetHeight(20)
	AAP.RoutePlan.FG1.Fx3["FS"]:SetJustifyH("CENTER")
	AAP.RoutePlan.FG1.Fx3["FS"]:SetFontObject("GameFontNormal")
	AAP.RoutePlan.FG1.Fx3["FS"]:SetText("Speed Runs")

	local zenr = AAP.NumbRoutePlan("SpeedRun")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fx3z"..CLi] = CreateFrame("frame", "AAP.RoutePlanMainFsramex2x3xxs"..CLi, AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetHeight(20)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetMovable(true)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:EnableMouse(true)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetResizable(true)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetScale(0.7)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 0, -(20*CLi))
		--AAP.RoutePlan.FG1["Fx3z"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});


local t = AAP.RoutePlan.FG1["Fx3z"..CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.RoutePlan.FG1["Fx3z"..CLi])
t:SetColorTexture(0.1,0.1,0.4,1)
AAP.RoutePlan.FG1["Fx3z"..CLi].texture = t

		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					AAP.RoutePlan.FG1["Fx3z"..CLi]:StartMoving();
					AAP.RoutePlan.FG1["Fx3z"..CLi].isMoving = true;
				elseif button == "RightButton" then
					local zenew = getn(AAP_Custom[AAP.Name.."-"..AAP.Realm]) + 1
					if (zenew < 19 or zenew == 19) then
						tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]["FS"]:SetText(AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]:Show()
					end
					AAP.RoutePlanCheckPos()
					AAP.CheckCustomEmpty()
				end
		end)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.RoutePlan.FG1["Fx3z"..CLi].isMoving then
				AAP.RoutePlan.FG1["Fx3z"..CLi]:StopMovingOrSizing();
				AAP.RoutePlan.FG1["Fx3z"..CLi].isMoving = false;
				AAP.CheckPosMove(5)
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
			end
		end)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetScript("OnHide", function(self)
			if ( AAP.RoutePlan.FG1.isMoving ) then
				AAP.RoutePlan.FG1:StopMovingOrSizing();
				AAP.RoutePlan.FG1.isMoving = false;
			end
		end)
		--AAP.RoutePlan.FG1["Fx3z"..CLi]:SetBackdropColor(0.1,0.1,0.4,1)
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"] = AAP.RoutePlan.FG1["Fx3z"..CLi]:CreateFontString("AAP.RoutePlan_Fx3x_FFGs3S"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetParent(AAP.RoutePlan.FG1["Fx3z"..CLi])
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1["Fx3z"..CLi],"TOP",0,1)
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetWidth(210)
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetHeight(20)
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetJustifyH("LEFT")
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetFontObject("GameFontNormal")
		AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:SetText("")
	end




----------------------- SpeedFrame End ---------------



	AAP.RoutePlan.FG1["CloseButton"] = CreateFrame("Button", "AAP_RoutePlan_FG1_CloseButton", AAP.RoutePlan.FG1, "UIPanelButtonTemplate")
	AAP.RoutePlan.FG1["CloseButton"]:SetWidth(25)
	AAP.RoutePlan.FG1["CloseButton"]:SetHeight(25)
	AAP.RoutePlan.FG1["CloseButton"]:SetText("X")
	AAP.RoutePlan.FG1["CloseButton"]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1, "TOPRIGHT", 840, 25)
	AAP.RoutePlan.FG1["CloseButton"]:SetNormalFontObject("GameFontNormalLarge")
	AAP.RoutePlan.FG1["CloseButton"]:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			AAP.RoutePlan.FG1:Hide()
		end
	end)
AAP.RoutePlan.FG1:Hide()



	AAP.RoutePlan.FG1.Fx0 = CreateFrame("frame", "AAP.RoutePlanMainFr22amex0", AAP.RoutePlan.FG1)
	AAP.RoutePlan.FG1.Fx0:SetWidth(165)
	AAP.RoutePlan.FG1.Fx0:SetHeight(20)
	AAP.RoutePlan.FG1.Fx0:SetFrameStrata("LOW")
	AAP.RoutePlan.FG1.Fx0:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1, "BOTTOMLEFT", 0, 0)

	local t = AAP.RoutePlan.FG1.Fx0:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	t:SetAllPoints(AAP.RoutePlan.FG1.Fx0)
	AAP.RoutePlan.FG1.Fx0.texture = t

	AAP.RoutePlan.FG1.Fx0:SetScript("OnMouseDown", function(self, button)
			if button == "RightButton" then
				AAP.RoutePlan:StartMoving();
				AAP.RoutePlan.isMoving = true;
			else
				AAP.RoutePlan:StopMovingOrSizing();
				AAP.RoutePlan.isMoving = false;
			end
	end)
	AAP.RoutePlan.FG1.Fx0:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" and AAP.RoutePlan.isMoving then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
			AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = AAP.RoutePlan:GetLeft()
			AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = AAP.RoutePlan:GetTop() - GetScreenHeight()
			AAP.RoutePlan:ClearAllPoints()
			AAP.RoutePlan:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"], AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"])
		end
	end)
	AAP.RoutePlan.FG1.Fx0:SetScript("OnHide", function(self)
		if ( AAP.RoutePlan.isMoving ) then
			AAP.RoutePlan:StopMovingOrSizing();
			AAP.RoutePlan.isMoving = false;
		end
	end)
	AAP.RoutePlan.FG1.Fx0["FS"] = AAP.RoutePlan.FG1.Fx0:CreateFontString("AAP.RoutePlan_Fxx3x_FFGs1Sx1","ARTWORK", "ChatFontNormal")
	AAP.RoutePlan.FG1.Fx0["FS"]:SetParent(AAP.RoutePlan.FG1.Fx0)
	AAP.RoutePlan.FG1.Fx0["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1.Fx0,"TOP",0,0)
	AAP.RoutePlan.FG1.Fx0["FS"]:SetWidth(165)
	AAP.RoutePlan.FG1.Fx0["FS"]:SetHeight(20)
	AAP.RoutePlan.FG1.Fx0["FS"]:SetJustifyH("CENTER")
	AAP.RoutePlan.FG1.Fx0["FS"]:SetFontObject("GameFontNormal")
	AAP.RoutePlan.FG1.Fx0["FS"]:SetText("Custom Path")
	
	
	
	local zenr = AAP.NumbRoutePlan("EasternKingdom")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fxz"..CLi] = CreateFrame("frame", "AAP.RoutePlanMainFsramex2xxxs"..CLi, AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetMovable(true)
		AAP.RoutePlan.FG1["Fxz"..CLi]:EnableMouse(true)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetResizable(true)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetScale(0.7)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 0, -(20*CLi))
		--AAP.RoutePlan.FG1["Fxz"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.RoutePlan.FG1["Fxz"..CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.RoutePlan.FG1["Fxz"..CLi])
t:SetColorTexture(0.1,0.1,0.4,1)
AAP.RoutePlan.FG1["Fxz"..CLi].texture = t

		AAP.RoutePlan.FG1["Fxz"..CLi]:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					AAP.RoutePlan.FG1["Fxz"..CLi]:StartMoving();
					AAP.RoutePlan.FG1["Fxz"..CLi].isMoving = true;
				elseif button == "RightButton" then
					local zenew = getn(AAP_Custom[AAP.Name.."-"..AAP.Realm]) + 1
					if (zenew < 19 or zenew == 19) then
						tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]["FS"]:SetText(AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]:Show()
					end
					AAP.RoutePlanCheckPos()
					AAP.CheckCustomEmpty()
				end
		end)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.RoutePlan.FG1["Fxz"..CLi].isMoving then
				AAP.RoutePlan.FG1["Fxz"..CLi]:StopMovingOrSizing();
				AAP.RoutePlan.FG1["Fxz"..CLi].isMoving = false;
				AAP.CheckPosMove(1)
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
			end
		end)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetScript("OnHide", function(self)
			if ( AAP.RoutePlan.FG1.isMoving ) then
				AAP.RoutePlan.FG1:StopMovingOrSizing();
				AAP.RoutePlan.FG1.isMoving = false;
			end
		end)
		--AAP.RoutePlan.FG1["Fxz"..CLi]:SetBackdropColor(0.1,0.1,0.4,1)
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"] = AAP.RoutePlan.FG1["Fxz"..CLi]:CreateFontString("AAP.RoutePlan_Fx3x_FFGs1S"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetParent(AAP.RoutePlan.FG1["Fxz"..CLi])
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1["Fxz"..CLi],"TOP",0,1)
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetWidth(210)
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetJustifyH("LEFT")
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetFontObject("GameFontNormal")
		AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:SetText("Group "..CLi)
	end
	
	
	local zenr = AAP.NumbRoutePlan("Kalimdor")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fxzx2"..CLi] = CreateFrame("frame", "AAP.RoutePlanMainFsramex2xxx2s"..CLi, AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetMovable(true)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:EnableMouse(true)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetResizable(true)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetScale(0.7)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 0, -(20*CLi))
		--AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.RoutePlan.FG1["Fxzx2"..CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.RoutePlan.FG1["Fxzx2"..CLi])
t:SetColorTexture(0.1,0.1,0.4,1)
AAP.RoutePlan.FG1["Fxzx2"..CLi].texture = t

		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					AAP.RoutePlan.FG1["Fxzx2"..CLi]:StartMoving();
					AAP.RoutePlan.FG1["Fxzx2"..CLi].isMoving = true;
				elseif button == "RightButton" then
					local zenew = getn(AAP_Custom[AAP.Name.."-"..AAP.Realm]) + 1
					if (zenew < 19 or zenew == 19) then
						tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]["FS"]:SetText(AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]:Show()
					end
					AAP.RoutePlanCheckPos()
					AAP.CheckCustomEmpty()
				end
		end)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.RoutePlan.FG1["Fxzx2"..CLi].isMoving then
				AAP.RoutePlan.FG1["Fxzx2"..CLi]:StopMovingOrSizing();
				AAP.RoutePlan.FG1["Fxzx2"..CLi].isMoving = false;
				AAP.CheckPosMove(3)
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
			end
		end)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetScript("OnHide", function(self)
			if ( AAP.RoutePlan.FG1.isMoving ) then
				AAP.RoutePlan.FG1:StopMovingOrSizing();
				AAP.RoutePlan.FG1.isMoving = false;
			end
		end)
		--AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetBackdropColor(0.1,0.1,0.4,1)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"] = AAP.RoutePlan.FG1["Fxzx2"..CLi]:CreateFontString("AAP.RoutePlan_Fx3x_FFGs1S"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetParent(AAP.RoutePlan.FG1["Fxzx2"..CLi])
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1["Fxzx2"..CLi],"TOP",0,1)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetWidth(210)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetJustifyH("LEFT")
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetFontObject("GameFontNormal")
		AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:SetText("Group "..CLi)
	end
	
	local zenr = AAP.NumbRoutePlan("Shadowlands")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fxzx3"..CLi] = CreateFrame("frame", "AAP.RoutePlanMainFsramex2xx3x2s"..CLi, AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetMovable(true)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:EnableMouse(true)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetResizable(true)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetScale(0.7)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 0, -(20*CLi))
		--AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
--AAP.RoutePlan.FG1["Fxzx3"..CLi]:Hide()
		
local t = AAP.RoutePlan.FG1["Fxzx3"..CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.RoutePlan.FG1["Fxzx3"..CLi])
t:SetColorTexture(0.1,0.1,0.4,1)
AAP.RoutePlan.FG1["Fxzx3"..CLi].texture = t

		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					AAP.RoutePlan.FG1["Fxzx3"..CLi]:StartMoving();
					AAP.RoutePlan.FG1["Fxzx3"..CLi].isMoving = true;
				elseif button == "RightButton" then
					local zenew = getn(AAP_Custom[AAP.Name.."-"..AAP.Realm]) + 1
					if (zenew < 19 or zenew == 19) then
						tinsert(AAP_Custom[AAP.Name.."-"..AAP.Realm],AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]["FS"]:SetText(AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:GetText())
						AAP.RoutePlan.FG1["Fxz2Custom"..zenew]:Show()
					end
					AAP.RoutePlanCheckPos()
					AAP.CheckCustomEmpty()
				end
		end)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.RoutePlan.FG1["Fxzx3"..CLi].isMoving then
				AAP.RoutePlan.FG1["Fxzx3"..CLi]:StopMovingOrSizing();
				AAP.RoutePlan.FG1["Fxzx3"..CLi].isMoving = false;
				AAP.CheckPosMove(4)
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
			end
		end)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetScript("OnHide", function(self)
			if ( AAP.RoutePlan.FG1.isMoving ) then
				AAP.RoutePlan.FG1:StopMovingOrSizing();
				AAP.RoutePlan.FG1.isMoving = false;
			end
		end)
		--AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetBackdropColor(0.1,0.1,0.4,1)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"] = AAP.RoutePlan.FG1["Fxzx3"..CLi]:CreateFontString("AAP.RoutePlan_Fx3x_FFGs1S"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetParent(AAP.RoutePlan.FG1["Fxzx3"..CLi])
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1["Fxzx3"..CLi],"TOP",0,1)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetWidth(210)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetJustifyH("LEFT")
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetFontObject("GameFontNormal")
		AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:SetText("Group "..CLi)
	end
	
	for CLi = 1, 19 do
		AAP.RoutePlan.FG1["FxzCustom"..CLi] = CreateFrame("frame", "AAP.RoutePlanMainFsramex2xxxsc"..CLi, AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetWidth(25)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetHeight(20)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetMovable(true)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:EnableMouse(true)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetResizable(true)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetScale(0.7)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", -15, -((20*CLi)-17))
		--AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.RoutePlan.FG1["FxzCustom"..CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.RoutePlan.FG1["FxzCustom"..CLi])
t:SetColorTexture(0.1,0.1,0.4,1)
AAP.RoutePlan.FG1["FxzCustom"..CLi].texture = t

		--AAP.RoutePlan.FG1["FxzCustom"..CLi]:SetBackdropColor(0,0.9,0,1)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"] = AAP.RoutePlan.FG1["FxzCustom"..CLi]:CreateFontString("AAP.RoutePlan_Fx3x_FFGs1S"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetParent(AAP.RoutePlan.FG1["FxzCustom"..CLi])
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1["FxzCustom"..CLi],"TOP",0,1)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetWidth(25)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetHeight(20)
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetJustifyH("CENTER")
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetFontObject("GameFontNormal")
		AAP.RoutePlan.FG1["FxzCustom"..CLi]["FS"]:SetText(CLi)
		
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi] = CreateFrame("frame", "AAP.RoutePlanMainFsramex2xc2x"..CLi, AAP.RoutePlan.FG1)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetMovable(true)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:EnableMouse(true)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetFrameStrata("HIGH")
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetResizable(true)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetScale(0.7)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1, "TOPLEFT", 0, -(20*CLi))
		--AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetBackdrop( { 
		--	bgFile = "Interface\\Buttons\\WHITE8X8", tile = false, tileSize=0,
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		--	tile = true, tileSize = 10, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 }
		--});
local t = AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:CreateTexture(nil,"BACKGROUND")
t:SetTexture("Interface\\Buttons\\WHITE8X8")
t:SetAllPoints(AAP.RoutePlan.FG1["Fxz2Custom"..CLi])
t:SetColorTexture(0.1,0.1,0.4,1)
AAP.RoutePlan.FG1["Fxz2Custom"..CLi].texture = t

		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:StartMoving();
					AAP.RoutePlan.FG1["Fxz2Custom"..CLi].isMoving = true;
				end
		end)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" and AAP.RoutePlan.FG1["Fxz2Custom"..CLi].isMoving then
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:StopMovingOrSizing();
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi].isMoving = false;
				AAP.CheckPosMove(2)
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
			else
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
				AAP.FP.QuedFP = nil
				AAP.CheckPosMove(2)
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
			end
		end)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetScript("OnHide", function(self)
			if ( AAP.RoutePlan.FG1.isMoving ) then
				AAP.RoutePlan.FG1:StopMovingOrSizing();
				AAP.RoutePlan.FG1.isMoving = false;
			end
		end)
		--AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetBackdropColor(0.1,0.1,0.4,1)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"] = AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:CreateFontString("AAP.RoutePlan_Fx3x_FFGs21Sx"..CLi,"ARTWORK", "ChatFontNormal")
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetParent(AAP.RoutePlan.FG1["Fxz2Custom"..CLi])
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetPoint("TOP",AAP.RoutePlan.FG1["Fxz2Custom"..CLi],"TOP",0,1)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetWidth(210)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetHeight(20)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetJustifyH("LEFT")
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetFontObject("GameFontNormal")
		if (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]) then
			if (AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]]) then
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
			else
				if (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]) then
					local zew = AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]]
					if (AAP["EasternKingdomDB"] and AAP["EasternKingdomDB"][zew] and IsAddOnLoaded("AAP-EasternKingdoms") == false) then
						local loaded, reason = LoadAddOn("AAP-EasternKingdoms")
						if (not loaded) then
							if (reason == "DISABLED") then
								print("AAP: AAP - Eastern Kingdoms is Disabled in your Addon-List!")
							end
						end
					end
					if (AAP["ShadowlandsDB"] and AAP["ShadowlandsDB"][zew] and IsAddOnLoaded("AAP-Shadowlands") == false) then
						local loaded, reason = LoadAddOn("AAP-Shadowlands")
						if (not loaded) then
							if (reason == "DISABLED") then
								print("AAP: AAP - Shadowlands is Disabled in your Addon-List!")
							end
						end
					end
				end
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText(AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi])
				AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Show()
			end
		else
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
			AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
		end
	end
	local zenr2 = 0
	local dzer = {}
	local dzer2 = {}
	if (AAP.QuestStepListListingStartAreas["Kalimdor"]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListingStartAreas["Kalimdor"]) do
			dzer2[AAP_value2] = AAP_index2
		end
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(dzer2) do
			zenr2 = zenr2 + 1
			AAP.RoutePlan.FG1["Fxzx2"..zenr2]["FS"]:SetText(AAP_index2)
		end
	end
	if (AAP.QuestStepListListing and AAP.QuestStepListListing["Kalimdor"]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["Kalimdor"]) do
			dzer[AAP_value2] = AAP_index2
		end
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(dzer) do
			zenr2 = zenr2 + 1
			AAP.RoutePlan.FG1["Fxzx2"..zenr2]["FS"]:SetText(AAP_index2)
		end
	end
	zenr2 = 0
	dzer = nil
	dzer = {}
	dzer2 = nil
	dzer2 = {}
	
	if (AAP.QuestStepListListingStartAreas["EasternKingdom"]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListingStartAreas["EasternKingdom"]) do
			dzer2[AAP_value2] = AAP_index2
		end
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(dzer2) do
			zenr2 = zenr2 + 1
			AAP.RoutePlan.FG1["Fxz"..zenr2]["FS"]:SetText(AAP_index2)
		end
	end
	if (AAP.QuestStepListListing and AAP.QuestStepListListing["EasternKingdom"]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["EasternKingdom"]) do
			dzer[AAP_value2] = AAP_index2
		end
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(dzer) do
			zenr2 = zenr2 + 1
			AAP.RoutePlan.FG1["Fxz"..zenr2]["FS"]:SetText(AAP_index2)
		end
	end
	zenr2 = 0
	dzer = nil
	dzer = {}
	dzer2 = nil
	dzer2 = {}
	if (AAP.QuestStepListListing and AAP.QuestStepListListing["Shadowlands"]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["Shadowlands"]) do
			dzer[AAP_value2] = AAP_index2
		end
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(dzer) do
			zenr2 = zenr2 + 1
			AAP.RoutePlan.FG1["Fxzx3"..zenr2]["FS"]:SetText(AAP_index2)
			--AAP.RoutePlan.FG1["Fxzx3"..zenr2]["FS"]:SetText("")
		end
	end
	zenr2 = 0
	dzer = nil
	dzer = {}
	dzer2 = nil
	dzer2 = {}
	if (AAP.QuestStepListListing and AAP.QuestStepListListing["SpeedRun"]) then
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(AAP.QuestStepListListing["SpeedRun"]) do
			dzer[AAP_value2] = AAP_index2
		end
		for AAP_index2,AAP_value2 in AAP.pairsByKeys(dzer) do
			zenr2 = zenr2 + 1
			--AAP.RoutePlan.FG1["Fx3z"..zenr2]["FS"]:SetText(AAP_index2)
			AAP.RoutePlan.FG1["Fx3z"..zenr2]["FS"]:SetText("")
		end
	end





	AAP.RoutePlanCheckPos()
	AAP.CheckPosMove()
end

function AAP.CheckPosMove(zeActivz)
	if (AAP1["Debug"]) then
		print("Function: AAP.CheckPosMove()")
	end
	local zenr = AAP.NumbRoutePlan("EasternKingdom")
	local zenr2 = AAP.NumbRoutePlan("Kalimdor")
	local zenr3 = AAP.NumbRoutePlan("Shadowlands")
	local zenr4 = AAP.NumbRoutePlan("SpeedRun")
	local ZeBreak = 0
	local zfrom
	local zto
	for CLi = 1, zenr do
		local ZeMTop = AAP.RoutePlan.FG1["Fxz"..CLi]:GetTop()
		local ZeMBottom = AAP.RoutePlan.FG1["Fxz"..CLi]:GetBottom()
		local ZeMLeft = AAP.RoutePlan.FG1["Fxz"..CLi]:GetLeft()
		local ZeMRight = AAP.RoutePlan.FG1["Fxz"..CLi]:GetRight()
		local ZeMHeight = ((ZeMTop - ZeMBottom) / 2)+ZeMTop
		local ZeMWidth = ((ZeMRight - ZeMLeft) / 2)+ZeMLeft
		for CLi2 = 1, 19 do
			local zsda = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetBottom())
			local zsda2 = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetRight()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft())
			
			if (ZeMHeight > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop() and ZeMHeight < zsda) then
				if (ZeMWidth > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft() and ZeMWidth < zsda2) then
					zfrom = CLi
					zto = CLi2
					ZeBreak = 1
				end
			end
			if (ZeBreak == 1) then
				break
			end
		end
		if (ZeBreak == 1) then
			break
		end
	end
	for CLi = 1, zenr2 do
		local ZeMTop = AAP.RoutePlan.FG1["Fxzx2"..CLi]:GetTop()
		local ZeMBottom = AAP.RoutePlan.FG1["Fxzx2"..CLi]:GetBottom()
		local ZeMLeft = AAP.RoutePlan.FG1["Fxzx2"..CLi]:GetLeft()
		local ZeMRight = AAP.RoutePlan.FG1["Fxzx2"..CLi]:GetRight()
		local ZeMHeight = ((ZeMTop - ZeMBottom) / 2)+ZeMTop
		local ZeMWidth = ((ZeMRight - ZeMLeft) / 2)+ZeMLeft
		for CLi2 = 1, 19 do
			local zsda = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetBottom())
			local zsda2 = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetRight()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft())
			
			if (ZeMHeight > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop() and ZeMHeight < zsda) then
				if (ZeMWidth > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft() and ZeMWidth < zsda2) then
					zfrom = CLi
					zto = CLi2
					ZeBreak = 1
				end
			end
			if (ZeBreak == 1) then
				break
			end
		end
		if (ZeBreak == 1) then
			break
		end
	end
	for CLi = 1, zenr3 do
		local ZeMTop = AAP.RoutePlan.FG1["Fxzx3"..CLi]:GetTop()
		local ZeMBottom = AAP.RoutePlan.FG1["Fxzx3"..CLi]:GetBottom()
		local ZeMLeft = AAP.RoutePlan.FG1["Fxzx3"..CLi]:GetLeft()
		local ZeMRight = AAP.RoutePlan.FG1["Fxzx3"..CLi]:GetRight()
		local ZeMHeight = ((ZeMTop - ZeMBottom) / 2)+ZeMTop
		local ZeMWidth = ((ZeMRight - ZeMLeft) / 2)+ZeMLeft
		for CLi2 = 1, 19 do
			local zsda = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetBottom())
			local zsda2 = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetRight()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft())
			
			if (ZeMHeight > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop() and ZeMHeight < zsda) then
				if (ZeMWidth > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft() and ZeMWidth < zsda2) then
					zfrom = CLi
					zto = CLi2
					ZeBreak = 1
				end
			end
			if (ZeBreak == 1) then
				break
			end
		end
		if (ZeBreak == 1) then
			break
		end
	end
	for CLi = 1, zenr4 do
		local ZeMTop = AAP.RoutePlan.FG1["Fx3z"..CLi]:GetTop()
		local ZeMBottom = AAP.RoutePlan.FG1["Fx3z"..CLi]:GetBottom()
		local ZeMLeft = AAP.RoutePlan.FG1["Fx3z"..CLi]:GetLeft()
		local ZeMRight = AAP.RoutePlan.FG1["Fx3z"..CLi]:GetRight()
		local ZeMHeight = ((ZeMTop - ZeMBottom) / 2)+ZeMTop
		local ZeMWidth = ((ZeMRight - ZeMLeft) / 2)+ZeMLeft
		for CLi2 = 1, 19 do
			local zsda = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetBottom())
			local zsda2 = AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft()+(AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetRight()-AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft())
			
			if (ZeMHeight > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetTop() and ZeMHeight < zsda) then
				if (ZeMWidth > AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]:GetLeft() and ZeMWidth < zsda2) then
					zfrom = CLi
					zto = CLi2
					ZeBreak = 1
				end
			end
			if (ZeBreak == 1) then
				break
			end
		end
		if (ZeBreak == 1) then
			break
		end
	end
	if (zeActivz == 1 and zfrom and zto) then
		if (AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:GetText() ~= nil) then
			local zerpd = 20
			for CLi2z = 1, 19 do
				zerpd = zerpd - 1
				if (zerpd ~= 1 and zerpd > zto) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:SetText(AAP.RoutePlan.FG1["Fxz2Custom"..zerpd-1]["FS"]:GetText())
				end
				if (AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:GetText()) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Show()
				else
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Hide()
				end
			end
		end
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:SetText(AAP.RoutePlan.FG1["Fxz"..zfrom]["FS"]:GetText())
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]:Show()
	elseif (zeActivz == 2 and zfrom and zto) then
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:SetText("")
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]:Hide()
	elseif (zeActivz == 3 and zfrom and zto) then
		if (AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:GetText() ~= nil) then
			local zerpd = 20
			for CLi2z = 1, 19 do
				zerpd = zerpd - 1
				if (zerpd ~= 1 and zerpd > zto) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:SetText(AAP.RoutePlan.FG1["Fxz2Custom"..zerpd-1]["FS"]:GetText())
				end
				if (AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:GetText()) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Show()
				else
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Hide()
				end
			end
		end
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:SetText(AAP.RoutePlan.FG1["Fxzx2"..zfrom]["FS"]:GetText())
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]:Show()
	elseif (zeActivz == 4 and zfrom and zto) then
		if (AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:GetText() ~= nil) then
			local zerpd = 20
			for CLi2z = 1, 19 do
				zerpd = zerpd - 1
				if (zerpd ~= 1 and zerpd > zto) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:SetText(AAP.RoutePlan.FG1["Fxz2Custom"..zerpd-1]["FS"]:GetText())
				end
				if (AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:GetText()) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Show()
				else
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Hide()
				end
			end
		end
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:SetText(AAP.RoutePlan.FG1["Fxzx3"..zfrom]["FS"]:GetText())
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]:Show()
	end
	if (zeActivz == 5 and zfrom and zto) then
		if (AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:GetText() ~= nil) then
			local zerpd = 20
			for CLi2z = 1, 19 do
				zerpd = zerpd - 1
				if (zerpd ~= 1 and zerpd > zto) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:SetText(AAP.RoutePlan.FG1["Fxz2Custom"..zerpd-1]["FS"]:GetText())
				end
				if (AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]["FS"]:GetText()) then
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Show()
				else
					AAP.RoutePlan.FG1["Fxz2Custom"..zerpd]:Hide()
				end
			end
		end
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]["FS"]:SetText(AAP.RoutePlan.FG1["Fx3z"..zfrom]["FS"]:GetText())
		AAP.RoutePlan.FG1["Fxz2Custom"..zto]:Show()
	end
	for CLi = 1, zenr do
		local zeTex = AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:GetText()
		local ZeMatch = 0
		for CLi2 = 1, 19 do
			if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]["FS"]:GetText() == zeTex) then
				AAP.RoutePlan.FG1["Fxz"..CLi]:Hide()
				ZeMatch = 1
			end
		end
		if (ZeMatch == 0) then
			if (AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:GetText()]) then
				AAP.RoutePlan.FG1["Fxz"..CLi]:Hide()
				AAP.FP.GoToZone = nil
				AAP.ActiveMap = nil
			else
				AAP.RoutePlan.FG1["Fxz"..CLi]:Show()
			end
		end
	end
	for CLi = 1, zenr2 do
		local zeTex = AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:GetText()
		local ZeMatch = 0
		for CLi2 = 1, 19 do
			if (AAP.RoutePlan.FG1 and AAP.RoutePlan.FG1["Fxz2Custom"..CLi2] and AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]["FS"] and AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]["FS"]:GetText() == zeTex) then
				AAP.RoutePlan.FG1["Fxzx2"..CLi]:Hide()
				ZeMatch = 1
			end
		end
		if (ZeMatch == 0) then
			if (AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:GetText()]) then
				AAP.RoutePlan.FG1["Fxzx2"..CLi]:Hide()
				AAP.FP.GoToZone = nil
				AAP.ActiveMap = nil
			else
				AAP.RoutePlan.FG1["Fxzx2"..CLi]:Show()
			end
		end
	end
	for CLi = 1, zenr3 do
		local zeTex = AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:GetText()
		local ZeMatch = 0
		for CLi2 = 1, 19 do
			if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]["FS"]:GetText() == zeTex) then
				AAP.RoutePlan.FG1["Fxzx3"..CLi]:Hide()
				ZeMatch = 1
			end
		end
		if (ZeMatch == 0) then
			if (AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:GetText()]) then
				AAP.RoutePlan.FG1["Fxzx3"..CLi]:Hide()
				AAP.FP.GoToZone = nil
				AAP.ActiveMap = nil
			else
				AAP.RoutePlan.FG1["Fxzx3"..CLi]:Show()
			end
		end
		if (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]) then
			local zew = AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]]
			if (AAP["EasternKingdomDB"] and AAP["EasternKingdomDB"][zew] and IsAddOnLoaded("AAP-EasternKingdoms") == false) then
				local loaded, reason = LoadAddOn("AAP-EasternKingdoms")
				if (not loaded) then
					if (reason == "DISABLED") then
						print("AAP: AAP - Eastern Kingdoms is Disabled in your Addon-List!")
					end
				end
			end
			if (AAP["ShadowlandsDB"] and AAP["ShadowlandsDB"][zew] and IsAddOnLoaded("AAP-Shadowlands") == false) then
				local loaded, reason = LoadAddOn("AAP-Shadowlands")
				if (not loaded) then
					if (reason == "DISABLED") then
						print("AAP: AAP - Shadowlands is Disabled in your Addon-List!")
					end
				end
			end
		end
	end
	for CLi = 1, zenr4 do
		local zeTex = AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:GetText()
		local ZeMatch = 0
		for CLi2 = 1, 19 do
			if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi2]["FS"]:GetText() == zeTex) then
				AAP.RoutePlan.FG1["Fx3z"..CLi]:Hide()
				ZeMatch = 1
			end
		end
		if (ZeMatch == 0) then
			if (AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:GetText()]) then
				AAP.RoutePlan.FG1["Fx3z"..CLi]:Hide()
				AAP.FP.GoToZone = nil
				AAP.ActiveMap = nil
			else
				AAP.RoutePlan.FG1["Fx3z"..CLi]:Show()
			end
		end
		if (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]) then
			local zew = AAP.QuestStepListListingZone[AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi]]
			if (AAP["ShadowlandsDB"] and AAP["ShadowlandsDB"][zew] and IsAddOnLoaded("AAP-Shadowlands") == false) then
				local loaded, reason = LoadAddOn("AAP-Shadowlands")
				if (not loaded) then
					if (reason == "DISABLED") then
						print("AAP: AAP - Shadowlands is Disabled in your Addon-List!")
					end
				end
			end
		end
	end
end
function AAP.CheckCustomEmpty()
	if (AAP1["Debug"]) then
		print("Function: AAP.CheckCustomEmpty()")
	end
	local zeemp = 0
	for CLi = 1, 19 do
		if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:IsVisible()) then
			zeemp = 1
		end
	end
	if (zeemp == 0) then
		AAP.FP.GoToZone = nil
		AAP.ActiveMap = nil
	end
end
function AAP.RoutePlanCheckPos()
	if (AAP1["Debug"]) then
		print("Function: AAP.RoutePlanCheckPos()")
	end
	local zenr = AAP.NumbRoutePlan("EasternKingdom")
	local ZeHide = {}
	for CLi = 1, 19 do
		if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:GetText() and AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:GetText() ~= "") then
			ZeHide[AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:GetText()] = 1
		end
	end
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fxz"..CLi]:ClearAllPoints()
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.F23, "TOPRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetPoint("BOTTOMRIGHT", AAP.RoutePlan.FG1.F23, "BOTTOMRIGHT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1.F23, "BOTTOMLEFT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.F23, "BOTTOMRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1.F23, "TOPLEFT", 10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxz"..CLi]:SetHeight(20)
		if (ZeHide and ZeHide[AAP.RoutePlan.FG1["Fxz"..CLi]["FS"]:GetText()]) then
			AAP.RoutePlan.FG1["Fxz"..CLi]:Hide()
		end
	end
	local zenr = AAP.NumbRoutePlan("Kalimdor")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:ClearAllPoints()
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.Fx1, "TOPRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetPoint("BOTTOMRIGHT", AAP.RoutePlan.FG1.Fx1, "BOTTOMRIGHT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1.Fx1, "BOTTOMLEFT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.Fx1, "BOTTOMRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1.Fx1, "TOPLEFT", 10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxzx2"..CLi]:SetHeight(20)
		if (ZeHide and ZeHide[AAP.RoutePlan.FG1["Fxzx2"..CLi]["FS"]:GetText()]) then
			AAP.RoutePlan.FG1["Fxzx2"..CLi]:Hide()
		end
	end
	local zenr = AAP.NumbRoutePlan("Shadowlands")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:ClearAllPoints()
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.Fx2x2, "TOPRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetPoint("BOTTOMRIGHT", AAP.RoutePlan.FG1.Fx2x2, "BOTTOMRIGHT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1.Fx2x2, "BOTTOMLEFT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.Fx2x2, "BOTTOMRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1.Fx2x2, "TOPLEFT", 10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxzx3"..CLi]:SetHeight(20)
		if (ZeHide and ZeHide[AAP.RoutePlan.FG1["Fxzx3"..CLi]["FS"]:GetText()]) then
			AAP.RoutePlan.FG1["Fxzx3"..CLi]:Hide()
		end
	end
	local zenr = AAP.NumbRoutePlan("SpeedRun")
	for CLi = 1, zenr do
		AAP.RoutePlan.FG1["Fx3z"..CLi]:ClearAllPoints()
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.F25x3, "TOPRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetPoint("BOTTOMRIGHT", AAP.RoutePlan.FG1.F25x3, "BOTTOMRIGHT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1.F25x3, "BOTTOMLEFT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.F25x3, "BOTTOMRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1.F25x3, "TOPLEFT", 10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fx3z"..CLi]:SetHeight(20)
--		if (ZeHide and ZeHide[AAP.RoutePlan.FG1["Fx3z"..CLi]["FS"]:GetText()]) then
			AAP.RoutePlan.FG1["Fx3z"..CLi]:Hide()
--		end
	end
	AAP_Custom[AAP.Name.."-"..AAP.Realm] = nil
	AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
	for CLi = 1, 19 do
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:ClearAllPoints()
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.Fx0, "TOPRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetPoint("BOTTOMRIGHT", AAP.RoutePlan.FG1.Fx0, "BOTTOMRIGHT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetPoint("BOTTOMLEFT", AAP.RoutePlan.FG1.Fx0, "BOTTOMLEFT", 10, -(20*CLi)+10-10)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetPoint("TOPRIGHT", AAP.RoutePlan.FG1.Fx0, "BOTTOMRIGHT", -10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetPoint("TOPLEFT", AAP.RoutePlan.FG1.Fx0, "TOPLEFT", 10, -(20*CLi)-10)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetWidth(225)
		AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:SetHeight(20)
		if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:GetText() ~= "") then
			AAP_Custom[AAP.Name.."-"..AAP.Realm][CLi] = AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:GetText()
		end
	end
	AAP.BookingList["UpdateMapId"] = 1
end
function AAP.NumbRoutePlan(Continz)
	local zenr = 0

	if (Continz == "EasternKingdom") then
		if (AAP.QuestStepListListingStartAreas["EasternKingdom"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListingStartAreas["EasternKingdom"]) do
				zenr = zenr + 1
			end
		end
		if (AAP.QuestStepListListing["EasternKingdom"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListing["EasternKingdom"]) do
				zenr = zenr + 1
			end
		end
	elseif (Continz == "Kalimdor") then
		if (AAP.QuestStepListListingStartAreas["Kalimdor"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListingStartAreas["Kalimdor"]) do
				zenr = zenr + 1
			end
		end
		if (AAP.QuestStepListListing["Kalimdor"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListing["Kalimdor"]) do
				zenr = zenr + 1
			end
		end
	elseif (Continz == "BrokenIsles") then
		if (AAP.QuestStepListListingStartAreas["BrokenIsles"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListingStartAreas["BrokenIsles"]) do
				zenr = zenr + 1
			end
		end
	elseif (Continz == "SpeedRun") then
		if (AAP.QuestStepListListing["SpeedRun"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListing["SpeedRun"]) do
				zenr = zenr + 1
			end
		end
	elseif (Continz == "Shadowlands") then
		if (AAP.QuestStepListListing["Shadowlands"]) then
			for AAP_index2,AAP_value2 in pairs(AAP.QuestStepListListing["Shadowlands"]) do
				zenr = zenr + 1
			end
		end
	end
	return zenr
end

function AAP.TimeFPs(CurrentFP, DestFP)
	if (not AAP_TaxiTimers[CurrentFP.."-"..DestFP]) then
		AAP.TaxiTimerCur = CurrentFP
		AAP.TaxiTimerDes = DestFP
		AAP_TaxicTimer:Play()
	else
		AAP.AFK_Timer(AAP_TaxiTimers[CurrentFP.."-"..DestFP])
	end
end

AAP.CoreEventFrame = CreateFrame("Frame")
AAP.CoreEventFrame:RegisterEvent ("ADDON_LOADED")
AAP.CoreEventFrame:RegisterEvent ("CINEMATIC_START")

AAP.CoreEventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event=="ADDON_LOADED") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if (arg1 ~= "AAP-Core") then
			return
		end
		if (not AAP1) then
			AAP1 = {}
		end
		if (not AAP1[AAP.Realm]) then
			AAP1[AAP.Realm] = {}
		end
		if (not AAP1[AAP.Realm][AAP.Name]) then
			AAP1[AAP.Realm][AAP.Name] = {}
		end
		if (not AAP1[AAP.Realm][AAP.Name]["BonusSkips"]) then
			AAP1[AAP.Realm][AAP.Name]["BonusSkips"] = {}
		end
		AAP.ZoneQuestOrderList()

		AAP_TaxicTimer = AAP.CoreEventFrame:CreateAnimationGroup()
		AAP_TaxicTimer.anim = AAP_TaxicTimer:CreateAnimation()
		AAP_TaxicTimer.anim:SetDuration(1)
		AAP_TaxicTimer:SetLooping("REPEAT")
		AAP_TaxicTimer:SetScript("OnLoop", function(self, event, ...)
			if (AAP.TaxiTimerCur and AAP.TaxiTimerDes and UnitOnTaxi("player")) then
				if (not AAP_TaxiTimers[AAP.TaxiTimerCur.."-"..AAP.TaxiTimerDes]) then
					AAP_TaxiTimers[AAP.TaxiTimerCur.."-"..AAP.TaxiTimerDes] = 3
				end
				AAP_TaxiTimers[AAP.TaxiTimerCur.."-"..AAP.TaxiTimerDes] = AAP_TaxiTimers[AAP.TaxiTimerCur.."-"..AAP.TaxiTimerDes] + 1
			else
				AAP.TaxiTimerCur = nil
				AAP.TaxiTimerDes = nil
				AAP_TaxicTimer:Stop()
			end
		end)


		AAP_LoadInTimer = AAP.CoreEventFrame:CreateAnimationGroup()
		AAP_LoadInTimer.anim = AAP_LoadInTimer:CreateAnimation()
		AAP_LoadInTimer.anim:SetDuration(2)
		AAP_LoadInTimer:SetLooping("REPEAT")
		AAP_LoadInTimer:SetScript("OnLoop", function(self, event, ...)
			if (CoreLoadin == 1 and AAP.QuestListLoadin == 1) then
				if (not AAP_Transport) then
					AAP_Transport = {}
				end
				if (not AAP_Custom) then
					AAP_Custom = {}
				end
				if (not AAP_TaxiTimers) then
					AAP_TaxiTimers = {}
				end
				if (not AAP_Custom[AAP.Name.."-"..AAP.Realm]) then
					AAP_Custom[AAP.Name.."-"..AAP.Realm] = {}
				end
				if (not AAP_ZoneComplete) then
					AAP_ZoneComplete = {}
				end
				if (not AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm]) then
					AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm] = {}
				end
				if (not AAP_Transport["FPs"]) then
					AAP_Transport["FPs"] = {}
				end
				if (not AAP_Transport["FPs"][AAP.Faction]) then
					AAP_Transport["FPs"][AAP.Faction] = {}
				end
				if (AAP.getContinent() and not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()]) then
					AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()] = {}
				end
				if (AAP.getContinent() and not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]) then
					AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm] = {}
				end
				local CLi
				if (AAP.getContinent() and not AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"]) then
					AAP_Transport["FPs"][AAP.Faction][AAP.getContinent()][AAP.Name.."-"..AAP.Realm]["Conts"] = {}
				end
				AAP.LoadOptionsFrame()
				AAP.BookingList["UpdateMapId"] = 1
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
				AAP.BookingList["Heirloomscheck"] = 1
				AAP.CreateMacro()
				AAP.RoutePlanLoadIn()
				if (not AAP1[AAP.Realm][AAP.Name]["FirstLoadz"]) then
					AAP.LoadInOptionFrame:Show()
					AAP1[AAP.Realm][AAP.Name]["FirstLoadz"] = 1
				else
					AAP.LoadInOptionFrame:Hide()
				end
				print("AAP Loaded")
				AAP_LoadInTimer:Stop()
				C_Timer.After(4, AAP_UpdatezeMapId)
				C_Timer.After(5, AAP_BookQStep)
				AAP.RegisterChat = C_ChatInfo.RegisterAddonMessagePrefix("AAPChat")
				--AAP.FP.ToyFPs()
				local CQIDs = C_QuestLog.GetAllCompletedQuestIDs()
				AAP1[AAP.Realm][AAP.Name]["QuestCounter"] = getn(CQIDs)
				AAP1[AAP.Realm][AAP.Name]["QuestCounter2"] = AAP1[AAP.Realm][AAP.Name]["QuestCounter"]
				AAP_QidsTimer:Play()
			end
		end)
		AAP_LoadInTimer:Play()
		AAP.RegisterChat = C_ChatInfo.RegisterAddonMessagePrefix("AAPChat")
		
		AAP_QidsTimer = AAP.CoreEventFrame:CreateAnimationGroup()
		AAP_QidsTimer.anim = AAP_QidsTimer:CreateAnimation()
		AAP_QidsTimer.anim:SetDuration(1)
		AAP_QidsTimer:SetLooping("REPEAT")
		AAP_QidsTimer:SetScript("OnLoop", function(self, event, ...)
			if (AAP1[AAP.Realm][AAP.Name]["QuestCounter2"] ~= AAP1[AAP.Realm][AAP.Name]["QuestCounter"]) then
				AAP.BookingList["PrintQStep"] = 1
				AAP1[AAP.Realm][AAP.Name]["QuestCounter"] = AAP1[AAP.Realm][AAP.Name]["QuestCounter2"]

			end
			if (not InCombatLockdown() and AAP.MacroUpdaterVar[1]) then
				local macroSlot = AAP.MacroUpdaterVar[1]
				local itemName = AAP.MacroUpdaterVar[2]
				local aapextra = AAP.MacroUpdaterVar[3]
				AAP.MacroUpdater2(macroSlot,itemName,aapextra)
				AAP.MacroUpdaterVar = nil
				AAP.MacroUpdaterVar = {}
			end
		end)
	
		
		AAP_IconTimer = AAP.CoreEventFrame:CreateAnimationGroup()
		AAP_IconTimer.anim = AAP_IconTimer:CreateAnimation()
		AAP_IconTimer.anim:SetDuration(0.05)
		AAP_IconTimer:SetLooping("REPEAT")
		AAP_IconTimer:SetScript("OnLoop", function(self, event, ...)
			if (AAP.Icons and AAP.Icons[1]) then
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowBlobs"] == 1) then
					AAP:MoveIcons()
				end
			end
			if (AAP.MapIcons and AAP.MapIcons[1]) then
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMapBlobs"] == 1) then
					AAP:MoveMapIcons()
				end
			end
		end)
		AAP_IconTimer:Play()
		
		
		if (not AAP1[AAP.Realm][AAP.Name]["LoaPick"]) then
			AAP1[AAP.Realm][AAP.Name]["LoaPick"] = 0
		end
			if (not AAP1[AAP.Realm][AAP.Name]["QlineSkip"]) then
				AAP1[AAP.Realm][AAP.Name]["QlineSkip"] = {}
			end
			if (not AAP1[AAP.Realm][AAP.Name]["SkippedBonusObj"]) then
				AAP1[AAP.Realm][AAP.Name]["SkippedBonusObj"] = {}
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"] = {}
				AAP1[AAP.Realm][AAP.Name]["Settings"]["left"] = GetScreenWidth() / 1.6
				AAP1[AAP.Realm][AAP.Name]["Settings"]["top"] = -(GetScreenHeight() / 5)
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Scale"] = UIParent:GetScale()
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Lock"] = 0
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Hide"] = 0
				AAP1[AAP.Realm][AAP.Name]["Settings"]["alpha"] = 1
				AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"] = GetScreenWidth() / 2.05
				AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"] = -(GetScreenHeight() / 1.5)
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["leftLiz"] = 150
				AAP1[AAP.Realm][AAP.Name]["Settings"]["topLiz"] = -150
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"] = 2
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["QuestButtons"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["QuestButtons"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["MiniMapBlobAlpha"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["MiniMapBlobAlpha"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["QuestButtonDetatch"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["QuestButtonDetatch"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQuestListOrder"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQuestListOrder"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["OrderListScale"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["OrderListScale"] = 1
			end
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQuestListOrder"] == 1) then
				AAP.ZoneQuestOrder:Show()
			else
				AAP.ZoneQuestOrder:Hide()
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowBlobs"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowBlobs"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMap10s"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMap10s"] = 0
			end
			
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMapBlobs"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMapBlobs"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["DisableHeirloomWarning"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["DisableHeirloomWarning"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["LockArrow"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["LockArrow"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoFlight"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoFlight"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["Hcampleft"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Hcampleft"] = GetScreenWidth() / 1.6
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["Hcamptop"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Hcamptop"] = -(GetScreenHeight() / 5)
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["CutScene"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["CutScene"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] = 1
			end
			AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoShareQ"] = 0
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ChooseQuests"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ChooseQuests"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"] = UIParent:GetScale()
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandInChoice"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandInChoice"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["Greetings"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Greetings"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["Greetings3"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["Greetings3"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoVendor"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoVendor"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoRepair"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoRepair"] = 0
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowGroup"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowGroup"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowArrow"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowArrow"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"]) then
				AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] = 1
			end
			if (not AAP1[AAP.Realm][AAP.Name]["AAP_DoWarCampaign"]) then
				AAP1[AAP.Realm][AAP.Name]["AAP_DoWarCampaign"] = 0
			end

			if (not AAP1[AAP.Realm][AAP.Name]["WantedQuestList"]) then
				AAP1[AAP.Realm][AAP.Name]["WantedQuestList"] = {}
			end
			AAP.ZoneQuestOrder:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["OrderListScale"])
			AAP.ArrowFrame:SetScale(AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowScale"])
			AAP.ArrowFrameM:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowleft"], AAP1[AAP.Realm][AAP.Name]["Settings"]["arrowtop"])

			
			
			AAP.ButtonBookingTimer = AAP.CoreEventFrame:CreateAnimationGroup()
			AAP.ButtonBookingTimer.anim = AAP.ButtonBookingTimer:CreateAnimation()
			AAP.ButtonBookingTimer.anim:SetDuration(5)
			AAP.ButtonBookingTimer:SetLooping("REPEAT")
			AAP.ButtonBookingTimer:SetScript("OnLoop", function(self, event, ...)
				AAP.SetButton()
			end)
			AAP.ButtonBookingTimer:Play()
			AAP.LoadInTimer = AAP.CoreEventFrame:CreateAnimationGroup()
			AAP.LoadInTimer.anim = AAP.LoadInTimer:CreateAnimation()
			AAP.LoadInTimer.anim:SetDuration(10)
			AAP.LoadInTimer:SetLooping("REPEAT")
			AAP.LoadInTimer:SetScript("OnLoop", function(self, event, ...)
				AAP.BookingList["PrintQStep"] = 1
				AAP.LoadInTimer:Stop()
			end)
			AAP.LoadInTimer:Play()
			AAP.ArrowEventAFkTimer = AAP.CoreEventFrame:CreateAnimationGroup()
			AAP.ArrowEventAFkTimer.anim = AAP.ArrowEventAFkTimer:CreateAnimation()
			AAP.ArrowEventAFkTimer.anim:SetDuration(0.1)
			AAP.ArrowEventAFkTimer:SetLooping("REPEAT")
			AAP.ArrowEventAFkTimer:SetScript("OnLoop", function(self, event, ...)
				local ZeTime = AAP.AfkTimerVar - floor(GetTime())
				if (ZeTime > 0) then


					AAP.AfkFrame.Fontstring:SetText("AFK: " .. string.format(SecondsToTime(ZeTime)))
					local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
					if (AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
						local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
						if (steps and steps["SpecialETAHide"]) then
							AAP.AfkFrame:Hide()
						else
							AAP.AfkFrame:Show()
						end
					else
						AAP.AfkFrame:Show()
					end
				else
					AAP.ArrowEventAFkTimer:Stop()
					AAP.AfkFrame:Hide()
				end
			end)
		SlashCmdList["AAP_Cmd"] = AAP_SlashCmd
		SLASH_AAP_Cmd1 = "/aap"
		CoreLoadin = 1
	elseif (event=="CINEMATIC_START") then
		if (not IsControlKeyDown()) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["CutScene"] == 1 and (steps and not steps["Dontskipvid"]) and (AAP.ActiveQuests and not AAP.ActiveQuests[52042])) then
				AAP.BookingList["SkipCutscene"] = 1
			end
		end
	end
end)
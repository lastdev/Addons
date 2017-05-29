local VERSION = 34

--[[
Special icons for rares, pvp or pet battle quests in list
Better sorting for all reward types
Quest position on general Broken Isles map
Number of artifact power on item in list
New quests will be marked as "new" for another 3 min
Minor localization fixes

Added Eye Of Azshara zone
Note for BOE gear rewards
Fix for 1k+ AP items
Minor fixes

Added helper for Kirin Tor enigma world quest
Added minor functionality for leveling

Blood of Sargeras filter
Icon on map for hidden quests (that expires in 15min)
Icon in list for profession quests
Fix for Kirin-Tor helper (quest is 7x7 now instead 8x8)

Added button "Show all quests"
QOL improvements (mouseovering + shift, click on quest)
Fixed changing order for quests with same timer while sorting by time
Click on quest now send you to zone map
Added ElvUI support
Bugfixes

Added icon on the flight map for recently chosen quest

Added filters for pvp, pet battles & professions quests
Added checkbox above map to disable WQL

Artifact weapon color for all artifact power items
Minor notification for artifact power items that can be earned after reaching next artifact knowledge level
Dungeon icon for dungeons world quests
Added options for scale, anchor and arrow

Added tooltip with date for timeleft
Enigma helper disabled ("/enigmahelper" still works)
Added "Total AP" text
Minor fixes

Fixed highlighting faction for emissary quests (You can do Watchers or Kirin-tor quests for zone emissary)
Added "Total gold & total order resources" text
Minor fixes

Fixed summary while filtered
Added "Time to Complete" for marked ("**") quests
Added 7.1 support
Different color for elite quests
Some pvp quests shows honor as reward if reward is only gold [filter for them gold as before]
Minor fixes

7.1 Update

New option "Ignore filter for bounty quests"
Minor fixes

Last client update (not addon) broke something with world quests (updating info too frequently). I added 5 second limit for updating (so may need time for update rewards after login), dropdowns will closing every 5 sec too. Sorry for the inconvenience, it'll not be too long until I write real solution

Added "Barrels o' Fun" helper
Minor fixes

Rewards updates must be faster
Added options for enable/disabe Enigma Helper/Barrels Helper
Added option "Ignore filter for PvP quests"

Added scroll (use mouse wheel or buttons for navigate) [still in testing]
AP numbers divided by 1000 for artifact knowledge 26 or higher
7.2 PTR Update (Note: this version works on both clients: live 7.1.5 and ptr 7.2.0)

More "Ignore filter" options
7.2 Updates (Note: this version works on both clients: live 7.1.5 and ptr 7.2.0)

7.2 toc update
Added dalaran quests to general map
Added option for AP number formatting
Added header line for quick sorting (and option for disabling it)
Added switcher to regular quests (not WQ) for max level chars
Tooltip with icons for all factions if quest can be done for any emissary
Added option for disabling highlight for new quests

Added quests without timer to list (unlimited quests; expired quests)
Added sorting by distance to quest
Sorting by reward: Gear rewards had low priority for high ilvl chars
Minor fixes

Bugfixes

Added invasions quests to list for low level chars
Added faction icons for emissary quests (can be disabled in options)
Threshold for lower priority on gear rewards was lowered to 880 ilvl
]]


local GetCurrentMapAreaID, GetCurrentMapZone, tonumber, C_TaskQuest, tinsert, abs, time, GetCurrencyInfo, HaveQuestData, QuestUtils_IsQuestWorldQuest, GetQuestTagInfo, bit, format, floor = 
      GetCurrentMapAreaID, GetCurrentMapZone, tonumber, C_TaskQuest, tinsert, abs, time, GetCurrencyInfo, HaveQuestData, QuestUtils_IsQuestWorldQuest, GetQuestTagInfo, bit, format, floor
local BAG_ITEM_QUALITY_COLORS, ARTIFACT_POWER, ITEM_SPELL_TRIGGER_ONUSE, ITEM_BIND_ON_EQUIP = 
      BAG_ITEM_QUALITY_COLORS, ARTIFACT_POWER, ITEM_SPELL_TRIGGER_ONUSE, ITEM_BIND_ON_EQUIP
local LE = {
	LE_QUEST_TAG_TYPE_INVASION = LE_QUEST_TAG_TYPE_INVASION,
	LE_QUEST_TAG_TYPE_DUNGEON = LE_QUEST_TAG_TYPE_DUNGEON,
	LE_QUEST_TAG_TYPE_RAID = LE_QUEST_TAG_TYPE_RAID,
	LE_WORLD_QUEST_QUALITY_RARE = LE_WORLD_QUEST_QUALITY_RARE,
	LE_WORLD_QUEST_QUALITY_EPIC = LE_WORLD_QUEST_QUALITY_EPIC,
	LE_QUEST_TAG_TYPE_PVP = LE_QUEST_TAG_TYPE_PVP,
	LE_QUEST_TAG_TYPE_PET_BATTLE = LE_QUEST_TAG_TYPE_PET_BATTLE,
	LE_QUEST_TAG_TYPE_PROFESSION = LE_QUEST_TAG_TYPE_PROFESSION,
	LE_ITEM_QUALITY_COMMON = LE_ITEM_QUALITY_COMMON,
}
      
local charKey = (UnitName'player' or "").."-"..(GetRealmName() or ""):gsub(" ","")

local locale = GetLocale()
local LOCALE = 
	locale == "ruRU" and {
		gear = "Экипировка",
		gold = "Золото",
		blood = "Кровь Саргераса",
		knowledgeTooltip = "** Можно выполнить после повышения уровня знаний вашего артефакта",
		disableArrow = "Отключить стрелку",
		anchor = "Привязка",
		totalap = "Всего силы артефакта: ",
		totalapdisable = 'Отключить сумму силы артефакта',
		timeToComplete = "Времени на выполнение: ",
		bountyIgnoreFilter = "Задания посланника",
		enigmaHelper = "Включить Enigma Helper",
		barrelsHelper = "Включить Barrels Helper",
		honorIgnoreFilter = "PvP задания",
		ignoreFilter = "Игнорировать фильтр для",
		epicIgnoreFilter = '"Золотые" задания',	
		wantedIgnoreFilter = 'Задания "Разыскиваются"',	
		apFormatSetup = "Формат силы артефакта",
		headerEnable = "Включить полосу-заголовок",
		disabeHighlightNewQuests = "Отключить подсветку новых заданий",
		distance = "Расстояние",
		disableBountyIcon = "Отключить иконку фракций для заданий посланника",
	} or
	locale == "deDE" and {
		gear = "Ausrüstung",
		gold = "Gold",
		blood = "Blut von Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",	
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or
	locale == "frFR" and {
		gear = "Équipement",
		gold = "Or",
		blood = "Sang de Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",	
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or
	(locale == "esES" or locale == "esMX") and {
		gear = "Equipo",
		gold = "Oro",
		blood = "Sangre de Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",	
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or	
	locale == "itIT" and {
		gear = "Equipaggiamento",
		gold = "Oro",
		blood = "Sangue di Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",	
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or
	locale == "ptBR" and {
		gear = "Equipamento",
		gold = "Ouro",
		blood = "Sangue de Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",		
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or
	locale == "koKR" and {
		gear = "Gear",
		gold = "금메달",
		blood = "살게라스의 피",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",		
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or
	(locale == "zhCN" or locale == "zhTW") and {
		gear = "装备",
		gold = "黄金",
		blood = "萨格拉斯之血",
		knowledgeTooltip = "** 可在达到下一个神器知识等级后完成",
		disableArrow = "禁用 箭头",
		anchor = "插件位置",
		totalap = "神器能量总数：",
		totalapdisable = '禁用 "神器能量总数"',
		timeToComplete = "剩余时间：",
		bountyIgnoreFilter = "宝箱任务",
		enigmaHelper = "开启 迷宫助手",
		barrelsHelper = "开启 欢乐桶助手",
		honorIgnoreFilter = "PvP 任务",
		ignoreFilter = "不过滤：",
		epicIgnoreFilter = '精英任务',
		wantedIgnoreFilter = "通缉任务", 
		apFormatSetup = "神器能量数字格式",
		headerEnable = "开启 标题行",
		disabeHighlightNewQuests = "禁用 新任务高亮",
		distance = "距离",
		disableBountyIcon = "Disable Emissary icons for faction names",
	} or	
	{
		gear = "Gear",
		gold = "Gold",
		blood = "Blood of Sargeras",
		knowledgeTooltip = "** Can be completed after reaching next artifact knowledge level",
		disableArrow = "Disable arrow",
		anchor = "Anchor",
		totalap = "Total Artifact Power: ",
		totalapdisable = 'Disable "Total AP"',
		timeToComplete = "Time to complete: ",
		bountyIgnoreFilter = "Emissary quests",
		enigmaHelper = "Enable Enigma Helper",
		barrelsHelper = "Enable Barrels Helper",
		honorIgnoreFilter = "PvP quests",
		ignoreFilter = "Ignore filter for",
		epicIgnoreFilter = '"Golden" quests',
		wantedIgnoreFilter = "WANTED quests",
		apFormatSetup = "Artifact Power format",
		headerEnable = "Enable header line",
		disabeHighlightNewQuests = "Disable highlight for new quests",
		distance = "Distance",
		disableBountyIcon = "Disable Emissary icons for faction names",
	}

local orderResName = GetCurrencyInfo(1220)
local filters = {
	{LOCALE.gear,2^0},
	{ARTIFACT_POWER,2^1},
	{orderResName,2^2},
	{LOCALE.blood,2^5},
	{LOCALE.gold,2^3},
	{OTHER,2^4},
}
local ActiveFilter = 2 ^ #filters - 1
local ActiveFilterType

local ActiveSort = 5

local WorldMapHideWQLCheck
local UpdateScale
local UpdateAnchor

local FIRST_NUMBER, SECOND_NUMBER, THIRD_NUMBER, FOURTH_NUMBER = FIRST_NUMBER, SECOND_NUMBER, THIRD_NUMBER, FOURTH_NUMBER

if SECOND_NUMBER then
	if locale == "deDE" or locale == "frFR" then
		SECOND_NUMBER = SECOND_NUMBER:match("|7([^:]+):")
		THIRD_NUMBER = THIRD_NUMBER:match("|7([^:]+):")
		FOURTH_NUMBER = FOURTH_NUMBER:match("|7([^:]+):")
	elseif locale == "ptBR" then
		SECOND_NUMBER = SECOND_NUMBER:match("|7([^h]+h)")
		THIRD_NUMBER = THIRD_NUMBER:match("|7([^h]+h)")
		FOURTH_NUMBER = FOURTH_NUMBER:match("|7([^h]+h)")
	elseif locale == "esES" or locale == "esMX" then
		SECOND_NUMBER = SECOND_NUMBER:match("|7([^l]+ll)")
		FOURTH_NUMBER = FOURTH_NUMBER:match("|7([^l]+ll)")
	elseif locale == "itIT" then
		SECOND_NUMBER = SECOND_NUMBER:match("|7([^:]+).:")
		THIRD_NUMBER = THIRD_NUMBER:match("|7([^:]+).:")
		FOURTH_NUMBER = FOURTH_NUMBER:match("|7([^:]+).:")
	end
end

local WorldQuestList_Update

local is72
do
	local expansion,majorPatch,minorPatch = (GetBuildInfo() or "1.0.0"):match("^(%d+)%.(%d+)%.(%d+)")
	local ver = (expansion or 0) * 10000 + (majorPatch or 0) * 100 + (minorPatch or 0)
	if ver >= 70200 then
		is72 = true
	end
end


local WorldQuestList_Update_PrevZone = nil

local UpdateTicker = nil

local ELib = {}

local function EnableClickArrow()
	hooksecurefunc("TaskPOI_OnClick", function (self,button)
		if not GExRT or VWQL.DisableArrow then
			return
		end
		if self.worldQuest and button == "LeftButton" then
			local mapAreaID = GetCurrentMapAreaID()
			local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapAreaID)
			local numTaskPOIs = 0
			if(taskInfo ~= nil) then
				numTaskPOIs = #taskInfo
			end
			
			local hasWorldQuests = false;
			local taskIconIndex = 1;
			if ( numTaskPOIs > 0 ) then
				for i, info  in ipairs(taskInfo) do
					if info.questId == self.questID then
						local floor, a1, b1, c1, d1 = GetCurrentMapDungeonLevel()
						local _, a2, b2, c2, d2 = GetCurrentMapZone()
						if not a1 or not b1 or not c1 or not d1 then
							a1, b1, c1, d1 = c2, d2, a2, b2
						end
						local x = c1 - info.x * abs(c1-a1)
						local y = d1 - info.y * abs(d1-b1)
					
						GExRT.F.Arrow:ShowRunTo(x,y,40,nil,true)
						return
					end
				end
			end
		end
	end)
	EnableClickArrow = nil
end


local WorldQuestList_Width = 450+70
local WorldQuestList_ZoneWidth = 100

local WorldQuestList = CreateFrame("Frame","WorldQuestsListFrame",WorldMapFrame)
WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"TOPRIGHT",10,-4)
WorldQuestList:SetSize(550,300)

WorldQuestList:SetScript("OnHide",function(self)
	if self:GetParent() ~= WorldMapFrame then
		self:SetParent(WorldMapFrame)
		UpdateAnchor()
	end
	WorldQuestList_Update_PrevZone = nil
	WorldQuestList.Cheader:SetVerticalScroll(0)
	WorldQuestList.Close:Hide()
end)
WorldQuestList:SetScript("OnShow",function(self)
	C_Timer.After(2.5,function()
		UpdateTicker = true
	end)
end)

WorldQuestList.Cheader = CreateFrame("ScrollFrame", nil, WorldQuestList) 
WorldQuestList.Cheader:SetPoint("LEFT")
WorldQuestList.Cheader:SetPoint("RIGHT")
WorldQuestList.Cheader:SetPoint("BOTTOM")
WorldQuestList.Cheader:SetPoint("TOP")

WorldQuestList.Cheader.lines = {}
for i=1,100 do
	local line = CreateFrame("Frame",nil,WorldQuestList.Cheader)
	line:SetPoint("TOPLEFT",0,-(i-1)*16)
	line:SetSize(1,16)
	WorldQuestList.Cheader.lines[i] = line
end

WorldQuestList.C = CreateFrame("Frame", nil, WorldQuestList.Cheader) 
WorldQuestList.Cheader:SetScrollChild(WorldQuestList.C)
WorldQuestList.Cheader:SetScript("OnMouseWheel", function (self,delta)
	delta = delta * 16
	local max = max(0 , WorldQuestList.C:GetHeight() - self:GetHeight() )
	local val = self:GetVerticalScroll()
	if (val - delta) < 0 then
		self:SetVerticalScroll(0)
	elseif (val - delta) > max then
		self:SetVerticalScroll(max)
	else
		self:SetVerticalScroll(val - delta)
	end
end)
WorldQuestList.C:SetWidth(WorldQuestList_Width)

local function UpdateScrollButtonsState()
	local val = WorldQuestList.Cheader:GetVerticalScroll()

	if val > 3.5 then
		WorldQuestList.ScrollUpLine:Show()
	else
		WorldQuestList.ScrollUpLine:Hide()
	end
	
	local maxScroll = WorldQuestList.Cheader:GetVerticalScrollRange()
	if maxScroll > 4.5 and not ((maxScroll - val) < 5) then
		WorldQuestList.ScrollDownLine:Show()
	else
		WorldQuestList.ScrollDownLine:Hide()
	end
end

WorldQuestList.Cheader:SetScript("OnVerticalScroll",function(self,val)
	UpdateScrollButtonsState()
end)

WorldQuestList.ScrollDownLine = CreateFrame("Button", nil, WorldQuestList)
WorldQuestList.ScrollDownLine:SetPoint("LEFT",-1,0)
WorldQuestList.ScrollDownLine:SetPoint("RIGHT",1,0)
WorldQuestList.ScrollDownLine:SetPoint("BOTTOM",0,-1)
WorldQuestList.ScrollDownLine:SetHeight(15)
WorldQuestList.ScrollDownLine:SetFrameLevel(120)
WorldQuestList.ScrollDownLine:Hide()
WorldQuestList.ScrollDownLine:SetScript("OnEnter",function(self)
	self.entered = true
	self.timer = C_Timer.NewTicker(.05,function(timer)
		if not self.entered then
			timer:Cancel()
			self.timer = nil
			return
		end
		local limit = WorldQuestList.C:GetHeight()
		local curr = WorldQuestList.Cheader:GetVerticalScroll()
		WorldQuestList.Cheader:SetVerticalScroll(min(curr + 4,limit - WorldQuestList.Cheader:GetHeight() + 14))
	end)
end)
WorldQuestList.ScrollDownLine:SetScript("OnLeave",function(self)
	self.entered = nil
end)
WorldQuestList.ScrollDownLine:SetScript("OnHide",function(self)
	if self.timer then
		self.timer:Cancel()
	end
	self.timer = nil
	self.entered = nil
end)
WorldQuestList.ScrollDownLine:SetScript("OnClick",function(self)
	local limit = WorldQuestList.C:GetHeight()
	WorldQuestList.Cheader:SetVerticalScroll(limit - WorldQuestList.Cheader:GetHeight())
end)

WorldQuestList.ScrollDownLine.b = WorldQuestList.ScrollDownLine:CreateTexture(nil,"BACKGROUND")
WorldQuestList.ScrollDownLine.b:SetAllPoints()
WorldQuestList.ScrollDownLine.b:SetColorTexture(.3,.3,.3,.9)

WorldQuestList.ScrollDownLine.i = WorldQuestList.ScrollDownLine:CreateTexture(nil,"ARTWORK")
WorldQuestList.ScrollDownLine.i:SetTexture("Interface\\AddOns\\WorldQuestsList\\navButtons")
WorldQuestList.ScrollDownLine.i:SetPoint("CENTER")
WorldQuestList.ScrollDownLine.i:SetTexCoord(0,.25,0,1)
WorldQuestList.ScrollDownLine.i:SetSize(14,14)

WorldQuestList.ScrollUpLine = CreateFrame("Button", nil, WorldQuestList)
WorldQuestList.ScrollUpLine:SetPoint("LEFT",-1,0)
WorldQuestList.ScrollUpLine:SetPoint("RIGHT",1,0)
WorldQuestList.ScrollUpLine:SetPoint("TOP",WorldQuestList.Cheader,0,1)
WorldQuestList.ScrollUpLine:SetHeight(15)
WorldQuestList.ScrollUpLine:SetFrameLevel(120)
WorldQuestList.ScrollUpLine:Hide()
WorldQuestList.ScrollUpLine:SetScript("OnEnter",function(self)
	self.entered = true
	self.timer = C_Timer.NewTicker(.05,function(timer)
		if not self.entered then
			timer:Cancel()
			self.timer = nil
			return
		end
		local limit = WorldQuestList.C:GetHeight()
		local curr = WorldQuestList.Cheader:GetVerticalScroll()
		WorldQuestList.Cheader:SetVerticalScroll(max(curr - 4,0))
	end)
end)
WorldQuestList.ScrollUpLine:SetScript("OnLeave",function(self)
	self.entered = nil
end)
WorldQuestList.ScrollUpLine:SetScript("OnHide",function(self)
	if self.timer then
		self.timer:Cancel()
	end
	self.timer = nil
	self.entered = nil
end)
WorldQuestList.ScrollUpLine:SetScript("OnClick",function(self)
	WorldQuestList.Cheader:SetVerticalScroll(0)
end)

WorldQuestList.ScrollUpLine.b = WorldQuestList.ScrollUpLine:CreateTexture(nil,"BACKGROUND")
WorldQuestList.ScrollUpLine.b:SetAllPoints()
WorldQuestList.ScrollUpLine.b:SetColorTexture(.3,.3,.3,.9)

WorldQuestList.ScrollUpLine.i = WorldQuestList.ScrollUpLine:CreateTexture(nil,"ARTWORK")
WorldQuestList.ScrollUpLine.i:SetTexture("Interface\\AddOns\\WorldQuestsList\\navButtons")
WorldQuestList.ScrollUpLine.i:SetPoint("CENTER")
WorldQuestList.ScrollUpLine.i:SetTexCoord(.25,.5,0,1)
WorldQuestList.ScrollUpLine.i:SetSize(14,14)

WorldQuestList.b = WorldQuestList:CreateTexture(nil,"BACKGROUND")
WorldQuestList.b:SetAllPoints()
WorldQuestList.b:SetColorTexture(0,0,0,1)

WorldQuestList.backdrop = CreateFrame("Frame",nil,WorldQuestList)
WorldQuestList.backdrop:SetPoint("TOPLEFT",-4,4)
WorldQuestList.backdrop:SetPoint("BOTTOMRIGHT",4,-4)
WorldQuestList.backdrop:SetBackdrop({edgeFile="Interface/Tooltips/UI-Tooltip-Border",tile=false,edgeSize=14,insets={left=2.5,right=2.5,top=2.5,bottom=2.5}})

WorldQuestList.mapB = WorldMapButton:CreateTexture(nil,"OVERLAY")
WorldQuestList.mapB:SetSize(80,80)
WorldQuestList.mapB:SetTexture("Interface\\AddOns\\WorldQuestsList\\Button-Pushed")
WorldQuestList.mapB:Hide()

WorldQuestList.mapC = WorldMapButton:CreateTexture(nil,"OVERLAY")
WorldQuestList.mapC:SetSize(50,50)
WorldQuestList.mapC:SetTexture("Interface\\AddOns\\WorldQuestsList\\Button-Pushed")
WorldQuestList.mapC:Hide()

WorldQuestList.mapC = WorldMapButton:CreateTexture(nil,"OVERLAY")
WorldQuestList.mapC:SetSize(50,50)
WorldQuestList.mapC:SetTexture("Interface\\AddOns\\WorldQuestsList\\Button-Pushed")
WorldQuestList.mapC:Hide()

WorldQuestList.mapD = WorldMapButton:CreateTexture(nil,"OVERLAY")
WorldQuestList.mapD:SetSize(24,24)
WorldQuestList.mapD:SetAtlas("XMarksTheSpot")
WorldQuestList.mapD:SetPoint("CENTER",WorldQuestList.mapC)
WorldQuestList.mapD:Hide()

WorldQuestList.TotalAP = WorldQuestList:CreateFontString(nil,"ARTWORK","GameFontWhite")
WorldQuestList.TotalAP:SetPoint("TOPLEFT",WorldQuestList,"BOTTOMLEFT",5,-4)
WorldQuestList.TotalAP:SetJustifyH("LEFT")
WorldQuestList.TotalAP:SetJustifyV("TOP")
WorldQuestList.TotalAP:SetSize(1000,1000)
do
	local a1,a2 = WorldQuestList.TotalAP:GetFont()
	WorldQuestList.TotalAP:SetFont(a1,a2,"OUTLINE")
end
local ArtifactRelicSubclass = "Artifact Relic"

WorldQuestList.Close = CreateFrame("Button",nil,WorldQuestList)
WorldQuestList.Close:SetPoint("BOTTOMLEFT",WorldQuestList,"TOPRIGHT",5,5)
WorldQuestList.Close:SetSize(25,25)
WorldQuestList.Close:SetScript("OnClick",function()
	WorldQuestList:Hide()
	WorldQuestList:Show()
end)
WorldQuestList.Close:Hide()

WorldQuestList.Close.X = WorldQuestList.Close:CreateFontString(nil,"ARTWORK","GameFontWhite")
WorldQuestList.Close.X:SetPoint("CENTER",WorldQuestList.Close)
WorldQuestList.Close.X:SetText("X")
do
	local a1,a2 = WorldQuestList.Close.X:GetFont()
	WorldQuestList.Close.X:SetFont(a1,14)
end
WorldQuestList.Close.b = WorldQuestList.Close:CreateTexture(nil,"BACKGROUND")
WorldQuestList.Close.b:SetAllPoints()
WorldQuestList.Close.b:SetColorTexture(0,0,0,.8)

WorldQuestList:RegisterEvent('ADDON_LOADED')
WorldQuestList:SetScript("OnEvent",function(self,event,...)
	if event == 'ADDON_LOADED' then
		self:UnregisterEvent('ADDON_LOADED')
		VWQL = VWQL or {
			VERSION = VERSION,
		}
		
		if not VWQL.VERSION then
			VWQL.VERSION = VERSION
			for q,w in pairs(VWQL) do
				if type(w)=='table' and w.Filter then
					--Blood of Sargeras Fix
					w.Filter = bit.bor(w.Filter,filters[4][2])
				end
			end
		end
		
		VWQL[charKey] = VWQL[charKey] or {}
		
		VWQL[charKey].Quests = VWQL[charKey].Quests or {}
		
		VWQL[charKey].Filter = VWQL[charKey].Filter and tonumber(VWQL[charKey].Filter) or ActiveFilter
		ActiveFilter = VWQL[charKey].Filter
		
		VWQL[charKey].FilterType = VWQL[charKey].FilterType or {}
		ActiveFilterType = VWQL[charKey].FilterType
		
		VWQL.Sort = VWQL.Sort and tonumber(VWQL.Sort) or ActiveSort
		ActiveSort = VWQL.Sort
		
		WorldMapHideWQLCheck:SetChecked(not VWQL[charKey].HideMap)
		
		WorldQuestList.modeSwitcherCheck:SetChecked(not VWQL[charKey].RegularQuestMode)

		local _,_,arsc = GetItemInfoInstant(138227)
		ArtifactRelicSubclass = arsc
		if not ArtifactRelicSubclass then
			ArtifactRelicSubclass = "Artifact Relic"
		end

		if not VWQL.DisableArrow and EnableClickArrow then
			EnableClickArrow()
		end
		
		UpdateScale()
		UpdateAnchor()
		WorldQuestList.header:Update()
	end
end)


local function WorldQuestList_Line_OnEnter(self)
	if not self.questID then
		return
	end
	local isButtonExist = false
	for i=1,500 do
		local existingButton = _G["WorldMapFrameTaskPOI"..i]
		if not existingButton then
			break
		end
		if existingButton.questID == self.questID and existingButton:IsVisible() and existingButton:IsShown() then
			WorldQuestList.mapB:ClearAllPoints()
			WorldQuestList.mapB:SetPoint("CENTER",existingButton,0,0)
			WorldQuestList.mapB:Show()
			isButtonExist = true
		end
	end
	if not isButtonExist and self.data and self.data.Wx and not self.isLeveling then
		WorldQuestList.mapC:ClearAllPoints()
		WorldQuestList.mapC:SetPoint("CENTER",WorldMapButton,"BOTTOMRIGHT",-WorldMapButton:GetWidth() * self.data.Wx,WorldMapButton:GetHeight() * self.data.Wy)
		WorldQuestList.mapC:Show()
		WorldQuestList.mapD:Show()
	end
	self.hl:Show()
	
	if self.isLeveling then
		local existingButton = QuestPOI_FindButton(WorldMapPOIFrame, self.questID)
		if existingButton then
			WorldQuestList.mapB:ClearAllPoints()
			WorldQuestList.mapB:SetPoint("CENTER",existingButton,0,0)
			WorldQuestList.mapB:Show()		
		elseif self.data and self.data.Wx then
			WorldQuestList.mapC:ClearAllPoints()
			WorldQuestList.mapC:SetPoint("CENTER",WorldMapButton,"BOTTOMRIGHT",-WorldMapButton:GetWidth() * self.data.Wx,WorldMapButton:GetHeight() * self.data.Wy)
			WorldQuestList.mapC:Show()
			WorldQuestList.mapD:Show()
		end
	end
end

local function WorldQuestList_Line_OnLeave(self)
	WorldQuestList.mapB:Hide()
	WorldQuestList.mapC:Hide()
	WorldQuestList.mapD:Hide()
	self.hl:Hide()
end

local function WorldQuestList_Line_OnClick(self,button)
	if button == "RightButton" then
		WorldMapButton:Click("RightButton")
	end
end

local additionalTooltips = {}

local function GetAdditionalTooltip(i,isBottom)
	if not additionalTooltips[i] then
		additionalTooltips[i] = CreateFrame("GameTooltip", "WorldQuestsListAdditionalTooltip"..i, UIParent, "GameTooltipTemplate")
	end
	local tooltip = additionalTooltips[i]
	local owner = nil
	if i == 2 then
		owner = GameTooltip
	else
		owner = additionalTooltips[i - 1]
	end
	tooltip:SetOwner(owner, "ANCHOR_NONE")
	tooltip:ClearAllPoints()
	if isBottom then
		tooltip:SetPoint("TOPLEFT",owner,"BOTTOMLEFT",0,0)
	else
		tooltip:SetPoint("TOPRIGHT",owner,"TOPLEFT",0,0)
	end
	
	return tooltip
end

local function WorldQuestList_LineReward_OnEnter(self)
	local line = self:GetParent()
	if line.reward.ID and GetNumQuestLogRewards(line.reward.ID) > 0 then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetQuestLogItem("reward", 1, line.reward.ID)
		GameTooltip:Show()
		
		local additional = 2
		if line.reward.IDs then
			for i=2,line.reward.IDs do
				local tooltip = GetAdditionalTooltip(additional)
				tooltip:SetQuestLogItem("reward", i, line.reward.ID)
				tooltip:Show()
				additional = additional + 1
			end
		end
		if line.reward.artifactKnowlege then
			local tooltip = GetAdditionalTooltip(additional,true)
			tooltip:AddLine(LOCALE.knowledgeTooltip)
			if line.reward.timeToComplete then
				local timeLeftMinutes, timeString = line.reward.timeToComplete
				if timeLeftMinutes >= 14400 then
					timeString = ""		--A lot, 10+ days
				elseif timeLeftMinutes >= 1440 then
					timeString = format("%d.%02d:%02d",floor(timeLeftMinutes / 1440),floor(timeLeftMinutes / 60) % 24, timeLeftMinutes % 60)
				else
					timeString = (timeLeftMinutes >= 60 and (floor(timeLeftMinutes / 60) % 24) or "0")..":"..format("%02d",timeLeftMinutes % 60)
				end
			
				tooltip:AddLine(LOCALE.timeToComplete..timeString)
			end
			tooltip:Show()
			additional = additional + 1
		end
		if line.reward:IsTruncated() then
			local text = line.reward:GetText()
			if text and text ~= "" then
				local tooltip = GetAdditionalTooltip(additional,true)
				tooltip:AddLine(text)
				tooltip:Show()
				additional = additional + 1
			end
		end
		
		self:RegisterEvent('MODIFIER_STATE_CHANGED')
	elseif line.reward:IsTruncated() then
		local text = line.reward:GetText()
		if text and text ~= "" then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(text)
			GameTooltip:Show()
		end
	end

	WorldQuestList_Line_OnEnter(line)
end
local function WorldQuestList_LineReward_OnLeave(self)
	self:UnregisterEvent('MODIFIER_STATE_CHANGED')
	GameTooltip_Hide()
	GameTooltip:ClearLines()
	WorldQuestList_Line_OnLeave(self:GetParent())
	for _,tip in pairs(additionalTooltips) do
		tip:Hide()
	end
end
local function WorldQuestList_LineReward_OnClick(self,button)
	if button == "LeftButton" then
		local itemLink = self:GetParent().rewardLink
		if not itemLink then
			return
		elseif IsModifiedClick("DRESSUP") then
			return DressUpItemLink(itemLink)
		elseif IsModifiedClick("CHATLINK") then
			if ChatEdit_GetActiveWindow() then
				ChatEdit_InsertLink(itemLink)
			else
				ChatFrame_OpenChat(itemLink)
			end
		end
	elseif button == "RightButton" then
		WorldQuestList_Line_OnClick(self:GetParent(),"RightButton")
	end
end
local function WorldQuestList_LineReward_OnEvent(self)
	if self:IsMouseOver() then
		WorldQuestList_LineReward_OnLeave(self)
		WorldQuestList_LineReward_OnEnter(self)
	end
end

local function WorldQuestList_LineFaction_OnEnter(self)
	if self.tooltip then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(self.tooltip)
		GameTooltip:Show()
	end
	WorldQuestList_Line_OnEnter(self:GetParent())
end
local function WorldQuestList_LineFaction_OnLeave(self)
	GameTooltip_Hide()
	WorldQuestList_Line_OnLeave(self:GetParent())
end


local function WorldQuestList_LineName_OnEnter(self)
	local line = self:GetParent()
	local questID = line.questID
	if questID and not line.isLeveling then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		local title, factionID = C_TaskQuest.GetQuestInfoByQuestID(questID)
		local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex = GetQuestTagInfo(questID)
		
		local color = WORLD_QUEST_QUALITY_COLORS[rarity]
		GameTooltip:SetText(title, color.r, color.g, color.b)
		
		if ( factionID ) then
			local factionName = GetFactionInfoByID(factionID)
			if ( factionName ) then
				GameTooltip:AddLine(factionName)
			end
		end
		
		for objectiveIndex = 1, line.numObjectives do
			local objectiveText, objectiveType, finished = GetQuestObjectiveInfo(questID, objectiveIndex, false)
			if ( objectiveText and #objectiveText > 0 ) then
				local color = finished and GRAY_FONT_COLOR or HIGHLIGHT_FONT_COLOR;
				GameTooltip:AddLine(QUEST_DASH .. objectiveText, color.r, color.g, color.b, true)
			end
		end
		
		GameTooltip:AddLine(format("QuestID: %d",questID),.5,.5,1)
	
		GameTooltip:Show()
	elseif line.isLeveling and questID then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink("quest:"..questID)
		GameTooltip:Show()
	end
	WorldQuestList_Line_OnEnter(line)
end
local function WorldQuestList_LineName_OnLeave(self)
	GameTooltip_Hide()
	WorldQuestList_Line_OnLeave(self:GetParent())
end

local function WorldQuestList_LineName_OnClick(self,button)
	if button == "LeftButton" then
		local line = self:GetParent()
		local questID = line.questID

		--[[
		if questID and line.data.x then
			for i=1,500 do
				local existingButton = _G["WorldMapFrameTaskPOI"..i]
				if not existingButton then
					break
				end
				if existingButton.questID == questID and existingButton:IsVisible() then
					existingButton:Click()
					return				
				end
			end
		end
		]]

		if not line.isLeveling then
			if IsShiftKeyDown() then
				if IsWorldQuestHardWatched(questID) or (IsWorldQuestWatched(questID) and GetSuperTrackedQuestID() == questID) then
					BonusObjectiveTracker_UntrackWorldQuest(questID)
				else
					BonusObjectiveTracker_TrackWorldQuest(questID, true)
				end
			else
				if IsWorldQuestHardWatched(questID) then
					SetSuperTrackedQuestID(questID)
				else
					BonusObjectiveTracker_TrackWorldQuest(questID)
				end
			end
		end
		
		if line.data and not IsShiftKeyDown() then
			local Wx,Wy = line.data.Wx,line.data.Wy
			if (GExRT and not VWQL.DisableArrow) and Wx and Wy then
				Wx = 1 - Wx
				Wy = 1 - Wy
				local floor, a1, b1, c1, d1 = GetCurrentMapDungeonLevel()
				local _, a2, b2, c2, d2 = GetCurrentMapZone()
				if not a1 or not b1 or not c1 or not d1 then
					a1, b1, c1, d1 = c2, d2, a2, b2
				end
				local x = c1 - Wx * abs(c1-a1)
				local y = d1 - Wy * abs(d1-b1)
			
				GExRT.F.Arrow:ShowRunTo(x,y,30,nil,true)
			end
		end


		local info = line.data
		if info and info.zoneMapID and GetCurrentMapAreaID() == 1007 and not IsShiftKeyDown() then
			WorldQuestList.mapC:Hide()
			WorldQuestList.mapD:Hide()
			SetMapByID(info.zoneMapID)
			C_Timer.After(.1,function()
				if not questID then
					return
				end
				for i=1,500 do
					local existingButton = _G["WorldMapFrameTaskPOI"..i]
					if not existingButton then
						break
					end
					if existingButton.questID == questID and existingButton:IsVisible() and existingButton:IsShown() then
						WorldQuestList.mapB:ClearAllPoints()
						WorldQuestList.mapB:SetPoint("CENTER",existingButton,0,0)
						WorldQuestList.mapB:Show()
					end
				end
			end)
		end
	elseif button == "RightButton" then
		WorldQuestList_Line_OnClick(self:GetParent(),"RightButton")
	end
end

local function WorldQuestList_LineZone_OnEnter(self)
	WorldQuestList_Line_OnEnter(self:GetParent())
end
local function WorldQuestList_LineZone_OnLeave(self)
	WorldQuestList_Line_OnLeave(self:GetParent())
end

local function WorldQuestList_LineZone_OnClick(self,button)
	if button == "LeftButton" then
		local info = self:GetParent().data
		if info and info.zoneMapID then
			SetMapByID(info.zoneMapID)
		end
	elseif button == "RightButton" then
		WorldQuestList_Line_OnClick(self:GetParent(),"RightButton")
	end
end

local function WorldQuestList_Timeleft_OnEnter(self)
	WorldQuestList_Line_OnEnter(self:GetParent())
	if self._t then
		local t = time() + self._t * 60
		t = floor(t / 60) * 60
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		local format = "%x %X"
		if date("%x",t) == date("%x") then
			format = "%X"
		end
		GameTooltip:AddLine(date(format,t))
		GameTooltip:Show()
	end
end
local function WorldQuestList_Timeleft_OnLeave(self)
	WorldQuestList_Line_OnLeave(self:GetParent())
	GameTooltip_Hide()
end

local NAME_WIDTH = 135

WorldQuestList.l = {}
local function WorldQuestList_CreateLine(i)
	if WorldQuestList.l[i] then
		return
	end
	WorldQuestList.l[i] = CreateFrame("Button",nil,WorldQuestList.C)
	local line = WorldQuestList.l[i]
	line:SetPoint("TOPLEFT",0,-(i-1)*16)
	line:SetPoint("BOTTOMRIGHT",WorldQuestList.C,"TOPRIGHT",0,-i*16)
	
	line:SetScript("OnEnter",WorldQuestList_Line_OnEnter)
	line:SetScript("OnLeave",WorldQuestList_Line_OnLeave)
	line:SetScript("OnClick",WorldQuestList_Line_OnClick)
	line:RegisterForClicks("RightButtonUp")
	
	line.nameicon = line:CreateTexture(nil, "BACKGROUND")
	line.nameicon:SetPoint("LEFT",3,0)
	line.nameicon:SetSize(1,16)
	
	line.secondicon = line:CreateTexture(nil, "BACKGROUND")
	line.secondicon:SetPoint("LEFT",line.nameicon,"RIGHT",0,0)
	line.secondicon:SetSize(1,16)	

	line.name = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.name:SetPoint("LEFT",line.secondicon,"RIGHT",0,0)
	line.name:SetSize(135,20)
	line.name:SetJustifyH("LEFT")

	line.reward = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.reward:SetPoint("LEFT",line.name,"RIGHT",5,0)
	line.reward:SetSize(180,20)
	line.reward:SetJustifyH("LEFT")

	line.faction = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.faction:SetPoint("LEFT",line.reward,"RIGHT",5,0)
	line.faction:SetSize(115,20)
	line.faction:SetJustifyH("LEFT")
	
	line.faction.f = CreateFrame("Frame",nil,line)
	line.faction.f:SetAllPoints(line.faction)
	line.faction.f:SetScript("OnEnter",WorldQuestList_LineFaction_OnEnter)
	line.faction.f:SetScript("OnLeave",WorldQuestList_LineFaction_OnLeave)

	line.timeleft = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.timeleft:SetPoint("LEFT",line.faction,"RIGHT",5,0)
	line.timeleft:SetSize(65,20)
	line.timeleft:SetJustifyH("LEFT")

	line.zone = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.zone:SetPoint("LEFT",line.timeleft,"RIGHT",5,0)
	line.zone:SetSize(100,20)
	line.zone:SetJustifyH("LEFT")
	
	line.zone.f = CreateFrame("Button",nil,line)
	line.zone.f:SetAllPoints(line.zone)
	line.zone.f:SetScript("OnEnter",WorldQuestList_LineZone_OnEnter)
	line.zone.f:SetScript("OnLeave",WorldQuestList_LineZone_OnLeave)
	line.zone.f:SetScript("OnClick",WorldQuestList_LineZone_OnClick)
	line.zone.f:RegisterForClicks("LeftButtonDown","RightButtonUp")
	
	line.reward.f = CreateFrame("Button",nil,line)
	line.reward.f:SetAllPoints(line.reward)
	line.reward.f:SetScript("OnEnter",WorldQuestList_LineReward_OnEnter)
	line.reward.f:SetScript("OnLeave",WorldQuestList_LineReward_OnLeave)
	line.reward.f:SetScript("OnClick",WorldQuestList_LineReward_OnClick)
	line.reward.f:SetScript("OnEvent",WorldQuestList_LineReward_OnEvent)
	line.reward.f:RegisterForClicks("LeftButtonDown","RightButtonUp")
	
	--line.reward.f.icon = line.reward.f:CreateTexture(nil, "BACKGROUND")

	line.name.f = CreateFrame("Button",nil,line)
	line.name.f:SetAllPoints(line.name)
	line.name.f:SetScript("OnEnter",WorldQuestList_LineName_OnEnter)
	line.name.f:SetScript("OnLeave",WorldQuestList_LineName_OnLeave)
	line.name.f:SetScript("OnClick",WorldQuestList_LineName_OnClick)
	line.name.f:RegisterForClicks("LeftButtonDown","RightButtonUp")
	
	line.timeleft.f = CreateFrame("Frame",nil,line)
	line.timeleft.f:SetAllPoints(line.timeleft)
	line.timeleft.f:SetScript("OnEnter",WorldQuestList_Timeleft_OnEnter)
	line.timeleft.f:SetScript("OnLeave",WorldQuestList_Timeleft_OnLeave)
	
	line.hl = line:CreateTexture(nil, "BACKGROUND")
	line.hl:SetPoint("TOPLEFT", 0, -1)
	line.hl:SetPoint("BOTTOMRIGHT", 0, 1)
	line.hl:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
	line.hl:SetBlendMode("ADD")
	line.hl:SetVertexColor(.6,.6,1,1)
	line.hl:Hide()
	
	line.nqhl = line:CreateTexture(nil, "BACKGROUND",nil,-1)
	line.nqhl:SetPoint("TOPLEFT", 0, -1)
	line.nqhl:SetPoint("BOTTOMRIGHT", 0, 1)
	line.nqhl:SetTexture("Interface\\Buttons\\WHITE8X8")
	line.nqhl:SetBlendMode("ADD")
	line.nqhl:SetVertexColor(.7,.7,1,.2)
	line.nqhl:Hide()
end

do
	local function WorldQuestList_HeaderLine_OnClick(self)
		if ActiveSort == self.sort then
			VWQL.ReverseSort = not VWQL.ReverseSort
		end
		ActiveSort = self.sort
		VWQL.Sort = ActiveSort
		ELib.ScrollDropDown.Close()
		WorldQuestList_Update_PrevZone = nil
		WorldQuestList_Update()
	end
	local function WorldQuestList_HeaderLine_OnEnter(self)
		local _,parent = self:GetPoint()
		parent:SetTextColor(1,1,0)
	end	
	local function WorldQuestList_HeaderLine_OnLeave(self)
		local _,parent = self:GetPoint()
		parent:SetTextColor(1,1,1)
	end	

	WorldQuestList.header = CreateFrame("Button",nil,WorldQuestList)
	local line = WorldQuestList.header
	line:SetPoint("TOPLEFT",0,0)
	line:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",0,-16)
	
	line.b = line:CreateTexture(nil,"BACKGROUND")
	line.b:SetAllPoints()
	line.b:SetColorTexture(.3,.3,.3,1)
	
	line.name = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.name:SetPoint("LEFT",3,0)
	line.name:SetSize(135,20)
	line.name:SetJustifyH("LEFT")
	line.name.text = CALENDAR_EVENT_NAME
	
	line.name.f = CreateFrame("Button",nil,line)
	line.name.f:SetAllPoints(line.name)
	line.name.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.name.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.name.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.name.f:RegisterForClicks("LeftButtonDown")
	line.name.f.sort = 3

	line.reward = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.reward:SetPoint("LEFT",line.name,"RIGHT",5,0)
	line.reward:SetSize(180,20)
	line.reward:SetJustifyH("LEFT")
	line.reward.text = REWARDS

	line.reward.f = CreateFrame("Button",nil,line)
	line.reward.f:SetAllPoints(line.reward)
	line.reward.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.reward.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.reward.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.reward.f:RegisterForClicks("LeftButtonDown")
	line.reward.f.sort = 5

	line.faction = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.faction:SetPoint("LEFT",line.reward,"RIGHT",5,0)
	line.faction:SetSize(115,20)
	line.faction:SetJustifyH("LEFT")
	line.faction.text = FACTION
	
	line.faction.f = CreateFrame("Button",nil,line)
	line.faction.f:SetAllPoints(line.faction)
	line.faction.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.faction.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.faction.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.faction.f:RegisterForClicks("LeftButtonDown")
	line.faction.f.sort = 4

	line.timeleft = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.timeleft:SetPoint("LEFT",line.faction,"RIGHT",5,0)
	line.timeleft:SetSize(65,20)
	line.timeleft:SetJustifyH("LEFT")
	line.timeleft.text = TIME_LABEL:match("^[^:]+")
	
	line.timeleft.f = CreateFrame("Button",nil,line)
	line.timeleft.f:SetAllPoints(line.timeleft)
	line.timeleft.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.timeleft.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.timeleft.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.timeleft.f:RegisterForClicks("LeftButtonDown")
	line.timeleft.f.sort = 1

	line.zone = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
	line.zone:SetPoint("LEFT",line.timeleft,"RIGHT",5,0)
	line.zone:SetSize(100,20)
	line.zone:SetJustifyH("LEFT")
	line.zone.text = ZONE
	
	line.zone.f = CreateFrame("Button",nil,line)
	line.zone.f:SetAllPoints(line.zone)
	line.zone.f:SetScript("OnClick",WorldQuestList_HeaderLine_OnClick)
	line.zone.f:SetScript("OnEnter",WorldQuestList_HeaderLine_OnEnter)
	line.zone.f:SetScript("OnLeave",WorldQuestList_HeaderLine_OnLeave)
	line.zone.f:RegisterForClicks("LeftButtonDown")
	line.zone.f.sort = 2

	local str = {'name','reward','faction','timeleft','zone'}
	
	line.Update = function(self,disable,disabeZone)
		if VWQL.DisableHeader or disable then
			self:Hide()
			WorldQuestList.Cheader:SetPoint("TOP",0,0)
			return
		else
			self:Show()
			WorldQuestList.Cheader:SetPoint("TOP",0,-16)
		end
		
		line.zone:SetShown(disabeZone)
		line.zone.f:SetShown(disabeZone)
		
		for _,n in pairs(str) do
			line[n]:SetText(line[n].text)
		end

		local currSort = nil
		if ActiveSort == 1 then
			currSort = line.timeleft
		elseif ActiveSort == 2 then
			currSort = line.zone
		elseif ActiveSort == 3 then
			currSort = line.name
		elseif ActiveSort == 4 then
			currSort = line.faction
		elseif ActiveSort == 5 then
			currSort = line.reward
		end
		
		if currSort and VWQL.ReverseSort then
			currSort:SetText("|TInterface\\AddOns\\WorldQuestsList\\navButtons:16:16:0:0:64:16:17:32:0:16|t "..currSort:GetText())
		elseif currSort and not VWQL.ReverseSort then
			currSort:SetText("|TInterface\\AddOns\\WorldQuestsList\\navButtons:16:16:0:0:64:16:0:16:0:16|t "..currSort:GetText())
		end
	end
	
end

local ViewAllButton = CreateFrame("Button",nil,WorldQuestList,"UIPanelButtonTemplate")
ViewAllButton:SetPoint("TOPLEFT",0,0)
ViewAllButton:SetSize(300,25)
ViewAllButton:SetText("World Quests List: "..(QUEST_MAP_VIEW_ALL_FORMAT:gsub("|c.+$","")))
ViewAllButton:SetScript("OnClick",function()
	SetMapByID(1007)
end)
ViewAllButton:Hide()

WorldQuestList.sortDropDown = CreateFrame("Frame", "WorldQuestListSortDropDown", WorldQuestList, "UIDropDownMenuTemplate")
WorldQuestList.sortDropDown:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",15-120,0)
WorldQuestList.sortDropDown.Text:SetText(RAID_FRAME_SORT_LABEL:gsub(" ([^ ]+)$",""), nil)
UIDropDownMenu_SetWidth(WorldQuestList.sortDropDown, 100)
WorldQuestList.sortDropDown.Button.Width = 150
WorldQuestList.sortDropDown.Button.isButton = true
WorldQuestList.sortDropDown:SetScript("OnHide",function () ELib.ScrollDropDown.Close() end)

local function SetSort(_, arg1)
	ActiveSort = arg1
	VWQL.Sort = ActiveSort
	VWQL.ReverseSort = false
	ELib.ScrollDropDown.Close()
	WorldQuestList_Update_PrevZone = nil
	WorldQuestList_Update()
end

local TableSortNames = {
	TIME_LABEL:match("^[^:]+"),
	ZONE,
	NAME,
	FACTION,
	REWARDS,
	LOCALE.distance,
}

do
	local list = {}
	WorldQuestList.sortDropDown.Button.List = list
	for i=1,#TableSortNames do
		list[i] = {
			text = TableSortNames[i],
			radio = true,
			arg1 = i,
			func = SetSort,
		}
	end
	function WorldQuestList.sortDropDown.Button:additionalToggle()
		for i=1,#self.List do
			self.List[i].checkState = ActiveSort == i
		end
	end
end


WorldQuestList.sortDropDown.Button:SetScript("OnClick",function(self)
	ELib.ScrollDropDown.ClickButton(self)
end)

WorldQuestList.filterDropDown = CreateFrame("Frame", "WorldQuestListFilterDropDown", WorldQuestList, "UIDropDownMenuTemplate")
WorldQuestList.filterDropDown:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",15,0)
WorldQuestList.filterDropDown.Text:SetText(FILTERS)
UIDropDownMenu_SetWidth(WorldQuestList.filterDropDown, 100)
WorldQuestList.filterDropDown.Button.Width = 220
WorldQuestList.filterDropDown.Button.isButton = true
WorldQuestList.filterDropDown:SetScript("OnHide",function () ELib.ScrollDropDown.Close() end)

local function SetFilter(_, arg1)
	if bit.band(filters[arg1][2],ActiveFilter) > 0 then
		ActiveFilter = bit.bxor(ActiveFilter,filters[arg1][2])
	else
		ActiveFilter = bit.bor(ActiveFilter,filters[arg1][2])
	end
	VWQL[charKey].Filter = ActiveFilter
	ELib.ScrollDropDown.UpdateChecks()
	WorldQuestList_Update_PrevZone = nil
	WorldQuestList_Update()
end

local function SetFilterType(_, arg1)
	ActiveFilterType[arg1] = not ActiveFilterType[arg1]
	ELib.ScrollDropDown.UpdateChecks()
	WorldQuestList_Update_PrevZone = nil
	WorldQuestList_Update()
end

do
	local list = {}
	WorldQuestList.filterDropDown.Button.List = list

	list[#list+1] = {
		text = CHECK_ALL,
		func = function()
			ActiveFilter = 2 ^ #filters - 1
			VWQL[charKey].Filter = ActiveFilter
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
	}
	list[#list+1] = {
		text = UNCHECK_ALL,
		func = function()
			ActiveFilter = 0
			VWQL[charKey].Filter = ActiveFilter
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
	}
	for i=1,#filters do
		list[#list+1] = {
			text = filters[i][1],
			func = SetFilter,
			arg1 = i,
			checkable = true,
		}
	end
	list[#list+1] = {
		text = TYPE,
		isTitle = true,
	}
	list[#list+1] = {
		text = PVP,
		func = SetFilterType,
		arg1 = "pvp",
		checkable = true,
	}
	list[#list+1] = {
		text = DUNGEONS,
		func = SetFilterType,
		arg1 = "dung",
		checkable = true,
	}
	list[#list+1] = {
		text = TRADE_SKILLS,
		func = SetFilterType,
		arg1 = "prof",
		checkable = true,
	}
	list[#list+1] = {
		text = PET_BATTLE_PVP_QUEUE,
		func = SetFilterType,
		arg1 = "pet",
		checkable = true,
	}
	list[#list+1] = {
		text = LOCALE.ignoreFilter,
		isTitle = true,
	}
	list[#list+1] = {
		text = LOCALE.bountyIgnoreFilter,
		func = function()
			VWQL[charKey].bountyIgnoreFilter = not VWQL[charKey].bountyIgnoreFilter
			ELib.ScrollDropDown.UpdateChecks()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		arg1 = "!ignoreFilter",
		checkable = true,
	}
	list[#list+1] = {
		text = ARTIFACT_POWER,
		func = function()
			VWQL[charKey].apIgnoreFilter = not VWQL[charKey].apIgnoreFilter
			ELib.ScrollDropDown.UpdateChecks()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		arg1 = "!ignoreFilterAP",
		checkable = true,
	}	
	list[#list+1] = {
		text = LOCALE.honorIgnoreFilter,
		func = function()
			VWQL[charKey].honorIgnoreFilter = not VWQL[charKey].honorIgnoreFilter
			ELib.ScrollDropDown.UpdateChecks()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		arg1 = "!ignoreFilterPvP",
		checkable = true,
	}
	list[#list+1] = {
		text = SHOW_PET_BATTLES_ON_MAP_TEXT,
		func = function()
			VWQL[charKey].petIgnoreFilter = not VWQL[charKey].petIgnoreFilter
			ELib.ScrollDropDown.UpdateChecks()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		arg1 = "!ignoreFilterPB",
		checkable = true,
	}
	list[#list+1] = {
		text = LOCALE.wantedIgnoreFilter,
		func = function()
			VWQL[charKey].wantedIgnoreFilter = not VWQL[charKey].wantedIgnoreFilter
			ELib.ScrollDropDown.UpdateChecks()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		arg1 = "!ignoreFilterWanted",
		checkable = true,
	}
	list[#list+1] = {
		text = LOCALE.epicIgnoreFilter,
		func = function()
			VWQL[charKey].epicIgnoreFilter = not VWQL[charKey].epicIgnoreFilter
			ELib.ScrollDropDown.UpdateChecks()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		arg1 = "!ignoreFilterEpic",
		checkable = true,
	}
	if is72 then
		list[#list+1] = {
			text = FACTION.." "..(GetFactionInfoByID(2045) or "Legionfall"),
			func = function()
				VWQL[charKey].legionfallIgnoreFilter = not VWQL[charKey].legionfallIgnoreFilter
				ELib.ScrollDropDown.UpdateChecks()
				WorldQuestList_Update_PrevZone = nil
				WorldQuestList_Update()
			end,
			arg1 = "!ignoreFilterLegionfall",
			checkable = true,
		}	
	
	end
	
	
	function WorldQuestList.filterDropDown.Button:additionalToggle()
		for i=1,#self.List do
			if self.List[i].func == SetFilter then
				self.List[i].checkState = bit.band(filters[ self.List[i].arg1 ][2],ActiveFilter) > 0
			elseif self.List[i].func == SetFilterType then
				self.List[i].checkState = not ActiveFilterType[ self.List[i].arg1 ]
			elseif self.List[i].arg1 == "!ignoreFilter" then
				self.List[i].checkState = VWQL[charKey].bountyIgnoreFilter
			elseif self.List[i].arg1 == "!ignoreFilterPvP" then
				self.List[i].checkState = VWQL[charKey].honorIgnoreFilter
			elseif self.List[i].arg1 == "!ignoreFilterPB" then
				self.List[i].checkState = VWQL[charKey].petIgnoreFilter
			elseif self.List[i].arg1 == "!ignoreFilterAP" then
				self.List[i].checkState = VWQL[charKey].apIgnoreFilter
			elseif self.List[i].arg1 == "!ignoreFilterWanted" then
				self.List[i].checkState = VWQL[charKey].wantedIgnoreFilter
			elseif self.List[i].arg1 == "!ignoreFilterEpic" then
				self.List[i].checkState = VWQL[charKey].epicIgnoreFilter
			elseif self.List[i].arg1 == "!ignoreFilterLegionfall" then
				self.List[i].checkState = VWQL[charKey].legionfallIgnoreFilter
			end
		end
	end	
end

WorldQuestList.filterDropDown.Button:SetScript("OnClick",function(self)
	ELib.ScrollDropDown.ClickButton(self)
end)

function UpdateScale()
	WorldQuestList:SetScale(tonumber(VWQL.Scale) or 1)
end
function UpdateAnchor()
	WorldQuestList:ClearAllPoints()
	if VWQL.Anchor == 1 then
		WorldQuestList.filterDropDown:ClearAllPoints()
		WorldQuestList.filterDropDown:SetPoint("TOPLEFT",WorldQuestList,"TOPRIGHT",-5,5)

		WorldQuestList.sortDropDown:ClearAllPoints()
		WorldQuestList.sortDropDown:SetPoint("TOPLEFT",WorldQuestList,"TOPRIGHT",-5,-20)

		WorldQuestList.optionsDropDown:ClearAllPoints()
		WorldQuestList.optionsDropDown:SetPoint("TOPLEFT",WorldQuestList,"TOPRIGHT",-5,-45)
		
		WorldQuestList.modeSwitcherCheck:ClearAllPoints()
		WorldQuestList.modeSwitcherCheck:SetPoint("TOPLEFT", WorldQuestList.optionsDropDown, 13, -25)
			
		WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"BOTTOMLEFT",3,-7)
	else
		WorldQuestList.filterDropDown:ClearAllPoints()
		WorldQuestList.filterDropDown:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",15,0)

		WorldQuestList.sortDropDown:ClearAllPoints()
		WorldQuestList.sortDropDown:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",15-120,0)

		WorldQuestList.optionsDropDown:ClearAllPoints()
		WorldQuestList.optionsDropDown:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",15-120*2,0)
		
		WorldQuestList.modeSwitcherCheck:ClearAllPoints()
		WorldQuestList.modeSwitcherCheck:SetPoint("LEFT", WorldQuestList.optionsDropDown, -50, 3)
	
		WorldQuestList:SetPoint("TOPLEFT",WorldMapFrame,"TOPRIGHT",10,-4)
	end
end


WorldQuestList.optionsDropDown = CreateFrame("Frame", "WorldQuestListOptionsDropDown", WorldQuestList, "UIDropDownMenuTemplate")
WorldQuestList.optionsDropDown:SetPoint("BOTTOMRIGHT",WorldQuestList,"TOPRIGHT",15-120*2,0)
WorldQuestList.optionsDropDown.Text:SetText(GAMEOPTIONS_MENU)
UIDropDownMenu_SetWidth(WorldQuestList.optionsDropDown, 100)
WorldQuestList.optionsDropDown.Button.Width = 220
WorldQuestList.optionsDropDown.Button.isButton = true
WorldQuestList.optionsDropDown:SetScript("OnHide",function () ELib.ScrollDropDown.Close() end)

do
	local list = {}
	WorldQuestList.optionsDropDown.Button.List = list

	list[#list+1] = {
		text = LOCALE.disableArrow,
		func = function()
			VWQL.DisableArrow = not VWQL.DisableArrow
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
			
			if not VWQL.DisableArrow and EnableClickArrow then
				EnableClickArrow()
			end
		end,
		checkable = true,
	}
	list[#list+1] = {
		text = LOCALE.totalapdisable,
		func = function()
			VWQL.DisableTotalAP = not VWQL.DisableTotalAP
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		checkable = true,
	}
	
	local scaleSubMenu = {
		{
			text = "1.25",
			func = function()
				VWQL.Scale = 1.25
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "1.1",
			func = function()
				VWQL.Scale = 1.1
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "1.0",
			func = function()
				VWQL.Scale = nil
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "0.90",
			func = function()
				VWQL.Scale = 0.9
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "0.80",
			func = function()
				VWQL.Scale = 0.8
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "0.70",
			func = function()
				VWQL.Scale = 0.7
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "0.60",
			func = function()
				VWQL.Scale = 0.6
				ELib.ScrollDropDown.Close()
				UpdateScale()
				WorldQuestList_Update()
			end,
			radio = true,
		},
	}
	
	list[#list+1] = {
		text = UI_SCALE,
		subMenu = scaleSubMenu,
		padding = 16,
	}


	local anchorSubMenu = {
		{
			text = "1",
			func = function()
				VWQL.Anchor = nil
				UpdateAnchor()
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "2",
			func = function()
				VWQL.Anchor = 1
				UpdateAnchor()
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update()
			end,
			radio = true,	
		},
	}

	list[#list+1] = {
		text = LOCALE.anchor,
		subMenu = anchorSubMenu,
		padding = 16,
	}

	list[#list+1] = {
		text = LOCALE.enigmaHelper,
		func = function()
			VWQL.EnableEnigma = not VWQL.EnableEnigma
			ELib.ScrollDropDown.Close()
		end,
		checkable = true,
	}
	list[#list+1] = {
		text = LOCALE.barrelsHelper,
		func = function()
			VWQL.DisableBarrels = not VWQL.DisableBarrels
			ELib.ScrollDropDown.Close()
		end,
		checkable = true,
	}	
	

	local apFormatSubMenu = {
		{
			text = "2100000",
			func = function()
				VWQL.APFormat = 1
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update_PrevZone = nil
				WorldQuestList_Update()
			end,
			radio = true,
		},	
		{
			text = "1100k",
			func = function()
				VWQL.APFormat = 2
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update_PrevZone = nil
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "1.1M",
			func = function()
				VWQL.APFormat = 3
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update_PrevZone = nil
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "1M",
			func = function()
				VWQL.APFormat = 4
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update_PrevZone = nil
				WorldQuestList_Update()
			end,
			radio = true,
		},
		{
			text = "Auto",
			func = function()
				VWQL.APFormat = nil
				ELib.ScrollDropDown.Close()
				WorldQuestList_Update_PrevZone = nil
				WorldQuestList_Update()
			end,
			radio = true,
		},		
	}	
	
	
	list[#list+1] = {
		text = LOCALE.apFormatSetup,
		subMenu = apFormatSubMenu,
		padding = 16,
	}
	
	list[#list+1] = {
		text = LOCALE.headerEnable,
		func = function()
			VWQL.DisableHeader = not VWQL.DisableHeader
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		checkable = true,
	}
	
	list[#list+1] = {
		text = LOCALE.disabeHighlightNewQuests,
		func = function()
			VWQL.DisableHighlightNewQuest = not VWQL.DisableHighlightNewQuest
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		checkable = true,
	}

	list[#list+1] = {
		text = LOCALE.disableBountyIcon,
		func = function()
			VWQL.DisableBountyIcon = not VWQL.DisableBountyIcon
			ELib.ScrollDropDown.Close()
			WorldQuestList_Update_PrevZone = nil
			WorldQuestList_Update()
		end,
		checkable = true,
	}	
	
	function WorldQuestList.optionsDropDown.Button:additionalToggle()
		for i=1,#self.List do
			if self.List[i].text == LOCALE.disableArrow then
				self.List[i].checkState = VWQL.DisableArrow
			elseif self.List[i].text == LOCALE.totalapdisable then	
				self.List[i].checkState = VWQL.DisableTotalAP
			elseif self.List[i].text == LOCALE.barrelsHelper then
				self.List[i].checkState = not VWQL.DisableBarrels
			elseif self.List[i].text == LOCALE.enigmaHelper then
				self.List[i].checkState = VWQL.EnableEnigma
			elseif self.List[i].text == LOCALE.headerEnable then
				self.List[i].checkState = not VWQL.DisableHeader
			elseif self.List[i].text == LOCALE.disabeHighlightNewQuests then
				self.List[i].checkState = VWQL.DisableHighlightNewQuest
			elseif self.List[i].text == LOCALE.disableBountyIcon then
				self.List[i].checkState = VWQL.DisableBountyIcon
			end
		end
		anchorSubMenu[1].checkState = not VWQL.Anchor
		anchorSubMenu[2].checkState = VWQL.Anchor == 1
		scaleSubMenu[1].checkState = VWQL.Scale == 1.25
		scaleSubMenu[2].checkState = VWQL.Scale == 1.1
		scaleSubMenu[3].checkState = not VWQL.Scale
		scaleSubMenu[4].checkState = VWQL.Scale == 0.9
		scaleSubMenu[5].checkState = VWQL.Scale == 0.8
		scaleSubMenu[6].checkState = VWQL.Scale == 0.7
		scaleSubMenu[7].checkState = VWQL.Scale == 0.6
		apFormatSubMenu[1].checkState = VWQL.APFormat == 1
		apFormatSubMenu[2].checkState = VWQL.APFormat == 2
		apFormatSubMenu[3].checkState = VWQL.APFormat == 3
		apFormatSubMenu[4].checkState = VWQL.APFormat == 4
		apFormatSubMenu[5].checkState = not VWQL.APFormat
	end	
end

WorldQuestList.optionsDropDown.Button:SetScript("OnClick",function(self)
	ELib.ScrollDropDown.ClickButton(self)
end)

WorldQuestList.modeSwitcherCheck = CreateFrame("CheckButton",nil,WorldQuestList,"UICheckButtonTemplate")  
WorldQuestList.modeSwitcherCheck:SetPoint("LEFT", WorldQuestList.optionsDropDown, -50, 3)
WorldQuestList.modeSwitcherCheck.text:SetText("WQ")
WorldQuestList.modeSwitcherCheck:SetScript("OnClick", function(self,event) 
	if self:GetChecked() then
		VWQL[charKey].RegularQuestMode = nil
		WorldQuestList_Update()
	else
		VWQL[charKey].RegularQuestMode = true
		WorldQuestList_Update()
	end
end)


local SortFuncs = {
	function(a,b) if a and b and a.time and b.time then 
			if abs(a.time - b.time) <= 2 then 
				return a.faction < b.faction 
			else 
				return a.time < b.time 
			end 
		end 
	end,
	function(a,b) return a.zoneTime < b.zoneTime end,
	function(a,b) return a.name < b.name end,
	function(a,b) if a.faction == b.faction then 
			if a.time and b.time then 
				if abs(a.time - b.time) <= 2 then 
					return a.name < b.name 
				else 
					return a.time < b.time 
				end 
			else 
				return a.name < b.name 
			end
		else 
			return a.faction < b.faction 
		end
	end,
	function(a,b) if a and b then if a.rewardType == b.rewardType then return a.rewardSort > b.rewardSort else return a.rewardType < b.rewardType end end end,
	function(a,b) if a and b then return a.distance < b.distance end end,
	
}

local GlobalAddonName = ...
local inspectScantip = CreateFrame("GameTooltip", GlobalAddonName.."WorldQuestListInspectScanningTooltip", nil, "GameTooltipTemplate")
inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")

local ITEM_LEVEL = (ITEM_LEVEL or "NO DATA FOR ITEM_LEVEL"):gsub("%%d","(%%d+%+*)")

local NUM_WORLDMAP_TASK_POIS = 0

local BrokenIslesZones = {
	1015,
	1018,
	1024,
	1017,
	1033,
	1014,
	1021,
	1096,
}

local dalaranWQs = {	--Invincible outside dalaran, API broken too
	41662,41656,41680,41638,41650,41644,41674,41668,
	46135,46134,46136,46137,46139,46138,
	40277,42062,40298,41886,41881,40299,42442,
}

local function WorldQuestList_Leveling_Update()
	local quests = {}
	local prevHeader = nil
	for i=1,GetNumQuestLogEntries() do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i)
		if isHeader then
			prevHeader = title
		elseif questID and questID ~= 0 then
			quests[#quests+1] = {
				title = title,
				header = prevHeader,
				questID = questID,
				isCompleted = IsQuestComplete(questID),
				id = i,
			}
		end
	end
	
	if UnitLevel'player' < 110 then
		local taskInfo
		local mapAreaID = GetCurrentMapAreaID()
		if mapAreaID == 1007 then
			taskInfo = {}
			for i=1,#BrokenIslesZones do
				local currTaskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(BrokenIslesZones[i])
				if currTaskInfo and #currTaskInfo > 0 then
					for j=1,#currTaskInfo do
						taskInfo[#taskInfo + 1] = currTaskInfo[j]
					end
				end
			end	
		else
			taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapAreaID)
		end	
	
		
		for _,info in pairs(taskInfo or {}) do
			if HaveQuestData(info.questId) and QuestUtils_IsQuestWorldQuest(info.questId) then
				local _,_,worldQuestType,rarity, isElite, tradeskillLineIndex, allowDisplayPastCritical = GetQuestTagInfo(info.questId)
				
				quests[#quests+1] = {
					title = C_TaskQuest.GetQuestInfoByQuestID(info.questId),
					header = MAP_UNDER_INVASION,
					questID = info.questId,
					isCompleted = false,
					isInvasion = worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION,
					isElite = isElite,
					isWQ = true,
				}				
			end
		end
	end
	
	WorldQuestList:SetWidth(WorldQuestList_Width)
	
	local numTaskPOIs = #quests
	
	if ( NUM_WORLDMAP_TASK_POIS < numTaskPOIs ) then
		for i=NUM_WORLDMAP_TASK_POIS+1, numTaskPOIs do
			WorldQuestList_CreateLine(i)
		end
		NUM_WORLDMAP_TASK_POIS = numTaskPOIs
	end
	
	local result = {}
	local taskIconIndex = 1

	if ( numTaskPOIs > 0 ) then
		for i, questData in ipairs(quests) do
			local title = questData.title
			local header = questData.header
			local questID = questData.questID

			local _,x,y = QuestPOIGetIconInfo(questID)
			if questData.isWQ then
				x,y = C_TaskQuest.GetQuestLocation(questID)
			end
			if x and y and x ~= 0 and y ~= 0 then
				local rewardXP = GetQuestLogRewardXP(questID)
				if rewardXP == 0 then
					rewardXP = nil
				end
				
				local reward, rewardColor
				
				local numRewards = GetNumQuestLogRewards(questID)
				if numRewards > 0 then
					local name,icon,numItems,quality,_,itemID = GetQuestLogRewardInfo(1,questID)
					if name then
						reward = "|T"..icon..":0|t "..name..(numItems and numItems > 1 and " x"..numItems or "")
					end
					
					if quality and quality >= LE.LE_ITEM_QUALITY_COMMON and BAG_ITEM_QUALITY_COLORS[quality] then
						rewardColor = BAG_ITEM_QUALITY_COLORS[quality]
					end
					
				end
				
				if not reward then
					local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
					for i = 1, numQuestCurrencies do
						local name, texture, numItems = GetQuestLogRewardCurrencyInfo(i, questID)
						local text = BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format(texture, numItems, name)
						
						reward = text
					end
				end
					
				tinsert(result,{
					questID = questID,
					name = (questData.isCompleted and "|cff00ff00" or "")..title,
					info = {
						Wx = 1 - x,
						Wy = 1 - y,
					},
					rewardXP = rewardXP,
					reward = reward,
					rewardColor = rewardColor,
					header = header,
					numRewards = numRewards,
					isInvasion = questData.isInvasion,
					isElite = questData.isElite,
				})
			end
		end
	end	
	
	for i=1,#result do
		local data = result[i]
		local line = WorldQuestList.l[taskIconIndex]
		
		line.name:SetText(data.name)
		line.name:SetTextColor(1,1,1)
		
		line.nameicon:SetTexture("")
		line.nameicon:SetWidth(1)
		line.secondicon:SetTexture("")
		line.secondicon:SetWidth(1)		
		
		line.reward:SetText(data.reward or "")
		if data.rewardColor then
			line.reward:SetTextColor(data.rewardColor.r, data.rewardColor.g, data.rewardColor.b)
		else
			line.reward:SetTextColor(1,1,1)
		end
		if data.reward then
			line.reward.ID = data.questID
		else
			line.reward.ID = nil
		end
		if data.numRewards and data.numRewards > 1 then
			line.reward.IDs = data.numRewards
		else
			line.reward.IDs = nil
		end
		
		local questNameWidth = NAME_WIDTH
		if data.isInvasion then
			line.secondicon:SetAtlas("worldquest-icon-burninglegion")
			line.secondicon:SetWidth(16)
			
			line.name:SetTextColor(0.78, 1, 0)
			
			if data.isElite then
				line.nameicon:SetAtlas("nameplates-icon-elite-silver")
				line.nameicon:SetWidth(16)
				questNameWidth = questNameWidth - 15
			end
			
			questNameWidth = questNameWidth - 15
		end

		line.name:SetWidth(questNameWidth)
		
		line.faction:SetText(data.header or "")
		line.faction:SetTextColor(1,1,1)
		
		line.zone:SetText("")
		line.timeleft:SetText(data.rewardXP or "0")

		line.zone:Hide()
		line.zone.f:Hide()
		
		line.questID = data.questID
		line.numObjectives = 0
		
		line.nqhl:Hide()
		
		line.rewardLink = nil
		line.data = data.info
		line.faction.f.tooltip = nil
		
		line.isLeveling = true
		
		line:Show()
	
		taskIconIndex = taskIconIndex + 1
	end


	WorldQuestList:SetHeight(max(16*(taskIconIndex-1),1))
	WorldQuestList.C:SetHeight(max(16*(taskIconIndex-1),1))
	
	
	local lowestLine = #WorldQuestList.Cheader.lines
	for i=1,#WorldQuestList.Cheader.lines do
		local bottomPos = WorldQuestList.Cheader.lines[i]:GetBottom()
		if bottomPos and bottomPos < 40 then
			lowestLine = i - 1
			break
		end
	end
	
	if lowestLine >= taskIconIndex then
		WorldQuestList.Cheader:SetVerticalScroll(0)
	else
		WorldQuestList:SetHeight((lowestLine+1)*16)
		WorldQuestList.Cheader:SetVerticalScroll( max(min(WorldQuestList.C:GetHeight() - WorldQuestList.Cheader:GetHeight(),WorldQuestList.Cheader:GetVerticalScroll()),0) )
	end
	UpdateScrollButtonsState()
	C_Timer.After(0.05,UpdateScrollButtonsState)
	
	WorldQuestList.header:Update(true)
	ViewAllButton:Hide()
	
	for i = taskIconIndex, NUM_WORLDMAP_TASK_POIS do
		WorldQuestList.l[i]:Hide()
	end
	
	if taskIconIndex == 1 then
		WorldQuestList.b:SetAlpha(0)
		WorldQuestList.backdrop:SetAlpha(0)
	else
		WorldQuestList.b:SetAlpha(WorldQuestList.b.A or 1)
		WorldQuestList.backdrop:SetAlpha(1)
	end
end


local function FormatAPnumber(ap,artifactKnowlegeLevel)
	if VWQL.APFormat == 1 then
		return tostring(ap)
	elseif VWQL.APFormat == 2 then
		return format("%dk",ap / 1000)
	elseif VWQL.APFormat == 3 then
		return format("%.1fM",ap / 1000000)
	elseif VWQL.APFormat == 4 then
		return format("%dM",ap / 1000000)
	else
		artifactKnowlegeLevel = artifactKnowlegeLevel or 0
		if artifactKnowlegeLevel >= 40 then
			return format("%dM",ap / 1000000)
		elseif artifactKnowlegeLevel >= 35 then
			return format("%.1fM",ap / 1000000)
		elseif artifactKnowlegeLevel > 25 then
			return format("%dk",ap / 1000)
		else
			return tostring(ap)
		end	
	end
end

local QuestsCachedPosX,QuestsCachedPosY = {},{}

local WorldQuestList_Update_Timer = nil
local TableQuestsViewed = {}
local TableQuestsViewed_Time = {}

local FactionBountyIcons,FactionBountyIconsCounter = {},0

local WANTED_TEXT,DANGER_TEXT,DANGER_TEXT_2,DANGER_TEXT_3

function WorldQuestList_Update()
	if not WorldQuestList:IsVisible() then
		return
	end

	WorldQuestList_Update_Timer = nil
	
	local mapAreaID = GetCurrentMapAreaID()

	WorldQuestList.TotalAP:SetText("")
	if UnitLevel'player' < 110 or VWQL[charKey].RegularQuestMode then
		WorldQuestList.sortDropDown:Hide()
		WorldQuestList.filterDropDown:Hide()
		WorldQuestList.optionsDropDown:Hide()
		WorldQuestList_Leveling_Update()
		return
	else
		WorldQuestList.sortDropDown:Show()
		WorldQuestList.filterDropDown:Show()
		WorldQuestList.optionsDropDown:Show()	
	end
	local taskInfo
	local zoneName
	
	if mapAreaID == 1007 then
		taskInfo = {}
		
		local _,xR,yT,xL,yB = GetCurrentMapZone()

		for i=1,#BrokenIslesZones do
			local mapID = BrokenIslesZones[i]
			zoneName = GetMapNameByID(mapID)
			
			local z = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
			local c = 0
			for _, info  in ipairs(z or {}) do
				tinsert(taskInfo, info)
				info.zone = zoneName
				info.zoneID = i
				info.zoneMapID = mapID
				
				if info.x and info.y then
					info.Wx = 1 - info.x
					info.Wy = 1 - info.y
					
					QuestsCachedPosX[info.questId] = xR - abs(xR - xL) * info.x
					QuestsCachedPosY[info.questId] = yT - abs(yT - yB) * info.y
				end
				
				c = c + 1
			end
			
			if mapID == 1014 and c == 0 then
				for j=1,#dalaranWQs do
					local questID = dalaranWQs[j]
					local timeLeft = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
					if (timeLeft or 0) > 0 then
						local info = {
							questId = questID,
							numObjectives = 1,
							zone = zoneName,
							zoneID = i,
							zoneMapID = mapID,
						}
					
						tinsert(taskInfo, info)
						
						local x,y = C_TaskQuest.GetQuestLocation(questID)
						if x and x > 0 and y and y > 0 then
							info.x = x
							info.y = y
							info.Wx = 1 - info.x
							info.Wy = 1 - info.y
							
							QuestsCachedPosX[info.questId] = xR - abs(xR - xL) * info.x
							QuestsCachedPosY[info.questId] = yT - abs(yT - yB) * info.y
						end
					end
				end
			end
		end
		WorldQuestList:SetWidth(WorldQuestList_Width+WorldQuestList_ZoneWidth)
		WorldQuestList.C:SetWidth(WorldQuestList_Width+WorldQuestList_ZoneWidth)
	else
		taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mapAreaID)
		
		local _,xR,yT,xL,yB = GetCurrentMapZone()
		
		for _, info  in ipairs(taskInfo or {}) do			
			if info.x and info.y then
				info.Wx = 1 - info.x
				info.Wy = 1 - info.y
				
				if mapAreaID ~= 1014 then
					QuestsCachedPosX[info.questId] = xR - abs(xR - xL) * info.x
					QuestsCachedPosY[info.questId] = yT - abs(yT - yB) * info.y
				end
			end
		end
		
		WorldQuestList:SetWidth(WorldQuestList_Width)
		WorldQuestList.C:SetWidth(WorldQuestList_Width)
	end
	
	local nextResearch = nil
	
	local looseShipments = C_Garrison.GetLooseShipments(3)
	for i = 1, #looseShipments do
		local name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString = C_Garrison.GetLandingPageShipmentInfoByContainerID(looseShipments[i])
		if texture == 237446 and creationTime then
			nextResearch = (creationTime + duration - time()) / 60 + 60
			if nextResearch < 0 then
				nextResearch = nil
			end
			if shipmentsReady and shipmentsReady > 0 then
				nextResearch = 0
			end
			break
		end
	end
	
	local artifactKnowlegeLevel = select(2,GetCurrencyInfo(1171)) or 0
	
	local isGearLessRelevant = (select(2,GetAverageItemLevel()) or 0) >= 880
		
	local bounties = GetQuestBountyInfoForMapID(1007)
	local bountiesInProgress = {}
	for _,bountyData in pairs(bounties or {}) do
		local questID = bountyData.questID
		if questID and not IsQuestComplete(questID) then
			bountiesInProgress[ questID ] = bountyData.icon or 0
		end
	end
	
	local numTaskPOIs = 0
	if(taskInfo ~= nil) then
		numTaskPOIs = #taskInfo
	end
	
	if ( NUM_WORLDMAP_TASK_POIS < numTaskPOIs ) then
		for i=NUM_WORLDMAP_TASK_POIS+1, numTaskPOIs do
			WorldQuestList_CreateLine(i)
		end
		NUM_WORLDMAP_TASK_POIS = numTaskPOIs
	end
	
	local result = {}
	local totalAP,totalOR,totalG = 0,0,0
	
	if not WANTED_TEXT then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(43612)
		if qName and qName:find(":") then
			WANTED_TEXT = qName:match("^([^:]+):")
			if WANTED_TEXT then
				WANTED_TEXT = WANTED_TEXT:lower()
			end
		end
	end
	if not DANGER_TEXT then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(43798)
		if qName and qName:find(":") then
			DANGER_TEXT = qName:match("^([^:]+):")
			if DANGER_TEXT then
				DANGER_TEXT = DANGER_TEXT:lower()
			end
		end
	end
	if not DANGER_TEXT_2 then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(41697)
		if qName and qName:find(":") then
			DANGER_TEXT_2 = qName:match("^([^:]+):")
			if DANGER_TEXT_2 then
				DANGER_TEXT_2 = DANGER_TEXT_2:lower()
			end
		end
	end
	if not DANGER_TEXT_3 then
		local qName = C_TaskQuest.GetQuestInfoByQuestID(44114)
		if qName and qName:find(":") then
			DANGER_TEXT_3 = qName:match("^([^:]+):")
			if DANGER_TEXT_3 then
				DANGER_TEXT_3 = DANGER_TEXT_3:lower()
			end
		end
	end
	
	local currTime = GetTime()

	local taskIconIndex = 1
	local totalQuestsNumber = 0
	if ( numTaskPOIs > 0 ) then
		for i, info  in pairs(taskInfo) do
			if HaveQuestData(info.questId) and QuestUtils_IsQuestWorldQuest(info.questId) then
				local questID = info.questId
				
				local isNewQuest = not VWQL[charKey].Quests[ questID ] or (TableQuestsViewed_Time[ questID ] and TableQuestsViewed_Time[ questID ] > currTime)
				
				local reward = ""
				local rewardItem
				local rewardColor
				local faction = ""
				local factionInProgress
				local timeleft = ""
				local name = ""
				local rewardType = 0
				local rewardSort = 0
				local rewardItemLink
				local nameicon = nil
				local artifactKnowlege
				local isEliteQuest
				local timeToComplete
				local isInvasion
				local WarSupplies
				local ShardsNothing
				local rewardItemIcon
				local bountyTooltip
				local isUnlimited
				local questColor	--nil - white, 1 - blue, 2 - epic, 3 - invasion
				
				local professionFix
				local IsPvPQuest
				local IsWantedQuest
				
				local isValidLine = 1
				
				local title, factionID = C_TaskQuest.GetQuestInfoByQuestID(questID)
				name = title
				
				local _,_,worldQuestType,rarity, isElite, tradeskillLineIndex, allowDisplayPastCritical = GetQuestTagInfo(questID)
				
				if isElite then
					isEliteQuest = true
					nameicon = -1
				end

				if worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION then
					isInvasion = true
					questColor = 3
				end
				
				if worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON then
					questColor = 1
					nameicon = -6
					if ActiveFilterType.dung then 
						isValidLine = 0 
					end
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID then
					nameicon = -7
					if ActiveFilterType.dung then 
						isValidLine = 0 
					end
					questColor = 2				
				elseif rarity == LE.LE_WORLD_QUEST_QUALITY_RARE then
					questColor = 1
				elseif rarity == LE.LE_WORLD_QUEST_QUALITY_EPIC then
					nameicon = -2
					questColor = 2
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PVP then
					nameicon = -3
					if ActiveFilterType.pvp then 
						isValidLine = 0 
					end
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
					nameicon = -4
					if ActiveFilterType.pet then 
						isValidLine = 0 
					end
				elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PROFESSION then
					nameicon = -5
					if ActiveFilterType.prof or not tradeskillLineIndex then 
						isValidLine = 0 
						if not tradeskillLineIndex then
							professionFix = true
						end
					end
				end
				
				if (WANTED_TEXT and name:lower():find("^"..WANTED_TEXT)) or (DANGER_TEXT and name:lower():find("^"..DANGER_TEXT)) or (DANGER_TEXT_2 and name:lower():find("^"..DANGER_TEXT_2)) or (DANGER_TEXT_3 and name:lower():find("^"..DANGER_TEXT_3)) then
					IsWantedQuest = true
				end
				
				if ( factionID ) then
					local factionName = GetFactionInfoByID(factionID)
					if ( factionName ) then
						faction = factionName
					end
				end
				
				--FactionBountyIconsCounter = 0
				for bountyQuestID,bountyIcon in pairs(bountiesInProgress) do
					if IsQuestCriteriaForBounty(questID, bountyQuestID) then
						if not VWQL.DisableBountyIcon then
							--FactionBountyIconsCounter = FactionBountyIconsCounter + 1
							--FactionBountyIcons[FactionBountyIconsCounter] = "|T" .. bountyIcon .. ":0|t "
							faction = "|T" .. bountyIcon .. ":0|t " .. (faction or "")
						end
					
						factionInProgress = true
						
						if bountyIcon and bountyIcon ~= 0 then
							bountyTooltip = bountyTooltip or ""
							bountyTooltip = bountyTooltip .. (bountyTooltip ~= "" and " " or "") .. "|T" .. bountyIcon .. ":32|t"
						end
					end
				end
				
				--[[
				if FactionBountyIconsCounter > 0 then
					sort(FactionBountyIcons)
					for i=1,FactionBountyIconsCounter do
						faction = FactionBountyIcons[i] .. (faction or "")
					end
				end
				]]
				
				if ( GetQuestLogRewardXP(questID) > 0 or GetNumQuestLogRewardCurrencies(questID) > 0 or GetNumQuestLogRewards(questID) > 0 or GetQuestLogRewardMoney(questID) > 0 or GetQuestLogRewardArtifactXP(questID) > 0 or (GetQuestLogRewardHonor and GetQuestLogRewardHonor(questID) > 0) ) then
					local hasRewardFiltered = false
					-- xp
					local xp = GetQuestLogRewardXP(questID)
					if ( xp > 0 ) then
						reward = BONUS_OBJECTIVE_EXPERIENCE_FORMAT:format(xp)
						rewardSort = xp
						rewardType = 50
					end
					-- money
					local money = GetQuestLogRewardMoney(questID)
					if ( money > 0 ) then
						reward = GetCoinTextureString(money)
						rewardType = 40
						if money > 500000 then
							hasRewardFiltered = true
							rewardSort = money
							
							if bit.band(filters[5][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
							if isValidLine ~= 0 then
								totalG = totalG + money
							end
						end
					end						
					
					-- currency		
					local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
					for i = 1, numQuestCurrencies do
						local name, texture, numItems = GetQuestLogRewardCurrencyInfo(i, questID)
						local text = BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format(texture, numItems, name)
						if type(texture)=='string' and texture:find("ble_boss_token$") then	--War Supplies
							WarSupplies = numItems
						elseif type(texture)=='string' and texture:find("acrystal01$") and isInvasion then	--Shard of nothing
							ShardsNothing = numItems
						else
							reward = text
							rewardType = 30
						end
					
						if type(texture)=='string' and texture:find("orderresources$") then
							hasRewardFiltered = true
							rewardSort = numItems or 0
							if bit.band(filters[3][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
							if isValidLine ~= 0 then
								totalOR = totalOR + (numItems or 0)
							end
						end
					end
					
					local artifactXP = GetQuestLogRewardArtifactXP(questID)
					local totalAPadded = 0
					if ( artifactXP > 0 ) then
						--reward = BONUS_OBJECTIVE_ARTIFACT_XP_FORMAT:format(artifactXP)
						--rewardSort = artifactXP
						--rewardType = 25
						
						hasRewardFiltered = true
						rewardType = 20
						if bit.band(filters[2][2],ActiveFilter) == 0 then 
							isValidLine = 0  
						end
						if BAG_ITEM_QUALITY_COLORS[6] then
							rewardColor = BAG_ITEM_QUALITY_COLORS[6]
						end
					
						reward = "["..artifactXP.."] "..BONUS_OBJECTIVE_ARTIFACT_XP_FORMAT:gsub("^%%s ","")
						rewardSort = artifactXP
						if isValidLine ~= 0 then
							totalAP = totalAP + artifactXP
							totalAPadded = totalAPadded + artifactXP
						end
					end
			
					-- items
					local numQuestRewards = GetNumQuestLogRewards(questID)
					if numQuestRewards > 0 then
						local name,icon,numItems,quality,_,itemID = GetQuestLogRewardInfo(1,questID)
						if name then
							rewardType = 10
							rewardItem = true
							reward = "|T"..icon..":0|t "..(numItems and numItems > 1 and numItems.."x " or "")..name
							
							rewardItemIcon = icon
						end
						

						if quality and quality >= LE.LE_ITEM_QUALITY_COMMON and BAG_ITEM_QUALITY_COLORS[quality] then
							rewardColor = BAG_ITEM_QUALITY_COLORS[quality]
						end
						
						local isBoeItem = nil
						
						inspectScantip:SetQuestLogItem("reward", 1, questID)
						rewardItemLink = select(2,inspectScantip:GetItem())
						for j=2, inspectScantip:NumLines() do
							local tooltipLine = _G[GlobalAddonName.."WorldQuestListInspectScanningTooltipTextLeft"..j]
							local text = tooltipLine:GetText()
							if text and ( text:find(ARTIFACT_POWER.."|r$") or text:find("Artifact Power|r$") ) then
								hasRewardFiltered = true
								rewardType = 20
								if bit.band(filters[2][2],ActiveFilter) == 0 then 
									isValidLine = 0  
								end
								if BAG_ITEM_QUALITY_COLORS[6] then
									rewardColor = BAG_ITEM_QUALITY_COLORS[6]
								end
							elseif text and text:find(ITEM_LEVEL) then
								local ilvl = text:match(ITEM_LEVEL)
								reward = "|T"..icon..":0|t "..ilvl.." "..name
								ilvl = tonumber( ilvl:gsub("%+",""),nil )
								if ilvl then
									rewardType = isGearLessRelevant and 37 or 0
									rewardSort = ilvl
									hasRewardFiltered = true
								end
							elseif text and rewardType == 20 and text:find("^"..ITEM_SPELL_TRIGGER_ONUSE) then
								local ap = tonumber((text:gsub("(%d)[ %.,]+(%d)","%1%2"):match("%d+[,%d%.]*") or "?"):gsub(",",""):gsub("%.",""),nil)
								if ap then
									if SECOND_NUMBER then	--Check 7.2
										local isLarge = nil
										if text:find("%d+ *"..SECOND_NUMBER:gsub("%.","%%.")) then
											isLarge = 10 ^ 6
											if locale == "zhCN" or locale == "koKR" or locale == "zhTW" then
												isLarge = 10 ^ 4
											end
										elseif text:find("%d+ *"..THIRD_NUMBER:gsub("%.","%%.")) then
											isLarge = 10 ^ 9
											if locale == "zhCN" or locale == "koKR" or locale == "zhTW" then
												isLarge = 10 ^ 8
											end											
										elseif text:find("%d+ *"..FOURTH_NUMBER:gsub("%.","%%.")) then
											isLarge = 10 ^ 12
										end
										if isLarge then
											if text:find("%d+[%.,]*%d*") then
												ap = tonumber( text:gsub("(%d+)[%.,](%d+)","%1.%2"):match("%d+%.*%d*") or "0",nil )
											end
											ap = ap * isLarge
										end
									end
									
									if artifactXP then
										ap = ap + artifactXP
										totalAP = totalAP - totalAPadded
									end
									
									local apString = FormatAPnumber(ap,artifactKnowlegeLevel)
									
									reward = reward:gsub(":0|t ",":0|t ["..apString.."] ")
									rewardSort = ap
									if isValidLine ~= 0 then
										totalAP = totalAP + ap
									end
								end
							elseif text and text:find(ITEM_BIND_ON_EQUIP) and j<=4 then
								isBoeItem = true
							end 
						end
						inspectScantip:ClearLines()
						
						if itemID == 124124 then
							rewardType = 35
							rewardSort = numItems or 0
							hasRewardFiltered = true
							if bit.band(filters[4][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
						end
						
						--[[
						if itemID then
							local _, _, subclass, invType = GetItemInfoInstant(itemID)
						
							if invType and invType ~= "" and subclass == ArtifactRelicSubclass then
								if rewardType > 0 and rewardType ~= 37 then
									rewardType = 5
								end
								hasRewardFiltered = true
								if bit.band(filters[1][2],ActiveFilter) == 0 then 
									isValidLine = 0 
								end
							end
						end
						]]
						if itemID and (rewardType == 0 or rewardType == 37) then
							hasRewardFiltered = true
							if bit.band(filters[1][2],ActiveFilter) == 0 then 
								isValidLine = 0 
							end
						end
						
						if (rewardType == 0 or rewardType == 5 or rewardType == 37) and isBoeItem then
							reward = reward:gsub("(|t %d+) ","%1 BOE ")
						end
						
					end
					
					-- honor
					local honorAmount = GetQuestLogRewardHonor and GetQuestLogRewardHonor(questID)
					if ( honorAmount and honorAmount > 0 ) then
						if reward ~= "" then
							reward = reward .. ", "
						else
							rewardSort = honorAmount
							rewardType = 32
						end
						reward = reward .. BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format("Interface\\ICONS\\Achievement_LegionPVPTier4", honorAmount, HONOR)
						
						IsPvPQuest = true
					end
					
					if WarSupplies and WarSupplies > 0 then
						local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1342)
						if mapAreaID == 1021 and factionID == 2045 then
							local prevFaction
							if faction and faction:find(":0|t") then
								prevFaction = faction:match("^(.-:0|t )[^|]*$")
							end
							faction = (prevFaction or "").."|T" .. (texturePath or "") .. ":0|t " .. WarSupplies .. " " .. name
						else
							if reward ~= "" then
								reward = reward .. ", "
							else
								rewardSort = WarSupplies
								rewardType = 31
							end
							reward = reward .. "|T" .. texturePath .. ":0|t " .. WarSupplies .. " " .. name
						end
					end
					if ShardsNothing and ShardsNothing > 0 then
						local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1226)
						if mapAreaID ~= 1007 then
							local prevFaction
							if faction and faction:find(":0|t") then
								prevFaction = faction:match("^(.-:0|t )[^|]*$")
							end
							faction = (prevFaction or "").."|T" .. (texturePath or "") .. ":0|t|cffffffff" .. ShardsNothing .. (faction~="" and "," or "").."|r " .. faction
						else
							if reward ~= "" then
								reward = reward .. ", "
							else
								rewardSort = ShardsNothing
								rewardType = 31
							end
							reward = reward .. BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT:format(texturePath or "", ShardsNothing, name)
						end							
					end
					
					if not hasRewardFiltered then
						rewardType = 60
						if bit.band(filters[6][2],ActiveFilter) == 0 then 
							isValidLine = 0 
						end
					end
				end
				
							
				local timeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
				if ( timeLeftMinutes ) then
					local color
					local timeString
					if ( timeLeftMinutes <= WORLD_QUESTS_TIME_CRITICAL_MINUTES ) then
						color = "|cffff3333"
						timeString = SecondsToTime(timeLeftMinutes * 60)
					else
						if timeLeftMinutes <= 30 then
							color = "|cffff3333"
						elseif timeLeftMinutes <= 180 then
							color = "|cffffff00"
						end
					
						if timeLeftMinutes >= 14400 then	--A lot, 10+ days
							timeString = format("%dd",floor(timeLeftMinutes / 1440))
						elseif timeLeftMinutes >= 1440 then
							timeString = format("%d.%02d:%02d",floor(timeLeftMinutes / 1440),floor(timeLeftMinutes / 60) % 24, timeLeftMinutes % 60)
						else
							timeString = (timeLeftMinutes >= 60 and (floor(timeLeftMinutes / 60) % 24) or "0")..":"..format("%02d",timeLeftMinutes % 60)
						end
					end
					timeleft = (color or "")..(timeString or "")
					
					if rewardType == 20 and nextResearch and timeLeftMinutes > nextResearch and reward then
						timeToComplete = timeLeftMinutes - nextResearch + 60
						reward = reward:gsub("] ","]** ")
						artifactKnowlege = true
					end
					
					if timeLeftMinutes == 0 and not C_TaskQuest.IsActive(questID) then
						isValidLine = 0
					end
					if not allowDisplayPastCritical then
						timeLeftMinutes = timeLeftMinutes + 1440 * 15
						isUnlimited = true
					end
				end
				
				if not professionFix then
					if VWQL[charKey].bountyIgnoreFilter and factionInProgress then 
						isValidLine = 1
					end
					if VWQL[charKey].honorIgnoreFilter and IsPvPQuest then
						isValidLine = 1
					end
					if VWQL[charKey].petIgnoreFilter and worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
						isValidLine = 1
					end
					if VWQL[charKey].apIgnoreFilter and rewardType == 20 then
						isValidLine = 1
					end						
					if VWQL[charKey].epicIgnoreFilter and rarity == LE.LE_WORLD_QUEST_QUALITY_EPIC then
						isValidLine = 1
					end	
					if VWQL[charKey].legionfallIgnoreFilter and factionID == 2045 then
						isValidLine = 1
					end
					if VWQL[charKey].wantedIgnoreFilter and IsWantedQuest then
						isValidLine = 1
					end
				end
									
				
				if isValidLine == 1 then
					TableQuestsViewed[ questID ] = true
					if not VWQL[charKey].Quests[ questID ] then
						TableQuestsViewed_Time[ questID ] = currTime + 180
					end
					tinsert(result,{
						info = info,
						reward = reward,
						rewardItem = rewardItem,
						rewardItemLink = rewardItemLink,
						rewardItemIcon = rewardItemIcon,
						rewardColor = rewardColor,
						faction = faction,
						factionInProgress = factionInProgress,
						zone = info.zone or "",
						zoneTime = (info.zoneID or 0) * 1000000000 + (timeLeftMinutes or 0),
						timeleft = timeleft,
						time = timeLeftMinutes or 0,
						numObjectives = info.numObjectives,
						questID = questID,
						isNewQuest = isNewQuest,
						name = name,
						rewardType = rewardType,
						rewardSort = rewardSort,
						nameicon = nameicon,
						artifactKnowlege = artifactKnowlege,
						isEliteQuest = isEliteQuest,
						timeToComplete = timeToComplete,
						isInvasion = isInvasion,
						bountyTooltip = bountyTooltip,
						isUnlimited = isUnlimited,
						distance = C_TaskQuest.GetDistanceSqToQuest(questID) or 99999999999,
						questColor = questColor,
					})
				end
				
				totalQuestsNumber = totalQuestsNumber + 1
			end
		end
	end

	sort(result,SortFuncs[ActiveSort])
	
	if VWQL.ReverseSort then
		local newResult = {}
		for i=#result,1,-1 do
			newResult[#newResult+1] = result[i]
		end
		result = newResult
	end
	
	--taskIconIndex = taskIconIndex + 1
	for i=1,#result do
		local data = result[i]
		local line = WorldQuestList.l[taskIconIndex]
		
		line.name:SetText(data.name)
		if data.questColor == 3 then
			line.name:SetTextColor(0.78, 1, 0)
		elseif data.questColor == 1 then
			line.name:SetTextColor(.2,.5,1)
		elseif data.questColor == 2 then
			line.name:SetTextColor(.63,.2,.9)
		else
			line.name:SetTextColor(1,1,1)
		end
		
		local questNameWidth = NAME_WIDTH
		if data.nameicon then
			line.nameicon:SetWidth(16)
			if data.nameicon == -1 then
				line.nameicon:SetAtlas("nameplates-icon-elite-silver")
			elseif data.nameicon == -2 then
				line.nameicon:SetAtlas("nameplates-icon-elite-gold")
			elseif data.nameicon == -3 then
				line.nameicon:SetAtlas("worldquest-icon-pvp-ffa")
			elseif data.nameicon == -4 then
				line.nameicon:SetAtlas("worldquest-icon-petbattle")
			elseif data.nameicon == -5 then
				line.nameicon:SetAtlas("worldquest-icon-engineering")
			elseif data.nameicon == -6 then
				line.nameicon:SetAtlas("Dungeon")
			elseif data.nameicon == -7 then
				line.nameicon:SetAtlas("Raid")
			end
			questNameWidth = questNameWidth - 15
		else
			line.nameicon:SetTexture("")
			line.nameicon:SetWidth(1)
		end
		
		if data.isInvasion then
			line.secondicon:SetAtlas("worldquest-icon-burninglegion")
			line.secondicon:SetWidth(16)
			
			questNameWidth = questNameWidth - 15
		else
			line.secondicon:SetTexture("")
			line.secondicon:SetWidth(1)	
		end
		
		line.name:SetWidth(questNameWidth)
		
		line.reward:SetText(data.reward)
		if data.rewardColor then
			line.reward:SetTextColor(data.rewardColor.r, data.rewardColor.g, data.rewardColor.b)
		else
			line.reward:SetTextColor(1,1,1)
		end
		if data.rewardItem then
			line.reward.ID = data.questID
		else
			line.reward.ID = nil
		end
		
		line.faction:SetText(data.faction)
		if data.factionInProgress then
			line.faction:SetTextColor(.5,1,.5)
		else
			line.faction:SetTextColor(1,1,1)
		end
		
		line.zone:SetText(data.zone)
		line.timeleft:SetText(data.timeleft or "")
		if data.isUnlimited then
			line.timeleft.f._t = nil
		else
			line.timeleft.f._t = data.time
		end
		
		if mapAreaID == 1007 then
			line.zone:Show()
			line.zone.f:Show()
		else
			line.zone:Hide()
			line.zone.f:Hide()
		end
		
		line.questID = data.questID
		line.numObjectives = data.numObjectives
		line.data = data.info
		
		if data.isNewQuest and not VWQL.DisableHighlightNewQuest then
			line.nqhl:Show()
		else
			line.nqhl:Hide()
		end
		
		if data.artifactKnowlege then
			line.reward.artifactKnowlege = true
			line.reward.timeToComplete = data.timeToComplete
		else
			line.reward.artifactKnowlege = nil
			line.reward.timeToComplete = nil
		end
		
		line.rewardLink = data.rewardItemLink
		
		line.faction.f.tooltip = data.bountyTooltip
		
		line.isLeveling = nil
		line.reward.IDs = nil
		
		line:Show()
	
		taskIconIndex = taskIconIndex + 1
	end
	
	WorldQuestList:SetHeight(max(16*(taskIconIndex-1+(VWQL.DisableHeader and 0 or 1)),1))
	WorldQuestList.C:SetHeight(max(16*(taskIconIndex-1),1))
	
	local lowestLine = #WorldQuestList.Cheader.lines
	local lowestPosConst = VWQL.DisableHeader and 60 or 40
	for i=1,#WorldQuestList.Cheader.lines do
		local bottomPos = WorldQuestList.Cheader.lines[i]:GetBottom()
		if bottomPos and bottomPos < lowestPosConst then
			lowestLine = i - 1
			break
		end
	end
	
	if lowestLine >= taskIconIndex then
		WorldQuestList.Cheader:SetVerticalScroll(0)
	else
		WorldQuestList:SetHeight((lowestLine+1)*16)
		WorldQuestList.Cheader:SetVerticalScroll( min(WorldQuestList.Cheader:GetVerticalScrollRange(),WorldQuestList.Cheader:GetVerticalScroll()) )
	end
	UpdateScrollButtonsState()
	C_Timer.After(0.05,UpdateScrollButtonsState)
	
	for i = taskIconIndex, NUM_WORLDMAP_TASK_POIS do
		WorldQuestList.l[i]:Hide()
	end
	
	if taskIconIndex == 1 then
		WorldQuestList.b:SetAlpha(0)
		WorldQuestList.backdrop:SetAlpha(0)
		if mapAreaID == 1007 then
			ViewAllButton:Hide()
		else
			ViewAllButton:Show()
		end
		WorldQuestList.header:Update(true)
	else
		WorldQuestList.b:SetAlpha(WorldQuestList.b.A or 1)
		WorldQuestList.backdrop:SetAlpha(1)
		ViewAllButton:Hide()
		WorldQuestList.header:Update(false,mapAreaID == 1007)
	end
	
	if not VWQL.DisableTotalAP then
		local fString = ""
		if totalAP > 0 then
			fString = fString .. (fString ~= "" and "|n" or "") .. LOCALE.totalap .. FormatAPnumber(totalAP,artifactKnowlegeLevel)
		end
		if totalOR > 0 then
			fString = fString .. (fString ~= "" and "|n" or "") .. format("%s: %d",orderResName,totalOR)
		end
		if totalG > 0 then
			fString = fString .. (fString ~= "" and "|n" or "") .. LOCALE.gold..": "..GetCoinTextureString(totalG)
		end
		WorldQuestList.TotalAP:SetText(fString)
	end
	
	if totalQuestsNumber == 0 then
		WorldQuestList.sortDropDown:Hide()
		WorldQuestList.filterDropDown:Hide()
		WorldQuestList.optionsDropDown:Hide()
	else
		WorldQuestList.sortDropDown:Show()
		WorldQuestList.filterDropDown:Show()
		WorldQuestList.optionsDropDown:Show()		
	end
end

C_Timer.NewTicker(.7,function()
	if UpdateTicker then
		UpdateTicker = nil
		WorldQuestList_Update()
	end
end)

local prevZone
hooksecurefunc("WorldMap_UpdateQuestBonusObjectives", function ()
	local currZone = GetCurrentMapAreaID()
	if currZone ~= prevZone then
		WorldQuestList_Update()
	end
	prevZone = currZone
	UpdateTicker = true
end)
--[[
local WorldMap_UpdateQuestBonusObjectives_Replace = CreateFrame'Frame'
WorldMap_UpdateQuestBonusObjectives_Replace:RegisterEvent("QUEST_LOG_UPDATE")
WorldMap_UpdateQuestBonusObjectives_Replace:SetScript("OnEvent",function()
	if WorldMapFrame:IsVisible() then
		local currZone = GetCurrentMapAreaID()
		if currZone ~= prevZone then
			WorldQuestList_Update()
		end
		prevZone = currZone
		UpdateTicker = true
	end
end)
]]

local UpdateDB_Sch = nil

local function UpdateDB()
	UpdateDB_Sch = nil
	for questID,_ in pairs(TableQuestsViewed) do
		VWQL[charKey].Quests[ questID ] = true
	end
	local mapAreaID = GetCurrentMapAreaID()
	SetMapByID(1007)
	local questsList = {}
	for i=1,#BrokenIslesZones do
		local z = C_TaskQuest.GetQuestsForPlayerByMapID(BrokenIslesZones[i])
		for i, info  in ipairs(z) do
			local questID = info.questId
			if HaveQuestData(questID) and QuestUtils_IsQuestWorldQuest(questID) then
				questsList[ questID ] = true
			end
		end
	end
	
	local toRemove = {}
	for questID,_ in pairs(VWQL[charKey].Quests) do
		if not questsList[ questID ] then
			toRemove[ questID ] = true
		end
	end
	for questID,_ in pairs(toRemove) do
		VWQL[charKey].Quests[ questID ] = nil
	end
	
	wipe(TableQuestsViewed)
	
	SetMapByID(mapAreaID)
end

local WorldMapButton_HookShowHide = CreateFrame("Frame",nil,WorldMapButton)
WorldMapButton_HookShowHide:SetPoint("TOPLEFT")
WorldMapButton_HookShowHide:SetSize(1,1)

WorldMapButton_HookShowHide:SetScript('OnHide',function()
	if UpdateDB_Sch then
		UpdateDB_Sch:Cancel()
	end
	UpdateDB_Sch = C_Timer.NewTimer(.2,UpdateDB)
	
	WorldQuestList.mapB:Hide()
end)
WorldMapButton_HookShowHide:SetScript('OnShow',function()
	if UpdateDB_Sch then
		UpdateDB_Sch:Cancel()
	end
	if VWQL[charKey].HideMap then
		WorldQuestList:Hide()
		return
	end
	if WorldQuestList:IsVisible() then
		WorldQuestList:Hide()
		WorldQuestList:Show()
	end
	C_Garrison.RequestLandingPageShipmentInfo()
end)

SlashCmdList["WQLSlash"] = function() 
	if WorldQuestList:IsVisible() then
		WorldQuestList:Hide()
		WorldQuestList:Show()
		return
	end
	WorldQuestList:ClearAllPoints()
	WorldQuestList:SetParent(UIParent)
	WorldQuestList:SetPoint("TOPLEFT",WorldMapScreenAnchor,20)
	SetMapByID(1007)
	WorldQuestList_Update()
	C_Timer.NewTimer(.5,WorldQuestList_Update)
	C_Timer.NewTimer(1.5,WorldQuestList_Update)
	WorldQuestList.Close:Show()
	WorldQuestList:Show()
end
SLASH_WQLSlash1 = "/wql"
SLASH_WQLSlash2 = "/worldquestslist"

WorldMapHideWQLCheck = CreateFrame("CheckButton",nil,WorldMapFrame,"UICheckButtonTemplate")  
WorldMapHideWQLCheck:SetPoint("TOPLEFT", WorldMapFrame, "TOPRIGHT", -130, 25)
WorldMapHideWQLCheck.text:SetText("World Quests List")
WorldMapHideWQLCheck:SetScript("OnClick", function(self,event) 
	if not self:GetChecked() then
		VWQL[charKey].HideMap = true
		WorldQuestList:Hide()
	else
		VWQL[charKey].HideMap = nil
		WorldQuestList:Show()
	end
end)


local function DEV_CreateBorder(parent,sZ)
	local top = parent["border_top"] or parent:CreateTexture(nil, "BORDER")
	local bottom = parent["border_bottom"] or parent:CreateTexture(nil, "BORDER")
	local left = parent["border_left"] or parent:CreateTexture(nil, "BORDER")
	local right = parent["border_right"] or parent:CreateTexture(nil, "BORDER")
	
	parent["border_top"] = top
	parent["border_bottom"] = bottom
	parent["border_left"] = left
	parent["border_right"] = right
	
	local size,outside = sZ or 1,-1
	
	top:SetPoint("TOPLEFT",parent,"TOPLEFT",-size-outside,size+outside)
	top:SetPoint("BOTTOMRIGHT",parent,"TOPRIGHT",size+outside,outside)

	bottom:SetPoint("BOTTOMLEFT",parent,"BOTTOMLEFT",-size-outside,-size-outside)
	bottom:SetPoint("TOPRIGHT",parent,"BOTTOMRIGHT",size+outside,-outside)

	left:SetPoint("TOPLEFT",parent,"TOPLEFT",-size-outside,outside)
	left:SetPoint("BOTTOMRIGHT",parent,"BOTTOMLEFT",-outside,-outside)

	right:SetPoint("TOPLEFT",parent,"TOPRIGHT",outside,outside)
	right:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",size+outside,-outside)

	parent.SetBorderColor = function(self,colorR,colorG,colorB,colorA)
		top:SetColorTexture(colorR,colorG,colorB,colorA)
		bottom:SetColorTexture(colorR,colorG,colorB,colorA)
		left:SetColorTexture(colorR,colorG,colorB,colorA)
		right:SetColorTexture(colorR,colorG,colorB,colorA)
	end
	

	top:Show()
	bottom:Show()
	left:Show()
	right:Show()
end

local KirinTorQuests = {
	[43756]=true,	--VS
	[43772]=true,	--SH
	[43767]=true,	--HM
	[43328]=true,	--A
	[43778]=true,	--SU
}

--[[
local KirinTorPatt = {
	[1] = {	[41]=2,[40]=1,[39]=1,[32]=1,[25]=1,[26]=1,[19]=1,[12]=1,[11]=1,[10]=1,[9]=1,},
	[2] = {	[9]=1,[10]=1,[17]=1,[24]=1,[25]=1,[32]=1,[33]=1,[40]=1,[41]=2,},
	[3] = {	[9]=1,[16]=1,[17]=1,[18]=1,[19]=1,[20]=1,[27]=1,[34]=1,[41]=2,},
	[4] = {	[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[20]=1,[27]=1,[26]=1,[25]=1,[24]=1,[23]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
	[5] = {	[9]=1,[16]=1,[23]=1,[24]=1,[25]=1,[18]=1,[11]=1,[12]=1,[13]=1,[20]=1,[27]=1,[34]=1,[41]=2,},
	[6] = {	[9]=1,[16]=1,[23]=1,[30]=1,[31]=1,[32]=1,[25]=1,[18]=1,[11]=1,[12]=1,[13]=1,[20]=1,[27]=1,[34]=1,[41]=2,},
	[7] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[16]=1,[23]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
	[8] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[16]=1,[23]=1,[30]=1,[37]=1,[38]=1,[39]=1,[32]=1,[25]=1,[26]=1,[27]=1,[34]=1,[41]=2,},
	[9] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[16]=1,[23]=1,[24]=1,[25]=1,[32]=1,[39]=1,[40]=1,[41]=2,},
}

]]

local KirinTorPatt = {		--Patterns created by flow0284
	[1] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[20]=1,[23]=1,[24]=1,[25]=1,[26]=1,[27]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
	[2] = { [9]=1,[11]=1,[12]=1,[13]=1,[16]=1,[18]=1,[20]=1,[23]=1,[24]=1,[25]=1,[27]=1,[34]=1,[41]=2,},
	[3] = { [9]=1,[10]=1,[11]=1,[12]=1,[19]=1,[25]=1,[26]=1,[32]=1,[39]=1,[40]=1,[41]=2,},
	[4] = { [9]=1,[10]=1,[11]=1,[18]=1,[23]=1,[24]=1,[25]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
	[5] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[16]=1,[23]=1,[25]=1,[26]=1,[27]=1,[30]=1,[32]=1,[34]=1,[37]=1,[38]=1,[39]=1,[41]=2,},
	[6] = { [12]=1,[13]=1,[18]=1,[19]=1,[25]=1,[32]=1,[33]=1,[40]=1,[41]=2,},
	[7] = { [9]=1,[11]=1,[12]=1,[13]=1,[16]=1,[18]=1,[20]=1,[23]=1,[25]=1,[27]=1,[30]=1,[31]=1,[32]=1,[34]=1,[41]=2,},
	[8] = { [9]=1,[10]=1,[17]=1,[24]=1,[25]=1,[32]=1,[33]=1,[40]=1,[41]=2,},
	[9] = { [9]=1,[16]=1,[17]=1,[18]=1,[19]=1,[20]=1,[27]=1,[34]=1,[41]=2,},
	[10] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[16]=1,[23]=1,[24]=1,[25]=1,[26]=1,[33]=1,[40]=1,[41]=2,},
	[11] = { [9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[16]=1,[23]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
	[12] = { [11]=1,[12]=1,[13]=1,[18]=1,[23]=1,[24]=1,[25]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
	[13] = { [13]=1,[20]=1,[23]=1,[24]=1,[25]=1,[26]=1,[27]=1,[30]=1,[37]=1,[38]=1,[39]=1,[40]=1,[41]=2,},
}

local KIRIN_TOR_SIZE = 7
local KirinTorSelecter_Big_BSize = 30
local KirinTorSelecter_Big_Size = KIRIN_TOR_SIZE * KirinTorSelecter_Big_BSize + 10

local KirinTorSelecter_BSize = 12
local KirinTorSelecter_Size = KIRIN_TOR_SIZE * KirinTorSelecter_BSize + 10

local KirinTorSelecter_Big = CreateFrame('Button',nil,UIParent)
KirinTorSelecter_Big:SetPoint("LEFT",30,0)
KirinTorSelecter_Big:SetSize(KirinTorSelecter_Big_Size,KirinTorSelecter_Big_Size)
KirinTorSelecter_Big:SetAlpha(.8)
DEV_CreateBorder(KirinTorSelecter_Big)
KirinTorSelecter_Big:SetBorderColor(0,0,0,0)

KirinTorSelecter_Big.back = KirinTorSelecter_Big:CreateTexture(nil,"BACKGROUND")
KirinTorSelecter_Big.back:SetAllPoints()
KirinTorSelecter_Big.back:SetColorTexture(0,0,0,1)
KirinTorSelecter_Big.T = {}
KirinTorSelecter_Big:Hide()
do
	local L = (KirinTorSelecter_Big_Size - KirinTorSelecter_Big_BSize * KIRIN_TOR_SIZE) / 2
	for j=0,KIRIN_TOR_SIZE-1 do
		for k=0,KIRIN_TOR_SIZE-1 do
			local t = KirinTorSelecter_Big:CreateTexture(nil,"ARTWORK")
			t:SetSize(KirinTorSelecter_Big_BSize,KirinTorSelecter_Big_BSize)
			t:SetPoint("TOPLEFT",L + k*KirinTorSelecter_Big_BSize,-L-j*KirinTorSelecter_Big_BSize)
			
			KirinTorSelecter_Big.T[ j*KIRIN_TOR_SIZE+k+1 ] = t
		end
		

		local l = KirinTorSelecter_Big:CreateTexture(nil,"OVERLAY")
		l:SetPoint("TOPLEFT",L+j*KirinTorSelecter_Big_BSize,-L)
		l:SetSize(1,KirinTorSelecter_Big_BSize*KIRIN_TOR_SIZE)
		l:SetColorTexture(0,0,0,.3)
	end
	for j=0,7 do
		local l = KirinTorSelecter_Big:CreateTexture(nil,"OVERLAY")
		l:SetPoint("TOPLEFT",L,-L-j*KirinTorSelecter_Big_BSize)
		l:SetSize(KirinTorSelecter_Big_BSize*KIRIN_TOR_SIZE,1)
		l:SetColorTexture(0,0,0,.3)	
	end
end



local KirinTorSelecter = CreateFrame('Frame',nil,UIParent)
KirinTorSelecter:SetPoint("LEFT",30,0)
KirinTorSelecter:SetSize(KirinTorSelecter_Size * 3,KirinTorSelecter_Size * 2)
KirinTorSelecter:SetAlpha(.7)
KirinTorSelecter:Hide()

KirinTorSelecter.back = KirinTorSelecter:CreateTexture(nil,"BACKGROUND")
KirinTorSelecter.back:SetAllPoints()
KirinTorSelecter.back:SetColorTexture(0,0,0,1)

for i=1,#KirinTorPatt do
	local b = CreateFrame('Button',nil,KirinTorSelecter)
	b:SetSize(KirinTorSelecter_Size,KirinTorSelecter_Size)
	b:SetPoint("TOPLEFT",((i-1)%3)*KirinTorSelecter_Size,-floor((i-1)/3)*KirinTorSelecter_Size)
	
	DEV_CreateBorder(b)
	b:SetBorderColor(0,0,0,1)
	b:SetScript("OnEnter",function(self)
		self:SetBorderColor(1,1,1,1)
	end)
	b:SetScript("OnLeave",function(self)
		self:SetBorderColor(0,0,0,1)
	end)
	b:SetScript("OnClick",function(self)
		for j=0,KIRIN_TOR_SIZE-1 do
			for k=0,KIRIN_TOR_SIZE-1 do
				local n = j*KIRIN_TOR_SIZE+k+1
				local c = KirinTorPatt[i][n]
				if c == 2 then
					KirinTorSelecter_Big.T[n]:SetColorTexture(0,1,0,1)
				elseif c then
					KirinTorSelecter_Big.T[n]:SetColorTexture(1,0,0,1)
				else
					KirinTorSelecter_Big.T[n]:SetColorTexture(1,.7,.4,1)
				end
			end
		end	
		KirinTorSelecter:Hide()
		KirinTorSelecter_Big:Show()
	end)
	
	local L = (KirinTorSelecter_Size - KirinTorSelecter_BSize * KIRIN_TOR_SIZE) / 2
	for j=0,KIRIN_TOR_SIZE-1 do
		for k=0,KIRIN_TOR_SIZE-1 do
			local t = b:CreateTexture(nil,"ARTWORK")
			t:SetSize(KirinTorSelecter_BSize,KirinTorSelecter_BSize)
			t:SetPoint("TOPLEFT",L + k*KirinTorSelecter_BSize,-L-j*KirinTorSelecter_BSize)
			
			local c = KirinTorPatt[i][ j*KIRIN_TOR_SIZE+k+1 ]
			if c == 2 then
				t:SetColorTexture(0,1,0,1)
			elseif c then
				t:SetColorTexture(1,0,0,1)
			else
				t:SetColorTexture(1,.7,.4,1)
			end
			
		end
	end
end

KirinTorSelecter.Close = CreateFrame('Button',nil,KirinTorSelecter)
KirinTorSelecter.Close:SetSize(10,10)
KirinTorSelecter.Close:SetPoint("BOTTOMRIGHT",KirinTorSelecter,"TOPRIGHT")
KirinTorSelecter.Close.Text = KirinTorSelecter.Close:CreateFontString(nil,"ARTWORK","GameFontWhite")
KirinTorSelecter.Close.Text:SetPoint("CENTER")
KirinTorSelecter.Close.Text:SetText("X")

KirinTorSelecter_Big:SetScript("OnClick",function (self)
	self:Hide()
  	KirinTorSelecter:Show()
end)


local KirinTorHelper = CreateFrame'Frame'
KirinTorHelper:RegisterEvent('QUEST_ACCEPTED')
KirinTorHelper:RegisterEvent('QUEST_REMOVED')
KirinTorHelper:SetScript("OnEvent",function(self,event,arg1,arg2, hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId)
	if event == 'QUEST_ACCEPTED' then
		if (arg1 and KirinTorQuests[arg1]) or (arg2 and KirinTorQuests[arg2]) then
			if not VWQL.EnableEnigma then
				print('"|cff00ff00/enigmahelper|r" - to see all patterns')
				return
			end
			print("World Quests List: Enigma helper loaded")
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	elseif event == 'QUEST_REMOVED' then
		if (arg1 and KirinTorQuests[arg1]) or (arg2 and KirinTorQuests[arg2]) then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	elseif event == 'COMBAT_LOG_EVENT_UNFILTERED' then
		if arg2 == "SPELL_AURA_APPLIED" and spellId == 219247 and destGUID == UnitGUID'player' then
			KirinTorSelecter:Show()
		elseif arg2 == "SPELL_AURA_REMOVED" and spellId == 219247 and destGUID == UnitGUID'player' then
			KirinTorSelecter:Hide()
			KirinTorSelecter_Big:Hide()
		end
	end
end)

KirinTorSelecter.Close:SetScript("OnClick",function ()
	KirinTorSelecter:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	KirinTorSelecter:Hide()
end)

SlashCmdList["WQLEnigmaSlash"] = function() 
	KirinTorHelper:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	KirinTorSelecter:Show()
end
SLASH_WQLEnigmaSlash1 = "/enigmahelper"


-- Barrels o' Fun

local BarrelsHelperQuests = {
	[45070]=true,	--Valsh
	[45068]=true,	--Suramar
	[45069]=true,	--Azuna
	[45071]=true,	--Highm
	[45072]=true,	--Stormh
}
local BarrelsHelper_guid = {}
local BarrelsHelper_count = 8

local BarrelsHelper = CreateFrame'Frame'
BarrelsHelper:RegisterEvent('QUEST_ACCEPTED')
BarrelsHelper:RegisterEvent('QUEST_REMOVED')
BarrelsHelper:RegisterEvent('PLAYER_ENTERING_WORLD')
BarrelsHelper:SetScript("OnEvent",function(self,event,arg1,arg2, hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellId)
	if event == 'QUEST_ACCEPTED' then
		if (arg1 and BarrelsHelperQuests[arg1]) or (arg2 and BarrelsHelperQuests[arg2]) then
			if VWQL.DisableBarrels then
				return
			end
			print("World Quests List: Barrels helper loaded")
			BarrelsHelper_count = 8
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		end
	elseif event == 'QUEST_REMOVED' then
		if (arg1 and BarrelsHelperQuests[arg1]) or (arg2 and BarrelsHelperQuests[arg2]) then
			self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
			BarrelsHelper_count = 8
		end
	elseif event == 'UPDATE_MOUSEOVER_UNIT' then
		local guid = UnitGUID'mouseover'
		if guid then
			local type,_,serverID,instanceID,zoneUID,id,spawnID = strsplit("-", guid)
			if id == "115947" then
				if not BarrelsHelper_guid[guid] then
					BarrelsHelper_guid[guid] = BarrelsHelper_count
					BarrelsHelper_count = BarrelsHelper_count - 1
					if BarrelsHelper_count < 1 then
						BarrelsHelper_count = 8
					end
				end
				if GetRaidTargetIndex("mouseover") ~= BarrelsHelper_guid[guid] then
					SetRaidTarget("mouseover", BarrelsHelper_guid[guid])
				end
			end
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		if VWQL.DisableBarrels then
			return
		end
		for i=1,GetNumQuestLogEntries() do
			local title, _, _, _, _, _, _, questID = GetQuestLogTitle(i)
			if questID and BarrelsHelperQuests[questID] then
				BarrelsHelper_count = 8
				self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
				break
			end
		end
	end
end)

SlashCmdList["WQLBarrelsSlash"] = function(arg) 
	arg = (arg or ""):lower()
	if arg == "off" or arg == "on" then
		VWQL.DisableBarrels = not VWQL.DisableBarrels
		if VWQL.DisableBarrels then
			print("Barrels helper disabled")
			BarrelsHelper:UnregisterEvent('UPDATE_MOUSEOVER_UNIT')
		else
			print("Barrels helper enabled")
		end
	elseif arg == "load" then
		BarrelsHelper:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		print("Barrels helper loaded")
	else
		print("Commands:")
		print("/barrelshelper on")
		print("/barrelshelper off")
		print("/barrelshelper load")
	end
end
SLASH_WQLBarrelsSlash1 = "/barrelshelper"


---- ElvUI

C_Timer.After(5,function()
	if ElvUI and ElvUI[1] and ElvUI[1].GetModule then
		local S = ElvUI[1]:GetModule('Skins')
		if S then
			S:HandleButton(ViewAllButton, true)
			S:HandleDropDownBox(WorldQuestList.sortDropDown)
			S:HandleDropDownBox(WorldQuestList.filterDropDown)
			S:HandleDropDownBox(WorldQuestList.optionsDropDown)
			
			WorldQuestList.backdrop:SetBackdrop({})
			DEV_CreateBorder(WorldQuestList.backdrop,2)
			WorldQuestList.backdrop:SetBorderColor(0,0,0,1)
			WorldQuestList.b.A = .7
			
			WorldQuestList.backdrop:SetPoint("TOPLEFT",0,0)
			WorldQuestList.backdrop:SetPoint("BOTTOMRIGHT",0,0)
		end
	end
end)

local FlightMap_Pos = {13100.099609375,7262.1298828125,-5738.080078125,-5296.6899414063}

local FlightMap = CreateFrame("Frame")
FlightMap:RegisterEvent("ADDON_LOADED")
FlightMap:SetScript("OnEvent",function (self, event, arg)
	if arg == "Blizzard_FlightMap" then
		local t1,t2
		local f = CreateFrame("Frame",nil,FlightMapFrame.ScrollContainer.Child)
		f:SetPoint("TOPLEFT")
		f:SetSize(1,1)
		f:SetScript("OnShow",function()
			local mapID = GetTaxiMapID()
			if mapID == 1007 then
				for i=1,GetNumWorldQuestWatches() do
					local questID = GetWorldQuestWatchInfo(i)
					if QuestsCachedPosX[questID] then
						local posX = abs((FlightMap_Pos[1] - QuestsCachedPosX[questID]) / (FlightMap_Pos[1] - FlightMap_Pos[3]))
						local posY = abs((FlightMap_Pos[2] - QuestsCachedPosY[questID]) / (FlightMap_Pos[2] - FlightMap_Pos[4]))
						
						local width = FlightMapFrame.ScrollContainer.Child:GetWidth()
						if width == 0 then
							C_Timer.After(.1,function()
								t1:SetPoint("CENTER",FlightMapFrame.ScrollContainer.Child,"TOPLEFT",FlightMapFrame.ScrollContainer.Child:GetWidth() * posX,-FlightMapFrame.ScrollContainer.Child:GetHeight() * posY)
								--t1:Show()
								t2:Show()
							end)
						else
							t1:SetPoint("CENTER",FlightMapFrame.ScrollContainer.Child,"TOPLEFT",FlightMapFrame.ScrollContainer.Child:GetWidth() * posX,-FlightMapFrame.ScrollContainer.Child:GetHeight() * posY)
							--t1:Show()
							t2:Show()
						end
						
						return
					end
				end
			end
			
			t1:Hide()
			t2:Hide()
		end)
		local prevScale = 0
		f:SetScript("OnUpdate",function()
			local scale = FlightMapFrame.ScrollContainer.Child:GetScale()
			if scale ~= prevScale then
				prevScale = scale
				if scale < .4 then
					t1:SetAlpha(1)
					t2:SetAlpha(1)
				else
					local alpha = 1 - min(max(0,scale - .4) / .4, 1)
					t1:SetAlpha(alpha)
					t2:SetAlpha(alpha)
				end
			end
		end)
		
		local ICON_SCALE = 3
		
		t1 = f:CreateTexture(nil,"OVERLAY")
		t1:SetSize(50 * ICON_SCALE,50 * ICON_SCALE)
		t1:SetTexture("Interface\\AddOns\\WorldQuestsList\\Button-Pushed")
		t1:Hide()
		
		t2 = f:CreateTexture(nil,"OVERLAY")
		t2:SetSize(24 * ICON_SCALE,24 * ICON_SCALE)
		t2:SetAtlas("XMarksTheSpot")
		t2:SetPoint("CENTER",t1)
		t2:Hide()
		
		self:UnregisterAllEvents()
	end
end)



do
	local Templates = {}
	function ELib:Template(name,parent)
		if not Templates[name] then
			return
		end
		local obj = Templates[name](nil,parent)
		--obj:SetParent(parent or UIParent)
		return obj
	end
	function Templates:Border(self,cR,cG,cB,cA,size,offsetX,offsetY)
		offsetX = offsetX or 0
		offsetY = offsetY or 0
	
		self.BorderTop = self:CreateTexture(nil,"BACKGROUND")
		self.BorderTop:SetColorTexture(cR,cG,cB,cA)
		self.BorderTop:SetPoint("TOPLEFT",-size-offsetX,size+offsetY)
		self.BorderTop:SetPoint("BOTTOMRIGHT",self,"TOPRIGHT",size+offsetX,offsetY)

		self.BorderLeft = self:CreateTexture(nil,"BACKGROUND")
		self.BorderLeft:SetColorTexture(cR,cG,cB,cA)
		self.BorderLeft:SetPoint("TOPLEFT",-size-offsetX,offsetY)
		self.BorderLeft:SetPoint("BOTTOMRIGHT",self,"BOTTOMLEFT",-offsetX,-offsetY)

		self.BorderBottom = self:CreateTexture(nil,"BACKGROUND")
		self.BorderBottom:SetColorTexture(cR,cG,cB,cA)
		self.BorderBottom:SetPoint("BOTTOMLEFT",-size-offsetX,-size-offsetY)
		self.BorderBottom:SetPoint("TOPRIGHT",self,"BOTTOMRIGHT",size+offsetX,-offsetY)

		self.BorderRight = self:CreateTexture(nil,"BACKGROUND")
		self.BorderRight:SetColorTexture(cR,cG,cB,cA)
		self.BorderRight:SetPoint("BOTTOMRIGHT",size+offsetX,offsetY)
		self.BorderRight:SetPoint("TOPLEFT",self,"TOPRIGHT",offsetX,-offsetY)
	end
	function ELib:Shadow(parent,size,edgeSize)
		local self = CreateFrame("Frame",nil,parent)
		self:SetPoint("LEFT",-size,0)
		self:SetPoint("RIGHT",size,0)
		self:SetPoint("TOP",0,size)
		self:SetPoint("BOTTOM",0,-size)
		self:SetBackdrop({edgeFile="Interface/AddOns/WorldQuestsList/shadow",edgeSize=edgeSize or 28,insets={left=size,right=size,top=size,bottom=size}})
		self:SetBackdropBorderColor(0,0,0,.45)
	
		return self
	end	
	do
		local function OnEnter(self, motion)
			UIDropDownMenu_StopCounting(self, motion)
		end
		local function OnLeave(self, motion)
			UIDropDownMenu_StartCounting(self, motion)
		end
		local function OnClick(self)
			self:Hide()
		end
		local function OnShow(self)
			self:SetFrameLevel(1000)
			if self.OnShow then
				self:OnShow()
			end
		end
		local function OnHide(self)
			UIDropDownMenu_StopCounting(self)
		end
		local function OnUpdate(self, elapsed)
			ELib.ScrollDropDown.Update(self, elapsed)
		end
		function Templates:ExRTDropDownListTemplate(parent)
			local self = CreateFrame("Button",nil,parent)
			self:SetFrameStrata("TOOLTIP")
			self:EnableMouse(true)
			self:Hide()
			
			self.Backdrop = CreateFrame("Frame",nil,self)
			self.Backdrop:SetAllPoints()
			self.Backdrop:SetBackdrop({
				bgFile="Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
				edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
				tile = true,
				insets = {
					left = 11,
					right = 12,
					top = 11,
					bottom = 9,
				},
				tileSize = 32,
				edgeSize = 32,
			})
			
			self:SetScript("OnEnter",OnEnter)
			self:SetScript("OnLeave",OnLeave)
			self:SetScript("OnClick",OnClick)
			self:SetScript("OnShow",OnShow)
			self:SetScript("OnHide",OnHide)
			self:SetScript("OnUpdate",OnUpdate)
			return self
		end	
		function Templates:ExRTDropDownListModernTemplate(parent)
			local self = CreateFrame("Button",nil,parent)
			self:SetFrameStrata("TOOLTIP")
			self:EnableMouse(true)
			self:Hide()
			
			Templates:Border(self,0,0,0,1,1)
			
			self.Background = self:CreateTexture(nil,"BACKGROUND")
			self.Background:SetColorTexture(0,0,0,.9)
			self.Background:SetPoint("TOPLEFT")
			self.Background:SetPoint("BOTTOMRIGHT")
			
			self:SetScript("OnEnter",OnEnter)
			self:SetScript("OnLeave",OnLeave)
			self:SetScript("OnClick",OnClick)
			self:SetScript("OnShow",OnShow)
			self:SetScript("OnHide",OnHide)
			self:SetScript("OnUpdate",OnUpdate)
			return self
		end
	end	
	do
		local function OnEnter(self)
			self.Highlight:Show()
			UIDropDownMenu_StopCounting(self:GetParent())
			if ( self.tooltipTitle ) then
				if ( self.tooltipOnButton ) then
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
					GameTooltip:AddLine(self.tooltipTitle, 1.0, 1.0, 1.0)
					GameTooltip:AddLine(self.tooltipText)
					GameTooltip:Show()
				else
					GameTooltip_AddNewbieTip(self, self.tooltipTitle, 1.0, 1.0, 1.0, self.tooltipText, true)
				end
			end
			if ( self.NormalText:IsTruncated() ) then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:AddLine(self.NormalText:GetText())
				GameTooltip:Show()
			end
			ELib.ScrollDropDown.OnButtonEnter(self)
		end
		local function OnLeave(self)
			self.Highlight:Hide()
			UIDropDownMenu_StartCounting(self:GetParent())
			GameTooltip:Hide()
			ELib.ScrollDropDown.OnButtonLeave(self)
		end
		local function OnClick(self, button, down)
			ELib.ScrollDropDown.OnClick(self, button, down)
		end
		local function OnLoad(self)
			self:SetFrameLevel(self:GetParent():GetFrameLevel()+2)
		end
		function Templates:ExRTDropDownMenuButtonTemplate(parent)
			local self = CreateFrame("Button",nil,parent)
			self:SetSize(100,16)
			
			self.Highlight = self:CreateTexture(nil,"BACKGROUND")
			self.Highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			self.Highlight:SetAllPoints()
			self.Highlight:SetBlendMode("ADD")
			self.Highlight:Hide()
			
			self.Texture = self:CreateTexture(nil,"BACKGROUND",nil,-8)
			self.Texture:Hide()
			self.Texture:SetAllPoints()
			
			self.Icon = self:CreateTexture(nil,"ARTWORK")
			self.Icon:SetSize(16,16)
			self.Icon:SetPoint("LEFT")
			self.Icon:Hide()
			
			self.Arrow = self:CreateTexture(nil,"ARTWORK")
			self.Arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
			self.Arrow:SetSize(16,16)
			self.Arrow:SetPoint("RIGHT")
			self.Arrow:Hide()
			
			self.NormalText = self:CreateFontString()
			self.NormalText:SetPoint("LEFT")
			
			self:SetFontString(self.NormalText)
			
			self:SetNormalFontObject("GameFontHighlightSmallLeft")
			self:SetHighlightFontObject("GameFontHighlightSmallLeft")
			self:SetDisabledFontObject("GameFontDisableSmallLeft")
	
			self:SetPushedTextOffset(1,-1)
			
			self:SetScript("OnEnter",OnEnter)
			self:SetScript("OnLeave",OnLeave)
			self:SetScript("OnClick",OnClick)
			self:SetScript("OnLoad",OnLoad)
			return self
		end
	end	
	function Templates:ExRTCheckButtonModernTemplate(parent)
		local self = CreateFrame("CheckButton",nil,parent)
		self:SetSize(20,20)
		
		self.text = self:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
		self.text:SetPoint("TOPLEFT",self,"TOPRIGHT",4,0)
		self.text:SetPoint("BOTTOMLEFT",self,"BOTTOMRIGHT",4,0)
		self.text:SetJustifyV("MIDDLE")
		
		self:SetFontString(self.text)
		
		Templates:Border(self,0.24,0.25,0.3,1,1)
		
		self.Texture = self:CreateTexture(nil,"BACKGROUND")
		self.Texture:SetColorTexture(0,0,0,.3)
		self.Texture:SetPoint("TOPLEFT")
		self.Texture:SetPoint("BOTTOMRIGHT")
		
		self.CheckedTexture = self:CreateTexture()
		self.CheckedTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		self.CheckedTexture:SetPoint("TOPLEFT",-4,4)
		self.CheckedTexture:SetPoint("BOTTOMRIGHT",4,-4)
		self:SetCheckedTexture(self.CheckedTexture)
		
		self.PushedTexture = self:CreateTexture()
		self.PushedTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		self.PushedTexture:SetPoint("TOPLEFT",-4,4)
		self.PushedTexture:SetPoint("BOTTOMRIGHT",4,-4)
		self.PushedTexture:SetVertexColor(0.8,0.8,0.8,0.5)
		self.PushedTexture:SetDesaturated(true)
		self:SetPushedTexture(self.PushedTexture)
	
		self.DisabledTexture = self:CreateTexture()
		self.DisabledTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		self.DisabledTexture:SetPoint("TOPLEFT",-4,4)
		self.DisabledTexture:SetPoint("BOTTOMRIGHT",4,-4)
		self:SetDisabledTexture(self.DisabledTexture)
			
		self.HighlightTexture = self:CreateTexture()
		self.HighlightTexture:SetColorTexture(1,1,1,.3)
		self.HighlightTexture:SetPoint("TOPLEFT")
		self.HighlightTexture:SetPoint("BOTTOMRIGHT")
		self:SetHighlightTexture(self.HighlightTexture)
				
		return self
	end
	function Templates:ExRTRadioButtonModernTemplate(parent)
		local self = CreateFrame("CheckButton",nil,parent)
		self:SetSize(16,16)
		
		self.text = self:CreateFontString(nil,"BACKGROUND","GameFontNormalSmall")
		self.text:SetPoint("LEFT",self,"RIGHT",5,0)
		
		self:SetFontString(self.text)
		
		self.NormalTexture = self:CreateTexture()
		self.NormalTexture:SetTexture("Interface\\Addons\\WorldQuestsList\\radioModern")
		self.NormalTexture:SetAllPoints()
		self.NormalTexture:SetTexCoord(0,0.25,0,1)
		self:SetNormalTexture(self.PushedTexture)
	
		self.HighlightTexture = self:CreateTexture()
		self.HighlightTexture:SetTexture("Interface\\Addons\\WorldQuestsList\\radioModern")
		self.HighlightTexture:SetAllPoints()
		self.HighlightTexture:SetTexCoord(0.5,0.75,0,1)
		self:SetHighlightTexture(self.HighlightTexture)
		
		self.CheckedTexture = self:CreateTexture()
		self.CheckedTexture:SetTexture("Interface\\Addons\\WorldQuestsList\\radioModern")
		self.CheckedTexture:SetAllPoints()
		self.CheckedTexture:SetTexCoord(0.25,0.5,0,1)
		self:SetCheckedTexture(self.CheckedTexture)
				
		return self
	end
	
	
	ELib.ScrollDropDown = {}
	ELib.ScrollDropDown.List = {}
	local ScrollDropDown_Modern = {}
	
	for i=1,2 do
		ScrollDropDown_Modern[i] = ELib:Template("ExRTDropDownListModernTemplate",UIParent)
		_G["WQL_ExRTDropDownListModern"..i] = ScrollDropDown_Modern[i]
		ScrollDropDown_Modern[i]:SetClampedToScreen(true)
		ScrollDropDown_Modern[i].border = ELib:Shadow(ScrollDropDown_Modern[i],20)
		ScrollDropDown_Modern[i].Buttons = {}
		ScrollDropDown_Modern[i].MaxLines = 0
		ScrollDropDown_Modern[i].isModern = true
		do
			ScrollDropDown_Modern[i].Animation = CreateFrame("Frame",nil,ScrollDropDown_Modern[i])
			ScrollDropDown_Modern[i].Animation:SetSize(1,1)
			ScrollDropDown_Modern[i].Animation:SetPoint("CENTER")
			ScrollDropDown_Modern[i].Animation.P = 0
			ScrollDropDown_Modern[i].Animation.parent = ScrollDropDown_Modern[i]
			ScrollDropDown_Modern[i].Animation:SetScript("OnUpdate",function(self,elapsed)
				self.P = self.P + elapsed
				local P = self.P
				if P > 2.5 then
					P = P % 2.5
					self.P = P
				end
				local color = P <= 1 and P / 2 or P <= 1.5 and 0.5 or (2.5 - P)/2
				local parent = self.parent
				parent.BorderTop:SetColorTexture(color,color,color,1)
				parent.BorderLeft:SetColorTexture(color,color,color,1)
				parent.BorderBottom:SetColorTexture(color,color,color,1)
				parent.BorderRight:SetColorTexture(color,color,color,1)
			end)
		end
	end
		
	ELib.ScrollDropDown.DropDownList = ScrollDropDown_Modern
	
	do
		local function CheckButtonClick(self)
			local parent = self:GetParent()
			self:GetParent():GetParent().List[parent.id].checkState = self:GetChecked()
			if parent.checkFunc then
				parent.checkFunc(parent,self:GetChecked())
			end
		end
		local function CheckButtonOnEnter(self)
			UIDropDownMenu_StopCounting(self:GetParent():GetParent())
		end
		local function CheckButtonOnLeave(self)
			UIDropDownMenu_StartCounting(self:GetParent():GetParent())
		end
		function ELib.ScrollDropDown.CreateButton(i,level)
			level = level or 1
			local dropDown = ELib.ScrollDropDown.DropDownList[level]
			if dropDown.Buttons[i] then
				return
			end
			dropDown.Buttons[i] = ELib:Template("ExRTDropDownMenuButtonTemplate",dropDown)
			dropDown.Buttons[i]:SetPoint("TOPLEFT",8,-8 - (i-1) * 16)
			dropDown.Buttons[i].NormalText:SetMaxLines(1) 
			
			dropDown.Buttons[i].checkButton = ELib:Template("ExRTCheckButtonModernTemplate",dropDown.Buttons[i])
			dropDown.Buttons[i].checkButton:SetPoint("LEFT",1,0)
			dropDown.Buttons[i].checkButton:SetSize(12,12)
			
			dropDown.Buttons[i].radioButton = ELib:Template("ExRTRadioButtonModernTemplate",dropDown.Buttons[i])
			dropDown.Buttons[i].radioButton:SetPoint("LEFT",1,0)
			dropDown.Buttons[i].radioButton:SetSize(12,12)
			dropDown.Buttons[i].radioButton:EnableMouse(false)

			dropDown.Buttons[i].checkButton:SetScript("OnClick",CheckButtonClick)
			dropDown.Buttons[i].checkButton:SetScript("OnEnter",CheckButtonOnEnter)
			dropDown.Buttons[i].checkButton:SetScript("OnLeave",CheckButtonOnLeave)
			dropDown.Buttons[i].checkButton:Hide()
			dropDown.Buttons[i].radioButton:Hide()
			
			dropDown.Buttons[i].Level = level
		end
	end
	
	local function ScrollDropDown_DefaultCheckFunc(self)
		self:Click()
	end
	
	function ELib.ScrollDropDown.ClickButton(self)
		if ELib.ScrollDropDown.DropDownList[1]:IsShown() then
			ELib:DropDownClose()
			return
		end
		local dropDown = nil
		if self.isButton then
			dropDown = self
		else
			dropDown = self:GetParent()
		end
		ELib.ScrollDropDown.ToggleDropDownMenu(dropDown)
		PlaySound("igMainMenuOptionCheckBoxOn")
	end
	
	function ELib.ScrollDropDown:Reload(level)
		for j=1,#ELib.ScrollDropDown.DropDownList do
			if ELib.ScrollDropDown.DropDownList[j]:IsShown() or level == j then
				local val = ELib.ScrollDropDown.DropDownList[j].Position
				local count = #ELib.ScrollDropDown.DropDownList[j].List
				local now = 0
				for i=val,count do
					local data = ELib.ScrollDropDown.DropDownList[j].List[i]
					
					if not data.isHidden then
						now = now + 1
						local button = ELib.ScrollDropDown.DropDownList[j].Buttons[now]
						local text = button.NormalText
						local icon = button.Icon
						local paddingLeft = data.padding or 0
						
						if data.icon then
							icon:SetTexture(data.icon)
							paddingLeft = paddingLeft + 18
							icon:Show()
						else
							icon:Hide()
						end
						
						button:SetNormalFontObject(GameFontHighlightSmallLeft)
						button:SetHighlightFontObject(GameFontHighlightSmallLeft)
						
						if data.colorCode then
							text:SetText( data.colorCode .. (data.text or "") .. "|r" )
						else
							text:SetText( data.text or "" )
						end
						
						text:ClearAllPoints()
						if data.checkable or data.radio then
							text:SetPoint("LEFT", paddingLeft + 16, 0)
						else
							text:SetPoint("LEFT", paddingLeft, 0)
						end
						text:SetPoint("RIGHT", button, "RIGHT", 0, 0)
						text:SetJustifyH(data.justifyH or "LEFT")
						
						if data.checkable then
							button.checkButton:SetChecked(data.checkState)
							button.checkButton:Show()
						else
							button.checkButton:Hide()
						end
						if data.radio then
							button.radioButton:SetChecked(data.checkState)
							button.radioButton:Show()
						else
							button.radioButton:Hide()
						end
						
						local texture = button.Texture
						if data.texture then
							texture:SetTexture(data.texture)
							texture:Show()
						else
							texture:Hide()
						end
						
						if data.subMenu then
							button.Arrow:Show()
						else
							button.Arrow:Hide()
						end
						
						if data.isTitle then
							button:SetEnabled(false)
						else
							button:SetEnabled(true)
						end
						
						button.id = i
						button.arg1 = data.arg1
						button.arg2 = data.arg2
						button.arg3 = data.arg3
						button.arg4 = data.arg4
						button.func = data.func
						button.hoverFunc = data.hoverFunc
						button.leaveFunc = data.leaveFunc
						button.hoverArg = data.hoverArg
						button.checkFunc = data.checkFunc
						
						if not data.checkFunc then
							button.checkFunc = ScrollDropDown_DefaultCheckFunc
						end
						
						button.subMenu = data.subMenu
						button.Lines = data.Lines --Max lines for second level
						
						button.data = data
					
						button:Show()
						
						if now >= ELib.ScrollDropDown.DropDownList[j].LinesNow then
							break
						end
					end
				end
				for i=(now+1),ELib.ScrollDropDown.DropDownList[j].MaxLines do
					ELib.ScrollDropDown.DropDownList[j].Buttons[i]:Hide()
				end
			end
		end
	end
	
	function ELib.ScrollDropDown.UpdateChecks()
		local parent = ELib.ScrollDropDown.DropDownList[1].parent
		if parent.additionalToggle then
			parent.additionalToggle(parent)
		end
		for j=1,#ELib.ScrollDropDown.DropDownList do
			for i=1,#ELib.ScrollDropDown.DropDownList[j].Buttons do
				local button = ELib.ScrollDropDown.DropDownList[j].Buttons[i]
				if button:IsShown() and button.data then
					button.checkButton:SetChecked(button.data.checkState)
				end
			end
		end
	end

	function ELib.ScrollDropDown.Update(self, elapsed)
		if ( not self.showTimer or not self.isCounting ) then
			return
		elseif ( self.showTimer < 0 ) then
			self:Hide()
			self.showTimer = nil
			self.isCounting = nil
		else
			self.showTimer = self.showTimer - elapsed
		end
	end
	
	function ELib.ScrollDropDown.OnClick(self, button, down)
		local func = self.func
		if func then
			func(self, self.arg1, self.arg2, self.arg3, self.arg4)
		end
	end
	function ELib.ScrollDropDown.OnButtonEnter(self)
		local func = self.hoverFunc
		if func then
			func(self,self.hoverArg)
		end
		ELib.ScrollDropDown:CloseSecondLevel(self.Level)
		if self.subMenu then
			ELib.ScrollDropDown.ToggleDropDownMenu(self,2)
		end
	end
	function ELib.ScrollDropDown.OnButtonLeave(self)
		local func = self.leaveFunc
		if func then
			func(self)
		end
	end
	
	function ELib.ScrollDropDown.ToggleDropDownMenu(self,level)
		level = level or 1
		if self.ToggleUpadte then
			self:ToggleUpadte()
		end
		
		if level == 1 then
			ELib.ScrollDropDown.DropDownList = ScrollDropDown_Modern
		end
		for i=level+1,#ELib.ScrollDropDown.DropDownList do
			ELib.ScrollDropDown.DropDownList[i]:Hide()
		end
		local dropDown = ELib.ScrollDropDown.DropDownList[level]
	
		local dropDownWidth = self.Width
		if level > 1 then
			local parent = ELib.ScrollDropDown.DropDownList[1].parent
			dropDownWidth = parent.Width
		end
	
	
		dropDown.List = self.subMenu or self.List
		
		local count = #dropDown.List
		
		local maxLinesNow = self.Lines or count
		
		for i=(dropDown.MaxLines+1),maxLinesNow do
			ELib.ScrollDropDown.CreateButton(i,level)
		end
		dropDown.MaxLines = max(dropDown.MaxLines,maxLinesNow)
		
		for i=1,maxLinesNow do
			dropDown.Buttons[i]:SetSize(dropDownWidth - 16,16)
		end
		dropDown.Position = 1
		dropDown.LinesNow = maxLinesNow
		if self.additionalToggle then
			self.additionalToggle(self)
		end
		dropDown:SetPoint("TOPRIGHT",self,"BOTTOMRIGHT",-16,0)
		dropDown:SetSize(dropDownWidth,16 + 16 * maxLinesNow)
		dropDown:ClearAllPoints()
		if level > 1 then
			dropDown:SetPoint("TOPLEFT",self,"TOPRIGHT",12,8)
		else
			local toggleX = self.toggleX or -16
			local toggleY = self.toggleY or 0
			dropDown:SetPoint("TOPRIGHT",self,"BOTTOMRIGHT",toggleX,toggleY)
		end
		
		dropDown.parent = self
		
		dropDown:Show()
		dropDown:SetFrameLevel(0)
		
		ELib.ScrollDropDown:Reload()
	end
	
	function ELib.ScrollDropDown.CreateInfo(self,info)
		if info then
			self.List[#self.List + 1] = info
		end
		self.List[#self.List + 1] = {}
		return self.List[#self.List]
	end
	
	function ELib.ScrollDropDown.ClearData(self)
		table.wipe(self.List)
		return self.List
	end
	
	function ELib.ScrollDropDown.Close()
		ELib.ScrollDropDown.DropDownList[1]:Hide()
		ELib.ScrollDropDown:CloseSecondLevel()
	end
	function ELib.ScrollDropDown:CloseSecondLevel(level)
		level = level or 1
		for i=(level+1),#ELib.ScrollDropDown.DropDownList do
			ELib.ScrollDropDown.DropDownList[i]:Hide()
		end
	end
	ELib.DropDownClose = ELib.ScrollDropDown.Close
	
	---> End Scroll Drop Down

end
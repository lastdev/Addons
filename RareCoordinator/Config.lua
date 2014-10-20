-- Variables
local i,j = 0,0
local ListLoaded = false
local RareList = {}
local IgnoredRareIDs = {}
local backdrop = {	bgFile = "", 
					edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
					tile = true, tileSize = 16, edgeSize = 16, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 } }
local resetToDefaults = false

-- Functions

local function RCConfig_Load()
	-- The config is handled in the addon itself
	--print("load")
end

local function RCConfig_Okay()
	-- The config is handled in the addon itself
	--print("okay")
end

local function RCConfig_Cancel()
	-- The config is handled in the addon itself
	--print("cancel")
end

local function RCConfig_Defaults()
	-- The config is handled in the addon itself
	--print("defaults")
end

local function RCConfigList_Load()
	local j
	if ListLoaded == false then
		RareList[0] = RC:GetSortedRareNamesAndIDs() --ToDo: Hardcoded 0
		if RareList[0] ~= nil then
			if RCConfigList.tabs.tabs[0] ~= nil then 
				j = 0
				for k,v in pairs(RareList[0]) do
					j = j + 1
					RCConfigList.tabs.tabs[0].rarename[j]:SetText(v.name)
				end
				j = j + 1
				for j = j,58 do
					RCConfigList.tabs.tabs[0].rarename[j]:Hide()
					RCConfigList.tabs.tabs[0].rarename[j].cb:Hide()
				end
				ListLoaded = true
			end
		end
	end
	
	if not resetToDefaults then
		IgnoredRareIDs = RC:GetIgnoredRareIDs()
		j = 0
		for k,v in pairs(RareList[0]) do
			j = j + 1
			if IgnoredRareIDs[v.id] ~= nil then
				RCConfigList.tabs.tabs[0].rarename[j].cb:SetChecked(false)
			else
				RCConfigList.tabs.tabs[0].rarename[j].cb:SetChecked(true)
			end
		end
	else
		resetToDefaults = false
	end
end

local function RCConfigList_Okay()
	local t = {}
	for j = 1,#RareList[0] do
		if not RCConfigList.tabs.tabs[0].rarename[j].cb:GetChecked() then
			table.insert(t, RareList[0][j].id)
		end
	end
	RC:SetIgnoredRareIDs(t)
end

local function RCConfigList_Cancel()
	-- No need to do stuff (for now?!)
end

local function RCConfigList_Defaults()
	for j = 1,#RCConfigList.tabs.tabs[0].rarename do
		RCConfigList.tabs.tabs[0].rarename[j].cb:SetChecked(true)
	end
	resetToDefaults = true
end



local RCConfig = CreateFrame("Frame", "RCConfig", UIParent)
RCConfig.name = "RareCoordinator"
RCConfig.refresh = function(self) RCConfig_Load() end
RCConfig.okay = function(self) RCConfig_Okay() end
RCConfig.cancel = function(self) RConfig_Cancel() end
RCConfig.default = function(self) RCConfig_Defaults() end


RCConfig.heading = RCConfig:CreateFontString("RCconfig.text", nil, "GameFontNormalLarge")
RCConfig.heading:SetPoint("TOPLEFT", "RCConfig", 10, -10)
RCConfig.heading:SetText("RareCoordinator")

RCConfig.description = RCConfig:CreateFontString("RCConfig.description", nil, "GameFontHighlight")
RCConfig.description:SetPoint("TOPLEFT", RCConfig.heading, "BOTTOMLEFT", 0, -10)
RCConfig.description:SetWidth(600)
RCConfig.description:SetJustifyH("LEFT")
RCConfig.description:SetText("You can change general settings in RareCoordinator directly.\nPlease use the cogwheel in the upper left corner of the main window.")

RCConfig.configurelist = CreateFrame("Button", "RCConfig.configurelist", RCConfig, "UIPanelButtonTemplate")
RCConfig.configurelist:SetText("Configure Rare List")
RCConfig.configurelist:SetPoint("TOPLEFT",RCConfig.description, "BOTTOMLEFT", 0, -10)
RCConfig.configurelist:SetWidth(160)
RCConfig.configurelist:SetHeight(20)


local RCConfigList = CreateFrame("Frame", "RCConfigList", RCConfig)
RCConfigList.name = "List"
RCConfigList.parent = "RareCoordinator"
RCConfigList.refresh = function(self) RCConfigList_Load() end
RCConfigList.okay = function(self) RCConfigList_Okay() end
RCConfigList.cancel = function(self) RCConfigList_Cancel() end
RCConfigList.default = function(self) RCConfigList_Defaults() end

RCConfigList.tabs = CreateFrame("Frame", "RCConfigList.tabs", RCConfigList)
RCConfigList.tabs:SetWidth(600)
RCConfigList.tabs:SetHeight(550)
RCConfigList.tabs:SetPoint("TOPLEFT", "RCConfigList", 10, -10)

RCConfigList.tabs.texture = RCConfigList.tabs:CreateTexture()
RCConfigList.tabs.texture:SetTexture(1,1,1,0)
RCConfigList.tabs.texture:SetAllPoints(RCConfigList.tabs)


RCConfigList.tabs.select = CreateFrame("Frame", "RCConfigList.tabs.select", RCConfigList.tabs)
RCConfigList.tabs.select:SetWidth(RCConfigList.tabs:GetWidth())
RCConfigList.tabs.select:SetHeight(20)
RCConfigList.tabs.select:SetPoint("TOPLEFT", "RCConfigList.tabs", 0, 0)

RCConfigList.tabs.select.texture = RCConfigList.tabs.select:CreateTexture()
RCConfigList.tabs.select.texture:SetTexture(0,0,0,0)
RCConfigList.tabs.select.texture:SetAllPoints(RCConfigList.tabs.select)

RCConfigList.tabs.select.tabs = {}
RCConfigList.tabs.tabs = {}
local i = 0 -- ToDo
--for i in 1,#zones do --ToDo
	RCConfigList.tabs.select.tabs[i] = CreateFrame("Button", "RCConfigList.tabs.select.tabs["..i.."]", RCConfigList.tabs, "OptionsFrameTabButtonTemplate")
	--RCConfigList.tabs.select.tabs[i]:SetWidth(100)
	RCConfigList.tabs.select.tabs[i]:SetHeight(RCConfigList.tabs.select:GetHeight())
	RCConfigList.tabs.select.tabs[i]:SetText("Timeless Isle")
	RCConfigList.tabs.select.tabs[i]:SetPoint("TOPLEFT", "RCConfigList.tabs.select", 0, 0)
	--RCConfigList.tabs.select.tabs[i]:SetHitRectInsets(6, 6, 6, 0)
	--RCConfigList.tabs.select.tabs[i]:GetFontString():SetPoint("RIGHT", -12, 0)
	PanelTemplates_TabResize(RCConfigList.tabs.select.tabs[i])
	
    local name = RCConfigList.tabs.select.tabs[i]:GetName()
	
    _G[name.."Left"]:Hide()
    _G[name.."Middle"]:Hide()
    _G[name.."Right"]:Hide()
     
    _G[name.."LeftDisabled"]:Show()
    _G[name.."MiddleDisabled"]:Show()
    _G[name.."RightDisabled"]:Show()

	--RCConfigList.tabs.select.tabs[i].texture = RCConfigList.tabs.select.tabs[i]:CreateTexture()
	--RCConfigList.tabs.select.tabs[i].texture:SetTexture(0.3,0.3,0.3,0.5)
	--RCConfigList.tabs.select.tabs[i].texture:SetAllPoints(RCConfigList.tabs.select.tabs[i])
	--local t = RCConfigList.tabs.select.tabs[i]:CreateTexture(nil, 'OVERLAY')
	--t:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-Spacer]])
	--t:SetPoint('BOTTOMLEFT', RCConfigList.tabs.select, 'BOTTOMRIGHT', -11, -6)
	--t:SetPoint('BOTTOMRIGHT', RCConfigList.tabs.select, 'TOPRIGHT', -16, -(34 + RCConfigList.tabs.select:GetHeight() + 7))

	--local t2 = RCConfigList.tabs.select.tabs[i]:CreateTexture(nil, 'OVERLAY')
	--t2:SetTexture([[Interface\OptionsFrame\UI-OptionsFrame-Spacer]])
	--t2:SetPoint('BOTTOMLEFT', RCConfigList.tabs.select, 'BOTTOMRIGHT', -11, -6)
	--t2:SetPoint('BOTTOMRIGHT', RCConfigList.tabs.select, 'TOPRIGHT', -16, -(34 + RCConfigList.tabs.select:GetHeight() + 11))

	--RCConfigList.tabs.select.tabs[i].header = RCConfigList.tabs.select.tabs[i]:CreateFontString("RCConfigList.tabs.select.tabs["..i.."]", nil, "GameFontNormal")
	--RCConfigList.tabs.select.tabs[i].header:SetPoint("CENTER", RCConfigList.tabs.select.tabs[i])
	--RCConfigList.tabs.select.tabs[i].header:SetText("Timeless Isle")




	RCConfigList.tabs.tabs[i] = CreateFrame("Frame", "RCConfigList.tabs.tabs["..i.."]", RCConfigList.tabs)
	RCConfigList.tabs.tabs[i]:SetWidth(RCConfigList.tabs:GetWidth())
	RCConfigList.tabs.tabs[i]:SetHeight(RCConfigList.tabs:GetHeight()-RCConfigList.tabs.select:GetHeight())
	RCConfigList.tabs.tabs[i]:SetPoint("TOPLEFT", "RCConfigList.tabs", 0, -RCConfigList.tabs.select:GetHeight())

	--RCConfigList.tabs.tabs[i].texture = RCConfigList.tabs.tabs[i]:CreateTexture()
	--RCConfigList.tabs.tabs[i].texture:SetTexture(0.3,0.3,0.3,0.5)
	--RCConfigList.tabs.tabs[i].texture:SetAllPoints(RCConfigList.tabs.tabs[i])
	RCConfigList.tabs.tabs[i]:SetBackdrop(backdrop)


	RCConfigList.tabs.tabs[i].header = RCConfigList.tabs.tabs[i]:CreateFontString("RCConfigList.tabs.tabs["..i.."]", nil, "GameFontNormal")
	RCConfigList.tabs.tabs[i].header:SetPoint("TOPLEFT", RCConfigList.tabs.tabs[i], 10, -10)
	RCConfigList.tabs.tabs[i].header:SetText("Check the boxes of the rares you want to show in the main window.")

	RCConfigList.tabs.tabs[i].rarename = {}
	local j
	for j = 1,58 do
		RCConfigList.tabs.tabs[i].rarename[j] = RCConfigList.tabs.tabs[i]:CreateFontString("RCConfigList.tabs.tabs["..i.."]", nil, "GameFontNormal")
		RCConfigList.tabs.tabs[i].rarename[j]:SetText("Test")

		if j == 1 then
			RCConfigList.tabs.tabs[i].rarename[j]:SetPoint("TOPLEFT", RCConfigList.tabs.tabs[i].header, "BOTTOMLEFT", 20, -5)
		elseif j == 30 then
			RCConfigList.tabs.tabs[i].rarename[j]:SetPoint("TOPLEFT", RCConfigList.tabs.tabs[i].header, "BOTTOMLEFT", 20+RCConfigList.tabs:GetWidth()/2, -5)
		else
			RCConfigList.tabs.tabs[i].rarename[j]:SetPoint("TOPLEFT", RCConfigList.tabs.tabs[i].rarename[j-1], "BOTTOMLEFT", 0, -5)
		end
		RCConfigList.tabs.tabs[i].rarename[j].cb = CreateFrame("CheckButton", "RCConfigList.tabs.tabs["..i.."].rarename["..j.."].cb", RCConfigList.tabs.tabs[i], "ChatConfigCheckButtonTemplate");
		RCConfigList.tabs.tabs[i].rarename[j].cb:SetPoint("RIGHT", RCConfigList.tabs.tabs[i].rarename[j], "LEFT", 0, -1);
	end


--end --ToDo



RCConfig.configurelist:SetScript("OnClick", function(self) InterfaceOptionsFrame_OpenToCategory(RCConfigList) end)


InterfaceOptions_AddCategory(RCConfig)
InterfaceOptions_AddCategory(RCConfigList)
--InterfaceOptionsFrame_OpenToCategory(RCConfigList)
--InterfaceOptionsFrame_OpenToCategory(RCConfigList)


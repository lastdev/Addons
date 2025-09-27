-- Handynotes Worldmap Button by fuba

local AddOnName, AddOn = ...

local IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded
if not IsAddOnLoaded('HandyNotes') then return end

local WorldMapTooltip = WorldMapTooltip or GameTooltip;
local buildver = select(4,GetBuildInfo())
local isClassicWow = buildver < 20000
local isTBCC = (buildver > 20000) and (buildver < 30000)
local isWOTLKC = (buildver > 30000) and (buildver < 40000)
local isCATA = (buildver > 40000) and (buildver < 50000)
local isMOP = (buildver > 50000) and (buildver < 60000)
local isWOD = (buildver > 60000) and (buildver < 70000)
local isLEGION = (buildver > 60000) and (buildver < 70000)
local isBFA = (buildver > 70000) and (buildver < 80000)
local isSL = (buildver > 80000) and (buildver < 90000)
local isRetail = (buildver >= 110000)

local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_WorldMapButton", false);

local iconDefault = [[Interface\AddOns\]] .. AddOnName .. [[\Buttons\Default]];
local iconDisabled = [[Interface\AddOns\]] .. AddOnName .. [[\Buttons\Disabled]];

-- Create the Button for WorldMap Border
local ButtonName = "HandyNotesWorldMapButton"
local btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
btn:RegisterForClicks("AnyUp");
btn:SetText("");

local function SetIconTexture()
	local btn = _G[ButtonName]
	if not btn then return end
	if HandyNotes:IsEnabled() then
		btn:SetNormalTexture(iconDefault);
	else
		btn:SetNormalTexture(iconDisabled);
	end
end

local function SetIconTooltip(ShowTooltip)
	local btn = _G[ButtonName]
	if not btn then return end
	if not WorldMapTooltip then return end
	WorldMapTooltip:Hide();
	WorldMapTooltip:SetOwner(btn, "ANCHOR_BOTTOMLEFT");
	if HandyNotes:IsEnabled() then
		WorldMapTooltip:AddLine(L["TEXT_TOOLTIP_HIDE_ICONS"], nil, nil, nil, nil, 1 );
	else
		WorldMapTooltip:AddLine(L["TEXT_TOOLTIP_SHOW_ICONS"], nil, nil, nil, nil, 1 );
	end
	if ShowTooltip then
		WorldMapTooltip:Show();
	end
end

local function btnOnEnter(self, motion)
	SetIconTexture();
	SetIconTooltip(true);
end

local function btnOnLeave(self, motion)
	SetIconTexture();
	if WorldMapTooltip then
		WorldMapTooltip:Hide();
	end
end

local function IsHandyNotesEnabled()
	return HandyNotes:IsEnabled()
end

local function ToggleHandyNotes(button, ShowTooltip)
	if not HandyNotes then return end
	local db = LibStub("AceDB-3.0"):New("HandyNotesDB", defaults);
	if not db then return end
	local profile = db.profile;
	if not profile then return end
	
	
	if button == "LeftButton" then
		if HandyNotes:IsEnabled() then
			profile.enabled = false
			HandyNotes:Disable();
		else
			profile.enabled = true
			HandyNotes:Enable();
		end
	elseif button == "RightButton" then
		LibStub("AceConfigDialog-3.0"):Open("HandyNotes")
	end
	
	SetIconTexture();
	SetIconTooltip(ShowTooltip);
end

local function btnOnClick(self, button)
	ToggleHandyNotes(button, true)
end

hooksecurefunc(HandyNotes, "OnEnable", function(self)
	SetIconTexture()
end)

hooksecurefunc(HandyNotes, "OnDisable", function(self)
	SetIconTexture()
end)

btn:SetScript("OnClick", btnOnClick);
btn:SetScript("OnEnter", btnOnEnter);
btn:SetScript("OnLeave", btnOnLeave);

-- Hook "WorldMapFrame, OnShow" to set the Button's Position
WorldMapFrame:HookScript("OnShow", function(self)
	local btn = _G[ButtonName]
	if not btn then return end

	local alignmentFrame = _G.WorldMapFrame
	local parent = _G.WorldMapFrame
	local x, y = 0, 0

	-- Set different Values for different Expansions (Client Versions)
	if isClassicWow then
		alignmentFrame = _G.WorldMapFrame.MaximizeMinimizeFrame or _G.WorldMapFrameCloseButton or _G.WorldMapFrame;
		parent = alignmentFrame:GetParent();
		x = 0;
		y = 0;
	elseif isTBCC then
		alignmentFrame = _G.WorldMapFrame.MaximizeMinimizeFrame or _G.WorldMapFrameCloseButton or _G.WorldMapFrame;
		parent = alignmentFrame:GetParent();
		x = 0;
		y = 0;
	elseif isWOTLKC then
		alignmentFrame = _G.WorldMapFrame.MaximizeMinimizeFrame or _G.WorldMapFrameCloseButton or _G.WorldMapFrame;
		parent = alignmentFrame:GetParent();
		x = 0;
		y = 0;
	elseif isCATA then
		alignmentFrame = _G.WorldMapFrame.MaximizeMinimizeFrame.MinimizeButton or _G.WorldMapFrameCloseButton or _G.WorldMapFrame;
		parent = alignmentFrame:GetParent();
		x = 0;
		y = 0;		
	else
		alignmentFrame = _G.WorldMapFrame.BorderFrame.MaximizeMinimizeFrame or _G.WorldMapFrame;
		parent = alignmentFrame:GetParent();
		x = -2;
		y = 0;
	end
	if (not alignmentFrame) or (not parent) then return end
	
	-- Set the Button for the WorldMap Border or Create it it
	
	btn:ClearAllPoints();
	btn:SetPoint("RIGHT", alignmentFrame, "LEFT", x, y);
	btn:SetFrameStrata("HIGH");
	btn:SetSize(16, 16);
	
	if IsAddOnLoaded('Leatrix_Maps') then
		if isClassicWow then
			if LeaMapsDB and (LeaMapsDB["UseDefaultMap"] == "Off") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("RIGHT", WorldMapFrameCloseButton, "LEFT", 0, 0);
				btn:SetFrameStrata(WorldMapFrameCloseButton:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(18, 18);
			end
		elseif isTBCC then
			if LeaMapsDB and (LeaMapsDB["UseDefaultMap"] == "Off") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("RIGHT", WorldMapFrameCloseButton, "LEFT", 0, 0);
				btn:SetFrameStrata(WorldMapFrameCloseButton:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(18, 18);
			end
		elseif isWOTLKC then
			if LeaMapsDB and (LeaMapsDB["UseDefaultMap"] == "Off") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("RIGHT", WorldMapFrameCloseButton, "LEFT", 0, 0);
				btn:SetFrameStrata(WorldMapFrameCloseButton:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(18, 18);
			end
		elseif isCATA then
			if LeaMapsDB and (LeaMapsDB["UseDefaultMap"] == "Off") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("RIGHT", WorldMapFrameCloseButton, "LEFT", 0, 0);
				btn:SetFrameStrata(WorldMapFrameCloseButton:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(18, 18);
			end
		else
			-- disabled because Leatrix Maps not Retail is now handled diferent
			--[[
			if LeaMapsDB and (LeaMapsDB["UseDefaultMap"] == "Off") then
				btn = _G[ButtonName] or CreateFrame("Button", ButtonName, WorldMapFrame, "UIPanelButtonTemplate");
				btn:ClearAllPoints();
				btn:SetPoint("TOPLEFT", WorldMapFrame.ScrollContainer, "TOPLEFT", 5, -5);
				btn:SetFrameStrata(WorldMapFrame.ScrollContainer:GetFrameStrata());
				btn:SetFrameLevel(5000);
				btn:SetSize(24, 24);
			end
			]]
		end
	end

	SetIconTexture();
	SetIconTooltip(false);
	
	btn:Show();
	
end)


----------------------------------------------------------------------
-- Add Worldmap Filter Button if Client is Retail
----------------------------------------------------------------------

local function AddButtonToWorldMapMenu()
	if (not Menu) then return end
	if (not MenuUtil) then return end

	-- Create checkbox entry
	local button = MenuUtil.CreateCheckbox(L["TEXT_TOOLTIP_SHOW_ICONS"], IsHandyNotesEnabled, ToggleHandyNotes)

	-- Add tooltip
	-- local function OnTooltipShow(tooltipFrame, elementDescription)
	--   GameTooltip_SetTitle(tooltipFrame, L["placeholder text"])
	-- end
	-- button:SetTooltip(OnTooltipShow)

	-- Insert button to menu
	Menu.ModifyMenu("MENU_WORLD_MAP_TRACKING", function(ownerRegion, rootDescription, contextData)
		rootDescription:CreateDivider()
		rootDescription:CreateTitle("Handynotes: WorldmapButton")
		rootDescription:Insert(button)
	end)

end

if isRetail then
	AddButtonToWorldMapMenu()
end
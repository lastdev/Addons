SERVERHOP_VERSION = GetAddOnMetadata("ServerHop", "Version")

-- GUI
HOPADDON_WIDTH = 240
HOPADDON_HEIGHT = 110
HOPADDON_HEIGHTOPTIONS = 100
-- globals
HOPADDON_MAX_RESULTS = 100 -- C_LFGList.GetSearchResults() return count and list, #list is always capped at 100 ):
HOPADDON_PREFIX = "ServerHopMSG"


SendAddonMessage("ServerHopMSG","Kek","RAID")

hopAddon = CreateFrame("Frame",nil,UIParent)
hopAddon:SetPoint("CENTER",0,0)
hopAddon:SetFrameStrata("HIGH")
hopAddon:SetFrameLevel(1)
hopAddon:SetWidth(HOPADDON_WIDTH)
hopAddon:SetHeight(HOPADDON_HEIGHT)
hopAddon:SetBackdrop({bgFile = "Interface\\FrameGeneral\\UI-Background-Rock", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 200, edgeSize = 24, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
hopAddon:SetBackdropColor(1,1,1,1);
hopAddon:SetMovable(true)
hopAddon:EnableMouse(true)
hopAddon:RegisterForDrag("LeftButton")
hopAddon:SetScript("OnDragStart", hopAddon.StartMoving)
hopAddon:SetScript("OnDragStop", hopAddon.StopMovingOrSizing)
hopAddon:Hide()

hopAddon:SetScript("OnHide",function(self)
		HelpPlate_Hide(true)
end)

-- Toggle button attached to LFGListFrame
local toggleButton = CreateFrame("Button",nil,LFGListFrame,"UIPanelButtonTemplate")
toggleButton:SetSize(70,22)
toggleButton:SetPoint("BOTTOM",LFGListFrame,"BOTTOM",-4,5)
toggleButton:SetText(" ServerHop")
toggleButton:SetScript("OnClick", function(btn)
	if hopAddon:IsShown() then
		hopAddon:Hide()
	else
		hopAddon:Show()
	end
end)

toggleButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(HOPADDON_TOGGLE)
	GameTooltip:Show()
end)
toggleButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

function SH_atl(atlasName,size)
	size = tonumber(size) or 0;
	local filename, width, height, txLeft, txRight, txTop, txBottom = GetAtlasInfo(atlasName);

	if (not filename) then return; end

	local atlasWidth = width / (txRight - txLeft);
	local atlasHeight = height / (txBottom - txTop);

	local pxLeft	= atlasWidth	* txLeft;
	local pxRight	= atlasWidth	* txRight;
	local pxTop		= atlasHeight	* txTop;
	local pxBottom	= atlasHeight	* txBottom;
	return string.format("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t", filename, size, size, atlasWidth, atlasHeight, pxLeft, pxRight, pxTop, pxBottom)
end

local success = RegisterAddonMessagePrefix(HOPADDON_PREFIX)
if not success then
	print("[ServerHop] Can't register addon messages.")
end

SLASH_SERVERHOP1 = "/sh" SLASH_SERVERHOP2 = "/serverhop"
SlashCmdList["SERVERHOP"] = function(msg, editbox)
	if hopAddon:IsShown() then
		hopAddon:Hide()
	else
		hopAddon:Show()
	end
	
end

-- MICRO MENU EYE BUTTON SHIFT+CLICK
local oldscript = LFDMicroButton:GetScript("OnClick")
LFDMicroButton:SetScript("OnClick",function(self,btn)
	if IsShiftKeyDown() then
		if hopAddon:IsShown() then
			hopAddon:Hide()
		else
			hopAddon:Show()
		end
	else
		oldscript()
	end
end)

local oldonenter = LFDMicroButton:GetScript("OnEnter")
LFDMicroButton:SetScript("OnEnter",function(self)
	if self.tooltipText == MicroButtonTooltipText(DUNGEONS_BUTTON, "TOGGLEGROUPFINDER") then
		self.tooltipText = LFDMicroButton.tooltipText .."\n\n"..NORMAL_FONT_COLOR_CODE.."SHIFT"..FONT_COLOR_CODE_CLOSE.." + "..SH_atl("NPE_LeftClick",18).." =  ServerHop"
	end
	oldonenter(self)
end)

NEWBIE_TOOLTIP_LFGPARENT = NEWBIE_TOOLTIP_LFGPARENT.."\n\n"..NORMAL_FONT_COLOR_CODE.."SHIFT"..FONT_COLOR_CODE_CLOSE.." + "..SH_atl("NPE_LeftClick",18).." =  ServerHop"


hopAddon.minimap = LibStub("LibDBIcon-1.0")
-- Variables
hopAddon.var = CreateFrame("Frame")
-- Custom Search Declarations
hopAddon.var.addonSearchRequest = false
-- Host mode
hopAddon.var.hosting = false
hopAddon.var.defaultComment = "Hosted by Server Hop addon for hopping."
hopAddon.var.currentZone = 1
hopAddon.var.inOrderHall = false

hopAddon.var.pvpList = {}
hopAddon.var.minimapDB = {
	global = {
		minimap = {hide = false}
	}
}

-- Tables
hopAddon.tables = {}
hopAddon.tables.LeadersBL = {}
hopAddon.tables.TabCategories = {}
hopAddon.tables.Zones = {}
-- Functions
function hopAddon_GatherPvPRealms(region)
	hopAddon.var.pvpList = {}
	for k,v in pairs(hopAddon_Realmlist) do
		if v.region == region and v.pvp == true then
			local blizzname = v.name:gsub("[%s]+", "")
			hopAddon.var.pvpList[blizzname] = true
		end
	end
end

function NotInGroup()
    return (not IsInGroup() and not IsInRaid())
end

function canJoinGroup()
    return (not IsInGroup()) or (UnitIsGroupLeader('player') and not IsInRaid())
end

function hopAddon_GetRealm(region, name)
	for index, info in pairs(hopAddon_Realmlist) do
		if info.region == region and info.name == name then
			return info;
		end
	end
	
	return nil;
end


function SH_AddAlphaAnimation(anim,child,delay,dur,order,from,to)
	local a = anim:CreateAnimation("ALPHA")
	a:SetChildKey(child) 
	a:SetStartDelay(delay)
	a:SetDuration(dur)
	a:SetOrder(order)
	a:SetFromAlpha(from)
	a:SetToAlpha(to)
end

function SH_AddTranslationAnimation(anim,child,delay,dur,order,x,y)
	local a = anim:CreateAnimation("TRANSLATION")
	a:SetChildKey(child)
	a:SetStartDelay(delay)
	a:SetDuration(dur)
	a:SetOrder(order)
	a:SetOffset(x,y)
end

function SH_AddScaleAnimation(anim,child,delay,dur,order,x,y)
	local a = anim:CreateAnimation("SCALE")
	a:SetChildKey(child)
	a:SetStartDelay(delay)
	a:SetDuration(dur)
	a:SetOrder(order)
	a:SetScale(x,y)
end

function hopAddon:GetZoneList()
	for i=1,500 do
		local name,subname,cat = C_LFGList.GetActivityInfo(i)
		if cat == 1 then
			table.insert(hopAddon.tables.Zones,i)
		end
	end
end

function hopAddon:GetMyZoneID()
	-- remove garrisons
	if C_Garrison.IsPlayerInGarrison(LE_GARRISON_TYPE_7_0) or C_Garrison.IsPlayerInGarrison(LE_GARRISON_TYPE_6_0) then hopAddon.var.inOrderHall = true return 1 end
	
	for k,v in pairs(hopAddon.tables.Zones) do
		if C_LFGList.GetActivityInfoExpensive(v) then
			return v
		end
	end

	-- no such zone - return 1
	return 1
end

-- Got from LFGList.lua
function hopAddon_AddToTabCategory(self, tabCategory)
	self.tabCategory = tabCategory;
	local cat = hopAddon.tables.TabCategories[tabCategory];
	if ( not cat ) then
		cat = {};
		hopAddon.tables.TabCategories[tabCategory] = cat;
	end
	self.tabCategoryIndex = #cat+1;
	cat[self.tabCategoryIndex] = self;
end

function hopAddon_OnTabPressed(self)
	if ( self.tabCategory ) then
		local offset = IsShiftKeyDown() and -1 or 1;
		local cat = hopAddon.tables.TabCategories[self.tabCategory];
		if ( cat ) then
			--It's times like this when I wish Lua was 0-based...
			cat[((self.tabCategoryIndex - 1 + offset + #cat) % #cat) + 1]:SetFocus();
		end
	end
end


local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...
	if type(text) == "string" and text:match("sehopW") and not IsModifiedClick() then
		hopAddon:Show()
	else
		return origChatFrame_OnHyperlinkShow(...)
	end
end

function hopAddon:Log(log,msg)
	print("\124cff71d5ff\124HsehopW:123\124h[Server Hop]\124h\124r ["..log.."]: "..msg)
end
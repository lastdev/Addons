-- Merchant frame. Because RR's current configuration is horrible.
-- It's time for a new UI.

local addonName, addonTable = ...;
--local GUI = LibStub("AceGUI-3.0");

local oldEnv = getfenv();
setfenv(1,addonTable);

-- List of items.
local items = {}
items.length = 0;

-- add item to list
function addItem(text, icon, onclick)
	items[items.length+1].text = text;
	items[items.length+1].icon = icon;
	items[items.length+1].onclick = onclick;
	return items.length+1;
end

merchantFrame = _G.CreateFrame("Frame", "test", UIParent);
merchantFrame:SetWidth(400)
merchantFrame:SetHeight(400)

merchantFrame:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=11,
		right=12,
		top=12,
		bottom=11
	}
})

-- Hook merchantFrame's hide and show methods in order to add an IsHidden method.
merchantFrame.oldHide = merchantFrame.Hide;
merchantFrame.oldShow = merchantFrame.Show;
merchantFrame.merchantHidden = true;

merchantFrame.Hide = function(self,...)
	self:oldHide(...);
	self.merchantHidden = true;
end

merchantFrame.Show = function(self,...)
	self:oldShow(...);
	self.merchantHidden = false;
end

merchantFrame:SetBackdropColor(0.75,0.75,0.75)
merchantFrame:SetBackdropBorderColor(1,1,1)
merchantFrame:SetFrameStrata("DIALOG")
--merchantFrame:SetFrameStrata("BACKGROUND")
merchantFrame:SetPoint("CENTER",0,0)
--merchantFrame:Show()
merchantFrame:Hide()

merchantFrame.IsHidden = function(self)
	if self.merchantHidden ~= nil then
		return self.merchantHidden;
	else
		-- It's hidden at first.
		self.merchantHidden = true;
		return true;
	end
end

merchantFrame.ToggleHide = function(self)
	if self:IsHidden(self) then
		self:Show()
	else
		self:Hide()
	end
end

local tabFrame = _G.CreateFrame("Frame", nil, merchantFrame);
tabFrame:SetWidth(200)
tabFrame:SetHeight(350)

tabFrame:SetBackdropColor(0.75,0.75,0.75)
tabFrame:SetBackdropBorderColor(1,1,1)
tabFrame:SetFrameStrata("DIALOG")
--tabFrame:SetFrameStrata("BACKGROUND")
--tabFrame:SetPoint("CENTER",0,0)
--tabFrame:Show()
tabFrame:SetBackdrop({
	bgFile=[[Interface\Tooltips\UI-Tooltip-Background]],
	edgeFile=[[Interface\Tooltips\UI-Tooltip-Border]],
	tile="true",
	tileSize=32,
	edgeSize=16,
	insets = 
	{
		left=11,
		right=12,
		top=12,
		bottom=11
	}
})

tabFrame:SetBackdropColor(0.75,0.75,0.75)
tabFrame:SetBackdropBorderColor(1,1,1)
tabFrame:SetFrameStrata("DIALOG")
--tabFrame:SetFrameStrata("BACKGROUND")
tabFrame:SetPoint("TOPLEFT",10,-30)
--tabFrame:Show()
--tabFrame:Hide()

local sellTab = _G.CreateFrame("Button", "Sell", tabFrame, "OptionsFrameTabButtonTemplate");
sellTab:SetText("Sell");
sellTab:SetPoint("TOPLEFT",0,22)
--sellTab:

local buyTab = _G.CreateFrame("Button", "Buy", tabFrame, "OptionsFrameTabButtonTemplate");
buyTab:SetText("Buy");
buyTab:SetPoint("TOPLEFT",42,22)

local exceptTab = _G.CreateFrame("Button", "Exceptions", tabFrame, "OptionsFrameTabButtonTemplate");
exceptTab:SetText("Exceptions");
exceptTab:SetPoint("TOPLEFT",82,22)


--------------------------------------------------------------------------------
-- Faux Scrolling

local MySlider = _G.CreateFrame("Slider", "MySliderGlobalName", tabFrame, "OptionsSliderTemplate")
 
-- List frame
 
local listButton = {}

--fontstring = basicFrame:CreateFontString()
--fontstring:SetPoint("TOPLEFT", basicFrame, "TOPLEFT", 22, -22)
--fontstring:SetFontObject(_G.GameFontNormal)
--fontstring:SetText("WARNING: NO TEXT!")
 
for a = 1, 10, 1 do

--	listFrame[a] = tabFrame:CreateFontString()
--	listFrame[a]:SetPoint("TOPLEFT", tabFrame, "TOPLEFT", 22, -22*a)
--	listFrame[a]:SetFontObject(_G.GameFontNormal)
--	listFrame[a]:SetText("WARNING: NO TEXT!")

	listButton[a] = _G.CreateFrame("Button","listButton"..a,tabFrame, "OptionsListButtonTemplate")
	listButton[a]:SetScript("OnClick",function(self, button)
		-- By default, does nothing.
	end)

--	listFrame[a] = _G.CreateFrame("Button", nil, sellTab, "UIPanelButtonTemplate");
--	listFrame[a]:SetBackdrop({
--		bgFile=[[Interface\Tooltips\UI-Tooltip-Background]],
--		edgeFile=[[Interface\Tooltips\UI-Tooltip-Border]],
--		tile="true",
--		tileSize=32,
--		edgeSize=16,
--		insets = 
--		{
--			left=11,
--			right=12,
--			top=12,
--			bottom=11
--		}
--	})
--	listFrame[a]:SetBackdropColor(0.75,0.75,0.75)
--	listFrame[a]:SetBackdropBorderColor(1,1,1)
--	listFrame[a]:SetFrameStrata("DIALOG")
	listButton[a]:SetText("");
	listButton[a]:SetPoint("TOPLEFT",10,-a*30+10)
--	listFrame[a]:SetWidth(220)
--	listFrame[a]:SetHeight(25)
	
	-- Frame for text
--	listFrame[a].font = listFrame[a]:CreateFontString("test" .. a, nil, listFrame[a]);
	--listFrame[a].font
end
 
-- Updates the list to be scrolled at a certain position.
function updateList(position)
	for a = 1, 10, 1 do
		if listButton[a] ~= nil then
			listButton[a]:SetText(items[a+position].text);
			listButton[a]:SetScript("OnClick",items[a+position].onclick);
		end
	end
end

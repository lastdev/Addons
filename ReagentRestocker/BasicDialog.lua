-- Something I just created to show a basic dialog box.

local addonName, addonTable = ...;
--local GUI = LibStub("AceGUI-3.0");

--local oldEnv = getfenv();
setfenv(1,addonTable);

local basicFrame = _G.CreateFrame("Frame", nil, UIParent);
basicFrame:SetWidth(512)
basicFrame:SetHeight(128)

basicFrame:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
	tile="true",
	TileSize=32,
	EdgeSize=32,
	insets = 
	{
		left=11,
		right=12,
		top=12,
		bottom=11
	}
})

basicFrame:SetBackdropColor(0.75,0.75,0.75)
basicFrame:SetBackdropBorderColor(1,1,1)
basicFrame:SetFrameStrata("DIALOG")
--basicFrame:SetFrameStrata("BACKGROUND")
basicFrame:SetPoint("CENTER",0,0)
--basicFrame:Show()
basicFrame:Hide()

local okayButton = _G.CreateFrame("Button", nil, basicFrame, "UIPanelButtonTemplate");
okayButton:SetText("OK");
okayButton:SetWidth(100)
okayButton:SetHeight(20)
okayButton:SetPoint("TOPLEFT", 12, -90);
okayButton:Show();
okayButton:RegisterForClicks("LeftButtonUp");
okayButton:SetScript("OnClick", function (self, button, down)
	basicFrame:Hide()
end)

local cancelButton = _G.CreateFrame("Button", nil, basicFrame, "UIPanelButtonTemplate");
cancelButton:SetText("CANCEL");
cancelButton:SetWidth(100)
cancelButton:SetHeight(20)
cancelButton:SetPoint("TOPLEFT", 124, -90);
cancelButton:Show();
cancelButton:RegisterForClicks("LeftButtonUp");
cancelButton:SetScript("OnClick", function (self, button, down)
	basicFrame:Hide()
end)

local fontstring = basicFrame:CreateFontString()
fontstring:SetPoint("TOPLEFT", basicFrame, "TOPLEFT", 22, -22)
fontstring:SetFontObject(_G.GameFontNormal)
fontstring:SetText("WARNING: NO TEXT!")

function quickDialog(text, okayFunc, cancelFunc, okText, cancelText)
	fontstring:SetText(text);
	
	okayButton:SetScript("OnClick", function (self, button, down, ...)
		okayFunc(...);
		basicFrame:Hide()
		okayButton:SetText("OK")
		cancelButton:SetText("CANCEL");
	end)

	cancelButton:SetScript("OnClick", function (self, button, down, ...)
		cancelFunc(...);
		basicFrame:Hide()
		okayButton:SetText("OK")
		cancelButton:SetText("CANCEL");
	end)
	
	if okText ~= nil then
		okayButton:SetText(okText)
	end

	if okText ~= nil then
		cancelButton:SetText(cancelText)
	end

	basicFrame:Show()
end

-- Attempt to create a new UI - again. Centers on lists, should use tabs.

local addonName, addonTable = ...;
--local GUI = LibStub("AceGUI-3.0");

local oldEnv = getfenv();
setfenv(1,addonTable);
--ReagentRestockerDB=addonTable.ReagentRestockerDB

--------------------------------------------------------------------------------

local currentFilter;

local borderFrame = _G.CreateFrame("ScrollFrame", "RRMerchant", _G["MerchantFrame"]);

--frame.items = {}
--frame.items.length = 0;

borderWidth = 250
borderHeight = 400


borderFrame:SetWidth(borderWidth)
borderFrame:SetHeight(borderHeight)

borderFrame:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\AddOns\ReagentRestocker\RRBorders]],
	--edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=1,
		right=1,
		top=1,
		bottom=1
	}
})

-- Hook frame's hide and show methods in order to add an IsHidden method.
borderFrame.oldHide = borderFrame.Hide;
borderFrame.oldShow = borderFrame.Show;
borderFrame.merchantHidden = true;

borderFrame.Hide = function(self,...)
	self:oldHide(...);
	self.merchantHidden = true;
end

borderFrame.Show = function(self,...)
	dprint("***BORDER FRAME OPENED***")
	showItems()
--	if self.oldshow ~= nil then
		dprint("showing old items")
		self:oldShow(...);
--	end
	dprint("UNHIDING MERCHANT")
	self.merchantHidden = false;
end

borderFrame:SetBackdropColor(0.75,0.75,0.75)
borderFrame:SetBackdropBorderColor(1,1,1)
borderFrame:SetFrameStrata("DIALOG")
--frame:SetFrameStrata("BACKGROUND")
borderFrame:SetPoint("CENTER",0,0)
--frame:Show()
borderFrame:Hide()

borderFrame.IsHidden = function(self)
	if self.merchantHidden ~= nil then
		return self.merchantHidden;
	else
		-- It's hidden at first.
		self.merchantHidden = true;
		return true;
	end
end

borderFrame.ToggleHide = function(self)
	if self:IsHidden(self) then
		self:Show()
	else
		self:Hide()
	end
end

SubscribeWOWEvent("MERCHANT_SHOW", function()
	if ReagentRestockerDB.Options.DisableNewUI ~= true then
		borderFrame:Show();
		borderFrame:SetPoint("TOPLEFT", _G["MerchantFrame"], "TOPRIGHT",0,-30);
	end
end)

SubscribeWOWEvent("MERCHANT_CLOSED", function() borderFrame:Hide() end)

	--self:RegisterEvent("MERCHANT_UPDATE");
	--self:RegisterEvent("MERCHANT_CLOSED");
	--self:RegisterEvent("MERCHANT_SHOW");
	--self:RegisterEvent("GUILDBANK_UPDATE_MONEY");
	--self:RegisterForDrag("LeftButton");

local closeFrame = _G.CreateFrame("Button", "RRMerchantClose", borderFrame, "UIPanelCloseButton");
closeFrame:SetWidth(32)
closeFrame:SetHeight(32)
closeFrame:SetText("X")
closeFrame:SetFrameStrata("DIALOG")
closeFrame:SetPoint("TOPRIGHT", borderFrame, "TOPRIGHT",5,5)
closeFrame:Show();

local titleFrame = _G.CreateFrame("Frame", "RRMerchantTitle", borderFrame);
titleFrame:SetWidth(150)
titleFrame:SetHeight(20)
titleFrame:SetFrameStrata("DIALOG")
titleFrame:SetPoint("TOP", borderFrame, "TOP",5,15)
titleFrame:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\AddOns\ReagentRestocker\RRBorders]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=1,
		right=1,
		top=1,
		bottom=1
	}
})
titleFrame:Show();

local titleText = titleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
titleText:SetPoint("CENTER", titleFrame, "CENTER", 0, 0)
titleText:SetTextColor(.9, .7, 1)
titleText:SetText("Reagent Restocker")


--------------------------------------------------------------------------------
local frame = _G.CreateFrame("ScrollFrame", "RRMerchant", borderFrame);

frame:SetWidth(borderWidth-20)
frame:SetHeight(borderHeight-20)

frame:SetBackdrop({
	--bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	--edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
	tile="true",
	--tileSize=32,
	--edgeSize=32,
	--insets = 
	--{
	--	left=11,
	--	right=12,
	--	top=12,
	--	bottom=11
	--}
})

frame:SetBackdropColor(0.75,0.75,0.75)
frame:SetBackdropBorderColor(1,1,1)
frame:SetFrameStrata("DIALOG")
--frame:SetFrameStrata("BACKGROUND")
frame:SetPoint("CENTER",0,0)
frame:Show()
--frame:Hide()

--------------------------------------------------------------------------------
local scrollFrame = _G.CreateFrame("Frame", "RRMerchantScroll", frame);
scrollFrame:SetHeight(borderHeight)
scrollFrame:SetWidth(borderWidth - 20)

scrollFrame:SetBackdrop({
	bgFile=nil,
	--bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	--edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
	
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

scrollFrame:SetBackdropColor(1,1,1)
scrollFrame:SetFrameStrata("DIALOG")
scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
scrollFrame:Show()

frame:SetScrollChild(scrollFrame)

function addItem()
	local infoType, info1, info2 = _G.GetCursorInfo();
	if (infoType == "item") then
		if currentFilter ~= nil then
			ReagentRestocker:addToListByID(info1,0, currentFilter);
		else
			ReagentRestocker:addToListByID(info1,0, "Buy");
		end
		_G.ClearCursor();
		refreshShoppingList();
		selectTree:RefreshTree();
		showItems(currentFilter)
	elseif(infoType == "merchant") then
		if currentFilter ~= nil then
			ReagentRestocker:addToListByID(getIDFromItemLink(_G.GetMerchantItemLink(info1)),0, currentFilter);
		else
			ReagentRestocker:addToListByID(getIDFromItemLink(_G.GetMerchantItemLink(info1)),0, "Buy");
		end
		_G.ClearCursor();
		refreshShoppingList();
		selectTree:RefreshTree();
		showShoppingItem(getIDFromItemLink(_G.GetMerchantItemLink(info1)));
		showItems(currentFilter)
	else --getIDFromItemLink
		--dprint("Unknown infoType")
		--dprint("infoType: "..infoType)
		--dprint("info1: "..info1)
		--if info2 ~= nil then
		--	dprint("info2: "..info2)
		--end
	end
	
	scrollFrame:SetBackdrop({
		bgFile=nil,
--		bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
		--edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
		
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
end

scrollFrame:SetScript("OnMouseUp", addItem)
scrollFrame:SetScript("OnEnter", function()
	if _G.GetCursorInfo() ~= nil then
		scrollFrame:SetBackdrop({
			bgFile=[[Interface\BUTTONS\CheckButtonHilight]],
			--edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
			
			tile=false,
			tileSize=nil,
			edgeSize=16,
			insets = 
			{
				left=11,
				right=12,
				top=12,
				bottom=11
			}
		})
	end
end)

scrollFrame:SetScript("OnLeave", function()
	if _G.GetCursorInfo() ~= nil then
		scrollFrame:SetBackdrop({
			bgFile=nil,
			--bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
			--edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
			
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
	end
end)


--buyTab:SetScript("OnDragStop", filterBuy)
--buyTab:SetScript("OnReceiveDrag", filterBuy)

--------------------------------------------------------------------------------

local scrollSlider = _G.CreateFrame("Slider", "RRMechtantScroller", frame, "OptionsSliderTemplate")
scrollSlider:SetWidth(10)
scrollSlider:SetHeight(borderHeight-35)
scrollSlider:SetOrientation('VERTICAL')
scrollSlider:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -15)
scrollSlider:SetMinMaxValues(0, 1000)
scrollSlider:SetValue(0)
scrollSlider:SetFrameStrata("DIALOG")
scrollSlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
scrollSlider:SetBackdrop({
  bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
  edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
  tile = true, tileSize = 8, edgeSize = 8,
  insets = { left = 3, right = 3, top = 6, bottom = 6 }})
  
_G.getglobal(scrollSlider:GetName() .. 'Low'):SetText('');
_G.getglobal(scrollSlider:GetName() .. 'High'):SetText('');
_G.getglobal(scrollSlider:GetName() .. 'Text'):SetText('');
  
scrollSlider:Show()

scrollSlider:SetScript("OnValueChanged", function(self)
       frame:SetVerticalScroll(self:GetValue())
 end)
 
scrollFrame:SetScript("OnMouseWheel", function(self, arg1)
	local min, max = scrollSlider:GetMinMaxValues()
	if arg1==1 and scrollSlider:GetValue()-10 > min and scrollSlider:IsVisible() then
		scrollSlider:SetValue(scrollSlider:GetValue()-10);
	elseif arg1==1 and scrollSlider:GetValue()-10 < min and scrollSlider:IsVisible() then
		scrollSlider:SetValue(min);
	elseif arg1==-1 and scrollSlider:GetValue()+10 < max and scrollSlider:IsVisible() then
		scrollSlider:SetValue(scrollSlider:GetValue()+10);
	elseif arg1==-1 and scrollSlider:GetValue()+10 > max and scrollSlider:IsVisible() then
		scrollSlider:SetValue(max);
	end
end)

--------------------------------------------------------------------------------

local buyListFrames = {}
local buyListText = {}
local removeItemButton = {}

local position=1
local itemSpacing = 18 -- spacing between items on list.

function showItems(filter)
	currentFilter = filter
	position = 1
	dprint("--Showing items--");
	--dprint(ReagentRestockerDB);
	
	dprint("removing old frames")
	-- remove any old frames
	for k, v in pairs(buyListFrames) do
		buyListFrames[k]:Hide()
		buyListFrames[k]=nil
		removeItemButton[k]:Hide()
		removeItemButton[k]=nil
	end
	
	dprint("creating UI")
	for k,v in pairs(ReagentRestockerDB.Items) do
		if filter==nil or (v.tags ~=nil and v.tags[filter]~=nil) then
			dprint("KEY: "..k);
			buyListFrames[position]=_G.CreateFrame("Frame", "buyListFrame" .. position, scrollFrame);
			buyListFrames[position]:SetHeight(32)
			buyListFrames[position]:SetWidth(32)
			
			buyListFrames[position]:SetBackdrop({
--				bgFile=[[Interface\BUTTONS\UI-Panel-MinimizeButton-Up]],
				tile="false",
			})
			
			buyListFrames[position]:SetFrameStrata("DIALOG")
			buyListFrames[position]:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", -10, 32-position*itemSpacing-16)
			
			dprint("buy list frame created.")
			
			removeItemButton[position]=_G.CreateFrame("Button", "buyListFrame" .. position, scrollFrame, "UIPanelButtonTemplate");
			dprint("frame created")
			
			removeItemButton[position]:SetHeight(15)
			removeItemButton[position]:SetWidth(65)
			removeItemButton[position]:SetText("REMOVE")

			dprint("setting script")
			removeItemButton[position]:SetScript("OnClick",function(self)
				ReagentRestocker:removeItemFromList(k)
				showItems(currentFilter)
			end);
			dprint("set script")
			
			removeItemButton[position]:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", -20, -position*itemSpacing+2)
			removeItemButton[position]:Show()
			
			dprint("remove item button created.")

--			buyListFrames[position]:SetScript("OnMouseDown",function(self)
--				self:SetBackdrop({
--					bgFile=[[Interface\BUTTONS\UI-Panel-MinimizeButton-Down]],
--					tile="false",
--				})			end);
--			
--			buyListFrames[position]:SetScript("OnEnter",function(self)
--				self:SetBackdrop({
--					bgFile=[[Interface\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
--					tile="false",
--				})			end);
---
--			buyListFrames[position]:SetScript("OnLeave",function(self)
--				self:SetBackdrop({
--					bgFile=[[Interface\BUTTONS\UI-Panel-MinimizeButton-Up]],
--					tile="false",
--				})
--			end);

			
			buyListFrames[position]:Show()
			
			buyListText[position] = buyListFrames[position]:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
			buyListText[position]:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 5, 32-position*itemSpacing-34)
			buyListText[position]:SetTextColor(.9, .7, 1)
			
			
			
			buyListText[position]:SetText(v.item_name)
			dprint("value: ")
			dprint(v)
			buyListText[position]:Show()
			position = position + 1
		end
	end
	
	dprint("setting position")
	
	if position*32 > borderHeight then
		scrollFrame:SetHeight(position*32)
	else
		scrollFrame:SetHeight(borderHeight)
	end

	if position*32-borderHeight > 0 then
		scrollSlider:Show()
		scrollSlider:SetMinMaxValues(0, position*32-borderHeight)
	else
		scrollSlider:Hide()
	end
	
	dprint("returning from call")
end


-- ReagentRestockerDB.

local yAdjust = -15 -- to adjust the Y position of the tabs

-- Adjust tab size
local tabHeight = 30
local tabWidth = 60

--------------------------------------------------------------------------------
local buyTab = _G.CreateFrame("Frame", "RRBuyTab", frame);
buyTab:SetWidth(tabWidth)
buyTab:SetHeight(tabHeight)
buyTab:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\AddOns\ReagentRestocker\RRRightTab]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=1,
		right=1,
		top=1,
		bottom=1
	}
})
buyTab:SetPoint("TOPLEFT",frame,"TOPRIGHT",0,0 + yAdjust)
buyText = buyTab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
buyText:SetPoint("CENTER", buyTab, "CENTER", 0, 0)
buyText:SetTextColor(.9, .7, 1)
buyText:SetText("Buy")

function filterBuy()
	dprint("filter bought items")
	scrollSlider:SetValue(0)
	showItems("Buy")
end
buyTab:SetScript("OnMouseUp", filterBuy)

--buyTab:SetScript("OnDragStop", filterBuy)
--buyTab:SetScript("OnReceiveDrag", filterBuy)

--------------------------------------------------------------------------------
local sellTab = _G.CreateFrame("Frame", "RRSellTab", frame);
sellTab:SetWidth(tabWidth)
sellTab:SetHeight(tabHeight)
sellTab:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\AddOns\ReagentRestocker\RRRightTab]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=1,
		right=1,
		top=1,
		bottom=1
	}
})
sellTab:SetPoint("TOPLEFT",frame,"TOPRIGHT",0,-tabHeight + yAdjust)
sellText = sellTab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
sellText:SetPoint("CENTER", sellTab, "CENTER", 0, 0)
sellText:SetTextColor(.9, .7, 1)
sellText:SetText("Sell")

function filterSell()
	dprint("filter sold items")
	scrollSlider:SetValue(0)
	showItems("Sell")
end
sellTab:SetScript("OnMouseUp", filterSell)
--------------------------------------------------------------------------------
local exceptTab = _G.CreateFrame("Frame", "RRExceptTab", frame);
exceptTab:SetWidth(tabWidth)
exceptTab:SetHeight(tabHeight)
exceptTab:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\AddOns\ReagentRestocker\RRRightTab]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=1,
		right=1,
		top=1,
		bottom=1
	}
})
exceptTab:SetPoint("TOPLEFT",frame,"TOPRIGHT",0,-2*tabHeight + yAdjust)
exceptText = exceptTab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
exceptText:SetPoint("CENTER", exceptTab, "CENTER", 0, 0)
exceptText:SetTextColor(.9, .7, 1)
exceptText:SetText("Exceptions")

function filterExcept()
	dprint("filter exception items")
	scrollSlider:SetValue(0)
	showItems("Exception")
end
exceptTab:SetScript("OnMouseUp", filterExcept)

--------------------------------------------------------------------------------
local allTab = _G.CreateFrame("Frame", "RRAllTab", frame);
allTab:SetWidth(tabWidth)
allTab:SetHeight(tabHeight)
allTab:SetBackdrop({
	bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile=[[Interface\AddOns\ReagentRestocker\RRRightTab]],
	tile="true",
	tileSize=32,
	edgeSize=32,
	insets = 
	{
		left=1,
		right=1,
		top=1,
		bottom=1
	}
})
allTab:SetPoint("TOPLEFT",frame,"TOPRIGHT",0,-3*tabHeight + yAdjust)
allText = allTab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
allText:SetPoint("CENTER", allTab, "CENTER", 0, 0)
allText:SetTextColor(.9, .7, 1)
allText:SetText("All")

function filterExcept()
	dprint("filter all items")
	scrollSlider:SetValue(0)
	showItems()
end
allTab:SetScript("OnMouseUp", filterExcept)


local init = false -- should frames be created

hopAddon.tables.searchFavourites = {
{name="Terrorfist",words="terror horropuño terreur pugnocupo punho страха fist кулак -пудовый -pound"},
{name="Vengeance",words="veng rache vend ving отм"},
{name="Deathtalon",words="death talon todeskralle garramuerte serres mort fraffia mortis коготь"},
{name="Doomroller",words="Verdammniswalze doom roller fatalitas Compresseur Rovina Cingolata Rolador Ruinoso пушка смерти"},
{name="Boss Invasions", words="гарнизон нападение босс garrison invasion boss гогг натог маг mag gogg nathog teluur телуур dro gan дро ган гаур gaur lady госпожа плотогонь anni аннигилон"},
}

hopAddon.favouritesFrame = CreateFrame("Frame","hopAddonFavourites",hopAddon)
local f1 = hopAddon.favouritesFrame
f1:Hide()
f1:SetFrameLevel(5)
f1:SetPoint("CENTER",UIParent,0,0)
f1:SetWidth(340)
f1:SetHeight(300)
f1:SetBackdrop({bgFile = "Interface\\FrameGeneral\\UI-Background-Rock", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 500, edgeSize = 24, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
f1:SetBackdropColor(1,1,1,1);

f1:SetMovable(true)
f1:EnableMouse(true)
f1:RegisterForDrag("LeftButton")
f1:SetScript("OnDragStart", f1.StartMoving)
f1:SetScript("OnDragStop", f1.StopMovingOrSizing)



f1.bg = f1:CreateTexture(nil,"OVERLAY")
f1.bg:SetPoint("TOPLEFT", 8,-8)
f1.bg:SetPoint("BOTTOMRIGHT",-8,8)
f1.bg:SetSize(f1:GetWidth(),f1:GetHeight())
f1.bg:SetAtlas("groupfinder-background")

f1.stringHeader = f1:CreateFontString(nil, "OVERLAY", "QuestFont_Shadow_Huge")
f1.stringHeader:SetPoint("BOTTOM",f1,"TOP",0,-30)
f1.stringHeader:SetText(HOPADDON_FAVOURITES)
f1.stringHeader:SetShadowColor(0,0,0,1)


f1.closeButton = CreateFrame("Button", nil, f1,"BrowserButtonTemplate")
f1.closeButton:SetSize(25,25)
f1.closeButton:SetPoint("TOPRIGHT",-6,-6)
f1.closeButton.Icon = f1.closeButton:CreateTexture(nil,"OVERLAY")
f1.closeButton.Icon:SetSize(14,14)
f1.closeButton.Icon:SetPoint("CENTER",0,0)
f1.closeButton.Icon:SetTexture("Interface\\Buttons\\UI-StopButton")
f1.closeButton:SetScript("OnClick", function(btn)
	f1:Hide()
	PlaySound("igMainMenuOptionCheckBoxOn")
end)

f1.scrollframe = CreateFrame("ScrollFrame", "ANewScrollFrame", f1, "UIPanelScrollFrameTemplate");
f1.scrollframe:SetPoint("BOTTOM",0,8)
f1.scrollframe:SetSize(f1:GetWidth()-16,190)

f1.scrollframe.scrollchild = CreateFrame("Frame")
local scrollbarName = f1.scrollframe:GetName()
f1.scrollframe.scrollchild:SetSize(f1.scrollframe:GetWidth(), f1.scrollframe:GetHeight());
f1.scrollframe.scrollchild.frames = {}

f1.scrollframe:SetScrollChild(f1.scrollframe.scrollchild);

f1.scrollframe.scrollupbutton = _G[scrollbarName.."ScrollBarScrollUpButton"];
f1.scrollframe.scrollupbutton:ClearAllPoints();
f1.scrollframe.scrollupbutton:SetPoint("TOPRIGHT", f1.scrollframe, "TOPRIGHT", 0, 0);

f1.scrollframe.scrolldownbutton = _G[scrollbarName.."ScrollBarScrollDownButton"];
f1.scrollframe.scrolldownbutton:ClearAllPoints();
f1.scrollframe.scrolldownbutton:SetPoint("BOTTOMRIGHT", f1.scrollframe, "BOTTOMRIGHT", 0, 0);

f1.scrollframe.scrollbar = _G[scrollbarName.."ScrollBar"];
f1.scrollframe.scrollbar:ClearAllPoints();
f1.scrollframe.scrollbar:SetPoint("TOP", f1.scrollframe.scrollupbutton, "BOTTOM", 0, 4);
f1.scrollframe.scrollbar:SetPoint("BOTTOM", f1.scrollframe.scrolldownbutton, "TOP", 0, -4);

f1.scrollframe.stringAbout = f1.scrollframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
f1.scrollframe.stringAbout:SetPoint("BOTTOM",f1.scrollframe,"TOP",0,30)
f1.scrollframe.stringAbout:SetSize(f1.scrollframe:GetWidth(), 40)
f1.scrollframe.stringAbout:SetText(HOPADDON_FAVDESC)


f1.editFrame = CreateFrame("Frame",nil,f1)
f1.editFrame:Hide()
f1.editFrame:SetPoint("BOTTOM",0,8)
f1.editFrame:SetSize(f1:GetWidth()-16,190)
f1.editFrame.index = 0

f1.editFrame.editBoxName = CreateFrame("EditBox", nil, f1.editFrame, "LFGListEditBoxTemplate")
f1.editFrame.editBoxName:SetPoint("TOP",0,-20)
f1.editFrame.editBoxName:SetSize(f1.editFrame:GetWidth()-40,20)
hopAddon_AddToTabCategory(f1.editFrame.editBoxName, "FavouritesCreation")
f1.editFrame.editBoxName:SetScript("OnTabPressed", hopAddon_OnTabPressed)


f1.editFrame.stringName = f1.editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
f1.editFrame.stringName:SetPoint("BOTTOMLEFT",f1.editFrame.editBoxName,"TOPLEFT",0,0)
f1.editFrame.stringName:SetText(LFG_LIST_TITLE)


f1.editFrame.editBoxWords = CreateFrame("ScrollFrame", "hopfavdescr",f1.editFrame,"InputScrollFrameTemplate")
local f = f1.editFrame.editBoxWords
f:SetSize(f1.editFrame:GetWidth()-40,60)
f:SetPoint("TOP",0,-80)
f.maxLetters = 1024
f.instructions = HOPADDON_ENTERKEYWORDS
f.hideCharCount = true
InputScrollFrame_OnLoad(f)
hopAddon_AddToTabCategory(f.EditBox, "FavouritesCreation")
f.EditBox:SetScript("OnTabPressed", hopAddon_OnTabPressed)



f1.editFrame.stringWords = f1.editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
f1.editFrame.stringWords:SetPoint("BOTTOMLEFT",f,"TOPLEFT",0,5)
f1.editFrame.stringWords:SetText(HOPADDON_KEYWORDS)



f1.editFrame.buttonSave = CreateFrame("Button", nil, f1.editFrame, "UIGoldBorderButtonTemplate")
f1.editFrame.buttonSave:SetPoint("BOTTOM",f1.editFrame,"TOP",0,4)
f1.editFrame.buttonSave:SetSize(100,22)
f1.editFrame.buttonSave:SetText(APPLY)

f1.editFrame.buttonCancel = CreateFrame("Button", nil, f1.editFrame, "UIGoldBorderButtonTemplate")
f1.editFrame.buttonCancel:SetPoint("LEFT",f1.editFrame.buttonSave,"RIGHT",4,0)
f1.editFrame.buttonCancel:SetSize(100,22)
f1.editFrame.buttonCancel:SetText(CANCEL)
f1.editFrame.buttonCancel:SetScript("OnClick",function(btn)
	f1.editFrame:Hide()
	f1.scrollframe:Show()
end)

f1.editFrame.buttonDelete = CreateFrame("Button", nil, f1.editFrame, "UIGoldBorderButtonTemplate")
f1.editFrame.buttonDelete:SetPoint("BOTTOM",0,0)
f1.editFrame.buttonDelete:SetSize(100,22)
f1.editFrame.buttonDelete:SetText(DELETE)


local addNewButton = CreateFrame("Button", nil, f1.scrollframe, "UIGoldBorderButtonTemplate")
f1.scrollframe.buttonAdd = addNewButton
addNewButton:SetPoint("BOTTOM",f1.scrollframe,"TOP",0,4)
addNewButton:SetSize(100,22)
addNewButton:SetText(ADD)
addNewButton:SetScript("OnClick",function(btn)
	f1.scrollframe:Hide()
	f1.editFrame.index = 0
	f1.editFrame.editBoxName:SetText("")
	f1.editFrame.editBoxWords.EditBox:SetText("")
	f1.editFrame.buttonDelete:Hide()
	f1.editFrame:Show()
end)



local function MakeScrollObject(index)
	local frame = CreateFrame("Button", nil, f1.scrollframe.scrollchild)
	local height = 30
	local text = hopAddon.tables.searchFavourites[index]
	
	frame:SetSize(f1.scrollframe.scrollchild:GetWidth()-28,height)
	frame:SetPoint("TOPLEFT",f1.scrollframe.scrollchild,10,-(height+5)*(index-1))

	frame.bg = frame:CreateTexture(nil,"OVERLAY")
	frame.bg:SetPoint("TOPLEFT", 0,0)
	frame.bg:SetPoint("BOTTOMRIGHT",0,0)
	frame.bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	
	local highlightTexture = frame:CreateTexture()
	highlightTexture:SetPoint("TOPLEFT",-10,10)
	highlightTexture:SetPoint("BOTTOMRIGHT",0,-10)
	highlightTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
	frame:SetHighlightTexture(highlightTexture,"ADD")
	
	frame.stringName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.stringName:SetSize(0,14)
	frame.stringName:SetPoint("TOPLEFT",5,-4)
	frame.stringName:SetJustifyH("LEFT")
	frame.stringName:SetText(text.name)

	frame.stringKeywords = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	frame.stringKeywords:SetSize(frame:GetSize()-34,14)
	frame.stringKeywords:SetPoint("BOTTOMLEFT",10,0)
	frame.stringKeywords:SetJustifyH("LEFT")
	frame.stringKeywords:SetJustifyV("TOP")
	frame.stringKeywords:SetText(text.words)

	local button = CreateFrame("Button",nil,frame,"BrowserButtonTemplate")
	button:SetSize(25,25)
	button:SetPoint("RIGHT",0,0)
	button.Icon = button:CreateTexture("butOptionsTex","OVERLAY")
	button.Icon:SetSize(14,14)
	button.Icon:SetPoint("CENTER",0,0)
	button.Icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
	
	button:SetScript("OnClick", function(btn)
		f1.scrollframe:Hide()
		f1.editFrame.index = index
		f1.editFrame.editBoxName:SetText(hopAddon.tables.searchFavourites[index].name)
		f1.editFrame.editBoxWords.EditBox:SetText(hopAddon.tables.searchFavourites[index].words)
		f1.editFrame.buttonDelete:Show()
		f1.editFrame:Show()
		PlaySound("igMainMenuOptionCheckBoxOn")
	end)
	
	frame:SetScript("OnClick", function(btn)
		local newText = hopAddon.tables.searchFavourites[index].words
		if IsShiftKeyDown() then
			newText = hopAddon.searchFrame.searchBox:GetText().." "..newText
		end
		
		hopAddon.searchFrame.searchBox:SetText(newText)
		hopAddon_searchBox_OnEnter(hopAddon.searchFrame.searchBox)
		PlaySound("igMainMenuOptionCheckBoxOn")
	end)
	table.insert(f1.scrollframe.scrollchild.frames,frame)	
end



local function UpdateFrames()
	for i=1,#f1.scrollframe.scrollchild.frames do
		f1.scrollframe.scrollchild.frames[i]:Hide()
	end

	for i=1,#hopAddon.tables.searchFavourites do
		f1.scrollframe.scrollchild.frames[i].stringName:SetText(hopAddon.tables.searchFavourites[i].name)
		f1.scrollframe.scrollchild.frames[i].stringKeywords:SetText(hopAddon.tables.searchFavourites[i].words)
		f1.scrollframe.scrollchild.frames[i]:Show()
	end
end


f1.editFrame.buttonSave:SetScript("OnClick",function(btn)
	if f1.editFrame.index == 0 then
		local t = {}
		t.name = f1.editFrame.editBoxName:GetText()
		t.words = f1.editFrame.editBoxWords.EditBox:GetText()
		table.insert(hopAddon.tables.searchFavourites,t)
		if #hopAddon.tables.searchFavourites > #f1.scrollframe.scrollchild.frames then
			MakeScrollObject(#hopAddon.tables.searchFavourites)
		else
			UpdateFrames()
		end
	else
		hopAddon.tables.searchFavourites[f1.editFrame.index].name = f1.editFrame.editBoxName:GetText()
		hopAddon.tables.searchFavourites[f1.editFrame.index].words = f1.editFrame.editBoxWords.EditBox:GetText()
		UpdateFrames()
	end
	f1.editFrame:Hide()	
	f1.scrollframe:Show()
end)

f1.editFrame.buttonDelete:SetScript("OnClick",function(btn)
	table.remove(hopAddon.tables.searchFavourites,f1.editFrame.index)
	UpdateFrames()
	f1.editFrame:Hide()
	f1.scrollframe:Show()
end)

hopAddon.searchFrame.buttonFavourites = CreateFrame("Button", nil, hopAddon.searchFrame)
hopAddon.searchFrame.buttonFavourites:SetSize(18,18)
hopAddon.searchFrame.buttonFavourites:SetPoint("LEFT",hopAddon.searchFrame.searchBox,"RIGHT",2,0)
hopAddon.searchFrame.buttonFavourites.icon = hopAddon.searchFrame.buttonFavourites:CreateTexture(nil,"BORDER")
hopAddon.searchFrame.buttonFavourites.icon:SetAllPoints(hopAddon.searchFrame.buttonFavourites)

hopAddon.searchFrame.buttonFavourites.icon:SetTexture("Interface\\Common\\ReputationStar")
hopAddon.searchFrame.buttonFavourites.icon:SetTexCoord(0,0.5,0,0.5)
--hopAddon.searchFrame.buttonFavourites.icon:SetTexture("Interface\\\PetBattles\\PetBattle-StatIcons")
--hopAddon.searchFrame.buttonFavourites.icon:SetTexCoord(0.5,1,0.5,1)

hopAddon.searchFrame.buttonFavourites:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, -20)
	GameTooltip:SetText(HOPADDON_FAVOURITES, 1, 1, 1, true)
	GameTooltip:AddLine(" ");	
	GameTooltip:AddDoubleLine(EDIT,HOPADDON_LMB,0.25, 0.75, 0.25);
	GameTooltip:AddDoubleLine(HOPADDON_QUICKFAVOURITES,HOPADDON_RMB,0.75, 0.25, 0);
	GameTooltip:Show()
end)
hopAddon.searchFrame.buttonFavourites:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local function MakeEntryMenu()
	local menulist = {}
	
	for	i=1,#hopAddon.tables.searchFavourites do
		local entry = {
			text = nil,
			func = nil,
			notCheckable = true
		}
		entry.text = hopAddon.tables.searchFavourites[i].name
		entry.func = function()
			local newText = hopAddon.tables.searchFavourites[i].words
			if IsShiftKeyDown() then
				newText = hopAddon.searchFrame.searchBox:GetText().." "..newText
			end
		
			hopAddon.searchFrame.searchBox:SetText(newText)
			hopAddon_searchBox_OnEnter(hopAddon.searchFrame.searchBox)
			PlaySound("igMainMenuOptionCheckBoxOn")
		end
		table.insert(menulist,entry)
	end
	
	return menulist
end

local drop = CreateFrame("Frame", "ExampleMenuFrame", UIParent, "UIDropDownMenuTemplate")
hopAddon.searchFrame.buttonFavourites:RegisterForClicks("AnyUp")
hopAddon.searchFrame.buttonFavourites:SetScript("OnClick", function(self, button)
	if button == "LeftButton" then
		if f1:IsShown() then
			f1:Hide()
		else
			if not init then
				for i=1,#hopAddon.tables.searchFavourites do MakeScrollObject(i) end
				init = true
			end
			f1:Show()
		end
	end
	if button == "RightButton" then
		EasyMenu(MakeEntryMenu(), drop, self, 0, -2, "MENU",1);
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)
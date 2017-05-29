-- MODULE FOR CREATING NEW LISTING QUICK --

-- holder with fields to create a listing
hopAddon.EntryCreationHolder = CreateFrame("Button",nil,hopAddon)
local frame = hopAddon.EntryCreationHolder
frame:SetSize(230,90)
frame:SetPoint("CENTER",0,-5)
frame:SetBackdrop({bgFile = "Interface\\FrameGeneral\\UI-Background-Rock", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 256, edgeSize = 24, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
frame:SetFrameLevel(13)
frame:Hide()

frame.createGroup = CreateFrame("Button",nil,frame,"UIGoldBorderButtonTemplate")
frame.createGroup:SetSize(25,20)
frame.createGroup:SetPoint("TOPLEFT",193,-50)
frame.createGroup:SetText("Ok")
frame.createGroup.errorText = LFG_LIST_MUST_HAVE_NAME
frame.createGroup:SetMotionScriptsWhileDisabled(true)
frame.createGroup:SetScript("OnEnter", function(self)
	if self.errorText then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.errorText, nil, nil, nil, nil, true)
		GameTooltip:Show()
	end
end)
frame.createGroup:SetScript("OnLeave", GameTooltip_Hide)

frame.createGroup:Disable()

frame.editBoxName = CreateFrame("EditBox", nil, frame, "LFGListEditBoxTemplate")
frame.editBoxName:SetPoint("TOPLEFT",20,-10)
frame.editBoxName:SetSize(170,20)
frame.editBoxName:SetMaxLetters(31)
frame.editBoxName.Instructions:SetText(LFG_LIST_TITLE)

hopAddon_AddToTabCategory(frame.editBoxName, "GroupCreation")
frame.editBoxName:SetScript("OnTabPressed", hopAddon_OnTabPressed)
frame.editBoxName:SetScript("OnTextChanged", function(self)
	InputBoxInstructions_OnTextChanged(self)
	local errorText
	if string.match(self:GetText(), "^%s*(.-)%s*$") == "" then
		errorText = LFG_LIST_MUST_HAVE_NAME
	end
	
	frame.createGroup:SetEnabled(not errorText)
	frame.createGroup.errorText = errorText
end)

frame.editBoxWords = CreateFrame("ScrollFrame", "SHGroupCreatedescr",frame,"InputScrollFrameTemplate")
local f = frame.editBoxWords
f:SetSize(165,35)
f:SetPoint("TOPLEFT",20,-40)
f.maxLetters = 255
f.instructions = LFG_LIST_DETAILS
f.hideCharCount = true
InputScrollFrame_OnLoad(f)
hopAddon_AddToTabCategory(f.EditBox, "GroupCreation")
f.EditBox:SetScript("OnTabPressed", hopAddon_OnTabPressed)

frame.autoCheckBox = CreateFrame("CheckButton","SHGroupCreateAutoAccept",frame,"ChatConfigCheckButtonTemplate")
frame.autoCheckBox:SetHitRectInsets(0,0,0,0)
frame.autoCheckBox:SetPoint("TOPLEFT",195,-9)
frame.autoCheckBox.tooltip = LFG_LIST_AUTO_ACCEPT
frame.autoCheckBox:SetChecked(true)

frame.createGroup:SetScript("OnClick", function(self)
	local descText = frame.editBoxWords.EditBox:GetText()
	if descText == "" then descText = "Listed by Server Hop addon." end
	
	--activity, name,ilevel,honorlevel,voicechat,description,autoinvitebool
	C_LFGList.CreateListing(16,frame.editBoxName:GetText(),0,0,"",descText,frame.autoCheckBox:GetChecked())
	
	frame:Hide()
	frame.editBoxName:SetText("")
	frame.editBoxWords.EditBox:SetText("")
	frame.autoCheckBox:SetChecked(true)
end)


-- ATTACHING TO THE MAIN MODULE --
hopAddon.buttonNewEntry = CreateFrame("Button","groupOnMain",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonNewEntry:SetSize(25,25)
hopAddon.buttonNewEntry:SetPoint("TOPRIGHT",-46,4)
hopAddon.buttonNewEntry.Icon = hopAddon.buttonNewEntry:CreateTexture(nil,"OVERLAY")
hopAddon.buttonNewEntry.Icon:SetSize(10,11)
hopAddon.buttonNewEntry.Icon:SetPoint("CENTER",1,0)
hopAddon.buttonNewEntry.origX = 1
hopAddon.buttonNewEntry.origY = 0
hopAddon.buttonNewEntry.Icon:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-Note")
hopAddon.buttonNewEntry.Icon:SetVertexColor(1,0.82,0)
hopAddon.buttonNewEntry.tooltip = LIST_GROUP
-- override on enter, onhide event is inside template
hopAddon.buttonNewEntry:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT", 0, -25)
	GameTooltip:SetText(button.tooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)

-- toggle group creation modes on click
hopAddon.buttonNewEntry:SetScript("OnClick", function(self,button,down)
	if hopAddon.EntryCreationHolder:IsShown() then
		hopAddon.EntryCreationHolder:Hide()	
	else
		hopAddon.EntryCreationHolder:Show()
	end
end)
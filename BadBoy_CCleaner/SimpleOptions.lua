
do
	BadBoyCCleanerConfigTitle:SetText("BadBoy_CCleaner")

	local ccleanerInput = CreateFrame("EditBox", nil, BadBoyConfig, "InputBoxTemplate")
	ccleanerInput:SetPoint("TOPLEFT", BadBoyCCleanerConfigTitle, "BOTTOMLEFT", 10, -5)
	ccleanerInput:SetAutoFocus(false)
	ccleanerInput:EnableMouse(true)
	ccleanerInput:SetWidth(250)
	ccleanerInput:SetHeight(20)
	ccleanerInput:SetMaxLetters(100)
	ccleanerInput:SetScript("OnEscapePressed", function(frame)
		frame:SetText("")
		frame:ClearFocus()
	end)
	ccleanerInput:SetScript("OnTextChanged", function(frame, changed)
		if changed then
			local msg = (frame:GetText()):lower()
			frame:SetText(msg)
		end
	end)
	ccleanerInput:Show()

	local ccleanerButton = CreateFrame("Button", nil, ccleanerInput, "UIPanelButtonTemplate")
	ccleanerButton:SetWidth(110)
	ccleanerButton:SetHeight(20)
	ccleanerButton:SetPoint("LEFT", ccleanerInput, "RIGHT")
	ccleanerButton:SetText(ADD.."/"..REMOVE)
	ccleanerInput:SetScript("OnEnterPressed", function() ccleanerButton:Click() end)

	local ccleanerScrollArea = CreateFrame("ScrollFrame", nil, BadBoyConfig, "UIPanelScrollFrameTemplate")
	ccleanerScrollArea:SetPoint("TOPLEFT", ccleanerInput, "BOTTOMLEFT", 0, -7)
	ccleanerScrollArea:SetPoint("BOTTOMRIGHT", BadBoyConfig, "BOTTOMRIGHT", -30, 10)

	local ccleanerEditBox = CreateFrame("EditBox", nil, BadBoyConfig)
	ccleanerEditBox:SetMultiLine(true)
	ccleanerEditBox:SetMaxLetters(99999)
	ccleanerEditBox:EnableMouse(false)
	ccleanerEditBox:SetAutoFocus(false)
	ccleanerEditBox:SetFontObject(ChatFontNormal)
	ccleanerEditBox:SetWidth(350)
	ccleanerEditBox:SetHeight(250)
	ccleanerEditBox:Show()
	ccleanerEditBox:SetScript("OnShow", function(frame)
		if type(BADBOY_CCLEANER) == "table" then
			table.sort(BADBOY_CCLEANER)
			local text
			for i=1, #BADBOY_CCLEANER do
				if not text then
					text = BADBOY_CCLEANER[i]
				else
					text = text.."\n"..BADBOY_CCLEANER[i]
				end
			end
			frame:SetText(text or "")
		end
	end)

	ccleanerScrollArea:SetScrollChild(ccleanerEditBox)

	ccleanerButton:SetScript("OnClick", function()
		ccleanerInput:ClearFocus()
		local t = ccleanerInput:GetText()
		if t == "" or t:find("^ *$") then ccleanerInput:SetText("") return end
		t = t:lower()
		local found
		for i=1, #BADBOY_CCLEANER do
			if BADBOY_CCLEANER[i] == t then found = i end
		end
		if found then
			table.remove(BADBOY_CCLEANER, found)
		else
			table.insert(BADBOY_CCLEANER, t)
		end
		table.sort(BADBOY_CCLEANER)
		local text
		for i=1, #BADBOY_CCLEANER do
			if not text then
				text = BADBOY_CCLEANER[i]
			else
				text = text.."\n"..BADBOY_CCLEANER[i]
			end
		end
		ccleanerEditBox:SetText(text or "")
		ccleanerInput:SetText("")
	end)

	local ccleanerBackdrop = BadBoyConfig:CreateTexture()
	ccleanerBackdrop:SetPoint("TOPLEFT", ccleanerInput, "BOTTOMLEFT", -5, -5)
	ccleanerBackdrop:SetPoint("BOTTOMRIGHT", BadBoyConfig, "BOTTOMRIGHT", -27, 5)
	ccleanerBackdrop:SetColorTexture(0, 0, 0, 0.6)
end

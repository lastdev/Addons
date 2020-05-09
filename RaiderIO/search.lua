local addonName, ns = ...

-- widget references
local Frame
local RegionEditBox
local RealmEditBox
local NameEditBox
local Tooltip

-- sort regions, realms or names
local function SortReturn(a, b)
	return a.name < b.name
end

-- Search region for activated provider
local function GetRegions(text, maxResults, cursorPosition)
	text = text:lower()

	local temp = {}
	local unique = {}
	local count = 0

	for regionName in pairs(ns.dataProvider) do
		if count >= maxResults then
			break
		end

		if not unique[regionName] and regionName:find(text, nil, true) == 1 then
			unique[regionName] = true
			count = count + 1

			temp[count] = {
				name = regionName,
				priority = 7,
			}
		end
	end

	table.wipe(unique)
	table.sort(temp, SortReturn)
	return temp
end

-- searches for realms
local function GetRealms(text, maxResults, cursorPosition)
	local regionName = (RegionEditBox:GetText() and RegionEditBox:GetText() ~= "") and RegionEditBox:GetText() or ns.PLAYER_REGION

	if not ns.dataProvider[regionName] then
		return
	end

	text = text:lower()
	local temp = {}
	local count = 0
	local unique = {}
	local data
	local kl
	for i = 1, 2 do
		if count >= maxResults then
			break
		end
		for _, dataProviderGroup in pairs(ns.dataProvider[regionName]) do
			data = dataProviderGroup["db" .. i]
			if data then
				for k, _ in pairs(data) do
					if count >= maxResults then
						break
					end

					local realmSlug = ns.realmSlugs[k]
					kl = k:lower()
					if not unique[kl] and (kl:find(text, nil, true) == 1 or (realmSlug and realmSlug:find(text, nil, true)))  then
						unique[kl] = true
						count = count + 1
						temp[count] = {
							name = k,
							priority = 7,
						}
					end
				end
			end
		end
	end
	table.wipe(unique)
	table.sort(temp, SortReturn)
	return temp
end

-- searches for character names
local function GetNames(text, maxResults, cursorPosition)
	local regionName = (RegionEditBox:GetText() and RegionEditBox:GetText() ~= "") and RegionEditBox:GetText() or ns.PLAYER_REGION

	if not ns.dataProvider[regionName] then
		return
	end

	text = text:lower()
	local realm = RealmEditBox:GetText()
	if not realm or strlenutf8(realm) < 1 then return end
	local temp = {}
	local rcount = 0
	local data
	local count
	local name
	local namel
	local unique = {}
	for i = 1, 2 do
		if rcount >= maxResults then
			break
		end
		for _, dataProviderGroup in pairs(ns.dataProvider[regionName]) do
			data = dataProviderGroup["db" .. i]
			if data then
				data = data[realm]
				if data then
					count = #data
					for j = 2, count do
						if rcount >= maxResults then
							break
						end
						name = data[j]
						namel = name:lower()
						if not unique[namel] and namel:find(text, nil, true) == 1 then
							rcount = rcount + 1
							unique[namel] = true
							temp[rcount] = {
								name = name,
								priority = 7,
							}
						end
					end
				end
			end
		end
	end
	table.sort(temp, SortReturn)
	return temp
end

-- create own edit box and apply the function wraps
local function CreateEditBox()
	local f = CreateFrame("EditBox", nil, UIParent, "AutoCompleteEditBoxTemplate")
	-- autocomplete
	f.autoComplete = AutoCompleteBox
	f.autoCompleteParams = { include = AUTOCOMPLETE_FLAG_ALL, exclude = AUTOCOMPLETE_FLAG_NONE }
	-- onload
	f:SetFontObject("ChatFontNormal")
	f:SetSize(256, 32)
	f:SetAutoFocus(false)
	f:SetAltArrowKeyMode(true)
	f:SetHistoryLines(32)
	f:SetMaxLetters(32)
	f:SetMaxBytes(256)
	-- background
	f.texLeft = f:CreateTexture(nil, "BACKGROUND")
	f.texLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left2")
	f.texLeft:SetSize(32, 32)
	f.texLeft:SetPoint("LEFT", -16, 0)
	f.texRight = f:CreateTexture(nil, "BACKGROUND")
	f.texRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right2")
	f.texRight:SetSize(32, 32)
	f.texRight:SetPoint("RIGHT", 16, 0)
	f.texMid = f:CreateTexture(nil, "BACKGROUND")
	f.texMid:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Mid2", true)
	f.texMid:SetSize(0, 32)
	f.texMid:SetPoint("TOPLEFT", f.texLeft, "TOPRIGHT", 0, 0)
	f.texMid:SetPoint("TOPRIGHT", f.texRight, "TOPLEFT", 0, 0)
	-- border
	f.texFocusLeft = f:CreateTexture(nil, "BORDER")
	f.texFocusLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorderFocus-Left")
	f.texFocusLeft:SetSize(32, 32)
	f.texFocusLeft:SetPoint("LEFT", -16, 0)
	f.texFocusRight = f:CreateTexture(nil, "BORDER")
	f.texFocusRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorderFocus-Right")
	f.texFocusRight:SetSize(32, 32)
	f.texFocusRight:SetPoint("RIGHT", 16, 0)
	f.texFocusMid = f:CreateTexture(nil, "BORDER")
	f.texFocusMid:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorderFocus-Mid", true)
	f.texFocusMid:SetSize(0, 32)
	f.texFocusMid:SetPoint("TOPLEFT", f.texFocusLeft, "TOPRIGHT", 0, 0)
	f.texFocusMid:SetPoint("TOPRIGHT", f.texFocusRight, "TOPLEFT", 0, 0)
	return f
end

-- create own tooltip widget
local function CreateTooltip()
	local f = CreateFrame("GameTooltip", addonName .. "_SearchTooltip", UIParent, "GameTooltipTemplate")
	return f
end

-- update the tooltip
local function UpdateTooltip(region, realm, name)
	if realm and name and strlenutf8(realm) > 0 and strlenutf8(name) > 0 then
		Tooltip:SetParent(Frame)
		Tooltip:SetOwner(Frame, "ANCHOR_BOTTOM", 0, -8)
		local isShown = ns.ShowTooltipRegion(Tooltip, bit.bor(ns.ProfileOutput.DEFAULT, ns.ProfileOutput.MOD_KEY_DOWN_STICKY, ns.ProfileOutput.ADD_NAME), name, realm, nil, region)
		if not isShown then
			Tooltip:AddLine(ERR_FRIEND_NOT_FOUND, 1, 1, 1, false)
		end
		Tooltip:Show()
		if isShown then
			ns.PROFILE_UI.ShowProfile(name, realm, nil, region, Frame, nil, nil, nil, true)
		end
	else
		Tooltip:Hide()
	end
end

-- search for a character
local function Search(self, query)
	local arg1, arg2 = query:match("^([^%-%s]+)[%-%s+]?(.*)$")
	arg1, arg2 = (arg1 or ""):trim(), (arg2 or ""):trim()
	arg2 = arg2 ~= "" and arg2 or GetNormalizedRealmName()
	local arg2q = GetRealms(arg2, 1)
	if arg2q and arg2q[1] and arg2q[1].name then
		arg2 = arg2q[1].name
	end
	RealmEditBox:SetText(arg2)
	local arg1q = GetNames(arg1, 1)
	if arg1q and arg1q[1] and arg1q[1].name then
		arg1 = arg1q[1].name
	end
	NameEditBox:SetText(arg1)
	UpdateTooltip(ns.PLAYER_REGION, arg2, arg1)
end

-- creates the search widget
local function Init()
	local regionBox = CreateEditBox()
	local realmBox = CreateEditBox()
	local nameBox = CreateEditBox()
	local t = CreateTooltip()

	regionBox.autoCompleteFunction = GetRegions
	regionBox:SetText(ns.PLAYER_REGION)
	realmBox.autoCompleteFunction = GetRealms
	nameBox.autoCompleteFunction = GetNames

	Frame = CreateFrame("Frame", nil, UIParent)
	do
		Frame:Hide()
		Frame:EnableMouse(true)
		Frame:SetFrameStrata("DIALOG")
		Frame:SetToplevel(true)

		Frame:SetSize(310, ns.addonConfig.debugMode and 130 or 100)
		Frame:SetPoint("CENTER")

		Frame:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		})
		Frame:SetBackdropColor(0, 0, 0, 1)

		Frame.header = Frame:CreateFontString(nil, nil, "ChatFontNormal")
		Frame.header:SetPoint("TOPLEFT", 16, -12)
		Frame.header:SetText("Enter realm and character name:")

		Frame:SetMovable(true)
		Frame:RegisterForDrag("LeftButton")
		Frame:SetClampedToScreen(true)
		Frame:SetScript("OnDragStart", function() Frame:StartMoving() end)
		Frame:SetScript("OnDragStop", function() Frame:StopMovingOrSizing() end)

		Frame:SetScript("OnShow", function() UpdateTooltip(regionBox:GetText(), realmBox:GetText(), nameBox:GetText()) end)
		Frame:SetScript("OnHide", function() UpdateTooltip() end)

		Frame.Search = Search
	end

	if ns.addonConfig.debugMode then
		regionBox:SetParent(Frame)
	end
	realmBox:SetParent(Frame)
	nameBox:SetParent(Frame)

	if ns.addonConfig.debugMode then
		regionBox:SetPoint("CENTER")
		realmBox:SetPoint("TOP", regionBox, "BOTTOM", 0, 11)
	else
		realmBox:SetPoint("CENTER")
	end
	nameBox:SetPoint("TOP", realmBox, "BOTTOM", 0, 11)

	local function OnTabPressed(self)
		if self.autoComplete:IsShown() then
			return
		end
		self:ClearFocus()
		if self == regionBox then
			realmBox:SetFocus()
			realmBox:HighlightText()
		elseif self == realmBox then
			nameBox:SetFocus()
			nameBox:HighlightText()
		elseif self == nameBox then
			if ns.addonConfig.debugMode then
				regionBox:SetFocus()
				regionBox:HighlightText()
			else
				realmBox:SetFocus()
				realmBox:HighlightText()
			end
		end
	end

	local function OnEditFocusLost(self)
		self:HighlightText(0, 0)
	end

	local function OnEnterPressed(self)
		if self == regionBox then
			self:ClearFocus()
			realmBox:SetFocus()
			realmBox:HighlightText()
		elseif self == realmBox then
			self:ClearFocus()
			nameBox:SetFocus()
			nameBox:HighlightText()
		elseif self == nameBox then
			self:ClearFocus()
			self:HighlightText(0, 0)
		end
		UpdateTooltip(regionBox:GetText(), realmBox:GetText(), nameBox:GetText())
	end

	local function OnEscapePressed(self)
		self:ClearFocus()
	end

	local function OnTextChanged(self, userInput)
		if not userInput then return end
		local text = self:GetText()
		if text:len() > 0 then
			AutoCompleteEditBox_SetAutoCompleteSource(self, self.autoCompleteFunction)
			AutoComplete_Update(self, text, #text)
		end
	end

	regionBox:HookScript("OnTabPressed", OnTabPressed)
	realmBox:HookScript("OnTabPressed", OnTabPressed)
	nameBox:HookScript("OnTabPressed", OnTabPressed)

	regionBox:HookScript("OnEditFocusLost", OnEditFocusLost)
	realmBox:HookScript("OnEditFocusLost", OnEditFocusLost)
	nameBox:HookScript("OnEditFocusLost", OnEditFocusLost)

	regionBox:HookScript("OnEnterPressed", OnEnterPressed)
	realmBox:HookScript("OnEnterPressed", OnEnterPressed)
	nameBox:HookScript("OnEnterPressed", OnEnterPressed)

	regionBox:HookScript("OnEscapePressed", OnEscapePressed)
	realmBox:HookScript("OnEscapePressed", OnEscapePressed)
	nameBox:HookScript("OnEscapePressed", OnEscapePressed)

	regionBox:HookScript("OnTextChanged", OnTextChanged)
	realmBox:HookScript("OnTextChanged", OnTextChanged)
	nameBox:HookScript("OnTextChanged", OnTextChanged)

	-- references
	RegionEditBox = regionBox
	RealmEditBox = realmBox
	NameEditBox = nameBox
	Tooltip = t

	-- this is required for "/raiderio search" to be able to toggle the dialog
	ns.SEARCH_UI = Frame
end

-- namespace references
ns.SEARCH_INIT = Init

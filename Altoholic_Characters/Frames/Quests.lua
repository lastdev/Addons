local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local isViewValid
local collapsedHeaders

local questSizeColors = {
	[2] = colors.green,
	[3] = colors.yellow,
	[4] = colors.orange,
	[5] = colors.red,
}

local function FormatQuestType(tag, size)
	if questSizeColors[size] then
		return format("%s%s%s (%d)", colors.white, tag, questSizeColors[size], size)
	else
		return format("%s%s", colors.white, tag)
	end
end

addon.Quests = {}

local ns = addon.Quests		-- ns = namespace

function ns:Update()
	local frame = "AltoholicFrameQuests"
	if not _G[frame]:IsVisible() then return end		-- frame is not visible, do nothing
	
	local character = addon.Tabs.Characters:GetAltKey()
	local VisibleLines = 14
	local entry = frame.."Entry"
	
	local DS = DataStore
	local scrollFrame = _G[ frame.."ScrollFrame" ]
	
	if DS:GetQuestLogSize(character) == 0 then
		AltoholicTabCharacters.Status:SetText(L["No quest found for "] .. addon.Tabs.Characters:GetAlt())
		
		for i=1, VisibleLines do					-- Hides all entries of the scrollframe, and updates it accordingly
			_G[ entry..i ]:Hide()
		end

		scrollFrame:Update(VisibleLines, VisibleLines, 18)
		return
	end

	AltoholicTabCharacters.Status:SetText(format("%s|r / %s", DataStore:GetColoredCharacterName(character), QUEST_LOG))
	
	local offset = scrollFrame:GetOffset()
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup

	collapsedHeaders = collapsedHeaders or {}
	if not isViewValid then
		wipe(collapsedHeaders)
		isViewValid = true
	end

	local i=1
	for line = 1, DS:GetQuestLogSize(character) do
		local isHeader, quest, groupSize, money, isComplete = DS:GetQuestLogInfo(character, line)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if isHeader then													-- then keep track of counters
				
				if not collapsedHeaders[line] then
					DrawGroup = true
				else
					DrawGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if isHeader then
				if not collapsedHeaders[line] then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."QuestLinkNormalText"]:SetText(colors.teal .. quest)
				_G[entry..i.."QuestLink"]:SetID(0)
				_G[entry..i.."QuestLink"]:SetPoint("TOPLEFT", 25, 0)
				
				_G[entry..i.."Tag"]:Hide()
				_G[entry..i.."Status"]:Hide()
				_G[entry..i.."Money"]:Hide()
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()
				
				local _, _, level = DS:GetQuestInfo(quest)
				-- quick fix, level may be nil, I suspect that due to certain locales, the quest link may require different parsing.
				level = level or 0
				
				_G[entry..i.."QuestLinkNormalText"]:SetText(colors.white .. "[" .. level .. "] " .. quest)
				_G[entry..i.."QuestLink"]:SetID(line)
				_G[entry..i.."QuestLink"]:SetPoint("TOPLEFT", 15, 0)
				if groupSize then 
					_G[entry..i.."Tag"]:SetText(FormatQuestType("", groupSize))
					_G[entry..i.."Tag"]:Show()
				else
					_G[entry..i.."Tag"]:Hide()
				end
				
				_G[entry..i.."Status"]:Hide()
				if isComplete == 1 then
					_G[entry..i.."Status"]:SetText(colors.green .. COMPLETE)
					_G[entry..i.."Status"]:Show()
				elseif isComplete == -1 then
					_G[entry..i.."Status"]:SetText(colors.red .. FAILED)
					_G[entry..i.."Status"]:Show()
				end
				
				if money then
					_G[entry..i.."Money"]:SetText(addon:GetMoneyString(money))
					_G[entry..i.."Money"]:Show()
				else
					_G[entry..i.."Money"]:Hide()
				end
					
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end 

	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end
	
	scrollFrame:Update(VisibleCount, VisibleLines, 18)
end

function ns:InvalidateView()
	isViewValid = nil
end

function ns:Collapse_OnClick(frame, button)
	local id = frame:GetParent():GetID()
	if id ~= 0 then
		collapsedHeaders[id] = not collapsedHeaders[id]
		ns:Update()
	end
end

function ns:Link_OnEnter(frame)
	local id = frame:GetID()
	if id == 0 then return end

	local DS = DataStore
	local character = addon.Tabs.Characters:GetAltKey()
	local _, link = DS:GetQuestLogInfo(character, id)
	if not link then return end

	local questName, questID, level = DS:GetQuestInfo(link)
	if IsAddOnLoaded("Odyssey") and IsAddOnLoaded("OdysseyQuests") then
		Odyssey:ShowQuestTooltip(frame, questID)
		return
	end
	
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	GameTooltip:SetHyperlink(link);
	GameTooltip:AddLine(" ",1,1,1);
	
	GameTooltip:AddDoubleLine(LEVEL .. ": |cFF00FF9A" .. level, L["QuestID"] .. ": |cFF00FF9A" .. questID);
	
	local player = addon.Tabs.Characters:GetAlt()
	addon:ListCharsOnQuest(questName, player, GameTooltip)
	GameTooltip:Show();
end

function ns:Link_OnClick(frame, button)
	if button == "LeftButton" and IsShiftKeyDown() then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local id = frame:GetID()
			if id == 0 then return end
			
			local character = addon.Tabs.Characters:GetAltKey()
			local _, link = DataStore:GetQuestLogInfo(character, id)
			if link then
				chat:Insert(link)
			end
		end
	end
end

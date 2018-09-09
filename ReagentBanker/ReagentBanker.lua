
--
--  Reagent Banker
--    by Tuhljin
--

ReagentBanker = {}
local L = REAGENTBANKER_STRINGS

local frame = CreateFrame("Frame")
ReagentBanker.Frame = frame
frame:Hide()

local seenBank
local prevContents, awaitingChanges

local REAGENTBANK_ID = ReagentBankFrame:GetID()
local DepositButton = ReagentBankFrame.DespositButton -- Blizzard typo

local LIMIT_LINKS_PER_LINE = 10  --3 --15


--local R, G, B = 1, 0.6, 0.4
local R, G, B = 1, (170 / 255), (128 / 255)

local function chatprint(msg)
  DEFAULT_CHAT_FRAME:AddMessage(msg, R, G, B);
end


local function isModifierKeyHeld(key)
  if (key == 0) then
    return IsAltKeyDown()
  elseif (key == 1) then
    return IsControlKeyDown()
  elseif (key == 2) then
    return IsShiftKeyDown()
  end
  -- If key is set to None (3), it always returns nil.
end


local function doesBagSort(id)
	-- See ContainerFrameFilterDropDown_Initialize in FrameXML\ContainerFrame.lua
	if (id == -1) then
		return not GetBankAutosortDisabled()
	elseif (id == 0) then
		return not GetBackpackAutosortDisabled()
	elseif (id > NUM_BAG_SLOTS) then
		return not GetBankBagSlotFlag(id - NUM_BAG_SLOTS, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP)
	else
		return not GetBagSlotFlag(id, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP)
	end
end

local function setBagSort(id, value)
	-- See ContainerFrameFilterDropDown_Initialize in FrameXML\ContainerFrame.lua
	if (id == -1) then
		SetBankAutosortDisabled(not value)
	elseif (id == 0) then
		SetBackpackAutosortDisabled(not value)
	elseif (id > NUM_BAG_SLOTS) then
		SetBankBagSlotFlag(id - NUM_BAG_SLOTS, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, not value)
	else
		SetBagSlotFlag(id, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, not value)
	end
end

local function makeBagsSort()
	local changed
	for id=0,NUM_BAG_SLOTS do
		if (not doesBagSort(id)) then
			setBagSort(id, true)
			if (not changed) then  changed = {};  end
			changed[#changed+1] = id
		end
	end
	return changed
end


local function getReagentBankContents()
	local tab = {}
	local _, count, itemID
	for slot=1,ReagentBankFrame.size do
		--texture, count, locked, quality, readable, lootable, link, isFiltered, hasNoValue, itemID
		_, count, _, _, _, _, _, _, _, itemID = GetContainerItemInfo(REAGENTBANK_ID, slot)
		if (itemID) then
			--print("GetContainerItemInfo(",REAGENTBANK_ID,",", slot,") => ",count,itemID)
			tab[itemID] = (tab[itemID] or 0) + count
		end
	end
	return tab
end
ReagentBanker.GetReagentBankContents = getReagentBankContents


local preDeposit, postDeposit
do
	local changed

	function preDeposit(ignoreIgnored)
		changed = ignoreIgnored and makeBagsSort() or nil
		if (ReagentBanker_Settings.chatLogDeposits) then
			prevContents = getReagentBankContents()
			awaitingChanges = true
		end
	end

	function postDeposit()
		if (changed) then
			for i,id in ipairs(changed) do
				setBagSort(id, false)
			end
			changed = nil
		end
	end
end

local function depositReaction()
	local newContents = getReagentBankContents()
	local numAdded, added = 0 -- numAdded is the number of item IDs that saw an addition of any size
	for id,count in pairs(newContents) do
		local prev = prevContents[id] or 0
		if (count > prev) then
			if (not added) then  added = {};  end
			added[id] = count - prev
			numAdded = numAdded + 1
		end
	end
	prevContents = nil

	if (numAdded > 0) then
		local numLines, numLeft = 0, numAdded
		local links = {}
		for id,diff in pairs(added) do
			local _, link = GetItemInfo(id)
			links[#links + 1] = diff == 1 and link or L.CHATLOG_DEPOSITED_COUNT:format(link, diff)
			numLeft = numLeft - 1
			if (#links == LIMIT_LINKS_PER_LINE) then
				local s = table.concat(links, L.CHATLOG_DEPOSITED_SEP .. ' ')
				if (numLeft > 0) then  s = s .. L.CHATLOG_DEPOSITED_SEP;  end
				links = {}
				numLines = numLines + 1
				chatprint(numLines == 1 and L.CHATLOG_DEPOSITED:format(s) or "   " .. s)
			end
		end
		if (#links > 0) then
			local s = table.concat(links, L.CHATLOG_DEPOSITED_SEP .. ' ')
			numLines = numLines + 1
			chatprint(numLines == 1 and L.CHATLOG_DEPOSITED:format(s) or "   " .. s)
		end
	end
end


local function OnEvent(self, event, ...)
	if (event == "BANKFRAME_OPENED") then
		if (not IsReagentBankUnlocked()) then  return;  end
		local altTab = isModifierKeyHeld(ReagentBanker_Settings.openTabModifierKey)
		if (ReagentBanker_Settings.reagentTabIsDefault) then  altTab = not altTab;  end

		local deposit = isModifierKeyHeld(ReagentBanker_Settings.depositModifierKey)
		if (ReagentBanker_Settings.autoDeposit) then  deposit = not deposit;  end

		--if (not seenBank or altTab) then
		if (altTab) then
			BankFrame_ShowPanel(BANK_PANELS[BankFrameTab2:GetID()].name)
		elseif (not seenBank) then
			-- If we haven't been to the bank before this session, we need elements of the reagent tab to load in order to prevent an error in
			-- function BankFrameItemButton_Update that happens when we try to make a deposit at this time.
			ReagentBankFrame_OnShow(ReagentBankFrame)
		end

		if (deposit) then
			preDeposit(ReagentBanker_Settings.includeIgnoredAuto)
			DepositReagentBank()
			postDeposit()
		end

		if (not seenBank) then
			seenBank = true
			--[[
			if (not altTab) then
				BankFrame_ShowPanel(BANK_PANELS[BankFrameTab1:GetID()].name)
			end
			--]]
		end

	elseif (event == "PLAYERREAGENTBANKSLOTS_CHANGED") then
		if (awaitingChanges) then
			awaitingChanges = false
			-- Consolidate all PLAYERREAGENTBANKSLOTS_CHANGED events into one reaction:
			C_Timer.After(0, depositReaction) -- 0 seconds because we should receive all the events at once so the function ought to be triggered after all of them are in
		end

	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg1)
	if (arg1 == "ReagentBanker") then
		frame:UnregisterEvent("ADDON_LOADED")
		ReagentBanker.CreateOptions()

		frame:SetScript("OnEvent", OnEvent)
		frame:RegisterEvent("BANKFRAME_OPENED")
		ReagentBanker.UpdateOptionChatLog()
	end
end)


local DepositButton_click_old = DepositButton:GetScript("OnClick")
DepositButton:SetScript("OnClick", function(...)
	preDeposit(ReagentBanker_Settings.includeIgnoredButton)
	DepositButton_click_old(...)
	postDeposit()
end)


--[[
elseif ( event == "PLAYERREAGENTBANKSLOTS_CHANGED" ) then
		local slot = ...;
		BankFrameItemButton_Update(ReagentBankFrame["Item"..(slot)]);
--]]


-- /dump ReagentBankFrame.size
-- ReagentBankFrame["Item"..<#>] == ReagentBankFrameItem<#>

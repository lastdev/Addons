local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local function OnCalendarDataUpdated(frame, event, itemID)
	frame.Calendar:InvalidateView()
	frame:Refresh()
end

local function _Init(frame)
	frame.MenuItem1:SetText(L["Calendar"])
	-- frame.MenuItem2:SetText("Contacts")
	-- frame.MenuItem3:SetText("Tasks")
	-- frame.MenuItem4:SetText("Notes")
	-- frame.MenuItem5:SetText("Mail")
	frame:MenuItem_Highlight(1)
	
	addon:RegisterMessage("DATASTORE_ITEM_COOLDOWN_UPDATED", OnCalendarDataUpdated, frame)
	addon:RegisterMessage("DATASTORE_CALENDAR_SCANNED", OnCalendarDataUpdated, frame)
end

local function _HideAll(frame)
	frame.Calendar:Hide()
	-- frame.Contacts:Hide()
end

local function _Refresh(frame)
	if frame.Calendar:IsVisible() then
		frame.Calendar:Update()
	-- elseif frame.Contacts:IsVisible() then
		-- frame.Contacts:Update()
	end
end

local function _MenuItem_Highlight(frame, id)
	-- highlight the current menu item
	for i = 1, 5 do 
		frame["MenuItem"..i]:UnlockHighlight()
	end
	frame["MenuItem"..id]:LockHighlight()
end

local function _MenuItem_OnClick(frame, id, panel)
	frame:HideAll()
	frame:MenuItem_Highlight(id)

	if panel then
		frame[panel]:Update()
	end
end

addon:RegisterClassExtensions("AltoTabAgenda", {
	Init = _Init,
	HideAll = _HideAll,
	Refresh = _Refresh,
	MenuItem_Highlight = _MenuItem_Highlight,
	MenuItem_OnClick = _MenuItem_OnClick,
})

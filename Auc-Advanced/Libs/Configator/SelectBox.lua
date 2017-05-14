--[[
	SelectBox
	Version: 7.5.5714 (TasmanianThylacine)
	Revision: $Id: SelectBox.lua 396 2015-10-01 16:35:24Z brykrys $
	URL: http://auctioneeraddon.com/dl/

	License:
		This library is free software; you can redistribute it and/or
		modify it under the terms of the GNU Lesser General Public
		License as published by the Free Software Foundation; either
		version 2.1 of the License, or (at your option) any later version.

		This library is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
		Lesser General Public License for more details.

		You should have received a copy of the GNU Lesser General Public
		License along with this library; if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor,
		Boston, MA  02110-1301  USA

	Additional:
		Regardless of any other conditions, you may freely use this code
		within the World of Warcraft game client.
--]]

local LIBRARY_VERSION_MAJOR = "SelectBox"
local LIBRARY_VERSION_MINOR = 5
local lib = LibStub:NewLibrary(LIBRARY_VERSION_MAJOR, LIBRARY_VERSION_MINOR)
if not lib then return end

LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/libs/trunk/Configator/SelectBox.lua $","$Rev: 396 $","5.1.DEV.", 'auctioneer', 'libs')

local NUM_MENU_ITEMS = 15
local SCROLLTIME = 0.2

local _G = _G
local tinsert = tinsert
local type = type

local kit = {}
local buttonKit = {}

local keys, values = {}, {}
function kit:GetItems(setMenu)
	local curpos, curtext
	local current = self.value
	local items = self.items
	if type(items) == "function" then
		items = items()
	end
	if setMenu then
		wipe(keys)
		wipe(values)
	end

	if type(items) == "table" then
		local key, value
		for _, item in ipairs(items) do
			if type(item) == "table" then
				key = item[1]
				value = item[2]
			else
				key = item
				value = item
			end
			if key then
				if setMenu then
					tinsert(keys, key)
					tinsert(values, value)
				end
				if not curpos and key == current then
					curpos = #keys
					curtext = value
				end
			end
		end
	end

	return curpos, curtext
end

function kit:SetWidth(width)
	local fname = self:GetName()
	self:origSetWidth(width + 50)
	self.curWidth = width
	_G[fname.."Middle"]:SetWidth(width)
	_G[fname.."Text"]:SetWidth(width - 25)
	self:UpdateInset()
end

function kit:UpdateInset()
	local leftInset = -2
	if not self.hiddenInput then
		leftInset = 5-self.curWidth
	end
	local fname = self:GetName()
	_G[fname.."Button"]:SetHitRectInsets(leftInset, -2,-2,-2)
end

function kit:SetInputHidden(hide)
	local fname = self:GetName()
	if hide then
		self.hiddenInput = true
		_G[fname.."Left"]:Hide()
		_G[fname.."Middle"]:Hide()
		_G[fname.."Right"]:Hide()
		_G[fname.."Text"]:Hide()
	else
		self.hiddenInput = nil
		_G[fname.."Left"]:Show()
		_G[fname.."Middle"]:Show()
		_G[fname.."Right"]:Show()
		_G[fname.."Text"]:Show()
	end
	self:UpdateInset()
end

function kit:GetHeight()
	local minx,miny,width,height = self:GetBoundsRect()
	return height
end

function kit:GetWidth()
	local minx,miny,width,height = self:GetBoundsRect()
	return width
end

function kit:SetText(text)
	local fname = self:GetName()
	_G[fname.."Text"]:SetText(text)
end

function kit:UpdateValue()
	local _, text = self:GetItems()
	self:SetText(text or "---")
end

function kit:OnClose()
	if (lib.menu.currentBox == self) then
		lib:DoHide()
	end
end

function buttonKit:Open()
	local box = self
	if not box.items then box = self:GetParent() end
	if not box.items then error("Unable to open menu") end

	PlaySound("igMainMenuOptionCheckBoxOn")
	lib.menu:ClearAllPoints()
	lib.menu:SetPoint("TOPLEFT", box, "TOPLEFT", 0, 0)
	lib.menu:SetWidth(box:GetWidth())

	lib.menu.currentBox = box
	lib.menu.cp = nil
	lib.menu.ts = nil
	lib.menu.position = box:GetItems(true) or 1
	lib:DoUpdate()
	lib:DoShow()
end

function lib:Create(name, parent, width, callback, list, current)
	local frame = CreateFrame("Frame", name, parent, "SelectBoxTemplate_v1")
	if (not width) then width = 100 end
	frame.items = list
	frame.value = current
	frame.onsel = callback
	frame.origSetWidth = frame.SetWidth
	frame.button = _G[name.."Button"]

	for k,v in pairs(kit) do
		frame[k] = v
	end
	for k,v in pairs(buttonKit) do
		_G[name.."Button"][k] = v
	end

	frame:SetWidth(width)
	return frame
end

function lib:DoUpdate()
	local key, value, pos, j

	local ts, cp
	if (lib.menu.cp) then
		cp = lib.menu.cp
		ts = lib.menu.ts
	else
		ts = #keys
		cp = lib.menu.position
		cp = max(1, min(cp-7, ts-10))
		lib.menu.cp = cp
		lib.menu.ts = ts
	end

	j = 0
	for i = 1, NUM_MENU_ITEMS do
		pos = cp + i - 1
		if (i==1 and pos > 1) then
			j = j + 1
			lib.menu.buttons[j].index = "prev"
			lib.menu.buttons[j]:SetText("...")
			lib.menu.buttons[j]:Show()
		elseif (i == NUM_MENU_ITEMS and pos < ts) then
			j = j + 1
			lib.menu.buttons[j].index = "next"
			lib.menu.buttons[j]:SetText("...")
			lib.menu.buttons[j]:Show()
		else
			key = keys[pos]
			value = values[pos]
			if (key) then
				j = j + 1
				lib.menu.buttons[j].index = pos
				lib.menu.buttons[j]:SetText(value)
				lib.menu.buttons[j]:Show()
			end
		end
	end
	local total = j
	for i = j+1, NUM_MENU_ITEMS do
		lib.menu.buttons[i]:SetText("")
		lib.menu.buttons[i]:Hide()
	end

	local height = 50
	height = max(height, 42 + (total * 12))

	lib.menu:SetHeight(height)
end

function lib:DoShow()
	lib.menu:SetAlpha(0)
	lib.menu:Show()
	UIFrameFadeIn(lib.menu, 0.15, 0, 1)
end
function lib:DoHide()
	lib.menu:Hide()
end
function lib:DoFade()
	UIFrameFadeOut(lib.menu, 0.25, 1, 0)
	lib.menu.fadeInfo.finishedFunc = lib.DoHide
end

function lib:MouseIn()
	if (self.index == 'prev') then
		lib.menu.scrollTimer = SCROLLTIME
		lib.menu.scrollDir = -1
	elseif (self.index == 'next') then
		lib.menu.scrollTimer = SCROLLTIME
		lib.menu.scrollDir = 1
	end
	lib.menu.outTimer = nil
end
function lib:MouseOut()
	lib.menu.scrollTimer = nil
	lib.menu.outTimer = 0.5
end
function lib:OnUpdate(delay)
	if (lib.menu.scrollTimer ~= nil) then
		lib.menu.scrollTimer = lib.menu.scrollTimer - delay
		if lib.menu.scrollTimer <= 0 then
			lib.menu.scrollTimer = lib.menu.scrollTimer + SCROLLTIME
			lib.menu.cp = max(1, min(lib.menu.ts-9, lib.menu.cp + lib.menu.scrollDir))
			lib:DoUpdate()
		end
	end

	if (not lib.menu.outTimer) then return end
	lib.menu.outTimer = lib.menu.outTimer - delay
	if (lib.menu.outTimer <= 0) then
		lib.menu.outTimer = nil
		lib:DoFade()
	end
end

function lib:OnClick()
	local pos = self.index
	if (type(pos) == 'string') then return end
	lib.menu.currentBox.value = keys[pos]			-- the value for setter callback
	lib.menu.currentBox:SetText(values[pos])		-- the string shown in the UI
	lib.menu.currentBox:onsel(pos, keys[pos], values[pos])
	lib:DoHide()
end

if not lib.menu then
	local menu = CreateFrame("Frame", "SelectBoxMenu", UIParent)
	lib.menu = menu
	menu:Hide()
	menu:SetWidth(120)
	menu:SetHeight(16 * NUM_MENU_ITEMS + 5)
	menu:EnableMouse(true)
	menu:SetFrameStrata("TOOLTIP")
	menu:SetScript("OnEnter", lib.MouseIn)
	menu:SetScript("OnLeave", lib.MouseOut)
	menu:SetScript("OnMouseDown", lib.DoHide)
	menu:SetScript("OnUpdate", lib.OnUpdate)

	menu.back = CreateFrame("Frame", "", lib.menu)
	menu.back:SetPoint("TOPLEFT", lib.menu, "TOPLEFT", 15, -20)
	menu.back:SetPoint("BOTTOMRIGHT", lib.menu, "BOTTOMRIGHT", -15, 10)
	menu.back:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	menu.back:SetBackdropColor(0,0,0, 0.8)

	local buttons = {}
	menu.buttons = buttons
	for i=1, NUM_MENU_ITEMS do
		local l = CreateFrame("Button", "SelectBoxMenuButton"..i, menu.back)
		buttons[i] = l
		if (i == 1) then
			l:SetPoint("TOPLEFT", menu.back, "TOPLEFT", 0,-5)
		else
			l:SetPoint("TOPLEFT", buttons[i-1], "BOTTOMLEFT", 0,0)
		end
		l:SetPoint("RIGHT", menu.back, "RIGHT", 0,0)
		l:SetNormalFontObject (GameFontHighlightSmall)
		l:SetHighlightFontObject(GameFontNormalSmall)
		l:SetHeight(12)
		l:SetText("Line "..i)
		l:SetScript("OnEnter", lib.MouseIn)
		l:SetScript("OnLeave", lib.MouseOut)
		l:SetScript("OnClick", lib.OnClick)
		l:Show()
	end
end

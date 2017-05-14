local MDH = MDH
local QTC = LibStub("LibQTip-1.0")
local _G = _G
local L = MDH.L
local uc = MDH.uc
local UnitName, UnitInRaid = UnitName, UnitInRaid
local UnitIsUnit, UnitInParty = UnitIsUnit, UnitInParty
local UnitCreatureType, UnitUsingVehicle = UnitCreatureType, UnitUsingVehicle
local string, tonumber, unpack, print, table = string, tonumber, unpack, print, table
local type, pairs, setmetatable, getmetatable = type, pairs, setmetatable, getmetatable
local StaticPopup_Show = StaticPopup_Show
local GetNumSubgroupMembers, IsInRaid = GetNumSubgroupMembers, IsInRaid
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory
local InCombatLockdown, IsAddOnLoaded = InCombatLockdown, IsAddOnLoaded

-- GLOBALS: LibStub TipTac ElvUI StaticPopupDialogs

function MDH:trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end

function MDH:CreateLDBObject()
	MDH.dataObject = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("MisdirectionHelper", {
		type = "data source",
		text = MDH:TTText("both"),
		icon = "Interface\\Icons\\Ability_Hunter_Misdirection",
		OnClick = 
			function(frame, button)
				if button == "RightButton" then InterfaceOptionsFrame_OpenToCategory(MDH.optionsFrame)
				elseif button == "LeftButton" then MDH:MDHtarget(button) end
			end,
		OnEnter = 
			function(frame)
				MDH.tooltip = QTC:Acquire("Broker_MisdirectionHelperTooltip", 1, "CENTER")
				MDH.tooltip:SmartAnchorTo(frame)
				MDH.tooltip:SetAutoHideDelay(0.25, frame)
				MDH:MDHShowToolTip()
			end,
		OnLeave = nil,
	})
end

function MDH:validateTarget(unit)
	local t = UnitName(unit)
	local mdt = unit
	if t then if UnitIsUnit(unit, "pet") or UnitInParty(unit) or UnitInRaid(unit) then mdt = t end end
	return mdt
end

function MDH:PopUp(button)
	self.button = button
	StaticPopup_Show("MDH_GET_PLAYER_NAME")
end

function MDH:MDHgetpet()
	local petname = UnitName("pet")
	if petname == _G.UNKNOWN  or (UnitCreatureType("pet") ~= L["Beast"]) or UnitUsingVehicle("player") then petname = self.db.profile.petname end
	self.db.profile.petname = petname
end

function MDH:HexToRGBA(hex)
	local ahex, rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6), string.sub(hex, 7, 8)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, tonumber(ahex, 16)/255
end

function MDH:RGBAToHex(r, g, b, a)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	a = a <= 1 and a >= 0 and a or 0
	return string.format("%.2x%.2x%.2x%.2x", a*255, r*255, g*255, b*255)
end

function MDH:deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then return object
        elseif lookup_table[object] then return lookup_table[object] end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do new_table[_copy(index)] = _copy(value) end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function MDH:checkParty()
	MDH.inParty = (GetNumSubgroupMembers() > 0) and true or false
	MDH.inRaid = IsInRaid()
	if MDH.inParty or MDH.inRaid or UnitInRaid("player") then
		if not MDH.ingroup then
			MDH:ClearTarget("LeftButton")
			MDH:ClearTarget("RightButton")
			MDH.ingroup = true
			print("|cff568bffMisdirection Helper:|r " .. L["Targets reset"])
			if MDH.db.profile.autotank and MDH.inParty then MDH:PartyTank("LeftButton") end
		end
	else 
		MDH.ingroup = nil
		if MDH.db.profile.autopet then
			MDH:ClearTarget("LeftButton")
			MDH:ClearTarget("RightButton")
			MDH:PlayerPet("LeftButton")
			print("|cff568bffMisdirection Helper:r " .. L["Target set to pet"])
		end
	end
end

function MDH:TTText(t)
	local n = self.db.profile.name or ""
	local ts, te, target
	local uname, out
	if t == "left" then ts = 1; te = 1 end
	if t == "right" then ts = 2; te = 2 end
	if t == "both" then ts = 1; te = 2 end
	for target = ts, te do
		if target == 2 then n = self.db.profile.name2 if not n then break end end
		if out then out = out .. ", " end
		if n == "target" then uname = _G.TARGET
		elseif n == "targettarget" then uname = _G.SHOW_TARGET_OF_TARGET_TEXT
		elseif n == "focus" then uname = _G.BINDING_NAME_FOCUSTARGET
		elseif n == "pet" then uname = _G.PET
		elseif n == "" then uname = L["Nobody"]
		else uname = n end
		out = (out or "") .. uname
	end
	return out
end

local function HandlerFunc(arg, button)
    if arg == "b1" then MDH:PartyTank(button)
    elseif arg == "b2" then MDH:MDHtarget(button)
    elseif arg == "b3" then MDH:ToT(button)
	elseif arg == "b4" then MDH:PlayerPet(button)
	elseif arg == "b5" then MDH:PopUp(button)
	elseif arg == "f" then MDH:MDHfocus(button)
	elseif arg == "b6" then InterfaceOptionsFrame_OpenToCategory(MDH.optionsFrame)
	elseif arg == "h" then MDH:MDHHover()
	elseif arg == "c" then MDH:ClearTarget(button) end
end

function MDH:MDHShowToolTip()
	if InCombatLockdown() then return end
	local theme = self.themes[self.db.profile.theme]
	local y
	local tooltip = self.tooltip
	if not tooltip then return end
	if not tooltip.lines then return end
	if not theme then
		self.db.profile.theme = _G.DEFAULT
		theme = _G.DEFAULT
	end
	if IsAddOnLoaded("TipTac") then 
		if not self.tiptacstyled then
			table.insert(TipTac.tipsToModify, tooltip:GetName())
			self.tiptacstyled = true
		end
	else
		tooltip:SetFont(self.fonts[theme.linefont].font)
		tooltip:SetHeaderFont(self.fonts[theme.headerfont].font)
	end
	tooltip:Clear()

    y = tooltip:AddHeader()
	tooltip:SetCell(y, 1, "|c" .. theme.title[5] .. "MisdirectionHelper|r", "CENTER", 1)
    tooltip:SetLineColor(y, theme.title[1], theme.title[2], theme.title[3], theme.title[4])

    y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
    tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

    y = tooltip:AddLine()
	tooltip:SetCell(y, 1, " " .. L["Set To Party Tank"])
	tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("b1", button) end)
    tooltip:SetLineColor(y, theme.group1[1], theme.group1[2],theme.group1[3], theme.group1[4])

    y = tooltip:AddLine()
    tooltip:SetCell(y, 1, " " .. L["Set To Target"])
	tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("b2", button) end)
    tooltip:SetLineColor(y, theme.group1[1], theme.group1[2],theme.group1[3], theme.group1[4])

    y = tooltip:AddLine()
    tooltip:SetCell(y, 1, " " .. L["Set to Target Of Target"])
	tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("b3", button) end)
    tooltip:SetLineColor(y, theme.group1[1], theme.group1[2],theme.group1[3], theme.group1[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, " " .. L["Set to Focus"])
	tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("f", button) end)
	tooltip:SetLineColor(y, theme.group1[1], theme.group1[2],theme.group1[3], theme.group1[4])

	--y = tooltip:AddLine()
	--if MDH.db.profile.target3 then
		--tooltip:SetCell(y, 1, " " .. L["Disable Mouseover"])
	--else
		--tooltip:SetCell(y, 1, " " .. L["Enable Mouseover"])
	--end
	--tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("h", button) end)
	--tooltip:SetLineColor(y, theme.group1[1], theme.group1[2], theme.group1[3], theme.group1[4])
	
    y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	if uc == "HUNTER" then
		y = tooltip:AddLine()
		tooltip:SetCell(y, 1, " " .. L["Set to Your Pet"])
		tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("b4", button) end)
		tooltip:SetLineColor(y, theme.group2[1], theme.group2[2],theme.group2[3], theme.group2[4])
	end

    y = tooltip:AddLine()
    tooltip:SetCell(y, 1, " " .. L["Enter Player Name"])
	tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("b5", button) end)
	tooltip:SetLineColor(y, theme.group2[1], theme.group2[2],theme.group2[3], theme.group2[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, " " .. L["Clear Target"])
	tooltip:SetCellScript(y, 1, "OnMouseDown", function(this, arg, button) HandlerFunc("c", button) end)
	tooltip:SetLineColor(y, theme.group3[1], theme.group3[2],theme.group3[3], theme.group3[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "|c" .. theme.group4[5] .. string.format(L["Left click target: %s"], "|c" .. theme.group4[6] .. self:TTText("left")), "CENTER", 1)
	tooltip:SetLineColor(y, theme.group4[1], theme.group4[2],theme.group4[3], theme.group4[4])

	if self.db.profile.target2 then
		y = tooltip:AddLine()
		tooltip:SetCell(y, 1, "|c" .. theme.group4[5] .. string.format(L["Right click target: %s"], "|c" .. theme.group4[6] .. self:TTText("right")), "CENTER", 1)
		tooltip:SetLineColor(y, theme.group4[1], theme.group4[2],theme.group4[3], theme.group4[4])
	end

	--if MDH.db.profile.target3 then
		--y = tooltip:AddLine()
		--tooltip:SetCell(y, 1, "|c" .. theme.group4[5] .. L["Mouseover Enabled"], "CENTER", 1)
		--tooltip:SetLineColor(y, theme.group4[1], theme.group4[2],theme.group4[3], theme.group4[4])
	--end
	
    y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "", "CENTER", 1)
	tooltip:SetLineColor(y, theme.spacer[1], theme.spacer[2],theme.spacer[3], theme.spacer[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "|c" .. theme.group5[5] .. L["Left Click Each Text To Activate"] .. "|r ", "CENTER", 1)
	tooltip:SetLineColor(y, theme.group5[1], theme.group5[2],theme.group5[3], theme.group5[4])

	y = tooltip:AddLine()
	tooltip:SetCell(y, 1, "|c" .. theme.group5[5] .. L["Right Click For MDH Options"] .. "|r", "CENTER", 1)
    tooltip:SetLineColor(y, theme.group5[1], theme.group5[2],theme.group5[3], theme.group5[4])

	if IsAddOnLoaded("ElvUI") then
		if not self.ttstyled then
			local E, L, V, P, G, DF = unpack(ElvUI)
			local TT = E:GetModule("Tooltip")
			function tooltip:GetUnit(unit) return UnitName("player"), "player" end
			TT:HookScript(tooltip, "OnShow", "SetStyle")
			self.ttstyled = true
		end
	end			
    tooltip:Show()
end

function MDH:ShowError(msg)
	StaticPopupDialogs["MDH_ERROR"] = {
		text = msg,
		button1 = _G.OKAY,
		OnAccept = function(this) this:Hide() end,
		timeout = 0,
		whileDead = 0,
		hideOnEscape = 1,
	}
	StaticPopup_Show("MDH_ERROR")
end

function MDH:ShowExport(val)
	StaticPopupDialogs["MDH_THEME_EXPORT"] = {
		text = L["Export"],
		button1 = _G.OKAY,
		hasEditBox = 1,
		editBoxWidth = 250,
		OnAccept = function(this) this:Hide() end,
		OnShow = function(this) this.editBox:SetText(val) end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	}
	StaticPopup_Show("MDH_THEME_EXPORT")
end

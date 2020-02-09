local addonName, ns = ...

-- micro-optimization for more speed
local band = bit.band
local bor = bit.bor

-- constants
local L = ns.L

-- export button
local ExportButton
do
	ExportButton = CreateFrame("Button", addonName .. "_ExportButton", LFGListFrame)
	ExportButton:SetPoint("BOTTOMRIGHT", ExportButton:GetParent(), "BOTTOM", 4, 6)
	ExportButton:SetSize(16, 16)
	ExportButton.Icon = ExportButton:CreateTexture(nil, "ARTWORK")
	ExportButton.Icon:SetAllPoints()
	ExportButton.Icon:SetMask("Interface\\Minimap\\UI-Minimap-Background")
	ExportButton.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")
	ExportButton.Border = ExportButton:CreateTexture(nil, "BACKGROUND")
	ExportButton.Border:SetPoint("TOPLEFT", -2, 2)
	ExportButton.Border:SetSize(36, 36)
	ExportButton.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	ExportButton.Border:SetVertexColor(.8, .8, .8)
end

-- copy dialog
local StaticPopupName = "RAIDERIO_EXPORTJSON_DIALOG"
do
	_G.StaticPopupDialogs[StaticPopupName] = {
		text = L.EXPORTJSON_COPY_TEXT,
		button2 = CLOSE,
		hasEditBox = true,
		hasWideEditBox = true,
		editBoxWidth = 350,
		preferredIndex = 3,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function() ExportButton.OpenCopyDialog() end,
		OnHide = function() ExportButton.CloseCopyDialog() end,
		OnAccept = nil,
		OnCancel = nil,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	}
end

local TableToJSON
local UpdateCopyDialog
local CanShowCopyDialog
do
	local function IsArray(o)
		if not o[1] then
			return false
		end
		local i
		for k = 1, #o do
			local v = o[k]
			if type(k) ~= "number" then
				return false
			end
			if i and i ~= k - 1 then
				return false
			end
			i = k
		end
		return true
	end

	local function IsMap(o)
		return not not (not IsArray(o) and next(o))
	end

	local function WrapValue(o)
		local t = type(o)
		local s = ""
		if t == "nil" then
			s = "null"
		elseif t == "number" then
			s = o
		elseif t == "boolean" then
			s = o and "true" or "false"
		elseif t == "table" then
			s = TableToJSON(o)
		else
			s = "\"" .. tostring(o) .. "\""
		end
		return s
	end

	function TableToJSON(o)
		if type(o) == "table" then
			local s = ""
			if IsMap(o) then
				s = s .. "{"
				for k, v in pairs(o) do
					s = s .. "\"" .. tostring(k) .. "\":" .. WrapValue(v) .. ","
				end
				if s:sub(-1) == "," then
					s = s:sub(1, -2)
				end
				s = s .. "}"
			else
				s = s .. "["
				for i = 1, #o do
					local v = o[i]
					s = s .. WrapValue(v) .. ","
				end
				if s:sub(-1) == "," then
					s = s:sub(1, -2)
				end
				s = s .. "]"
			end
			return s
		end
		return o
	end

	local RoleNameToBit = {
		TANK = 4,
		HEALER = 2,
		DAMAGER = 1,
		NONE = 0,
	}

	local function GetUnitRole(unit)
		local role = UnitGroupRolesAssigned(unit)
		return RoleNameToBit[role] or RoleNameToBit.NONE
	end

	local function GetQueuedRole(tank, heal, dps)
		local role1 = tank and "TANK" or (heal and "HEALER" or (dps and "DAMAGER"))
		local role2 = (tank and heal and "HEALER") or ((tank or heal) and dps and "DAMAGER")
		local role3 = tank and heal and dps and "DAMAGER"
		local role = RoleNameToBit.NONE
		if role1 == "TANK" or role2 == "TANK" or role3 == "TANK" then
			if band(role, RoleNameToBit.TANK) ~= RoleNameToBit.TANK then
				role = bor(role, RoleNameToBit.TANK)
			end
		end
		if role1 == "HEALER" or role2 == "HEALER" or role3 == "HEALER" then
			if band(role, RoleNameToBit.HEALER) ~= RoleNameToBit.HEALER then
				role = bor(role, RoleNameToBit.HEALER)
			end
		end
		if role1 == "DAMAGER" or role2 == "DAMAGER" or role3 == "DAMAGER" then
			if band(role, RoleNameToBit.DAMAGER) ~= RoleNameToBit.DAMAGER then
				role = bor(role, RoleNameToBit.DAMAGER)
			end
		end
		return role
	end

	local function GetJSON()
		local data = {
			["activity"] = 0,
			["region"] = ns.PLAYER_REGION
		}

		local prefix, x, y, i
		if IsInRaid() then
			prefix, x, y = "raid", 1, GetNumGroupMembers()
		elseif IsInGroup() then
			prefix, x, y = "party", 0, GetNumGroupMembers() - 1
		end
		if prefix then
			data.group = {}
			i = 0
			for j = x, y do
				local unit = j == 0 and "player" or prefix .. j
				local name, realm = ns.GetNameAndRealm(unit)
				if name then
					i = i + 1
					data.group[i] = format("%d-%s-%s", GetUnitRole(unit), name, ns.GetRealmSlug(realm))
				end
			end
		end

		local activityEntryInfo = C_LFGList.GetActiveEntryInfo()

		if activityEntryInfo and activityEntryInfo.activityID then
			data.activity = activityEntryInfo.activityID
			data.queue = {}
			i = 0
			local numApps, numActiveApps = C_LFGList.GetNumApplicants()
			if numActiveApps > 0 then
				local applicants = C_LFGList.GetApplicants()
				for j = 1, #applicants do
					local applicantInfo = C_LFGList.GetApplicantInfo(applicants[j])

					if applicantInfo then
						local id = applicantInfo.applicantID
						local numMembers = applicantInfo.numMembers
						if numMembers > 0 then
							local memberIndex = 0
							local bumpedIndex
							for k = 1, numMembers do
								local fullName, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(id, k)
								local name, realm = ns.GetNameAndRealm(fullName)
								if name then
									if not bumpedIndex then
										bumpedIndex = true
										i = i + 1
									end
									local role = GetQueuedRole(tank, healer, damage)
									if numMembers > 1 then
										memberIndex = memberIndex + 1
										data.queue[i] = data.queue[i] or {}
										data.queue[i][memberIndex] = format("%d-%s-%s", role, name, ns.GetRealmSlug(realm))
									else
										data.queue[i] = format("%d-%s-%s", role, name, ns.GetRealmSlug(realm))
									end
								end
							end
						end
					end
				end
			end
		end
		return TableToJSON(data)
	end

	function UpdateCopyDialog()
		local canShow = CanShowCopyDialog()
		ExportButton:SetShown(canShow)
		if not canShow then ExportButton.CloseCopyDialog() return end
		local frameName, frame = StaticPopup_Visible(StaticPopupName)
		if not frame then return end
		local editBox = _G[frameName .. "WideEditBox"] or _G[frameName .. "EditBox"]
		frame:SetWidth(420)
		editBox:SetText(canShow and GetJSON() or "")
		editBox:SetFocus()
		editBox:HighlightText(false)
		local button = _G[frameName .. "Button2"]
		button:ClearAllPoints()
		button:SetWidth(200)
		button:SetPoint("CENTER", editBox, "CENTER", 0, -30)
	end

	function CanShowCopyDialog()
		if not ns.PLAYER_REGION then return false end
		local hasGroup = (IsInRaid() or IsInGroup()) and GetNumGroupMembers() > 1
		local hasGroupQueued = not not C_LFGList.GetActiveEntryInfo()
		local _, hasApplied = C_LFGList.GetNumApplications()
		return hasGroup or hasGroupQueued or hasApplied > 0
	end
end

function ExportButton.ToggleCopyDialog()
	if not StaticPopup_Visible(StaticPopupName) then
		ExportButton.OpenCopyDialog()
	else
		ExportButton.CloseCopyDialog()
	end
end

function ExportButton.OpenCopyDialog()
	local _, frame = StaticPopup_Visible(StaticPopupName)
	if frame then UpdateCopyDialog() return end
	frame = StaticPopup_Show(StaticPopupName)
end

function ExportButton.CloseCopyDialog()
	local _, frame = StaticPopup_Visible(StaticPopupName)
	if not frame then return end
	StaticPopup_Hide(StaticPopupName)
end

-- button scripts and events
do
	ExportButton:SetScript("OnEnter", function() ExportButton.Border:SetVertexColor(1, 1, 1) end)
	ExportButton:SetScript("OnLeave", function() ExportButton.Border:SetVertexColor(.8, .8, .8) end)
	ExportButton:SetScript("OnClick", ExportButton.ToggleCopyDialog)
	ExportButton:SetScript("OnEvent", UpdateCopyDialog)
	ExportButton:RegisterEvent("PLAYER_ENTERING_WORLD")
	ExportButton:RegisterEvent("GROUP_ROSTER_UPDATE")
	ExportButton:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
	ExportButton:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED")
	ExportButton:RegisterEvent("LFG_LIST_APPLICANT_UPDATED")
	ExportButton:RegisterEvent("PLAYER_ROLES_ASSIGNED")
	ExportButton:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

-- namespace references
ns.EXPORT_JSON = ExportButton


local addonName, scope = ...
local oRA = scope.addon
local module = oRA:NewModule("RoleIcons")

-- luacheck: globals NUM_RAID_GROUPS RaidFrame

-- Icons on the player buttons
local updateIcons
do
	-- Deprecated then added back, just leaving the function here for now
	local function GetTexCoordsForOldRoleSmallCircle(role)
		if role == "TANK" then
			return 0, 19 / 64, 22 / 64, 41 / 64
		elseif role == "HEALER" then
			return 20 / 64, 39 / 64, 1 / 64, 20 / 64
		elseif role == "DAMAGER" then
			return 20 / 64, 39 / 64, 22 / 64, 41 / 64
		else
			error("Unknown role: " .. tostring(role))
		end
	end
	local roleIcons = setmetatable({}, { __index = function(t,i)
		local parent = _G["RaidGroupButton"..i]
		local icon = CreateFrame("Frame", nil, parent)
		icon:SetSize(14, 14)
		icon:SetPoint("RIGHT", parent.subframes.level, "LEFT", 2, 0)
		icon:SetFrameLevel(icon:GetFrameLevel()+1)

		local texture = icon:CreateTexture(nil, "ARTWORK")
		texture:SetAllPoints()
		texture:SetTexture(337497) --"Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES"
		icon.texture = texture

		icon:Hide()

		t[i] = icon
		return icon
	end })

	function updateIcons()
		if not oRA.db.profile.showRoleIcons then
			for _,icon in next, roleIcons do
				icon:Hide()
			end
			return
		end
		if not IsInRaid() then
			return
		end

		for i = 1, GetNumGroupMembers() do
			local button = _G["RaidGroupButton"..i]
			if button and button.subframes then -- make sure the raid button is set up
				local icon = roleIcons[i]
				local role = UnitGroupRolesAssigned("raid"..i)
				if role and role ~= "NONE" then
					icon.texture:SetTexCoord(GetTexCoordsForOldRoleSmallCircle(role))
					icon:Show()
				else
					icon:Hide()
				end
			end
		end
	end
end

-- Icons on the raid frame
local createCountIcons
do
	local roster = {}
	for i=1,NUM_RAID_GROUPS do roster[i] = {} end
	local function sortColoredNames(a, b) return a:sub(11) < b:sub(11) end

	local function onEnter(self)
		local role = self.role
		local found = nil
		for i = 1, GetNumGroupMembers() do
			local name, _, group, _, _, class, _, _, _, _, _, groupRole = GetRaidRosterInfo(i)
			if name and groupRole == role then
				local color = oRA.classColors[class]
				local coloredName = ("|cff%02x%02x%02x%s"):format(color.r * 255, color.g * 255, color.b * 255, name:gsub("%-.+", "*"))
				tinsert(roster[group], coloredName)
				found = true
			end
		end
		if not found then
			return
		end

		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
		GameTooltip:SetText(_G["INLINE_" .. role .. "_ICON"] .. _G[role])
		for group, list in ipairs(roster) do
			sort(list, sortColoredNames)
			for _, name in ipairs(list) do
				GameTooltip:AddLine(("[%d] %s"):format(group, name), 1, 1, 1)
			end
			wipe(list)
		end
		GameTooltip:Show()
	end

	function createCountIcons()
		local parent = RaidFrame.RoleCount
		for _, role in next, {"Tank", "Healer", "Damager"} do
			local frame = CreateFrame("Frame", nil, parent)
			frame.role = role:upper()
			frame:SetAllPoints(parent[role.."Icon"])
			frame:SetScript("OnEnter", onEnter)
			frame:SetScript("OnLeave", GameTooltip_Hide)
		end
	end
end

function module:OnRegister()
	self:RegisterEvent("ADDON_LOADED")
	createCountIcons()
end

function module:ADDON_LOADED(name)
	if name == "Blizzard_RaidUI" then
		self:UnregisterEvent("ADDON_LOADED")
		if RaidFrame:IsShown() then
			updateIcons()
		end
		hooksecurefunc("RaidGroupFrame_Update", updateIcons)
	end
end

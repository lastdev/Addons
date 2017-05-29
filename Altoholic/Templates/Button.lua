local addonName = ...
local addon = _G[addonName]

local function _SetIcon(frame, icon)
	if icon then
		frame.Icon:SetTexture(icon)
	end
end

local function _SetIconSize(frame, width, height)
	-- resize the frame, the icon will be resized along with it due to setAllPoints="true"
	if width then
		frame:SetWidth(width)
	end
	
	if height then
		frame:SetHeight(height)
	end
end

addon:RegisterClassExtensions("AltoButton", {
	SetIcon = _SetIcon,
	SetIconSize = _SetIconSize,
})

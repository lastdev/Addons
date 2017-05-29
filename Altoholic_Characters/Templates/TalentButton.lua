local addonName = "Altoholic"
local addon = _G[addonName]

local function _EnableIcon(frame)
	-- frame:Enable()
	frame.Icon:SetDesaturated(false)
end

local function _DisableIcon(frame)
	-- frame:Disable()
	frame.Icon:SetDesaturated(true)
end

addon:RegisterClassExtensions("AltoTalentButton", {
	EnableIcon = _EnableIcon,
	DisableIcon = _DisableIcon,
})

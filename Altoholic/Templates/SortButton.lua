local addonName = "Altoholic"
local addon = _G[addonName]

local function _DrawArrow(frame, ascending)
	if ascending then
		frame:SetTexCoord(0, 0.5625, 1.0, 0)		-- arrow pointing up
	else
		frame:SetTexCoord(0, 0.5625, 0, 1.0)		-- arrow pointing down
	end
	frame:Show()
end

addon:RegisterClassExtensions("AltoSortButton", {
	Draw = _DrawArrow,
})

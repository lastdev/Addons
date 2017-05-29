local addonName = "Altoholic"
local addon = _G[addonName]

local function _SetButton(frame, id, title, width, func)
	local button = frame["Sort"..id]

	if not title then		-- no title ? hide the button
		button:Hide()
		return
	end
	
	button:SetText(title)
	button:SetWidth(width)
	button.func = func
	button:Show()	
end

addon:RegisterClassExtensions("AltoSortButtonsContainer", {
	SetButton = _SetButton,
})

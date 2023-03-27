--[[ See license.txt for license and copyright information ]]
select(2, ...).SetScope("options")

LinkButton = { }

function LinkButton.Create(frame, label, url, iconPath)
	local linkButton = CreateFrame("Button", nil, frame)
	linkButton.text = linkButton:CreateFontString(nil, "Artwork", "GameFontWhite")
	linkButton.icon = linkButton:CreateTexture()
	linkButton.icon:SetTexture(iconPath)
	linkButton.icon:SetSize(22, 22)
	linkButton.icon:SetPoint("LEFT")
	linkButton.text:SetText(label)
	linkButton:SetSize(linkButton.text:GetStringWidth() + 32, 22)
	linkButton.text:SetPoint("RIGHT")
	linkButton.url = url
	--todo: add click, highlight, etc. function
	return linkButton
end

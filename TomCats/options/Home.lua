--[[ See license.txt for license and copyright information ]]
select(2, ...).SetScope("options")

Home = CreateFrame("Frame")
Home:Hide()

local contents

Home:SetScript("OnShow", function(self)
	Header.Acquire(self, "Home")
	if (not contents) then
		contents = CreateFrame("Frame", nil, UIParent)
		local linksFrame = CreateFrame("Frame", nil, contents)
		linksFrame:SetPoint("TOPLEFT", 0, -10)
		linksFrame:SetPoint("TOPRIGHT", 0, -10)
		linksFrame:SetHeight(80)
		local wwwLink = LinkButton.Create(linksFrame,"TomCatsTours.com","https://TomCatsTours.com", Image.www_icon)
		wwwLink:SetPoint("TOPLEFT", 30, 0)
		local githubLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		githubLink:SetPoint("LEFT", 30, 0)
		local discordLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		discordLink:SetPoint("BOTTOMLEFT", 30, 0)
		local twitchLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		twitchLink:SetPoint("TOP")
		local patreonLink = LinkButton.Create(linksFrame,"TomCatsTours","https://patreon.com/TomCatsTours", Image.PatreonLogo)
		patreonLink:SetPoint("CENTER")
		local twitterLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		twitterLink:SetPoint("BOTTOM")
		local curseforgeLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		curseforgeLink:SetPoint("TOPRIGHT", -30, 0)
		local paypalLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		paypalLink:SetPoint("RIGHT", -30, 0)
		local bnetLink = LinkButton.Create(linksFrame,"TomCatsTours","https://TomCatsTours.com", Image.www_icon)
		bnetLink:SetPoint("BOTTOMRIGHT", -30, 0)
		local welcome = CreateFrame("SimpleHTML",nil, contents, "TomCats_HTML_Welcome")
		welcome:SetPoint("TOPLEFT", linksFrame, "BOTTOMLEFT", 0, -10)
		welcome:SetPoint("RIGHT")
		contents.Reset = function()
			contents:SetHeight(10 + 80 + 10 + welcome:GetContentHeight())
		end
	end
	ScrollBox.Acquire(self, contents)
end)

Home:SetScript("OnHide", function()
	Header.Release()
end)

--todo: localize
Settings.RegisterAddOnCategory(Settings.RegisterCanvasLayoutCategory(Home, "TomCat's Tours"))

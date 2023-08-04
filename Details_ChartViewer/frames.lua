
local addonId, addonTable = ...
local AceLocale = LibStub("AceLocale-3.0")
local Loc = AceLocale:GetLocale("Details_ChartViewer")
local Details = Details
local detailsFramework = DetailsFramework
local ChartViewer = addonTable.ChartViewer
local ChartViewerWindowFrame = ChartViewerWindowFrame
local CreateFrame = CreateFrame

function ChartViewer:CreateTitleBarAndHeader()
    local height = ChartViewerWindowFrame:GetHeight()
    ChartViewerWindowFrameChartFrame:SetSize(ChartViewerWindowFrame:GetWidth()-3, height-74)

    --title bar
    local titleBar = CreateFrame("frame", nil, ChartViewerWindowFrame, "BackdropTemplate")
    titleBar:SetPoint("topleft", ChartViewerWindowFrame, "topleft", 2, -3)
    titleBar:SetPoint("topright", ChartViewerWindowFrame, "topright", -2, -3)
    titleBar:SetHeight(20)
    titleBar:SetBackdrop({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\AddOns\Details\images\background]], tileSize = 64, tile = true})
    titleBar:SetBackdropColor(.5, .5, .5, 1)
    titleBar:SetBackdropBorderColor(0, 0, 0, 1)

    local nameBackgroundTexture = ChartViewerWindowFrame:CreateTexture(nil, "background")
    nameBackgroundTexture:SetTexture([[Interface\PetBattles\_PetBattleHorizTile]], true)
    nameBackgroundTexture:SetHorizTile(true)
    nameBackgroundTexture:SetTexCoord(0, 1, 126/256, 19/256)
    nameBackgroundTexture:SetPoint("topleft", ChartViewerWindowFrame, "topleft", 2, -22)
    nameBackgroundTexture:SetPoint("bottomright", ChartViewerWindowFrame, "bottomright")
    nameBackgroundTexture:SetHeight(54)
    nameBackgroundTexture:SetVertexColor(0, 0, 0, 0.2)

    --window title
    local titleLabel = detailsFramework:NewLabel(titleBar, titleBar, nil, "titulo", "Chart Viewer", "GameFontHighlightLeft", 12, {227/255, 186/255, 4/255})
    titleLabel:SetPoint("center", ChartViewerWindowFrame, "center")
    titleLabel:SetPoint("top", ChartViewerWindowFrame, "top", 0, -7)

    --header background
    local headerFrame = CreateFrame("frame", "EncounterDetailsHeaderFrame", ChartViewerWindowFrame, "BackdropTemplate")
    headerFrame:EnableMouse(false)
    headerFrame:SetPoint("topleft", titleBar, "bottomleft", -1, -1)
    headerFrame:SetPoint("topright", titleBar, "bottomright", 1, -1)
    headerFrame:SetBackdrop({bgFile = [[Interface\AddOns\Details\images\background]], tileSize = 64, tile = true})
    headerFrame:SetBackdropColor(.7, .7, .7, .4)
    headerFrame:SetHeight(48)
    ChartViewerWindowFrame.headerFrame = headerFrame

    local gradientTop = detailsFramework:CreateTexture(headerFrame,
    {gradient = "vertical", fromColor = {0, 0, 0, 0.5}, toColor = "transparent"}, 1, 48, "artwork", {0, 1, 0, 1})
    gradientTop:SetPoint("bottoms", 1, 1)
    ChartViewerWindowFrame.gradientTop = gradientTop
end

function ChartViewer.CreateSegmentDropdown()
	local statusbarBackground = CreateFrame("frame", nil, ChartViewerWindowFrame, "BackdropTemplate")
	statusbarBackground:SetPoint("bottomleft", ChartViewerWindowFrame, "bottomleft")
	statusbarBackground:SetPoint("bottomright", ChartViewerWindowFrame, "bottomright")
	statusbarBackground:SetHeight(30)
	statusbarBackground:EnableMouse(true)
	statusbarBackground:SetFrameLevel(9)

	local frame = ChartViewerWindowFrame
	if (not DetailsPluginContainerWindow) then
		statusbarBackground:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton") then
				if (not frame.isMoving) then
					frame.isMoving = true
					frame:StartMoving()
				end

			elseif (button == "RightButton") then
				if (not frame.isMoving) then
					frame:Hide()
				end
			end
		end)

		statusbarBackground:SetScript("OnMouseUp", function (self, button)
			if (button == "LeftButton" and frame.isMoving) then
				frame.isMoving = nil
				frame:StopMovingOrSizing()
			end
		end)
	end

	local onSelectSegment = function(self, _, segmentId)
		ChartViewer.current_segment = segmentId
		ChartViewer:RefreshGraphic(Details:GetCombat(segmentId))
	end

	local buildSegmentMenuFunc = function(self)
		local segmentsTable = Details:GetCombatSegments()
		local result = {}

		--ChartViewerDB.chartData[combatUniquieID][ChartName] = chartData

		for index, combatObject in ipairs(segmentsTable) do
			local combatUniquieID = combatObject:GetCombatUID()
			local charts = ChartViewerDB.chartData[combatUniquieID]

			if (charts) then
				if (combatObject.is_boss and combatObject.is_boss.index) then
					local bossIcon = Details:GetBossEncounterTexture(combatObject.is_boss.name)
					--print(bossIcon, combatObject.is_boss.name)
					local l, r, t, b, icon = ChartViewer:GetBossIcon(combatObject.is_boss.mapid, combatObject.is_boss.index)
					result[#result+1] = {value = index, label = "#" .. index .. " " .. combatObject.is_boss.name, icon = bossIcon, iconsize = {32, 20}, texcoord = {0, 1, 0, 0.9}, onclick = onSelectSegment}
				else
					result[#result+1] = {value = index, label = "#" .. index .. " " .. (combatObject.enemy or "unknown"), icon = [[Interface\Buttons\UI-GuildButton-PublicNote-Up]], onclick = onSelectSegment}
				end
			end
		end

		return result
	end

	local segmentsDropdown = detailsFramework:CreateDropDown(ChartViewerWindowFrame, buildSegmentMenuFunc, 1, 215, 20)
	segmentsDropdown:SetPoint("topleft", ChartViewerWindowFrame.headerFrame, "topleft", 3, -49)
	segmentsDropdown:SetFrameLevel(10)
	segmentsDropdown:SetTemplate(detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
	ChartViewer.segments_dropdown = segmentsDropdown
end

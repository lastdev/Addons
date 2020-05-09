local addonName, ns = ...

-- constants
local L = ns.L

-- max visible runs
local MAX_VISIBLE_RUNS = 5

-- mousewheel offset
local MW_OFFSET = 0

-- utility functions
local GetGuildFullName
local GetGuildLeaders
do
	function GetGuildFullName(unit)
		local guildName, _, _, guildRealm = GetGuildInfo(unit)
		if not guildName then
			return
		end
		if not guildRealm then
			_, guildRealm = ns.GetNameAndRealm(unit)
		end
		return guildName .. "-" .. guildRealm
	end

	local function IsRunTheSameRun(r1, r2)
		if r1.zone_id == r2.zone_id and r1.level == r2.level then
			local a, b = #r1.party, 0
			for i = 1, #r1.party do
				for j = 1, #r2.party do
					if r1.party[i].name == r2.party[j].name then
						b = b + 1
					end
				end
			end
			return a == b
		end
		return false
	end

	local function IsRunInGuildData(weekData, run)
		for i = 1, #weekData do
			local r = weekData[i]
			if IsRunTheSameRun(r, run) then
				return true
			end
		end
		return false
	end

	local function GetDungeonFromChallengeModeID(mapChallengeModeID)
		for i = 1, #ns.CONST_DUNGEONS do
			local dungeon = ns.CONST_DUNGEONS[i]
			if dungeon.keystone_instance == mapChallengeModeID then
				return dungeon
			end
		end
	end

	local CLASS_FILENAME_TO_ID = {
		WARRIOR = 1,
		PALADIN = 2,
		HUNTER = 3,
		ROGUE = 4,
		PRIEST = 5,
		DEATHKNIGHT = 6,
		SHAMAN = 7,
		MAGE = 8,
		WARLOCK = 9,
		MONK = 10,
		DRUID = 11,
		DEMONHUNTER = 12,
	}

	local function ConvertRunData(run)
		local dungeon = GetDungeonFromChallengeModeID(run.mapChallengeModeID)
		local r = {
			zone_id = dungeon and dungeon.id or 0,
			level = run.keystoneLevel or 0,
			upgrades = 0,
			party = {},
		}
		for i = 1, #run.members do
			local member = run.members[i]
			r.party[i] = {
				name = member.name,
				class_id = CLASS_FILENAME_TO_ID[member.classFileName] or 0,
			}
		end
		return r
	end

	function GetGuildLeaders(guildBestData)
		local data = setmetatable({ weekly_best = {} }, { __index = guildBestData })
		local weekData = data.weekly_best
		local hasGuildData = guildBestData

		if hasGuildData and hasGuildData.weekly_best then
			for i = 1, #hasGuildData.weekly_best do
				weekData[i] = hasGuildData.weekly_best[i]
			end
		end

		if type(C_ChallengeMode.GetGuildLeaders) == "function" then
			local leaders = C_ChallengeMode.GetGuildLeaders()
			if leaders and leaders[1] then
				for i = 1, #leaders do
					local run = ConvertRunData(leaders[i])
					if hasGuildData then
						if not IsRunInGuildData(weekData, run) then
							weekData[#weekData + 1] = run
						end
					else
						weekData[#weekData + 1] = run
					end
				end
			end
		end

		return data
	end
end

RaiderIO_GuildBestMixin = {}

function RaiderIO_GuildBestMixin:OnLoad()
	-- namespace reference
	ns.GUILD_BEST_FRAME = self
	-- make it fit the scale of the parent
	self:SetScale(1.2)
	-- prepare to be shown later
	self:Reset()
	-- set the title of the container
	self.Title:SetText(L.GUILD_BEST_TITLE)
end

function RaiderIO_GuildBestMixin:OnMouseWheel(delta)
	MW_OFFSET = max(0, min(MAX_VISIBLE_RUNS, delta > 0 and -1 or 1))
	self:Refresh()
end

function RaiderIO_GuildBestMixin:Refresh()
	if not ChallengesFrame then self:Reset() self:Hide() return end
	local guildFullName = GetGuildFullName("player")
	if not guildFullName then self:Reset() self:Hide() return end
	self:SetParent(ChallengesFrame)
	local numRuns = self:SetUp(guildFullName)
	-- anchor and appearance logic
	if false and ns.DEBUG_MODE then
		-- debug and test it showing outside bottom right (below the profile tooltip)
		self.Background:Hide()
		GameTooltip_SetBackdropStyle(self, GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT)
		self:ClearAllPoints()
		self:SetPoint("BOTTOMLEFT", ChallengesFrame, "BOTTOMRIGHT", 0, 0)
	else
		-- show inside the frame either top right or bottom left
		self.Background:Show()
		self:SetFrameLevel(10)
		self:SetBackdropBorderColor(0, 0, 0, 0)
		self:SetBackdropColor(0, 0, 0, 0)
		self:ClearAllPoints()
		if IsAddOnLoaded("AngryKeystones") then
			self:SetPoint("TOPRIGHT", ChallengesFrame, "TOPRIGHT", -6, -18)
		else
			self:SetPoint("BOTTOMLEFT", ChallengesFrame.DungeonIcons[1], "TOPLEFT", 2, 12)
		end
	end
	-- show the frame and enable mousewheel if we have more runs than we can show
	self:Show()
	self:EnableMouseWheel(true) -- numRuns > MAX_VISIBLE_RUNS
end

function RaiderIO_GuildBestMixin:SwitchBestRun()
	ns.addonConfig.displayWeeklyGuildBest = not ns.addonConfig.displayWeeklyGuildBest
	self:SetUp(GetGuildFullName("player"))
end

function RaiderIO_GuildBestMixin:SetUp(guildFullName)
	local guildBestData = ns.GUILD_BEST_DATA and ns.GUILD_BEST_DATA[guildFullName]
	local bestRuns = guildBestData

	local keyBest = "season_best"
	local title = L.GUILD_BEST_SEASON

	if not guildBestData or ns.addonConfig.displayWeeklyGuildBest then
		if not guildBestData then
			bestRuns = GetGuildLeaders(guildBestData)
		end
		keyBest = "weekly_best"
		title = L.GUILD_BEST_WEEKLY
	end

	self.SwitchGuildBest:SetShown(guildBestData)
	self.SubTitle:SetText(title)
	self.bestRuns = bestRuns and bestRuns[keyBest] or {}
	self:Reset()

	if not self.bestRuns or not self.bestRuns[1] then
		self.GuildBestNoRun:Show()
		self:SetHeight(35 + 15 + (self.SwitchGuildBest:IsShown() and self.SwitchGuildBest:GetHeight() or 0))
		return 0
	end

	local numRuns = #self.bestRuns

	if numRuns <= MAX_VISIBLE_RUNS then
		MW_OFFSET = 0
	end

	for i = 1, min(numRuns, MAX_VISIBLE_RUNS) do
		local frame = self.GuildBests[i]
		if not frame then
			frame = CreateFrame("Frame", nil, ns.GUILD_BEST_FRAME, "RaiderIO_GuildBestRunTemplate")
			frame:SetPoint("TOP", self.GuildBests[i-1], "BOTTOM")
		end
		frame:SetUp(self.bestRuns[i + MW_OFFSET])
	end

	-- update mouse focus after potential scrolling
	if self:IsMouseOver() then
		local focus = GetMouseFocus()
		if focus and focus ~= GameTooltip:GetOwner() and type(focus.OnEnter) == "function" then
			focus:OnEnter()
		end
	end

	-- resize the height to fit the contents
	self:SetHeight(35 + (numRuns > 0 and numRuns * self.GuildBests[1]:GetHeight() or 0) + (self.SwitchGuildBest:IsShown() and self.SwitchGuildBest:GetHeight() or 0))

	return numRuns
end

function RaiderIO_GuildBestMixin:Reset()
	self.GuildBestNoRun:Hide()
	self.GuildBestNoRun.Text:SetText(L.NO_GUILD_RECORD)
	if self.GuildBests then
		for _, frame in ipairs(self.GuildBests) do
			frame:Hide()
		end
	end
end

RaiderIO_SwitchGuildBestMixin = {}

function RaiderIO_SwitchGuildBestMixin:OnLoad()
	self.text:SetFontObject("GameFontNormalTiny2")
	self.text:SetText(L.CHECKBOX_DISPLAY_WEEKLY)
	self.text:SetPoint("LEFT", 15, 0)
	self.text:SetJustifyH("LEFT")
	self:SetSize(15, 15)
end

function RaiderIO_SwitchGuildBestMixin:OnShow()
	self:SetChecked(ns.addonConfig.displayWeeklyGuildBest)
end

RaiderIO_GuildBestRunMixin = {}

function RaiderIO_GuildBestRunMixin:SetUp(runInfo)
	self.runInfo = runInfo
	if not runInfo then
		self:Hide()
		return
	end
	self.CharacterName:SetText(ns.GetDungeonWithData("id", self.runInfo.zone_id).shortNameLocale)
	self.Level:SetTextColor(1, 1, 1)
	if self.runInfo.clear_time and self.runInfo.upgrades == 0 then
		self.Level:SetTextColor(.62, .62, .62)
	end
	self.Level:SetText(ns.GetStarsForUpgrades(self.runInfo.upgrades) .. self.runInfo.level)
	self:Show()
end

function RaiderIO_GuildBestRunMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(C_ChallengeMode.GetMapUIInfo(ns.GetDungeonWithData("id", self.runInfo.zone_id).keystone_instance), 1, 1, 1)
	local upgradeStr = ""
	if self.runInfo.upgrades > 0 then
		upgradeStr = " (" .. ns.GetStarsForUpgrades(self.runInfo.upgrades, true) .. ")"
	end
	GameTooltip:AddLine(MYTHIC_PLUS_POWER_LEVEL:format(self.runInfo.level) .. upgradeStr, 1, 1, 1)
	if self.runInfo.clear_time then
		GameTooltip:AddLine(self.runInfo.clear_time, 1, 1, 1)
	end
	if self.runInfo.party then
		GameTooltip:AddLine(" ")
		for i, member in ipairs(self.runInfo.party) do
			if member.name then
				local classInfo = C_CreatureInfo.GetClassInfo(member.class_id)
				local color = (classInfo and RAID_CLASS_COLORS[classInfo.classFile]) or NORMAL_FONT_COLOR
				local texture
				if member.role == "tank" or member.role == "TANK" then
					texture = CreateAtlasMarkup("roleicon-tiny-tank")
				elseif member.role == "dps" or member.role == "DAMAGER" then
					texture = CreateAtlasMarkup("roleicon-tiny-dps")
				elseif member.role == "healer" or member.role == "HEALER" then
					texture = CreateAtlasMarkup("roleicon-tiny-healer")
				end
				if texture then
					GameTooltip:AddLine(MYTHIC_PLUS_LEADER_BOARD_NAME_ICON:format(texture, member.name), color.r, color.g, color.b)
				else
					GameTooltip:AddLine(member.name, color.r, color.g, color.b)
				end
			end
		end
	end
	GameTooltip:Show()
end

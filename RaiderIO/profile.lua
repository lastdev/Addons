local addonName, ns = ...

-- constants
local L = ns.L
local RAIDERIO_ADDON_DOWNLOAD_URL = "https://rio.gg/addon"

-- colors
local COLOR_WHITE = { r = 1, g = 1, b = 1 }
local COLOR_GREY = { r = 0.62, g = 0.62, b = 0.62 }
local COLOR_GREEN = { r = 0, g = 1, b = 0 }

-- text color escape codes
local TEXT_COLOR_START_RAIDERIO = "|cffffbd0a"
local TEXT_COLOR_CLOSE = "|r"

-- fallback frames and stratas
local FALLBACK_ANCHOR = _G.PVEFrame
local FALLBACK_ANCHOR_STRATA = "LOW"
local FALLBACK_FRAME = _G.UIParent
local FALLBACK_FRAME_STRATA = "LOW"

-- profile tooltip
local ProfileTooltip
do
	ProfileTooltip = CreateFrame("GameTooltip", addonName .. "_ProfileTooltip", FALLBACK_FRAME, "GameTooltipTemplate")
	ProfileTooltip:SetClampedToScreen(true)
	ProfileTooltip:RegisterForDrag("LeftButton")
	ProfileTooltip:SetScript("OnDragStart", ProfileTooltip.StartMoving)
	ProfileTooltip:SetScript("OnDragStop", function()
		ProfileTooltip:StopMovingOrSizing()
		-- ProfileTooltip:SetUserPlaced(true)
		local point, _, _, x, y = ProfileTooltip:GetPoint()
		local p = ns.addonConfig.profilePoint or {}
		p.point, p.x, p.y = point, x, y
		ns.addonConfig.profilePoint = p
	end)
	ProfileTooltip:SetScript("OnShow", function()
		GameTooltip_SetBackdropStyle(ProfileTooltip, GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT)
	end)
end

local IsFallbackAnchorShown
local HookFrame
local SetAnchor
local SetUserAnchor
local UpdateProfile
local SetDrag
do
	local hooks = {}
	local query = {}
	local hasQuery = false

	local function IsFrame(widget)
		return type(widget) == "table" and type(widget.GetObjectType) == "function"
	end

	local function HookHideTooltip()
		if IsFallbackAnchorShown() then
			ProfileTooltip.ShowProfile("player", nil, ns.PLAYER_FACTION, nil, FALLBACK_ANCHOR, FALLBACK_ANCHOR_STRATA)
		else
			ProfileTooltip.HideProfile(true)
		end
	end

	local function PopulateProfile(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier)
		-- respect modifier and inverse modifier behavior for the profile tooltip
		if not forceDisableModifier and ns.addonConfig.enableProfileModifier then
			if (ns.addonConfig.inverseProfileModifier == ns.addon:IsModifierKeyDown(true) or not ns.HasPlayerProfile(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil)) then
				if not (not ns.addonConfig.showRaiderIOProfile) then
					unitOrNameOrNameAndRealm, realmOrNil = "player", nil
				end
			end
		end
		-- do not show our own profile if the user doesn't want to see it
		if ns.addonConfig.hidePersonalRaiderIOProfile and unitOrNameOrNameAndRealm == "player" then
			return
		end

		local isPlayer = unitOrNameOrNameAndRealm == "player"

		local name, realm, unit = ns.GetNameAndRealm(unitOrNameOrNameAndRealm, realmOrNil)
		local faction = type(factionOrNil) == "number" and factionOrNil or ns.GetFaction(unit)

		local isDataExpired = (ns.DB_OUTDATED[1][faction] == "expired" or ns.DB_OUTDATED[2][faction] == "expired")

		if isDataExpired and not isPlayer then
			-- prevent showing profile data when expired and looking at anyone but yourself
			ProfileTooltip:AddLine(L.OUTDATED_EXPIRED_TITLE, 1, 0, 0, false)
			ProfileTooltip:AddLine(format(L.OUTDATED_DOWNLOAD_LINK, TEXT_COLOR_START_RAIDERIO .. RAIDERIO_ADDON_DOWNLOAD_URL .. TEXT_COLOR_CLOSE), 1, 1, 1, true)
			ProfileTooltip:AddLine(" ", 1, 1, 1, false)
			ProfileTooltip:AddLine(L.OUTDATED_PROFILE_TOOLTIP_MESSAGE, 1, 1, 1, true)
			return true
		end

		-- mythic plus data
		local hasMythicPlusProfile = false
		do
			local output, hasProfile = ns.GetPlayerProfile(bit.bor(ns.ProfileOutput.MYTHICPLUS, ns.ProfileOutput.TOOLTIP, ns.ProfileOutput.PROFILE, ns.ProfileOutput.MOD_KEY_DOWN_STICKY), unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, true, lfdActivityID, keystoneLevel)
			local profile = hasProfile and output.profile or nil
			hasMythicPlusProfile = hasProfile
			if profile and hasProfile then
				if isDataExpired then
					ProfileTooltip:AddLine(L.OUTDATED_EXPIRED_TITLE, 1, 0, 0, false)
					ProfileTooltip:AddLine(format(L.OUTDATED_DOWNLOAD_LINK, TEXT_COLOR_START_RAIDERIO .. RAIDERIO_ADDON_DOWNLOAD_URL .. TEXT_COLOR_CLOSE), 1, 1, 1, true)
					ProfileTooltip:AddLine(" ", 1, 1, 1, false)
				end

				ProfileTooltip:AddLine(isPlayer and L.MY_PROFILE_TITLE or format("%s: %s", L.MY_PROFILE_TITLE, profile.name), 1, 0.85, 0, false)

				-- the focused dungeon based on LFD activityID
				local dungeon
				if lfdActivityID then
					local dungeonID = ns.LFD_ACTIVITYID_TO_DUNGEONID[lfdActivityID]
					if dungeonID then
						dungeon = ns.CONST_DUNGEONS[dungeonID]
					end
				end
				local focusOnDungeonIndex = dungeon and dungeon.index or nil
				-- make a list over the dungeons the profile has done
				local dungeons = {}
				for dungeonIndex, keyLevel in ipairs(profile.dungeons) do
					local d = ns.CONST_DUNGEONS[dungeonIndex]
					dungeons[dungeonIndex] = {
						index = dungeonIndex,
						dungeon = d,
						shortName = d.shortNameLocale,
						keyLevel = keyLevel,
						upgrades = profile.dungeonUpgrades[dungeonIndex] or 0,
						fractionalTime = profile.dungeonTimes[dungeonIndex] or 0,
					}
				end
				table.sort(dungeons, ns.CompareDungeon)
				-- add the tooltip header and regular tooltip lines
				for i = 1, output.length do
					local line = output[i]
					if type(line) == "table" then
						ProfileTooltip:AddDoubleLine(line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10])
					else
						ProfileTooltip:AddLine(line)
					end
				end
				-- add the dungeons list of the best runs
				ProfileTooltip:AddLine(" ")
				ProfileTooltip:AddLine(L.PROFILE_BEST_RUNS, 1, 0.85, 0, false)
				for i, dungeon in ipairs(dungeons) do
					local colorDungeonName = COLOR_WHITE
					local colorDungeonLevel = COLOR_WHITE
					local keyLevel = dungeon.keyLevel
					if keyLevel ~= 0 then
						if dungeon.upgrades == 0 then
							colorDungeonLevel = COLOR_GREY
						end
						keyLevel = ns.GetStarsForUpgrades(dungeon.upgrades) .. keyLevel
					else
						keyLevel = "-"
						colorDungeonLevel = COLOR_GREY
					end
					if focusOnDungeonIndex == dungeon.index then
						colorDungeonName = COLOR_GREEN
						colorDungeonLevel = COLOR_GREEN
					end
					ProfileTooltip:AddDoubleLine(dungeon.shortName, keyLevel, colorDungeonName.r, colorDungeonName.g, colorDungeonName.b, colorDungeonLevel.r, colorDungeonLevel.g, colorDungeonLevel.b)
				end
			end
		end

		-- if wanting to show raid data
		if ns.addonConfig.showRaidEncountersInProfile then
			local output, hasProfile = ns.GetPlayerProfile(bit.bor(ns.ProfileOutput.RAIDING, ns.ProfileOutput.TOOLTIP, ns.ProfileOutput.MOD_KEY_DOWN_STICKY), unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, true, lfdActivityID, keystoneLevel)
			local profile = hasProfile and output.profile or nil
			if profile and hasProfile then
				if hasMythicPlusProfile then
					ProfileTooltip:AddLine(" ")
				else
					ProfileTooltip:AddLine(isPlayer and L.MY_PROFILE_TITLE or format("%s: %s", L.MY_PROFILE_TITLE, profile.name), 1, 0.85, 0, false)
				end

				ProfileTooltip:AddLine(L.RAID_ENCOUNTERS_DEFEATED_TITLE, 1, 0.85, 0, false)

				-- only show breakdown for their top progress
				for bossIndex = 1, profile.currentRaid.bossCount do
					local progFound = false
					for progIndex = 1, #profile.progress do
						if not progFound then
							local prog = profile.progress[progIndex]
							if prog.killsPerBoss[bossIndex] > 0 then
								progFound = true
								ProfileTooltip:AddDoubleLine(
									format("|c%s%s|r %s",
										ns.GetRaidDifficultyColor(prog.difficulty)[4],
										ns.RAID_DIFFICULTY_SUFFIXES[prog.difficulty],
										L[format("RAID_BOSS_%s_%d", profile.currentRaid.shortName, bossIndex)]
									),
									prog.killsPerBoss[bossIndex],
									1, 1, 1,
									1, 1, 1
								)
							end
						end
					end

					if not progFound then
						ProfileTooltip:AddDoubleLine(
							L[format("RAID_BOSS_%s_%d", profile.currentRaid.shortName, bossIndex)],
							"-",
							0.5, 0.5, 0.5,
							0.5, 0.5, 0.5
						)
					end
				end
			end
		end

		return true
	end

	local function SaveQuery(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier)
		query[1], query[2], query[3], query[4], query[5], query[6], query[7] = unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier
		hasQuery = true
	end

	local function ClearQuery()
		query[1], query[2], query[3], query[4], query[5], query[6], query[7] = nil
		hasQuery = false
	end

	local function GetQuery()
		return query[1], query[2], query[3], query[4], query[5], query[6], query[7]
	end

	function IsFallbackAnchorShown()
		return FALLBACK_ANCHOR:IsShown()
	end

	function HookFrame(frame)
		if not IsFrame(frame) then return end
		if hooks[frame] then return end
		hooks[frame] = 1
		frame:HookScript("OnHide", HookHideTooltip)
	end

	function SetAnchor(anchorFrame, frameStrata)
		anchorFrame = IsFrame(anchorFrame) and anchorFrame or FALLBACK_ANCHOR
		ProfileTooltip:SetParent(anchorFrame or FALLBACK_ANCHOR)
		ProfileTooltip:SetOwner(anchorFrame, "ANCHOR_NONE")
		ProfileTooltip:ClearAllPoints()
		ProfileTooltip:SetPoint("TOPLEFT", anchorFrame or FALLBACK_ANCHOR, "TOPRIGHT", 0, 0)
		ProfileTooltip:SetFrameStrata(frameStrata or FALLBACK_ANCHOR_STRATA)
	end

	function SetUserAnchor()
		local p = ns.addonConfig.profilePoint or {}
		ProfileTooltip:SetParent(FALLBACK_FRAME)
		ProfileTooltip:SetOwner(FALLBACK_FRAME, "ANCHOR_NONE")
		ProfileTooltip:ClearAllPoints()
		ProfileTooltip:SetPoint(p.point or "CENTER", FALLBACK_FRAME, p.point or "CENTER", p.x or 0, p.y or 0)
		ProfileTooltip:SetFrameStrata(FALLBACK_FRAME_STRATA)
	end

	function UpdateProfile(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier)
		if unitOrNameOrNameAndRealm == true then
			unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier = GetQuery()
		end
		ProfileTooltip:ClearLines()
		if PopulateProfile(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier) then
			SaveQuery(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier)
			ProfileTooltip:Show()
		else
			ClearQuery()
			ProfileTooltip:Hide()
		end
	end

	function SetDrag(canDrag)
		ProfileTooltip:EnableMouse(canDrag)
		ProfileTooltip:SetMovable(canDrag)
	end
end

function ProfileTooltip.Init()
	-- set or unset the ability to drag the frame around
	SetDrag(not ns.addonConfig.positionProfileAuto and not ns.addonConfig.lockProfile)
	-- if auto is enabled reset the point and anchor to the correct frame
	if ns.addonConfig.positionProfileAuto then
		SetAnchor(FALLBACK_ANCHOR, FALLBACK_ANCHOR_STRATA)
	else
		SetUserAnchor()
	end
end

function ProfileTooltip.SaveConfig()
	-- same procedure as logging in by adjusting drag state and anchor based on preferences
	ProfileTooltip.Init()
	-- update the tooltip visuals in case the profile is visible
	ProfileTooltip.UpdateTooltip()
end

function ProfileTooltip.ToggleLock()
	if ns.addonConfig.positionProfileAuto then
		DEFAULT_CHAT_FRAME:AddMessage(L.WARNING_LOCK_POSITION_FRAME_AUTO, 1, 1, 0)
		return
	end
	if ns.addonConfig.lockProfile then
		DEFAULT_CHAT_FRAME:AddMessage(L.UNLOCKING_PROFILE_FRAME, 1, 1, 0)
	else
		DEFAULT_CHAT_FRAME:AddMessage(L.LOCKING_PROFILE_FRAME, 1, 1, 0)
	end
	ns.addonConfig.lockProfile = not ns.addonConfig.lockProfile
	SetDrag(not ns.addonConfig.lockProfile)
end

function ProfileTooltip.ShowProfile(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, anchorFrame, frameStrata, lfdActivityID, keystoneLevel, forceDisableModifier)
	if not ns.addonConfig.showRaiderIOProfile then
		return
	end
	if anchorFrame then
		HookFrame(anchorFrame)
	end
	if ns.addonConfig.positionProfileAuto then
		SetAnchor(anchorFrame, frameStrata or (anchorFrame and anchorFrame:GetFrameStrata() or FALLBACK_FRAME_STRATA))
	else
		SetUserAnchor()
	end
	UpdateProfile(unitOrNameOrNameAndRealm, realmOrNil, factionOrNil, regionOrNil, lfdActivityID, keystoneLevel, forceDisableModifier)
end

function ProfileTooltip.HideProfile(useFallback)
	if useFallback == true and IsFallbackAnchorShown() then
		if ns.addonConfig.positionProfileAuto then
			SetAnchor(FALLBACK_ANCHOR, FALLBACK_ANCHOR_STRATA)
		else
			SetUserAnchor()
		end
		ProfileTooltip.UpdateTooltip()
	else
		ProfileTooltip:Hide()
	end
end

function ProfileTooltip.UpdateTooltip()
	if ProfileTooltip:IsShown() then
		UpdateProfile(true)
	end
end

-- namespace references
ns.PROFILE_UI = ProfileTooltip

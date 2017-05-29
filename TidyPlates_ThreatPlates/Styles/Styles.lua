local _, ns = ...
local t = ns.ThreatPlates

---------------------------------------------------------------------------------------------------

local function GetGeneral(unit)
	local r, d, e = unit.reaction, unit.isDangerous, unit.isElite
	if unit.isTapped then
		return "Tapped"
	elseif r == "NEUTRAL" then
		return "Neutral"
	elseif r ~= "NEUTRAL" and r~= "TAPPED" then
		if d and e then
			return "Boss"
		elseif not d and e then
			return "Elite"
		elseif not d and not e then
			return "Normal"
		end
	else
		return "empty"
	end
end

local function GetType(unit)
	local db = TidyPlatesThreat.db.profile
	local unitRank
	local totem = ThreatPlates_Totems[unit.name]
	local unique = tContains(db.uniqueSettings.list, unit.name)
	if totem then
		unitRank = "Totem"
	elseif unique then
		for k_c,k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				if db.uniqueSettings[k_c].useStyle then
					unitRank = "Unique"
				else
					unitRank = GetGeneral(unit)
				end
			end
		end
	else
		unitRank = GetGeneral(unit)
	end
	return unitRank
end

local function IsUnitActive(unit)
	return (unit.health < unit.healthmax) or (unit.threatValue > 1) or unit.isMarked	-- or unit.isInCombat
end

-- Returns style based on threat (currently checks for in combat, should not do hat)
local function GetThreatStyle(unit)
	local db = TidyPlatesThreat.db.profile
	local style

	-- style tank/dps only used for NPCs/non-player units
	if InCombatLockdown() and unit.type == "NPC" and db.threat.ON then
		--		if db.threat.toggle[T] then
			if db.threat.nonCombat  then
				-- db.thread.nonCombat not nessessary in following if statement?!?
				if (unit.isInCombat or (unit.health < unit.healthmax)) and db.threat.nonCombat then
					if TidyPlatesThreat:GetSpecRole() then
						style = "tank"
					else
						style = "dps"
					end
				end
			else
				if TidyPlatesThreat:GetSpecRole()	then
					style = "tank"
				else
					style = "dps"
				end
			end
--		end
	end
	if not style then
		style = "normal"
	end

	return style
end

local function SetStyle(unit)
	local db = TidyPlatesThreat.db.profile
	local T = GetType(unit)
	local style, unique_setting

	-- just for alpha feature alphaFeatureHeadlineView
	if t.AlphaFeatureHeadlineView() then
		local hub_style = TidyPlatesHubFunctions.SetStyleNamed(unit)
		if (hub_style == "NameOnly") then
			return "NameOnly"
		end
	end

	if T == "Totem" then
		local tS = db.totemSettings[ThreatPlates_Totems[unit.name]]
		if tS[1] then
			if db.totemSettings.hideHealthbar then
				style = "etotem"
			else
				style = "totem"
			end
		end
	elseif T == "Unique" then
		for k_c,k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				unique_setting = db.uniqueSettings[k_c]
				if unique_setting.showNameplate then
					style = "unique"
				end
			end
		end
	elseif T then
		if unit.reaction == "FRIENDLY" then
			if db.nameplate.toggle[T] then
				style = "normal"
			end
		else
			if db.nameplate.toggle[T] then
				-- style tank/dps only used for NPCs/non-player units, old: unit.class == "UNKNOWN"
				if InCombatLockdown() and unit.type == "NPC" and db.threat.ON then
					if db.threat.toggle[T] then
						if db.threat.nonCombat  then
							-- db.thread.nonCombat not nessessary in following if statement?!?
							if (unit.isInCombat or (unit.health < unit.healthmax)) and db.threat.nonCombat then
								if TidyPlatesThreat:GetSpecRole() then
									style = "tank"
								else
									style = "dps"
								end
							end
						else
							if TidyPlatesThreat:GetSpecRole()	then
								style = "tank"
							else
								style = "dps"
							end
						end
					end
				end
				if not style then
					style = "normal"
				end
			end
		end
	end

	if not style then style = "etotem" end

	return style, unique_setting
end

TidyPlatesThreat.GetGeneral = GetGeneral
TidyPlatesThreat.GetType = GetType
TidyPlatesThreat.SetStyle = SetStyle
TidyPlatesThreat.GetStyle = GetStyle
TidyPlatesThreat.GetThreatStyle = GetThreatStyle

local _
---------
function GoGo_ZoneMapIDMigration()
---------
	-- Migrating the 7.0 zoneIDs to 8.0 mapIDs
	-- Moving from GoGoPrefs.Zones to GoGoPrefs.MapIDs
	
	local iMapID = C_Map.GetBestMapForUnit("player")
	if not iMapID then return end
	
	local iZoneID = GoGo_Variables.ZoneMapID[iMapID] or 0
	
	if not GoGo_Prefs.MapIDs[iMapID] then
		if GoGo_Prefs.Zones and GoGo_Prefs.Zones[iZoneID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		else
			GoGo_Prefs.MapIDs[iMapID] = {}
			GoGo_Prefs.MapIDs[iMapID]["Preferred"] = {}
			GoGo_Prefs.MapIDs[iMapID]["Excluded"] = {}
		end --if
	end --if not GoGo_Prefs.MapIDs....
	
end -- function GoGo_ZoneMapIDMigration()

---------
function GoGo_ZoneCheck()
--------- 
	--Resetting zone flags (if true then don't use)
	GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = true
	GoGo_Variables.ZoneExclude.TheOculus = true
	GoGo_Variables.ZoneExclude.AQ40 = true
	GoGo_Variables.ZoneExclude.ThousandNeedles = true
	GoGo_Variables.ZoneExclude.Draenor_Nagrand = true
	GoGo_Variables.ZoneExclude.CanFly = false
	GoGo_Variables.ZoneExclude.UseMountGroup = nil
	GoGo_Variables.InBattleground = false
	GoGo_Variables.ZoneExclude.LegionZones = true
	GoGo_Variables.Player.MapID = C_Map.GetBestMapForUnit("player")
    GoGo_Variables.ZoneExclude.TheMaw = true
	
	if GoGo_Variables.Debug >= 10 then
		GoGo_DebugAddLine("GoGo_ZoneCheck: Beginning function.")
	end --if
	if GoGo_Variables.Debug >= 5 then
		GoGo_DebugAddLine("GoGo_ChooseMount: Map ID = " .. GoGo_Variables.Player.MapID)
	end --if

	if GoGo_Variables.Player.MapID == 1 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Durotar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 2 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Durotar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 3 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Durotar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 4 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Durotar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 5 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Durotar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 6 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Durotar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 7 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mulgore")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 8 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mulgore")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 9 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mulgore")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 10 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Northern Barrens")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 11 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Northern Barrens")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 12 then  -- The Steam Pools
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for unzoned areas of Kalimdor")
			-- The Veiled Sea (docks outside of Exador waiting for boat)
			-- Wailing Caverns Cave before the instance
			-- Maraudon cavern outside the instance
			-- The Steam Pools
		end --if
		if not IsInInstance() then  -- for Caverns of Time instances
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 13 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for unzoned areas of Eastern Kingdom")
			-- The North Sea south of Isle of Quel'danas from Ironforge
			-- Magister's Terrence (instance)
			-- The Forbidden Sea (east of Loch Modan)
			-- Dread Wastes
		end --if
		if not IsInInstance() then
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 14 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Arathi Highlands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 15 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Badlands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 16 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Badlands -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 17 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blasted Lands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 18 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tristfal Glades")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 19 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tristfal Glades - Scarlet Monestary")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--		GoGo_Variables.ZoneExclude.CanRide = false
--	elseif GoGo_Variables.Player.MapID == 20 then
--		if GoGo_Variables.Debug >= 10 then
--			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monestary (in Tristfal Glades)")
--		end --if
--		GoGo_Variables.ZoneExclude.CanFly = false
--		GoGo_Variables.ZoneExclude.CanRide = false
	elseif GoGo_Variables.Player.MapID == 21 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Silverpine Forest")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 22 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Western Plaguelands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 23 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Eastern Plaguelands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 24 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Eastern Plaguelands -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 25 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hillsbrad Foothills")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 26 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Hinderlands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 27 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dun Morogh")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 28 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dun Morogh -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 29 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dun Morogh -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 30 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dun Morogh -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 31 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dun Morogh -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 32 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Searing Gorge")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 33 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Searing Gorge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 34 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Searing Gorge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 35 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Searing Gorge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 36 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Burning Stepps")
			-- Blackrock Mountains
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 37 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Elwynn Forest")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 38 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Elwynn Forest -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 39 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Elwynn Forest -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 40 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Elwynn Forest -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 42 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deadwind Pass")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 43 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deadwind Pass")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 44 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deadwind Pass")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 45 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deadwind Pass")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 46 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deadwind Pass")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 47 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Duskwood")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 48 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Loch Modan")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 49 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Redridge Mountains")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 50 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Northern Stranglethorn")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 51 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Swamp of Sorrows")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 52 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Westfall")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 53 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Westfall -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 54 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Westfall -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 55 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Westfall - The Deadmines")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 56 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Wetlands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 57 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Teldrassil")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 58 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Teldrassil -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 59 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Teldrassil -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 60 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Teldrassil -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 61 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Teldrassil -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 62 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Darkshore")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 63 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ashenvale")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 64 then  -- Thousand Needles
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Thousand Needles")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		GoGo_Variables.ZoneExclude.ThousandNeedles = false
	elseif GoGo_Variables.Player.MapID == 65 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stonetalon Mountains")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 66 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Desolace")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 67 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Desolace - unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 68 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Desolace - unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 69 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Feralas")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 70 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dustwallow Marsh")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 71 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaris")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 72 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaris -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 73 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaris -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 74 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaris -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 75 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaris -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 76 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azshara")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 77 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Felwood")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 78 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Un'Goro Crator")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 79 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Un'Goro Crator -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 80 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Moonglade")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 81 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Silithus")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 82 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Silithus -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 83 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Winterspring")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 84 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormwind")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 85 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Orgrimmar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 86 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Orgrimmar --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 87 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ironforge")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 88 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Thunder Bluff")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 89 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Darnassus")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 90 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Undercity")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 91 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Alterac Valley (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
	elseif GoGo_Variables.Player.MapID == 92 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Warsong Gulch (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
	elseif GoGo_Variables.Player.MapID == 93 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Arathi Basin (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
	elseif GoGo_Variables.Player.MapID == 94 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Eversong Woods")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 95 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ghostlands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 96 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ghostlands -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 97 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azuremyst Isle")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 98 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azuremyst Isle -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 99 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azuremyst Isle -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 100 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Peninsula")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 101 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Twisting Nether / BC instances")
		end --if
		if not IsInInstance() then
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 102 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Zangamarsh")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 103 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Exodar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 104 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Valley")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 105 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blade's Edge Mountains")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 106 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Bloodmyst Isle")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 107 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nagrand")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 108 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Terokkar Forest")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 109 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Netherstorm")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 110 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Silvermoon City")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 111 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shattrath")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 112 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Eye Of The Storm (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
	elseif GoGo_Variables.Player.MapID == 113 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Frozen Sea")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 114 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Borean Tundra")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 115 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragonblight")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 116 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Grizzly Hills")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 117 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Howling Fjord")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 118 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ice Crown")
		end --if
		GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = false
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 119 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Sholazar Basin")
		end --if
		GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = false
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 120 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Storm Peaks")
		end --if
		GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = false
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 121 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Zul'Drak")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 122 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Isle of Quel'Danas")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 123 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Wintergrasp")
		end --if
		local _, _, GOGO_WGACTIVE = GetWorldPVPAreaInfo(1)
		if GOGO_WGACTIVE then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Player in Wintergrasp and battle ground is active.")
			end --if
			-- we should be in battle.. can't mount
			GoGo_Variables.ZoneExclude.CanFly = false
		else
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Player in Wintergrasp and battle ground is not active.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 124 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Plaguelands:  The Scarlet Enclave (Deathknight area)")
			-- while phased doing starting quests only?  then shares 23 with EPL
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 125 then
		-- Dalaran
		-- Warcraft 3 / Northrend
		-- Outdoor area
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 126 then
		-- Dalaran
		-- Warcraft 3 / Northrend
		-- Sewers
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 127 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Crystal Song Forest")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 128 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Strand Of The Ancients (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
--	elseif GoGo_Variables.Player.MapID == 129 then
	elseif GoGo_Variables.Player.MapID == 130 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Culling Of Stratholme (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 131 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Culling Of Stratholme (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 132 then
--	elseif GoGo_Variables.Player.MapID == 133 then
--	elseif GoGo_Variables.Player.MapID == 134 then
--	elseif GoGo_Variables.Player.MapID == 135 then
--	elseif GoGo_Variables.Player.MapID == 136 then
--	elseif GoGo_Variables.Player.MapID == 137 then
--	elseif GoGo_Variables.Player.MapID == 138 then
--	elseif GoGo_Variables.Player.MapID == 139 then
--	elseif GoGo_Variables.Player.MapID == 140 then
	elseif GoGo_Variables.Player.MapID == 141 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Eye of Eternity (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 142 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Occulus (instance)")
		end --if
		GoGo_Variables.ZoneExclude.TheOculus = false
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 143 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Occulus (instance)")
		end --if
		GoGo_Variables.ZoneExclude.TheOculus = false
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 144 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Occulus (instance)")
		end --if
		GoGo_Variables.ZoneExclude.TheOculus = false
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 145 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Occulus (instance)")
		end --if
		GoGo_Variables.ZoneExclude.TheOculus = false
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 146 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Occulus (instance)")
		end --if
		GoGo_Variables.ZoneExclude.TheOculus = false
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 147 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 148 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 149 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 150 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 151 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 152 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 153 then
--	elseif GoGo_Variables.Player.MapID == 154 then
	elseif GoGo_Variables.Player.MapID == 155 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Obsidian Sanctum (25 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 156 then
--	elseif GoGo_Variables.Player.MapID == 157 then
--	elseif GoGo_Variables.Player.MapID == 158 then
--	elseif GoGo_Variables.Player.MapID == 159 then
--	elseif GoGo_Variables.Player.MapID == 160 then
--	elseif GoGo_Variables.Player.MapID == 161 then
	elseif GoGo_Variables.Player.MapID == 162 then
		-- Naxxaramas
		-- North West (Golem) wing
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Naxxaramas (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 163 then
		-- Naxxaramas
		-- North East (Spider) wing
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Naxxaramas (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 164 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Naxxaramas (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 165 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Naxxaramas (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 166 then
		-- Naxxaramas
		-- First level (entering the instance)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Naxxaramas (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 167 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Naxxaramas (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 168 then
	elseif GoGo_Variables.Player.MapID == 169 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Isle of Conquest (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
	elseif GoGo_Variables.Player.MapID == 170 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hrothgar's Landing")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 171 then
--	elseif GoGo_Variables.Player.MapID == 172 then
--	elseif GoGo_Variables.Player.MapID == 173 then
	elseif GoGo_Variables.Player.MapID == 174 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost Isles")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 175 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 176 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 177 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 178 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 179 then
--	elseif GoGo_Variables.Player.MapID == 180 then
--	elseif GoGo_Variables.Player.MapID == 181 then
--	elseif GoGo_Variables.Player.MapID == 182 then
--	elseif GoGo_Variables.Player.MapID == 183 then
--	elseif GoGo_Variables.Player.MapID == 184 then
--	elseif GoGo_Variables.Player.MapID == 185 then
	elseif GoGo_Variables.Player.MapID == 186 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 187 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 188 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 189 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 190 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 191 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 192 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 193 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Icecrown Citadel (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 194 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kezan (Goblin starting area)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 195 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kezan (Goblin starting area) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 196 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kezan (Goblin starting area) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 197 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kezan (Goblin starting area) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 198 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mount Hyjal")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 199 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Southern Barrons")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 200 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Ruby Sanctum")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 201 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kelp'thar Forest")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 202 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gilneas")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 203 then
	elseif GoGo_Variables.Player.MapID == 204 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Abyssal Depths")
		end --if
		if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.DarkbreakCove then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / Darkbreak Cove.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.Lghorek then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / L'ghorek.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.TenebrousCavern then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / Tenebrous Cavern.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.TheCerebrillum then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / The Cerebrillum.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		else
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Abyssal Depths (not in known no fly area).")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 205 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shimmering Expanse")
		end --if
		if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.Nespirah then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Shimmering Expanse / Nesphirah.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		else
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Shimmering Expanse (and not in known no fly area).")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 206 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Twin Peaks (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
	elseif GoGo_Variables.Player.MapID == 207 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deepholm")
		end --if
		if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Crumbling Depths / .")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.MiniSubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		else
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 208 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deepholm")
		end --if
		if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Crumbling Depths / .")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.MiniSubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		else
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 209 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deepholm")
		end --if
		if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Crumbling Depths / .")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.MiniSubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug >= 10 then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
		else
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif GoGo_Variables.Player.MapID == 210 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Cape of Stranglethorn")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 213 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ragefire Chasm (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 217 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Ruins Of Gilneas")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 218 then
	elseif GoGo_Variables.Player.MapID == 219 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Zul'Farak (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 220 then
	elseif GoGo_Variables.Player.MapID == 221 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackfathom Deeps (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 222 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackfathom Deeps (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 223 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackfathom Deeps (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 224 then
	elseif GoGo_Variables.Player.MapID == 225 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormwind Stockade (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 226 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gnomeregan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 227 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gnomeregan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 228 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gnomeregan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 229 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gnomeregan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 230 then
--	elseif GoGo_Variables.Player.MapID == 231 then
	elseif GoGo_Variables.Player.MapID == 232 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Molten Core (40 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 233 then
	elseif GoGo_Variables.Player.MapID == 234 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 235 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 236 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 237 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 238 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 239 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 240 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dire Maul (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 241 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Twilight Highlands")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 242 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Depths (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 243 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Depths (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 244 then  -- Tol Barad Peninsula
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tol Barad")
		end --if
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 601)
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 245 then  -- Tol Barad
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tol Barad Peninsula")
		end --if
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 600)
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 246 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Shattered Halls")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 247 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Ruins Of Ahn'Qiraj (10 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 248 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Onyxia's Lair (10 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 249 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Uldum")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 250 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Spire (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 251 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Spire (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 252 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Spire (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 253 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Spire (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 254 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Spire (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 255 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Spire (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 256 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Auchenai Crypts (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 257 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Auchenai Crypts (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 258 then
		-- Sethekk Halls
		-- Bottom level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Sethekk Halls (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 259 then
		-- Sethekk Halls
		-- Top level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Sethekk Halls (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 260 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadow Labrynth (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 261 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Blood Furnace (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 262 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Underbog (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 263 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Steamvault (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 264 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Steamvault (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 265 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Slave Pens (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 266 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Botanica (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 267 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Mechanar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 268 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Mechanar (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 269 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Arcatraz (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 270 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Arcatraz (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 271 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Arcatraz (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 272 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mana Tombs (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 273 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Black Morass (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 274 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Old Hillsbrad (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 275 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Lost City Of The Battle for Gilneas (battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.InBattleground = true
--	elseif GoGo_Variables.Player.MapID == 276 then
	elseif GoGo_Variables.Player.MapID == 277 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Lost City Of The Tol'vir (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 279 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Wailing Caverns (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 280 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Maraudon (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 281 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Maraudon (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 282 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Baradin Hold (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 283 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Caverns? (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 284 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackrock Caverns? (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 285 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackwing Descent (10 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 286 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackwing Descent (10 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 287 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackwing Lair (40 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 288 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackwing Lair (40 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 289 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackwing Lair (40 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 290 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Blackwing Lair (40 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 291 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Deadmines (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 292 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Deadmines (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 293 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Grim Batol (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 294 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Bastion of Twilight (10 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 295 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Bastion of Twilight (10 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 296 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Bastion of Twilight (10 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 297 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost City of Tol'Vir (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 298 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost City of Tol'Vir (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 299 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Lost City of Tol'Vir (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 300 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Razorfen Downs (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 301 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Razorfen Krawl (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 302 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monastery (5 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 303 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monastery (5 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 304 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monastery (5 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 305 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monastery (5 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 306 then
--	elseif GoGo_Variables.Player.MapID == 307 then
--	elseif GoGo_Variables.Player.MapID == 308 then
--	elseif GoGo_Variables.Player.MapID == 309 then
	elseif GoGo_Variables.Player.MapID == 310 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 311 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 312 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 313 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 314 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 315 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 316 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowfang Keep (heroic) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 317 then
--	elseif GoGo_Variables.Player.MapID == 318 then
	elseif GoGo_Variables.Player.MapID == 319 then  -- AQ40
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ahn'Qiraj (AQ40) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.ZoneExclude.AQ40 = false
	elseif GoGo_Variables.Player.MapID == 320 then  -- AQ40
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ahn'Qiraj (AQ40) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.ZoneExclude.AQ40 = false
	elseif GoGo_Variables.Player.MapID == 321 then  -- AQ40
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ahn'Qiraj (AQ40) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.ZoneExclude.AQ40 = false
	elseif GoGo_Variables.Player.MapID == 322 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of the Tides (5 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 323 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of the Tides (5 man instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 324 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stonecore (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 325 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Vortex Pinnacle")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.ZoneExclude.UseMountGroup = 500
	elseif GoGo_Variables.Player.MapID == 327 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ahn'Qiraj: The Fallen Kingdom")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 328 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne Of The Four Winds (10 player instance")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 329 then
	elseif GoGo_Variables.Player.MapID == 330 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gruul's Lair (25 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 331 then
	elseif GoGo_Variables.Player.MapID == 332 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Serpentshrine Caverns")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 333 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Zul'Aman (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 334 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tempest Keep (25 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 335 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Sunwell Plateau (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 336 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Sunwell Plateau (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 337 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Zul'Gurub (5 player instance")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 338 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Molten Front (Firelands quest area)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 339 then
		-- Black Temple - Illidari Training Grounds
		-- 25 player instance in Shadowmoon Valley (Burning Crusade)
		-- Second area
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple - Illidari Training Grounds")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 340 then
		-- Black Temple - Karabor Sewers
		-- 25 player instance in Shadowmoon Valley (Burning Crusade)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple - Karabor Sewers")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 341 then
		-- Black Temple - Sanctuary of Shadows
		-- 25 player instance in Shadowmoon Valley (Burning Crusade)
		-- Third area
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple - Sanctuary of Shadows")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 342 then
		-- Black Temple - Halls of Anguish
		-- 25 player instance in Shadowmoon Valley (Burning Crusade)
		-- Fourth area
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple - Halls of Anguish")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 343 then
		-- Black Temple - Gorefiend's Vigil
		-- 25 player instance in Shadowmoon Valley (Burning Crusade)
		-- Fifth area
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple - Gorefiend's Vigil")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 344 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 345 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 346 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 347 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Ramparts (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 348 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Magister's Terrace (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 349 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Magister's Terrace (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 350 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 351 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 352 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 353 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 354 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 355 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 356 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 357 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 358 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 359 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 360 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 361 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 362 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 363 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 364 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 365 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 366 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Karazhan (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 367 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Firelands (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 368 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Firelands (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 369 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Firelands (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 370 then
		-- entered as part of the legendary quest - might be the same as the regular nexus instance
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Nexus (5 player instance")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 371 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Jade Forest -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 372 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Jade Forest -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 373 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Jade Forest -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 374 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Jade Forest -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 375 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Jade Forest -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 376 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Valley of the Four Winds -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 377 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Valley of the Four Winds -- unknown")
			-- Stormstout Brewery using the same zone id?  (instanced scene)
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 378 then
	elseif GoGo_Variables.Player.MapID == 379 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 380 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 381 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 382 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 383 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 384 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 385 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 386 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 387 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kun-Lai Summit -- unknown")
			-- Serpent's Spine
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 388 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Townlong Steppes -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 389 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Townlong Steppes -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 390 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Vale of Eternal Blossoms -- unknown")
			-- Mogu'shan Palace
			-- Shrine of Seven Stars?
			-- Shrine of Two Moons
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 391 then
		-- Enterance level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shrine of Two Moons")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 392 then
		-- Second level (bank, portals, etc.)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shrine of Two Moons")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 393 then
		-- Enterance level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shrine of Seven Stars")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 394 then
		-- Second level (bank, portals, etc.)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shrine of Seven Stars")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 395 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Vale of Eternal Blossoms -- unknown")
			-- Mogu'shan Palace
			-- Shrine of Seven Stars?
			-- Shrine of Two Moons
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 396 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Vale of Eternal Blossoms -- unknown")
			-- Mogu'shan Palace
			-- Shrine of Seven Stars?
			-- Shrine of Two Moons
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 397 then
	elseif GoGo_Variables.Player.MapID == 398 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Well of Eternity (5 player instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 399 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hour of Twilight (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 400 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hour of Twilight (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 401 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for End Time (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 402 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for End Time (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 403 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for End Time (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 404 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for End Time (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 405 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for End Time (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 406 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for End Time (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 407 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Darkmoon Island -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 408 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Darkmoon Island -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 409 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 410 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 411 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 412 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 413 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 414 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 415 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dragon Soul (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 416 then
	elseif GoGo_Variables.Player.MapID == 417 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Temple of Kotmogu (10 player battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 418 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krasarang Wilds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 419 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krasarang Wilds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 420 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krasarang Wilds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 421 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krasarang Wilds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 422 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dread Wastes")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 423 then
	elseif GoGo_Variables.Player.MapID == 424 then
		-- New zone for Stormwind City??
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormwind City")
		end --if
--		if GoGo_InBook(GoGo_Variables.Localize.WisdomOfTheFourWinds) then
--			GoGo_Variables.ZoneExclude.CanFly = true
--		end --if
	elseif GoGo_Variables.Player.MapID == 425 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Northshire -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 426 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Northshire -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 427 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Coldridge Valley -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 428 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Coldridge Valley -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 429 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Temple of the Jade Serpent (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 430 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Temple of the Jade Serpent (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 431 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Halls (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 432 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Halls (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 433 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Veiled Stair -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 434 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Veiled Stair -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 435 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monastery (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 436 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Scarlet Monastery (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 437 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gate of the Setting Sun (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 438 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gate of the Setting Sun (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 439 then
--	elseif GoGo_Variables.Player.MapID == 440 then
--	elseif GoGo_Variables.Player.MapID == 441 then
--	elseif GoGo_Variables.Player.MapID == 442 then
	elseif GoGo_Variables.Player.MapID == 443 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shado-Pan Monastery (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 444 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shado-Pan Monastery (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 445 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shado-Pan Monastery (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 446 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shado-Pan Monastery (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 447 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for A Brewing Storm (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 448 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Jade Forest (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 449 then
	elseif GoGo_Variables.Player.MapID == 450 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Unga Ingoo (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 451 then
	elseif GoGo_Variables.Player.MapID == 452 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Brewmoon Festival (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 453 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mogu'shan Palace (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 454 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mogu'shan Palace (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 455 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mogu'shan Palace (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 456 then
	elseif GoGo_Variables.Player.MapID == 457 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege of Niuzao Temple (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 458 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege of Niuzao Temple (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 459 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege of Niuzao Temple (5 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 460 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowglen")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 461 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowglen")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 462 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Camp Narache")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 463 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Echo Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 464 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Echo Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 465 then
--	elseif GoGo_Variables.Player.MapID == 466 then
	elseif GoGo_Variables.Player.MapID == 467 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Sunstrider Isle")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
--	elseif GoGo_Variables.Player.MapID == 468 then
	elseif GoGo_Variables.Player.MapID == 469 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for New Tinkertown -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 470 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for New Tinkertown -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.MapID == 471 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mogu'shan Vaults (25 player raid) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 472 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mogu'shan Vaults (25 player raid) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 473 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mogu'shan Vaults (25 player raid) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 474 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Heart of Fear (25 player raid) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 475 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Heart of Fear (25 player raid) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
--	elseif GoGo_Variables.Player.MapID == 476 then
--	elseif GoGo_Variables.Player.MapID == 477 then
--	elseif GoGo_Variables.Player.MapID == 478 then
--	elseif GoGo_Variables.Player.MapID == 479 then
	elseif GoGo_Variables.Player.MapID == 480 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Proving Grounds (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 481 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Crypt of Forgotten Kings (3 player scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 482 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Crypt of Forgotten Kings (3 player scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 483 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dustwallow Marsh (scenario - 85)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 486 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krasarang Wilds (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 487 then
--	elseif GoGo_Variables.Player.MapID == 488 then
--	elseif GoGo_Variables.Player.MapID == 489 then
	elseif GoGo_Variables.Player.MapID == 490 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 491 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 492 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 493 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 494 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 495 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 496 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 497 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Black Temple (1 player scenario - Warlock quest) --  unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 498 then
	elseif GoGo_Variables.Player.MapID == 499 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deeprun Tram -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 500 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deeprun Tram -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 501 then
--	elseif GoGo_Variables.Player.MapID == 502 then
	elseif GoGo_Variables.Player.MapID == 503 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Brawl'gar Arena")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 504 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Isle of Thunder -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 505 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Isle of Thunder -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 506 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Isle of Thunder -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 507 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Isle of Giants")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 508 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 509 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 510 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 511 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 512 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 513 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 514 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 515 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Throne of Thunder (10 / 25 player instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 516 then
--	elseif GoGo_Variables.Player.MapID == 517 then
	elseif GoGo_Variables.Player.MapID == 518 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Thunder King's Citadel (1 player scenario)")
			-- single player scenario from key obtained during thunder king isle dailies
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 519 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Deepwind Gorge (Battleground)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
	elseif GoGo_Variables.Player.MapID == 520 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Vale of Eternal Blossoms (3 player scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 521 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Vale of Eternal Blossoms (3 player scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 522 then
	elseif GoGo_Variables.Player.MapID == 523 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dun Morogh - Shimmer Ridge (3 player scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 524 then
	elseif GoGo_Variables.Player.MapID == 525 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 526 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 527 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 528 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 529 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 530 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 531 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 532 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 533 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Frostfire Ridge -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 534 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaan Jungle")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 535 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Talador")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 536 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Talador -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 537 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Talador -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 538 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Talador -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 539 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Valley")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 540 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Valley - unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true--		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 541 then
		-- May also include Lunar Fall before garrison is setup
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Valley")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true--		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 542 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Spires of Arak")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 543 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 544 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 545 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 546 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 547 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 548 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 549 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Gorgrond -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 550 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nagrand")
		end --if
		GoGo_Variables.ZoneExclude.Draenor_Nagrand = false
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 551 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nagrand -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.Draenor_Nagrand = false
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 552 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nagrand -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.Draenor_Nagrand = false
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 553 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nagrand -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.Draenor_Nagrand = false
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 554 then
		-- shows Temperal Anomaly buff showing no-flying for the main island
		-- areas in the water around the island allows for flying even with the Temperal Anomaly buff
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Timeless Isle -- unknown")
		end --if
		-- shows Temperal Anomaly buff showing no-flying for the main island
		-- areas in the water around the island allows for flying even with the Temperal Anomaly buff
		-- using IsFlyableArea() for now as the only other method to determine non-flyable area right now is drawing out co-ordinates similar to Dalaran before IsFlyableArea() was introduced
		if IsFlyableArea() then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 555 then
		-- shows Temperal Anomaly buff showing no-flying for the main island
		-- areas in the water around the island allows for flying even with the Temperal Anomaly buff
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Timeless Isle -- unknown")
		end --if
		-- shows Temperal Anomaly buff showing no-flying for the main island
		-- areas in the water around the island allows for flying even with the Temperal Anomaly buff
		-- using IsFlyableArea() for now as the only other method to determine non-flyable area right now is drawing out co-ordinates similar to Dalaran before IsFlyableArea() was introduced
		if IsFlyableArea() then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 556 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 557 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 558 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 559 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 560 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 561 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 562 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 563 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 564 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 565 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 566 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 567 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 568 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 569 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 570 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Siege Of Orgrimmar (raid instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 571 then
	elseif GoGo_Variables.Player.MapID == 572 then
		-- instanced version of Ashran which replaced the phased world Ashran (mapID 588 / 589) with Warcraft 7.0
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ashran (instace)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 573 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Bloodmaul Slag Mines (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 574 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Burial Grounds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false   -- can't fly here yet in WoD
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 575 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Burial Grounds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false   -- can't fly here yet in WoD
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 576 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Shadowmoon Burial Grounds -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false   -- can't fly here yet in WoD
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 577 then
		-- Tanaan Jungle - Kargathar Proving Grounds   --- Area behind the dark portal for Horde during initial WoD quests entering WoD
		-- On PTR, character did not have achievement for flying and did not have spell purchased since that comes from the vendor.  On live, players might have achievement and might be able to fly here..
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaan Jungle -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false   -- can't fly here yet in WoD
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 578 then
		-- Tanaan Jungle - Kargathar Proving Grounds   --- Area behind the dark portal for Horde during initial WoD quests entering WoD
		-- On PTR, character did not have achievement for flying and did not have spell purchased since that comes from the vendor.  On live, players might have achievement and might be able to fly here..
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tanaan Jungle -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false   -- can't fly here yet in WoD
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 579 then
		-- Alliance Garrison
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Lunarfall -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 580 then
		-- Alliance Garrison
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Lunarfall -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 581 then
		-- Alliance Garrison ??
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Lunarfall -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 582 then
		-- Alliance Garrison (3)
		-- Lunarfall
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Lunarfall (Garrison)")
		end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 585 then
		-- Horde Garrison
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Quazzik's Outpost -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 586 then
		-- Horde Garrison
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Quazzik's Outpost -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 587 then
		-- Horde Garrison
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Quazzik's Outpost -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 588 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ashran -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 589 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ashran -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 590 then
		-- Horde Garrison zone before building Garrison
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Horde Garrison zone before building Garrison")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 592 then
	elseif GoGo_Variables.Player.MapID == 593 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Auchindoun (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 594 then
	elseif GoGo_Variables.Player.MapID == 595 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Iron Docks (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 596 then
--	elseif GoGo_Variables.Player.MapID == 597 then
--	elseif GoGo_Variables.Player.MapID == 598 then
--	elseif GoGo_Variables.Player.MapID == 599 then
--	elseif GoGo_Variables.Player.MapID == 600 then
	elseif GoGo_Variables.Player.MapID == 601 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Skyreach (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 602 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Skyreach (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 606 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Grimrail Depot (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 607 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Grimrail Depot (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 608 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Grimrail Depot (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 609 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Grimrail Depot (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 610 then
--	elseif GoGo_Variables.Player.MapID == 611 then
--	elseif GoGo_Variables.Player.MapID == 612 then
--	elseif GoGo_Variables.Player.MapID == 613 then
--	elseif GoGo_Variables.Player.MapID == 614 then
--	elseif GoGo_Variables.Player.MapID == 615 then
	elseif GoGo_Variables.Player.MapID == 616 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hall of Blackhand (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 617 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hall of Blackhand (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 618 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hall of Blackhand (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 619 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Broken Shore - The Veiled Isles")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 620 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Everbloom (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 621 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Everbloom (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 622 then
		-- Alliance part of Ashran
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Stormshield")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 623 then
	elseif GoGo_Variables.Player.MapID == 624 then
		-- Horde part of Ashran
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Warspear")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 625 then
		-- Dalaran 7.0 (Legion)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 626 then
		-- Dalaran 7.0 (Legion)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 627 then
		-- Dalaran 7.0 (Legion)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 628 then
		-- Dalaran 7.0 (Legion) Underbelly
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran - Underbelly")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
		GoGo_Variables.MountDB[220124][10002] = 200
		GoGo_Variables.MountDB[220124][7] = true
		GoGo_Variables.MountDB[220124][8] = true
	elseif GoGo_Variables.Player.MapID == 629 then
		-- Dalaran 7.0 (Legion)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dalaran -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 630 then -- Subtelty Rogue scenario
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azsuna")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 631 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azsuna unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 632 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azsuna unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 633 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azsuna unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 634 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 635 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 636 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 637 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 638 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 639 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 640 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormheim -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 641 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Val'sharah")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 642 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Val'sharah unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 643 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Val'sharah unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 644 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Val'sharah unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 645 then
	elseif GoGo_Variables.Player.MapID == 646 then
		-- Broken Isles - Rooms used for scenarios as part of the various class specific quests
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Broken Isles")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 647 then
		-- Broken Isles - Rooms used for scenarios as part of the various class specific quests
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Broken Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 648 then
		-- Broken Isles - Rooms used for scenarios as part of the various class specific quests
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Broken Isles -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 650 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 651 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 652 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 653 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 654 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 655 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 656 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 657 then
		-- Highmountain cave near south-west end
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Path of Huln - Neltharion's Vault (Highmountain)")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 658 then
		-- Highmountain cave near south-west end
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Path of Huln - The Slave Enclave (Highmountain)")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 659 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 660 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Highmountain -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 661 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 662 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 663 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 664 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 665 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 666 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 667 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 668 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 669 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 670 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hellfire Citadel (instance) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 671 then
--	elseif GoGo_Variables.Player.MapID == 672 then
--	elseif GoGo_Variables.Player.MapID == 673 then
--	elseif GoGo_Variables.Player.MapID == 674 then
--	elseif GoGo_Variables.Player.MapID == 675 then
--	elseif GoGo_Variables.Player.MapID == 676 then
--	elseif GoGo_Variables.Player.MapID == 677 then
--	elseif GoGo_Variables.Player.MapID == 678 then
--	elseif GoGo_Variables.Player.MapID == 679 then
	elseif GoGo_Variables.Player.MapID == 680 then -- DH havoc artifact
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 681 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 682 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 683 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 684 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 685 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar (Cave)")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 686 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 687 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 688 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 689 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 690 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 691 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 692 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 693 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Suramar -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 694 then
--	elseif GoGo_Variables.Player.MapID == 695 then
--	elseif GoGo_Variables.Player.MapID == 696 then
--	elseif GoGo_Variables.Player.MapID == 697 then
--	elseif GoGo_Variables.Player.MapID == 698 then
--	elseif GoGo_Variables.Player.MapID == 699 then
--	elseif GoGo_Variables.Player.MapID == 700 then
--	elseif GoGo_Variables.Player.MapID == 701 then
--	elseif GoGo_Variables.Player.MapID == 702 then
	elseif GoGo_Variables.Player.MapID == 703 then
		-- 5 player instance
		-- Halls of Valor - Fields of the Eternal Hunt
		-- East end, outdoors, ground mounts allowed
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Halls of Valor - Fields of the Eternal Hunt")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 704 then
		-- 5 player instance
		-- Halls of Valor - Hearth of Revelry
		-- last part of the instance leading up to the final boss
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Halls of Valor - Hearth of Revelry")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 705 then
--	elseif GoGo_Variables.Player.MapID == 706 then
--	elseif GoGo_Variables.Player.MapID == 707 then
--	elseif GoGo_Variables.Player.MapID == 708 then
--	elseif GoGo_Variables.Player.MapID == 709 then
--	elseif GoGo_Variables.Player.MapID == 710 then
--	elseif GoGo_Variables.Player.MapID == 711 then
--	elseif GoGo_Variables.Player.MapID == 712 then
	elseif GoGo_Variables.Player.MapID == 713 then
		-- 5 player instance in Azuna
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Eye of Azshara (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 714 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Niskara (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 715 then
--	elseif GoGo_Variables.Player.MapID == 716 then
--	elseif GoGo_Variables.Player.MapID == 717 then
--	elseif GoGo_Variables.Player.MapID == 718 then
	elseif GoGo_Variables.Player.MapID == 719 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mardum, the Shattered Abyss -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 720 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mardum, the Shattered Abyss -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 721 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mardum, the Shattered Abyss -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 723 then
		-- Broken Isles version of Dalaran - The Violet Hold instance (scenario) for mages starting their quest line for the 7.0 expansion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Violet Hold")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 725 then
--	elseif GoGo_Variables.Player.MapID == 726 then
--	elseif GoGo_Variables.Player.MapID == 728 then
--	elseif GoGo_Variables.Player.MapID == 729 then
	elseif GoGo_Variables.Player.MapID == 731 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Neltharion's Lair (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 732 then
	elseif GoGo_Variables.Player.MapID == 733 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Darkheart Thicket (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 734 then
		-- Mage hangout area in (Broken Isles) Dalaran
		-- Lower level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hall of the Guardian")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 735 then
		-- Mage hangout area in (Broken Isles) Dalaran
		-- Upper level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Hall of the Guardian")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 736 then
--	elseif GoGo_Variables.Player.MapID == 737 then
--	elseif GoGo_Variables.Player.MapID == 738 then
	elseif GoGo_Variables.Player.MapID == 739 then
		-- Hunter's Hall
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Trueshot Lodge")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true	
--	elseif GoGo_Variables.Player.MapID == 740 then
--	elseif GoGo_Variables.Player.MapID == 741 then
--	elseif GoGo_Variables.Player.MapID == 742 then
--	elseif GoGo_Variables.Player.MapID == 743 then
	elseif GoGo_Variables.Player.MapID == 744 then
		-- The Ulduar scenario as part of the quest line for the pre-release events to Warcraft 7.0 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 745 then
		-- The Ulduar scenario as part of the quest line for the pre-release events to Warcraft 7.0 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 746 then
		-- The Ulduar scenario as part of the quest line for the pre-release events to Warcraft 7.0 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Ulduar (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 747 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Dreamgrove")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
--	elseif GoGo_Variables.Player.MapID == 748 then
--	elseif GoGo_Variables.Player.MapID == 749 then
	elseif GoGo_Variables.Player.MapID == 750 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Thunder Totem")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true	
--	elseif GoGo_Variables.Player.MapID == 751 then
--	elseif GoGo_Variables.Player.MapID == 752 then
--	elseif GoGo_Variables.Player.MapID == 753 then
--	elseif GoGo_Variables.Player.MapID == 754 then
--	elseif GoGo_Variables.Player.MapID == 755 then
--	elseif GoGo_Variables.Player.MapID == 756 then
--	elseif GoGo_Variables.Player.MapID == 757 then
--	elseif GoGo_Variables.Player.MapID == 758 then
--	elseif GoGo_Variables.Player.MapID == 759 then
--	elseif GoGo_Variables.Player.MapID == 760 then
	elseif GoGo_Variables.Player.MapID == 761 then
		-- Court of Stars (5 player instance)
		-- First area entering the instance
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Court of Stars (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 762 then
		-- Court of Stars (5 player instance)
		-- Inside a building (talking to people) bottom floor
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Court of Stars (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 763 then
		-- Court of Stars (5 player instance)
		-- Inside a building (talking to people) top floor
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Court of Stars (instance)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 764 then
--	elseif GoGo_Variables.Player.MapID == 765 then
--	elseif GoGo_Variables.Player.MapID == 766 then
--	elseif GoGo_Variables.Player.MapID == 767 then
--	elseif GoGo_Variables.Player.MapID == 768 then
--	elseif GoGo_Variables.Player.MapID == 769 then
--	elseif GoGo_Variables.Player.MapID == 770 then
--	elseif GoGo_Variables.Player.MapID == 771 then
--	elseif GoGo_Variables.Player.MapID == 772 then
--	elseif GoGo_Variables.Player.MapID == 773 then
--	elseif GoGo_Variables.Player.MapID == 774 then
	elseif GoGo_Variables.Player.MapID == 775 then
		-- Single player scenario
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Exodar (scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 776 then
--	elseif GoGo_Variables.Player.MapID == 777 then
--	elseif GoGo_Variables.Player.MapID == 778 then
--	elseif GoGo_Variables.Player.MapID == 779 then
--	elseif GoGo_Variables.Player.MapID == 780 then
--	elseif GoGo_Variables.Player.MapID == 781 then
--	elseif GoGo_Variables.Player.MapID == 782 then
--	elseif GoGo_Variables.Player.MapID == 783 then
--	elseif GoGo_Variables.Player.MapID == 784 then
--	elseif GoGo_Variables.Player.MapID == 785 then
--	elseif GoGo_Variables.Player.MapID == 786 then
--	elseif GoGo_Variables.Player.MapID == 787 then
--	elseif GoGo_Variables.Player.MapID == 788 then
--	elseif GoGo_Variables.Player.MapID == 789 then
--	elseif GoGo_Variables.Player.MapID == 790 then
--	elseif GoGo_Variables.Player.MapID == 791 then
--	elseif GoGo_Variables.Player.MapID == 792 then
--	elseif GoGo_Variables.Player.MapID == 793 then
	elseif GoGo_Variables.Player.MapID == 794 then
		-- The Kharazan scenario as part of the quest line for the pre-release events to Warcraft 7 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kharazan (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 795 then
		-- The Kharazan scenario as part of the quest line for the pre-release events to Warcraft 7 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kharazan (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 796 then
		-- The Kharazan scenario as part of the quest line for the pre-release events to Warcraft 7 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kharazan (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 797 then
		-- The Kharazan scenario as part of the quest line for the pre-release events to Warcraft 7 - Legion
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Kharazan (scenario) -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 798 then
--	elseif GoGo_Variables.Player.MapID == 799 then
--	elseif GoGo_Variables.Player.MapID == 800 then
--	elseif GoGo_Variables.Player.MapID == 801 then
--	elseif GoGo_Variables.Player.MapID == 802 then
--	elseif GoGo_Variables.Player.MapID == 803 then
--	elseif GoGo_Variables.Player.MapID == 804 then
--	elseif GoGo_Variables.Player.MapID == 805 then
--	elseif GoGo_Variables.Player.MapID == 806 then
--	elseif GoGo_Variables.Player.MapID == 807 then
--	elseif GoGo_Variables.Player.MapID == 808 then
--	elseif GoGo_Variables.Player.MapID == 809 then
--	elseif GoGo_Variables.Player.MapID == 810 then
--	elseif GoGo_Variables.Player.MapID == 811 then
--	elseif GoGo_Variables.Player.MapID == 812 then
--	elseif GoGo_Variables.Player.MapID == 813 then
--	elseif GoGo_Variables.Player.MapID == 814 then
--	elseif GoGo_Variables.Player.MapID == 815 then
--	elseif GoGo_Variables.Player.MapID == 816 then
--	elseif GoGo_Variables.Player.MapID == 817 then
--	elseif GoGo_Variables.Player.MapID == 818 then
--	elseif GoGo_Variables.Player.MapID == 819 then
--	elseif GoGo_Variables.Player.MapID == 820 then
--	elseif GoGo_Variables.Player.MapID == 821 then
--	elseif GoGo_Variables.Player.MapID == 822 then
--	elseif GoGo_Variables.Player.MapID == 823 then
--	elseif GoGo_Variables.Player.MapID == 824 then
--	elseif GoGo_Variables.Player.MapID == 825 then
--	elseif GoGo_Variables.Player.MapID == 826 then
--	elseif GoGo_Variables.Player.MapID == 827 then
--	elseif GoGo_Variables.Player.MapID == 828 then
--	elseif GoGo_Variables.Player.MapID == 829 then
	elseif GoGo_Variables.Player.MapID == 830 then
		-- Krokuun
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krokuun -- unknown")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 831 then
		-- Krokuun - Top level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krokuun - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 832 then
		-- Krokuun - Bottom level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krokuun - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 833 then
		-- Krokuun - Nath'raxas Spire
		-- North end of Krokuun zone
		-- Indoors area
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Krokuun - Nath'raxas Spire")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
--	elseif GoGo_Variables.Player.MapID == 834 then
--	elseif GoGo_Variables.Player.MapID == 835 then
--	elseif GoGo_Variables.Player.MapID == 836 then
--	elseif GoGo_Variables.Player.MapID == 837 then
--	elseif GoGo_Variables.Player.MapID == 838 then
--	elseif GoGo_Variables.Player.MapID == 839 then
--	elseif GoGo_Variables.Player.MapID == 840 then
--	elseif GoGo_Variables.Player.MapID == 841 then
--	elseif GoGo_Variables.Player.MapID == 842 then
--	elseif GoGo_Variables.Player.MapID == 843 then
--	elseif GoGo_Variables.Player.MapID == 844 then
--	elseif GoGo_Variables.Player.MapID == 845 then
--	elseif GoGo_Variables.Player.MapID == 846 then
--	elseif GoGo_Variables.Player.MapID == 847 then
--	elseif GoGo_Variables.Player.MapID == 848 then
--	elseif GoGo_Variables.Player.MapID == 849 then
--	elseif GoGo_Variables.Player.MapID == 850 then
--	elseif GoGo_Variables.Player.MapID == 851 then
--	elseif GoGo_Variables.Player.MapID == 852 then
--	elseif GoGo_Variables.Player.MapID == 853 then
--	elseif GoGo_Variables.Player.MapID == 854 then
--	elseif GoGo_Variables.Player.MapID == 855 then
--	elseif GoGo_Variables.Player.MapID == 856 then
--	elseif GoGo_Variables.Player.MapID == 857 then
	elseif GoGo_Variables.Player.MapID == 858 then
		-- Assult on Broken Shore
		-- Single player instance opening up the Broken Shore island
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Assult on Broken Shore")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 859 then
--	elseif GoGo_Variables.Player.MapID == 860 then
--	elseif GoGo_Variables.Player.MapID == 861 then
--	elseif GoGo_Variables.Player.MapID == 862 then
	elseif GoGo_Variables.Player.MapID == 862 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Zuldazar")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 863 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nazmir")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end
	elseif GoGo_Variables.Player.MapID == 864 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Voldun")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end
--	elseif GoGo_Variables.Player.MapID == 865 then
--	elseif GoGo_Variables.Player.MapID == 866 then
--	elseif GoGo_Variables.Player.MapID == 867 then
--	elseif GoGo_Variables.Player.MapID == 868 then
--	elseif GoGo_Variables.Player.MapID == 869 then
--	elseif GoGo_Variables.Player.MapID == 870 then
--	elseif GoGo_Variables.Player.MapID == 871 then
--	elseif GoGo_Variables.Player.MapID == 872 then
--	elseif GoGo_Variables.Player.MapID == 873 then
--	elseif GoGo_Variables.Player.MapID == 874 then
--	elseif GoGo_Variables.Player.MapID == 875 then
	elseif GoGo_Variables.Player.MapID == 876 then
		-- Great Sea
		-- Overall area covering Kul'Tiras
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Great Sea")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
		GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 877 then
--	elseif GoGo_Variables.Player.MapID == 878 then
--	elseif GoGo_Variables.Player.MapID == 879 then
--	elseif GoGo_Variables.Player.MapID == 880 then
--	elseif GoGo_Variables.Player.MapID == 881 then
	elseif GoGo_Variables.Player.MapID == 882 then
		-- Mac'Aree
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mac'Aree")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 883 then
		-- Mac'Aree - Top level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mac'Aree - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 884 then
		-- Mac'Aree - Bottom level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mac'Aree - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 885 then
		-- Krokuun - Top level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Antoran Wastes - Hope's Landing")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 886 then
		-- Krokuun - Top level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Antoran Wastes - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 887 then
		-- Krokuun - Bottom level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Antoran Wastes - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 888 then
		-- ----
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for -- (scenario)")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
--	elseif GoGo_Variables.Player.MapID == 889 then
--	elseif GoGo_Variables.Player.MapID == 890 then
	elseif GoGo_Variables.Player.MapID == 891 then
		-- Azuremyst Isle
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azuremyst Isle")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 892 then
		-- Exodar (Quest version)
		-- Quest line leading to the opening (access) to Argus zones
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Exodar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 893 then
		-- Azuremyst Isle - The Vindicaar
		-- Top level
		-- The ship after accepting the quest in Exodor before the cut scene (traveling to Argus)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azuremyst Isle - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 894 then
		-- Azuremyst Isle - The Vindicaar
		-- Bottom level
		-- The ship after accepting the quest in Exodor before the cut scene (traveling to Argus)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Azuremyst Isle - The Vindicaar")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 895 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tiragarde Sound")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
		GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 896 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Boralus Drustvar")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
		GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 897 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Deaths of Chromie")
		end --if
		GoGo_Variables.ZoneExclude.LegionZones = false
		if GoGo_InBook(GoGo_Variables.Localize.BrokenIslesPathFinder) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 907 then
		-- No mounting
		-- Starting area after using character level boost token (Warrior)
		-- On an Alliance air ship
		-- Parent map is Kalimdor
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Seething Shore")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 942 then
		-- Will probably be flyable in the future
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormsong Valley")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
		GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1021 then
		-- Instance / Scenario starting BfA (Getting the Azeroth heart necklace)
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Chamber of Heart")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 1161 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Boralus Harbor - Tradewinds Market")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
		GoGo_Variables.ZoneExclude.CanFly = false
		end --if
	elseif GoGo_Variables.Player.MapID == 1163 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Great Seal")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1165 then
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Dazar'alor")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1169 then
		-- Island with prison
		-- Starting Warcraft 8.0
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tol Dagor")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1171 then
		-- Tiragarde Sound - Gol Thovas
		-- Indoor cave
		-- Bottom level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tiragarde Sound - Gol Thovas")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 1172 then
		-- Tiragarde Sound - Gol Thovas
		-- Indoor cave
		-- Top level
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Tiragarde Sound - Gol Thovas")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		-- can ride = false
	elseif GoGo_Variables.Player.MapID == 1183 then
		-- Stormsong Valley - Thornheart
		-- Outdoor area
		-- South part of the zone
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Stormsong Valley - Thornheart")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1355 then
		-- Nazjatar
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Nazjatar")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
		GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1462 then
		-- Mechagon
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Mechagon")
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.BfaPathFinder2) then
			GoGo_Variables.ZoneExclude.CanFly = true
		else
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1527 then
		-- Uldum - N'Zoth
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Uldum - N'Zoth")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1530 then
		-- Shrine of Seven Stars - 8.3
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Uldum - N'Zoth")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = true
		-- can ride = true
	elseif GoGo_Variables.Player.MapID == 1543 then  -- Jumping into the Maw
		if GoGo_Variables.Debug >= 10
		then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Maw")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.ZoneExclude.TheMaw = false
	elseif GoGo_Variables.Player.MapID == 1648 then  -- The Maw
		if GoGo_Variables.Debug >= 10
		then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for The Maw")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false
		GoGo_Variables.ZoneExclude.TheMaw = false
	elseif GoGo_Variables.Player.MapID == 1670 then
		-- Oribos
		if GoGo_Variables.Debug >= 10 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Setting up for Oribos")
		end --if
		GoGo_Variables.ZoneExclude.CanFly = false

--	elseif GoGo_Variables.Player.ZoneID == -1 then
		-- Arenas:
		-- -- Nagrand Arena
		-- -- Ruins of Lordaeron
		-- Quests:
		-- -- Draenor / Talador:  Remains of Xandros
--		if GoGo_Variables.Debug >= 4 then
--			GoGo_DebugAddLine("GoGo_ZoneCheck: Arena??? - " .. GoGo_Variables.Player.ZoneID)
--		end --if
	else
		if GoGo_Variables.Debug >= 4 then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Unknown zone ID.  Showing debug information.")
			GoGo_DebugCollectInformation()
		end --if
	end --if
	
	if IsIndoors() then	-- indoor zone exclusions go here
		GoGo_Variables.ZoneExclude.RestrictedIndoorMounts = true -- restricting mounts to indoor mounts only unless something below says otherwise
	else
		GoGo_Variables.ZoneExclude.RestrictedIndoorMounts = false
	end --if
end --function

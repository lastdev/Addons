local QNumberLocal = 0
local AAP_ArrowUpdateNr = 0
local ETAStep = 0
local AAP_AntiTaxiLoop = 0
local Updateblock = 0
local HBDP = LibStub("HereBeDragons-Pins-2.0")
local HBD = LibStub("HereBeDragons-2.0")
local AAPWhereToGo
local CurMapShown
local Delaytime = 0
local AAPGOSSIPCOUNT = 0
local QuestSpecial57710 = 0
local Quest2Special57710 = 0
AAP.GossipOpen = 0
AAP.BookingList = {}
AAP.HBDP = HBDP
AAP.HBD = HBD
AAP.ProgressbarIgnore = {
	["60520-2"] = 1,
	["57724-2"] = 1,
}
local AAP_HSSpellIDs = {
	[8690] = 1,
	[298068] = 1,
	[278559] = 1,
	[278244] = 1,
	[286331] = 1,
	[286353] = 1,
	[94719] = 1,
	[285424] = 1,
	[286031] = 1,
	[285362] = 1,
	[136508] = 1,
	[75136] = 1,
	[39937] = 1,
	[231504] = 1,
	[308742] = 1,
}
local AAP_GigglingBasket = {
	["One time, I managed to trick all the sylvari in a grove into thinking I was a member of their court! The other spriggans were all cheering my name for days!"] = "cheer",
	["Spriggans have our share of heroes too! The great hero Hollain was said to be able to split a mountain with a single thrust of his spear. Oh, to see such a display! How strong he must have been!"] = "flex",
	["Many seek us for our talents, but few can actually earn them. Some give gifts, always gratefully accepted. Some try to outwit us, usually failing. Some ask permission, and always thank us for our trouble."] = "thank",
	["The fae courts are very big on manners, you know. The slightest lapse in decorum can have... devastating consequences. Introductions are an important part of first impressions!"] = "introduce",
	["Oh, my feet are practically jumping with excitement! I could just dance for an eternity! Dance with me!"] = "dance",
	["We do so much to help out the people of the lands. I'm sure you've heard the stories. Mending shoes, growing fields, reuniting lost loves. But what do we get in return? Not so much as a word of praise! Hmph!"] = "praise",
}
local AAP_BonusObj = {
---- WoD Bonus Obj ----
	[36473] = 1,
	[36500] = 1,
	[36504] = 1,
	[34724] = 1,
	[36564] = 1,
	[34496] = 1,
	[36603] = 1,
	[35881] = 1,
	[37422] = 1,
	[34667] = 1,
	[36480] = 1,
	[36563] = 1,
	[36520] = 1,
	[35237] = 1,
	[34639] = 1,
	[34660] = 1,
	[36792] = 1,
	[35649] = 1,
	[36660] = 1,
---- Legion Bonus Obj ----
	[36811] = 1,
	[37466] = 1,
	[37779] = 1,
	[37965] = 1,
	[37963] = 1,
	[37495] = 1,
	[39393] = 1,
	[38842] = 1,
	[43241] = 1,
	[38748] = 1,
	[38716] = 1,
	[39274] = 1,
	[39576] = 1,
	[39317] = 1,
	[39371] = 1,
	[42373] = 1,
	[40316] = 1,
	[38442] = 1,
	[38343] = 1,
	[38939] = 1,
	[39998] = 1,
	[38374] = 1,
	[39119] = 1,
	[9785] = 1,
---- Duskwood ----
	[26623] = 1,
---- Hillsbrad Foothills ----
	[28489] = 1,
--- DH Start Area ----
	[39279] = 1,
	[39742] = 1,
---- BFA Bonus Obj ----
	[50005] = 1,
	[50009] = 1,
	[50080] = 1,
	[50448] = 1,
	[50133] = 1,
	[51534] = 1,
	[50779] = 1,
	[49739] = 1,
	[51689] = 1,
	[50497] = 1,
	[48093] = 1,
	[47996] = 1,
	[48934] = 1,
	[49315] = 1,
	[48852] = 1,
	[49406] = 1,
	[48588] = 1,
	[47756] = 1,
	[49529] = 1,
	[49300] = 1,
	[47797] = 1,
	[49315] = 1,
	[50178] = 1,
	[49918] = 1,
	[47527] = 1,
	[47647] = 1,
	[51900] = 1,
	[50805] = 1,
	[48474] = 1,
	[48525] = 1,
	[45972] = 1,
	[47969] = 1,
	[48181] = 1,
	[48680] = 1,
	[50091] = 1,
---- Shadowlands ----
	[60840] = 1,
	[59211] = 1,
	[62732] = 1,
	[62735] = 1,
	[59015] = 1,
}
local MapRects = {};
local TempVec2D = CreateVector2D(0,0);
local function GetPlayerMapPos(MapID, dx, dy)
	if (MapID and MapID == 1726 or MapID == 1727 or AAPt_Zone == 1727) then
		return
	end
	--if (UnitPosition('Player')) then
	--	return
	--end
    local R,P,_ = MapRects[MapID],TempVec2D;
    if not R then
        R = {};
        _, R[1] = C_Map.GetWorldPosFromMapPos(MapID,CreateVector2D(0,0));
        _, R[2] = C_Map.GetWorldPosFromMapPos(MapID,CreateVector2D(1,1));
        R[2]:Subtract(R[1]);
        MapRects[MapID] = R;
    end
	if (dx) then
		P.x, P.y = dx, dy
	else
		P.x, P.y = UnitPosition('Player');
	end
	if (P.x) then
		P:Subtract(R[1]);
		return (1/R[2].y)*P.y, (1/R[2].x)*P.x;
	else
		return
	end
end
function AAP.RemoveIcons()
	for CLi = 1, 20 do
		if (AAP["Icons"][CLi].A == 1) then
			AAP["Icons"][CLi].A = 0
			AAP["Icons"][CLi].P = 0
			AAP["Icons"][CLi].D = 0
			AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
		end
	end
end
function AAP.RemoveMapIcons()
	for CLi = 1, 20 do
		if (AAP["MapIcons"][CLi].A == 1) then
			AAP["MapIcons"][CLi].A = 0
			AAP["MapIcons"][CLi].P = 0
			AAP["MapIcons"][CLi].D = 0
			AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
		end
	end
end
function AAP:MoveIcons()
	local d_y, d_x = UnitPosition("player")
	if (IsInInstance() or AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowBlobs"] == 0 or not d_y) then
		AAP.RemoveIcons()
		return
	end
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local ix, iy
	if (AAP.SettingsOpen == 1 and C_Map.GetBestMapForUnit('player')) then
		ix, iy = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'), AAP.ArrowActive_Y, AAP.ArrowActive_X)
	elseif (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		local d_y, d_x = UnitPosition("player")
		if (steps and steps["TT"] and d_y and C_Map.GetBestMapForUnit('player')) then
			ix, iy = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'), steps["TT"]["y"],steps["TT"]["x"])
		else
			return
		end
	else
		return
	end
	local steps
	if (AAP.SettingsOpen == 1) then
		steps = {}
		steps["TT"] = {}
		steps["TT"]["y"] = AAP.ArrowActive_Y
		steps["TT"]["x"] = AAP.ArrowActive_X
	else
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	end
	if (steps["CRange"]) then
		local CLi
		local totalCR = 1
		if (AAP.QuestStepList[AAP.ActiveMap][CurStep+1] and AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["CRange"]) then
			totalCR = 3
		end
		if (not C_Map.GetBestMapForUnit('player')) then
			return
		end
		local px, py = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'))
		if (not px) then
			return
		end
		local CLi, CLi2
		for CLi = 1, 20 do
			local px2, py2
			px2 = px - ix
			py2 = py - iy
			if (AAP["Icons"][CLi]["A"] == 1 and (AAP["Icons"][CLi]["D"] == 0 or AAP["Icons"][CLi]["D"] == 1)) then
				AAP["Icons"][CLi]["P"] = AAP["Icons"][CLi]["P"] + 0.02
				local test = 0.2
				if (AAP["Icons"][CLi]["P"] > 0.399 and AAP["Icons"][CLi]["P"] < 0.409) then
					local set = 0
					for CLi2 = 1, 20 do
						if (set == 0 and AAP["Icons"][CLi2]["A"] == 0) then
							AAP["Icons"][CLi2]["A"] = 1
							AAP["Icons"][CLi2]["D"] = 1
							set = 1
						end
					end
				end
				if (AAP["Icons"][CLi].P < 1) then
					px2 = px - px2 * AAP["Icons"][CLi]["P"]
					py2 = py - py2 * AAP["Icons"][CLi]["P"]
					AAP["Icons"][CLi]["D"] = 1
					AAP.HBDP:AddMinimapIconMap("AAP", AAP["Icons"][CLi], C_Map.GetBestMapForUnit('player'), px2, py2, true, true)
				else
					AAP["Icons"][CLi]["A"] = 1
					AAP["Icons"][CLi]["P"] = 0
					AAP["Icons"][CLi]["D"] = 2
					AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
				end
			end
		end
		if (not C_Map.GetBestMapForUnit('player')) then
			return
		end
		local px, py = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'), AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]["x"])
		local CLi, CLi2
		if (not AAP.QuestStepList[AAP.ActiveMap][CurStep+1]) then
			for CLi = 1, 20 do
				AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
			end
		else
			if (not C_Map.GetBestMapForUnit('player')) then
				return
			end
			local ix, iy = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'), AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["x"])
			for CLi = 1, 20 do
				local px2, py2
				px2 = px - ix
				py2 = py - iy
				if (AAP["Icons"][CLi]["A"] == 1 and (AAP["Icons"][CLi]["D"] == 0 or AAP["Icons"][CLi]["D"] == 2)) then
					AAP["Icons"][CLi]["P"] = AAP["Icons"][CLi]["P"] + 0.02
					local test = 0.2

					if (AAP["Icons"][CLi].P < 1) then
						px2 = px - px2 * AAP["Icons"][CLi]["P"]
						py2 = py - py2 * AAP["Icons"][CLi]["P"]
						AAP["Icons"][CLi]["D"] = 2
						AAP.HBDP:AddMinimapIconMap("AAP", AAP["Icons"][CLi], C_Map.GetBestMapForUnit('player'), px2, py2, true, true)
					else
						AAP["Icons"][CLi]["A"] = 0
						AAP["Icons"][CLi]["P"] = 0
						if (totalCR == 3) then
							AAP["Icons"][CLi]["A"] = 1
							AAP["Icons"][CLi]["D"] = 3
						elseif (totalCR == 2) then
							AAP["Icons"][CLi]["D"] = 1
						elseif (totalCR == 1) then
							AAP["Icons"][CLi]["D"] = 1
						end
						AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
					end
				end
			end
		end
		if (totalCR == 3) then
			if (not C_Map.GetBestMapForUnit('player')) then
				return
			end
			local px, py = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'), AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["x"])
			local CLi, CLi2
			local ix, iy = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'), AAP.QuestStepList[AAP.ActiveMap][CurStep+2]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep+2]["TT"]["x"])
			for CLi = 1, 20 do
				local px2, py2
				px2 = px - ix
				py2 = py - iy
				if (AAP["Icons"][CLi]["A"] == 1 and (AAP["Icons"][CLi]["D"] == 0 or AAP["Icons"][CLi]["D"] == 3)) then
					AAP["Icons"][CLi]["P"] = AAP["Icons"][CLi]["P"] + 0.02
					local test = 0.2

					if (AAP["Icons"][CLi].P < 1) then
						px2 = px - px2 * AAP["Icons"][CLi]["P"]
						py2 = py - py2 * AAP["Icons"][CLi]["P"]
						AAP["Icons"][CLi]["D"] = 3
						AAP.HBDP:AddMinimapIconMap("AAP", AAP["Icons"][CLi], C_Map.GetBestMapForUnit('player'), px2, py2, true, true)
					else
						AAP["Icons"][CLi]["A"] = 0
						AAP["Icons"][CLi]["P"] = 0
						AAP["Icons"][CLi]["D"] = 0
						AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
					end
				end
			end
		end
	else
		if (not C_Map.GetBestMapForUnit('player')) then
			return
		end
		local px, py = GetPlayerMapPos(C_Map.GetBestMapForUnit('player'))
		local CLi, CLi2
		for CLi = 1, 20 do
			if (not px) then
				AAP["Icons"][CLi]["A"] = 0
				AAP["Icons"][CLi]["P"] = 0
				AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
			else
				local px2, py2
				px2 = px - ix
				py2 = py - iy
				if (AAP["Icons"][CLi]["A"] == 1) then
					AAP["Icons"][CLi]["P"] = AAP["Icons"][CLi]["P"] + 0.02
					local test = 0.2
					if (AAP["Icons"][CLi]["P"] > 0.39 and AAP["Icons"][CLi]["P"] < 0.41) then
						local set = 0
						for CLi2 = 1, 20 do
							if (set == 0 and AAP["Icons"][CLi2]["A"] == 0) then
								AAP["Icons"][CLi2]["A"] = 1
								set = 1
							end
						end
					end
					if (AAP["Icons"][CLi].P < 1) then
						px2 = px - px2 * AAP["Icons"][CLi]["P"]
						py2 = py - py2 * AAP["Icons"][CLi]["P"]
						AAP.HBDP:AddMinimapIconMap("AAP", AAP["Icons"][CLi], C_Map.GetBestMapForUnit('player'), px2, py2, true, true)
					else
						AAP["Icons"][CLi]["A"] = 0
						AAP["Icons"][CLi]["P"] = 0
						AAP.HBDP:RemoveMinimapIcon("AAP", AAP["Icons"][CLi])
					end
				end
			end
		end
	end
end
local function AAP_MapDelay()
	Delaytime = 0
end
function AAP:MoveMapIcons()
	local d_y, d_x = UnitPosition("player")
	if (IsInInstance() or AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowMapBlobs"] == 0 or not d_y) then
		return
	end
	if (Delaytime == 1) then
		return
	end
	if (WorldMapFrame:GetMapID() and WorldMapFrame:GetMapID() == 946) then
		return
	end
	if (CurMapShown ~= WorldMapFrame:GetMapID()) then
		CurMapShown = WorldMapFrame:GetMapID()
		Delaytime = 1
		C_Timer.After(0.1, AAP_MapDelay)
		return
	end
	local SetMapIDs = WorldMapFrame:GetMapID()
	if (SetMapIDs == nil) then
		SetMapIDs = C_Map.GetBestMapForUnit("player")
	end
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local ix, iy
	if (AAP.SettingsOpen == 1) then
		return
	elseif (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		if (steps and steps["TT"]) then
			if (not SetMapIDs) then
				return
			end
			ix, iy = GetPlayerMapPos(SetMapIDs, steps["TT"]["y"],steps["TT"]["x"])
		else
			return
		end
	else
		return
	end
	local steps
	if (AAP.SettingsOpen == 1) then
		return
	else
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	end
	if (steps["CRange"]) then
		local CLi
		local totalCR = 1
		if (AAP.QuestStepList[AAP.ActiveMap][CurStep+1] and AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["CRange"]) then
			totalCR = 3
		end
		if (not SetMapIDs) then
			return
		end
		local px, py = GetPlayerMapPos(SetMapIDs)
		if (not px) then
			return
		end
		local CLi, CLi2
		for CLi = 1, 20 do
			local px2, py2
			px2 = px - ix
			py2 = py - iy
			if (AAP["MapIcons"][CLi]["A"] == 1 and (AAP["MapIcons"][CLi]["D"] == 0 or AAP["MapIcons"][CLi]["D"] == 1)) then
				AAP["MapIcons"][CLi]["P"] = AAP["MapIcons"][CLi]["P"] + 0.02
				local test = 0.2
				if (AAP["MapIcons"][CLi]["P"] > 0.399 and AAP["MapIcons"][CLi]["P"] < 0.409) then
					local set = 0
					for CLi2 = 1, 20 do
						if (set == 0 and AAP["MapIcons"][CLi2]["A"] == 0) then
							AAP["MapIcons"][CLi2]["A"] = 1
							AAP["MapIcons"][CLi2]["D"] = 1
							set = 1
						end
					end
				end
				if (AAP["MapIcons"][CLi].P < 1) then
					px2 = px - px2 * AAP["MapIcons"][CLi]["P"]
					py2 = py - py2 * AAP["MapIcons"][CLi]["P"]
					AAP["MapIcons"][CLi]["D"] = 1
					AAP.HBDP:AddWorldMapIconMap("AAPMap", AAP["MapIcons"][CLi], SetMapIDs, px2, py2, HBD_PINS_WORLDMAP_SHOW_PARENT)
				else
					AAP["MapIcons"][CLi]["A"] = 1
					AAP["MapIcons"][CLi]["P"] = 0
					AAP["MapIcons"][CLi]["D"] = 2
					AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
				end
			end
		end
		if (not SetMapIDs) then
			return
		end
		local px, py = GetPlayerMapPos(SetMapIDs, AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]["x"])
		local CLi, CLi2
		if (not AAP.QuestStepList[AAP.ActiveMap][CurStep+1]) then
			for CLi = 1, 20 do
				AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
			end
		else
			if (not SetMapIDs) then
				return
			end
			local ix, iy = GetPlayerMapPos(SetMapIDs, AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["x"])
			for CLi = 1, 20 do
				local px2, py2
				px2 = px - ix
				py2 = py - iy
				if (AAP["MapIcons"][CLi]["A"] == 1 and (AAP["MapIcons"][CLi]["D"] == 0 or AAP["MapIcons"][CLi]["D"] == 2)) then
					AAP["MapIcons"][CLi]["P"] = AAP["MapIcons"][CLi]["P"] + 0.02
					local test = 0.2

					if (AAP["MapIcons"][CLi].P < 1) then
						px2 = px - px2 * AAP["MapIcons"][CLi]["P"]
						py2 = py - py2 * AAP["MapIcons"][CLi]["P"]
						AAP["MapIcons"][CLi]["D"] = 2
						AAP.HBDP:AddWorldMapIconMap("AAPMap", AAP["MapIcons"][CLi], SetMapIDs, px2, py2, HBD_PINS_WORLDMAP_SHOW_PARENT)
					else
						AAP["MapIcons"][CLi]["A"] = 0
						AAP["MapIcons"][CLi]["P"] = 0
						if (totalCR == 3) then
							AAP["MapIcons"][CLi]["A"] = 1
							AAP["MapIcons"][CLi]["D"] = 3
						elseif (totalCR == 2) then
							AAP["MapIcons"][CLi]["D"] = 1
						elseif (totalCR == 1) then
							AAP["MapIcons"][CLi]["D"] = 1
						end
						AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
					end
				end
			end
		end
		if (totalCR == 3) then
			if (not SetMapIDs) then
				return
			end
			local px, py = GetPlayerMapPos(SetMapIDs, AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep+1]["TT"]["x"])
			local CLi, CLi2
			local ix, iy = GetPlayerMapPos(SetMapIDs, AAP.QuestStepList[AAP.ActiveMap][CurStep+2]["TT"]["y"],AAP.QuestStepList[AAP.ActiveMap][CurStep+2]["TT"]["x"])
			for CLi = 1, 20 do
				local px2, py2
				px2 = px - ix
				py2 = py - iy
				if (AAP["MapIcons"][CLi]["A"] == 1 and (AAP["MapIcons"][CLi]["D"] == 0 or AAP["MapIcons"][CLi]["D"] == 3)) then
					AAP["MapIcons"][CLi]["P"] = AAP["MapIcons"][CLi]["P"] + 0.02
					local test = 0.2

					if (AAP["MapIcons"][CLi].P < 1) then
						px2 = px - px2 * AAP["MapIcons"][CLi]["P"]
						py2 = py - py2 * AAP["MapIcons"][CLi]["P"]
						AAP["MapIcons"][CLi]["D"] = 3
						AAP.HBDP:AddWorldMapIconMap("AAPMap", AAP["MapIcons"][CLi], SetMapIDs, px2, py2, HBD_PINS_WORLDMAP_SHOW_PARENT)
					else
						AAP["MapIcons"][CLi]["A"] = 0
						AAP["MapIcons"][CLi]["P"] = 0
						AAP["MapIcons"][CLi]["D"] = 0
						AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
					end
				end
			end
		end
	else
		if (not SetMapIDs) then
			return
		end
		local px, py = GetPlayerMapPos(SetMapIDs)
		local CLi, CLi2
		for CLi = 1, 20 do
			if (not px) then
				AAP["MapIcons"][CLi]["A"] = 0
				AAP["MapIcons"][CLi]["P"] = 0
				AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
			else
				local px2, py2
				px2 = px - ix
				py2 = py - iy
				if (AAP["MapIcons"][CLi]["A"] == 1) then
					AAP["MapIcons"][CLi]["P"] = AAP["MapIcons"][CLi]["P"] + 0.02
					local test = 0.2
					if (AAP["MapIcons"][CLi]["P"] > 0.39 and AAP["MapIcons"][CLi]["P"] < 0.41) then
						local set = 0
						for CLi2 = 1, 20 do
							if (set == 0 and AAP["MapIcons"][CLi2]["A"] == 0) then
								AAP["MapIcons"][CLi2]["A"] = 1
								set = 1
							end
						end
					end
					if (AAP["MapIcons"][CLi].P < 1) then
						px2 = px - px2 * AAP["MapIcons"][CLi]["P"]
						py2 = py - py2 * AAP["MapIcons"][CLi]["P"]
						AAP.HBDP:AddWorldMapIconMap("AAPMap", AAP["MapIcons"][CLi], SetMapIDs, px2, py2, HBD_PINS_WORLDMAP_SHOW_PARENT)
					else
						AAP["MapIcons"][CLi]["A"] = 0
						AAP["MapIcons"][CLi]["P"] = 0
						AAP.HBDP:RemoveWorldMapIcon("AAPMap", AAP["MapIcons"][CLi])
					end
				end
			end
		end
	end
end

AAP.DubbleMacro = {}
AAP.ButtonList = {}
AAP.BreadCrumSkips = {}
AAP.SetButtonVar = nil
AAP.ButtonVisual = nil
local function AAP_SettingsButtons()
	local CLi
	for CLi = 1, 3 do
		local CL_Items, clt2, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(6948)
		AAP.QuestList2["BF"..CLi]["AAP_Buttonptex"]:SetTexture(CL_ItemTex)
		AAP.QuestList2["BF"..CLi]["AAP_Buttonntex"]:SetTexture(CL_ItemTex)
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetNormalTexture(CL_ItemTex)
		AAP.QuestList2["BF"..CLi]["AAP_Button"]:SetText("")
		local Topz = AAP1[AAP.Realm][AAP.Name]["Settings"]["left"]
		local Topz2 = AAP1[AAP.Realm][AAP.Name]["Settings"]["top"]
		AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Topz, Topz2)
		AAP.QuestList2["BF"..CLi]:SetPoint("BOTTOMLEFT", AAP.QuestList21, "BOTTOMLEFT",0,-((CLi * 38)+CLi))
		AAP.QuestList2["BF"..CLi]:Show()
	end
end
function AAP.ChkBreadcrums(qids)
	if (qids and AAP.Breadcrums and AAP.Breadcrums[qids]) then
		for AAP_index,AAP_value in pairs(AAP.Breadcrums[qids]) do
			if ((AAP.ActiveQuests[AAP_value] or C_QuestLog.IsQuestFlaggedCompleted(AAP_value) == true) and (not AAP.ActiveQuests[qids])) then
				AAP.BreadCrumSkips[qids] = qids
			end
		end
	end
end
local function AAP_SendGroup()
	if (IsInGroup(LE_PARTY_CATEGORY_HOME) and AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] and (AAP.LastSent ~= AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]) and (IsInInstance() == false)) then
	
		C_ChatInfo.SendAddonMessage("AAPChat", AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap], "PARTY");
		AAP.LastSent = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	end
end
local function AAP_LeaveQuest(QuestIDs)
	C_QuestLog.SetSelectedQuest(QuestIDs)
	C_QuestLog.AbandonQuest()
end
local function AAP_ExitVhicle()
	VehicleExit()
end

local function AAP_QAskPopWanted()
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local steps
	if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	end
	local Qid = steps["QaskPopup"]
	if (C_QuestLog.IsQuestFlaggedCompleted(Qid) == true) then
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
		AAP.BookingList["PrintQStep"] = 1
		AAP.QuestList.SugQuestFrame:Hide()
	elseif (steps["QuestLineSkip"] and AAP1[AAP.Realm][AAP.Name]["QlineSkip"][steps["QuestLineSkip"]] and AAP1[AAP.Realm][AAP.Name]["QlineSkip"][steps["QuestLineSkip"]] == 0) then
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
		AAP.BookingList["PrintQStep"] = 1
	else
		local SugGroupNr = steps["Group"]
		AAP.QuestList.SugQuestFrameFS1:SetText(AAP_Locals["Optional"])
		AAP.QuestList.SugQuestFrameFS2:SetText(AAP_Locals["Suggested Players"]..": "..SugGroupNr)
		AAP.QuestList.SugQuestFrame:Show()
	end
end
function AAP.QAskPopWantedAsk(AAP_answer)
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local steps
	if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	end
	if (AAP_answer == "yes") then
		AAP1[AAP.Realm][AAP.Name]["WantedQuestList"][steps["QaskPopup"]] = 1
		AAP.QuestList.SugQuestFrame:Hide()
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
		AAP.BookingList["PrintQStep"] = 1
	else
		AAP.QuestList.SugQuestFrame:Hide()
		AAP1[AAP.Realm][AAP.Name]["WantedQuestList"][steps["QaskPopup"]] = 0
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
		AAP.BookingList["PrintQStep"] = 1
	end
end
local function AAP_PrintQStep()
	if (AAP1["Debug"]) then
		print("Function: AAP_PrintQStep()")
	end
	if (IsInGroup() and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowGroup"] == 1) then
	elseif (AAP.PartyList.PartyFrames[1]:IsShown()) then
		for CLi = 1, 5 do
			AAP.PartyList.PartyFrames[CLi]:Hide()
			AAP.PartyList.PartyFrames2[CLi]:Hide()
		end
	end
	if (IsInInstance()) then
		for CLi = 1, 5 do
			AAP.PartyList.PartyFrames[CLi]:Hide()
			AAP.PartyList.PartyFrames2[CLi]:Hide()
		end
		AAP.ZoneQuestOrder:Hide()
		return
	elseif (AAP1[AAP.Realm][AAP.Name]["Settings"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQuestListOrder"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQuestListOrder"] == 1) then
		AAP.ZoneQuestOrder:Show()
	end
	if (AAP.ActiveMap and not AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]) then
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = 1
	end
	if (AAP.ZoneTransfer == 1) then
	else
		if (AAP.InCombat == 1) then
			AAP.BookUpdAfterCombat = 1
		end
		local CLi
		for CLi = 1, 10 do
			if (not InCombatLockdown()) then
				if (AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:IsShown()) then
					AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()
				end
				if (AAP.QuestList2["BF"..CLi]:IsShown() and AAP.SettingsOpen ~= 1) then
					AAP.QuestList2["BF"..CLi]:Hide()
				end
			end
		end
	end
	local LineNr = 0
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	-- Extra liners here
	local MissingQs = {}
	if (AAP.Level ~= UnitLevel("player")) then
		AAP.BookingList["UpdateMapId"] = 1
		AAP.Level = UnitLevel("player")
	end
	if (AAP1["Debug"]) then
		print("AAP_PrintQStep() Step:".. CurStep)
	end
	AAP_SendGroup()
	AAP.FP.QuedFP = nil
	if (AAP.SettingsOpen == 1) then
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 0 and AAP.ZoneTransfer == 0) then
			return
		end
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Test Quest number 1")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
		local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
		if (aapwidth and aapwidth > 400) then
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
		else
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
		end
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Test Quest number 2")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
		local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
		if (aapwidth and aapwidth > 400) then
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
		else
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
		end
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Test Quest number 3")
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
		local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
		if (aapwidth and aapwidth > 400) then
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
		else
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
		end
		return
	end
	
	if (AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.ProgressText and AAP.ProgressShown == 1) then
		AAP.QuestList.QuestFrames["MyProgress"]:Show()
		AAP.QuestList.QuestFrames["MyProgressFS"]:SetText(AAP.ProgressText)
	else
		AAP.QuestList.QuestFrames["MyProgress"]:Hide()
	end
	if (AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		local StepP, IdList
		if (AAPExtraText and AAP.ZoneTransfer == 0) then
			if (AAPExtraText.Paths and AAPExtraText.Paths[AAP.ActiveMap] and AAPExtraText.Paths[AAP.ActiveMap][CurStep]) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAPExtraText.Paths[AAP.ActiveMap][CurStep])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
		end
		if (steps and steps["LoaPick"] and steps["LoaPick"] == 123 and ((AAP.ActiveQuests[47440] or C_QuestLog.IsQuestFlaggedCompleted(47440)) or (AAP.ActiveQuests[47439] or C_QuestLog.IsQuestFlaggedCompleted(47439)))) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
			return
		elseif (steps["PickedLoa"] and steps["PickedLoa"] == 2 and (AAP.ActiveQuests[47440] or C_QuestLog.IsQuestFlaggedCompleted(47440))) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
			if (AAP1["Debug"]) then
				print("PickedLoa Skip 2 step:".. CurStep)
			end
			return
		elseif (steps["PickedLoa"] and steps["PickedLoa"] == 1 and (AAP.ActiveQuests[47439] or C_QuestLog.IsQuestFlaggedCompleted(47439))) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
			if (AAP1["Debug"]) then
				print("PickedLoa Skip 1 step:".. CurStep)
			end
			return
		elseif (steps["PickUp"]) then
			StepP = "PickUp"
		elseif (steps["WarMode"]) then
			StepP = "WarMode"
		elseif (steps["DalaranToOgri"]) then
			StepP = "DalaranToOgri"
		elseif (steps["Qpart"]) then
			StepP = "Qpart"
		elseif (steps["Done"]) then
			StepP = "Done"
		elseif (steps["CRange"]) then
			StepP = "CRange"
		elseif (steps["ZonePick"]) then
			StepP = "ZonePick"
		elseif (steps["QpartPart"]) then
			StepP = "QpartPart"
		elseif (steps["DropQuest"]) then
			StepP = "DropQuest"
		elseif (steps["SetHS"]) then
			StepP = "SetHS"
		elseif (steps["UseHS"]) then
			StepP = "UseHS"
		elseif (steps["GetFP"]) then
			StepP = "GetFP"
		elseif (steps["UseFlightPath"]) then
			StepP = "UseFlightPath"
		elseif (steps["QaskPopup"]) then
			StepP = "QaskPopup"
		elseif (steps["Treasure"]) then
			StepP = "Treasure"
		elseif (steps["UseDalaHS"]) then
			StepP = "UseDalaHS"
		elseif (steps["UseGarrisonHS"]) then
			StepP = "UseGarrisonHS"
		elseif (steps["ZoneDone"]) then
			StepP = "ZoneDone"
		elseif (steps["PahonixMadeMe"]) then
			StepP = "TrainRiding"
		end
		if (steps["BreadCrum"]) then
			AAP.ChkBreadcrums(steps["BreadCrum"])
		end
		if (C_QuestLog.IsQuestFlaggedCompleted(47440) == true) then
			AAP1[AAP.Realm][AAP.Name]["LoaPick"] = 1
		elseif (C_QuestLog.IsQuestFlaggedCompleted(47439) == true) then
			AAP1[AAP.Realm][AAP.Name]["LoaPick"] = 2
		end
		if (steps["LeaveQuest"]) then
			AAP_LeaveQuest(steps["LeaveQuest"])
		end
		if (steps["LeaveQuests"]) then
			for AAP_index,AAP_value in pairs(steps["LeaveQuests"]) do
				AAP_LeaveQuest(AAP_value)
			end
		end
		if (AAP1["Debug"]) then
			print(StepP)
		end
		if (steps["ZoneDoneSave"]) then
			local zeMApz
			if (AAP.QuestStepListListing["Shadowlands"][AAP.ActiveMap]) then
				zeMApz = AAP.QuestStepListListing["Shadowlands"][AAP.ActiveMap]
			elseif (AAP.QuestStepListListing["Kalimdor"][AAP.ActiveMap]) then
				zeMApz = AAP.QuestStepListListing["Kalimdor"][AAP.ActiveMap]
			elseif (AAP.QuestStepListListing["SpeedRun"][AAP.ActiveMap]) then
				zeMApz = AAP.QuestStepListListing["SpeedRun"][AAP.ActiveMap]
			elseif (AAP.QuestStepListListing["EasternKingdom"][AAP.ActiveMap]) then
				zeMApz = AAP.QuestStepListListing["EasternKingdom"][AAP.ActiveMap]
			elseif (AAP.QuestStepListListingStartAreas["EasternKingdom"] and AAP.QuestStepListListingStartAreas["EasternKingdom"][AAP.ActiveMap]) then
				zeMApz = AAP.QuestStepListListingStartAreas["EasternKingdom"][AAP.ActiveMap]
			elseif (AAP.QuestStepListListingStartAreas["Kalimdor"] and AAP.QuestStepListListingStartAreas["Kalimdor"][AAP.ActiveMap]) then
				zeMApz = AAP.QuestStepListListingStartAreas["Kalimdor"][AAP.ActiveMap]
			elseif (AAP_Custom[AAP.Name.."-"..AAP.Realm] and AAP_Custom[AAP.Name.."-"..AAP.Realm][AAP.ActiveMap]) then
				zeMApz = AAP_Custom[AAP.Name.."-"..AAP.Realm][AAP.ActiveMap]
			end
			if (zeMApz) then
				AAP_ZoneComplete[AAP.Name.."-"..AAP.Realm][zeMApz] = 1
				for CLi = 1, 19 do
					if (AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:GetText() == zeMApz) then
						AAP.RoutePlan.FG1["Fxz2Custom"..CLi]["FS"]:SetText("")
						AAP.RoutePlan.FG1["Fxz2Custom"..CLi]:Hide()
					end
				end
				AAP.RoutePlanCheckPos()
				AAP.CheckCustomEmpty()
				AAP.BookingList["UpdateMapId"] = 1
			end
		end
		if (steps["SpecialLeaveVehicle"]) then
			C_Timer.After(1, AAP_ExitVhicle)
			C_Timer.After(3, AAP_ExitVhicle)
			C_Timer.After(5, AAP_ExitVhicle)
			C_Timer.After(10, AAP_ExitVhicle)
		end
		if (steps["VehicleExit"]) then
			VehicleExit()
		end
		if (steps["SpecialFlight"] and C_QuestLog.IsQuestFlaggedCompleted(steps["SpecialFlight"])) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
		end
		if (steps["GroupTask"] and AAP1[AAP.Realm][AAP.Name]["WantedQuestList"][steps["GroupTask"]] and AAP1[AAP.Realm][AAP.Name]["WantedQuestList"][steps["GroupTask"]] == 0) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
			return
		end
		if (steps["ETA"] and not steps["UseFlightPath"]) then
			if (ETAStep ~= CurStep) then
				AAP.AFK_Timer(steps["ETA"])
				ETAStep = CurStep
			end
		end
		if (steps["UseGlider"] and AAP.ZoneTransfer == 0) then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Use Item"]..": "..AAP.GliderFunc())
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
		end
		if (steps["Bloodlust"] and AAP.ZoneTransfer == 0) then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["Bloodlust"].." **")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
		end
		if (steps["InVehicle"] and not UnitInVehicle("player") and AAP.ZoneTransfer == 0) then
			LineNr = LineNr + 1
			AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Mount a Horse and scare Spiders")
			AAP.QuestList.QuestFrames[LineNr]:Show()
			AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
			local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
			if (aapwidth and aapwidth > 400) then
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
			else
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
			end
		elseif (steps["InVehicle"] and steps["InVehicle"] == 2 and UnitInVehicle("player") and AAP.ZoneTransfer == 0) then
			LineNr = LineNr + 1
			AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Scare Spiders into the Lumbermill")
			AAP.QuestList.QuestFrames[LineNr]:Show()
			AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
			local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
			if (aapwidth and aapwidth > 400) then
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
			else
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
			end
		end
		if (steps["ExtraActionB"] and AAP.ZoneTransfer == 0) then
			local isFound, macroSlot = AAP.MacroFinder()
			if isFound and macroSlot then
				if (steps["ExtraActionB"] == 6666) then
					AAP.MacroUpdater(macroSlot, 6666666)
				else
					AAP.MacroUpdater(macroSlot, 123123123)
				end
			end
		end
		if (steps["DalaranToOgri"] and AAP.ZoneTransfer == 0) then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["DalaranToOgri"])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
		end
		
		if (AAP.Level > 35 and AAP.Level < 50) then
			if (AAP.ActiveMap and AAP.QuestStepListListing["Shadowlands"][AAP.ActiveMap]) then
				local OnTime = 0
				local ChrimeTimez = C_ChromieTime.GetChromieTimeExpansionOptions()
				for AAP_index,AAP_value in pairs(ChrimeTimez) do
					if (ChrimeTimez[AAP_index] and ChrimeTimez[AAP_index]["id"] and ChrimeTimez[AAP_index]["id"] == 9 and ChrimeTimez[AAP_index]["alreadyOn"] and ChrimeTimez[AAP_index]["alreadyOn"] == true) then
						OnTime = 1
					end
				end
				if (OnTime == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** You are not in Chromie Time!")
					AAP.QuestList.QuestFrames[LineNr]:Show()
				end
			end
		end
		if (steps["DoIHaveFlight"]) then
			if (GetSpellBookItemInfo(GetSpellInfo(33391)) or GetSpellBookItemInfo(GetSpellInfo(90265)) or GetSpellBookItemInfo(GetSpellInfo(34090))) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		
		if (GetSpellBookItemInfo(GetSpellInfo(90265))) then
		elseif (AAP.Level > 39) then
			LineNr = LineNr + 1
			AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** You can now learn Master Riding!")
			AAP.QuestList.QuestFrames[LineNr]:Show()
		elseif (GetSpellBookItemInfo(GetSpellInfo(34090))) then
		elseif (AAP.Level > 29) then
			LineNr = LineNr + 1
			if (AAP.Faction == "Alliance" and AAP.ActiveMap and AAP.ActiveMap == "A543-DesMephisto-Gorgrond") then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("* HS to Stormwind and learn Expert Riding!")
				AAP.QuestList.QuestFrames[LineNr]:Show()
			elseif (AAP.Faction == "Horde" and AAP.ActiveMap and AAP.ActiveMap == "543-DesMephisto-Gorgrond-p1") then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("* HS to Orgrimmar and learn Expert Riding! And get back")
				AAP.QuestList.QuestFrames[LineNr]:Show()
			else
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** You can now learn Expert Riding!")
				AAP.QuestList.QuestFrames[LineNr]:Show()
			end
		elseif (GetSpellBookItemInfo(GetSpellInfo(33391))) then
		elseif (AAP.Level > 19) then
			LineNr = LineNr + 1
			AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** You can now learn Journeyman Riding!")
			AAP.QuestList.QuestFrames[LineNr]:Show()
		elseif (GetSpellBookItemInfo(GetSpellInfo(33388))) then
		elseif (AAP.Level > 9) then
			LineNr = LineNr + 1
			AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** You can now learn Apprentice Riding!")
			AAP.QuestList.QuestFrames[LineNr]:Show()
		end
		if ((steps["ExtraLine"] or steps["ExtraLineText"]) and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
			LineNr = LineNr + 1
			local AAPExtralk = steps["ExtraLine"]
			if (steps["ExtraLineText"]) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..steps["ExtraLineText"])
			end
			if (AAPExtralk == 1) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["HeFlying"].." **")
			end
			if (AAPExtralk == 2) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["ClickShrine"])
			end
			if (AAPExtralk == 3) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Talk to NPC to ride boat"])
			end
			if (AAPExtralk == 4) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Takes little dmg at start1"])
			end
			if (AAPExtralk == 5) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Click 1 Dirt Pile"])
			end
			if (AAPExtralk == 6) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Go Up Elevator"])
			end
			if (AAPExtralk == 7) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Jump off Bridge"])
			end
			if (AAPExtralk == 8) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Jump off"])
			end
			if (AAPExtralk == 9) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["ClickAltar"])
			end
			if (AAPExtralk == 10) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["ClickTotem"])
			end
			if (AAPExtralk == 11) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Kajamite"])
			end
			if (AAPExtralk == 12) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Spices"])
			end
			if (AAPExtralk == 13) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["SeaUrchineBrine"])
			end
			if (AAPExtralk == 14) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["JolPoweder"])
			end
			if (AAPExtralk == 15) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["JolStir"])
			end
			if (AAPExtralk == 16) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["JolNotes"])
			end
			if (AAPExtralk == 17) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["JolHandin"])
			end
			if (AAPExtralk == 18) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["TopOfBoat"])
			end
			if (AAPExtralk == 19) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Dontwaitrun"])
			end
			if (AAPExtralk == 20) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Doesntmatterwep"])
			end
			if (AAPExtralk == 21) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Extracaravans"])
			end
			if (AAPExtralk == 22) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["dotsexpire"])
			end
			if (AAPExtralk == 23) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Banneronstuff"])
			end
			if (AAPExtralk == 24) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["GetSaurolistBuff"])
			end
			if (AAPExtralk == 25) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Get Flight Point"])
			end
			if (AAPExtralk == 26) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Fixed Quest"])
			end
			if (AAPExtralk == 27) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Talk to Princess Talanji"])
			end
			if (AAPExtralk == 28) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Zone Complete"])
			end
			if (AAPExtralk == 29) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Missing quest"])
			end
			if (AAPExtralk == 30) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["waitforportal"].." **")
			end
			if (AAPExtralk == 31) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["WaitforsetHS"].." **")
			end
			if (AAPExtralk == 32) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["BeneathHandin"])
			end
			if (AAPExtralk == 33) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["Totemdmg"].." **")
			end
			if (AAPExtralk == 34) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["WarModeOff"].." **")
			end
			if (AAPExtralk == 35) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["LoaInfo1"])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
			if (AAPExtralk == 35) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..AAP_Locals["LoaInfo2"])
			end
			if (AAPExtralk == 36) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Dontglide"])
			end
			if (AAPExtralk == 37) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Orb on a Canyon Ettin, then save Oslow")
			end
			if (AAPExtralk == 38) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Get Key in cave")
			end
			if (AAPExtralk == 39) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Talk to FlightMaster")
			end
			if (AAPExtralk == 40) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Talk to War-Mage Erallier to teleport")
			end
			if (AAPExtralk == 41) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Leveling Starts in Redridge Mountains")
			end
			if (AAPExtralk == 42) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("NPC is ontop of the tower")
			end
			if (AAPExtralk == 43) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("*** Open the Cannary's Cache Bag to continue!")
			end
			if (AAPExtralk == 44) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("*** disguise yourself as a plant close by the murlocs")
			end
			if (AAPExtralk == 45) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("*** Use Pheromones Close by Mosshide Representative")
			end
			if (AAPExtralk == 46) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Command Board")
			end
			if (AAPExtralk == 47) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal To Undercity on top of the tower")
			end
			if (AAPExtralk == 48) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Don't skip video")
			end
			if (AAPExtralk == 49) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Dalaran Crater Portal")
			end
			if (AAPExtralk == 50) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal Back")
			end
			if (AAPExtralk == 51) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal")
			end
			if (AAPExtralk == 52) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Zepelin to Stranglethorn Vale")
			end
			if (AAPExtralk == 53) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Learn Journeyman Riding and then type /aap skip or click skip waypoint")
			end
			if (AAPExtralk == 54) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Loot: Pamela's Doll's Head, Left and Right Side and combine them.")
			end
			if (AAPExtralk == 55) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Disguise.")
			end
			if (AAPExtralk == 56) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Place Lightwells around the corpsebeasts")
			end
			if (AAPExtralk == 57) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Take Portal to Stranglethorn Vale")
			end
			if (AAPExtralk == 58) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Get Cozzle's Key")
			end
			if (AAPExtralk == 59) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal to Orgrimmar")
			end
			if (AAPExtralk == 60) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Train Flying")
			end
			if (AAPExtralk == 61) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Go to Borean Tundra on Zepelin")
			end
			if (AAPExtralk == 62) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Handin is on roof")
			end
			if (AAPExtralk == 63) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Beryl Hounds drops Cores to release Kaskala")
			end
			if (AAPExtralk == 64) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Beryl Reclaimers drop bombs")
			end
			if (AAPExtralk == 65) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Beryl Mage Hunters drops the key for the Arcane Prison")
			end
			if (AAPExtralk == 66) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Hand in far up, on a flying rock")
			end
			if (AAPExtralk == 67) then
				local CL_Items, itemLink, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(35586)
				if (itemLink and GetItemCount(itemLink)) then
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Kill Coldarra Wyrmkin and loot 5 Frozen Axes (".. GetItemCount(itemLink) .."/5)")
					if (GetItemCount(itemLink) > 4) then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					end
				else
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Kill Coldarra Wyrmkin and loot 5 Frozen Axes (0/5)")
				end
			end
			if (AAPExtralk == 68) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use item on a dead Mechagnome to capture")
			end
			if (AAPExtralk == 69) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("*** Click Valve")
			end
			if (AAPExtralk == 70) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Loot Dead Mage Hunters for the plans")
			end
			if (AAPExtralk == 71) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Unholy gem on Duke Vallenhal below 35%hp")
			end
			if (AAPExtralk == 72) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Talk to Rokhan to make Sarathstra land")
			end
			if (AAPExtralk == 73) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Woodlands Walkers drop bark for Lothalor Ancients")
			end
			if (AAPExtralk == 74) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Lieutenant Ta'zinni drops Ley Line Focus")
			end
			if (AAPExtralk == 75) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Talk to Budd")
			end
			if (AAPExtralk == 76) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Budds stun on a troll and then cage it")
			end
			if (AAPExtralk == 77) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Dull Carving Knife (by the tree stump), then talk to him")
			end
			if (AAPExtralk == 78) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Buy a Crystal Vial from Ameenah")
			end
			if (AAPExtralk == 79) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Loot a mummy")
			end
			if (AAPExtralk == 80) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Kill Trolls for 5 Frozen Mojo")
			end
			if (AAPExtralk == 81) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Kill Warlord Zim 'bo for his Mojo")
			end
			if (AAPExtralk == 82) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Kill Trolls for 5 Desperate Mojo")
			end
			if (AAPExtralk == 83) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Drakuru mobs drop Lock Openers")
			end
			if (AAPExtralk == 84) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Thrallmar Mage to go to Dark Portal")
			end
			if (AAPExtralk == 85) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal to Hyjal")
			end
			if (AAPExtralk == 86) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Loot Juniper Berries and use them on Faerie Dragons")
			end
			if (AAPExtralk == 87) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Kill Explosive Hatreds to disable shield")
			end
			if (AAPExtralk == 88) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use boat to go to Northrend")
			end
			if (AAPExtralk == 89) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Loot bombs")
			end
			if (AAPExtralk == 90) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Dismiss pets and pick up a miner (don't mount), and run and deliver miner")
			end
			if (AAPExtralk == 91) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal to Blasted Lands")
			end
			if (AAPExtralk == 92) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Flamebringer")
			end
			if (AAPExtralk == 93) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Take Portal to Hellfire Peninsula")
			end
			if (AAPExtralk == 94) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Start Questing in Zangarmarsh")
			end
			if (AAPExtralk == 95) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Portal to Hyjal")
			end
			if (AAPExtralk == 96) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Dread-Rider Cullen")
			end
			if (AAPExtralk == 97) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Recruiter Lee to skip to Dalaran")
			end
			if (AAPExtralk == 98) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Ensign Ward")
			end
			if (AAPExtralk == 99) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** talk to Bilgewater Rocket-jockey")
			end
			if (AAPExtralk == 100) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Loot Cages and deliver back to Subject Nine (Don't mount)")
			end
			if (AAPExtralk == 101) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Pull Handle and Follow Core (put out fires on Labgoblin)")
			end
			if (AAPExtralk == 102) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Go to Azshara")
			end
			if (AAPExtralk == 103) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Go to Tirisfal Glades")
			end
			if (AAPExtralk == 104) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Go to Silverpine Forest")
			end
			if (AAPExtralk == 105) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Dodge Mines")
			end
			if (AAPExtralk == 106) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Assistant Greely to get shrinked")
			end
			if (AAPExtralk == 107) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Mount a Rocketway Rat")
			end
			if (AAPExtralk == 108) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Talk to Friz for a free flight")
			end
			if (AAPExtralk == 109) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use rocket to fly to Shattered Strand")
			end
			if (AAPExtralk == 110) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Military Gyrocopter to return to Bilgewater Harbor")
			end
			if (AAPExtralk == 111) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Kill a troll then use the quest item to collect")
			end
			if (AAPExtralk == 112) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Disguise and Buy Bitter Plasma")
			end
			if (AAPExtralk == 113) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Loot the big Sack")
			end
			if (AAPExtralk == 114) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** both are on 2nd shelf, on the right side")
			end
			if (AAPExtralk == 115) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Bottom shelf, left side")
			end
			if (AAPExtralk == 116) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Do Class Hall and pick zone and go there")
			end
			if (AAPExtralk == 117) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Use Cart")
			end
			if (AAPExtralk == 118) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Treasure is ontop of the tower")
			end
			if (AAPExtralk == 119) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Treasure is up on the tree")
			end
			if (AAPExtralk == 120) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Killing a Bloodfang Stalker spawns a quest")
			end
			if (AAPExtralk == 121) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("If your mounted Npcs might not spawn.")
			end
			if (AAPExtralk == 122) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Only one can do the quest at a time so you might have to wait for npc to respawn")
			end
			if (AAPExtralk == 123) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Talk to Orkus after RP and then loot Plans")
			end
			if (AAPExtralk == 124) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Pet ability (Call to Arms) to Enlist Troops")
			end
			if (AAPExtralk == 125) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Click on the the npc (Zen'Kiki) so he pulls Hawks")
			end
			if (AAPExtralk == 126) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Upstairs")
			end
			if (AAPExtralk == 127) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Use Insense Burner quest item.")
			end
			if (AAPExtralk == 128) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Exit Dungeon.")
			end
			if (AAPExtralk == 129) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Enter Dungeon.")
			end
			if (AAPExtralk == 130) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Chop down trees to spawn snipers")
			end
			if (AAPExtralk == 131) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Talk to Sassy Hardwrench for a ride")
			end
			if (AAPExtralk == 13544) then
				local CL_Items, itemLink, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(44886)
				if (itemLink and GetItemCount(itemLink)) then
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Kill Fleetfoot and loot his tail (".. GetItemCount(itemLink) .."/1)")
					if (GetItemCount(itemLink) and GetItemCount(itemLink) > 0) then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					end
				end
			end
			if (AAPExtralk == 13595) then
				local CL_Items, itemLink, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(44967)
				if (itemLink and GetItemCount(itemLink)) then
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Loot Bottle of Wildfire from table (".. GetItemCount(itemLink) .."/1)")
					if (GetItemCount(itemLink) and GetItemCount(itemLink) > 0) then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					end
				end
			end
			
			if (AAPExtralk == 14358) then
				local zdsLine = 0
				local zdsLine2 = 0
				local zdsLine3 = 0
				if (GetItemInfo(48106) and GetItemCount(GetItemInfo(48106))) then
					if (GetItemCount(GetItemInfo(48106)) and GetItemCount(GetItemInfo(48106)) < 8) then
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] ".. GetItemCount(GetItemInfo(48106)) .."/8 Loot Melonfruit")
						zdsLine = 1
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
						local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
						if (aapwidth and aapwidth > 400) then
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
						else
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
						end
					end
				end
				if (GetItemCount(GetItemInfo(48857))) then
					if (GetItemCount(GetItemInfo(48857)) and GetItemCount(GetItemInfo(48857)) < 10) then
						if (zdsLine == 1) then
							LineNr = LineNr + 1
						end
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] ".. GetItemCount(GetItemInfo(48857)) .."/10 Kill Satyrs for Satyr Flesh")
						zdsLine2 = 1
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
						local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
						if (aapwidth and aapwidth > 400) then
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
						else
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
						end
					end
				end
				if (GetItemInfo(48943) and GetItemCount(GetItemInfo(48943))) then
					if (GetItemCount(GetItemInfo(48943)) and GetItemCount(GetItemInfo(48943)) < 20) then
						if (zdsLine2 == 1) then
							LineNr = LineNr + 1
						end
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] ".. GetItemCount(GetItemInfo(48943)) .."/20 Loot weaponracks for Satyr Sabers")
						zdsLine3 = 1
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
						local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
						if (aapwidth and aapwidth > 400) then
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
						else
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
						end
					end
				end
				if (zdsLine == 0 and zdsLine2 == 0 and zdsLine3 == 0) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				end
			end
			if (AAPExtralk == 25654) then
				if (GetItemInfo(9530) and GetItemCount(GetItemInfo(9530))) then
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Loot Horn from Harpys (".. GetItemCount(GetItemInfo(9530)) .."/1)")
					if (GetItemCount(GetItemInfo(9530)) and GetItemCount(GetItemInfo(9530)) > 0) then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					end
				end
			end
			if (AAPExtralk == 27237) then
				local CL_Items, itemLink, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(33044)
				if (itemLink and GetItemCount(itemLink)) then
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Open Bag")
					if (GetItemCount(itemLink) and GetItemCount(itemLink) > 0) then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					end
				end
			end
			AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
			AAP.QuestList.QuestFrames[LineNr]:Show()
			local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
			if (aapwidth and aapwidth > 400) then
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
			else
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
			end
		end
		if ((steps["ExtraLineText2"]) and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
			LineNr = LineNr + 1
			if (steps["ExtraLineText2"]) then
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** "..steps["ExtraLineText2"])
			end
			AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
			AAP.QuestList.QuestFrames[LineNr]:Show()
			local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
			if (aapwidth and aapwidth > 400) then
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
			else
				AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
			end
		end
		if (AAP.ActiveQuests and AAP.ActiveQuests[57867] and AAP.ZoneTransfer == 0) then
			AAP.QuestList.SweatOfOurBrowBuffFrame:Show()
		else
			AAP.QuestList.SweatOfOurBrowBuffFrame:Hide()
		end
		if (StepP == "Qpart") then
			local IdList = steps["Qpart"]
			if (steps["QpartDB"]) then
				local ZeIDi = 0
				for hz=1, getn(steps["QpartDB"]) do
					local ZeQID = steps["QpartDB"][hz]
					if (C_QuestLog.IsQuestFlaggedCompleted(ZeQID) or AAP.ActiveQuests[ZeQID]) then
						ZeIDi = ZeQID
						break
					end
				end
				local newList = {}
				for AAP_index,AAP_value in pairs(IdList) do
					newList = AAP_value
					break
				end
				IdList = nil
				IdList = {}
				IdList[ZeIDi] = newList
			end
			if (steps["QSpecialz"] and AAP.ActiveQuests["57657-2"]) then
				for i=1,40 do
					local name, rank, count, debuffType, duration, expirationTime, unitCaster, isStealable, asd, spellId  = UnitDebuff("player", i)
					if (spellId and spellId == 309806) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] "..count.."/30 gormlings collected.")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
						if (aapwidth and aapwidth > 400) then
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
						else
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
						end
						if (count == 30) then
							AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
							AAP.BookingList["UpdateQuest"] = 1
							AAP.BookingList["PrintQStep"] = 1
						end
					end
				end
			end
			if (AAP.ActiveQuests["57710-2"]) then
				if (Quest2Special57710 ~= AAP.ActiveQuests["57710-2"]) then
					Quest2Special57710 = AAP.ActiveQuests["57710-2"]
					QuestSpecial57710 = 0
				end
				if (QuestSpecial57710 == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** Click The Eternal Flame")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
				end
			end
			local Flagged = 0
			local Total = 0
			for AAP_index,AAP_value in pairs(IdList) do
				for AAP_index2,AAP_value2 in pairs(AAP_value) do
					Total = Total + 1
					local qid = AAP_index.."-"..AAP_index2
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP_index) or ((UnitLevel("player") == 121) and AAP_BonusObj[AAP_index]) or AAP1[AAP.Realm][AAP.Name]["BonusSkips"][AAP_index] or AAP.BreadCrumSkips[AAP_index]) then
						Flagged = Flagged + 1
					elseif (AAP.ActiveQuests[qid] and AAP.ActiveQuests[qid] == "C") then
						Flagged = Flagged + 1
					elseif (AAP.ActiveQuests[qid]) then
						if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
							LineNr = LineNr + 1
							local ZeTExt
							if (AAP.ActiveQuests["57713-4"] and UIWidgetTopCenterContainerFrame and UIWidgetTopCenterContainerFrame["widgetFrames"]) then
								for AAP_index2,AAP_value2 in AAP.pairsByKeys(UIWidgetTopCenterContainerFrame["widgetFrames"]) do
									if (UIWidgetTopCenterContainerFrame["widgetFrames"][AAP_index2]["Text"]) then
										ZeTExt = UIWidgetTopCenterContainerFrame["widgetFrames"][AAP_index2]["Text"]:GetText()
										if (string.find(ZeTExt, "(%d+)(.*)")) then
											local _,_,ZeTExt2 = string.find(ZeTExt, "(%d+)(.*)")
											ZeTExt = ZeTExt2
										end
									end
								end
							end



							local checkpbar = C_QuestLog.GetQuestObjectives(AAP_index)
						--	if (checkpbar and checkpbar[tonumber(AAP_index2)] and checkpbar[tonumber(AAP_index2)]["type"] and checkpbar[tonumber(AAP_index2)]["type"] == "progressbar") then
						--		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] "..GetQuestProgressBarPercent(AAP_index).."/100 "..AAP.ActiveQuests[qid])
							if (not string.find(AAP.ActiveQuests[qid], "(.*)(%d+)(.*)") and checkpbar and checkpbar[tonumber(AAP_index2)] and checkpbar[tonumber(AAP_index2)]["type"] and checkpbar[tonumber(AAP_index2)]["type"] == "progressbar") then
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] ["..GetQuestProgressBarPercent(AAP_index).."%] "..AAP.ActiveQuests[qid])
							elseif (ZeTExt) then
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] "..ZeTExt.."% - "..AAP.ActiveQuests[qid])
							else
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] "..AAP.ActiveQuests[qid])
							end
							AAP.QuestList.QuestFrames[LineNr]:Show()
							AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
							local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
							if (aapwidth and aapwidth > 400) then
								AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
							else
								AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
							end
							if (steps["Button"] and steps["Button"][qid]) then
								if (not AAP.SetButtonVar) then
									AAP.SetButtonVar = {}
								end
								AAP.SetButtonVar[qid] = LineNr
							end
							if (AAP_BonusObj[AAP_index]) then
								AAP.QuestList.QuestFrames[LineNr]["BQid"] = AAP_index
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
							else
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
							end
						end
					elseif (not AAP.ActiveQuests[AAP_index] and not MissingQs[AAP_index]) then
						if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
							if (AAP_BonusObj[AAP_index]) then
								LineNr = LineNr + 1
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Do Bonus Objective: "..AAP_index)
								AAP.QuestList.QuestFrames[LineNr]:Show()
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
								if (aapwidth and aapwidth > 400) then
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
								else
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
								end
								MissingQs[AAP_index] = 1
								if (AAP_BonusObj[AAP_index]) then
									AAP.QuestList.QuestFrames[LineNr]["BQid"] = AAP_index
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
								else
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								end
							else
								LineNr = LineNr + 1
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Error - Missing Quest: "..AAP_index)
								AAP.QuestList.QuestFrames[LineNr]:Show()
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
								if (aapwidth and aapwidth > 400) then
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
								else
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
								end
								MissingQs[AAP_index] = 1
								if (AAP_BonusObj[AAP_index]) then
									AAP.QuestList.QuestFrames[LineNr]["BQid"] = AAP_index
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
								else
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								end
							end
						end
					end
				end
				if (steps and steps["Gossip"] and (AAP.GossipOpen == 1) and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] == 1 and not IsControlKeyDown()) then
					C_GossipInfo.SelectOption(steps["Gossip"])
				end
			end
			if (Flagged == Total and Flagged > 0) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
--			elseif (LineNr == 0) then
--				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
--				AAP.BookingList["PrintQStep"] = 1
			end
			if (steps and steps["Gossip"] and (AAP.GossipOpen == 1) and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] == 1 and not IsControlKeyDown()) then
				if (steps and steps["Gossip"] and steps["Gossip"] == 34398) then
					C_GossipInfo.SelectOption(1)
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				end
			end
		elseif (StepP == "PickUp") then
			IdList = steps["PickUp"]
			if (steps["PickDraenor"]) then
				if not EncounterJournal then
					EncounterJournal_LoadUI()
				end
				ToggleFrame(EncounterJournal)
			end
			if (steps["PickUpDB"]) then
				local Flagged = 0
				for hz=1, getn(steps["PickUpDB"]) do
					local ZeQID = steps["PickUpDB"][hz]
					if (C_QuestLog.IsQuestFlaggedCompleted(ZeQID) or AAP.ActiveQuests[ZeQID]) then
						Flagged = ZeQID
					end
				end
				if (Flagged > 0) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				else
					if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Pick Up Quests"]..": 1")
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
						local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
						if (aapwidth and aapwidth > 400) then
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
						else
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
						end
					end
				end
			else
				local NrLeft = 0
				local Flagged = 0
				local Total = 0
				local NrLeft2 = 0
				local Flagged2 = 0
				local Total2 = 0
				for h=1, getn(IdList) do
					local theqid = IdList[h]
					Total = Total + 1
					if (not AAP.ActiveQuests[theqid] and C_QuestLog.IsQuestFlaggedCompleted(theqid) == false) then
						NrLeft = NrLeft + 1
					end
					if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.ActiveQuests[theqid] or AAP.BreadCrumSkips[theqid]) then
						Flagged = Flagged + 1
					end
				end
				if (steps["PickUp2"]) then
					IdList2 = steps["PickUp2"]
					for h=1, getn(IdList2) do
						local theqid = IdList2[h]
						Total2 = Total2 + 1
						if (not AAP.ActiveQuests[theqid]) then
							NrLeft2 = NrLeft2 + 1
						end
						if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.ActiveQuests[theqid] or AAP.BreadCrumSkips[theqid]) then
							Flagged2 = Flagged2 + 1
						end
					end
				end
				if (Total == Flagged) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					if (AAP1["Debug"]) then
						print("AAP.PrintQStep:PickUp:Plus:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
					end
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				elseif (steps["PickUp2"] and Total2 == Flagged2) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					if (AAP1["Debug"]) then
						print("AAP.PrintQStep:PickUp:Plus2:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
					end
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				else
					if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
						LineNr = LineNr + 1
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Pick Up Quests"]..": "..NrLeft)
						AAP.QuestList.QuestFrames[LineNr]:Show()
						AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
						local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
						if (aapwidth and aapwidth > 400) then
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
						else
							AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
						end
					end
				end
			end
		elseif (StepP == "CRange") then
			IdList = steps["CRange"]
			if (C_QuestLog.IsQuestFlaggedCompleted(IdList) or AAP.BreadCrumSkips[IdList]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				if (AAP1["Debug"]) then
					print("AAP.PrintQStep:CRange:Plus:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
				end
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
			else
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP.CheckCRangeText())
					AAP.QuestList.QuestFrames[LineNr]:Show()
--					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
					AAP.QuestList.QuestFrames[LineNr]["BQid"] = AAP_index
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
				end
			end
		elseif (StepP == "TrainRiding") then
			IdList = steps["PahonixMadeMe"]
			if (C_QuestLog.IsQuestFlaggedCompleted(IdList) or (GetSpellBookItemInfo(GetSpellInfo(steps["SpellInTab"])))) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
			end
		elseif (StepP == "Treasure") then
			IdList = steps["Treasure"]
			if (C_QuestLog.IsQuestFlaggedCompleted(IdList)) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				if (AAP1["Debug"]) then
					print("AAP.PrintQStep:Treasure:Plus:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
				end
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
			else
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Get the Treasure")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
				end
			end
		elseif (StepP == "DropQuest") then
			IdList = steps["DropQuest"]
			if (C_QuestLog.IsQuestFlaggedCompleted(IdList) or AAP.ActiveQuests[IdList]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				if (AAP1["Debug"]) then
					print("AAP.PrintQStep:DropQuest:Plus:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
				end
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
			end
		elseif (StepP == "Done") then
			IdList = steps["Done"]
			if (steps["DoneDB"]) then
				local Flagged = 0
				for hz=1, getn(steps["DoneDB"]) do
					local zEQID = steps["DoneDB"][hz]
					if (C_QuestLog.IsQuestFlaggedCompleted(zEQID) or AAP.ActiveQuests[zEQID]) then
						IdList = nil
						IdList = {}
						tinsert(IdList,zEQID)
						break
					end
				end
			end
			local NrLeft = 0
			local Flagged = 0
			local Total = 0
			for h=1, getn(IdList) do
				Total = Total + 1
				local theqid = IdList[h]
				if (AAP.ActiveQuests[theqid]) then
					NrLeft = NrLeft + 1
				end
				if (C_QuestLog.IsQuestFlaggedCompleted(theqid) or AAP.BreadCrumSkips[theqid]) then
					Flagged = Flagged + 1
				end
				if (steps["Button"] and steps["Button"][tostring(theqid)]) then
					if (not AAP.SetButtonVar) then
						AAP.SetButtonVar = {}
					end
					AAP.SetButtonVar[tostring(theqid)] = LineNr+1
				end
			end
			if (Total == Flagged) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			else
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Turn in Quest"]..": "..NrLeft)
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
				end
			end
		elseif (StepP == "WarMode") then
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["WarMode"]) or C_PvP.IsWarModeDesired() == true) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			else
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("*** Turn on WARMODE ***")
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
				end
				if (C_PvP.IsWarModeDesired() == false and C_PvP.CanToggleWarMode("toggle") == true) then
					C_PvP.ToggleWarMode()
					AAP.BookingList["PrintQStep"] = 1
				end
			end
		elseif (StepP == "UseDalaHS") then
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["UseDalaHS"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			else
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
					LineNr = LineNr + 1
					if (steps["Button"] and steps["Button"]["12112552-1"]) then
						if (not AAP.SetButtonVar) then
							AAP.SetButtonVar = {}
						end
						AAP.SetButtonVar["12112552-1"] = LineNr
					end
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["UseDalaHS"])
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
				end
			end
		elseif (StepP == "UseGarrisonHS") then
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["UseGarrisonHS"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			else
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
					LineNr = LineNr + 1
					AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["UseGarrisonHS"])
					AAP.QuestList.QuestFrames[LineNr]:Show()
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
					if (steps["Button"] and steps["Button"][tostring(steps["UseGarrisonHS"])]) then
						if (not AAP.SetButtonVar) then
							AAP.SetButtonVar = {}
						end
						AAP.SetButtonVar[tostring(steps["UseGarrisonHS"])] = LineNr
					end
					local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
					if (aapwidth and aapwidth > 400) then
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
					else
						AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
					end
					AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
				end
			end
		elseif (StepP == "ZonePick") then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Pick Zone"])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
		elseif (StepP == "SetHS") then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Set Hearthstone"])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["SetHS"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			elseif (steps["HSZone"] and AAP1[AAP.Realm][AAP.Name]["HSLoc"] and AAP1[AAP.Realm][AAP.Name]["HSLoc"] == steps["HSZone"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		elseif (StepP == "UseHS") then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Use Hearthstone"])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
				if (not AAP.SetButtonVar) then
					AAP.SetButtonVar = {}
				end
				AAP.SetButtonVar[steps["UseHS"]] = LineNr
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["UseHS"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		elseif (StepP == "GetFP") then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
				AAP.FP.GoToZone = nil
				LineNr = LineNr + 1
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Get Flight Point"])
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["GetFP"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		elseif (StepP == "UseFlightPath") then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
				LineNr = LineNr + 1
				if (steps["Boat"]) then
					if (steps["Name"]) then
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Boat to"]..": "..steps["Name"])
					else
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Boat to"])
					end
					
				else
					if (steps["Name"]) then
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Fly to"]..": "..steps["Name"])
					else
						AAP.QuestList.QuestFrames["FS"..LineNr]:SetText(AAP_Locals["Fly to"])
					end
				end
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
			if (steps["SkipIfOnTaxi"] and UnitOnTaxi("player")) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["UseFlightPath"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		elseif (StepP == "QaskPopup") then
			if (C_QuestLog.IsQuestFlaggedCompleted(steps["QaskPopup"])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			else
				AAP_QAskPopWanted()
			end
		elseif (StepP == "QpartPart") then
			IdList = steps["QpartPart"]
			local Flagged = 0
			local Total = 0
			for AAP_index,AAP_value in pairs(IdList) do
				for AAP_index2,AAP_value2 in pairs(AAP_value) do
					Total = Total + 1
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP_index)) then
						Flagged = Flagged + 1
					end
					local qid = AAP_index.."-"..AAP_index2
					if (AAP.ActiveQuests[qid] and AAP.ActiveQuests[qid] == "C") then
						Flagged = Flagged + 1
					elseif (AAP.ActiveQuests[qid]) then
						if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
							LineNr = LineNr + 1
							AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] "..AAP.ActiveQuests[qid])
							AAP.QuestList.QuestFrames[LineNr]:Show()
							AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
							local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
							if (aapwidth and aapwidth > 400) then
								AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
							else
								AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
							end
							if (steps["Button"] and steps["Button"][qid]) then
								if (not AAP.SetButtonVar) then
									AAP.SetButtonVar = {}
								end
								AAP.SetButtonVar[qid] = LineNr
							end
						end
					elseif (not AAP.ActiveQuests[AAP_index] and not MissingQs[AAP_index]) then
						if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
							if (AAP_BonusObj[AAP_index]) then
								LineNr = LineNr + 1
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Do Bonus Objective: "..AAP_index)
								AAP.QuestList.QuestFrames[LineNr]:Show()
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
								if (aapwidth and aapwidth > 400) then
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
								else
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
								end
								MissingQs[AAP_index] = 1
								if (AAP_BonusObj[AAP_index]) then
									AAP.QuestList.QuestFrames[LineNr]["BQid"] = AAP_index
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
								else
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								end
							elseif (AAP.ZoneTransfer == 0) then
								LineNr = LineNr + 1
								AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("Error - Missing Quest: "..AAP_index)
								AAP.QuestList.QuestFrames[LineNr]:Show()
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
								if (aapwidth and aapwidth > 400) then
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
								else
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
								end
							end
						end
						MissingQs[AAP_index] = 1
					end
				end
			end
			if (Flagged == Total) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			elseif (LineNr == 0) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			elseif (steps and steps["TrigText"]) then
				for AAP_index,AAP_value in pairs(steps["QpartPart"]) do
					for AAP_index2,AAP_value2 in pairs(AAP_value) do
						if (AAP.ActiveQuests[AAP_index.."-"..tonumber(AAP_index2)]) then
							if (string.find(AAP.ActiveQuests[AAP_index.."-"..tonumber(AAP_index2)], steps["TrigText"])) then
								AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
								AAP.BookingList["PrintQStep"] = 1
							elseif (steps["TrigText2"] and string.find(AAP.ActiveQuests[AAP_index.."-"..tonumber(AAP_index2)], steps["TrigText2"])) then
								AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
								AAP.BookingList["PrintQStep"] = 1
							elseif (steps["TrigText3"] and string.find(AAP.ActiveQuests[AAP_index.."-"..tonumber(AAP_index2)], steps["TrigText3"])) then
								AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
								AAP.BookingList["PrintQStep"] = 1
							end
						end
					end
				end
			end
		end
		if (steps["DroppableQuest"] and not C_QuestLog.IsQuestFlaggedCompleted(steps["DroppableQuest"]["Qid"]) and not AAP.ActiveQuests[steps["DroppableQuest"]["Qid"]]) then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
				LineNr = LineNr + 1
				local MobName = steps["DroppableQuest"]["Text"]
				if (AAP.NPCList[steps["DroppableQuest"]["MobId"]]) then
					MobName = AAP.NPCList[steps["DroppableQuest"]["MobId"]]
				end
				AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("[".. LineNr .."] "..MobName.." drops quest")
				AAP.QuestList.QuestFrames[LineNr]:Show()
				AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
				local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
				if (aapwidth and aapwidth > 400) then
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
				else
					AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
				end
			end
		end
		if (steps["Fillers"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1) then
			IdList = steps["Fillers"]
			for AAP_index,AAP_value in pairs(IdList) do
				for AAP_index2,AAP_value2 in pairs(AAP_value) do
					if (C_QuestLog.IsQuestFlaggedCompleted(AAP_index) == false and not AAP1[AAP.Realm][AAP.Name]["BonusSkips"][AAP_index]) then
						if ((UnitLevel("player") ~= 121) or (UnitLevel("player") == 121 and not AAP_BonusObj[AAP_index])) then
							local qid = AAP_index.."-"..AAP_index2
							if (AAP.ActiveQuests[qid] and AAP.ActiveQuests[qid] == "C") then
							elseif (AAP.ActiveQuests[qid] and AAP.ZoneTransfer == 0) then
								LineNr = LineNr + 1
								local checkpbar = C_QuestLog.GetQuestObjectives(AAP_index)
								if (not string.find(AAP.ActiveQuests[qid], "(.*)(%d+)(.*)") and checkpbar and checkpbar[tonumber(AAP_index2)] and checkpbar[tonumber(AAP_index2)]["type"] and checkpbar[tonumber(AAP_index2)]["type"] == "progressbar") then
									AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] ["..GetQuestProgressBarPercent(AAP_index).."%] "..AAP.ActiveQuests[qid])
								else
									AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("["..LineNr.."] "..AAP.ActiveQuests[qid])
								end
								AAP.QuestList.QuestFrames[LineNr]:Show()
								AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
								if (aapwidth and aapwidth > 400) then
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
								else
									AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
								end
								if (steps["Button"] and steps["Button"][qid]) then
									if (not AAP.SetButtonVar) then
										AAP.SetButtonVar = {}
									end
									AAP.SetButtonVar[qid] = LineNr
								end
								if (AAP_BonusObj[AAP_index]) then
									AAP.QuestList.QuestFrames[LineNr]["BQid"] = AAP_index
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Show()
								else
									AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
								end
							end
						end
					end
				end
			end
		end
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1) then
			AAP.SetButton()
		end
		if (AAP.QuestListShown ~= LineNr) then
			if (AAP.QuestListShown > LineNr) then
				local FrameHideNr = AAP.QuestListShown - LineNr
				local NewLine = LineNr
				local CLi
				for CLi = 1, FrameHideNr do
					NewLine = NewLine + CLi
					if (AAP.QuestList.QuestFrames[NewLine]) then
						AAP.QuestList.QuestFrames[NewLine]:Hide()
						if (not InCombatLockdown()) then
							AAP.QuestList.QuestFrames["FS"..NewLine]["Button"]:Hide()
							AAP.QuestList2["BF"..NewLine]:Hide()
						end
						if (AAP1["Debug"]) then
							print("Hide:"..NewLine)
						end
					end
				end
			end
		end
		if (StepP == "ZoneDone" or (AAP.ActiveMap == 862 and AAP1[AAP.Realm][AAP.Name]["HordeD"] and AAP1[AAP.Realm][AAP.Name]["HordeD"] == 1)) then
			local CLi
			for CLi = 1, 10 do
				AAP.QuestList.QuestFrames[CLi]:Hide()
				AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()
				if (not InCombatLockdown()) then
					AAP.QuestList2["BF"..CLi]:Hide()
				end
				if (AAP1["Debug"]) then
					print("Hide:"..CLi)
				end
			end
			AAP.ArrowActive = 0
		end
		AAP.QuestListShown = LineNr
		AAP.BookingList["SetQPTT"] = 1
		if (AAP.ZoneQuestOrder:IsShown() == true) then
			AAP.BookingList["UpdateZoneQuestOrderListL"] = 1
		end
	elseif (AAPWhereToGo and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowQList"] == 1 and AAP.ZoneTransfer == 0) then
		LineNr = LineNr + 1
		AAP.QuestList.QuestFrames["FS"..LineNr]:SetText("** AAP: GoTo ".. AAPWhereToGo)
		AAP.QuestList.QuestFrames[LineNr]:Show()
		AAP.QuestList.QuestFrames["FS"..LineNr]["Button"]:Hide()
		local aapwidth = AAP.QuestList.QuestFrames["FS"..LineNr]:GetStringWidth()
		if (aapwidth and aapwidth > 400) then
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(aapwidth+10)
		else
			AAP.QuestList.QuestFrames[LineNr]:SetWidth(410)
		end
	end
	for CLi = 1, 10 do
		if (CLi > LineNr) then
			if (AAP.QuestList.QuestFrames[CLi]:IsShown()) then
				AAP.QuestList.QuestFrames[CLi]:Hide()
			end
		end
	end
end
function AAP.TrimPlayerServer(CLPName)
	if (string.find(CLPName, "(.*)-(.*)")) then
		local _, _, CL_First, CL_Rest = string.find(CLPName, "(.*)-(.*)")
		return CL_First
	else
		return CLPName
	end
end
function AAP.SetButton()
	if (AAP1["Debug"]) then
		print("Function: AAP.SetButton()")
	end
	if (AAP.SettingsOpen == 1) then
		local CLi
		for CLi = 1, 3 do
			local Topz = AAP1[AAP.Realm][AAP.Name]["Settings"]["left"]
			local Topz2 = AAP1[AAP.Realm][AAP.Name]["Settings"]["top"]
			AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Topz, Topz2)
			AAP.QuestList2["BF"..CLi]:SetPoint("BOTTOMLEFT", AAP.QuestList21, "BOTTOMLEFT",0,-((CLi * 38)+CLi))
		end
		return
	end
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local steps
	if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	end
	if (steps and steps["Button"] or (AAP.Dinged100 == 1 and AAP.Dinged100nr > 0)) then
		if (not InCombatLockdown()) then
			if (AAP.SetButtonVar) then
				if (AAP1["Debug"]) then
					print("SetButton")
				end
				AAP.ButtonList = nil
				AAP.ButtonList = {}
				local HideVar = {}
				for AAP_index2,AAP_value2 in pairs(AAP.SetButtonVar) do
					for AAP_index,AAP_value in pairs(steps["Button"]) do
						if (AAP1["Debug"]) then
							print(AAP_index)
						end
						if (AAP_index2 == AAP_index or steps["UseHS"] or steps["UseGarrisonHS"]) then
							local CL_Items, itemLink, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(AAP_value)
							if (CL_Items and string.sub(CL_Items, 1, 1) and CL_ItemTex) then
								HideVar[AAP_value2] = AAP_value2
								AAP.ButtonList[AAP_index] = AAP_value2
								AAP.QuestList2["BF"..AAP_value2]["AAP_Buttonptex"]:SetTexture(CL_ItemTex)
								AAP.QuestList2["BF"..AAP_value2]["AAP_Buttonntex"]:SetTexture(CL_ItemTex)
								AAP.QuestList2["BF"..AAP_value2]["AAP_Button"]:SetNormalTexture(CL_ItemTex)
								AAP.QuestList2["BF"..AAP_value2]["AAP_Button"]:SetText("")
								AAP.QuestList2["BF"..AAP_value2]["AAP_Button"]:SetAttribute("type", "item");
								AAP.QuestList2["BF"..AAP_value2]["AAP_Button"]:SetAttribute("item", "item:"..AAP_value);
								AAP.QuestList2["BF"..AAP_value2]["AAP_Button"]:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:SetItemByID(AAP_value); GameTooltip:Show() end)
								AAP.QuestList2["BF"..AAP_value2]["AAP_Button"]:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
								if (GetItemCount(itemLink) and GetItemCount(itemLink) > 0) then
									AAP.QuestList2["BF"..AAP_value2]:Show()
								else
									AAP.QuestList2["BF"..AAP_value2]:Hide()
								end
								local Topz = AAP1[AAP.Realm][AAP.Name]["Settings"]["left"]
								local Topz2 = AAP1[AAP.Realm][AAP.Name]["Settings"]["top"]
								AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Topz, Topz2)
								AAP.QuestList2["BF"..AAP_value2]:SetPoint("BOTTOMLEFT", AAP.QuestList21, "BOTTOMLEFT",0,-((AAP_value2 * 38)+AAP_value2))
								if (not AAP.ButtonVisual) then
									AAP.ButtonVisual = {}
								end
								local _, Spellidz = GetItemSpell(AAP_value)
								if (Spellidz) then
									AAP.QuestStepList[AAP.ActiveMap][CurStep]["ButtonSpellId"] = { [Spellidz] = AAP_index }
								end
								AAP.ButtonVisual[AAP_value2] = AAP_value2
								local isFound, macroSlot = AAP.MacroFinder()
								if isFound and macroSlot then
									if (steps and steps["SpecialDubbleMacro"]) then
										if (not AAP.DubbleMacro[1]) then
											AAP.DubbleMacro[1] = CL_Items
										elseif (AAP.DubbleMacro and AAP.DubbleMacro[1] and not AAP.DubbleMacro[2]) then
											AAP.DubbleMacro[2] = CL_Items
										end
									else
										AAP.DubbleMacro = nil
										AAP.DubbleMacro = {}
									end
									AAP.MacroUpdater(macroSlot, CL_Items)
								end
							end
						end
					end
				end
				for i=1, 10 do
					if (not HideVar[i] and AAP.SettingsOpen ~= 1) then
						AAP.QuestList2["BF"..i]:Hide()
					end
				end
				if (AAP.Dinged100 == 1 and AAP.Dinged100nr > 0) then
					local CL_Items, clt2, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(6948)
					if (CL_Items and string.sub(CL_Items, 1, 1) and CL_ItemTex) then
						HideVar[AAP.Dinged100nr] = AAP.Dinged100nr
						AAP.ButtonList[123451234] = AAP.Dinged100nr
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Buttonptex"]:SetTexture(CL_ItemTex)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Buttonntex"]:SetTexture(CL_ItemTex)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetNormalTexture(CL_ItemTex)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetText("")
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetAttribute("type", "item");
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetAttribute("item", "item:6948");
						AAP.QuestList2["BF"..AAP.Dinged100nr]:Show()
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:SetItemByID(6948); GameTooltip:Show() end)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
						local Topz = AAP1[AAP.Realm][AAP.Name]["Settings"]["left"]
						local Topz2 = AAP1[AAP.Realm][AAP.Name]["Settings"]["top"]
						AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Topz, Topz2)
						AAP.QuestList2["BF"..AAP.Dinged100nr]:SetPoint("BOTTOMLEFT", AAP.QuestList21, "BOTTOMLEFT",0,-((AAP.Dinged100nr * 38)+AAP.Dinged100nr))
						if (not AAP.ButtonVisual) then
							AAP.ButtonVisual = {}
						end
						AAP.ButtonVisual[AAP.Dinged100nr] = AAP.Dinged100nr
						local isFound, macroSlot = AAP.MacroFinder()
						if isFound and macroSlot then
							if (steps and steps["SpecialDubbleMacro"]) then
								if (not AAP.DubbleMacro[1]) then
									AAP.DubbleMacro[1] = CL_Items
								elseif (AAP.DubbleMacro and AAP.DubbleMacro[1] and not AAP.DubbleMacro[2]) then
									AAP.DubbleMacro[2] = CL_Items
								end
							else
								AAP.DubbleMacro = nil
								AAP.DubbleMacro = {}
							end
							AAP.MacroUpdater(macroSlot, CL_Items)
						end
					end
				end
			else
				if (steps and not steps["Button"] and AAP.SettingsOpen ~= 1) then
					for i=1, 10 do
						AAP.QuestList2["BF"..i]:Hide()
					end
				end
				if (AAP.Dinged100 == 1 and AAP.Dinged100nr > 0) then
					local CL_Items, clt2, clt3, clt4, clt5, clt6, clt7, clt8, clt9, CL_ItemTex = GetItemInfo(6948)
					if (CL_Items and string.sub(CL_Items, 1, 1) and CL_ItemTex) then
						AAP.ButtonList[123451234] = AAP.Dinged100nr
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Buttonptex"]:SetTexture(CL_ItemTex)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Buttonntex"]:SetTexture(CL_ItemTex)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetNormalTexture(CL_ItemTex)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetText("")
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetAttribute("type", "item");
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetAttribute("item", "item:6948");
						AAP.QuestList2["BF"..AAP.Dinged100nr]:Show()
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:SetItemByID(6948); GameTooltip:Show() end)
						AAP.QuestList2["BF"..AAP.Dinged100nr]["AAP_Button"]:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
						local Topz = AAP1[AAP.Realm][AAP.Name]["Settings"]["left"]
						local Topz2 = AAP1[AAP.Realm][AAP.Name]["Settings"]["top"]
						AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Topz, Topz2)
						AAP.QuestList2["BF"..AAP.Dinged100nr]:SetPoint("BOTTOMLEFT", AAP.QuestList21, "BOTTOMLEFT",0,-((AAP.Dinged100nr * 38)+AAP.Dinged100nr))
						if (not AAP.ButtonVisual) then
							AAP.ButtonVisual = {}
						end
						AAP.ButtonVisual[AAP.Dinged100nr] = AAP.Dinged100nr
						local isFound, macroSlot = AAP.MacroFinder()
						if isFound and macroSlot then
							AAP.DubbleMacro = nil
							AAP.DubbleMacro = {}
							AAP.MacroUpdater(macroSlot, CL_Items)
						end
					end
				end
			end
			AAP.SetButtonVar = nil
		end
	elseif (AAP.ButtonVisual and not InCombatLockdown() and AAP.SettingsOpen ~= 1) then
		for AAP_index,AAP_value in pairs(AAP.ButtonVisual) do
			AAP.QuestList2["BF"..AAP_index]:Hide()
		end
		AAP.ButtonVisual = nil
	end
	if (not InCombatLockdown()) then
		AAP.QuestList20:SetPoint("TOPLEFT", UIParent, "TOPLEFT", AAP1[AAP.Realm][AAP.Name]["Settings"]["left"], AAP1[AAP.Realm][AAP.Name]["Settings"]["top"])
	end
end
function AAP.CheckCRangeText()
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
	local i = 1
	while i  <= 15 do
		CurStep = CurStep + 1
		steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		if (steps and steps["FlightPath"]) then
			local Derp2 = "[WayPoint] - "..AAP_Locals["Get Flight Point"]
			return Derp2
		elseif (steps and steps["UseFlightPath"]) then
			if (steps["Boat"]) then
				local Derp2 = "[WayPoint] - "..AAP_Locals["Boat to"]
				return Derp2
			else
				local Derp2 = "[WayPoint] - "..AAP_Locals["Fly to"]
				return Derp2
			end
		elseif (steps and steps["PickUp"]) then
			local Derp2 = "[WayPoint] - Accept Quest"
			return Derp2
		elseif (steps and steps["Done"]) then
			local Derp2 = "[WayPoint] - Turn in Quest"
			return Derp2
		elseif (steps and steps["Qpart"]) then
			local Derp2 ="[WayPoint] - Complete Quest"
			return Derp2
		elseif (steps and steps["SetHS"]) then
			local Derp2 = "[WayPoint] - Set Hearthstone"
			return Derp2
		elseif (steps and steps["QpartPart"]) then
			local Derp2 = "[WayPoint] - Complete Quest"
			return Derp2
		end

		i = i + 1
	end
	local Derp2 = AAP_Locals["Travel to"]
	return Derp2
end
local function AAP_UpdateQuest()
	if (AAP1["Debug"]) then
		print("Function: AAP_UpdateQuest()")
	end
	local i = 1
	local UpdateQpart = 0
	if (not AAPQuestNames) then
		AAPQuestNames = {}
	end
	while C_QuestLog.GetTitleForLogIndex(i) do
		local ZeInfoz = C_QuestLog.GetInfo(i)
		if (ZeInfoz) then
			local questID = ZeInfoz["questID"]
			if (questID > 0) then
				local isHeader = ZeInfoz["isHeader"]
				local questTitle = C_QuestLog.GetTitleForQuestID(questID)
				local isComplete = C_QuestLog.IsComplete(questID)
				if (not isHeader) then
					AAPQuestNames[questID] = questTitle
					local numObjectives = C_QuestLog.GetNumQuestObjectives(questID)
					if (not AAP.ActiveQuests[questID]) then
						if (AAP1["Debug"]) then
							print("New Q:"..questID)
						end
					end
					if (not isComplete) then
						isComplete = 0
						AAP.ActiveQuests[questID] = "P"
					else
						isComplete = 1
						AAP.ActiveQuests[questID] = "C"
					end
					if (numObjectives == 0) then
						if (isComplete == 1) then
							AAP.ActiveQuests[questID.."-".."1"] = "C"
						else
							AAP.ActiveQuests[questID.."-".."1"] = questTitle
						end
					else
						local ZeObject = C_QuestLog.GetQuestObjectives(questID)
						for h=1, numObjectives do
							local finished = ZeObject[h]["finished"]
							local text = ZeObject[h]["text"]
							if (finished == true) then
								finished = 1
							else
								finished = 0
							end
							if (finished == 1) then
								if (AAP.ActiveQuests[questID.."-"..h] and AAP.ActiveQuests[questID.."-"..h] ~= "C") then
									if (AAP1["Debug"]) then
										print("Update:".."C")
									end
									Update = 1
								end
								AAP.ActiveQuests[questID.."-"..h] = "C"
							elseif ((select(2,GetQuestObjectiveInfo(questID, 1, false)) == "progressbar") and text) then
								if (not AAP.ProgressbarIgnore[questID.."-"..h]) then
									local AAP_Mathstuff = tonumber(GetQuestProgressBarPercent(questID))
									AAP_Mathstuff = floor((AAP_Mathstuff + 0.5))
									text = "["..AAP_Mathstuff.."%] " .. text
									if (not AAP.ActiveQuests[questID.."-"..h]) then
										if (AAP1["Debug"]) then
											print("New1:"..text)
										end
									end
								end
								if (AAP.ActiveQuests[questID.."-"..h] and AAP.ActiveQuests[questID.."-"..h] ~= text) then
									if (AAP1["Debug"]) then
										print("Update:"..text)
									end
									Update = 1
									AAP.ActiveQuests[questID.."-"..h] = text
								else
									AAP.ActiveQuests[questID.."-"..h] = text
								end
							else
								if (not AAP.ActiveQuests[questID.."-"..h]) then
									--print("New2:"..text)
								end
								if (AAP.ActiveQuests[questID.."-"..h] and AAP.ActiveQuests[questID.."-"..h] ~= text) then
									if (AAP1["Debug"]) then
										print("Update:"..text)
									end
									Update = 1
									AAP.ActiveQuests[questID.."-"..h] = text
								else
									AAP.ActiveQuests[questID.."-"..h] = text
								end
							end
						end
					end
				end
			end
		else
			break
		end
	i = i + 1
	end
	if (Update == 1) then
		AAP.BookingList["PrintQStep"] = 1
	end
end
function AAP.MacroFinder()
	if (AAP1["Debug"]) then
		print("Function: AAP.MacroFinder()")
	end
	local found = false
	local global, character = GetNumMacros()
	for i=1, global do
		local name = GetMacroInfo(i)
		if name == "AAP_MACRO" then
			found = true
			return true, i
		end
	end
	if not found then
		return false, nil
	end
end
function AAP.CreateMacro()
	if InCombatLockdown() then
		return
	end
	if (AAP1["Debug"]) then
		print("AAP.CreateMacro()")
	end
	local global, character = GetNumMacros()
	local isFound, macroSlot = AAP.MacroFinder()
	local aap_hasSpace = global < MAX_ACCOUNT_MACROS
	if aap_hasSpace then 
		if not isFound and not InCombatLockdown() then
			CreateMacro("AAP_MACRO","INV_MISC_QUESTIONMARK","/script print('no button yet')",nil,nil)
		end
	else
		print("AAP: No global macro space. Please delete a macro to create space.")
	end
end
function AAP.MacroUpdater(macroSlot,itemName,aapextra)
	AAP.MacroUpdaterVar[1] = macroSlot
	AAP.MacroUpdaterVar[2] = itemName
	AAP.MacroUpdaterVar[3] = aapextra
end
function AAP.MacroUpdater2(macroSlot,itemName,aapextra)
	if (AAP1["Debug"]) then
		print("Function: AAP.MacroUpdater()")
	end
	if (itemName) then
		if (itemName == 123123123) then
			EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/click ExtraActionButton1",nil,nil)
		elseif (itemName == 6666666) then
			EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/cast Summon Steward",nil,nil)
		elseif (aapextra == 65274) then
			EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/script AAP.SaveOldSlot()\n/use "..itemName,nil,nil)
		else
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			if (AAP.DubbleMacro and AAP.DubbleMacro[1] and AAP.DubbleMacro[2] and steps and steps["SpecialDubbleMacro"]) then
				EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/use "..AAP.DubbleMacro[1].."\n/use "..AAP.DubbleMacro[2],nil,nil)
			elseif (steps and steps["SpecialMacro"]) then
				EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/target Serrik\n/use "..itemName,nil,nil)
			elseif (steps and steps["SpecialMacro2"]) then
				EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/target Hrillik's\n/use "..itemName,nil,nil)
			else
				EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","#showtooltip\n/use "..itemName,nil,nil)
			end
		end
	else
		EditMacro(macroSlot, "AAP_MACRO","INV_MISC_QUESTIONMARK","/script print('no button yet')",nil,nil)
	end
end
function AAP.GliderFunc()
	if (AAP1["Debug"]) then
		print("Function: AAP.GliderFunc()")
	end
	if (AAP1["GliderName"]) then
		return AAP1["GliderName"]
	else
		local bag, slot, itemLink, itemName, count
		local DerpGot = 0
		for bag = 0,4 do
			for slot = 1,GetContainerNumSlots(bag) do
				local itemID = GetContainerItemID(bag, slot)
				if (itemID and itemID == 109076) then
					DerpGot = 1
					itemLink = GetContainerItemLink(bag,slot)
					itemName = GetItemInfo(itemLink)
					count = GetItemCount(itemLink)
				end
			end
		end
		if (DerpGot == 1) then
			AAP1["GliderName"] = itemName
			return itemName
		else
			return "Goblin Glider Kit"
		end
	end
end
local function AAP_QuestStepIds()
	if (AAP.QuestStepList[AAP.ActiveMap]) then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		if (CurStep and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
			local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			if (steps["PickUp"]) then
				return steps["PickUp"], "PickUp"
			elseif (steps["Qpart"]) then
				return steps["Qpart"], "Qpart"
			elseif (steps["Done"]) then
				return steps["Done"], "Done"
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function AAP_RemoveQuest(questID)
	AAP.ActiveQuests[questID] = nil
	for AAP_index,AAP_value in pairs(AAP.ActiveQuests) do
		if (string.find(AAP_index, "(.*)-(.*)")) then
			local _, _, AAP_First, AAP_Rest = string.find(AAP_index, "(.*)-(.*)")
			if (tonumber(AAP_First) == questID) then
				AAP.ActiveQuests[AAP_index] = nil
			end
		end
	end
	local IdList, StepP = AAP_QuestStepIds()
	if (StepP == "Done") then
		local NrLeft = 0
		for AAP_index,AAP_value in pairs(IdList) do
			if (C_QuestLog.IsQuestFlaggedCompleted(AAP_value) or questID == AAP_value) then
			else
				NrLeft = NrLeft + 1
			end
		end
		if (NrLeft == 0) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			if (AAP1["Debug"]) then
				print("AAP.RemoveQuest:Plus"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
			end
			AAP.BookingList["UpdateQuest"] = 1
		end
	end
	AAP.BookingList["PrintQStep"] = 1
end
local function AAP_AddQuest(questID)
	AAP.ActiveQuests[questID] = "P"
	local IdList, StepP = AAP_QuestStepIds()
	if (StepP == "PickUp") then
		local NrLeft = 0
		for AAP_index,AAP_value in pairs(IdList) do
			if (not AAPQuestNames[AAP_value]) then
				AAPQuestNames[AAP_value] = 1
			end
			if (not AAP.ActiveQuests[AAP_value]) then
				NrLeft = NrLeft + 1
			end
		end
		if (NrLeft == 0) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			if (AAP1["Debug"]) then
				print("AAP.AddQuest:Plus"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
			end
			AAP.BookingList["UpdateQuest"] = 1
		end
	end
	AAP.BookingList["PrintQStep"] = 1
end
local function AAP_UpdateMapId()
	if (AAP1["Debug"]) then
		print("Function: AAP_UpdateMapId()")
	end
	local OldMap = AAP.ActiveMap
	local levelcheck = 0
	local levelcheck80 = 0
	local levelcheck90 = 0
	local levelcheck100 = 0
	local levelcheck110 = 0
	AAP.Level = UnitLevel("player")
	AAP.ActiveMap = C_Map.GetBestMapForUnit("player")
	local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
	if (Enum and Enum.UIMapType and Enum.UIMapType.Continent and currentMapId) then
		AAP.ActiveMap = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
	end
	if (AAP.ActiveMap and AAP.ActiveMap["mapID"]) then
		AAP.ActiveMap = AAP.ActiveMap["mapID"]
	else
		AAP.ActiveMap = C_Map.GetBestMapForUnit("player")
	end
	AAPt_Zone = AAP.ActiveMap
	if (AAP.ActiveMap == 1671) then
		AAP.ActiveMap = 1670
	elseif (AAPt_Zone == 578) then
		AAPt_Zone = 577
	elseif (AAP.ActiveMap == "A543-DesMephisto-Gorgrond" and AAPt_Zone == 535) then
		AAPt_Zone = 543
	elseif (AAPt_Zone == 1726 or AAPt_Zone == 1727) then
		AAPt_Zone = 1409
	end
	if (AAP.ActiveQuests and AAP.ActiveQuests[59974] and AAP.ActiveMap == 1536) then
		AAP.ActiveMap = 1670
	end
	if (OldMap and OldMap ~= AAP.ActiveMap) then
		AAP.BookingList["PrintQStep"] = 1
	end
	if (AAP.ActiveMap == nil) then
		AAP.ActiveMap = "NoZone"
	end

	if (AAP.Faction == "Alliance") then
		AAP.ActiveMap = "A"..AAP.ActiveMap
	end
	if (AAP.ActiveQuests and AAP.ActiveQuests[32675] and AAPt_Zone == 84 and AAP.Faction == "Alliance") then
		AAP.ActiveMap = "A84-LearnFlying"
	end
	--if (AAP.Race == "Goblin" and AAP.ActiveMap == 194) then
	--	if (AAP.Gender == 2) then
	--		AAP.ActiveMap = "194-male"
	--	else
	--		AAP.ActiveMap = "194-female"
	--	end
	--end
--	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	--if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
	--else
	--	AAP.BookingList["ClosedSettings"] = 1
	--end
	if (AAP.QuestStepListListingZone) then
		AAP.BookingList["GetMeToNextZone"] = 1
	end
	if (AAP.ZoneTransfer == 1) then
		AAP.BookingList["ZoneTransfer"] = 1
	end
	if (not AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]) then
		AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = 1
	end
	if (AAP.ZoneQuestOrder:IsShown() == true) then
		AAP.BookingList["UpdateZoneQuestOrderListL"] = 1
	end
	AAP.BookingList["PrintQStep"] = 1
	C_Timer.After(0.1, AAP_BookQStep)
end
local function AAP_CheckZonePick()
	if (AAP.ActiveMap == 862) then
		if (C_QuestLog.IsQuestFlaggedCompleted(50963) == false and (AAP.ActiveQuests[47514] or C_QuestLog.IsQuestFlaggedCompleted(47514) == true)) then
			AAP.BookingList["UpdateMapId"] = 1
			AAP.BookingList["PrintQStep"] = 1
		elseif ((AAP.ActiveQuests[47513] or C_QuestLog.IsQuestFlaggedCompleted(47513) == true) and C_QuestLog.IsQuestFlaggedCompleted(47315) == false) then
			AAP.BookingList["UpdateMapId"] = 1
			AAP.BookingList["PrintQStep"] = 1
		elseif ((AAP.ActiveQuests[47512] or C_QuestLog.IsQuestFlaggedCompleted(47512) == true) and C_QuestLog.IsQuestFlaggedCompleted(47105) == false) then
			AAP.BookingList["UpdateMapId"] = 1
			AAP.BookingList["PrintQStep"] = 1
		elseif (C_QuestLog.IsQuestFlaggedCompleted(47105) == true and C_QuestLog.IsQuestFlaggedCompleted(47315) == true and C_QuestLog.IsQuestFlaggedCompleted(50963) == true) then
			AAP.BookingList["UpdateMapId"] = 1
			AAP.BookingList["PrintQStep"] = 1
		end
	end
end
local function AAP_AcceptQuester()
	AcceptQuest()
end
local function AAP_CheckDistance()
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	if (CurStep and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
		if (AAP.QuestStepList[AAP.ActiveMap][CurStep]["CRange"]) then
			AAP.ArrowFrame.Button:Show()
			local plusnr = CurStep
			local Distancenr = 0
			local testad = true
			if (AAP.QuestStepList[AAP.ActiveMap][CurStep]["NoExtraRange"]) then
				testad = false
			end
			while testad do
				local oldx = AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]["x"]
				local oldy = AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]["y"]
				plusnr = plusnr + 1
				if (AAP.QuestStepList[AAP.ActiveMap][plusnr] and AAP.QuestStepList[AAP.ActiveMap][plusnr]["CRange"]) then
					local newx = AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]["x"]
					local newy = AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]["y"]
					local deltaX, deltaY = oldx - newx, newy - oldy
					local distance = (deltaX * deltaX + deltaY * deltaY)^0.5
					Distancenr = Distancenr + distance
				else
					if (AAP.QuestStepList[AAP.ActiveMap][plusnr] and AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]) then
						local newx = AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]["x"]
						local newy = AAP.QuestStepList[AAP.ActiveMap][plusnr]["TT"]["y"]
						local deltaX, deltaY = oldx - newx, newy - oldy
						local distance = (deltaX * deltaX + deltaY * deltaY)^0.5
						Distancenr = Distancenr + distance
					end
					return floor(Distancenr + 0.5)
				end
			end
		end
	end
	return 0
end
local function AAP_SetQPTT()
	if (AAP1["Debug"]) then
		print("Function: AAP_SetQPTT()")
	end
	if (AAP.SettingsOpen == 1) then
		return
	end
	local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
	if (QNumberLocal ~= CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep] and AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]) then
		AAP.ArrowActive = 1
		AAP.ArrowActive_X = AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]["x"]
		AAP.ArrowActive_Y = AAP.QuestStepList[AAP.ActiveMap][CurStep]["TT"]["y"]
		QNumberLocal = CurStep
		AAP["Icons"][1].A = 1
		AAP["MapIcons"][1].A = 1
	end
end
local function AAP_PosTest()
	local d_y, d_x = UnitPosition("player")
	if (not d_y) then
		AAP.ArrowFrame:Hide()
		AAP.RemoveIcons()
	elseif (AAP1 and AAP1[AAP.Realm][AAP.Name] and AAP1[AAP.Realm][AAP.Name]["Settings"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowArrow"] == 0) then
		AAP.ArrowActive = 0
		AAP.ArrowFrame:Hide()
		
		AAP.RemoveIcons()
	else
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		if (AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep] and AAP.QuestStepList[AAP.ActiveMap][CurStep]["AreaTriggerZ"]) then
			x = AAP.QuestStepList[AAP.ActiveMap][CurStep]["AreaTriggerZ"]["x"]
			y = AAP.QuestStepList[AAP.ActiveMap][CurStep]["AreaTriggerZ"]["y"]
			local deltaX, deltaY = d_x - x, y - d_y
			local distance = (deltaX * deltaX + deltaY * deltaY)^0.5
			if (AAP.QuestStepList[AAP.ActiveMap][CurStep]["AreaTriggerZ"]["R"] > distance) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				QNumberLocal = 0
				AAP.BookingList["UpdateQuest"] = 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		if (((AAP.ArrowActive == 0) or (AAP.ArrowActive_X == 0) or (IsInInstance()) or not AAP.QuestStepList) or (AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep] and AAP.QuestStepList[AAP.ActiveMap][CurStep]["NoArrows"])) then
			if (AAP.ArrowFrame) then
				AAP.ArrowActive = 0
				AAP.ArrowFrame:Hide()
				AAP.RemoveIcons()
			end
		else
			AAP.ArrowFrame:Show()
			AAP.ArrowFrame.Button:Hide()
			local d_y, d_x = UnitPosition("player")
			if (d_x and d_y and GetPlayerFacing()) then
				x = AAP.ArrowActive_X
				y = AAP.ArrowActive_Y
				local AAP_ArrowActive_TrigDistance
				local PI2 = math.pi * 2
				local atan2 = math.atan2
				local twopi = math.pi * 2
				local deltaX, deltaY = d_x - x, y - d_y
				local distance = (deltaX * deltaX + deltaY * deltaY)^0.5
				local angle = atan2(-deltaX, deltaY)
				local player = GetPlayerFacing()
				angle = angle - player
				local perc = math.abs((math.pi - math.abs(angle)) / math.pi)
				if perc > 0.98 then
					AAP.ArrowFrame.arrow:SetVertexColor(0,1,0)
				elseif perc > 0.49 then
					AAP.ArrowFrame.arrow:SetVertexColor((1-perc)*2,1,0)
				else
					AAP.ArrowFrame.arrow:SetVertexColor(1,perc*2,0)
				end
				local cell = floor(angle / twopi * 108 + 0.5) % 108
				local col = cell % 9
				local row = floor(cell / 9)
				AAP.ArrowFrame.arrow:SetTexCoord((col * 56) / 512,((col + 1) * 56) / 512,(row * 42) / 512,((row + 1) * 42) / 512)
				AAP.ArrowFrame.distance:SetText(floor(distance + AAP_CheckDistance()) .. " "..AAP_Locals["Yards"])
				local AAP_ArrowActive_Distance = 0
				if (CurStep and AAP.ActiveMap and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
					if (AAP.QuestStepList[AAP.ActiveMap][CurStep]["Trigger"]) then
						local d_y, d_x = UnitPosition("player")
						local AAP_ArrowActive_Trigger_X = AAP.QuestStepList[AAP.ActiveMap][CurStep]["Trigger"]["x"]
						local AAP_ArrowActive_Trigger_Y = AAP.QuestStepList[AAP.ActiveMap][CurStep]["Trigger"]["y"]
						local deltaX, deltaY = d_x - AAP_ArrowActive_Trigger_X, AAP_ArrowActive_Trigger_Y - d_y
						AAP_ArrowActive_Distance = (deltaX * deltaX + deltaY * deltaY)^0.5
						AAP_ArrowActive_TrigDistance = AAP.QuestStepList[AAP.ActiveMap][CurStep]["Range"]
						if (AAP.QuestStepList[AAP.ActiveMap][CurStep]["HIDEME"]) then
							AAP.ArrowActive = 0
						end
					end
				end
				if (distance < 5 and AAP_ArrowActive_Distance == 0) then
					AAP.ArrowActive_X = 0
				elseif (AAP_ArrowActive_Distance and AAP_ArrowActive_TrigDistance and AAP_ArrowActive_Distance < AAP_ArrowActive_TrigDistance) then
					AAP.ArrowActive_X = 0
					if (CurStep and AAP.ActiveMap and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
						if (AAP.QuestStepList[AAP.ActiveMap][CurStep]["CRange"]) then
							AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
							QNumberLocal = 0
							AAP.BookingList["UpdateQuest"] = 1
							AAP.BookingList["PrintQStep"] = 1
						end
					end
				end
			end
		end
	end
end
local function AAP_LoopBookingFunc()
	local TestaAAP = 0
	if (not AAP.BookingList) then
		AAP.BookingList = {}
	end
	if (AAP.BookingList["OpenedSettings"]) then
		AAP.BookingList["OpenedSettings"] = nil
		AAP.ArrowActive = 1
		AAP.ArrowActive_Y, AAP.ArrowActive_X = UnitPosition("player")
		QNumberLocal = 0
		AAP_SettingsButtons()
		if (AAP.ArrowActive_Y) then
			AAP.ArrowActive_Y = AAP.ArrowActive_Y + 150
			AAP.ArrowActive_X = AAP.ArrowActive_X + 150
			AAP["Icons"][1].A = 1
		end
		AAP.BookingList["PrintQStep"] = 1
		TestaAAP = "OpenedSettings"
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:OpenedSettings")
		end
	elseif (AAP.BookingList["ClosedSettings"]) then
		if (not InCombatLockdown()) then
			AAP.BookingList["ClosedSettings"] = nil
			QNumberLocal = 0
			AAP.ArrowActive = 0
			AAP.RemoveIcons()
			local CLi
			for CLi = 1, 10 do
				AAP.QuestList.QuestFrames[CLi]:Hide()
				AAP.QuestList.QuestFrames["FS"..CLi]["Button"]:Hide()
				AAP.QuestList2["BF"..CLi]:Hide()
			end
			AAP.BookingList["UpdateQuest"] = 1
			AAP.BookingList["PrintQStep"] = 1
		end
		TestaAAP = "ClosedSettings"
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:ClosedSettings")
		end
	elseif (AAP.BookingList["GetMeToNextZone"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:GetMeToNextZone:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		AAP.BookingList["GetMeToNextZone"] = nil
		AAP.FP.GetMeToNextZone()
	elseif (AAP.BookingList["UpdateMapId"]) then
		AAP.BookingList["UpdateMapId"] = nil
		AAP_UpdateMapId()
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:UpdateMapId:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		TestaAAP = "UpdateMapId"
	elseif (AAP.BookingList["AcceptQuest"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:AcceptQuest")
		end
		AAP.BookingList["AcceptQuest"] = nil
		C_Timer.After(0.2, AAP_AcceptQuester)
		TestaAAP = "AcceptQuest"
	elseif (AAP.BookingList["CompleteQuest"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:CompleteQuest")
		end
		AAP.BookingList["CompleteQuest"] = nil
		CompleteQuest()
		TestaAAP = "CompleteQuest"
	elseif (AAP.BookingList["CreateMacro"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:CreateMacro")
		end
		AAP.BookingList["CreateMacro"] = nil
		AAP_CreateMacro()
		TestaAAP = "CreateMacro"
	elseif (AAP.BookingList["AddQuest"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:AddQuest:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		AAP_AddQuest(AAP.BookingList["AddQuest"])
		AAP.BookingList["AddQuest"] = nil
		TestaAAP = "AddQuest"
	elseif (AAP.BookingList["RemoveQuest"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:RemoveQuest:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		AAP_RemoveQuest(AAP.BookingList["RemoveQuest"])
		AAP.BookingList["RemoveQuest"] = nil
		AAP.BookingList["UpdateMapId"] = 1
		AAP.BookingList["PrintQStep"] = 1
		TestaAAP = "RemoveQuest"
	elseif (AAP.BookingList["UpdateQuest"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:UpdateQuest:")
		end
		AAP.BookingList["UpdateQuest"] = nil
		AAP_UpdateQuest()
		TestaAAP = "UpdateQuest"
	elseif (AAP.BookingList["PrintQStep"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:PrintQStep:")
		end
		AAP.BookingList["PrintQStep"] = nil
		AAP_PrintQStep()
		TestaAAP = "PrintQStep"
	elseif (AAP.BookingList["UpdateILVLGear"]) then
		AAP.BookingList["UpdateILVLGear"] = nil
		AAP_UpdateILVLGear()
		TestaAAP = "UpdateILVLGear"
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:UpdateILVLGear")
		end
	elseif (AAP.BookingList["CheckSaveOldSlot"]) then
		AAP.BookingList["CheckSaveOldSlot"] = nil
		AAP_CheckSaveOldSlot()
		TestaAAP = "CheckSaveOldSlot"
	elseif (AAP.BookingList["CheckZonePick"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:CheckZonePick:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		AAP.BookingList["CheckZonePick"] = nil
		AAP_CheckZonePick()
		TestaAAP = "CheckZonePick"
	elseif (AAP.BookingList["ZoneTransfer"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:ZoneTransfer:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		AAP.BookingList["ZoneTransfer"] = nil
		AAP.FP.GetMeToNextZone()
		TestaAAP = "ZoneTransfer"
	elseif (AAP.BookingList["SetQPTT"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:SetQPTT:"..AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap])
		end
		AAP.BookingList["SetQPTT"] = nil
		AAP_SetQPTT()
		TestaAAP = "SetQPTT"
	elseif (AAP.BookingList["TestTaxiFunc"]) then
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:TestTaxiFunc")
		end
		AAP_AntiTaxiLoop = AAP_AntiTaxiLoop + 1
		if (UnitOnTaxi("player")) then
			AAP.BookingList["TestTaxiFunc"] = nil
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["UseFlightPath"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			end
			AAP.BookingList["PrintQStep"] = 1
			AAP_AntiTaxiLoop = 0
		elseif (AAP_AntiTaxiLoop == 50 or AAP_AntiTaxiLoop == 100 or AAP_AntiTaxiLoop == 150) then
			AAP.BookingList["TestTaxiFunc"] = nil
		end
		if (AAP_AntiTaxiLoop > 200) then
			print ("AAP: Error - AntiTaxiLoop")
			AAP.BookingList["TestTaxiFunc"] = nil
			AAP_AntiTaxiLoop = 0
		end
		TestaAAP = "TestTaxiFunc"
	elseif (AAP.BookingList["UpdateZoneQuestOrderListL"]) then
		AAP.UpdateZoneQuestOrderList("LoadIn")
		AAP.BookingList["UpdateZoneQuestOrderListL"] = nil
	elseif (AAP.BookingList["SkipCutscene"]) then
		AAP.BookingList["SkipCutscene"] = nil
		--CinematicFrame_CancelCinematic()
		C_Timer.After(1, CinematicFrame_CancelCinematic)
		C_Timer.After(3, CinematicFrame_CancelCinematic)
		TestaAAP = "SkipCutscene"
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:SkipCutscene")
		end
	elseif (AAP.BookingList["GetMeToNextZone2"]) then
		AAP.BookingList["GetMeToNextZone2"] = nil
		AAP.FP.GetMeToNextZone2()
	elseif (AAP.BookingList["ButtonSpellidchk"]) then
		for AAP_index,AAP_value in pairs(AAP.BookingList["ButtonSpellidchk"]) do
			if (AAP_value) then
				local _, duration = GetItemCooldown(AAP_value)
				if (duration and duration > 0 and AAP_index and AAP.QuestList2 and AAP.QuestList2["BF"..AAP_index] and AAP.QuestList2["BF"..AAP_index]["AAP_ButtonCD"]) then
					AAP.QuestList2["BF"..AAP_index]["AAP_ButtonCD"]:SetCooldown(GetTime(), duration)
				end
			end
		end
		AAP.BookingList["ButtonSpellidchk"] = nil
		TestaAAP = "ButtonSpellidchk"
		if (AAP1["Debug"]) then
			print("LoopBookingFunc:ButtonSpellidchk")
		end
	end
	if (AAP1 and AAP1[AAP.Realm][AAP.Name] and AAP1[AAP.Realm][AAP.Name]["Settings"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"] and AAP_ArrowUpdateNr >= AAP1[AAP.Realm][AAP.Name]["Settings"]["ArrowFPS"]) then
		AAP_PosTest()
		AAP_ArrowUpdateNr = 0
	else
		AAP_ArrowUpdateNr = AAP_ArrowUpdateNr + 1
	end
	--if (TestaAAP ~= 0) then
	--	print("** "..TestaAAP)
	--end
end
local function AAP_BuyMerchFunc()
	local i
	for i=1,GetMerchantNumItems() do
		local link = GetMerchantItemLink(i)
		if (link) then
			local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
			if (tonumber(Id) == 160499) then
				BuyMerchantItem(i)
				MerchantFrame:Hide()
				return 1
			end
		end
	end
	return 0
end
local function AAP_PopupFunc()
	if (GetNumAutoQuestPopUps() > 0) then
		local questID, popUpType = GetAutoQuestPopUp(1)
		if(popUpType == "OFFER") then
			ShowQuestOffer(1)
			ShowQuestOffer(questID)
		elseif (popUpType == "COMPLETE") then
			ShowQuestOffer(1)
			ShowQuestComplete(questID)
		end
	else
		C_Timer.After(1, AAP_PopupFunc)
	end
end
function AAP_BookQStep()
	AAP.BookingList["UpdateQuest"] = 1
	AAP.BookingList["PrintQStep"] = 1
	if (AAP1["Debug"]) then
		print("Extra BookQStep")
	end
end
function AAP_UpdMapIDz()
	AAP.BookingList["UpdateMapId"] = 1
end
function AAP_UpdQuestThing()
	if (UnitGUID("target") and UnitName("target")) then
		local guid, name = UnitGUID("target"), UnitName("target")
		local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
		if (npc_id and name) then
			if (AAP.ActiveQuests and AAP.ActiveQuests["55981-3"] and AAP.ActiveQuests["55981-3"] ~= "C" and tonumber(npc_id) == 153580) then
				DoEmote("hug")
			elseif (AAP.ActiveQuests and AAP.ActiveQuests["55981-4"] and AAP.ActiveQuests["55981-4"] ~= "C" and tonumber(npc_id) == 153580) then
				DoEmote("wave")
			elseif (AAP.ActiveQuests and AAP.ActiveQuests["59978-4"] and AAP.ActiveQuests["59978-4"] ~= "C" and tonumber(npc_id) == 153580) then
				DoEmote("wave")
			end
		end
	end
	AAP.BookingList["UpdateQuest"] = 1
	AAP.BookingList["PrintQStep"] = 1
	Updateblock = 0
	if (AAP1["Debug"]) then
		print("Extra UpdQuestThing")
	end
end
function AAP_UpdatezeMapId()
	AAP.BookingList["UpdateMapId"] = 1
end
local function AAP_ZoneResetQnumb()
	QNumberLocal = 0
	AAP_SetQPTT()
end
local function AAP_InstanceTest()
	local inInstance, instanceType = IsInInstance()
	if (inInstance) then
		local name, type, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapId, lfgID = GetInstanceInfo()
		if (instanceMapId == 1760) then
			return 0
		elseif (instanceMapId == 1904) then
			return 0
		else
			return 1
		end
	else
		return 0
	end
end
function AAP.GroupListingFunc(AAP_StepStuffs, AAP_GListName)
	if (not AAP.GroupListSteps[1]) then
		AAP.GroupListSteps[1] = {}
		AAP.GroupListStepsNr = 1
	end
	AAP.GroupListSteps[1]["Step"] = AAP_StepStuffs
	AAP.GroupListSteps[1]["Name"] = AAP.Name
	if (AAP_GListName ~= AAP.Name) then
		local AAPNews = 0
		for AAP_index,AAP_value in pairs(AAP.GroupListSteps) do
			if (AAP.GroupListSteps[AAP_index]["Name"] == AAP_GListName) then
				AAP.GroupListSteps[AAP_index]["Step"] = AAP_StepStuffs
				AAPNews = 1
			end
		end
		if (AAPNews == 0) then
			AAP.GroupListStepsNr = AAP.GroupListStepsNr + 1
			AAP.GroupListSteps[AAP.GroupListStepsNr] = {}
			AAP.GroupListSteps[AAP.GroupListStepsNr]["Name"] = AAP_GListName
			AAP.GroupListSteps[AAP.GroupListStepsNr]["Step"] = AAP_StepStuffs
		end
	end
	AAP.RepaintGroups()
end
function AAP.RepaintGroups()
	if (IsInInstance()) then
		local CLi
		for CLi = 1, 5 do
			AAP.PartyList.PartyFrames[CLi]:Hide()
			AAP.PartyList.PartyFrames2[CLi]:Hide()
		end
	else
		if (not AAP.GroupListSteps[1]) then
			AAP.GroupListSteps[1] = {}
			AAP.GroupListStepsNr = 1
		end
		AAP.GroupListSteps[1]["Step"] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		AAP.GroupListSteps[1]["Name"] = AAP.Name
		local CLi
		for CLi = 1, 5 do
			if (AAP.GroupListSteps[CLi]) then
				AAP.PartyList.PartyFramesFS1[CLi]:SetText(AAP.GroupListSteps[CLi]["Name"])
				AAP.PartyList.PartyFramesFS2[CLi]:SetText(AAP.GroupListSteps[CLi]["Step"])
				local CLi2
				local Highnr = 0
				for CLi2 = 1, 5 do
					if (AAP.GroupListSteps[CLi2] and AAP.GroupListSteps[CLi2]["Step"] and AAP.GroupListSteps[CLi] and AAP.GroupListSteps[CLi]["Step"] and (AAP.GroupListSteps[CLi2]["Step"] > AAP.GroupListSteps[CLi]["Step"])) then
						Highnr = 1
					end
				end
				if (Highnr == 1) then
					AAP.PartyList.PartyFramesFS2[CLi]:SetTextColor(1, 0, 0)
				else
					AAP.PartyList.PartyFramesFS2[CLi]:SetTextColor(0, 1, 0)
				end
				AAP.PartyList.PartyFrames[CLi]:Show()
				AAP.PartyList.PartyFrames2[CLi]:Show()
			else
				AAP.PartyList.PartyFrames[CLi]:Hide()
				AAP.PartyList.PartyFrames2[CLi]:Hide()
			end
		end
	end
	if (AAP1[AAP.Realm][AAP.Name]["Settings"]["ShowGroup"] == 0) then
		local CLi
		for CLi = 1, 5 do
			AAP.PartyList.PartyFrames[CLi]:Hide()
			AAP.PartyList.PartyFrames2[CLi]:Hide()
		end
	end
end
function AAP.CheckSweatBuffz()
	for i=1,20 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = UnitBuff("player", i)
		if (spellId and name) then
			if (spellId == 311103) then
				AAP.SweatBuff[1] = 1
				AAP.QuestList.SweatOfOurBrowBuffFrame.Traps.texture:SetColorTexture(0.1,0.5,0.1,1)
			end
			if (spellId == 311107) then
				AAP.SweatBuff[2] = 1
				AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2.texture:SetColorTexture(0.1,0.5,0.1,1)
			end
			if (spellId == 311058) then
				AAP.SweatBuff[3] = 1
				AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3.texture:SetColorTexture(0.1,0.5,0.1,1)
			end
		end
	end
end
AAP.LoopBooking = CreateFrame("frame")
AAP.LoopBooking:SetScript("OnUpdate", AAP_LoopBookingFunc)

AAP_QH_EventFrame = CreateFrame("Frame")
AAP_QH_EventFrame:RegisterEvent ("QUEST_REMOVED")
AAP_QH_EventFrame:RegisterEvent ("QUEST_ACCEPTED")
AAP_QH_EventFrame:RegisterEvent ("UNIT_QUEST_LOG_CHANGED")
AAP_QH_EventFrame:RegisterEvent ("ZONE_CHANGED")
AAP_QH_EventFrame:RegisterEvent ("ZONE_CHANGED_NEW_AREA")
AAP_QH_EventFrame:RegisterEvent ("UPDATE_MOUSEOVER_UNIT")
AAP_QH_EventFrame:RegisterEvent ("GOSSIP_SHOW")
AAP_QH_EventFrame:RegisterEvent ("GOSSIP_CLOSED")
AAP_QH_EventFrame:RegisterEvent ("UI_INFO_MESSAGE")
AAP_QH_EventFrame:RegisterEvent ("HEARTHSTONE_BOUND")
AAP_QH_EventFrame:RegisterEvent ("UNIT_SPELLCAST_SUCCEEDED")
AAP_QH_EventFrame:RegisterEvent ("UNIT_SPELLCAST_START")
AAP_QH_EventFrame:RegisterEvent ("QUEST_PROGRESS")
AAP_QH_EventFrame:RegisterEvent ("QUEST_DETAIL")
AAP_QH_EventFrame:RegisterEvent ("QUEST_COMPLETE")
AAP_QH_EventFrame:RegisterEvent ("QUEST_FINISHED")
AAP_QH_EventFrame:RegisterEvent ("TAXIMAP_OPENED")
AAP_QH_EventFrame:RegisterEvent ("MERCHANT_SHOW")
AAP_QH_EventFrame:RegisterEvent ("QUEST_GREETING")
AAP_QH_EventFrame:RegisterEvent ("ITEM_PUSH")
AAP_QH_EventFrame:RegisterEvent ("QUEST_AUTOCOMPLETE")
AAP_QH_EventFrame:RegisterEvent ("QUEST_ACCEPT_CONFIRM")
AAP_QH_EventFrame:RegisterEvent ("UNIT_ENTERED_VEHICLE")
AAP_QH_EventFrame:RegisterEvent ("CHROMIE_TIME_OPEN")
AAP_QH_EventFrame:RegisterEvent ("QUEST_LOG_UPDATE")
AAP_QH_EventFrame:RegisterEvent ("PLAYER_TARGET_CHANGED")
AAP_QH_EventFrame:RegisterEvent ("PLAYER_REGEN_ENABLED")
AAP_QH_EventFrame:RegisterEvent ("PLAYER_REGEN_DISABLED")
AAP_QH_EventFrame:RegisterEvent ("CHAT_MSG_ADDON")
AAP_QH_EventFrame:RegisterEvent ("CHAT_MSG_MONSTER_SAY")
AAP_QH_EventFrame:RegisterEvent ("CHAT_MSG_COMBAT_XP_GAIN")
AAP_QH_EventFrame:RegisterEvent ("LEARNED_SPELL_IN_TAB")
AAP_QH_EventFrame:RegisterEvent ("UNIT_AURA")
AAP_QH_EventFrame:RegisterEvent ("PLAYER_CHOICE_UPDATE")
AAP_QH_EventFrame:RegisterEvent ("REQUEST_CEMETERY_LIST_RESPONSE")
AAP_QH_EventFrame:RegisterEvent ("AJ_REFRESH_DISPLAY")
AAP_QH_EventFrame:RegisterEvent ("UPDATE_UI_WIDGET")

AAP_QH_EventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event=="UPDATE_UI_WIDGET") then
		if (AAP.ActiveQuests and AAP.ActiveQuests["57713-4"]) then
			AAP.BookingList["PrintQStep"] = 1
		end
	end
	if (event=="AJ_REFRESH_DISPLAY") then
	end
	if (event=="REQUEST_CEMETERY_LIST_RESPONSE") then
		AAP.BookingList["UpdateMapId"] = 1
		C_Timer.After(1, AAP_ZoneResetQnumb)
		C_Timer.After(1, AAP_BookQStep)
	end
	if (event=="LEARNED_SPELL_IN_TAB") then
		local arg1, arg2, arg3, arg4 = ...;
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["SpellInTab"] and (arg1 == steps["SpellInTab"] or arg2 == steps["SpellInTab"])) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["UpdateQuest"] = 1
			AAP.BookingList["PrintQStep"] = 1
		end
	end
	if (event=="QUEST_LOG_UPDATE") then
		C_Timer.After(0.1, AAP_UpdQuestThing)
	end
	if (event=="UNIT_AURA") then
		local arg1, arg2, arg3, arg4 = ...;
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["QSpecialz"] and AAP.ActiveQuests and AAP.ActiveQuests["57657-2"]) then
			AAP.BookingList["PrintQStep"] = 1
		end
		if (arg1 == "player" and steps and steps["Debuffcount"]) then
			for i=1,20 do
				local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = UnitBuff("player", i)
				if (spellId and name and count) then
					if (spellId == 69704 and count == 5) then
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
					end
				end
			end
		end
		if (AAP.SweatBuff[1] == 1 or AAP.SweatBuff[2] == 1 or AAP.SweatBuff[3] == 1) then
			local gotbuff1 = 0
			local gotbuff2 = 0
			local gotbuff3 = 0
			for i=1,20 do
				local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = UnitBuff("player", i)
				if (spellId and name) then
					if (spellId == 311103) then
						gotbuff1 = 1
					elseif (spellId == 311107) then
						gotbuff2 = 1
					elseif (spellId == 311058) then
						gotbuff3 = 1
					end
				end
			end
			if (AAP.SweatBuff[1] == 1) then
				if (gotbuff1 == 0) then
					AAP.SweatBuff[1] = 0
					AAP.QuestList.SweatOfOurBrowBuffFrame.Traps.texture:SetColorTexture(0.5,0.1,0.1,1)
				end
			end
			if (AAP.SweatBuff[2] == 1) then
				if (gotbuff2 == 0) then
					AAP.SweatBuff[2] = 0
					AAP.QuestList.SweatOfOurBrowBuffFrame.Traps2.texture:SetColorTexture(0.5,0.1,0.1,1)
				end
			end
			if (AAP.SweatBuff[3] == 1) then
				if (gotbuff3 == 0) then
					AAP.SweatBuff[3] = 0
					AAP.QuestList.SweatOfOurBrowBuffFrame.Traps3.texture:SetColorTexture(0.5,0.1,0.1,1)
				end
			end
		end
		if (arg1 == "player" and AAP.ActiveQuests and AAP.ActiveQuests[57867]) then
			AAP.CheckSweatBuffz()
			C_Timer.After(2, AAP.CheckSweatBuffz)
		end
	end
	if (event=="PLAYER_TARGET_CHANGED") then
		if (UnitGUID("target") and UnitName("target")) then
			local guid, name = UnitGUID("target"), UnitName("target")
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
			if (npc_id and name) then
				if (AAP.ActiveQuests and AAP.ActiveQuests["55981-3"] and AAP.ActiveQuests["55981-3"] ~= "C" and tonumber(npc_id) == 153580) then
					DoEmote("hug")
				elseif (AAP.ActiveQuests and AAP.ActiveQuests["55981-4"] and AAP.ActiveQuests["55981-4"] ~= "C" and tonumber(npc_id) == 153580) then
					DoEmote("wave")
				elseif (AAP.ActiveQuests and AAP.ActiveQuests["59978-4"] and AAP.ActiveQuests["59978-4"] ~= "C" and tonumber(npc_id) == 153580) then
					DoEmote("wave")
				end
			end
		end
	end
	if (event=="CHAT_MSG_COMBAT_XP_GAIN") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["Treasure"]) then
			AAP.BookingList["UpdateQuest"] = 1
			AAP.BookingList["PrintQStep"] = 1
			C_Timer.After(2, AAP_BookQStep)
			C_Timer.After(4, AAP_BookQStep)
		end
	end
	if (event=="UNIT_ENTERED_VEHICLE") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["MountVehicle"]) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["UpdateQuest"] = 1
			AAP.BookingList["PrintQStep"] = 1
		end
	end
	if (event=="PLAYER_REGEN_ENABLED") then
		AAP.InCombat = 0
		if (AAP.BookUpdAfterCombat == 1) then
			AAP.BookingList["PrintQStep"] = 1
		end
	end
	if (event=="PLAYER_REGEN_DISABLED") then
		AAP.InCombat = 1
	end
	if (event=="CHAT_MSG_ADDON") then
		local arg1, arg2, arg3, arg4 = ...;
		if (arg1 == "AAPChat" and arg3 == "PARTY") then
			AAP.GroupListingFunc(tonumber(arg2), AAP.TrimPlayerServer(arg4))
		end
	end
	if (event=="PLAYER_CHOICE_UPDATE") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		local Choizs = C_PlayerChoice.GetPlayerChoiceInfo()
		if (Choizs) then
			local choiceID = Choizs["choiceID"]
			local questionText = Choizs["questionText"]
			local numOptions = Choizs["numOptions"]
			if (numOptions and numOptions > 1 and steps and steps["Brewery"]) then
				local CLi
				for CLi = 1, numOptions do
					local opzios = C_PlayerChoice.GetPlayerChoiceOptionInfo(CLi)
					local optionID = opzios["id"]
					if (steps["Brewery"] == optionID) then
						--C_PlayerChoice.SendQuestChoiceResponse(GetQuestChoiceOptionInfo(CLi))
						PlayerChoiceFrame["Option"..CLi]["OptionButtonsContainer"]["button1"]:Click()
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
						break
					end
				end
			end
			if (numOptions and numOptions > 1 and steps and steps["SparringRing"]) then
				local CLi
				for CLi = 1, numOptions do
					local opzios = C_PlayerChoice.GetPlayerChoiceOptionInfo(CLi)
					local optionID = opzios["id"]
					if (steps["SparringRing"] == optionID) then
						PlayerChoiceFrame["Option"..CLi]["OptionButtonsContainer"]["button1"]:Click()
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["UpdateQuest"] = 1
						AAP.BookingList["PrintQStep"] = 1
						break
					end
				end
			end
		end
		if (numOptions and numOptions > 1 and steps and steps["PickUpSpecial"]) then
			local CLi
			for CLi = 1, numOptions do
				local optionID, buttonText, description, artFile = GetQuestChoiceOptionInfo(CLi)
				if (steps["PickUpSpecial"] == optionID) then
					SendQuestChoiceResponse(GetQuestChoiceOptionInfo(CLi))
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
					break
				end
			end
		end
	end
	if (event=="UNIT_ENTERED_VEHICLE") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if (arg1 == "player") then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
				if (steps and steps["InVehicle"]) then
					AAP.BookingList["PrintQStep"] = 1
				end
			end
		end
	end
	if (event=="QUEST_AUTOCOMPLETE") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if(AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] == 1 and not IsControlKeyDown()) then
			if (steps and steps["SpecialNoAutoHandin"]) then
			else
				AAP_PopupFunc()
			end
		end
	end
	
	if (event=="CHROMIE_TIME_OPEN") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["ChromiePick"]) then
			local AAPChromie = C_ChromieTime.GetChromieTimeExpansionOptions()
			for AAP_index,AAP_value in pairs(AAPChromie) do
				if (steps["ChromiePick"] == AAPChromie[AAP_index]["id"]) then
					C_ChromieTime.SelectChromieTimeOption(AAPChromie[AAP_index]["id"])
					print("AAP: Switched to "..AAPChromie[AAP_index]["name"].." time.")
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
					break
				end
			end
		end
	end
	if (event=="QUEST_ACCEPT_CONFIRM") then
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] == 1 and not IsControlKeyDown()) then
			AcceptQuest()
		end
	end
	if (event=="QUEST_GREETING") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["DenyNPC"]) then
			if (UnitGUID("target") and UnitName("target")) then
				local guid, name = UnitGUID("target"), UnitName("target")
				local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
				if (npc_id and name) then
					if (tonumber(npc_id) == steps["DenyNPC"]) then
						C_GossipInfo.CloseGossip()
					end
				end
			end
		end
		if (steps and steps["SpecialNoAutoHandin"]) then
			return
		end
		if (UnitGUID("target") and string.find(UnitGUID("target"), "(.*)-(.*)")) then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",UnitGUID("target"))
			if (npc_id and ((tonumber(npc_id) == 141584) or (tonumber(npc_id) == 142063) or (tonumber(npc_id) == 25809) or (tonumber(npc_id) == 87391))) then
				return
			end
		end
		local numAvailableQuests = 0;
		local numActiveQuests = 0;
		local lastActiveQuest = 0
		local lastAvailableQuest = 0;
		numAvailableQuests = GetNumAvailableQuests();
		numActiveQuests = GetNumActiveQuests();
		if numAvailableQuests > 0 or numActiveQuests > 0 then
			local guid = UnitGUID("target");
			if lastNPC ~= guid then
				lastActiveQuest = 1;
				lastAvailableQuest = 1;
				lastNPC = guid;
			end
			if (lastAvailableQuest > numAvailableQuests) then
				lastAvailableQuest = 1;
			end    
			for i = lastAvailableQuest, numAvailableQuests do
				lastAvailableQuest = i;
				if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] == 1 and not IsControlKeyDown()) then
					SelectAvailableQuest(i);
				end
			end
		end
		if lastActiveQuest > numActiveQuests then
			lastActiveQuest = 1;
		end
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] == 1 and not IsControlKeyDown()) then
			local TempQList = {}
			local i = 1
			local UpdateQpart = 0
			while C_QuestLog.GetTitleForLogIndex(i) do
				local ZeInfoz = C_QuestLog.GetInfo(i)
				if (ZeInfoz) then
					local questID = ZeInfoz["questID"]
					if (questID > 0) then
						local isHeader = ZeInfoz["isHeader"]
						local questTitle = C_QuestLog.GetTitleForQuestID(questID)
						local isComplete = C_QuestLog.IsComplete(questID)
						if (not isHeader) then
							TempQList[questID] = {}
							if (isComplete) then
								TempQList[questID]["C"] = 1
							end
							TempQList[questID]["T"] = questTitle
						end
					end
				else
					break
				end
				i = i + 1
			end
			local CLi
			for CLi = 1, numActiveQuests do
				for CL_index,CL_value in pairs(TempQList) do
					if (GetActiveTitle(CLi) == TempQList[CL_index]["T"] and TempQList[CL_index]["C"] and TempQList[CL_index]["C"] == 1) then
						SelectActiveQuest(CLi)
					end
				end
			end
		end
	end
	if (event=="ITEM_PUSH") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		AAP.BookingList["PrintQStep"] = 1
		C_Timer.After(1, AAP_BookQStep)
	end
	if (event=="MERCHANT_SHOW") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["BuyMerchant"]) then
				if (not IsControlKeyDown() and AAP_BuyMerchFunc() == 0) then
					C_Timer.After(0.1,print(AAP_BuyMerchFunc()))
				end
		end
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoRepair"] == 1) then
			if (CanMerchantRepair()) then	
				repairAllCost, canRepair = GetRepairAllCost();
				if (canRepair and repairAllCost > 0) then
					guildRepairedItems = false
					if (IsInGuild() and CanGuildBankRepair()) then
						local amount = GetGuildBankWithdrawMoney()
						local guildBankMoney = GetGuildBankMoney()
						amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)
						if (amount >= repairAllCost) then
							RepairAllItems(true);
							guildRepairedItems = true
							DEFAULT_CHAT_FRAME:AddMessage("AAP: Equipment has been repaired by your Guild")
						end
					end
					if (repairAllCost <= GetMoney() and not guildRepairedItems) then
						RepairAllItems(false);
						print("AAP: Equipment has been repaired for "..GetCoinTextureString(repairAllCost))
					end
				end
			end
		end
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoVendor"] == 1) then
			local AAPtotal = 0
			for myBags = 0,4 do
				for bagSlots = 1, GetContainerNumSlots(myBags) do
					local CurrentItemLink = GetContainerItemLink(myBags, bagSlots)
					if CurrentItemLink then
						local _, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(CurrentItemLink)
						local _, itemCount = GetContainerItemInfo(myBags, bagSlots)
						if itemRarity == 0 and itemSellPrice ~= 0 then
							AAPtotal = AAPtotal + (itemSellPrice * itemCount)
							UseContainerItem(myBags, bagSlots)
						end
					end
				end
			end
			if AAPtotal ~= 0 then
				print("AAP: Items were sold for "..GetCoinTextureString(AAPtotal))
			end
		end
	end
	if (event=="UI_INFO_MESSAGE") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if (arg1 == 280) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["GetFP"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		if (arg1 == 281) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["GetFP"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		if (arg1 == 282) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["GetFP"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		if (arg1 == 283) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["GetFP"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
	end
	if (event=="TAXIMAP_OPENED") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["GetFP"] and not IsControlKeyDown()) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
		end
	end
	if (event=="UNIT_SPELLCAST_SUCCEEDED") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if ((arg1 == "player") and (AAP_HSSpellIDs[arg3])) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["UseHS"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		if (arg1 == "player") then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.ActiveMap and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			
			if (QuestSpecial57710 == 0 and arg3 == 310061) then
				QuestSpecial57710 = 1
				AAP.BookingList["PrintQStep"] = 1
			end
			
			if (steps and steps["ButtonSpellId"]) then
				for AAP_index,AAP_value in pairs(steps["ButtonSpellId"]) do
					if (arg3 == AAP_index) then
						for AAP_index2,AAP_value2 in pairs(AAP.ButtonList) do
							if (AAP_index2 == AAP_value) then
								if (not AAP.BookingList["ButtonSpellidchk"]) then
									AAP.BookingList["ButtonSpellidchk"] = {}
								end
								AAP.BookingList["ButtonSpellidchk"][AAP_value2] = steps["Button"][AAP_value]
							end
						end
					end
				end
			end
			
			if (steps and steps["SpellTrigger"]) then
				if (arg3 == steps["SpellTrigger"]) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["PrintQStep"] = 1
				end
			end
		end
	end
	if (event=="UNIT_SPELLCAST_START") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if ((arg1 == "player") and (arg3 == 171253)) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["UseGarrisonHS"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			end		
		end
		if ((arg1 == "player") and (arg3 == 222695)) then
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (steps and steps["UseDalaHS"]) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			end
		end
	end
	if (event=="HEARTHSTONE_BOUND") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		local ZeMap = C_Map.GetBestMapForUnit("player")
		local currentMapId, TOP_MOST = C_Map.GetBestMapForUnit('player'), true
		if (Enum and Enum.UIMapType and Enum.UIMapType.Continent and currentMapId) then
			ZeMap = MapUtil.GetMapParentInfo(currentMapId, Enum.UIMapType.Continent+1, TOP_MOST)
		end
		if (ZeMap and ZeMap["mapID"]) then
			ZeMap = ZeMap["mapID"]
		else
			ZeMap = C_Map.GetBestMapForUnit("player")
		end
		AAP1[AAP.Realm][AAP.Name]["HSLoc"] = ZeMap
		if (steps and steps["SetHS"]) then
			AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
			AAP.BookingList["PrintQStep"] = 1
		end
	end
	if (event=="QUEST_ACCEPTED") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if (AAP1["Debug"]) then
			print("QUEST_ACCEPTED: ".. arg1)
		end
		C_Timer.After(0.1, AAP_UpdMapIDz)
		C_Timer.After(3, AAP_UpdMapIDz)
		if (arg2 and arg2 > 0 and not AAP.ActiveQuests[arg2]) then
			AAP.BookingList["AddQuest"] = arg2
		end
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		if (CurStep and AAP.QuestStepList and AAP.ActiveMap and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
			local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			if (steps and steps["ZonePick"]) then
				AAP.BookingList["CheckZonePick"] = 1
			end
			if (steps and steps["LoaPick"] and steps["LoaPick"] == 123 and (AAP.ActiveQuests[47440] or AAP.ActiveQuests[47439])) then
				AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
				AAP.BookingList["PrintQStep"] = 1
			end
		end
		C_Timer.After(0.1, AAP_BookQStep)
		C_Timer.After(3, AAP_BookQStep)
	end
	if (event=="QUEST_REMOVED") then
		if (AAP1["Debug"]) then
			print("QUEST_REMOVED")
		end
		local arg1, arg2, arg3, arg4, arg5 = ...;
		AAP.BookingList["RemoveQuest"] = arg1
		if (AAP.ActiveMap == arg1 and AAP1[AAP.Realm][AAP.Name]["Settings"]["WQs"] == 1) then
			AAP.WQFunc()
			AAP.BookingList["UpdateMapId"] = 1
			AAP1[AAP.Realm][AAP.Name][arg1] = nil
			AAP.RemoveMapIcons()
		end
		AAP1[AAP.Realm][AAP.Name]["QuestCounter2"] = AAP1[AAP.Realm][AAP.Name]["QuestCounter2"] + 1
	end
	if (event=="UNIT_QUEST_LOG_CHANGED") then
		local arg1, arg2, arg3, arg4, arg5 = ...;
		if (arg1 == "player" and Updateblock == 0) then
			Updateblock = 1
			C_Timer.After(1, AAP_UpdQuestThing)
		end
	end
	if (event=="ZONE_CHANGED") then
		QNumberLocal = 0
		if (AAP.ZoneTransfer == 0) then
			C_Timer.After(2, AAP_UpdatezeMapId)
			C_Timer.After(3, AAP_ZoneResetQnumb)
			AAP.BookingList["UpdateMapId"] = 1
		end
	end
	if (event=="ZONE_CHANGED_NEW_AREA") then
		if (AAP.ZoneTransfer == 0) then
			C_Timer.After(2, AAP_UpdatezeMapId)
			AAP.BookingList["UpdateMapId"] = 1
		end
	end
	if (event=="GOSSIP_SHOW") then
		AAP.GossipOpen = 1
		if (UnitGUID("target") and string.find(UnitGUID("target"), "(.*)-(.*)")) then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",UnitGUID("target"))
			if (UnitGUID("target") and string.find(UnitGUID("target"), "(.*)-(.*)")) then
				if (npc_id and ((tonumber(npc_id) == 141584) or (tonumber(npc_id) == 142063))) then
					return
				end
			end
		end
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		if (CurStep and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep] and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] == 1 and not IsControlKeyDown()) then
			local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			if (UnitGUID("target") and string.find(UnitGUID("target"), "(.*)-(.*)")) then
				local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",UnitGUID("target"))
				if (npc_id and ((tonumber(npc_id) == 141584) or (tonumber(npc_id) == 142063) or (tonumber(npc_id) == 45400) or (tonumber(npc_id) == 25809) or (tonumber(npc_id) == 87391))) then
					local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
					if (steps and steps["Gossip"] and steps["Gossip"] == 27373) then
						C_GossipInfo.SelectOption(1)
						AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
						AAP.BookingList["PrintQStep"] = 1
					end
					return
				end
				if (steps and steps["Gossip"] and steps["Gossip"] == 34398) then
					C_GossipInfo.SelectOption(1)
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				end
				if (steps and steps["Gossip"] and steps["Gossip"] == 3433398) then
					C_GossipInfo.SelectOption(2)
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["UpdateQuest"] = 1
					AAP.BookingList["PrintQStep"] = 1
				end
				if (npc_id and (tonumber(npc_id) == 43733) and (tonumber(npc_id) == 45312)) then
					Dismount()
				end
			end
			local AAPDenied = 0
			if (steps and steps["DenyNPC"]) then
				if (UnitGUID("target") and UnitName("target")) then
					local guid, name = UnitGUID("target"), UnitName("target")
					local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
					if (npc_id and name) then
						if (tonumber(npc_id) == steps["DenyNPC"]) then
							AAPDenied = 1
						end
					end
				end
			end
			if (steps and steps["SpecialNoAutoHandin"]) then
				return
			end
			if (AAPDenied == 1) then
				C_GossipInfo.CloseGossip()
				print("AAP: Not Yet!")
			elseif (steps and steps["Gossip"] and steps["Gossip"] == 28202 and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] == 1 and not IsControlKeyDown()) then
				AAPGOSSIPCOUNT = AAPGOSSIPCOUNT + 1
				print(AAPGOSSIPCOUNT)
				if (AAPGOSSIPCOUNT == 1) then
					C_GossipInfo.SelectOption(1)
				elseif (AAPGOSSIPCOUNT == 2) then
					if (AAP.Race == "Gnome") then
						C_GossipInfo.SelectOption(1)
					elseif (AAP.Race == "Human" or AAP.Race == "Dwarf") then
						C_GossipInfo.SelectOption(2)
					elseif (AAP.Race == "NightElf") then
						C_GossipInfo.SelectOption(3)
					elseif (AAP.Race == "Draenei" or AAP.Race == "Worgen") then
						C_GossipInfo.SelectOption(4)
					end
				elseif (AAPGOSSIPCOUNT == 3) then
					if (AAP.Race == "Gnome") then
						C_GossipInfo.SelectOption(3)
					elseif (AAP.Race == "Human" or AAP.Race == "Dwarf") then
						C_GossipInfo.SelectOption(4)
					elseif (AAP.Race == "NightElf") then
						C_GossipInfo.SelectOption(2)
					elseif (AAP.Race == "Draenei" or AAP.Race == "Worgen") then
						C_GossipInfo.SelectOption(1)
					end
				elseif (AAPGOSSIPCOUNT == 4) then
					if (AAP.Race == "Gnome") then
						C_GossipInfo.SelectOption(4)
					elseif (AAP.Race == "Human" or AAP.Race == "Dwarf") then
						C_GossipInfo.SelectOption(2)
					elseif (AAP.Race == "NightElf") then
						C_GossipInfo.SelectOption(1)
					elseif (AAP.Race == "Draenei" or AAP.Race == "Worgen") then
						C_GossipInfo.SelectOption(3)
					end
				elseif (AAPGOSSIPCOUNT == 5) then
					AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
					AAP.BookingList["PrintQStep"] = 1
				end
			elseif (steps and steps["Gossip"] and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoGossip"] == 1 and not IsControlKeyDown()) then
				C_GossipInfo.SelectOption(steps["Gossip"])
				local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
				local steps
				if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
					steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
				end
				if (steps and steps["BlockQuests"]) then
					StaticPopup1Button1:SetScript("OnMouseDown", function(self, button)
						local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
						local steps
						if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
							steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
						end
						if (steps and steps["BlockQuests"]) then
							AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap] + 1
							AAP.BookingList["UpdateQuest"] = 1
							AAP.BookingList["PrintQStep"] = 1
						end
					end)
				end
			end
		end
		local arg1, arg2, arg3, arg4 = ...;
		local ActiveQuests = C_GossipInfo.GetActiveQuests()
		local ActiveQNr = C_GossipInfo.GetNumActiveQuests()
		local CLi
		local NumAvailableQuests = C_GossipInfo.GetNumAvailableQuests()
		local AvailableQuests = {C_GossipInfo.GetAvailableQuests()}
		if (ActiveQuests and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] == 1 and not IsControlKeyDown()) then
			for CLi = 1, ActiveQNr do
				if (ActiveQuests[CLi] and ActiveQuests[CLi]["isComplete"] == true) then
					C_GossipInfo.SelectActiveQuest(CLi)
				end
			end
		end
		if (NumAvailableQuests > 0 and AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] == 1 and not IsControlKeyDown()) then
			if (steps and steps["BlockQuests"]) then
			elseif (steps and steps["SpecialPickupOrder"]) then
				C_GossipInfo.SelectAvailableQuest(2)
			else
				C_GossipInfo.SelectAvailableQuest(1)
			end
		end
	end
	if (event=="GOSSIP_CLOSED") then
		AAPGOSSIPCOUNT = 0
		AAP.GossipOpen = 0
	end
	if (event=="QUEST_DETAIL") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["DenyNPC"]) then
			if (UnitGUID("target") and UnitName("target")) then
				local guid, name = UnitGUID("target"), UnitName("target")
				local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
				if (npc_id and name) then
					if (tonumber(npc_id) == steps["DenyNPC"]) then
						C_GossipInfo.CloseGossip()
					end
				end
			end
		end
		if (UnitGUID("target") and string.find(UnitGUID("target"), "(.*)-(.*)")) then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",UnitGUID("target"))
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			if (CurStep and AAP.ActiveMap and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
				local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
				local AAPDenied = 0
				if (steps and steps["DenyNPC"]) then
					if (UnitGUID("target") and UnitName("target")) then
						local guid, name = UnitGUID("target"), UnitName("target")
						local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
						if (npc_id and name) then
							if (tonumber(npc_id) == steps["DenyNPC"]) then
								AAPDenied = 1
							end
						end
					end
				end
				if (AAPDenied == 1) then
					CloseQuest()
					print("AAP: Not Yet!")
				end
			end
		end
		if (GetQuestID() and (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoAccept"] == 1) and (not IsControlKeyDown())) then
			if (QuestGetAutoAccept()) then
				CloseQuest()
			else
				QuestInfoDescriptionText:SetAlphaGradient(0, -1)
				QuestInfoDescriptionText:SetAlpha(1)
				AAP.BookingList["AcceptQuest"] = 1
			end
		end
	end
	if (event=="QUEST_PROGRESS") then
		if (AAP1["Debug"]) then
			print("QUEST_PROGRESS")
		end
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["DenyNPC"]) then
			if (UnitGUID("target") and UnitName("target")) then
				local guid, name = UnitGUID("target"), UnitName("target")
				local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
				if (npc_id and name) then
					if (tonumber(npc_id) == steps["DenyNPC"]) then
						C_GossipInfo.CloseGossip()
					end
				end
			end
		end
		if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] == 1 and not IsControlKeyDown()) then
			if (steps and steps["SpecialNoAutoHandin"]) then
				return
			end
			AAP.BookingList["CompleteQuest"] = 1
			if (AAP1["Debug"]) then
				print("Complete")
			end
		end
	end

	if (event=="QUEST_COMPLETE") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		local steps
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
			steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
		end
		if (steps and steps["DenyNPC"]) then
			if (UnitGUID("target") and UnitName("target")) then
				local guid, name = UnitGUID("target"), UnitName("target")
				local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
				if (npc_id and name) then
					if (tonumber(npc_id) == steps["DenyNPC"]) then
						C_GossipInfo.CloseGossip()
					end
				end
			end
		end
		if (GetNumQuestChoices() > 1) then
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandInChoice"] == 1) then
				local AAP_GearIlvlList = {}
				for slots2 = 0,18 do
					if (GetInventoryItemLink("player", slots2)) then
						local _, _, itemRarity, itemLevel, _, _, _, _, SpotName = GetItemInfo(GetInventoryItemLink("player", slots2))
						if (itemRarity == 7) then
							itemLevel = GetDetailedItemLevelInfo(GetInventoryItemLink("player", slots2))
						end
						if (SpotName and itemLevel) then
							if (SpotName == "INVTYPE_WEAPONOFFHAND") then
								SpotName = "INVTYPE_WEAPON"
							end
							if (SpotName == "INVTYPE_WEAPONMAINHAND") then
								SpotName = "INVTYPE_WEAPON"
							end
							if (SpotName == "INVTYPE_WEAPON" or SpotName == "INVTYPE_SHIELD" or SpotName == "INVTYPE_2HWEAPON" or SpotName == "INVTYPE_WEAPONMAINHAND" or SpotName == "INVTYPE_WEAPONOFFHAND" or SpotName == "INVTYPE_HOLDABLE" or SpotName == "INVTYPE_RANGED" or SpotName == "INVTYPE_THROWN" or SpotName == "INVTYPE_RANGEDRIGHT" or SpotName == "INVTYPE_RELIC") then
								SpotName = "INVTYPE_WEAPON"
							end
							if (AAP_GearIlvlList[SpotName]) then
								if (AAP_GearIlvlList[SpotName] > itemLevel) then
									AAP_GearIlvlList[SpotName] = itemLevel
								end
							else
								AAP_GearIlvlList[SpotName] = itemLevel
							end
						end
					end
				end
				local AAPTempGearList = {}
				local isweaponz = 0
				local AAPColorof = 0
				for h=1, GetNumQuestChoices() do
					local _, _, ItemRarityz, _, _, _, _, _, SpotName = GetItemInfo(GetQuestItemLink("choice", h))
					local ilvl = GetDetailedItemLevelInfo(GetQuestItemLink("choice", h))
					if (SpotName == "INVTYPE_WEAPONOFFHAND") then
						SpotName = "INVTYPE_WEAPON"
					end
					if (SpotName == "INVTYPE_WEAPONMAINHAND") then
						SpotName = "INVTYPE_WEAPON"
					end
					if (SpotName == "INVTYPE_WEAPON" or SpotName == "INVTYPE_SHIELD" or SpotName == "INVTYPE_2HWEAPON" or SpotName == "INVTYPE_WEAPONMAINHAND" or SpotName == "INVTYPE_WEAPONOFFHAND" or SpotName == "INVTYPE_HOLDABLE" or SpotName == "INVTYPE_RANGED" or SpotName == "INVTYPE_THROWN" or SpotName == "INVTYPE_RANGEDRIGHT" or SpotName == "INVTYPE_RELIC") then
						SpotName = "INVTYPE_WEAPON"
						print(SpotName)
					end
					if (AAP_GearIlvlList[SpotName]) then
						if (ItemRarityz > 2) then
							--AAPColorof = ItemRarityz
						end
						AAPTempGearList[h] = ilvl - AAP_GearIlvlList[SpotName]
						print("Qilvl: "..ItemRarityz.." - "..SpotName.." - MySpot: "..AAP_GearIlvlList[SpotName])
						if (SpotName == "INVTYPE_WEAPON" or SpotName == "INVTYPE_SHIELD" or SpotName == "INVTYPE_2HWEAPON" or SpotName == "INVTYPE_WEAPONMAINHAND" or SpotName == "INVTYPE_WEAPONOFFHAND" or SpotName == "INVTYPE_HOLDABLE" or SpotName == "INVTYPE_RANGED" or SpotName == "INVTYPE_THROWN" or SpotName == "INVTYPE_RANGEDRIGHT" or SpotName == "INVTYPE_RELIC") then
							--isweaponz = 1
						end
					end
				end
				-- temp remove
				isweaponz = 0
				AAPColorof = 0
				if (AAPColorof > 2) then
				elseif (isweaponz == 1) then
				else
					local PickOne = 0
					local PickOne2 = -99999
					for AAP_indexx,AAP_valuex in pairs(AAPTempGearList) do
						if (AAP_valuex > PickOne2) then
							PickOne = AAP_indexx
							PickOne2 = AAP_valuex
						end
					end
					if (PickOne > 0) then
						GetQuestReward(PickOne)
						--print("picked: "..PickOne)
					end
				end
			end
		else
			local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
			local steps
			if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap]) then
				steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			end
			if (AAP1[AAP.Realm][AAP.Name]["Settings"]["AutoHandIn"] == 1 and not IsControlKeyDown()) then
				if (steps and steps["SpecialNoAutoHandin"]) then
					return
				end
				if (UnitGUID("target") and string.find(UnitGUID("target"), "(.*)-(.*)")) then
					local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",UnitGUID("target"))
					if (npc_id and ((tonumber(npc_id) == 141584) or (tonumber(npc_id) == 142063) or (tonumber(npc_id) == 45400) or (tonumber(npc_id) == 25809) or (tonumber(npc_id) == 87391))) then
						return
					end
				end
				GetQuestReward(1)
			end
		end
	end
	if (event=="CHAT_MSG_MONSTER_SAY") then
		local arg1, arg2, arg3, arg4 = ...;
		if (UnitGUID("target") and UnitName("target")) then
			local guid, name = UnitGUID("target"), UnitName("target")
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
			if (npc_id and name) then
				if (tonumber(npc_id) == 159477) then
					if (AAP_GigglingBasket[arg1]) then
						print("AAP: Doing Emote: "..AAP_GigglingBasket[arg1])
						DoEmote(AAP_GigglingBasket[arg1])
					end
				end
			end
		end
	end
	if (event=="UPDATE_MOUSEOVER_UNIT") then
		local CurStep = AAP1[AAP.Realm][AAP.Name][AAP.ActiveMap]
		if (CurStep and AAP.QuestStepList and AAP.QuestStepList[AAP.ActiveMap] and AAP.QuestStepList[AAP.ActiveMap][CurStep]) then
			local steps = AAP.QuestStepList[AAP.ActiveMap][CurStep]
			if (steps and steps["RaidIcon"]) then
				local guid = UnitGUID("mouseover")
				if (guid) then
					local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid)
					if (npc_id and tonumber(steps["RaidIcon"]) == tonumber(npc_id)) then
						if (not GetRaidTargetIndex("mouseover")) then
							SetRaidTarget("mouseover",8)
						end
					end
				end
			elseif (steps and steps["DroppableQuest"]) then
				if (UnitGUID("mouseover") and UnitName("mouseover")) then
					local guid, name = UnitGUID("mouseover"), UnitName("mouseover")
					local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
					if (type == "Creature" and npc_id and name and steps["DroppableQuest"]["MobId"] == tonumber(npc_id)) then
						if (AAP.NPCList and not AAP.NPCList[tonumber(npc_id)]) then
							AAP.NPCList[tonumber(npc_id)] = name

						end
					end
				end
			end
		end
	end
end)
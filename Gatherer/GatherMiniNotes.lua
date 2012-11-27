--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.0.6 (<%codename%>)
	Revision: $Id: GatherMiniNotes.lua 1025 2012-09-26 03:00:40Z Esamynn $

	License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program(see GPL.txt); if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Minimap Drawing Routines
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherMiniNotes.lua $", "$Rev: 1025 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

local timeDiff = 0
local checkDiff = 0
local numNotesUsed = 0
local numArchNotesUsed = 0

local SHADED_TEXTURE = "Interface\\AddOns\\Gatherer\\Shaded\\White"

-- table to store current active Minimap Notes objects
Gatherer.MiniNotes.Notes = {}
Gatherer.MiniNotes.ArchNotes = {}

function Gatherer.MiniNotes.Show()
	if ( Gatherer.Config.GetSetting("minimap.enable") ) then
		if ( GatherMiniNoteUpdateFrame:IsShown() ) then
			Gatherer.MiniNotes.ForceUpdate()
		else
			GatherMiniNoteUpdateFrame:Show()
		end
	end
end

function Gatherer.MiniNotes.ForceUpdate()
	if ( GatherMiniNoteUpdateFrame:IsShown() ) then
		Gatherer.MiniNotes.UpdateMinimapNotes(0, true)
	end
end

function Gatherer.MiniNotes.Hide()
	GatherMiniNoteUpdateFrame:Hide()
	numNotesUsed = 0
	for i, note in pairs(Gatherer.MiniNotes.Notes) do
		Astrolabe:RemoveIconFromMinimap(note)
	end
	numArchNotesUsed = 0
	for i, note in pairs(Gatherer.MiniNotes.ArchNotes) do
		Astrolabe:RemoveIconFromMinimap(note)
	end
end

local function GetMinimapNote( index )
	local note = Gatherer.MiniNotes.Notes[index]
	if not ( note ) then
		note = CreateFrame("Button", "GatherNote"..index, Minimap, "GatherNoteTemplate")
		Gatherer.MiniNotes.Notes[index] = note
		note:SetID(index)
	end
	return note
end

local function GetArchMinimapNote( index )
	local note = Gatherer.MiniNotes.ArchNotes[index]
	if not ( note ) then
		note = CreateFrame("Button", "GatherArchNote"..index, Minimap, "GatherArchNoteTemplate")
		Gatherer.MiniNotes.ArchNotes[index] = note
		note:SetID(index)
	end
	return note
end

local function ArchFilter( nodeId, gType )
	if ( gType == "ARCH" ) then
		return true
	else
		return false
	end
end

function Gatherer.MiniNotes.UpdateMinimapNotes(timeDelta, force)
	local setting = Gatherer.Config.GetSetting
	
	if ( Astrolabe.WorldMapVisible and (not Astrolabe:GetCurrentPlayerPosition()) ) then
		return
	end
	
	if not ( setting("minimap.enable") ) then
		Gatherer.MiniNotes.Hide()
		return
	end
	
	local updateIcons = false
	local updateNodes = false
	
	if ( force or Gatherer.Command.IsUpdated("minimap.update") ) then
		updateIcons = true
		updateNodes = true
	else
		checkDiff = checkDiff + timeDelta
		timeDiff = timeDiff + timeDelta
		if (checkDiff > Gatherer.Var.NoteCheckInterval) then
			updateNodes = true
			checkDiff = 0
			updateIcons = true
			timeDiff = 0
		
		elseif (timeDiff > Gatherer.Var.NoteUpdateInterval) then
			updateIcons = true
			timeDiff = 0
			
		end
	end
	
	if ( updateNodes ) then
		local zoneToken, px, py = Gatherer.Util.GetPositionInCurrentZone()
		if not (zoneToken and px and py) then
			Gatherer.MiniNotes.Hide()
			return
		end
		
		local maxDist = setting("minimap.distance", 800)
		local displayNumber = setting("minimap.count", 20)

		local getDist = maxDist
		local getNumber = displayNumber

		if Gatherer_HUD then
			Gatherer_HUD.BeginUpdate()
			getNumber = math.max(displayNumber, 500)
			getDist = math.max(maxDist, setting("plugin.gatherer_hud.yards"))
		end
	
		numNotesUsed = 0
		local mapID, mapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(zoneToken)
		for i, nodeZoneToken, gType, nodeIndex, nodeDist, nodeX, nodeY, nodeIndoors, nodeInspected
		in Gatherer.Storage.ClosestNodesInfo(zoneToken, px, py, getNumber, getDist, Gatherer.Config.DisplayFilter_MiniMap) do
			if ( numNotesUsed < displayNumber ) then
				numNotesUsed = numNotesUsed + 1
				-- need to position and label the corresponding button
				local gatherNote = GetMinimapNote(numNotesUsed)
				gatherNote.gType = gType
				gatherNote.zone = nodeZoneToken
				gatherNote.index = nodeIndex
				gatherNote.dist = nodeDist
				
				local nodeMapID, nodeMapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(nodeZoneToken)
				local result = Astrolabe:PlaceIconOnMinimap(gatherNote, nodeMapID, nodeMapFloor, nodeX, nodeY)
				-- a non-zero results some failure when adding the icon to the Minimap
				if ( result ~= 0 ) then
					numNotesUsed = numNotesUsed - 1
				end
			end
			if ( Gatherer_HUD and nodeDist <= setting("plugin.gatherer_hud.yards") ) then
				Gatherer_HUD.PlaceIcon(zoneToken, gType, nodeIndex, nodeX, nodeY)
			end
		end
		
		local notes = Gatherer.MiniNotes.Notes
		for i = (numNotesUsed + 1), #(notes) do
			Astrolabe:RemoveIconFromMinimap(notes[i]);
		end

		-- Archaeology
		numArchNotesUsed = 0
		if ( Gatherer.Var.ArchaeologyActive and setting("arch.enable")) then
			local displayNumber = setting("arch.minimap.count")
			local maxDist = 500
			
			for i, nodeZoneToken, gType, nodeIndex, nodeDist, nodeX, nodeY, nodeIndoors, nodeInspected
			in Gatherer.Storage.ClosestNodesInfo(zoneToken, px, py, displayNumber, maxDist, ArchFilter) do
				if ( numArchNotesUsed < displayNumber ) then
					numArchNotesUsed = numArchNotesUsed + 1
					-- need to position and label the corresponding button
					local gatherNote = GetArchMinimapNote(numArchNotesUsed)
					gatherNote.gType = gType
					gatherNote.zone = nodeZoneToken
					gatherNote.index = nodeIndex
					gatherNote.dist = nodeDist
					
					local nodeMapID, nodeMapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(nodeZoneToken)
					local result = Astrolabe:PlaceIconOnMinimap(gatherNote, nodeMapID, nodeMapFloor, nodeX, nodeY)
					-- a non-zero results some failure when adding the icon to the Minimap
					if ( result ~= 0 ) then
						numArchNotesUsed = numArchNotesUsed - 1
					end
				end
			end
		end

		notes = Gatherer.MiniNotes.ArchNotes
		for i = (numArchNotesUsed + 1), #(notes) do
			Astrolabe:RemoveIconFromMinimap(notes[i]);
		end
	end
	
	if ( updateIcons or updateNodes ) then
		local now = time()
		
		local normSize = setting("minimap.iconsize")
		local normOpac = setting("minimap.opacity") / 100
		local fadeEnab = setting("fade.enable")
		local fadeDist = setting("fade.distance")
		local fadePerc = setting("fade.percent") / 100
		local tracEnab = setting("track.enable")
		local tracCirc = setting("track.circle")
		local tracStyl = setting("track.style")
		local tracCurr = setting("track.current")
		local tracDist = setting("track.distance")
		local tracOpac = setting("track.opacity") / 100
		local inspEnab = setting("inspect.enable")
		local inspTint = setting("inspect.tint")
		local inspDist = setting("inspect.distance")
		local inspPerc = setting("inspect.percent") / 100
		local inspTime = setting("inspect.time")
		local anonEnab = setting("anon.enable")
		local anonTint = setting("anon.tint")
		local anonOpac = setting("anon.opacity") / 100
		local tooltip = setting("minimap.tooltip.enable")
		
		for i = 1, numNotesUsed do
			local gatherNote = GetMinimapNote(i)
			local gType = gatherNote.gType
			local nodeZone= gatherNote.zone
			local nodeIndex = gatherNote.index
			
			local iconColor = "normal"
			local opacity = normOpac
			local nodeDist = Astrolabe:GetDistanceToIcon(gatherNote)
			
			if ( nodeDist ) then
				local selectedTexture, trimTexture = Gatherer.Util.GetNodeTexture(nodeZone, gType, nodeIndex)
				
				if ( anonEnab ) then
					local nodeVerified = false
					for _, gatherID, count, harvested, nodeSource in Gatherer.Storage.GetNodeGatherNames(nodeZone, gType, nodeIndex) do
						-- If this icon has not been verified
						if ( not nodeSource or (nodeSource == "REQUIRE") or (nodeSource == "IMPORTED") ) then
							nodeVerified = true
						end
					end
					if not ( nodeVerified ) then
						opacity = anonOpac
						if anonTint then
							iconColor = "red"
						end
					end
				end
				
				-- If node is within tracking distance
				if ( tracEnab and (nodeDist <= tracDist) ) then
					if ( (not tracCurr) or Gatherer.Util.IsNodeTracked(nodeZone, gType, nodeIndex) ) then
						if (tracCirc) then
							selectedTexture = SHADED_TEXTURE
							trimTexture = false
						end
						opacity = tracOpac
					end
				end
				
				-- If we need to fade the icon (because of great distance)
				if ( fadeEnab ) then
					if nodeDist >= fadeDist then
						opacity = opacity * (1 - fadePerc)
					elseif ( nodeDist > tracDist ) then
						local range = math.max(fadeDist - tracDist, 0)
						local posit = math.min(nodeDist - tracDist, range)
						if (range > 0) then
							opacity = opacity * (1 - ( fadePerc * (posit / range) ))
						end
					end
				end
				
				-- If inspecting is enabled
				if (inspEnab) then
					-- If we are within inspect distance of this item, mark it as inspected
					if (nodeDist < inspDist) then
						Gatherer.Storage.SetNodeInspected(nodeZone, gType, nodeIndex)
						if (inspTint) then
							iconColor = "green"
						end
						opacity = normOpac
				
					-- If we've recently seen this node, set its transparency
					else
						local nodeInspected = Gatherer.Storage.GetNodeInspected(nodeZone, gType, nodeIndex)
						if (nodeInspected) then
							local delta = math.max(now - nodeInspected, 0)
							if (inspTime > 0) and (delta < inspTime) then
								opacity = opacity * (1 - ( inspPerc * (1 - (delta / inspTime)) ))
							end
						end
					end
				end
				
				-- Set the texture
				gatherNote:SetNormalTexture(selectedTexture)
				gatherNote:SetWidth(normSize)
				gatherNote:SetHeight(normSize)
				
				if ( tooltip ) then
					gatherNote:EnableMouse(true)
				else
					gatherNote:EnableMouse(false)
				end
				
				local gatherNoteTexture = gatherNote:GetNormalTexture()
				
				-- Check to see if we need to trim the border off
				if ( trimTexture ) then
					gatherNoteTexture:SetTexCoord(0.08,0.92,0.08,0.92)
				else
					gatherNoteTexture:SetTexCoord(0,1,0,1)
				end
				
				-- If this node is unverified, then make it reddish
				if ( iconColor == "red" ) then
					gatherNoteTexture:SetVertexColor(0.9,0.4,0.4)
				elseif ( iconColor == "green" ) then
					gatherNoteTexture:SetVertexColor(0.4,0.9,0.4)
				else
					local r, g, b = 1, 1, 1;
					if ( selectedTexture == SHADED_TEXTURE ) then
						local nodeType = tostring(gType) -- in case nil is returned, call tostring
						if ( setting("track.colour."..nodeType) ) then
							r, g, b = setting("track.colour."..nodeType)
						end
					end
					gatherNoteTexture:SetVertexColor(r, g, b);
				end
				gatherNoteTexture:SetAlpha(opacity)
			end
		end
		
		-- Archaeology Nodes
		for i = 1, numArchNotesUsed do
			local gatherNote = GetArchMinimapNote(i)
			local nodeDist = Astrolabe:GetDistanceToIcon(gatherNote)
			if ( nodeDist ) then
				local gatherNoteTexture = gatherNote:GetNormalTexture()
				if ( nodeDist < 40 ) then
					gatherNoteTexture:SetVertexColor(0,1,0);
				elseif ( nodeDist < 80 ) then
					gatherNoteTexture:SetVertexColor(1,1,0);
				else
					gatherNoteTexture:SetVertexColor(1,0,0);
				end
				gatherNoteTexture:SetAlpha(normOpac)
			end
		end
	end
end

-- Pass on any node clicks
function Gatherer.MiniNotes.MiniNoteOnClick()
	Minimap_OnClick(Minimap)
end

function Gatherer.MiniNotes.MiniNoteOnEnter(frame)
	local setting = Gatherer.Config.GetSetting
	
	local enabled = setting("minimap.tooltip.enable")
	if (not enabled) then 
		return
	end
	
	local showcount = setting("minimap.tooltip.count")
	local showsource = setting("minimap.tooltip.source")
	local showseen = setting("minimap.tooltip.seen")
	local showdist = setting("minimap.tooltip.distance")
	local showrate = setting("minimap.tooltip.rate")

	local gType = frame.gType
	local dist = Astrolabe:GetDistanceToIcon(frame)
	local _, _, indoors, inspected = Gatherer.Storage.GetNodeInfo(frame.zone, gType, frame.index)
	
	local numTooltips = 0
	for id, gatherID, count, harvested, who in Gatherer.Storage.GetNodeGatherNames(frame.zone, gType, frame.index) do
		local tooltip = Gatherer.Tooltip.GetTooltip(id)
		tooltip:ClearLines()
		tooltip:SetParent(UIParent)
		tooltip:SetFrameLevel(Minimap:GetFrameLevel() + 5)
		if ( id == 1 ) then
			tooltip:SetOwner(frame, "ANCHOR_BOTTOMLEFT")
		else
			tooltip:SetOwner(frame, "ANCHOR_PRESERVE")
			tooltip:SetPoint("TOPLEFT", Gatherer.Tooltip.GetTooltip(id - 1),"BOTTOMLEFT")
		end
		
		local name = Gatherer.Util.GetNodeName(gatherID)
		local last = inspected or harvested
		
		tooltip:AddLine(name)
		if (count > 0 and showcount) then
			tooltip:AddLine(_tr("NOTE_COUNT", count))
		end
		if (who and showsource) then
			if (who == "REQUIRE") then
				tooltip:AddLine(_tr("NOTE_UNSKILLED"))
			elseif (who == "IMPORTED") then
				tooltip:AddLine(_tr("NOTE_IMPORTED"))
			else
				tooltip:AddLine(_tr("NOTE_SOURCE", who:gsub(",", ", ")))
			end
		end
		if (last and last > 0 and showseen) then
			tooltip:AddLine(_tr("NOTE_LASTVISITED", Gatherer.Util.SecondsToTime(time()-last)))
		end
		if (showdist) then
			tooltip:AddLine(_tr("NOTE_DISTANCE", format("%0.2f", dist)))
		end
		
		if ( showrate ) then
			local num = Gatherer.Config.GetSetting("minimap.tooltip.rate.num")
			local zone = frame.zone
			if ( gType ~= "OPEN" and gatherID ~= 190175 ) then
				zone = nil
			end
			Gatherer.Tooltip.AddDropRates(tooltip, gatherID, zone, num)
		end
		tooltip:Show()
		numTooltips = id
	end
	Gatherer.Tooltip.SetClamps(numTooltips)
end

--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.4.1 (<%codename%>)
	Revision: $Id: GatherMapNotes.lua 1004 2012-09-13 04:23:41Z Esamynn $

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

	World Map Drawing Functions
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_4.4.1/Gatherer/GatherMapNotes.lua $", "$Rev: 1004 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

function Gatherer.MapNotes.Enable()
	Gatherer.Config.SetSetting("mainmap.enable", true)
	Gatherer.MapNotes.Update()
end

function Gatherer.MapNotes.Disable()
	Gatherer.Config.SetSetting("mainmap.enable", false)
	Gatherer.MapNotes.Update()
end

function Gatherer.MapNotes.ToggleDisplay()
	if ( Gatherer.Config.GetSetting("mainmap.enable") ) then
		Gatherer.MapNotes.Disable()
	else
		Gatherer.MapNotes.Enable()
	end
end

local Gatherer_WorldMapDisplay_ButtonWidth = 100
function Gatherer.MapNotes.Update()
	if ( Gatherer.Config.GetSetting("mainmap.enable") ) then
		Gatherer_WorldMapDisplay:SetText(_tr("MAP_NOTES_HIDE"))
		GathererMapOverlayParent:Show()
	else
		Gatherer_WorldMapDisplay:SetText(_tr("MAP_NOTES_SHOW"))
		GathererMapOverlayParent:Hide()
	end
	local buttonWidth = Gatherer_WorldMapDisplay:GetFontString():GetWidth() + 15
	if ( buttonWidth > Gatherer_WorldMapDisplay_ButtonWidth ) then
		if ( buttonWidth > 150 ) then buttonWidth = 150 end
		if ( buttonWidth < 100 ) then buttonWidth = 100 end
		Gatherer_WorldMapDisplay:SetWidth(buttonWidth)
		Gatherer_WorldMapDisplay_ButtonWidth = buttonWidth
	end
end

function Gatherer.MapNotes.GetNoteObject( noteNumber )
	local button = _G["GatherMain"..noteNumber]
	if not ( button ) then
		local overlayFrameNumber = math.ceil(noteNumber / 100)
		local overlayFrame = GathererMapOverlayParent[overlayFrameNumber]
		if not ( overlayFrame ) then
			overlayFrame = CreateFrame("Frame", "GathererMapOverlayFrame"..overlayFrameNumber, GathererMapOverlayParent, "GathererMapOverlayTemplate")
			GathererMapOverlayParent[overlayFrameNumber] = overlayFrame
		end
		button = CreateFrame("Button" ,"GatherMain"..noteNumber, overlayFrame, "GatherMainTemplate")
		button:SetID(noteNumber)
		overlayFrame[(noteNumber-1) % 100 + 1] = button
		Gatherer.Util.Debug("create id "..noteNumber.." frame ".. overlayFrameNumber)
	end
	return button
end

function Gatherer.MapNotes.MapDraw()
	local GathererMapOverlayParent = GathererMapOverlayParent
	if not ( GathererMapOverlayParent:IsVisible() ) then
		return
	end
	local setting = Gatherer.Config.GetSetting
	local maxNotes = setting("mainmap.count", 600)
	local noteCount = 0

	-- prevent the function from running twice at the same time.
	if (Gatherer.Var.UpdateWorldMap == 0 ) then return; end
	Gatherer.Var.UpdateWorldMap = 0

	local GetNodeInfo = Gatherer.Storage.GetNodeInfo
	local GetNodeGatherNames = Gatherer.Storage.GetNodeGatherNames
	
	local showType, showObject
	local mapID, mapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(Gatherer.ZoneTokens.GetZoneToken(GetCurrentMapAreaID()))
	if ( Gatherer.Storage.HasDataOnZone(mapID) ) then
		for _, gatherType in pairs(Gatherer.Constants.SupportedGatherTypes) do
			for index, xPos, yPos in Gatherer.Storage.ZoneGatherNodes(mapID, gatherType) do
				local displayNode = false
				for _, gatherID, count in GetNodeGatherNames(mapID, gatherType, index) do
					if ( Gatherer.Config.DisplayFilter_MainMap(gatherID) ) then
						displayNode = true
						break
					end
				end
				local _, _, _, isMicroDungeon = GetMapInfo();
				if ( displayNode and isMicroDungeon ) then
					local _, _, indoors = GetNodeInfo(mapID, gatherType, index)
					displayNode = indoors
				end
				if ( displayNode ) then
					if ( noteCount < maxNotes ) then
						noteCount = noteCount + 1
						local mainNote = Gatherer.MapNotes.GetNoteObject(noteCount)
						
						mainNote:SetAlpha(setting("mainmap.opacity", 80) / 100)
						
						local texture = Gatherer.Util.GetNodeTexture(mapID, gatherType, index)
						_G[mainNote:GetName().."Texture"]:SetTexture(texture)
						
						local iconsize = setting("mainmap.iconsize", 16)
						mainNote:SetWidth(iconsize)
						mainNote:SetHeight(iconsize)
						
						mainNote.mapID = mapID
						mainNote.index = index
						mainNote.gType = gatherType
						
						local tooltip = setting("mainmap.tooltip.enable")
						if (tooltip and not mainNote:IsMouseEnabled()) then
							mainNote:EnableMouse(true)
						elseif (not tooltip and mainNote:IsMouseEnabled()) then
							mainNote:EnableMouse(false)
						end
						
						Astrolabe:PlaceIconOnWorldMap(WorldMapButton, mainNote, mapID, mapFloor, xPos, yPos)
					else -- reached note limit
						break
					end
				end
			end
		end
	end
	
	local numUsedOverlays = math.ceil(noteCount / 100)
	local partialOverlay = GathererMapOverlayParent[numUsedOverlays]
	for i = (noteCount - ((numUsedOverlays - 1) * 100) + 1), 100 do
		local note = partialOverlay[i]
		if not ( note ) then
			break
		end
		note:Hide()
	end
	for i, overlay in ipairs(GathererMapOverlayParent) do
		if ( i <= numUsedOverlays ) then
			overlay:Show()
		else
			overlay:Hide()
		end
	end
	
	Gatherer.Var.UpdateWorldMap = -1
end

function Gatherer.MapNotes.MapOverlayFrame_OnHide( frame )
	for _, childFrame in ipairs(frame) do
		childFrame:Hide()
	end
end

function Gatherer.MapNotes.MapNoteOnEnter(frame)
	local setting = Gatherer.Config.GetSetting
	
	local enabled = setting("mainmap.tooltip.enable")
	if (not enabled) then 
		return
	end
	
	local showcount = setting("mainmap.tooltip.count")
	local showsource = setting("mainmap.tooltip.source")
	local showseen = setting("mainmap.tooltip.seen")
	local showrate = setting("mainmap.tooltip.rate")
	
	local cont = frame.continent
	local zone = Gatherer.ZoneTokens.GetZoneToken(frame.mapID)
	local index = frame.index
	local gType = frame.gType
	local inspected = Gatherer.Storage.GetNodeInspected(zone, gType, index)
	
	local numTooltips = 0
	for id, gatherID, count, harvested, who in Gatherer.Storage.GetNodeGatherNames(zone, gType, index) do
		local tooltip = Gatherer.Tooltip.GetTooltip(id)
		tooltip:ClearLines()
		tooltip:SetParent(WorldMapFrame)
		tooltip:SetFrameLevel(WorldMapFrame:GetFrameLevel() + 5)
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
		
		if ( showrate ) then
			local num = Gatherer.Config.GetSetting("mainmap.tooltip.rate.num")
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

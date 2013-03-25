--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.2.0 (<%codename%>)
	Revision: $Id: GatherUtil.lua 997 2012-09-11 03:14:32Z Esamynn $

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

	Utility functions
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherUtil.lua $", "$Rev: 997 $")

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

function Gatherer.Util.Round(x)
	return math.ceil(x - 0.5);
end

function Gatherer.Util.BreakLink(link)
	--DEFAULT_CHAT_FRAME:AddMessage("Breaking link: " .. (link or "None"))

	if (type(link) ~= 'string') then return end
--	local item, name = link:match("|H(.-)|h[[]([^]]+)[]]|h")
	local i,j, item, name = string.find(link, "|H(.-)|h[[](.-)[]]|h")
	--DEFAULT_CHAT_FRAME:AddMessage(" found item "..(item or "None")..": " .. (name or "None"))
	local itype, id, enchant, slot1,slot2,slot3,slot4, random, uniq = strsplit(":", item)
	
	--DEFAULT_CHAT_FRAME:AddMessage(" id: "..(id or "None"))
	if (random == nil) then
		random, uniq = slot1, slot2
		slot1, slot2, slot3, slot4 = 0, 0, 0, 0
	end
	return
		tonumber(id) or 0,
		tonumber(enchant) or 0,
		tonumber(random) or 0,
		tonumber(slot1) or 0,
		tonumber(slot2) or 0,
		tonumber(slot3) or 0,
		tonumber(slot4) or 0,
		tonumber(uniq) or 0,
		name, itype
end

function Gatherer.Util.DumpAll()
	for _, zone in Gatherer.Storage.GetAreaIndices() do
		for gatherName, gtype in Gatherer.Storage.ZoneGatherNames(zone) do
			for index, x, y, count in Gatherer.Storage.ZoneGatherNodes(zone, gatherName) do
				Gatherer.Util.Print(gtype.." "..gatherName.." was found in zone "..zone.." at "..x..","..y.."  ("..count.." times)")
			end
		end
	end
end

function Gatherer.Util.ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(str, 1.0, 0.5, 0.25)
	end
end

function Gatherer.Util.Print(str, add)
	if ((Gatherer.Var.LastPrited) and (str == Gatherer.Var.LastPrited)) then
		return
	end
	Gatherer.Var.LastPrited = str
	if (add) then
		str = str..": "..add
	end
	if(ChatFrame5) then
		ChatFrame5:AddMessage(str, 1.0, 1.0, 0.0)
	end
end

function Gatherer.Util.Debug(str, ...)
	if not ( type(Gatherer.Util.DebugFrame) == "table" and Gatherer.Util.DebugFrame.AddMessage ) then
		return
	end
	str = str..": "..strjoin(", ", tostringall(...))
	Gatherer.Util.DebugFrame:AddMessage("DEBUG: "..str, 1.0, 1.0, 0.0)
end

local _, _, _, tocVersion = GetBuildInfo();

if ( tocVersion >= 40000 ) then


function Gatherer.Util.GetSkills()
	local ProfessionTextures = Gatherer.Constants.ProfessionTextures;
	
	for _, profId in pairs({GetProfessions()}) do
		local name, texture, skillRank, maxRank = GetProfessionInfo(profId);
		if ( ProfessionTextures[texture] ) then
			Gatherer.Var.Skills[ProfessionTextures[texture]] = skillRank;
		end
	end
end


else


local checkingSkills = false

function Gatherer.Util.GetSkills()
	if ( checkingSkills ) then return end -- avoid infinate loops
	checkingSkills = true
	local GatherExpandedHeaders = {}
	local i, j
	
	if ( not Gatherer.Var.Skills ) then Gatherer.Var.Skills = {}; end
		
	-- search the skill tree for gathering skills
	for i=0, GetNumSkillLines(), 1 do
		local skillName, header, isExpanded, skillRank = GetSkillLineInfo(i)
	
		-- expand the header if necessary
		if ( header and not isExpanded ) then
			GatherExpandedHeaders[i] = skillName
		end
	end
	
	ExpandSkillHeader(0)
	for i=1, GetNumSkillLines(), 1 do
		local skillName, header, _, skillRank = GetSkillLineInfo(i)
		-- check for the skill name
		if (skillName and not header) then
			if (skillName == Gatherer.Locale.TrClient("TRADE_HERBALISM")) then
				Gatherer.Var.Skills.HERB = skillRank
			elseif (skillName == Gatherer.Locale.TrClient("TRADE_MINING")) then
				Gatherer.Var.Skills.MINE = skillRank
			end
		end
		
		-- once we got both, no need to look the rest
		if ( Gatherer.Var.Skills.HERB and Gatherer.Var.Skills.MINE ) then
			break
		end
	end
	
	-- close headers expanded during search process
	for i=0, GetNumSkillLines() do
		local skillName, header, isExpanded = GetSkillLineInfo(i)
		for j in pairs(GatherExpandedHeaders) do
			if ( header and skillName == GatherExpandedHeaders[j] ) then
				CollapseSkillHeader(i)
				GatherExpandedHeaders[j] = nil
			end
		end
	end
	checkingSkills = false
end


end

--******************************************************
-- Current Tracking State Tracker System
--******************************************************

local currentTracks = {};

function Gatherer.Util.UpdateTrackingState()
	local TrackingTextures = Gatherer.Constants.TrackingTextures;
	for id = 1, GetNumTrackingTypes() do
		local name, texture, active, category  = GetTrackingInfo(id);
		if ( TrackingTextures[texture] ) then
			currentTracks[TrackingTextures[texture]] = active and true or false
		end
	end
end

function Gatherer.Util.IsGatherTracked( nodeId )
	local trackType = Gatherer.Nodes.Objects[nodeId]
	
	-- check for a tracking type override
	local category = Gatherer.Categories.ObjectCategories[nodeId]
	trackType = Gatherer.Constants.TrackingOverrides[category] or trackType
	
	return currentTracks[trackType]
end

function Gatherer.Util.IsNodeTracked( mapZone, gatherType, index )
	if ( gatherType == "OPEN" ) or ( gatherType == "ARCH" ) then
		-- tracking overrides only happen for OPEN or ARCH items
		for _, gatherID, count in Gatherer.Storage.GetNodeGatherNames(mapZone, gatherType, index) do
			if ( Gatherer.Util.IsGatherTracked(gatherID) ) then
				return ture
			end
		end
	else
		return currentTracks[gatherType]
	end
	return false
end

--******************************************************
-- END Current Tracking State Tracker System
--******************************************************

local nodeNames = {}
for name, objid in pairs(Gatherer.Nodes.Names) do
	nodeNames[objid] = name
end
function Gatherer.Util.GetNodeName(objectID)
	return nodeNames[objectID] or ("Unknown: "..objectID)
end

function Gatherer.Util.BuildLoot(coins, ...)
	local loot = {}
	coins = tonumber(coins) or 0
	for i=1, select("#", ...) do
		local lootItem = select(i, ...)
		local itemID, count = strsplit("x", lootItem)
		itemID = tonumber(itemID)
		count = tonumber(count)
		if (itemID and count) then
			table.insert(loot, { id = itemID, count = count })
		end
	end
	return coins, loot
end

function Gatherer.Util.LootSplit(lootString)
	return Gatherer.Util.BuildLoot(strsplit(":", lootString))
end

local parseStrings = {}
local parseStringInfo = {}
local returnCache = {}

local function processMatches( format, ... )
	local parseInfo = parseStringInfo[format]
	for i = 1, select("#", ...) do
		if ( parseInfo[i] ) then
			returnCache[i] = select(parseInfo[i], ...)
		else
			returnCache[i] = ""
		end
	end
	return unpack(returnCache, 1, select("#", ...))
end

local function replaceAllBut( char )
	if ( char ~= "$" and char ~= "%" ) then
		return "%"..char
	end
end

function Gatherer.Util.ParseFormattedMessage(format, message)
	local parser = parseStrings[format]
	if not ( parser ) then
		parser = string.gsub(format, "([%p])", replaceAllBut)
		local parseInfo = {}
		local curPos = 0
		local count = 0
		local function analyzeMatch( index, check, type )
			if ( #index > 1 ) then return end
			index = tonumber(index)
			if ( index ) then
				curPos = index
				if ( check ~= "$" ) then
					return
				end
			else
				curPos = curPos + 1
			end
			local replacement
			if ( type == "s" ) then
				replacement = "(.-)"
			elseif ( type == "d" ) then
				replacement = "(-?%d+)"
			else
				return
			end
			count = count + 1
			parseInfo[curPos] = count
			return replacement
		end
		parser = string.gsub(parser, "%%(%d?)(%$?)([sd])", analyzeMatch)
		parseStringInfo[format] = parseInfo
		parser = string.gsub(parser, "%$", "%%$")
		parser = "^"..parser.."$"
		parseStrings[format] = parser
	end
	return processMatches(format, string.match(message, parser))
end

function Gatherer.Util.GetNodeTexture( mapZone, gatherType, index )
	local texture, trimTexture = "Interface\\AddOns\\Gatherer\\Original\\Test", false
	local maxCount = -1
	for _, gatherID, count in Gatherer.Storage.GetNodeGatherNames(mapZone, gatherType, index) do
		if ( count > maxCount ) then
			texture, trimTexture = Gatherer.Util.GetGatherTexture(gatherID)
			maxCount = count
		end
	end
	return texture, trimTexture
end

function Gatherer.Util.GetGatherTexture( nodeID )
	local selectedTexture
	local trimTexture = false
	
	if (Gatherer.Icons[nodeID]) then
		selectedTexture = "Interface\\AddOns\\Gatherer\\Icons\\"..Gatherer.Icons[nodeID]
	end
	
	if not ( selectedTexture ) then
		selectedTexture = GetItemIcon(Gatherer.Nodes.PrimaryItems[nodeID])
		trimTexture = selectedTexture and true or false
	end
	
	if not ( selectedTexture ) then
		local prime, pcount = Gatherer.DropRates.GetPrimaryItem(nodeID)
		if ( prime ) then
			local primaryName, _, _, _, _, _, _, _, _, nodeTexture = GetItemInfo(prime)
			selectedTexture = nodeTexture
			trimTexture = true
		end
	end
	
	-- Check to see if we found the item
	if (not selectedTexture) then
		selectedTexture = "Interface\\AddOns\\Gatherer\\Shaded\\Red"
		trimTexture = false
	end
	
	return selectedTexture, trimTexture
end

Gatherer.Util.ZoneNames = { __index = 
function(tbl, key)
	setmetatable(tbl, nil)
	tbl["__index"] = nil
	for C, cname in pairs({GetMapContinents()}) do
		for Z, zoneName in pairs({GetMapZones(C)}) do
			tbl[zoneName] = Astrolabe:GetMapID(C, Z)
		end
	end
	return tbl[key]
end
}
setmetatable( Gatherer.Util.ZoneNames, Gatherer.Util.ZoneNames )

function Gatherer.Util.GetPositionInCurrentZone()
	local realZoneText = GetRealZoneText()
	local zone = Gatherer.Util.ZoneNames[realZoneText]
	local mapID, mapFloor, px, py = Astrolabe:GetCurrentPlayerPosition()
	if not ( mapID ) then return end
	local zoneToken
	if ( zone ) then
		zoneToken = Gatherer.ZoneTokens.GetZoneToken(zone)
		local realMapID, realMapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(zoneToken)
		if ( realMapID ) then
			px, py = Astrolabe:TranslateWorldMapPosition(mapID, mapFloor, px, py, realMapID, realMapFloor)
		else
			return
		end
	else
		zoneToken = Gatherer.ZoneTokens.GetZoneToken(mapID)
	end
	
	if ( zoneToken ) then
		return zoneToken, px, py
	end
end


function Gatherer.Util.SecondsToTime(seconds, noSeconds)
	local time = ""
	local count = 0
	local GetText = Gatherer.Locale.GetText
	seconds = floor(seconds)
	if ( seconds >= 604800 ) then
		local tempTime = floor(seconds / 604800)
		time = tempTime.." "..GetText("WEEKS_ABBR", tempTime).." "
		seconds = (seconds % 604800)
		count = count + 1
	end
	if ( seconds >= 86400  ) then
		local tempTime = floor(seconds / 86400)
		time = time..tempTime.." "..GetText("DAYS_ABBR", tempTime).." "
		seconds = (seconds % 86400)
		count = count + 1
	end
	if ( count < 2 and seconds >= 3600  ) then
		local tempTime = floor(seconds / 3600)
		time = time..tempTime.." "..GetText("HOURS_ABBR", tempTime).." "
		seconds = (seconds % 3600)
		count = count + 1
	end
	if ( count < 2 and seconds >= 60  ) then
		local tempTime = floor(seconds / 60)
		time = time..tempTime.." "..GetText("MINUTES_ABBR",tempTime).." "
		seconds = (seconds % 60)
		count = count + 1
	end
	if ( count < 2 and seconds > 0 and not noSeconds ) then
		time = time..seconds.." "..GetText("SECONDS_ABBR", seconds).." "
	end
	return time
end


--******************************************************
-- Client Item Cache Refresh System
--******************************************************

local refreshFrame = CreateFrame("Frame")
local tooltip = CreateFrame("GameTooltip")
refreshFrame:Hide()
local itemIdList = {}
local lastItem = nil
local timer = 0


function Gatherer.Util.StartClientItemCacheRefresh()
	if ( Gatherer.DropRates.OldData ) then
		for nodeId, nodeData in pairs(Gatherer.DropRates.OldData) do
			for itemId in pairs(nodeData) do
				if ( type(itemId) == "number" ) then
					itemIdList[itemId] = true
				end
			end
		end
	end
	for cont, contData in ipairs(Gatherer.DropRates.Data) do
		for zone, zoneData in pairs(contData) do
			for nodeId, nodeData in pairs(zoneData) do
				for itemId in pairs(nodeData) do
					if ( type(itemId) == "number" ) then
						itemIdList[itemId] = true
					end
				end
			end
		end
	end
	
	lastItem = nil
	timer = 0
	refreshFrame:Show()
end

refreshFrame:SetScript("OnUpdate",
	function( self, elapsed )
		timer = timer + elapsed
		if ( timer > 5 ) then
			timer = 0
			local itemId = next(itemIdList, lastItem)
			if not ( itemId ) then
				self:Hide()
				return
			end
			
			while ( itemId and GetItemInfo(itemId) ) do
				itemId = next(itemIdList, itemId)
			end
			if not ( itemId ) then
				self:Hide()
				return
			end
			tooltip:SetOwner(refreshFrame, "ANCHOR_NONE")
			tooltip:SetHyperlink("item:"..itemId..":0:0:0:0:0:0:0")
			lastItem = itemId
		end
	end
)

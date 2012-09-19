--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.0.2 (<%codename%>)
	Revision: $Id: GatherStorage.lua 979 2012-09-04 07:38:10Z Esamynn $

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

	Library for accessing and updating the database
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherStorage.lua $", "$Rev: 979 $")


--------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------
-- Note: These indexing constants need to be kept in sync with those in GatherClosestNodes.lua

-- Node Indexing
local POS_X = 1
local POS_Y = 2
local INSPECTED = 3
local FLOOR = 4

-- Gather Indexing
local COUNT = 1
local HARVESTED = 2
local SOURCE = 3

-- Current Database Version
local dbVersion = 5

--------------------------------------------------------------------------
-- Data Table
--------------------------------------------------------------------------

local globalName = "GatherItems"
local data

local corruptData = false

--------------------------------------------------------------------------
-- Global Library Table with a local pointer
--------------------------------------------------------------------------

local lib = Gatherer.Storage

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

local ZoneData = {}
local continents = {GetMapContinents()}
for index, name in ipairs(continents) do
	ZoneData[index] = {GetMapZones(index)}
	ZoneData[index].name = name
end


local function argcheck(value, num, ...)
	assert(1, type(num) == "number", "Bad argument #2 to 'argcheck' (number expected, got " .. type(level) .. ")")
	
	for i=1,select("#", ...) do
		if type(value) == select(i, ...) then return end
	end
	
	local types = strjoin(", ", ...)
	local name = string.match(debugstack(2,2,0), ": in function [`<](.-)['>]")
	error(string.format("Bad argument #%d to 'Gatherer.Storage.%s' (%s expected, got %s)", num, name, types, type(value)), 3)
end

--[[
##########################################################################
 Regular Library Functions
##########################################################################
--]]

--************************************************************************
-- This returns the raw data table, BE CAREFUL WITH IT!!!!
--************************************************************************
--[[
function lib.GetRawDataTable()
	return data
end
--]]

local function processSourceList( newSource, ... )
	for i = 1, select("#", ...) do
		if ( newSource == select(i, ...) ) then
			return ...
		end
	end
	return ..., newSource
end

local validGatherTypes = {
	MINE = "MINE",
	HERB = "HERB",
	OPEN = "OPEN",
	ARCH = "ARCH",
}
function lib.AddNode(nodeName, gatherType, zoneToken, gatherX, gatherY, source, incrementCount, indoorFloor)
	argcheck(nodeName, 1, "number", "string");
	argcheck(gatherType, 2, "string", "nil");
	argcheck(zoneToken, 3, "number", "string");
	argcheck(gatherX, 4, "number");
	argcheck(gatherY, 5, "number");
	argcheck(source, 6, "string", "nil");
	argcheck(incrementCount, 7, "boolean", "nil");
	argcheck(indoorFloor, 8, "boolean", "nil");
	
	zoneToken = Gatherer.ZoneTokens.GetZoneToken(zoneToken)
	local mapID, mapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(zoneToken)
	-- check for invalid location information
	
	-- ccox - we should handle negative X and Y, see gatherer ticket #139
	-- Swamp of Sorrows has stranglekelp at a negative Y position (northeast corner, off in the water)
	if not ( zoneToken and (0 < gatherX) and (gatherX < 1) and (0 < gatherY) and (gatherY < 1) ) then return end
	
	local gatherType = validGatherTypes[gatherType]
	if not ( gatherType ) then
		gatherType = Gatherer.Nodes.Objects[nodeName]
	end
	if not ( gatherType ) then
		-- bye bye now
		return
	end

	if not (data[zoneToken]) then data[zoneToken] = { }; end
	if not (data[zoneToken][gatherType]) then data[zoneToken][gatherType] = { }; end
	local gtypeTable = data[zoneToken][gatherType]
	
	-- standard interact distance for objects is 5 yards
	local matchDist = 10 -- radius of 5 yards
	local isImport = false
	if source and source:sub(1,3) == "DB:" then
		-- DB sources have a tendancy to be more "fuzzy" than
		-- actual harvested nodes, so look farther for a match
		matchDist = 25
		isImport = true
	end
	
	local index, node
	
	for i, nodeData in ipairs(gtypeTable) do
		if ( nodeData[FLOOR] == indoorFloor ) then
			local dist = Astrolabe:ComputeDistance(mapID, mapFloor, gatherX, gatherY, mapID, mapFloor, nodeData[POS_X], nodeData[POS_Y])
			if ( dist < matchDist ) then
				
				-- don't combine Treasure or Archaeology gathers into a common node unless they share a category
				local allowByCategory = true
				if ( gatherType == "OPEN" ) or ( gatherType == "ARCH" ) then
					allowByCategory = false
					local nodeCategory
					local gatherCategory = Gatherer.Categories.ObjectCategories[nodeName]
					for gatherID, gather in pairs(nodeData) do
						if ( type(gather) == "table" ) then
							if ( gatherID == nodeName ) then
								allowByCategory = true
								break
							end
							nodeCategory = Gatherer.Categories.ObjectCategories[gatherID]
							if ( nodeCategory ) then
								break
							end
						end
					end
					if ( nodeCategory and gatherCategory and nodeCategory == gatherCategory ) then
						allowByCategory = true
					end
				end
				
				if ( allowByCategory ) then
					node = nodeData
					index = i
					break
				end
			end
		end
	end

	-- If we found a close, matching node, then proceed to update it.
	if node then

		-- But don't allow imports to affect real gathered nodes.
		if isImport then return end

		local count = 0
		for gatherID, gather in pairs(node) do
			if ( type(gather) == "table" ) then
				count = count + gather[COUNT]
			end
		end

		if ( count < 1 ) then
			-- something is VERY WRONG
			count = 1
		end

		-- Do a proper average of the node position
		gatherX = (gatherX + (node[POS_X] * count)) / (count + 1)
		gatherY = (gatherY + (node[POS_Y] * count)) / (count + 1)

	-- Else, we didn't find it in the current list, time to create a new node!
	else
		node = { [POS_X]=0, [POS_Y]=0, [INSPECTED]=0, [FLOOR]=indoorFloor }
		table.insert(gtypeTable, node)
		index = table.getn(gtypeTable)
	end

	local gatherData;
	for gatherID, gather in pairs(node) do
		if ( type(gather) == "table" and gatherID == nodeName ) then
			gatherData = gather;
			break;
		end
	end
	
	if ( gatherData ) then
		-- Update the node's source field
		local nodeSource = gatherData[SOURCE]
		if ( nodeSource ) then
			-- If we got this node from someone else
			if ( source ) then
				-- If the node is imported, but wasn't or vice versa, clear current source
				if ( (source == "IMPORTED" or nodeSource == "IMPORTED") and nodeSource ~= source ) then
					gatherData[SOURCE] = nil
				-- If the node is require-level, but wasn't or vice versa, clear current source
				elseif ( (source == "REQUIRE" or nodeSource == "REQUIRE") and nodeSource ~= source ) then
					gatherData[SOURCE] = nil
				-- Otherwise add the new source to the current source
				else
					gatherData[SOURCE] = string.join(",", processSourceList(source, string.split(",", nodeSource)))
				end
			-- Else, we have just personally verified the node as correct! Yay us!
			else
				gatherData[SOURCE] = nil
			end
		end
	else
		gatherData = { [COUNT]=0, [HARVESTED]=0, [SOURCE]=source }
		node[nodeName] = gatherData
	end
	
	node[POS_X] = gatherX
	node[POS_Y] = gatherY
	if ( incrementCount ) then
		gatherData[COUNT] = gatherData[COUNT] + 1
	end

	local now = time()

	-- Update last harvested time (and inspected time as well)
	gatherData[HARVESTED] = now
	if (not gatherData[SOURCE]) then
		node[INSPECTED] = now
	end

	-- Notify the reporting subsystem that something has changed
	Gatherer.Report.NeedsUpdate()

	-- Return the indexed position
	return index
end

--************************************************************************
-- Node Removal
--************************************************************************

function lib.ClearDatabase()
	data = { dbVersion = dbVersion }
	collectgarbage("collect"); --reclaim the old database
	-- Notify the reporting subsystem that something has changed
	Gatherer.Report.NeedsUpdate()
end

local function removeNode( gtypeData, index, gatherName, playerName )
	local shouldRemoveNode = true
	local gatherRemoved = true
	local nodeData = gtypeData[index]
	if ( playerName ) then
		for gatherID, gatherData in pairs(nodeData) do
			if ( type(gatherData) == "table" and (gatherName == nil or gatherName == gatherID) ) then
				if ( gatherData[SOURCE] ) then
					local newSource = (gatherData[SOURCE]..","):gsub(playerName..",", ""):sub(1, -2)
					if ( newSource ~= "" ) then
						-- don't remove the node if source string is not empty after removing the specified name
						shouldRemoveNode = false
						gatherRemoved = false
						gatherData[SOURCE] = newSource
					else
						nodeData[gatherID] = nil
					end
				
				else  -- don't remove the node if a name was specified, but the node is "confirmed"
					shouldRemoveNode = false
					gatherRemoved = false
				
				end
			end
		end
		for _, v in pairs(nodeData) do
			if ( type(v) == "table" ) then
				shouldRemoveNode = false
				break
			end
		end
	elseif ( gatherName ) then
		nodeData[gatherName] = nil
		for _, v in pairs(nodeData) do
			if ( type(v) == "table" ) then
				shouldRemoveNode = false
				break
			end
		end
	end
	if ( shouldRemoveNode ) then
		table.remove(gtypeData, index)
	end

	-- Notify the reporting subsystem that something has changed
	Gatherer.Report.NeedsUpdate()

	return shouldRemoveNode, gatherRemoved
end

function lib.RemoveNode( continent, zone, gType, index )
	-- TODO: implement
end

-- returns true if the gather was removed from the node
function lib.RemoveGatherFromNode( zone, gatherName, gType, index, playerName )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.IsGatherInZone(zone, gatherName, gType) ) then
		local gtypeData = data[zone][gType]
		if ( gtypeData[index] ) then
			local nodeRemoved, gatherRemoved = removeNode(gtypeData, index, gatherName, playerName)
			if not ( gtypeData[1] ) then
				-- if the gather table is now empty, remove it from the DB table
				data[zone][gType] = nil
			end
			return (nodeRemoved or gatherRemoved)
		end
	end
end

-- Returns:
-- -2 if the gather did not exist
-- -1 if the gather was not removed from any nodes
--  0 if the gather was removed from the zone
--  1 if the gather was removed from some, but not all, nodes in this zone
function lib.RemoveGather( zone, gatherName, gType, playerName )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	local result
	local gathersRemoved, nodesRemoved = 0, 0
	if ( lib.IsGatherInZone(zone, gatherName, gType) ) then
		local gtypeData = data[zone][gType]
		local oldCount = lib.GetGatherCountsForZone(zone, gatherName, gType)
		local numNodes = #gtypeData
		for i = numNodes, 1, -1 do
			local nodeRemoved = removeNode(gtypeData, i, gatherName, playerName)
			if ( nodeRemoved ) then nodesRemoved = nodesRemoved + 1 end
		end
		if ( gtypeData[1] ) then
			gathersRemoved = oldCount - lib.GetGatherCountsForZone(zone, gatherName, gType)
			if ( gathersRemoved <= 0 ) then result = -1 end
			if ( gathersRemoved >= 1 ) then result = 1 end
			if ( gathersRemoved >= oldCount ) then result = 0 end
		else
			data[zone][gType] = nil
			gathersRemoved = nodesRemoved
			result = 0
		end
		
		-- check for empty ancestors
		if not ( next(data[zone]) ) then
			data[zone] = nil
		end
		
		return result, gathersRemoved, nodesRemoved
	else
		return -2, 0, 0
	end
end

--************************************************************************
-- Node Information
--************************************************************************

function lib.HasDataOnZone( zone )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( data[zone] ) then
		return true
	else
		return false
	end
end

function lib.IsGatherInZone( zone, gatherName, gType )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.HasDataOnZone(zone) ) then
		local gtypeData = data[zone][gType]
		if ( gtypeData ) then
			for index, nodeData in ipairs(gtypeData) do
				if ( nodeData[gatherName] ) then
					return true
				end
			end
		end
	end
	return false
end

function lib.IsNodeInZone( zone, gType, index )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.HasDataOnZone(zone) ) then
		local gtypeData = data[zone][gType]
		if ( gtypeData ) then
			return gtypeData[index] and true or false
		end
	end
	return false
end

function lib.IsGatherTypeInZone( zone, gType )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.HasDataOnZone(zone) ) then
		if ( data[zone][gType] ) then
			return true
		end
	end
	return false
end

-- Returns 2 values
-- 1) the number of gathers in a zone
-- 2) the total number of nodes in a zone
--------------------------------------------------------------------------
function lib.GetNodeCounts( zone )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	local gatherCount = 0
	local nodeCount = 0

	if (  data[zone] ) then
		for gtype, nodes in pairs(data[zone]) do
			for index, nodeData in ipairs(nodes) do
				nodeCount = nodeCount + 1
				for key, gather in pairs(nodeData) do
					if ( type(gather) == "table" ) then
						gatherCount = gatherCount + 1
					end
				end
			end
		end
	end
	return gatherCount, nodeCount
end



-- Returns the number of nodes of the given gather name in the specified zone
--------------------------------------------------------------------------
function lib.GetGatherCountsForZone( zone, gatherName, gType )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( data[zone] and data[zone][gType] ) then
		local gatherCount = 0
		for index, nodeData in ipairs(data[zone][gType]) do
			if ( nodeData[gatherName] ) then
				gatherCount = gatherCount + 1
			end
		end
		return gatherCount
	else
		return 0
	end
end


-- Returns the count of nodes for each "Gather Type" in the zone specified
-- the return order is
--------------------------------------------------------------------------
local nodeCountsByType = { ARCH=0, OPEN=0, HERB=0, MINE=0, unknown=0, }

function lib.GetNodeCountsByGatherType( zone )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	for k, v in pairs(nodeCountsByType) do
		nodeCountsByType[k] = 0
	end

	if ( lib.HasDataOnZone(zone) ) then
		for gtype, nodes in pairs(data[zone]) do
			for index, nodeData in ipairs(nodes) do
				if ( nodeCountsByType[gtype] ) then
				nodeCountsByType[gtype] = nodeCountsByType[gtype] + 1
				else
					nodeCountsByType.unknown = nodeCountsByType.unknown + 1
				end
			end
		end
	end
	return nodeCountsByType.ARCH,
	       nodeCountsByType.OPEN,
	       nodeCountsByType.HERB,
	       nodeCountsByType.MINE,
	       nodeCountsByType.unknown
end


-- Returns information on a specific gather
--
-- Return Values:
-- x - the node's x coordinate value
-- y - the node's y coordinate value
-- count - the node's count value
-- indoors - true if this gather is located indoors
-- lastHarvested - time at which the node was last harvested
-- lastInspected - time at which the node was last inspected
-- source - the source of this node
--------------------------------------------------------------------------
function lib.GetGatherInfo( zone, gatherName, gType, index )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.IsGatherInZone(zone, gatherName, gType) ) then
		local nodeInfo = data[zone][gType][index]
		if ( nodeInfo ) then
			local gatherInfo = nodeInfo[gatherName]
			if ( gatherInfo ) then
				return nodeInfo[POS_X],
				       nodeInfo[POS_Y],
				       gatherInfo[COUNT],
				       nodeInfo[FLOOR],
				       gatherInfo[HARVESTED] or 0,
				       nodeInfo[INSPECTED] or 0,
				       gatherInfo[SOURCE]
			end
		end
	end
end

-- Returns information on a specific node
--
-- Return Values:
-- x - the node's x coordinate value
-- y - the node's y coordinate value
-- indoors - true if the node is flagged as an indoor node
-- lastInspected - time at which the node was last inspected
--------------------------------------------------------------------------
function lib.GetNodeInfo( zone, gType, index )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.IsGatherTypeInZone(zone, gType) ) then
		local nodeInfo = data[zone][gType][index]
		if ( nodeInfo ) then
			return nodeInfo[POS_X],
			       nodeInfo[POS_Y],
			       nodeInfo[FLOOR],
			       nodeInfo[INSPECTED] or 0
		end
	end
end

function lib.SetNodeInspected( zone, gType, index )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.IsGatherTypeInZone(zone, gType) ) then
		local node = data[zone][gType][index]
		if ( node ) then
			node[INSPECTED] = time()
		end
	end
end

function lib.GetNodeInspected( zone, gType, index )
	zone = Gatherer.ZoneTokens.GetZoneToken(zone)
	if ( lib.IsGatherTypeInZone(zone, gType) ) then
		local node = data[zone][gType][index]
		if ( node ) then
			return node[INSPECTED]
		end
	end
end


--[[
##########################################################################
 Iterators
##########################################################################
--]]
local EmptyIterator = function() end

local iteratorStateTables = {}
setmetatable(iteratorStateTables, { __mode = "k" }); --weak keys

--------------------------------------------------------------------------
-- iterator work table cache
--------------------------------------------------------------------------

local workTableCache = { {}, {}, {}, {}, }; -- initial size of 4 tables

local function getWorkTablePair()
	if ( table.getn(workTableCache) < 2 ) then
		table.insert(workTableCache, {})
		table.insert(workTableCache, {})
	end
	local index = table.remove(workTableCache)
	local state = table.remove(workTableCache)
	iteratorStateTables[index] = state
	return index, state
end

local function releaseWorkTablePair( index )
	local data = iteratorStateTables[index]
	if ( data ) then
		iteratorStateTables[index] = nil
		for k, v in pairs(index) do
			index[k] = nil
		end
		for k, v in pairs(data) do
			data[k] = nil
		end
		table.insert(workTableCache, index)
		table.insert(workTableCache, data)
	end
end

local function getWorkTable()
	if ( table.getn(workTableCache) < 1 ) then
		table.insert(workTableCache, {})
	end
	local workTable = table.remove(workTableCache)
	iteratorStateTables[workTable] = false
	return workTable
end

local function releaseWorkTable( workTable )
	if ( iteratorStateTables[workTable] == false ) then
		iteratorStateTables[workTable] = nil
		for k, v in pairs(workTable) do
			workTable[k] = nil
		end
		table.insert(workTableCache, workTable)
	end
end



-- Iterates over the contienent or the zones of a continent and returns
-- the indices for which Gatherer has data
--------------------------------------------------------------------------
do --create a new block

	local function iterator( iteratorData, lastIndex )
		if not ( iteratorData and lastIndex ) then return end --not enough information

		lastIndex = lastIndex + 1
		if ( iteratorData[lastIndex] ) then
			return lastIndex, iteratorData[lastIndex]
		else
			releaseWorkTable(iteratorData)
			return; --no data left
		end
	end


	function lib.GetAreaIndices( continent )
		local contTokens = Gatherer.ZoneTokens.TokensByContinent[continent]
		if ( continent and not contTokens ) then return EmptyIterator; end -- no data
		
		local iteratorData = getWorkTable()
		if ( continent ) then
			for i in pairs(data) do
				if ( contTokens[i] ) then
					tinsert(iteratorData, i)
				end
			end
		else
			for i in pairs(data) do
				if ( i ~= "dbVersion" ) then
					tinsert(iteratorData, i)
				end
			end
		end
		return iterator, iteratorData, 0
	end

end -- end the block

-- Iterates over the node types in a zone returning data on each type
-- The interator returns the following data on each gather
-- iteratorIndex
-- gatherName - loot name
-- gType - Gather type
--------------------------------------------------------------------------
do --create a new block

	local function iterator( iteratorData, lastIndex )
		if not ( iteratorData and lastIndex ) then return end --not enough information

		lastIndex = lastIndex + 1
		local nodeIndex = lastIndex * 2
		if ( iteratorData[nodeIndex] ) then
			return lastIndex,
			       iteratorData[nodeIndex - 1],
			       iteratorData[nodeIndex]
		else
			releaseWorkTable(iteratorData)
			return; --no data left
		end
	end


	function lib.ZoneGatherNames( zone )
		zone = Gatherer.ZoneTokens.GetZoneToken(zone)
		if ( lib.HasDataOnZone(zone) ) then
			local iteratorData = getWorkTable()
			for gtype, nodes in pairs(data[zone]) do
				local namesSeen = {}
				for index, nodeData in ipairs(nodes) do
					for gatherName, gather in pairs(nodeData) do
						if ( type(gather) == "table" and not namesSeen[gatherName] ) then
							tinsert(iteratorData, gatherName)
							tinsert(iteratorData, gtype)
						end
					end
				end
			end
			
			return iterator, iteratorData, 0
		end
		--safety
		return EmptyIterator
	end

end -- end the block

-- Iterates over the nodes of a specific type in a zone
-- The interator returns the following data on each node
--
-- index - for direct access to this node's information
-- x - the node's x coordinate value
-- y - the node's y coordinate value
-- inspected - the last time the node was inspected
-- indoors - if the node is considered to be indoors or not
--------------------------------------------------------------------------
do --create a new block

	local function iterator( stateIndex, lastNodeIndex )
		local state = iteratorStateTables[stateIndex]
		if not ( state ) then return end; --no data left

		local nodeIndex, info = state.iterator(state.stateInfo, lastNodeIndex)
		if not ( info ) then
			releaseWorkTablePair(stateIndex)
			return; --no data left
		end
		return nodeIndex, info[POS_X], info[POS_Y], info[INSPECTED], info[FLOOR]
	end


	function lib.ZoneGatherNodes( zone, gType )
		zone = Gatherer.ZoneTokens.GetZoneToken(zone)
		if ( lib.IsGatherTypeInZone(zone, gType) ) then
			local stateIndex, state = getWorkTablePair()
			state.iterator, state.stateInfo = ipairs(data[zone][gType])

			return iterator, stateIndex, 0
		end
		--safety
		return EmptyIterator
	end

end -- end the block

-- Closest Nodes
-- Returns an iterator
-- Iterator returns: id, zoneToken, gType, nodeIndex, distance
--------------------------------------------------------------------------
do --create a new block

	local function iterator( iteratorData, lastIndex )
		if not ( iteratorData and lastIndex ) then return end --not enough information

		lastIndex = lastIndex + 1
		local nodeIndex = lastIndex * 3
		if ( iteratorData[nodeIndex] ) then
			return lastIndex,
			       iteratorData.zoneToken,
			       iteratorData[nodeIndex - 2],
			       iteratorData[nodeIndex - 1],
			       iteratorData[nodeIndex]
		else
			releaseWorkTable(iteratorData)
			return; --no data left
		end
	end


	-- working tables
	local gTypes = {}
	local nodeIndex = {}
	local distances = {}

	function lib.ClosestNodes( zone, xPos, yPos, num, maxDist, filter )
		local zoneToken = Gatherer.ZoneTokens.GetZoneToken(zone)
		-- return if the position is invalid or we have no data on the specified zone
		if not ( lib.HasDataOnZone(zone) and xPos > 0 and yPos > 0 ) then
			return EmptyIterator
		end

		local iteratorData = getWorkTable()
		iteratorData.zoneToken = zoneToken

		if ( type(filter) == "function" ) then
			--do nothing

		elseif ( type(filter) == "table" ) then
			local filterTable = filter
			filter = (
				function( nodeName, gatherType )
					if not ( filterTable[gatherType] ) then
						return false
					
					elseif ( filterTable[gatherType] == true ) then
						return true
					
					elseif ( gatherType and not nodeName ) then
						return filterTable[gatherType] and true or false
					
					else
						return filterTable[gatherType][nodeName]
					
					end
				end
			)

		elseif ( filter == nil or filter ) then
			filter = true

		else
			return EmptyIterator

		end

		for i in ipairs(gTypes) do
			gTypes[i] = nil
			nodeIndex[i] = nil
			distances[i] = nil
		end
		
		local mapID, mapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(zoneToken)
		
		local zoneData = data[zoneToken]
		xPos = xPos
		yPos = yPos
		for gType, nodesList in pairs(zoneData) do
			if ( (filter == true ) or filter(nil, gType) ) then
				for index, nodeData in ipairs(nodesList) do
					local returnNode = filter;
					if ( type(filter) == "function" ) then
						for gatherName, gather in pairs(nodeData) do
							if ( type(gather) == "table" ) then
								returnNode = filter(gatherName, gType)
								if ( returnNode ) then
									break
								end
							end
						end
					end
					if ( returnNode ) then
						local nodeX, nodeY = nodeData[POS_X], nodeData[POS_Y]
						if ( (nodeX ~= 0) and (nodeY ~= 0) ) then
							local dist = Astrolabe:ComputeDistance(mapID, mapFloor, xPos, yPos, mapID, mapFloor, nodeX, nodeY)

							if ( (maxDist == 0) or (dist < maxDist) ) then
								local insertPoint = 1

								for i, nodeName in ipairs(gTypes) do
									if not ( distances[i+1] ) then
										insertPoint = i + 1
										break

									elseif ( distances[i] > dist ) then
										insertPoint = i
										break

									end
								end
								if ( insertPoint <= num) then
									tinsert(gTypes, insertPoint, gType)
									tinsert(nodeIndex, insertPoint, index)
									tinsert(distances, insertPoint, dist)
									local limit = num + 1
									gTypes[limit] = nil
									nodeIndex[limit] = nil
									distances[limit] = nil
								end
							end
						end
					end
				end
			end
		end

		for i, gType in ipairs(gTypes) do
			local dist = math.floor(distances[i]*100)/100
			tinsert(iteratorData, gType)
			tinsert(iteratorData, nodeIndex[i])
			tinsert(iteratorData, dist)
		end

		return iterator, iteratorData, 0
	end

end -- end the block

-- Closest Nodes Info
-- Returns an iterator
-- Iterator returns: id, zoneToken, gType, nodeIndex, distance, +GetNodeInfo()
--------------------------------------------------------------------------
do --create a new block

	local function iterator( iteratorData, lastIndex )
		if not ( iteratorData and lastIndex ) then return end --not enough information

		lastIndex = lastIndex + 1
		local nodeIndex = lastIndex * 3
		if ( iteratorData[nodeIndex] ) then
			local zoneToken, gType, index, dist = iteratorData.zoneToken, iteratorData[nodeIndex - 2], iteratorData[nodeIndex - 1], iteratorData[nodeIndex]
			return lastIndex, zoneToken, gType, index, dist, lib.GetNodeInfo(zoneToken, gType, index)
		else
			releaseWorkTable(iteratorData)
			return; --no data left
		end
	end


	function lib.ClosestNodesInfo( zone, xPos, yPos, num, maxDist, filter )
		local f, iteratorData, var = lib.ClosestNodes(zone, xPos, yPos, num, maxDist, filter)

		if ( f == EmptyIterator ) then
			return f
		else
			return iterator, iteratorData, var
		end
	end

end -- end the block

-- Iterates over the gather names in a node
-- The interator returns the following data on each gather
-- gatherName - loot name
-- count
-- last harvested
-- source
--------------------------------------------------------------------------
do --create a new block

	local function iterator( iteratorData, lastIndex )
		if not ( iteratorData and lastIndex ) then return end --not enough information

		lastIndex = lastIndex + 1
		local nodeIndex = lastIndex * 4
		if ( lastIndex <= iteratorData.numElem ) then
			return lastIndex,
			       iteratorData[nodeIndex - 3],
			       iteratorData[nodeIndex - 2],
			       iteratorData[nodeIndex - 1],
			       iteratorData[nodeIndex]
		else
			releaseWorkTable(iteratorData)
			return; --no data left
		end
	end


	function lib.GetNodeGatherNames( zone, gType, nodeIndex )
		zone = Gatherer.ZoneTokens.GetZoneToken(zone)
		if ( lib.IsNodeInZone(zone, gType, nodeIndex) ) then
			local iteratorData = getWorkTable()
				local index = 0
				for gatherName, gatherData in pairs(data[zone][gType][nodeIndex]) do
					if ( type(gatherData) == "table" ) then
						index = index + 1
						local nodeIndex = index * 4
						iteratorData[nodeIndex - 3] = gatherName
						iteratorData[nodeIndex - 2] =  gatherData[COUNT]
						iteratorData[nodeIndex - 1] =  gatherData[HARVESTED] or 0
						iteratorData[nodeIndex] =  gatherData[SOURCE]
					end
				end
				iteratorData.numElem = index
			
			return iterator, iteratorData, 0
		end
		--safety
		return EmptyIterator
	end

end -- end the block


--------------------------------------------------------------------------
-- Event Frame to import/export the data table from/to the global
-- namespace when appropriate
--------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_LOGOUT")
eventFrame.UnregisterEvent = function() end

eventFrame:SetScript("OnEvent", function( frame, event, arg1 )
	if ( event == "ADDON_LOADED" and strlower(arg1) == "gatherer" ) then
		local savedData = _G[globalName]
		if ( savedData ) then
			-- set the corruptData flag to true, just in case we encounter a Lua error
			corruptData = true
			
			if ( savedData.dbVersion == nil ) then --old, unversioned Database
				savedData.dbVersion = 0
			end
			if ( type(savedData.dbVersion) == "number" ) then
				if ( dbVersion == savedData.dbVersion ) then --database is current, no conversion needed
					data = savedData
					
					local needImport = false
					local dataToImport = { dbVersion = dbVersion }
					
					-- check for map File names that were used as a zone token and merge them if we now have a token
					for zoneToken, zoneData in pairs(data) do
						if ( type(zoneToken) == "number" and type(zoneData) == "table" ) then
							needImport = true
							if not (dataToImport) then dataToImport = { }; end
							dataToImport[zoneToken] = data[zoneToken]
							data[zoneToken] = nil
						end
					end
					
					if ( needImport ) then
						lib.ImportDatabase(dataToImport)
					end
					
					-- old deprecated check removed
					-- if needed, add back an explict Deprecated list instead of removing unknown gather names
					
				elseif ( savedData.dbVersion < dbVersion ) then --old database, conversion needed
					-- data wipe notification
					if ( savedData.dbVersion < 4 ) then
						Gatherer.Notifications.AddInfo(_tr("STORAGE_DB_CATACLYSMIC"))
					end
					
					-- check for, and import any set aside DBs that we can now process
					if ( type(savedData.setAsideDatabases) == "table" ) then
						for i, setAsideDB in pairs(savedData.setAsideDatabases) do
							if ( type(setAsideDB) == "table" ) then
								if ( type(setAsideDB.dbVersion) == "number" ) then
									if ( setAsideDB.dbVersion <= dbVersion ) then
										lib.ImportDatabase(setAsideDB)
										savedData.setAsideDatabases[i] = nil
									end
								else
									savedData.setAsideDatabases[i] = nil -- version isn't a number (and thus is invalid)
								end
							else
								savedData.setAsideDatabases[i] = nil -- not a table, dump it
							end
						end
						if not ( next(savedData.setAsideDatabases) ) then
							savedData.setAsideDatabases = nil
						end
					else
						savedData.setAsideDatabases = nil -- not a table, dump it
					end
					
					-- import the main database
					lib.ImportDatabase(savedData)
					
					if ( savedData.setAsideDatabases ) then
						-- still 1 or more databases stored that are too new, save them for now
						data.setAsideDatabases = savedData.setAsideDatabases
					end
				
				elseif ( savedData.dbVersion > dbVersion ) then	--database TOO new (Old Gatherer Version)
					--set the database aside and warn the user
					lib.ClearDatabase()
					data.setAsideDatabases = savedData.setAsideDatabases or {}
					table.insert(data.setAsideDatabases, savedData)
					StaticPopup_Show("GATHERER_DATABASE_TOO_NEW")
				
				end
				
				-- clear the corruptData flag as we didn't error out anywhere
				corruptData = false
				getfenv(0)[globalName] = nil
			else
				--INVALID DATABASE VERSION, raise an error and put the invalid database back into the global 
				-- environment, the user can choose to clear the DB, or keep the invalid one
				StaticPopup_Show("GATHERER_INVALID_DATABASE_VERSION")
				getfenv(0)[globalName] = savedData
				corruptData = true
				lib.ClearDatabase()
			end
		else
			lib.ClearDatabase();
		end

	elseif ( event == "PLAYER_LOGOUT" ) then
		-- don't write out the internal table if the user chose to keep a corrupt database
		if not ( corruptData ) then
			getfenv(0)[globalName] = data
		end

	end
end)
eventFrame.SetScript = function() end

local workingTable = {}
local function processImportedSourceField( ... )
	for k in pairs(workingTable) do
		workingTable[k] = nil
	end
	local hasName, imported, require
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		if ( name == "REQUIRE" ) then
			require = true
		elseif ( name == "IMPORTED" ) then
			imported = true
		else
			hasName = true
			workingTable[name] = true
		end
	end
	if ( (hasName and imported) or (hasName and require) or (require and imported) ) then
		return nil
	else
		local nameList = ""
		for name in pairs(workingTable) do
			nameList = nameList..","..name
		end
		return nameList:sub(2)
	end
end

local numMergeNodeArgs = 11
local function MergeNode(gather, gatherType, continent, zone, gatherX, gatherY, count, harvested, inspected, source, indoorNode)
	if not ( gather and gatherType and zone and gatherX and gatherY ) then
		return -- not enough data
	end
	zone = Gatherer.ZoneTokens.GetZoneTokenByContZone(continent, zone) or Gatherer.ZoneTokens.GetZoneToken(zone)
	local index = lib.AddNode(gather, gatherType, zone, gatherX, gatherY, source, false, indoorNode)
	if not ( index ) then return end -- node was not added for some reason, abort
	local node = data[zone][gatherType][index]
	local gather = node[gather]
	if ( count ) then
		gather[COUNT] = gather[COUNT] + count
	end
	if ( harvested ) then
		gather[HARVESTED] = harvested
	else
		gather[HARVESTED] = 0
	end
	if ( inspected ) then
		node[INSPECTED] = inspected
	else
		node[INSPECTED] = 0
	end
	if ( gather[SOURCE] and gather[SOURCE] ~= "IMPORTED" and gather[SOURCE] ~= "REQUIRE" ) then
		gather[SOURCE] = processImportedSourceField(string.split(",", gather[SOURCE]))
	end
end

function lib.ImportDatabase( database )
	if not ( data ) then
		lib.ClearDatabase();
	end
	Gatherer.Convert.ImportDatabase(database, MergeNode, numMergeNodeArgs)
end


--------------------------------------------------------------------------
-- Warning Dialogs
--------------------------------------------------------------------------

-- references to localization functions
local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

StaticPopupDialogs["GATHERER_INVALID_DATABASE_VERSION"] = {
	text = _trL("STORAGE_DB_VERSION_INVALID"),
	button1 = _trL("ACCEPT"),
	button2 = _trL("IGNORE"),
	OnAccept = function()
		corruptData = false
	end,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs["GATHERER_DATABASE_TOO_NEW"] = {
	text = _trL("STORAGE_DB_VERSION_NEWER"),
	button1 = _trL("OKAY"),
	timeout = 0,
	whileDead = 1,
}

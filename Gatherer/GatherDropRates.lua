--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 5.0.0 (<%codename%>)
	Revision: $Id: GatherDropRates.lua 1129 2014-11-13 21:02:28Z esamynn $

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
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_5.0.0/Gatherer/GatherDropRates.lua $", "$Rev: 1129 $")

local dbVersion = 5

local ArchaeologyCurrencies_DropRateConversions = {
	["ARCH_DRAENEI"] = 398,
	["ARCH_DWARF"] = 384,
	["ARCH_FOSSIL"] = 393,
	["ARCH_NERUBIAN"] = 400,
	["ARCH_NIGHTELF"] = 394,
	["ARCH_ORC"] = 397,
	["ARCH_TOLVIR"] = 401,
	["ARCH_TROLL"] = 385,
	["ARCH_VRYKUL"] = 399,
	["ARCH_PANDAREN"] = 676,
	["ARCH_MOGU"] = 677,
}

function Gatherer.DropRates.Load()
	local data = Gatherer_DropRates
	
	if ( type(data) ~= "table" ) then
		data = { dbVersion = dbVersion }
	elseif ( dbVersion ~= data.dbVersion ) then
		
		if (data.dbVersion == 1) then
			local objectCategories = Gatherer.Categories.ObjectCategories
			local objectGTypes = Gatherer.Nodes.Objects
			
			for cont, contData in pairs(data) do
				if ( type(contData) == "table" ) then
					for zone, zoneData in pairs(contData) do
						for nodeId, nodeData in pairs(zoneData) do
							
							if (objectGTypes[nodeId] == "MINE") then
								local total = nodeData.total
								if (objectCategories[nodeId]:find("^ORE_R")) then
									total = total / 6.5
								else
									total = total / 3
								end
								total = math.floor(total + 0.5)
								if total < 1 then total = 1 end
								nodeData.total = total
							end
							
						end
					end
				end
			end
			data.dbVersion = 2
		end
		
		if (data.dbVersion == 2) then
			local objectCategories = Gatherer.Categories.ObjectCategories
			local objectGTypes = Gatherer.Nodes.Objects
			
			for cont, contData in pairs(data) do
				if ( type(contData) == "table" ) then
					for zone, zoneData in pairs(contData) do
						for nodeId, nodeData in pairs(zoneData) do
							
							if (objectGTypes[nodeId] == "ARCH") then
								local total = nodeData.total
								local currencyID = ArchaeologyCurrencies_DropRateConversions[objectCategories[nodeId]]
								if ( currencyID and not nodeData[currencyID] ) then
									nodeData[currencyID] = nodeData.total * 7 -- magic number is 7... just because
								end
							end
							
						end
					end
				end
			end
			data.dbVersion = 3
		end
		
		if (data.dbVersion == 3) then
			data = { dbVersion = 4 }
			for cont, contData in pairs(Gatherer_DropRates) do
				if ( type(cont) == "number" ) then
					for zone, zoneData in pairs(contData) do
						local zoneToken = Gatherer.ZoneTokens.GetZoneToken(tonumber(zone) or zone)
						if ( zoneToken ) then
							data[zoneToken] = zoneData
						end
					end
				end
			end
		end

		if (data.dbVersion == 4) then
			local objectGTypes = Gatherer.Nodes.Objects
			for zoneToken, zoneData in pairs(data) do
				if ( type(zoneData) == "table" ) then
					for nodeId, nodeData in pairs(zoneData) do
						if (objectGTypes[nodeId] == "ARCH") then
							local newData = {}
							for itemId, count in pairs(nodeData) do
								if ( type(itemId) == "number" and itemId < 1000 ) then
									newData[-itemId] = count
								else
									newData[itemId] = count
								end
							end
							zoneData[nodeId] = newData
						end
					end
				end
			end
			data.dbVersion = 5
		end
		
		if ( data.dbVersion ~= dbVersion ) then
			-- just clear the data if version isn't current and we don't know how to convert
			data = { dbVersion = dbVersion }
		end
	end
	
	Gatherer.DropRates.Data = data
end

function Gatherer.DropRates.Save()
	Gatherer_DropRates = Gatherer.DropRates.Data
end

function Gatherer.DropRates.ProcessDrops( objectId, zone, source, coins, loot )
	if not ( loot ) then return end
	local zoneToken = Gatherer.ZoneTokens.GetZoneToken(zone)
	if not zoneToken then
		return
	end
	local data = Gatherer.DropRates.Data
	
	if not (data[zoneToken]) then data[zoneToken] = { } end
	if not (data[zoneToken][objectId]) then data[zoneToken][objectId] = { total = 0 } end
	data = data[zoneToken][objectId]
	
	local foundItem = false
	for pos, loot in ipairs(loot) do
		local id = loot.id
		local lootType = loot.type
		if (not id and loot.link) then
			id = Gatherer.Util.BreakLink(loot.link)
		end
		if ( lootType == LOOT_SLOT_CURRENCY ) then
			id = -id
		end
		if ( id ) then
			local count = loot.count
			if ( count ) then
				data[id] = (data[id] or 0) + count
				foundItem = true
			end
		end
	end
	if ( foundItem ) then
		data.total = data.total + 1
	end
end

local tempData = {}
local function GetDropsTable( objectId, zone )
	local data = Gatherer.DropRates.Data
	if ( zone ) then
		zone = Gatherer.ZoneTokens.GetZoneToken(zone)
		if ( data and data[zone] and data[zone][objectId] ) then
			return data[zone][objectId]
		end
	else
		for k in pairs(tempData) do
			tempData[k] = nil
		end
		tempData.total = 0
		for _, nodes in pairs(data) do
			if ( type(nodes) == "table" ) then
				for id, node in pairs(nodes) do
					if ( objectId == id ) then
						for item, count in pairs(node) do
							tempData[item] = (tempData[item] or 0) + count
						end
					end
				end
			end
		end
		return tempData
	end
end

function Gatherer.DropRates.HasDropsInfo( objectId, zone )
	local data = Gatherer.DropRates.GetDropsTotal(objectId, cont, zone)
	return data and (data.total > 0)
end

function Gatherer.DropRates.GetDropsTotal( objectId, zone )
	local data = GetDropsTable(objectId, zone)
	if ( data ) then
		return data.total
	end
end

function Gatherer.DropRates.GetPrimaryItem( objectId )
	local data = GetDropsTable(objectId)
	if ( data and (data.total > 0) ) then
		local prime = 0
		local pcount = 0
		for item, count in pairs(data) do
			if (item ~= "total" and pcount < count) then
				prime = item
				pcount = count
			end
		end
		return prime, pcount
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


--
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
			return --no data left
		end
	end
	
	local data
	local function dropRateCompare_DESC( i, j )
		if ( data[i] > data[j] ) then
			return true
		else
			return false
		end
	end
	local function dropRateCompare_ASC( i, j )
		if ( data[i] < data[j] ) then
			return true
		else
			return false
		end
	end
	
	local dropsCache = {}
	
	function Gatherer.DropRates.ObjectDrops( objectId, zone, sort )
		data = GetDropsTable(objectId, zone)
		if not ( data and (data.total > 0) ) then
			return EmptyIterator
		end
		
		local iteratorData = getWorkTable()
		if ( sort ) then
			for k in pairs(dropsCache) do
				dropsCache[k] = nil
			end
			for item, count in pairs(data) do
				if (item ~= "total") then
					table.insert(dropsCache, item)
				end
			end
			if ( sort == "ASC" ) then
				table.sort(dropsCache, dropRateCompare_ASC)
			elseif ( sort == "DESC" ) then
				table.sort(dropsCache, dropRateCompare_DESC)
			end
			for i, item in ipairs(dropsCache) do
				tinsert(iteratorData, item)
				tinsert(iteratorData, data[item])
			end
		
		else
			for item, count in pairs(data) do
				if (item ~= "total") then
					tinsert(iteratorData, item)
					tinsert(iteratorData, count)
				end
			end
		
		end
		
		return iterator, iteratorData, 0
	end

end -- end the block
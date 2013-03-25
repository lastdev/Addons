--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.2.0 (<%codename%>)
	Revision: $Id: GatherConvert.lua 955 2012-08-28 16:39:14Z Esamynn $

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

	Database conversion/merging code and conversion data tables
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherConvert.lua $", "$Rev: 955 $")

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Convert, metatable )
setfenv(1, Gatherer.Convert)

local type = type
local ipairs = ipairs
local pairs = pairs
local _G = _G


local nodeLevel, mappingData, typeConversionData, conversionValidationFunc
local traversalData = {}
local MergeNode, NumMergeNodeArgs

local nodeData = {}
local function extractNodeInformation()
	for index, mapping in pairs(mappingData) do
		if ( mapping.type == "key" ) then
			nodeData[index] = traversalData[mapping.level].key
		elseif ( mapping.type == "value" ) then
			nodeData[index] = traversalData[mapping.level].data[mapping.key]
		else
			--ERROR
			return
		end
	end
	for index, data in ipairs(nodeData) do
		local typeInfo = typeConversionData[index]
		local dataType = type(data)
		if ( typeInfo ) then
			if ( type(typeInfo) == "string" ) then
				if ( dataType ~= typeInfo ) then
					data = nil; --Invalid Type, set to nil
				end
			elseif ( type(typeInfo) == "table" ) then
				local conversionInfo = typeInfo[dataType]
				if ( (dataType == "string") and not (typeInfo.caseSensitive) ) then
					data = string.lower(data)
				end
				if ( conversionInfo ) then
					if ( type(conversionInfo) == "table" ) then
						data = conversionInfo[data]
					elseif ( type(conversionInfo) == "function" ) then
						data = conversionInfo(data, nodeData)
					elseif ( type(conversionInfo) == "string" ) then
						data = _G[conversionInfo](data, nodeData)
					end
				else
					data = nil; --Invalid Type, set to nil
				end
			else
				--BAD MERGE DEFINITION!
			end
		else
			data = nil; --no type or conversion information
		end
		nodeData[index] = data
	end
	if ( type(conversionValidationFunc) == "function" ) then
		local result, err = pcall(conversionValidationFunc, unpack(nodeData, 1, NumMergeNodeArgs))
		if ( result ) then
			if not ( err ) then
				return
			end
		else
			Gatherer.Util.Debug("Conversion validator error", err, "Data: ("..strjoin(", ", tostringall(unpack(nodeData, 1, NumMergeNodeArgs)))..")")
		end
	end
	local result, err = pcall(MergeNode, unpack(nodeData, 1, NumMergeNodeArgs))
	if not ( result ) then
		Gatherer.Util.Debug("MergeNode error", err, "Data: ("..strjoin(", ", tostringall(unpack(nodeData, 1, NumMergeNodeArgs)))..")")
	end
end

local function iterateOnLevel( level )
	if ( level < 1 or level > nodeLevel ) then return level end --Invalid Level!
	
	if ( level == nodeLevel ) then
		extractNodeInformation()
	else
		for key, data in pairs(traversalData[level].data) do
			if ( type(data) == "table" ) then
				local newLevel = level + 1
				traversalData[newLevel].key = key
				traversalData[newLevel].data = data
				iterateOnLevel(newLevel)
			end
		end
	end
end


function ImportDatabase( dataToImport, nodeMergeFunction, numMergeArgs )
	local dbVer = dataToImport.dbVersion
	local converInfo = ConversionInformation[dbVer]
	if ( converInfo ) then
		nodeLevel = converInfo.nodeLevel
		mappingData = converInfo.mappingData
		typeConversionData = converInfo.typeConversionData
		conversionValidationFunc = converInfo.validator
		MergeNode = nodeMergeFunction
		NumMergeNodeArgs = numMergeArgs
		for i = 1, nodeLevel do
			if not ( traversalData[i] ) then
				traversalData[i] = {}
			end
		end
		for key, data in pairs(dataToImport) do
			if ( type(data) == "table" ) then
				traversalData[1].data = data
				traversalData[1].key = key
				iterateOnLevel(1)
			end
		end
	end
end

ConversionInformation = {
	[0] = false, -- DB version 0 only dealt with the old world, we can just dump it
	[1] = false, -- DB version 1 only dealt with the old world, we can just dump it
	
	--MergeNode argument mapping table for DB version 2 to MergeNode function arguments
	[2] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=3, }, --gatherName
			[2] = { type="value", level=3, key="gtype" }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key=1, }, --x
			[6] = { type="value", level=4, key=2, }, --y
			[7] = { type="value", level=4, key=3, }, --count
			[8] = { type="value", level=4, key=4, }, --harvested
			[9] = { type="value", level=4, key=5, }, --inspected
			[10] = { type="value", level=4, key=6, }, --source
		},
		--conversion table for any needed type conversions to the arguments of MergeNode
		--this is also type checking data
		--if there is no data for an arugment, then it is nil'd out
		--values with invalid types are nil'd out
		--conversion specifications can either be a table or a function that maps old values to new ones
		typeConversionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						--stick with the name if we don't have an id for it yet
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
				number = (
					function( data )
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
			},
			[2] = "string",
			[3] = "number",
			[4] = {
				string = (
					function( data )
						data = data:upper()
						return Gatherer.ZoneTokens.Ver3To4TempTokens[zone] or data
					end
				),
			},
			[5] = "number",
			[6] = "number",
			[7] = "number",
			[8] = "number",
			[9] = "number",
			[10] = "string",
		},
		-- returns true if import should process, false to stop import of a node
		validator = function(gather, gatherType, continent, zone, gatherX, gatherY, count, harvested, inspected, source)
			if ( continent == 1 or continent == 2 ) then
				if ( CataclysmDoNotDeleteTokens[zone] ) then
					return true
				end
				return false
			else
				return true
			end
		end,
	},
	
	--MergeNode argument mapping table for DB version 4 to MergeNode function arguments
	[3] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=3, }, --gatherName
			[2] = { type="value", level=3, key="gtype" }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key=1, }, --x
			[6] = { type="value", level=4, key=2, }, --y
			[7] = { type="value", level=4, key=3, }, --count
			[8] = { type="value", level=4, key=4, }, --harvested
			[9] = { type="value", level=4, key=5, }, --inspected
			[10] = { type="value", level=4, key=6, }, --source
		},
		--conversion table for any needed type conversions to the arguments of MergeNode
		--this is also type checking data
		--if there is no data for an arugment, then it is nil'd out
		--values with invalid types are nil'd out
		--conversion specifications can either be a table or a function that maps old values to new ones
		typeConversionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						--stick with the name if we don't have an id for it yet
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
				number = (
					function( data )
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
			},
			[2] = "string",
			[3] = "number",
			[4] = {
				string = (
					function( data )
						data = data:upper()
						return Gatherer.ZoneTokens.Ver3To4TempTokens[zone] or data
					end
				),
			},
			[5] = "number",
			[6] = "number",
			[7] = "number",
			[8] = "number",
			[9] = "number",
			[10] = "string",
		},
		-- returns true if import should process, false to stop import of a node
		validator = function(gather, gatherType, continent, zone, gatherX, gatherY, count, harvested, inspected, source)
			if ( continent == 1 or continent == 2 ) then
				if ( CataclysmDoNotDeleteTokens[zone] ) then
					return true
				end
				return false
			else
				return true
			end
		end,
	},
	
	--MergeNode argument mapping table for DB version 4 to MergeNode function arguments
	[4] = {
		nodeLevel = 5,
		mappingData = {
			[1] = { type="key", level=5, }, --gatherName
			[2] = { type="key", level=3, }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key=1, }, --x
			[6] = { type="value", level=4, key=2, }, --y
			[7] = { type="value", level=5, key=1, }, --count
			[8] = { type="value", level=5, key=2, }, --harvested
			[9] = { type="value", level=4, key=3, }, --inspected
			[10] = { type="value", level=5, key=3, }, --source
			[11] = { type="value", level=4, key=4, }, --indoor
		},
		typeConversionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						--stick with the name if we don't have an id for it yet
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
				number = (
					function( data )
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
			},
			[2] = "string",
			[3] = "number",
			[4] = {
				caseSensitive = true,
				string = (
					function( data )
						return tonumber(data) or data
					end
				),
				number = (
					function( data )
						return data
					end
				),
			},
			[5] = "number",
			[6] = "number",
			[7] = "number",
			[8] = "number",
			[9] = "number",
			[10] = "string",
			[11] = "boolean",
		},
	},
	
	--MergeNode argument mapping table for DB version 5 to MergeNode function arguments
	[5] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=4, }, --gatherName
			[2] = { type="key", level=2, }, --gatherType
			[3] = nil, --continent
			[4] = { type="key", level=1, }, --zone
			[5] = { type="value", level=3, key=1, }, --x
			[6] = { type="value", level=3, key=2, }, --y
			[7] = { type="value", level=4, key=1, }, --count
			[8] = { type="value", level=4, key=2, }, --harvested
			[9] = { type="value", level=3, key=3, }, --inspected
			[10] = { type="value", level=4, key=3, }, --source
			[11] = { type="value", level=3, key=4, }, --indoor
		},
		typeConversionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						--stick with the name if we don't have an id for it yet
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
				number = (
					function( data )
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
			},
			[2] = "string",
			[3] = nil,
			[4] = {
				caseSensitive = true,
				string = (
					function( data )
						return data
					end
				),
				number = (
					function( data )
						return data
					end
				),
			},
			[5] = "number",
			[6] = "number",
			[7] = "number",
			[8] = "number",
			[9] = "number",
			[10] = "string",
			[11] = "boolean",
		},
	},
}

-- tokens for zones that are part of TBC and were
-- not changed by the Shattering
CataclysmDoNotDeleteTokens = {
	-- Kalimdor
	AZUREMYST_ISLE = true,
	BLOODMYST_ISLE = true,
	EXODAR = true,
	
	-- Eastern Kingdoms
	EVERSONG_WOODS = true,
	GHOSTLANDS = true,
	SILVERMOON = true,
	QUEL_DANAS = true,
}
for _, token in pairs(Gatherer.ZoneTokens.Ver3To4TempTokens) do
	CataclysmDoNotDeleteTokens[token] = true
end

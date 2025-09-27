local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate2")
local Config = GatherMate:GetModule("Config")

local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate2", true)

local versionCli = select(4,GetBuildInfo())
local isRetail = versionCli>=50000  -- MoP or higher is considered retail

--------------------------------------------------------------------------

local zone_fix = isRetail and {
	[1951] = 107, -- 301
	[1946] = 102, -- 302
	[1953] = 109, -- 303
	[1948] = 104, -- 304
} or {}

--------------------------------------------------------------------------

local function GetGasNodeTypeForZone(zone)
	if zone then
		local validNodes = GatherMateData2GasCloudsDB[zone]
		if validNodes then
			local _, validNodeID = next(validNodes)
			return validNodeID
		end
	end
end

local function FixGasNodesForZone(zone, nodes)
	local count = 0
	local validNodeID = GetGasNodeTypeForZone(zone)
	if validNodeID and validNodeID<305 then -- fix only burning crusade gas nodes
		nodes = nodes or GatherMate2GasDB[zone]
		if nodes then
			for coord, nodeID in pairs(nodes) do
				if nodeID~=validNodeID then
					nodes[coord] = validNodeID
					count = count + 1
				end
			end
		end
	end
	return count
end

local UpdateDatabaseAutoRepair
do
	local events = CreateFrame('Frame')
	events:SetScript('OnEvent', function(self, event, unit, guid, spellID)
		if spellID==30427 then -- Gas Extract Channeling spell
			C_Timer.After(1, function()
				local count = FixGasNodesForZone( C_Map.GetBestMapForUnit("player") )
				if count>0 then
					Config:SendMessage("GatherMate2ConfigChanged")
				end
			end)
		end
	end)
	function UpdateDatabaseAutoRepair()
		if GatherMate.db.global.__GasCloudsAutoFixDisabled then
			events:UnregisterAllEvents()
		else
			events:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
		end
	end
	UpdateDatabaseAutoRepair()
end

--------------------------------------------------------------------------

local importStyle = 'Merge'
Config:RegisterImportModule('GatherMate2_GasClouds', {
	type = "group",
	name = L["Gas Clouds"] .. " <by MiCHaEL>",
	args = {
		desc = {
			order = 1,
			type = "description",
			name = "Importing Gas Clouds Data for WoW Classic <by MiCHaEL>",
		},
		loadType = {
			order = 2,
			name = L["Import Style"],
			desc = "Merge will add Gas Clouds to your database. Overwrite will replace your Gas Clouds database.",
			type = "select",
			set = function(info,value) importStyle = value end,
			get = function() return importStyle	end,
			values = { Merge = L["Merge"], Overwrite = L["Overwrite"] },
		},
		import = {
			order = 3,
			name = "Import Gas Clouds",
			type = "execute",
			func = function()
				if importStyle == 'Overwrite' then
					GatherMate:ClearDB("Extract Gas")
				end
				for zoneID, node_table in pairs(GatherMateData2GasCloudsDB) do
					if not zoneFilter or zoneFilter[zoneID] then
						for coord, nodeID in pairs(node_table) do
							GatherMate:InjectNode2(zone_fix[zoneID] or zoneID,coord,"Extract Gas", nodeID)
						end
					end
				end
				print("GatherMate2: Gas Clouds Database has been imported.")
				Config:SendMessage("GatherMate2ConfigChanged")
			end,
		},
		separator = {
			order = 4,
			type = "description",
			name = "\nGas Clouds Database Maintenance",
			hidden = function() return isRetail end,
		},
		repair = {
			order = 5,
			width = 'double',
			name = "Repair Gas Clouds Database",
			desc = "Gathermate2 may incorrect marks all new discovered nodes as Steam Clouds. This process repairs the gas clouds database assigning the correct nodes types.",
			type = "execute",
			func = function()
				local count = 0
				for zone, nodes in pairs(GatherMate2GasDB) do
					count = count + FixGasNodesForZone(zone, nodes)
				end
				print( count>0 and string.format( "GatherMate2: Gas Clouds Database Repaired, %d gas clouds have been fixed!", count) or "GatherMate2: Gas Clouds Database verified, there is nothing to fix!" )
				Config:SendMessage("GatherMate2ConfigChanged")
			end,
			confirm = true,
			confirmText = "Are you sure you want to verify and repair the Gas Clouds Database ?",
			hidden = function() return isRetail end,
		},
		autorepair = {
			order = 6,
			width = "full",
			name = "Auto Repair Gas Clouds Database",
			desc = "Gathermate2 may incorrect marks all new discovered nodes as Steam Clouds. Check this option to automatic fix new discovered nodes.",
			type = "toggle",
			get = function()
				return not GatherMate.db.global.__GasCloudsAutoFixDisabled
			end,
			set = function(info, value)
				GatherMate.db.global.__GasCloudsAutoFixDisabled = (not value) or nil
				UpdateDatabaseAutoRepair()
			end,
			hidden = function() return isRetail end,
		},
	},
})

--[[ See license.txt for license and copyright information ]]
local _, addon = ...
local cache = addon.newCache(600, 30)

function addon.getVignettes(mapID)
	local tbl = cache.get(mapID)
	if (not tbl) then
		local namesC = addon.vignette_names.data[mapID]
		if (namesC) then
			local names = loadstring(
					addon.compression.decompress(
							namesC,
							addon.vignette_names.dictionary,
							addon.vignette_names.encodingF))()
			local info = loadstring(
					addon.compression.decompress(
							addon.vignette_info.data[mapID],
							addon.vignette_info.dictionary,
							addon.vignette_info.encodingF))()
			local keys = { }
			for k, v in ipairs(info[1]) do
				keys[v] = k
			end
			tbl = { }
			local v_rule, l_rule, t_rule = unpack(info[3])
			for k, v in ipairs(info[2]) do
				local row = { }
				local function GetLocation()
					local location = addon.executeLocationRule(l_rule, row)
					return location[1] / 100000, location[2] / 100000
				end
				setmetatable(row, {
					__index = function(_, key)
						if (key == "Name") then
							return names[k]
						end
						if (key == "isVisible") then
							return addon.executeVisibilityRule(v_rule, row)
						end
						if (key == "GetLocation") then
							return GetLocation
						end
						if (key == "isCompleted") then
							return addon.executeTrackingRule(t_rule, row)
						end
						return v[keys[key]]
					end
				})
				tbl[row["ID"]] = row
			end
			cache.add(mapID, tbl)
		end
	end
	return tbl
end

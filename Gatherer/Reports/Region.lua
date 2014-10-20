--[[

	Report for Gatherer

]]

local filterName = Gatherer.Locale.Tr("REPORT_SEARCH_BY_REGION")

function filterFunction(parameter, zone, nodeid, index, x,y, count, harvest, inspect, source, gtype)
	if ( zone ) then
		for i, cdata in ipairs(Gatherer.ZoneTokens.ZoneNames) do
			if ( cdata[zone] ) then
				local zoneName = tostring(cdata.CONTINENT or "") .. " " .. tostring(cdata[zone] or "")
				if (zoneName:lower():find(parameter:lower(), 1, true)) then return true end
			end
		end
	end
	return false
end

Gatherer.Report.AddButton(filterName, filterFunction)

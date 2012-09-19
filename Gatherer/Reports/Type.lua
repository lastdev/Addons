--[[

	Report for Gatherer

]]

local filterName = Gatherer.Locale.Tr("REPORT_SEARCH_BY_TYPE")

function filterFunction(parameter, zone, nodeid, index, x,y, count, harvest, inspect, source, gtype)
	local nodeName = Gatherer.Util.GetNodeName(nodeid)
	if (nodeName and nodeName:lower():find(parameter:lower(), 1, true)) then return true end
	if (not nodeName) then Gatherer.Util.Debug("Unknown node", nodeid) end
	return false
end

Gatherer.Report.AddButton(filterName, filterFunction)

-- Global locals.
ItemExpansion_G = {}

function ItemExpansion_G.ToolTipHook(t, data)
	-- Ignore vendor items.
	if t["GetItem"] == nil then
		return
	end
	-- t = {name, link, itemID}
	local itemID = select(3, t:GetItem())

	-- Item 'data["hyperlink"]' exists (not nil) on the first item load only,
	-- so no double show happens.
	if not itemID or data["hyperlink"] then
		return
	end

	local expacID = ItemExpansion_G.exceptions[itemID]
	if expacID == nil then
		-- Zero indexed to lua standard one indexed (also used by 'EJ_GetTierInfo').
		expacID = select(15, GetItemInfo(itemID)) + 1
		-- Classic or info missing. Is here, so `exceptions` can allow "Classic".
		if expacID == nil or expacID == 1 then
			return
		end
	end

	local expacName = EJ_GetTierInfo(expacID)
	GameTooltip:AddLine(expacName, 0, 1, 1)
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, ItemExpansion_G.ToolTipHook)

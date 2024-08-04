local _, IE = ...;
local select, strsplit, string = select, strsplit, string;

local expColors = {
	"|cFFFFFFFF%s|r",
	"|cFF1EFF00%s|r",
	"|cFF0070DD%s|r",
	"|cFFFF8000%s|r",
	"|cFFE6CC80%s|r",
	"|cFFeb9452%s|r",
	"|cFF108A00%s|r",
	"|cFF7a7a7a%s|r",
	"|cFFefdea9%s|r",
	"|cFFc9c3c3%s|r",
	"|cFFff5f07%s|r",
};

local function OnTooltipSetItem(tooltip, data)
	if (tooltip ~= GameTooltip and
		tooltip ~= ItemRefTooltip and
		tooltip ~= ItemRefShoppingTooltip1 and
		tooltip ~= ItemRefShoppingTooltip2 and
		tooltip ~= ShoppingTooltip1 and
		tooltip ~= ShoppingTooltip2) then
		return;
	end

	local itemID;
	if (data) then
		itemID = data.id;
	else
		local _, link = tooltip:GetItem();
		local itemSting = {strsplit(":", link)};
		itemID = itemSting[2];
	end

    local expacID = select(15, C_Item.GetItemInfo(itemID));
	if (expacID) then
		expacID = expacID + 1;
	else
		return;
	end

    tooltip:AddDoubleLine(IE.loc.EXPANSION, string.format(expColors[expacID], IE.loc.EXP_LIST[expacID]));
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem);
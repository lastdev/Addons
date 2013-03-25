local addonName, addonTable = ...;
local GUI = LibStub("AceGUI-3.0");

local oldEnv = getfenv();
setfenv(1,addonTable);

local frame = GUI:Create("Frame", "Reagent Restocker");
frame:SetTitle("Reagent Restocker")

-- Frame for blizzard's dialog box. Needed because Blizzard will eventually
-- clobber its parents. Duplicate ALL types of frames, in fact!
local bFrame = GUI:Create("BlizOptionsGroup", "Reagent Restocker");
local myGroup = GUI:Create("ScrollFrame", "Reagent Restocker");

-- current Frame, used for creating new frames and such.
local currentFrame = nil;

bFrame:SetName("Reagent Restocker", nil)
bFrame:SetTitle("Reagent Restocker")

--frame:SetTitle("Reagent Restocker");
frame:SetLayout("Fill");
bFrame:SetLayout("Fill");

frame:SetFullWidth(true);
frame:SetFullHeight(true);

myGroup:SetFullWidth(true);
myGroup:SetFullHeight(true);

myGroup:SetLayout("Fill");

frame:SetCallback("OnClose", function() ReagentRestocker:hideFrame(); end);

local maxFromSC = function (stack)	
	if stack >= 1000 then
		return 28000
	elseif stack > 100 then
		return 6400
	elseif stack > 20 then
		return 3200
	elseif stack > 10 then
		return 640
	elseif stack > 1 then
		return 320
	else
		return 32
	end
end	

--include("BLIZZARD");

local defaultStatus = "Reagent Restocker is a simple addon for automatically purchasing items, selling unwanted items, and repairing.";


local Menu = {
	{
		text = "Shopping",
		value = "shop",
		func=function() print"FUNC!" end
	},
	{
		text = "Selling",
		value = "sell"
	},
	{
		text="Exceptions",
		value = "exclude"
	},
	{
		text = "Bank",
		value = "bank"
	},
	{
		text = "Repair",
		value = "repair"
	},
	{
		text = "Misc",
		value = "misc"
	},
	{
		text = "Profiles",
		value = "profiles"
	},
--	{
--		text = "Global",
--		value = "global"
--	},
--	{
--		text = "Receipts",
--		value = "receipts"
--	},
	{
		text = "About",
		value = "about"
	},
}

shopList = {
}

sellList = {
}

excludeList = {
}

Menu[1].children=shopList;
Menu[2].children=sellList;
Menu[3].children=excludeList;

local selectTree = GUI:Create("TreeGroup");

selectTree:SetFullWidth(true);
--selectTree:SetFullHeight(true);
selectTree:SetLayout("List");
selectTree:SetTree(Menu);

local head = GUI:Create("Heading");

head:SetFullWidth(true);
selectTree:AddChild(head);

--Tooltip code
function displayTooltip(self, text)
	if self == nil then
		self = UIParent;
	end
	GameTooltip_SetDefaultAnchor(GameTooltip, WorldFrame);
	--GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
	GameTooltip:ClearAllPoints()
	--GameTooltip:SetMinimumWidth(256, 1);
	--GameTooltip:SetPoint("BOTTOM",nil,nil,0,0)
	GameTooltip:SetText(text, nil, nil, nil,  nil, 1)
	GameTooltip:Show()
end

function hideTooltip()
	GameTooltip:Hide()
end

-- Helper functions for one-line additions to the panel.
local function addHeader(text)
	local head = GUI:Create("Heading");
	head:SetText(text);
	head:SetFullWidth(true);
	selectTree:AddChild(head);
end

local function addButton(title, click)
	local button = GUI:Create("Button");
	button:SetText(title);
	button:SetCallback("OnClick", click);
	button:SetFullWidth(true);
	selectTree:AddChild(button);
end

local function addSlider(step, bigStep, min, max, name, desc, get, set)
	local slider = GUI:Create("Slider");
	slider:SetSliderValues(min, max, bigStep);
	slider:SetLabel(name);
	if get ~= nil then
		slider:SetValue(get());
	end
	slider:SetCallback("OnValueChanged", set);
	
	-- Strangely enough, OnMouseUp fires when the enter key is pressed.
	slider:SetCallback("OnMouseUp", function(self, name, value) set(self, name, value); slider:SetValue(value) end);
	slider:SetCallback("OnEnter", function() displayTooltip(slider.frame,desc) end);
	slider:SetCallback("OnLeave", function() hideTooltip() end);
	slider:SetFullWidth(true);
	selectTree:AddChild(slider);
	return slider;
end

local function addInput(name, desc, usage, set)
	local input = GUI:Create("EditBox");
	input:SetText(usage);
	input:SetLabel(name);
	--input:SetCallback("OnEnter", function() frame:SetStatusText(desc); end);
	--input:SetCallback("OnLeave", function() frame:SetStatusText(defaultStatus); end);
	input:SetCallback("OnEnter", function() displayTooltip(input.frame,desc) end);
	input:SetCallback("OnLeave", function() hideTooltip() end);
	input:SetCallback("OnEnterPressed", set);
	-- TODO: Tooltips
	--input:SetCallback("OnEnter", set);
	selectTree:AddChild(input);
end

local function addDropTarget(name, func)

	local dummyButton =  GUI:Create("DragDropTarget");
	if name == nil then
		error("NIL name!");
	end
	dummyButton:SetText(name);
	dummyButton:SetCallback("OnClick", func);
	dummyButton:SetCallback("OnReceiveDrag", func);
	dummyButton:SetCallback("OnMouseUp", func);
	selectTree:AddChild(dummyButton);
end

local function addCheckBox(name, desc, get, set, checkType)
	local box = GUI:Create("CheckBox");
	box:SetLabel(name);
--	box:SetCallback("OnEnter", function() frame:SetStatusText(desc) end);
--	box:SetCallback("OnLeave", function() frame:SetStatusText(defaultStatus) end);
	box:SetCallback("OnEnter", function() displayTooltip(box.frame,desc) end);
	box:SetCallback("OnLeave", function() hideTooltip() end);
	box:SetCallback("OnValueChanged", function(self,name,x) if x~= nil then set(x) else set(false) end end);
	
	if get~=nil then
		box:SetValue(get());
	end
	
	if checkType ~= nil then
		box:SetType(type);
	end
	
	-- Fill width to show all of the text.
	box:SetFullWidth(true);
	selectTree:AddChild(box);
end

local function addDisabledCheckBox(name, desc, get)
	local box = GUI:Create("CheckBox");
	box:SetLabel(name);
--	box:SetCallback("OnEnter", function() frame:SetStatusText(desc) end);
--	box:SetCallback("OnLeave", function() frame:SetStatusText(defaultStatus) end);
	box:SetCallback("OnEnter", function() displayTooltip(box.frame,desc) end);
	box:SetCallback("OnLeave", function() hideTooltip() end);
	--box:SetCallback("OnValueChanged", function(self,name,x) if x~= nil then set(x) else set(false) end end);
	
	if get~=nil then
		box:SetValue(get());
	end
	
	-- Fill width to show all of the text.
	box:SetFullWidth(true);
	
	-- Show as disabled
	box:SetDisabled(true);
	
	selectTree:AddChild(box);
end

local function addLabel(text)
	local label = GUI:Create("InteractiveLabel");
	label:SetText(text);
	label:SetFullWidth(true);
	selectTree:AddChild(label);
end

local function addCopyBox(labelText, text)
	local label = GUI:Create("EditBox");
	label:SetLabel(labelText);
	label:SetText(text);
	label:SetFullWidth(true);
	selectTree:AddChild(label);
end

--------------------------------------------------------------------------------

function loadShopping()
	-- create new frame.
	currentFrame = GUI:Create("BlizOptionsGroup", "Reagent Restocker");
	defaultStatus = "Change how Reagent Restocker shops";
	
	addHeader("Add to Shopping List");
	addInput("Type the item's name and hit enter",
		"Adds a new item to your Shopping List",
		"<reagent name>",
		function (x) ReagentRestocker:addItemToShoppingList(x); end);
		
	addHeader("Drag item into drop target.");
	addDropTarget("Stuff goes here.",
		function (x)
			local infoType, info1, info2 = _G.GetCursorInfo();
			if (infoType == "item") then
				ReagentRestocker:addToListByID(info1,0, "Buy");
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
			elseif(infoType == "merchant") then
				ReagentRestocker:addToListByID(getIDFromItemLink(_G.GetMerchantItemLink(info1)),0, "Buy");
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				showShoppingItem(getIDFromItemLink(_G.GetMerchantItemLink(info1)));
			else --getIDFromItemLink
				dprint("Unknown infoType")
				dprint("infoType: "..infoType)
				dprint("info1: "..info1)
				if info2 ~= nil then
					dprint("info2: "..info2)
				end
			end
		end);
		
	addHeader("Required Faction Reputation");
	addCheckBox("None",
		"Reagent Restocker will purchase Shopping List items from vendors regardless of reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 0) end,
		function (x) ReagentRestockerDB.Options.Reputation = 0 end,
		"radio");
	
	addCheckBox("Friendly",
		"Reagent Restocker will only purchase Shopping List items from vendors with a friendly (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 5) end,
		function (x) ReagentRestockerDB.Options.Reputation = 5 end,
		"radio");
	
	addCheckBox("Honored",
		"Reagent Restocker will only purchase Shopping List items from vendors with an honored (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 6) end,
		function (x) ReagentRestockerDB.Options.Reputation = 6 end,
		"radio");
	
	addCheckBox("Revered",
		"Reagent Restocker will only purchase Shopping List items from vendors with a revered (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 7) end,
		function (x) ReagentRestockerDB.Options.Reputation = 7 end,
		"radio");
	
	addCheckBox("Exalted",
		"Reagent Restocker will only purchase Shopping List items from vendors with an exalted (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 8) end,
		function (x) ReagentRestockerDB.Options.Reputation = 8 end,
		"radio");
		
	addHeader("Other shopping options");
	
	addCheckBox("Enable auto-shop",
		"Enables auto-shopping; if you turn this option off, Reagent Restocker will not purchase items automatically",
		function () return ReagentRestockerDB.Options.AutoBuy end,
		function (x) ReagentRestockerDB.Options.AutoBuy = x end);

	addCheckBox("Overstock",
		"If this option is disabled, Reagent Restocker will never stock more than the quantity you specify (otherwise, overstocking may occur when a vendor sells an item in stacks instead of one-by-one)",
		function () return not ReagentRestockerDB.Options.NotOverstock; end,
		function (x) ReagentRestockerDB.Options.NotOverstock = not x; end);
end

function showShopping()
	selectTree:ReleaseChildren();
	defaultStatus = "Change how Reagent Restocker shops";
	
	addHeader("Add to Shopping List");
	addInput("Type the item's name and hit enter",
		"Adds a new item to your Shopping List",
		"<reagent name>",
		function (x)
			if type(x)=="table" and type(x.lasttext) ~="nil" then
				-- Called from Ace, have to get text from a table.
				ReagentRestocker:addItemToShoppingList(x.lasttext);
			elseif type(x)=="string" then
				ReagentRestocker:addItemToShoppingList(x);
			else
				derror(x);
			end
		end);
		
	addHeader("Drag item into drop target.");
	addDropTarget("Stuff goes here.",
		function (x)
			dprint("Shopping drop action detected.")
			local infoType, info1, info2 = _G.GetCursorInfo();
			if (infoType == "item") then
				ReagentRestocker:addToListByID(info1,0, "Buy"); -- TODO: get drag and drop working!
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				showShoppingItem(info1);
			elseif(infoType == "merchant") then
				ReagentRestocker:addToListByID(getIDFromItemLink(_G.GetMerchantItemLink(info1)),0, "Buy");
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				showShoppingItem(getIDFromItemLink(_G.GetMerchantItemLink(info1)));
			else --getIDFromItemLink
				dprint("Unknown infoType")
				dprint("infoType: "..infoType)
				dprint("info1: "..info1)
				if info2 ~= nil then
					dprint("info2: "..info2)
				end
			end
		end);
		
	addHeader("Required Faction Reputation");
	addCheckBox("None",
		"Reagent Restocker will purchase Shopping List items from vendors regardless of reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 0) end,
		function (x) ReagentRestockerDB.Options.Reputation = 0 end);
	
	addCheckBox("Friendly",
		"Reagent Restocker will only purchase Shopping List items from vendors with a friendly (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 5) end,
		function (x) ReagentRestockerDB.Options.Reputation = 5 end);
	
	addCheckBox("Honored",
		"Reagent Restocker will only purchase Shopping List items from vendors with an honored (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 6) end,
		function (x) ReagentRestockerDB.Options.Reputation = 6 end);
	
	addCheckBox("Revered",
		"Reagent Restocker will only purchase Shopping List items from vendors with a revered (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 7) end,
		function (x) ReagentRestockerDB.Options.Reputation = 7 end);
	
	addCheckBox("Exalted",
		"Reagent Restocker will only purchase Shopping List items from vendors with a exalted (or better) reputation",
		function () return (ReagentRestockerDB.Options.Reputation == 8) end,
		function (x) ReagentRestockerDB.Options.Reputation = 8 end);
		
	addHeader("Other shopping options");
	
	addCheckBox("Enable auto-shop",
		"Enables auto-shopping; if you turn this option off, Reagent Restocker will not purchase items automatically",
		function () return ReagentRestockerDB.Options.AutoBuy end,
		function (x) ReagentRestockerDB.Options.AutoBuy = x end);

	addCheckBox("Overstock",
		"If this option is disabled, Reagent Restocker will never stock more than the quantity you specify (otherwise, overstocking may occur when a vendor sells an item in stacks instead of one-by-one)",
		function () return not ReagentRestockerDB.Options.NotOverstock; end,
		function (x) ReagentRestockerDB.Options.NotOverstock = not x; end);
		
	-----------------
	selectTree:RefreshTree();
end

function showSelling()
	selectTree:ReleaseChildren();
	defaultStatus = "Options for automatically selling items";
	
	addHeader("Add to Selling List");
	
	addInput("Type the item's name and hit enter",
		"Adds an item to your Selling List",
		"<reagent name>",
		function (x)
			if type(x)=="table" and type(x.lasttext) ~="nil" then
				-- Called from Ace, have to get text from a table.
				ReagentRestocker:addItemToSellingList(x.lasttext);
			elseif type(x)=="string" then
				ReagentRestocker:addItemToSellingList(x);
			else
				derror(x);
			end
		end);

	addHeader("Drag item into drop target.");
	addDropTarget("Stuff goes here.",
		function (x)
			local infoType, info1, info2 = _G.GetCursorInfo();
			if (infoType == "item") then
				ReagentRestocker:addToListByID(info1,-1, "Sell");
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				showSellingItem(info1);
			elseif(infoType == "merchant") then
				ReagentRestocker:addToListByID(getIDFromItemLink(_G.GetMerchantItemLink(info1)),-1, "Sell");
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				showSellingItem(getIDFromItemLink(_G.GetMerchantItemLink(info1)));
			else --getIDFromItemLink
				dprint("Unknown infoType")
				dprint("infoType: "..infoType)
				dprint("info1: "..info1)
				if info2 ~= nil then
					dprint("info2: "..info2)
				end
			end
		end);
		addHeader("Other selling options");
		
	addCheckBox("Sell items based on quality",
		"Do you want Reagent Restocker to automatically sell low quality items from your inventory?",
		function() return ReagentRestockerDB.Options.AutoSellQuality end,
		function(x) ReagentRestockerDB.Options.AutoSellQuality = x;
			if x==true then
				qualitySlider:SetDisabled(false);
			else
				qualitySlider:SetDisabled(true);
			end
		end);
		
	local qualityString = "";
	
	for i = 0, 7 do
	local r, g, b, hex = _G.GetItemQualityColor(i);
		qualityString = qualityString .. i .. "=|c" .. hex .. _G.getglobal("ITEM_QUALITY" .. i .. "_DESC") .. "|r|n";
	end
		
	qualitySlider = addSlider(1, 1, 0, 7, "Quality to sell", "Select which quality of items you wish to sell. |n|cFFFF7700WARNING:|r Many common items are useful!|r|n" .. qualityString,
		function() return ReagentRestockerDB.Options.AutoSellQualityLevel end,
		function(self, name, x) if type(x)~="number" then error("x must be a number!") end; ReagentRestockerDB.Options.AutoSellQualityLevel = x; end);

	addCheckBox("Sell unusable armor and weapons",
		"Do you want Reagent Restocker to automatically sell armor and weapons you can't use?",
		function() return ReagentRestockerDB.Options.AutoSellUnusable end,
		function(x) ReagentRestockerDB.Options.AutoSellUnusable = x end);
		
	unusableQualitySlider = addSlider(1, 1, 0, 7, "Maximum unusable quality to sell", "Sell unusables at or below this quality.|r|n" .. qualityString,
		function() return ReagentRestockerDB.Options.UnusableQualityLevel end,
		function(self, name, x) if type(x)~="number" then error("x must be a number!") end; ReagentRestockerDB.Options.UnusableQualityLevel = x; end);

	addDisabledCheckBox("Keep bind on equip items",
		"DISABLED UNTIL FIXED. Prevent Reagent Restocker from selling items marked as " .. _G.ITEM_BIND_ON_EQUIP,
--		function() return ReagentRestockerDB.Options.KeepBindOnEquip end,
		function() return false end,
		function(x) ReagentRestockerDB.Options.KeepBindOnEquip = x end);

	addDisabledCheckBox("Keep soulbound items",
		"DISABLED UNTIL FIXED. Prevent Reagent Restocker from selling items marked as " .. _G.ITEM_SOULBOUND,
--		function() return ReagentRestockerDB.Options.KeepSoulbound end,
		function() return false end,
		function(x) ReagentRestockerDB.Options.KeepSoulbound = x end);

		
	-- Sell food/water. If Periodic Table is loaded, we can distinguish between the two.
	if PT ~= nil then
		addCheckBox("Sell food",
			"Do you want Reagent Restocker to automatically sell food?",
			function() return ReagentRestockerDB.Options.AutoSellFood end,
			function(x) ReagentRestockerDB.Options.AutoSellFood = x end);
		
		addCheckBox("Sell water",
			"Do you want Reagent Restocker to automatically sell water?",
			function() return ReagentRestockerDB.Options.AutoSellWater end,
			function(x) ReagentRestockerDB.Options.AutoSellWater = x end);
	else
		addCheckBox("Sell food and water",
			"Do you want Reagent Restocker to automatically sell food and water?|n|nInstall the Periodic Table library to get separate options for food and water.",
			function() return ReagentRestockerDB.Options.AutoSellFoodWater end,
			function(x) ReagentRestockerDB.Options.AutoSellFoodWater = x end);
	end
		
	addCheckBox("Destroy unsellable gray items",
		"Destroys gray items that can't be sold.\nWARNING: Destroyed items cannot be recovered!",
		function() return ReagentRestockerDB.Options.AutoDestroyGrays end,
		function(x) ReagentRestockerDB.Options.AutoDestroyGrays = x end);

	addCheckBox("Enable auto-sell",
		"Enable auto-selling; if you turn this option off, Reagent Restocker will not sell items automatically.",
		function () return ReagentRestockerDB.Options.AutoSell end,
		function (x) ReagentRestockerDB.Options.AutoSell = x end);
end

function showExclusion()
	selectTree:ReleaseChildren();
	defaultStatus = "Exclude items you don't want to sell/buy";
	addHeader("Add to Exceptions List");
		addDropTarget("Stuff goes here.",
		function (x)
			local infoType, info1, info2 = _G.GetCursorInfo();
			if (infoType == "item") then
				ReagentRestocker:addItemToList(info1,"Exception");
			--	ReagentRestocker:addToListByID(info1,-1);
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				--showListItem(excludeList[info1].itemID, "Exception");
			elseif(infoType == "merchant") then
				ReagentRestocker:addItemToList(getIDFromItemLink(_G.GetMerchantItemLink(info1)),"Exception");
				_G.ClearCursor();
				refreshShoppingList();
				selectTree:RefreshTree();
				--showShoppingItem(getIDFromItemLink(_G.GetMerchantItemLink(info1)));
			else --getIDFromItemLink
				dprint("Unknown infoType")
				dprint("infoType: "..infoType)
				dprint("info1: "..info1)
				if info2 ~= nil then
					dprint("info2: "..info2)
				end
			end
		end);
end

function showBank()
	selectTree:ReleaseChildren();
	defaultStatus = "Options for interacting with your bank";

	addCheckBox("Stock items from bank",
		"Pulls items on your Shopping List from your bank if you need them",
		function () return ReagentRestockerDB.Options.PullFromBank end,
		function (x) ReagentRestockerDB.Options.PullFromBank = x end);

	addCheckBox("Overstock to bank",
		"Puts 'extra' Shopping List items (i.e., more than the quantity you keep stocked) into your bank",
		function() return ReagentRestockerDB.Options.OverstockToBank end,
		function(x) ReagentRestockerDB.Options.OverstockToBank = x end);

	addCheckBox("Stock items from guild bank",
		"Pulls items on your Shopping List from your guild bank if you need them",
		function () return ReagentRestockerDB.Options.PullFromGuildBank end,
		function (x) ReagentRestockerDB.Options.PullFromGuildBank = x end);

	addCheckBox("Overstock to guild bank",
		"Puts 'extra' Shopping List items (i.e., more than the quantity you keep stocked) into your guild bank",
		function() return ReagentRestockerDB.Options.OverstockToGuildBank end,
		function(x) ReagentRestockerDB.Options.OverstockToGuildBank = x end);

end

function showRepair()
	selectTree:ReleaseChildren();
	defaultStatus = "Options for repairing";
	
	addCheckBox("Auto-repair",
		"Automatically repair your gear when you visit a repair-able vendor",
		function () return ReagentRestockerDB.Options.AutoRepair end,
		function (x) ReagentRestockerDB.Options.AutoRepair = x end);
		
	addCheckBox("Use guild bank funds",
		"Use guild bank funds when auto-repairing, if possible",
		function() return ReagentRestockerDB.Options.UseGuildBankFunds end,
		function(x) ReagentRestockerDB.Options.UseGuildBankFunds = x end);
		
	addCheckBox("Require discount (see Shopping options)",
		"Only repair if the repair vendor meets the required vendor discounts (as chosen in the Shopping options)",
		function() return ReagentRestockerDB.Options.RepairDiscount end,
		function(x) ReagentRestockerDB.Options.RepairDiscount = x end);
end

function showMisc()
	selectTree:ReleaseChildren();
	defaultStatus = "Other Reagent Restocker options";
	
	addCheckBox("Quiet mode",
		"Disable Reagent Restocker messages",
		function() return ReagentRestockerDB.Options.QuietMode end,
		function(x) ReagentRestockerDB.Options.QuietMode = x end);

	addCheckBox("Single LDB item (Requires UI reload)",
		"Reduces LDB to one button, instead of one button per item. Requires UI reload.",
		function() return ReagentRestockerDB.Options.SingleLDB end,
		function(x) ReagentRestockerDB.Options.SingleLDB = x; end);

	addCheckBox("LDB: Use text instead of label",
		"Uses LDB's text for everything instead of a separate label. Useful for some brokers like NinjaPanel.",
		function() return ReagentRestockerDB.Options.UseTextLDB end,
		function(x) ReagentRestockerDB.Options.UseTextLDB = x; addonTable:updateLDB(); end);

	addCheckBox("Low reagent warning",
		"Show a warning when you don't have enough of an item.",
		function() return ReagentRestockerDB.Options.ReagentWarning end,
		function(x) ReagentRestockerDB.Options.ReagentWarning = x end);

	addCheckBox("Automatically upgrade water",
		"If you're buying water, will automatically upgrade water to the best.",
		function() return ReagentRestockerDB.Options.UpgradeWater end,
		function(x) ReagentRestockerDB.Options.UpgradeWater = x; addonTable:updateLDB(); end);

	addCheckBox("Use global cache (will increase memory usage)",
		"Keeps a global cache of discovered items, allowing user to add any discovered items to lists.",
		function() return RRGlobal.Options.UseCache end,
		function(x) RRGlobal.Options.UseCache = x
			if RRGlobal.Options.UseCache==false then
				RRGlobal.ItemCache={} -- Clear the cache if the user doesn't want to use it.
			end
		end);

	addCheckBox("Disable new UI",
		"Disables the new vendor UI. Note that the new UI will be improving over time; this is not final.",
		function() return ReagentRestockerDB.Options.DisableNewUI end,
		function(x) ReagentRestockerDB.Options.DisableNewUI = x; end);
		
	addCheckBox("Enable debug logging",
		"Enables debug logging. Will spam your chat!",
		function() return ReagentRestockerDB.Options.Debug end,
		function(x) ReagentRestockerDB.Options.Debug = x; debugRR = x; addonTable.debugRR = x; end);

	addCheckBox("Check database on next login",
		"Checks the database for inconsistencies and removes inconsistent items on next login.",
		function() return ReagentRestockerDB.Options.CheckData end,
		function(x) ReagentRestockerDB.Options.CheckData = x; end);
		

	if dbIcon then
		addCheckBox("Add minimap icon",
			"Shows an icon on the minimap for Reagent Restocker.",
			function() return ReagentRestockerDB.Options.MapIcon end,
			function(x)
				ReagentRestockerDB.Options.MapIcon = x;
				if dbIcon and ReagentRestockerDB.Options.MapIcon then
					print("Icon lib found")
					dbIcon:Show("Reagent Restocker");
				elseif dbIcon then
					print("Icon lib found")
					dbIcon:Hide("Reagent Restocker");
				else
					print("Icon lib NOT found")
				end
			end);
	else
		addCopyBox("Install LibDBIcon to show an icon on the minimap. ","http://wow.curse.com/downloads/wow-addons/details/libdbicon-1-0.aspx\n");
	end

	addCheckBox("Auto-populate Selling List (|cFFFF7700May cause lag|r)",
		"|cFFFF7700WARNING:|r Long lists can cause lag, not recommended anymore.|n|nWith this option enabled, Reagent Restocker will watch what items you sell to the vendor and automatically add them to the Selling List.",
		function() return ReagentRestockerDB.Options.AutoPopulate end,
		function(x) ReagentRestockerDB.Options.AutoPopulate = x end);
	
--	addCheckBox("Debug",
--		"Turns on debug info.",
--		function() return ReagentRestockerDB.Options.Debug end,
--		function(x) ReagentRestockerDB.Options.Debug = x; debugRR=x end);
--	addButton("Toggle new UI", function() merchantFrame:ToggleHide() end)
end

function showProfiles(text)
	--dprint(RRAceDB)
			
	-- Load the profile names
	profileNames = {}
	
	for k, v in pairs(RRAceDB:GetProfiles()) do
		profileNames[v] = v
	end
	
	--RRAceDB:GetProfiles(profileNames)

	-- UI setup
	selectTree:ReleaseChildren()
	defaultStatus = "Profiles";

	if text ~= nil then
		addLabel(text .. "\n")
	end
	
	addLabel("Note that |cFFFFFF00default|r is always overwritten when the game is realoaded, do not use for shared profiles!")

	addLabel("|nProfiles are currently not saved automatically - you have to manually save them.")
	
	addLabel("|nCurrent profile is: " .. RRAceDB:GetCurrentProfile());
	
	addInput("Save to profile: ", "Name of profile to save to", "", 
		function(x)
			if type(x)=="table" and type(x.lasttext) ~="nil" then
				-- Called from Ace, have to get text from a table.
				x = x.lasttext
				--RRAceDB.profile[x] = ReagentRestockerDB;
			elseif type(x)=="string" then
				--RRAceDB.profile[x] = ReagentRestockerDB;
			else
				derror(x);
			end
			--dprint(x)
			RRAceDB:SetProfile(x)
			
			-- 
			if profileNames[x] == nil then
				-- If the profile doesn't already exist, create a new one by copying the old one.
				RRAceDB.profile.db = deepcopy(ReagentRestockerDB)
			else
				RRAceDB.profile.db = ReagentRestockerDB
			end
			showProfiles("|cFFFFFF00Profile |r".. x .." |cFFFFFF00saved.|r");
			refreshShoppingList();
			selectTree:RefreshTree();
		end)

		
	addLabel("Select an active profile (NOTE: Profiles are not automatically saved yet)")
	local profileSelect = GUI:Create("Dropdown")
	profileSelect:SetList(profileNames)
	profileSelect:SetText("Select a profile")
	profileSelect:SetCallback("OnValueChanged",
		function(key)
			if key.value == RRAceDB:GetCurrentProfile() then
				showProfiles("|cFFFF0000The current profile is already loaded.|r")
			else
				RRAceDB:SetProfile(key.value)
				ReagentRestockerDB = RRAceDB.profile.db
				showProfiles("|cFFFFFF00Profile |r".. key.value .." |cFFFFFF00loaded.|r")
				refreshShoppingList();
				selectTree:RefreshTree();
			end
		end)
	selectTree:AddChild(profileSelect)

	--addLabel("Load from profile")
	--local profileLoad = GUI:Create("Dropdown")
	--profileLoad:SetList(profileNames)
	--profileLoad:SetText("Select a profile")
	--profileLoad:SetCallback("OnValueChanged",function(key) ReagentRestockerDB = RRAceDB.profile[key.value]; showProfiles("|cFFFFFF00Profile |r".. key.value .." |cFFFFFF00loaded.|r"); end)
	--selectTree:AddChild(profileLoad)
	
	addLabel("|nRemove profile |cFFFF0000(WARNING: Currently does not ask for confirmation!)|r")
	local profileRemove = GUI:Create("Dropdown")
	profileRemove:SetList(profileNames)
	profileRemove:SetText("Select a profile")
	profileRemove:SetCallback("OnValueChanged",
		function(key)
			--dprint(key)
			RRAceDB:DeleteProfile(key.value)
			--RRAceDB.profile[key.value] = nil
			showProfiles("|cFFFF0000Profile |r".. key.value .." |cFFFF0000removed.|r");
		end)
		
	selectTree:AddChild(profileRemove)

end

function showAbout()
	selectTree:ReleaseChildren();
	addLabel("Reagent Restocker version " .. GetAddOnMetadata(addonName, "Version") .. "\n");
	addLabel("Author: " .. GetAddOnMetadata(addonName, "Author") .. "\n");
	addLabel("Thanks to " .. GetAddOnMetadata(addonName, "X-Credits") .. " for the creation of and contributions to this addon.\n");
	addLabel("License: " .. GetAddOnMetadata(addonName, "X-License") .. "\n");
	addCopyBox("Website: ",GetAddOnMetadata(addonName, "X-Website") .. "\n");
	addCopyBox("Google+: ","https://plus.google.com/101127866821396020019" .. "\n");
	addCopyBox("Facebook: ","https://www.facebook.com/ReagentRestocker" .. "\n");
	addCopyBox("Bug reports and feature requests: ",GetAddOnMetadata(addonName, "X-Bugs") .. "\n");

	local version, build, date, tocversion = GetBuildInfo();
	addLabel("\nDesigned for UI version " .. GetAddOnMetadata(addonName, "X-Interface") .. ", current UI version is " .. tostring(tocversion) .. ".\n");
	
	--local function addButton("Test", click)
end

function showGlobals()
	selectTree:ReleaseChildren();
	addCheckBox("Use global cache",
		"Keeps a global cache of discovered items, allowing user to add any discovered items to lists (will increase memory usage).",
		function() return RRGlobal.Options.UseCache end,
		function(x) RRGlobal.Options.UseCache = x
			if RRGlobal.Options.UseCache==false then
				RRGlobal.ItemCache={} -- Clear the cache if the user doesn't want to use it.
			end
		end);
end

function showReceipts()
	selectTree:ReleaseChildren();
	addLabel("Not implemented yet! Will show previous receipts.")
	addCheckBox("Record receipts",
		"Records previous receipts (will increase memory usage).",
		function() return ReagentRestockerDB.Options.KeepReceipts end,
		function(x) ReagentRestockerDB.Options.KeepReceipts = x end);
end
--------------------------------------------------------------------------------
function refreshShoppingList()
	for k, v in pairs(shopList) do
		shopList[k]=nil
	end
	for k, v in pairs(sellList) do
		sellList[k]=nil
	end
	for k, v in pairs(excludeList) do
		excludeList[k]=nil
	end
	
	if ReagentRestockerDB==nil then
		error("Database not found!");
	end
	
	local shopNum=1;
	local sellNum=1;
	local excludeNum=1;
	for k, v in pairs(ReagentRestockerDB.Items) do
		local info = ReagentRestocker:safeGetItemInfo(k);
		--jprint(v["0"]);
		--jprint("shopList["..num.."].text="..v.item_name);
		if hasTag(k,"Exception") then
			excludeList[excludeNum]={};
			excludeList[excludeNum].value=excludeNum;
			excludeList[excludeNum].text=v.item_name;
			excludeList[excludeNum].icon=v["9"];
			excludeList[excludeNum].itemID=k;
			excludeNum=excludeNum+1;
		elseif hasTag(k,"Buy") then
			shopList[shopNum]={};
			shopList[shopNum].value=shopNum;
			shopList[shopNum].text=v.item_name;
			shopList[shopNum].icon=v["9"];
			shopList[shopNum].itemID=k;
			shopNum=shopNum+1;
		elseif hasTag(k, "Sell") then
			sellList[sellNum]={};
			sellList[sellNum].value=sellNum;
			sellList[sellNum].text=v.item_name;
			sellList[sellNum].icon=v["9"];
			sellList[sellNum].itemID=k;
			sellNum=sellNum+1;
		end

	end
	table.sort(shopList, function(x, y) return x.text < y.text end);
	num=1;
	for k, v in pairs(shopList) do
		shopList[num].value=num;
		num = num + 1;
	end
	
	table.sort(sellList, function(x, y) return x.text < y.text end);
	num=1;
	for k, v in pairs(sellList) do
		sellList[num].value=num;
		num = num + 1;
	end

	table.sort(excludeList, function(x, y) return x.text < y.text end);
	num=1;
	for k, v in pairs(excludeList) do
		excludeList[num].value=num;
		num = num + 1;
	end

	--Menu[1].
end

-- Show menu for individual item in shopping list.
function showShoppingItem(item)
	selectTree:ReleaseChildren();
	defaultStatus = "Adjust shopping options for this item.";
	local itemName, _, _, _, _, _, _, itemStackCount, _, itemTexture = ReagentRestocker:safeGetItemInfo(item);
	
	addHeader(ReagentRestockerDB.Items[item].item_name);
	
	addSlider(
		ceil(itemStackCount/20),
		itemStackCount,
		0,
		maxFromSC(itemStackCount),
		"Stock how many?",
		"Number of items to keep in stock.",
		function()
			return ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK];
		end,
		function(self, name, x) if type(x)~="number" then error("x must be a number!") end; ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK] = x; end
	);
	
	addSlider(
		ceil(itemStackCount/20),
		floor(itemStackCount/4),
		0,
		maxFromSC(itemStackCount),
		"Low item warning",
		"When at or below this number, give a warning to the player.",
		function()
			if type(ReagentRestockerDB.Items[item][LOW_WARNING]) == "nil" then
				ReagentRestockerDB.Items[item][LOW_WARNING] = ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK]
			end
			
			if ReagentRestockerDB.Items[item][LOW_WARNING] > ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK] then
				ReagentRestockerDB.Items[item][LOW_WARNING] = ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK]
			end
			return ReagentRestockerDB.Items[item][LOW_WARNING];
		end,
		function(self, name, x)
			if type(x)~="number" then error("x must be a number!") end;
			ReagentRestockerDB.Items[item][LOW_WARNING] = x;
			if ReagentRestockerDB.Items[item][LOW_WARNING] > ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK] then
				ReagentRestockerDB.Items[item][LOW_WARNING] = ReagentRestockerDB.Items[item][QUANTITY_TO_STOCK]
			end
			--ReagentRestocker:synchronizeOptionsTable();
		end
	);
	
	addButton("Remove item from Shopping list", function()
		ReagentRestocker:removeItemFromList(item);
		dataobj=nil;
		refreshShoppingList();
		selectTree:RefreshTree();
		-- Clear UI
		selectTree:ReleaseChildren();
		
		-- Display the default shopping UI again.
		showShopping()
	end);
end

function showSellingItem(item)
	selectTree:ReleaseChildren();
	defaultStatus = "Adjust selling options for this item.";

	addHeader(ReagentRestockerDB.Items[item].item_name);
	addButton("Remove item from Selling list", function()
		ReagentRestocker:removeItemFromList(item);
		dataobj=nil;
		refreshShoppingList();
		selectTree:RefreshTree();
		-- Clear UI
		selectTree:ReleaseChildren();
		
		-- Display the default selling UI again.
		showSelling()
	end);
end

-- TODO: This currently just deletes it from all lists.
function showListItem(item, list)
	selectTree:ReleaseChildren();
	defaultStatus = string.format("Adjust %s options for this item.", list);
	
	addHeader(ReagentRestockerDB.Items[item].item_name);
	addButton(string.format("Remove item from %s list", list), function()
		ReagentRestocker:removeItemFromList(item, list);
		dataobj=nil;
		refreshShoppingList();
		selectTree:RefreshTree();
		-- Clear UI
		selectTree:ReleaseChildren();
	end);
	
--	if list == "Exception" then
--		addCheckBox("Never sell this item.",
--			"Prevents selling this item",
--			function() return ReagentRestockerDB.Items[item].neverSell end,
--			function(x) ReagentRestockerDB.Items[item].neverSell = x end);
--	end
end


selectTree:SetCallback("OnGroupSelected",
	function(_widget, nothing, group)
		if group == "shop" then
			showShopping();
		elseif group=="sell" then
			showSelling();
		elseif group == "exclude" then
			showExclusion();
		elseif group=="bank" then
			showBank();
		elseif group=="repair" then
			showRepair();
		elseif group=="misc" then
			showMisc();
		elseif group=="profiles" then
			showProfiles();
		elseif group=="global" then
			showGlobals();
		elseif group=="receipts" then
			showReceipts();
		elseif group=="about" then
			showAbout();
		elseif string.find(group, "^shop\001") then
			-- dynamically created list, get item number.
			number = tonumber(string.sub(group,6));
			-- Display menu
			showShoppingItem(shopList[number].itemID);
			
		elseif string.find(group, "^sell\001") then
			-- dynamically created list, get item number.
			number = tonumber(string.sub(group,6));
			showSellingItem(sellList[number].itemID);
		elseif string.find(group, "^exclude\001") then
			-- dynamically created list, get item number.
			number = tonumber(string.sub(group,9));
			showListItem(excludeList[number].itemID, "Exception");
		else
				addInput("Type the item's name and hit enter",
			"Adds an item to your Selling List",
			group,
			function (x) ReagentRestocker:addItemToSellingList(x); end);
		end
		
		--print(group);
		--rprint(3,Menu);
		--shopshop1
		
		-- Refresh shopping/selling lists
		refreshShoppingList();
		selectTree:RefreshTree();
		
		-- add some filler to the height so it's not ridiculously small.
		filler = GUI:Create("SimpleGroup");
		filler:SetLayout("Fill");
		filler:SetFullWidth(true);
		filler:SetFullHeight(true);
		selectTree:AddChild(filler);

	end
)

selectTree:RefreshTree();


myGroup:AddChild(selectTree);

bFrame:AddChild(myGroup);
frame:AddChild(myGroup);

bFrame.frame.refresh = function()
	dprint("Showing frame");
	--ReagentRestocker:synchronizeOptionsTable();
	refreshShoppingList();
	selectTree:RefreshTree();
	showShopping();
	myGroup:AddChild(selectTree);
	bFrame:AddChild(myGroup);
end

InterfaceOptions_AddCategory(bFrame.frame);
dprint("WoW addon should be added.");

function ReagentRestocker:hideFrame()
	frame:Hide();
end

function ReagentRestocker:showFrame()
	if firstTime == true then
		showShopping();
		firstTime = false;
	end

	dprint("Showing frame");
	refreshShoppingList();
	selectTree:RefreshTree();
	frame:AddChild(myGroup);
	myGroup:AddChild(selectTree);
	frame:Show();
end

menuu= createNewMenu(frame);

firstTime = true;
frame:Hide();

dprint("UI.lua loaded");
--dprint(type(RRTooltip))
addonTable.RRTooltip=RRTooltip;
setfenv(1, oldEnv);
ReagentRestockerDB=addonTable.ReagentRestockerDB
RRGlobal=addonTable.RRGlobal



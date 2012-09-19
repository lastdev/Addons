--===============--
-- Database load --
--===============--


local addonName, addonTable = ...;
local oldEnv = getfenv();
setfenv(1,addonTable);

-- Helper method to fix a database problem: Apparently, some previous versions
-- put a table in where there should be a boolean - which works, but
-- blows up the file size and affects the load time.
function ReagentRestocker:fixBoolean(var)
	if type(var)=="table" then
		return true;
	else
		return var;
	end
end

-- Maximum database version.
ReagentRestocker.maxVer = 14;

function ReagentRestocker:loadDB()

	dprint("Upgrading database.");

	setfenv(1, oldEnv)
	
	-- Activate debugging, if neccesary.
	if ReagentRestockerDB and ReagentRestockerDB.Options.Debug ~= nil and ReagentRestockerDB.Options.Debug == true then
		debugRR=true;
	else
		debugRR=false;
	end
	
	-- Initialize variables.
	if not ReagentRestockerDB then
		--dprint("New database.");
		ReagentRestockerDB = {}
		ReagentRestockerDB.Options = {}
		ReagentRestockerDB.Options.UnusedNotification = true
		ReagentRestockerDB.Options.AutoBuy = true
		ReagentRestockerDB.Options.AutoSell = true
		ReagentRestockerDB.Options.Reputation = 0
		ReagentRestockerDB.Options.UseTextLDB = false
		ReagentRestockerDB.Options.SingleLDB = true
		ReagentRestockerDB.Options.ReagentWarning = true
		ReagentRestockerDB.Options.AutoSellQuality = false
		ReagentRestockerDB.Options.AutoSellQualityLevel = 0
		ReagentRestockerDB.Options.AutoDestroyGrays = false
		ReagentRestockerDB.Options.AutoSellUnusable = false
		ReagentRestockerDB.Options.AutoSellFood = false
		ReagentRestockerDB.Options.AutoSellWater = false
		ReagentRestockerDB.Options.AutoSellFoodWater = false
		ReagentRestockerDB.Options.PullFromBank = false
		ReagentRestockerDB.Options.OverstockToBank = false
		ReagentRestockerDB.Options.PullFromGuildBank = false
		ReagentRestockerDB.Options.OverstockToGuildBank = false
		ReagentRestockerDB.Options.UnusableQualityLevel = 7
		ReagentRestockerDB.Options.KeepReceipts = false
		ReagentRestockerDB.Options.MapIcon = false -- Icon on map
		ReagentRestockerDB.Options.UpgradeWater = false
		ReagentRestockerDB.Options.DisableNewUI = false
		ReagentRestockerDB.Options.Debug = false
		ReagentRestockerDB.MapTable = {} -- Info for icon on map
		ReagentRestockerDB.MapTable.hide = true
		ReagentRestockerDB.Items = {}
		ReagentRestockerDB.Tags = {}
		ReagentRestockerDB.Version = GetAddOnMetadata(addonName, "Version");
		
		-- Database version, so I don't have to parse the addon's version, which is a string.
		ReagentRestockerDB.DataVersion = 14;
	end
	
	-- Initialize global table, which has its own versioning independent of per-character versioning.
	if not RRGlobal then
		RRGlobal={}	
		RRGlobal.ItemCache={}
		RRGlobal.Chars={}
		RRGlobal.Options={}
		RRGlobal.Options.UseCache = false;
		RRGlobal.Options.Version = GetAddOnMetadata(addonName, "Version");
		RRGlobal.Options.DataVersion = 0;
	end

	
	-- Initialize variables new to 2.0.
	if ReagentRestockerDB.DataVersion == nil then
		ReagentRestockerDB.Options.UseTextLDB = false
		ReagentRestockerDB.Options.SingleLDB = true
		ReagentRestockerDB.Version = GetAddOnMetadata(addonName, "Version");
		ReagentRestockerDB.version = nil;
		ReagentRestockerDB.DataVersion = 1;
	end
	
	-- Add LOW_WARNING to items
	if ReagentRestockerDB.DataVersion == 1 then
		for k, v in pairs(ReagentRestockerDB["Items"]) do
			if ReagentRestockerDB["Items"][k]["qty"] >= 0 then
				ReagentRestockerDB["Items"][k]["low_warning"] = ReagentRestockerDB["Items"][k]["qty"];
			end
		end
		ReagentRestockerDB.DataVersion = 2;
	end
	
	-- Add option to disable low reagent warnings.
	if ReagentRestockerDB.DataVersion == 2 then
		ReagentRestockerDB.Options.ReagentWarning = true
		ReagentRestockerDB.DataVersion = 3;
	end
	
	-- Add LOW_WARNING to ALL items
	if ReagentRestockerDB.DataVersion == 3 then
		for k, v in pairs(ReagentRestockerDB["Items"]) do
			if type(ReagentRestockerDB["Items"][k]["low_warning"]) == "nil" then
				ReagentRestockerDB["Items"][k]["low_warning"] = 0;
			end
		end
		ReagentRestockerDB.DataVersion = 4;
	end
	
	if ReagentRestockerDB.DataVersion == 4 then
		-- Make absolutely sure we have the tags database.
		if ReagentRestockerDB.Tags == nil then
			ReagentRestockerDB.Tags = {}
		end
		
		-- Make sure all items have tags
		for k, v in pairs(ReagentRestockerDB["Items"]) do
			if type(ReagentRestockerDB["Items"][k]["tags"]) == "nil" then
				ReagentRestockerDB["Items"][k]["tags"] = {}
			end
		end
		ReagentRestockerDB.DataVersion = 5;
	end
	
	-- Add option to disable low reagent warnings.
	if ReagentRestockerDB.DataVersion == 5 then
		ReagentRestockerDB.Options.AutoDestroyGrays = false
		ReagentRestockerDB.DataVersion = 6;
	end

	-- Add option to sell unusable armor.
	if ReagentRestockerDB.DataVersion == 6 then
		ReagentRestockerDB.Options.AutoSellUnusable = false
		ReagentRestockerDB.DataVersion = 7;
	end

	-- Add selling based on quality level, food, or water.
	if ReagentRestockerDB.DataVersion == 7 then
		ReagentRestockerDB.Options.AutoSellQuality = ReagentRestockerDB.Options.AutoSellGrays;
		ReagentRestockerDB.Options.AutoSellQualityLevel = 0;
		ReagentRestockerDB.Options.AutoSellGrays = nil;
		ReagentRestockerDB.Options.AutoSellFood = false;
		ReagentRestockerDB.Options.AutoSellWater = false;
		ReagentRestockerDB.Options.AutoSellFoodWater = false;
		ReagentRestockerDB.DataVersion = 8;
	end
	
	-- Add options to prevent selling BoE, Soulbound, etc.
	if ReagentRestockerDB.DataVersion == 8 then
		ReagentRestockerDB.Options.KeepBindOnEquip = false
		ReagentRestockerDB.Options.KeepSoulbound = false
		ReagentRestockerDB.Options.KeepReceipts = false
		ReagentRestockerDB.DataVersion = 9;
	end
	
	-- Finally moving to tag library.
	if ReagentRestockerDB.DataVersion == 9 then
	
		addonTable.ReagentRestockerDB=ReagentRestockerDB
		ReagentRestockerDB.Options.MapIcon = false
		ReagentRestockerDB.MapTable = {}
		ReagentRestockerDB.MapTable.hide = true
		
		-- Strangely enough, these options weren't set by default?
		if ReagentRestockerDB.Options.PullFromBank == nil then
			ReagentRestockerDB.Options.PullFromBank = false
		end
		if ReagentRestockerDB.Options.OverstockToBank == nil then
			ReagentRestockerDB.Options.OverstockToBank = false
		end
		
		-- These are new.
		ReagentRestockerDB.Options.PullFromGuildBank = false
		ReagentRestockerDB.Options.OverstockToGuildBank = false

		
		for k, v in pairs(ReagentRestockerDB["Items"]) do
			if ReagentRestockerDB["Items"][k]["tags"] == nil and ReagentRestockerDB["Items"][k]["tags"]["Exception"] == nil then
				if ReagentRestockerDB.Items[k]["qty"]~=nil and ReagentRestockerDB.Items[k]["qty"] > -1 then
					addonTable.tagObject("Buy", k) -- shopping list
				elseif ReagentRestockerDB.Items[k]["qty"]~=nil then
					addonTable.tagObject("Sell", k) -- selling list
				end
			end
			
			-- Also, begin keeping track of WoW version for detecting item changes. If we don't know the toc version, we'll set it as 0.
			if ReagentRestockerDB["Items"][k]["tocversion"] == nil then
				ReagentRestockerDB["Items"][k]["tocversion"] = 0
			end
		end
		
		ReagentRestockerDB.DataVersion = 10;
	end
	
	-- Slowly but surely moving away from using numbers as names in the database.
	if ReagentRestockerDB.DataVersion == 10 then
	
		ReagentRestockerDB.Options.UpgradeWater = false
		for k, v in pairs(ReagentRestockerDB["Items"]) do
			if v["0"]~=nil then
				v.item_name=v["0"]
				v["0"]=nil
			end
		end
		
		-- Move items in cache to names as well.
		for k, v in pairs(RRGlobal["ItemCache"]) do
			if v["0"]~=nil then
				v.item_name=v["0"]
				v["0"]=nil
			end
		end

		ReagentRestockerDB.DataVersion = 11;
	end
	
	-- Replace discount with reputation.
	if ReagentRestockerDB.DataVersion == 11 then
		ReagentRestockerDB.Options.Reputation = ReagentRestockerDB.Options.RequiredDiscount / 5 + 4; -- The discount was always based on reputation anyways. 
		ReagentRestockerDB.Options.RequiredDiscount = nil;
		ReagentRestockerDB.DataVersion = 12;
	end
	
	
		-- BoE, Soulbound, aren't gonna happen. Instead, limit what is automatically sold by item quality.
	if ReagentRestockerDB.DataVersion == 12 then
		ReagentRestockerDB.Options.KeepBindOnEquip = nil
		ReagentRestockerDB.Options.KeepSoulbound = nil
		ReagentRestockerDB.Options.UnusableQualityLevel = 7
		ReagentRestockerDB.DataVersion = 13;
	end
	
	if ReagentRestockerDB.DataVersion == 13 then
		ReagentRestockerDB.Options.DisableNewUI = false
		ReagentRestockerDB.Options.Debug = false
		ReagentRestockerDB.DataVersion = 14
	end
	
	-- Fix any nil quantities.
	--for k, v in pairs(ReagentRestockerDB["Items"]) do
	--	if ReagentRestockerDB["Items"][k]["tags"]["Buy"] ~= nil then
	--		if ReagentRestockerDB.Items[k]["qty"]==nil then
	--			ReagentRestockerDB.Items[k]["qty"] = 0
	--		end
	--	end
	--end
	
	-- Fix any booleans that became tables.
	ReagentRestockerDB.Options.UnusedNotification = ReagentRestocker:fixBoolean(ReagentRestockerDB.Options.UnusedNotification)
	ReagentRestockerDB.Options.AutoBuy = ReagentRestocker:fixBoolean(ReagentRestockerDB.Options.AutoBuy)
	ReagentRestockerDB.Options.AutoSell = ReagentRestocker:fixBoolean(ReagentRestockerDB.Options.AutoSell)
	ReagentRestockerDB.Options.UseTextLDB = ReagentRestocker:fixBoolean(ReagentRestockerDB.Options.UseTextLDB)
	ReagentRestockerDB.Options.SingleLDB = ReagentRestocker:fixBoolean(ReagentRestockerDB.Options.SingleLDB)
	ReagentRestockerDB.Options.ReagentWarning = ReagentRestocker:fixBoolean(ReagentRestockerDB.Options.ReagentWarning)
		
	addonTable.dprint("Database upgraded.")
	addonTable.dprint(addonName .. " version: " .. ReagentRestockerDB.Version);
	addonTable.dprint(addonName .. " database version: " .. ReagentRestockerDB.DataVersion);


	-- Load RR's version from the TOC file.
	ReagentRestockerDB.Version = GetAddOnMetadata(addonName, "Version");
	
	addonTable.ReagentRestockerDB = ReagentRestockerDB
	addonTable.RRGlobal=RRGlobal
	
	setfenv(1, addonTable)
	
	ReagentRestocker:notifyPlayer()
	
	-- Init tags.
	if debugRR then
		tagsInit();
	end
	
	fixTags()
	
end

function ReagentRestocker:VARIABLES_LOADED()

	if oldEnv.ReagentRestockerDB == nil then
		-- load the database and update if needed.
		print("Reagent Restocker: No database found, creating a new one.");
		ReagentRestocker:loadDB()
	elseif oldEnv.ReagentRestockerDB.DataVersion == ReagentRestocker.maxVer then
		-- Shortcut to load faster if a database upgrade isn't needed.
		setfenv(1, oldEnv)
		addonTable.dprint("Database loaded.")
		addonTable.dprint(addonName .. " version: " .. ReagentRestockerDB.Version);
		addonTable.dprint(addonName .. " database version: " .. ReagentRestockerDB.DataVersion);
	
		-- Load RR's version from the TOC file.
		ReagentRestockerDB.Version = GetAddOnMetadata(addonName, "Version");
		
		addonTable.ReagentRestockerDB = ReagentRestockerDB
		addonTable.RRGlobal=RRGlobal
		
		if ReagentRestockerDB.Options.Debug == true then
			addonTable.debugRR = true;
		else
			addonTable.debugRR = false;
		end
		
		setfenv(1, addonTable)
		
		ReagentRestocker:notifyPlayer()
		
	else
		-- load the database and update if needed.
		ReagentRestocker:loadDB()
	end
	
	-- Remove the function, since it's not needed anymore.
	ReagentRestocker.loadDB = nil
	ReagentRestocker.maxVer = nil
	ReagentRestocker.fixBoolean = nil

end

setfenv(1, oldEnv);
RRGlobal = addonTable.RRGlobal
ReagentRestockerDB=addonTable.ReagentRestockerDB

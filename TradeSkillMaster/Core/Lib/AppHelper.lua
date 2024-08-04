-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local AppHelper = TSM:NewPackage("AppHelper") ---@type AddonPackage
local ClientInfo = TSM.LibTSMWoW:Include("Util.ClientInfo")
local L = TSM.Locale.GetTable()
local RealmData = TSM.LibTSMData:Include("Realm")
local StaticPopupDialog = TSM.LibTSMWoW:IncludeClassType("StaticPopupDialog")
local Addon = TSM.LibTSMWoW:Include("API.Addon")
local SessionInfo = TSM.LibTSMWoW:Include("Util.SessionInfo")
local Log = TSM.LibTSMUtil:Include("Util.Log")
local Hash = TSM.LibTSMUtil:Include("Util.Hash")
local Analytics = TSM.LibTSMUtil:Include("Util.Analytics")
local Auction = TSM.LibTSMService:Include("Auction")
local AuctionHouseWrapper = TSM.LibTSMWoW:Include("API.AuctionHouseWrapper")
local ErrorHandler = TSM.LibTSMService:Include("Debug.ErrorHandler")
local LibRealmInfo = LibStub("LibRealmInfo")
local private = {
	settings = nil,
	-- The addon has historically had the game version as a suffix, whereas the app data has it as a prefix, so we store both
	addonRegion = nil,
	appDataRegion = nil,
	appInfo = nil,
	auctionDBData = {
		realm = {},
		region = {},
		commodity = {},
		altRealm = {},
	},
	shoppingData = nil,
	altRealms = {},
}
local APP_INFO_REQUIRED_KEYS = { "version", "lastSync", "message", "news" }
local AUCTIONDB_REALM_TAGS = {
	AUCTIONDB_NON_COMMODITY_DATA = true,
	AUCTIONDB_NON_COMMODITY_SCAN_STAT = true,
	AUCTIONDB_NON_COMMODITY_HISTORICAL = true,
}
local AUCTIONDB_REGION_TAGS = {
	AUCTIONDB_REGION_STAT = true,
	AUCTIONDB_REGION_HISTORICAL = true,
	AUCTIONDB_REGION_SALE = true,
}
local AUCTIONDB_COMMODITY_TAGS = {
	AUCTIONDB_COMMODITY_DATA = true,
	AUCTIONDB_COMMODITY_SCAN_STAT = true,
	AUCTIONDB_COMMODITY_HISTORICAL = true,
}
local LOGOUT_TIME_WARNING_THRESHOLD = 0.02
local MAX_ANALYTICS_AGE = 14 * 24 * 60 * 60 -- 2 weeks
local APP_DB_GLOBAL_NAME = "TradeSkillMaster_AppHelperDB"



-- ============================================================================
-- Global Function
-- ============================================================================

-- luacheck: globals TSM_APPHELPER_LOAD_DATA
function TSM_APPHELPER_LOAD_DATA(tag, realmOrRegion, data)
	if type(tag) ~= "string" or type(realmOrRegion) ~= "string" or type(data) ~= "string" then
		Log.Err("Unknown AppHelper data: %s, %s, %s", strsub(tostring(tag), 1, 20), strsub(tostring(realmOrRegion), 1, 20), strsub(tostring(data), 1, 20))
		return
	end
	if tag == "APP_INFO" and realmOrRegion == "Global" then
		if private.appInfo then
			Log.Err("Duplicate app info")
			return
		end
		Log.Info("Got app info")

		-- Load the app info
		private.appInfo = assert(loadstring(data))()
		for _, key in ipairs(APP_INFO_REQUIRED_KEYS) do
			assert(private.appInfo[key])
		end

		-- Clean up the news content strings
		for _, info in ipairs(private.appInfo.news) do
			-- For some reason the data is missing a few newlines before bold headings, so add one
			info.content = gsub(info.content, "(<strong>)", "\n\n%1")
			info.content = gsub(info.content, "<br%s+/>", "\n")
			info.content = gsub(info.content, "<strong>(.-)</strong>", "%1")
			info.content = gsub(info.content, "<a href='.-'>(.-)</a>", "%1")
			info.content = gsub(info.content, "&#8211;", "-")
			info.content = gsub(info.content, "&#8216;", "'")
		end
	elseif AUCTIONDB_REALM_TAGS[tag] or AUCTIONDB_REGION_TAGS[tag] or AUCTIONDB_COMMODITY_TAGS[tag] then
		if AUCTIONDB_REALM_TAGS[tag] and private.IsCurrentRealm(realmOrRegion) then
			private.StoreAuctionDBData(private.auctionDBData.realm, tag, data, "realm")
		elseif AUCTIONDB_REALM_TAGS[tag] and private.IsRealm(realmOrRegion, private.settings.auctionDBAltRealm) then
			private.altRealms[realmOrRegion] = true
			private.StoreAuctionDBData(private.auctionDBData.altRealm, tag, data, "alt realm")
		elseif AUCTIONDB_REGION_TAGS[tag] and realmOrRegion == private.appDataRegion then
			private.StoreAuctionDBData(private.auctionDBData.region, tag, data, "region")
		elseif AUCTIONDB_COMMODITY_TAGS[tag] and realmOrRegion == private.appDataRegion then
			private.StoreAuctionDBData(private.auctionDBData.commodity, tag, data, "commodity")
		else
			Log.Info("Ignoring AuctionDB data (%s) for '%s'", tag, realmOrRegion)
			if AUCTIONDB_REALM_TAGS[tag] then
				private.altRealms[realmOrRegion] = true
			end
		end
	elseif tag == "SHOPPING_SEARCHES" then
		if not private.IsCurrentRealm(realmOrRegion) then
			Log.Info("Ignoring Shopping data for '%s'", realmOrRegion)
			private.altRealms[realmOrRegion] = true
			return
		elseif private.shoppingData then
			Log.Err("Duplicate Shopping data")
			return
		end
		private.shoppingData = data
		Log.Info("Got Shopping data")
	else
		Log.Err("Unknown AppHelper data: %s, %s", strsub(tag, 1, 25), strsub(realmOrRegion, 1, 25))
	end
end



-- ============================================================================
-- Module Functions
-- ============================================================================

function AppHelper.OnInitialize(settingsDB)
	private.settings = settingsDB:NewView()
		:AddKey("global", "internalData", "appMessageId")
		:AddKey("global", "internalData", "lastCharacter")
		:AddKey("realm", "coreOptions", "auctionDBAltRealm")
	-- Set the last character we logged into for display in the app
	private.settings.lastCharacter = UnitName("player").." - "..GetRealmName()

	local cVar = GetCVar("Portal")
	local region = nil
	if ClientInfo.IsRetail() then
		region = LibRealmInfo:GetCurrentRegion()
	else
		local currentRealmName = private.SanitizedRealmName(SessionInfo.GetRealmName())
		local realmInfo = RealmData.Classic[currentRealmName]
		region = realmInfo and realmInfo.region
	end
	region = region or (cVar ~= "public-test" and cVar) or "PTR"
	if ClientInfo.IsRetail() then
		private.addonRegion = region
		private.appDataRegion = region
	elseif ClientInfo.IsVanillaClassic() then
		if C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason() == Enum.SeasonID.Hardcore then
			private.addonRegion = region.."-HC"
			private.appDataRegion = "HC-"..region
		elseif C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason() == 2 then -- Boo Blizzard
			private.addonRegion = region.."-SoD"
			private.appDataRegion = "SoD-"..region
		else
			private.addonRegion = region.."-Classic"
			private.appDataRegion = "Classic-"..region
		end
	elseif ClientInfo.IsCataClassic() then
		private.addonRegion = region.."-BCC"
		private.appDataRegion = "BCC-"..region
	else
		error("Invalid game version")
	end
	AuctionHouseWrapper.SetAnalyticsRegionRealm(private.addonRegion.."-"..private.SanitizedRealmName(SessionInfo.GetRealmName()))
end

function AppHelper.OnEnable()
	TSM_APPHELPER_LOAD_DATA = nil

	if not Addon.IsInstalled("TradeSkillMaster_AppHelper") then
		return
	elseif not Addon.IsEnabled("TradeSkillMaster_AppHelper") then
		-- TSM_AppHelper is disabled
		StaticPopupDialog.New()
			:SetText(L["The TradeSkillMaster_AppHelper addon is installed, but not enabled. TSM has enabled it and requires a reload."])
			:SetAcceptButtonText(L["Reload"])
			:SetScript("OnAccept", function()
				C_AddOns.EnableAddOn("TradeSkillMaster_AppHelper")
				ReloadUI()
			end)
			:Show()
		return
	elseif not private.appInfo or not private.appInfo.lastSync then
		-- The app hasn't run yet or isn't pointing at the right WoW directory
		StaticPopupDialog.ShowWithOk(L["TSM is missing important information from the TSM Desktop Application. Please ensure the TSM Desktop Application is running and is properly configured."])
		return
	end

	if private.appInfo.message.msg and private.appInfo.message.id > private.settings.appMessageId then
		-- Show the message from the app
		private.settings.appMessageId = private.appInfo.message.id
		StaticPopupDialog.ShowWithOk(private.appInfo.message.msg)
	end

	if time() - private.appInfo.lastSync > 60 * 60 then
		-- The app hasn't been running for over an hour
		StaticPopupDialog.ShowWithOk(L["TSM is missing important information from the TSM Desktop Application. Please ensure the TSM Desktop Application is running and is properly configured."])
	end
end

function AppHelper.OnDisableLate()
	-- Erroring here would cause the profile to be reset, so use pcall
	local startTime = GetTimePreciseSec()
	private.SaveAppData()
	local timeTaken = GetTimePreciseSec() - startTime
	if timeTaken > LOGOUT_TIME_WARNING_THRESHOLD then
		Log.Warn("private.SaveAppData took %0.5fs", timeTaken)
	end
end

function AppHelper.GetLastSync()
	return private.appInfo and private.appInfo.lastSync or nil
end

function AppHelper.GetNews()
	return private.appInfo and private.appInfo.news or nil
end

function AppHelper.GetRegion()
	return private.addonRegion
end

function AppHelper.GetAuctionDBData()
	return private.auctionDBData.realm, private.auctionDBData.region, private.auctionDBData.commodity, private.auctionDBData.altRealm
end

function AppHelper.GetShoppingData()
	return private.shoppingData
end

function AppHelper.GetAltRealms()
	return private.altRealms
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.StoreAuctionDBData(tbl, tag, data, label)
	if tbl[tag] then
		Log.Err("Duplicate AuctionDB %s data (%s)", label, tag)
		return
	end
	tbl[tag] = data
	Log.Info("Got AuctionDB %s data (%s)", label, tag)
end

function private.SanitizedRealmName(realm)
	return gsub(realm, "\226", "'")
end

function private.IsCurrentRealm(realm)
	return private.IsRealm(realm, SessionInfo.GetRealmName())
end

function private.IsRealm(realm, targetRealm)
	local currentRealmName = private.SanitizedRealmName(targetRealm)
	if not ClientInfo.HasFeature(ClientInfo.FEATURES.CONNECTED_FACTION_AH) then
		currentRealmName = currentRealmName.."-"..SessionInfo.GetFactionName()
	end
	return strlower(private.SanitizedRealmName(realm)) == strlower(currentRealmName)
end

function private.SaveAppData()
	if not Addon.IsInstalled("TradeSkillMaster_AppHelper") or not Addon.IsEnabled("TradeSkillMaster_AppHelper") then
		return
	end

	local appDB = _G[APP_DB_GLOBAL_NAME]
	if not appDB then
		appDB = {}
		_G[APP_DB_GLOBAL_NAME] = appDB
	end
	appDB.region = private.addonRegion
	ErrorHandler.SaveReports(appDB)
	private.SaveBlackMarket(appDB)
	private.SaveAnalytics(appDB)
end

function private.SaveBlackMarket(appDB)
	local realmName = GetRealmName()
	appDB.blackMarket = appDB.blackMarket or {}
	local blackMarketData, blackMarketTime = Auction.GetBlackMarketScanData()
	if blackMarketData then
		appDB.blackMarket[realmName] = {
			data = blackMarketData,
			key = Hash.Calculate(blackMarketData..":"..blackMarketTime),
			updateTime = blackMarketTime
		}
	end
end

function private.SaveAnalytics(appDB)
	appDB.analytics = appDB.analytics or {updateTime=0, data={}}
	appDB.analytics.updateTime = Analytics.GetLastEventTime() or appDB.analytics.updateTime

	-- Remove entries which are too old
	local minTime = time() - MAX_ANALYTICS_AGE
	for i = #appDB.analytics.data, 1, -1 do
		if Analytics.GetEntryTime(appDB.analytics.data[i]) < minTime then
			tremove(appDB.analytics.data, i)
		end
	end

	-- Add new entries
	for _, eventStr in Analytics.EventIterator() do
		tinsert(appDB.analytics.data, eventStr)
	end
end

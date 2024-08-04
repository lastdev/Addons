-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Inventory = TSM.Init("Service.Inventory") ---@class Service.Inventory: TSMModule
local Log = TSM.LibTSMUtil:Include("Util.Log")
local CustomString = TSM.LibTSMTypes:Include("CustomString")
local AltTracking = TSM.Include("Service.AltTracking")
local BagTracking = TSM.LibTSMService:Include("Inventory.BagTracking")
local WarbankTracking = TSM.LibTSMService:Include("Inventory.WarbankTracking")
local Auction = TSM.LibTSMService:Include("Auction")
local Guild = TSM.LibTSMService:Include("Guild")
local Mail = TSM.LibTSMService:Include("Mail")
local private = {
	sources = {},
	settingsDB = nil,
	settings = nil,
}



-- ============================================================================
-- Module Loading
-- ============================================================================

Inventory:OnSettingsLoad(function(db)
	tinsert(private.sources, "NumInventory")
	private.settingsDB = db
	private.settings = db:NewView()
		:AddKey("sync", "internalData", "bagQuantity")
		:AddKey("sync", "internalData", "bankQuantity")
		:AddKey("sync", "internalData", "reagentBankQuantity")
		:AddKey("char", "internalData", "auctionSaleHints")
		:AddKey("factionrealm", "internalData", "expiringAuction")
		:AddKey("sync", "internalData", "auctionQuantity")
		:AddKey("factionrealm", "internalData", "pendingMail")
		:AddKey("factionrealm", "internalData", "expiringMail")
		:AddKey("sync", "internalData", "mailQuantity")
		:AddKey("factionrealm", "internalData", "guildVaults")
		:AddKey("global", "mailingOptions", "recentlyMailedList")
		:AddKey("global", "internalData", "warbankQuantity")

	-- Bag tracking
	BagTracking.Load(private.settings.bagQuantity, private.settings.bankQuantity, private.settings.reagentBankQuantity)
	BagTracking.Start()
	BagTracking.RegisterQuantityCallback(private.QuantityChangedCallback)

	-- Warbank tracking
	WarbankTracking.Load(private.settings.warbankQuantity)
	WarbankTracking.Start()
	WarbankTracking.RegisterQuantityCallback(private.QuantityChangedCallback)

	-- Auction tracking
	Auction.Load(private.settings.auctionQuantity, private.settings.auctionSaleHints, private.settings.expiringAuction)
	Auction.Start()
	Auction.RegisterQuantityCallback(private.QuantityChangedCallback)

	-- Mail Tracking
	private.SanitizePendingMail()
	Mail.Load(private.settings.mailQuantity, private.settings.pendingMail, private.settings.expiringMail, db, private.settings.recentlyMailedList, private.ValidateMailCharacter)
	Mail.Start()
	Mail.RegisterQuantityCallback(private.QuantityChangedCallback)

	-- Guild Tracking
	Guild.Load(private.settings.guildVaults)
	Guild.Start()

	AltTracking.RegisterQuantityCallback(private.QuantityChangedCallback)
end)

Inventory:OnGameDataLoad(function()
	BagTracking.InitialScan()
end)



-- ============================================================================
-- Module Functions
-- ============================================================================

function Inventory.RegisterDependentCustomSource(source)
	tinsert(private.sources, source)
end

function Inventory.GetTotalQuantity(itemString)
	local total = 0
	total = total + BagTracking.GetBagQuantity(itemString)
	total = total + BagTracking.GetBankQuantity(itemString)
	total = total + BagTracking.GetReagentBankQuantity(itemString)
	total = total + WarbankTracking.GetQuantity(itemString)
	total = total + Mail.GetQuantity(itemString)
	total = total + Auction.GetQuantity(itemString)
	total = total + AltTracking.GetTotalQuantity(itemString)
	total = total + AltTracking.GetTotalGuildQuantity(itemString)
	return total
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.SanitizePendingMail()
	-- Remove pending mail data for characters we don't own
	for character in pairs(private.settings.pendingMail) do
		if private.settingsDB:GetOwnerSyncAccountKey(character) ~= private.settingsDB:GetLocalSyncAccountKey() then
			Log.Info("Removed pending mail data for %s", character)
			private.settings.pendingMail[character] = nil
		end
	end
end

function private.ValidateMailCharacter(character)
	if not character then
		return nil
	end
	local characterName, realm = strsplit("-", strlower(character))
	-- We only care to track mails with characters on this realm
	if realm and realm ~= strlower(GetRealmName()) then
		return nil
	end
	-- We only care to track mails with characters on this account
	local result = nil
	for _, name in private.settingsDB:AccessibleCharacterIterator(private.settingsDB:GetLocalSyncAccountKey()) do
		if strlower(name) == characterName then
			result = name
		end
	end
	return result
end

function private.QuantityChangedCallback(updatedItems)
	for _, source in ipairs(private.sources) do
		for itemString in pairs(updatedItems) do
			CustomString.InvalidateCache(source, itemString)
		end
	end
end

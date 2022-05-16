local Amr = LibStub("AceAddon-3.0"):GetAddon("AskMrRobot")
local L = LibStub("AceLocale-3.0"):GetLocale("AskMrRobot", true)
local AceGUI = LibStub("AceGUI-3.0")

local _lastExport = nil
local _txt = nil

local function createLabel(container, text, width)
	local lbl = AceGUI:Create("AmrUiLabel")
	container:AddChild(lbl)
	lbl:SetWidth(width or 800)
	lbl:SetText(text)
	lbl:SetFont(Amr.CreateFont("Regular", 14, Amr.Colors.Text))
	return lbl
end

local function onSplashClose()
	Amr:HideCover()
	Amr.db.char.FirstUse = false
end

local function onTextChanged(widget)
	local val = _txt:GetText()
	if val == "overwolf-bib" then
		-- go to the gear tab, open import window, and show a cover
		Amr:ShowTab("Gear")
		Amr:ShowImportWindow(true)
	end
end

-- render a splash screen with first-time help
local function renderSplash(container)
	local panel = Amr:RenderCoverChrome(container, 700, 450)
	
	local lbl = createLabel(panel, L.ExportSplashTitle, 650)
	lbl:SetJustifyH("CENTER")
	lbl:SetFont(Amr.CreateFont("Bold", 24, Amr.Colors.TextHeaderActive))
	lbl:SetPoint("TOP", panel.content, "TOP", 0, -10)
	
	local lbl2 = createLabel(panel, L.ExportSplashSubtitle, 650)
	lbl2:SetJustifyH("CENTER")
	lbl2:SetFont(Amr.CreateFont("Bold", 18, Amr.Colors.TextTan))
	lbl2:SetPoint("TOP", lbl.frame, "BOTTOM", 0, -20)
	
	lbl = createLabel(panel, L.ExportSplash1, 650)
	lbl:SetFont(Amr.CreateFont("Regular", 14, Amr.Colors.Text))
	lbl:SetPoint("TOPLEFT", lbl2.frame, "BOTTOMLEFT", 0, -70)
	
	lbl2 = createLabel(panel, L.ExportSplash2, 650)
	lbl2:SetFont(Amr.CreateFont("Regular", 14, Amr.Colors.Text))
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -15)
	
	local btn = AceGUI:Create("AmrUiButton")
	btn:SetText(L.ExportSplashClose)
	btn:SetBackgroundColor(Amr.Colors.Green)
	btn:SetFont(Amr.CreateFont("Bold", 16, Amr.Colors.White))
	btn:SetWidth(120)
	btn:SetHeight(28)
	btn:SetCallback("OnClick", onSplashClose)
	panel:AddChild(btn)
	btn:SetPoint("BOTTOM", panel.content, "BOTTOM", 0, 20)
end

-- renders the main UI for the Export tab
function Amr:RenderTabExport(container)

	local lbl = createLabel(container, L.ExportTitle)
	lbl:SetFont(Amr.CreateFont("Bold", 24, Amr.Colors.TextHeaderActive))
	lbl:SetPoint("TOPLEFT", container.content, "TOPLEFT", 0, -40)
	
	local lbl2 = createLabel(container, L.ExportHelp1)
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -10)
	
	lbl = createLabel(container, L.ExportHelp2)
	lbl:SetPoint("TOPLEFT", lbl2.frame, "BOTTOMLEFT", 0, -10)
	
	lbl2 = createLabel(container, L.ExportHelp3)
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -10)
	
	_txt = AceGUI:Create("AmrUiTextarea")
	_txt:SetWidth(800)
	_txt:SetHeight(300)
	_txt:SetFont(Amr.CreateFont("Regular", 12, Amr.Colors.Text))
	_txt:SetCallback("OnTextChanged", onTextChanged)
	container:AddChild(_txt)
	_txt:SetPoint("TOP", lbl2.frame, "BOTTOM", 0, -20)
	
	local data = self:ExportCharacter()	
	local txt = Amr.Serializer:SerializePlayerData(data, true)
	_txt:SetText(txt)
	_txt:SetFocus(true)
	
	-- update shopping list data
	Amr:UpdateShoppingData(data)
	
	-- show help splash if first time a user is using this
	if Amr.db.char.FirstUse then
		Amr:ShowCover(renderSplash)	
		AceGUI:ClearFocus()
	end
end

function Amr:ReleaseTabExport()
end

function Amr:GetExportText()
	return _txt:GetText()
end


-- use some local variables to deal with the fact that a user can close the bank before a scan completes
local _lastBankBagId = nil
local _lastBankSlotId = nil
local _bankOpen = false

local function scanBag(bagId, isBank, bagTable, bagItemsWithCount)
	local numSlots = GetContainerNumSlots(bagId)
	--local loc = ItemLocation.CreateEmpty()
	local item
	for slotId = 1, numSlots do
		local _, itemCount, _, _, _, _, itemLink = GetContainerItemInfo(bagId, slotId)
		if itemLink ~= nil then
			local itemData = Amr.Serializer.ParseItemLink(itemLink)
			if itemData ~= nil then
				item = Item:CreateFromBagAndSlot(bagId, slotId)

				-- seems to be of the form Item-1147-0-4000000XXXXXXXXX, so we take just the last 9 digits
				itemData.guid = item:GetItemGUID()
				if itemData.guid and strlen(itemData.guid) > 9 then
					itemData.guid = strsub(itemData.guid, -9)
				end

				-- see if this is an azerite item and read azerite power ids
				--[[loc:SetBagAndSlot(bagId, slotId)
				if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(loc) then
					local powers = Amr.ReadAzeritePowers(loc)
					if powers then
						itemData.azerite = powers
					end
				end]]

				if isBank then
					_lastBankBagId = bagId
					_lastBankSlotId = slotId
				end
										
				table.insert(bagTable, itemData)
				
				-- all items and counts, used for e.g. shopping list and reagents, etc.
                if bagItemsWithCount then
                	if bagItemsWithCount[itemData.id] then
                		bagItemsWithCount[itemData.id] = bagItemsWithCount[itemData.id] + itemCount
                	else
                		bagItemsWithCount[itemData.id] = itemCount
                	end
                end
            end
		end
	end
end

-- cache the currently equipped gear for this spec
local function cacheEquipped()
	local data = Amr.Serializer:GetEquipped()
	
	local spec = GetSpecialization()	
	Amr.db.char.Equipped[spec] = data.Equipped[spec]
end

local function scanBags()

	local bagItems = {}
	local itemsAndCounts = {}
	
	scanBag(BACKPACK_CONTAINER, false, bagItems, itemsAndCounts) -- backpack
	for bagId = 1, NUM_BAG_SLOTS do
		scanBag(bagId, false, bagItems, itemsAndCounts)
	end
	
	Amr.db.char.BagItems = bagItems
	Amr.db.char.BagItemsAndCounts = itemsAndCounts
end

-- scan the player's bank and save the contents, must be at the bank
local function scanBank()

	local bankItems = {}
	local itemsAndCounts = {}
	
	local bagList = {}
	table.insert(bagList, BANK_CONTAINER)
	table.insert(bagList, REAGENTBANK_CONTAINER)
	for bagId = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		table.insert(bagList, bagId)
	end

	for i,bagId in ipairs(bagList) do
		local bagItems = {}
		local bagItemsAndCounts = {}
		scanBag(bagId, true, bagItems, bagItemsAndCounts)

		bankItems[bagId] = bagItems
		itemsAndCounts[bagId] = bagItemsAndCounts
	end
	
	-- see if the scan completed before the window closed, otherwise we don't overwrite with partial data
	if _bankOpen and _lastBankBagId then
		local itemLink = GetContainerItemLink(_lastBankBagId, _lastBankSlotId)
		if itemLink then --still open
            Amr.db.char.BankItems = bankItems
            Amr.db.char.BankItemsAndCounts = itemsAndCounts
		end
	end
end

local function onBankOpened()
	_bankOpen = true
	scanBank()
end

local function onBankClosed()
	_bankOpen = false
end

-- if a bank bag is updated while the bank is open, re-scan that bag
local function onBankUpdated(bagID)
	if _bankOpen and (bagID == BANK_CONTAINER or bagID == REAGENTBANK_CONTAINER or (bagID >= NUM_BAG_SLOTS + 1 and bagID <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS)) then
		local bagItems = {}
		local bagItemsAndCounts = {}
		scanBag(bagID, true, bagItems, bagItemsAndCounts)

		-- see if the scan completed before the window closed, otherwise we don't overwrite with partial data
		if _bankOpen and _lastBankBagId == bagID then
			local itemLink = GetContainerItemLink(_lastBankBagId, _lastBankSlotId)
			if itemLink then
				Amr.db.char.BankItems[bagID] = bagItems
				Amr.db.char.BankItemsAndCounts[bagID] = bagItemsAndCounts
			end
		end
	end
end

--[[
-- scan the player's void storage and save the contents, must be at void storage
local function scanVoid()

	if IsVoidStorageReady() then
		local voidItems = {}
		local VOID_STORAGE_MAX = 80
		local VOID_STORAGE_PAGES = 2
        
		for page = 1,VOID_STORAGE_PAGES do
			for i = 1,VOID_STORAGE_MAX do
				local itemId = GetVoidItemInfo(page, i)
				if itemId then
					local itemLink = GetVoidItemHyperlinkString(((page - 1) * VOID_STORAGE_MAX) + i);
					if itemLink then
						tinsert(voidItems, itemLink)
					end
				end
			end
		end
        
		Amr.db.char.VoidItems = voidItems
	end
	
end
]]

local function scanGreatVault()

	Amr.db.char.GreatVaultItems = {}

	if not C_WeeklyRewards then return end

	local vaultItems = {}
	local activities = C_WeeklyRewards.GetActivities()
	for i, activityInfo in ipairs(activities) do
		if activityInfo and activityInfo.rewards then
			for i, rewardInfo in ipairs(activityInfo.rewards) do
				if rewardInfo.type == Enum.CachedRewardType.Item and not C_Item.IsItemKeystoneByID(rewardInfo.id) then
					local itemLink = C_WeeklyRewards.GetItemHyperlink(rewardInfo.itemDBID)
					if itemLink then
						local itemData = Amr.Serializer.ParseItemLink(itemLink)
						if itemData ~= nil then
							table.insert(vaultItems, itemData)
						end
					end
				end
			end
		end
	end
	Amr.db.char.GreatVaultItems = vaultItems
end

local function scanSoulbinds()
	if not C_Soulbinds then return end

	-- get renown
	if C_CovenantSanctumUI then
		Amr.db.char.CovenantRenownLevel = C_CovenantSanctumUI.GetRenownLevel()
	else
		Amr.db.char.CovenantRenownLevel = 0
	end

	-- read which conduits this player has unlocked
	Amr.db.char.UnlockedConduits = {}

	for t = 0,2 do
		local conduits = C_Soulbinds.GetConduitCollection(t)
		for i, conduit in ipairs(conduits) do
			table.insert(Amr.db.char.UnlockedConduits, { conduit.conduitID, conduit.conduitRank })
		end
	end

	if not Amr.db.char.ActiveSoulbinds then
		Amr.db.char.ActiveSoulbinds = {}
	end

	-- read the currently active soulbind for this spec
	local specPos = GetSpecialization()	
	if specPos and specPos >= 1 and specPos <= 4 then
		Amr.db.char.ActiveSoulbinds[specPos] = C_Soulbinds.GetActiveSoulbindID() or 0
	end

	-- update soulbind tree info for all soulbinds
	Amr.db.char.Soulbinds = {}
	
	for c, covenantId in ipairs(C_Covenants.GetCovenantIDs()) do
		local covenantData = C_Covenants.GetCovenantData(covenantId)

		if covenantData and covenantData.soulbindIDs then
			for i, soulbindId in ipairs(covenantData.soulbindIDs) do
				local soulbindData = soulbindId and C_Soulbinds.GetSoulbindData(soulbindId)
				local nodes = {}
				local unlockedTier = -1
	
				if soulbindData and soulbindData.tree and soulbindData.tree.nodes then
					for i, node in ipairs(soulbindData.tree.nodes) do
						if node.state == 3 then
							nodes[node.row] = { soulbindId, node.row, node.column, node.conduitID, node.conduitRank }
						end
						if node.state > 0 then
							unlockedTier = math.max(node.row, unlockedTier)
						end
					end
				end
	
				Amr.db.char.Soulbinds[soulbindId] = {
					UnlockedTier = unlockedTier,
					Nodes = nodes
				}
	
			end
		end
	end	

end

--[[
local function scanEssences()
	if not C_AzeriteEssence then return end

	-- read which essences this player has unlocked
	Amr.db.char.UnlockedEssences = {}

	local essences = C_AzeriteEssence.GetEssences()
	if essences then
		for i, essence in ipairs(essences) do
			if essence.unlocked then
				table.insert(Amr.db.char.UnlockedEssences, { essence.ID, essence.rank })
			end
		end 
	end

	local specPos = GetSpecialization()	
	if not specPos or specPos < 1 or specPos > 4 then return end

	if not Amr.db.char.Essences then
		Amr.db.char.Essences = {}
	end

	Amr.db.char.Essences[specPos] = {}
	local active = Amr.db.char.Essences[specPos]

	local milestones = C_AzeriteEssence.GetMilestones()
	if milestones then
		for i, milestone in ipairs(milestones) do
			-- if no slot, it corresponds to the stamina nodes, skip those
			if milestone.slot ~= nil then
				if milestone.unlocked then
					local essenceId = C_AzeriteEssence.GetMilestoneEssence(milestone.ID)
					if essenceId then
						local essence = C_AzeriteEssence.GetEssenceInfo(essenceId)
						table.insert(active, { milestone.slot, essence.ID, essence.rank })
					end
				end
			end
		end
	end
end
]]

local function scanTalents()	
	local specPos = GetSpecialization()	
	if not specPos or specPos < 1 or specPos > 4 then return end
	
	local talentInfo = {}
    local maxTiers = 7
    for tier = 1, maxTiers do
        for col = 1, 3 do
            local id, name, _, _, _, spellId, _, t, c, selected = GetTalentInfoBySpecialization(specPos, tier, col)
            if selected then
                talentInfo[tier] = col
            end
        end
    end
    
    local str = ""
    for i = 1, maxTiers do
    	if talentInfo[i] then
    		str = str .. talentInfo[i]
    	else
    		str = str .. '0'
    	end
    end
	
	Amr.db.char.Talents[specPos] = str
end

-- Returns a data object containing all information about the current player needed for an export:
-- gear, spec, reputations, bag, bank, and void storage items.
function Amr:ExportCharacter()
	
	-- get all necessary player data
	local data = Amr.Serializer:GetPlayerData()

	-- cache latest-seen equipped gear for current spec
	local spec = GetSpecialization()	
	Amr.db.char.Equipped[spec] = data.Equipped[spec]

	-- scan current inventory just before export so that it is always fresh
	scanBags()
	
	-- scan current spec's talents just before exporting
	scanTalents()

	-- scan all soulbinds just before exporting
	scanSoulbinds()

	-- scan current spec's essences just before exporting
	--scanEssences()
	
	-- scan the great vault for potential rewards this week
	scanGreatVault()

	data.Talents = Amr.db.char.Talents	
	data.CovenantRenownLevel = Amr.db.char.CovenantRenownLevel
	data.UnlockedConduits = Amr.db.char.UnlockedConduits
	data.ActiveSoulbinds = Amr.db.char.ActiveSoulbinds
	data.Soulbinds = Amr.db.char.Soulbinds
	--data.UnlockedEssences = Amr.db.char.UnlockedEssences
	--data.Essences = Amr.db.char.Essences
	data.Equipped = Amr.db.char.Equipped	
	data.BagItems = Amr.db.char.BagItems
	data.GreatVaultItems = Amr.db.char.GreatVaultItems

	-- flatten bank data (which is stored by bag for more efficient updating)
	data.BankItems = {}
	for k,v in pairs(Amr.db.char.BankItems) do
		for i,v2 in ipairs(v) do
			table.insert(data.BankItems, v2)
		end
	end

	--data.VoidItems = Amr.db.char.VoidItems
	
	return data
end

function Amr:InitializeExport()
	Amr:AddEventHandler("UNIT_INVENTORY_CHANGED", function(unitID)
		if unitID and unitID ~= "player" then return end
		cacheEquipped()
	end)
end

Amr:AddEventHandler("BANKFRAME_OPENED", onBankOpened)
Amr:AddEventHandler("BANKFRAME_CLOSED", onBankClosed)
Amr:AddEventHandler("BAG_UPDATE", onBankUpdated)

--Amr:AddEventHandler("VOID_STORAGE_OPEN", scanVoid)
--Amr:AddEventHandler("VOID_STORAGE_CONTENTS_UPDATE", scanVoid)
--Amr:AddEventHandler("VOID_STORAGE_DEPOSIT_UPDATE", scanVoid)
--Amr:AddEventHandler("VOID_STORAGE_UPDATE", scanVoid)

Amr:AddEventHandler("PLAYER_TALENT_UPDATE", scanTalents)

--if C_AzeriteEssence then
--	Amr:AddEventHandler("AZERITE_ESSENCE_UPDATE", scanEssences)
--end

if C_Soulbinds then
	Amr:AddEventHandler("SOULBIND_ACTIVATED", scanSoulbinds)
end
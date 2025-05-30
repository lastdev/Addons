local addonTabName = ...
local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

local tab		-- small shortcut to easily address the frame (set in OnBind)
local currentPanelKey

local function OnGuildAltsReceived(event, sender, alts)
	tab.Panels.Members:InvalidateView()
	tab:Update()
end

local function OnBankTabRequestAck(event, sender)
	addon:Print(format(L["WAIT_OTHER_PLAYER_ACK"], sender))
end

local function OnBankTabRequestRejected(event, sender)
	addon:Print(format(L["REJECTED_BY_OTHER_PLAYER"], sender))
end

local function OnBankTabUpdateSuccess(event, sender, guildName, tabName, tabID)
	addon:Print(format(L["GUILD_BANK_TAB_UPDATED"], tabName ))
	-- frame.Bank:Update()
end

local function OnGuildMemberOffline(event, member)
	tab.Panels.Members:InvalidateView()
	tab:Update()
end

local function OnRosterUpdate()
	-- local _, onlineMembers = GetNumGuildMembers()
	-- frame.MenuItem1.Text:SetText(format("%s %s(%d)", L["GUILD_MEMBERS"], colors.green, onlineMembers))
	
	tab.Panels.Members:InvalidateView()
	tab:Update()
end

addon:Controller("AltoholicUI.TabGuild", { "AddonFactory.Classes", function(oop)
	return oop:New("AuctionHouseUI.Tab", {
		OnBind = function(frame)
			tab = frame
			currentPanelKey = "Members"
		
			DataStore:ListenTo("DATASTORE_GUILD_ALTS_RECEIVED", OnGuildAltsReceived)
			DataStore:ListenTo("DATASTORE_BANKTAB_REQUEST_ACK", OnBankTabRequestAck)
			DataStore:ListenTo("DATASTORE_BANKTAB_REQUEST_REJECTED", OnBankTabRequestRejected)
			DataStore:ListenTo("DATASTORE_BANKTAB_UPDATE_SUCCESS", OnBankTabUpdateSuccess)
			DataStore:ListenTo("DATASTORE_GUILD_MEMBER_OFFLINE", OnGuildMemberOffline)
			
			if IsInGuild() then
				addon:ListenTo("GUILD_ROSTER_UPDATE", OnRosterUpdate)
			end
		end,
		
		GetCurrentGuild = function(frame)
			return tab.Panels.Bank:GetCurrentGuild()
		end,
		SortBy = function(frame, columnName, buttonIndex)
			local options = Altoholic_GuildTab_Options
			
			-- Toggle the option
			options["SortAscending"] = not options["SortAscending"]
			
			-- Sort the whole view by a given column
			local hc = frame.HeaderContainer
			local sortOrder = options["SortAscending"]		
			
			hc.SortButtons[buttonIndex]:DrawArrow(sortOrder)
			
			frame.Panels.Members:Sort(columnName, sortOrder)
			frame:Update()
		end,
		SetColumns = function(frame, panel)

			local hc = frame.HeaderContainer
		
			if panel == "Members" then
				hc:SetButton(1, NAME, 150, function() frame:SortBy("name", 1) end)
				hc:SetButton(2, LEVEL, 60, function() frame:SortBy("level", 2) end)
				hc:SetButton(3, "AiL", 65, function() frame:SortBy("averageItemLvl", 3) end)
				hc:SetButton(4, GAME_VERSION_LABEL, 80, function() frame:SortBy("version", 4) end)
				hc:SetButton(5, CLASS, 100, function() frame:SortBy("englishClass", 5) end)
				hc:Show()
			else
				hc:Hide()
			end
			
			-- hc:LimitWidth(frame.Background:GetWidth())
		end,
		Update = function(frame)
			frame:SetColumns(currentPanelKey)
			frame:ShowPanel(currentPanelKey)
		end,
	})
end})

local function GuildBank_OnClick(categoryData)
	currentPanelKey = "Bank" 
	
	-- when applying oop, use this
	-- local guildBank = tab:SetCurrentPanel("Bank")
	local guildBank = tab.Panels.Bank
	guildBank.ContextualMenu:Close()						-- Close the DDM if it is still open
	guildBank:SetCurrentGuild(categoryData.key)		-- Set the guild
	guildBank:UpdateBankTabButtons()
	
	tab:Update()
end


addon:Controller("AltoholicUI.TabGuildCategoriesList", {
	OnBind = function(frame)
	
		local categories = {
			{ text = L["GUILD_MEMBERS"], callback = function()
					tab:SetColumns("Members")
					tab:ShowPanel("Members")
				end 
			},
			{ text = format("%s%s", colors.cyan, L["GUILD_BANKS"]) },		-- Not clickable, just a separator
		}
		
		local guildBanks = categories[#categories].subMenu
		
		for account in pairs(DataStore:GetAccounts()) do
			local accountTable = nil
			
			for realm in pairs(DataStore:GetRealms(account)) do
				local realmTable = nil
				
				for guildName, guild in pairs(DataStore:GetGuilds(realm, account)) do
					
					-- Add the account table entry if not done yet.
					if not accountTable then
						table.insert(categories, { text = format("%s%s: %s%s", colors.white, "Account", colors.green, account), isExpanded = true })
						accountTable = categories[#categories]
					end
					
					-- Add the realm table entry if not done yet.
					if not realmTable then
						accountTable.subMenu = accountTable.subMenu or {}
						table.insert(accountTable.subMenu, { text = format("%s%s", colors.gold, realm), subMenu = {}, isExpanded = true })
						realmTable = accountTable.subMenu[#accountTable.subMenu]
					end
					
					
					-- Add the guild and its key
					table.insert(realmTable.subMenu, { text = guildName, key = guild, callback = GuildBank_OnClick})
				end
			end
		end

		frame:SetCategories(categories)
	end,

})

AddonFactory:OnAddonLoaded(addonTabName, function() 
	AddonFactory:SetOptionsTable("Altoholic_GuildTab_Options", {
		BankItemsRarity = 0,				-- rarity filter in the guild bank tab
		SortAscending = true,			-- ascending or descending sort order
	})
end)

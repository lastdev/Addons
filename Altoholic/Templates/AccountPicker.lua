local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local THIS_ACCOUNT = "Default"

local function OnAccountChange(frame, dropDownFrame)
	local oldAccount, oldRealm = dropDownFrame:GetCurrentAccount()
	local newAccount = frame.value
	
	dropDownFrame:SetCurrentAccount(newAccount)

	if oldAccount then	-- clear the "select char" drop down if account has changed
		if (oldRealm ~= nil) or (oldAccount ~= newAccount) then
			dropDownFrame:TriggerClassEvent("AccountChanged", newAccount)
		end
	end
    
    if newAccount == THIS_ACCOUNT then
        addon:SetOption("UI.Tabs.Grids.CurrentAccountRealmScope", "Account")
    end
    
    if AltoholicTabGrids then AltoholicTabGrids.RefreshReputations() end
end

local function OnRealmChange(frame, dropDownFrame, newAccount)
	local oldAccount, oldRealm = dropDownFrame:GetCurrentAccount()
	local newRealm = frame.value
	
	dropDownFrame:SetCurrentAccount(newAccount, newRealm)

	if oldAccount then	-- clear the "select char" drop down if account has changed
		if (oldAccount ~= newAccount) or (oldRealm ~= newRealm) then
			dropDownFrame:TriggerClassEvent("AccountChanged", newAccount)
		end
	end
    
    if newRealm == GetRealmName() then
        addon:SetOption("UI.Tabs.Grids.CurrentAccountRealmScope", "Realm")
    end
    
    if AltoholicTabGrids then AltoholicTabGrids.RefreshReputations() end
end

addon:Controller("AltoholicUI.AccountPicker", {
	OnBind = function(frame)
		frame:SetMenuWidth(frame.menuWidth) 
		frame:SetButtonWidth(20)
		frame:Initialize(frame.DropDownAccount_Initialize)
		if addon:GetOption("UI.Tabs.Grids.CurrentAccountRealmScope") == "Account" then
            frame:SetCurrentAccount("Default")
        else
            frame:SetCurrentAccount("Default", GetRealmName())
        end
	end,
	DropDownAccount_Initialize = function(frame)
		if not frame.currentAccount then return end
        
        local scope = addon:GetOption("UI.Tabs.Grids.CurrentAccountRealmScope")

		-- this account first ..
		frame:AddTitle(colors.gold..L["This account"])
		
        local info = frame:CreateInfo()
		info.text = colors.green..L["This account"]
		info.value = THIS_ACCOUNT 
		info.checked = nil
		info.func = OnAccountChange
		info.arg1 = frame
		frame:AddButtonInfo(info, 1)
        
        for realm in pairs(DataStore:GetRealms(THIS_ACCOUNT)) do
		  local info = frame:CreateInfo()
		  info.text = realm
		  info.value = realm
          info.checked = nil
		  info.func = OnRealmChange
		  info.arg1 = frame
          info.arg2 = THIS_ACCOUNT
		  frame:AddButtonInfo(info, 1)
        end

		-- .. then all other accounts
		local accounts = DataStore:GetAccounts()
		local count = 0
		for account in pairs(accounts) do
			if account ~= THIS_ACCOUNT then
				count = count + 1
			end
		end
		
		if count > 0 then
            for account in pairs(accounts) do
			    if account ~= THIS_ACCOUNT then
                    frame:AddTitle()
			        frame:AddTitle(colors.gold..account)
			
					local info = frame:CreateInfo()
					info.text = format("%s%s", colors.green, account)
					info.value = format("%s", account)
					info.checked = nil
					info.func = OnAccountChange
					info.arg1 = frame
					frame:AddButtonInfo(info, 1)
                    
                    for realm in pairs(DataStore:GetRealms(account)) do
            		  local info = frame:CreateInfo()
            		  info.text = realm
            		  info.value = realm 
            		  info.checked = nil
            		  info.func = OnRealmChange
            		  info.arg1 = frame
                      info.arg2 = account
            		  frame:AddButtonInfo(info, 1)
                    end
				end
			end
		end
		
		frame:TriggerClassEvent("DropDownInitialized")
	end,
	SetCurrentAccount = function(frame, account, realm)
		account = account or THIS_ACCOUNT
		frame.currentAccount = account
        frame.currentRealm = realm
		if realm then
            frame:SetSelectedValue(realm)
            if account == THIS_ACCOUNT then account = L["This account"] end
		    frame:SetText(format("%s%s: %s%s", colors.green, account, colors.white, realm))
        else
            frame:SetSelectedValue(account)
            if account == THIS_ACCOUNT then account = L["This account"] end
		    frame:SetText(format("%s%s", colors.green, account))
        end
	end,
	GetCurrentAccount = function(frame)
		return frame.currentAccount, frame.currentRealm
	end,
})

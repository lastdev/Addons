if not DataStore then return end

local addonName = "DataStore_Mails"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	-- can't improve the slider right now, the use of parentKey in XML make it hard to address _Low & _High..
	local f = DataStoreMailOptions

	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	DataStoreMailOptions_SliderMailExpiry.tooltipText = L["Warn when mail expires in less days than this value"]; 
	DataStoreMailOptions_SliderMailExpiryLow:SetText("1");
	DataStoreMailOptions_SliderMailExpiryHigh:SetText("15"); 
	f.CheckMailExpiry.Text:SetText(L["Mail Expiry Warning"])
	f.ScanMailBody.Text:SetText(L["Scan mail body (marks it as read)"])
	f.CheckMailExpiryAllAccounts.Text:SetText(L["Check mail expiries on all known accounts"])
	f.CheckMailExpiryAllRealms.Text:SetText(L["Check mail expiries on all known realms"])
	f.ReportExpiredMailsToChat.Text:SetText(L["REPORT_EXPIRED_MAILS_LABEL"])
	
	DataStore:SetCheckBoxTooltip(f.CheckMailExpiry, L["EXPIRY_CHECK_TITLE"], L["EXPIRY_CHECK_ENABLED"], L["EXPIRY_CHECK_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.ScanMailBody, L["SCAN_MAIL_BODY_TITLE"], L["SCAN_MAIL_BODY_ENABLED"], L["SCAN_MAIL_BODY_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.CheckMailExpiryAllAccounts, L["EXPIRY_ALL_ACCOUNTS_TITLE"], L["EXPIRY_ALL_ACCOUNTS_ENABLED"], L["EXPIRY_ALL_ACCOUNTS_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.CheckMailExpiryAllRealms, L["EXPIRY_ALL_REALMS_TITLE"], L["EXPIRY_ALL_REALMS_ENABLED"], L["EXPIRY_ALL_REALMS_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.ReportExpiredMailsToChat, L["REPORT_EXPIRED_MAILS_TITLE"], L["REPORT_EXPIRED_MAILS_ENABLED"], L["REPORT_EXPIRED_MAILS_DISABLED"])
	
	-- restore saved options to gui
	DataStoreMailOptions_SliderMailExpiry:SetValue(DataStore:GetOption(addonName, "MailWarningThreshold"))
	DataStoreMailOptions_SliderMailExpiryText:SetText(format("%s (%s)", L["Mail Expiry Warning"], DataStoreMailOptions_SliderMailExpiry:GetValue()))
	f.CheckMailExpiry:SetChecked(DataStore:GetOption(addonName, "CheckMailExpiry"))
	f.ScanMailBody:SetChecked(DataStore:GetOption(addonName, "ScanMailBody"))
	f.CheckMailExpiryAllAccounts:SetChecked(DataStore:GetOption(addonName, "CheckMailExpiryAllAccounts"))
	f.CheckMailExpiryAllRealms:SetChecked(DataStore:GetOption(addonName, "CheckMailExpiryAllRealms"))
	f.ReportExpiredMailsToChat:SetChecked(DataStore:GetOption(addonName, "ReportExpiredMailsToChat"))
end

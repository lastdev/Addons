local addonName, addon = ...

local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local gui = addon.GUI

gui.AlertsDescLabel = gui.AlertsTabPanel:CreateFontString("TLDRMissionsFrameAlertsDescLabel", "OVERLAY", "GameFontNormal")
gui.AlertsDescLabel:SetPoint("TOPLEFT", gui.TitleBarTexture, "BOTTOMLEFT", 5, 0)
gui.AlertsDescLabel:SetText(L["AlertsDesc"])

gui.AlertsSentSuccessfulButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsSentSuccessfulButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsSentSuccessfulButton:SetPoint("TOPLEFT", gui.AlertsDescLabel, 0, -15)
gui.AlertsSentSuccessfulButton.Text:SetText(L["MissonsSentSuccess"])
gui.AlertsSentSuccessfulButton.Text:SetWordWrap(true)
gui.AlertsSentSuccessfulButton.Text:SetWidth(250)
gui.AlertsSentSuccessfulButton.Text:SetJustifyH("LEFT")
gui.AlertsSentSuccessfulButton:HookScript("OnClick", function(self)
    addon.db.profile.alertSentSuccess = self:GetChecked()
end)

gui.AlertsSentSuccessfulEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsSentSuccessfulEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsSentSuccessfulEditBox:SetNumeric(true)
gui.AlertsSentSuccessfulEditBox:SetMaxLetters(10)
gui.AlertsSentSuccessfulEditBox:SetPoint("TOPLEFT", gui.AlertsSentSuccessfulButton, "TOPRIGHT", 150, 0)
gui.AlertsSentSuccessfulEditBox:SetSize(107, 30)
gui.AlertsSentSuccessfulEditBox.Instructions:SetText(L["FileID"])
gui.AlertsSentSuccessfulEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertSentSuccessFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertSentSuccessFileID, "MASTER")
end)

gui.AlertsSentSuccessfulFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsSentSuccessfulFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsSentSuccessfulFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsSentSuccessfulEditBox, "TOPRIGHT", 5, 0)
gui.AlertsSentSuccessfulFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsSentSuccessfulFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsSentSuccessfulFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsSentSuccessfulFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertSentSuccessFlashTaskbar = self:GetChecked()
end)

gui.AlertsSentPartialButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsSentPartialButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsSentPartialButton:SetPoint("TOPLEFT", gui.AlertsSentSuccessfulButton, 0, -25)
gui.AlertsSentPartialButton.Text:SetText(L["MissionsSentPartialAlert"])
gui.AlertsSentPartialButton.Text:SetWordWrap(true)
gui.AlertsSentPartialButton.Text:SetWidth(250)
gui.AlertsSentPartialButton.Text:SetJustifyH("LEFT")
gui.AlertsSentPartialButton:HookScript("OnClick", function(self)
    addon.db.profile.alertSentPartial = self:GetChecked()
end)

gui.AlertsSentPartialEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsSentPartialEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsSentPartialEditBox:SetNumeric(true)
gui.AlertsSentPartialEditBox:SetMaxLetters(10)
gui.AlertsSentPartialEditBox:SetPoint("TOPLEFT", gui.AlertsSentPartialButton, "TOPRIGHT", 150, 0)
gui.AlertsSentPartialEditBox:SetSize(107, 30)
gui.AlertsSentPartialEditBox.Instructions:SetText(L["FileID"])
gui.AlertsSentPartialEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertSentPartialFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertSentPartialFileID, "MASTER")
end)

gui.AlertsSentPartialFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsSentPartialFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsSentPartialFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsSentPartialEditBox, "TOPRIGHT", 5, 0)
gui.AlertsSentPartialFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsSentPartialFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsSentPartialFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsSentPartialFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertSentPartialFlashTaskbar = self:GetChecked()
end)

gui.AlertsZeroHPButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsZeroHPButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsZeroHPButton:SetPoint("TOPLEFT", gui.AlertsSentPartialButton, 0, -25)
gui.AlertsZeroHPButton.Text:SetText(L["ZeroHPAlertsDesc"])
gui.AlertsZeroHPButton.Text:SetWordWrap(true)
gui.AlertsZeroHPButton.Text:SetWidth(250)
gui.AlertsZeroHPButton.Text:SetJustifyH("LEFT")
gui.AlertsZeroHPButton:HookScript("OnClick", function(self)
    addon.db.profile.alertZeroHP = self:GetChecked()
end)

gui.AlertsZeroHPEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsZeroHPEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsZeroHPEditBox:SetNumeric(true)
gui.AlertsZeroHPEditBox:SetMaxLetters(10)
gui.AlertsZeroHPEditBox:SetPoint("TOPLEFT", gui.AlertsZeroHPButton, "TOPRIGHT", 150, 0)
gui.AlertsZeroHPEditBox:SetSize(107, 30)
gui.AlertsZeroHPEditBox.Instructions:SetText(L["FileID"])
gui.AlertsZeroHPEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertZeroHPFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertZeroHPFileID, "MASTER")
end)

gui.AlertsZeroHPFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsZeroHPFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsZeroHPFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsZeroHPEditBox, "TOPRIGHT", 5, 0)
gui.AlertsZeroHPFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsZeroHPFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsZeroHPFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsZeroHPFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertZeroHPFlashTaskbar = self:GetChecked()
end)

gui.AlertsNotEnoughAnimaButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsNotEnoughAnimaButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsNotEnoughAnimaButton:SetPoint("TOPLEFT", gui.AlertsZeroHPButton, 0, -25)
gui.AlertsNotEnoughAnimaButton.Text:SetText(L["NotEnoughAnimaAlert"])
gui.AlertsNotEnoughAnimaButton.Text:SetWordWrap(true)
gui.AlertsNotEnoughAnimaButton.Text:SetWidth(250)
gui.AlertsNotEnoughAnimaButton.Text:SetJustifyH("LEFT")
gui.AlertsNotEnoughAnimaButton:HookScript("OnClick", function(self)
    addon.db.profile.alertNotEnoughAnima = self:GetChecked()
end)

gui.AlertsNotEnoughAnimaEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsNotEnoughAnimaEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsNotEnoughAnimaEditBox:SetNumeric(true)
gui.AlertsNotEnoughAnimaEditBox:SetMaxLetters(10)
gui.AlertsNotEnoughAnimaEditBox:SetPoint("TOPLEFT", gui.AlertsNotEnoughAnimaButton, "TOPRIGHT", 150, 0)
gui.AlertsNotEnoughAnimaEditBox:SetSize(107, 30)
gui.AlertsNotEnoughAnimaEditBox.Instructions:SetText(L["FileID"])
gui.AlertsNotEnoughAnimaEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertNotEnoughAnimaFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertNotEnoughAnimaFileID, "MASTER")
end)

gui.AlertsNotEnoughAnimaFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsNotEnoughAnimaFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsNotEnoughAnimaFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsNotEnoughAnimaEditBox, "TOPRIGHT", 5, 0)
gui.AlertsNotEnoughAnimaFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsNotEnoughAnimaFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsNotEnoughAnimaFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsNotEnoughAnimaFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertNotEnoughAnimaFlashTaskbar = self:GetChecked()
end)

gui.AlertsSentFailureButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsSentFailureButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsSentFailureButton:SetPoint("TOPLEFT", gui.AlertsNotEnoughAnimaButton, 0, -25)
gui.AlertsSentFailureButton.Text:SetText(L["MissionsSentNoneAlert"])
gui.AlertsSentFailureButton.Text:SetWordWrap(true)
gui.AlertsSentFailureButton.Text:SetWidth(250)
gui.AlertsSentFailureButton.Text:SetJustifyH("LEFT")
gui.AlertsSentFailureButton:HookScript("OnClick", function(self)
    addon.db.profile.alertSentFailure = self:GetChecked()
end)

gui.AlertsSentFailureEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsSentFailureEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsSentFailureEditBox:SetNumeric(true)
gui.AlertsSentFailureEditBox:SetMaxLetters(10)
gui.AlertsSentFailureEditBox:SetPoint("TOPLEFT", gui.AlertsSentFailureButton, "TOPRIGHT", 150, 0)
gui.AlertsSentFailureEditBox:SetSize(107, 30)
gui.AlertsSentFailureEditBox.Instructions:SetText(L["FileID"])
gui.AlertsSentFailureEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertSentFailureFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertSentFailureFileID, "MASTER")
end)

gui.AlertsSentFailureFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsSentFailureFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsSentFailureFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsSentFailureEditBox, "TOPRIGHT", 5, 0)
gui.AlertsSentFailureFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsSentFailureFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsSentFailureFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsSentFailureFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertSentFailureFlashTaskbar = self:GetChecked()
end)

gui.AlertsAnimaQuestMissingButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsAnimaQuestMissingButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsAnimaQuestMissingButton:SetPoint("TOPLEFT", gui.AlertsSentFailureButton, 0, -25)
gui.AlertsAnimaQuestMissingButton.Text:SetText(L["CompleteMissionBlockedAlert"])
gui.AlertsAnimaQuestMissingButton.Text:SetWordWrap(true)
gui.AlertsAnimaQuestMissingButton.Text:SetWidth(150)
gui.AlertsAnimaQuestMissingButton.Text:SetJustifyH("LEFT")
gui.AlertsAnimaQuestMissingButton:HookScript("OnClick", function(self)
    addon.db.profile.alertAnimaQuestMissing = self:GetChecked()
end)

gui.AlertsAnimaQuestMissingEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsAnimaQuestMissingEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsAnimaQuestMissingEditBox:SetNumeric(true)
gui.AlertsAnimaQuestMissingEditBox:SetMaxLetters(10)
gui.AlertsAnimaQuestMissingEditBox:SetPoint("TOPLEFT", gui.AlertsAnimaQuestMissingButton, "TOPRIGHT", 150, 0)
gui.AlertsAnimaQuestMissingEditBox:SetSize(107, 30)
gui.AlertsAnimaQuestMissingEditBox.Instructions:SetText(L["FileID"])
gui.AlertsAnimaQuestMissingEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertAnimaQuestMissingFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertAnimaQuestMissingFileID, "MASTER")
end)

gui.AlertsAnimaQuestMissingFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsAnimaQuestMissingFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsAnimaQuestMissingFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsAnimaQuestMissingEditBox, "TOPRIGHT", 5, 0)
gui.AlertsAnimaQuestMissingFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsAnimaQuestMissingFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsAnimaQuestMissingFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsAnimaQuestMissingFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertAnimaQuestMissingFlashTaskbar = self:GetChecked()
end)

gui.AlertsCompleteMissionsButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsCompleteMissionsButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsCompleteMissionsButton:SetPoint("TOPLEFT", gui.AlertsAnimaQuestMissingButton, 0, -25)
gui.AlertsCompleteMissionsButton.Text:SetText(L["CompleteMissionsAlert"])
gui.AlertsCompleteMissionsButton.Text:SetWordWrap(true)
gui.AlertsCompleteMissionsButton.Text:SetWidth(250)
gui.AlertsCompleteMissionsButton.Text:SetJustifyH("LEFT")
gui.AlertsCompleteMissionsButton:HookScript("OnClick", function(self)
    addon.db.profile.alertCompleteMissions = self:GetChecked()
end)

gui.AlertsCompleteMissionsEditBox = CreateFrame("EditBox", "TLDRMissionsFrameAlertsCompleteMissionsEditBox", gui.AlertsTabPanel, "SearchBoxTemplate")
gui.AlertsCompleteMissionsEditBox:SetNumeric(true)
gui.AlertsCompleteMissionsEditBox:SetMaxLetters(10)
gui.AlertsCompleteMissionsEditBox:SetPoint("TOPLEFT", gui.AlertsCompleteMissionsButton, "TOPRIGHT", 150, 0)
gui.AlertsCompleteMissionsEditBox:SetSize(107, 30)
gui.AlertsCompleteMissionsEditBox.Instructions:SetText(L["FileID"])
gui.AlertsCompleteMissionsEditBox:HookScript("OnEnterPressed", function(self)
    addon.db.profile.alertCompleteMissionsFileID = tonumber(self:GetText())
    PlaySoundFile(addon.db.profile.alertCompleteMissionsFileID, "MASTER")
end)

gui.AlertsCompleteMissionsFlashTaskbarButton = CreateFrame("CheckButton", "TLDRMissionsFrameAlertsCompleteMissionsFlashTaskbarButton", gui.AlertsTabPanel, "UICheckButtonTemplate")
gui.AlertsCompleteMissionsFlashTaskbarButton:SetPoint("TOPLEFT", gui.AlertsCompleteMissionsEditBox, "TOPRIGHT", 5, 0)
gui.AlertsCompleteMissionsFlashTaskbarButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(gui.AlertsCompleteMissionsFlashTaskbarButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(L["AlertsFlashTaskbarDesc"])
    GameTooltip:Show()
end)
gui.AlertsCompleteMissionsFlashTaskbarButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
gui.AlertsCompleteMissionsFlashTaskbarButton:HookScript("OnClick", function(self)
    addon.db.profile.alertCompleteMissionsFlashTaskbar = self:GetChecked()
end)

function addon.triggerSentSuccessAlert()
    if not addon.db.profile.alertSentSuccess then return end
    if not addon.db.profile.alertSentSuccessFileID then return end
    if type(addon.db.profile.alertSentSuccessFileID) ~= "number" then return end
    if addon.db.profile.alertSentSuccessFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertSentSuccessFileID, "MASTER")
    
    if addon.db.profile.alertSentSuccessFlashTaskbar then
        FlashClientIcon()
    end
end

function addon.triggerSentPartialAlert()
    if not addon.db.profile.alertSentPartial then return end
    if not addon.db.profile.alertSentPartialFileID then return end
    if type(addon.db.profile.alertSentPartialFileID) ~= "number" then return end
    if addon.db.profile.alertSentPartialFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertSentPartialFileID, "MASTER")
    
    if addon.db.profile.alertSentPartialFlashTaskbar then
        FlashClientIcon()
    end
end

function addon.triggerZeroHPAlert()
    if not addon.db.profile.alertZeroHP then return end
    if not addon.db.profile.alertZeroHPFileID then return end
    if type(addon.db.profile.alertZeroHPFileID) ~= "number" then return end
    if addon.db.profile.alertZeroHPFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertZeroHPFileID, "MASTER")
    
    if addon.db.profile.alertZeroHPFlashTaskbar then
        FlashClientIcon()
    end
end

function addon.triggerNotEnoughAnimaAlert()
    if not addon.db.profile.alertNotEnoughAnima then return end
    if not addon.db.profile.alertNotEnoughAnimaFileID then return end
    if type(addon.db.profile.alertNotEnoughAnimaFileID) ~= "number" then return end
    if addon.db.profile.alertNotEnoughAnimaFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertNotEnoughAnimaFileID, "MASTER")
    
    if addon.db.profile.alertNotEnoughAnimaFlashTaskbar then
        FlashClientIcon()
    end
end

function addon.triggerSentFailureAlert()
    if not addon.db.profile.alertSentFailure then return end
    if not addon.db.profile.alertSentFailureFileID then return end
    if type(addon.db.profile.alertSentFailureFileID) ~= "number" then return end
    if addon.db.profile.alertSentFailureFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertSentFailureFileID, "MASTER")
    
    if addon.db.profile.alertSentFailureFlashTaskbar then
        FlashClientIcon()
    end
end

function addon.triggerAnimaQuestMissingAlert()
    if not addon.db.profile.alertAnimaQuestMissing then return end
    if not addon.db.profile.alertAnimaQuestMissingFileID then return end
    if type(addon.db.profile.alertAnimaQuestMissingFileID) ~= "number" then return end
    if addon.db.profile.alertAnimaQuestMissingFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertAnimaQuestMissingFileID, "MASTER")
    
    if addon.db.profile.alertAnimaQuestMissingFlashTaskbar then
        FlashClientIcon()
    end
end

function addon.triggerCompleteMissionsAlert()
    if not addon.db.profile.alertCompleteMissions then return end
    if not addon.db.profile.alertCompleteMissionsFileID then return end
    if type(addon.db.profile.alertCompleteMissionsFileID) ~= "number" then return end
    if addon.db.profile.alertCompleteMissionsFileID < 1 then return end
    
    PlaySoundFile(addon.db.profile.alertCompleteMissionsFileID, "MASTER")
    
    if addon.db.profile.alertCompleteMissionsFlashTaskbar then
        FlashClientIcon()
    end
end


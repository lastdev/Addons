local AddonName, Addon = ...
local L = Addon:GetLocale()
local UI = Addon.CommonUI.UI
local Encoder = Addon.Features.Import.Encoder
local Info = Addon.Systems.Info
local ImportDialog = {}



local ImportHandlers = {
    customlist = "Features.Import.ImportList",
    customrule = "Features.Import.ImportRule"
}

function ImportDialog:OnInitDialog(dialog, importString)

    self:SetButtonState({ import = false, cancel = true })
end

function ImportDialog:OnShow()
end

function ImportDialog:OnHide()
end

--[[ Shows the invalid text string ]]
function ImportDialog:ShowInvalidPayload(show)
    if (show) then
        self.invalid:Show()
        self.import:SetPoint("BOTTOMRIGHT", self.invalid, "TOPRIGHT", 0, 12)
    else
        self.invalid:Hide()
        self.import:SetPoint("BOTTOMRIGHT")
    end
end
function ImportDialog:OnImportText(text)
    if (type(text)) == "string" then
        text = Addon.StringTrim(text)
    end

    if (type(text) ~= "string" or string.len(text) == 0) then
        self:ShowInvalidPayload(false)
        return
    end
    

    if (not Encoder.VerifyString(text)) then

        self:ShowInvalidPayload(true)
    else
        self:ShowInvalidPayload(false)
    end

    local import = Encoder.Decode(text)
    if (type(import) == "table") then



        if (not Info:CheckReleaseForClient(import.Release)) then

            self:MessageBox("IMPORT_ERROR_CAPTION", "IMPORT_MISMATCH_RELEASE", { CLOSE })
            return
        end

        if (import.Version ~= Addon.Features.Import.CURRENT_EXPORT_VERSION) then

            self:MessageBox("IMPORT_ERROR_CAPTION", "IMPORT_OUTDATED_VERSION", { CLOSE })
            return
        end
        
        local handler = ImportHandlers[import.Content]

        if (not handler) then

            self:MessageBox("IMPORT_ERROR_CAPTION", "IMPORT_UNKNOWN_CONTENT", { CLOSE })
            return
        end

        handler = UI.Resolve(handler)
        if (not handler) then

            self:MessageBox("IMPORT_ERROR_CAPTION", "IMPORT_UNKNOWN_CONTENT", { CLOSE })
            return
        end

        if (not handler:Validate(import)) then

            self:MessageBox("IMPORT_ERROR_CAPTION", "IMPORT_PAYLOAD_ERROR", { CLOSE })
            return
        else

        end

        local frame = handler:CreateUI(self, import)
        self.handler = handler
        self.payload = import

        self.import:Hide()
        self.help:Hide()
        self.invalid:Hide()
        frame:SetPoint("TOPLEFT", self, "TOPLEFT")
        frame:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
        frame:Show()

        local buttons = {}
        buttons.cancel = true
        buttons.confirm = true

        self:SetButtonState(buttons)
    end
end

--[[ Handle importing the actual data ]]
function ImportDialog:DoImport()
    if (self.handler) then
        self.handler:Import(self.payload)
        self:Close()
    end
end

--[[ Show the export dialog with the contents provided ]]
function Addon.Features.Import:ShowImportDialog(importString)
    local dialog = UI.Dialog("IMPORT_DIALOG_CAPTION", "Import_ImportDialog", ImportDialog, {
            { id="cancel", label = L["EXPORT_CLOSE_BUTTON"], handler = "Hide" },
            { id="confirm", label = L["DIALOG_TEXT_CONFIRM"], handler="DoImport" }
        }, importString)

    dialog:Show()
    dialog:Raise()
end
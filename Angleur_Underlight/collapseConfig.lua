local T = AngleurUnderlight_Translate
local colorUnderlight = CreateColor(0.9, 0.8, 0.5)
local colorYello = CreateColor(1.0, 0.82, 0.0)
local colorBlu = CreateColor(0.61, 0.85, 0.92)
local colorDarkBlu = CreateColor(0.35, 0.45, 0.92)
local colorGrae = CreateColor(0.85, 0.85, 0.85)


function AngleurUnderlight_CollapseConfig_LoadSavedVars(config)
    config.popup.checkboxes.savedVarTable = AngleurUnderlightConfig
    config.popup.checkboxes.checkbox1.reference = "waterwalking"
    config.popup.checkboxes.checkbox2.reference = "delveMode"
    config.popup.checkboxes:Update()
end

function AngleurUnderlight_CollapseConfig_OnLoad(self)
    self.tooltip = T["Open Config"]

    self.icon:SetTexture("Interface/BUTTONS/UI-OptionsButton")
    self.popup.title:SetText(colorUnderlight:WrapTextInColorCode(T["Angleur_Underlight Config"]))

    self.popup.checkboxes.checkbox1.text:SetText(T["Waterwalking"])
    self.popup.checkboxes.checkbox1.text.tooltip = T["While " .. colorBlu:WrapTextInColorCode("Angleur ") .. "is " .. colorGrae:WrapTextInColorCode("Sleeping")
    .. ", won't re-equip \'Main\' Fishing Rod " .. "when you stop swimming - allowing you to waterwalk.\n\nWhen you " 
    .. colorYello:WrapTextInColorCode("wake ") .. colorBlu:WrapTextInColorCode("Angleur ") .. "up, your \'Main\' Fishing Rod will be equipped back."]
    self.popup.checkboxes.checkbox1:reposition()
    self.popup.checkboxes.checkbox1.disabledText:SetText(T["Disabled.\n" .. "Needs " .. colorBlu:WrapTextInColorCode("Angleur\n") .. "to function."])
    if not AngleurUnderlight_AngLoaded then
        self.popup.checkboxes.checkbox1:greyOut()
    end

    self.popup.checkboxes.checkbox2.text:SetText(T["Delve Mode"])
    self.popup.checkboxes.checkbox2.text.tooltip = T["Keeps the fish form active while submerged inside " .. colorDarkBlu:WrapTextInColorCode("Underwater Delves,") 
    .. " allowing for infinite breath.\n\n" .."Won't be able to re-equip " .. "\'Main\' Fishing Rod inside the delve while active."]
    self.popup.checkboxes.checkbox2:reposition()

end





local THIS_VERSION = GetAddOnMetadata("ReagentBanker", "Version")
local THIS_TITLE = GetAddOnMetadata("ReagentBanker", "Title")
local L = REAGENTBANKER_STRINGS

local TabKeySelectDropDown

ReagentBanker.DefaultSettings = {
	Version = THIS_VERSION,
	autoDeposit = false,
	depositModifierKey = 2,
	reagentTabIsDefault = false,
	openTabModifierKey = 2,
	includeIgnoredAuto = false,
	includeIgnoredButton = false,
	chatLogDeposits = true,
}

local function UpdateLabelTab()
  local KEYTIP
  if (ReagentBanker_Settings.reagentTabIsDefault) then
    ReagentBanker_DirectTabModDropdown:SetLabel(L.TAB_MODIFIERKEY_LABEL_DONOT)
	KEYTIP = L.TAB_MODIFIERKEY_TOOLTIP_KEY_DONOT
  else
    ReagentBanker_DirectTabModDropdown:SetLabel(L.TAB_MODIFIERKEY_LABEL_DO)
    KEYTIP = L.TAB_MODIFIERKEY_TOOLTIP_KEY_DO
  end
  for k,v in ipairs(TabKeySelectDropDown) do
    if (v.key) then
      v.tooltipText = KEYTIP:format(v.key)
	end
  end
end

local function UpdateLabelDeposit()
  local KEYTIP
  if (ReagentBanker_Settings.autoDeposit) then
    ReagentBanker_DepositModDropdown:SetLabel(L.DEPOSIT_MODIFIERKEY_LABEL_DONOT)
	KEYTIP = L.DEPOSIT_MODIFIERKEY_TOOLTIP_KEY_DONOT
  else
    ReagentBanker_DepositModDropdown:SetLabel(L.DEPOSIT_MODIFIERKEY_LABEL_DO)
    KEYTIP = L.DEPOSIT_MODIFIERKEY_TOOLTIP_KEY_DO
  end
  for k,v in ipairs(DepositKeySelectDropDown) do
    if (v.key) then
      v.tooltipText = KEYTIP:format(v.key)
	end
  end
end

function ReagentBanker.CreateOptions()
	--local KEY, KEYTIP = L.KEY, L.TAB_MODIFIERKEY_TOOLTIP_KEY
	local KEY = L.KEY
	TabKeySelectDropDown = {
		{
			text = KEY:format(L.ALT),
			tooltipTitle = KEY:format(L.ALT),
			--tooltipText = KEYTIP:format(L.ALT),
			key = L.ALT,
			value = 0
		},
		{
			text = KEY:format(L.CTRL),
			tooltipTitle = KEY:format(L.CTRL),
			--tooltipText = KEYTIP:format(L.CTRL),
			key = L.CTRL,
			value = 1
		},
		{
			text = KEY:format(L.SHIFT),
			tooltipTitle = KEY:format(L.SHIFT),
			--tooltipText = KEYTIP:format(L.SHIFT),
			key = L.SHIFT,
			value = 2
		},
		{
			text = L.MODIFIERKEY_NONE,
			tooltipTitle = L.MODIFIERKEY_NONE,
			tooltipText = L.MODIFIERKEY_NONE_TOOLTIP,
			value = 3
		}
	}
	DepositKeySelectDropDown = {
		{
			text = KEY:format(L.ALT),
			tooltipTitle = KEY:format(L.ALT),
			--tooltipText = KEYTIP:format(L.ALT),
			key = L.ALT,
			value = 0
		},
		{
			text = KEY:format(L.CTRL),
			tooltipTitle = KEY:format(L.CTRL),
			--tooltipText = KEYTIP:format(L.CTRL),
			key = L.CTRL,
			value = 1
		},
		{
			text = KEY:format(L.SHIFT),
			tooltipTitle = KEY:format(L.SHIFT),
			--tooltipText = KEYTIP:format(L.SHIFT),
			key = L.SHIFT,
			value = 2
		},
		{
			text = L.MODIFIERKEY_NONE,
			tooltipTitle = L.MODIFIERKEY_NONE,
			tooltipText = L.MODIFIERKEY_NONE_TOOLTIP,
			value = 3
		}
	}

	local items = {
  		 { variable = "autoDeposit", text = L.AUTODEPOSIT, OnChange = UpdateLabelDeposit },
  		 { variable = "depositModifierKey", type = "dropdown", name = "ReagentBanker_DepositModDropdown",
  		   text = L.TAB_MODIFIERKEY_LABEL_DONOT, menu = DepositKeySelectDropDown, width = 85 },

  		 { variable = "reagentTabIsDefault", text = L.REAGENT_TAB_DEFAULT, OnChange = UpdateLabelTab },
  		 { variable = "openTabModifierKey", type = "dropdown", name = "ReagentBanker_DirectTabModDropdown",
  		   text = L.DEPOSIT_MODIFIERKEY_LABEL_DONOT, menu = TabKeySelectDropDown, width = 85 },

  		 { variable = "chatLogDeposits", type = "checkbox", text = L.CHATLOG_SHOW_DEPOSITED, topBuffer = 10,
		   OnChange = ReagentBanker.UpdateOptionChatLog },

  		 { type = "label", text = L.DEPOSIT_IGNORED_LABEL, topBuffer = 10 },
  		 { variable = "includeIgnoredAuto", type = "checkbox", text = L.DEPOSIT_IGNORED_AUTO, tooltip = L.DEPOSIT_IGNORED_AUTO_TIP },
		 { variable = "includeIgnoredButton", type = "checkbox", text = L.DEPOSIT_IGNORED_BUTTON, tooltip = L.DEPOSIT_IGNORED_BUTTON_TIP },
	}

	local mainpanel, oldver = TjOptions.CreatePanel(THIS_TITLE, nil, {
		title = THIS_TITLE.." v"..THIS_VERSION,
		--itemspacing = 3,
		--scrolling = true,
		items = items,
		variables = "ReagentBanker_Settings",
		defaults = ReagentBanker.DefaultSettings,
		OnShow = function()  UpdateLabelTab(); UpdateLabelDeposit();  end,
	});

	return mainpanel, oldver
end

function ReagentBanker.UpdateOptionChatLog()
	if (ReagentBanker_Settings.chatLogDeposits) then
		ReagentBanker.Frame:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
	else
		ReagentBanker.Frame:UnregisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
	end
end

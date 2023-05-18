local _, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom

local statusbar_dropdown = CreateFrame(
  "Button",
  "DFH_StatusbarDropdown",
  UIParent,
  "UIDropDownMenuTemplate"
)

function statusbar_dropdown:init(parent, current_name)
  self:SetParent(parent)

  local update_statusbar = function(_, name, value)
    UIDropDownMenu_SetSelectedName(statusbar_dropdown, name)
    event_manager:handle(custom_events.STATUSBAR_TEXTURE_CHANGED, name, value)
  end

  UIDropDownMenu_SetInitializeFunction(self, function()
    for _, name in ipairs(ns.media.shared:List("statusbar")) do
      local info = UIDropDownMenu_CreateInfo()
      local value = ns.media.shared:Fetch("statusbar", name)

      info.text = name
      info.value = value
      info.arg1 = name
      info.arg2 = value
      info.func = update_statusbar

      UIDropDownMenu_AddButton(info)
    end
  end)

  UIDropDownMenu_SetSelectedName(statusbar_dropdown, current_name)
  UIDropDownMenu_SetText(statusbar_dropdown, current_name)

  return self
end

ns.config.statusbar_dropdown = statusbar_dropdown

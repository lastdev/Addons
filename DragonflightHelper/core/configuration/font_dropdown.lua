local _, ns = ...
local media = ns.media
local event_manager = ns.events.manager
local custom_events = ns.events.custom

local font_dropdown = CreateFrame(
  "Button",
  "DFH_FontDropdown",
  UIParent,
  "UIDropDownMenuTemplate"
)

function font_dropdown:init(parent, current_font)
  self:SetParent(parent)

  local update_font = function(_, name, value)
    UIDropDownMenu_SetSelectedName(font_dropdown, name)
    event_manager:handle(custom_events.FONT_CHANGED, name, value)
  end

  UIDropDownMenu_SetInitializeFunction(self, function()
    for _, name in ipairs(ns.media.shared:List("font")) do
      local info = UIDropDownMenu_CreateInfo()
      local value = media:get_font_object(name)

      info.text = name
      info.value = value
      info.arg1 = name
      info.arg2 = value
      info.fontObject = media:get_font_object(name)
      info.func = update_font

      UIDropDownMenu_AddButton(info)
    end
  end)

  UIDropDownMenu_SetSelectedName(font_dropdown, current_font)
  UIDropDownMenu_SetText(self, current_font)

  return self
end

ns.config.font_dropdown = font_dropdown

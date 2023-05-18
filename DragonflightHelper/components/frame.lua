local _, ns = ...
local components = ns.components

local media = ns.media.shared

function components:frame(config)
  config = config or {}

  local type = config.type or "Frame"
  local name = config.name
  local parent = config.parent or UIParent
  local template = config.template or "BackdropTemplate"

  local frame = CreateFrame(type, name, parent, template)

  if template == "BackdropTemplate" then
    frame:SetBackdrop({
      bgFile = media:Fetch("background", "Solid"),
      insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    frame:SetBackdropColor(0, 0, 0, 0.7)
  end

  local w = config.width or 0
  local h = config.height or 0

  frame:SetSize(w, h)

  return frame
end

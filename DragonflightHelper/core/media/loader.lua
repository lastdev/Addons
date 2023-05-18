local addon, ns = ...

local LSM = LibStub("LibSharedMedia-3.0")
local media = {}

function media:init()
  self.fonts = {}
  self.statusbars = {}
end

function media:get_font_object(font)
  if self.fonts[font] == nil then
    self.fonts[font] = CreateFont(addon .. "_font_" .. font)
    self.fonts[font]:SetFont(LSM:Fetch("font", font), 12, "")
  end

  return self.fonts[font] or self.fonts[self:get_default_font()]
end

function media:get_statusbar(statusbar)
  if self.statusbars[statusbar] == nil then
    self.statusbars[statusbar] = LSM:Fetch("statusbar", statusbar)
  end

  return self.statusbars[statusbar]
end

function media:get_default_font()
  return LSM:GetDefault("font")
end

function media:get_default_statusbar()
  return LSM:GetDefault("statusbar")
end

media:init()
ns.media = media
ns.media.shared = LSM

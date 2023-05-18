local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media

DFH_SectionTitleMixin = {}

local id = 0

function DFH_SectionTitleMixin:OnLoad()
  if self.title == nil then
    self.title = ""
  end

  self.id = addon .. "_title_" .. id
  id = id + 1

  event_manager:subscribe(self, { custom_events.FONT_CHANGED, custom_events.THEME_LOADED }, self.id)
end

function DFH_SectionTitleMixin:notify(event_name, ...)
  if event_name == custom_events.FONT_CHANGED then
    local _, font_object = ...
    self.Title:SetFontObject(font_object)
    self:SetTitle(self.title)
  else
    local font_name = ...
    local font_object = media:get_font_object(font_name)

    self.Title:SetFontObject(font_object)
    self:SetTitle(self.title)
  end
end

function DFH_SectionTitleMixin:SetTitle(title)
  self.title = title

  self.Title:SetText(self.title)
end

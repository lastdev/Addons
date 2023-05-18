local _, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media

local theme = {}

function theme:init()
  self.sections = {
    ["FACTIONS"] = "FACTIONS",
    ["TIMERS"] = "TIMERS",
    ["TODOS"] = "TODOS",
    ["PROFESSIONS"] = "PROFESSIONS",
  }

  event_manager:subscribe(
    self,
    {
      "ADDON_LOADED",
      custom_events.STATUSBAR_TEXTURE_CHANGED,
      custom_events.FONT_CHANGED,
      custom_events.BACKGROUND_OPACITY_CHANGED,
      custom_events.SECTION_SELECTION_CHANGED,
      custom_events.FRAME_SHOWING_CHANGED,
      custom_events.FRAME_LOCKED_CHANGED
    },
    "Theme"
  )

  return self
end

function theme:notify(event_name, ...)
  if event_name == "ADDON_LOADED" then
    event_manager:unsubscribe(self, "ADDON_LOADED")

    self.config = DRAGONFLIGHT_HELPER_CONFIG.theme or {}
    event_manager:handle(
      custom_events.THEME_LOADED,
      self:get_font(),
      self:get_statusbar(),
      self:get_background_opacity(),
      self:get_is_showing(),
      self:get_is_locked(),
      self:get_sections()
    )
  elseif event_name == custom_events.STATUSBAR_TEXTURE_CHANGED then
    self.config.statusbar = ...
  elseif event_name == custom_events.FONT_CHANGED then
    self.config.font = ...
  elseif event_name == custom_events.SECTION_SELECTION_CHANGED then
    local section, enabled = ...
    self.config.sections[section] = enabled
  elseif event_name == custom_events.FRAME_SHOWING_CHANGED then
    self.config.showing = ...
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self.config.background_opacity = math.floor(... * 100) / 100
  elseif event_name == custom_events.FRAME_LOCKED_CHANGED then
    self.config.locked = ...
  end
end

function theme:get_font()
  return self.config.font or media:get_default_font()
end

function theme:get_statusbar()
  return self.config.statusbar or media:get_default_statusbar()
end

function theme:get_background_opacity()
  return self.config.background_opacity or 0.5
end

function theme:get_is_showing()
  if self.config.showing == nil then
    self.config.showing = true
  end

  return self.config.showing
end

function theme:get_is_locked()
  if self.config.locked == nil then
    self.config.locked = true
  end

  return self.config.locked
end

function theme:get_sections()
  if self.config.sections == nil then
    self.config.sections = {}

    for key, _ in pairs(self.sections) do
      self.config.sections[key] = true
    end
  end

  return self.config.sections
end

ns.theme = theme:init()

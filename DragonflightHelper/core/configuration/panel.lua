local _, ns = ...

local event_manager = ns.events.manager
local ui_components = ns.components
local custom_events = ns.events.custom
local theme = ns.theme

local font_dropdown = ns.config.font_dropdown
local statusbar_dropdown = ns.config.statusbar_dropdown
local section_selector = ns.config.section_selector
local opacity_slider = ns.config.opacity_slider

local addon_configuration = ui_components:frame({
  name = "DFH_Configuration", width = 200, height = 500
})

function addon_configuration:init()
  self.name = "Dragonflight Helper Configuration"
  self.showing = false

  event_manager:subscribe(
    self,
    {
      custom_events.OPEN_CONFIG,
      custom_events.THEME_LOADED,
      custom_events.BACKGROUND_OPACITY_CHANGED
    },
    self.name
  )
end

function addon_configuration:initialize_frames(font, statusbar, opacity, sections)
  self:SetBackdropColor(0, 0, 0, opacity)

  self.font_dropdown = font_dropdown:init(self, font)
  self.font_dropdown:SetPoint("TOPLEFT", self, "TOPLEFT", -15, -5)
  self.font_dropdown:SetPoint("RIGHT", self, "RIGHT")
  UIDropDownMenu_SetWidth(self.font_dropdown, self:GetWidth() - 24)

  self.statusbar_dropdown = statusbar_dropdown:init(self, statusbar)
  self.statusbar_dropdown:SetPoint("TOPLEFT", self.font_dropdown, "BOTTOMLEFT")
  self.statusbar_dropdown:SetPoint("RIGHT", self, "RIGHT")
  UIDropDownMenu_SetWidth(self.statusbar_dropdown, self:GetWidth() - 24)

  self.opacity_slider = opacity_slider:init(self, opacity)
  self.opacity_slider:SetPoint("TOP", self.statusbar_dropdown, "BOTTOM", 0, -20)
  self.opacity_slider:SetPoint("LEFT", self, "LEFT", 30)
  self.opacity_slider:SetPoint("RIGHT", self, "RIGHT", -50)
  -- self.section_selector = section_selector:init(self, sections)
  -- self.section_selector:SetPoint("TOP", self.statusbar_dropdown, "BOTTOM")
  -- self.section_selector:SetPoint("LEFT", self, "LEFT")
  -- self.section_selector:SetPoint("RIGHT", self, "RIGHT")
end

function addon_configuration:notify(event_name, ...)
  if event_name == custom_events.OPEN_CONFIG then
    self:SetPoint("TOPLEFT", ..., "TOPRIGHT")

    self.showing = not self.showing

    if self.showing then
      self:Show()
    else
      self:Hide()
    end
  elseif event_name == custom_events.THEME_LOADED then
    self:initialize_frames(...)
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self:SetBackdropColor(0, 0, 0, ...)
  end
end

addon_configuration:init()
ns.config.panel = addon_configuration

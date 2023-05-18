local _, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom

local opacity_slider = CreateFrame(
  "Frame",
  "DFH_SectionSelectorFrame"
)

function opacity_slider:init(parent, current_opacity)
  self:SetParent(parent)
  self:SetHeight(40)

  self.slider = CreateFrame(
    "Slider",
    "DFH_OpacitySlider",
    self,
    "OptionsSliderTemplate"
  )

  self.slider:SetOrientation("HORIZONTAL")
  self.slider:SetHeight(15)
  self.slider:SetMinMaxValues(0, 1)
  self.slider:SetValue(current_opacity)
  self.slider:SetValueStep(0.01)
  self.slider:SetObeyStepOnDrag(true)

  self.slider.Text:SetText("Background Opacity (" .. current_opacity * 100 .. "%)")
  self.slider.High:SetText("")
  self.slider.Low:SetText("")

  self.slider:SetPoint("TOP")
  self.slider:SetPoint("LEFT", self, "LEFT", 20)
  self.slider:SetPoint("RIGHT", self, "RIGHT", -20)

  self.slider:SetScript("OnValueChanged", function(_, value)
    self.slider.Text:SetText("Background Opacity (" .. math.floor(value * 100) .. "%)")

    event_manager:handle(custom_events.BACKGROUND_OPACITY_CHANGED, value)
  end)

  return self
end

ns.config.opacity_slider = opacity_slider

local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom

local section_selector = CreateFrame(
  "Frame",
  "DFH_SectionSelectorFrame"
)

function section_selector:init(parent, current_sections)
  self:SetParent(parent)

  local title = self:CreateFontString(nil, "OVERLAY", "GameTooltipText")
  title:SetText("Show/Hide Sections")
  title:SetJustifyH("CENTER")
  title:SetPoint("TOPLEFT")
  title:SetPoint("RIGHT")

  self:SetHeight(title:GetStringHeight())

  local previous = title

  for section, enabled in pairs(current_sections) do
    local option_frame = CreateFrame("Frame", nil, self)
    option_frame:SetHeight(30)
    option_frame:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    option_frame:SetPoint("RIGHT", self, "RIGHT")
    previous = option_frame

    local option = CreateFrame(
      "CheckButton",
      addon .. "_" .. section .. "_section_selector_checkbox",
      option_frame,
      "UICheckButtonTemplate"
    )
    option:SetChecked(enabled)
    option:SetPoint("TOPLEFT", 0)
    option:SetScript("OnClick", function(checkbox)
      event_manager:handle(custom_events.SECTION_SELECTION_CHANGED, section, checkbox:GetChecked())
    end)

    local label = option_frame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    label:SetText(section:sub(1, 1) .. section:sub(2, section:len()):lower())
    label:SetPoint("TOPLEFT", option_frame, "TOPLEFT", 40, -8)

    self:SetHeight(option_frame:GetHeight() + self:GetHeight())
  end

  return self
end

ns.config.section_selector = section_selector

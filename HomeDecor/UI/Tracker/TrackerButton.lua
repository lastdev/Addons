local ADDON, NS = ...

NS.UI = NS.UI or {}
NS.UI.Tracker = NS.UI.Tracker or {}

local Tracker = NS.UI.Tracker

local TrackerButton = NS.UI.TrackerButton or {}
NS.UI.TrackerButton = TrackerButton

function TrackerButton:Attach(parent)
  local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
  button:SetSize(70, 22)

  local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  text:SetPoint("CENTER")
  text:SetText("Tracker")
  button.text = text

  button:SetScript("OnClick", function()
    if Tracker and Tracker.Toggle then
      Tracker:Toggle(parent)
    end
  end)

  return button
end

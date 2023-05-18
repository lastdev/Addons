DFH_TimerMixin = {}

function DFH_TimerMixin:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)

  self.color = ITEM_QUALITY_COLORS[self.colorIndex]
  self.thresholdColor = ITEM_QUALITY_COLORS[2]

  self:SetTitle(self.title)
  self:SetReverseFill()
  self:SetMinMaxValues(0, self.frequency * 60 * 60)
  self:SetForegroundColor(self.color.r, self.color.g, self.color.b, 1)

  local waypoint = {
    map = self.tt_map,
    x = self.tt_x / 100,
    y = self.tt_y / 100,
    options = { title = self.tt_title }
  }

  self:SetClickCallback(function()
    if TomTom == nil then
      DFH_Utilities.error("TomTom required to use this functionality")
    end

    TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
  end)
end

function DFH_TimerMixin:OnShow()
  self:Update()
  self.timer = C_Timer.NewTimer(30, function() self:Update() end)
end

function DFH_TimerMixin:OnHide()
  -- no op now
end

function DFH_TimerMixin:Update()
  local interval = self.frequency * 60 * 60
  local secondsUntilNextEvent = (C_DateAndTime.GetSecondsUntilDailyReset() / interval) % 1 * interval

  local aboutToStart = secondsUntilNextEvent <= (10 * 60)
  local inProgress = (interval - secondsUntilNextEvent) <= (self.activeThreshold * 60)

  if aboutToStart then
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, 10 * 60)
    self:SetValue(secondsUntilNextEvent)
    self:SetDescription("About to start - " .. SecondsToTime(secondsUntilNextEvent))
  elseif inProgress then
    self:SetForegroundColor(self.thresholdColor.r, self.thresholdColor.g, self.thresholdColor.b)
    self:SetMinMaxValues(0, self.activeThreshold * 60)
    self:SetValue(interval - secondsUntilNextEvent)
    self:SetDescription("Active - " ..
      SecondsToTime((interval - secondsUntilNextEvent), true))
  else
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, interval)
    self:SetValue(secondsUntilNextEvent)
    self:SetDescription(SecondsToTime(secondsUntilNextEvent, true))
  end

  if aboutToStart then
    self.timer = C_Timer.NewTimer(1, function() self:Update() end)
  else
    self.timer = C_Timer.NewTimer(30, function() self:Update() end)
  end
end

DFH_FeastTimerMixin = CreateFromMixins(DFH_TimerMixin)
DFH_SiegeTimerMixin = CreateFromMixins(DFH_TimerMixin)

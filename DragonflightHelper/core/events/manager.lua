local addon, ns = ...
local EventSubscriber = ns.events.subscriber

local event_manager = {}

function event_manager:init()
  self.events = {}
  self.subscriber_map = {}
  self.initialized = false

  self.event_frame = CreateFrame("Frame")
  self.event_frame:SetScript("OnEvent", function(_, ...) self:handle(...) end)

  self:subscribe(self, "ADDON_LOADED", "Event Manager")
end

function event_manager:notify(event_name, ...)
  if ... == addon then
    self.initialized = true
    self:unsubscribe(self, event_name)
  end
end

function event_manager:handle(event_name, ...)
  if event_name == "ADDON_LOADED" and addon == ... then
    self:notify(event_name, ...)
  end

  if not self.initialized then
    return
  end

  if self.events[event_name] and self.events[event_name].event_count > 0 then
    for subscriber_identifier, _ in pairs(self.events[event_name]) do
      if subscriber_identifier ~= "event_count" then
        self.subscriber_map[subscriber_identifier].component:notify(event_name, ...)
      end
    end
  end
end

function event_manager:get_subscriber(name, component)
  local item = self.subscriber_map[EventSubscriber.id_for(component)]

  if item then
    return true, item
  else
    return pcall(function() return EventSubscriber:new(name, component) end)
  end
end

function event_manager:subscribe(component, events, name)
  local status, subscriber = self:get_subscriber(name, component)

  if type(events) == "string" then
    events = { events }
  end

  if not status then
    error("Error occurred creating subscriber for " .. name .. " (" .. #events .. ")")
    return
  end

  for _, event in ipairs(events) do
    self.events[event] = self.events[event] or { event_count = 0 }
    subscriber:add_event(event)

    self.subscriber_map[subscriber:id()] = subscriber
    self.events[event][subscriber:id()] = true
    self.events[event].event_count = self.events[event].event_count + 1

    if not ns.events.custom[event] then
      self.event_frame:RegisterEvent(event)
    end
  end
end

function event_manager:unsubscribe(component, event)
  local subscriber = self.subscriber_map[EventSubscriber.id_for(component)]

  if subscriber == nil or self.events[event] == nil then
    return
  end

  subscriber:remove_event(event)
  self.events[event][subscriber:id()] = nil
  self.events[event].event_count = self.events[event].event_count - 1

  if self.events[event].event_count == 0 and not ns.events.custom[event] then
    self.event_frame:UnregisterEvent(event)
  end
end

function event_manager:debug()
  print("** REGISTERED EVENTS **")
  for key, value in pairs(self.events) do
    print(string.format("%s (%d)", key, value.event_count))
  end
end

event_manager:init()
ns.events.manager = event_manager

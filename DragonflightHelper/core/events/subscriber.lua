local _, ns = ...

local subscriber = {}

function subscriber.id_for(component)
  if type(component) == "table" then
    return tostring(component)
  else
    error("Subscribers can only be created from tables")
  end
end

function subscriber:new(name, component)
  if component.notify == nil then
    error(name .. " does not implement the required `notify` method")
  end

  local o = {
    name = name,
    component = component,
    count = 0,
    events = {}
  }

  setmetatable(o, self)
  self.__index = self

  return o
end

function subscriber:id()
  return subscriber.id_for(self.component)
end

function subscriber:add_event(event_name)
  self.events[event_name] = true
  self.count = self.count + 1
end

function subscriber:remove_event(event_name)
  self.events[event_name] = nil
  self.count = self.count - 1
end

function subscriber:__tostring()
  local event_list = ""

  for key, value in pairs(self.events) do
    event_list = key .. " " .. tostring(value) .. ", "
  end

  return string.format("<%s> %s (%d) {%s}", self:id(), self.name, self.count, event_list:sub(1, event_list:len() - 2))
end

ns.events.subscriber = subscriber

local addonName, shared = ...;

if LibStub == nil then return end

shared.HandyNotes = LibStub('AceAddon-3.0'):GetAddon('HandyNotes', true)

if shared.HandyNotes == nil then return end

shared.addon = {};

local addon = shared.addon;

-- event handling
do
  local events = {};
  local addonFrame = CreateFrame('frame');

  addon.on = function (eventList, callback)
    if (type(eventList) ~= 'table') then
      eventList = {eventList};
    end

    for x = 1, #eventList, 1 do
      local event = eventList[x];
      local list = events[event];

      if (list == nil) then
        events[event] = {callback};
        addonFrame:RegisterEvent(event);
      else
        list[#list + 1] = callback;
      end
    end
  end

  local function eventHandler (self, event, ...)
    for i = 1, #events[event] do
      events[event][i](...);
    end
  end

  addonFrame:SetScript('OnEvent', eventHandler);
end

-- event funnel
addon.funnel = function (eventList, timeSpan, callback)
  local flag = false;

  local funnel = function (...)
    local args = {...};

    if (flag == false) then
      flag = true;

      C_Timer.After(timeSpan, function ()
        flag = false;
        callback(unpack(args));
      end);
    end
  end

  addon.on(eventList, funnel);

  -- returning funnel for manual call
  return funnel;
end

-- export and import handling
do
  local modules = {};

  addon.export = function (moduleName, module)
    modules[moduleName] = module;
  end

  addon.import = function (moduleName)
    return modules[moduleName];
  end
end

-- internal message handling
do
  local callbacks = {};

  addon.listen = function (message, callback)
    callbacks[message] = callbacks[message] or {};

    table.insert(callbacks[message], callback);
  end

  addon.yell = function (message, ...)
    local callbackList = callbacks[message];

    if (callbackList == nil) then return end

    for x = 1, #callbackList, 1 do
      callbackList[x](...);
    end
  end
end

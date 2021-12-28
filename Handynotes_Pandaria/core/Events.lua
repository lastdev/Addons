local addonName, shared = ...;

local eventFrame = _G.CreateFrame('frame');
local callbacks = {};

eventFrame:SetScript('OnEvent', function (_, event, ...)
  for callback in pairs(callbacks[event]) do
    callback(event, ...);
  end
end);

local function addCallback (event, callback)
  if (callbacks[event] == nil) then
    callbacks[event] = {[callback] = true};
    eventFrame:RegisterEvent(event);
  else
    callbacks[event][callback] = true;
  end
end

local function removeCallback (event, callback)
  callbacks[event][callback] = nil;

  if (next(callbacks[event]) == nil) then
    eventFrame:UnregisterEvent(event);
  end
end

local function callForEvents (events, callback, method)
  assert(type(callback) == 'function',
    addonName .. ': callback is not a function');

  if (type(events) == 'table') then
    for _, event in ipairs(events) do
      method(event, callback);
    end
  else
    method(events, callback);
  end
end

--##############################################################################
-- public methods
--##############################################################################

function shared.addon.on (events, callback)
  callForEvents(events, callback, addCallback);
end

function shared.addon.off (events, callback)
  callForEvents(events, callback, removeCallback);
end

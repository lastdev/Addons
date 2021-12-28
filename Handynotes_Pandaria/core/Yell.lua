local _, shared = ...;

local callbacks = {};

function shared.addon.listen (message, callback)
  callbacks[message] = callbacks[message] or {};
  callbacks[message][callback] = true;
end

function shared.addon.yell (message, ...)
  if (callbacks[message]) then
    for callback in pairs(callbacks[message]) do
      callback(...);
    end
  end
end

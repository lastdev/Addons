local _, addon = ...;

local callbacks = {};

function addon.listen (message, callback)
  callbacks[message] = callbacks[message] or {};
  callbacks[message][callback] = true;
end

function addon.yell (message, ...)
  if (callbacks[message]) then
    for callback in pairs(callbacks[message]) do
      callback(...);
    end
  end
end

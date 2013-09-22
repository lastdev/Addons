-- Events - well, events complicate things.

-- One of my first rewrites of Reagent Restocker (RR) moved it out of the global
-- namespace. This was great for compatibility with other addons, but not so
-- great for events. When an event in WoW is hooked by my code, I had to
-- manually force it into RR's namespace. Unfortunately, that lead to many,
-- many bugs when I forgot to do it or did it incorrectly.

-- Therefore, I am creating my own event handler in hopes of killing this issue
-- once and for all. I'm getting pretty sick of dealing with event issues.

-- Note that this is not an event queue - all events are triggered immediately.
-- If you need queued events (ie, waiting for WoW's game loop), that needs
-- to be implemented separately.

local addonName, addonTable = ...;

local eventTable = {}
--local isWOWTable = {}

local eventTableSize = 0

-- Frame for WoW events
local eventFrame = CreateFrame("Frame")

-- Triggers an event, with a callback to be called when all of the subscribers
-- are done handling the event. Callback is optional and defaults to a generic
-- function that returns whatever it is given.

-- Arguments can be passed to the subscribed functions. The arguments are also
-- passed to the callback.
function addonTable.TriggerEvent(eventName, callback, ...)

	if getfenv == nil then
		error(eventName .. " event gave an improper environment.")
	end
	
	if eventName == nil then
		error("Event name cannot be nil. It must be a string.");
	end
	
	if type(eventName) ~= "string" then
		error("Event name cannot be of type " .. type(eventName) .. ". It must be a string.");
	end

	if callback == nil then
		callback = function(...) return ... end
	end
	
	if type(callback) ~= "function" then
		error("Callback cannot be of type " .. type(callback) .. ". It must be a function or nil.");
	end

	addonTable.dprint("(EventHandler) " .. eventName .. " triggered.")

	-- If there are no subscribers, just run the callback.	
	if eventTable[eventName] ~= nil then
		
		-- Enter RR's environment to process events and callback.
		addonTable.oldEnv = getfenv()
		addonTable.eventTable = eventTable
		setfenv(1,addonTable)
	
		for k, v in pairs(eventTable[eventName]) do
			dprint("(EventHandler) Action #" .. k .. " taken.")
			v(...)
		end
	end
	
	callback(...)
	
	-- Return to old environment, whatever it is.
	setfenv(1, oldEnv);
end

--local eventThread = _G.coroutine.create(function(...) addonTable.TriggerEvent(...) end)

-- Call eventAction whenever an event of a certain name is triggered. One event
-- can have many subscribers.
function addonTable.SubscribeEvent(eventName, eventAction)
	if eventName == nil then
		error("Event name cannot be nil. It must be a string.");
	end
	
	if type(eventName) ~= "string" then
		error("Event name cannot be of type " .. type(eventName) .. ". It must be a string.");
	end

	if eventAction == nil then
		error("Event action cannot be nil. It must be a function.");
	end
	
	if type(eventAction) ~= "function" then
		error("Event action cannot be of type " .. type(eventName) .. ". It must be a function.");
	end
	
	-- If this is a new event, create a new table for that event.
	if eventTable[eventName] == nil then
	eventTable[eventName] = {}
	end
	
	table.insert(eventTable[eventName], eventTableSize, eventAction)
	eventTableSize = eventTableSize + 1
	return eventTableSize - 1
end

-- Subscribe to one of World of Warcraft's events.
function addonTable.SubscribeWOWEvent(eventName, eventAction)
	if eventName == nil then
		error("Event name cannot be nil. It must be a string.");
	end
	
	if type(eventName) ~= "string" then
		error("Event name cannot be of type " .. type(eventName) .. ". It must be a string.");
	end

	if eventAction == nil then
		error("Event action cannot be nil. It must be a function.");
	end
	
	if type(eventAction) ~= "function" then
		error("Event action cannot be of type " .. type(eventName) .. ". It must be a function.");
	end

	-- Register event with WoW
	eventFrame:RegisterEvent(eventName)
	
	-- Subscribe to event with our system
	return addonTable.SubscribeEvent(eventName, eventAction)
end

-- This is called when a WoW event triggers. Any arguments are passed to our
-- own system. "self" is not used.
local function eventHandler(self, event, ...)
	if event == nil then
		error("Event name cannot be nil. It must be a string.");
	end

	if type(event) ~= "string" then	
		error("Event name cannot be of type " .. type(eventName) .. ". It must be a string.");
	end
	
	-- Trigger our own system.
	return addonTable.TriggerEvent(event, nil, ...)
end

eventFrame:SetScript("OnEvent", eventHandler);



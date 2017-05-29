local addonName = "Altoholic"
local addon = _G[addonName]

local function _ShowChildFrames(frame)
	for _, child in ipairs( {frame} ) do
		child:Show()
	end
end

local function _HideChildFrames(frame)
	for _, child in ipairs( {frame} ) do
		child:Hide()
	end
end

local function _RegisterClassEvent(frame, event, func)
	frame.customCallbacks = frame.customCallbacks or {}
	frame.customCallbacks[event] = func
end

local function _TriggerClassEvent(frame, event, arg1, arg2)
	if frame.customCallbacks[event] then
		frame.customCallbacks[event](frame, arg1, arg2)
	end
end

addon:RegisterClassExtensions("AltoFrame", {
	ShowChildFrames = _ShowChildFrames,
	HideChildFrames = _HideChildFrames,
	RegisterClassEvent = _RegisterClassEvent,		-- this one can obviously not be called RegisterEvent, it would conflict with Blizzard's own
	TriggerClassEvent = _TriggerClassEvent,
})

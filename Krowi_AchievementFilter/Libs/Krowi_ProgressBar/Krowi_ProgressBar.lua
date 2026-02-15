--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local lib = KROWI_LIBMAN:NewLibrary('Krowi_ProgressBar_2', 2, {
    SetCurrent = true,
    SetUtil = true,
})
if not lib then	return end

local numFrames = 0;
function lib:GetNew(parent)
	numFrames = numFrames + 1;
	return CreateFrame('Frame', 'Krowi_ProgressBar' .. numFrames, parent or UIParent, 'Krowi_ProgressBar_Template');
end
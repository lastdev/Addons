--[[----------------------------------------------------------------------------

  LiteMount/Print.lua

  AddMessage() into the currently displayed chat window.

  Copyright 2011-2021 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

--[==[@debug@
if LibDebug then LibDebug() end
--@end-debug@]==]

local debugLines = {}
local debugLinePos = 1
local maxDebugLines = 100

function LM.Print(msg)
    local f = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
    f:AddMessage("|cff00ff00LiteMount:|r " .. msg)
end

function LM.PrintError(msg)
    LM.Print("|cffff6666" .. msg .. "|r")
end

function LM.GetDebugLines()
    local out = {}
    for i = 1, maxDebugLines do
        local offset = (debugLinePos + i - 1) % (maxDebugLines + 1)
        if debugLines[offset] then
            out[#out+1] = debugLines[offset]
        end
    end
    return out
end

function LM.Debug(msg)
    debugLines[debugLinePos] = msg
    debugLinePos = ( debugLinePos + 1 ) % (maxDebugLines + 1)

    if LM.Options:GetDebug() then
        LM.Print(msg)
    end
end

local function GetFrameNameInternal(frame)
    local name = frame:GetName()
    if name then
        if name:sub(1,9) == "LiteMount" then
            return name:sub(10)
        else
            return name
        end
    end
    local parent = frame:GetParent()
    for name,child in pairs(parent) do
        if child == frame then
            return GetFrameNameInternal(parent)..'.'..name
        end
    end
    name = tostring(frame):sub(10)
    return GetFrameNameInternal(parent)..'.'..name
end

local function GetFrameName(frame)
    if not frame.__printableName then
        frame.__printableName = GetFrameNameInternal(frame)
    end
    return frame.__printableName
end

function LM.UIDebug(frame, msg)
    if LM.Options:GetUIDebug() then
        local name = GetFrameName(frame)
        LM.Print(ORANGE_FONT_COLOR:WrapTextInColorCode(name) .. ' : ' .. msg)
    end
end

-- This prints into the UI error box the same as Blizzards code
function LM.Warning(msg)
    UIErrorsFrame:AddMessage(msg, 1.0, 0.1, 0.1)
end

function LM.WarningAndPrint(msg)
    LM.Warning(msg)
    LM.PrintError(msg)
end

-------------------------------------------------------------------------------
-- Smooth Cursor Trail Addon (Connected Lines System)
-------------------------------------------------------------------------------
local ADDON_NAME = "CursorTrail"
local CursorTrail = CreateFrame("Frame", "CursorTrailFrame", UIParent)

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
local trailPoints = {}
local trailLines = {}
local linePool = {}
local config = {
    enabled = true,
    maxPoints = 25,
    lineWidth = 4,
    trailLength = 1.5,
    color = {r = 0.2, g = 0.6, b = 1.0, a = 0.8},
    updateRate = 0.015,
    minDistance = 5
}

local lastUpdate = 0
local frameCount = 0

-------------------------------------------------------------------------------
-- Line Creation and Management
-------------------------------------------------------------------------------
local function CreateTrailLine()
    local line = CursorTrail:CreateTexture(nil, "OVERLAY")
    line:SetColorTexture(1, 1, 1, 1)
    line:SetBlendMode("ADD")
    line:Hide()
    return line
end

local function GetLine()
    local line = next(linePool)
    if line then
        linePool[line] = nil
        return line
    end
    return CreateTrailLine()
end

local function ReleaseLine(line)
    line:Hide()
    line:ClearAllPoints()
    linePool[line] = true
end

local function CalculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

local function CalculateAngle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

local function CreateLineBetweenPoints(p1, p2, alpha)
    local line = GetLine()
    
    local distance = CalculateDistance(p1.x, p1.y, p2.x, p2.y)
    local angle = CalculateAngle(p1.x, p1.y, p2.x, p2.y)
    
    -- Centro entre los dos puntos
    local centerX = (p1.x + p2.x) / 2
    local centerY = (p1.y + p2.y) / 2
    
    -- Configurar la línea
    line:SetSize(distance, config.lineWidth)
    line:SetPoint("CENTER", UIParent, "BOTTOMLEFT", centerX, centerY)
    line:SetRotation(angle)
    line:SetVertexColor(config.color.r, config.color.g, config.color.b, alpha)
    line:Show()
    
    return line
end

-------------------------------------------------------------------------------
-- Main Trail Logic
-------------------------------------------------------------------------------
CursorTrail:SetScript("OnUpdate", function(self, elapsed)
    if not config.enabled then return end
    
    lastUpdate = lastUpdate + elapsed
    frameCount = frameCount + 1
    
    if lastUpdate >= config.updateRate then
        local x, y = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        x, y = x/scale, y/scale
        
        -- Solo agregar punto si hay suficiente movimiento
        local shouldAdd = true
        if #trailPoints > 0 then
            local lastPoint = trailPoints[1]
            local distance = CalculateDistance(lastPoint.x, lastPoint.y, x, y)
            if distance < config.minDistance then
                shouldAdd = false
            end
        end
        
        if shouldAdd then
            -- Limpiar líneas existentes
            for _, line in ipairs(trailLines) do
                ReleaseLine(line)
            end
            trailLines = {}
            
            -- Agregar nuevo punto al inicio
            table.insert(trailPoints, 1, {
                x = x, 
                y = y, 
                time = GetTime()
            })
            
            -- Remover puntos viejos
            local currentTime = GetTime()
            for i = #trailPoints, 1, -1 do
                local point = trailPoints[i]
                if currentTime - point.time > config.trailLength then
                    table.remove(trailPoints, i)
                end
            end
            
            -- Limitar número de puntos
            while #trailPoints > config.maxPoints do
                table.remove(trailPoints)
            end
            
            -- Crear líneas entre puntos consecutivos
            for i = 1, #trailPoints - 1 do
                local p1 = trailPoints[i]
                local p2 = trailPoints[i + 1]
                
                -- Calcular alpha basado en la edad del punto
                local age = (currentTime - p2.time) / config.trailLength
                local alpha = (1 - age) * config.color.a
                alpha = math.max(0, math.min(1, alpha))
                
                if alpha > 0.05 then
                    local line = CreateLineBetweenPoints(p1, p2, alpha)
                    table.insert(trailLines, line)
                end
            end
        end
        
        lastUpdate = 0
    end
end)

-------------------------------------------------------------------------------
-- Configuration Functions
-------------------------------------------------------------------------------
function CursorTrail:SetEnabled(enabled)
    config.enabled = enabled
    if not enabled then
        self:ClearTrail()
    end
end

function CursorTrail:SetColor(r, g, b, a)
    config.color.r = r or config.color.r
    config.color.g = g or config.color.g  
    config.color.b = b or config.color.b
    config.color.a = a or config.color.a
end

function CursorTrail:SetWidth(width)
    config.lineWidth = math.max(1, math.min(12, width or 4))
    -- No necesita actualizar líneas existentes, se actualizarán automáticamente
end

function CursorTrail:SetLength(length)
    config.trailLength = math.max(0.2, math.min(5.0, length or 1.5))
end

function CursorTrail:SetMaxPoints(points)
    config.maxPoints = math.max(5, math.min(50, points or 25))
end

function CursorTrail:SetUpdateRate(rate)
    config.updateRate = math.max(0.005, math.min(0.1, rate or 0.015))
end

function CursorTrail:SetMinDistance(distance)
    config.minDistance = math.max(1, math.min(20, distance or 5))
end

function CursorTrail:ClearTrail()
    -- Limpiar líneas
    for _, line in ipairs(trailLines) do
        ReleaseLine(line)
    end
    trailLines = {}
    
    -- Limpiar puntos
    trailPoints = {}
end

-------------------------------------------------------------------------------
-- Preset Effects
-------------------------------------------------------------------------------
local presets = {
    ["Electric Blue"] = {
        color = {r = 0.2, g = 0.6, b = 1.0, a = 0.9},
        width = 3,
        length = 1.2,
        maxPoints = 20
    },
    ["Fire Trail"] = {
        color = {r = 1.0, g = 0.4, b = 0.1, a = 0.8},
        width = 5,
        length = 1.8,
        maxPoints = 25
    },
    ["Neon Green"] = {
        color = {r = 0.2, g = 1.0, b = 0.3, a = 0.9},
        width = 4,
        length = 1.5,
        maxPoints = 22
    },
    ["Purple Magic"] = {
        color = {r = 0.8, g = 0.2, b = 1.0, a = 0.8},
        width = 6,
        length = 2.0,
        maxPoints = 30
    },
    ["Golden"] = {
        color = {r = 1.0, g = 0.8, b = 0.2, a = 0.9},
        width = 4,
        length = 1.3,
        maxPoints = 18
    },
    ["Ice Blue"] = {
        color = {r = 0.7, g = 0.9, b = 1.0, a = 0.7},
        width = 2,
        length = 1.0,
        maxPoints = 15
    },
    ["Blood Red"] = {
        color = {r = 0.9, g = 0.1, b = 0.1, a = 0.8},
        width = 5,
        length = 2.2,
        maxPoints = 28
    },
    ["Shadow"] = {
        color = {r = 0.3, g = 0.2, b = 0.8, a = 0.6},
        width = 7,
        length = 2.5,
        maxPoints = 35
    }
}

function CursorTrail:SetPreset(presetName)
    local preset = presets[presetName]
    if preset then
        self:SetColor(preset.color.r, preset.color.g, preset.color.b, preset.color.a)
        self:SetWidth(preset.width)
        self:SetLength(preset.length)
        self:SetMaxPoints(preset.maxPoints)
        print("Cursor trail preset: " .. presetName)
    else
        print("Available presets:")
        for name in pairs(presets) do
            print("- " .. name)
        end
    end
end

-------------------------------------------------------------------------------
-- Chat Commands
-------------------------------------------------------------------------------
SLASH_CURSORTRAIL1 = "/cursortrail"
SLASH_CURSORTRAIL2 = "/ctrail"

function SlashCmdList.CURSORTRAIL(msg)
    local command, arg = msg:match("^(%S+)%s*(.-)$")
    command = command and command:lower() or ""
    
    if command == "on" or command == "enable" then
        CursorTrail:SetEnabled(true)
        print("Cursor trail enabled")
    elseif command == "off" or command == "disable" then
        CursorTrail:SetEnabled(false) 
        print("Cursor trail disabled")
    elseif command == "preset" and arg ~= "" then
        CursorTrail:SetPreset(arg)
    elseif command == "width" and arg ~= "" then
        local width = tonumber(arg)
        if width then
            CursorTrail:SetWidth(width)
            print("Trail width: " .. width)
        end
    elseif command == "length" and arg ~= "" then
        local length = tonumber(arg)
        if length then
            CursorTrail:SetLength(length)
            print("Trail length: " .. length)
        end
    elseif command == "color" then
        local r, g, b, a = arg:match("([%d.]+)%s+([%d.]+)%s+([%d.]+)%s*([%d.]*)")
        if r and g and b then
            CursorTrail:SetColor(tonumber(r), tonumber(g), tonumber(b), tonumber(a) or config.color.a)
            print("Color set to: " .. r .. " " .. g .. " " .. b .. " " .. (a or config.color.a))
        else
            print("Usage: /ctrail color <r> <g> <b> [a] (0-1)")
        end
    elseif command == "clear" then
        CursorTrail:ClearTrail()
        print("Trail cleared")
    else
        print("=== Cursor Trail Commands ===")
        print("/ctrail on/off - Enable/disable")
        print("/ctrail preset <name> - Use preset")
        print("/ctrail width <1-12> - Line width")
        print("/ctrail length <0.2-5> - Trail duration")
        print("/ctrail color <r> <g> <b> [a] - Custom color")
        print("/ctrail clear - Clear trail")
        print("Try: /ctrail preset Electric Blue")
    end
end

-------------------------------------------------------------------------------
-- Hide during screenshots and cinematics
-------------------------------------------------------------------------------
local hideConditions = {}

local function addHideCondition(condition)
    hideConditions[condition] = true
    CursorTrail:SetEnabled(false)
end

local function removeHideCondition(condition)
    hideConditions[condition] = nil
    if not next(hideConditions) then
        CursorTrail:SetEnabled(true)
    end
end

hooksecurefunc("Screenshot", function()
    addHideCondition("screenshot")
    C_Timer.After(0.5, function() removeHideCondition("screenshot") end)
end)

CursorTrail:RegisterEvent("CINEMATIC_START")
CursorTrail:RegisterEvent("CINEMATIC_STOP")
CursorTrail:SetScript("OnEvent", function(self, event)
    if event == "CINEMATIC_START" then
        addHideCondition("cinematic")
    else
        removeHideCondition("cinematic")
    end
end)

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
print("Smooth Cursor Trail loaded!")
print("Try: /ctrail preset Electric Blue")
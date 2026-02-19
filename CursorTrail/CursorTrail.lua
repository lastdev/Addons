-------------------------------------------------------------------------------
-- Smooth Cursor Trail Addon (Connected Lines System)
-------------------------------------------------------------------------------
local ADDON_NAME, addon = ...
local CursorTrail = CreateFrame("Frame", "CursorTrailFrame", UIParent)

-------------------------------------------------------------------------------
-- Variables & Defaults
-------------------------------------------------------------------------------
local trailPoints = {}
local trailLines = {}
local linePool = {}

-- Ripple variables
local activeRipples = {}
local ripplePool = {}
local wasLeftDown = false
local wasRightDown = false

local defaults = {
    enabled = true,
    maxPoints = 30,
    lineWidth = 4,
    trailLength = 1.5,
    color = {r = 0.2, g = 0.6, b = 1.0, a = 0.8},
    updateRate = 0.015,
    minDistance = 5,
    classColor = false,
    rainbow = false,
    pulse = false,
    texture = "solid", -- solid, glow, soft, star, spot
    combatMode = 1, -- 1: Always, 2: Combat Only, 3: Non-Combat Only
    clickEffects = true,
}

-- Global DB reference (will be set on ADDON_LOADED)
CursorTrailDB = CursorTrailDB or CopyTable(defaults)

local lastUpdate = 0
local frameCount = 0
local rainbowHue = 0

-- Dictionaries
local namedColors = {
    ["red"]     = {1.0, 0.0, 0.0},
    ["green"]   = {0.0, 1.0, 0.0},
    ["blue"]    = {0.0, 0.0, 1.0},
    ["cyan"]    = {0.0, 1.0, 1.0},
    ["magenta"] = {1.0, 0.0, 1.0},
    ["yellow"]  = {1.0, 1.0, 0.0},
    ["white"]   = {1.0, 1.0, 1.0},
    ["black"]   = {0.0, 0.0, 0.0},
    ["orange"]  = {1.0, 0.5, 0.0},
    ["purple"]  = {0.6, 0.2, 0.8},
    ["pink"]    = {1.0, 0.4, 0.7},
    ["gold"]    = {1.0, 0.8, 0.0},
    ["teal"]    = {0.0, 0.5, 0.5},
}

local textureOptions = {
    ["solid"] = "Solid",
    ["glow"]  = "Interface\\COMMON\\Indicator-Gray",
    ["soft"]  = "Interface\\COMMON\\Indicator-White",
    ["star"]  = "Interface\\Cooldown\\star4",
    ["spot"]  = "Interface\\COMMON\\Indicator-Yellow",
}

local combatModes = {
    [1] = "Always",
    [2] = "Combat Only",
    [3] = "Out of Combat Only"
}

-------------------------------------------------------------------------------
-- Utility Functions
-------------------------------------------------------------------------------
local function CalculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

local function CalculateAngle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

local function GetRainbowColor(hue)
    -- Simple HSV to RGB conversion
    local h = hue % 1
    local r, g, b
    if h < 1/6 then r, g, b = 1, h*6, 0
    elseif h < 2/6 then r, g, b = (2/6-h)*6, 1, 0
    elseif h < 3/6 then r, g, b = 0, 1, (h-2/6)*6
    elseif h < 4/6 then r, g, b = 0, (4/6-h)*6, 1
    elseif h < 5/6 then r, g, b = (h-4/6)*6, 0, 1
    else r, g, b = 1, 0, (1-h)*6 end
    return r, g, b
end

local function GetCurrentColor()
    if CursorTrailDB.classColor then
        local _, class = UnitClass("player")
        local color = C_ClassColor.GetClassColor(class)
        if color then
            return color.r, color.g, color.b, CursorTrailDB.color.a
        end
    end
    
    if CursorTrailDB.rainbow then
        local r, g, b = GetRainbowColor(rainbowHue)
        return r, g, b, CursorTrailDB.color.a
    end
    
    return CursorTrailDB.color.r, CursorTrailDB.color.g, CursorTrailDB.color.b, CursorTrailDB.color.a
end

-------------------------------------------------------------------------------
-- Line Creation and Management
-------------------------------------------------------------------------------
local function CreateTrailLine()
    local line = CursorTrail:CreateTexture(nil, "OVERLAY")
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

local function CreateLineBetweenPoints(p1, p2, alpha, widthMult)
    local line = GetLine()
    
    local distance = CalculateDistance(p1.x, p1.y, p2.x, p2.y)
    local angle = CalculateAngle(p1.x, p1.y, p2.x, p2.y)
    
    -- Center point
    local centerX = (p1.x + p2.x) / 2
    local centerY = (p1.y + p2.y) / 2
    
    -- Config
    local texturePath = textureOptions[CursorTrailDB.texture] or textureOptions["solid"]
    if texturePath == "Solid" then
       line:SetColorTexture(1, 1, 1, 1)
    else
       line:SetTexture(texturePath)
    end
    
    local width = CursorTrailDB.lineWidth * (widthMult or 1)
    if CursorTrailDB.pulse then
        width = width * (0.8 + 0.4 * math.sin(GetTime() * 5))
    end
    
    line:SetSize(distance, width)
    line:SetPoint("CENTER", UIParent, "BOTTOMLEFT", centerX, centerY)
    line:SetRotation(angle)
    
    local r, g, b, baseAlpha = GetCurrentColor()
    line:SetVertexColor(r, g, b, alpha * baseAlpha)
    line:Show()
    
    return line
end

-------------------------------------------------------------------------------
-- Ripple Effects (Click Animation)
-------------------------------------------------------------------------------
local function CreateRippleTexture()
    local tex = CursorTrail:CreateTexture(nil, "OVERLAY")
    tex:SetTexture("Interface\\Cooldown\\star4") -- Star burst effect
    tex:SetBlendMode("ADD")
    tex:Hide()
    return tex
end

local function GetRipple()
    local tex = next(ripplePool)
    if tex then
        ripplePool[tex] = nil
        return tex
    end
    return CreateRippleTexture()
end

local function ReleaseRipple(tex)
    tex:Hide()
    tex:ClearAllPoints()
    ripplePool[tex] = true
end

local function SpawnRipple(x, y)
    local r = GetRipple()
    local scale = UIParent:GetEffectiveScale()
    r:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x/scale, y/scale)
    local r_col, g_col, b_col = GetCurrentColor()
    r:SetVertexColor(r_col, g_col, b_col, 1)
    r:Show()
    
    table.insert(activeRipples, {
        texture = r,
        age = 0,
        maxAge = 0.5, -- duration
        startSize = 10,
        endSize = 50
    })
end

local function UpdateRipples(elapsed)
    for i = #activeRipples, 1, -1 do
        local ripple = activeRipples[i]
        ripple.age = ripple.age + elapsed
        
        if ripple.age >= ripple.maxAge then
            ReleaseRipple(ripple.texture)
            table.remove(activeRipples, i)
        else
            local progress = ripple.age / ripple.maxAge
            local size = ripple.startSize + (ripple.endSize - ripple.startSize) * math.pow(progress, 0.5)
            local alpha = 1 - progress
            
            ripple.texture:SetSize(size, size)
            ripple.texture:SetAlpha(alpha)
            ripple.texture:SetRotation(progress * math.pi)
        end
    end
end

-------------------------------------------------------------------------------
-- Main Logic
-------------------------------------------------------------------------------
CursorTrail:RegisterEvent("ADDON_LOADED")
CursorTrail:RegisterEvent("CINEMATIC_START")
CursorTrail:RegisterEvent("CINEMATIC_STOP")
CursorTrail:RegisterEvent("PLAYER_REGEN_DISABLED")
CursorTrail:RegisterEvent("PLAYER_REGEN_ENABLED")

local hideConditions = {}

local function CheckCombatState()
    local inCombat = InCombatLockdown()
    local mode = CursorTrailDB.combatMode
    
    hideConditions["combat_mode"] = nil
    
    if mode == 2 and not inCombat then -- Combat Only
        hideConditions["combat_mode"] = true
    elseif mode == 3 and inCombat then -- Non-Combat Only
        hideConditions["combat_mode"] = true
    end
end

CursorTrail:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        if not CursorTrailDB then
            CursorTrailDB = CopyTable(defaults)
        else
            -- Validate/Migrate
            for k, v in pairs(defaults) do
                if CursorTrailDB[k] == nil then
                    CursorTrailDB[k] = v
                end
            end
            
            -- Migrate old "glow" boolean to texture
            if CursorTrailDB.glow == true then
                CursorTrailDB.texture = "glow"
                CursorTrailDB.glow = nil -- clear old key
            end
        end
        self:UnregisterEvent("ADDON_LOADED")
        print("|cff00ccffCursorTrail|r: Loaded! |cffffee00/ctrail|r for options.")
        
    elseif event == "CINEMATIC_START" then
        hideConditions["cinematic"] = true
    elseif event == "CINEMATIC_STOP" then
        hideConditions["cinematic"] = nil
    elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        CheckCombatState()
    end
end)

-- Screenshot hook
hooksecurefunc("Screenshot", function()
    hideConditions["screenshot"] = true
    C_Timer.After(0.5, function() hideConditions["screenshot"] = nil end)
end)

CursorTrail:SetScript("OnUpdate", function(self, elapsed)
    UpdateRipples(elapsed)

    -- Mouse Click Detection for Ripples
    if CursorTrailDB.clickEffects then
        local left = IsMouseButtonDown("LeftButton")
        local right = IsMouseButtonDown("RightButton")
        
        if left and not wasLeftDown then
            local x, y = GetCursorPosition()
            SpawnRipple(x, y)
        end
        if right and not wasRightDown then
            local x, y = GetCursorPosition()
            SpawnRipple(x, y)
        end
        
        wasLeftDown = left
        wasRightDown = right
    end

    if not CursorTrailDB.enabled or next(hideConditions) then 
        if #trailLines > 0 then self:ClearTrail() end
        return 
    end
    
    -- Check combat state initially or if changed externally (failsafe)
    if not hideConditions["combat_mode"] then
        CheckCombatState()
        if hideConditions["combat_mode"] then return end
    end
    
    lastUpdate = lastUpdate + elapsed
    rainbowHue = (rainbowHue + elapsed * 0.2) % 1
    
    if lastUpdate >= CursorTrailDB.updateRate then
        local x, y = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        x, y = x/scale, y/scale
        
        -- Add point logic
        local shouldAdd = true
        if #trailPoints > 0 then
            local lastPoint = trailPoints[1]
            local distance = CalculateDistance(lastPoint.x, lastPoint.y, x, y)
            if distance < CursorTrailDB.minDistance then
                shouldAdd = false
            end
        end
        
        if shouldAdd then
            -- Release old lines
            for _, line in ipairs(trailLines) do ReleaseLine(line) end
            wipe(trailLines)
            
            -- Add new point
            table.insert(trailPoints, 1, {x = x, y = y, time = GetTime()})
            
            -- Remove old points
            local currentTime = GetTime()
            for i = #trailPoints, 1, -1 do
                if currentTime - trailPoints[i].time > CursorTrailDB.trailLength then
                    table.remove(trailPoints, i)
                end
            end
            
            -- Cap points
            while #trailPoints > CursorTrailDB.maxPoints do
                table.remove(trailPoints)
            end
            
            -- Draw new lines
            for i = 1, #trailPoints - 1 do
                local p1 = trailPoints[i]
                local p2 = trailPoints[i + 1]
                
                local age = (currentTime - p2.time) / CursorTrailDB.trailLength
                local alpha = 1 - age
                local widthMult = 1 - (age * 0.5)
                
                if alpha > 0.05 then
                    local line = CreateLineBetweenPoints(p1, p2, alpha, widthMult)
                    table.insert(trailLines, line)
                end
            end
        end
        
        lastUpdate = 0
    end
end)

function CursorTrail:ClearTrail()
    for _, line in ipairs(trailLines) do ReleaseLine(line) end
    wipe(trailLines)
    wipe(trailPoints)
end

-------------------------------------------------------------------------------
-- Presets
-------------------------------------------------------------------------------
local presets = {
    ["Electric Blue"] = { color={0.2, 0.6, 1.0, 0.9}, width=3, length=1.2, texture="glow", pulse=false, rainbow=false },
    ["Fire Trail"]    = { color={1.0, 0.4, 0.1, 0.8}, width=5, length=1.8, texture="soft", pulse=true, rainbow=false },
    ["Neon Green"]    = { color={0.2, 1.0, 0.3, 0.9}, width=4, length=1.5, texture="solid", pulse=false, rainbow=false },
    ["Rainbow Power"] = { color={1,1,1,1}, width=6, length=2.0, texture="star", pulse=true, rainbow=true },
    ["Classy"]        = { color={1,1,1,1}, width=4, length=1.5, texture="glow", pulse=false, classColor=true },
}

function CursorTrail:ApplyPreset(name)
    local p = presets[name]
    if p then
        CursorTrailDB.color.r = p.color[1]
        CursorTrailDB.color.g = p.color[2]
        CursorTrailDB.color.b = p.color[3]
        CursorTrailDB.color.a = p.color[4] or 1
        CursorTrailDB.lineWidth = p.width
        CursorTrailDB.trailLength = p.length
        CursorTrailDB.texture = p.texture or "glow"
        CursorTrailDB.pulse = p.pulse
        CursorTrailDB.rainbow = p.rainbow
        CursorTrailDB.classColor = p.classColor or false
        print("|cff00ccffCursorTrail|r: Applied preset " .. name)
    end
end

-------------------------------------------------------------------------------
-- Chat Commands
-------------------------------------------------------------------------------
SLASH_CURSORTRAIL1 = "/cursortrail"
SLASH_CURSORTRAIL2 = "/ctrail"

SlashCmdList.CURSORTRAIL = function(msg)
    local cmd, arg = msg:match("^(%S+)%s*(.-)$")
    cmd = cmd and cmd:lower() or ""
    
    if cmd == "on" or cmd == "enable" then
        CursorTrailDB.enabled = true
        print("|cff00ccffCursorTrail|r: Enabled")
    elseif cmd == "off" or cmd == "disable" then
        CursorTrailDB.enabled = false
        print("|cff00ccffCursorTrail|r: Disabled")
    elseif cmd == "reset" then
        CursorTrailDB = CopyTable(defaults)
        CursorTrail:ClearTrail()
        print("|cff00ccffCursorTrail|r: Reset to defaults")
    
    -- Modes
    elseif cmd == "combat" then
        CursorTrailDB.combatMode = CursorTrailDB.combatMode + 1
        if CursorTrailDB.combatMode > 3 then CursorTrailDB.combatMode = 1 end
        print("|cff00ccffCursorTrail|r: Combat Mode: " .. combatModes[CursorTrailDB.combatMode])
        CheckCombatState()
        
    elseif cmd == "click" or cmd == "ripple" then
        CursorTrailDB.clickEffects = not CursorTrailDB.clickEffects
        print("|cff00ccffCursorTrail|r: Click Effects " .. (CursorTrailDB.clickEffects and "ON" or "OFF"))
        
    -- Toggles
    elseif cmd == "class" then
        CursorTrailDB.classColor = not CursorTrailDB.classColor
        print("|cff00ccffCursorTrail|r: Class Color " .. (CursorTrailDB.classColor and "ON" or "OFF"))
    elseif cmd == "rainbow" then
        CursorTrailDB.rainbow = not CursorTrailDB.rainbow
        print("|cff00ccffCursorTrail|r: Rainbow Mode " .. (CursorTrailDB.rainbow and "ON" or "OFF"))
    elseif cmd == "pulse" then
        CursorTrailDB.pulse = not CursorTrailDB.pulse
        print("|cff00ccffCursorTrail|r: Pulse Effect " .. (CursorTrailDB.pulse and "ON" or "OFF"))
    
    -- Values
    elseif cmd == "width" and tonumber(arg) then
        CursorTrailDB.lineWidth = tonumber(arg)
        print("|cff00ccffCursorTrail|r: Width set to " .. arg)
    
    -- Colors
    elseif cmd == "color" then
        if arg and namedColors[arg:lower()] then
            local c = namedColors[arg:lower()]
            CursorTrailDB.color.r = c[1]
            CursorTrailDB.color.g = c[2]
            CursorTrailDB.color.b = c[3]
            CursorTrailDB.classColor = false
            CursorTrailDB.rainbow = false
            print("|cff00ccffCursorTrail|r: Color set to " .. arg)
        else
            print("|cff00ccffCursorTrail|r Available Colors:")
            local s = ""
            for name, _ in pairs(namedColors) do s = s .. name .. ", " end
            print(s)
        end
        
    -- Textures
    elseif cmd == "texture" then
        if arg and textureOptions[arg:lower()] then
            CursorTrailDB.texture = arg:lower()
            print("|cff00ccffCursorTrail|r: Texture set to " .. arg:lower())
        else
            print("|cff00ccffCursorTrail|r Textures: solid, glow, soft, star, spot")
        end
        
    -- Presets
    elseif cmd == "preset" then
        if presets[arg] then
            CursorTrail:ApplyPreset(arg)
        else
            print("|cff00ccffCursorTrail|r: Presets:")
            for k in pairs(presets) do print(" - " .. k) end
        end
        
    else
        print("|cff00ccffCursorTrail|r Commands:")
        print(" /ctrail on/off")
        print(" /ctrail combat (Toggle: Always, Combat, NoCombat)")
        print(" /ctrail click (Toggle click ripples)")
        print(" /ctrail color <name> (or just /ctrail color for list)")
        print(" /ctrail texture <name> (solid, glow, soft, star, spot)")
        print(" /ctrail rainbow | class | pulse")
        print(" /ctrail width <num>")
        print(" /ctrail preset <name>")
        print(" /ctrail reset")
    end
end
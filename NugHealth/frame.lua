local addonName, ns = ...

local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register("statusbar", "Gradient", [[Interface\AddOns\NugHealth\gradient.tga]])
LSM:Register("font", "OpenSans Bold", [[Interface\AddOns\NugHealth\OpenSans-Bold.ttf]], GetLocale() ~= "enUS" and 15)

local pmult = 1
local function pixelperfect(size)
    return floor(size/pmult + 0.5)*pmult
end

local FRAMELEVEL = {
    BASEFRAME = 0,
    HEALTH = 1,
    POWER = 1,
    BORDER = 2,
    BAR = 5,
    TEXT = 3,
}

local MakeBorder = function(self, tex, left, right, top, bottom, drawLayer, level)
    local t = self:CreateTexture(nil, drawLayer, nil, level)
    t:SetTexture(tex)
    t:SetPoint("TOPLEFT", self, "TOPLEFT", left, -top)
    t:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -right, bottom)
    return t
end

local CompositeBorder_Set = function(self, left, right, top, bottom)
    local frame = self[5]
    local ttop = self[1]
    ttop:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, top)
    ttop:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", right, 0)

    local tright = self[2]
    tright:SetPoint("TOPRIGHT", frame, "TOPRIGHT", right, 0)
    tright:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -bottom)

    local tbot = self[3]
    tbot:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, -bottom)
    tbot:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -left, 0)

    local tleft = self[4]
    tleft:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -left, 0)
    tleft:SetPoint("TOPRIGHT", frame, "TOPLEFT", 0, top)
end
local MakeCompositeBorder = function(frame, tex, left, right, top, bottom, drawLayer, level)
    local ttop = frame:CreateTexture(nil, drawLayer, nil, level)
    ttop:SetTexture(tex)
    ttop:SetVertexColor(0,0,0,1)

    local tright = frame:CreateTexture(nil, drawLayer, nil, level)
    tright:SetTexture(tex)
    tright:SetVertexColor(0,0,0,1)

    local tbot = frame:CreateTexture(nil, drawLayer, nil, level)
    tbot:SetTexture(tex)
    tbot:SetVertexColor(0,0,0,1)

    local tleft = frame:CreateTexture(nil, drawLayer, nil, level)
    tleft:SetTexture(tex)
    tleft:SetVertexColor(0,0,0,1)

    local border = { ttop, tright, tbot, tleft, frame }
    border.parent = frame
    border.Set = CompositeBorder_Set

    border:Set(left, right, top, bottom)

    return border
end

----------------
-- HEAL ABSORB
----------------
local HealAbsorbUpdatePositionVertical = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetHeight(p*frameLength)
    local offset = (health-p)*frameLength
    self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, offset)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, offset)
end
local HealAbsorbUpdatePositionHorizontal = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetWidth(p*frameLength)
    local offset = (health-p)*frameLength
    self:SetPoint("TOPLEFT", parent, "TOPLEFT", offset, 0)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
end
local HealAbsorbSetValue = function(self, p, health)
    if p < 0.005 then
        self:Hide()
        return
    end

    local parent = self.parent

    if p > health then
        p = health
    end

    self:Show()
    self:UpdatePosition(p, health, parent)
end

local function CreateHealAbsorb(hp)
    local healAbsorb = hp:CreateTexture(nil, "ARTWORK", nil, -5)

    healAbsorb:SetHorizTile(true)
    healAbsorb:SetVertTile(true)
    healAbsorb:SetTexture("Interface\\AddOns\\NugHealth\\shieldtex", "REPEAT", "REPEAT")
    healAbsorb:SetVertexColor(0.5,0.1,0.1, 0.65)
    healAbsorb:SetBlendMode("ADD")

    healAbsorb.UpdatePositionVertical = HealAbsorbUpdatePositionVertical
    healAbsorb.UpdatePositionHorizontal = HealAbsorbUpdatePositionHorizontal
    healAbsorb.UpdatePosition = HealAbsorbUpdatePositionVertical

    healAbsorb.SetValue = HealAbsorbSetValue
    return healAbsorb
end
--------------------
-- ABSORB BAR
--------------------
local AbsorbUpdatePositionVertical = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetHeight(p*frameLength)
    local offset = health*frameLength
    self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, offset)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, offset)
end
local AbsorbUpdatePositionHorizontal = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetWidth(p*frameLength)
    local offset = health*frameLength
    self:SetPoint("TOPLEFT", parent, "TOPLEFT", offset, 0)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
end
local AbsorbSetValue = function(self, p, health)
    if p + health > 1 then
        p = 1 - health
    end

    if p < 0.005 then
        self:Hide()
        return
    end

    local parent = self.parent

    self:Show()
    self:UpdatePosition(p, health, parent)
end
local function CreateAbsorbBar(hp)
    local absorb = hp:CreateTexture(nil, "ARTWORK", nil, -5)

    absorb:SetHorizTile(true)
    absorb:SetVertTile(true)
    absorb:SetTexture("Interface\\AddOns\\NugHealth\\shieldtex", "REPEAT", "REPEAT")
    absorb:SetVertexColor(0,0,0, 0.65)
    -- absorb:SetBlendMode("ADD")

    absorb.UpdatePositionVertical = AbsorbUpdatePositionVertical
    absorb.UpdatePositionHorizontal = AbsorbUpdatePositionHorizontal
    absorb.UpdatePosition = AbsorbUpdatePositionVertical

    absorb.SetValue = AbsorbSetValue
    return absorb
end

--------------------
-- INCOMING HEAL
--------------------
local function CreateIncominHealBar(hp)
    local hpi = hp:CreateTexture(nil, "ARTWORK", nil, -5)

    -- hpi:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    hpi:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    hpi:SetVertexColor(0,0,0, 0.5)

    hpi.UpdatePositionVertical = AbsorbUpdatePositionVertical
    hpi.UpdatePositionHorizontal = AbsorbUpdatePositionHorizontal
    hpi.UpdatePosition = AbsorbUpdatePositionVertical

    hpi.SetValue = AbsorbSetValue
    return hpi
end


local AlignAbsorbVertical = function(self, absorb_height, missing_health_height)
    self:SetHeight(absorb_height)
    if absorb_height >= missing_health_height then
        self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", -3 ,0)
    else
        self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", -3, -(missing_health_height - absorb_height))
    end
end
local AlignAbsorbHorizontal = function(self, absorb_height, missing_health_height)
    self:SetWidth(absorb_height)
    if absorb_height >= missing_health_height then
        self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", 0 ,-3)
    else
        self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", -(missing_health_height - absorb_height), -3)
    end
end
local CreateAbsorbSideBar_SetValue = function(self, p, h)
    if p > 1 then p = 1 end
    if p < 0 then p = 0 end
    if p <= 0.015 then self:Hide(); return; else self:Show() end

    local frameLength = self.parent.frameLength

    local missing_health_height = (1-h)*frameLength
    local absorb_height = p*frameLength

    self:AlignAbsorb(absorb_height, missing_health_height)
end

local function CreateAbsorbSideBar(hp, absorbWidth)
    local absorb = CreateFrame("Frame", nil, hp)
    absorb:SetParent(hp)
    -- absorb:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",0,0)
    absorb:SetPoint("TOPLEFT",hp,"TOPLEFT",-3,0)
    absorb:SetWidth(absorbWidth)

    local at = absorb:CreateTexture(nil, "ARTWORK", nil, -4)
    at:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    at:SetVertexColor(.7, .7, 1, 1)
    at:SetAllPoints(absorb)

    local atbg = absorb:CreateTexture(nil, "ARTWORK", nil, -5)
    atbg:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    atbg:SetVertexColor(0,0,0,1)
    atbg:SetPoint("TOPLEFT", at, "TOPLEFT", -1,1)
    atbg:SetPoint("BOTTOMRIGHT", at, "BOTTOMRIGHT", 1,-1)

    absorb.AlignAbsorb = AlignAbsorbVertical

    absorb.SetValue = CreateAbsorbSideBar_SetValue
    absorb:SetValue(0)
    return absorb
end

--------------------
-- HEALTH LOST
--------------------
local HealthLostUpdatePositionVertical = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetHeight(p*frameLength)
    if health then
        local offset = health*frameLength
        self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, offset)
        self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, offset)
    end
end
local HealthLostUpdatePositionHorizontal = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetWidth(p*frameLength)
    if health then
        local offset = health*frameLength
        self:SetPoint("TOPLEFT", parent, "TOPLEFT", offset, 0)
        self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
    end
end
local function CreateHealthLostBar(hp)
    local hl = hp:CreateTexture(nil, "ARTWORK", nil, -5)
    hp.lost = hl

    -- hpi:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    hl:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    hl:SetVertexColor(1,0,0, 1)

    hl.UpdatePositionVertical = HealthLostUpdatePositionVertical
    hl.UpdatePositionHorizontal = HealthLostUpdatePositionHorizontal
    hl.UpdatePosition = HealthLostUpdatePositionVertical

    hl.currentvalue = 0
    hl.endvalue = 0

    hl.UpdateDiff = function(self, diff)
        if diff > 0 then
            self:UpdatePosition(diff, nil, self.parent)
            self:Show()
        else
            self:Hide()
        end
    end

    hp:SetScript("OnUpdate", function(self, time)
        self._elapsed = (self._elapsed or 0) + time
        if self._elapsed < 0.025 then return end
        self._elapsed = 0


        local hl = self.lost
        local diff = hl.currentvalue - hl.endvalue
        if diff > 0 then
            local d = (diff > 0.1) and diff/15 or 0.006
            hl.currentvalue = hl.currentvalue - d
            hl:UpdateDiff(diff-d)
        end
    end)

    hl.SetNewHealthTarget = function(self, vp, health)
        local diff = self.currentvalue - vp
        if diff <= 0 then
            self.currentvalue = vp
            self.endvalue = vp
            self:Hide()
        else
            self.endvalue = vp
            self:UpdatePosition(diff, health, self.parent)
        end
    end

    -- hl.SetValue = function(self, p, health)
    --     if p < 0.005 then
    --         self:Hide()
    --         return
    --     end

    --     local parent = self.parent

    --     if p > health then
    --         p = health
    --     end

    --     self:Show()
    --     self:UpdatePosition(p, health, parent)
    --     self:SetNewHealthTarget(p)
    --     self:_SetValue(p, health)
    -- end

    -- hl.SetValue = AbsorbSetValue
    return hl
end


---------------------------
-- Stagger Spikes
---------------------------

local math_min = math.min
local StaggerSpikeSetModVertical = function(self, mod, averageStagger)
    local stagger = self:GetParent()
    local frameLength = stagger.frameLength
    if mod > 0 then
        self:ClearAllPoints()
        local mod2 = math_min(0.75, mod)
        -- local ah = math_min(averageStagger, 0.75)*frameLength
        local ah = averageStagger*frameLength
        self:SetPoint("TOPLEFT", stagger, "BOTTOMRIGHT", 0, ah)
        self:SetHeight(mod2*frameLength)
        self.texture:SetVertexColor(0,1,0)
        self:Show()
    elseif mod < 0 then
        self:ClearAllPoints()
        local mod2 = math.max(-0.75, mod)
        -- local ah = math_min(averageStagger, 0.75)*frameLength
        local ah = averageStagger*frameLength
        -- spike bar won't be starting higher than 75% stagger position.
        -- it's maximum length is also 75% of frame frameLength
        -- and the actual stagger bar itself also extends from 100% to 150% stagger if needed
        self:SetPoint("BOTTOMLEFT", stagger, "BOTTOMRIGHT", 0, ah)
        self:SetHeight(-mod2*frameLength)
        self.texture:SetVertexColor(1,0,0)
        self:Show()
    else
        self:Hide()
    end
end
local StaggerSpikeSetModHorizontal = function(self, mod, averageStagger)
    local stagger = self:GetParent()
    local frameLength = stagger.frameLength
    if mod > 0 then
        self:ClearAllPoints()
        local mod2 = math_min(0.75, mod)
        local ah = averageStagger*frameLength
        self:SetPoint("TOPRIGHT", stagger, "BOTTOMLEFT", ah, 0)
        self:SetWidth(mod2*frameLength)
        self.texture:SetVertexColor(0,1,0)
        self:Show()
    elseif mod < 0 then
        self:ClearAllPoints()
        local mod2 = math.max(-0.75, mod)
        local ah = averageStagger*frameLength
        self:SetPoint("TOPLEFT", stagger, "BOTTOMLEFT", ah, 0)
        self:SetWidth(-mod2*frameLength)
        self.texture:SetVertexColor(1,0,0)
        self:Show()
    else
        self:Hide()
    end
end
local function CreateStaggerSpikebar(parent)
    local height = pixelperfect(NugHealthDB.height)
    local width = pixelperfect(NugHealthDB.width)
    local trend_width = pixelperfect(NugHealthDB.spike_width)

    local trend = CreateFrame("Frame", nil, parent)
    trend:SetFrameLevel(FRAMELEVEL.BAR)
    trend:SetWidth(trend_width)
    trend:SetHeight(height*0.25)

    local ttex = trend:CreateTexture(nil, "ARTWORK", nil, 0)
    ttex:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    ttex:SetAllPoints()
    trend.texture = ttex

    local p = pixelperfect(1)
    local outline = MakeBorder(trend, "Interface\\BUTTONS\\WHITE8X8", -p, -p, -p, -p, "BACKGROUND", -2)
    outline:SetVertexColor(0,0,0,1)


    trend.SetMod = StaggerSpikeSetModVertical

    return trend
end
------------------
-- Stagger Bar
------------------

local StaggerExtendV = function(self, v)
    if v > 1.5 then v = 1.5 end
    if v > 1 then
        self:SetHeight(self.frameLength*v)
    else
        self:SetHeight(self.frameLength)
    end
end
local StaggerExtendH = function(self, v)
    if v > 1.5 then v = 1.5 end
    if v > 1 then
        self:SetWidth(self.frameLength*v)
    else
        self:SetWidth(self.frameLength)
    end
end
local function AlignStagger(stagger, width, height, orientation)
    local stagger_width = pixelperfect(NugHealthDB.stagger_width)
    local trend_width = pixelperfect(NugHealthDB.spike_width)
    local parent = stagger:GetParent()
    stagger:SetOrientation(orientation)
    stagger:ClearAllPoints()
    if orientation == "VERTICAL" then
        stagger.frameLength = height
        stagger:SetWidth(stagger_width)
        stagger:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT",2,0)
        stagger:SetHeight(height)
        stagger.Extend = StaggerExtendV

        stagger.trend:ClearAllPoints()
        stagger.trend:SetWidth(trend_width)
        stagger.trend.SetMod = StaggerSpikeSetModVertical
    else
        stagger.frameLength = width
        stagger:SetWidth(width)
        stagger:SetPoint("TOPLEFT", parent, "BOTTOMLEFT",0,-2)
        stagger:SetHeight(stagger_width)
        stagger.Extend = StaggerExtendH

        stagger.trend:ClearAllPoints()
        stagger.trend:SetHeight(trend_width)
        stagger.trend.SetMod = StaggerSpikeSetModHorizontal
    end
end
local function CreateStaggerBar(self)
    local height = pixelperfect(NugHealthDB.height)
    local width = pixelperfect(NugHealthDB.width)
    local stagger_width = pixelperfect(NugHealthDB.stagger_width)

    local stagger = CreateFrame("StatusBar", nil, self)
    stagger:SetWidth(stagger_width)
    stagger:SetPoint("BOTTOMLEFT",self,"BOTTOMRIGHT",2,0)
    stagger:SetHeight(height)
    stagger.frameLength = height
    stagger.Extend = StaggerExtendV

    stagger:SetStatusBarTexture("Interface\\BUTTONS\\WHITE8X8")
    stagger:GetStatusBarTexture():SetDrawLayer("ARTWORK",-2)
    stagger:SetOrientation("VERTICAL")
    stagger:SetMinMaxValues(0, 1)
    stagger:SetValue(0.5)

    local p = pixelperfect(1)
    local outline = MakeBorder(stagger, "Interface\\BUTTONS\\WHITE8X8", -p*2, -p*2, -p*2, -p*2, "BACKGROUND", -2)
    outline:SetVertexColor(0,0,0,1)

    local stbg = stagger:CreateTexture(nil,"ARTWORK",nil,-3)
    stbg:SetAllPoints(stagger)
    stbg:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    stagger.bg = stbg

    stagger.SetColor = ns.MakeSetColor(0.1)
    stagger.Align = AlignStagger

    -- stagger:SetScript("OnUpdate", function(self, time)
        -- self:SetValue( self.endTime - GetTime())
    -- end)

    stagger:Hide()
    return stagger
end

---------------------
-- Resolve Bar
---------------------


local Resolve_SetValueVertical = function(self, p)
    if p > 1 then p = 1 end
    if p < 0 then p = 0 end
    if p == 0 then self:Hide() else self:Show() end
    self:SetHeight(p*self.frameLength)
end
local Resolve_SetValueHorizontal = function(self, p)
    if p > 1 then p = 1 end
    if p < 0 then p = 0 end
    if p == 0 then self:Hide() else self:Show() end
    self:SetWidth(p*self.frameLength)
end
local function AlignResolve(resolve, width, height, orientation)
    resolve:ClearAllPoints()
    local parent = resolve:GetParent()
    if orientation == "VERTICAL" then
        resolve.frameLength = height
        resolve:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT",0,0)
        resolve:SetWidth(6)
        resolve.SetValue = Resolve_SetValueVertical
    else
        resolve.frameLength = width
        resolve:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT",0,0)
        resolve:SetHeight(6)
        resolve.SetValue = Resolve_SetValueHorizontal
    end
end
local function CreateResolveBar(self)
    local resolve = CreateFrame("Frame", nil, self)
    resolve:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",0,0)
    resolve:SetWidth(6)

    local at = resolve:CreateTexture(nil, "ARTWORK", nil, -4)
    at:SetTexture"Interface\\BUTTONS\\WHITE8X8"
    -- at:SetVertexColor(.7, .7, 1, 1)
    resolve.texture = at
    at:SetAllPoints(resolve)

    local p = pixelperfect(1)
    local outline = MakeBorder(resolve, "Interface\\BUTTONS\\WHITE8X8", -p, -p, -p, -p, "ARTWORK", -5)
    outline:SetVertexColor(0,0,0,1)

    resolve.frameLength = self:GetHeight()
    resolve.SetValue = Resolve_SetValueVertical
    resolve:SetValue(0)

    resolve.Align = AlignResolve

    resolve.SetStatusBarColor = function(self, r,g,b)
        self.texture:SetVertexColor(r,g,b)
    end
    return resolve
end


local function Reconf(self)

    -- TODO: Restore glowtex

    local db = NugHealthDB
    local isVertical = db.healthOrientation == "VERTICAL"

    local texpath = LSM:Fetch("statusbar", db.healthTexture)
    local healthTextFont = LSM:Fetch("font", "OpenSans Bold")

    self.health:SetStatusBarTexture(texpath)
    self.health:GetStatusBarTexture():SetDrawLayer("ARTWORK",-6)
    self.health.bg:SetTexture(texpath)


    -- if not db.fgShowMissing then
    --     -- Blizzard's StatusBar SetFillStyle is bad, because even if it reverses direction,
    --     -- it still cuts tex coords from the usual direction
    --     -- So i'm using custom status bar for health and resolve
    --     self.health:SetFillStyle("STANDARD")
    --     -- self.resolve:SetFillStyle("STANDARD")

    --     -- self.health.SetColor = HealthBarSetColorInverted
    --     -- self.resolve.SetColor = HealthBarSetColorInverted
    --     -- self.text1.SetColor = Text1_SetColorInverted
    --     -- self.text1:SetShadowOffset(0,0)
    --     self.health.absorb2:SetVertexColor(0.7,0.7,1, 0.65)
    --     self.health.incoming:SetVertexColor(0.3, 1,0.4, 0.4)
    --     self.health.absorb2:SetDrawLayer("ARTWORK", -7)
    --     self.health.incoming:SetDrawLayer("ARTWORK", -7)
    -- else
        self.health:SetFillStyle("REVERSE")
        -- self.health.SetColor = HealthBarSetColor
        -- self.resolve.SetColor = HealthBarSetColor
        -- self.text1.SetColor = Text1_SetColor
        -- self.text1:SetShadowOffset(1,-1)
        self.health.absorb2:SetVertexColor(0,0,0, 0.65)
        self.health.incoming:SetVertexColor(0,0,0, 0.4)
        self.health.absorb2:SetDrawLayer("ARTWORK", -5)
        self.health.incoming:SetDrawLayer("ARTWORK", -5)
    -- end

    -- Aptechka.FrameSetJob(self,config.HealthBarColor,true)
    -- Aptechka.FrameSetJob(self,config.staggerColor,true)
    -- Aptechka.FrameSetJob(self,config.UnitNameStatus,true)

    -- local nameFont = LSM:Fetch("font",  Aptechka.db.profile.nameFontName)
    -- local nameFontSize = Aptechka.db.profile.nameFontSize
    -- local nameFontOutline = Aptechka.db.profile.nameFontOutline
    -- local outline = nameFontOutline == "OUTLINE" and "OUTLINE"
    -- self.text1:SetFont(nameFont, nameFontSize, outline)
    -- if nameFontOutline == "SHADOW" then
    --     self.text1:SetShadowOffset(1,-1)
    -- else
    --     self.text1:SetShadowOffset(0,0)
    -- end

    local height = pixelperfect(NugHealthDB.height)
    local width = pixelperfect(NugHealthDB.width)
    local absorb_width = pixelperfect(NugHealthDB.absorb_width)
    local stagger_width = pixelperfect(NugHealthDB.stagger_width)
    local trend_width = pixelperfect(NugHealthDB.spike_width)

    self:SetWidth(width)
    self:SetHeight(height)
    -- self.trend:SetWidth(trend_width)
    -- self.absorb.maxheight = height
    -- self.absorb:SetWidth(absorb_width)

    -- self.glowtex:SetWidth(width*hmul)
    -- self.glowtex:SetHeight(height*vmul)

    local htext = self.health.text
    if NugHealthDB.healthText then
        htext:Show()

    else
        htext:Hide()
    end

    if isVertical then
        self.health:SetOrientation("VERTICAL")
        -- self.resolve:SetOrientation("VERTICAL")

        local frameLength = pixelperfect(db.height)
        self.health.frameLength = frameLength

        self.health:ClearAllPoints()
        self.health:SetPoint("TOPLEFT",self,"TOPLEFT",0,0)
        self.health:SetPoint("TOPRIGHT",self,"TOPRIGHT",0,0)
        self.health:SetHeight(frameLength)

        htext:ClearAllPoints()
        htext:SetFont(healthTextFont, NugHealthDB.healthTextSize)
        htext:SetPoint("TOP", self.health, "TOP",0, -NugHealthDB.healthTextOffset)

        self.stagger:Align(width, height, "VERTICAL")

        self.resolve:Align(width, height, "VERTICAL")

        self.trend:SetHeight(frameLength)
        self.trend:SetWidth(trend_width)

        local  absorb = self.health.absorb
        absorb:ClearAllPoints()
        absorb:SetWidth(absorb_width)
        absorb.orientation = "VERTICAL"
        absorb.AlignAbsorb = AlignAbsorbVertical
        -- Aptechka:UNIT_ABSORB_AMOUNT_CHANGED(nil, self.unit)

        local flashPool = self.flashPool
        flashPool.UpdatePosition = flashPool.UpdatePositionVertical

        local hplost = self.health.lost
        hplost:ClearAllPoints()
        hplost.UpdatePosition = hplost.UpdatePositionVertical

        local healAbsorb = self.health.healabsorb
        healAbsorb:ClearAllPoints()
        healAbsorb.UpdatePosition = healAbsorb.UpdatePositionVertical

        local absorb2 = self.health.absorb2
        absorb2:ClearAllPoints()
        absorb2.UpdatePosition = absorb2.UpdatePositionVertical

        local hpi = self.health.incoming
        hpi:ClearAllPoints()
        hpi.UpdatePosition = hpi.UpdatePositionVertical
    else
        self.health:SetOrientation("HORIZONTAL")
        -- self.resolve:SetOrientation("HORIZONTAL")

        local frameLength = pixelperfect(db.width)
        self.health.frameLength = frameLength

        self.health:ClearAllPoints()
        self.health:SetPoint("TOPLEFT",self,"TOPLEFT",0,0)
        self.health:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",0,0)
        self.health:SetWidth(frameLength)

        htext:ClearAllPoints()
        htext:SetFont(healthTextFont, NugHealthDB.healthTextSize)
        htext:SetPoint("RIGHT", self.health, "RIGHT", -NugHealthDB.healthTextOffset, 0)

        self.stagger:Align(width, height, "HORIZONTAL")

        self.resolve:Align(width, height, "HORIZONTAL")
        -- self.resolve:OnPowerTypeChange()

        local absorb = self.health.absorb
        absorb:ClearAllPoints()
        absorb:SetHeight(3)
        absorb.orientation = "HORIZONTAL"
        absorb.AlignAbsorb = AlignAbsorbHorizontal

        local flashPool = self.flashPool
        flashPool.UpdatePosition = flashPool.UpdatePositionHorizontal

        local hplost = self.health.lost
        hplost:ClearAllPoints()
        hplost.UpdatePosition = hplost.UpdatePositionHorizontal

        local healAbsorb = self.health.healabsorb
        healAbsorb:ClearAllPoints()
        healAbsorb.UpdatePosition = healAbsorb.UpdatePositionHorizontal

        local absorb2 = self.health.absorb2
        absorb2:ClearAllPoints()
        absorb2.UpdatePosition = absorb2.UpdatePositionHorizontal

        local hpi = self.health.incoming
        hpi:ClearAllPoints()
        hpi.UpdatePosition = hpi.UpdatePositionHorizontal
    end

end

function NugHealth.Create(self)
    local res = GetCVar("gxWindowedResolution")
    if res then
        local w,h = string.match(res, "(%d+)x(%d+)")
        pmult = (768/h) / UIParent:GetScale()
    end

    local db = NugHealthDB

    local p = pixelperfect(1)

    local texture = LSM:Fetch("statusbar", db.healthTexture)
    local healthTextFont = LSM:Fetch("font", "OpenSans Bold")
    -- local powertexture = LSM:Fetch("statusbar", db.powerTexture)
    -- local font = LSM:Fetch("font",  Aptechka.db.profile.nameFontName)
    -- local fontsize = Aptechka.db.profile.nameFontSize
    -- local manabar_width = config.manabarwidth
    local outlineSize = pixelperfect(2)
    local height = pixelperfect(NugHealthDB.height)
    local width = pixelperfect(NugHealthDB.width)
    local absorb_width = pixelperfect(NugHealthDB.absorb_width)
    local stagger_width = pixelperfect(NugHealthDB.stagger_width)

    self:SetWidth(width)
    self:SetHeight(height)
    self:SetFrameLevel(FRAMELEVEL.BASEFRAME)

    self.state = {}

    self.ReconfigureUnitFrame = Reconf
    self.Resize = Reconf

    local outline = MakeCompositeBorder(self, "Interface\\BUTTONS\\WHITE8X8", outlineSize, outlineSize, outlineSize, outlineSize, "BACKGROUND", -2)
    -- outline:Set(1,1,1,1)

    --------------
    -- Resolve
    --------------

    local resolve = CreateResolveBar(self)
    self.resolve = resolve

    --------------
    -- Stagger
    --------------

    local stagger = CreateStaggerBar(self)

    self.stagger = stagger

    --------------
    -- Stagger Spikes
    --------------

    local trend = CreateStaggerSpikebar(stagger)
    self.trend = trend
    stagger.trend = trend

    --------------
    -- Health
    --------------

    -- local hp = CreateFrame("StatusBar", nil, self)
    local hp = ns.CreateCustomStatusBar(nil, self, "VERTICAL")
    hp:SetFrameLevel(FRAMELEVEL.HEALTH)
    hp:SetPoint("TOPLEFT",self,"TOPLEFT",0,0)
    hp:SetPoint("TOPRIGHT",self,"TOPRIGHT",0,0)
    -- hp:SetPoint("TOPRIGHT",stagger,"TOPRIGHT",0,0)
    hp:SetHeight(height)
    hp:GetStatusBarTexture():SetDrawLayer("ARTWORK",-6)
    hp:SetMinMaxValues(0,100)
    hp:SetOrientation("VERTICAL")
    hp.parent = self
    --hp:SetValue(0)

    local hpbg = hp:CreateTexture(nil,"ARTWORK",nil,-8)
    hpbg:SetAllPoints(hp)
    hpbg:SetTexture(texture)
    -- hpbg.SetColor = HealthBarSetColorBG
    hp.bg = hpbg

    ---------------
    -- Health Text
    ---------------

    local htext = hp:CreateFontString()
    htext:SetFont(healthTextFont, NugHealthDB.healthTextSize)
    htext:SetPoint("TOP", hp, "TOP",0, -NugHealthDB.healthTextOffset)
    if not NugHealthDB.healthText then htext:Hide() end
    hp.text = htext

    hp.SetColor = function(self, r,g,b)
        self:SetStatusBarColor(r,g,b)
        self.bg:SetVertexColor(r*0.2,g*0.2,b*0.2)
        self.text:SetTextColor(r*0.2,g*0.2,b*0.2)
    end

    hp.RestoreColor = function(self)
        if NugHealthDB.classcolor then
            local _, class = UnitClass("player")
            local c = RAID_CLASS_COLORS[class]
            self:SetColor(c.r,c.g,c.b)
        else
            self:SetColor(unpack(NugHealthDB.healthcolor))
        end
    end

    hp:RestoreColor()

    ----------------------
    -- HEALTH LOST EFFECT
    ----------------------

    local flashPool = CreateTexturePool(hp, "ARTWORK", -5)
    flashPool.StopEffect = function(self, flash)
        flash.ag:Finish()
    end
    flashPool.UpdatePositionVertical = function(pool, self, p, health, parent)
        local frameLength = parent.frameLength
        self:SetHeight(-p*frameLength)
        local offset = health*frameLength
        self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, offset)
        self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, offset)
    end
    flashPool.UpdatePositionHorizontal = function(pool, self, p, health, parent)
        local frameLength = parent.frameLength
        self:SetWidth(-p*frameLength)
        local offset = health*frameLength
        self:SetPoint("TOPLEFT", parent, "TOPLEFT", offset, 0)
        self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
    end
    flashPool.UpdatePosition = flashPool.bUpdatePositionVertical
    flashPool.FireEffect = function(self, flash, p, health, frameState, flashId)
        --[=[
        if p >= 0 then return end

        local tex = flash
        local hp = tex:GetParent()
        local frameLength = hp.frameLength
        tex:SetTexture("Interface\\BUTTONS\\WHITE8X8")
        -- tex:SetBlendMode("ADD")
        tex:SetVertexColor(1,1,1, 1)
        tex:Show()

        tex:ClearAllPoints()
        self:UpdatePosition(tex, p, health, hp)

        if not tex.ag then
            local bag = tex:CreateAnimationGroup()

            -- local ba1 = bag:CreateAnimation("Alpha")
            -- ba1:SetFromAlpha(0)
            -- ba1:SetToAlpha(0.8)
            -- ba1:SetDuration(0.1)
            -- ba1:SetOrder(1)

            -- local s1 = bag:CreateAnimation("Scale")
            -- s1:SetOrigin("LEFT",0,0)
            -- s1:SetFromScale(1, 1)
            -- s1:SetToScale(0.01, 1)
            -- s1:SetDuration(0.3)
            -- s1:SetOrder(1)

            -- local t1 = bag:CreateAnimation("Translation")
            -- t1:SetOffset(10, 0)
            -- t1:SetDuration(0.15)
            -- t1:SetOrder(1)

            local ba2 = bag:CreateAnimation("Alpha")
            -- ba2:SetStartDelay(0.1)
            ba2:SetFromAlpha(1)
            ba2:SetToAlpha(0)
            ba2:SetDuration(0.2)
            ba2:SetOrder(1)
            bag.a2 = ba2

            -- local t2 = bag:CreateAnimation("Scale")
            -- t2:SetFromScale(1.1, 1)
            -- t2:SetToScale(1, 1)
            -- t2:SetDuration(0.7)
            -- t2:SetOrder(2)

            bag.pool = flashPool
            bag:SetScript("OnFinished", function(self)
                self.pool:Release(self:GetParent())
                local frameState = self.state
                local id = self.flashId
                frameState.flashes[id] = nil
            end)

            tex.ag = bag
        end

        tex.ag.state = frameState
        tex.ag.flashId = flashId

        tex.ag:Play()
        return true
        ]=]
    end
    self.flashPool = flashPool


    --------------------

    local lost = CreateHealthLostBar(hp)
    lost.parent = hp
    hp.lost = lost

    --------------------

    local absorb = CreateAbsorbSideBar(hp, absorb_width)
    absorb.parent = hp
    hp.absorb = absorb

    -------------------

    local absorb2 = CreateAbsorbBar(hp)
    absorb2.parent = hp
    hp.absorb2 = absorb2

    -------------------

    local healAbsorb = CreateHealAbsorb(hp)
    healAbsorb.parent = hp
    hp.healabsorb = healAbsorb

    -----------------------

    local hpi = CreateIncominHealBar(hp)
    hpi.parent = hp
    hp.incoming = hpi

    self.health = hp
    -- self.power = stagger

    self.healabsorb = healAbsorb
    self.absorb = absorb
    self.absorb2 = absorb2

    Reconf(self)

    self:EnableMouse(false)
    self:RegisterForDrag("LeftButton")
    self:SetMovable(true)
    self:SetScript("OnDragStart",function(self) self:StartMoving() end)
    self:SetScript("OnDragStop",function(self)
        self:StopMovingOrSizing();
        local db = NugHealthDB
        db.point, db.frame, db.relative_point, db.x, db.y = self:GetPoint(1)
    end)

    -- print(self == NugHealth)
    -- print(db.point, db.frame, db.relative_point, db.x, db.y)

    self:SetPoint(db.point, db.frame, db.relative_point, db.x, db.y)
    self:Hide()

    return self
end



do
    local function CustomStatusBar_SetStatusBarTexture(self, texture)
        self._texture:SetTexture(texture)
    end
    local function CustomStatusBar_GetStatusBarTexture(self)
        return self._texture
    end
    local function CustomStatusBar_SetStatusBarColor(self, r,g,b,a)
        self._texture:SetVertexColor(r,g,b,a)
    end
    local function CustomStatusBar_SetMinMaxValues(self, min, max)
        if max > min then
            self._min = min
            self._max = max
        else
            self._min = 0
            self._max = 1
        end
    end

    local function CustomStatusBar_SetFillStyle(self, fillStyle)
        self._reversed = fillStyle == "REVERSE"
        self:_Configure()
    end
    local function CustomStatusBar_SetOrientation(self, orientation)
        self._orientation = orientation
        self:_Configure()
    end

    local function CustomStatusBar_ResizeVertical(self, value)
        local len = self._height or self:GetHeight()
        self._texture:SetHeight(len*value)
    end
    local function CustomStatusBar_ResizeHorizontal(self, value)
        local len = self._width or self:GetWidth()
        self._texture:SetWidth(len*value)
    end

    local function CustomStatusBar_MakeCoordsVerticalStandard(self, p)
        -- left,right, bottom - (bottom-top)*pos , bottom
        return 0,1, 1-p, 1
    end
    local function CustomStatusBar_MakeCoordsVerticalReversed(self, p)
        return 0,1, 0, p
    end
    local function CustomStatusBar_MakeCoordsHorizontalStandard(self, p)
        return 0,p,0,1
    end
    local function CustomStatusBar_MakeCoordsHorizontalReversed(self, p)
        return 1-p,1,0,1
    end

    local function CustomStatusBar_SetWidth(self, w)
        self:_SetWidth(w)
        self._width = w
    end

    local function CustomStatusBar_SetHeight(self, w)
        self:_SetHeight(w)
        self._height = w
    end

    local function CustomStatusBar_Configure(self)
        local isReversed = self._reversed
        local orientation = self._orientation
        local t = self._texture
        t:ClearAllPoints()
        if orientation == "VERTICAL" then
            self._Resize = CustomStatusBar_ResizeVertical
            if isReversed then
                t:SetPoint("TOPLEFT")
                t:SetPoint("TOPRIGHT")
                self.MakeCoords = CustomStatusBar_MakeCoordsVerticalReversed
            else
                t:SetPoint("BOTTOMLEFT")
                t:SetPoint("BOTTOMRIGHT")
                self.MakeCoords = CustomStatusBar_MakeCoordsVerticalStandard
            end
        else
            self._Resize = CustomStatusBar_ResizeHorizontal
            if isReversed then
                t:SetPoint("TOPRIGHT")
                t:SetPoint("BOTTOMRIGHT")
                self.MakeCoords = CustomStatusBar_MakeCoordsHorizontalReversed
            else
                t:SetPoint("TOPLEFT")
                t:SetPoint("BOTTOMLEFT")
                self.MakeCoords = CustomStatusBar_MakeCoordsHorizontalStandard
            end
        end
        self:SetValue(self._value)
    end

    local function CustomStatusBar_SetValue(self, val)
        local min = self._min
        local max = self._max
        self._value = val
        local pos = (val-min)/(max-min)
        if pos > 1 then pos = 1 end
        local tex = self._texture
        if pos <= 0 then tex:Hide(); return end

        tex:Show()

        self:_Resize(pos)
        self._texture:SetTexCoord(self:MakeCoords(pos))
    end


    function ns.CreateCustomStatusBar(name, parent, orientation)
        local f = CreateFrame("Frame", name, parent)
        f._min = 0
        f._max = 100
        f._value = 0

        local t = f:CreateTexture(nil, "ARTWORK")

        f._texture = t


        f.SetStatusBarTexture = CustomStatusBar_SetStatusBarTexture
        f.GetStatusBarTexture = CustomStatusBar_GetStatusBarTexture
        f.SetStatusBarColor = CustomStatusBar_SetStatusBarColor
        f.SetMinMaxValues = CustomStatusBar_SetMinMaxValues
        f.SetFillStyle = CustomStatusBar_SetFillStyle
        f.SetOrientation = CustomStatusBar_SetOrientation
        f._Configure = CustomStatusBar_Configure
        f.SetValue = CustomStatusBar_SetValue

        -- As i later found out, parent:GetHeight() doesn't immediately return the correct values on login, leading to infinite bars
        -- So i had to move from attachment by opposing corners to attachment by neighboring corners + SetHeight/SetWidth

        f._SetWidth = f.SetWidth
        f.SetWidth = CustomStatusBar_SetWidth
        f._SetHeight = f.SetHeight
        f.SetHeight = CustomStatusBar_SetHeight

        f:SetOrientation(orientation or "HORIZONTAL")

        f:Show()

        return f
    end
end

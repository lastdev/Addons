local __exports = LibStub:NewLibrary("ovale/ui/Icon", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__Localization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__Localization.l
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.isString = __imports.__toolstools.isString
local l = __imports.l
local format = string.format
local next = next
local tostring = tostring
local _G = _G
local GetTime = GetTime
local PlaySoundFile = PlaySoundFile
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local huge = math.huge
local isNumber = __imports.isNumber
local isString = __imports.isString
local infinity = huge
local cooldownThreshold = 0.1
__exports.OvaleIcon = __class(nil, {
    hasScriptControls = function(self)
        return (next(self.parent.checkBoxWidget) ~= nil or next(self.parent.listWidget) ~= nil)
    end,
    constructor = function(self, index, name, parent, secure, ovaleOptions, ovaleSpellBook, actionBar)
        self.index = index
        self.parent = parent
        self.ovaleOptions = ovaleOptions
        self.ovaleSpellBook = ovaleSpellBook
        self.actionBar = actionBar
        self.actionButton = false
        self.shouldClick = false
        self.cdShown = false
        self.onMouseUp = function(_, button)
            if  not self.actionButton then
                if button == "LeftButton" then
                    self.parent:toggleOptions()
                elseif button == "MiddleButton" then
                    self.parent:debugIcon(self.index)
                end
            end
            self.frame:SetChecked(true)
        end
        self.onEnter = function()
            if self.help or self.actionType or self:hasScriptControls() then
                GameTooltip:SetOwner(self.frame, "ANCHOR_BOTTOMLEFT")
                if self.help then
                    GameTooltip:SetText(l[self.help] or self.help)
                end
                if self.actionType then
                    local actionHelp
                    if self.actionHelp then
                        actionHelp = self.actionHelp
                    else
                        if self.actionType == "spell" and isNumber(self.actionId) then
                            actionHelp = self.ovaleSpellBook:getSpellName(self.actionId) or "Unknown spell"
                        elseif self.actionType == "value" and isNumber(self.value) then
                            actionHelp = (self.value < infinity and tostring(self.value)) or "infinity"
                        else
                            actionHelp = format("%s %s", self.actionType, tostring(self.actionId))
                        end
                    end
                    GameTooltip:AddLine(actionHelp, 0.5, 1, 0.75)
                end
                if self:hasScriptControls() then
                    GameTooltip:AddLine(l["options_tooltip"], 1, 1, 1)
                end
                GameTooltip:Show()
            end
        end
        self.onLeave = function()
            if self.help or self:hasScriptControls() then
                GameTooltip:Hide()
            end
        end
        self.frame = CreateFrame("CheckButton", name, parent.iconsFrame, (secure and "SecureActionButtonTemplate, ActionButtonTemplate") or "ActionButtonTemplate")
        local profile = self.ovaleOptions.db.profile
        self.icon = _G[name .. "Icon"]
        self.shortcut = _G[name .. "HotKey"]
        self.remains = _G[name .. "Name"]
        self.rangeIndicator = _G[name .. "Count"]
        self.rangeIndicator:SetText(profile.apparence.targetText)
        self.cd = _G[name .. "Cooldown"]
        self.normalTexture = _G[name .. "NormalTexture"]
        local fontName, fontHeight, fontFlags = self.shortcut:GetFont()
        self.fontName = fontName
        self.fontHeight = fontHeight
        self.fontFlags = fontFlags
        self.focusText = self.frame:CreateFontString(nil, "OVERLAY")
        self.cdShown = true
        self.shouldClick = false
        self.help = nil
        self.value = nil
        self.fontScale = nil
        self.lastSound = nil
        self.cooldownEnd = nil
        self.cooldownStart = nil
        self.texture = nil
        self.positionalParams = nil
        self.namedParams = nil
        self.actionButton = false
        self.actionType = nil
        self.actionId = nil
        self.actionHelp = nil
        self.frame:SetScript("OnMouseUp", self.onMouseUp)
        self.frame:SetScript("OnEnter", self.onEnter)
        self.frame:SetScript("OnLeave", self.onLeave)
        self.focusText:SetFontObject("GameFontNormalSmall")
        self.focusText:SetAllPoints(self.frame)
        self.focusText:SetTextColor(1, 1, 1)
        self.focusText:SetText(l["focus"])
        self.frame:RegisterForClicks("AnyUp")
        if profile.apparence.clickThru then
            self.frame:EnableMouse(false)
        end
    end,
    setValue = function(self, value, actionTexture)
        self.icon:Show()
        self.icon:SetTexture(actionTexture)
        self.icon:SetAlpha(self.ovaleOptions.db.profile.apparence.alpha)
        self.cd:Hide()
        self.focusText:Hide()
        self.rangeIndicator:Hide()
        self.shortcut:Hide()
        if value then
            self.actionType = "value"
            self.actionHelp = nil
            self.value = value
            if value < 10 then
                self.remains:SetFormattedText("%.1f", value)
            elseif value == infinity then
                self.remains:SetFormattedText("inf")
            else
                self.remains:SetFormattedText("%d", value)
            end
            self.remains:Show()
        else
            self.remains:Hide()
        end
        self.frame:Show()
    end,
    update = function(self, element, startTime)
        self.actionType = element.actionType
        self.actionId = element.actionId
        self.value = nil
        local now = GetTime()
        local profile = self.ovaleOptions.db.profile
        if startTime and element.actionTexture then
            local cd = self.cd
            local resetCooldown = false
            if startTime > now then
                local duration = cd:GetCooldownDuration()
                if duration == 0 and self.texture == element.actionTexture and self.cooldownStart and self.cooldownEnd then
                    resetCooldown = true
                end
                if self.texture ~= element.actionTexture or  not self.cooldownStart or  not self.cooldownEnd then
                    self.cooldownStart = now
                    self.cooldownEnd = startTime
                    resetCooldown = true
                elseif startTime < self.cooldownEnd - cooldownThreshold or startTime > self.cooldownEnd + cooldownThreshold then
                    if startTime - self.cooldownEnd > 0.25 or startTime - self.cooldownEnd < -0.25 then
                        self.cooldownStart = now
                    else
                        local oldCooldownProgressPercent = (now - self.cooldownStart) / (self.cooldownEnd - self.cooldownStart)
                        self.cooldownStart = (now - oldCooldownProgressPercent * startTime) / (1 - oldCooldownProgressPercent)
                    end
                    self.cooldownEnd = startTime
                    resetCooldown = true
                end
                self.texture = element.actionTexture
            else
                self.cooldownStart = nil
                self.cooldownEnd = nil
            end
            if self.cdShown and profile.apparence.flashIcon and self.cooldownStart and self.cooldownEnd then
                local start, ending = self.cooldownStart, self.cooldownEnd
                local duration = ending - start
                if resetCooldown and duration > cooldownThreshold then
                    cd:SetDrawEdge(false)
                    cd:SetSwipeColor(0, 0, 0, 0.8)
                    cd:SetCooldown(start, duration)
                end
                cd:Show()
            else
                cd:Hide()
            end
            self.icon:Show()
            self.icon:SetTexture(element.actionTexture)
            if element.actionUsable then
                self.icon:SetAlpha(1)
            else
                self.icon:SetAlpha(0.5)
            end
            local options = element.options
            if options then
                if options.nored ~= 1 and element.actionResourceExtend and element.actionResourceExtend > 0 then
                    self.icon:SetVertexColor(0.75, 0.2, 0.2)
                else
                    self.icon:SetVertexColor(1, 1, 1)
                end
                if isString(options.help) then
                    self.actionHelp = options.help
                end
                if  not (self.cooldownStart and self.cooldownEnd) then
                    self.lastSound = nil
                end
                if isString(options.sound) and  not self.lastSound then
                    local delay
                    if isNumber(options.soundtime) then
                        delay = options.soundtime
                    else
                        delay = 0.5
                    end
                    if now >= startTime - delay then
                        self.lastSound = options.sound
                        PlaySoundFile(self.lastSound)
                    end
                end
            end
            local red = false
            if  not red and startTime > now and profile.apparence.highlightIcon then
                local lag = 0.6
                local newShouldClick = startTime < now + lag
                if self.shouldClick ~= newShouldClick then
                    if newShouldClick then
                        self.frame:SetChecked(true)
                    else
                        self.frame:SetChecked(false)
                    end
                    self.shouldClick = newShouldClick
                end
            elseif self.shouldClick then
                self.shouldClick = false
                self.frame:SetChecked(false)
            end
            if (profile.apparence.numeric or (self.namedParams and self.namedParams.text and self.namedParams.text.type == "string" and self.namedParams.text.value == "always")) and startTime > now then
                self.remains:SetFormattedText("%.1f", startTime - now)
                self.remains:Show()
            else
                self.remains:Hide()
            end
            local showShortcut = false
            if profile.apparence.raccourcis and element.actionSlot then
                local binding = self.actionBar:getBindings(element.actionSlot)
                if binding then
                    self.shortcut:SetText(binding)
                    showShortcut = true
                end
            end
            if showShortcut then
                self.shortcut:Show()
            else
                self.shortcut:Hide()
            end
            if element.actionInRange == nil then
                self.rangeIndicator:Hide()
            elseif element.actionInRange then
                self.rangeIndicator:SetVertexColor(0.6, 0.6, 0.6)
                self.rangeIndicator:Show()
            else
                self.rangeIndicator:SetVertexColor(1, 0.1, 0.1)
                self.rangeIndicator:Show()
            end
            if options and options.text then
                self.focusText:SetText(tostring(options.text))
                self.focusText:Show()
            elseif element.actionTarget and element.actionTarget ~= "target" then
                self.focusText:SetText(element.actionTarget)
                self.focusText:Show()
            else
                self.focusText:Hide()
            end
            self.frame:Show()
        else
            self.icon:Hide()
            self.rangeIndicator:Hide()
            self.shortcut:Hide()
            self.remains:Hide()
            self.focusText:Hide()
            if profile.apparence.hideEmpty then
                self.frame:Hide()
            else
                self.frame:Show()
            end
            if self.shouldClick then
                self.frame:SetChecked(false)
                self.shouldClick = false
            end
        end
        return startTime, element
    end,
    setHelp = function(self, help)
        self.help = help
    end,
    setParams = function(self, positionalParams, namedParams)
        self.positionalParams = positionalParams
        self.namedParams = namedParams
        self.actionButton = false
    end,
    setRemainsFont = function(self, color)
        self.remains:SetTextColor(color.r, color.g, color.b, 1)
        self.remains:SetJustifyH("left")
        self.remains:SetPoint("BOTTOMLEFT", 2, 2)
    end,
    setFontScale = function(self, scale)
        self.fontScale = scale
        self.remains:SetFont(self.fontName, self.fontHeight * self.fontScale, self.fontFlags)
        self.shortcut:SetFont(self.fontName, self.fontHeight * self.fontScale, self.fontFlags)
        self.rangeIndicator:SetFont(self.fontName, self.fontHeight * self.fontScale, self.fontFlags)
        self.focusText:SetFont(self.fontName, self.fontHeight * self.fontScale, self.fontFlags)
    end,
    setRangeIndicator = function(self, text)
        self.rangeIndicator:SetText(text)
    end,
    setPoint = function(self, anchor, reference, refAnchor, x, y)
        self.frame:SetPoint(anchor, reference, refAnchor, x, y)
    end,
    Show = function(self)
        self.frame:Show()
    end,
    Hide = function(self)
        self.frame:Hide()
    end,
    setScale = function(self, scale)
        self.frame:SetScale(scale)
    end,
    enableMouse = function(self, enabled)
        self.frame:EnableMouse(enabled)
    end,
})

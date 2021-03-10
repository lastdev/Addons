local __exports = LibStub:NewLibrary("ovale/ui/Frame", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local AceGUI = LibStub:GetLibrary("AceGUI-3.0", true)
local Masque = LibStub:GetLibrary("Masque", true)
local __Icon = LibStub:GetLibrary("ovale/ui/Icon")
local OvaleIcon = __Icon.OvaleIcon
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ipairs = ipairs
local next = next
local pairs = pairs
local wipe = wipe
local type = type
local match = string.match
local CreateFrame = CreateFrame
local GetItemInfo = GetItemInfo
local GetTime = GetTime
local RegisterStateDriver = RegisterStateDriver
local UnitHasVehicleUI = UnitHasVehicleUI
local UnitExists = UnitExists
local UnitIsDead = UnitIsDead
local UnitCanAttack = UnitCanAttack
local UIParent = UIParent
local huge = math.huge
local __aceguihelpers = LibStub:GetLibrary("ovale/ui/acegui-helpers")
local WidgetContainer = __aceguihelpers.WidgetContainer
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local oneTimeMessage = __toolstools.oneTimeMessage
local printOneTimeMessages = __toolstools.printOneTimeMessages
local stringify = __toolstools.stringify
local insert = table.insert
local LibTextDump = LibStub:GetLibrary("LibTextDump-1.0", true)
local __Localization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __Localization.l
local infinity = huge
local dragHandlerHeight = 8
local OvaleFrame = __class(WidgetContainer, {
    toggleOptions = function(self)
        if self.content:IsShown() then
            self.content:Hide()
        else
            self.content:Show()
        end
    end,
    Hide = function(self)
        self.frame:Hide()
    end,
    Show = function(self)
        self.frame:Show()
    end,
    OnAcquire = function(self)
        self.frame:SetParent(UIParent)
    end,
    OnRelease = function(self)
    end,
    getScore = function(self, spellId)
        for _, action in pairs(self.actions) do
            if action.spellId == spellId then
                if  not action.waitStart then
                    return 1
                else
                    local now = self.baseState.currentTime
                    local lag = now - action.waitStart
                    if lag > 5 then
                        return nil
                    elseif lag > 1.5 then
                        return 0
                    elseif lag > 0 then
                        return 1 - lag / 1.5
                    else
                        return 1
                    end
                end
            end
        end
        return 0
    end,
    goNextIcon = function(self, action, left, top, maxWidth, maxHeight)
        local profile = self.ovaleOptions.db.profile
        local margin = profile.apparence.margin
        local width = action.scale * 36 + margin
        local height = action.scale * 36 + margin
        action.left = left
        action.top = top
        if profile.apparence.vertical then
            action.dx = 0
            action.dy = -height
        else
            action.dx = width
            action.dy = 0
        end
        if left + width > maxWidth then
            maxWidth = left + width
        end
        if height - top > maxHeight then
            maxHeight = height - top
        end
        left = left + action.dx
        top = top + action.dy
        return left, top, maxWidth, maxHeight
    end,
    updateVisibility = function(self)
        self.visible = true
        local profile = self.ovaleOptions.db.profile
        if  not profile.apparence.enableIcons then
            self.visible = false
        elseif  not self.petFrame:IsVisible() then
            self.visible = false
        else
            if profile.apparence.hideVehicule and UnitHasVehicleUI("player") then
                self.visible = false
            end
            if profile.apparence.avecCible and  not UnitExists("target") then
                self.visible = false
            end
            if profile.apparence.enCombat and  not self.combat:isInCombat(nil) then
                self.visible = false
            end
            if profile.apparence.targetHostileOnly and (UnitIsDead("target") or  not UnitCanAttack("player", "target")) then
                self.visible = false
            end
        end
        if self.visible then
            self:Show()
        else
            self:Hide()
        end
    end,
    handleUpdate = function(self, elapsed)
        self.ovaleFrameModule.module:SendMessage("Ovale_OnUpdate")
        self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed
        local refresh = false
        if self.ovaleDebug.trace then
            refresh = true
        elseif self.visible or self.ovaleSpellFlash:isSpellFlashEnabled() then
            local minSeconds = self.ovaleOptions.db.profile.apparence.minFrameRefresh / 1000
            local maxSeconds = self.ovaleOptions.db.profile.apparence.maxFrameRefresh / 1000
            if self.timeSinceLastUpdate > minSeconds and next(self.ovale.refreshNeeded) then
                refresh = true
            elseif self.timeSinceLastUpdate > maxSeconds then
                refresh = true
            end
        end
        if refresh then
            self.ovale:addRefreshInterval(self.timeSinceLastUpdate * 1000)
            self.ovaleState:initializeState()
            if self.ovaleCompile:evaluateScript() then
                self:updateFrame()
            end
            self.ovaleState:resetState()
            self.ovaleFuture:applyInFlightSpells()
            local profile = self.ovaleOptions.db.profile
            local iconNodes = self.ovaleCompile:getIconNodes()
            local left = 0
            local top = 0
            local maxHeight = 0
            local maxWidth = 0
            for k, node in ipairs(iconNodes) do
                local icon = self.actions[k]
                self.tracer:log("+++ Icon %d", k)
                local element, atTime = self:getIconAction(node)
                if element and atTime then
                    left, top, maxWidth, maxHeight = self:goNextIcon(icon, left, top, maxWidth, maxHeight)
                    icon.icons:Show()
                    local start
                    if element.type == "action" and element.offgcd then
                        start = element.timeSpan:nextTime(self.baseState.currentTime)
                    else
                        start = element.timeSpan:nextTime(atTime)
                    end
                    if profile.apparence.enableIcons then
                        self:updateActionIcon(icon, element, start or 0)
                    end
                    if profile.apparence.spellFlash.enabled then
                        self.ovaleSpellFlash:flash(node.cachedParams.named.flash, node.cachedParams.named.help, element, start or 0, k)
                    end
                else
                    self.ovaleSpellFlash:hideFlash(k)
                    icon.icons:Hide()
                end
            end
            self:updateDragHandle(maxWidth, maxHeight)
            wipe(self.ovale.refreshNeeded)
            self.ovaleDebug:updateTrace()
            printOneTimeMessages()
            self.timeSinceLastUpdate = 0
        end
    end,
    updateActionIcon = function(self, action, element, start, now)
        local profile = self.ovaleOptions.db.profile
        local icons = action.icons
        now = now or GetTime()
        if element.type == "value" then
            local value
            if isNumber(element.value) and element.origin and element.rate then
                value = element.value + (now - element.origin) * element.rate
            end
            self.tracer:log("GetAction: start=%s, value=%f", start, value)
            icons:setValue(value, nil)
        elseif element.type == "none" then
            icons:setValue(nil, nil)
        elseif element.type == "action" then
            if element.actionResourceExtend and element.actionResourceExtend > 0 then
                if element.actionCooldownDuration and element.actionCooldownDuration > 0 then
                    self.tracer:log("Extending cooldown of spell ID '%s' for primary resource by %fs.", element.actionId, element.actionResourceExtend)
                    element.actionCooldownDuration = element.actionCooldownDuration + element.actionResourceExtend
                elseif element.options and element.options.pool_resource == 1 then
                    self.tracer:log("Delaying spell ID '%s' for primary resource by %fs.", element.actionId, element.actionResourceExtend)
                    start = start + element.actionResourceExtend
                end
            end
            self.tracer:log("GetAction: start=%s, id=%s", start, element.actionId)
            if element.actionType == "spell" and element.actionId == self.ovaleFuture.next.currentCast.spellId and start and self.ovaleFuture.next.nextCast and start < self.ovaleFuture.next.nextCast then
                start = self.ovaleFuture.next.nextCast
            end
            icons:update(element, start)
            if element.actionType == "spell" then
                action.spellId = element.actionId
            else
                action.spellId = nil
            end
            if start and start <= now and element.actionUsable then
                action.waitStart = action.waitStart or now
            else
                action.waitStart = nil
            end
            if profile.apparence.moving and icons.cooldownStart and icons.cooldownEnd then
                local ratio = 1 - (now - icons.cooldownStart) / (icons.cooldownEnd - icons.cooldownStart)
                if ratio < 0 then
                    ratio = 0
                elseif ratio > 1 then
                    ratio = 1
                end
                icons:setPoint("TOPLEFT", self.iconsFrame, "TOPLEFT", (action.left + ratio * action.dx) / action.scale, (action.top + ratio * action.dy) / action.scale)
            end
        end
        if  not profile.apparence.moving then
            icons:setPoint("TOPLEFT", self.iconsFrame, "TOPLEFT", action.left / action.scale, action.top / action.scale - dragHandlerHeight - profile.apparence.margin)
        end
    end,
    updateFrame = function(self)
        local profile = self.ovaleOptions.db.profile
        if self.petFrame:IsVisible() then
            self.frame:ClearAllPoints()
            self.frame:SetPoint("CENTER", self.petFrame, "CENTER", profile.apparence.offsetX, profile.apparence.offsetY)
            self.frame:EnableMouse( not profile.apparence.clickThru)
        end
        self:ReleaseChildren()
        self:updateIcons()
        self:updateControls()
        self:updateVisibility()
    end,
    getCheckBox = function(self, name)
        local widget
        if type(name) == "string" then
            widget = self.checkBoxWidget[name]
        elseif type(name) == "number" then
            local k = 0
            for _, frame in pairs(self.checkBoxWidget) do
                if k == name then
                    widget = frame
                    break
                end
                k = k + 1
            end
        end
        return widget
    end,
    isChecked = function(self, name)
        local widget = self:getCheckBox(name)
        return widget and widget:GetValue()
    end,
    getListValue = function(self, name)
        local widget = self.listWidget[name]
        return widget and widget:GetValue()
    end,
    setCheckBox = function(self, name, on)
        local widget = self:getCheckBox(name)
        if widget then
            local oldValue = widget:GetValue()
            if oldValue ~= on then
                widget:SetValue(on)
                self.handleCheckBoxValueChanged(widget)
            end
        end
    end,
    toggleCheckBox = function(self, name)
        local widget = self:getCheckBox(name)
        if widget then
            local on =  not widget:GetValue()
            widget:SetValue(on)
            self.handleCheckBoxValueChanged(widget)
        end
    end,
    finalizeString = function(self, s)
        local item, id = match(s, "^(item:)(.+)")
        if item then
            s = GetItemInfo(id)
        end
        return s
    end,
    updateControls = function(self)
        local profile = self.ovaleOptions.db.profile
        wipe(self.checkBoxWidget)
        local atTime = self.ovaleFuture.next.nextCast
        for _, checkBox in ipairs(self.controls.checkBoxes) do
            if checkBox.text and ( not checkBox.enabled or self.runner:computeAsBoolean(checkBox.enabled, atTime)) then
                local name = checkBox.name
                local widget = AceGUI:Create("CheckBox")
                local text = self:finalizeString(checkBox.text)
                widget:SetLabel(text)
                if profile.check[name] == nil then
                    profile.check[name] = checkBox.defaultValue
                end
                if profile.check[name] then
                    widget:SetValue(profile.check[name])
                end
                widget:SetUserData("name", name)
                widget:SetCallback("OnValueChanged", self.handleCheckBoxValueChanged)
                self:AddChild(widget)
                self.checkBoxWidget[name] = widget
            end
        end
        wipe(self.listWidget)
        for _, list in ipairs(self.controls.lists) do
            if next(list.items) then
                local widget = AceGUI:Create("Dropdown")
                local items = {}
                local order = {}
                for _, v in ipairs(list.items) do
                    if  not v.enabled or self.runner:computeAsBoolean(v.enabled, atTime) then
                        items[v.name] = v.text
                        insert(order, v.name)
                    end
                end
                widget:SetList(items, order)
                local name = list.name
                if  not profile.list[name] then
                    profile.list[name] = list.defaultValue
                end
                if profile.list[name] then
                    widget:SetValue(profile.list[name])
                end
                widget:SetUserData("name", name)
                widget:SetCallback("OnValueChanged", self.handleDropDownValueChanged)
                self:AddChild(widget)
                self.listWidget[name] = widget
            else
                oneTimeMessage("Warning: list '%s' is used but has no items.", list.name)
            end
        end
    end,
    updateIcons = function(self)
        for _, action in pairs(self.actions) do
            action.icons:Hide()
            action.icons:Hide()
        end
        local profile = self.ovaleOptions.db.profile
        self.frame:EnableMouse( not profile.apparence.clickThru)
        local iconNodes = self.ovaleCompile:getIconNodes()
        for k, node in ipairs(iconNodes) do
            if  not self.actions[k] then
                self.actions[k] = {
                    icons = OvaleIcon(k, "Icon" .. k, self, false, self.ovaleOptions, self.ovaleSpellBook, self.actionBar),
                    dx = 0,
                    dy = 0,
                    left = 0,
                    scale = 1,
                    top = 0
                }
            end
            local action = self.actions[k]
            local newScale
            if node.rawNamedParams.size ~= nil and node.rawNamedParams.size.type == "string" and node.rawNamedParams.size.value == "small" then
                newScale = profile.apparence.smallIconScale
            else
                newScale = profile.apparence.iconScale
            end
            action.scale = newScale
            local icon
            icon = action.icons
            local scale = action.scale
            icon:setScale(scale)
            icon:setRemainsFont(profile.apparence.remainsFontColor)
            icon:setFontScale(profile.apparence.fontScale)
            icon:setParams(node.rawPositionalParams, node.rawNamedParams)
            icon:setHelp((node.rawNamedParams.help ~= nil and node.rawNamedParams.help.type == "string" and node.rawNamedParams.help.value) or nil)
            icon:setRangeIndicator(profile.apparence.targetText)
            icon:enableMouse( not profile.apparence.clickThru)
            icon.frame:SetAlpha(profile.apparence.alpha)
            icon.cdShown = true
            if self.skinGroup then
                self.skinGroup:AddButton(icon.frame)
            end
            icon:Show()
        end
        self.content:SetAlpha(profile.apparence.optionsAlpha)
    end,
    updateDragHandle = function(self, maxWidth, maxHeight)
        local profile = self.ovaleOptions.db.profile
        local margin = profile.apparence.margin
        self.dragHandleTexture:SetWidth(maxWidth - margin)
        self.dragHandleTexture:SetHeight(dragHandlerHeight)
        self.frame:SetWidth(maxWidth)
        self.frame:SetHeight(maxHeight + dragHandlerHeight + margin)
        self.content:SetPoint("TOPLEFT", maxWidth + profile.apparence.iconShiftX, profile.apparence.iconShiftY - dragHandlerHeight)
    end,
    constructor = function(self, ovaleState, ovaleFrameModule, ovaleCompile, ovaleFuture, baseState, ovaleEnemies, ovale, ovaleOptions, ovaleDebug, ovaleSpellFlash, ovaleSpellBook, ovaleBestAction, combat, runner, controls, scripts, actionBar, petFrame)
        self.ovaleState = ovaleState
        self.ovaleFrameModule = ovaleFrameModule
        self.ovaleCompile = ovaleCompile
        self.ovaleFuture = ovaleFuture
        self.baseState = baseState
        self.ovaleEnemies = ovaleEnemies
        self.ovale = ovale
        self.ovaleOptions = ovaleOptions
        self.ovaleDebug = ovaleDebug
        self.ovaleSpellFlash = ovaleSpellFlash
        self.ovaleSpellBook = ovaleSpellBook
        self.ovaleBestAction = ovaleBestAction
        self.combat = combat
        self.runner = runner
        self.controls = controls
        self.scripts = scripts
        self.actionBar = actionBar
        self.petFrame = petFrame
        self.checkBoxWidget = {}
        self.listWidget = {}
        self.visible = true
        self.OnWidthSet = function(width)
            local content = self.content
            local contentwidth = width
            if contentwidth < 0 then
                contentwidth = 0
            end
            content:SetWidth(contentwidth)
        end
        self.OnHeightSet = function(height)
            local content = self.content
            local contentheight = height
            if contentheight < 0 then
                contentheight = 0
            end
            content:SetHeight(contentheight)
        end
        self.handleCheckBoxValueChanged = function(widget)
            local name = widget:GetUserData("name")
            self.ovaleOptions.db.profile.check[name] = widget:GetValue()
            self.ovaleFrameModule.module:SendMessage("Ovale_CheckBoxValueChanged", name)
        end
        self.handleDropDownValueChanged = function(widget)
            local name = widget:GetUserData("name")
            self.ovaleOptions.db.profile.list[name] = widget:GetValue()
            self.ovaleFrameModule.module:SendMessage("Ovale_ListValueChanged", name)
        end
        self.type = "Frame"
        self.localstatus = {}
        self.actions = {}
        WidgetContainer.constructor(self, CreateFrame("Frame", "OvaleIcons", petFrame))
        self.traceLog = LibTextDump:New("Ovale - " .. l.icon_snapshot, 750, 500)
        self.tracer = ovaleDebug:create("OvaleFrame")
        self.updateIntervalFrame = CreateFrame("Frame", ovale:GetName() .. "UpdateFrame")
        self.updateIntervalFrame:SetAllPoints(self.frame)
        self.updateIntervalFrame:Show()
        self.iconsFrame = CreateFrame("Frame", nil, self.frame)
        self.iconsFrame:SetAllPoints(self.frame)
        self.dragHandleTexture = self.frame:CreateTexture()
        if Masque then
            self.skinGroup = Masque:Group(ovale:GetName())
        end
        self.timeSinceLastUpdate = infinity
        local frame = self.frame
        frame:SetWidth(100)
        frame:SetHeight(100)
        frame:SetMovable(true)
        frame:SetFrameStrata("MEDIUM")
        frame:SetScript("OnMouseDown", function()
            if  not ovaleOptions.db.profile.apparence.verrouille then
                frame:StartMoving()
                AceGUI:ClearFocus()
            end
        end)
        frame:SetScript("OnMouseUp", function()
            frame:StopMovingOrSizing()
            local x, y = frame:GetCenter()
            local parent = frame:GetParent()
            if parent then
                local profile = ovaleOptions.db.profile
                local parentX, parentY = parent:GetCenter()
                profile.apparence.offsetX = x - parentX
                profile.apparence.offsetY = y - parentY
            end
        end)
        frame:SetScript("OnEnter", function()
            local profile = ovaleOptions.db.profile
            if  not (profile.apparence.enableIcons and profile.apparence.verrouille) then
                self.dragHandleTexture:Show()
            end
        end)
        frame:SetScript("OnLeave", function()
            self.dragHandleTexture:Hide()
        end)
        frame:SetScript("OnHide", function()
            return self:Hide()
        end)
        self.updateIntervalFrame:SetScript("OnUpdate", function(updateFrame, elapsed)
            return self:handleUpdate(elapsed)
        end)
        self.dragHandleTexture:SetColorTexture(0.8, 0.8, 0.8, 0.5)
        self.dragHandleTexture:SetPoint("TOPLEFT", 0, 0)
        self.dragHandleTexture:Hide()
        local content = self.content
        content:Hide()
    end,
    debugIcon = function(self, index)
        local iconNodes = self.ovaleCompile:getIconNodes()
        self.tracer:print("%d", index)
        local result, atTime = self:getIconAction(iconNodes[index])
        if result and atTime then
            local traceLog = self.traceLog
            traceLog:Clear()
            local serial = result.serial
            traceLog:AddLine("{ \"atTime\": " .. atTime .. ", \"serial\": " .. serial .. ", \"index\": " .. index .. ", \"script\": \"" .. self.scripts:getScriptName(self.scripts:getCurrentSpecScriptName()) .. "\", \"nodes\": {")
            local first = true
            for _, node in ipairs(iconNodes[index].annotation.nodeList) do
                if  not node.result.constant then
                    local nodeResult = node.result
                    if nodeResult.serial == serial then
                        local serialized
                        if first then
                            first = false
                            serialized = ""
                        else
                            serialized = ","
                        end
                        serialized = serialized .. "\"" .. node.nodeId .. "\": {\"result\": " .. stringify(node.result) .. ", \"type\": \"" .. node.type .. "\", \"asString\": " .. stringify(node.asString) .. " }"
                        traceLog:AddLine(serialized)
                    end
                end
            end
            traceLog:AddLine("}, \"result\": " .. stringify(result) .. " }")
            traceLog:Display()
            self.ovaleDebug.trace = true
            self.ovaleDebug.traceLog:Clear()
            self.ovaleState:resetState()
            self.ovaleFuture:applyInFlightSpells()
            self:getIconAction(iconNodes[index])
            self.ovaleDebug.trace = false
            self.ovaleDebug:displayTraceLog()
        end
    end,
    getIconAction = function(self, node)
        if node.rawNamedParams.target and node.rawNamedParams.target.type == "string" then
            self.tracer:debug("Default target is " .. node.rawNamedParams.target.value)
            self.baseState.defaultTarget = node.rawNamedParams.target.value
        else
            self.baseState.defaultTarget = "target"
        end
        if node.rawNamedParams.enemies and node.rawNamedParams.enemies.type == "value" then
            self.ovaleEnemies.next.enemies = node.rawNamedParams.enemies.value
        else
            self.ovaleEnemies.next.enemies = nil
        end
        self.ovaleBestAction:startNewAction()
        local atTime = self.ovaleFuture.next.nextCast
        if self.ovaleFuture.next.currentCast.spellId == nil or self.ovaleFuture.next.currentCast.spellId ~= self.ovaleFuture.next.lastGCDSpellId or self.ovaleFuture:isChannelingAtTime(self.baseState.currentTime) then
            atTime = self.baseState.currentTime
        end
        local _, namedParameters = self.runner:computeParameters(node, atTime)
        if namedParameters.enabled == nil or namedParameters.enabled then
            return self.ovaleBestAction:getAction(node, atTime), atTime
        end
        return 
    end,
})
__exports.OvaleFrameModuleClass = __class(nil, {
    constructor = function(self, ovaleState, ovaleCompile, ovaleFuture, baseState, ovaleEnemies, ovale, ovaleOptions, ovaleDebug, ovaleSpellFlash, ovaleSpellBook, ovaleBestAction, combat, runner, controls, scripts, actionBar)
        self.ovaleState = ovaleState
        self.ovaleCompile = ovaleCompile
        self.ovaleFuture = ovaleFuture
        self.baseState = baseState
        self.ovaleEnemies = ovaleEnemies
        self.ovale = ovale
        self.ovaleOptions = ovaleOptions
        self.ovaleDebug = ovaleDebug
        self.ovaleSpellFlash = ovaleSpellFlash
        self.ovaleSpellBook = ovaleSpellBook
        self.ovaleBestAction = ovaleBestAction
        self.handleInitialize = function()
            self.module:RegisterMessage("Ovale_OptionChanged", self.handleOptionChanged)
            self.module:RegisterMessage("Ovale_CombatStarted", self.handleCombatStarted)
            self.module:RegisterMessage("Ovale_CombatEnded", self.handleCombatEnded)
            self.module:RegisterEvent("PLAYER_TARGET_CHANGED", self.handlePlayerTargetChanged)
            self.frame:updateFrame()
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_OptionChanged")
            self.module:UnregisterMessage("Ovale_CombatStarted")
            self.module:UnregisterMessage("Ovale_CombatEnded")
            self.module:UnregisterEvent("PLAYER_TARGET_CHANGED")
        end
        self.handleOptionChanged = function(event, eventType)
            if  not self.frame then
                return 
            end
            if eventType == "visibility" then
                self.frame:updateVisibility()
            else
                self.frame:updateFrame()
            end
        end
        self.handlePlayerTargetChanged = function()
            self.frame:updateVisibility()
        end
        self.handleCombatStarted = function()
            self.frame:updateVisibility()
        end
        self.handleCombatEnded = function()
            self.frame:updateVisibility()
        end
        local petFrame = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
        RegisterStateDriver(petFrame, "visibility", "[petbattle] hide; show")
        petFrame:SetAllPoints(UIParent)
        self.module = ovale:createModule("OvaleFrame", self.handleInitialize, self.handleDisable, aceEvent)
        self.frame = OvaleFrame(self.ovaleState, self, self.ovaleCompile, self.ovaleFuture, self.baseState, self.ovaleEnemies, self.ovale, self.ovaleOptions, self.ovaleDebug, self.ovaleSpellFlash, self.ovaleSpellBook, self.ovaleBestAction, combat, runner, controls, scripts, actionBar, petFrame)
    end,
})

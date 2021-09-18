local __exports = LibStub:NewLibrary("ovale/engine/action-bar", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__uiLocalization.l
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.aceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
__imports.ElvUI = LibStub:GetLibrary("LibActionButton-1.0-ElvUI", true)
local l = __imports.l
local aceEvent = __imports.aceEvent
local aceTimer = __imports.aceTimer
local gsub = string.gsub
local len = string.len
local match = string.match
local upper = string.upper
local concat = table.concat
local sort = table.sort
local insert = table.insert
local tonumber = tonumber
local wipe = wipe
local pairs = pairs
local tostring = tostring
local ipairs = ipairs
local _G = _G
local GetActionInfo = GetActionInfo
local GetActionText = GetActionText
local GetBindingKey = GetBindingKey
local GetBonusBarIndex = GetBonusBarIndex
local GetMacroItem = GetMacroItem
local GetMacroSpell = GetMacroSpell
local ElvUI = __imports.ElvUI
local actionBars = {
    [1] = "ActionButton",
    [2] = "MultiBarRightButton",
    [3] = "MultiBarLeftButton",
    [4] = "MultiBarBottomRightButton",
    [5] = "MultiBarBottomLeftButton"
}
__exports.OvaleActionBarClass = __class(nil, {
    constructor = function(self, ovaleDebug, ovale, ovaleSpellBook)
        self.ovaleSpellBook = ovaleSpellBook
        self.debugOptions = {
            actionbar = {
                name = l["action_bar"],
                type = "group",
                args = {
                    spellbook = {
                        name = l["action_bar"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function()
                            return self:debugActions()
                        end
                    }
                }
            }
        }
        self.action = {}
        self.keybind = {}
        self.spell = {}
        self.macro = {}
        self.item = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("ACTIONBAR_SLOT_CHANGED", self.handleActionBarSlotChanged)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleActionSlotUpdate)
            self.module:RegisterEvent("UPDATE_BINDINGS", self.handleUpdateBindings)
            self.module:RegisterEvent("UPDATE_BONUS_ACTIONBAR", self.handleActionSlotUpdate)
            self.module:RegisterEvent("SPELLS_CHANGED", self.handleActionSlotUpdate)
            self.module:RegisterMessage("Ovale_StanceChanged", self.handleActionSlotUpdate)
            self.module:RegisterMessage("Ovale_TalentsChanged", self.handleActionSlotUpdate)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("UPDATE_BINDINGS")
            self.module:UnregisterEvent("UPDATE_BONUS_ACTIONBAR")
            self.module:UnregisterEvent("SPELLS_CHANGED")
            self.module:UnregisterMessage("Ovale_StanceChanged")
            self.module:UnregisterMessage("Ovale_TalentsChanged")
        end
        self.handleActionBarSlotChanged = function(event, slot)
            slot = tonumber(slot)
            if slot == 0 then
                self.handleActionSlotUpdate(event)
            elseif ElvUI then
                local elvUIButtons = ElvUI.buttonRegistry
                for btn in pairs(elvUIButtons) do
                    local s = btn:GetAttribute("action")
                    if s == slot then
                        self:updateActionSlot(slot)
                    end
                end
            elseif slot then
                local bonus = tonumber(GetBonusBarIndex()) * 12
                local bonusStart = (bonus > 0 and bonus - 11) or 1
                local isBonus = slot >= bonusStart and slot < bonusStart + 12
                if isBonus or (slot > 12 and slot < 73) then
                    self:updateActionSlot(slot)
                end
            end
        end
        self.handleUpdateBindings = function(event)
            self.debug:debug("%s: Updating key bindings.", event)
            self:updateKeyBindings()
        end
        self.handleTimerUpdateActionSlots = function()
            self.handleActionSlotUpdate("TimerUpdateActionSlots")
        end
        self.handleActionSlotUpdate = function(event)
            self.debug:debug("%s: Updating all action slot mappings.", event)
            wipe(self.action)
            wipe(self.item)
            wipe(self.macro)
            wipe(self.spell)
            if ElvUI then
                local elvUIButtons = ElvUI.buttonRegistry
                for btn in pairs(elvUIButtons) do
                    local s = btn:GetAttribute("action")
                    self:updateActionSlot(s)
                end
            else
                local start = 1
                local bonus = tonumber(GetBonusBarIndex()) * 12
                if bonus > 0 then
                    start = 13
                    for slot = bonus - 11, bonus, 1 do
                        self:updateActionSlot(slot)
                    end
                end
                for slot = start, 72, 1 do
                    self:updateActionSlot(slot)
                end
            end
            if event ~= "TimerUpdateActionSlots" then
                self.module:ScheduleTimer(self.handleTimerUpdateActionSlots, 1)
            end
        end
        self.output = {}
        self.module = ovale:createModule("OvaleActionBar", self.handleInitialize, self.handleDisable, aceEvent, aceTimer)
        self.debug = ovaleDebug:create("OvaleActionBar")
        for k, v in pairs(self.debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    getKeyBinding = function(self, slot)
        local name
        if _G["Bartender4"] then
            name = "CLICK BT4Button" .. slot .. ":LeftButton"
        else
            if slot <= 24 or slot > 72 then
                name = "ACTIONBUTTON" .. (((slot - 1) % 12) + 1)
            elseif slot <= 36 then
                name = "MULTIACTIONBAR3BUTTON" .. (slot - 24)
            elseif slot <= 48 then
                name = "MULTIACTIONBAR4BUTTON" .. (slot - 36)
            elseif slot <= 60 then
                name = "MULTIACTIONBAR2BUTTON" .. (slot - 48)
            else
                name = "MULTIACTIONBAR1BUTTON" .. (slot - 60)
            end
        end
        local key = name and GetBindingKey(name)
        if key and len(key) > 4 then
            key = upper(key)
            key = gsub(key, "%s+", "")
            key = gsub(key, "ALT%-", "A")
            key = gsub(key, "CTRL%-", "C")
            key = gsub(key, "SHIFT%-", "S")
            key = gsub(key, "NUMPAD", "N")
            key = gsub(key, "PLUS", "+")
            key = gsub(key, "MINUS", "-")
            key = gsub(key, "MULTIPLY", "*")
            key = gsub(key, "DIVIDE", "/")
            key = gsub(key, "BUTTON", "B")
        end
        return key
    end,
    parseHyperlink = function(self, hyperlink)
        local color, linkType, linkData, text = match(hyperlink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
        return color, linkType, linkData, text
    end,
    updateActionSlot = function(self, slot)
        local action = self.action[slot]
        if self.spell[action] == slot then
            self.spell[action] = nil
        elseif self.item[action] == slot then
            self.item[action] = nil
        elseif self.macro[action] == slot then
            self.macro[action] = nil
        end
        self.action[slot] = nil
        local actionType, actionId = GetActionInfo(slot)
        if actionType == "spell" then
            local id = tonumber(actionId)
            if id then
                if  not self.spell[id] or slot < self.spell[id] then
                    self.spell[id] = slot
                end
                self.action[slot] = id
            end
        elseif actionType == "item" then
            local id = tonumber(actionId)
            if id then
                if  not self.item[id] or slot < self.item[id] then
                    self.item[id] = slot
                end
                self.action[slot] = id
            end
        elseif actionType == "macro" then
            local id = tonumber(actionId)
            if id then
                local actionText = GetActionText(slot)
                if actionText then
                    if  not self.macro[actionText] or slot < self.macro[actionText] then
                        self.macro[actionText] = slot
                    end
                    local spellId = GetMacroSpell(id)
                    if spellId then
                        if  not self.spell[spellId] or slot < self.spell[spellId] then
                            self.spell[spellId] = slot
                        end
                        self.action[slot] = spellId
                    else
                        local _, hyperlink = GetMacroItem(id)
                        if hyperlink then
                            local _, _, linkData = self:parseHyperlink(hyperlink)
                            local itemIdText = gsub(linkData, ":.*", "")
                            local itemId = tonumber(itemIdText)
                            if itemId then
                                if  not self.item[itemId] or slot < self.item[itemId] then
                                    self.item[itemId] = slot
                                end
                                self.action[slot] = itemId
                            end
                        end
                    end
                    if  not self.action[slot] then
                        self.action[slot] = actionText
                    end
                end
            end
        end
        if self.action[slot] then
            self.debug:debug("Mapping button %s to %s.", slot, self.action[slot])
        else
            self.debug:debug("Clearing mapping for button %s.", slot)
        end
        self.keybind[slot] = self:getKeyBinding(slot)
    end,
    updateKeyBindings = function(self)
        for slot = 1, 120, 1 do
            self.keybind[slot] = self:getKeyBinding(slot)
        end
    end,
    getSpellActionSlot = function(self, spellId)
        return self.spell[spellId]
    end,
    getMacroActionSlot = function(self, macroName)
        return self.macro[macroName]
    end,
    getItemActionSlot = function(self, itemId)
        return self.item[itemId]
    end,
    getBindings = function(self, slot)
        return self.keybind[slot]
    end,
    getFrame = function(self, slot)
        local name
        if _G["Bartender4"] then
            name = "BT4Button" .. slot
        else
            if slot <= 24 or slot > 72 then
                name = "ActionButton" .. (((slot - 1) % 12) + 1)
            else
                local slotIndex = slot - 1
                local actionBar = (slotIndex - (slotIndex % 12)) / 12
                name = actionBars[actionBar] .. ((slotIndex % 12) + 1)
            end
        end
        return _G[name]
    end,
    debugActions = function(self)
        wipe(self.output)
        local array = {}
        for k, v in pairs(self.spell) do
            insert(array, tostring(self:getKeyBinding(v)) .. ": " .. tostring(k) .. " " .. tostring(self.ovaleSpellBook:getSpellName(k)))
        end
        sort(array)
        for _, v in ipairs(array) do
            self.output[#self.output + 1] = v
        end
        local total = 0
        for _ in pairs(self.spell) do
            total = total + 1
        end
        self.output[#self.output + 1] = "Total spells: " .. total
        return concat(self.output, "\n")
    end,
})

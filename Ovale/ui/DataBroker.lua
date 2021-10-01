local __exports = LibStub:NewLibrary("ovale/ui/DataBroker", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__Localization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__Localization.l
__imports.LibDataBroker = LibStub:GetLibrary("LibDataBroker-1.1", true)
__imports.LibDBIcon = LibStub:GetLibrary("LibDBIcon-1.0", true)
__imports.__enginescripts = LibStub:GetLibrary("ovale/engine/scripts")
__imports.defaultScriptName = __imports.__enginescripts.defaultScriptName
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local l = __imports.l
local LibDataBroker = __imports.LibDataBroker
local LibDBIcon = __imports.LibDBIcon
local defaultScriptName = __imports.defaultScriptName
local aceEvent = __imports.aceEvent
local pairs = pairs
local kpairs = pairs
local insert = table.insert
local CreateFrame = CreateFrame
local EasyMenu = EasyMenu
local IsShiftKeyDown = IsShiftKeyDown
local UIParent = UIParent
local classIcons = {
    ["DEATHKNIGHT"] = "Interface\\Icons\\ClassIcon_DeathKnight",
    ["DEMONHUNTER"] = "Interface\\Icons\\ClassIcon_DemonHunter",
    ["DRUID"] = "Interface\\Icons\\ClassIcon_Druid",
    ["HUNTER"] = "Interface\\Icons\\ClassIcon_Hunter",
    ["MAGE"] = "Interface\\Icons\\ClassIcon_Mage",
    ["MONK"] = "Interface\\Icons\\ClassIcon_Monk",
    ["PALADIN"] = "Interface\\Icons\\ClassIcon_Paladin",
    ["PRIEST"] = "Interface\\Icons\\ClassIcon_Priest",
    ["ROGUE"] = "Interface\\Icons\\ClassIcon_Rogue",
    ["SHAMAN"] = "Interface\\Icons\\ClassIcon_Shaman",
    ["WARLOCK"] = "Interface\\Icons\\ClassIcon_Warlock",
    ["WARRIOR"] = "Interface\\Icons\\ClassIcon_Warrior"
}
local defaultDB = {
    minimap = {
        hide = false
    }
}
__exports.OvaleDataBrokerClass = __class(nil, {
    constructor = function(self, ovalePaperDoll, ovaleFrameModule, ovaleOptions, ovale, ovaleDebug, ovaleScripts)
        self.ovalePaperDoll = ovalePaperDoll
        self.ovaleFrameModule = ovaleFrameModule
        self.ovaleOptions = ovaleOptions
        self.ovale = ovale
        self.ovaleDebug = ovaleDebug
        self.ovaleScripts = ovaleScripts
        self.broker = {
            text = ""
        }
        self.handleTooltipShow = function(tooltip)
            self.tooltipTitle = self.tooltipTitle or self.ovale:GetName() .. " " .. "90108"
            tooltip:SetText(self.tooltipTitle, 1, 1, 1)
            tooltip:AddLine(l["script_tooltip"])
            tooltip:AddLine(l["middle_click_help"])
            tooltip:AddLine(l["right_click_help"])
            tooltip:AddLine(l["shift_right_click_help"])
        end
        self.handleClick = function(fr, button)
            if button == "LeftButton" then
                local menu = {
                    [1] = {
                        text = l["script"],
                        isTitle = true
                    }
                }
                local scriptType = ( not self.ovaleOptions.db.profile.showHiddenScripts and "script") or nil
                local descriptions = self.ovaleScripts:getDescriptions(scriptType)
                for name, description in pairs(descriptions) do
                    local menuItem = {
                        text = description,
                        func = function()
                            self.ovaleScripts:setScript(name)
                        end
                    }
                    insert(menu, menuItem)
                end
                self.menuFrame = self.menuFrame or CreateFrame("Frame", "OvaleDataBroker_MenuFrame", UIParent, "UIDropDownMenuTemplate")
                EasyMenu(menu, self.menuFrame, "cursor", 0, 0, "MENU")
            elseif button == "MiddleButton" then
                self.ovaleFrameModule.frame:toggleOptions()
            elseif button == "RightButton" then
                if IsShiftKeyDown() then
                    self.ovaleDebug:doTrace(true)
                else
                    self.ovaleOptions:toggleConfig()
                end
            end
        end
        self.handleInitialize = function()
            if LibDataBroker then
                local broker = {
                    type = "data source",
                    text = "",
                    icon = classIcons[self.ovale.playerClass],
                    OnClick = self.handleClick,
                    OnTooltipShow = self.handleTooltipShow
                }
                self.broker = LibDataBroker:NewDataObject(self.ovale:GetName(), broker)
                if LibDBIcon then
                    LibDBIcon:Register(self.ovale:GetName(), self.broker, self.ovaleOptions.db.profile.apparence.minimap)
                end
            end
            if self.broker then
                self.module:RegisterMessage("Ovale_ProfileChanged", self.updateIcon)
                self.module:RegisterMessage("Ovale_ScriptChanged", self.handleScriptChanged)
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.handleScriptChanged)
                self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleScriptChanged)
                self.handleScriptChanged()
                self.updateIcon()
            end
        end
        self.handleDisable = function()
            if self.broker then
                self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.module:UnregisterMessage("Ovale_ProfileChanged")
                self.module:UnregisterMessage("Ovale_ScriptChanged")
            end
        end
        self.updateIcon = function()
            if LibDBIcon and self.broker then
                local minimap = self.ovaleOptions.db.profile.apparence.minimap
                LibDBIcon:Refresh(self.ovale:GetName(), minimap)
                if minimap and minimap.hide then
                    LibDBIcon:Hide(self.ovale:GetName())
                else
                    LibDBIcon:Show(self.ovale:GetName())
                end
            end
        end
        self.handleScriptChanged = function()
            local script = self.ovaleOptions.db.profile.source[self.ovale.playerClass .. "_" .. self.ovalePaperDoll:getSpecialization()]
            self.broker.text = (script == defaultScriptName and self.ovaleScripts:getDefaultScriptName(self.ovale.playerClass, self.ovalePaperDoll:getSpecialization())) or script or "Disabled"
        end
        self.module = ovale:createModule("OvaleDataBroker", self.handleInitialize, self.handleDisable, aceEvent)
        local options = {
            minimap = {
                order = 25,
                type = "toggle",
                name = l["show_minimap_icon"],
                get = function()
                    return  not self.ovaleOptions.db.profile.apparence.minimap.hide
                end,
                set = function(info, value)
                    self.ovaleOptions.db.profile.apparence.minimap.hide =  not value
                    self.updateIcon()
                end
            }
        }
        for k, v in kpairs(defaultDB) do
            self.ovaleOptions.defaultDB.profile.apparence[k] = v
        end
        for k, v in pairs(options) do
            self.ovaleOptions.apparence.args[k] = v
        end
        self.ovaleOptions:registerOptions()
    end,
})

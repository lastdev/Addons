local __exports = LibStub:NewLibrary("ovale/engine/scripts", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local AceConfig = LibStub:GetLibrary("AceConfig-3.0", true)
local AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0", true)
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local format = string.format
local gsub = string.gsub
local lower = string.lower
local pairs = pairs
local kpairs = pairs
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isLuaArray = __toolstools.isLuaArray
local GetNumSpecializations = GetNumSpecializations
__exports.defaultScriptName = "Ovale"
local defaultScriptDescription = l["default_script"]
local customScriptName = "custom"
local customScriptDescription = l["custom_script"]
local disabledScriptName = "Disabled"
local disabledScriptDescription = l["disabled"]
__exports.OvaleScriptsClass = __class(nil, {
    constructor = function(self, ovale, ovaleOptions, ovalePaperDoll, ovaleDebug)
        self.ovale = ovale
        self.ovaleOptions = ovaleOptions
        self.ovalePaperDoll = ovalePaperDoll
        self.script = {}
        self.handleInitialize = function()
            self:createOptions()
            self:registerScript(nil, nil, __exports.defaultScriptName, defaultScriptDescription, nil, "script")
            self:registerScript(self.ovale.playerClass, nil, customScriptName, customScriptDescription, self.ovaleOptions.db.profile.code, "script")
            self:registerScript(nil, nil, disabledScriptName, disabledScriptDescription, nil, "script")
            self.module:RegisterMessage("Ovale_ScriptChanged", self.initScriptProfiles)
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_ScriptChanged")
        end
        self.initScriptProfiles = function()
            local countSpecializations = GetNumSpecializations(false, false)
            if  not isLuaArray(self.ovaleOptions.db.profile.source) then
                self.ovaleOptions.db.profile.source = {}
            end
            for i = 1, countSpecializations, 1 do
                local specName = self.ovalePaperDoll:getSpecialization(i)
                if specName then
                    self.ovaleOptions.db.profile.source[self.ovale.playerClass .. "_" .. specName] = self.ovaleOptions.db.profile.source[self.ovale.playerClass .. "_" .. specName] or self:getDefaultScriptName(self.ovale.playerClass, specName)
                end
            end
        end
        self.module = ovale:createModule("OvaleScripts", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        local defaultDB = {
            code = "",
            source = {},
            showHiddenScripts = false
        }
        local actions = {
            code = {
                name = l["code"],
                type = "execute",
                func = function()
                    local appName = self.module:GetName()
                    AceConfigDialog:SetDefaultSize(appName, 700, 550)
                    AceConfigDialog:Open(appName)
                end
            }
        }
        for k, v in kpairs(defaultDB) do
            (ovaleOptions.defaultDB.profile)[k] = v
        end
        for k, v in pairs(actions) do
            ovaleOptions.actions.args[k] = v
        end
        ovaleOptions:registerOptions()
    end,
    getDescriptions = function(self, scriptType)
        local descriptionsTable = {}
        for name, script in pairs(self.script) do
            if ( not scriptType or script.type == scriptType) and ( not script.className or script.className == self.ovale.playerClass) and ( not script.specialization or self.ovalePaperDoll:isSpecialization(script.specialization)) then
                if name == __exports.defaultScriptName then
                    descriptionsTable[name] = script.desc .. " (" .. self:getScriptName(name) .. ")"
                else
                    descriptionsTable[name] = script.desc or "No description"
                end
            end
        end
        return descriptionsTable
    end,
    registerScript = function(self, className, specialization, name, description, code, scriptType)
        self.script[name] = self.script[name] or {}
        local script = self.script[name]
        script.type = scriptType or "script"
        script.desc = description or name
        script.specialization = specialization
        script.code = code or ""
        script.className = className
    end,
    unregisterScript = function(self, name)
        self.script[name] = nil
    end,
    setScript = function(self, name)
        local oldSource = self:getCurrentSpecScriptName()
        if oldSource ~= name then
            self:setCurrentSpecScript(name)
            self.module:SendMessage("Ovale_ScriptChanged")
        end
    end,
    getDefaultScriptName = function(self, className, specialization)
        local name = nil
        local scClassName = lower(className)
        if className == "DEMONHUNTER" then
            scClassName = "demon_hunter"
        elseif className == "DEATHKNIGHT" then
            scClassName = "death_knight"
        end
        if specialization then
            name = format("sc_t26_%s_%s", scClassName, specialization)
            if  not self.script[name] then
                self.tracer:log("Script " .. name .. " not found")
                name = disabledScriptName
            end
        else
            return disabledScriptName
        end
        return name
    end,
    getScriptName = function(self, name)
        return ((name == __exports.defaultScriptName and self:getDefaultScriptName(self.ovale.playerClass, self.ovalePaperDoll:getSpecialization())) or name)
    end,
    getScript = function(self, name)
        name = self:getScriptName(name)
        if name and self.script[name] then
            return self.script[name].code
        end
        return nil
    end,
    getScriptOrDefault = function(self, name)
        return (self:getScript(name) or self:getScript(self:getDefaultScriptName(self.ovale.playerClass, self.ovalePaperDoll:getSpecialization())))
    end,
    getCurrentSpecScriptId = function(self)
        return self.ovale.playerClass .. "_" .. self.ovalePaperDoll:getSpecialization()
    end,
    getCurrentSpecScriptName = function(self)
        return self.ovaleOptions.db.profile.source[self:getCurrentSpecScriptId()]
    end,
    setCurrentSpecScript = function(self, scriptName)
        self.ovaleOptions.db.profile.source[self:getCurrentSpecScriptId()] = scriptName
    end,
    createOptions = function(self)
        local options = {
            name = self.ovale:GetName() .. " " .. l["script"],
            type = "group",
            args = {
                source = {
                    order = 10,
                    type = "select",
                    name = l["script"],
                    width = "double",
                    values = function(info)
                        local scriptType = ( not self.ovaleOptions.db.profile.showHiddenScripts and "script") or nil
                        return self:getDescriptions(scriptType)
                    end,
                    get = function(info)
                        return self:getCurrentSpecScriptName()
                    end,
                    set = function(info, v)
                        self:setScript(v)
                    end
                },
                script = {
                    order = 20,
                    type = "input",
                    multiline = 25,
                    name = l["script"],
                    width = "full",
                    disabled = function()
                        return (self:getCurrentSpecScriptName() ~= customScriptName)
                    end,
                    get = function(info)
                        local code = self:getScript(self:getCurrentSpecScriptName()) or ""
                        return gsub(code, "	", "    ")
                    end,
                    set = function(info, v)
                        self:registerScript(self.ovale.playerClass, nil, customScriptName, customScriptDescription, v, "script")
                        self.ovaleOptions.db.profile.code = v
                        self.module:SendMessage("Ovale_ScriptChanged")
                    end
                },
                copy = {
                    order = 30,
                    type = "execute",
                    name = l["copy_to_custom_script"],
                    disabled = function()
                        return (self:getCurrentSpecScriptName() == customScriptName)
                    end,
                    confirm = function()
                        return l["overwrite_existing_script"]
                    end,
                    func = function()
                        local code = self:getScript(self:getCurrentSpecScriptName())
                        self:registerScript(self.ovale.playerClass, nil, customScriptName, customScriptDescription, code, "script")
                        self:setCurrentSpecScript(customScriptName)
                        local script = self:getScript(customScriptName)
                        if script then
                            self.ovaleOptions.db.profile.code = script
                        end
                        self.module:SendMessage("Ovale_ScriptChanged")
                    end
                },
                showHiddenScripts = {
                    order = 40,
                    type = "toggle",
                    name = l["show_hidden"],
                    get = function(info)
                        return self.ovaleOptions.db.profile.showHiddenScripts
                    end,
                    set = function(info, value)
                        self.ovaleOptions.db.profile.showHiddenScripts = value
                    end
                }
            }
        }
        local appName = self.module:GetName()
        AceConfig:RegisterOptionsTable(appName, options)
        AceConfigDialog:AddToBlizOptions(appName, l["script"], self.ovale:GetName())
    end,
})

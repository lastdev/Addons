local __exports = LibStub:NewLibrary("ovale/engine/debug", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.AceConfig = LibStub:GetLibrary("AceConfig-3.0", true)
__imports.AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0", true)
__imports.__uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__uiLocalization.l
__imports.LibTextDump = LibStub:GetLibrary("LibTextDump-1.0", true)
__imports.aceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.makeString = __imports.__toolstools.makeString
local AceConfig = __imports.AceConfig
local AceConfigDialog = __imports.AceConfigDialog
local l = __imports.l
local LibTextDump = __imports.LibTextDump
local aceTimer = __imports.aceTimer
local format = string.format
local pairs = pairs
local GetTime = GetTime
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local makeString = __imports.makeString
local traceLogMaxLines = 4096
__exports.Tracer = __class(nil, {
    constructor = function(self, options, debugTools, name)
        self.options = options
        self.debugTools = debugTools
        self.name = name
        local toggles = debugTools.defaultOptions.args.toggles
        toggles.args[name] = {
            name = name,
            desc = format(l["enable_debug_messages"], name),
            type = "toggle"
        }
    end,
    isDebugging = function(self)
        return (self.options.db.global.debug[self.name] and true) or false
    end,
    debug = function(self, pattern, ...)
        local name = self.name
        if self:isDebugging() then
            DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99%s|r: %s", name, makeString(pattern, ...)))
        end
    end,
    debugTimestamp = function(self, pattern, ...)
        local name = self.name
        if self:isDebugging() then
            local now = GetTime()
            local s = format("|cffffff00%f|r %s", now, makeString(pattern, ...))
            DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99%s|r: %s", name, s))
        end
    end,
    log = function(self, pattern, ...)
        if self.debugTools.trace then
            local numberOfLines = self.debugTools.traceLog:Lines()
            if numberOfLines < traceLogMaxLines - 1 then
                self.debugTools.traceLog:AddLine(makeString(pattern, ...))
            elseif numberOfLines == traceLogMaxLines - 1 then
                self.debugTools.traceLog:AddLine("WARNING: Maximum length of trace log has been reached.")
            end
        end
    end,
    error = function(self, pattern, ...)
        local name = self.name
        local s = makeString(pattern, ...)
        DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99%s|r:|cffff3333 Error:|r %s", name, s))
        self.debugTools.bug = s
    end,
    warning = function(self, pattern, ...)
        local name = self.name
        local s = makeString(pattern, ...)
        DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99%s|r: |cff999933Warning:|r %s", name, s))
        self.debugTools.warning = s
    end,
    print = function(self, pattern, ...)
        local name = self.name
        local s = makeString(pattern, ...)
        DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99%s|r: %s", name, s))
    end,
})
__exports.DebugTools = __class(nil, {
    constructor = function(self, ovale, options)
        self.ovale = ovale
        self.options = options
        self.traced = false
        self.defaultOptions = {
            name = "Ovale " .. l["debug"],
            type = "group",
            args = {
                toggles = {
                    name = l["options"],
                    type = "group",
                    order = 10,
                    args = {},
                    get = function(info)
                        local value = self.options.db.global.debug[info[#info]]
                        return value ~= nil
                    end,
                    set = function(info, value)
                        if  not value then
                            self.options.db.global.debug[info[#info]] = nil
                        else
                            self.options.db.global.debug[info[#info]] = value
                        end
                    end
                },
                trace = {
                    name = l["trace"],
                    type = "group",
                    order = 20,
                    args = {
                        trace = {
                            order = 10,
                            type = "execute",
                            name = l["trace"],
                            desc = l["trace_next_frame"],
                            func = function()
                                self:doTrace(true)
                            end
                        },
                        traceLog = {
                            order = 20,
                            type = "execute",
                            name = l["show_trace_log"],
                            func = function()
                                self:displayTraceLog()
                            end
                        }
                    }
                }
            }
        }
        self.trace = false
        self.onInitialize = function()
            local appName = self.module:GetName()
            AceConfig:RegisterOptionsTable(appName, self.defaultOptions)
            AceConfigDialog:AddToBlizOptions(appName, l["debug"], self.ovale:GetName())
        end
        self.onDisable = function()
        end
        self.module = ovale:createModule("OvaleDebug", self.onInitialize, self.onDisable, aceTimer)
        self.traceLog = LibTextDump:New(self.ovale:GetName() .. " - " .. l["trace_log"], 750, 500)
        local actions = {
            debug = {
                name = l["debug"],
                type = "execute",
                func = function()
                    local appName = self.module:GetName()
                    AceConfigDialog:SetDefaultSize(appName, 800, 550)
                    AceConfigDialog:Open(appName)
                end
            }
        }
        for k, v in pairs(actions) do
            options.actions.args[k] = v
        end
        options.defaultDB.global = options.defaultDB.global or {}
        options.defaultDB.global.debug = {}
        options:registerOptions()
    end,
    create = function(self, name)
        return __exports.Tracer(self.options, self, name)
    end,
    doTrace = function(self, displayLog)
        self.traceLog:Clear()
        self.trace = true
        DEFAULT_CHAT_FRAME:AddMessage(format("=== Trace @%f", GetTime()))
        if displayLog then
            self.module:ScheduleTimer(function()
                self:displayTraceLog()
            end, 0.5)
        end
    end,
    resetTrace = function(self)
        self.bug = nil
        self.trace = false
        self.traced = false
    end,
    updateTrace = function(self)
        if self.trace then
            self.traced = true
        end
        if self.bug then
            self.trace = true
        end
        if self.trace and self.traced then
            self.traced = false
            self.trace = false
        end
    end,
    displayTraceLog = function(self)
        if self.traceLog:Lines() == 0 then
            self.traceLog:AddLine("Trace log is empty.")
        end
        self.traceLog:Display()
    end,
})

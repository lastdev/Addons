local __exports = LibStub:NewLibrary("ovale/engine/profiler", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local AceConfig = LibStub:GetLibrary("AceConfig-3.0", true)
local AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0", true)
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local LibTextDump = LibStub:GetLibrary("LibTextDump-1.0", true)
local debugprofilestop = debugprofilestop
local GetTime = GetTime
local format = string.format
local pairs = pairs
local next = next
local wipe = wipe
local insert = table.insert
local sort = table.sort
local concat = table.concat
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local printFormat = __toolstools.printFormat
__exports.Profiler = __class(nil, {
    constructor = function(self, name, profiler)
        self.profiler = profiler
        self.timestamp = debugprofilestop()
        self.enabled = false
        local args = profiler.moduleOptions
        args[name] = {
            name = name,
            desc = format(l["enable_profiling"], name),
            type = "toggle"
        }
        profiler.profiles[name] = self
    end,
    startProfiling = function(self, tag)
        if  not self.enabled then
            return 
        end
        local newTimestamp = debugprofilestop()
        if self.profiler.stackSize > 0 then
            local delta = newTimestamp - self.timestamp
            local previous = self.profiler.stack[self.profiler.stackSize]
            local timeSpent = self.profiler.timeSpent[previous] or 0
            timeSpent = timeSpent + delta
            self.profiler.timeSpent[previous] = timeSpent
        end
        self.timestamp = newTimestamp
        self.profiler.stackSize = self.profiler.stackSize + 1
        self.profiler.stack[self.profiler.stackSize] = tag
        do
            local timesInvoked = self.profiler.timesInvoked[tag] or 0
            timesInvoked = timesInvoked + 1
            self.profiler.timesInvoked[tag] = timesInvoked
        end
    end,
    stopProfiling = function(self, tag)
        if  not self.enabled then
            return 
        end
        if self.profiler.stackSize > 0 then
            local currentTag = self.profiler.stack[self.profiler.stackSize]
            if currentTag == tag then
                local newTimestamp = debugprofilestop()
                local delta = newTimestamp - self.timestamp
                local timeSpent = self.profiler.timeSpent[currentTag] or 0
                timeSpent = timeSpent + delta
                self.profiler.timeSpent[currentTag] = timeSpent
                self.timestamp = newTimestamp
                self.profiler.stackSize = self.profiler.stackSize - 1
            end
        end
    end,
})
__exports.OvaleProfilerClass = __class(nil, {
    constructor = function(self, ovaleOptions, ovale)
        self.ovaleOptions = ovaleOptions
        self.ovale = ovale
        self.timeSpent = {}
        self.timesInvoked = {}
        self.stack = {}
        self.stackSize = 0
        self.profiles = {}
        self.actions = {
            profiling = {
                name = l["profiling"],
                type = "execute",
                func = function()
                    local appName = self.ovale:GetName()
                    AceConfigDialog:SetDefaultSize(appName, 800, 550)
                    AceConfigDialog:Open(appName)
                end
            }
        }
        self.moduleOptions = {}
        self.options = {
            name = self.ovale:GetName() .. " " .. l["profiling"],
            type = "group",
            args = {
                profiling = {
                    name = l["profiling"],
                    type = "group",
                    args = {
                        modules = {
                            name = l["modules"],
                            type = "group",
                            inline = true,
                            order = 10,
                            args = self.moduleOptions,
                            get = function(info)
                                local name = info[#info]
                                local value = self.ovaleOptions.db.global.profiler[name]
                                return value ~= nil
                            end,
                            set = function(info, value)
                                local name = info[#info]
                                self.ovaleOptions.db.global.profiler[name] = value
                                if value then
                                    self:enableProfiling(name)
                                else
                                    self:disableProfiling(name)
                                end
                            end
                        },
                        reset = {
                            name = l["reset"],
                            desc = l["reset_profiling"],
                            type = "execute",
                            order = 20,
                            func = function()
                                self:resetProfiling()
                            end
                        },
                        show = {
                            name = l["show"],
                            desc = l["show_profiling_statistics"],
                            type = "execute",
                            order = 30,
                            func = function()
                                self.profilingOutput:Clear()
                                local s = self:getProfilingInfo()
                                if s then
                                    self.profilingOutput:AddLine(s)
                                    self.profilingOutput:Display()
                                end
                            end
                        }
                    }
                }
            }
        }
        self.handleInitialize = function()
            local appName = self.module:GetName()
            AceConfig:RegisterOptionsTable(appName, self.options)
            AceConfigDialog:AddToBlizOptions(appName, l["profiling"], self.ovale:GetName())
        end
        self.handleDisable = function()
            self.profilingOutput:Clear()
        end
        self.array = {}
        for k, v in pairs(self.actions) do
            ovaleOptions.actions.args[k] = v
        end
        ovaleOptions.defaultDB.global = ovaleOptions.defaultDB.global or {}
        ovaleOptions.defaultDB.global.profiler = {}
        ovaleOptions:registerOptions()
        self.module = ovale:createModule("OvaleProfiler", self.handleInitialize, self.handleDisable)
        self.profilingOutput = LibTextDump:New(self.ovale:GetName() .. " - " .. l["profiling"], 750, 500)
    end,
    create = function(self, name)
        return __exports.Profiler(name, self)
    end,
    resetProfiling = function(self)
        for tag in pairs(self.timeSpent) do
            self.timeSpent[tag] = nil
        end
        for tag in pairs(self.timesInvoked) do
            self.timesInvoked[tag] = nil
        end
    end,
    getProfilingInfo = function(self)
        if next(self.timeSpent) then
            local width = 1
            do
                local tenPower = 10
                for _, timesInvoked in pairs(self.timesInvoked) do
                    while timesInvoked > tenPower do
                        width = width + 1
                        tenPower = tenPower * 10
                    end
                end
            end
            wipe(self.array)
            local formatString = format("    %%08.3fms: %%0%dd (%%05f) x %%s", width)
            for tag, timeSpent in pairs(self.timeSpent) do
                local timesInvoked = self.timesInvoked[tag]
                insert(self.array, format(formatString, timeSpent, timesInvoked, timeSpent / timesInvoked, tag))
            end
            if next(self.array) then
                sort(self.array)
                local now = GetTime()
                insert(self.array, 1, format("Profiling statistics at %f:", now))
                return concat(self.array, "\n")
            end
        end
    end,
    debuggingInfo = function(self)
        printFormat("Profiler stack size = %d", self.stackSize)
        local index = self.stackSize
        while index > 0 and self.stackSize - index < 10 do
            local tag = self.stack[index]
            printFormat("    [%d] %s", index, tag)
            index = index - 1
        end
    end,
    enableProfiling = function(self, name)
        self.profiles[name].enabled = true
    end,
    disableProfiling = function(self, name)
        self.profiles[name].enabled = false
    end,
})

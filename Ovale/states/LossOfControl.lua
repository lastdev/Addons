local __exports = LibStub:NewLibrary("ovale/states/LossOfControl", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local aceEvent = __imports.aceEvent
local C_LossOfControl = C_LossOfControl
local GetTime = GetTime
local GetSpellInfo = GetSpellInfo
local pairs = pairs
local concat = table.concat
local insert = table.insert
local upper = string.upper
local huge = math.huge
__exports.OvaleLossOfControlClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug)
        self.lossOfControlHistory = {}
        self.handleInitialize = function()
            self.tracer:debug("Enabled LossOfControl module")
            self.module:RegisterEvent("LOSS_OF_CONTROL_ADDED", self.handleLossOfControlAdded)
        end
        self.handleDisable = function()
            self.tracer:debug("Disabled LossOfControl module")
            self.lossOfControlHistory = {}
            self.module:UnregisterEvent("LOSS_OF_CONTROL_ADDED")
        end
        self.handleLossOfControlAdded = function(e, eventIndex)
            local lossOfControlData = C_LossOfControl.GetActiveLossOfControlData(eventIndex)
            if lossOfControlData then
                self.tracer:debug("event", e, "eventIndex", eventIndex, "locType", lossOfControlData.locType or "undefined", "spellID", lossOfControlData.spellID or "undefined", "spellName", GetSpellInfo(lossOfControlData.spellID), "startTime", lossOfControlData.startTime or "undefined", "duration", lossOfControlData.duration or "undefined")
                local data = {
                    locType = upper(lossOfControlData.locType),
                    spellID = lossOfControlData.spellID,
                    startTime = lossOfControlData.startTime or GetTime(),
                    duration = lossOfControlData.duration or 10
                }
                insert(self.lossOfControlHistory, data)
            end
        end
        self.hasLossOfControl = function(locType, atTime)
            local lowestStartTime = huge
            local highestEndTime = 0
            for _, data in pairs(self.lossOfControlHistory) do
                if upper(locType) == upper(data.locType) and data.startTime <= atTime and atTime <= data.startTime + data.duration then
                    if lowestStartTime > data.startTime then
                        lowestStartTime = data.startTime
                    end
                    if highestEndTime < data.startTime + data.duration then
                        highestEndTime = data.startTime + data.duration
                    end
                end
            end
            return lowestStartTime < huge and highestEndTime > 0
        end
        self.debugOptions = {
            type = "group",
            name = "Loss of Control History",
            args = {
                locHistory = {
                    type = "input",
                    name = "Loss of Control History",
                    multiline = 25,
                    width = "full",
                    get = function()
                        local output = {}
                        for _, data in pairs(self.lossOfControlHistory) do
                            local spellName = GetSpellInfo(data.spellID)
                            insert(output, spellName .. " - " .. data.spellID .. " - " .. data.locType .. " - " .. data.startTime .. " - " .. data.duration)
                        end
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.module = ovale:createModule("OvaleLossOfControl", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        ovaleDebug.defaultOptions.args["locHistory"] = self.debugOptions
    end,
    cleanState = function(self)
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
    end,
})

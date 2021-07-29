local __exports = LibStub:NewLibrary("ovale/ui/Version", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __Localization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __Localization.l
local __Ovale = LibStub:GetLibrary("ovale/Ovale")
local messagePrefix = __Ovale.messagePrefix
local aceComm = LibStub:GetLibrary("AceComm-3.0", true)
local aceSerializer = LibStub:GetLibrary("AceSerializer-3.0", true)
local aceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
local format = string.format
local ipairs = ipairs
local next = next
local pairs = pairs
local wipe = wipe
local insert = table.insert
local sort = table.sort
local IsInGroup = IsInGroup
local IsInGuild = IsInGuild
local IsInRaid = IsInRaid
local LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE
local printTable = {}
local userVersions = {}
local timer
__exports.OvaleVersionClass = __class(nil, {
    constructor = function(self, ovale, ovaleOptions, ovaleDebug)
        self.warned = false
        self.handleInitialize = function()
            self.module:RegisterComm(messagePrefix, self.handleCommReceived)
        end
        self.handleDisable = function()
        end
        self.handleCommReceived = function(prefix, message, channel, sender)
            if prefix == messagePrefix then
                local ok, msgType, senderVersion = self.module:Deserialize(message)
                if ok then
                    self.tracer:debug(msgType, senderVersion, channel, sender)
                    if msgType == "V" then
                        local msg = self.module:Serialize("VR", "90103")
                        self.module:SendCommMessage(messagePrefix, msg, channel)
                    elseif msgType == "VR" then
                        userVersions[sender] = senderVersion
                    end
                end
            end
        end
        self.printVersionCheck = function()
            if next(userVersions) then
                wipe(printTable)
                for sender, userVersion in pairs(userVersions) do
                    insert(printTable, format(">>> %s is using Ovale %s", sender, userVersion))
                end
                sort(printTable)
                for _, v in ipairs(printTable) do
                    self.tracer:print(v)
                end
            else
                self.tracer:print(">>> No other Ovale users present.")
            end
            timer = nil
        end
        self.module = ovale:createModule("OvaleVersion", self.handleInitialize, self.handleDisable, aceComm, aceSerializer, aceTimer)
        self.tracer = ovaleDebug:create(self.module:GetName())
        local actions = {
            ping = {
                name = l["ping_users"],
                type = "execute",
                func = function()
                    self:versionCheck()
                end
            },
            version = {
                name = l["show_version_number"],
                type = "execute",
                func = function()
                    self.tracer:print("90103")
                end
            }
        }
        for k, v in pairs(actions) do
            ovaleOptions.actions.args[k] = v
        end
        ovaleOptions:registerOptions()
    end,
    versionCheck = function(self)
        if  not timer then
            wipe(userVersions)
            local message = self.module:Serialize("V", "90103")
            local channel
            if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                channel = "INSTANCE_CHAT"
            elseif IsInRaid() then
                channel = "RAID"
            elseif IsInGroup() then
                channel = "PARTY"
            elseif IsInGuild() then
                channel = "GUILD"
            end
            if channel then
                self.module:SendCommMessage(messagePrefix, message, channel)
            end
            timer = self.module:ScheduleTimer(self.printVersionCheck, 3)
        end
    end,
})

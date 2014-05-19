local addonName, addon = ...
addon.L = addon.L or {} --TODO localization 
local L = setmetatable(addon.L, {__index = function(t,i) return i end} )

local klaxxi = {
    ["1"] = L["Skeer the Bloodseeker"],
    ["2"] = L["Rik'kal the Dissector"],
    ["3"] = L["Hisek the Swarmkeeper"],
    ["4"] = L["Ka'roz the Locust"],
    ["5"] = L["Korven the Prime"],
    ["6"] = L["Iyyokuk the Lucid"],
    ["7"] = L["Xaril the Poisoned Mind"],
    ["8"] = L["Kaz'tik the Manipulator"],
    ["9"] = L["Kil'ruk the Wind-Reaver"],
}

local K  = {
    [L["Skeer the Bloodseeker"]] = "1",
    [L["Rik'kal the Dissector"]] = "2",
    [L["Hisek the Swarmkeeper"]] = "3",
    [L["Ka'roz the Locust"]] = "4",
    [L["Korven the Prime"]] = "5",
    [L["Iyyokuk the Lucid"]] = "6",
    [L["Xaril the Poisoned Mind"]] = "7",
    [L["Kaz'tik the Manipulator"]] = "8",
    [L["Kil'ruk the Wind-Reaver"]] = "9",
}

local defaults = {
    global = {
        ["enabled"] = true,
        ["announces"] = {
            yell = true,
            raid = false,
            raidWarning = true,
            privateRaidWarning = false,
            privateChatMessage = false,
        },
        ["klaxxi"] = {
            ["1"] = K[L["Skeer the Bloodseeker"]],
            ["2"] = K[L["Rik'kal the Dissector"]],
            ["4"] = K[L["Hisek the Swarmkeeper"]],
            ["7"] = K[L["Ka'roz the Locust"]],
            ["3"] = K[L["Korven the Prime"]],
            ["8"] = K[L["Iyyokuk the Lucid"]],
            ["5"] = K[L["Xaril the Poisoned Mind"]],
            ["6"] = K[L["Kaz'tik the Manipulator"]],
            ["9"] = K[L["Kil'ruk the Wind-Reaver"]],
        },
        ["messages"] = {
            ["1"] = "1) Skeer: bloods, adds, snipper",
            ["2"] = "2) Rik'kai: adds, snipper, amber/flash",
            ["3"] = "3) Korven: amber 50%, snipper, amber/flash",
            ["4"] = "4) Hisek: snipper, amber/flash, fire lines",
            ["5"] = "5) Xaril: toxins, amber/flash, fire lines",
            ["6"] = "6) Kaz'tik: shield adds, amber/flash, fire lines",
            ["7"] = "7) Ka'roz: amber/flash, fire lines, death from above",
            ["8"] = "8) Iyyokuk: fire lines, death from above",
            ["9"] = "9) Kil'ruk: death from above"
        },
    },
}

function addon:IsKlaxxi(name)
    return K[name] ~= nil
end

function addon:GetKlaxxi(i)
    return klaxxi[self.db.global.klaxxi[tostring(i)]]
end

function setprio(info, value)    
    addon.db.global.klaxxi[info[#info]] = value
end

function getprio(info)
    return addon.db.global.klaxxi[info[#info]]    
end

local optionsTable = {
    name = addonName,
    handler = addon,
    type = 'group',
    args = {
        enable = {
            name = L["Enable"],
            type = 'toggle',
            order = 1,
            set = function(_, enabled)
                addon.db.global.enabled = enabled
                if enabled then
                    addon:Enable()
                else
                    addon:Disable()
                end
            end,
            get = function() return addon.db.global.enabled end,
            desc = L["Enables/Disables this addon"],
        },
        reset = {
            name = L['Restore Defaults'],
            desc = L['Restore all combinations to default.'],
            type = 'execute',
            order = 2,
            func = function()
                addon.db:ResetDB()
            end,
        },
        klaxxi = {
            name = L['Klaxxi priority'],
            desc = L['Order of klaxxis to kill'],
            type = 'group',
            order = 3,
            args = {
                ["1"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['1']
                },
                ["2"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['2']
                },
                ["3"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['3']
                },
                ["4"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['4']
                },
                ["5"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['5']
                },
                ["6"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['6']
                },
                ["7"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['7']
                },
                ["8"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['8']
                },
                ["9"] = {
                    type = 'select', values = klaxxi, set = setprio, get = getprio,
                    name = L['9']
                }
            },
        },
        messages = {
            name = L["Messages"],
            desc = L["Message to show up every time the target changes"],
            type = 'group',
            order = 4,
            args = {
                ["1"] = {
                    type = 'input',
                    name = L['First message (show on pull)'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["1"] = v end,
                    get = function() return addon.db.global.messages["1"] end,
                    order = 1,
                },
                ["2"] = {
                    type = 'input',
                    name = L['Second message'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["2"] = v end,
                    get = function() return addon.db.global.messages["2"] end,
                    order = 2,
                },
                ["3"] = {
                    type = 'input',
                    name = L['Third message'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["3"] = v end,
                    get = function() return addon.db.global.messages["3"] end,
                    order = 3,
                },
                ["4"] = {
                    type = 'input',
                    name = L['Fourth message'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["4"] = v end,
                    get = function() return addon.db.global.messages["4"] end,
                    order = 4,
                },
                ["5"] = {
                    type = 'input',
                    name = L['Fifth message'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["5"] = v end,
                    get = function() return addon.db.global.messages["5"] end,
                    order = 5,
                },
                ["6"] = {
                    type = 'input',
                    name = L['Sixth message'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["6"] = v end,
                    get = function() return addon.db.global.messages["6"] end,
                    order = 6,
                },
                ["7"] = {
                    type = 'input',
                    name = L['Seventh message (three klaxxi alive)'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["7"] = v end,
                    get = function() return addon.db.global.messages["7"] end,
                    order = 7,
                },
                ["8"] = {
                    type = 'input',
                    name = L['Eight message (two klaxxi alive)'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["8"] = v end,
                    get = function() return addon.db.global.messages["8"] end,
                    order = 8,
                },
                ["9"] = {
                    type = 'input',
                    name = L['Ninth and last message (only one klaxxi alive)'],
                    multiline = 2,
                    set = function(_, v) addon.db.global.messages["9"] = v end,
                    get = function() return addon.db.global.messages["9"] end,
                    order = 9,
                }
            },
        },
        output = {
            name = L.Output,
            desc = L['Setup where output messages are sent.'],
            type = 'group',
            order = 5,
            args = {
                yell = {
                    name = L.Yell,
                    type = 'toggle',
                    order = 1,
                    set = function(_, enabled)
                        addon.db.global.announces.yell = enabled
                    end,
                    get = function() return addon.db.global.announces.yell end,
                },
                raid = {
                    name = L.Raid,
                    type = 'toggle',
                    order = 2,
                    set = function(_, enabled)
                        addon.db.global.announces.raid = enabled
                    end,
                    get = function() return addon.db.global.announces.raid end,
                },
                raidWarning = {
                    name = L['Raid Warning'],
                    type = 'toggle',
                    order = 3,
                    set = function(_, enabled)
                        addon.db.global.announces.raidWarning = enabled
                    end,
                    get = function() return addon.db.global.announces.raidWarning end,
                },
                privateRaidWarning = {
                    name = L['Private Raid Warning'],
                    type = 'toggle',
                    order = 4,
                    set = function(_, enabled)
                        addon.db.global.announces.privateRaidWarning = enabled
                    end,
                    get = function() return addon.db.global.announces.privateRaidWarning end,
                },
                privateChatMessage = {
                    name = L['Private Chat Message'],
                    type = 'toggle',
                    order = 5,
                    set = function(_, enabled)
                        addon.db.global.announces.privateChatMessage = enabled
                    end,
                    get = function() return addon.db.global.announces.privateChatMessage end,
                },
            },
        },
    },
}

function addon:SetupDB()
    self.db = LibStub("AceDB-3.0"):New("KlaxxiPriorityDB", defaults)
end

function addon:SetupOptions()      
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, optionsTable)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName)
end

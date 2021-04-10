local __exports = LibStub:NewLibrary("ovale/ui/Options", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local AceConfig = LibStub:GetLibrary("AceConfig-3.0", true)
local AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0", true)
local __Localization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __Localization.l
local AceDB = LibStub:GetLibrary("AceDB-3.0", true)
local AceDBOptions = LibStub:GetLibrary("AceDBOptions-3.0", true)
local aceConsole = LibStub:GetLibrary("AceConsole-3.0", true)
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory
local ipairs = ipairs
local huge = math.huge
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local printFormat = __toolstools.printFormat
local optionModules = {}
__exports.OvaleOptionsClass = __class(nil, {
    constructor = function(self, ovale)
        self.ovale = ovale
        self.defaultDB = {
            profile = {
                source = {},
                code = "",
                showHiddenScripts = false,
                overrideCode = nil,
                check = {},
                list = {},
                standaloneOptions = false,
                apparence = {
                    avecCible = false,
                    clickThru = false,
                    enCombat = false,
                    enableIcons = true,
                    hideEmpty = false,
                    hideVehicule = false,
                    margin = 4,
                    offsetX = 0,
                    offsetY = 0,
                    targetHostileOnly = false,
                    verrouille = false,
                    vertical = false,
                    alpha = 1,
                    flashIcon = true,
                    remainsFontColor = {
                        r = 1,
                        g = 1,
                        b = 1
                    },
                    fontScale = 1,
                    highlightIcon = true,
                    iconScale = 1,
                    numeric = false,
                    raccourcis = true,
                    smallIconScale = 0.8,
                    targetText = "●",
                    iconShiftX = 0,
                    iconShiftY = 0,
                    optionsAlpha = 1,
                    secondIconScale = 1,
                    taggedEnemies = false,
                    minFrameRefresh = 50,
                    maxFrameRefresh = 250,
                    fullAuraScan = false,
                    frequentHealthUpdates = true,
                    auraLag = 400,
                    moving = false,
                    spellFlash = {
                        enabled = true,
                        brightness = 1,
                        hasHostileTarget = false,
                        hasTarget = false,
                        hideInVehicle = false,
                        inCombat = false,
                        size = 2.4,
                        threshold = 500,
                        colors = {
                            colorMain = {
                                r = 1,
                                g = 1,
                                b = 1
                            },
                            colorShortCd = {
                                r = 1,
                                g = 1,
                                b = 0
                            },
                            colorCd = {
                                r = 1,
                                g = 1,
                                b = 0
                            },
                            colorInterrupt = {
                                r = 0,
                                g = 1,
                                b = 1
                            }
                        }
                    },
                    minimap = {
                        hide = false
                    }
                }
            },
            global = {
                debug = {},
                profiler = {}
            }
        }
        self.actions = {
            name = "Actions",
            type = "group",
            args = {
                show = {
                    type = "execute",
                    name = l["show_frame"],
                    guiHidden = true,
                    func = function()
                        self.db.profile.apparence.enableIcons = true
                        self.module:SendMessage("Ovale_OptionChanged", "visibility")
                    end
                },
                hide = {
                    type = "execute",
                    name = l["hide_frame"],
                    guiHidden = true,
                    func = function()
                        self.db.profile.apparence.enableIcons = false
                        self.module:SendMessage("Ovale_OptionChanged", "visibility")
                    end
                },
                config = {
                    name = "Configuration",
                    type = "execute",
                    func = function()
                        self:toggleConfig()
                    end
                },
                refresh = {
                    name = l["display_refresh_statistics"],
                    type = "execute",
                    func = function()
                        local avgRefresh, minRefresh, maxRefresh, count = self.ovale:getRefreshIntervalStatistics()
                        if minRefresh == huge then
                            avgRefresh, minRefresh, maxRefresh, count = 0, 0, 0, 0
                        end
                        printFormat("Refresh intervals: count = %d, avg = %d, min = %d, max = %d (ms)", count, avgRefresh, minRefresh, maxRefresh)
                    end
                }
            }
        }
        self.apparence = {
            name = "Ovale Spell Priority",
            type = "group",
            get = function(info)
                return self.db.profile.apparence[info[#info]]
            end,
            set = function(info, value)
                self.db.profile.apparence[info[#info]] = value
                self.module:SendMessage("Ovale_OptionChanged", info[#info - 1])
            end,
            args = {
                standaloneOptions = {
                    order = 30,
                    name = l["standalone_options"],
                    desc = l["movable_configuration_pannel"],
                    type = "toggle",
                    get = function()
                        return self.db.profile.standaloneOptions
                    end,
                    set = function(info, value)
                        self.db.profile.standaloneOptions = value
                    end
                },
                iconGroupAppearance = {
                    order = 40,
                    type = "group",
                    name = l["icon_group"],
                    args = {
                        enableIcons = {
                            order = 10,
                            type = "toggle",
                            name = l["enabled"],
                            width = "full",
                            set = function(info, value)
                                self.db.profile.apparence.enableIcons = value
                                self.module:SendMessage("Ovale_OptionChanged", "visibility")
                            end
                        },
                        verrouille = {
                            order = 10,
                            type = "toggle",
                            name = l["lock_position"],
                            disabled = function()
                                return  not self.db.profile.apparence.enableIcons
                            end
                        },
                        clickThru = {
                            order = 20,
                            type = "toggle",
                            name = l["ignore_mouse_clicks"],
                            disabled = function()
                                return  not self.db.profile.apparence.enableIcons
                            end
                        },
                        visibility = {
                            order = 20,
                            type = "group",
                            name = l["visibility"],
                            inline = true,
                            disabled = function()
                                return  not self.db.profile.apparence.enableIcons
                            end,
                            args = {
                                enCombat = {
                                    order = 10,
                                    type = "toggle",
                                    name = l["combat_only"]
                                },
                                avecCible = {
                                    order = 20,
                                    type = "toggle",
                                    name = l["if_target"]
                                },
                                targetHostileOnly = {
                                    order = 30,
                                    type = "toggle",
                                    name = l["hide_if_dead_or_friendly_target"]
                                },
                                hideVehicule = {
                                    order = 40,
                                    type = "toggle",
                                    name = l["hide_in_vehicles"]
                                },
                                hideEmpty = {
                                    order = 50,
                                    type = "toggle",
                                    name = l["hide_empty_buttons"]
                                }
                            }
                        },
                        layout = {
                            order = 30,
                            type = "group",
                            name = l["layout"],
                            inline = true,
                            disabled = function()
                                return  not self.db.profile.apparence.enableIcons
                            end,
                            args = {
                                moving = {
                                    order = 10,
                                    type = "toggle",
                                    name = l["scrolling"],
                                    desc = l["scrolling_help"]
                                },
                                vertical = {
                                    order = 20,
                                    type = "toggle",
                                    name = l["vertical"]
                                },
                                offsetX = {
                                    order = 30,
                                    type = "range",
                                    name = l["horizontal_offset"],
                                    desc = l["horizontal_offset_help"],
                                    min = -1000,
                                    max = 1000,
                                    softMin = -500,
                                    softMax = 500,
                                    bigStep = 1
                                },
                                offsetY = {
                                    order = 40,
                                    type = "range",
                                    name = l["vertical_offset"],
                                    desc = l["vertical_offset_help"],
                                    min = -1000,
                                    max = 1000,
                                    softMin = -500,
                                    softMax = 500,
                                    bigStep = 1
                                },
                                margin = {
                                    order = 50,
                                    type = "range",
                                    name = l["margin_between_icons"],
                                    min = -16,
                                    max = 64,
                                    step = 1
                                }
                            }
                        }
                    }
                },
                iconAppearance = {
                    order = 50,
                    type = "group",
                    name = l["icon"],
                    args = {
                        iconScale = {
                            order = 10,
                            type = "range",
                            name = l["icon_scale"],
                            desc = l["icon_scale"],
                            min = 0.5,
                            max = 3,
                            bigStep = 0.01,
                            isPercent = true
                        },
                        smallIconScale = {
                            order = 20,
                            type = "range",
                            name = l["small_icon_scale"],
                            desc = l["small_icon_scale_help"],
                            min = 0.5,
                            max = 3,
                            bigStep = 0.01,
                            isPercent = true
                        },
                        remainsFontColor = {
                            type = "color",
                            order = 25,
                            name = l["remaining_time_font_color"],
                            get = function()
                                local t = self.db.profile.apparence.remainsFontColor
                                return t.r, t.g, t.b
                            end,
                            set = function(info, r, g, b)
                                local t = self.db.profile.apparence.remainsFontColor
                                t.r, t.g, t.b = r, g, b
                                self.db.profile.apparence.remainsFontColor = t
                            end
                        },
                        fontScale = {
                            order = 30,
                            type = "range",
                            name = l["font_scale"],
                            desc = l["font_scale_help"],
                            min = 0.2,
                            max = 2,
                            bigStep = 0.01,
                            isPercent = true
                        },
                        alpha = {
                            order = 40,
                            type = "range",
                            name = l["icon_opacity"],
                            min = 0,
                            max = 1,
                            bigStep = 0.01,
                            isPercent = true
                        },
                        raccourcis = {
                            order = 50,
                            type = "toggle",
                            name = l["keyboard_shortcuts"],
                            desc = l["show_keyboard_shortcuts"]
                        },
                        numeric = {
                            order = 60,
                            type = "toggle",
                            name = l["show_cooldown"],
                            desc = l["show_cooldown_help"]
                        },
                        highlightIcon = {
                            order = 70,
                            type = "toggle",
                            name = l["highlight_icon"],
                            desc = l["highlight_icon_help"]
                        },
                        flashIcon = {
                            order = 80,
                            type = "toggle",
                            name = l["highlight_icon_on_cd"]
                        },
                        targetText = {
                            order = 90,
                            type = "input",
                            name = l["range_indicator"],
                            desc = l["range_indicator_help"]
                        }
                    }
                },
                optionsAppearance = {
                    order = 60,
                    type = "group",
                    name = l["options"],
                    args = {
                        iconShiftX = {
                            order = 10,
                            type = "range",
                            name = l["options_horizontal_shift"],
                            min = -256,
                            max = 256,
                            step = 1
                        },
                        iconShiftY = {
                            order = 20,
                            type = "range",
                            name = l["options_vertical_shift"],
                            min = -256,
                            max = 256,
                            step = 1
                        },
                        optionsAlpha = {
                            order = 30,
                            type = "range",
                            name = l["option_opacity"],
                            min = 0,
                            max = 1,
                            bigStep = 0.01,
                            isPercent = true
                        }
                    }
                },
                advanced = {
                    order = 80,
                    type = "group",
                    name = "Advanced",
                    args = {
                        taggedEnemies = {
                            order = 10,
                            type = "toggle",
                            name = l["only_tagged"],
                            desc = l["only_tagged_help"]
                        },
                        auraLag = {
                            order = 20,
                            type = "range",
                            name = l["aura_lag"],
                            desc = l["lag_threshold"],
                            min = 100,
                            max = 700,
                            step = 10
                        },
                        minFrameRefresh = {
                            order = 30,
                            type = "range",
                            name = l["min_refresh"],
                            desc = l["min_refresh_help"],
                            min = 50,
                            max = 100,
                            step = 5
                        },
                        maxFrameRefresh = {
                            order = 40,
                            type = "range",
                            name = l["max_refresh"],
                            desc = l["min_refresh_help"],
                            min = 100,
                            max = 400,
                            step = 10
                        },
                        fullAuraScan = {
                            order = 50,
                            width = "full",
                            type = "toggle",
                            name = l["scan_all_auras"],
                            desc = l.scan_all_auras_help
                        },
                        frequentHealthUpdates = {
                            order = 60,
                            width = "full",
                            type = "toggle",
                            name = l["frequent_health_updates"],
                            desc = l["frequent_health_updates_help"]
                        }
                    }
                }
            }
        }
        self.options = {
            type = "group",
            args = {
                apparence = self.apparence,
                actions = self.actions,
                profile = {}
            }
        }
        self.handleInitialize = function()
            local ovale = self.ovale:GetName()
            self.db = AceDB:New("OvaleDB", self.defaultDB)
            local db = self.db
            self.options.args.profile = AceDBOptions:GetOptionsTable(db)
            db.RegisterCallback(self, "OnNewProfile", self.handleProfileChanges)
            db.RegisterCallback(self, "OnProfileReset", self.handleProfileChanges)
            db.RegisterCallback(self, "OnProfileChanged", self.handleProfileChanges)
            db.RegisterCallback(self, "OnProfileCopied", self.handleProfileChanges)
            self:upgradeSavedVariables()
            AceConfig:RegisterOptionsTable(ovale, self.options.args.apparence)
            AceConfig:RegisterOptionsTable(ovale .. " Profiles", self.options.args.profile)
            AceConfig:RegisterOptionsTable(ovale .. " Actions", self.options.args.actions, "Ovale")
            AceConfigDialog:AddToBlizOptions(ovale)
            AceConfigDialog:AddToBlizOptions(ovale .. " Profiles", "Profiles", ovale)
            self.handleProfileChanges()
        end
        self.handleDisable = function()
        end
        self.handleProfileChanges = function()
            self.module:SendMessage("Ovale_ProfileChanged")
            self.module:SendMessage("Ovale_ScriptChanged")
            self.module:SendMessage("Ovale_OptionChanged", "layout")
            self.module:SendMessage("Ovale_OptionChanged", "visibility")
        end
        self.module = ovale:createModule("OvaleOptions", self.handleInitialize, self.handleDisable, aceConsole, aceEvent)
    end,
    registerOptions = function(self)
    end,
    upgradeSavedVariables = function(self)
        for _, addon in ipairs(optionModules) do
            if addon.upgradeSavedVariables then
                addon:upgradeSavedVariables()
            end
        end
        self.db.RegisterDefaults(self.defaultDB)
    end,
    toggleConfig = function(self)
        local appName = self.ovale:GetName()
        if self.db.profile.standaloneOptions then
            if AceConfigDialog.OpenFrames[appName] then
                AceConfigDialog:Close(appName)
            else
                AceConfigDialog:Open(appName)
            end
        else
            InterfaceOptionsFrame_OpenToCategory(appName)
            InterfaceOptionsFrame_OpenToCategory(appName)
        end
    end,
})

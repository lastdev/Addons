-- ####################################################################
-- ##                      Localization Support                      ##
-- ####################################################################

-- Get an object we can use for the localization of the addon.
local L = LibStub("AceLocale-3.0"):GetLocale("RareTrackerMechagon", true)

-- ####################################################################
-- ##                             Options                            ##
-- ####################################################################

function RTM:InitializeRareTrackerDatabase()
    self.defaults = RT.GetDefaultModuleDatabaseValues()
    
    -- Copy over settings from the previous version, if possible.
    if RTMDB then
        -- Copy over the favorite rares, ignored rares and window scale.
        if RTMDB.favorite_rares then
            self.defaults.global.favorite_rares = RTMDB.favorite_rares
        end
        
        if RTMDB.ignore_rare then
            self.defaults.global.ignore_rares = RTMDB.ignore_rare
        end
        
        if RTMDB.window_scale then
            self.defaults.global.window_scale = RTMDB.window_scale
        end
        
        -- Remove the RTUDB table.
        RTMDB = nil
    end
    
    -- Load the database.
    self.db = LibStub("AceDB-3.0"):New("RareTrackerMechagonDB", self.defaults, true)
end

function RTM:AddModuleOptions(options)
    options[self.addon_code] = {
        type = "group",
        name = "Mechagon",
        order = RT:GetOrder(),
        childGroups = "tab",
        args = {
            description = {
                type = "description",
                name = "RareTrackerMechagon (RTM)",
                order = RT:GetOrder(),
                fontSize = "large",
                width = "full",
            },
            general = {
                type = "group",
                name = L["General Options"],
                order = RT:GetOrder(),
                args = {
                    window_scale = {
                        type = "range",
                        name = L["Rare window scale"],
                        desc = L["Set the scale of the rare window."],
                        min = 0.5,
                        max = 2,
                        step = 0.05,
                        isPercent = true,
                        order = RT:GetOrder(),
                        width = 1.2,
                        get = function()
                            return self.db.global.window_scale
                        end,
                        set = function(_, val)
                            self.db.global.window_scale  = val
                            self:SetScale(val)
                        end
                    },
                    reset_favorites = {
                        type = "execute",
                        name = L["Reset Favorites"],
                        desc = L["Reset the list of favorite rares."],
                        order = RT:GetOrder(),
                        width = 1.2,
                        func = function()
                            self.db.global.favorite_rares = {}
                            self:CorrectFavoriteMarks()
                        end
                    },
                }
            },
            ordering = {
                type = "group",
                name = L["Rare List Options"],
                order = RT:GetOrder(),
                args = {
                    enable_all = {
                        type = "execute",
                        name = L["Enable All"],
                        desc = L["Enable all rares in the list."],
                        order = RT:GetOrder(),
                        width = 0.7,
                        func = function()
                            for _, npc_id in pairs(self.rare_ids) do
                                self.db.global.ignore_rares[npc_id] = nil
                            end
                            self:ReorganizeRareTableFrame(self.entities_frame)
                        end
                    },
                    disable_all = {
                        type = "execute",
                        name = L["Disable All"],
                        desc = L["Disable all non-favorite rares in the list."],
                        order = RT:GetOrder(),
                        width = 0.7,
                        func = function(_)
                            for _, npc_id in pairs(self.rare_ids) do
                                if self.db.global.favorite_rares[npc_id] ~= true then
                                  self.db.global.ignore_rares[npc_id] = true
                                end
                            end
                            self:ReorganizeRareTableFrame(self.entities_frame)
                        end
                    },
                    ignore = {
                        type = "group",
                        name = L["Active Rares"],
                        order = RT:GetOrder(),
                        inline = true,
                        args = {
                            -- To be filled dynamically.
                        }
                    },
                }
            }
        }
    }
    
    -- Add checkboxes for all of the rares.
    for _, npc_id in pairs(self.rare_ids) do
        options[self.addon_code].args.ordering.args.ignore.args[""..npc_id] = {
            type = "toggle",
            name = self.rare_names[npc_id],
            width = "full",
            order = RT:GetOrder(),
            get = function()
                return not self.db.global.ignore_rares[npc_id]
            end,
            set = function(_, val)
                if val then
                    self.db.global.ignore_rares[npc_id] = nil
                else
                    self.db.global.ignore_rares[npc_id] = true
                end
                self:ReorganizeRareTableFrame(self.entities_frame)
            end,
            disabled = function()
                return self.db.global.favorite_rares[npc_id]
            end
        }
    end
end

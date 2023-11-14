local myname, ns = ...

ns.defaults = {
    profile = {
        -- found = false,
        icon_scale = 1.5,
        icon_alpha = 1.0,
        icon_item = true,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

ns.options = {
    type = "group",
    name = myname:gsub("HandyNotes_", ""),
    get = function(info) return ns.db[info[#info]] end,
    set = function(info, v)
        ns.db[info[#info]] = v
        ns.HL:SendMessage("HandyNotes_NotifyUpdate", myname:gsub("HandyNotes_", ""))
    end,
    args = {
        icon = {
            type = "group",
            name = "Icon settings",
            inline = true,
            args = {
                desc = {
                    name = "These settings control the look and feel of the icon.",
                    type = "description",
                    order = 0,
                },
                icon_scale = {
                    type = "range",
                    name = "Icon Scale",
                    desc = "The scale of the icons",
                    min = 0.50, max = 3, step = 0.1,
                    order = 20,
                },
                icon_alpha = {
                    type = "range",
                    name = "Icon Alpha",
                    desc = "The alpha transparency of the icons",
                    min = 0, max = 1, step = 0.01,
                    order = 30,
                },
            },
        },
        display = {
            type = "group",
            name = "What to display",
            inline = true,
            args = {
                -- found = {
                --     type = "toggle",
                --     name = "Show found",
                --     desc = "Show waypoints for items you've already found?",
                --     order = 20,
                -- },
                unhide = {
                    type = "execute",
                    name = "Reset hidden nodes",
                    desc = "Show all nodes that you manually hid by right-clicking on them and choosing \"hide\".",
                    func = function()
                        for map,coords in pairs(ns.hidden) do
                            wipe(coords)
                        end
                        ns.HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
ns.should_show_point = function(coord, point, currentZone, currentLevel)
    if point.level and point.level ~= currentLevel then
        return false
    end
    if ns.hidden[currentZone] and ns.hidden[currentZone][coord] then
        return false
    end
    if point.junk and not ns.db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not ns.db.found) then
        if point.quest and IsQuestFlaggedCompleted(point.quest) then
            return false
        end
        if point.achievement then
            local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(point.achievement)
            if completed then
                return false
            end
            if point.criteria then
                local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                if completed then
                    return false
                end
            end
        end
        if point.follower and C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        -- This is actually super-targeted at Basten, who is repeatable daily and drops a toy
        -- Might want to generalize at some point...
        if point.toy and point.item and point.repeatable and select(4, C_ToyBox.GetToyInfo(point.item)) then
            return false
        end
    end
    if (not ns.db.repeatable) and point.repeatable then
        return false
    end
    if point.npc and not point.follower and not ns.db.show_npcs then
        return false
    end
    return true
end

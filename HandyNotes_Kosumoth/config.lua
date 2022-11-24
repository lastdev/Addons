local myname, ns = ...

ns.defaults = {
    profile = {
        icon_scale = 1.5,
        icon_alpha = 1.0,
        completed = false,
        numbered = true,
        upcoming = false,
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
                    min = 0.25, max = 2, step = 0.01,
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
                completed = {
                    type = "toggle",
                    name = "Show completed",
                    desc = "Show waypoints for orbs you've already found",
                    order = 20,
                },
                numbered = {
                    type = "toggle",
                    name = "Show numbers",
                    desc = "Use the orb number as the icon (may be a bit harder to see)",
                    order = 30,
                },
                upcoming = {
                    type = "toggle",
                    name = "Show irrelevant orbs",
                    desc = "Show the upcoming quest steps, as well as the current one (may be too much currently-useless information)",
                    order = 40,
                },
            },
        },
    },
}

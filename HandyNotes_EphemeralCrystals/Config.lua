local AddonName, ec = ...

ec.defaults = {
    profile = {
        icon_scale = 1.0,
        icon_alpha = 1.0
    },
}
ec.options = {
    type = "group",
    name = AddonName:gsub("HandyNotes_", ""),
    get = function(info) return ec.db[info[#info]] end,
    set = function(info, v)
        ec.db[info[#info]] = v
        ec.EphemeralCrystals:SendMessage("HandyNotes_NotifyUpdate", AddonName:gsub("HandyNotes_", ""))
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
    },
}
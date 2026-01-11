local addonName, addon = ...

Mixin(addon.WODGUI, addon.WODGUIMixin)
addon.WODGUI:Init()

addon.WODGUI.rewardStrings = {
    "garrison-resources",
    "follower-items",
    "pet-charms",
    "reputation",
    "followerxp",
    "gear",
    "apexis",
    "oil",
    "seal",
    "archaeology",
}

if addon.WODGUI.GoldCheckButton then
    table.insert(addon.DraenorGUI.rewardStrings, 1, "gold")
end
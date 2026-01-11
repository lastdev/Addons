local addonName, addon = ...

Mixin(addon.LegionGUI, addon.LegionGUIMixin)
addon.LegionGUI:Init()

addon.LegionGUI.rewardStrings = {
    "orderhall-resources",
    "follower-items",
    "pet-charms",
    --"followerxp",
    "reputation",
    "gear",
    "crafting-reagents",
    "augment-runes",
}

if addon.LegionGUI.GoldCheckButton then
    table.insert(addon.LegionGUI.rewardStrings, 1, "gold")
end
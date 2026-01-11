local addonName, addon = ...

Mixin(addon.BFAGUI, addon.BFAGUIMixin)
addon.BFAGUI:Init()

addon.BFAGUI.rewardStrings = {
    "resources",
    "artifact-power",
    "augment-runes",
    --"follower-items",
    --"pet-charms",
    --"followerxp",
    "reputation",
    --"gear",
    "crafting-reagents",
}

if addon.BFAGUI.GoldCheckButton then
    table.insert(addon.BFAGUI.rewardStrings, 1, "gold")
end
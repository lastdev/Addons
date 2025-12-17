local addonName, addon = ...

Mixin(addon.BFAGUI, addon.BFAGUIMixin)
addon.BFAGUI:Init()

addon.BFAGUI.rewardStrings = {
    "resources",
    --"follower-items",
    --"pet-charms",
    --"followerxp",
    "reputation",
    --"gear",
    --"crafting-reagents",
    "artifact-power",
}

if addon.BFAGUI.GoldCheckButton then
    table.insert(addon.BFAGUI.rewardStrings, 1, "gold")
end
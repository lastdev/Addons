local __exports = LibStub:NewLibrary("ovale/scripts/index", 90113)
if not __exports then return end
local __imports = {}
__imports.__ovale_common = LibStub:GetLibrary("ovale/scripts/ovale_common")
__imports.registerCommon = __imports.__ovale_common.registerCommon
__imports.__ovale_deathknight_spells = LibStub:GetLibrary("ovale/scripts/ovale_deathknight_spells")
__imports.registerDeathKnightSpells = __imports.__ovale_deathknight_spells.registerDeathKnightSpells
__imports.__ovale_deathknight = LibStub:GetLibrary("ovale/scripts/ovale_deathknight")
__imports.registerDeathKnight = __imports.__ovale_deathknight.registerDeathKnight
__imports.__ovale_demonhunter = LibStub:GetLibrary("ovale/scripts/ovale_demonhunter")
__imports.registerDemonHunter = __imports.__ovale_demonhunter.registerDemonHunter
__imports.__ovale_druid = LibStub:GetLibrary("ovale/scripts/ovale_druid")
__imports.registerDruid = __imports.__ovale_druid.registerDruid
__imports.__ovale_hunter = LibStub:GetLibrary("ovale/scripts/ovale_hunter")
__imports.registerHunter = __imports.__ovale_hunter.registerHunter
__imports.__ovale_mage = LibStub:GetLibrary("ovale/scripts/ovale_mage")
__imports.registerMage = __imports.__ovale_mage.registerMage
__imports.__ovale_monk = LibStub:GetLibrary("ovale/scripts/ovale_monk")
__imports.registerMonk = __imports.__ovale_monk.registerMonk
__imports.__ovale_paladin = LibStub:GetLibrary("ovale/scripts/ovale_paladin")
__imports.registerPaladin = __imports.__ovale_paladin.registerPaladin
__imports.__ovale_priest = LibStub:GetLibrary("ovale/scripts/ovale_priest")
__imports.registerPriest = __imports.__ovale_priest.registerPriest
__imports.__ovale_rogue = LibStub:GetLibrary("ovale/scripts/ovale_rogue")
__imports.registerRogue = __imports.__ovale_rogue.registerRogue
__imports.__ovale_shaman = LibStub:GetLibrary("ovale/scripts/ovale_shaman")
__imports.registerShaman = __imports.__ovale_shaman.registerShaman
__imports.__ovale_warlock = LibStub:GetLibrary("ovale/scripts/ovale_warlock")
__imports.registerWarlock = __imports.__ovale_warlock.registerWarlock
__imports.__ovale_warrior = LibStub:GetLibrary("ovale/scripts/ovale_warrior")
__imports.registerWarrior = __imports.__ovale_warrior.registerWarrior
__imports.__ovale_demonhunter_spells = LibStub:GetLibrary("ovale/scripts/ovale_demonhunter_spells")
__imports.registerDemonHunterSpells = __imports.__ovale_demonhunter_spells.registerDemonHunterSpells
__imports.__ovale_druid_spells = LibStub:GetLibrary("ovale/scripts/ovale_druid_spells")
__imports.registerDruidSpells = __imports.__ovale_druid_spells.registerDruidSpells
__imports.__ovale_hunter_spells = LibStub:GetLibrary("ovale/scripts/ovale_hunter_spells")
__imports.registerHunterSpells = __imports.__ovale_hunter_spells.registerHunterSpells
__imports.__ovale_mage_spells = LibStub:GetLibrary("ovale/scripts/ovale_mage_spells")
__imports.registerMageSpells = __imports.__ovale_mage_spells.registerMageSpells
__imports.__ovale_monk_spells = LibStub:GetLibrary("ovale/scripts/ovale_monk_spells")
__imports.registerMonkSpells = __imports.__ovale_monk_spells.registerMonkSpells
__imports.__ovale_paladin_spells = LibStub:GetLibrary("ovale/scripts/ovale_paladin_spells")
__imports.registerPaladinSpells = __imports.__ovale_paladin_spells.registerPaladinSpells
__imports.__ovale_priest_spells = LibStub:GetLibrary("ovale/scripts/ovale_priest_spells")
__imports.registerPriestSpells = __imports.__ovale_priest_spells.registerPriestSpells
__imports.__ovale_rogue_spells = LibStub:GetLibrary("ovale/scripts/ovale_rogue_spells")
__imports.registerRogueSpells = __imports.__ovale_rogue_spells.registerRogueSpells
__imports.__ovale_shaman_spells = LibStub:GetLibrary("ovale/scripts/ovale_shaman_spells")
__imports.registerShamanSpells = __imports.__ovale_shaman_spells.registerShamanSpells
__imports.__ovale_warlock_spells = LibStub:GetLibrary("ovale/scripts/ovale_warlock_spells")
__imports.registerWarlockSpells = __imports.__ovale_warlock_spells.registerWarlockSpells
__imports.__ovale_warrior_spells = LibStub:GetLibrary("ovale/scripts/ovale_warrior_spells")
__imports.registerWarriorSpells = __imports.__ovale_warrior_spells.registerWarriorSpells
local registerCommon = __imports.registerCommon
local registerDeathKnightSpells = __imports.registerDeathKnightSpells
local registerDeathKnight = __imports.registerDeathKnight
local registerDemonHunter = __imports.registerDemonHunter
local registerDruid = __imports.registerDruid
local registerHunter = __imports.registerHunter
local registerMage = __imports.registerMage
local registerMonk = __imports.registerMonk
local registerPaladin = __imports.registerPaladin
local registerPriest = __imports.registerPriest
local registerRogue = __imports.registerRogue
local registerShaman = __imports.registerShaman
local registerWarlock = __imports.registerWarlock
local registerWarrior = __imports.registerWarrior
local registerDemonHunterSpells = __imports.registerDemonHunterSpells
local registerDruidSpells = __imports.registerDruidSpells
local registerHunterSpells = __imports.registerHunterSpells
local registerMageSpells = __imports.registerMageSpells
local registerMonkSpells = __imports.registerMonkSpells
local registerPaladinSpells = __imports.registerPaladinSpells
local registerPriestSpells = __imports.registerPriestSpells
local registerRogueSpells = __imports.registerRogueSpells
local registerShamanSpells = __imports.registerShamanSpells
local registerWarlockSpells = __imports.registerWarlockSpells
local registerWarriorSpells = __imports.registerWarriorSpells
__exports.registerScripts = function(ovaleScripts)
    registerCommon(ovaleScripts)
    registerDeathKnightSpells(ovaleScripts)
    registerDemonHunterSpells(ovaleScripts)
    registerDruidSpells(ovaleScripts)
    registerHunterSpells(ovaleScripts)
    registerMageSpells(ovaleScripts)
    registerMonkSpells(ovaleScripts)
    registerPaladinSpells(ovaleScripts)
    registerPriestSpells(ovaleScripts)
    registerRogueSpells(ovaleScripts)
    registerShamanSpells(ovaleScripts)
    registerWarlockSpells(ovaleScripts)
    registerWarriorSpells(ovaleScripts)
    registerDeathKnight(ovaleScripts)
    registerDemonHunter(ovaleScripts)
    registerDruid(ovaleScripts)
    registerHunter(ovaleScripts)
    registerMage(ovaleScripts)
    registerMonk(ovaleScripts)
    registerPaladin(ovaleScripts)
    registerPriest(ovaleScripts)
    registerRogue(ovaleScripts)
    registerShaman(ovaleScripts)
    registerWarlock(ovaleScripts)
    registerWarrior(ovaleScripts)
end

local __exports = LibStub:NewLibrary("ovale/ioc", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__Ovale = LibStub:GetLibrary("ovale/Ovale")
__imports.OvaleClass = __imports.__Ovale.OvaleClass
__imports.__enginescripts = LibStub:GetLibrary("ovale/engine/scripts")
__imports.OvaleScriptsClass = __imports.__enginescripts.OvaleScriptsClass
__imports.__uiOptions = LibStub:GetLibrary("ovale/ui/Options")
__imports.OvaleOptionsClass = __imports.__uiOptions.OvaleOptionsClass
__imports.__statesPaperDoll = LibStub:GetLibrary("ovale/states/PaperDoll")
__imports.OvalePaperDollClass = __imports.__statesPaperDoll.OvalePaperDollClass
__imports.__engineactionbar = LibStub:GetLibrary("ovale/engine/action-bar")
__imports.OvaleActionBarClass = __imports.__engineactionbar.OvaleActionBarClass
__imports.__enginecombatlogevent = LibStub:GetLibrary("ovale/engine/combat-log-event")
__imports.CombatLogEvent = __imports.__enginecombatlogevent.CombatLogEvent
__imports.__engineast = LibStub:GetLibrary("ovale/engine/ast")
__imports.OvaleASTClass = __imports.__engineast.OvaleASTClass
__imports.__statesAura = LibStub:GetLibrary("ovale/states/Aura")
__imports.OvaleAuraClass = __imports.__statesAura.OvaleAuraClass
__imports.__statesAzeriteArmor = LibStub:GetLibrary("ovale/states/AzeriteArmor")
__imports.OvaleAzeriteArmor = __imports.__statesAzeriteArmor.OvaleAzeriteArmor
__imports.__statesAzeriteEssence = LibStub:GetLibrary("ovale/states/AzeriteEssence")
__imports.OvaleAzeriteEssenceClass = __imports.__statesAzeriteEssence.OvaleAzeriteEssenceClass
__imports.__statesBaseState = LibStub:GetLibrary("ovale/states/BaseState")
__imports.BaseState = __imports.__statesBaseState.BaseState
__imports.__enginebestaction = LibStub:GetLibrary("ovale/engine/best-action")
__imports.OvaleBestActionClass = __imports.__enginebestaction.OvaleBestActionClass
__imports.__statesbloodtalons = LibStub:GetLibrary("ovale/states/bloodtalons")
__imports.Bloodtalons = __imports.__statesbloodtalons.Bloodtalons
__imports.__statesBossMod = LibStub:GetLibrary("ovale/states/BossMod")
__imports.OvaleBossModClass = __imports.__statesBossMod.OvaleBossModClass
__imports.__enginecompile = LibStub:GetLibrary("ovale/engine/compile")
__imports.OvaleCompileClass = __imports.__enginecompile.OvaleCompileClass
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.OvaleConditionClass = __imports.__enginecondition.OvaleConditionClass
__imports.__statesCooldown = LibStub:GetLibrary("ovale/states/Cooldown")
__imports.OvaleCooldownClass = __imports.__statesCooldown.OvaleCooldownClass
__imports.__statesDamageTaken = LibStub:GetLibrary("ovale/states/DamageTaken")
__imports.OvaleDamageTakenClass = __imports.__statesDamageTaken.OvaleDamageTakenClass
__imports.__enginedata = LibStub:GetLibrary("ovale/engine/data")
__imports.OvaleDataClass = __imports.__enginedata.OvaleDataClass
__imports.__uiDataBroker = LibStub:GetLibrary("ovale/ui/DataBroker")
__imports.OvaleDataBrokerClass = __imports.__uiDataBroker.OvaleDataBrokerClass
__imports.__enginedebug = LibStub:GetLibrary("ovale/engine/debug")
__imports.DebugTools = __imports.__enginedebug.DebugTools
__imports.__statesDemonHunterDemonic = LibStub:GetLibrary("ovale/states/DemonHunterDemonic")
__imports.OvaleDemonHunterDemonicClass = __imports.__statesDemonHunterDemonic.OvaleDemonHunterDemonicClass
__imports.__statesDemonHunterSoulFragments = LibStub:GetLibrary("ovale/states/DemonHunterSoulFragments")
__imports.OvaleDemonHunterSoulFragmentsClass = __imports.__statesDemonHunterSoulFragments.OvaleDemonHunterSoulFragmentsClass
__imports.__statesDemonHunterSigils = LibStub:GetLibrary("ovale/states/DemonHunterSigils")
__imports.OvaleSigilClass = __imports.__statesDemonHunterSigils.OvaleSigilClass
__imports.__stateseclipse = LibStub:GetLibrary("ovale/states/eclipse")
__imports.Eclipse = __imports.__stateseclipse.Eclipse
__imports.__statesEnemies = LibStub:GetLibrary("ovale/states/Enemies")
__imports.OvaleEnemiesClass = __imports.__statesEnemies.OvaleEnemiesClass
__imports.__statesEquipment = LibStub:GetLibrary("ovale/states/Equipment")
__imports.OvaleEquipmentClass = __imports.__statesEquipment.OvaleEquipmentClass
__imports.__uiFrame = LibStub:GetLibrary("ovale/ui/Frame")
__imports.OvaleFrameModuleClass = __imports.__uiFrame.OvaleFrameModuleClass
__imports.__statesFuture = LibStub:GetLibrary("ovale/states/Future")
__imports.OvaleFutureClass = __imports.__statesFuture.OvaleFutureClass
__imports.__engineguid = LibStub:GetLibrary("ovale/engine/guid")
__imports.Guids = __imports.__engineguid.Guids
__imports.__statesHealth = LibStub:GetLibrary("ovale/states/Health")
__imports.OvaleHealthClass = __imports.__statesHealth.OvaleHealthClass
__imports.__statesLastSpell = LibStub:GetLibrary("ovale/states/LastSpell")
__imports.LastSpell = __imports.__statesLastSpell.LastSpell
__imports.__statesLossOfControl = LibStub:GetLibrary("ovale/states/LossOfControl")
__imports.OvaleLossOfControlClass = __imports.__statesLossOfControl.OvaleLossOfControlClass
__imports.__statesPower = LibStub:GetLibrary("ovale/states/Power")
__imports.OvalePowerClass = __imports.__statesPower.OvalePowerClass
__imports.__uiRecount = LibStub:GetLibrary("ovale/ui/Recount")
__imports.OvaleRecountClass = __imports.__uiRecount.OvaleRecountClass
__imports.__statesRunes = LibStub:GetLibrary("ovale/states/Runes")
__imports.OvaleRunesClass = __imports.__statesRunes.OvaleRunesClass
__imports.__uiScore = LibStub:GetLibrary("ovale/ui/Score")
__imports.OvaleScoreClass = __imports.__uiScore.OvaleScoreClass
__imports.__statesSpellBook = LibStub:GetLibrary("ovale/states/SpellBook")
__imports.OvaleSpellBookClass = __imports.__statesSpellBook.OvaleSpellBookClass
__imports.__statesSpellDamage = LibStub:GetLibrary("ovale/states/SpellDamage")
__imports.OvaleSpellDamageClass = __imports.__statesSpellDamage.OvaleSpellDamageClass
__imports.__uiSpellFlash = LibStub:GetLibrary("ovale/ui/SpellFlash")
__imports.OvaleSpellFlashClass = __imports.__uiSpellFlash.OvaleSpellFlashClass
__imports.__statesSpells = LibStub:GetLibrary("ovale/states/Spells")
__imports.OvaleSpellsClass = __imports.__statesSpells.OvaleSpellsClass
__imports.__statesStagger = LibStub:GetLibrary("ovale/states/Stagger")
__imports.OvaleStaggerClass = __imports.__statesStagger.OvaleStaggerClass
__imports.__statesStance = LibStub:GetLibrary("ovale/states/Stance")
__imports.OvaleStanceClass = __imports.__statesStance.OvaleStanceClass
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.OvaleStateClass = __imports.__enginestate.OvaleStateClass
__imports.__statesTotem = LibStub:GetLibrary("ovale/states/Totem")
__imports.OvaleTotemClass = __imports.__statesTotem.OvaleTotemClass
__imports.__statesVariables = LibStub:GetLibrary("ovale/states/Variables")
__imports.Variables = __imports.__statesVariables.Variables
__imports.__uiVersion = LibStub:GetLibrary("ovale/ui/Version")
__imports.OvaleVersionClass = __imports.__uiVersion.OvaleVersionClass
__imports.__statesWarlock = LibStub:GetLibrary("ovale/states/Warlock")
__imports.OvaleWarlockClass = __imports.__statesWarlock.OvaleWarlockClass
__imports.__statesconditions = LibStub:GetLibrary("ovale/states/conditions")
__imports.OvaleConditions = __imports.__statesconditions.OvaleConditions
__imports.__simulationcraftSimulationCraft = LibStub:GetLibrary("ovale/simulationcraft/SimulationCraft")
__imports.OvaleSimulationCraftClass = __imports.__simulationcraftSimulationCraft.OvaleSimulationCraftClass
__imports.__simulationcraftemiter = LibStub:GetLibrary("ovale/simulationcraft/emiter")
__imports.Emiter = __imports.__simulationcraftemiter.Emiter
__imports.__simulationcraftparser = LibStub:GetLibrary("ovale/simulationcraft/parser")
__imports.Parser = __imports.__simulationcraftparser.Parser
__imports.__simulationcraftgenerator = LibStub:GetLibrary("ovale/simulationcraft/generator")
__imports.Generator = __imports.__simulationcraftgenerator.Generator
__imports.__simulationcraftunparser = LibStub:GetLibrary("ovale/simulationcraft/unparser")
__imports.Unparser = __imports.__simulationcraftunparser.Unparser
__imports.__simulationcraftsplitter = LibStub:GetLibrary("ovale/simulationcraft/splitter")
__imports.Splitter = __imports.__simulationcraftsplitter.Splitter
__imports.__statescombat = LibStub:GetLibrary("ovale/states/combat")
__imports.OvaleCombatClass = __imports.__statescombat.OvaleCombatClass
__imports.__statescovenant = LibStub:GetLibrary("ovale/states/covenant")
__imports.Covenant = __imports.__statescovenant.Covenant
__imports.__statesruneforge = LibStub:GetLibrary("ovale/states/runeforge")
__imports.Runeforge = __imports.__statesruneforge.Runeforge
__imports.__statessoulbind = LibStub:GetLibrary("ovale/states/soulbind")
__imports.Soulbind = __imports.__statessoulbind.Soulbind
__imports.__enginerunner = LibStub:GetLibrary("ovale/engine/runner")
__imports.Runner = __imports.__enginerunner.Runner
__imports.__enginecontrols = LibStub:GetLibrary("ovale/engine/controls")
__imports.Controls = __imports.__enginecontrols.Controls
__imports.__statesspellactivationglow = LibStub:GetLibrary("ovale/states/spellactivationglow")
__imports.SpellActivationGlow = __imports.__statesspellactivationglow.SpellActivationGlow
local OvaleClass = __imports.OvaleClass
local OvaleScriptsClass = __imports.OvaleScriptsClass
local OvaleOptionsClass = __imports.OvaleOptionsClass
local OvalePaperDollClass = __imports.OvalePaperDollClass
local OvaleActionBarClass = __imports.OvaleActionBarClass
local CombatLogEvent = __imports.CombatLogEvent
local OvaleASTClass = __imports.OvaleASTClass
local OvaleAuraClass = __imports.OvaleAuraClass
local OvaleAzeriteArmor = __imports.OvaleAzeriteArmor
local OvaleAzeriteEssenceClass = __imports.OvaleAzeriteEssenceClass
local BaseState = __imports.BaseState
local OvaleBestActionClass = __imports.OvaleBestActionClass
local Bloodtalons = __imports.Bloodtalons
local OvaleBossModClass = __imports.OvaleBossModClass
local OvaleCompileClass = __imports.OvaleCompileClass
local OvaleConditionClass = __imports.OvaleConditionClass
local OvaleCooldownClass = __imports.OvaleCooldownClass
local OvaleDamageTakenClass = __imports.OvaleDamageTakenClass
local OvaleDataClass = __imports.OvaleDataClass
local OvaleDataBrokerClass = __imports.OvaleDataBrokerClass
local DebugTools = __imports.DebugTools
local OvaleDemonHunterDemonicClass = __imports.OvaleDemonHunterDemonicClass
local OvaleDemonHunterSoulFragmentsClass = __imports.OvaleDemonHunterSoulFragmentsClass
local OvaleSigilClass = __imports.OvaleSigilClass
local Eclipse = __imports.Eclipse
local OvaleEnemiesClass = __imports.OvaleEnemiesClass
local OvaleEquipmentClass = __imports.OvaleEquipmentClass
local OvaleFrameModuleClass = __imports.OvaleFrameModuleClass
local OvaleFutureClass = __imports.OvaleFutureClass
local Guids = __imports.Guids
local OvaleHealthClass = __imports.OvaleHealthClass
local LastSpell = __imports.LastSpell
local OvaleLossOfControlClass = __imports.OvaleLossOfControlClass
local OvalePowerClass = __imports.OvalePowerClass
local OvaleRecountClass = __imports.OvaleRecountClass
local OvaleRunesClass = __imports.OvaleRunesClass
local OvaleScoreClass = __imports.OvaleScoreClass
local OvaleSpellBookClass = __imports.OvaleSpellBookClass
local OvaleSpellDamageClass = __imports.OvaleSpellDamageClass
local OvaleSpellFlashClass = __imports.OvaleSpellFlashClass
local OvaleSpellsClass = __imports.OvaleSpellsClass
local OvaleStaggerClass = __imports.OvaleStaggerClass
local OvaleStanceClass = __imports.OvaleStanceClass
local OvaleStateClass = __imports.OvaleStateClass
local OvaleTotemClass = __imports.OvaleTotemClass
local Variables = __imports.Variables
local OvaleVersionClass = __imports.OvaleVersionClass
local OvaleWarlockClass = __imports.OvaleWarlockClass
local OvaleConditions = __imports.OvaleConditions
local OvaleSimulationCraftClass = __imports.OvaleSimulationCraftClass
local Emiter = __imports.Emiter
local Parser = __imports.Parser
local Generator = __imports.Generator
local Unparser = __imports.Unparser
local Splitter = __imports.Splitter
local OvaleCombatClass = __imports.OvaleCombatClass
local Covenant = __imports.Covenant
local Runeforge = __imports.Runeforge
local Soulbind = __imports.Soulbind
local Runner = __imports.Runner
local Controls = __imports.Controls
local SpellActivationGlow = __imports.SpellActivationGlow
__exports.IoC = __class(nil, {
    constructor = function(self)
        self.ovale = __imports.OvaleClass()
        self.options = __imports.OvaleOptionsClass(self.ovale)
        self.debug = __imports.DebugTools(self.ovale, self.options)
        self.lastSpell = __imports.LastSpell()
        self.baseState = __imports.BaseState()
        self.condition = __imports.OvaleConditionClass(self.baseState)
        local controls = __imports.Controls()
        local runner = __imports.Runner(self.debug, self.baseState, self.condition)
        self.data = __imports.OvaleDataClass(runner, self.debug)
        self.combatLogEvent = __imports.CombatLogEvent(self.ovale, self.debug)
        self.guid = __imports.Guids(self.ovale, self.debug)
        self.equipment = __imports.OvaleEquipmentClass(self.ovale, self.debug, self.data)
        self.paperDoll = __imports.OvalePaperDollClass(self.equipment, self.ovale, self.debug)
        local covenant = __imports.Covenant(self.ovale, self.debug)
        local runeforge = __imports.Runeforge(self.ovale, self.debug, self.equipment)
        local soulbind = __imports.Soulbind(self.ovale, self.debug)
        self.spellBook = __imports.OvaleSpellBookClass(self.ovale, self.debug, self.data)
        self.cooldown = __imports.OvaleCooldownClass(self.paperDoll, self.data, self.lastSpell, self.ovale, self.debug)
        self.demonHunterSigils = __imports.OvaleSigilClass(self.ovale, self.debug, self.paperDoll, self.spellBook)
        local combat = __imports.OvaleCombatClass(self.ovale, self.debug, self.spellBook)
        self.power = __imports.OvalePowerClass(self.debug, self.ovale, self.data, self.baseState, self.spellBook, combat)
        self.state = __imports.OvaleStateClass()
        self.aura = __imports.OvaleAuraClass(self.state, self.paperDoll, self.baseState, self.data, self.guid, self.lastSpell, self.options, self.debug, self.ovale, self.spellBook, self.power, self.combatLogEvent)
        self.bloodtalons = __imports.Bloodtalons(self.ovale, self.debug, self.aura, self.paperDoll, self.spellBook)
        self.eclipse = __imports.Eclipse(self.ovale, self.debug, self.aura, combat, self.paperDoll, self.spellBook)
        self.stance = __imports.OvaleStanceClass(self.debug, self.ovale, self.data)
        self.enemies = __imports.OvaleEnemiesClass(self.guid, self.combatLogEvent, self.ovale, self.debug)
        self.future = __imports.OvaleFutureClass(self.data, self.aura, self.paperDoll, self.baseState, self.cooldown, self.state, self.guid, self.lastSpell, self.ovale, self.debug, self.stance, self.spellBook, self.combatLogEvent, runner)
        self.health = __imports.OvaleHealthClass(self.guid, self.ovale, self.options, self.debug, self.combatLogEvent)
        self.lossOfControl = __imports.OvaleLossOfControlClass(self.ovale, self.debug)
        self.azeriteEssence = __imports.OvaleAzeriteEssenceClass(self.ovale, self.debug)
        self.azeriteArmor = __imports.OvaleAzeriteArmor(self.equipment, self.ovale, self.debug)
        self.scripts = __imports.OvaleScriptsClass(self.ovale, self.options, self.paperDoll, self.debug)
        self.ast = __imports.OvaleASTClass(self.condition, self.debug, self.scripts, self.spellBook)
        self.score = __imports.OvaleScoreClass(self.ovale, self.future, self.debug, self.spellBook, combat)
        self.compile = __imports.OvaleCompileClass(self.azeriteArmor, self.ast, self.condition, self.cooldown, self.data, self.debug, self.ovale, self.score, self.spellBook, controls, self.scripts)
        self.stagger = __imports.OvaleStaggerClass(self.ovale, self.debug, self.aura, self.health, self.paperDoll, self.combatLogEvent)
        self.actionBar = __imports.OvaleActionBarClass(self.debug, self.ovale, self.spellBook)
        self.spellFlash = __imports.OvaleSpellFlashClass(self.options, self.ovale, combat, self.actionBar)
        self.totem = __imports.OvaleTotemClass(self.ovale, self.state, self.data, self.future, self.aura, self.spellBook, self.debug)
        self.variables = __imports.Variables(combat, self.baseState, self.debug)
        self.warlock = __imports.OvaleWarlockClass(self.ovale, self.aura, self.paperDoll, self.spellBook, self.future, self.power, self.combatLogEvent)
        self.version = __imports.OvaleVersionClass(self.ovale, self.options, self.debug)
        self.damageTaken = __imports.OvaleDamageTakenClass(self.ovale, self.debug, self.combatLogEvent)
        self.spellDamage = __imports.OvaleSpellDamageClass(self.ovale, self.combatLogEvent)
        self.demonHunterSoulFragments = __imports.OvaleDemonHunterSoulFragmentsClass(self.ovale, self.debug, self.aura, self.combatLogEvent, self.paperDoll)
        self.runes = __imports.OvaleRunesClass(self.ovale, self.debug, self.data, self.power, self.paperDoll)
        self.spellActivationGlow = __imports.SpellActivationGlow(self.ovale, self.debug)
        self.spells = __imports.OvaleSpellsClass(self.spellBook, self.ovale, self.debug, self.data, self.power, self.runes, self.spellActivationGlow)
        self.bestAction = __imports.OvaleBestActionClass(self.equipment, self.actionBar, self.data, self.cooldown, self.ovale, self.guid, self.future, self.spellBook, self.debug, self.variables, self.spells, runner)
        self.frame = __imports.OvaleFrameModuleClass(self.state, self.compile, self.future, self.baseState, self.enemies, self.ovale, self.options, self.debug, self.spellFlash, self.spellBook, self.bestAction, combat, runner, controls, self.scripts, self.actionBar, self.guid)
        self.dataBroker = __imports.OvaleDataBrokerClass(self.paperDoll, self.frame, self.options, self.ovale, self.debug, self.scripts)
        self.unparser = __imports.Unparser(self.debug)
        self.emiter = __imports.Emiter(self.debug, self.ast, self.data, self.unparser)
        self.parser = __imports.Parser(self.debug)
        self.splitter = __imports.Splitter(self.ast, self.debug, self.data)
        self.bossMod = __imports.OvaleBossModClass(self.ovale, self.debug, combat)
        self.demonHunterDemonic = __imports.OvaleDemonHunterDemonicClass(self.aura, self.paperDoll, self.spellBook, self.ovale, self.debug)
        self.generator = __imports.Generator(self.ast, self.data)
        self.simulationCraft = __imports.OvaleSimulationCraftClass(self.options, self.data, self.emiter, self.ast, self.parser, self.unparser, self.debug, self.compile, self.splitter, self.generator, self.ovale, controls)
        self.recount = __imports.OvaleRecountClass(self.ovale, self.score)
        self.conditions = __imports.OvaleConditions(self.condition, self.data, self.paperDoll, self.azeriteEssence, self.aura, self.baseState, self.bloodtalons, self.cooldown, self.future, self.spellBook, self.frame, self.guid, self.damageTaken, self.power, self.enemies, self.lastSpell, self.health, self.options, self.lossOfControl, self.spellDamage, self.totem, self.demonHunterSigils, self.demonHunterSoulFragments, self.runes, self.bossMod, self.spells)
        self.runner = runner
        self.state:registerState(self.cooldown)
        self.state:registerState(self.paperDoll)
        self.state:registerState(self.baseState)
        self.state:registerState(self.bloodtalons)
        self.state:registerState(self.demonHunterDemonic)
        self.state:registerState(self.demonHunterSigils)
        self.state:registerState(self.demonHunterSoulFragments)
        self.state:registerState(self.eclipse)
        self.state:registerState(self.enemies)
        self.state:registerState(self.future)
        self.state:registerState(self.health)
        self.state:registerState(self.lossOfControl)
        self.state:registerState(self.power)
        self.state:registerState(self.stance)
        self.state:registerState(self.totem)
        self.state:registerState(self.variables)
        self.state:registerState(self.warlock)
        self.state:registerState(self.runes)
        self.state:registerState(combat)
        runeforge:registerConditions(self.condition)
        covenant:registerConditions(self.condition)
        combat:registerConditions(self.condition)
        soulbind:registerConditions(self.condition)
        self.warlock:registerConditions(self.condition)
        self.aura:registerConditions(self.condition)
        self.eclipse:registerConditions(self.condition)
        self.future:registerConditions(self.condition)
        self.paperDoll:registerConditions(self.condition)
        self.equipment:registerConditions(self.condition)
        self.azeriteArmor:registerConditions(self.condition)
        self.stagger:registerConditions(self.condition)
        self.stance:registerConditions(self.condition)
        self.spellActivationGlow:registerConditions(self.condition)
    end,
})

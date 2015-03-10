local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local x = s.UpdatedVariables

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local GetTotemInfo = GetTotemInfo
local UnitLevel = UnitLevel
local UnitSpellHaste = UnitSpellHaste

local ceil = math.ceil
local format = string.format
local max = math.max
local min = math.min
local select = select
local tconcat = table.concat
local tinsert = table.insert
local tostring = tostring
local unpack = unpack
local wipe = wipe

local rotation = nil
a.rotationName = '-'

a.LastRuneCast = 0

local function processCast(info)
   if c.InfoMatches(info, "Rune of Power") then
      a.LastRuneCast = GetTime()
      c.Debug("Event", "Rune of Power cast")
   end
end

a.Rotations = {}

function a.PreFlash()
   a.SpellHaste = 1 + UnitSpellHaste("player") / 100

   local mana = c.GetPower(select(2, GetPowerRegen()))
   a.ManaPercent = mana / s.MaxPower("player") * 100

   a.AlterTime = c.HasBuff("Alter Time", false, false, true)

   a.FloesStack = c.GetBuffStack("Ice Floes")
   if c.IsCasting("Ice Floes") then
      a.FloesStack = a.FloesStack + 1
   end

   a.Presence = c.HasBuff("Presence of Mind", false, false, true)

   if c.IsCasting(
      "Arcane Blast",
      "Arcane Missiles",
      "Flamestrike",
      "Frostfire Bolt",
      "Frostbolt")
   then
      a.FloesStack = a.FloesStack - 1
      a.Presence = false
   end

   a.HasPrismaticCrystal = c.HasTalent("Prismatic Crystal")

   -- prismatic crystal lives in the first totem slot
   local exists, _, _, duration = GetTotemInfo(1)
   if exists then
      a.PrismaticCrystal = true
      a.PrismaticCrystalRemains = duration
   else
      a.PrismaticCrystal = false
      a.PrismaticCrystalRemains = 0
   end

   local _, targetID = s.UnitInfo("target")
   -- 76933 is "Prismatic Crystal", FWIW.
   a.TargettingCrystal = (targetID == 76933)
end

------------------------------------------------------------------------ Arcane
local chargeStart = 0

local function bumpChargesAt(time)
   if time - chargeStart < 10 then
      a.ChargeStacks = min(4, a.ChargeStacks + 1)
   else
      a.ChargeStacks = 1
   end
   chargeStart = time
end

a.NetherTempests = {}

a.Rotations.Arcane = {
   Spec = 1,

   UsefulStats = { "Intellect", "Mastery", "Multistrike", "Haste", "Crit" },

   PreFlash = function()
      a.ChargeStacks = s.DebuffStack(c.GetID("Arcane Charge"), "player")
      chargeStart = GetTime()
         + s.DebuffDuration(c.GetID("Arcane Charge"), "player")
         - 10

      a.MissilesStacks = c.GetBuffStack("Arcane Missiles!")
      if c.IsQueued("Arcane Missiles") then
         a.MissilesStacks = a.MissilesStacks - 1
      end

      local info = c.GetCastingInfo()
      if info then
         if c.InfoMatches(info, "Arcane Blast", "Arcane Missiles") then
            bumpChargesAt(
               GetTime() + s.GetCastingOrChanneling(nil, "player"))
         elseif c.InfoMatches(info, "Arcane Barrage") then
            a.ChargeStacks = 0
         end
      end

      info = c.GetQueuedInfo()
      if info then
         if c.InfoMatches(info, "Arcane Blast", "Arcane Missiles") then
            bumpChargesAt(
               info.CastStart + s.CastTime(c.GetID("Arcane Blast")))
         elseif c.InfoMatches(info, "Arcane Barrage") then
            a.ChargeStacks = 0
         end
      end

      if a.ChargeStacks == 0 then
         a.ChargeDuration = 0
      else
         a.ChargeDuration = max(
            0, chargeStart + 10 - GetTime() - c.GetBusyTime())
         if a.ChargeDuration == 0 then
            a.ChargeStacks = 0
         end
      end

      a.ArcanePowerCD = c.GetCooldown("Arcane Power", false, 90)

      a.ArcanePower = c.HasBuff("Arcane Power", false, false, true)
      a.ArcanePowerDuration = c.GetBuffDuration("Arcane Power")
   end,

   RotationAoE = {
      -- # AoE sequence
      "Prismatic Crystal for Arcane",
      "Nether Tempest with 4 Arcane Charges",
      "Supernova",
      "Arcane Barrage with 4 Arcane Charges",
      "Arcane Orb",
      "Cone of Cold Glyphed",
      "Arcane Explosion"
   },

   -- High mana usage, "burn" sequence, also level < 80
   RotationBurn = {
      "Prismatic Crystal for Arcane",
      "Arcane Missiles with 3 Arcane Missiles",
      "Supernova High Priority",
      "Nether Tempest with 4 Arcane Charges",
      "Arcane Orb",
      "Supernova on Prismatic Crystal",
      "Presence of Mind >= 96",
      "Arcane Blast at 4 stacks",
      "Arcane Missiles with 4 Arcane Charges",
      "Supernova with mana < 96",
      -- # APL hack for evocation interrupt
      -- actions.burn+=/call_action_list,name=conserve,if=cooldown.evocation.duration-cooldown.evocation.remains<5
      -- actions.burn+=/evocation,interrupt_if=mana.pct>92,if=time_to_die>10&mana.pct<50
      "Evocation for Arcane",
      "Evocation Interrupt",
      "Presence of Mind",
      "Arcane Blast"
   },

   RotationConserve = {
      "Prismatic Crystal for Arcane",
      "Arcane Missiles with 3 Arcane Missiles",
      "Nether Tempest with 4 Arcane Charges",
      "Supernova High Priority",
      "Arcane Orb",
      "Presence of Mind >= 96",
      "Arcane Blast at 4 stacks",
      "Arcane Missiles with 4 Arcane Charges",
      "Supernova Low Priority",
      "Nether Tempest Early",
      "Arcane Barrage with 4 Arcane Charges",
      "Presence of Mind low priority",
      "Arcane Blast",
   },

   FlashInCombat = function()
      c.FlashAll(
         "Arcane Power",
         "Counterspell",
         -- blink,if=movement.distance>10
         -- blazing_speed,if=movement.remains>0
         -- ice_floes,if=buff.ice_floes.down&(raid_event.movement.distance>0|raid_event.movement.in<action.arcane_missiles.cast_time)
         "Cold Snap",
         "Spellsteal"
      )

      -- If we are less than level 80, there is no value to conserving mana,
      -- because that is tied to our mastery, which kicks in at 80...
      --
      -- time_to_die<mana.pct*0.35*spell_haste
      local burn = UnitLevel("player") < 80
         or c.GetCooldown("Evocation") <=
         (a.ManaPercent - 30) * (a.ArcanePower and 0.4 or 0.3) * a.SpellHaste

      -- c.Debug(
      --    "Event", burn and "burn" or "conserve", "selected:",
      --    format("%d <= [%d] (%d - 30)[%d] * (%s and 0.4 or 0.3)[%d] * %d",
      --           c.GetCooldown("Evocation"),
      --           (a.ManaPercent - 30) * (a.ArcanePower and 0.4 or 0.3) * a.SpellHaste,
      --           a.ManaPercent, (a.ManaPercent - 30),
      --           a.ArcanePower and "true" or "false", (a.ArcanePower and 0.4 or 0.3),
      --           a.SpellHaste
      --    )
      -- )

      -- Prismatic Crystal pre-init build, which is the conservative rotation
      -- until we have four stacks, but only if we have the talent.
      if a.HasPrismaticCrystal then
         burn = burn and c.GetCooldown("Prismatic Crystal") <= 0
      end

      if a.PrismaticCrystal then
         rotation = a.Rotations.Arcane.RotationBurn
         a.rotationName = 'B'
      elseif c.EstimatedHarmTargets >= 4 then
         rotation = a.Rotations.Arcane.RotationAoE
         a.rotationName = 'a'
      elseif burn then
         rotation = a.Rotations.Arcane.RotationBurn
         a.rotationName = 'b'
      else
         rotation = a.Rotations.Arcane.RotationConserve
         a.rotationName = 'c'
      end

      c.DelayPriorityFlash(
         "Cold Snap if health <= 30",
         "Rune of Power",
         "Mirror Image",
         "Cold Snap for Presence of Mind",
         -- must be the last line for this to work.
         unpack(rotation)
      )
   end,

   MovementFallthrough = function()
      c.PriorityFlash(
         "Ice Floes",
         "Arcane Barrage when Moving",
         "Fire Blast",
         "Ice Lance"
      )
   end,

   FlashOutOfCombat = function()
      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Evocation for Arcane",
            "Rune of Power",
            "Mirror Image",
            "Arcane Orb",
            "Arcane Blast"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Arcane Brilliance",
         "Dalaran Brilliance",
         "Ice Barrier"
      )
   end,

   LeftCombat = function()
      wipe(a.NetherTempests)
   end,

   CastSucceeded = processCast,

   AuraApplied = function(spellID, _, targetID)
      if spellID == c.GetID("Nether Tempest") then
         c.Debug("Event", s.SpellName(spellID), "applied to", targetID)
         a.NetherTempests[targetID] = GetTime()
      end
   end,

   AuraRemoved = function(spellID, _, targetID)
      if spellID == c.GetID("Nether Tempest") then
         c.Debug("Event", s.SpellName(spellID), "removed from", targetID)
         a.NetherTempests[targetID] = nil
      end
   end,

   ExtraDebugInfo = function()
      return format(
         "%s: m:%d c:%d/%.1f m:%.1f a:%s",
         a.rotationName or '-',
         a.MissilesStacks,
         a.ChargeStacks,
         a.ChargeDuration,
         a.ManaPercent,
         tostring(a.AlterTime)
      )
   end
}

-------------------------------------------------------------------------- Fire
local fireDebug = {}
local pendingNaturalCrit = false
local pendingBlast = false
local consumerLandedAt = 0
local affectsCritStreak = {
   [c.GetID("Combustion")] = true,
   [c.GetID("Fireball")] = "delay",
   [c.GetID("Frostfire Bolt")] = "delay",
--      [c.GetID("Inferno Blast")] = true,
   [c.GetID("Pyroblast")] = "delay",
   [c.GetID("Scorch")] = "delay",
}

local function applyFireProc()
   if a.HeatingProc then
      a.HeatingProc = false
      a.PyroProc = true
   else
      a.HeatingProc = true
   end
end

local pyroChain = false

local function pyroStacked(GCDs, fireball_in_flight)
   return a.combustionCD < c.LastGCD * GCDs
      and a.PyroProc
      and a.HeatingProc
      and (a.FireballInFlight or not fireball_in_flight)
end

a.Rotations.Fire = {
   Spec = 2,

   UsefulStats = { "Intellect", "Crit", "Mastery", "Multistrike", "Haste" },

   PreFlash = function()
      -- Manage Pyroblast! and Heating Up
      a.HeatingProc = c.HasBuff("Heating Up")
      a.PyroProc = c.HasBuff("Pyroblast!")

      wipe(fireDebug)
      tinsert(fireDebug, format("(%s, %s)",
                                a.HeatingProc and "|cffff8000heating|r" or "|cff9d9d9d--|r",
                                a.PyroProc and "|cffff8000pyro|r" or "|cff9d9d9d--|r"))
      if pendingBlast or c.IsCastingOrInAir("Inferno Blast") then
         tinsert(fireDebug, "pendingBlast")
         applyFireProc()
      end
      if pendingNaturalCrit then
         tinsert(fireDebug, "naturalCrit")
         applyFireProc()
      end
      if a.HeatingProc then
         local endDelay = c.GetBusyTime() - .01
         if GetTime() - consumerLandedAt < 1
            or c.CountLandings("Fireball", -3, endDelay, false) > 0
            or c.CountLandings("Pyroblast", -3, endDelay, false) > 0
            or c.CountLandings("Frostfire Bolt", -3, endDelay, false) > 0
            or c.CountLandings("Scorch", -3, endDelay, false) > 0
            or c.IsCastingOrInAir("Combustion")
         then
            tinsert(fireDebug, "landingDirties")
            a.HeatingProc = false

            --c.Debug("dirty", endDelay,
            --      GetTime() - consumerLandedAt < 1,
            --      c.CountLandings("Fireball", -3, endDelay, false),
            --      c.CountLandings("Pyroblast", -3, endDelay, false),
            --      c.CountLandings("Frostfire Bolt", -3, endDelay, false),
            --      c.CountLandings("Scorch", -3, endDelay, false),
            --      c.IsCastingOrInAir("Combustion")
            --)
         end
      end
      if a.PyroProc and c.IsCasting("Pyroblast") then
         tinsert(fireDebug, "pyroConsume")
         a.PyroProc = false
      end

      a.FireballInFlight = c.IsCastingOrInAir("Fireball")
      a.combustionCD = c.GetCooldown("Combustion")

      local final_state = format("(%s, %s)",
                                 a.HeatingProc and "|cffff8000heating|r" or "|cff9d9d9d--|r",
                                 a.PyroProc and "|cffff8000pyro|r" or "|cff9d9d9d--|r")
      if final_state ~= fireDebug[1] then
         tinsert(fireDebug, final_state)
      end
   end,

   RotationCombust = {
      "Prismatic Crystal for Fire",
      -- /blood_fury
      -- /berserking
      -- /arcane_torrent
      -- /potion,name=draenic_intellect
      "Meteor Unconditionally",
      "Pyroblast for T14 4PC",
      "Fireball for DoT",
      "Pyroblast with Pyroblast! or Pyromaniac",
      "Inferno Blast with Meteor",
      "Combustion"
   },

   RotationAoE = {
      "Rune of Power for Fire",
      "Mirror Image without Heating Up",
      -- actions.aoe=inferno_blast,cycle_targets=1,if=(dot.combustion.ticking&active_dot.combustion<active_enemies)|(dot.pyroblast.ticking&active_dot.pyroblast<active_enemies)
      -- simc "active talents" actions
      "Meteor",
      "Inferno Blast with Living Bomb",
      "Living Bomb",
      "Blast Wave",
      -- simc "active talents" ends
      "Pyroblast with Pyroblast! or Pyromaniac",
      "Pyroblast when down",
      "Cold Snap for Dragon's Breath",
      "Dragon's Breath if Glyphed",
      "Flamestrike"
   },

   RotationSingleTarget = {
      "Inferno Blast with Prismatic Crystal",
      "Pyroblast with Prismatic Crystal",
      "Rune of Power for Fire",
      "Mirror Image without Heating Up",
      -- "Inferno Blast to spread", @todo danielp 2014-12-20: implement this!
      "Pyroblast before expiration",
      "Pyroblast for T14 4PC",
      "Pyroblast when stacked",
      "Inferno Blast without Pyroblast!",
      -- simc "active talents" actions
      "Meteor",
      "Inferno Blast with Living Bomb",
      "Living Bomb",
      "Blast Wave",
      -- simc "active talents" ends
      "Inferno Blast with Pyroblast!",
      "Pyroblast when solo",
      "Fireball"
   },

   FlashInCombat = function()
      c.FlashAll(
         "Arcane Power",
         "Counterspell",
         -- blink,if=movement.distance>10
         -- blazing_speed,if=movement.remains>0
         "Cold Snap",
         "Spellsteal"
      )

      -- can we prep a combustion combo, by talent choice.
      if pyroChain then
         if (a.combustionCD - c.GetBuffDuration("Combustion")) < 15 then
            pyroChain = false
         end
      else
         local pyromaniac = c.HasBuff("Pyromaniac")
            and (a.combustionCD <
                    ceil(c.GetBuffDuration("Pyromaniac") / c.LastGCD) * c.LastGCD)

         if c.HasTalent("Meteor") then
            pyroChain = (c.GetCooldown("Meteor") <= 0) and (pyroStacked(3) or pyromaniac)
         elseif a.HasPrismaticCrystal then
            local prismaticCD = c.GetCooldown("Prismatic Crystal")

            pyroChain = (prismaticCD <= 0 and (pyroStacked(2) or pyromaniac))
               or (c.HasGlyph("Combustion")
                      and prismaticCD > 20
                      and (pyroStacked(2, true) or pyromaniac))
         else
            pyroChain = pyroStacked(4, true)
               or (pyromaniac and c.HasTalent("Kindling"))
         end
      end

      if pyroChain then
         rotation = a.Rotations.Fire.RotationCombust
      elseif c.EstimatedHarmTargets >= 4 and not a.PrismaticCrystal then
         -- prismatic crystal may be aoe, but we mostly single target the
         -- crystal during it, so it is handler in the ST rotation.
         rotation = a.Rotations.Fire.RotationAoE
      else
         rotation = a.Rotations.Fire.RotationSingleTarget
      end

      c.DelayPriorityFlash(
         "Rune of Power",
         unpack(rotation) -- must be last line.
      )
   end,

   MovementFallthrough = function()
      c.FlashAll(
         "Ice Floes",
         "Scorch"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll(
         "Rune of Power"
      )
   end,

   FlashAlways = function()
      c.FlashAll(
         "Arcane Brilliance",
         "Dalaran Brilliance",
         "Ice Barrier"
      )
   end,

   CastSucceeded = function(info)
      processCast(info)
      if c.InfoMatches(info, "Inferno Blast") then
         pendingBlast = true
         c.Debug("Event", "blast pending")
      end
   end,

   SpellMissed = function(spellID)
      if spellID == c.GetID("Inferno Blast") then
         pendingBlast = false
         c.Debug("Event", "blast missed")
      end
   end,

   SpellDamage = function(spellID, _, _, critical, isTick)
      if affectsCritStreak[spellID] and not isTick then
         if critical then
            pendingNaturalCrit = true
         else
            pendingNaturalCrit = false
            consumerLandedAt = GetTime()
         end
         c.Debug("Event", s.SpellName(spellID), "crit?:", critical)
      end
   end,

   AuraApplied = function(spellID)
      if spellID == c.GetID("Pyroblast!")
         or spellID == c.GetID("Heating Up") then

         pendingNaturalCrit = false
         pendingBlast = false
         consumerLandedAt = 0
         c.Debug("Event", s.SpellName(spellID), "applied")
      end
   end,

   AuraRemoved = function(spellID)
      if spellID == c.GetID("Pyroblast!")
         or spellID == c.GetID("Heating Up") then

         pendingNaturalCrit = false
         pendingBlast = false
         consumerLandedAt = 0
         c.Debug("Event", s.SpellName(spellID), "removed")
      end
   end,

   ExtraDebugInfo = function()
      return tconcat(fireDebug, "->")
   end
}

------------------------------------------------------------------------- Frost
a.FingerCount = c.GetBuffStack("Fingers of Frost")

a.frostBombActive = false

a.Rotations.Frost = {
   Spec = 3,
   AoEColor = "pink",

   UsefulStats = { "Intellect", "Multistrike", "Versatility", "Crit", "Mastery", "Haste" },

   PreFlash = function()
      local now = GetTime()

      if a.CombatStartTime then
         a.CombatTime = now - a.CombatStartTime
      else
         a.CombatTime = -1
      end

      if a.frostBombActive and (now - a.frostBombActive) > 12 then
         c.Debug("Event", "frost bomb passed expiration date without event")
         a.frostBombActive = false
      end

      a.BrainFreeze = c.HasBuff("Brain Freeze")
         and not c.IsCasting("Frostfire Bolt")

      a.VeinsCD = c.GetCooldown("Icy Veins")
   end,

   RotationSingleTarget = {
      "Ice Lance before FoF expiration",
      "Frostfire Bolt for Brain Freeze expiration",
      "Frost Bomb for Frozen Orb",
      "Frozen Orb",
      "Frost Bomb Single Target",
      "Ice Nova with 2 charges",
      "Ice Lance with 2 Fingers or Frozen Orb",
      "Comet Storm",
      "Ice Nova with 1 charge",
      "Frostfire Bolt with Brain Freeze",
      -- actions.single_target+=/ice_lance,if=set_bonus.tier17_4pc&talent.thermal_void.enabled&talent.mirror_image.enabled&dot.frozen_orb.ticking
      "Ice Lance with Frost Bomb",
      -- # Camp procs and spam Frostbolt while 4T17 buff is up
      -- actions.single_target+=/frostbolt,if=set_bonus.tier17_2pc&buff.ice_shard.up&!(talent.thermal_void.enabled&buff.icy_veins.up&buff.icy_veins.remains<10)
      "Ice Lance without Frost Bomb",
      "Water Jet",
      "Frostbolt"
   },

   RotationAoE = {
      "Frost Bomb AoE",
      "Frozen Orb",
      "Ice Lance with Frost Bomb",
      "Comet Storm",
      "Ice Nova with 1 charge",
      -- we will interrupt if anything higher prio comes off CD.
      "Blizzard"
   },

   RotationCrystal = {
      "Frost Bomb before Crystal",
      "Frozen Orb for Crystal",
      "Prismatic Crystal for Frost",
      "Frost Bomb on Crystal",
      "Ice Lance with 2 Fingers or Frozen Orb",
      "Ice Nova with 2 charges",
      "Frostfire Bolt with Brain Freeze",
      "Ice Lance on Crystal",
      "Ice Nova",
      "Blizzard on Crystal",
      "Frostbolt"
   },

   FlashInCombat = function()
      c.FlashAll(
         "Arcane Power",
         "Counterspell",
         -- blink,if=movement.distance>10
         -- blazing_speed,if=movement.remains>0
         "Cold Snap",
         "Spellsteal"
      )

      if a.PrismaticCrystal or c.GetCooldown("Prismatic Crystal", false, 90) <= c.LastGCD then
         rotation = a.Rotations.Frost.RotationCrystal
         a.rotationName = 'c'
      elseif c.EstimatedHarmTargets >= 4 then
         rotation = a.Rotations.Frost.RotationAoE
         a.rotationName = 'a'
      else
         rotation = a.Rotations.Frost.RotationSingleTarget
         a.rotationName = 's'
      end

      c.DelayPriorityFlash(
         "Frostbolt right after Water Jet",
         "Ice Lance with 2 Fingers and Water Jet",
         "Frostbolt during Water Jet",
         "Mirror Image",
         "Rune of Power",
         -- actions+=/rune_of_power,if=(cooldown.icy_veins.remains<gcd.max&buff.rune_of_power.remains<20)|(cooldown.prismatic_crystal.remains<gcd.max&buff.rune_of_power.remains<10)
         "Icy Veins",
         "Water Jet on pull",
         unpack(rotation)       -- must be last line!
      )
   end,

   MovementFallthrough = function()
      c.DelayPriorityFlash(
         "Ice Floes",
         "Ice Lance",
         "Fire Blast"
      )
   end,

   FlashOutOfCombat = function()
      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Rune of Power",
            "Mirror Image",
            "Frostfire Bolt with Brain Freeze",
            "Frostbolt"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Summon Water Elemental",
         "Arcane Brilliance",
         "Dalaran Brilliance",
         "Ice Barrier"
      )
   end,

   EnteredCombat = function()
      a.CombatStartTime = GetTime()
   end,

   LeftCombat = function()
      a.CombatStartTime = nil
   end,

   CastQueued = function(info)
      if c.InfoMatches(info, "Water Jet") then
         a.castWaterJet = true
      end
   end,

   CastFailed = function(info)
      if c.InfoMatches(info, "Water Jet") then
         a.castWaterJet = false
      end
   end,

   CastSucceeded = function(info)
      processCast(info)
      if not c.InfoMatches(info, "Water Jet") then
         a.castWaterJet = false
      end
   end,

   AuraApplied = function(spellID)
      if spellID == c.GetID("Fingers of Frost") then
         a.FingerCount = c.GetBuffStack("Fingers of Frost")
         c.Debug("Event", "Gained FoF. Stack =", a.FingerCount)
      elseif spellID == c.GetID("Frost Bomb") then
         a.frostBombActive = GetTime()
         c.Debug("Event", "Frost Bomb applied to new target")
      end
   end,

   AuraRemoved = function(spellID)
      if spellID == c.GetID("Fingers of Frost") then
         a.FingerCount = c.GetBuffStack("Fingers of Frost")
         c.Debug("Event", "Lost FoF. Stack =", a.FingerCount)
      elseif spellID == c.GetID("Frost Bomb") then
         a.frostBombActive = false
         c.Debug("Event", "Frost Bomb removed")
      end
   end,

   ExtraDebugInfo = function()
      return format(
         "%s: f:%d h:%s f:%d b:%s a:%s wj:%s",
         a.rotationName or '-',
         a.FingerCount,
         tostring(a.HoldProcs),
         a.FBStacks,
         tostring(a.BrainFreeze),
         tostring(a.AlterTime),
         tostring(a.castWaterJet)
      )
   end
}

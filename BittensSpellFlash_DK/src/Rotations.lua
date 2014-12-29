local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetRuneCooldown = GetRuneCooldown
local GetRuneType = GetRuneType
local GetTime = GetTime
local OffhandHasWeapon = OffhandHasWeapon
local UnitGUID = UnitGUID
local UnitIsUnit = UnitIsUnit

local SPELL_POWER_RUNIC_POWER = SPELL_POWER_RUNIC_POWER

local math = math
local select = select
local string = string
local tostring = tostring
local strsub = strsub

local rpBumped = 0
local rpBumpExpires = 0
local suppressKM = false
a.Runes = {
   {Delay = 0, Type = "blood",  BaseType = "blood"},
   {Delay = 0, Type = "blood",  BaseType = "blood"},
   {Delay = 0, Type = "unholy", BaseType = "unholy"},
   {Delay = 0, Type = "unholy", BaseType = "unholy"},
   {Delay = 0, Type = "frost",  BaseType = "frost"},
   {Delay = 0, Type = "frost",  BaseType = "frost"},
}
a.PendingDeathRunes = 0
a.Rotations = { }

local function getBump(name, freezingFog, crimsonScourge)
   local cost = a.Costs[name]
   if cost == nil then
      return 0
   end

   local bump = cost.BonusRP or 0
   if (not cost.Rime or freezingFog == 0)
      and (name ~= s.SpellName(c.GetID("Blood Boil"))
         or not crimsonScourge) then

      bump = bump + math.max(0, 10 * (cost.Blood + cost.Frost + cost.Unholy))
   end
   if c.HasBuff("Frost Presence") then
      bump = bump * 1.2
   end
   return bump
end

local function consumeRune(runeID, needed, forbidDeath)
   if needed == 0 or (forbidDeath and a.Runes[runeID].Type == "death") then
      return needed
   end

   local start, duration = GetRuneCooldown(runeID)
   if start + duration < GetTime() then
      a.Runes[runeID].Delay = 100
      a.Runes[runeID].Type = a.Runes[runeID].BaseType
      return needed - 1
   else
      return needed
   end
end

local function consumesKM(info)
   return c.InfoMatches(info, "Obliterate", "Frost Strike")
end

local function adjustResourcesForSuccessfulCast(info)
   if c.InfoMatches(info, "Blood Boil") then
      return -- Blood Boil's RP return is before the cast succeeds
   end

   local cost = s.SpellCost(info.Name, SPELL_POWER_RUNIC_POWER)
   if cost == 0 then
      local bump = getBump(
         info.Name,
         s.BuffStack(c.GetID("Freezing Fog"), "player"),
         s.Buff(c.GetID("Crimson Scourge"), "player"))
      if bump > 0 then
         rpBumped = s.Power("player") + bump
         rpBumpExpires = GetTime() + .8
      end
--c.Debug("Resources", info.Name, "bump", bump, "->", rpBumped)
   elseif GetTime() < rpBumpExpires then
      rpBumped = rpBumped - cost
   end
end

local function getGenericDebugInfo()
   return string.format(
      "b:%.1f r:%d %s:%.1f %s:%.1f %s:%.1f %s:%.1f %s:%.1f %s:%.1f d:%d b:%d c:%s",
      c.GetBusyTime(),
      a.RP,
      strsub(a.Runes[1].Type, 1, 1),
      math.max(0, math.min(9.9, a.Runes[1].Delay)),
      strsub(a.Runes[2].Type, 1, 1),
      math.max(0, math.min(9.9, a.Runes[2].Delay)),
      strsub(a.Runes[3].Type, 1, 1),
      math.max(0, math.min(9.9, a.Runes[3].Delay)),
      strsub(a.Runes[4].Type, 1, 1),
      math.max(0, math.min(9.9, a.Runes[4].Delay)),
      strsub(a.Runes[5].Type, 1, 1),
      math.max(0, math.min(9.9, a.Runes[5].Delay)),
      strsub(a.Runes[6].Type, 1, 1),
      math.max(0, math.min(9.9, a.Runes[6].Delay)),
      a.PendingDeathRunes,
      a.BloodCharges,
      tostring(a.CrimsonScourge))
end

local function flashInterrupts()
   if c.FlashAll("Mind Freeze") then
      return
   end
   if c.HasSpell("Asphyxiate") then
      c.FlashAll("Asphyxiate")
   else
      c.FlashAll("Strangulate")
   end
end

function a.PreFlash()
   -- grab RP
   a.RP = s.Power("player")
   if rpBumpExpires > 0 then
      if a.RP < rpBumped and GetTime() < rpBumpExpires then
         a.RP = rpBumped
      else
         rpBumped = 0
         rpBumpExpires = 0
      end
   end

   -- grab rune state
   local busyTime = c.GetBusyTime()
   local now = GetTime()
   for i = 1, 6 do
      local rune = a.Runes[i]
      local start, duration, ready = GetRuneCooldown(i)

      -- @todo danielp 2014-11-29: ticket 200 reported a bug where start was
      -- nil, on a level 58 DK, during zoning, and I can't reproduce it.
      --
      -- extra debugging output, and work around it by just *assuming* that it
      -- is ready if we didn't get any cooldown data.
      if start == nil and not a.printedNilRuneDebug then
         a.printedNilRuneDebug = true
         print(format("please file a ticket and report that rune cooldown %d is nil: %s, %s, %s", i, start, duration, ready))
      end

      if (start or 0) == 0 then -- rune is ready to use
         rune.Delay = 0
      else
         rune.Delay = start + duration - now - busyTime
      end

      rune.Type = (GetRuneType(i) == 4) and "death" or rune.BaseType
   end

   -- grab KM
   a.KillingMachine = not suppressKM and c.HasBuff("Killing Machine")

   -- grab Freezing Fog
   a.FreezingFog = c.GetBuffStack("Freezing Fog")

   -- grab Crimson Scourge
   a.CrimsonScourge = c.HasBuff("Crimson Scourge")

   -- grab Blood Charge
   a.BloodCharges = c.GetBuffStack("Blood Charge")
   if c.IsCasting("Blood Tap") then
      a.BloodCharges = a.BloodCharges - 5
   end
   -- handle RP to Blood Charge conversion.

   -- @todo eric 2014-10-31: This will not conside queued spells (spells
   -- which have been
   -- sent to the server, but not yet cast).  You probably *only* need
   -- to consider queued spells anyway, since DK's don't have a cast time
   -- leading up to spell cost.  c.GetQueuedInfo()
   -- I might experiment with their current RP - c.GetPower(), which
   -- handles looping through queued & casting spells.
   local info = c.GetCastingInfo()
   if info then
      local cost = s.SpellCost(info.Name, SPELL_POWER_RUNIC_POWER)
      if cost > 0 then
         -- we generate one blood charge per 15 RP
         a.BloodCharges = a.BloodCharges + (cost / 15)
      end
   end

   -- adjust resources for queued spell
   local info = c.GetQueuedInfo()
   a.PendingDeathRunes = 0
   if info then
      -- only get RP cost, not rune cost, of things.
      local cost = s.SpellCost(info.Name, SPELL_POWER_RUNIC_POWER)
      if cost > 0 then
         a.RP = a.RP - cost
      else
         a.RP = a.RP + getBump(info.Name, a.FreezingFog, a.CrimsonScourge)
      end
      if c.IsQueued("Empower Rune Weapon") then
         for i = 1, 6 do
            a.Runes[i].Delay = 0
         end
      else
         if c.IsQueued("Blood Tap") then
            a.PendingDeathRunes = a.PendingDeathRunes + 1
         end
         if c.IsQueued("Plague Leech") then
            a.PendingDeathRunes = a.PendingDeathRunes + 2
         end
      end
      local cost = a.Costs[info.Name]
      if s.Buff(c.GetID("Crimson Scourge"), "player")
         and c.InfoMatches(info, "Blood Boil", "Death and Decay") then

         a.CrimsonScourge = false
      elseif cost then
         local blood = cost.Blood
         local frost = cost.Rime and a.FreezingFog > 0 and 0 or cost.Frost
         local unholy = cost.Unholy

         -- consume colored runes
         blood = consumeRune(1, blood, true)
         blood = consumeRune(2, blood, true)
         frost = consumeRune(5, frost, true)
         frost = consumeRune(6, frost, true)
         unholy = consumeRune(3, unholy, true)
         unholy = consumeRune(4, unholy, true)

         -- consume matching-color death runes
         blood = consumeRune(1, blood)
         blood = consumeRune(2, blood)
         frost = consumeRune(5, frost)
         frost = consumeRune(6, frost)
         unholy = consumeRune(3, unholy)
         unholy = consumeRune(4, unholy)

         -- consume death runes indiscriminately
         local death = cost.Death + blood + frost + unholy
         death = consumeRune(1, death)
         death = consumeRune(2, death)
         death = consumeRune(5, death)
         death = consumeRune(6, death)
         death = consumeRune(3, death)
         death = consumeRune(4, death)
         a.PendingDeathRunes = a.PendingDeathRunes - death
      end
      if consumesKM(info) then
         a.KillingMachine = false
      end
      if a.FreezingFog > 0
         and c.IsQueued("Howling Blast", "Icy Touch") then

         a.FreezingFog = a.FreezingFog - 1
      end
   end

   if c.HasSpell("Improved Soul Reaper") or c.WearingSet(4, "DpsT15") then
      a.InExecute = s.HealthPercent() < 45
   else
      a.InExecute = s.HealthPercent() < 35
   end
end

------------------------------------------------------------------------- Blood
a.BloodPlagueRefreshPending = 0

a.Rotations.Blood = {
   Spec = 1,

   UsefulStats = {
      "Stamina", "Strength", "Multistrike", "Haste"
   },

   FlashInCombat = function()
      a.SetCost(1, 0, 0, 0, "Soul Reaper - Blood")
      flashInterrupts()
      c.FlashAll(
         "Dark Command",
         "Death Grip",
         "Conversion Cancel",
         "Horn of Winter for Buff, Optional")
      c.FlashMitigationBuffs(
         2,
         "Anti-Magic Shell",
         c.COMMON_TANKING_BUFFS,
         "Death Pact",
         "Dancing Rune Weapon Prime",
         "Bone Shield",
         "Rune Tap with more than one charge",
         "Vampiric Blood",
         "Dancing Rune Weapon",
         "Icebound Fortitude Glyphed",
         "Conversion",
         "Icebound Fortitude Unglyphed",
         "Rune Tap"
      )


      c.DelayPriorityFlash(
         -- not being dead
         "Death Strike for Health",
         "Death Strike to Save Shield",
         "Blood Tap for Death Strike",
         "Plague Leech for Death Strike",
         "Empower Rune Weapon for Death Strike",
         "Death Siphon for Health",
         -- diseases
         "Outbreak",
         "Death Coil 1 Rune to cap",
         "Blood Boil for diseases",
         -- DPS and stuff
         "Defile",
         "Death Coil 2 Runes to cap",
         "Death Strike if Two Available",
         "Death Coil 1 Rune to cap",
         -- ensure we SR on cooldown if possible, then BB, with
         -- all of our B runes, but not with our D runes.
         "Soul Reaper - Blood B",
         "Blood Boil BB",
         "Blood Boil B, if safe",
         "Death and Decay Free",
         "Blood Boil Free",
         -- ensure we don't cap BT
         "Blood Tap at 11",
         "Plague Leech if Outbreak",
         "Outbreak Early, Glyphed",
         "Death Coil",
         "Outbreak Early",
         "Empower Rune Weapon"
      )
   end,

   FlashOutOfCombat = function()
      c.FlashAll("Bone Shield")
   end,

   FlashAlways = function()
      c.FlashAll("Blood Presence")
   end,

   CastSucceeded = function(info)
      adjustResourcesForSuccessfulCast(info)
      if c.InfoMatches(info, "Blood Boil")
         and s.MyDebuff(c.GetID("Blood Plague")) then

         a.BloodPlagueRefreshPending = GetTime()
         c.Debug("Event", "Blood Plague refresh pending")
      end
   end,

   SpellMissed = function(spellID, _, targetID)
      if c.IdMatches(spellID, "Blood Boil") then
         if targetID == UnitGUID("target") then
            a.BloodPlagueRefreshPending = 0
            c.Debug("Event", "Blood Plague refresh missed")
         end
      end
   end,

   AuraApplied = function(spellID, _, targetID)
      if spellID == c.GetID("Blood Plague") then
         if targetID == UnitGUID("target") then
            a.BloodPlagueRefreshPending = 0
            c.Debug("Event", "Blood Plague applied")
         end
      elseif spellID == c.GetID("Scent of Blood") then
         c.Debug("Event", "Scent of Blood")
      end
   end,

   ExtraDebugInfo = getGenericDebugInfo,
}

------------------------------------------------------------------------- Frost
a.Rotations.Frost = {
   Spec = 2,

   UsefulStats = { "Strength", "Crit", "Haste", "Multistrike" },

   FlashInCombat = function()
      a.SetCost(0, 1, 0, 0, "Soul Reaper - Frost")
      flashInterrupts()
      c.FlashAll(
         "Pillar of Frost",
         "Death Strike with Dark Succor",
         "Death Siphon",
         "Horn of Winter for Buff, Optional")

      -- c.Debug("aoe", "harm", c.EstimatedHarmTargets, "heal", c.EstimatedHealTargets)

      local flashing
      if c.EstimatedHarmTargets >= 3 then
         flashing = c.DelayPriorityFlash(
            "Unholy Blight",
            "Blood Boil for diseases",
            "Defile",
            -- /breath_of_sindragosa,if=runic_power>75
            -- /run_action_list,name=bos_aoe,if=dot.breath_of_sindragosa.ticking
            "Frost Strike for HB cap",
            "Howling Blast",
            "Blood Tap at 11",
            "Death and Decay U",
            "Plague Strike UU",
            "Blood Tap",
            "Plague Leech",
            "Frost Strike",
            "Plague Strike U",
            "Empower Rune Weapon"
         )
      elseif OffhandHasWeapon() then
         flashing = c.DelayPriorityFlash(
            "Soul Reaper - Frost",
            "Blood Tap for Soul Reaper - Frost",
            -- /breath_of_sindragosa,if=runic_power>75
            -- /run_action_list,name=bos_st,if=dot.breath_of_sindragosa.ticking
            "Defile",
            "Blood Tap for Defile",
            -- /howling_blast,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<7&runic_power<88
            -- /obliterate,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<3&runic_power<76
            "Frost Strike under KM",
            "Unholy Blight",
            "Howling Blast for Frost Fever",
            "Howling Blast under Freezing Fog",
            "Blood Tap at 8 or Non-Execute",
            "Death and Decay U, optional",
            "Frost Strike for PS cap",
            "Plague Strike for Blood Plague",
            "Frost Strike for Oblit cap no KM",
            "Obliterate U w/out KM",
            "Frost Strike for HB cap",
            "Howling Blast",
            "Blood Tap",
            "Plague Leech",
            "Frost Strike for PS cap",
            "Frost Strike when not pooling",
            "Plague Strike U",
            "Empower Rune Weapon")
      else -- 2H frost
         flashing = c.PriorityFlash(
            "Plague Leech at 1",
            "Soul Reaper - Frost",
            "Blood Tap for Soul Reaper - Frost",
            "Defile",
            "Blood Tap for Defile",
            "Obliterate under KM",
            "Blood Tap for OB KM",
            "Outbreak",
            "Unholy Blight",
            -- /breath_of_sindragosa,if=runic_power>75
            -- /run_action_list,name=bos_st,if=dot.breath_of_sindragosa.ticking
            -- /obliterate,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<7&runic_power<76
            -- /howling_blast,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<3&runic_power<88
            "Howling Blast under Freezing Fog",
            "Howling Blast for Frost Fever",
            "Plague Strike for Blood Plague",
            "Frost Strike for OB cap",
            "Obliterate BB or FF or UU",
            "Plague Leech at 3",
            "Frost Strike for RE",
            "Frost Strike for BT",
            "Outbreak at 3",
            "Unholy Blight at 3",
            "Obliterate",
            "Blood Tap at 11",
            "Frost Strike",
            "Plague Leech",
            "Empower Rune Weapon")
      end
      --c.Debug("FS", "selected", flashing)
      if flashing then
         local id = c.GetSpell(flashing).ID
         if id == c.GetID("Frost Strike") then
            c.FlashAll("Blood Tap at 11")
         end
      end
   end,

   FlashAlways = function()
      c.FlashAll("Frost Presence")
   end,

   CastSucceeded = function(info)
      adjustResourcesForSuccessfulCast(info)
      if s.Buff(c.GetID("Killing Machine"), "player")
         and consumesKM(info) then

         suppressKM = true
         c.Debug("Event", info.Name, "to consume KM")
      end
   end,

   AuraApplied = function(spellID)
      if spellID == c.GetID("Killing Machine") then
         suppressKM = false
         c.Debug("Event", "New KM")
      end
   end,

   AuraRemoved = function(spellID)
      if spellID == c.GetID("Killing Machine") then
         suppressKM = false
         c.Debug("Event", "KM is really gone")
      end
   end,

   ExtraDebugInfo = function()
      local rotation = c.EstimatedHarmTargets >= 3 and 'A'
         or OffhandHasWeapon() and 'D'
         or '2'

      return string.format("%s k:%s f:%d R:%s",
         getGenericDebugInfo(),
         tostring(a.KillingMachine),
         a.FreezingFog,
         rotation)
   end,
}

------------------------------------------------------------------------ Unholy
--a.LastPestilence = 0
a.DTCast = 0

a.Rotations.Unholy = {
   Spec = 3,

   UsefulStats = {
      "Strength", "Multistrike", "Crit", "Versatility", "Haste"
   },

   FlashInCombat = function()
      a.SetCost(0, 0, 1, 0, "Soul Reaper - Unholy")
      flashInterrupts()

      c.FlashAll(
         "Death Strike with Dark Succor",
         "Death Siphon",
         "Horn of Winter for Buff, Optional"
      )

      if c.EstimatedHarmTargets < 2 then
         c.DelayPriorityFlash(
            "Plague Leech if Outbreak",
            "Plague Leech at 2",
            "Blood Tap for Soul Reaper - Unholy",
            "Soul Reaper - Unholy",
            "Summon Gargoyle",
            "Death Coil 1 Rune to cap",
            "Defile",
            "Blood Tap for Dark Transformation",
            "Dark Transformation",
            "Unholy Blight for Unholy",
            "Outbreak",
            "Plague Strike for Diseases",
            -- breath_of_sindragosa,if=runic_power>75
            -- run_action_list,name=bos_st,if=dot.breath_of_sindragosa.ticking
            -- death_and_decay,if=cooldown.breath_of_sindragosa.remains<7&runic_power<88&talent.breath_of_sindragosa.enabled
            -- scourge_strike,if=cooldown.breath_of_sindragosa.remains<7&runic_power<88&talent.breath_of_sindragosa.enabled
            -- festering_strike,if=cooldown.breath_of_sindragosa.remains<7&runic_power<76&talent.breath_of_sindragosa.enabled
            "Death and Decay UU",
            "Blood Tap for D&D UU",
            "Scourge Strike UU",
            "Death Coil 1 Rune to cap",
            "Festering Strike BBFF",
            "Death and Decay",
            "Blood Tap for D&D",
            "Blood Tap for DC cap",
            -- blood_tap,if=buff.blood_charge.stack>10&(buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1))
            "Death Coil under Sudden Doom or for Dark Transformation",
            "Scourge Strike",
            "Festering Strike",
            "Blood Tap at 10 with 30 RP",
            -- "Death Coil",
            "Empower Rune Weapon"
         )
      else -- AoE rotation
         c.DelayPriorityFlash(
            "Unholy Blight unconditionally",
            -- @todo danielp 2014-11-29: BB to spread infection, if any target
            -- has no diseases, and something does have them up.
            -- This requires much more sophisticated target tracking than I
            -- have built so far.
            "Outbreak",
            "Plague Strike for Diseases",
            "Defile",
            -- breath_of_sindragosa,if=runic_power>75
            -- run_action_list,name=bos_aoe,if=dot.breath_of_sindragosa.ticking
            "Blood Boil BB",
            "Blood Boil FFDD",
            "Summon Gargoyle",
            "Blood Tap for Dark Transformation",
            "Dark Transformation",
            "Death and Decay U",
            "Blood Tap for Soul Reaper - Unholy",
            "Soul Reaper - Unholy",
            "Scourge Strike UU",
            "Blood Tap at 10",
            "Death Coil 1 Rune to cap",
            "Death Coil under Sudden Doom or for Dark Transformation",
            "Blood Boil",
            "Icy Touch",
            "Scourge Strike one unholy only",
            "Plague Leech",
            "Empower Rune Weapon"
         )
      end
   end,

   FlashOutOfCombat = function()
      if x.EnemyDetected then
         c.DelayPriorityFlash(
            "Dark Transformation",
            "Defile",
            "Outbreak",
            "Plague Strike"
         )
      end
   end,

   FlashAlways = function()
      c.FlashAll(
         "Unholy Presence",
         "Raise Dead"
      )
   end,

   CastSucceeded = function(info)
      adjustResourcesForSuccessfulCast(info)
      if c.InfoMatches(info, "Death Coil") then
         a.ShadowInfusionPending = true
         c.Debug("Event", "Shadow Infusion pending")
--         elseif c.InfoMatches(info, "Pestilence") then
--            a.LastPestilence = GetTime()
--            c.Debug("Event", "Pestilence cast")
      elseif c.InfoMatches(info, "Dark Transformation") then
         a.DTCast = GetTime()
         c.Debug("Event", "Dark Transformation Cast")
      end
   end,

   SpellMissed = function(spellID)
      if spellID == c.GetID("Death Coil") then
         a.ShadowInfusionPending = false
         c.Debug("Event", "Death Coil missed")
      end
   end,

   AuraApplied = function(spellID, target)
      if spellID == c.GetID("Shadow Infusion")
         and UnitIsUnit(target, "pet") then

         a.ShadowInfusionPending = false
         c.Debug("Event", "Shadow Infusion connected", target)
      end
   end,

--      LeftCombat = function()
--         a.LastPestilence = 0
--         c.Debug("Event", "Left combat")
--      end,

   ExtraDebugInfo = function()
      return string.format("%s i:%d i:%s",
         getGenericDebugInfo(),
         s.BuffStack(c.GetID("Shadow Infusion"), "pet"),
         tostring(a.ShadowInfusionPending))
   end,
}

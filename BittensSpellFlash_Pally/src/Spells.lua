local _, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetSpellBonusDamage = GetSpellBonusDamage
local UnitCreatureType = UnitCreatureType
local UnitLevel = UnitLevel

local max = math.max
local min = math.min

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Blessing of Kings", nil, { NoRangeCheck = 1 })
c.AddOptionalSpell("Blessing of Might", nil, { NoRangeCheck = 1 })

c.AddSpell("Judgment", nil, {
   GetDelay = function()
      return a.Judgment
   end,
})

c.AddSpell("Judgment", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return a.Judgment, .35
   end
})

c.AddSpell("Crusader Strike", nil, {
   GetDelay = function()
      return a.Crusader
   end,
})

c.AddSpell("Crusader Strike", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return a.Crusader, .35
   end,
})

c.AddOptionalSpell("Lay on Hands", nil, {
   FlashColor = "red",
   NoRangeCheck = true,
   CheckFirst = function()
      return c.GetHealthPercent("player") < 20
         and not s.Debuff(c.GetID("Forebearance"), "player")
   end
})

c.AddInterrupt("Rebuke")

-- our fun seal-twisting situations.
c.AddSpell("Seal of Truth", "for Maraad's Truth", {
   Type = "form",
   GetDelay = function()
      if not c.HasTalent("Empowered Seals") or c.Form("Seal of Truth") then
         return false
      end

      local buff = c.GetBuffDuration("Maraad's Truth")
      if buff > 3 then
         return false
      end

      local judge = c.GetCooldown("Judgment", true, 6)
      if buff < judge then
         return judge
      else
         return false
      end
   end
})

c.AddSpell("Seal of Righteousness", "for Liadrin's Righteousness", {
   Type = "form",
   GetDelay = function()
      if not c.HasTalent("Empowered Seals") or c.Form("Seal of Righteousness") then
         return false
      end

      local buff = c.GetBuffDuration("Liadrin's Righteousness")
      if buff > 3 then
         return false
      end

      local judge = c.GetCooldown("Judgment", true, 6)
      if buff < judge then
         return judge
      else
         return false
      end
   end
})

c.AddSpell("Seal of Insight", "for Uther's Insight", {
   Type = "form",
   GetDelay = function()
      if not c.HasTalent("Empowered Seals") or c.Form("Seal of Insight") then
         return false
      end

      local buff = c.GetBuffDuration("Uther's Insight")
      if buff > 3 then
         return false
      end

      local judge = c.GetCooldown("Judgment", true, 6)
      if buff < judge then
         return judge
      else
         return false
      end
   end
})



-------------------------------------------------------------------------- Holy
local function hpCheckFirst(z)
   if a.HolyPower < 3 then
      return false
   end

   local dp = c.GetBuffDuration("Divine Purpose")
   if dp > 0 and dp < 2.5 then
      z.FlashSize = nil
      z.FlashColor = "red"
      return true
   end

   z.FlashColor = "yellow"
   if a.HolyPower < 5 then
      z.FlashSize = s.FlashSizePercent() / 2
   else
      z.FlashSize = nil
   end
   return true
end

c.AddOptionalSpell("Seal of Insight", nil, {
   Type = "form",
})

c.AddOptionalSpell("Word of Glory", "for Holy", {
   Override = hpCheckFirst,
})

c.AddOptionalSpell("Light of Dawn", "for Holy", {
   Override = hpCheckFirst,
})

c.AddOptionalSpell("Holy Shock", "under 5 with Daybreak", {
   NoRangeCheck = true,
   CheckFirst = function(z)
      local stack = c.GetBuffStack("Daybreak")
      if stack < 2 and c.IsCasting("Holy Radiance") then
         stack = stack + 1
      end
      c.MakeMini(z, stack == 1)
      return stack > 0 and a.HolyPower < 5
   end
})

c.AddOptionalSpell("Beacon of Light", nil, {
   Override = function()
      return s.InRaidOrParty()
         and not s.MyBuff(c.GetID("Beacon of Light"), a.BeaconTarget)
   end
})

c.AddOptionalSpell("Sacred Shield", "for Holy", {
   NoRangeCheck = true,
   CheckFirst = function()
      return not s.MyBuff(c.GetID("Sacred Shield"), a.SacredShieldTarget)
   end
})

c.AddOptionalSpell("Consume Selfless Healer", nil, {
   ID = "Holy Radiance",
   FlashID = { "Holy Radiance" },
   NoRangeCheck = true,
   CheckFirst = function()
      return a.SelflessHealer == 3
   end
})

c.AddOptionalSpell("Save Selfless Healer", nil, {
   ID = "Judgment",
   FlashID = { "Judgment", "Holy Radiance" },
   NoRangeCheck = true,
   FlashColor = "red",
   CheckFirst = function()
      local duration = c.GetBuffDuration("Selfless Healer")
      return duration > 0 and duration < 2.5
   end
})

-------------------------------------------------------------------- Protection
c.AddOptionalSpell("Seal of Insight", "for Prot", {
   Type = "form",
})

c.AddOptionalSpell("Righteous Fury", nil, {
   NoGCD = true,
   Buff = "Righteous Fury",
   BuffUnit = "player",
})

c.AddOptionalSpell("Eternal Flame", nil, {
   FlashID = { "Eternal Flame", "Word of Glory" },
   MyBuff = "Eternal Flame",
   BuffUnit = "player",
   Cooldown = 1,
   CheckFirst = function()
      local hp = max(3, a.BastionOfPower and 3 or a.HolyPower)
      if a.HolyPower <= 0 or hp <= 0 then -- can't cast, so don't even bother
         return false
      end

      local existing = c.GetBuffDuration("Eternal Flame")
      local health = c.GetHealthPercent("player")
      local bog = c.GetBuffStack("Bastion of Glory")

      if existing > 9 then
         return health < 50
      elseif existing > 0 then
         if hp > a.EternalFlameStrength.hp then
            return true
         elseif hp == a.EternalFlameStrength.hp then
            return bog >= a.EternalFlameStrength.bog
         else
            return health < 75
         end
      else
         return (hp == 1 and health < 45)
            or (hp == 2 and health < 60)
            or (hp >= 3 and (bog >= 3 or health < 75))
      end
   end,
})

c.AddOptionalSpell("Word of Glory", "for Prot", {
   Override = function(z)
      if c.WearingSet(2, "ProtT15")
         and c.GetBuffDuration("Shield of Glory") < 3 then

         z.FlashColor = "red"
      else
         z.FlashColor = "yellow"
      end
      return a.HolyPower > 0
         and c.GetCooldown(z.ID, true, 1.5) == 0
         and 95 - c.GetHealthPercent("player")
            > min(3, a.HolyPower)
               * 4
               * (1 + .1 * c.GetBuffStack("Bastion of Glory", true))
   end
})

c.AddOptionalSpell("Hand of Purity", nil, {
   NoRangeCheck = true,
   CheckFirst = function()
      return not c.InDamageMode()
   end,
})

c.AddOptionalSpell("Divine Protection", "Glyphed", {
   NoGCD = true,
   CheckFirst = function()
      return c.HasGlyph("Divine Protection")
   end,
   ShouldHold = function()
      return c.HasBuff("Seraphim") or c.GetCooldown("Seraphim", false, 30) <= 5
   end,
})

c.AddOptionalSpell("Light's Hammer", "for Prot", {
   IsUp = function()
      return c.GetCooldown("Light's Hammer", false, 60) > 46
   end,
   ShouldHold = function()
      return c.GetHealthPercent() < 85
   end,
})

c.AddOptionalSpell("Guardian of Ancient Kings", nil, {
   NoGCD = true,
   NoRangeCheck = true,
})

c.AddOptionalSpell("Ardent Defender", nil, {
   NoGCD = true,
   Enabled = function()
      return not c.WearingSet(2, "ProtT14")
   end
})

c.AddOptionalSpell("Ardent Defender", "2pT14", {
   NoGCD = true,
   Enabled = function()
      return c.WearingSet(2, "ProtT14")
   end
})

c.AddOptionalSpell("Shield of the Righteous", nil, {
   NoGCD = true,
   Melee = true,
   Buff = "Shield of the Righteous",
   EarlyRefresh = 0.35,
   CheckFirst = function()
      return a.HolyPower >= 3
   end,
})

c.AddOptionalSpell("Shield of the Righteous", "with Divine Purpose", {
   NoGCD = true,
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.DivinePurpose
   end,
})

c.MakePredictor(c.AddOptionalSpell("Shield of the Righteous", "Predictor"))

c.AddOptionalSpell("Shield of the Righteous", "to save Buffs", {
   NoGCD = true,
   Melee = true,
   Override = function()
      if a.HolyPower < 3 then
         return false
      end

      local duration = c.GetBuffDuration("Bastion of Glory")
      if duration > 0 and duration < 1.6 then
         return true
      end

      duration = c.GetBuffDuration("Divine Purpose")
      if duration > 0 and duration < 1.6 then
         return true
      end
   end
})

c.AddSpell("Holy Wrath", nil, {
   Melee = true,
   NoRangeCheck = true,
   Cooldown = 9,
})

c.AddSpell("Holy Wrath", "with Sanctified Wrath", {
   Melee = true,
   NoRangeCheck = true,
   Cooldown = 9,
   CheckFirst = function()
      return
         -- might be broader than needed, but whatevs.
         c.HasTalent("Sanctified Wrath - Prot") or
         c.HasTalent("Sanctified Wrath - Ret") or
         c.HasTalent("Sanctified Wrath - Holy")
   end,
})

c.AddSpell("Holy Wrath", "with Final Wrath", {
   Melee = true,
   NoRangeCheck = true,
   Cooldown = 9,
   CheckFirst = function()
      return c.HasGlyph("Final Wrath") and c.GetHealthPercent() < 20
   end,
})

local hwStunnable = {
   [L["Demon"]] = true,
   [L["Undead"]] = true,
   [L["Dragonkin"]] = "glyphed",
   [L["Elemental"]] = "glyphed",
   [L["Aberration"]] = "glyphed",
}
c.AddSpell("Holy Wrath", "to Stun", {
   Melee = true,
   NoRangeCheck = true,
   Cooldown = 9,
   CheckFirst = function()
      local level = UnitLevel("target")
      if level == -1 or level > UnitLevel("player") then
         return false
      end

      local stunnable = hwStunnable[UnitCreatureType("target")]
      return stunnable == true
         or (stunnable == "glyphed" and c.HasGlyph("Holy Wrath"))
   end
})

c.AddSpell("Hammer of the Righteous", "with 3 targets", {
   Cooldown = 4.5,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 3
   end,
})

c.AddSpell("Sacred Shield", nil, {
   Buff = "Sacred Shield",
   BuffUnit = "player",
   UseBuffID = true,
   NoRangeCheck = true,
   Cooldown = 6,
   -- let "refresh" flash if needed when out of melee range, otherwise small
   -- green flashes are easy to confuse w/ big green flashes
   Melee = true,
})

c.AddSpell("Sacred Shield", "at 2", {
   NoRangeCheck = true,
   Cooldown = 6,
   CheckFirst = function(z)
      if GetSpellBonusDamage(2) > a.SacredShieldPower then
         z.FlashColor = "green"
         return true
      elseif c.GetBuffDuration("Sacred Shield", false, true, true) < 2 then
         z.FlashColor = nil
         return true
      end
   end,
})

c.AddSpell("Sacred Shield", "at 8", {
   NoRangeCheck = true,
   Cooldown = 6,
   CheckFirst = function(z)
      if GetSpellBonusDamage(2) > a.SacredShieldPower then
         z.FlashColor = "green"
         return true
      elseif c.GetBuffDuration("Sacred Shield", false, true, true) < 8 then
         z.FlashColor = nil
         return true
      end
   end,
})

c.AddSpell("Flash of Light", "for Prot", {
   NoRangeCheck = true,
   CheckFirst = function()
      return a.SelflessHealer >= 3 and c.GetHealthPercent("player") < 85
   end
})

c.AddSpell("Judgment", "under Sanctified Wrath", {
   Cooldown = 6,
   CheckFirst = function()
      return c.HasTalent("Sanctified Wrath")
         and c.HasBuff("Avenging Wrath", false, true)
   end,
})

c.AddSpell("Judgment", "under Sanctified Wrath Delay", {
   ID = "Judgment",
   IsMinDelayDefinition = true,
   GetDelay = function()
      return a.Judgment, c.InDamageMode() and .2 or c.LastGCD / 2
   end
})

c.AddSpell("Avenger's Shield", nil, {
   Cooldown = 15,
})

c.AddSpell("Avenger's Shield", "under Grand Crusader and multiple targets", {
   Cooldown = 15,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1 and a.GrandCrusader and not c.HasGlyph("Focused Shield")
   end
})

c.AddSpell("Avenger's Shield", "under Grand Crusader", {
   Cooldown = 15,
   CheckFirst = function()
      return a.GrandCrusader
   end
})

c.AddSpell("Avenger's Shield", "with multiple targets", {
   Cooldown = 15,
   CheckFirst = function()
      return c.EstimatedHarmTargets > 1 and a.GrandCrusader and not c.HasGlyph("Focused Shield")
   end
})

c.AddSpell("Prot HP Gen Delay", nil, {
   ID = "Crusader Strike",
   IsMinDelayDefinition = true,
   GetDelay = function()
      return min(a.Judgment, a.Crusader),
         c.InDamageMode() and .2 or c.LastGCD - .2
   end
})

c.AddSpell("Hammer of Wrath", nil, {
   Cooldown = 6,
   CheckFirst = function()
      return a.HoWPhase
   end
})

local getConsecrationDelay = function(z)
   if c.HasGlyph("Consecration") then
      z.Melee = nil
      return c.GetCooldown("Consecration with Consecration", false, 9)
   elseif c.HasGlyph("Consecrator") then
      z.Melee = true
      return c.GetCooldown("Consecration with Consecrator", false, 9)
   else
      z.Melee = true
      return c.GetCooldown("Consecration", false, 9)
   end
end

c.AddSpell("Consecration", nil, {
   NoRangeCheck = true,
   GetDelay = getConsecrationDelay,
})

c.AddSpell("Consecration", "with 3 targets", {
   NoRangeCheck = true,
   GetDelay = getConsecrationDelay,
   CheckFirst = function()
      return c.EstimatedHarmTargets >= 3
   end,
})

c.AddTaunt("Reckoning", nil, { NoGCD = true })

------------------------------------------------------------------- Retribution
c.AddOptionalSpell("Seal of Truth", nil, {
   Type = "form",
   CheckFirst = function()
      return not c.Form("Seal of Truth")
   end
})

-- sync both these spells with seraphim, if we have that talent.
c.AddOptionalSpell("Holy Avenger", nil, {
   NoGCD = true,
   GetDelay = function()
      local cd = c.GetCooldown("Holy Avenger", false, 120)
      if c.HasTalent("Seraphim") then
         return max(cd, c.GetCooldown("Seraphim", false, 30))
      else
         return a.HolyPower <= 2 and cd
      end
   end
})

c.AddOptionalSpell("Avenging Wrath", nil, {
   GetDelay = function()
      local cd = c.GetCooldown("Avenging Wrath", false, 120)
      if c.HasTalent("Seraphim") then
         return max(cd, c.GetCooldown("Seraphim", true, 30))
      else
         return cd
      end
   end,
})

c.AddSpell("Seraphim")

c.AddOptionalSpell("Word of Glory", "for Ret", {
   Override = function()
      return a.HolyPower > 0
         and not s.InRaidOrParty()
         and 95 - c.GetHealthPercent("player") > 8 * min(3, a.HolyPower)
         and (not s.InCombat() or a.HolyPower >= 3)
   end
})

c.AddOptionalSpell("Flash of Light", "for Ret", {
   NoRangeCheck = true,
   CheckFirst = function()
      return (a.SelflessHealer == 3 or not s.InCombat())
         and c.GetHealthPercent("player") < 80
   end,
})

c.AddOptionalSpell("Execution Sentence", nil, {
   Cooldown = 60,
})

c.AddSpell("Templar's Verdict", "at 3, no Seraphim", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and c.GetCooldown("Seraphim", true, 30) > 4
   end,
})

c.AddSpell("Templar's Verdict", "at 4, no Seraphim", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 4 and c.GetCooldown("Seraphim", true, 30) > 4
   end,
})

c.AddSpell("Templar's Verdict", "at 5", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 5 or
         (a.HolyPower >= 3 and a.HolyAvenger > c.LastGCD and c.GetCooldown("Seraphim", true, 30) > 4)
   end,
})

c.AddSpell("Templar's Verdict", "4pT15", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3
         and a.Crusader < c.LastGCD
         and c.EstimatedHarmTargets < 2
         and c.HasBuff("Ret 4pT15 Buff")
   end,
})

c.AddSpell("Templar's Verdict", "with Divine Purpose < 4", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.DivinePurpose < 4
   end
})

c.AddSpell("Templar's Verdict", "with Divine Purpose Talent", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and c.HasTalent("Divine Purpose")
   end
})

c.AddSpell("Templar's Verdict", "with Divine Purpose", {
   Melee = true,
   CheckFirst = function()
      return c.HasBuff("Divine Purpose")
   end
})

c.AddSpell("Templar's Verdict", "with Avenging Wrath", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.AvengingWrath and c.GetCooldown("Seraphim", true, 30) > 4
   end
})

c.AddSpell("Final Verdict", nil, {
   CheckFirst = function()
      return a.HolyPower >= 3
   end
})

c.AddSpell("Final Verdict", "for buff at 5", {
   CheckFirst = function()
      return a.HolyPower >= 5 and not a.FinalVerdict
   end,
})

c.AddSpell("Final Verdict", "at 5", {
   CheckFirst = function()
      return a.HolyPower >= 5
   end
})

c.AddSpell("Final Verdict", "with Holy Avenger", {
   CheckFirst = function()
      return a.HolyPower >= 3 and a.HolyAvenger
   end
})

c.AddSpell("Final Verdict", "with Divine Purpose < 4", {
   CheckFirst = function()
      return a.HolyPower >= 3 and a.DivinePurpose < 4
   end
})

c.AddSpell("Final Verdict", "with Divine Purpose", {
   CheckFirst = function()
      return a.HolyPower >= 3 and a.DivinePurpose
   end
})



local function HammerOfWrathDelay()
   local cd = c.GetCooldown("Hammer of Wrath", false, 6)
   return (a.HoWPhase or (a.AvengingWrath and a.AvengingWrath > 0))
      and s.SpellInRange(c.GetID("Hammer of Wrath"))
      and cd
end

c.AddSpell("Hammer of Wrath", "for Ret", {
   GetDelay = HammerOfWrathDelay,
})

c.AddSpell("Hammer of Wrath", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return HammerOfWrathDelay(), .35
   end,
})

c.AddSpell("Judgment", "for Liadrin's Righteousness < 5", {
   CheckFirst = function()
      return c.HasTalent("Empowered Seals") and
         c.Form("Seal of Righteousness") and
         c.GetBuffDuration("Liadrin's Righteousness") <= 5
   end,
})

c.AddSpell("Judgment", "for Liadrin's Righteousness", {
   CheckFirst = function()
      return c.HasTalent("Empowered Seals") and
         c.Form("Seal of Righteousness") and
         c.GetBuffDuration("Liadrin's Righteousness") <= c.GetCooldown("Judgment", true, 6)*2
   end,
})

c.AddSpell("Judgment", "for Maraad's Truth", {
   CheckFirst = function()
      return c.HasTalent("Empowered Seals") and
         c.Form("Seal of Truth") and
         c.GetBuffDuration("Maraad's Truth") <= c.GetCooldown("Judgment", true, 6)*2
   end,
})

local function exorcismDelay()
   return (not c.HasGlyph("Mass Exorcism") or s.MeleeDistance()) and a.Exorcism
end

c.AddSpell("Exorcism", nil, {
   GetDelay = exorcismDelay,
})

c.AddSpell("Exorcism", "Delay", {
   IsMinDelayDefinition = true,
   GetDelay = function()
      return exorcismDelay(), .35
   end,
})

c.AddSpell("Exorcism", "with Blazing Contempt", {
   Cooldown = 15,
   CheckFirst = function()
      return a.HolyPower <= 2 and c.HasBuff("Blazing Contempt") and not c.HasBuff("Holy Avenger")
   end,
})

c.AddSpell("Exorcism", "with Mass Exorcism", {
   Melee = true,
   Cooldown = 15,
   CheckFirst = function()
      return c.HasGlyph("Mass Exorcism")
   end,
})

c.AddSpell("HP Gen Delay for Ret", nil, {
   ID = "Crusader Strike",
   IsMinDelayDefinition = true,
   GetDelay = function()
      return min(a.Exorcism, a.Judgment, a.Crusader), .2
   end
})

c.AddOptionalSpell("Light's Hammer", nil, {
   Cooldown = 60,
   NoRangeCheck = true,
})

c.AddSpell("Holy Prism", nil, {
   Cooldown = 20,
})

c.AddOptionalSpell("Sacred Shield", "for Ret", {
   NoRangeCheck = true,
   GetDelay = function(z)
      local delay = max(c.LastGCD, c.GetCooldown("Sacred Shield", false, 6))
      z.WhiteFlashOffset = -delay
      return delay
   end
})

c.AddSpell("Divine Storm", nil, {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and c.GetCooldown("Seraphim", false, 30) > 4
   end
})

c.AddSpell("Divine Storm", "at 5", {
   Melee = true,
   CheckFirst = function()
      -- cooldown automatically true if we don't have seraphim
      return a.HolyPower >= 5 and c.GetCooldown("Seraphim", false, 30) > 4
   end,
})

c.AddSpell("Divine Storm", "at 5 with Final Verdict", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 5 and a.FinalVerdict
   end
})

c.AddSpell("Divine Storm", "at 5 without Final Verdict talent", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 5 and
         not c.HasTalent("Final Verdict") and
         c.GetCooldown("Seraphim", false, 30) > 4
   end
})

c.AddSpell("Divine Storm", "at 5 with Divine Crusader and Final Verdict", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 5 and a.FinalVerdict and a.DivineCrusader
   end
})

c.AddSpell("Divine Storm", "at 5 with Divine Crusader or Final Verdict, and Two Targets", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 5 and
         c.EstimatedHarmTargets >= 2 and
         (a.FinalVerdict or (a.DivineCrusader and not c.HasTalent("Final Verdict")))
   end
})

c.AddSpell("Divine Storm", "at 5 with Divine Crusader and Seraphim", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 5 and
         a.DivineCrusader and
         c.GetCooldown("Seraphim", false, 30) <= 4
   end
})

c.AddSpell("Divine Storm", "with Divine Crusader and Final Verdict", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.FinalVerdict and a.DivineCrusader
   end
})

c.AddSpell("Divine Storm", "with Final Verdict", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.FinalVerdict
   end
})

c.AddSpell("Divine Storm", "without Final Verdict talent", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and
         not c.HasTalent("Final Verdict") and
         c.GetCooldown("Seraphim", false, 30) > 4
   end
})

c.AddSpell("Divine Storm", "with Divine Purpose talent, and Divine Crusader, without Final Verdict talent", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and
         a.DivineCrusader and
         c.HasTalent("Divine Purpose") and
         not c.HasTalent("Final Verdict")
   end
})

c.AddSpell("Divine Storm", "with Divine Crusader", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.DivineCrusader
   end
})

c.AddSpell("Divine Storm", "with Divine Crusader, without Final Verdict talent", {
   Melee = true,
   CheckFirst = function()
      return a.HolyPower >= 3 and a.DivineCrusader and not c.HasTalent("Final Verdict")
   end
})

c.AddSpell("Hammer of the Righteous", nil, {
   Cooldown = 4.5,
})

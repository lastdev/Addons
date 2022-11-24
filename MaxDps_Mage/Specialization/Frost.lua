local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end

local Mage = addonTable.Mage;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;

local FT = {
	ArcaneExplosion = 1449,
	ArcaneIntellect = 1459,
	Blizzard = 190356,
	ColdFront = 382110,
	CometStorm = 153595,
	ConeOfCold = 120,
	Ebonbolt = 257537,
	Exhaustion = 390435,
	FingersOfFrost = 112965,
	FingersOfFrostBuff = 44544,
	FireBlast = 108853,
	Flurry = 44614,
	Freeze = 33395,
	FreezingRain = 270233,
	FreezingWinds = 382103,
	FrostNova = 122,
	Frostbite = 378760,
	Frostbolt = 116,
	FrozenOrb = 84714,
	GlacialSpike = 199786,
	GlacialSpikeDebuff = 228600,
	IceCaller = 236662,
	IceFloes = 108839,
	IceLance = 30455,
	IceNova = 157997,
	Icicles = 205473,
	IcyVeins = 12472,
	Meteor = 153561,
	RayOfFrost = 205021,
	RuneOfPower = 116011,
	RuneOfPowerBuff = 116014,
	ShiftingPower = 382440,
	SlickIce = 382144,
	Snowstorm = 381706,
	SnowstormBuff = 381522,
	SummonWaterElemental = 31687,
	TimeWarp = 80353,
	WaterJet = 135029,
	WintersChill = 228358
}

setmetatable(FT, Mage.spellMeta);

local function isFrozen()
	local fd = MaxDps.FrameData
	local debuff = fd.debuff

	return (debuff[FT.WintersChill].up and debuff[FT.WintersChill].count > 0)
			or debuff[FT.Frostbite].up
			or debuff[FT.Freeze].up
			or debuff[FT.GlacialSpikeDebuff].up;
end

function Mage:Frost()
	local fd = MaxDps.FrameData
	local targets = MaxDps:SmartAoe()
	fd.targets = targets
	fd.mana = UnitPower('player', Enum.PowerType.Mana);
	fd.manaMax = UnitPowerMax('player', Enum.PowerType.Mana);
	fd.manaPct = 100 * (fd.mana / fd.manaMax);

	fd.frozen = isFrozen()

	fd.moving = GetUnitSpeed('player') > 0;

	-- call_action_list,name=cds
	local result = Mage:FrostCds()
	if result then
		return result
	end

	if fd.moving then
		return Mage:FrostMovement()
	end

	-- call_action_list,name=aoe,if=active_enemies>=3
	if targets >= 3 then
		result = Mage:FrostAoe()
		if result then
			return result
		end
	end

	return Mage:FrostSt()
end

function Mage:FrostAoe()
	local fd = MaxDps.FrameData
	local cooldown = fd.cooldown
	local buff = fd.buff
	local debuff = fd.debuff
	local currentSpell = fd.currentSpell
	local spellHistory = fd.spellHistory
	local talents = fd.talents
	local targets = fd.targets
	local mana = fd.mana
	local frozen = fd.frozen
	local manaPct = fd.manaPct

	local remainingWintersChill = debuff[FT.WintersChill].count;

	-- frozen_orb
	if talents[FT.FrozenOrb] and cooldown[FT.FrozenOrb].ready and mana >= 500 then
		return FT.FrozenOrb
	end

	-- blizzard
	if talents[FT.Blizzard] and cooldown[FT.Blizzard].ready and mana >= 1250 and currentSpell ~= FT.Blizzard then
		return FT.Blizzard
	end

	-- frost_nova,if=prev_gcd.1.comet_storm
	if cooldown[FT.FrostNova].ready and mana >= 1000 and (spellHistory[1] == FT.CometStorm) then
		return FT.FrostNova
	end

	-- flurry,if=cooldown_react&remaining_winters_chill=0&debuff.winters_chill.down&(prev_gcd.1.frostbolt|prev_gcd.1.ebonbolt|prev_gcd.1.glacial_spike)
	if talents[FT.Flurry] and cooldown[FT.Flurry].ready and mana >= 500 and remainingWintersChill == 0 and ( spellHistory[1] == FT.Frostbolt or spellHistory[1] == FT.Ebonbolt or spellHistory[1] == FT.GlacialSpike ) then
		return FT.Flurry
	end

	-- ice_nova
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready then
		return FT.IceNova
	end

	-- cone_of_cold,if=buff.snowstorm.stack=buff.snowstorm.max_stack
	if cooldown[FT.ConeOfCold].ready and mana >= 2000 and (buff[FT.SnowstormBuff].count == buff[FT.SnowstormBuff].maxStacks) then
		return FT.ConeOfCold
	end

	-- comet_storm
	if talents[FT.CometStorm] and cooldown[FT.CometStorm].ready and mana >= 500 then
		return FT.CometStorm
	end

	-- ice_lance,if=buff.fingers_of_frost.react|debuff.frozen.remains>travel_time|remaining_winters_chill&debuff.winters_chill.remains>travel_time
	if talents[FT.IceLance] and mana >= 500 and (buff[FT.FingersOfFrostBuff].up or frozen) then
		return FT.IceLance
	end

	-- shifting_power
	if talents[FT.ShiftingPower] and cooldown[FT.ShiftingPower].ready and mana >= 2500 and currentSpell ~= FT.ShiftingPower then
		return FT.ShiftingPower
	end

	-- arcane_explosion,if=mana.pct>30&active_enemies>=6&!runeforge.glacial_fragments
	if manaPct > 30 and targets >= 6 then
		return FT.ArcaneExplosion
	end

	-- ebonbolt
	if talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].ready and currentSpell ~= FT.Ebonbolt then
		return FT.Ebonbolt
	end

	-- frostbolt
	if mana >= 1000 then
		return FT.Frostbolt
	end
end

function Mage:FrostCds()
	local fd = MaxDps.FrameData
	local cooldown = fd.cooldown
	local buff = fd.buff
	local talents = fd.talents
	local currentSpell = fd.currentSpell

	-- time_warp,if=buff.exhaustion.up&buff.bloodlust.down
	MaxDps:GlowCooldown(FT.TimeWarp, cooldown[FT.TimeWarp].ready and buff[FT.Exhaustion].up and not MaxDps:Bloodlust())

	-- icy_veins,if=buff.rune_of_power.down
	if talents[FT.IcyVeins] and cooldown[FT.IcyVeins].ready and (not buff[FT.RuneOfPowerBuff].up) then
		return FT.IcyVeins
	end

	-- rune_of_power,if=buff.rune_of_power.down&cooldown.icy_veins.remains>10
	if not fd.moving and talents[FT.RuneOfPower] and cooldown[FT.RuneOfPower].ready and currentSpell ~= FT.RuneOfPower and (not buff[FT.RuneOfPowerBuff].up and (not talents[FT.IcyVeins] or cooldown[FT.IcyVeins].remains > 10)) then
		return FT.RuneOfPower
	end
end

function Mage:FrostMovement()
	local fd = MaxDps.FrameData
	local cooldown = fd.cooldown
	local buff = fd.buff
	local talents = fd.talents
	local targets = fd.targets
	local mana = fd.mana
	local manaPct = fd.manaPct

	-- ice_floes,if=buff.ice_floes.down
	if talents[FT.IceFloes] and cooldown[FT.IceFloes].ready and (not buff[FT.IceFloes].up) then
		return FT.IceFloes
	end

	-- ice_nova
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready then
		return FT.IceNova
	end

	-- arcane_explosion,if=mana.pct>30&active_enemies>=2
	if manaPct > 30 and targets >= 2 then
		return FT.ArcaneExplosion
	end

	-- fire_blast
	if talents[FT.FireBlast] and cooldown[FT.FireBlast].ready and mana >= 500 then
		return FT.FireBlast
	end

	-- ice_lance
	if talents[FT.IceLance] and mana >= 500 then
		return FT.IceLance
	end
end

function Mage:FrostSt()
	local fd = MaxDps.FrameData
	local cooldown = fd.cooldown
	local buff = fd.buff
	local debuff = fd.debuff
	local currentSpell = fd.currentSpell
	local spellHistory = fd.spellHistory
	local talents = fd.talents
	local targets = fd.targets
	local mana = fd.mana
	local frozen = fd.frozen

	local remainingWintersChill = debuff[FT.WintersChill].count;

	-- flurry,if=cooldown_react&remaining_winters_chill=0&debuff.winters_chill.down&(prev_gcd.1.frostbolt|prev_gcd.1.ebonbolt|prev_gcd.1.glacial_spike|prev_gcd.1.radiant_spark)
	if talents[FT.Flurry] and cooldown[FT.Flurry].ready and mana >= 500 and (remainingWintersChill == 0 and not debuff[FT.WintersChill].up and ( spellHistory[1] == FT.Frostbolt or spellHistory[1] == FT.Ebonbolt or spellHistory[1] == FT.GlacialSpike )) then
		return FT.Flurry
	end

	-- meteor,if=prev_gcd.1.flurry
	if talents[FT.Meteor] and cooldown[FT.Meteor].ready and mana >= 500 and (spellHistory[1] == FT.Flurry) then
		return FT.Meteor
	end

	-- comet_storm,if=prev_gcd.1.flurry
	if talents[FT.CometStorm] and cooldown[FT.CometStorm].ready and mana >= 500 and (spellHistory[1] == FT.Flurry) then
		return FT.CometStorm
	end

	-- frozen_orb
	if talents[FT.FrozenOrb] and cooldown[FT.FrozenOrb].ready and mana >= 500 then
		return FT.FrozenOrb
	end

	-- blizzard,if=active_enemies>=2&talent.ice_caller&talent.freezing_rain
	if talents[FT.Blizzard] and cooldown[FT.Blizzard].ready and mana >= 1250 and currentSpell ~= FT.Blizzard and (targets >= 2 and talents[FT.IceCaller] and talents[FT.FreezingRain]) then
		return FT.Blizzard
	end

	-- shifting_power,if=buff.rune_of_power.down
	if talents[FT.ShiftingPower] and cooldown[FT.ShiftingPower].ready and mana >= 2500 and currentSpell ~= FT.ShiftingPower and (not buff[FT.RuneOfPowerBuff].up) then
		return FT.ShiftingPower
	end

	-- glacial_spike,if=remaining_winters_chill
	if talents[FT.GlacialSpike] and mana >= 500 and currentSpell ~= FT.GlacialSpike and (remainingWintersChill > 0) then
		return FT.GlacialSpike
	end

	-- ray_of_frost,if=remaining_winters_chill
	if talents[FT.RayOfFrost] and cooldown[FT.RayOfFrost].ready and mana >= 1000 and currentSpell ~= FT.RayOfFrost and (remainingWintersChill > 0) then
		return FT.RayOfFrost
	end

	-- ice_lance,if=buff.fingers_of_frost.react&!prev_gcd.1.glacial_spike|remaining_winters_chill
	if talents[FT.IceLance] and mana >= 500 and (buff[FT.FingersOfFrostBuff].up or frozen) then
		return FT.IceLance
	end

	-- glacial_spike,if=action.flurry.cooldown_react
	if talents[FT.GlacialSpike] and mana >= 500 and currentSpell ~= FT.GlacialSpike and (cooldown[FT.Flurry].ready) then
		return FT.GlacialSpike
	end

	-- ebonbolt,if=cooldown.flurry.charges_fractional<1
	if talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].ready and currentSpell ~= FT.Ebonbolt and (cooldown[FT.Flurry].charges < 1) then
		return FT.Ebonbolt
	end

	-- frostbolt
	if mana >= 1000 then
		return FT.Frostbolt
	end
end

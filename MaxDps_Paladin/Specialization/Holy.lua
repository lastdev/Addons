local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end;

local Paladin = addonTable.Paladin;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local HolyPower = Enum.PowerType.HolyPower;
local HL = {
    AvengingCrusader = 216331,
    AvengingWrath = 31884,
    Consecration = 26573,
    CrusaderStrike = 35395,
    CrusadersMight = 196926,
    DivineToll = 375576,
    HammerOfWrath = 24275,
    HolyAvenger = 105809,
    HolyShock = 20473,
    Judgment = 275773,
    LightOfDawn = 85222,
    LightsHammer = 114158,
    ShieldOfTheRighteous = 53600,
    TyrsDeliverance = 200652,
    WordOfGlory = 85673,
    --
    --Kyrian
    KyrianDivineToll = 304971,
    --
    --Venthyr
    AshenHallow = 316958,
    --
    --NightFae
    BlessingofSpring = 328282,
    BlessingofSummer = 328620,
    BlessingofAutumn = 328622,
    BlessingofWinter = 328281,
    --
    --Necrolord
    VanquishersHammer = 328204,
    --
};

local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(HL, Paladin.spellMeta);

function Paladin:Holy()
    local fd = MaxDps.FrameData;
    local covenantId = fd.covenant.covenantId;
    local holyPower = UnitPower('player', HolyPower);
    fd.holyPower = holyPower;
    local cooldown = fd.cooldown;
    local buff = fd.buff;
    local talents = fd.talents;
    local targetHp = MaxDps:TargetPercentHealth() * 100;

    -- Essences
    MaxDps:GlowEssences();

    -- Cooldowns
    MaxDps:GlowCooldown(HL.AvengingWrath, cooldown[HL.AvengingWrath].ready);

    --talents

    if talents[HL.LightsHammer] then
        MaxDps:GlowCooldown(HL.LightsHammer, cooldown[HL.LightsHammer].ready);
    end

    if talents[HL.HolyAvenger] then
        MaxDps:GlowCooldown(HL.HolyAvenger, cooldown[HL.HolyAvenger].ready);
    end

    if talents[HL.AvengingCrusader] then
        MaxDps:GlowCooldown(HL.AvengingCrusader, cooldown[HL.AvengingCrusader].ready);
    end

    --Covenant
    --Kyrian
    if covenantId == CN.Kyrian then
        MaxDps:GlowCooldown(HL.KyrianDivineToll, cooldown[HL.KyrianDivineToll].ready);
    end
    --
    --Venthyr
    if covenantId == CN.Venthyr then
        MaxDps:GlowCooldown(HL.AshenHallow, cooldown[HL.AshenHallow].ready);
    end
    --
    --NightFae
    --HL.BlessingofSpring Gives Healing

    if covenantId == CN.NightFae then
        MaxDps:GlowCooldown(HL.BlessingofSummer, cooldown[HL.BlessingofSummer].ready);
    end

    if covenantId == CN.NightFae then
        MaxDps:GlowCooldown(HL.BlessingofAutumn, cooldown[HL.BlessingofAutumn].ready);
    end

    if covenantId == CN.NightFae then
        MaxDps:GlowCooldown(HL.BlessingofWinter, cooldown[HL.BlessingofWinter].ready);
    end
    --
    --Necrolord
    if covenantId == CN.Necrolord then
        MaxDps:GlowCooldown(HL.VanquishersHammer, cooldown[HL.VanquishersHammer].ready);
    end

    -- Spenders
    if talents[HL.LightOfDawn] then
        MaxDps:GlowCooldown(HL.LightOfDawn, holyPower == 5);
    end

    MaxDps:GlowCooldown(HL.WordOfGlory, holyPower == 5);

    if talents[HL.DivineToll] then
        MaxDps:GlowCooldown(HL.DivineToll, (holyPower <= 1) and cooldown[HL.DivineToll].ready);
    end

    if talents[HL.LightsHammer] then
        MaxDps:GlowCooldown(HL.LightsHammer, cooldown[HL.LightsHammer].ready);
    end

    if talents[HL.TyrsDeliverance] then
        MaxDps:GlowCooldown(HL.TyrsDeliverance, cooldown[HL.TyrsDeliverance].ready);
    end

    if cooldown[HL.HolyShock].ready then
        return HL.HolyShock;
    end

    if cooldown[HL.CrusaderStrike].ready and talents[HL.CrusadersMight] then
        return HL.CrusaderStrike;
    end

    if (targetHp <= 20 or buff[HL.AvengingWrath].up) and cooldown[HL.HammerOfWrath].ready then
        return HL.HammerOfWrath;
    end

    if cooldown[HL.Judgment].ready then
        return HL.Judgment;
    end

    if cooldown[HL.Consecration].ready then
        return HL.Consecration;
    end

    if cooldown[HL.CrusaderStrike].ready then
        return HL.CrusaderStrike;
    end

    if cooldown[HL.ShieldOfTheRighteous].ready and holyPower >= 3 then
        return HL.ShieldOfTheRighteous;
    end
end
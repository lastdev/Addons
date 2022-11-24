local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end;

local Evoker = addonTable.Evoker;
local MaxDps = MaxDps;

local DV = {
    TipTheScales = 370553,
    Dragonrage = 375087,
    ShatteringStar = 370452,
    EternitySurge = 359073,
    EternitySurgeFontOfMagic = 382411,
    FireBreath = 357208,
    FireBreathFontOfMagic = 382266,
    FontOfMagic = 375783,
    Disintegrate = 356995,
    LivingFlame = 361469,
    AzureStrike = 362969,
    EssenceBurst = 359618,
    Firestorm = 368847,
    Pyre = 357211,
    Burnout = 375802,
    ShatteringStar = 370452,
    EssenceAttunement = 375722,
    Snapfire = 370818,
    EverburningFlame = 370819,
    ChargedBlast = 370455,
    ChargedBlastBuff = 370454
};

setmetatable(DV, Evoker.spellMeta);

local function getSpellCost(spellId, defaultCost)
    local cost = GetSpellPowerCost(spellId);
    if cost ~= nil then
        return cost[1].cost;
    end

    return defaultCost
end

function Evoker:Devastation()
    local fd = MaxDps.FrameData;
    fd.essence = UnitPower('player', Enum.PowerType.Essence)
    local talents = fd.talents
    fd.maxEssenceBurst = talents[DV.EssenceAttunement] and 2 or 1
    local cooldown = fd.cooldown

    fd.fireBreathSpellId = talents[DV.FontOfMagic] and DV.FireBreathFontOfMagic or DV.FireBreath
    fd.eternitySurgeSpellId = talents[DV.FontOfMagic] and DV.EternitySurgeFontOfMagic or DV.EternitySurge

    if talents[DV.Dragonrage] then
        MaxDps:GlowCooldown(DV.Dragonrage, cooldown[DV.Dragonrage].ready)
    end

    if talents[DV.TipTheScales] then
        MaxDps:GlowCooldown(DV.TipTheScales, cooldown[DV.TipTheScales].ready)
    end

    fd.targets = MaxDps:SmartAoe()

    if fd.targets > 1 then
        return Evoker:DevastationAoe()
    else
        return Evoker:DevastationSingle()
    end
end

function Evoker:DevastationSingle()
    local fd = MaxDps.FrameData;
    local cooldown = fd.cooldown
    local talents = fd.talents
    local buff = fd.buff
    local currentSpell = fd.currentSpell
    local gcd = fd.gcd
    local essence = fd.essence
    local maxEssenceBurst = fd.maxEssenceBurst
    local fireBreathSpellId = fd.fireBreathSpellId
    local eternitySurgeSpellId = fd.eternitySurgeSpellId

    if currentSpell ~= fireBreathSpellId and cooldown[fireBreathSpellId].ready then
        return fireBreathSpellId
    end

    if talents[DV.EverburningFlame] and (buff[DV.Snapfire].up or (cooldown[DV.Firestorm].ready and currentSpell ~= DV.Firestorm)) then
        return DV.Firestorm
    end

    if talents[DV.ShatteringStar] and cooldown[DV.ShatteringStar].ready then
        return DV.ShatteringStar
    end

    if talents[DV.ShatteringStar] and talents[DV.EternitySurge] and currentSpell ~= eternitySurgeSpellId and cooldown[eternitySurgeSpellId].ready then
        return eternitySurgeSpellId
    end

    if essence >= 4 or (buff[DV.EssenceBurst].up and (maxEssenceBurst == buff[DV.EssenceBurst].count or buff[DV.EssenceBurst].remains <= gcd * 2)) then
        return DV.Disintegrate
    end

    -- Prevent losing the buff
    if buff[DV.Burnout].up then
        return DV.LivingFlame
    end

    if essence >= 5 or buff[DV.EssenceBurst].up then
        return DV.Disintegrate
    end

    return DV.LivingFlame
end

function Evoker:DevastationAoe()
    local fd = MaxDps.FrameData;
    local cooldown = fd.cooldown
    local talents = fd.talents
    local buff = fd.buff
    local currentSpell = fd.currentSpell
    local gcd = fd.gcd
    local essence = fd.essence
    local maxEssenceBurst = fd.maxEssenceBurst
    local fireBreathSpellId = fd.fireBreathSpellId
    local eternitySurgeSpellId = fd.eternitySurgeSpellId
    local targets = fd.targets

    if currentSpell ~= fireBreathSpellId and cooldown[fireBreathSpellId].ready then
        return fireBreathSpellId
    end

    if talents[DV.ShatteringStar] and cooldown[DV.ShatteringStar].ready then
        return DV.ShatteringStar
    end

    if talents[DV.EternitySurge] and currentSpell ~= eternitySurgeSpellId and cooldown[eternitySurgeSpellId].ready then
        return eternitySurgeSpellId
    end

    local essenceSpender
    local essenceSpenderCost

    if talents[DV.ChargedBlast] then
        if not buff[DV.Dragonrage].up or targets < 3 then
            if (targets == 2 and buff[DV.ChargedBlastBuff].count == 20) or (targets == 3 and buff[DV.ChargedBlastBuff].count >= 10) or targets >= 4 then
                essenceSpender = DV.Pyre
            else
                essenceSpender = DV.Disintegrate
            end
        else
            essenceSpender = DV.Pyre
        end
    else
        if not buff[DV.Dragonrage].up then
            if targets >= 4 then
                essenceSpender = DV.Pyre
            else
                essenceSpender = DV.Disintegrate
            end
        else
            essenceSpender = DV.Pyre
        end
    end

    if essenceSpender == DV.Pyre then
        essenceSpenderCost = getSpellCost(DV.Pyre, 2)
    else
        essenceSpenderCost = getSpellCost(DV.Disintegrate, 3)
    end

    if essence >= 4 or (buff[DV.EssenceBurst].up and (maxEssenceBurst == buff[DV.EssenceBurst].count or buff[DV.EssenceBurst].remains <= gcd * 2)) then
        return essenceSpender
    end

    -- Prevent losing the buff
    if buff[DV.Burnout].up then
        return DV.LivingFlame
    end

    if buff[DV.EssenceBurst].up and buff[DV.EssenceBurst].remains <= 5 then
        return essenceSpender
    end

    if buff[DV.EssenceBurst].up or essence >= essenceSpenderCost then
        return essenceSpender
    end

    if buff[DV.Snapfire].up then
        return DV.Firestorm
    end

    if talents[DV.Firestorm] and currentSpell ~= DV.Firestorm and cooldown[DV.Firestorm].ready then
        return DV.Firestorm
    end

    return DV.AzureStrike
end

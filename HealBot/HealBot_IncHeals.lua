local hbHealsIn={}
local hbAbsorbs={}
local _

function HealBot_IncHeals_retHealsIn(unit, hbFrame)
    if UnitIsEnemy(unit,"player") then
        if hbHealsIn[unit] then hbHealsIn[unit]=nil end
        if hbAbsorbs[unit] then hbAbsorbs[unit]=nil end
    end
    local x=hbHealsIn[unit] or 0
    local y=hbAbsorbs[unit] or 0
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][hbFrame]["AC"]<2 then y=0 end
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][hbFrame]["IC"]<2 then x=0 end
    return x, y
end

function HealBot_IncHeals_updHealsIn(unit)
    if HealBot_Unit_Button[unit] then
        HealBot_IncHeals_HealsInUpdate(unit)
        HealBot_Action_ResetUnitStatus(unit)
    end
end

function HealBot_IncHeals_HealsInUpdate(unit)
    if unit then
        if UnitExists(unit) then
            hbHealsIn[unit]=UnitGetIncomingHeals(unit)
            hbAbsorbs[unit]=UnitGetTotalAbsorbs(unit)

            local x=hbHealsIn[unit] or 0
            local y=hbAbsorbs[unit] or 0
            if (x+y)==0 then
                HealBot_setHealsAbsorb(unit, nil)
            else
                HealBot_setHealsAbsorb(unit, true)
            end
            HealBot_Action_ResetUnitStatus(unit)
        else
            HealBot_IncHeals_ClearAll(unit)
            HealBot_setHealsAbsorb(unit, nil)
        end
    end
end

function HealBot_IncHeals_ClearAll(unit)
    if unit then
        if hbHealsIn[unit] then hbHealsIn[unit]=nil end
        if hbAbsorbs[unit] then hbAbsorbs[unit]=nil end
    else
        for xUnit,_ in pairs(hbHealsIn) do
            hbHealsIn[xUnit]=nil
        end
        for xUnit,_ in pairs(hbAbsorbs) do
            hbAbsorbs[xUnit]=nil
        end
    end
end





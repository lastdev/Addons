local hbHealsIn={}
local hbAbsorbs={}
local _

function HealBot_IncHeals_retHealsIn(unit)
    local x=hbHealsIn[unit] or 0
    local y=hbAbsorbs[unit] or 0
    return x, y
end

function HealBot_IncHeals_updHealsIn(unit)
    local xUnit,_ = HealBot_UnitID(unit)
    if xUnit then
        HealBot_IncHeals_HealsInUpdate(xUnit)
    end
end

function HealBot_IncHeals_HealsInUpdate(unit)
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
        hbHealsIn[unit]=0
        hbAbsorbs[unit]=0
        HealBot_setHealsAbsorb(unit, nil)
    end
end

function HealBot_IncHeals_ClearAll()
    for xUnit,_ in pairs(hbHealsIn) do
        hbHealsIn[xUnit]=nil
    end
    for xUnit,_ in pairs(hbAbsorbs) do
        hbAbsorbs[xUnit]=nil
    end
end





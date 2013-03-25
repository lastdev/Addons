local hbHealsIn={}
local hbAbsorbs={}
local xGUID=nil
local xUnit=nil
local _

function HealBot_IncHeals_retHealsIn(hbGUID)
    local x=hbHealsIn[hbGUID] or 0
    local y=hbAbsorbs[hbGUID] or 0
    return x, y
end

function HealBot_IncHeals_updHealsIn(unit)
    if HealBot_Unit_Button[unit] then
        xGUID=HealBot_UnitGUID(unit)
        if xGUID then HealBot_IncHeals_HealsInUpdate(xGUID) end
    end
end

function HealBot_IncHeals_HealsInUpdate(hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    if xUnit then 
        hbHealsIn[hbGUID]=UnitGetIncomingHeals(xUnit)
        hbAbsorbs[hbGUID]=UnitGetTotalAbsorbs(xUnit)
        HealBot_RecalcHeals(hbGUID)
    else
        if hbHealsIn[hbGUID] then hbHealsIn[hbGUID]=nil end
        if hbAbsorbs[hbGUID] then hbAbsorbs[hbGUID]=nil end
    end
    local x=hbHealsIn[hbGUID] or 0
    local y=hbAbsorbs[hbGUID] or 0
    if (x+y)==0 then
        HealBot_setHealsAbsorb(hbGUID, nil)
    else
        HealBot_setHealsAbsorb(hbGUID, true)
    end
end

function HealBot_IncHeals_ClearLocalArr(hbGUID)
    if hbHealsIn[hbGUID] then hbHealsIn[hbGUID]=nil end
    if hbAbsorbs[hbGUID] then hbAbsorbs[hbGUID]=nil end
end

function HealBot_IncHeals_ClearAll()
    for xGUID,_ in pairs(hbHealsIn) do
        hbHealsIn[xGUID]=nil
    end
    for xGUID,_ in pairs(hbAbsorbs) do
        hbAbsorbs[xGUID]=nil
    end
end





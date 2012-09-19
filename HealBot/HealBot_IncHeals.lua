local hbHealsIn={}
local xGUID=nil
local xUnit=nil
local _

function HealBot_IncHeals_retHealsIn(hbGUID)
    return hbHealsIn[hbGUID] or 0
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
        HealBot_RecalcHeals(hbGUID)
    elseif hbHealsIn[hbGUID] then
        hbHealsIn[hbGUID]=nil
    end
    if (hbHealsIn[hbGUID] or 0)==0 then
        HealBot_setHealsIncEndTime(hbGUID, nil)
    else
        HealBot_setHealsIncEndTime(hbGUID, GetTime()+2)
    end
end

function HealBot_IncHeals_ClearLocalArr(hbGUID)
    if hbHealsIn[hbGUID] then hbHealsIn[hbGUID]=nil end
end

function HealBot_IncHeals_ClearAll()
    for xGUID,_ in pairs(hbHealsIn) do
        hbHealsIn[xGUID]=nil
    end
end





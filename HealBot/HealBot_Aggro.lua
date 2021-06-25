local HealBot_Aggro_rCalls={}
local tConcat={}
local HealBot_Aggro_luVars={}
HealBot_Aggro_luVars["pluginThreat"]=false

function HealBot_Aggro_setLuVars(vName, vValue)
    HealBot_Aggro_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Aggro_setLuVars - "..vName)
end

function HealBot_Aggro_retLuVars(vName)
    return HealBot_Aggro_luVars[vName]
end

function HealBot_Aggro_Concat(elements)
    return table.concat(tConcat,"",1,elements)
end

function HealBot_Aggro_IndicatorClear(button)
    button.aggro.ind=0
    button.gref.indicator.aggro["Iconal1"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconar1"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
end

function HealBot_Aggro_IndicatorUpdate(button)
    if button.status.current<9 and button.frame<10 and button.aggro.status>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIND"] then
        if button.aggro.status==1 then
            if button.aggro.ind~=1 then
                button.aggro.ind=1
                button.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
            end
        elseif button.aggro.status==2 then
            if button.aggro.ind~=2 then
                button.aggro.ind=2
                button.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
            end
        elseif button.aggro.status==3 then
            if button.aggro.ind~=3 then
                button.aggro.ind=3
                button.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal3"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar3"]:SetAlpha(1)
            end
        end
    elseif button.aggro.ind~=0 then
        HealBot_Aggro_IndicatorClear(button)
    end
      --HealBot_setCall("HealBot_Aggro_IndicatorUpdate")
end

function HealBot_Aggro_UpdateUnit(button,status,threatStatus,threatPct,extra,threatValue,mobName)
    if button.status.current<9 and UnitIsFriend("player",button.unit) then
        if status then
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then
                if threatStatus>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                    HealBot_Aux_UpdateAggroBar(button)
                else
                    HealBot_Aux_ClearAggroBar(button)
                end
            end
        else
            threatStatus=0
            HealBot_Aux_ClearAggroBar(button)
        end
    else
        HealBot_Aux_ClearAggroBar(button)
        threatPct=0
        threatStatus=0
        threatValue=0
        mobName=""
    end
    if (button.aggro.status==3 or threatStatus==3) and button.aggro.status~=threatStatus then
        button.status.refresh=true
    end
    button.aggro.status=threatStatus
    if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] and 
       Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWIND"] then
        HealBot_Aggro_IndicatorUpdate(button)
    end
    if button.aggro.threatpct~=threatPct or button.aggro.threatvalue~=threatValue or button.aggro.mobname~=mobName then 
        button.aggro.threatpct=threatPct
        button.aggro.threatvalue=threatValue
        button.aggro.mobname=mobName
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXT"]>1 then
            HealBot_Text_setNameText(button)
        end
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] then
            HealBot_Text_setAggroText(button)
        end
        if HealBot_Aggro_luVars["pluginThreat"] and button.status.plugin then HealBot_Plugin_Threat_UnitUpdate(button) end
        if HealBot_Data["TIPBUTTON"] and HealBot_Data["TIPBUTTON"]==button then HealBot_Action_RefreshTooltip() end
        if threatPct<1 then
            HealBot_Aux_ClearThreatBar(button)
        else
            HealBot_Aux_UpdateThreatBar(button)
        end
    end
      --HealBot_setCall("HealBot_Aggro_UpdateUnit")
end

local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={}
local HealBot_UnitBuffCurrent={}
local HealBot_UnitDebuffCurrent={}
local HealBot_UnitExtraIcons={}
local HealBot_BuffNameTypes = {}
local HealBot_BuffMinLevels={}
local HealBot_AuraBuffCache={}
local HealBot_AuraBuffIconCache={}
local HealBot_AuraDebuffCache={}
local HealBot_AuraDebuffIconCache={}
local libCD=nil
local TimeNow=GetTime()
local HealBot_ExcludeBuffInCache={}
local HealBot_ExcludeEnemyInCache={}
local HealBot_Aura_WarningFilter={}
local HealBot_Aura_CanDispell={}
local HealBot_Aura_prevIconCount={["DEBUFF"]={[1]=0,[2]=0,[3]=0,},["BUFF"]={[1]=0,[2]=0,[3]=0,} }
local HealBot_Watch_HoT={};
local HealBot_CheckBuffs = {}
local HealBot_ShortBuffs = {}
local HealBot_BuffWatch={}
local HealBot_BuffWatchList={}
local PlayerBuffs = {}
local PlayerBuffTypes = {}
local buffSort={[1]={},[2]={},[3]={}}
local buffAuraCache={}
local debuffSort={[1]={},[2]={},[3]={}}
local debuffAuraCache={}
local HealBot_Aura_ID={}
local HealBot_Aura_IconSet={}
local HealBot_SpellID_LookupData={}
local HealBot_SpellID_LookupIdx={}
local _
local HealBot_Buff_Aura2Item={};
local HealBot_Buff_ItemIDs={};
local buffCheck, generalBuffs, buffWarnings, debuffCheck, debuffWarnings=false,false,false,true,true
local tmpBCheck, tmpCBuffs, tmpGBuffs, tmpDCheck=false,false,false,false
local uaName, uaTexture, uaCount, uaDebuffType, uaDuration = "","",0,"",0
local uaExpirationTime, uaUnitCaster, uaSpellId, uaIsBossDebuff, uaUnitCasterIsPlayer = 0,"",0,false,false
local classicAbsorbPWS=""
local HealBot_Classic_Absorbs={}
local HealBot_TargetIconsTextures = {[1]=[[Interface\Addons\HealBot\Images\Star.tga]],
                                     [2]=[[Interface\Addons\HealBot\Images\Circle.tga]],
                                     [3]=[[Interface\Addons\HealBot\Images\Diamond.tga]],
                                     [4]=[[Interface\Addons\HealBot\Images\Triangle.tga]],
                                     [5]=[[Interface\Addons\HealBot\Images\Moon.tga]],
                                     [6]=[[Interface\Addons\HealBot\Images\Square.tga]],
                                     [7]=[[Interface\Addons\HealBot\Images\Cross.tga]],
                                     [8]=[[Interface\Addons\HealBot\Images\Skull.tga]],}
local HealBot_Weapon_Enchant={[1]=false,[2]=false}
local HealBot_Aura_AuxAssigns={}
HealBot_Aura_AuxAssigns["NameOverlayBuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["NameOverlayDebuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["HealthOverlayBuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["HealthOverlayDebuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_Aura_luVars={}
HealBot_Aura_luVars["TankUnit"]="x"
HealBot_Aura_luVars["mapName"]=HEALBOT_WORD_OUTSIDE
HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]=-1
HealBot_Aura_luVars["cureOffCd"]=true
HealBot_Aura_luVars["HotBarDebuff"]=0
HealBot_Aura_luVars["ManaDrink"]=""
HealBot_Aura_luVars["WellFed"]=""
local unitCurrentDebuff={}
unitCurrentDebuff.active=false
unitCurrentDebuff.id=0
unitCurrentDebuff.prio=99
local unitCurrentBuff={}
unitCurrentBuff.active=false
unitCurrentBuff.id=0
unitCurrentBuff.name=""
unitCurrentBuff.prio=99
local classicAbsorbBonus={["DEFAULT"]=0}
local classicAbsorbPWSMulti={["DEFAULT"]=1}

if HEALBOT_GAME_VERSION<2 then
    libCD = HealBot_Libs_CD()
    if libCD then libCD:Register(HEALBOT_HEALBOT) end
end

function HealBot_Aura_setLuVars(vName, vValue)
    HealBot_Aura_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Aura_setLuVars - "..vName)
end

function HealBot_Aura_retLuVars(vName)
      --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_Aura_luVars[vName]
end

function HealBot_Aura_setAuxAssigns(vName, frame, vValue)
    HealBot_Aura_AuxAssigns[vName][frame]=vValue
end

function HealBot_Aura_TimeNow(now)
    TimeNow=now
end

function HealBot_Aura_retRaidtargetIcon(id)
    return HealBot_TargetIconsTextures[id]
end

function HealBot_Aura_ResetBuffCache()
    for spellId,_ in pairs(HealBot_AuraBuffCache) do
        HealBot_Aura_IconSet[spellId]=nil
        HealBot_AuraBuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomBuffFilterDisabled")
end

function HealBot_Aura_ResetDebuffCache()
    for spellId,_ in pairs(HealBot_AuraDebuffCache) do
        HealBot_AuraDebuffCache[spellId].always=false
        HealBot_Aura_IconSet[spellId]=nil
        HealBot_AuraDebuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomDebuffFilterDisabled")
    HealBot_Timers_Set("AURA","CheckUnits")
end

function HealBot_Aura_DeleteExcludeBuffInCache()
    for id,_ in pairs(HealBot_ExcludeBuffInCache) do
        HealBot_ExcludeBuffInCache[id]=nil
    end
    HealBot_setLuVars("UpdateAllAura", 5)
    HealBot_Aura_luVars["updateAll"]=true
    HealBot_Timers_Set("AURA","CheckUnits")
end

function HealBot_Aura_RemoveIcon(button, index)
    if not button then return; end;
    button.gref.icon[index]:SetAlpha(0)
    if index<90 then
        button.gref.txt.expire[index]:SetTextColor(1,1,1,0);
        button.gref.txt.count[index]:SetTextColor(1,1,1,0)
        button.gref.txt.expire[index]:SetText(" ");
        button.gref.txt.count[index]:SetText(" ");
        if index<50 then
            if HealBot_UnitBuffIcons[button.id] then
                HealBot_UnitBuffIcons[button.id][index].current=false
            end
            button.gref.indicator.selfcast[index]:SetAlpha(0)
            if button.glow.icon[index]>1 then
                HealBot_Action_DisableIconGlow(button, "ICONBUFF", index)
            end
        else
            if HealBot_UnitDebuffIcons[button.id] then
                HealBot_UnitDebuffIcons[button.id][index].current=false
            end
            if button.glow.icon[index]>1 then
                HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
            end
        end
        button.gref.iconf[index]:SetFrameLevel(0)
    else
        if HealBot_UnitExtraIcons[button.id] then
            HealBot_UnitExtraIcons[button.id][index].current=false
        end
        if index==91 then
            button.icon.extra.classtexture=false
        elseif index==92 then
            button.icon.extra.targeticon=0
        elseif index==93 then
            button.icon.extra.readycheck=false
        end
    end
      --HealBot_setCall("HealBot_Aura_RemoveIcon")
end

function HealBot_Aura_RemoveBuffIcons(button)
    if button.frame>0 then
        for i=1,button.icon.buff.count[1] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=9,8+button.icon.buff.count[2] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=13,12+button.icon.buff.count[3] do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
end

function HealBot_Aura_RemoveAllBuffIcons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
end

function HealBot_Aura_RemoveUnusedBuffIcons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]+1,5 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]+6,7 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]+8,9 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]+1,5 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]+6,7 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]+8,9 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]+1,5 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]+6,7 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]+8,9 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]+1,5 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]+6,7 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]+8,9 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXBICONS"]+1,5 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXBICONS"]+6,7 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXBICONS"]+8,9 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
end

function HealBot_Aura_RemoveDebuffIcons(button)
    if button.frame>0 then
        for i=51,50+button.icon.debuff.count[1] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=56,55+button.icon.debuff.count[2] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=58,57+button.icon.debuff.count[3] do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
end

function HealBot_Aura_RemoveAllDebuffIcons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
end

function HealBot_Aura_RemoveUnusedDebuffIcons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]+51,55 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]+56,57 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]+58,59 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]+51,55 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]+56,57 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]+58,59 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]+51,55 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]+56,57 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]+58,59 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]+51,55 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]+56,57 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]+58,59 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]+51,55 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]+56,57 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]+58,59 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]<5 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][1]["MAXDICONS"]+51,55 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][2]["MAXDICONS"]+56,57 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]<2 then
            for i = Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][xButton.frame][3]["MAXDICONS"]+58,59 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
end

function HealBot_Aura_RemoveExtraUnitIcons(button, index)
    HealBot_Aura_RemoveIcon(button, index)
        --HealBot_setCall("HealBot_Aura_RemoveExtraUnitIcons")
end

function HealBot_Aura_RemoveExtraIcons(index)
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
end

local auSecsLeft,iconAlpha=0,0
function HealBot_Aura_UpdateExtraIcon(button, iconData, index)
    if (index==91 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSEN"]) or
       (index==92 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["TARGETEN"]) or
       (index==93 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["RCEN"]) or
       (index==94 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["OOREN"]) then
        iconAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
    else
        iconAlpha=button.status.alpha
    end
    button.gref.icon[index]:SetAlpha(iconAlpha)
      --HealBot_setCall("HealBot_Aura_UpdateExtraIcon")
end

local retAlpha, fadeDiff, nextAuraUpdate=0,0,1
function HealBot_Aura_IconAlphaValue(secLeft, button, fade, fadeSecs, alwaysEnabled, buffIcon)
    nextAuraUpdate=999
    if secLeft>-2 then
        if fade then
            if secLeft<fadeSecs then
                nextAuraUpdate=0.2
                if secLeft<1 then
                    if secLeft>-1 then
                        secLeft=0.75
                    else
                        secLeft=0.5
                    end
                end
                fadeDiff=secLeft/fadeSecs
                retAlpha=fadeDiff+((1-fadeDiff)/3)
                if alwaysEnabled then
                    if retAlpha>HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1) then
                        retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                    end
                elseif retAlpha>button.status.alpha then
                    retAlpha=button.status.alpha
                end
            else
                nextAuraUpdate=secLeft-fadeSecs
                if alwaysEnabled then
                    retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                else
                    retAlpha=button.status.alpha
                end
            end
        elseif alwaysEnabled then
            retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
        else
            retAlpha=button.status.alpha
        end
    else
        retAlpha=0
        if buffIcon then
            HealBot_Check_UnitBuff(button)
        else
            HealBot_Check_UnitDebuff(button)
        end
    end
      --HealBot_setCall("HealBot_Aura_IconAlphaValue")
    return retAlpha, nextAuraUpdate
end

local alphaNextUpdate, durNextUpdate=0,0
function HealBot_Aura_UpdateIcon(button, iconData, index, timer, lastSpellId, fade, fadeSecs, alwaysEnabled, showDur, showSelfDur, durThrh, durWarn, showCnt, showSelfCnt, selfInd, buffIcon, srcTimer)
    if iconData.current and lastSpellId==iconData["spellId"] then
        alphaNextUpdate=999
        durNextUpdate=999
        auSecsLeft=floor((iconData.expirationTime-TimeNow)-0.5)
        if iconData.expirationTime>0 then
            iconAlpha, alphaNextUpdate=HealBot_Aura_IconAlphaValue(auSecsLeft, button, fade, fadeSecs, alwaysEnabled, buffIcon)
        elseif alwaysEnabled then
            iconAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
        else
            iconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(iconAlpha)
        if auSecsLeft>-2 and showDur and (not showSelfDur or UnitIsUnit(iconData.unitCaster,"player")) then
            if auSecsLeft<=durThrh then
                if auSecsLeft<=durWarn then
                    if UnitIsFriend("player",button.unit) then
                        if buffIcon then
                            button.gref.txt.expire[index]:SetTextColor(1,0.5,0,iconAlpha)
                        else
                            button.gref.txt.expire[index]:SetTextColor(0,1,0,iconAlpha)
                        end
                    else
                        button.gref.txt.expire[index]:SetTextColor(1,0,0,iconAlpha);
                    end
                    if auSecsLeft>-1 then
                        button.gref.txt.expire[index]:SetText(auSecsLeft);
                    else
                        button.gref.txt.expire[index]:SetText("0")
                    end
                else
                    button.gref.txt.expire[index]:SetTextColor(1,1,1,iconAlpha);
                    button.gref.txt.expire[index]:SetText(auSecsLeft)
                end
                durNextUpdate=1
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                if (iconData.expirationTime-TimeNow-1)>durThrh then
                    durNextUpdate=(iconData.expirationTime-TimeNow-1)-durThrh
                else
                    durNextUpdate=1
                end
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if not srcTimer then
            if buffIcon then
                if selfInd and UnitIsUnit(iconData.unitCaster,"player") then
                    button.gref.indicator.selfcast[index]:SetAlpha(HealBot_Action_BarColourAlpha(button, 1, 1))
                else
                    button.gref.indicator.selfcast[index]:SetAlpha(0)
                end
            end
            if iconData.count > 1 and showCnt and (not showSelfCnt or UnitIsUnit(iconData.unitCaster,"player")) then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,iconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if alphaNextUpdate<durNextUpdate then
                C_Timer.After(alphaNextUpdate, function() HealBot_Aura_UpdateIcon(button, iconData, index, true, lastSpellId, fade, fadeSecs, alwaysEnabled, showDur, showSelfDur, durThrh, durWarn, showCnt, showSelfCnt, selfInd, buffIcon, true) end)
            elseif durNextUpdate<999 then
                C_Timer.After(durNextUpdate, function() HealBot_Aura_UpdateIcon(button, iconData, index, true, lastSpellId, fade, fadeSecs, alwaysEnabled, showDur, showSelfDur, durThrh, durWarn, showCnt, showSelfCnt, selfInd, buffIcon, true) end)
            end
        end
        return iconAlpha
    end
      --HealBot_setCall("HealBot_Aura_UpdateDebuffIcon")
end

local hbGlowSpellName,hbGlowIdx="",1
local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
local iAlpha=1
function HealBot_Aura_UpdateDebuffIcon(button, iconData, index, timer, spellId, iconSet)
    iAlpha=HealBot_Aura_UpdateIcon(button, iconData, index, timer, spellId,
                                   Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DFADE"],
                                   Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DFADESECS"],
                                   Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DI15EN"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DBSDUR"],
                                   false,
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DBDURTHRH"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DBDURWARN"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["DBSCNT"],
                                   false,
                                   false,
                                   false)
    if iAlpha and HealBot_AuraDebuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraDebuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[spellId] or HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        if HealBot_Globals.CDCBarColour[spellId] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CDCBarColour[spellId]["R"] or 1, 
                                          HealBot_Globals.CDCBarColour[spellId]["G"] or 0.25, 
                                          HealBot_Globals.CDCBarColour[spellId]["B"] or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          iAlpha)
        elseif HealBot_Globals.CDCBarColour[hbGlowSpellName] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].R or 1, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          iAlpha)
        else
            HealBot_Action_EnableIconGlow(button,  
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].R or 1, 
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          iAlpha)
        end
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
    end
end

local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
function HealBot_Aura_UpdateBuffIcon(button, iconData, index, timer, spellId, iconSet)
    iAlpha=HealBot_Aura_UpdateIcon(button, iconData, index, timer, spellId,
                                   Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFFADE"],
                                   Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFFADESECS"],
                                   Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFI15EN"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFSDUR"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFSSDUR"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFDURTHRH"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFDURWARN"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFSCNT"],
                                   Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["BUFFSSCNT"],
                                   Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SELFIND"],
                                   true)
    if iAlpha and HealBot_AuraBuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraBuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_Globals.HealBot_Custom_Buffs_IconGlow[spellId] or HealBot_Globals.HealBot_Custom_Buffs_IconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        if HealBot_Globals.CustomBuffBarColour[spellId] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].R or 0.45, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].G or 0, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].B or 0.26, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          iAlpha)
        elseif HealBot_Globals.CustomBuffBarColour[hbGlowSpellName] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].R or 0.45, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].G or 0, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].B or 0.26, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          iAlpha)
        else
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].R or 0.45, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].G or 0, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].B or 0.26, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          iAlpha)
        end
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONBUFF", index)
    end
end

function HealBot_Aura_AddExtraIcon(button, index)
    button.gref.icon[index]:SetTexture(HealBot_UnitExtraIcons[button.id][index]["texture"])
    --if index==94 then HealBot_Action_SetDirectionArrow(button) end
    HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
      --HealBot_setCall("HealBot_Aura_AddExtraIcon")
end

function HealBot_Aura_AddBuffIcon(button, index)
    button.gref.icon[index]:SetTexture(HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][index]["spellId"]]["texture"])
    button.gref.iconf[index]:SetFrameLevel(1000)
    HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][index], index, true, HealBot_UnitBuffIcons[button.id][index]["spellId"], HealBot_UnitBuffIcons[button.id][index]["iconSet"])
      --HealBot_setCall("HealBot_Aura_AddBuffIcon")
end

function HealBot_Aura_DebuffAddIcon(button, index)
    button.gref.icon[index]:SetTexture(HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][index]["spellId"]]["texture"])
    button.gref.iconf[index]:SetFrameLevel(1000)
    HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][index], index, true, HealBot_UnitDebuffIcons[button.id][index]["spellId"], HealBot_UnitDebuffIcons[button.id][index]["iconSet"])
      --HealBot_setCall("HealBot_Aura_DebuffAddIcon")
end

local rtuPrevId=false
function HealBot_Aura_RaidTargetUpdate(button, iconID)
    rtuPrevId=button.icon.extra.targeticon
    button.icon.extra.targeticon=iconID
    if button.icon.extra.targeticon~=rtuPrevId and HealBot_UnitExtraIcons[button.id] then
        if not HealBot_TargetIconsTextures[button.icon.extra.targeticon] then
            HealBot_Aura_RemoveIcon(button, 92)
        elseif not HealBot_UnitExtraIcons[button.id][92].current or
           HealBot_UnitExtraIcons[button.id][92]["texture"]~=HealBot_TargetIconsTextures[button.icon.extra.targeticon] then
            HealBot_UnitExtraIcons[button.id][92]["texture"]=HealBot_TargetIconsTextures[button.icon.extra.targeticon]
            HealBot_UnitExtraIcons[button.id][92].current=true
            HealBot_Aura_AddExtraIcon(button, 92)
        end
    end
        --HealBot_setCall("HealBot_Aura_RaidTargetUpdate")
end

local cuPrevTexture=false
function HealBot_Aura_ClassUpdate(button, texture)
    cuPrevTexture=button.icon.extra.classtexture
    button.icon.extra.classtexture=texture
    if button.icon.extra.classtexture~=cuPrevTexture and HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.classtexture then 
            HealBot_Aura_RemoveIcon(button, 91)
        elseif not HealBot_UnitExtraIcons[button.id][91].current or
           HealBot_UnitExtraIcons[button.id][91]["texture"]~=button.icon.extra.classtexture then
            HealBot_UnitExtraIcons[button.id][91]["texture"]=button.icon.extra.classtexture
            HealBot_UnitExtraIcons[button.id][91].current=true
            HealBot_Aura_AddExtraIcon(button, 91)
        end
    end
        --HealBot_setCall("HealBot_Aura_ClassUpdate")
end

local hbIconRanks={[1]="Interface\\Addons\\HealBot\\Images\\leader.tga",
                   [2]="Interface\\Addons\\HealBot\\Images\\assist.tga",
                   [3]="Interface\\Addons\\HealBot\\Images\\looter.tga",
                   [4]="Interface\\Addons\\HealBot\\Images\\leader.tga",
                   }
function HealBot_Aura_UpdateState(button)
    if HealBot_UnitExtraIcons[button.id] then
        if button.status.hostile or button.status.incombat or button.icon.extra.readycheck or button.status.afk then
            if button.status.afk then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\afk.tga"
            elseif button.status.hostile then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\hostile.tga"
            elseif button.status.incombat then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\incombat.tga"
            else
                HealBot_UnitExtraIcons[button.id][93]["texture"]=button.icon.extra.readycheck
                if HealBot_Panel_RaidUnitGUID(button.guid) then HealBot_Action_setGuidData(button, "READYCHECK", button.icon.extra.readycheck) end
            end
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        elseif button.rank>0 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRANK"] then
            HealBot_UnitExtraIcons[button.id][93]["texture"]=hbIconRanks[button.rank]
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        elseif button.player and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRESTING"] and IsResting() then 
            HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\rested.tga"
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        else
            HealBot_Aura_RemoveIcon(button, 93)
        end
    end
end

local ooruPrevTexture=false
function HealBot_Aura_OORUpdate(button, texture)
    button.icon.extra.oorarrow=texture
    if HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.oorarrow then 
            HealBot_Aura_RemoveIcon(button, 94)
        else
            HealBot_UnitExtraIcons[button.id][94]["texture"]=button.icon.extra.oorarrow
            HealBot_UnitExtraIcons[button.id][94].current=true
            HealBot_Action_SetDirectionArrow(button, 94)
            HealBot_Aura_AddExtraIcon(button, 94)
        end
    end
        --HealBot_setCall("HealBot_Aura_OORUpdate")
end

function HealBot_Aura_InitUnitBuffIcons(buttonId)
    HealBot_UnitBuffIcons[buttonId]={}
    for i = 1,9 do
        HealBot_UnitBuffIcons[buttonId][i]={}
        HealBot_UnitBuffIcons[buttonId][i]["count"]=0
        HealBot_UnitBuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitBuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitBuffIcons[buttonId][i]["type"]="x"
        HealBot_UnitBuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitBuffIcons[buttonId][i]["iconSet"]=1
        HealBot_UnitBuffIcons[buttonId][i].current=false
    end
end

function HealBot_Aura_InitUnitDebuffIcons(buttonId)
    HealBot_UnitDebuffIcons[buttonId]={}
    for i = 51,59 do
        HealBot_UnitDebuffIcons[buttonId][i]={}
        HealBot_UnitDebuffIcons[buttonId][i]["count"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["type"]="x"
        HealBot_UnitDebuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitDebuffIcons[buttonId][i]["iconSet"]=1
        HealBot_UnitDebuffIcons[buttonId][i].current=false
    end
end

function HealBot_Aura_InitUnitAuraCurrent(id)
    if not HealBot_UnitBuffCurrent[id] then HealBot_UnitBuffCurrent[id]={} end
    if not HealBot_UnitDebuffCurrent[id] then HealBot_UnitDebuffCurrent[id]={} end
end

function HealBot_Aura_InitUnitExtraIcons(buttonId)
    HealBot_UnitExtraIcons[buttonId]={}
    for i = 91,94 do
        HealBot_UnitExtraIcons[buttonId][i]={}
        HealBot_UnitExtraIcons[buttonId][i]["texture"]=""
        HealBot_UnitExtraIcons[buttonId][i].current=false
    end
end

function HealBot_Aura_setButtonIcons(buttonId)
    HealBot_Aura_InitUnitDebuffIcons(buttonId) 
    HealBot_Aura_InitUnitBuffIcons(buttonId) 
    HealBot_Aura_InitUnitExtraIcons(buttonId) 
      --HealBot_setCall("HealBot_Aura_setButtonIcons")
end

function HealBot_Aura_setUnitIcons(unit)
    if not HealBot_Aura_WarningFilter[unit] then
        HealBot_Aura_WarningFilter[unit]={}
    end
      --HealBot_setCall("HealBot_Aura_setUnitIcons")
end

function HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
    for dID, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if not GetSpellInfo(dID) and dID==name then
            HealBot_Globals.Custom_Debuff_Categories[spellId]=HealBot_Globals.Custom_Debuff_Categories[name]
            HealBot_Globals.HealBot_Custom_Debuffs[spellId]=x
            if HealBot_Globals.FilterCustomDebuff[name] then 
                HealBot_Globals.FilterCustomDebuff[spellId]=HealBot_Globals.FilterCustomDebuff[name]
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[name] then
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[name]
            end
            if HealBot_Globals.CDCBarColour[name] then
                HealBot_Globals.CDCBarColour[spellId]=HealBot_Options_copyTable(HealBot_Globals.CDCBarColour[name])
            end
            if HealBot_Globals.IgnoreCustomDebuff[name] then
                HealBot_Globals.IgnoreCustomDebuff[spellId]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomDebuff[name])
            end
            HealBot_Options_DeleteCDebuff(name, name)
            break
        end
    end
    HealBot_Timers_Set("AURA","CustomDebuffListPrep")
end

function HealBot_Aura_CacheDebuffIcon(button, id, spellId, index)
    HealBot_UnitDebuffIcons[button.id][id]["type"]=HealBot_AuraDebuffCache[spellId]["type"]
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitDebuffIcons[button.id][id]["count"]~=debuffAuraCache[index]["count"] or
       HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=debuffAuraCache[index]["expiration"] or
       HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]~=debuffAuraCache[index]["caster"] then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=debuffAuraCache[index]["count"]
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=debuffAuraCache[index]["expiration"]
        HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]=debuffAuraCache[index]["caster"]
        HealBot_UnitDebuffIcons[button.id][id]["iconSet"]=HealBot_AuraDebuffCache[spellId]["iconSet"]
        if HealBot_UnitDebuffIcons[button.id][id].current then
            if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId then
                HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
                button.gref.icon[id]:SetTexture(HealBot_AuraDebuffCache[spellId]["texture"])
                HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, true, spellId, HealBot_AuraDebuffCache[spellId]["iconSet"])
            else
                HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, false, spellId, HealBot_AuraDebuffCache[spellId]["iconSet"])
            end
        else
            HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
        end
    end
end

local hbCustomDebuffsCastBy={}
local hbCustomDebuffsDisabled={}

function HealBot_Aura_SetDebuffIcon()
    if (hbCustomDebuffsDisabled[uaSpellId] and (hbCustomDebuffsDisabled[uaSpellId][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaName] and (hbCustomDebuffsDisabled[uaName][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaName]["ALL"])) then
        return false
    else
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["count"]=uaCount
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["expiration"]=uaExpirationTime
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["caster"]=uaUnitCaster
        table.insert(debuffSort[HealBot_Aura_IconSet[uaSpellId]],HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"])
    end
      --HealBot_setCall("HealBot_Aura_SetDebuffIcon")
    return true
end

function HealBot_Aura_SortDebuffIcons(button)
    button.icon.debuff.count[1]=#debuffSort[1]
    if button.icon.debuff.count[1]>0 then
        table.sort(debuffSort[1])
        if button.icon.debuff.count[1]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXDICONS"] then
            button.icon.debuff.count[1]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXDICONS"]
        end
        for j=1, button.icon.debuff.count[1], 1 do
            HealBot_Aura_CacheDebuffIcon(button, 50+j, debuffAuraCache[debuffSort[1][j]]["spellId"], debuffSort[1][j])
        end
    end
    button.icon.debuff.count[2]=#debuffSort[2]
    if button.icon.debuff.count[2]>0 then
        table.sort(debuffSort[2])
        if button.icon.debuff.count[2]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXDICONS"] then
            button.icon.debuff.count[2]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXDICONS"]
        end
        for j=1, button.icon.debuff.count[2], 1 do
            HealBot_Aura_CacheDebuffIcon(button, 55+j, debuffAuraCache[debuffSort[2][j]]["spellId"], debuffSort[2][j])
        end
    end
    button.icon.debuff.count[3]=#debuffSort[3]
    if button.icon.debuff.count[3]>0 then
        table.sort(debuffSort[3])
        if button.icon.debuff.count[3]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXDICONS"] then
            button.icon.debuff.count[3]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXDICONS"]
        end
        for j=1, button.icon.debuff.count[3], 1 do
            HealBot_Aura_CacheDebuffIcon(button, 57+j, debuffAuraCache[debuffSort[3][j]]["spellId"], debuffSort[3][j])
        end
    end
end

function HealBot_Aura_CacheBuffIcon(button, id, spellId, index)
    HealBot_UnitBuffIcons[button.id][id]["type"]=HealBot_AuraBuffCache[spellId]["type"]
    if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitBuffIcons[button.id][id]["count"]~=buffAuraCache[index]["count"] or
       HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=buffAuraCache[index]["expiration"] or
       HealBot_UnitBuffIcons[button.id][id]["unitCaster"]~=buffAuraCache[index]["caster"] then
        HealBot_UnitBuffIcons[button.id][id]["count"]=buffAuraCache[index]["count"]
        HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=buffAuraCache[index]["expiration"]
        HealBot_UnitBuffIcons[button.id][id]["unitCaster"]=buffAuraCache[index]["caster"]
        HealBot_UnitBuffIcons[button.id][id]["iconSet"]=HealBot_AuraBuffCache[spellId]["iconSet"]
        if HealBot_UnitBuffIcons[button.id][id].current then
            if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId then
                HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
                button.gref.icon[id]:SetTexture(HealBot_AuraBuffCache[spellId]["texture"])
                HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, true, spellId, HealBot_UnitBuffIcons[button.id][id]["iconSet"])
            else
                HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, false, spellId, HealBot_UnitBuffIcons[button.id][id]["iconSet"])
            end
        else
            HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
        end
    end
end

function HealBot_Aura_Counts(button)
    HealBot_AddDebug("button count="..button.icon.debuff.count[1].."  Aura Count="..HealBot_Aura_prevIconCount["DEBUFF"][1],"DebuffSet",true)
end

local debuffIndex=0
function HealBot_Aura_CheckUnitDebuffIcons(button)
    for i=51,55 do
        if i<=(50+button.icon.debuff.count[1]) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            end
        elseif i<=(50+HealBot_Aura_prevIconCount["DEBUFF"][1]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=56,57 do
        if i<=(55+button.icon.debuff.count[2]) then
            --if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            --end
        elseif i<=(55+HealBot_Aura_prevIconCount["DEBUFF"][2]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=58,59 do
        if i<=(57+button.icon.debuff.count[3]) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            end
        elseif i<=(57+HealBot_Aura_prevIconCount["DEBUFF"][3]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffIcons")
end

local hasBuffTypes, ownBlessing = false, false
function HealBot_Aura_HasBuffTypes(spellName, pBuffTypes)
    hasBuffTypes = false
    if HealBot_BuffNameTypes[spellName] then
        if pBuffTypes[HealBot_BuffNameTypes[spellName]] or (ownBlessing and HealBot_BuffNameTypes[spellName]<7 and HealBot_Config_Buffs.PalaBlessingsAsOne) then
            hasBuffTypes = true
        end
    end
      --HealBot_setCall("HealBot_Aura_HasBuffTypes")
    return hasBuffTypes
end

local curBuffName,curBuffxTime=false,0
local buffCheckThis, buffWatchTarget, buffSpellStart, buffSpellDur=false,false,0,0
local weaponEnchantState={[1]={["Active"]=false,["Expire"]=0},[2]={["Active"]=false,["Expire"]=0}}
function HealBot_Aura_SetGeneralBuff(button, bName)
    curBuffName=bName
    button.aura.buff.missingbuff=bName
    button.aura.buff.colbar=(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol["DEFAULT"] or 4)-1
    --button.aura.buff.priority=21
end

local buffWatchName=""
function HealBot_Aura_CheckGeneralBuff(button)  
    PlayerBuffsList=button.aura.buff.recheck
    for bName,nexttime in pairs (PlayerBuffsList) do
        if not PlayerBuffs[bName] then
            PlayerBuffsList[bName]=nil
            HealBot_Aura_MarkCheckBuffsTime(button)
        elseif nexttime < TimeNow then
            PlayerBuffs[bName]=false
        end
    end
    for j=1, #HealBot_BuffWatchList do
        buffWatchName=HealBot_BuffWatchList[j]
        if HEALBOT_GAME_VERSION<4 and HealBot_BuffMinLevels[buffWatchName] then
            if button.level<HealBot_BuffMinLevels[buffWatchName] then
                PlayerBuffs[buffWatchName]=true
            end
        end
        if not PlayerBuffs[buffWatchName] and not HealBot_Aura_HasBuffTypes(buffWatchName, PlayerBuffTypes) then
            buffSpellStart, buffSpellDur=0,0
            if GetSpellCooldown(buffWatchName) then
                buffSpellStart, buffSpellDur=GetSpellCooldown(buffWatchName)
            elseif HealBot_Buff_ItemIDs[buffWatchName] then
                buffSpellStart, buffSpellDur=HealBot_GetItemCooldown(HealBot_Buff_ItemIDs[buffWatchName])
            end 
            if ((buffSpellStart or 0)+(buffSpellDur or 0))-TimeNow<2 then
                buffCheckThis=false;
                buffWatchTarget=HealBot_Options_retBuffWatchTarget(buffWatchName) or "";
                if buffWatchTarget["Raid"] then
                    buffCheckThis=true;
                elseif buffWatchTarget["Self"] and button.player then
                    if HealBot_Aura_luVars["ManaDrink"]~=buffWatchName or button.mana.pct<HealBot_Config_Buffs.ManaDrinkThreshold then
                        buffCheckThis=true
                    end
                elseif buffWatchTarget["Party"] and button.group==HealBot_Data["PLAYERGROUP"] then 
                    buffCheckThis=true
                elseif buffWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    buffCheckThis=true
                elseif buffWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    buffCheckThis=true;
                elseif buffWatchTarget["SingleTank"] and UnitIsUnit(button.unit, HealBot_Aura_luVars["TankUnit"]) then
                    buffCheckThis=true
                elseif buffWatchTarget[button.text.classtrim] then
                    buffCheckThis=true
                elseif buffWatchTarget["Name"] and button.guid==HealBot_Config.MyFriend then
                    buffCheckThis=true
                elseif buffWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    buffCheckThis=true
                elseif buffWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["MyTargets"] and HealBot_Panel_IsMyTarget(button.guid) then
                    buffCheckThis=true;
                end
                if buffCheckThis then
                    HealBot_Aura_SetGeneralBuff(button, buffWatchName)
                    break
                end
            else
                button.aura.buff.recheck[buffWatchName] = (TimeNow-buffSpellStart)+buffSpellDur
                HealBot_Aura_MarkCheckBuffsTime(button)
            end
        end
    end
    if not button.aura.buff.missingbuff and button.player and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
        if HealBot_Weapon_Enchant[1] or HealBot_Weapon_Enchant[2] then
            weaponEnchantState[1]["Active"], weaponEnchantState[1]["Expire"], _, _, weaponEnchantState[2]["Active"], weaponEnchantState[2]["Expire"] = GetWeaponEnchantInfo()
            -- local hasMainHandEnchant, mainHandExpiration, _, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, _, offHandEnchantID = GetWeaponEnchantInfo()
            for x=1,2 do
                if HealBot_Weapon_Enchant[x] then
                    if weaponEnchantState[x]["Active"] then
                        if not weaponEnchantState[x]["Expire"] then weaponEnchantState[x]["Expire"]=30*60*1000 end
                        if (weaponEnchantState[x]["Expire"]/1000)<HealBot_Config_Buffs.LongBuffTimer then
                            HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                        else
                            button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=ceil(TimeNow+(weaponEnchantState[x]["Expire"]/1000)-HealBot_Config_Buffs.LongBuffTimer)
                            if not button.aura.buff.nextcheck or button.aura.buff.nextcheck>button.aura.buff.recheck[HealBot_Weapon_Enchant[x]] then
                                HealBot_Aura_MarkCheckBuffsTime(button)
                            end
                        end
                    else
                        HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                        button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=nil
                        HealBot_Aura_MarkCheckBuffsTime(button)
                    end
                end
            end
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckGeneralBuff")
end

local buffCustomType,scbUnitClassEN=false,"XXXX"
function HealBot_Aura_ShowCustomBuff()
    buffCustomType=HealBot_Watch_HoT[uaName] or HealBot_Watch_HoT[uaSpellId] or false
    if buffCustomType then
        if buffCustomType=="A" then
            HealBot_Options_MissingBuffPrio(uaSpellId)
            return true, false
        elseif buffCustomType=="S" then
            if uaUnitCasterIsPlayer then
                HealBot_Options_MissingBuffPrio(uaSpellId)
                return true, false
            end
        elseif buffCustomType=="C" then
            _, scbUnitClassEN = UnitClass(uaUnitCaster)
            if scbUnitClassEN and HealBot_Data["PCLASSTRIM"]==strsub(scbUnitClassEN,1,4) then
                HealBot_Options_MissingBuffPrio(uaSpellId)
                return true, false
            end
        end
    else
        if uaExpirationTime>0 then
            if HealBot_Config_Buffs.AutoBuff==3 or (HealBot_Config_Buffs.AutoBuff==2 and uaDuration<HealBot_Config_Buffs.AutoBuffExpireTime) then
                if HealBot_Config_Buffs.AutoBuffCastBy==1 then
                    if uaUnitCasterIsPlayer then
                        return true, false
                    end
                elseif HealBot_Config_Buffs.AutoBuffCastBy==3 then
                    return true, false
                else
                    _, scbUnitClassEN = UnitClass(uaUnitCaster)
                    if scbUnitClassEN and HealBot_Data["PCLASSTRIM"]==strsub(scbUnitClassEN,1,4) then
                        return true, false
                    end
                end
                return false, false
            end
        end
        return false, true
    end
    return false, false
end

local ciCustomBuff,ciCanExclude=false,true
function HealBot_Aura_CheckCurBuff()
    ciCustomBuff,ciCanExclude=HealBot_Aura_ShowCustomBuff()
    if ciCustomBuff or HealBot_BuffWatch[uaName] or HealBot_BuffNameTypes[uaName] then
        if not HealBot_AuraBuffCache[uaSpellId] or HealBot_AuraBuffCache[uaSpellId].reset then
            if not HealBot_AuraBuffCache[uaSpellId] then HealBot_AuraBuffCache[uaSpellId]={} end
            HealBot_AuraBuffCache[uaSpellId]["priority"]=HealBot_Globals.HealBot_Custom_Buffs[uaName] or HealBot_Globals.HealBot_Custom_Buffs[uaSpellId] or 15
            HealBot_AuraBuffCache[uaSpellId]["texture"]=uaTexture
            HealBot_AuraBuffCache[uaSpellId]["name"]=uaName
            HealBot_AuraBuffCache[uaSpellId]["type"]=uaDebuffType
            HealBot_AuraBuffCache[uaSpellId]["iconSet"]=HealBot_Aura_IconSet[uaSpellId]
            if HealBot_SpellID_LookupData[uaName] and HealBot_SpellID_LookupData[uaName]["CHECK"] then
                HealBot_SpellID_LookupData[uaName]["CHECK"]=false
                HealBot_SpellID_LookupData[uaName]["ID"]=uaSpellId
                table.insert(HealBot_SpellID_LookupIdx,uaName)
                HealBot_Timers_Set("AURA","BuffIdLookup",1)
            end
        end
        if ciCustomBuff then
            if not HealBot_AuraBuffIconCache[uaUnitCaster] then HealBot_AuraBuffIconCache[uaUnitCaster]={} end
            if not HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId] or HealBot_AuraBuffCache[uaSpellId].reset then 
                HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]={}
                if HealBot_AuraBuffCache[uaSpellId]["priority"]<10 then
                    HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]="0"..HealBot_AuraBuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
                else
                    HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]=HealBot_AuraBuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
                end
                if not buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]] then
                    buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]={}
                end
                buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["spellId"]=uaSpellId
                HealBot_AuraBuffCache[uaSpellId].reset=false
            end
        elseif HealBot_AuraBuffCache[uaSpellId].reset then 
            HealBot_AuraBuffCache[uaSpellId].reset=false
        end
        return true, ciCustomBuff, ciCanExclude
    else
        return false, false, ciCanExclude
    end
end

local hbCustomBuffsDisabled={}
function HealBot_Aura_setCustomBuffFilterDisabled()
    for id,_ in pairs(hbCustomBuffsDisabled) do
        hbCustomBuffsDisabled[id]=false
    end
    for id, _ in pairs(HealBot_Globals.IgnoreCustomBuff) do
        local name, _, _, _, _, _, _ = GetSpellInfo(id)
        if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
            if HealBot_Globals.CustomBuffIDMethod[id]==1 then
                hbCustomBuffsDisabled[id]={}
            elseif name then 
                hbCustomBuffsDisabled[name]={}
            end
        else
            if name then hbCustomBuffsDisabled[name]={} end
            hbCustomBuffsDisabled[id]={}
        end
        for instName, disabled in pairs(HealBot_Globals.IgnoreCustomBuff[id]) do
            if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
                if HealBot_Globals.CustomBuffIDMethod[id]==1 then
                    hbCustomBuffsDisabled[id][instName]=disabled
                elseif name then 
                    hbCustomBuffsDisabled[name][instName]=disabled
                end
            else
                if name then hbCustomBuffsDisabled[name][instName]=disabled end
                hbCustomBuffsDisabled[id][instName]=disabled
            end
        end
    end
    for id,_ in pairs(hbCustomBuffsDisabled) do
        if not hbCustomBuffsDisabled[id] then hbCustomBuffsDisabled[id]=nil end
    end
    HealBot_Timers_Set("AURA","DeleteExcludeBuffInCache")
end

function HealBot_Aura_SetBuffIcon()
    if (hbCustomBuffsDisabled[uaSpellId] and (hbCustomBuffsDisabled[uaSpellId][HealBot_Aura_luVars["mapName"]] or hbCustomBuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomBuffsDisabled[uaName] and (hbCustomBuffsDisabled[uaName][HealBot_Aura_luVars["mapName"]] or hbCustomBuffsDisabled[uaName]["ALL"])) then
        return
    elseif HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"] then
        buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["count"]=uaCount
        buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["expiration"]=uaExpirationTime
        buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["caster"]=uaUnitCaster
        table.insert(buffSort[HealBot_Aura_IconSet[uaSpellId]],HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"])
    elseif HealBot_AuraBuffCache[uaSpellId] then
        HealBot_AuraBuffCache[uaSpellId].reset=true
    end
      --HealBot_setCall("HealBot_Aura_SetBuffIcon")
end

function HealBot_Aura_SortBuffIcons(button)
    button.icon.buff.count[1]=#buffSort[1]
    if button.icon.buff.count[1]>0 then
        table.sort(buffSort[1])
        if button.icon.buff.count[1]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXBICONS"] then
            button.icon.buff.count[1]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXBICONS"]
        end
        for j=1, button.icon.buff.count[1], 1 do
            HealBot_Aura_CacheBuffIcon(button, j, buffAuraCache[buffSort[1][j]]["spellId"], buffSort[1][j])
        end
    end
    button.icon.buff.count[2]=#buffSort[2]
    if button.icon.buff.count[2]>0 then
        table.sort(buffSort[2])
        if button.icon.buff.count[2]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXBICONS"] then
            button.icon.buff.count[2]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXBICONS"]
        end
        for j=1, button.icon.buff.count[2], 1 do
            HealBot_Aura_CacheBuffIcon(button, j+5, buffAuraCache[buffSort[2][j]]["spellId"], buffSort[2][j])
        end
    end
    button.icon.buff.count[3]=#buffSort[3]
    if button.icon.buff.count[3]>0 then
        table.sort(buffSort[3])
        if button.icon.buff.count[3]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXBICONS"] then
            button.icon.buff.count[3]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXBICONS"]
        end
        for j=1, button.icon.buff.count[3], 1 do
            HealBot_Aura_CacheBuffIcon(button, j+7, buffAuraCache[buffSort[3][j]]["spellId"], buffSort[3][j])
        end
    end
end

local castByListIndexed={[HEALBOT_CUSTOM_CASTBY_EVERYONE]=1,
                         [HEALBOT_CUSTOM_CASTBY_ENEMY]=2,
                         [HEALBOT_CUSTOM_CASTBY_FRIEND]=3,
                         [HEALBOT_OPTIONS_SELFHEALS]=4,
                        }
function HealBot_Aura_setCDebuffCasyByIndexed(CDebuffCasyByList)
    castByListIndexed = CDebuffCasyByList
end

function HealBot_Aura_setCustomDebuffFilterCastBy()
    for id,_ in pairs(hbCustomDebuffsCastBy) do
        hbCustomDebuffsCastBy[id]=false
    end
    for id, x in pairs(HealBot_Globals.FilterCustomDebuff) do
        local name, _, _, _, _, _, _ = GetSpellInfo(id)
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
            if HealBot_Globals.CustomDebuffIDMethod[id]==1 then
                hbCustomDebuffsCastBy[id]=x
            elseif name then 
                hbCustomDebuffsCastBy[name]=x
            end
        else
            if name then hbCustomDebuffsCastBy[name]=x end
            hbCustomDebuffsCastBy[id]=x
        end
    end
    for id,_ in pairs(hbCustomDebuffsCastBy) do
        if not hbCustomDebuffsCastBy[id] then hbCustomDebuffsCastBy[id]=nil end
    end
    HealBot_Timers_Set("AURA","CheckUnits")
end

function HealBot_Aura_setCustomDebuffFilterDisabled()
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        hbCustomDebuffsDisabled[id]=false
    end
    for id, _ in pairs(HealBot_Globals.IgnoreCustomDebuff) do
        local name, _, _, _, _, _, _ = GetSpellInfo(id)
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
            if HealBot_Globals.CustomDebuffIDMethod[id]==1 then
                hbCustomDebuffsDisabled[id]={}
            elseif name then 
                hbCustomDebuffsDisabled[name]={}
            end
        else
            if name then hbCustomDebuffsDisabled[name]={} end
            hbCustomDebuffsDisabled[id]={}
        end
        for instName, disabled in pairs(HealBot_Globals.IgnoreCustomDebuff[id]) do
            if disabled then
                if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
                    if HealBot_Globals.CustomDebuffIDMethod[id]==1 then
                        hbCustomDebuffsDisabled[id][instName]=disabled
                    elseif name then 
                        hbCustomDebuffsDisabled[name][instName]=disabled
                    end
                else
                    if name then hbCustomDebuffsDisabled[name][instName]=disabled end
                    hbCustomDebuffsDisabled[id][instName]=disabled
                end
            end
        end
    end
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        if not hbCustomDebuffsDisabled[id] then hbCustomDebuffsDisabled[id]=nil end
    end
end

local cureSpellsOnCD={}
local cureSpellCD, cureSpellName=0, ""
local dNamePriority, dTypePriority=99,99
local debuffIsCurrent, cDebuffPrio, debuffIsAlways, debuff_Type, debuffIsAuto=true, 15, false, debuffType, false
local ccdbCasterID, ccdbUnitCasterID, ccdbCheckthis, ccdbAlways=0,1,false,false
local ccdbWatchTarget={}
function HealBot_Aura_CheckCurCustomDebuff(canBeAlways)
    ccdbCasterID=hbCustomDebuffsCastBy[uaSpellId] or hbCustomDebuffsCastBy[uaName] or HealBot_Globals.CureCustomDefaultCastBy
    if ccdbCasterID~=castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] then
        if uaUnitCasterIsPlayer then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            if ccdbCasterID==castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] then 
                ccdbCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            end
        elseif UnitIsFriend("player",uaUnitCaster) then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND]
        else
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY]
        end
        if ccdbUnitCasterID==ccdbCasterID then 
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=dNamePriority
        else
            debuffIsCurrent=false
        end
    else
        debuff_Type=HEALBOT_CUSTOM_en
        cDebuffPrio=dNamePriority
        if canBeAlways then
            debuffIsAlways=true 
        end
    end
end

local hbUpCustomDebuffsDone={}
function HealBot_Aura_ClearCustomDebuffsDone()
    hbUpCustomDebuffsDone={}
end

function HealBot_Aura_CacheDebuff(spellId, spellName, debuffIsAlways, debuffTexture, debuffType)
    if not HealBot_AuraDebuffCache[spellId] then HealBot_AuraDebuffCache[spellId]={} end
    HealBot_AuraDebuffCache[spellId].always=debuffIsAlways
    HealBot_AuraDebuffCache[spellId]["texture"]=debuffTexture
    HealBot_AuraDebuffCache[spellId]["name"]=spellName
    HealBot_AuraDebuffCache[spellId]["type"]=debuffType
    HealBot_AuraDebuffCache[spellId]["iconSet"]=HealBot_Aura_IconSet[spellId]
    HealBot_AuraDebuffCache[spellId].reset=false
    if not HealBot_Globals.HealBot_Custom_Debuffs[spellId] and not hbUpCustomDebuffsDone[spellName] then
        hbUpCustomDebuffsDone[spellName]=true
        HealBot_Aura_AutoUpdateCustomDebuff(button, spellName, spellId)
    end
end

function HealBot_Aura_CheckCurDebuff(button)
    debuffIsCurrent, cDebuffPrio, debuffIsAlways, debuff_Type, debuffIsAuto=true, 20, false, uaDebuffType, false
    dNamePriority, dTypePriority=HealBot_Options_retDebuffPriority(uaSpellId, uaName, uaDebuffType)
    if (hbCustomDebuffsDisabled[uaSpellId] and (hbCustomDebuffsDisabled[uaSpellId][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaName] and (hbCustomDebuffsDisabled[uaName][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaName]["ALL"])) then
        debuffIsCurrent=false
    elseif dTypePriority>dNamePriority and dNamePriority<21 then
        HealBot_Aura_CheckCurCustomDebuff(true)
    else
        ccdbCheckthis=false
        if HealBot_Aura_CanDispell[uaSpellId] and dTypePriority<21 and HealBot_Aura_luVars["cureOffCd"] and 
          (not HealBot_Config_Cures.IgnoreFriendDebuffs or not UnitIsFriend("player",uaUnitCaster)) and
          (uaDuration==0 or uaDuration>=HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]) then
            ccdbWatchTarget=HealBot_Options_retDebuffWatchTarget(uaDebuffType);
            if ccdbWatchTarget then
                if ccdbWatchTarget["Raid"] then
                    ccdbCheckthis=true;
                    if not HealBot_Config_Cures.IgnoreOnCooldownDebuffs then debuffIsAlways=true end
                elseif ccdbWatchTarget["Party"] and button.group==HealBot_Data["PLAYERGROUP"] then 
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["SingleTank"] and UnitIsUnit(button.unit, HealBot_Aura_luVars["TankUnit"]) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Self"] and button.player then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget[button.text.classtrim] then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["Name"] and button.guid==HealBot_Config.MyFriend then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["MyTargets"] and HealBot_Panel_IsMyTarget(button.guid) then
                    ccdbCheckthis=true
                end
            end
        end
        if ccdbCheckthis and dTypePriority<16 then
            cDebuffPrio=dTypePriority
        elseif (not UnitIsFriend("player",uaUnitCaster) and uaIsBossDebuff and HealBot_Config_Cures.AlwaysShowBoss and UnitExists("boss1")) or 
           (HealBot_Config_Cures.AlwaysShowTimed and uaDuration>0 and uaDuration<HealBot_Config_Cures.ShowTimeMaxDuration) or 
           (HealBot_Config_Cures.HealBot_Custom_Debuffs_All[uaDebuffType]) then
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=15
            debuffIsAuto=true
            if dTypePriority>15 then
                debuffIsAlways=true
            end
        elseif ccdbCheckthis then
            cDebuffPrio=dTypePriority
        elseif dNamePriority<21 then
            HealBot_Aura_CheckCurCustomDebuff(false)
        elseif uaUnitCasterIsPlayer and not UnitIsFriend("player",button.unit) then
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=20
        else
            debuffIsCurrent=false
        end
    end
    if debuffIsCurrent then
        if not HealBot_AuraDebuffCache[uaSpellId] or HealBot_AuraDebuffCache[uaSpellId].reset then
            HealBot_Aura_CacheDebuff(uaSpellId, uaName, debuffIsAlways, uaTexture, uaDebuffType)
            HealBot_AuraDebuffCache[uaSpellId]["priority"]=-1
        end
        HealBot_AuraDebuffCache[uaSpellId].isAuto=debuffIsAuto
        HealBot_AuraDebuffCache[uaSpellId]["debuffType"]=debuff_Type
        if not HealBot_AuraDebuffIconCache[uaUnitCaster] then HealBot_AuraDebuffIconCache[uaUnitCaster]={} end
        if not HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId] or HealBot_AuraDebuffCache[uaSpellId]["priority"]~=cDebuffPrio then
            HealBot_AuraDebuffCache[uaSpellId]["priority"]=cDebuffPrio
            HealBot_Aura_SetCurDebuffIconCache(button)
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckCurDebuff")
    return debuffIsCurrent
end

function HealBot_Aura_SetCurDebuffIconCache(button)
    if not HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId] then
        HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]={}
    end
    if HealBot_AuraDebuffCache[uaSpellId]["priority"]<10 then
        HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]="0"..HealBot_AuraDebuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
    else
        HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]=HealBot_AuraDebuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
    end
    if not debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]then
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]={}
    end
    debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["spellId"]=uaSpellId
end

function HealBot_Aura_AuxSetAuraBuffBars(button)
    HealBot_Aux_UpdateAuraBuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 8, true)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 8, true)
    end
end

function HealBot_Aura_AuxClearAuraBuffBars(button)
    HealBot_Aux_ClearAuraBuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 8, false)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 8, false)
    end
end

local curBuffRange=0
function HealBot_Aura_BuffWarnings(button, buffName, force)
    if button.aura.buff.name~=buffName or force then
        button.aura.buff.name=buffName
        HealBot_Emerg_Button[button.id].buffupdate=true
        button.aura.buff.r,button.aura.buff.g,button.aura.buff.b=HealBot_Options_RetBuffRGB(button)
        if button.aura.buff.missingbuff and button.status.rangespell~=button.aura.buff.name then
            curBuffRange=HealBot_UnitInRangeExc30(button, button.aura.buff.name)
        else
            curBuffRange=button.status.range
        end
        if curBuffRange>-1 then
            if button.aura.buff.colbar==4 then
                HealBot_Action_EnableBorderHazardType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "BUFF")
            elseif button.hazard.buff then
                HealBot_Action_DisableBorderHazardType(button, "BUFF")
            end
            if button.aura.buff.colbar>4 then
                HealBot_Action_EnableButtonGlowType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "BUFF", "", button.aura.buff.colbar)
            elseif button.glow.buff then
                HealBot_Action_DisableButtonGlowType(button, "BUFF")
            end
            if button.aura.buff.colbar>0 then 
                HealBot_Aura_AuxSetAuraBuffBars(button)
            else
                HealBot_Aura_AuxClearAuraBuffBars(button)
            end
        else
            if button.hazard.buff then HealBot_Action_DisableBorderHazardType(button, "BUFF") end
            if button.glow.buff then HealBot_Action_DisableButtonGlowType(button, "BUFF") end
            HealBot_Aura_AuxClearAuraBuffBars(button) 
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip() 
        end
        if buffWarnings and (not HealBot_Aura_WarningFilter[button.unit][buffName] or HealBot_Aura_WarningFilter[button.unit][buffName]<TimeNow) then
            if button.aura.buff.missingbuff and HealBot_BuffWatch[button.aura.buff.name] then
                HealBot_Aura_WarningFilter[button.unit][buffName]=TimeNow+2
            else
                HealBot_Aura_WarningFilter[button.unit][buffName]=curBuffxTime
            end
            if HealBot_Config_Buffs.ShowBuffWarning and curBuffRange>(HealBot_Config_Buffs.HealBot_CBWarnRange_Screen-3) then
                UIErrorsFrame:AddMessage(button.text.nameonly.." requires "..button.aura.buff.name, 
                                         button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, 1, UIERRORS_HOLD_TIME);
            end
            if HealBot_Config_Buffs.SoundBuffWarning and curBuffRange>(HealBot_Config_Buffs.HealBot_CBWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config_Buffs.SoundBuffPlay)
            end
        end
        if curBuffRange>(HealBot_Config_Buffs.HealBot_CBWarnRange_Bar-3) or button.aura.buffcol then HealBot_RefreshUnit(button) end
    end
        --HealBot_setCall("HealBot_Aura_BuffWarnings")
end

function HealBot_Aura_AuxSetAuraDebuffBars(button)
    HealBot_Aux_UpdateAuraDebuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 3, true)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 3, true)
    end
end

function HealBot_Aura_AuxClearAuraDebuffBars(button)
    HealBot_Aux_ClearAuraDebuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 3, false)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 3, false)
    end
end

local curDebuffRange,curDebuffSpell=0,""
function HealBot_Aura_DebuffWarnings(button, debuffName, force)
    if button.aura.debuff.name~=debuffName or force then
        button.aura.debuff.name=debuffName
        HealBot_Emerg_Button[button.id].debuffupdate=true
        button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b=HealBot_Options_RetDebuffRGB(button)
        button.aura.debuff.curespell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type)
        curDebuffSpell=button.aura.debuff.curespell or button.status.rangespell
        if button.status.rangespell~=curDebuffSpell then
            curDebuffRange=HealBot_UnitInRangeExc30(button, curDebuffSpell)
        else
            curDebuffRange=button.status.range
        end
        if curDebuffRange>-1 then
            if button.aura.debuff.colbar==4 then
                HealBot_Action_EnableBorderHazardType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "DEBUFF")
            elseif button.hazard.debuff then
                HealBot_Action_DisableBorderHazardType(button, "DEBUFF")
            end
            if button.aura.debuff.colbar>4 then
                HealBot_Action_EnableButtonGlowType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "DEBUFF", "", button.aura.debuff.colbar)
            elseif button.glow.debuff then
                HealBot_Action_DisableButtonGlowType(button, "DEBUFF")
            end
            if button.aura.debuff.colbar>0 then 
                HealBot_Aura_AuxSetAuraDebuffBars(button) 
            else
                HealBot_Aura_AuxClearAuraDebuffBars(button)
            end
        else
            if button.hazard.debuff then HealBot_Action_DisableBorderHazardType(button, "DEBUFF") end
            if button.glow.debuff then HealBot_Action_DisableButtonGlowType(button, "DEBUFF") end
            HealBot_Aura_AuxClearAuraDebuffBars(button)
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip() 
        end
        if curDebuffRange>0 and button.isplayer and button.frame<10 and button.aura.debuff.priority<=HealBot_Aura_luVars["HotBarDebuff"] then
            HealBot_Action_BarHotEnable(button, "DEBUFF")
        elseif button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        
        if debuffWarnings and (not HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name] or HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]<TimeNow) then
            HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]=HealBot_UnitDebuffIcons[button.id][51]["expirationTime"]
            if HealBot_Config_Cures.ShowDebuffWarning then
                if curDebuffRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Screen-3) then
                    UIErrorsFrame:AddMessage(button.text.nameonly.." suffers from "..button.aura.debuff.name, 
                                             button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b, 1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config_Cures.SoundDebuffWarning and curDebuffRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config_Cures.SoundDebuffPlay)
            end
        end
        if curDebuffRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) or button.aura.debuffcol then HealBot_RefreshUnit(button) end
    end
        --HealBot_setCall("HealBot_Aura_DebuffWarnings")
end

local asbtPrevEndTime=0
function HealBot_Aura_SetUnitBuffTimer(button)
    asbtPrevEndTime=button.aura.buff.recheck[uaName] or 0
    if HealBot_ShortBuffs[uaName] then 
        button.aura.buff.recheck[uaName] = uaExpirationTime-HealBot_Config_Buffs.ShortBuffTimer
    else
        button.aura.buff.recheck[uaName] = uaExpirationTime-HealBot_Config_Buffs.LongBuffTimer
    end
    if asbtPrevEndTime~=button.aura.buff.recheck[uaName] then
        HealBot_Aura_MarkCheckBuffsTime(button)
    end
      --HealBot_setCall("HealBot_Aura_SetUnitBuffTimer")
end

function HealBot_Aura_CheckUnitBuffIcons(button)
    for i=1,5 do
        if i<=button.icon.buff.count[1] then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=HealBot_Aura_prevIconCount["BUFF"][1] then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=6,7 do
        if i<=(5+button.icon.buff.count[2]) then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=(5+HealBot_Aura_prevIconCount["BUFF"][2]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=8,9 do
        if i<=(7+button.icon.buff.count[3]) then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=(7+HealBot_Aura_prevIconCount["BUFF"][3]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffIcons")
end

local hbAuraRequests={}
function HealBot_Aura_Requests(guid, buff)
    if buff then
        if not hbAuraRequests[guid] then hbAuraRequests[guid]={} end
        hbAuraRequests[guid][buff]=true
    else
        hbAuraRequests[guid]=nil
    end
end

function HealBot_Aura_RequestsClear()
    hbAuraRequests={}
end

local hbAuraBuffWatch={}
local hbAuraBuffTagWatch={}
local hbAuraDebuffWatch={}
local hbAuraDebuffTagWatch={}
function HealBot_Aura_BuffWatch(id, buff, active)
    if buff then
        if active then
            if not hbAuraBuffWatch[id] then 
                hbAuraBuffWatch[id]={}
            end
            if not hbAuraBuffWatch[id][buff] then
                if HealBot_Aura_CurrentBuff(id, buff) then
                    hbAuraBuffWatch[id][buff]=1
                else
                    hbAuraBuffWatch[id][buff]=0
                end
            end
        elseif hbAuraBuffWatch[id] and hbAuraBuffWatch[id][buff] then
            hbAuraBuffWatch[id][buff]=nil
        end
    else
        hbAuraBuffWatch[id]=nil
    end
end

function HealBot_Aura_BuffTagWatch(id, tag, active)
    if tag then
        if active then
            if not hbAuraBuffTagWatch[id] then 
                hbAuraBuffTagWatch[id]={}
            end
            if not hbAuraBuffTagWatch[id][tag] then
                hbAuraBuffTagWatch[id][tag]=0
                for bName, _ in pairs(HealBot_UnitBuffCurrent[id]) do
                    if HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]]==tag then
                        hbAuraBuffTagWatch[id][tag]=1
                        break
                    end
                end
            end
        elseif hbAuraBuffTagWatch[id] and hbAuraBuffTagWatch[id][tag] then
            hbAuraBuffTagWatch[id][tag]=nil
        end
    else
        hbAuraBuffTagWatch[id]=nil
    end
end

function HealBot_Aura_AuraWatchClear()
    hbAuraBuffWatch={}
    hbAuraBuffTagWatch={}
    hbAuraDebuffWatch={}
    hbAuraDebuffTagWatch={}
end

function HealBot_Aura_DebuffWatch(id, debuff, active)
    if debuff then
        if active then
            if not hbAuraDebuffWatch[id] then 
                hbAuraDebuffWatch[id]={}
            end
            if not hbAuraDebuffWatch[id][debuff] then
                if HealBot_Aura_CurrentDebuff(id, debuff) then
                    hbAuraDebuffWatch[id][debuff]=1
                else
                    hbAuraDebuffWatch[id][debuff]=0
                end
            end
        elseif hbAuraDebuffWatch[id] and hbAuraDebuffWatch[id][debuff] then
            hbAuraDebuffWatch[id][debuff]=nil
        end
    else
        hbAuraDebuffWatch[id]=nil
    end
end

function HealBot_Aura_DebuffTagWatch(id, tag, active)
    if tag then
        if active then
            if not hbAuraDebuffTagWatch[id] then 
                hbAuraDebuffTagWatch[id]={}
            end
            if not hbAuraDebuffTagWatch[id][tag] then
                hbAuraDebuffTagWatch[id][tag]=0
                for dName, _ in pairs(HealBot_UnitDebuffCurrent[id]) do
                    if HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]]==tag then
                        hbAuraDebuffTagWatch[id][tag]=1
                        break
                    end
                end
            end
        elseif hbAuraDebuffTagWatch[id] and hbAuraDebuffTagWatch[id][tag] then
            hbAuraDebuffTagWatch[id][tag]=nil
        end
    else
        hbAuraDebuffTagWatch[id]=nil
    end
end

function HealBot_Aura_CurrentBuffTag(id, tag)
    if hbAuraBuffTagWatch[id] and (hbAuraBuffTagWatch[id][tag] or 0)==1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_CurrentBuff(id, bName)
    return HealBot_UnitBuffCurrent[id][bName]
end

function HealBot_Aura_CurrentDebuff(id, dName)
    if HealBot_UnitDebuffCurrent[id] then
        return HealBot_UnitDebuffCurrent[id][dName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuffTag(id, tag)
    if hbAuraDebuffTagWatch[id] and (hbAuraDebuffTagWatch[id][tag] or 0)==1 then
        return true
    else
        return false
    end
end

local uaIsCurrent, uaIsCustom, uaNever, uaZ, tGeneralBuffs=false, false, false, 1, true
local onlyPlayers,prevMissingbuff=false,false
function HealBot_Aura_CheckUnitBuff(button)
    if uaExpirationTime then
        if not HealBot_Aura_IconSet[uaSpellId] then
            HealBot_Aura_IconSet[uaSpellId]=HealBot_Globals.HealBot_Custom_Buffs_IconSet[uaSpellId] or HealBot_Globals.HealBot_Custom_Buffs_IconSet[uaName] or 1
            HealBot_Aura_ID[uaName]=uaSpellId
        end
        if uaUnitCaster then
            if UnitIsUnit(uaUnitCaster,"player") then
                uaUnitCasterIsPlayer=true
            else
                uaUnitCasterIsPlayer=false
            end
        else
            uaUnitCasterIsPlayer=false
            uaUnitCaster="nil" 
        end
        HealBot_UnitBuffCurrent[button.id][uaName]=TimeNow
        HealBot_Aura_BuffUpdate_Plugins(button, uaName, HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[uaName]], uaCount, true, uaUnitCasterIsPlayer)
        if not HealBot_ExcludeBuffInCache[uaSpellId] then
            if not HealBot_Data["PALIVE"] or (button.player and uaSpellId==HEALBOT_SPIRIT_OF_REDEMPTION) then
                tGeneralBuffs=false
            elseif HealBot_Buff_Aura2Item[uaName] then
                uaName=GetItemInfo(HealBot_Buff_Aura2Item[uaName]) or uaName
            end
            uaIsCurrent, uaIsCustom, uaNever=HealBot_Aura_CheckCurBuff()
            if uaIsCurrent then
                curBuffxTime=uaExpirationTime
                if uaIsCustom then
                    HealBot_Aura_SetBuffIcon()
                end
                if tGeneralBuffs and onlyPlayers and (HealBot_BuffWatch[uaName] or HealBot_BuffNameTypes[uaName]) then
                    if HealBot_BuffNameTypes[uaName] and (not button.aura.buff.recheck[uaName] or button.aura.buff.recheck[uaName]>TimeNow) then
                        if HealBot_BuffNameTypes[uaName] then
                            if HealBot_BuffNameTypes[uaName]<7 and button.unit==uaUnitCaster then ownBlessing=true end
                            PlayerBuffTypes[HealBot_BuffNameTypes[uaName]]=true
                        end
                    end
                    PlayerBuffs[uaName]=true
                    if HealBot_CheckBuffs[uaName] and uaExpirationTime>0 and (HEALBOT_GAME_VERSION>1 or uaUnitCasterIsPlayer) then
                        HealBot_Aura_SetUnitBuffTimer(button)
                    elseif button.aura.buff.recheck[uaName] then
                        button.aura.buff.recheck[uaName]=nil
                        HealBot_Aura_MarkCheckBuffsTime(button)
                    end
                end
                if not unitCurrentBuff.active or unitCurrentBuff.prio>HealBot_AuraBuffCache[uaSpellId]["priority"] then
                    unitCurrentBuff.active=true
                    unitCurrentBuff.id=uaSpellId
                    unitCurrentBuff.name=HealBot_AuraBuffCache[uaSpellId]["name"]
                    unitCurrentBuff.prio=HealBot_AuraBuffCache[uaSpellId]["priority"]
                end
            elseif uaNever and not HealBot_BuffWatch[uaName] and not HealBot_BuffNameTypes[uaName] then
                HealBot_ExcludeBuffInCache[uaSpellId]=true
            end
        end
    end
end

function HealBot_Aura_CheckUnitDebuff(button)
    if not HealBot_Aura_IconSet[uaSpellId] then
        HealBot_Aura_IconSet[uaSpellId]=HealBot_Globals.HealBot_Custom_Debuffs_IconSet[uaSpellId] or HealBot_Globals.HealBot_Custom_Debuffs_IconSet[uaName] or 1
        HealBot_Aura_ID[uaName]=uaSpellId
        if HealBot_Aura_CanDispell[uaSpellId]==nil then
            local aId=1
            while true do
                local aSpellName, _, _, _, _, _, _, _, _, aSpellId = UnitAura(button.unit,aId,"HARMFUL|RAID")
                if aSpellId then
                    aId=aId+1
                    HealBot_Aura_CanDispell[aSpellId]=true
                else
                    if HealBot_Aura_CanDispell[uaSpellId]==nil then
                        HealBot_Aura_CanDispell[uaSpellId]=false
                    end
                    break
                end
            end
        end
    end
    if uaSpellId==32407 or uaName=="Strange Aura" then
    --    uaDebuffType=HEALBOT_DISEASE_en
    --    uaDebuffType=HEALBOT_MAGIC_en
    --    uaDebuffType=HEALBOT_CURSE_en
    --    uaDebuffType=HEALBOT_POISON_en
    --    HealBot_Aura_CanDispell[uaSpellId]=true
    --    HealBot_AddDebug("Strange Aura - IconSet="..HealBot_Aura_IconSet[uaSpellId])
    end
    if uaUnitCaster then
        if UnitIsUnit(uaUnitCaster,"player") then
            uaUnitCasterIsPlayer=true
        else
            uaUnitCasterIsPlayer=false
        end
    else
        uaUnitCasterIsPlayer=false
        uaUnitCaster="nil"
    end
    HealBot_UnitDebuffCurrent[button.id][uaName]=TimeNow
    HealBot_Aura_DebuffUpdate_Plugins(button, uaName, HealBot_Globals.CDCTag[HealBot_Aura_ID[uaName]], uaCount, true, uaUnitCasterIsPlayer)
    if not HealBot_AuraDebuffCache[uaSpellId] or not HealBot_AuraDebuffCache[uaSpellId].always then
        uaIsCurrent=HealBot_Aura_CheckCurDebuff(button)
    else
        uaIsCurrent=true
        if not HealBot_AuraDebuffIconCache[uaUnitCaster] then HealBot_AuraDebuffIconCache[uaUnitCaster]={} end
        HealBot_Aura_SetCurDebuffIconCache(button)
    end
    if uaIsCurrent then
        HealBot_Aura_SetDebuffIcon()
        if not unitCurrentDebuff.active or unitCurrentDebuff.prio>HealBot_AuraDebuffCache[uaSpellId]["priority"] then
            unitCurrentDebuff.active=true
            unitCurrentDebuff.id=uaSpellId
            unitCurrentDebuff.prio=HealBot_AuraDebuffCache[uaSpellId]["priority"]
        end
    end
end

function HealBot_Aura_GetBuffsV1(button)
    uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId = libCD:UnitAura(button.unit,uaZ,"HELPFUL")
end

function HealBot_Aura_GetBuffsV2(button)
    uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId = UnitBuff(button.unit,uaZ)
end

local HealBot_Aura_GetBuffs=HealBot_Aura_GetBuffsV2
if HEALBOT_GAME_VERSION<2 and libCD then
    HealBot_Aura_GetBuffs=HealBot_Aura_GetBuffsV1
end

local hbClassicAbsorbTotal=0
function HealBot_Aura_CheckBuffsV1(button)
    uaZ=1
    hbClassicAbsorbTotal=0
    while true do
        HealBot_Aura_GetBuffs(button)
        if uaSpellId then
            uaZ=uaZ+1
            if HealBot_Classic_Absorbs[uaName] then
                if uaName==classicAbsorbPWS then
                    hbClassicAbsorbTotal=hbClassicAbsorbTotal+((HealBot_Classic_Absorbs[uaName][uaSpellId] or HealBot_Classic_Absorbs[uaName][0] or 0) * (classicAbsorbPWSMulti[button.guid] or classicAbsorbPWSMulti["DEFAULT"])) + (classicAbsorbBonus[button.guid] or classicAbsorbBonus["DEFAULT"])
                else
                    hbClassicAbsorbTotal=hbClassicAbsorbTotal+(HealBot_Classic_Absorbs[uaName][uaSpellId] or HealBot_Classic_Absorbs[uaName][0] or 0) + (classicAbsorbBonus[button.guid] or classicAbsorbBonus["DEFAULT"])
                end
            end
            HealBot_Aura_CheckUnitBuff(button)
        else
            break
        end
    end
    if button.health.auraabsorbs~=hbClassicAbsorbTotal then
        button.health.auraabsorbs=hbClassicAbsorbTotal
        HealBot_OnEvent_AbsorbsUpdate(button)
    end
end

function HealBot_Aura_CheckBuffsV9(button)
    AuraUtil.ForEachAura(button.unit, "HELPFUL", nil, function(...)
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId = ...
        HealBot_Aura_CheckUnitBuff(button)
    end)
end

local HealBot_Aura_CheckBuffs=HealBot_Aura_CheckBuffsV1
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_CheckBuffs=HealBot_Aura_CheckBuffsV9
end

function HealBot_Aura_ClearUnitBuffOverDebuff(button)
    button.aura.buff.overdb=false
    button.aura.debuff.update=true
    HealBot_Check_UnitDebuff(button)
end

local hbOverDebuff=false
function HealBot_Aura_SetUnitBuffOverDebuff(button, dCol)
    button.aura.debuff.colbar=dCol
    button.aura.buff.overdb=true
    hbOverDebuff=true
end

function HealBot_Aura_CheckUnitBuffOverDebuff(button)
    hbOverDebuff=false
    if button.aura.buff.priority<button.aura.debuff.priority then
        if (button.aura.buff.colbar<5 or button.aura.buff.colbar==7) and (button.aura.debuff.colbar<5 or button.aura.debuff.colbar==7) then
            if button.aura.buff.colbar==button.aura.debuff.colbar or (button.aura.buff.colbar==2 and button.aura.debuff.colbar<4) then
                HealBot_Aura_SetUnitBuffOverDebuff(button, 0)
            elseif button.aura.debuff.colbar==2 then
                if button.aura.buff.colbar==1 then
                    HealBot_Aura_SetUnitBuffOverDebuff(button, 3)
                elseif button.aura.buff.colbar==3 then
                    HealBot_Aura_SetUnitBuffOverDebuff(button, 1)
                end
            end
        end
    end
    if button.aura.buff.overdb and not hbOverDebuff then
        HealBot_Aura_ClearUnitBuffOverDebuff(button)
    end
end

local buffBarCol,buffPrio=0,99
function HealBot_Aura_CheckUnitBuffs(button)
    prevMissingbuff=button.aura.buff.missingbuff
    button.aura.buff.missingbuff=false
    button.aura.buff.priority=99
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        button.aura.buff.colbar=0
        curBuffName=false;
        unitCurrentBuff.active=false
        tGeneralBuffs=generalBuffs
        if tGeneralBuffs then
            if button.player then
                onlyPlayers=true
            elseif HEALBOT_GAME_VERSION>3 then
                onlyPlayers=button.isplayer
            else
                onlyPlayers=UnitIsFriend("player",button.unit)
            end
            if onlyPlayers then 
                for x,_ in pairs(PlayerBuffs) do
                    PlayerBuffs[x]=false;
                end
                for x,_ in pairs(PlayerBuffTypes) do
                    PlayerBuffTypes[x]=false;
                end
                ownBlessing=false
            end
        end
        for z=1,3 do
            HealBot_Aura_prevIconCount["BUFF"][z]=button.icon.buff.count[z]
        end
        for z=1,3 do
            for x,_ in pairs(buffSort[z]) do
                buffSort[z][x]=nil;
            end
        end
        HealBot_Aura_CheckBuffs(button)
        for bName, bTime in pairs(HealBot_UnitBuffCurrent[button.id]) do
            if bTime<TimeNow then
                HealBot_UnitBuffCurrent[button.id][bName]=nil
                HealBot_Aura_BuffUpdate_Plugins(button, bName, HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]], 0, false)
            end
        end
        if buffCheck then
            if tGeneralBuffs and onlyPlayers then
                HealBot_Aura_CheckGeneralBuff(button)
            end
            HealBot_Aura_SortBuffIcons(button)
            HealBot_Aura_CheckUnitBuffIcons(button)
           
            if not curBuffName then
                if HealBot_UnitBuffIcons[button.id][1].current then
                    button.aura.buff.id=HealBot_UnitBuffIcons[button.id][1]["spellId"]
                    curBuffName=HealBot_AuraBuffCache[button.aura.buff.id]["name"]
                    buffPrio=HealBot_AuraBuffCache[button.aura.buff.id]["priority"]
                elseif unitCurrentBuff.active then
                    button.aura.buff.id=unitCurrentBuff.id
                    curBuffName=unitCurrentBuff.name
                    buffPrio=unitCurrentBuff.prio
                end
                if curBuffName then
                    buffBarCol=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[HealBot_AuraBuffCache[button.aura.buff.id]["name"]] or 1
                    if (HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[button.aura.buff.id] or 1) > buffBarCol then
                        buffBarCol=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[button.aura.buff.id] or 1
                    end
                    if buffBarCol>1 and button.aura.buff.colbar==0 then
                        button.aura.buff.colbar=buffBarCol-1
                        button.aura.buff.priority=buffPrio
                        HealBot_Aura_CheckUnitBuffOverDebuff(button)
                    elseif button.aura.buff.overdb then
                        HealBot_Aura_ClearUnitBuffOverDebuff(button)
                    end
                end
            end
            if curBuffName and (not HealBot_Aura_luVars["InRaid"] or HealBot_Config_Buffs.ShowGroups[button.group]) then
                if prevMissingbuff~=button.aura.buff.missingbuff or HealBot_Aura_luVars["updateAll"] then
                    button.aura.buff.name="needUpdate"
                end
                HealBot_Aura_BuffWarnings(button, curBuffName)
            else
                HealBot_Aura_ClearBuff(button)
            end
        else
            HealBot_Aura_ClearBuff(button)
        end
    else
        HealBot_Aura_ClearBuff(button)
    end
end

function HealBot_Aura_resetSpellCD()
    cureSpellsOnCD={}
    HealBot_Aura_luVars["cureOffCd"]=true
end

local cureSpellNextCheck=0
function HealBot_Aura_CureSpellOnCD()
    cureSpellNextCheck=(TimeNow+cureSpellCD)-0.1
    HealBot_setLuVars("MaskAuraCheckDebuff", cureSpellNextCheck)
    cureSpellsOnCD[cureSpellName]=cureSpellNextCheck
    HealBot_Aura_luVars["cureOffCd"]=false
end

function HealBot_Aura_GetDebuffsV1(button)
    uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId = libCD:UnitAura(button.unit,uaZ,"HARMFUL")
    if uaUnitCaster and (UnitClassification(uaUnitCaster)=="worldboss" or HealBot_UnitBosses(uaUnitCaster)) then
        uaIsBossDebuff=true
    else
        uaIsBossDebuff=false
    end
end

function HealBot_Aura_GetDebuffsV2(button)
    uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff = UnitDebuff(button.unit,uaZ)
end

local HealBot_Aura_GetDebuffs=HealBot_Aura_GetDebuffsV2
if HEALBOT_GAME_VERSION<2 and libCD then
    HealBot_Aura_GetDebuffs=HealBot_Aura_GetDebuffsV1
end

function HealBot_Aura_CheckDebuffsV1(button)
    uaZ=1
    while true do
        HealBot_Aura_GetDebuffs(button)
        if uaSpellId then
            uaZ=uaZ+1
            if uaExpirationTime then
                HealBot_Aura_CheckUnitDebuff(button)
            end
        else
            break
        end
    end
end

function HealBot_Aura_CheckDebuffsV9(button)
    AuraUtil.ForEachAura(button.unit, "HARMFUL", nil, function(...)
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff = ...
        if uaExpirationTime then
            if HealBot_Config_Cures.IgnoreOnCooldownDebuffs then
                cureSpellCD, cureSpellName=HealBot_Options_retDebuffWatchTargetCD(uaDebuffType, TimeNow)
                HealBot_Aura_luVars["cureOffCd"]=true
                if cureSpellName then
                    if not cureSpellsOnCD[cureSpellName] then
                        if cureSpellCD>2 then
                            HealBot_Aura_CureSpellOnCD()
                            HealBot_CheckAllActiveDebuffs()
                        end
                    elseif cureSpellsOnCD[cureSpellName]<TimeNow then
                        if cureSpellCD>2 then
                            HealBot_Aura_CureSpellOnCD()
                        end
                    else
                        HealBot_Aura_luVars["cureOffCd"]=false
                    end
                end
            end
            HealBot_Aura_CheckUnitDebuff(button)
        end
    end)
end

local HealBot_Aura_CheckDebuffs=HealBot_Aura_CheckDebuffsV1
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_CheckDebuffs=HealBot_Aura_CheckDebuffsV9
end

local debuffBarCol=0
function HealBot_Aura_CheckUnitDebuffs(button)
    for z=1,3 do
        HealBot_Aura_prevIconCount["DEBUFF"][z]=button.icon.debuff.count[z]
    end
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        --button.aura.debuff.type=false
        for z=1,3 do
            for x,_ in pairs(debuffSort[z]) do
                debuffSort[z][x]=nil;
            end
        end
        unitCurrentDebuff.active=false
        HealBot_Aura_CheckDebuffs(button)
        for dName, dTime in pairs(HealBot_UnitDebuffCurrent[button.id]) do
            if dTime<TimeNow then
                HealBot_UnitDebuffCurrent[button.id][dName]=nil
                HealBot_Aura_DebuffUpdate_Plugins(button, dName, HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]], 0, false)
            end
        end
        if debuffCheck then
            HealBot_Aura_SortDebuffIcons(button)
            HealBot_Aura_CheckUnitDebuffIcons(button)
            if HealBot_UnitDebuffIcons[button.id][51].current then
                button.aura.debuff.id=HealBot_UnitDebuffIcons[button.id][51]["spellId"]
                button.aura.debuff.priority=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["priority"]
            elseif unitCurrentDebuff.active then
                button.aura.debuff.id=unitCurrentDebuff.id
                button.aura.debuff.priority=unitCurrentDebuff.prio
            else
                button.aura.debuff.id=0
            end
            if button.aura.debuff.id>0 then
                if HealBot_AuraDebuffCache[button.aura.debuff.id].isAuto then 
                    debuffBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC] or 4
                elseif HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"]==HEALBOT_CUSTOM_en then
                    debuffBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] or 
                                 HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_AuraDebuffCache[button.aura.debuff.id]["name"]] or 4
                else
                    debuffBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"] or 4
                end
                button.aura.debuff.colbar=debuffBarCol-1
                HealBot_Aura_CheckUnitBuffOverDebuff(button)
                if button.aura.debuff.type~=HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"] or button.aura.debuff.update then
                    button.aura.debuff.update=false
                    button.aura.debuff.name="needUpdate"
                    button.aura.debuff.type=HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"]
                end
                if UnitIsFriend("player",button.unit) and (not HealBot_Aura_luVars["InRaid"] or HealBot_Config_Cures.ShowGroups[button.group]) then 
                    HealBot_Aura_DebuffWarnings(button, HealBot_AuraDebuffCache[button.aura.debuff.id]["name"])
                else
                    HealBot_Aura_ClearDebuff(button)
                end
            else
                HealBot_Aura_ClearDebuff(button)
            end
        else
            HealBot_Aura_ClearDebuff(button)
        end
    else
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_CheckUnitAuras(button, debuff)
    --if not UnitIsFriend("player",button.unit) then
    --    HealBot_Aura_RefreshEnemyAuras(button)
    if debuff then
        HealBot_Aura_CheckUnitDebuffs(button)
    else
        HealBot_Aura_CheckUnitBuffs(button)
    end
end

local lowTime=0
local PlayerBuffsList={}
function HealBot_Aura_ResetCheckBuffsTime(button)
    lowTime=TimeNow+10000000
    PlayerBuffsList=button.aura.buff.recheck
    button.aura.buff.resetcheck=false
    button.aura.buff.nextcheck=false
    for name,nexttime in pairs (PlayerBuffsList) do
        if nexttime<0 then
            PlayerBuffsList[name]=nil
        elseif nexttime < lowTime then
            lowTime=nexttime
            if nexttime<TimeNow+5 then nexttime=TimeNow+5 end
            button.aura.buff.nextcheck=nexttime
        end
    end
      --HealBot_setCall("HealBot_Aura_ResetCheckBuffsTime")
end

function HealBot_Aura_MarkCheckBuffsTime(button)
    if not button.aura.buff.nextcheck then button.aura.buff.nextcheck=TimeNow+5 end
    button.aura.buff.resetcheck=true
end

function HealBot_Aura_SetAuraWarningFlags()
    if HealBot_Config_Buffs.SoundBuffWarning or HealBot_Config_Buffs.ShowBuffWarning then
        buffWarnings=true
    else
        buffWarnings=false
    end
    if HealBot_Config_Cures.SoundDebuffWarning or HealBot_Config_Cures.ShowDebuffWarning then
        debuffWarnings=true
    else
        debuffWarnings=false
    end
end

function HealBot_Aura_SetAuraCheckFlags(debuffMounted, buffMounted, onTaxi, resting, inVehicle)
    tmpBCheck=buffCheck
    tmpGBuffs=generalBuffs
    tmpDCheck=debuffCheck

    if not HealBot_Config_Buffs.NoAuraWhenRested then resting=false end
    if resting or onTaxi or not HealBot_Config_Buffs.BuffWatch then 
        buffCheck=false 
    else
        buffCheck=true
        if (not HealBot_Config_Buffs.BuffWatchWhenGrouped or GetNumGroupMembers()>0) and 
           (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) and
            not inVehicle and not buffMounted and not UnitIsDeadOrGhost("player") then
            generalBuffs=true
            if HealBot_Config_Buffs.CheckManaDrink then
                HealBot_Action_setLuVars("CheckManaDrink", true)
            else
                HealBot_Action_setLuVars("CheckManaDrink", false)
            end
        else
            generalBuffs=false
            HealBot_Action_setLuVars("CheckManaDrink", false)
        end
    end
    
    if resting or onTaxi or not HealBot_Config_Cures.DebuffWatch then 
        debuffCheck=false 
    elseif (not HealBot_Config_Cures.DebuffWatchWhenGrouped or GetNumGroupMembers()>0) and 
           (HealBot_Config_Cures.DebuffWatchInCombat or not HealBot_Data["UILOCK"]) and
            not debuffMounted then
        debuffCheck=true
    else
        debuffCheck=false
    end
    
    if tmpBCheck~=buffCheck or tmpGBuffs~=generalBuffs or tmpDCheck~=debuffCheck then
        if not HealBot_Data["UILOCK"] then
            if debuffMounted or buffMounted or onTaxi or resting then
                HealBot_Timers_Set("AURA","RemoveAllBuffIcons")
                HealBot_Timers_Set("AURA","RemoveAllDebuffIcons")
            end
            HealBot_Timers_Set("AURA","CheckUnits")
        else
            if debuffMounted or buffMounted or onTaxi or resting then
                HealBot_Aura_RemoveAllBuffIcons()
                HealBot_Aura_RemoveAllDebuffIcons()
            end
            HealBot_AuraCheck()
        end
        --HealBot_Timers_Set("PLAYER","SetRestingState")
    end
end

function HealBot_Aura_ClearDebuff(button)
    if button.aura.debuff.name then
        button.aura.debuff.type = false;
        button.aura.debuff.name = false;
        button.aura.debuff.curespell = false
        button.aura.debuff.colbar=0
        button.aura.debuff.id=0
        button.aura.debuff.priority = 99;
        HealBot_Aura_AuxClearAuraDebuffBars(button)
        if button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        if button.glow.debuff then
            HealBot_Action_DisableButtonGlowType(button, "DEBUFF")
        end
        if button.hazard.debuff then
            HealBot_Action_DisableBorderHazardType(button, "DEBUFF")
        end
        HealBot_RefreshUnit(button)
    end
        --HealBot_setCall("HealBot_Aura_ClearDebuff")
end

function HealBot_Aura_ClearBuff(button)
    if button.aura.buff.name then
        button.aura.buff.name=false
        button.aura.buff.colbar=0
        button.aura.buff.missingbuff=false
        if button.glow.buff then
            HealBot_Action_DisableButtonGlowType(button, "BUFF")
        end
        if button.aura.buff.overdb then
            HealBot_Aura_ClearUnitBuffOverDebuff(button)
        end
        HealBot_Aura_AuxClearAuraBuffBars(button)
        HealBot_RefreshUnit(button)
    end
        --HealBot_setCall("HealBot_Aura_ClearBuff")
end

function HealBot_Aura_ClearAllBuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
      --HealBot_setCall("HealBot_Aura_ClearAllBuffs")
end

function HealBot_Aura_ClearAllDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
        --HealBot_setCall("HealBot_Aura_ClearAllDebuffs")
end

function HealBot_Aura_BuffUpdate_Plugins(button, aura, tag, count, active, casterIsPlayer)
    if count<1 then count=1 end
    if hbAuraRequests[button.guid] and hbAuraRequests[button.guid][aura] and active and button.frame<7 then
        HealBot_Plugin_Requests_CancelGUID(button.guid)
        hbAuraRequests[button.guid][aura]=false
    end
    if hbAuraBuffWatch[button.id] and hbAuraBuffWatch[button.id][aura] then
        if not active then
            hbAuraBuffWatch[button.id][aura]=0
            HealBot_Plugin_AuraWatch_PlayerBuffUpdate(button, aura, count, active, casterIsPlayer)
        elseif hbAuraBuffWatch[button.id][aura]~=count then
            hbAuraBuffWatch[button.id][aura]=count
            HealBot_Plugin_AuraWatch_PlayerBuffUpdate(button, aura, count, active, casterIsPlayer)
        end
    end
    if tag and hbAuraBuffTagWatch[button.id] and hbAuraBuffTagWatch[button.id][tag] then
        if not active then
            for bName, _ in pairs(HealBot_UnitBuffCurrent[button.id]) do
                if HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]]==tag then
                    return
                end
            end
            hbAuraBuffTagWatch[button.id][tag]=0
            HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(button, tag, count, active, casterIsPlayer)
        elseif hbAuraBuffTagWatch[button.id][tag]==0 then
            hbAuraBuffTagWatch[button.id][tag]=1
            HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(button, tag, count, active, casterIsPlayer)
        end
    end
end

function HealBot_Aura_DebuffUpdate_Plugins(button, aura, tag, count, active, casterIsPlayer)
    if count<1 then count=1 end
    if hbAuraDebuffWatch[button.id] and hbAuraDebuffWatch[button.id][aura] then
        if not active then
            hbAuraDebuffWatch[button.id][aura]=0
            HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(button, aura, count, active, casterIsPlayer)
        elseif hbAuraDebuffWatch[button.id][aura]~=count then
            hbAuraDebuffWatch[button.id][aura]=count
            HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(button, aura, count, active, casterIsPlayer)
        end
    end
    if tag and hbAuraDebuffTagWatch[button.id] and hbAuraDebuffTagWatch[button.id][tag] then
        if not active then
            for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.id]) do
                if HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]]==tag then
                    return
                end
            end
            hbAuraDebuffTagWatch[button.id][tag]=0
            HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(button, tag, count, active, casterIsPlayer)
        elseif hbAuraDebuffTagWatch[button.id][tag]==0 then
            hbAuraDebuffTagWatch[button.id][tag]=1
            HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(button, tag, count, active, casterIsPlayer)
        end
    end
end

function HealBot_Aura_ClearBuffWatch(buffName)
    if buffName then
        for j=1, #HealBot_BuffWatchList do
            if buffName==HealBot_BuffWatchList[j] then
                table.remove(HealBot_BuffWatchList, j)
                break;
            end
        end
        HealBot_BuffWatch[buffName]=nil
    else
        for x,_ in pairs(HealBot_BuffWatch) do
            HealBot_BuffWatch[x]=nil;
        end
        for x,_ in pairs(HealBot_BuffWatchList) do
            HealBot_BuffWatchList[x]=nil;
        end
    end
      --HealBot_setCall("HealBot_Aura_ClearBuffWatch")
end

local addBuffToWatch=true
function HealBot_Aura_SetBuffWatch(buffName)
    addBuffToWatch=true
    for j=1, #HealBot_BuffWatchList do
        if buffName==HealBot_BuffWatchList[j] then
            addBuffToWatch=false
            break;
        end
    end
    if addBuffToWatch then
        table.insert(HealBot_BuffWatchList,buffName)
    end
    HealBot_BuffWatch[buffName]=true
      --HealBot_setCall("HealBot_Aura_SetBuffWatch")
end

function HealBot_Aura_ClearCheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
      --HealBot_setCall("HealBot_Aura_ClearCheckBuffs")
end

function HealBot_Aura_SetCheckBuffs(buffName)
    HealBot_CheckBuffs[buffName]=true;
      --HealBot_setCall("HealBot_Aura_SetCheckBuffs")
end

local isBuffSpellName=""
function HealBot_Aura_IsBuffSpell(spellId)
    isBuffSpellName=GetSpellInfo(spellId) or spellId
    return HealBot_CheckBuffs[isBuffSpellName]
end

function HealBot_Aura_RetMyBuffTime(button,buffName)
    if not button.aura.buff.recheck[buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.ShortBuffTimer
    else
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.LongBuffTimer
    end
      --HealBot_setCall("HealBot_Aura_RetMyBuffTime")
end

local rdType=HEALBOT_CUSTOM_en
function HealBot_Aura_retDebufftype(id)
      --HealBot_setCall("HealBot_Aura_retDebufftype")
    rdType=HEALBOT_CUSTOM_en
    if HealBot_AuraDebuffCache[id] then rdType=HealBot_AuraDebuffCache[id]["debuffType"] end
    return rdType
end

function HealBot_Aura_Update_UnitAllBuffIcons(button)
    if button then
        for i=1,button.icon.buff.count[1] do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"], HealBot_UnitBuffIcons[button.id][i]["iconSet"])
        end
        for i=6,button.icon.buff.count[2]+5 do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"], HealBot_UnitBuffIcons[button.id][i]["iconSet"])
        end
        for i=8,button.icon.buff.count[3]+7 do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"], HealBot_UnitBuffIcons[button.id][i]["iconSet"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=6,xButton.icon.buff.count[2]+5 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=8,xButton.icon.buff.count[3]+7 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=6,xButton.icon.buff.count[2]+5 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=8,xButton.icon.buff.count[3]+7 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=6,xButton.icon.buff.count[2]+5 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=8,xButton.icon.buff.count[3]+7 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=6,xButton.icon.buff.count[2]+5 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=8,xButton.icon.buff.count[3]+7 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=6,xButton.icon.buff.count[2]+5 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
            for i=8,xButton.icon.buff.count[3]+7 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"], HealBot_UnitBuffIcons[xButton.id][i]["iconSet"])
            end
        end
    end
end

function HealBot_Aura_Update_UnitAllDebuffIcons(button)
    if button then
        for i=51,button.icon.debuff.count[1]+50 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"], HealBot_UnitDebuffIcons[button.id][i]["iconSet"])
        end
        for i=56,button.icon.debuff.count[2]+55 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"], HealBot_UnitDebuffIcons[button.id][i]["iconSet"])
        end
        for i=58,button.icon.debuff.count[3]+57 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"], HealBot_UnitDebuffIcons[button.id][i]["iconSet"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=56,xButton.icon.debuff.count[2]+55 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=58,xButton.icon.debuff.count[3]+57 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=56,xButton.icon.debuff.count[2]+55 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=58,xButton.icon.debuff.count[3]+57 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=56,xButton.icon.debuff.count[2]+55 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=58,xButton.icon.debuff.count[3]+57 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=56,xButton.icon.debuff.count[2]+55 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=58,xButton.icon.debuff.count[3]+57 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=56,xButton.icon.debuff.count[2]+55 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
            for i=58,xButton.icon.debuff.count[3]+57 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"], HealBot_UnitDebuffIcons[xButton.id][i]["iconSet"])
            end
        end
    end
end

function HealBot_Aura_Update_UnitAllExtraIcons(button, index)
    if button then
        if HealBot_UnitExtraIcons[button.id][index].current then
            HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
    end
end

function HealBot_Aura_Update_AllIcons(button)
    HealBot_Aura_Update_UnitAllBuffIcons(button)
    HealBot_Aura_Update_UnitAllDebuffIcons(button)
    for i = 91,94 do
        HealBot_Aura_Update_UnitAllExtraIcons(button, i)
    end
end

function HealBot_Aura_ReturnHoTdetails(buttonId)
      --HealBot_setCall("HealBot_Aura_ReturnHoTdetails")
    return HealBot_UnitBuffIcons[buttonId]
end

function HealBot_Aura_ReturnBuffSpellId(buttonId, iconId)
    return HealBot_UnitBuffIcons[buttonId][iconId]["spellId"]
end

function HealBot_Aura_ReturnHoTdetailsname(spellId)
    if HealBot_AuraBuffCache[spellId] then
        return HealBot_AuraBuffCache[spellId]["name"]
    else
        return false
    end
end

function HealBot_Aura_ReturnDebuffdetails(buttonId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffdetails")
    return HealBot_UnitDebuffIcons[buttonId]
end

function HealBot_Aura_ReturnDebuffSpellId(buttonId, iconId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffdetails")
    return HealBot_UnitDebuffIcons[buttonId][iconId]["spellId"]
end

function HealBot_Aura_ReturnDebuffdetailsname(spellId)
    if HealBot_AuraDebuffCache[spellId] then
        return HealBot_AuraDebuffCache[spellId]["name"]
    else
        return false
    end
end

function HealBot_Aura_RemoveIcons(button)
    HealBot_Aura_RemoveBuffIcons(button)
    HealBot_Aura_RemoveDebuffIcons(button)
    for i=91,94 do
        HealBot_Aura_RemoveExtraUnitIcons(button, i)
    end
      --HealBot_setCall("HealBot_Aura_RemoveIcons")
end

function HealBot_Aura_ConfigClassAllHoT(id, sName, wType)
    if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
        if HealBot_Globals.CustomBuffIDMethod[id]==2 and sName then
            HealBot_Watch_HoT[sName]=wType
        else
            HealBot_Watch_HoT[id]=wType
        end
    else
        HealBot_Watch_HoT[id]=wType
        if sName then HealBot_Watch_HoT[sName]=wType end
    end
end

function HealBot_Aura_ConfigClassHoT()
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for id,_ in pairs(HealBot_Watch_HoT) do
        HealBot_Watch_HoT[id]=false
    end
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for id,x  in pairs(HealBot_configClassHoTClass) do
            local sName=false
            if tonumber(id)==nil and not HealBot_SpellID_LookupData[id] then
                HealBot_SpellID_LookupData[id]={}
                HealBot_SpellID_LookupData[id]["CHECK"]=true
                HealBot_SpellID_LookupData[id]["CLASS"]=xClass
                sName=id
            elseif GetSpellInfo(id) then
                sName=GetSpellInfo(id)
            end
            if x==1 then
                HealBot_Aura_ConfigClassAllHoT(id, sName, "S")
            elseif x==2 then
                HealBot_Aura_ConfigClassAllHoT(id, sName, "C")
            else
                HealBot_Aura_ConfigClassAllHoT(id, sName, "A")
            end
        end
    end
    for id,_ in pairs(HealBot_Watch_HoT) do
        if not HealBot_Watch_HoT[id] then HealBot_Watch_HoT[id]=nil end
    end
    HealBot_Aura_setCustomBuffFilterDisabled()
      --HealBot_setCall("HealBot_configClassHoT")
end

function HealBot_Aura_ClearGUID(guid)
    hbAuraRequests[guid]=nil
end

function HealBot_Aura_BuffIdLookup()
    if HealBot_SpellID_LookupIdx[1] then
        local sName=HealBot_SpellID_LookupIdx[1]
        local sID=HealBot_SpellID_LookupData[sName]["ID"]
        local class=HealBot_SpellID_LookupData[sName]["CLASS"]
        table.remove(HealBot_SpellID_LookupIdx,1)
        if GetSpellInfo(sID) and GetSpellInfo(sID)==sName and HealBot_Globals.WatchHoT[class][sName] then
            HealBot_Globals.WatchHoT[class][sID]=HealBot_Globals.WatchHoT[class][sName]
            if HealBot_Globals.IgnoreCustomBuff[sName] then
                HealBot_Globals.IgnoreCustomBuff[sID]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomBuff[sName])
            end
            if HealBot_Globals.HealBot_Custom_Buffs[sName] then
                HealBot_Globals.HealBot_Custom_Buffs[sID]=HealBot_Globals.HealBot_Custom_Buffs[sName]
            end
            if HealBot_Globals.CustomBuffBarColour[sName] then
                HealBot_Globals.CustomBuffBarColour[sID]=HealBot_Options_copyTable(HealBot_Globals.CustomBuffBarColour[sName])
            end
            if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sName] then
                HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sID]=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sName]
            end
        end
        C_Timer.After(0.2, HealBot_Aura_BuffIdLookup)
    end
end

local function HealBot_Aura_InitItem2BuffsNames(buffId, itemId)
    if HealBot_IsItemInBag(itemId) then
        local sName=GetSpellInfo(buffId)
        if sName then HealBot_Buff_Aura2Item[sName] = itemId end
    end
end

local hbWeaponEnchants={}
function HealBot_Aura_WeaponEnchants(spell, x)
    if hbWeaponEnchants[spell] and GetSpellInfo(spell) then
        HealBot_Weapon_Enchant[x]=GetSpellInfo(spell)
    elseif hbWeaponEnchants[spell] and GetItemInfo(spell) then
        HealBot_Weapon_Enchant[x]=GetItemInfo(spell)
    else
        HealBot_Weapon_Enchant[x]=false
    end
end

function HealBot_Aura_UpdateItemData(iName, id)
    if iName then
        if HealBot_IsItemInBag(id) then 
            hbWeaponEnchants[iName]=true
        else
            hbWeaponEnchants[iName]=false 
        end
        HealBot_Aura_WeaponEnchants(iName, 1)
    end
end

local hbCustomItemID=0
function HealBot_Aura_InitItemsDataReady()
    if HEALBOT_GAME_VERSION<4 then
        HealBot_Aura_UpdateItemData(GetItemInfo(HEALBOT_BRILLIANT_MANA_OIL_SPELL), HEALBOT_BRILLIANT_MANA_OIL_SPELL)
        HealBot_Aura_UpdateItemData(GetItemInfo(HEALBOT_BRILLIANT_WIZARD_OIL_SPELL), HEALBOT_BRILLIANT_WIZARD_OIL_SPELL)
        HealBot_Aura_UpdateItemData(GetItemInfo(HEALBOT_BLESSED_WIZARD_OIL_SPELL), HEALBOT_BLESSED_WIZARD_OIL_SPELL)
        if HEALBOT_GAME_VERSION>1 then
            HealBot_Aura_UpdateItemData(GetItemInfo(HEALBOT_SUPERIOR_WIZARD_OIL_SPELL), HEALBOT_SUPERIOR_WIZARD_OIL_SPELL)
            HealBot_Aura_UpdateItemData(GetItemInfo(HEALBOT_SUPERIOR_MANA_OIL_SPELL), HEALBOT_SUPERIOR_MANA_OIL_SPELL)
        end
    end

    for x,_ in pairs(HealBot_Buff_Aura2Item) do
        HealBot_Buff_Aura2Item[x]=nil;
    end
    
    HealBot_Aura_luVars["ManaDrink"]=""
    if HealBot_Config_Buffs.CheckManaDrink then
        hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.ManaDrinkItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem) end
            HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK] = hbCustomItemID
            HealBot_Aura_luVars["ManaDrink"]=HealBot_Config_Buffs.ManaDrinkItem
            if not HealBot_BuffWatch[HealBot_Aura_luVars["ManaDrink"]] then
                HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["ManaDrink"])
                HealBot_Aura_DeleteExcludeBuffInCache()
            end
        else
            if HealBot_BuffWatch[HealBot_Config_Buffs.ManaDrinkItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.ManaDrinkItem) end
            hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.BackupManaDrinkItem or "x") or 0
            if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK] = hbCustomItemID
                HealBot_Aura_luVars["ManaDrink"]=HealBot_Config_Buffs.BackupManaDrinkItem
                if not HealBot_BuffWatch[HealBot_Aura_luVars["ManaDrink"]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["ManaDrink"])
                    HealBot_Aura_DeleteExcludeBuffInCache()
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem)
            end
        end
    end

    if HealBot_Config_Buffs.CheckWellFed then
        hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.WellFedItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupWellFedItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupWellFedItem) end
            HealBot_Buff_Aura2Item[HEALBOT_WELL_FED] = hbCustomItemID
            HealBot_Aura_luVars["WellFed"]=HealBot_Config_Buffs.WellFedItem
            if not HealBot_BuffWatch[HealBot_Aura_luVars["WellFed"]] then
                HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["WellFed"])
                HealBot_Aura_DeleteExcludeBuffInCache()
            end
        else
            if HealBot_BuffWatch[HealBot_Config_Buffs.WellFedItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.WellFedItem) end
            hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.BackupWellFedItem or "x") or 0
            if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HEALBOT_WELL_FED] = hbCustomItemID
                HealBot_Aura_luVars["WellFed"]=HealBot_Config_Buffs.BackupWellFedItem
                if not HealBot_BuffWatch[HealBot_Aura_luVars["WellFed"]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["WellFed"])
                    HealBot_Aura_DeleteExcludeBuffInCache()
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.BackupWellFedItem] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupWellFedItem)
            end
        end
    end

    for x=1,3 do
        if string.len(HealBot_Config_Buffs.CustomBuffName[x])>0 then
            hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.CustomItemName[x]) or 0
            if HealBot_Config_Buffs.CustomBuffCheck[x] and hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HealBot_Config_Buffs.CustomBuffName[x]] = hbCustomItemID
                if not HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                    HealBot_Aura_DeleteExcludeBuffInCache()
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
            end
        end
    end
    
    for x,_ in pairs(HealBot_Buff_ItemIDs) do
        HealBot_Buff_ItemIDs[x]=nil;
    end
    for _,id in pairs(HealBot_Buff_Aura2Item) do
        local itemName=GetItemInfo(id)
        if itemName then
            HealBot_Buff_ItemIDs[itemName]=id
        end
    end
    HealBot_Options_BuffWeaponEnchantSetAura(1)
    HealBot_Options_BuffWeaponEnchantSetAura(2)
    --HealBot_AddDebug("InitItemsDataReady","Buff",true)
    HealBot_Timers_Set("AURA","ExtraBuffReset")
    HealBot_Timers_Set("AURA","DeleteExcludeBuffInCache")
    HealBot_Timers_Set("AURA","ResetBuffCache")
    HealBot_Timers_Set("AURA","CheckPlayer")
end

function HealBot_Aura_InitItemsData()
    if HealBot_retLuVars("BagsScanned") then
        HealBot_Timers_Set("AURA","InitItemsDataReady")
    else
        HealBot_Timers_Set("LAST","InitItemsData",0.5)
        --HealBot_AddDebug("InitItemsData","Buff",true)
    end
end

function HealBot_Aura_InitData()
    local sName=nil
    if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
        sName=GetSpellInfo(HBC_DAMPEN_MAGIC)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_SHADOW_PROTECTION)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_FEAR_WARD)
        if sName then HealBot_ShortBuffs[sName]=true end
        if HEALBOT_GAME_VERSION<3 then
            sName=GetSpellInfo(HBC_INNER_FIRE)
            if sName then HealBot_ShortBuffs[sName]=true end
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        sName=GetSpellInfo(HBC_THORNS)
        if sName then HealBot_ShortBuffs[sName]=true end
        if HEALBOT_GAME_VERSION<2 then 
            sName=GetSpellInfo(HBC_OMEN_OF_CLARITY)
            if sName then HealBot_ShortBuffs[sName]=true end
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
        sName=GetSpellInfo(HEALBOT_BEACON_OF_LIGHT)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_SACRED_SHIELD)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_KINGS)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_MIGHT)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_WISDOM)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_LIGHT)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_SANCTUARY)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_SACRED_SHIELD)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
        -- Class buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARRIOR] then
        -- Class buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MAGE] then
        sName=GetSpellInfo(HEALBOT_ICE_WARD)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_ICE_BARRIER)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_DAMPEN_MAGIC)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
        -- Class buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        sName=GetSpellInfo(HEALBOT_HORN_OF_WINTER)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_HUNTER] then
        -- Class buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        sName=GetSpellInfo(HEALBOT_FLAMETONGUE_SPELL)
        if sName then hbWeaponEnchants[sName]=true end
        sName=GetSpellInfo(HEALBOT_WINDFURY_SPELL)
        if sName then hbWeaponEnchants[sName]=true end
        sName=GetSpellInfo(HBC_ROCKBITER_WEAPON)
        if sName then hbWeaponEnchants[sName]=true end
        sName=GetSpellInfo(HBC_EARTHLIVING_WEAPON)
        if sName then hbWeaponEnchants[sName]=true end
        sName=GetSpellInfo(HEALBOT_EARTHLIVING_WEAPON)
        if sName then hbWeaponEnchants[sName]=true end
        sName=GetSpellInfo(HBC_FLAMETONGUE_WEAPON)
        if sName then hbWeaponEnchants[sName]=true end
        sName=GetSpellInfo(HBC_WINDFURY_WEAPON)
        if sName then hbWeaponEnchants[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE] then
        -- Class buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEMONHUNTER] then
        -- Class buffs
    end

    if HEALBOT_GAME_VERSION<4 then
        
        local HBC_WISDOM_ID = 1 --Mana Regen
        local HBC_LIGHT_ID = 2 --Incoming Heals
        local HBC_SALVATION_ID = 3 --Threat Reduction
        local HBC_SANCTUARY_ID = 4 --Damage Reduction
        local HBC_STATS_ID = 5 --Stats
        local HBC_MIGHT_ID = 6 --Attack Power
        local HBC_STAMINA_ID = 7 --Stamina
        local HBC_INT_ID = 8 --Int
        local HBC_SPIRIT_ID = 9 --Spirit
        local HBC_SP_ID = 10 --Shadow Resistance 
        local HBC_MOTW_ID = 11 --Shadow Resistance 
        local HBC_INV_ID = 12
        if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) or "x")] = HBC_MOTW_ID,
                [(GetSpellInfo(HBC_GIFT_OF_THE_WILD) or "x")] = HBC_MOTW_ID,
            }
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MAGE] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_ARCANE_BRILLIANCE) or "x")] = HBC_INT_ID,
                [(GetSpellInfo(HEALBOT_ARCANE_BRILLIANCE) or "x")] = HBC_INT_ID,
            }
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_BLESSING_OF_KINGS) or "x")] = HBC_STATS_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_LIGHT) or "x")] = HBC_LIGHT_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_MIGHT) or "x")] = HBC_MIGHT_ID,
                [(GetSpellInfo(HEALBOT_HAND_OF_SALVATION) or "x")] = HBC_SALVATION_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_SANCTUARY) or "x")] = HBC_SANCTUARY_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_WISDOM) or "x")] = HBC_WISDOM_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_KINGS) or "x")] = HBC_STATS_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_LIGHT) or "x")] = HBC_LIGHT_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_MIGHT) or "x")] = HBC_MIGHT_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_SALVATION) or "x")] = HBC_SALVATION_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_SANCTUARY) or "x")] = HBC_SANCTUARY_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_WISDOM) or "x")] = HBC_WISDOM_ID,
            }
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_POWER_WORD_FORTITUDE) or "x")] = HBC_STAMINA_ID,
                [(GetSpellInfo(HEALBOT_POWER_WORD_FORTITUDE) or "x")] = HBC_STAMINA_ID,
                [(GetSpellInfo(HBC_DIVINE_SPIRIT) or "x")] = HBC_SPIRIT_ID,
                [(GetSpellInfo(HBC_PRAYER_OF_SPIRIT) or "x")] = HBC_SPIRIT_ID,
                [(GetSpellInfo(HBC_SHADOW_PROTECTION) or "x")] = HBC_SP_ID,
                [(GetSpellInfo(HBC_PRAYER_OF_SHADOW_PROTECTION) or "x")] = HBC_SP_ID,
            }
            if HealBot_Data["PLEVEL"]<80 then
                HealBot_BuffNameTypes[(GetSpellInfo(HBC_FEL_INTELLIGENCE) or "Fel Intelligence")] = HBC_SPIRIT_ID
            end
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_DETECT_LESSER_INVISIBILITY) or "x")] = HBC_INV_ID,
                [(GetSpellInfo(HBC_DETECT_INVISIBILITY) or "x")] = HBC_INV_ID,
                [(GetSpellInfo(HBC_DETECT_GREATER_INVISIBILITY) or "x")] = HBC_INV_ID,
            }
        end

        if HEALBOT_GAME_VERSION<3 then
            HealBot_BuffMinLevels={[GetSpellInfo(HEALBOT_POWER_WORD_FORTITUDE)]=48,
                                   [GetSpellInfo(HBC_DIVINE_SPIRIT)]=20,
                                   [GetSpellInfo(HBC_PRAYER_OF_SPIRIT)]=60,
                                   [GetSpellInfo(HBC_PRAYER_OF_SHADOW_PROTECTION)]=56,
                                   [GetSpellInfo(HBC_SHADOW_PROTECTION)]=30,
                                   [GetSpellInfo(HBC_GIFT_OF_THE_WILD)]=50,
                                   [GetSpellInfo(HBC_THORNS)]=6,
                                   [GetSpellInfo(HBC_ARCANE_BRILLIANCE)]=56,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_LIGHT)]=60,
                                   [GetSpellInfo(HBC_BLESSING_OF_LIGHT)]=40,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_MIGHT)]=52,
                                   [GetSpellInfo(HBC_BLESSING_OF_MIGHT)]=4,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_SALVATION)]=60,
                                   [GetSpellInfo(HBC_BLESSING_OF_SALVATION)]=26,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_WISDOM)]=54,
                                   [GetSpellInfo(HBC_BLESSING_OF_WISDOM)]=14,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_SANCTUARY)]=60,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_KINGS)]=60,
                                  }
        else
            HealBot_BuffMinLevels={[GetSpellInfo(HEALBOT_POWER_WORD_FORTITUDE)]=48,
                                   [GetSpellInfo(HBC_DIVINE_SPIRIT)]=20,
                                   [GetSpellInfo(HBC_PRAYER_OF_SPIRIT)]=60,
                                   [GetSpellInfo(HBC_PRAYER_OF_SHADOW_PROTECTION)]=56,
                                   [GetSpellInfo(HBC_SHADOW_PROTECTION)]=30,
                                   [GetSpellInfo(HBC_GIFT_OF_THE_WILD)]=50,
                                   [GetSpellInfo(HBC_THORNS)]=6,
                                   [GetSpellInfo(HBC_ARCANE_BRILLIANCE)]=56,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_MIGHT)]=52,
                                   [GetSpellInfo(HBC_BLESSING_OF_MIGHT)]=4,
                                   [GetSpellInfo(HBC_BLESSING_OF_SALVATION)]=26,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_WISDOM)]=54,
                                   [GetSpellInfo(HBC_BLESSING_OF_WISDOM)]=14,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_SANCTUARY)]=60,
                                   [GetSpellInfo(HBC_GREATER_BLESSING_OF_KINGS)]=60,
                                  }
        end
        
        classicAbsorbBonus["DEFAULT"]=ceil(GetSpellBonusHealing()*0.3)
        classicAbsorbBonus[HealBot_Data["PGUID"]]=classicAbsorbBonus["DEFAULT"]
        
        classicAbsorbPWS=(GetSpellInfo(HEALBOT_POWER_WORD_SHIELD) or "Power Word:Shield")
        HealBot_Classic_Absorbs={[classicAbsorbPWS]={[17]=48,
                                                    [592]=94,
                                                    [600]=166,
                                                   [3747]=244,
                                                   [6065]=313,
                                                   [6066]=394,
                                                  [10898]=499,
                                                  [10899]=622,
                                                  [10900]=783,
                                                  [10901]=942,
                                                  [25217]=1144,
                                                  [25218]=1265,
                                                  [48065]=1951,
                                                  [48066]=2230,
                                                      [0]=2230,},
                                 [(GetSpellInfo(HEALBOT_ICE_BARRIER) or "Ice Barrier")]={[11426]=455,
                                                                                         [13031]=569,
                                                                                         [13032]=700,
                                                                                         [13033]=824,
                                                                                         [27134]=952,
                                                                                         [33405]=1075,
                                                                                         [43038]=2860,
                                                                                         [43039]=3300,
                                                                                             [0]=3300,},
                                 [(GetSpellInfo(HBC_MANA_SHIELD) or "Mana Shield")]={[1463]=120,
                                                                                     [8494]=210,
                                                                                     [8495]=300,
                                                                                    [10191]=390,
                                                                                    [10192]=480,
                                                                                    [10193]=570,
                                                                                    [27131]=715,
                                                                                    [43019]=1080,
                                                                                    [43020]=1330,
                                                                                        [0]=1330},
                                }
        if HEALBOT_GAME_VERSION==3 and HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
            classicAbsorbPWSMulti[HealBot_Data["PGUID"]] = 1+(select(5, GetTalentInfo(1, 9))*0.05)
            HealBot_Classic_Absorbs["Divine Aegis"]={}
            HealBot_Classic_Absorbs["Divine Aegis"][47752]=250*(select(5, GetTalentInfo(1, 24)))
            HealBot_Classic_Absorbs["Divine Aegis"][0]=HealBot_Classic_Absorbs["Divine Aegis"][47752]
        else
            classicAbsorbPWSMulti[HealBot_Data["PGUID"]] = 1
        end
    end
    
    HealBot_Timers_Set("LAST","InitItemsData")
end

function HealBot_Aura_SendClassicData(rUser)
    if HEALBOT_GAME_VERSION<4 then
        if rUser then
            HealBot_Comms_SendAddonMsg("H:"..HealBot_Data["PGUID"].."~B~"..classicAbsorbBonus[HealBot_Data["PGUID"]], 2, rUser)
            HealBot_Comms_SendAddonMsg("H:"..HealBot_Data["PGUID"].."~M~"..classicAbsorbPWSMulti[HealBot_Data["PGUID"]], 2, rUser)
        else
            HealBot_Comms_SendAddonMsg("H:"..HealBot_Data["PGUID"].."~B~"..classicAbsorbBonus[HealBot_Data["PGUID"]], 1)
            HealBot_Comms_SendAddonMsg("H:"..HealBot_Data["PGUID"].."~M~"..classicAbsorbPWSMulti[HealBot_Data["PGUID"]], 1)
        end
    end
end

function HealBot_Aura_RecClassicData(msg)
    local guid,t,v=strsplit("~", msg)
    if guid and t and v then
        if t=="B" then
            classicAbsorbBonus[guid]=v
        else
            classicAbsorbPWSMulti[guid]=v
        end
    end
end
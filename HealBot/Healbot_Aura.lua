local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={}
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
local HealBot_iconUpdate={["DEBUFF"]={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,},
                            ["BUFF"]={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,} }
local HealBot_Watch_HoT={};
local HealBot_CheckBuffs = {}
local HealBot_ShortBuffs = {}
local HealBot_BuffWatch={}
local HealBot_BuffWatchList={}
local PlayerBuffs = {}
local PlayerBuffTypes = {}
local buffSort={}
local buffAuraCache={}
local debuffSort={}
local debuffAuraCache={}
local HealBot_SpellID_LookupData={}
local HealBot_SpellID_LookupIdx={}
local _
local HealBot_Buff_Aura2Item={};
local HealBot_Buff_ItemIDs={};
local buffCheck, generalBuffs, buffWarnings, debuffCheck, debuffWarnings=false,false,false,true,true
local tmpBCheck, tmpCBuffs, tmpGBuffs, tmpDCheck=false,false,false,false
local uaName, uaTexture, uaCount, uaDebuffType, uaDuration = "","",0,"",0
local uaExpirationTime, uaUnitCaster, uaSpellId, uaIsBossDebuff = 0,"",0,false
local highestBuffPrio=20
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
local HealBot_Aura_luVars={}
HealBot_Aura_luVars["TankUnit"]="x"
HealBot_Aura_luVars["hbInsName"]=HEALBOT_WORD_OUTSIDE
HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]=-1
HealBot_Aura_luVars["cureOffCd"]=true

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

function HealBot_Aura_TimeNow(now)
    TimeNow=now
end

function HealBot_Aura_retRaidtargetIcon(id)
    return HealBot_TargetIconsTextures[id]
end

function HealBot_Aura_ResetBuffCache()
    for spellId,_ in pairs(HealBot_AuraBuffCache) do
        HealBot_AuraBuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomBuffFilterDisabled")
end

function HealBot_Aura_ResetDebuffCache()
    for spellId,_ in pairs(HealBot_AuraDebuffCache) do
        HealBot_AuraDebuffCache[spellId].always=false
        HealBot_AuraDebuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomDebuffFilterDisabled")
    HealBot_Timers_Set("AURA","CheckUnits")
end

function HealBot_Aura_DeleteExcludeBuffInCache()
    for id,_ in pairs(HealBot_ExcludeBuffInCache) do
        HealBot_ExcludeBuffInCache[id]=nil
    end
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
        else
            if HealBot_UnitDebuffIcons[button.id] then
                HealBot_UnitDebuffIcons[button.id][index].current=false
            end
        end
        button.gref.iconf[index]:SetFrameLevel(0)
    else
        if HealBot_UnitExtraIcons[button.id] then
            HealBot_UnitExtraIcons[button.id][index].current=false
        end
        if index==91 then
            button.icon.extra.classtexture=""
        elseif index==92 then
            button.icon.extra.targeticon=0
        elseif index==93 then
            button.icon.extra.readycheck=""
        end
    end
      --HealBot_setCall("HealBot_Aura_RemoveIcon")
end

function HealBot_Aura_RemoveBuffIcons(button)
    if button.frame>0 then
        for i=1,button.icon.buff.count do
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
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]<12 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]+1,12 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]<12 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]+1,12 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]<12 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]+1,12 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]<12 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]+1,12 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]<12 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXBICONS"]+1,12 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
end

function HealBot_Aura_RemoveDebuffIcons(button)
    if button.frame>0 then
        for i=51,50+button.icon.debuff.count do
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
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]<8 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+51,58 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]<8 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+51,58 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]<8 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+51,58 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]<8 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+51,58 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]<8 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+51,58 do
                HealBot_Aura_RemoveIcon(xButton, i)
            end
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]<8 then
            for i = Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+51,58 do
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

HealBot_Aura_luVars["FadeTimeDiv"]=18
HealBot_Aura_luVars["BuffFadeTimeDiv"]=18
local retAlpha=0
function HealBot_Aura_DebuffIcon_AlphaValue(secLeft, button, nextUpdate)
    if secLeft>-2 then
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["FADE"] and 
            secLeft<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["FADESECS"] then
            if secLeft<1 then
                if secLeft>-1 then
                    secLeft=0.75
                else
                    secLeft=0.5
                end
            end
            retAlpha=(secLeft/HealBot_Aura_luVars["FadeTimeDiv"])+.12
            nextUpdate=0.2
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"] then
                if retAlpha>HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1) then
                    retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                end
            elseif retAlpha>button.status.alpha then
                retAlpha=button.status.alpha
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"] then
            retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
        else
            retAlpha=button.status.alpha
        end
    else
        HealBot_Check_UnitDebuff(button)
    end
      --HealBot_setCall("HealBot_Aura_DebuffIcon_AlphaValue")
    return retAlpha, nextUpdate
end

function HealBot_Aura_BuffIcon_AlphaValue(secLeft, button, nextUpdate)
    if secLeft>-2 then
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFFADE"] and 
           secLeft<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFFADESECS"] then
            if secLeft<1 then
                if secLeft>-1 then
                    secLeft=0.75
                else
                    secLeft=0.5
                end
            end
            retAlpha=(secLeft/HealBot_Aura_luVars["BuffFadeTimeDiv"])+.12
            nextUpdate=0.2
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFI15EN"] then
                if retAlpha>HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1) then
                    retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                end
            elseif retAlpha>button.status.alpha then
                retAlpha=button.status.alpha
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFI15EN"] then
            retAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
        else
            retAlpha=button.status.alpha
        end
    else
        HealBot_Check_UnitBuff(button)
    end
      --HealBot_setCall("HealBot_Aura_BuffIcon_AlphaValue")
    return retAlpha, nextUpdate
end

HealBot_UpdateIconFreq={["DEBUFF"]={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50},
                          ["BUFF"]={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}}
function HealBot_Aura_SetUpdateIconFreq()
    local tAdj=0.005
    for j=1,10 do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["FADE"] then
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["FADESECS"]<Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["DURTHRH"] then
                HealBot_UpdateIconFreq["DEBUFF"][j]=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["DURTHRH"]+tAdj
            else
                HealBot_UpdateIconFreq["DEBUFF"][j]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["FADESECS"]+tAdj
            end
        else
            HealBot_UpdateIconFreq["DEBUFF"][j]=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["DURTHRH"]+tAdj
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["BUFFFADE"] then
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["BUFFFADESECS"]<Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["BUFFDURTHRH"] then
                HealBot_UpdateIconFreq["BUFF"][j]=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["BUFFDURTHRH"]+tAdj
            else
                HealBot_UpdateIconFreq["BUFF"][j]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["BUFFFADESECS"]+tAdj
            end
        else
            HealBot_UpdateIconFreq["BUFF"][j]=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["BUFFDURTHRH"]+tAdj
        end
    end
end

local auSecsLeft,iconAlpha=0,0
local alphaNextUpdate, durNextUpdate=0,0
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

function HealBot_Aura_UpdateDebuffIcon(button, iconData, index, timer, lastSpellId, srcTimer)
    if iconData.current and lastSpellId==iconData["spellId"] then
        alphaNextUpdate=999
        durNextUpdate=999
        auSecsLeft=floor((iconData.expirationTime-TimeNow)-0.5)
        if iconData.expirationTime>0 then
            iconAlpha, alphaNextUpdate=HealBot_Aura_DebuffIcon_AlphaValue(auSecsLeft, button, alphaNextUpdate)
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"] then
            iconAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
        else
            iconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(iconAlpha)
        if auSecsLeft>-2 and Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SDUR"] then
            if auSecsLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURTHRH"] then
                if auSecsLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURWARN"] then
                    if UnitIsFriend("player",button.unit) then
                        button.gref.txt.expire[index]:SetTextColor(0,1,0,iconAlpha);
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
                durNextUpdate=(iconData.expirationTime-TimeNow-1)-Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURTHRH"]
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if not srcTimer then
            if iconData.count > 1 and Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SCNT"] then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,iconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if alphaNextUpdate<durNextUpdate then
                C_Timer.After(alphaNextUpdate, function() HealBot_Aura_UpdateDebuffIcon(button, iconData, index, true, lastSpellId, true) end)
            elseif durNextUpdate<999 then
                C_Timer.After(durNextUpdate, function() HealBot_Aura_UpdateDebuffIcon(button, iconData, index, true, lastSpellId, true) end)
            end
        end
    end
      --HealBot_setCall("HealBot_Aura_UpdateDebuffIcon")
end

function HealBot_Aura_UpdateBuffIcon(button, iconData, index, timer, lastSpellId, srcTimer)
    if iconData.current and lastSpellId==iconData["spellId"] then
        alphaNextUpdate=999
        durNextUpdate=999
        auSecsLeft=floor((iconData.expirationTime-TimeNow)-0.5)
        if iconData.expirationTime>0 then
            iconAlpha, alphaNextUpdate=HealBot_Aura_BuffIcon_AlphaValue(auSecsLeft, button, alphaNextUpdate)
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFI15EN"] then
            iconAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
        else
            iconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(iconAlpha)
        if auSecsLeft>-2 and Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFSDUR"] and
           (not Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFSSDUR"] or UnitIsUnit(iconData.unitCaster,"player")) then
            if auSecsLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFDURTHRH"] then
                if auSecsLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFDURWARN"] then
                    button.gref.txt.expire[index]:SetTextColor(1,0,0,iconAlpha);
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
                durNextUpdate=(iconData.expirationTime-TimeNow-1)-Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFDURTHRH"]
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if not srcTimer then
            if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SELFIND"] and UnitIsUnit(iconData.unitCaster,"player") then
                button.gref.indicator.selfcast[index]:SetAlpha(HealBot_Action_BarColourAlpha(button, 1, 1))
            else
                button.gref.indicator.selfcast[index]:SetAlpha(0)
            end
            if iconData.count > 1 and Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFSCNT"] and
               (not Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFSSCNT"] or UnitIsUnit(iconData.unitCaster,"player")) then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,iconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if alphaNextUpdate<durNextUpdate then
                C_Timer.After(alphaNextUpdate, function() HealBot_Aura_UpdateBuffIcon(button, iconData, index, true, lastSpellId, true) end)
            elseif durNextUpdate<999 then
                C_Timer.After(durNextUpdate, function() HealBot_Aura_UpdateBuffIcon(button, iconData, index, true, lastSpellId, true) end)
            end
        end
    end
      --HealBot_setCall("HealBot_Aura_UpdateBuffIcon")
end

function HealBot_Aura_AddExtraIcon(button, index)
    button.gref.icon[index]:SetTexture(HealBot_UnitExtraIcons[button.id][index]["texture"])
    --if index==94 then HealBot_Action_SetDirectionArrow(button) end
    HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
      --HealBot_setCall("HealBot_Aura_AddExtraIcon")
end

function HealBot_Aura_AddBuffIcon(button, index)
    button.gref.icon[index]:SetTexture(HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][index]["spellId"]]["texture"])
    HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][index], index, true, HealBot_UnitBuffIcons[button.id][index]["spellId"])
      --HealBot_setCall("HealBot_Aura_AddBuffIcon")
end

function HealBot_Aura_DebuffAddIcon(button, index)
    button.gref.icon[index]:SetTexture(HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][index]["spellId"]]["texture"])
    HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][index], index, true, HealBot_UnitDebuffIcons[button.id][index]["spellId"])
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

local rcuPrevTexture=false
function HealBot_Aura_RCUpdate(button, texture)
    rcuPrevTexture=button.icon.extra.readycheck
    button.icon.extra.readycheck=texture
    if button.icon.extra.readycheck~=rcuPrevTexture and HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.readycheck then 
            HealBot_Aura_RemoveIcon(button, 93)
        elseif not HealBot_UnitExtraIcons[button.id][93].current or
           HealBot_UnitExtraIcons[button.id][93]["texture"]~=button.icon.extra.readycheck then
            HealBot_UnitExtraIcons[button.id][93]["texture"]=button.icon.extra.readycheck
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        end
    end
    if HealBot_Panel_RaidUnitGUID(button.guid) then
        HealBot_Action_setGuidData(button, "READYCHECK", texture)
    end
        --HealBot_setCall("HealBot_Aura_RCUpdate")
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
    for i = 1,12 do
        HealBot_UnitBuffIcons[buttonId][i]={}
        HealBot_UnitBuffIcons[buttonId][i]["count"]=0
        HealBot_UnitBuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitBuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitBuffIcons[buttonId][i]["type"]="x"
        HealBot_UnitBuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitBuffIcons[buttonId][i].current=false
    end
end

function HealBot_Aura_InitUnitDebuffIcons(buttonId)
    HealBot_UnitDebuffIcons[buttonId]={}
    for i = 51,58 do
        HealBot_UnitDebuffIcons[buttonId][i]={}
        HealBot_UnitDebuffIcons[buttonId][i]["count"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["type"]="x"
        HealBot_UnitDebuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitDebuffIcons[buttonId][i].current=false
    end
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
    HealBot_Globals.CatchAltDebuffIDs[name]=nil
    for dID, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if (GetSpellInfo(dID) and GetSpellInfo(dID)==dName) or (not GetSpellInfo(dID) and dID==name) then
            local oldId=dID
            if dID==name then oldId=name end
            HealBot_Globals.Custom_Debuff_Categories[spellId]=HealBot_Globals.Custom_Debuff_Categories[oldId]
            HealBot_Globals.HealBot_Custom_Debuffs[spellId]=x
            if HealBot_Globals.FilterCustomDebuff[oldId] then 
                HealBot_Globals.FilterCustomDebuff[spellId]=HealBot_Globals.FilterCustomDebuff[oldId]
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[oldId] then
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[oldId]
            end
            if HealBot_Globals.CDCBarColour[oldId] then
                HealBot_Globals.CDCBarColour[spellId]=HealBot_Options_copyTable(HealBot_Globals.CDCBarColour[oldId])
            end
            if HealBot_Globals.IgnoreCustomDebuff[oldId] then
                HealBot_Globals.IgnoreCustomDebuff[spellId]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomDebuff[oldId])
            end
            if dID~=name then 
                HealBot_Options_CDebuffResetList()
                HealBot_Check_UnitDebuff(button)
            end
            break
        end
    end
end

local nextDebuffIconUpdate, debuffIconRunTimer=0, false
function HealBot_Aura_CacheDebuffIcon(button, id, spellId, index)
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitDebuffIcons[button.id][id]["count"]~=debuffAuraCache[index]["count"] or
       HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=debuffAuraCache[index]["expiration"] or
       HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]~=debuffAuraCache[index]["caster"] then
        if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId and HealBot_UnitDebuffIcons[button.id][id].current then
            button.gref.icon[id]:SetTexture(HealBot_AuraDebuffCache[spellId]["texture"])
            debuffIconRunTimer=true
        else
            debuffIconRunTimer=false
        end
        HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
        HealBot_UnitDebuffIcons[button.id][id]["count"]=debuffAuraCache[index]["count"]
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=debuffAuraCache[index]["expiration"]
        HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]=debuffAuraCache[index]["caster"]
        HealBot_UnitDebuffIcons[button.id][id]["type"]=HealBot_AuraDebuffCache[spellId]["type"]
        if HealBot_UnitDebuffIcons[button.id][id].current then
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, debuffIconRunTimer, spellId)
        end
    end
end

local hbCustomDebuffsCastBy={}
local hbCustomDebuffsDisabled={}

function HealBot_Aura_SetDebuffIcon()
    if (hbCustomDebuffsDisabled[uaSpellId] and (hbCustomDebuffsDisabled[uaSpellId][HealBot_Aura_luVars["hbInsName"]] or hbCustomDebuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaName] and (hbCustomDebuffsDisabled[uaName][HealBot_Aura_luVars["hbInsName"]] or hbCustomDebuffsDisabled[uaName]["ALL"])) then
        return false
    else
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["count"]=uaCount
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["expiration"]=uaExpirationTime
        debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["caster"]=uaUnitCaster
        table.insert(debuffSort,HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"])
    end
      --HealBot_setCall("HealBot_Aura_SetDebuffIcon")
    return true
end

function HealBot_Aura_SortDebuffIcons(button)
    table.sort(debuffSort)
    button.icon.debuff.count=getn(debuffSort)
    if button.icon.debuff.count>Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then
        button.icon.debuff.count=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"]
    end
    for j=1, button.icon.debuff.count, 1 do
        HealBot_Aura_CacheDebuffIcon(button, 50+j, debuffAuraCache[debuffSort[j]]["spellId"], debuffSort[j])
    end
end

local nextBuffIconUpdate, buffIconRunTimer=0, false
function HealBot_Aura_CacheBuffIcon(button, id, spellId, index)
    if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitBuffIcons[button.id][id]["count"]~=buffAuraCache[index]["count"] or
       HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=buffAuraCache[index]["expiration"] or
       HealBot_UnitBuffIcons[button.id][id]["unitCaster"]~=buffAuraCache[index]["caster"] then
        if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId and HealBot_UnitBuffIcons[button.id][id].current then
            button.gref.icon[id]:SetTexture(HealBot_AuraBuffCache[spellId]["texture"])
            buffIconRunTimer=true
        else
            buffIconRunTimer=false
        end
        HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
        HealBot_UnitBuffIcons[button.id][id]["type"]=HealBot_AuraBuffCache[spellId]["type"]
        HealBot_UnitBuffIcons[button.id][id]["count"]=buffAuraCache[index]["count"]
        HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=buffAuraCache[index]["expiration"]
        HealBot_UnitBuffIcons[button.id][id]["unitCaster"]=buffAuraCache[index]["caster"]
        if HealBot_UnitBuffIcons[button.id][id].current then
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, buffIconRunTimer, spellId)
        end
    end
end

local debuffIndex=0
function HealBot_Aura_CheckUnitDebuffIcons(button)
    for i=51,58 do
        if i<=(50+button.icon.debuff.count) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
                button.gref.iconf[i]:SetFrameLevel(1000)
            end
        elseif i<=(50+HealBot_Aura_luVars["prevIconCount"]) then
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
local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
function HealBot_Aura_SetGeneralBuff(button, bName)
    curBuffName=bName
    button.aura.buff.missingbuff=true
    button.aura.buff.colbar=true
    button.aura.buff.priority=1
end

local buffWatchName=""
function HealBot_Aura_CheckGeneralBuff(button)  
    PlayerBuffsList=button.aura.buff.recheck
    for bName,nexttime in pairs (PlayerBuffsList) do
        if not PlayerBuffs[bName] then
            PlayerBuffsList[bName]=nil
            button.aura.buff.nextcheck=1
        elseif nexttime < TimeNow then
            PlayerBuffs[bName]=false
        end
    end
    for j=1, #HealBot_BuffWatchList do
        buffWatchName=HealBot_BuffWatchList[j]
        if HEALBOT_GAME_VERSION<4 and HealBot_BuffMinLevels[buffWatchName] then
            if UnitLevel(button.unit)<HealBot_BuffMinLevels[buffWatchName] then
                PlayerBuffs[buffWatchName]=true
            end
        end
        if not PlayerBuffs[buffWatchName] and not HealBot_Aura_HasBuffTypes(buffWatchName, PlayerBuffTypes) then
            buffSpellStart, buffSpellDur=0,0
            if GetSpellCooldown(buffWatchName) then
                buffSpellStart, buffSpellDur=GetSpellCooldown(buffWatchName)
            elseif HealBot_Buff_ItemIDs[buffWatchName] then
                buffSpellStart, buffSpellDur=GetItemCooldown(HealBot_Buff_ItemIDs[buffWatchName])
            end 
            if ((buffSpellStart or 0)+(buffSpellDur or 0))-TimeNow<2 then
                buffCheckThis=false;
                buffWatchTarget=HealBot_Options_retBuffWatchTarget(buffWatchName) or "";
                if buffWatchTarget["Raid"] then
                    buffCheckThis=true;
                elseif buffWatchTarget["Self"] and button.player then
                    buffCheckThis=true
                elseif buffWatchTarget["Party"] and button.group==HealBot_Data["PLAYERGROUP"] then 
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
                elseif buffWatchTarget["MyTargets"] then
                    local myhTargets=HealBot_GetMyHealTargets();
                    for i=1, #myhTargets do
                        if button.guid==myhTargets[i] then
                            buffCheckThis=true;
                            break;
                        end
                    end
                elseif buffWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    buffCheckThis=true
                end
                if buffCheckThis then
                    HealBot_Aura_SetGeneralBuff(button, buffWatchName)
                    break
                end
            else
                button.aura.buff.recheck[buffWatchName] = (TimeNow-buffSpellStart)+buffSpellDur
                button.aura.buff.nextcheck=1
            end
        end
    end
    if not button.aura.buff.missingbuff and button.player then
        for x=1,2 do
            if HealBot_Weapon_Enchant[x] then
                local hasMainHandEnchant, mainHandExpiration, _, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, _, offHandEnchantID = GetWeaponEnchantInfo()
                if hasMainHandEnchant and x==1 then
                    if (mainHandExpiration/1000)<HealBot_Config_Buffs.LongBuffTimer then
                        HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    else
                        button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=ceil(TimeNow+(mainHandExpiration/1000)-HealBot_Config_Buffs.LongBuffTimer)
                        if not button.aura.buff.nextcheck or button.aura.buff.nextcheck>button.aura.buff.recheck[HealBot_Weapon_Enchant[x]] then
                            button.aura.buff.nextcheck=1
                        end
                    end
                elseif hasOffHandEnchant and x==2 then
                    if (offHandExpiration/1000)<HealBot_Config_Buffs.LongBuffTimer then
                        HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    else
                        button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=ceil(TimeNow+(offHandExpiration/1000)-HealBot_Config_Buffs.LongBuffTimer)
                        if not button.aura.buff.nextcheck or button.aura.buff.nextcheck>button.aura.buff.recheck[HealBot_Weapon_Enchant[x]] then
                            button.aura.buff.nextcheck=1
                        end
                    end
                else
                    HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=nil
                    button.aura.buff.nextcheck=1
                end
            end
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckGeneralBuff")
end

local buffCustomType,scbUnitClassEN=false,"XXXX"
function HealBot_Aura_ShowCustomBuff()
    buffCustomType=HealBot_Watch_HoT[uaSpellId] or HealBot_Watch_HoT[uaName] or false
    if buffCustomType then
        if buffCustomType=="A" then
            return true, false
        elseif buffCustomType=="S" then
            if uaUnitCaster=="player" then 
                return true, false
            end
        elseif buffCustomType=="C" then
            _, scbUnitClassEN = UnitClass(uaUnitCaster)
            if scbUnitClassEN and HealBot_Data["PCLASSTRIM"]==strsub(scbUnitClassEN,1,4) then
                return true, false
            end
        end
    else
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
            local bPrio=HealBot_Globals.HealBot_Custom_Buffs[uaSpellId]
            if not bPrio then
                local bId=HealBot_Options_MissingBuffPrio(uaSpellId)
                bPrio=HealBot_Globals.HealBot_Custom_Buffs[bId] or HealBot_Globals.HealBot_Custom_Buffs[uaName] or 20
            end
            HealBot_AuraBuffCache[uaSpellId]["priority"]=bPrio
            HealBot_AuraBuffCache[uaSpellId]["texture"]=uaTexture
            HealBot_AuraBuffCache[uaSpellId]["name"]=uaName
            HealBot_AuraBuffCache[uaSpellId]["type"]=uaDebuffType
            if HealBot_SpellID_LookupData[uaName] and HealBot_SpellID_LookupData[uaName]["CHECK"] then
                HealBot_SpellID_LookupData[uaName]["CHECK"]=false
                HealBot_SpellID_LookupData[uaName]["ID"]=uaSpellId
                table.insert(HealBot_SpellID_LookupIdx,uaName)
            end
        end
        if ciCustomBuff then
            if not HealBot_AuraBuffIconCache[uaUnitCaster] then HealBot_AuraBuffIconCache[uaUnitCaster]={} end
            if not HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId] or HealBot_AuraBuffCache[uaSpellId].reset then 
                if HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId] and
                   HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"] and
                   buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]] then
                    buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]=nil
                end
                HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]={}
                if HealBot_AuraBuffCache[uaSpellId]["priority"]<10 then
                    HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]="0"..HealBot_AuraBuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
                else
                    HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]=HealBot_AuraBuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
                end
                if not buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]] then
                    buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]={}
                    buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["spellId"]=uaSpellId
                end
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
    if (hbCustomBuffsDisabled[uaSpellId] and (hbCustomBuffsDisabled[uaSpellId][HealBot_Aura_luVars["hbInsName"]] or hbCustomBuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomBuffsDisabled[uaName] and (hbCustomBuffsDisabled[uaName][HealBot_Aura_luVars["hbInsName"]] or hbCustomBuffsDisabled[uaName]["ALL"])) then
        return
    elseif HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"] then
        buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["count"]=uaCount
        buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["expiration"]=uaExpirationTime
        buffAuraCache[HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["caster"]=uaUnitCaster
        table.insert(buffSort,HealBot_AuraBuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"])
    elseif HealBot_AuraBuffCache[uaSpellId] then
        HealBot_AuraBuffCache[uaSpellId].reset=true
    end
      --HealBot_setCall("HealBot_Aura_SetBuffIcon")
end

function HealBot_Aura_SortBuffIcons(button)
    table.sort(buffSort)
    button.icon.buff.count=getn(buffSort)
    if button.icon.buff.count>Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"] then
        button.icon.buff.count=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"]
    end
    for j=1, button.icon.buff.count, 1 do
        HealBot_Aura_CacheBuffIcon(button, j, buffAuraCache[buffSort[j]]["spellId"], buffSort[j])
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
function HealBot_Aura_CheckCurCustomDebuff(button, canBeAlways)
    ccdbCasterID=hbCustomDebuffsCastBy[uaSpellId] or hbCustomDebuffsCastBy[uaName] or HealBot_Globals.CureCustomDefaultCastBy
    if ccdbCasterID~=castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] then
        if UnitIsUnit(uaUnitCaster,"player") then
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

function HealBot_Aura_CacheDebuff(spellId, spellName, debuffIsAlways, debuffTexture, debuffType)
    if not HealBot_AuraDebuffCache[spellId] then HealBot_AuraDebuffCache[spellId]={} end
    HealBot_AuraDebuffCache[spellId].always=debuffIsAlways
    HealBot_AuraDebuffCache[spellId]["texture"]=debuffTexture
    HealBot_AuraDebuffCache[spellId]["name"]=spellName
    HealBot_AuraDebuffCache[spellId]["type"]=debuffType
    HealBot_AuraDebuffCache[spellId].reset=false
    if HealBot_Globals.CatchAltDebuffIDs[name] then
        if not HealBot_Globals.HealBot_Custom_Debuffs[spellId] then
            HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
        else
            HealBot_Globals.CatchAltDebuffIDs[name]=nil
        end
    end
end

function HealBot_Aura_CheckCurDebuff(button)
    debuffIsCurrent, cDebuffPrio, debuffIsAlways, debuff_Type, debuffIsAuto=true, 20, false, uaDebuffType, false
    dNamePriority, dTypePriority=HealBot_Options_retDebuffPriority(uaSpellId, uaName, uaDebuffType)
    if (hbCustomDebuffsDisabled[uaSpellId] and (hbCustomDebuffsDisabled[uaSpellId][HealBot_Aura_luVars["hbInsName"]] or hbCustomDebuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaName] and (hbCustomDebuffsDisabled[uaName][HealBot_Aura_luVars["hbInsName"]] or hbCustomDebuffsDisabled[uaName]["ALL"])) then
        debuffIsCurrent=false
    elseif dTypePriority>dNamePriority and dNamePriority<21 then
        HealBot_Aura_CheckCurCustomDebuff(button, true)
    else
        ccdbCheckthis=false
        if dTypePriority<21 and HealBot_Aura_luVars["cureOffCd"] and 
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
                elseif ccdbWatchTarget[button.text.classtrim] then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["Name"] and button.guid==HealBot_Config.MyFriend then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["MyTargets"] then
                    local myhTargets=HealBot_GetMyHealTargets();
                    for i=1, #myhTargets do
                        if button.guid==myhTargets[i] then
                            ccdbCheckthis=true;
                            break
                        end
                    end
                elseif ccdbWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                end
            end
        end
        if ccdbCheckthis then
            cDebuffPrio=dTypePriority
        elseif (UnitIsEnemy("player",uaUnitCaster) and uaIsBossDebuff and HealBot_Config_Cures.AlwaysShowBoss and UnitExists("boss1")) or 
               (HealBot_Config_Cures.AlwaysShowTimed and uaDuration>0 and uaDuration<HealBot_Config_Cures.ShowTimeMaxDuration) or 
               (HealBot_Config_Cures.HealBot_Custom_Defuffs_All[uaDebuffType]) then
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=15
            debuffIsAuto=true
            if dTypePriority>15 then
                debuffIsAlways=true 
            end
        elseif dNamePriority<21 then
            HealBot_Aura_CheckCurCustomDebuff(button, false)
        elseif uaUnitCaster=="player" and not UnitIsFriend("player",button.unit) then
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
            if HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId] then
                if HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"] and
                   debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]] then
                    debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]=nil
                end
                HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]=nil
            end
            HealBot_Aura_SetCurDebuffIconCache(button)
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckCurDebuff")
    return debuffIsCurrent
end

function HealBot_Aura_SetCurDebuffIconCache(button)
    HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]={}
    if HealBot_AuraDebuffCache[uaSpellId]["priority"]<10 then
        HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]="0"..HealBot_AuraDebuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
    else
        HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]=HealBot_AuraDebuffCache[uaSpellId]["priority"]..uaSpellId..uaUnitCaster
    end
    debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]={}
    debuffAuraCache[HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId]["prioIndex"]]["spellId"]=uaSpellId
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
        if curBuffRange>-1 and button.aura.buff.colbar then 
            HealBot_Aux_UpdateAuraBuffBars(button)
        else
            HealBot_Aux_ClearAuraBuffBars(button)
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
                UIErrorsFrame:AddMessage(HealBot_GetUnitName(button).." requires "..button.aura.buff.name, 
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

local curDebuffRange,curDebuffSpell=0,""
function HealBot_Aura_DebuffWarnings(button, debuffName, force)
    if button.aura.debuff.name~=debuffName or force then
        button.aura.debuff.name=debuffName
        HealBot_Emerg_Button[button.id].debuffupdate=true
        button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b=HealBot_Options_RetDebuffRGB(button)
        curDebuffSpell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type) or button.status.rangespell
        if button.status.rangespell~=curDebuffSpell then
            curDebuffRange=HealBot_UnitInRangeExc30(button, curDebuffSpell)
        else
            curDebuffRange=button.status.range
        end
        if curDebuffRange>-1 and button.aura.debuff.colbar then 
            HealBot_Aux_UpdateAuraDebuffBars(button) 
        else
            HealBot_Aux_ClearAuraDebuffBars(button)
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip() 
        end
        if debuffWarnings and (not HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name] or HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]<TimeNow) then
            HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]=HealBot_UnitDebuffIcons[button.id][51]["expirationTime"]
            if HealBot_Config_Cures.ShowDebuffWarning then
                if curDebuffRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Screen-3) then
                    UIErrorsFrame:AddMessage(HealBot_GetUnitName(button).." suffers from "..button.aura.debuff.name, 
                                             button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b, 1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config_Cures.SoundDebuffWarning and curDebuffRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config_Cures.SoundDebuffPlay)
            end
        end
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDEBUFF"] then
            button.text.nameupdate=true
            HealBot_Text_UpdateText(button)
        end
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HDEBUFF"] then
            button.text.healthupdate=true
            HealBot_Text_UpdateText(button)
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
        button.aura.buff.nextcheck=1
    end
      --HealBot_setCall("HealBot_Aura_SetUnitBuffTimer")
end

function HealBot_Aura_CheckUnitBuffIcons(button)
    for i=1,12 do
        if i<=button.icon.buff.count then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
                button.gref.iconf[i]:SetFrameLevel(1000)
            end
        elseif i<=HealBot_Aura_luVars["prevBuffIconCount"] then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffIcons")
end

local uaIsCurrent, uaIsCustom, uaNever, uaZ, tGeneralBuffs=false, false, false, 1, true
local onlyPlayers,prevMissingbuff=false,false
function HealBot_Aura_CheckUnitBuff(button)
    if not HealBot_ExcludeBuffInCache[uaSpellId] and uaExpirationTime then
        if not uaUnitCaster then uaUnitCaster="nil" end
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
                if HealBot_CheckBuffs[uaName] and uaExpirationTime>0 and (HEALBOT_GAME_VERSION>1 or uaUnitCaster=="player") then
                    HealBot_Aura_SetUnitBuffTimer(button)
                elseif button.aura.buff.recheck[uaName] then
                    button.aura.buff.recheck[uaName]=nil
                    button.aura.buff.nextcheck=1
                end
            end
        elseif uaNever and not HealBot_BuffWatch[uaName] and not HealBot_BuffNameTypes[uaName] then
            HealBot_ExcludeBuffInCache[uaSpellId]=true
        end
    end
    if button.player and (uaExpirationTime or 1)==0 then
        HealBot_ReadyPlayerCheck()
    end
end

function HealBot_Aura_CheckUnitDebuff(button)
    --if uaSpellId==32407 or uaName=="Strange Aura" then
        --uaDebuffType=HEALBOT_DISEASE_en
    --    uaDebuffType=HEALBOT_MAGIC_en
    --    uaDebuffType=HEALBOT_CURSE_en
    --    HealBot_AddDebug("Strange Aura")
    --end
    if not uaUnitCaster then uaUnitCaster="nil" end
    if not HealBot_AuraDebuffCache[uaSpellId] or not HealBot_AuraDebuffCache[uaSpellId].always then
        uaIsCurrent=HealBot_Aura_CheckCurDebuff(button)
    else
        uaIsCurrent=true
        if not HealBot_AuraDebuffIconCache[uaUnitCaster] then HealBot_AuraDebuffIconCache[uaUnitCaster]={} end
        if not HealBot_AuraDebuffIconCache[uaUnitCaster][uaSpellId] then
            HealBot_Aura_SetCurDebuffIconCache(button)
        end
    end
    if uaIsCurrent then
        HealBot_Aura_SetDebuffIcon()
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
                hbClassicAbsorbTotal=hbClassicAbsorbTotal+(HealBot_Classic_Absorbs[uaName][uaSpellId] or 0)
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

function HealBot_Aura_CheckUnitBuffs(button)
    prevMissingbuff=button.aura.buff.missingbuff
    button.aura.buff.missingbuff=false
    if buffCheck and button.status.current<HealBot_Unit_Status["DEAD"] then
        button.aura.buff.colbar=false
        highestBuffPrio=21
        curBuffName=false;
        HealBot_Aura_luVars["prevBuffIconCount"]=button.icon.buff.count
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
        for x,_ in pairs(buffSort) do
            buffSort[x]=nil;
        end
        HealBot_Aura_CheckBuffs(button)
        if tGeneralBuffs and onlyPlayers then
            HealBot_Aura_CheckGeneralBuff(button)
        end
        HealBot_Aura_SortBuffIcons(button)
        HealBot_Aura_CheckUnitBuffIcons(button)
        if not curBuffName and HealBot_UnitBuffIcons[button.id][1].current then 
            if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[HealBot_UnitBuffIcons[button.id][1]["spellId"]] or 
               HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][1]["spellId"]]["name"]] then
                button.aura.buff.colbar=true
                highestBuffPrio=HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][1]["spellId"]]["priority"]
            end
            curBuffName=HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][1]["spellId"]]["name"]
            button.aura.buff.id=HealBot_UnitBuffIcons[button.id][1]["spellId"]
            button.aura.buff.priority=HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][1]["spellId"]]["priority"]
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

function HealBot_Aura_CheckUnitDebuffs(button)
    HealBot_Aura_luVars["prevIconCount"]=button.icon.debuff.count
    if debuffCheck and button.status.current<HealBot_Unit_Status["DEAD"] then
        --button.aura.debuff.type=false
        for x,_ in pairs(debuffSort) do
            debuffSort[x]=nil;
        end
        HealBot_Aura_CheckDebuffs(button)
        HealBot_Aura_SortDebuffIcons(button)
        HealBot_Aura_CheckUnitDebuffIcons(button)
        if HealBot_UnitDebuffIcons[button.id][51].current then
            if button.aura.debuff.id~=HealBot_UnitDebuffIcons[button.id][51]["spellId"] then
                if (HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]].isAuto and not HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]) or
                  HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]==false or
                  HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["name"]]==false then
                    button.aura.debuff.colbar=false
                    --button.aura.debuff.id=0
                else
                    if highestBuffPrio>=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["priority"] then
                        button.aura.debuff.colbar=true
                    else
                        button.aura.debuff.colbar=false
                    end
                    button.aura.debuff.id=HealBot_UnitDebuffIcons[button.id][51]["spellId"]
                    button.aura.debuff.priority=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["priority"]
                    if button.aura.debuff.type~=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["debuffType"] then
                        button.aura.debuff.name="needUpdate"
                        button.aura.debuff.type=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["debuffType"]
                    end
                end
            elseif button.aura.debuff.type~=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["debuffType"] then
                button.aura.debuff.name="needUpdate"
                button.aura.debuff.type=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["debuffType"]
            end
        else
            button.aura.debuff.id=0
        end
        if button.aura.debuff.id>0 and UnitIsFriend("player",button.unit) and (not HealBot_Aura_luVars["InRaid"] or HealBot_Config_Cures.ShowGroups[button.group]) then 
            HealBot_Aura_DebuffWarnings(button, HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][51]["spellId"]]["name"])
        else
            HealBot_Aura_ClearDebuff(button)
        end
    else
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_CheckUnitAuras(button, debuff)
    if not UnitIsFriend("player",button.unit) then
        HealBot_Aura_RefreshEnemyAuras(button)
    elseif debuff then
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
    button.aura.buff.nextcheck=false
    for name,nexttime in pairs (PlayerBuffsList) do
        if nexttime<0 then
            PlayerBuffsList[name]=nil
        elseif nexttime < lowTime then
            lowTime=nexttime
            if nexttime<TimeNow+15 then nexttime=TimeNow+15 end
            button.aura.buff.nextcheck=nexttime
        end
    end
      --HealBot_setCall("HealBot_Aura_ResetCheckBuffsTime")
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

function HealBot_Aura_SetAuraCheckFlags(debuffMounted, buffMounted, onTaxi, resting)
    tmpBCheck=buffCheck
    tmpGBuffs=generalBuffs
    tmpDCheck=debuffCheck
    
    if resting or onTaxi or not HealBot_Config_Buffs.BuffWatch then 
        buffCheck=false 
    else
        buffCheck=true
        if (not HealBot_Config_Buffs.BuffWatchWhenGrouped or GetNumGroupMembers()>0) and 
           (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) and
            not buffMounted then
            generalBuffs=true
        else
            generalBuffs=false
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
        if debuffMounted or buffMounted or onTaxi or resting then
            HealBot_Aura_RemoveAllBuffIcons()
            HealBot_Aura_RemoveAllDebuffIcons()
        end
        HealBot_AuraCheck()
    end
end

function HealBot_Aura_ClearDebuff(button)
    if button.aura.debuff.name then
        button.aura.debuff.type = false;
        button.aura.debuff.name = false;
        button.aura.debuff.colbar=false
        button.aura.debuff.id=0
        button.aura.debuff.priority = 99;
        HealBot_Aux_ClearAuraDebuffBars(button)
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDEBUFF"] then
            button.text.nameupdate=true
            HealBot_Text_setHealthText(button)
        end
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HDEBUFF"] then
            button.text.healthupdate=true
            HealBot_Text_setHealthText(button)
        end
        if button.aura.debuffcol then HealBot_RefreshUnit(button) end
    end
        --HealBot_setCall("HealBot_Aura_ClearDebuff")
end

function HealBot_Aura_ClearBuff(button)
    if button.aura.buff.name then
        button.aura.buff.name=false
        button.aura.buff.colbar=false
        button.aura.buff.missingbuff=false
        button.aura.buff.priority=99
        HealBot_Aux_ClearAuraBuffBars(button)
        if button.aura.buffcol then HealBot_RefreshUnit(button) end
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

local eaName, eaTexture, eaCount, eaDebuffType, eaExpirationTime, eaUnitCaster, eaSpellId, eaZ = "","",0,"",0,"",0,1
function HealBot_Aura_SetEnemyDebuffIcon(button, id)
    if not HealBot_AuraDebuffCache[eaSpellId] then
        HealBot_Aura_CacheDebuff(eaSpellId, eaName, false, eaTexture, eaDebuffType)
        HealBot_AuraDebuffCache[eaSpellId]["debuffType"]=eaDebuffType
    end
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=eaSpellId or not HealBot_UnitDebuffIcons[button.id][id].current then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=eaCount
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=eaExpirationTime
        HealBot_UnitDebuffIcons[button.id][id]["spellId"]=eaSpellId
        HealBot_UnitDebuffIcons[button.id][id]["type"]=eaDebuffType
        HealBot_UnitDebuffIcons[button.id][id].current=false
    elseif HealBot_UnitDebuffIcons[button.id][id]["count"]~=eaCount or HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=eaExpirationTime then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=eaCount
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=eaExpirationTime
        HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, false, HealBot_UnitDebuffIcons[button.id][id]["spellId"])
    end
      --HealBot_setCall("HealBot_Aura_SetEnemyDebuffIcon")
end

function HealBot_Aura_RefreshEnemyAura(button)
    if not HealBot_ExcludeEnemyInCache[eaSpellId] then
        if eaExpirationTime and eaUnitCaster and UnitIsUnit(eaUnitCaster,"player") and not UnitIsFriend("player",button.unit) then
            if button.icon.debuff.count < Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then
                button.icon.debuff.count=button.icon.debuff.count+1
                HealBot_Aura_SetEnemyDebuffIcon(button, 50+button.icon.debuff.count)
            end
        elseif not HealBot_Spell_Names[eaName] then
            HealBot_ExcludeEnemyInCache[eaSpellId]=true
        end
    end
end

function HealBot_Aura_GetEnemyAurasV1(button)
    eaName, eaTexture, eaCount, eaDebuffType, _, eaExpirationTime, eaUnitCaster, _, _, eaSpellId = libCD:UnitAura(button.unit,eaZ,"HARMFUL")
end

function HealBot_Aura_GetEnemyAurasV2(button)
    eaName, eaTexture, eaCount, eaDebuffType, _, eaExpirationTime, eaUnitCaster, _, _, eaSpellId = UnitDebuff(button.unit,eaZ)
end

local HealBot_Aura_GetEnemyAuras=HealBot_Aura_GetEnemyAurasV2
if HEALBOT_GAME_VERSION<2 and libCD then
    HealBot_Aura_GetEnemyAuras=HealBot_Aura_GetEnemyAurasV1
end

function HealBot_Aura_EnemyAurasV1(button)
    eaZ=1
    while true do
        HealBot_Aura_GetEnemyAuras(button)
        if eaSpellId then
            eaZ=eaZ+1
            HealBot_Aura_RefreshEnemyAura(button)
        else
            break
        end
    end
end

function HealBot_Aura_EnemyAurasV9(button)
    AuraUtil.ForEachAura(button.unit, "HARMFUL", nil, function(...)
        eaName, eaTexture, eaCount, eaDebuffType, _, eaExpirationTime, eaUnitCaster, _, _, eaSpellId = ...
        HealBot_Aura_RefreshEnemyAura(button)
    end)
end

local HealBot_Aura_EnemyAuras=HealBot_Aura_EnemyAurasV1
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_EnemyAuras=HealBot_Aura_EnemyAurasV9
end

function HealBot_Aura_RefreshEnemyAuras(button)
    HealBot_Aura_luVars["prevIconCount"]=button.icon.debuff.count
    button.icon.debuff.count=0
    HealBot_Aura_EnemyAuras(button)
    HealBot_Aura_CheckUnitDebuffIcons(button)
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

function HealBot_Aura_SetIconUpdateInterval()
    for f=1,10 do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][f]["FADE"] then
            HealBot_iconUpdate["DEBUFF"][f]=0.2
        else
            HealBot_iconUpdate["DEBUFF"][f]=1
        end
        if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][f]["SDUR"] then
        elseif HealBot_iconUpdate["DEBUFF"][f]==1 then
            HealBot_iconUpdate["DEBUFF"][f]=1000
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][f]["BUFFFADE"] then
            HealBot_iconUpdate["BUFF"][f]=0.2
        else
            HealBot_iconUpdate["BUFF"][f]=1
        end
        if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][f]["BUFFSDUR"] then
        elseif HealBot_iconUpdate["BUFF"][f]==1 then
            HealBot_iconUpdate["BUFF"][f]=1000
        end
    end
      --HealBot_setCall("HealBot_Aura_SetIconUpdateInterval")
end

function HealBot_Aura_Update_UnitAllBuffIcons(button)
    if button then
        for i=1,button.icon.buff.count do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=1,xButton.icon.buff.count do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=1,xButton.icon.buff.count do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=1,xButton.icon.buff.count do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=1,xButton.icon.buff.count do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=1,xButton.icon.buff.count do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
    end
end

function HealBot_Aura_Update_UnitAllDebuffIcons(button)
    if button then
        for i=51,button.icon.debuff.count+50 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=51,xButton.icon.debuff.count+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=51,xButton.icon.debuff.count+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=51,xButton.icon.debuff.count+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=51,xButton.icon.debuff.count+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=51,xButton.icon.debuff.count+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
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
            elseif GetSpellInfo(id) then
                sName=GetSpellInfo(id)
            end
            --local giftNaaru=false
            --if sName==HealBot_Spell_IDs[HEALBOT_GIFT_OF_THE_NAARU] or (HealBot_Spell_Names[sName] or 0)==HEALBOT_GIFT_OF_THE_NAARU then
            --    giftNaaru=true
            --end
            if xClass=="ALL" and x==3 then
                if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
                    if HealBot_Globals.CustomBuffIDMethod[id]==2 and sName then
                        HealBot_Watch_HoT[sName]="C"
                    else
                        HealBot_Watch_HoT[id]="C"
                    end
                else
                    HealBot_Watch_HoT[id]="C"
                    if sName then HealBot_Watch_HoT[sName]="C" end
                end
              --  if giftNaaru and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="C" end
            elseif (x==4) or (x==3 and xClass==HealBot_Data["PCLASSTRIM"]) then
                if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
                    if HealBot_Globals.CustomBuffIDMethod[id]==2 and sName then
                        HealBot_Watch_HoT[sName]="A"
                    else
                        HealBot_Watch_HoT[id]="A"
                    end
                else
                    HealBot_Watch_HoT[id]="A"
                    if sName then HealBot_Watch_HoT[sName]="A" end
                end
            --    if giftNaaru and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="A" end
            elseif x==2 then
                if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
                    if HealBot_Globals.CustomBuffIDMethod[id]==2 and sName then
                        HealBot_Watch_HoT[sName]="S"
                    else
                        HealBot_Watch_HoT[id]="S"
                    end
                else
                    HealBot_Watch_HoT[id]="S"
                    if sName then HealBot_Watch_HoT[sName]="S" end
                end
            --    if giftNaaru and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="S" end
            --else
            --    HealBot_Watch_HoT[sName]="H"
            end
        end
    end
    for id,_ in pairs(HealBot_Watch_HoT) do
        if not HealBot_Watch_HoT[id] then HealBot_Watch_HoT[id]=nil end
    end
    HealBot_Aura_setCustomBuffFilterDisabled()
      --HealBot_setCall("HealBot_configClassHoT")
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
    else
        HealBot_Weapon_Enchant[x]=false
    end
end

function HealBot_Aura_UpdateItemData(iName, id)
    if iName then
        if HealBot_IsItemInBag(id) then 
            hbWeaponEnchants[iName]=true
        --    HealBot_AddDebug("Item "..iName.." in bag","Buff",true)
        else
            hbWeaponEnchants[iName]=false 
        --    HealBot_AddDebug("Item "..iName.." NOT in bag","Buff",true)
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

    if HealBot_Config_Buffs.CheckWellFed then
        hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.WellFedItem) or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) then
            HealBot_Buff_Aura2Item[HEALBOT_WELL_FED] = hbCustomItemID
            if not HealBot_BuffWatch[HealBot_Config_Buffs.WellFedItem] then
                HealBot_Aura_SetBuffWatch(HealBot_Config_Buffs.WellFedItem)
                HealBot_Aura_DeleteExcludeBuffInCache()
            end
        elseif HealBot_BuffWatch[HealBot_Config_Buffs.WellFedItem] then
            HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.WellFedItem)
        end
    end
    
    for x=1,3 do
        if string.len(HealBot_Config_Buffs.CustomBuffName[x])>0 then
            hbCustomItemID=GetItemInfoInstant(HealBot_Config_Buffs.CustomItemName[x]) or 0
            if HealBot_Config_Buffs.CustomBuffCheck[x] and hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) then
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
    HealBot_Timers_Set("AURA","DeleteExcludeBuffInCache")
    HealBot_Timers_Set("AURA","ResetBuffCache")
    HealBot_Timers_Set("AURA","CheckPlayer")
    
end

function HealBot_Aura_InitItemsData()
    if HealBot_retLuVars("BagsScanned") then
        HealBot_Timers_Set("INITSLOW","InitItemsDataReady")
    else
        HealBot_Timers_Set("LAST","InitItemsData")
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
        sName=GetSpellInfo(HBC_INNER_FIRE)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        sName=GetSpellInfo(HBC_THORNS)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_OMEN_OF_CLARITY)
        if sName then HealBot_ShortBuffs[sName]=true end
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
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_DETECT_LESSER_INVISIBILITY) or "x")] = HBC_INV_ID,
                [(GetSpellInfo(HBC_DETECT_INVISIBILITY) or "x")] = HBC_INV_ID,
                [(GetSpellInfo(HBC_DETECT_GREATER_INVISIBILITY) or "x")] = HBC_INV_ID,
            }
        end
        
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
                              
        HealBot_Classic_Absorbs={[GetSpellInfo(HEALBOT_POWER_WORD_SHIELD)]={[17]=48,
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
                                                                            [25218]=1265,},
                                 [GetSpellInfo(HEALBOT_ICE_BARRIER)]={[11426]=455,
                                                                      [13031]=569,
                                                                      [13032]=700,
                                                                      [13033]=824,
                                                                      [27134]=952,
                                                                      [33405]=1075,},
                                 [GetSpellInfo(HBC_MANA_SHIELD)]={[1463]=120,
                                                                  [8494]=210,
                                                                  [8495]=300,
                                                                  [10191]=390,
                                                                  [10192]=480,
                                                                  [10193]=570,
                                                                  [27131]=715,},
                                }
        
    end
    
    HealBot_Timers_Set("LAST","InitItemsData")
end
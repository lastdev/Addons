local spellLeft, LeftR, LeftG = nil,nil,nil
local spellMiddle, MiddleR, MiddleG = nil,nil,nil
local spellRight, RightR, RightG = nil,nil,nil
local spellButton4, Button4R, Button4G = nil,nil,nil
local spellButton5, Button5R, Button5G = nil,nil,nil
local hlth, maxhlth, linenum = 1,2,1
local id=nil
local lspell=nil
local lspellrank=nil
local r=nil
local g=nil
local b=nil
local a=nil
local br=nil
local bg=nil
local bb=nil
local text=nil
local Heals=nil
local ri=nil
local DebuffType=nil
local uName=nil
local uBuff=nil
local spellLeftRecInstant=nil
local spellMiddleRecInstant=nil
local spellRightRecInstant=nil
local spellButton4RecInstant=nil
local spellButton5RecInstant=nil
local hlthdelta, tmpnum=0,0
local height = 20 
local width = 0
local txtL = nil
local txtR = nil
local ret_val = "  ";
local linenum=1
local raidID=nil
local zone=nil;
local Instant_check=false
local top,left,right = nil,nil,nil
local x, y, z = nil,nil,nil
local HealBot_CheckBuffs = {}
local HealBot_Tooltip_DirtyLines={}
local mins,secs=0,0
local sName,sRank=nil,nil
local vUnit=nil
local xGUID=nil
local tp=nil
local mana, maxmana = nil, nil
local doTalentRequest={}
local hbGameTooltip = CreateFrame("GameTooltip", "hbGameTooltip", nil, "GameTooltipTemplate")
local _

function HealBot_Tooltip_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Tooltip_CheckBuffs(buff)
    HealBot_CheckBuffs[buff]=buff;
    z=HealBot_AltBuffNames(buff)
    if z then 
        HealBot_CheckBuffs[z]=buff; 
    end
end

function HealBot_talentSpam(hbGUID,cmd,status)
    if cmd=="insert" then
        if not doTalentRequest[hbGUID] then doTalentRequest[hbGUID]=1 end
    elseif cmd=="remove" then
        doTalentRequest[hbGUID]=nil
    else
        if not doTalentRequest[hbGUID] then 
            doTalentRequest[hbGUID]=1 
        else
            doTalentRequest[hbGUID]=status
        end
    end
end

function HealBot_Tooltip_ReturnMinsSecs(s)
    mins=floor(s/60)
    secs=floor(s-(mins*60))
  --  mins=mins+1
    if secs<10 then secs="0"..secs end
    return mins,secs
end

local UnitOffline=nil
local hbCommands = { [strlower(HEALBOT_DISABLED_TARGET)]=true,
                     [strlower(HEALBOT_ASSIST)]=true, 
                     [strlower(HEALBOT_FOCUS)]=true,
                     [strlower(HEALBOT_MENU)]=true,
                     [strlower(HEALBOT_HBMENU)]=true,
                     [strlower(HEALBOT_MAINTANK)]=true,
                     [strlower(HEALBOT_MAINASSIST)]=true,
                     [strlower(HEALBOT_STOP)]=true,
                     [strlower(HEALBOT_TELL)]=true,
                    }
function HealBot_Action_RefreshTooltip(unit, state)
    if HealBot_Globals.ShowTooltip==0 then return end
    if not unit then return end;
    if HealBot_Globals.DisableToolTipInCombat==1 and HealBot_IsFighting then return end
  
    uName=UnitName(unit);
    if (not uName) then return end;
    xGUID=HealBot_UnitGUID(unit)
    
    HealBot_ToolTip_SetTooltipPos();
  
    if unit=="target" and HealBot_Globals.TargetBarRestricted==1 then
        HealBot_Action_RefreshTargetTooltip(xGUID, unit)
        return
    end
  
    hlth,maxhlth=HealBot_UnitHealth(xGUID, unit)
    mana,maxmana=HealBot_UnitMana(unit)

    if hlth>maxhlth then
        maxhlth=HealBot_CorrectPetHealth(unit,hlth,maxhlth,xGUID)
    end
  
    UnitOffline=HealBot_Action_GetTimeOffline(xGUID); --added by Diacono
    uBuff=HealBot_UnitBuff[xGUID]
    if HealBot_UnitDebuff[xGUID] then
        DebuffType=HealBot_UnitDebuff[xGUID]["type"];
    else
        DebuffType=nil
    end

    spellLeft = HealBot_Action_SpellPattern("Left", state);
    spellMiddle = HealBot_Action_SpellPattern("Middle", state);
    spellRight = HealBot_Action_SpellPattern("Right", state);
    spellButton4 = HealBot_Action_SpellPattern("Button4", state);
    spellButton5 = HealBot_Action_SpellPattern("Button5", state);
    linenum = 1
    
    if spellLeft and strsub(strlower(spellLeft),1,4)==strlower(HEALBOT_TELL) then spellLeft=HEALBOT_TELL end
    if spellMiddle and strsub(strlower(spellMiddle),1,4)==strlower(HEALBOT_TELL) then spellMiddle=HEALBOT_TELL end
    if spellRight and strsub(strlower(spellRight),1,4)==strlower(HEALBOT_TELL) then spellRight=HEALBOT_TELL end
    if spellButton4 and strsub(strlower(spellButton4),1,4)==strlower(HEALBOT_TELL) then spellButton4=HEALBOT_TELL end
    if spellButton5 and strsub(strlower(spellButton5),1,4)==strlower(HEALBOT_TELL) then spellButton5=HEALBOT_TELL end
  
    if not IsModifierKeyDown() and not HealBot_IsFighting and HealBot_Globals.SmartCast==1 then 
        z=spellLeft;
        spellLeft=nil;
        spellLeft=HealBot_Action_SmartCast(xGUID);
        if not spellLeft then spellLeft=z; end;
    end
    
    if spellLeft=="" then spellLeft=nil; end
    if spellMiddle=="" then spellMiddle=nil; end
    if spellRight=="" then spellRight=nil; end
    if spellButton4=="" then spellButton4=nil; end
    if spellButton5=="" then spellButton5=nil; end
    spellLeft, LeftR, LeftG = HealBot_Tooltip_setspellName(unit, spellLeft, uName)
    spellMiddle, MiddleR, MiddleG = HealBot_Tooltip_setspellName(unit, spellMiddle, uName)
    spellRight, RightR, RightG = HealBot_Tooltip_setspellName(unit, spellRight, uName)
    spellButton4, Button4R, Button4G = HealBot_Tooltip_setspellName(unit, spellButton4, uName)
    spellButton5, Button5R, Button5G = HealBot_Tooltip_setspellName(unit, spellButton5, uName)

    HealBot_Tooltip_ClearLines();
    
    if HealBot_Globals.Tooltip_ShowTarget==1 then
        if uName then
            r,g,b=HealBot_Action_RetHealBot_ClassCol(xGUID, unit)
            if UnitClass(unit) and UnitIsPlayer(unit) then
                if HealBot_Globals.QueryTalents==1 and not HealBot_InspectUnit and HealBot_UnitSpec[xGUID] and (doTalentRequest[xGUID] or 1)==1 then
                    if HealBot_UnitSpec[xGUID]==" " or not HealBot_IsFighting then
                        HealBot_InspectUnit=true
                        HealBot_TalentQuery(unit)
                    end
                end
                text = HealBot_UnitSpec[xGUID] or "" 
                HealBot_Tooltip_SetLine(linenum,uName,r,g,b,1,"Level "..UnitLevel(unit).." "..text.." "..UnitClass(unit),r,g,b,1)                
            elseif UnitLevel(unit) then
                HealBot_Tooltip_SetLine(linenum,uName,r,g,b,1,"Level "..UnitLevel(unit),r,g,b,1)    
            else
                HealBot_Tooltip_SetLine(linenum,uName,r,g,b,1)     
            end      
      
            zone=nil;
            if HealBot_PlayerName==uName or UnitIsVisible(unit) then
                zone=GetRealZoneText();
            elseif GetNumGroupMembers()>0 and unit~="target" then
                if strsub(unit,1,4)~="raid" then
                    if UnitInRaid(unit) then
                        for r=1,40 do
                            if UnitName("raid"..r)==uName then
                                raidID=r
                                _, _, _, _, _, _, zone, _, _ = GetRaidRosterInfo(raidID);
                                break
                            end
                        end
                    end
                elseif strsub(unit,1,7)~="raidpet" then
                    raidID=tonumber(strsub(unit,5))
                    _, _, _, _, _, _, zone, _, _ = GetRaidRosterInfo(raidID);
                end
            else
                HealBot_TooltipInit();
                HealBot_ScanTooltip:SetUnit(unit)
                zone = HealBot_ScanTooltipTextLeft3:GetText()
                if zone == "PvP" then
                    zone = HealBot_ScanTooltipTextLeft4:GetText()
                end
            end
            linenum=linenum+1
            if hlth and maxhlth then
                hlthdelta=maxhlth-hlth;
                local inHeal, inAbsorb = HealBot_IncHeals_retHealsIn(xGUID)
                r,g,b,a=HealBot_HealthColor(unit,hlth,maxhlth,true,xGUID,false,uBuff,DebuffType,inHeal,inAbsorb);
                if UnitOffline then 
                    HealBot_Tooltip_SetLine(linenum,HB_TOOLTIP_OFFLINE..": "..UnitOffline,1,1,1,1,hlth.."/"..maxhlth.." ("..floor((hlth/maxhlth)*100).."%)",r,g,b,1)
                elseif zone and not strfind(zone,"Level") then
                    if zone==HB_TOOLTIP_OFFLINE then HealBot_Action_UnitIsOffline(xGUID,time()) end
                    HealBot_Tooltip_SetLine(linenum,zone,1,1,1,1,hlth.."/"..maxhlth.." ("..floor((hlth/maxhlth)*100).."%)",r,g,b,1)
                end
                vUnit=HealBot_retIsInVehicle(unit)
                if vUnit then
                    linenum=linenum+1
                    lr,lg,lb=HealBot_Action_RetHealBot_ClassCol(HealBot_UnitGUID(vUnit), vUnit)
                    hlth,maxhlth=HealBot_VehicleHealth(vUnit)
                    r,g,b,a=HealBot_HealthColor(vUnit,hlth,maxhlth,true,HealBot_UnitGUID(vUnit),false,uBuff,DebuffType,0,0);
                    if UnitExists(vUnit) then
                        HealBot_Tooltip_SetLine(linenum,"  "..UnitName(vUnit),lr,lg,lb,1,hlth.."/"..maxhlth.." ("..floor((hlth/maxhlth)*100).."%)",r,g,b,1)
                    else
                        HealBot_Tooltip_SetLine(linenum,"  "..HEALBOT_VEHICLE,lr,lg,lb,1,hlth.."/"..maxhlth.." ("..floor((hlth/maxhlth)*100).."%)",r,g,b,1)
                    end
                end
            end
            tp,_ = HealBot_CalcThreat(unit)
            if tp>0 or mana then
                linenum=linenum+1
                if not mana then
                    HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_THREAT.." "..tp.."%",1,0.1,0.1,1," ",0,0,0,0)
                elseif tp==0 then
                    HealBot_Tooltip_SetLine(linenum," ",0,0,0,0,mana.."/"..maxmana.." ("..floor((mana/maxmana)*100).."%)",0.4,0.4,1,1)
                else
                    HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_THREAT.." "..tp.."%",1,0.1,0.1,1,mana.."/"..maxmana.." ("..floor((mana/maxmana)*100).."%)",0.4,0.4,1,1)
                end
            end
            if DebuffType then
                linenum=linenum+1
                if HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]] then
                    HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..HealBot_UnitDebuff[xGUID]["name"],
                                                (HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].R or 0.4)+0.2,
                                                (HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].G or 0.05)+0.2,
                                                (HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].B or 0.2)+0.2,
                                                1," ",0,0,0,0)
                elseif DebuffType == HEALBOT_CUSTOM_en then
                    HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..HealBot_UnitDebuff[xGUID]["name"],
                                                (HealBot_Globals.CDCBarColour[DebuffType].R or 0.5)+0.2,
                                                (HealBot_Globals.CDCBarColour[DebuffType].G or 0.2)+0.2,
                                                (HealBot_Globals.CDCBarColour[DebuffType].B or 0.4)+0.2,
                                                1," ",0,0,0,0)
                else
                    HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..HealBot_UnitDebuff[xGUID]["name"],
                                                (HealBot_Config.CDCBarColour[DebuffType].R or 0.5)+0.2,
                                                (HealBot_Config.CDCBarColour[DebuffType].G or 0.2)+0.2,
                                                (HealBot_Config.CDCBarColour[DebuffType].B or 0.4)+0.2,
                                                1," ",0,0,0,0)
                end
            end
            linenum=linenum+1
            --if HealBot_Globals.UseGameTooltip==1 then HealBot_Tooltip_SetLine(linenum,"  ",0,0,0,0) end
            if uBuff then
                linenum=linenum+1
                br,bg,bb=HealBot_Options_RetBuffRGB(uBuff)
                HealBot_Tooltip_SetLine(linenum,"  Requires "..uBuff,br,bg,bb,1," ",0,0,0,0)
            end
            d=false
            if HealBot_Globals.Tooltip_ShowMyBuffs==1 then
                for x,y in pairs(HealBot_CheckBuffs) do
                    z=HealBot_RetMyBuffTime(xGUID,x)
                    if z then
                        d=true
                        z=z-GetTime()
                        mins,secs=HealBot_Tooltip_ReturnMinsSecs(z)
                        linenum=linenum+1
                        br,bg,bb=HealBot_Options_RetBuffRGB(y)
                        if mins>1 then 
                            HealBot_Tooltip_SetLine(linenum,"    "..x.."  "..mins.." mins",br,bg,bb,1," ",0,0,0,0)
                        elseif tonumber(secs)>=0 then
                            HealBot_Tooltip_SetLine(linenum,"    "..x.."  "..secs.." secs",br,bg,bb,1," ",0,0,0,0)
                        else
                            linenum=linenum-1
                            HealBot_Queue_MyBuffsCheck(xGUID, unit)
                        end
                    end
                end
            end
            if d then 
                linenum=linenum+1 
            end
            if HealBot_Globals.UseGameTooltip==1 then HealBot_Tooltip_SetLine(linenum,"  ",0,0,0,0) end
            if HealBot_Globals.ProtectPvP==1 and UnitIsPVP(unit) and not UnitIsPVP("player") then 
                HealBot_Tooltip_SetLine(linenum,"    ----- PVP -----",1,0.5,0.5,1,"----- PVP -----    ",1,0.5,0.5,1)
                linenum=linenum+1;
            end
        end
    else
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_TAB_SPELLS,1,1,1,1," ",0,0,0,0)
    end
  
    spellLeftRecInstant=HealBot_Tooltip_CheckForInstant(unit,spellLeft);
    spellMiddleRecInstant=HealBot_Tooltip_CheckForInstant(unit,spellMiddle)
    spellRightRecInstant=HealBot_Tooltip_CheckForInstant(unit,spellRight)
    spellButton4RecInstant=HealBot_Tooltip_CheckForInstant(unit,spellButton4)
    spellButton5RecInstant=HealBot_Tooltip_CheckForInstant(unit,spellButton5);
    
    if HealBot_Globals.Tooltip_ShowSpellDetail==1 then

        if spellLeft then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONLEFT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellLeft,LeftR,LeftG,0,1) 
            HealBot_Tooltip_SpellInfo(spellLeft);
            linenum=linenum+1;
        end
        if spellMiddle then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONMIDDLE.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellMiddle,MiddleR,MiddleG,0,1) 
            HealBot_Tooltip_SpellInfo(spellMiddle);
            linenum=linenum+1;
        end
        if spellRight then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONRIGHT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellRight,RightR,RightG,0,1) 
            HealBot_Tooltip_SpellInfo(spellRight);
            linenum=linenum+1;
        end
        if spellButton4 then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON4.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellButton4,Button4R,Button4G,0,1) 
            HealBot_Tooltip_SpellInfo(spellButton4);
            linenum=linenum+1;
        end
        if spellButton5 then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON5.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellButton5,Button5R,Button5G,0,1) 
            HealBot_Tooltip_SpellInfo(spellButton5);
            linenum=linenum+1;
        end
    else
        tmpnum=0;
        if spellLeft then 
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONLEFT..": "..spellLeft,LeftR,LeftG,0,1,HealBot_Tooltip_SpellSummary(spellLeft),0.5,0.5,1,1)
        end
        if spellMiddle then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONMIDDLE..": "..spellMiddle,MiddleR,MiddleG,0,1,HealBot_Tooltip_SpellSummary(spellMiddle),0.5,0.5,1,1)               
        end
        if spellRight then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONRIGHT..": "..spellRight,RightR,RightG,0,1,HealBot_Tooltip_SpellSummary(spellRight),0.5,0.5,1,1)
        end
        if spellButton4 then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON4..": "..spellButton4,Button4R,Button4G,0,1,HealBot_Tooltip_SpellSummary(spellButton4),0.5,0.5,1,1)
        end
        if spellButton5 then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON5..": "..spellButton5,Button5R,Button5G,0,1,HealBot_Tooltip_SpellSummary(spellButton5),0.5,0.5,1,1)
        end
    end      
    if HealBot_Globals.Tooltip_Recommend==1 then
        Instant_check=false;
        if HealBot_Globals.Tooltip_ShowSpellDetail==0 then linenum=linenum+1; end
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_TOOLTIP_RECOMMENDTEXT,0.8,0.8,0,1) 
        if spellLeftRecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,"   "..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,1,spellLeft.."    ",1,1,1,1)
            Instant_check=true;
        end
        if spellMiddleRecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,"   "..HEALBOT_OPTIONS_BUTTONMIDDLE..":",1,1,0.2,1,spellMiddle.."    ",1,1,1,1)
            Instant_check=true;
        end
        if spellRightRecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,"   "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,spellRight.."    ",1,1,1,1)
            Instant_check=true;
        end
        if spellButton4RecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,"   "..HEALBOT_OPTIONS_BUTTON4..":",1,1,0.2,1,spellButton4.."    ",1,1,1,1)
            Instant_check=true;
        end
        if spellButton5RecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,"   "..HEALBOT_OPTIONS_BUTTON5..":",1,1,0.2,1,spellButton5.."    ",1,1,1,1)
            Instant_check=true;
        end
        if not Instant_check then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,"  None",0.4,0.4,0.4,1) 
        end
    else
        if HealBot_Globals.Tooltip_ShowSpellDetail==1 then linenum=linenum-1; end
    end
  
    HealBot_ToolTip_ShowHoT(xGUID)
    
    HealBot_Tooltip_Show()
end

function HealBot_Tooltip_setspellName(unit, spellName, uName)
    local validSpellName=spellName
    local spellAR,spellAG=1,0
    if spellName then
        spellAR,spellAG=0,1
        if not hbCommands[strlower(spellName)] then
            x=GetMacroIndexByName(spellName)
            if x==0 then 
                if (HealBot_Spells[validSpellName] and HealBot_Spells[validSpellName].Level and tonumber(HealBot_Spells[validSpellName].Level)>UnitLevel("player")) then 
                    validSpellName=nil
                else
                    validSpellName, spellAR, spellAG = HealBot_Tooltip_GetHealSpell(unit,spellName,uName) 
                    if validSpellName then
                        z, x, _ = GetSpellCooldown(spellName);
                        if x and x>1 then 
                            z = HealBot_Comm_round(x-(GetTime()-z),3)
                            if HealBot_Globals.Tooltip_ShowCD==1 then
                                z = HealBot_Comm_round(z,1)
                                validSpellName=validSpellName..HEALBOT_TOOLTIP_CD..z..HEALBOT_TOOLTIP_SECS 
                                if z>0 then spellAR,spellAG=1,0 end
                            elseif z>0.101 then
                                spellAR,spellAG=1,0
                            end
                        end
                    end
                end
            else
                spellAR,spellAG=1,1
            end
        end
    end
    return validSpellName, spellAR, spellAG
end

local HealBot_Tooltip_Power = 9
function HealBot_Tooltip_SpellInfo(spellName)
    text=nil
    if HealBot_Spells[spellName] then
        if HealBot_Spells[spellName].Mana>0 then
            linenum=linenum+1
            if HealBot_Spells[spellName].Mana<HealBot_Tooltip_Power then
                HealBot_Tooltip_SetLine(linenum,HEALBOT_WORDS_CAST..": "..HealBot_Spells[spellName].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,1,"Power: "..HealBot_Spells[spellName].Mana,0.4,0.4,1,1)
            else
                HealBot_Tooltip_SetLine(linenum,HEALBOT_WORDS_CAST..": "..HealBot_Spells[spellName].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,1,"Mana: "..HealBot_Spells[spellName].Mana,0.4,0.4,1,1)
            end
        end
    elseif HealBot_OtherSpells[spellName] then
        linenum=linenum+1 
        HealBot_Tooltip_SetLine(linenum,HEALBOT_WORDS_CAST..": "..HealBot_OtherSpells[spellName].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,1,"Mana: "..HealBot_OtherSpells[spellName].Mana,0.4,0.4,1,1)
    end
end

function HealBot_Tooltip_SpellSummary(spellName)
    ret_val = "  "
    if HealBot_Spells[spellName] then
        if HealBot_Spells[spellName].Mana<HealBot_Tooltip_Power then
            ret_val = " -  "..HealBot_Spells[spellName].Mana.." Power"
        else
            ret_val = " -  "..HealBot_Spells[spellName].Mana.." Mana"
        end
    elseif HealBot_OtherSpells[spellName] then
        ret_val = " -  "..HealBot_OtherSpells[spellName].Mana.." Mana"
    end
    if strlen(ret_val)<5 then ret_val = " - "..spellName; end
    return ret_val;
end

function HealBot_Tooltip_CheckForInstant(unit,spellName)
    if spellName and HealBot_Spells[spellName] then
        if HealBot_Spells[spellName].HoT then
            if HealBot_HasUnitBuff(HealBot_Spells[spellName].HoT,unit,"player") then return false end;  
            return true;
        end
    end
    return false;
end

local hbTTHoTinfo1=nil
local hbTTHoTinfo2=nil
local ttCaster=nil
local ttHoT=nil
local ttHoTd=nil
local ttHoTdt=nil
local ttHoTc=nil
local ttHoTright=nil
local hbHoTline1=nil
function HealBot_ToolTip_ShowHoT(hbGUID)
    if HealBot_Globals.Tooltip_ShowHoT==1 then
        hbHoTline1=true
        hbTTHoTinfo1, hbTTHoTinfo2=HealBot_retHoTdetails(hbGUID)
        if hbTTHoTinfo1 then
            for x,y in pairs(hbTTHoTinfo1) do
                if y>0 and y<15 and linenum<44 then
                    xGUID,ttHoT=string.split("!", x)
                    if xGUID and ttHoT then
                        ttCaster=HealBot_UnitName[xGUID] or HEALBOT_WORDS_UNKNOWN
                        if hbHoTline1 then
                            hbHoTline1=nil
                            linenum=linenum+1
                        end
                        linenum=linenum+1
                        if hbTTHoTinfo2[x] then
                            ttHoTd=floor(hbTTHoTinfo2[x]-GetTime())
                        else
                            ttHoTd=nil
                        end
                        ttHoTc=HealBot_retHoTcount(x,hbGUID)
                        ttHoTright=nil
                        if ttHoTd and ttHoTd>60 then
                            ttHoTdt=floor(ttHoTd/60)
                            if ttHoTdt>120 then
                                ttHoTd=nil
                            else
                                ttHoTd=ttHoTd - (ttHoTdt*60)
                                if ttHoTd<10 then ttHoTd="0"..ttHoTd end
                                ttHoTd=ttHoTdt.."m "..ttHoTd
                            end
                        end
                        if ttHoTd then 
                            ttHoTright=" "..HEALBOT_OPTIONS_HOTTEXTDURATION..": "..ttHoTd.."s   " 
                        else
                            ttHoTright=" "
                        end
                        if ttHoTc then 
                            ttHoTright=ttHoTright..HEALBOT_OPTIONS_HOTTEXTCOUNT..": "..ttHoTc.."   " 
                        else
                            ttHoTright=ttHoTright.."   " 
                        end
                        if ttHoTright then 
                            HealBot_Tooltip_SetLine(linenum,"   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttHoT.." ",0.4,1,1,1,ttHoTright,0.7,1,0.7,1)
                        else
                            HealBot_Tooltip_SetLine(linenum,"   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttHoT.." ",0.4,1,1,1)
                        end
                    end
                end
            end
        end
    end
end

function HealBot_ToolTip_SetTooltipPos()
    if HealBot_Globals.UseGameTooltip==1 then
        if Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]>1 then
            top = HealBot_Action:GetTop();
            x, y = GetCursorPosition();
            x=x/UIParent:GetScale();
            y=y/UIParent:GetScale();
            if Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==2 then
                left=HealBot_Action:GetLeft()
                GameTooltip:SetOwner(HealBot_Action, "ANCHOR_LEFT", 0, 0-(top-(y-50)))
            elseif Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==3 then
                GameTooltip:SetOwner(HealBot_Action, "ANCHOR_RIGHT", 0, 0-(top-(y-50)))
            elseif Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==4 then
               GameTooltip:SetOwner(HealBot_Action, "ANCHOR_TOP")
            elseif Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==5 then
               GameTooltip:SetOwner(HealBot_Action, "ANCHOR_BOTTOM")
            else
                GameTooltip:SetOwner(HealBot_Action, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x+25,y-20);
            end
        else
            GameTooltip:SetOwner(HealBot_Action, "ANCHOR_NONE")
            GameTooltip_SetDefaultAnchor(GameTooltip, hbGameTooltip)
        end
    else
        HealBot_Tooltip:ClearAllPoints();
        if Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]>1 then
            top = HealBot_Action:GetTop();
            x, y = GetCursorPosition();
            x=x/UIParent:GetScale();
            y=y/UIParent:GetScale();
            if Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==2 then
                HealBot_Tooltip:SetPoint("TOPRIGHT","HealBot_Action","TOPLEFT",0,0-(top-(y+35)));
            elseif Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==3 then
                HealBot_Tooltip:SetPoint("TOPLEFT","HealBot_Action","TOPRIGHT",0,0-(top-(y+35)));
            elseif Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==4 then
                HealBot_Tooltip:SetPoint("BOTTOM","HealBot_Action","TOP",0,0);
            elseif Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Current_Skin]==5 then
                HealBot_Tooltip:SetPoint("TOP","HealBot_Action","BOTTOM",0,0);
            else
                HealBot_Tooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x+25,y-20);
            end
        else
            HealBot_Tooltip:SetPoint("BOTTOMRIGHT","WorldFrame","BOTTOMRIGHT",-105,105);
        end
    end
end

function HealBot_Tooltip_SetLine(lNo,lText,lR,lG,lB,la,rText,rR,rG,rB,ra)
    if rText then
        if HealBot_Globals.UseGameTooltip==1 then
            GameTooltip:AddDoubleLine(lText,rText,lR,lG,lB,rR,rG,rB)
        else
            HealBot_Tooltip_SetLineLeft(lText,lR,lG,lB,lNo,la)
            HealBot_Tooltip_SetLineRight(rText,rR,rG,rB,lNo,ra)
        end
    else
        if HealBot_Globals.UseGameTooltip==1 then
            GameTooltip:AddLine(lText,lR,lG,lB)
        else
            HealBot_Tooltip_SetLineLeft(lText,lR,lG,lB,lNo,la)
        end
    end
end

function HealBot_Tooltip_SetLineLeft(Text,R,G,B,lNo,a)
    if lNo>40 then return end
    txtL = _G["HealBot_TooltipTextL" .. lNo]
    txtL:SetTextColor(R,G,B,a)
    txtL:SetText(Text)
    txtL:Show()
    HealBot_Tooltip_DirtyLines[lNo]=true
end

function HealBot_Tooltip_SetLineRight(Text,R,G,B,lNo,a)
    if lNo>40 then return end
    txtR = _G["HealBot_TooltipTextR" .. lNo]
    txtR:SetTextColor(R,G,B,a)
    txtR:SetText(Text)
    txtR:Show()
    HealBot_Tooltip_DirtyLines[lNo]=true
end

function HealBot_Tooltip_ClearLines()
    if HealBot_Globals.UseGameTooltip==1 then
        GameTooltip:ClearLines()
    else
        for x,_ in pairs(HealBot_Tooltip_DirtyLines) do
            txtR = _G["HealBot_TooltipTextR" .. x]
            txtR:SetText(" ")
            txtL = _G["HealBot_TooltipTextL" .. x]
            txtL:SetText(" ")
            HealBot_Tooltip_DirtyLines[x]=nil
        end
    end
end

local timeOffline,uOffline = nil,nil
local hours, minutes, seconds
function HealBot_Action_GetTimeOffline(hbGUID)
    uOffline=HealBot_Action_retUnitOffline(hbGUID)
    timeOffline=nil
    if uOffline then
        timeOffline = time() - uOffline;
        seconds = timeOffline % 60;
        minutes = math.floor(timeOffline / 60) % 60
        hours = math.floor(timeOffline / 3600)
        timeOffline = "";
        if hours > 0 then
            if hours == 1 then
                timeOffline = hours.." hour ";
            else
                timeOffline = hours.." hours ";
            end
        end
        if minutes > 0 then
            if minutes == 1 then
                timeOffline = timeOffline..minutes.." min ";
            else
                timeOffline = timeOffline..minutes.." mins ";
            end
        end
        if seconds > 0 then
            if seconds == 1 then
                timeOffline = timeOffline..seconds.." sec";
            else
                timeOffline = timeOffline..seconds.." secs";
            end
        end                        
    end      
    return timeOffline;
end

function HealBot_Action_RefreshTargetTooltip(hbGUID, unit)
    HealBot_TooltipInit();
    HealBot_Tooltip_ClearLines();
    linenum=1
    r,g,b=HealBot_Action_RetHealBot_ClassCol(hbGUID)

    if UnitClass(unit) then
        text = HealBot_UnitSpec[hbGUID] or " "
        HealBot_Tooltip_SetLine(linenum,HealBot_UnitName[hbGUID],r,g,b,1,"Level "..UnitLevel(unit)..text..UnitClass(unit),r,g,b,1)    
    else
        HealBot_Tooltip_SetLine(linenum,HealBot_UnitName[hbGUID],r,g,b,1,rText,rR,rG,rB,ra)
    end
    linenum=linenum+1
    HealBot_Tooltip_SetLine(linenum,HEALBOT_TOOLTIP_TARGETBAR,1,1,0.5,1,HEALBOT_OPTIONS_TAB_SPELLS.." "..HEALBOT_SKIN_DISTEXT,1,1,0,1)
    linenum=linenum+2
    if HealBot_Globals.SmartCast==1 then
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,1,HEALBOT_TITAN_SMARTCAST.." ",1,1,1,1)
    end
    if HealBot_UnitID[hbGUID] then
        linenum=linenum+1
        HealBot_Tooltip_SetLineLeft(" "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,linenum,1)
        if HealBot_Panel_RetMyHealTarget(hbGUID) then
            HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_TARGETHEALS.." ",1,1,1,1)
        else
            HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_TARGETHEALS.." ",1,1,1,1)
        end
    end
  
    HealBot_Tooltip_Show()
end

local hbTT_Valid={}

function HealBot_Tooltip_GetHealSpell(unit,pattern,unitName)
 
    if not HealBot_Spells[pattern] then
        id = HealBot_GetSpellId(pattern);
    elseif HealBot_Spells[pattern].id then
        id = HealBot_Spells[pattern].id
    else
        id = HealBot_GetSpellId(pattern);
    end
    sName, sRank = HealBot_GetSpellName(id)
    if not sName then 
        if pattern then
            local w, _ = IsUsableItem(pattern, unit)
            if not w then
                return nil, 1, 0
            else
                if unitName~=HealBot_PlayerName then
                    if IsItemInRange(pattern,unit)~=1 then
                        return pattern, 1, 0
                    else
                        return pattern, 0, 1
                    end
                else
                    return pattern, 0, 1
                end
            end
        else
            return nil, 1, 0
        end
    end

    if (HealBot_UnitInRange(sName, unit)~=1) then
        return sName, 1, 0
    end
 
    return sName, 0, 1
end

function HealBot_Tooltip_Show()
    if HealBot_Globals.UseGameTooltip==1 then
        GameTooltip:Show();
    else
        height = 20 
        width = 0
        for x = 1, linenum do
            txtL = _G["HealBot_TooltipTextL" .. x]
            txtR = _G["HealBot_TooltipTextR" .. x]
            height = height + txtL:GetHeight() + 2
            if (txtL:GetWidth() + txtR:GetWidth() + 25 > width) then
                width = txtL:GetWidth() + txtR:GetWidth() + 25
            end
        end
        HealBot_Tooltip:SetWidth(width)
        HealBot_Tooltip:SetHeight(height)
        HealBot_Tooltip:Show();
    end
end
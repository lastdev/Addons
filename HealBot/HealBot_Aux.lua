local HealBot_Aux_Buttons={}
local HealBot_AuxStatic_Buttons={}
local HealBot_AuxFluid_Buttons={}
local HealBot_AuxTimed_Buttons={}
local HealBot_AuxFluid_ButtonsAlpha={}
local aBarActive,ufaBarActive,aBarSetValue,aBarGetValue=false,false,0,0
local HealBot_Aux_luVars={}

HealBot_Aux_luVars["auxAlpha"]=0.1
HealBot_Aux_luVars["AUXOMIN"]=0.1
HealBot_Aux_luVars["AUXOMAX"]=0.95
HealBot_Aux_luVars["FLUIDSTATEFREQ"]=0.05
HealBot_Aux_luVars["FLUIDFREQ"]=10
HealBot_Aux_luVars["OFREQ"]=0.07
HealBot_Aux_luVars["FluidFlashInUse"]=true

function HealBot_Aux_setLuVars(vName, vValue)
    HealBot_Aux_luVars[vName]=vValue
      --HealBot_setCall("HealBot_setLuVars")
end

local hbAuxTextMaxChars={[1]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [2]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [3]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [4]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [5]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [6]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [7]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [8]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [9]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                        [10]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                        }
function HealBot_Aux_setTextMaxChars(frame, size, id)
    hbAuxTextMaxChars[frame][id]=size
end

local function HealBot_Aux_clearBar(button, id)
    button.aux[id]["FLASH"]=false
    button.aux[id]["STATIC"]=false
    button.aux[id]["FLUID"]=-1
    button.aux[id]["TIMED"]=-1
    button.aux[id]["TIMEDH2L"]=-1
    button.aux[id]["TIMEDL2H"]=-1
    button.aux[id]["FLUIDSTATE"]=-1
    button.aux[id]["ISFLUID"]=false
    button.auxtxt[id]["TEXT"]=false
    button.gref.auxtxt[id]:SetText("")
    button.gref.aux[id]:SetStatusBarColor(1,1,1,0)
    button.gref.aux[id]:SetValue(0)
end

local function HealBot_Aux_setBar(button, id, value, isFluid, text, endTime, CastIsChan)
    if button.status.current<9 then
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==2 then
            button.aux[id]["R"]=button.text.r
            button.aux[id]["G"]=button.text.g
            button.aux[id]["B"]=button.text.b
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==3 then
            button.aux[id]["R"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["R"]
            button.aux[id]["G"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["G"]
            button.aux[id]["B"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["B"]
        end
        if isFluid and HealBot_Aux_luVars["FluidInUse"] and not button.mana.init then
            button.aux[id]["FLUID"]=value-- or 0
            HealBot_AuxFluid_Buttons[button.id]=button
            HealBot_Aux_luVars["AuxFluidBarInUse"]=true
        elseif endTime then
            if CastIsChan then
                button.aux[id]["TIMEDH2L"]=value
                button.aux[id]["TIMEDL2H"]=-1
                button.aux[id]["TIMED"]=endTime-value
                button.gref.aux[id]:SetMinMaxValues(0,button.aux[id]["TIMED"])
                button.gref.aux[id]:SetValue(button.aux[id]["TIMED"])
            else
                button.aux[id]["TIMEDH2L"]=-1
                button.aux[id]["TIMEDL2H"]=value
                button.aux[id]["TIMED"]=endTime-value
                button.gref.aux[id]:SetMinMaxValues(0,endTime-value)
                button.gref.aux[id]:SetValue(0)
            end
            HealBot_AuxTimed_Buttons[button.id]=button
            HealBot_Aux_luVars["AuxCastBarInUse"]=true
        else
            button.gref.aux[id]:SetValue(value)
            button.mana.init=false
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==2 then
            button.aux[id]["FLASH"]=true
            button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], HealBot_Aux_luVars["auxAlpha"])
            HealBot_Aux_Buttons[button.id]=button
            HealBot_Aux_luVars["AuxFlashBarsInUse"]=true
        else
            button.aux[id]["STATIC"]=true
            HealBot_AuxStatic_Buttons[button.id]=button
            if HealBot_AuxFluid_Buttons[button.id] then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==3 then
                    button.aux[id]["FLUIDSTATE"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["A"]
                else
                    button.aux[id]["FLUIDSTATE"]=button.status.alpha
                end
                button.aux[id]["ISFLUID"]=true
                HealBot_AuxFluid_ButtonsAlpha[button.id]=button
                HealBot_Aux_luVars["AuxFluidBarAlphaInUse"]=true
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==3 then
                button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["A"])
            else
                button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], button.status.alpha)
            end
        end
        if text then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==2 then
                button.auxtxt[id]["R"]=button.text.r
                button.auxtxt[id]["G"]=button.text.g
                button.auxtxt[id]["B"]=button.text.b
            elseif Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==3 then
                button.auxtxt[id]["R"]=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLR"]
                button.auxtxt[id]["G"]=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLG"]
                button.auxtxt[id]["B"]=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLB"]
            end
            if HealBot_Text_Len(text)>hbAuxTextMaxChars[button.frame][id] then
                text=HealBot_Text_Sub(text,1,hbAuxTextMaxChars[button.frame][id])
            end
            button.gref.auxtxt[id]:SetText(text)
            if button.status.enabled then
                button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLA"])
            else
                button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLDA"])
            end
            button.auxtxt[id]["TEXT"]=true
        else
            button.gref.auxtxt[id]:SetText("")
            button.auxtxt[id]["TEXT"]=false
        end
    else
        HealBot_Aux_clearBar(button, id)
    end
      --HealBot_setCall("HealBot_Aux_setBar")
end

local hbStaticOn=false
function HealBot_Aux_UpdBar(button, noFluid)
    hbStaticOn=false
    for x=1,9 do
        if button.aux[x]["STATIC"] then
            hbStaticOn=true
            if not noFluid and button.aux[x]["ISFLUID"] then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OTYPE"]==3 then
                    button.aux[x]["FLUIDSTATE"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["A"]
                else
                    button.aux[x]["FLUIDSTATE"]=button.status.alpha
                end
                HealBot_AuxFluid_ButtonsAlpha[button.id]=button
                HealBot_Aux_luVars["AuxFluidBarAlphaInUse"]=true
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OTYPE"]==3 then
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["A"])
            else
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], button.status.alpha)
            end
        end
        if button.auxtxt[x]["TEXT"] then
            if button.status.enabled then
                button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLA"])
            else
                button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLDA"])
            end
        end
    end
      --HealBot_setCall("HealBot_DoUpdAuxBar")
    if not hbStaticOn and HealBot_AuxStatic_Buttons[button.id] then
        HealBot_AuxStatic_Buttons[button.id]=nil
    end
end

function HealBot_Aux_clearAllBars(button)
    for x=1,9 do
        HealBot_Aux_clearBar(button, x)
    end
    HealBot_OnEvent_UnitManaUpdate(button)
      --HealBot_setCall("HealBot_Aux_clearAllBars")
end

function HealBot_Aux_resetAllBars()
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["STATIC"] then
                xButton.aux[x]["STATIC"]=false
                xButton.aux[x]["ISFLUID"]=false
                xButton.gref.aux[x]:SetStatusBarColor(1,1,1,0)
            end
            if xButton.auxtxt[x]["TEXT"] then
                xButton.gref.auxtxt[x]:SetText("")
                xButton.auxtxt[x]["TEXT"]=false
            end
        end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["FLASH"] then
                xButton.aux[x]["FLASH"]=false
                xButton.gref.aux[x]:SetStatusBarColor(1,1,1,0)
            end
            if xButton.auxtxt[x]["TEXT"] then
                xButton.gref.auxtxt[x]:SetText("")
                xButton.auxtxt[x]["TEXT"]=false
            end
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["FLUID"]>-1 then
                xButton.aux[x]["FLUID"]=-1
            end
        end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["TIMED"]>-1 then
                xButton.aux[x]["TIMED"]=-1
                xButton.aux[x]["TIMEDH2L"]=-1
                xButton.aux[x]["TIMEDL2H"]=-1
            end
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        for x=1,9 do
            if xButton.aux[x]["FLUIDSTATE"]>-1 then
                xButton.aux[x]["FLUIDSTATE"]=0
            end
        end
    end
    HealBot_fastUpdateEveryFrame(1)
      --HealBot_setCall("HealBot_resetAllAuxBar")
end

local hbFlashOn=false
local function HealBot_Aux_DoUpdateVariableBars(button)
    hbFlashOn=false
    for x=1,9 do
        if button.aux[x]["FLASH"] then
            button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], HealBot_Aux_luVars["auxAlpha"])
            hbFlashOn=true
        end
    end
      --HealBot_setCall("HealBot_DoUpdateVariableAuxBars")
    return hbFlashOn
end

local function HealBot_Aux_UpdateVariableBars(upVal)
    HealBot_Aux_luVars["AuxFlashBarsInUse"]=false
    for id,xButton in pairs(HealBot_Aux_Buttons) do
        if not HealBot_Aux_DoUpdateVariableBars(xButton) then
            HealBot_Aux_Buttons[id]=nil
        else
            HealBot_Aux_luVars["AuxFlashBarsInUse"]=true
        end
    end
    if HealBot_Aux_luVars["AuxFlashBarsInUse"] then
        if HealBot_Aux_luVars["AuxAlphaUp"] then
            HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["auxAlpha"]+upVal
            if HealBot_Aux_luVars["auxAlpha"]>=HealBot_Aux_luVars["AUXOMAX"] then 
                HealBot_Aux_luVars["AuxAlphaUp"]=false
                HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["AUXOMAX"]
            end
        else
            HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["auxAlpha"]-upVal
            if HealBot_Aux_luVars["auxAlpha"]<=HealBot_Aux_luVars["AUXOMIN"] then
                HealBot_Aux_luVars["AuxAlphaUp"]=true
                HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["AUXOMIN"]
            end
        end
    end
end

--------------------------------

local function HealBot_Aux_UpdateFluidBarsValue(button, upVal) 
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["FLUID"]>-1 then
            aBarGetValue=button.gref.aux[x]:GetValue()
            if aBarGetValue>button.aux[x]["FLUID"] then
                aBarSetValue=aBarGetValue-upVal
                if aBarSetValue<button.aux[x]["FLUID"] then aBarSetValue=button.aux[x]["FLUID"] end
                ufaBarActive=true
                button.gref.aux[x]:SetValue(aBarSetValue)
            elseif aBarGetValue<button.aux[x]["FLUID"] then
                aBarSetValue=aBarGetValue+upVal
                if aBarSetValue>button.aux[x]["FLUID"] then aBarSetValue=button.aux[x]["FLUID"] end
                ufaBarActive=true
                button.gref.aux[x]:SetValue(aBarSetValue)
            else
                button.aux[x]["FLUID"]=-1
            end
        end
    end
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsValue")
    return ufaBarActive
end

local utaElap=0
local function HealBot_Aux_UpdateTimedBarsValue(button, TimeNow) 
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["TIMED"]>-1 then
            if button.aux[x]["TIMEDH2L"]>-1 then
                utaElap=((TimeNow*1000)-button.aux[x]["TIMEDH2L"])
                if utaElap<button.aux[x]["TIMED"] then
                    button.gref.aux[x]:SetValue(button.aux[x]["TIMED"]-utaElap)
                    ufaBarActive=true
                end
            else
                utaElap=((TimeNow*1000)-button.aux[x]["TIMEDL2H"])
                if utaElap<button.aux[x]["TIMED"] then
                    button.gref.aux[x]:SetValue(utaElap)
                    ufaBarActive=true
                end
            end
        end
    end
      --HealBot_setCall("HealBot_Aux_UpdateTimedBarsValue")
    return ufaBarActive
end

local function HealBot_Aux_UpdateFluidBarsAlphaValue(button, upVal)
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["FLUIDSTATE"]>-1 then
            _,_,_,aBarGetValue=button.gref.aux[x]:GetStatusBarColor()
            aBarGetValue=HealBot_Comm_round(aBarGetValue, 2)
            if aBarGetValue>button.aux[x]["FLUIDSTATE"] then
                aBarSetValue=aBarGetValue-upVal
                if aBarSetValue<button.aux[x]["FLUIDSTATE"] then aBarSetValue=button.aux[x]["FLUIDSTATE"] end
                ufaBarActive=true
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], aBarSetValue)
            elseif aBarGetValue<button.aux[x]["FLUIDSTATE"] then
                aBarSetValue=aBarGetValue+upVal
                if aBarSetValue>button.aux[x]["FLUIDSTATE"] then aBarSetValue=button.aux[x]["FLUIDSTATE"] end
                ufaBarActive=true
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], aBarSetValue)
            else
                button.aux[x]["FLUIDSTATE"]=-1
            end
        end
    end
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsAlphaValue")
    return ufaBarActive
end

local function HealBot_Aux_UpdateFluidBars(upVal)
    HealBot_Aux_luVars["AuxFluidBarInUse"]=false
    for id,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if not HealBot_Aux_UpdateFluidBarsValue(xButton, upVal) then
            HealBot_AuxFluid_Buttons[id]=nil
        else
            HealBot_Aux_luVars["AuxFluidBarInUse"]=true
        end
    end
end

function HealBot_Aux_UpdateTimedBars(TimeNow)
    HealBot_Aux_luVars["AuxCastBarInUse"]=false
    for id,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if not HealBot_Aux_UpdateTimedBarsValue(xButton, TimeNow) then
            HealBot_AuxTimed_Buttons[id]=nil
        else
            HealBot_Aux_luVars["AuxCastBarInUse"]=true
        end
    end
end

local function HealBot_Aux_UpdateFluidBarsAlpha(upVal)
    HealBot_Aux_luVars["AuxFluidBarAlphaInUse"]=false
    for id,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        if not HealBot_Aux_UpdateFluidBarsAlphaValue(xButton, upVal) then
            HealBot_AuxFluid_ButtonsAlpha[id]=nil
        else
            HealBot_Aux_luVars["AuxFluidBarAlphaInUse"]=true
        end
    end
end

local ouFF, ouFA=0,0
function HealBot_Aux_FlashFluidInUse(elapsed)
    if HealBot_Aux_luVars["AuxFlashBarsInUse"] then
        HealBot_Aux_UpdateVariableBars(HealBot_Comm_round(elapsed+HealBot_Aux_luVars["OFREQ"],2))
    end
    if HealBot_Aux_luVars["FluidBarInUse"] or HealBot_Aux_luVars["AuxFluidBarInUse"] then
        ouFF=ceil(elapsed*HealBot_Aux_luVars["FLUIDFREQ"])
        if HealBot_Aux_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars(ouFF) end
        if HealBot_Aux_luVars["AuxFluidBarInUse"] then HealBot_Aux_UpdateFluidBars(ouFF) end
    end
    if HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] or HealBot_Aux_luVars["FluidBarAlphaInUse"] then
        ouFA=HealBot_Comm_round(elapsed+HealBot_Aux_luVars["FLUIDSTATEFREQ"],2)
        if HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] then HealBot_Aux_UpdateFluidBarsAlpha(ouFA) end
        if HealBot_Aux_luVars["FluidBarAlphaInUse"] then HealBot_Action_UpdateFluidBarsAlpha(ouFA) end
    end
end

function HealBot_Aux_CheckFlashFluidNotInUse()
    if not HealBot_Aux_luVars["AuxFlashBarsInUse"] and 
       not HealBot_Aux_luVars["FluidBarInUse"] and
       not HealBot_Aux_luVars["AuxFluidBarInUse"] and
       not HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] and 
       not HealBot_Aux_luVars["FluidBarAlphaInUse"] then
        HealBot_Aux_luVars["FluidFlashInUse"]=false
        return true
    else
        return false
    end
end

function HealBot_Aux_BarsUpdate(elapsed, TimeNow)
    if HealBot_Aux_luVars["FluidFlashInUse"] then HealBot_Aux_FlashFluidInUse(elapsed) end
    if HealBot_Aux_luVars["AuxCastBarInUse"] then HealBot_Aux_UpdateTimedBars(TimeNow) end
end

-- Power

local hbAuxPowerAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearPowerAssigned()
    for f=1,10 do
        hbAuxPowerAssigned[f]={};
    end
end

function HealBot_Aux_setPowerAssigned(frame, id)
    hbAuxPowerAssigned[frame][id]=true
end

function HealBot_Aux_setPowerBars(button)
    for id in pairs(hbAuxPowerAssigned[button.frame]) do
        if button.mana.max==0 then
            HealBot_Aux_setBar(button, id, 0, true)
        else
            if button.mana.change then HealBot_Action_setButtonManaBarCol(button) end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=button.mana.r
                button.aux[id]["G"]=button.mana.g
                button.aux[id]["B"]=button.mana.b
            end
            if button.mana.change then
                button.mana.change=false
                HealBot_Aux_UpdBar(button, true)
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
               Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.mana.r+0.2),(button.mana.g+0.2),(button.mana.b+0.2)
                end
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
                    HealBot_Aux_setBar(button, id, floor((button.mana.current/button.mana.max)*1000), true, HealBot_Text_shortHealTxt(button.mana.current, button.frame))
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                    HealBot_Aux_setBar(button, id, floor((button.mana.current/button.mana.max)*1000), true, HealBot_Text_shortHealTxt(button.mana.current-button.mana.max, button.frame))
                else
                    HealBot_Aux_setBar(button, id, floor((button.mana.current/button.mana.max)*1000), true, floor((button.mana.current/button.mana.max)*100).."%")
                end
            else
                HealBot_Aux_setBar(button, id, floor((button.mana.current/button.mana.max)*1000), true)
            end
        end
    end
    --HealBot_setCall("HealBot_Aux_setPowerBars")
end

-- Aggro and Threat

local hbAuxAggroAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxThreatAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearAggroAssigned()
    for f=1,9 do
        hbAuxAggroAssigned[f]={};
        hbAuxThreatAssigned[f]={};
    end
end

function HealBot_Aux_setAggroAssigned(aType, frame, id)
    if aType=="AGGRO" then
        hbAuxAggroAssigned[frame][id]=true
    else
        hbAuxThreatAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateThreatBar(button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=0.2
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.aura.debuff.r+0.2),(button.aura.debuff.g+0.2),(button.aura.debuff.b+0.2)
            end
            HealBot_Aux_setBar(button, id, button.aggro.threatpct*10, true, HealBot_Text_readNumber(button.aggro.threatvalue).." ("..button.aggro.threatpct.."%)")
        else
            HealBot_Aux_setBar(button, id, button.aggro.threatpct*10, true, false)
        end
    end
end

function HealBot_Aux_ClearThreatBar(button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAggroBar(button)
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    end
end

function HealBot_Aux_ClearAggroBar(button)
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Buff and Debuff

local hbAuxBuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxDebuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearAuraAssigned()
    for f=1,9 do
        hbAuxBuffAssigned[f]={};
        hbAuxDebuffAssigned[f]={};
    end
end

function HealBot_Aux_setAuraAssigned(aType, frame, id)
    if aType=="BUFF" then
        hbAuxBuffAssigned[frame][id]=true
    else
        hbAuxDebuffAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateAuraBuffBars(button)
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"]=button.aura.buff.r,button.aura.buff.g,button.aura.buff.b
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.aura.buff.r+0.2),(button.aura.buff.g+0.2),(button.aura.buff.b+0.2)
            end
            HealBot_Aux_setBar(button, id, 1000, false, button.aura.buff.name)
        else
            HealBot_Aux_setBar(button, id, 1000, false, false)
        end
    end
end

function HealBot_Aux_ClearAuraBuffBars(button)
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAuraDebuffBars(button)
    for id in pairs(hbAuxDebuffAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"]=button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.aura.debuff.r+0.2),(button.aura.debuff.g+0.2),(button.aura.debuff.b+0.2)
            end
            HealBot_Aux_setBar(button, id, 1000, false, button.aura.debuff.name)
        else
            HealBot_Aux_setBar(button, id, 1000, false, false)
        end
    end
end

function HealBot_Aux_ClearAuraDebuffBars(button)
    for id in pairs(hbAuxDebuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- HealIn and Absorbs (HoT in classic)

local hbAuxAbsorbAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxHealInAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearInHealsAssigned()
    for f=1,10 do
        hbAuxAbsorbAssigned[f]={};
        hbAuxHealInAssigned[f]={};
    end
end

function HealBot_Aux_setInHealsAssigned(aType, frame, id)
    if aType=="ABSORB" then
        hbAuxAbsorbAssigned[frame][id]=true
    else
        hbAuxHealInAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateAbsorbBar(button, value)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=button.health.absorbr
            button.aux[id]["G"]=button.health.absorbg
            button.aux[id]["B"]=button.health.absorbb
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.health.absorbr+0.2),(button.health.absorbg+0.2),(button.health.absorbb+0.2)
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                HealBot_Aux_setBar(button, id, value, true, floor((button.health.absorbs/button.health.max)*100).."%")
            else
                HealBot_Aux_setBar(button, id, value, true, HealBot_Text_shortHealTxt(button.health.absorbs, button.frame))
            end
        else
            HealBot_Aux_setBar(button, id, value, true)
        end
    end
end

function HealBot_Aux_ClearAbsorbBar(button)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateHealInBar(button, value)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=button.health.inhealr
            button.aux[id]["G"]=button.health.inhealg
            button.aux[id]["B"]=button.health.inhealb
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.health.inhealr+0.2),(button.health.inhealg+0.2),(button.health.inhealb+0.2)
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                HealBot_Aux_setBar(button, id, value, true, floor((button.health.incoming/button.health.max)*100).."%")
            else
                HealBot_Aux_setBar(button, id, value, true, HealBot_Text_shortHealTxt(button.health.incoming, button.frame))
            end
        else
            HealBot_Aux_setBar(button, id, value, true)
        end
    end
end

function HealBot_Aux_ClearHealInBar(button)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- OverHeal

local hbAuxOverHealAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearOverHealAssigned()
    for f=1,9 do
        hbAuxOverHealAssigned[f]={};
    end
end

function HealBot_Aux_setOverHealAssigned(frame, id)
    hbAuxOverHealAssigned[frame][id]=true
end

function HealBot_Aux_UpdateOverHealBar(button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=0.2
            button.aux[id]["B"]=0.2
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=1,1,1
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                HealBot_Aux_setBar(button, id, floor((button.health.overheal/button.health.incoming)*1000), true, floor((button.health.overheal/button.health.incoming)*100).."%")
            else
                HealBot_Aux_setBar(button, id, floor((button.health.overheal/button.health.incoming)*1000), true, HealBot_Text_shortHealTxt(button.health.overheal, button.frame))
            end
        else
            HealBot_Aux_setBar(button, id, floor((button.health.overheal/button.health.incoming)*1000), true)
        end
    end
end

function HealBot_Aux_ClearOverHealBar(button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Highlight

local hbAuxHightlightAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHightlightAssigned()
    for f=1,9 do
        hbAuxHightlightAssigned[f]={};
    end
end

function HealBot_Aux_setHightlightAssigned(frame, id)
    hbAuxHightlightAssigned[frame][id]=true
end

function HealBot_Aux_UpdateHighlightBar(button)
    for id in pairs(hbAuxHightlightAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=1
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    end
end

function HealBot_Aux_ClearHighlightBar(button)
    for id in pairs(hbAuxHightlightAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Target

local hbAuxTargetAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearTargetAssigned()
    HealBot_setLuVars("AuxTargetInUse", false)
    for f=1,9 do
        hbAuxTargetAssigned[f]={};
    end
end

function HealBot_Aux_setTargetAssigned(frame, id)
    hbAuxTargetAssigned[frame][id]=true
    HealBot_setLuVars("AuxTargetInUse", true)
end

function HealBot_Aux_UpdateTargetBar(button)
    for id in pairs(hbAuxTargetAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=1
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    end
end

function HealBot_Aux_ClearTargetBar(button)
    for id in pairs(hbAuxTargetAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Cast bar

local hbAuxCastBarAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearCastBarAssigned()
    HealBot_setLuVars("AuxCastBarAssigned", false)
    for f=1,9 do
        hbAuxCastBarAssigned[f]={};
    end
end

function HealBot_Aux_setCastBarAssigned(frame, id)
    hbAuxCastBarAssigned[frame][id]=true
    HealBot_setLuVars("AuxCastBarAssigned", true)
end

function HealBot_Aux_UpdateCastBar(button, text, startTime, endTime, CastIsChan)
    for id in pairs(hbAuxCastBarAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=0.8
            button.aux[id]["G"]=0.7
            button.aux[id]["B"]=0.1
        end
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] and
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<3 then
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"]=1
                button.auxtxt[id]["G"]=1
                button.auxtxt[id]["B"]=1
            end
            HealBot_Aux_setBar(button, id, startTime, false, text, endTime, CastIsChan)
        else
            HealBot_Aux_setBar(button, id, startTime, false, false, endTime, CastIsChan)
        end
    end
end

function HealBot_Aux_ClearCastBar(button)
    button.status.castend=-1
    for id in pairs(hbAuxCastBarAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end


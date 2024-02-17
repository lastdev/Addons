--[[ HealBot Continued ]]

local HealBot_DebugMsg={};
local HealBot_SpamCut={}
local HealBot_Vers={}
--local strfind=strfind
local scName, scStartTime, scEndTime="",0,0
local arrg = {}
local LSM = HealBot_Libs_LSM()
local LDB11 = HealBot_Libs_LDB11()
local LDBIcon = HealBot_Libs_LDBIcon()
local libCHC = HealBot_Libs_CHC()
local HealBot_UnitInVehicle={}
local HealBot_FastQueue={}
local HealBot_BuffQueue={}
local HealBot_DebuffQueue={}
local HealBot_BarQueue={}
local HealBot_RefreshQueue={}
local HealBot_SlowUpdateQueue={}
local HealBot_UpdateQueue={}
local HealBot_RecalcQueue={}
local HealBot_CDQueue={}
local HealBot_notVisible={}
local hbManaPlayers={}
local HealBot_customTempUserName={}
local HealBot_trackHiddenFrames={}
local HealBot_RefreshTypes={[0]=true,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local HealBot_ResSpells={}
local HealBot_MobGUID={}
local HealBot_MobNames={}
local xUnit="x"
local xGUID="x"
local xButton={}
local pButton={}
local hbPrevGUIDs={}
local HealBot_ItemsInBags={}
local HealBot_AuxAssigns={}
local HealBot_ClearGUIDQueue={}
HealBot_AuxAssigns["CastBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["OORBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["InRangeBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["RecentHeals"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthDrop"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayRecentHeals"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayHealthDrop"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayTarget"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayOOR"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayRecentHeals"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayHealthDrop"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayTarget"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayOOR"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

local HealBot_luVars={}
HealBot_luVars["FPS"]={[0]=60,
                       [1]={[1]=60,[2]=60,[3]=60,[0]=60},
                       [2]={[1]=60,[2]=60,[3]=60,[0]=60},
                       [3]={[1]=60,[2]=60,[3]=60,[0]=60},}
HealBot_luVars["qaFRNext"]=HealBot_TimeNow+5
HealBot_luVars["IsSolo"]=true
HealBot_luVars["IsRaid"]=false
HealBot_luVars["MaskAuraReCheck"]=false
HealBot_luVars["slowSwitch"]=0
HealBot_luVars["fastSwitch"]=0
HealBot_luVars["iconSwitch"]=0
HealBot_luVars["ResetFlag"]=false
HealBot_luVars["MovingFrame"]=0
HealBot_luVars["TargetNeedReset"]=true
HealBot_luVars["FocusNeedReset"]=true
HealBot_luVars["TankUnit"]="x"
HealBot_luVars["healthFactor"]=1
HealBot_luVars["NextTipUpdate"]=HealBot_TimeNow
HealBot_luVars["TipUpdateFreq"]=1
HealBot_luVars["EnableErrorSpeech"]=false
HealBot_luVars["EnableErrorText"]=false
HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+1
HealBot_luVars["UpdateEnemyFrame"]=true
HealBot_luVars["NoSpamOOM"]=0
HealBot_luVars["AuraEventRegistered"]=false 
HealBot_luVars["TestBarsOn"]=false
HealBot_luVars["RaidTargetUpdate"]=false
HealBot_luVars["showReloadMsg"]=true
HealBot_luVars["overhealUnit"]="-nil-"
HealBot_luVars["overhealCastID"]="-nil-"
HealBot_luVars["ChatMSG"]=""
HealBot_luVars["ChatNOTIFY"]=1
HealBot_luVars["pluginThreat"]=false
HealBot_luVars["pluginTimeToDie"]=false
HealBot_luVars["mapAreaID"]=0
HealBot_luVars["slowUpdateID"]=1
HealBot_luVars["UpdateMaxUnits"]=8
HealBot_luVars["UpdateNumUnits"]=4
HealBot_luVars["NumUnitsInQueue"]=0
HealBot_luVars["RecalcDelay"]=0.2
HealBot_luVars["UpdateID"]=1
HealBot_luVars["UpdateAllAura"]=0
HealBot_luVars["CheckAuraFlags"]=true
HealBot_luVars["GetVersions"]=false
HealBot_luVars["CheckFramesOnCombat"]=true
HealBot_luVars["UpdateSlowNext"]=HealBot_TimeNow+1
HealBot_luVars["cpuAdj"]=0
HealBot_luVars["rangeCheckAdj"]=2
HealBot_luVars["rangeCheckAdjEnabled"]=1
HealBot_luVars["HealthDropPct"]=999
HealBot_luVars["HealthDropCancelPct"]=100
HealBot_luVars["InInstance"]=false
HealBot_luVars["DoSendGuildVersion"]=true
HealBot_luVars["mapName"]=""
HealBot_luVars["DropCombat"]=0
HealBot_luVars["NumPrivateUnits"]=0
HealBot_luVars["NumPetUnits"]=0
HealBot_luVars["CurrentSpec"]=1
HealBot_luVars["inspectGUID"]=""
HealBot_luVars["pluginClearDown"]=0
HealBot_luVars["TalentQueryEnd"]=0
HealBot_luVars["ProcessRefreshTime"]=0
HealBot_luVars["UpdateUnitRecall"]=false

local HealBot_Calls={}
HealBot_luVars["MaxCount"]=0
HealBot_luVars["CurMem"]=0
function HealBot_setCall(Caller, start)
    if not HealBot_Calls[Caller] then 
        HealBot_Calls[Caller]=0
    end
    HealBot_Calls[Caller]=HealBot_Calls[Caller]+1
    if HealBot_luVars["MaxCount"]<HealBot_Calls[Caller] then
        HealBot_luVars["MaxCount"]=HealBot_Calls[Caller]
        HealBot_luVars["MaxCountName"]=Caller
    end
end

function HealBot_reportCalls()
    if HealBot_luVars["MaxCountName"] then HealBot_AddDebug("High Count:"..HealBot_luVars["MaxCountName"].."="..HealBot_luVars["MaxCount"]) end
end

function HealBot_retCalls()
    return HealBot_Calls
end

local hbSpecialInGeneralFrame={[2]=8, [1]=7, [3]=9, [4]=10}
function HealBot_nextRecalcParty(typeRequired)
    if not HealBot_RecalcQueue[typeRequired] then
        if hbSpecialInGeneralFrame[typeRequired] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbSpecialInGeneralFrame[typeRequired]]["FRAME"]<6 then
            if not HealBot_luVars["UILOCK"] and HealBot_Action_FrameIsVisible(hbSpecialInGeneralFrame[typeRequired]-1) then 
                HealBot_Action_HidePanel(hbSpecialInGeneralFrame[typeRequired]-1) 
            end
            typeRequired=6
        end
        if typeRequired==2 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] then
            HealBot_nextRecalcDelay(6,HealBot_luVars["RecalcDelay"])
        end
        
        
        HealBot_RefreshTypes[typeRequired]=true
        HealBot_Timer_FramesRefresh()
    end
      --HealBot_setCall("HealBot_nextRecalcParty"..typeRequired)
end

function HealBot_nextRecalcEndDelay(typeRequired)
    if HealBot_RecalcQueue[typeRequired] then
        HealBot_RecalcQueue[typeRequired]=false
        HealBot_nextRecalcParty(typeRequired)
    end
end

function HealBot_nextRecalcDelay(typeRequired,delay)
    if not HealBot_RecalcQueue[typeRequired] then
        HealBot_RecalcQueue[typeRequired]=true
        C_Timer.After(delay, function() HealBot_nextRecalcEndDelay(typeRequired) end)
    end
end

function HealBot_setLuVars(vName, vValue)
    HealBot_luVars[vName]=vValue
	--HealBot_setCall("HealBot_setLuVars - "..vName)
end

function HealBot_retLuVars(vName)
      --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_luVars[vName]
end

function HealBot_setAuxAssigns(vName, frame, vValue)
    HealBot_AuxAssigns[vName][frame]=vValue
end

function HealBot_ClearPlayerButtonCache()
    for x,_ in pairs(HealBot_UpdateQueue) do
        HealBot_UpdateQueue[x]=nil
    end
    for x,_ in pairs(HealBot_SlowUpdateQueue) do
        HealBot_SlowUpdateQueue[x]=nil
    end
end

function HealBot_setNotVisible(unit,group)
    HealBot_notVisible[unit]=group
      --HealBot_setCall("HealBot_setNotVisible")
end

function HealBot_SetResetFlag(mode)
    HealBot_Timers_Set("OOC","SaveSpellsProfile")
    HealBot_Timers_Set("OOC","SaveActionIconsProfile")
    HealBot_Timers_TurboOn(3)
    if mode=="HARD" then
        HealBot_Timers_Set("RESET","Reload",0.25)
    elseif mode=="SOFT" and not HealBot_luVars["TestBarsOn"] then
        if HealBot_Config.DisabledNow==1 then
            HealBot_Options_DisableHealBotOpt:SetChecked(false)
            HealBot_Options_DisableHealBot(false)
        end
        HealBot_Timers_Set("RESET","Full",0.25)
    elseif mode=="FRAMES" then
        HealBot_Timers_Set("RESET","Frames",0.25)
    else
        HealBot_Timers_Set("RESET","Quick",0.25)
    end
      --HealBot_setCall("HealBot_SetResetFlag")
end

function HealBot_SetToolTip(tip)
    if not tip:IsOwned(HealBot) then
        tip:SetOwner(HealBot, 'ANCHOR_NONE')
    end
end

local uzText=""
function HealBot_UnitZone(button)
    if button.player or UnitIsVisible(button.unit) then
        uzText=GetRealZoneText();
    elseif IsInRaid() and button.isplayer and UnitInRaid(button.unit) then
        local raidID=UnitInRaid(button.unit)
        _, _, _, _, _, _, uzText, _, _ = GetRaidRosterInfo(raidID);
    else
        HealBot_ScanTooltip:SetUnit(button.unit)
        uzText = HealBot_ScanTooltipTextLeft3:GetText()
        if uzText == "PvP" then
            uzText = HealBot_ScanTooltipTextLeft4:GetText()
        end
    end
    return uzText
end

function HealBot_AddChat(HBmsg)
    DEFAULT_CHAT_FRAME:AddMessage(HEALBOT_CHAT_ADDONID..HBmsg, 0.7, 0.7, 1.0);
      --HealBot_setCall("HealBot_AddChat")
end

function HealBot_AddDebug(HBmsg, cat, incTime)
    if HealBot_Globals.DebugOut and HBmsg and (HealBot_SpamCut[HBmsg] or 0)<HealBot_TimeNow then
        HealBot_SpamCut[HBmsg]=HealBot_TimeNow+1
        if cat and HBmsg then
            HealBot_Debug_Add(cat, HBmsg, incTime)
        else
            HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
            table.insert(HealBot_DebugMsg,HBmsg)
        end
    end
      --HealBot_setCall("HealBot_AddDebug")
end

function HealBot_TogglePanel(HBpanel, sound)
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HBpanel:Hide();
        if sound then
            PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
        end
        HealBot_Options_Close()
    else
        local fTop=HealBot_Comm_round(((HBpanel:GetTop()/GetScreenHeight())*100),2)
        local fLeft=HealBot_Comm_round(((HBpanel:GetLeft()/GetScreenWidth())*100),2)
        local fBottom=HealBot_Comm_round(((HBpanel:GetBottom()/GetScreenHeight())*100),2)
        local fRight=HealBot_Comm_round(((HBpanel:GetRight()/GetScreenWidth())*100),2)
        if fLeft<0 or fTop>100 or fBottom<0 or fRight>100 then 
            HBpanel:ClearAllPoints(); 
        end
        if fLeft<0 then 
            HBpanel:SetPoint("LEFT","UIParent","LEFT",0,0);
        elseif fTop>100 then 
            HBpanel:SetPoint("TOP","UIParent","TOP",0,0);
        elseif fBottom<0 then 
            HBpanel:SetPoint("BOTTOM","UIParent","BOTTOM",0,0);
        elseif fRight>100 then 
            HBpanel:SetPoint("RIGHT","UIParent","RIGHT",0,0); 
        end
        HBpanel:Show();
        if sound then
            PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
        end
       -- HBpanel:ClearAllPoints();
       -- HBpanel:SetPoint("CENTER","UIParent","CENTER",0,0);
    end
      --HealBot_setCall("HealBot_TogglePanel")
end


function HealBot_StartMoving(HBframe, hbCurFrame)
    if not HBframe.isMoving then
        HBframe:StartMoving();
        HBframe.isMoving = true;
        if hbCurFrame and Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] and hbCurFrame>1 then HealBot_luVars["MovingFrame"]=hbCurFrame end
    end
      --HealBot_setCall("HealBot_StartMoving")
end

function HealBot_StopMoving(HBframe,hbCurFrame)
    if ( HBframe.isMoving ) then
        HBframe:StopMovingOrSizing();
        HBframe.isMoving = false;
        if HealBot_luVars["MovingFrame"]>1 then 
            HealBot_luVars["MovingFrame"]=0
            HealBot_Action_StickyFrameCanStickTo(HBframe.id,0,0,0)
        end
    end
    if hbCurFrame then
        HealBot_Action_StickyFrameClearStuck(hbCurFrame)
        HealBot_Action_setPoint(hbCurFrame, true)
    end
      --HealBot_setCall("HealBot_StopMoving")
end

function HealBot_CheckFrame(hbCurFrame, HBframe)
    if HealBot_Config.DisabledNow==1 then return end
    local wPct=HealBot_Comm_round(((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["WIDTH"]/GetScreenWidth())*100),2)
    local hPct=HealBot_Comm_round(((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]/GetScreenHeight())*100),2)
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]+wPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100-wPct
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<hPct then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=hPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]+wPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100-wPct
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]+hPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100-hPct
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<wPct then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=wPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<hPct then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=hPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<wPct then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=wPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]+hPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100-hPct
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<hPct then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=hPct
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"])>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]+wPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100-wPct
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01 
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<wPct then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=wPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01 
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]+hPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100-hPct
        end
    end
      --HealBot_setCall("HealBot_CheckFrame")
end

function HealBot_TalentQuery(button)
    local hbInspect=false
    local s=" "
    if HealBot_Panel_RaidUnitGUID(button.guid) then 
        s=HealBot_Action_getGuidData(button.guid, "TMPSPEC")
    end
    if s~=" " then
        if button.spec~=s then
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers",1.25)
        else
            button.specupdate=0
        end
        button.spec=s
    elseif button.isplayer and HealBot_Panel_AllUnitGUID(button.guid) and UnitExists(button.unit) then
        if button.status.isdead or not UnitIsConnected(button.unit) then
            HealBot_SpecUpdate(button, HealBot_TimeNow+5)
        elseif HEALBOT_GAME_VERSION>5 then
            if UnitIsVisible(button.unit) then 
                hbInspect=true 
            else
                HealBot_SpecUpdate(button, HealBot_TimeNow+3)
            end
        elseif HEALBOT_GAME_VERSION>2 and not HealBot_Globals.DenyTalentQuery then
            if UnitInRange(button.unit) then
                local g,p,ip,t,tp,tpc="",false,false,false,false,false
                if _G["PaperDollFrame"] then g=_G["PaperDollFrame"]; p=g:IsVisible() end
                if _G["InspectPaperDollFrame"] then g=_G["InspectPaperDollFrame"]; ip=g:IsVisible() end
                if _G["TalentFrame"] then g=_G["TalentFrame"]; t=g:IsVisible() end
                if _G["InspectTalentFrame"] then g=_G["InspectTalentFrame"]; tp=g:IsVisible() end
                if _G["InspectTalentFrameScrollChildFrame"] then g=_G["InspectTalentFrameScrollChildFrame"]; tpc=g:IsVisible() end
                if not p and not ip and not t and not tp and not tpc then 
                    hbInspect=true 
                else
                    HealBot_SpecUpdate(button, HealBot_TimeNow+5)
                end
            elseif UnitIsVisible(button.unit) then 
                HealBot_SpecUpdate(button, HealBot_TimeNow+1)
            else
                HealBot_SpecUpdate(button, HealBot_TimeNow+3)
            end
        else
            button.specupdate=0
        end
    else
        button.specupdate=0
    end
    if hbInspect and CanInspect(button.unit) then
        HealBot_luVars["inspectGUID"]=button.guid
        HealBot_luVars["TalentQueryEnd"]=HealBot_TimeNow+3
        NotifyInspect(button.unit); 
        button.specupdate=0
    end
      --HealBot_setCall("HealBot_TalentQuery")
end

function HealBot_Reset_AutoUpdateSpellIDs()
    HealBot_Aura_ClearCustomDebuffsDone()
    HealBot_AddChat("Automatic Spell ID's Turned On")
end

local hbInPhase, hbPhaseShift=true,""
function HealBot_UnitInPhase(button)
    if HEALBOT_GAME_VERSION<9 then 
        if not HealBot_Data["UILOCK"] and HealBot_Aura_CurrentBuff(button.guid, hbPhaseShift) then
            hbInPhase=true
        else
            hbInPhase=UnitInPhase(button.unit)
        end
    elseif (UnitPhaseReason(button.unit) or 2)~=2 then
        hbInPhase=false
    else
        hbInPhase=true
    end
    return hbInPhase
end

function HealBot_ToggleHealBot()
    if HealBot_Config.DisabledNow==0 then
        HealBot_Options_DisableHealBotOpt:SetChecked(true)
        HealBot_Options_DisableHealBot(true)
    else
        HealBot_Options_DisableHealBotOpt:SetChecked(false)
        HealBot_Options_DisableHealBot(false)
    end
end

function HealBot_SlashCmd(cmd)
    if not cmd then cmd="" end
    local HBcmd, x, y, z = string.split(" ", cmd)
    if type(HBcmd)=="string" then
        HBcmd=string.lower(HBcmd) 
        if (HBcmd=="se1") then
            SetCVar("Sound_EnableErrorSpeech", "0");
        elseif (HBcmd=="se2") then
            HealBot_luVars["EnableErrorSpeech"]=true
        elseif (HBcmd=="se3") then
            UIErrorsFrame:Hide()
        elseif (HBcmd=="se4") then
            HealBot_luVars["EnableErrorText"]=true
        elseif (HBcmd=="" or HBcmd=="o" or HBcmd=="options" or HBcmd=="opt" or HBcmd=="config" or HBcmd=="cfg") then
            HealBot_Options_ShowHide()
        elseif (HBcmd=="d" or HBcmd=="defaults") then
            HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults, true);
        elseif (HBcmd=="ui") then
            HealBot_AddChat(HEALBOT_CHAT_HARDRELOAD)
            HealBot_SetResetFlag("HARD")
        elseif (HBcmd=="ri" or (HBcmd=="reset" and x and string.lower(x)=="healbot")) then
            HealBot_AddChat(HEALBOT_CHAT_SOFTRELOAD)
            HealBot_SetResetFlag("SOFT")
        elseif (HBcmd=="rc" or (HBcmd=="reset" and x and string.lower(x)=="customdebuffs")) then
            HealBot_Timers_Set("RESET","CustomDebuffs")
        elseif (HBcmd=="rs" or (HBcmd=="reset" and x and string.lower(x)=="skin")) then
            HealBot_Timers_Set("RESET","Skins")
        elseif (HBcmd=="show") then
            HealBot_SetResetFlag("FRAMES")
        elseif (HBcmd=="cb") then
            HealBot_Panel_ClearBlackList()
        elseif (HBcmd=="cspells") then
            HealBot_Copy_SpellCombos()
        elseif (HBcmd=="rspells") then
            HealBot_Reset_Spells()
        elseif (HBcmd=="rcures") then
            HealBot_Reset_Cures()
        elseif (HBcmd=="rbuffs") then
            HealBot_Reset_Buffs()
        elseif (HBcmd=="ricons") then
            HealBot_Reset_Icons()
        elseif (HBcmd=="tma") then
            HealBot_Options_ToggleMainAssist()
        elseif (HBcmd=="cs") then
            HealBot_Update_Skins()
            HealBot_AddChat(HEALBOT_SKIN_CHECK_DONE)
        elseif (HBcmd=="disable") then
            HealBot_Options_DisableHealBotOpt:SetChecked(true)
            HealBot_Options_DisableHealBot(true)
        elseif (HBcmd=="enable") then
            HealBot_Options_DisableHealBotOpt:SetChecked(false)
            HealBot_Options_DisableHealBot(false)
        elseif (HBcmd=="eac" and x) then
            if x=="buff" then
                HealBot_Globals.IgnoreCustomBuff={}
                HealBot_Options_BuffIconUpdate()
                HealBot_AddChat(HEALBOT_ENABLE_CUSTOM_BUFFS)
            elseif x=="debuff" then
                HealBot_Globals.IgnoreCustomDebuff={}
                HealBot_Options_DebuffIconUpdate()
                HealBot_AddChat(HEALBOT_ENABLE_CUSTOM_DEBUFFS)
            end
        elseif (HBcmd=="tnr") and HEALBOT_GAME_VERSION<4 then
            if HealBot_Globals.NoRanks then
                HealBot_Globals.NoRanks=false
                HealBot_AddChat("Ranks will be shown")
                HealBot_Options_ReloadUI()
            else
                HealBot_Globals.NoRanks=true
                HealBot_AddChat("Ranks will not be shown")
                HealBot_AddChat("WARNING: This is not recommanded")
                HealBot_Options_ReloadUI()
            end
        elseif (HBcmd=="t") then
            HealBot_ToggleHealBot()
        elseif (HBcmd=="help" or HBcmd=="h") then
            HealBot_luVars["HelpCnt1"]=0
            HealBot_luVars["Help"]=true
        elseif (HBcmd=="hs") then
            HealBot_luVars["HelpCnt2"]=0
            HealBot_luVars["Help"]=true
        elseif (HBcmd=="iht" and x) then
            if HEALBOT_GAME_VERSION<4 then
                if (tonumber(x)>0) and (tonumber(x)<22) then
                    HealBot_Globals.ClassicHoTTime=tonumber(x)+0.5
                    HealBot_AddChat("HoT Time set to "..x.."s")
                else
                    HealBot_AddChat("Invalid Value for HoT Time. valid range from 1 to 21")
                end
            end
        elseif (HBcmd=="skin" and x) then
            if y then x=x.." "..y end
            if z then x=x.." "..z end
            HealBot_Options_Set_Current_Skin(x, nil, nil, true)
        elseif (HBcmd=="use10") then
            if HealBot_Config.MacroUse10 then
                HealBot_Config.MacroUse10=false
                HealBot_AddChat(HEALBOT_CHAT_USE10OFF)
            else
                HealBot_Config.MacroUse10=true
                HealBot_AddChat(HEALBOT_CHAT_USE10ON)
            end
            HealBot_Timers_Set("INIT","PrepSetAllAttribs",0.1)
        elseif (HBcmd=="suppress" and x) then
            x=string.lower(x)
            HealBot_ToggleSuppressSetting(x)
        elseif (HBcmd=="atd" and x) then
            if (tonumber(x)>3) and (tonumber(x)<122) then
                HealBot_Config_Cures.ShowTimeMaxDuration=tonumber(x)
                HealBot_Lang_Options_enALL()
                HealBot_AddChat("Auto Timed Debuff Duration set to "..x.."s")
            else
                HealBot_AddChat("Invalid Value for Auto Timed Debuff Duration. valid range from 4 to 121")
            end
        elseif (HBcmd=="atb" and x) then
            if (tonumber(x)>3) and (tonumber(x)<122) then
                HealBot_Config_Buffs.AutoBuffExpireTime=tonumber(x)
                HealBot_Lang_Options_enALL()
                HealBot_AddChat("Auto Timed Buff Duration set to "..x.."s")
            else
                HealBot_AddChat("Invalid Value for Auto Timed Buff Duration. valid range from 4 to 121")
            end
        elseif (HBcmd=="test") then
            HealBot_TestBars()
        elseif (HBcmd=="tr" and x) then
            HealBot_Panel_SethbTopRole(x)
        elseif (HBcmd=="tpr") then 
            if HEALBOT_GAME_VERSION<4 then
                if HealBot_Globals.AllowPlayerRoles then
                    HealBot_Globals.AllowPlayerRoles=false
                    HealBot_AddChat(HEALBOT_CHAT_PLAYERROLESOFF)
                else
                    HealBot_Globals.AllowPlayerRoles=true
                    HealBot_AddChat(HEALBOT_CHAT_PLAYERROLESON)
                end
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcAll")
            end
        elseif (HBcmd=="ttq") then 
            if HEALBOT_GAME_VERSION==3 then
                if HealBot_Globals.DenyTalentQuery then
                    HealBot_Globals.DenyTalentQuery=nil
                    HealBot_AddChat(HEALBOT_ALLOWTALENTQUERYON)
                else
                    HealBot_Globals.DenyTalentQuery=true
                    HealBot_AddChat(HEALBOT_ALLOWTALENTQUERYOFF)
                end
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcAll")
            end
        elseif (HBcmd=="spt") then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] then
                Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=false
                HealBot_AddChat(HEALBOT_CHAT_SELFPETSOFF)
            else
                Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=true
                HealBot_AddChat(HEALBOT_CHAT_SELFPETSON)
            end
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
        elseif (HBcmd=="bt") then
            if HealBot_Config_Buffs.BuffWatch then
                HealBot_Config_Buffs.BuffWatch=false
            else
                HealBot_Config_Buffs.BuffWatch=true
            end
            HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
            HealBot_Options_MonitorBuffs_Toggle()
        elseif (HBcmd=="dt") then
            if HealBot_Config_Cures.DebuffWatch then
                HealBot_Config_Cures.DebuffWatch=false
            else
                HealBot_Config_Cures.DebuffWatch=true
            end
            HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config_Cures.DebuffWatch)
            HealBot_Options_MonitorDebuffs_Toggle()
        elseif (HBcmd=="rtb") then
            if HealBot_Globals.TargetBarRestricted==1 then
                HealBot_Globals.TargetBarRestricted=0
                HealBot_AddChat(HEALBOT_RESTRICTTARGETBAR_OFF)
            else
                HealBot_Globals.TargetBarRestricted=1
                HealBot_AddChat(HEALBOT_RESTRICTTARGETBAR_ON)
            end
        elseif (HBcmd=="dm") then
            HealBot_MountsPets_DislikeMount("Dislike")
        elseif (HBcmd=="em") then
            HealBot_MountsPets_DislikeMount("Exclude")
        elseif (HBcmd=="fm") then
            if HEALBOT_GAME_VERSION==3 then
                HealBot_MountsPets_FavClassicMount()
            end
        elseif (HBcmd=="cpu") then
            if HealBot_luVars["CPUProfilerOn"] then
                HealBot_AddChat("WARNING: cpu profiling is ON, to disable type:")
                HealBot_AddChat("WARNING: /console scriptProfile 0")
                HealBot_AddChat("WARNING: /reload")
            end
            HealBot_AddChat("Out of combat FPS="..HealBot_luVars["FPS"][0].." CPU Level="..HealBot_Globals.CPUUsage)
        elseif (HBcmd=="aggro" and x and y) then
            if tonumber(x) and tonumber(x)==2 then
                if tonumber(y) and tonumber(y)>24 and tonumber(x)<96 then
                    HealBot_Globals.aggro2pct=tonumber(y)
                    HealBot_AddChat(HEALBOT_AGGRO2_SET_MSG..y)
                else
                    HealBot_AddChat(HEALBOT_AGGRO2_ERROR_MSG)
                end
            elseif tonumber(x) and tonumber(x)==3 then
                if tonumber(y) and tonumber(y)>74 and tonumber(y)<101 then
                    HealBot_Globals.aggro3pct=tonumber(y)
                    HealBot_AddChat(HEALBOT_AGGRO3_SET_MSG..y)
                else
                    HealBot_AddChat(HEALBOT_AGGRO3_ERROR_MSG)
                end
            else
                HealBot_AddChat(HEALBOT_AGGRO_ERROR_MSG)
            end
        elseif (HBcmd=="lang" and x) then
            HealBot_Options_Lang(x, true)
        elseif (HBcmd=="cw") then  -- Clear Warnings
            HealBot_Globals.OneTimeMsg={}
        elseif (HBcmd=="rau") then
            HealBot_Reset_AutoUpdateSpellIDs()
        elseif (HBcmd=="tdb01") then
            if HealBot_Globals.Debug01 then
                HealBot_Globals.Debug01=false
                HealBot_AddChat("Debug 01 turned OFF")
            else
                HealBot_Globals.Debug01=true
                HealBot_AddChat("Debug 01 turned ON")
            end
        elseif (HBcmd=="tpt" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivateTanks(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd=="tph" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivateHealers(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd=="tpd" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivateDamagers(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd=="tpl" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelHealTarget(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd=="debugshow") then
            HealBot_Debug_HideShow()
        elseif (HBcmd=="debug") then
            if HealBot_Globals.DebugOut then
                HealBot_Globals.DebugOut=false
                HealBot_AddChat("Debug OFF")
            else
                HealBot_Globals.DebugOut=true
                HealBot_AddChat("Debug ON")
            end
        elseif (HBcmd=="debugtip") then
            if HealBot_Data["TIPUSE"] then
                HealBot_ToolTip_ToggleDebug()
            end
        elseif (HBcmd=="resetcalls") then
            HealBot_AddChat("Calls Reset")
            HealBot_Calls={}
        elseif (HBcmd=="ma" and x) then
            x=tonumber(x)
            if type(x)=="number" then
                if x>0 and x<21 then
                    HealBot_AddChat("Aux MAX Absorbs set to MaxHealth / "..x)
                    HealBot_Globals.AbsorbDiv=x
                    HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                else
                    HealBot_AddChat("The MAX Absorbs divider must be between 1 and 20")
                end
            else
                HealBot_AddChat("The MAX Absorbs divider must be a number between 1 and 20")
            end
        elseif (HBcmd=="mi" and x) then
            x=tonumber(x)
            if type(x)=="number" then
                if x>0 and x<81 then
                    HealBot_AddChat("Aux MAX In Heals set to MaxHealth / "..x)
                    HealBot_Globals.InHealDiv=x
                    HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                else
                    HealBot_AddChat("The MAX In Heals divider must be between 1 and 80")
                end
            else
                HealBot_AddChat("The MAX In Heals divider must be a number between 1 and 80")
            end
        elseif (HBcmd=="mt" and x) then
            x=tonumber(x)
            if type(x)=="number" then
                if x>0 and x<81 then
                    HealBot_AddChat("Aux MAX Total Heal Absorbs set to MaxHealth / "..x)
                    HealBot_Globals.HealAbsorbsDiv=x
                    HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                else
                    HealBot_AddChat("The MAX Total Heal Absorbs divider must be between 1 and 80")
                end
            else
                HealBot_AddChat("The MAX Total Heal Absorbs divider must be a number between 1 and 80")
            end
        elseif (HBcmd=="trs") then
            _,xButton,pButton = HealBot_UnitID("player")
            if xButton then
                xButton.health.init=false
                xButton.health.current=1
                xButton.gref["Bar"]:SetValue(0)
                HealBot_OnEvent_UnitHealth(xButton)
            end
            if pButton then
                pButton.health.init=false
                pButton.health.current=1
                pButton.gref["Bar"]:SetValue(0)
                HealBot_OnEvent_UnitHealth(pButton)
            end
        elseif (HBcmd=="zzz") then
            _,xButton,pButton = HealBot_UnitID("player")
            local button=xButton or pButton
            HealBot_AddDebug("#: UpdateMaxUnits="..HealBot_luVars["UpdateMaxUnits"].." UpdateNumUnits="..HealBot_luVars["UpdateNumUnits"].." nProcs="..HealBot_Timers_retLuVars("nProcs"))
            --HealBot_Action_EnableButtonGlowType(button, 1,0,0, "PLUGIN", "AW1", 6)
           -- HealBot_Action_setAdaptive()
            --HealBot_Aura_Counts(button)
            HealBot_ActionIcons_CursorIconOnMouseUp(nil, "RightButton")
        else
            if x then HBcmd=HBcmd.." "..x end
            if y then HBcmd=HBcmd.." "..y end
            if z then HBcmd=HBcmd.." "..z end
            HealBot_AddChat(HEALBOT_CHAT_UNKNOWNCMD..HBcmd)
            HealBot_luVars["HelpCnt1"]=0
            HealBot_luVars["Help"]=true
        end
    end
      --HealBot_setCall("HealBot_SlashCmd")
end

function HealBot_ToggleSuppressSetting(settingType)
    if settingType=="sound" then
        if HealBot_Globals.MacroSuppressSound then
            HealBot_Globals.MacroSuppressSound=false
            HealBot_AddChat(HEALBOT_CHAT_MACROSOUNDON)
        else
            HealBot_Globals.MacroSuppressSound=true
            HealBot_AddChat(HEALBOT_CHAT_MACROSOUNDOFF)
        end
        HealBot_Comms_MacroSuppressSound()
    elseif settingType=="error" then
        if HealBot_Globals.MacroSuppressError then
            HealBot_Globals.MacroSuppressError=false
            HealBot_AddChat(HEALBOT_CHAT_MACROERRORON)
        else
            HealBot_Globals.MacroSuppressError=true
            HealBot_AddChat(HEALBOT_CHAT_MACROERROROFF)
        end
        HealBot_Comms_MacroSuppressError()
    end
    HealBot_Timers_Set("INIT","PrepSetAllAttribs",0.1)
      --HealBot_setCall("HealBot_ToggleSuppressSetting")
end

function HealBot_TestBars()
    HealBot_Panel_ToggleTestBars()
    HealBot_Timers_Set("INIT","ResetSkinAllElements")
    HealBot_Timers_Set("SKINS","AllFramesChanged")
      --HealBot_setCall("HealBot_TestBars")
end

local hbManaWatch={}
local hbAuraWatchMana={}
local hbActionManaWatch={}
local hbManaExtra={}
function HealBot_ManaExtra(guid, state)
    if state then
        hbManaExtra[guid]=true
    elseif not hbManaWatch[guid] and not hbAuraWatchMana[guid] and not hbActionManaWatch[guid] then
        hbManaExtra[guid]=nil
    end
end

function HealBot_ManaWatch(guid, state)
    if state then
        hbManaWatch[guid]=true
    else
        hbManaWatch[guid]=nil
    end
    HealBot_ManaExtra(guid, state)
end

function HealBot_AuraWatchMana(guid, state)
    if state then
        hbAuraWatchMana[guid]=true
    else
        hbAuraWatchMana[guid]=nil
    end
    HealBot_ManaExtra(guid, state)
end

function HealBot_ActionWatchMana(guid, state)
    if state then
        hbActionManaWatch[guid]=true
    else
        hbActionManaWatch[guid]=nil
    end
    HealBot_ManaExtra(guid, state)
end

function HealBot_ManaWatchClear()
    hbManaWatch={}
end

function HealBot_AuraWatchManaClear()
    hbAuraWatchMana={}
end

local hbManaCurrent, hbManaMax, pLowManaDrinkNeed=0,0,false
function HealBot_UnitMana(button)
    button.mana.update=false
    if button.mana.change then HealBot_Action_setButtonManaBarCol(button) end
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hbManaCurrent=UnitPower(button.unit) or 0
        hbManaMax=UnitPowerMax(button.unit) or 0
        if button.mana.current~=hbManaCurrent or button.mana.max~=hbManaMax or button.mana.change then
            if not HealBot_Data["UILOCK"] and HEALBOT_GAME_VERSION==3 and button.isplayer and not button.player and (hbManaMax>(button.mana.max*1.1) or hbManaMax<(button.mana.max*0.9)) then
                HealBot_OnEvent_SpecChange(button)
            end
            button.mana.current=hbManaCurrent
            button.mana.max=hbManaMax
            if button.mana.max>0 then
                button.mana.pct=floor((button.mana.current/button.mana.max)*100)
                button.mana.pctc=button.mana.pct*10
            else
                button.mana.pct=0
                button.mana.pctc=0
            end
            if hbManaExtra[button.guid] then
                if hbManaWatch[button.guid] then
                    HealBot_Plugin_ManaWatch_UnitUpdate(button)
                end
                if hbAuraWatchMana[button.guid] then
                    HealBot_Plugin_AuraWatch_ManaUpdate(button)
                end
                if hbActionManaWatch[button.guid] then
                    HealBot_ActionIcons_UpdateMana(button.guid, button.mana.pct)
                end
            end
            HealBot_Aux_setPowerBars(button)
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        end
        HealBot_Action_setPowerIndicators(button)
    elseif button.mana.current>0 or button.mana.max>0 then
        button.mana.current=0
        button.mana.max=0
        HealBot_Aux_setPowerBars(button)
        HealBot_Action_setPowerIndicators(button)
    end
    button.mana.lowcheck=true
      --HealBot_setCall("HealBot_OnEvent_UnitMana")
end

function HealBot_OnEvent_UnitMana(button)
    if HealBot_Globals.EventQueues["POWER"] then
        button.mana.update=true
        if not HealBot_BarQueue[button.id] then
            HealBot_BarQueue[button.id]=true
            HealBot_InsertFastUnitQueue(button.id, "BAR")
        end
    else
        HealBot_UnitMana(button)
    end
end

function HealBot_OnEvent_UnitManaUpdate(button)
    button.mana.change=true
    button.mana.nextcheck=HealBot_TimeNow+5
    HealBot_OnEvent_UnitMana(button)
      --HealBot_setCall("HealBot_OnEvent_UnitManaUpdate")
end

function HealBot_UpdateAllRangeSpells()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllHotBars")
end

function HealBot_UpdateAllHotBarsButton(button)
    if HealBot_Action_retLuVars("HotBarsHealth")==0 then
        if button.hotbars.health then HealBot_Action_BarHotDisable(button, "HEALTH") end
    else
        HealBot_Action_UpdateHealthHotBar(button)
    end
    if button.aura.debuff.id>0 then HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true, 0) end
end

function HealBot_UpdateAllHotBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllHotBars")
end

function HealBot_UpdateAllAuxPowerBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllAuxPowerBars")
end

function HealBot_CheckAllAuxOverLays()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
      --HealBot_setCall("HealBot_CheckAllAuxOverLays")
end

function HealBot_ResetAllAuxText()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
      --HealBot_setCall("HealBot_ResetAllAuxText")
end

function HealBot_UpdateAllBackground()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllBackground")
end

function HealBot_UpdateAllAuxBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllAuxBars")
end

function HealBot_updAuxBuffBars(button)
    if button.aura.buff.name then
        HealBot_Aura_BuffWarnings(button, button.aura.buff.name, true)
    else
        HealBot_Aura_AuxClearAuraBuffBars(button)
    end
end

function HealBot_updAllAuxBuffBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxBuffBars")
end

function HealBot_updAllAuxOverHealsBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxOverHealsBars")
end

function HealBot_updAllAuxInHealsBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxInHealsBars")
end

function HealBot_updAllAuxAbsorbBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxAbsorbBars")
end

function HealBot_updAllAuxTotalHealAbsorbBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxAbsorbBars")
end

function HealBot_updAllThreat()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aggro.threatpct==0 then 
            xButton.aggro.threatpct=1
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aggro.threatpct==0 then 
            xButton.aggro.threatpct=1
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aggro.threatpct==0 then 
            xButton.aggro.threatpct=1
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aggro.threatpct==0 then 
            xButton.aggro.threatpct=1
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aggro.threatpct==0 then 
            xButton.aggro.threatpct=1
        end
    end
      --HealBot_setCall("HealBot_updAllAuxThreatBars")
end

function HealBot_updAllAuxThreatBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxThreatBars")
end

function HealBot_updAllStateIconAFK()
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_OnEvent_UnitFlagsChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_OnEvent_UnitFlagsChanged(xButton)
    end
      --HealBot_setCall("HealBot_updAllStateIconNotInCombat")
end

function HealBot_clearClassGuidData()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_setGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_setGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_setGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_setGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_setGuidData(xButton, "CLASSKNOWN", false)
    end
    HealBot_Action_ResetAllButtons(true)
    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcAll")
      --HealBot_setCall("HealBot_updAllStateIconNotInCombat")
end

function HealBot_updAllStateIconNotInCombat()
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
      --HealBot_setCall("HealBot_updAllStateIconNotInCombat")
end

function HealBot_updAllStateIconHostile()
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_ClassificationChanged(xButton)
    end
      --HealBot_setCall("HealBot_updAllStateIconNotInCombat")
end

function HealBot_updAuxDebuffBars(button)
    if button.aura.debuff.id>0 then
        HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true, 0)
    else
        HealBot_Aura_AuxClearAuraDebuffBars(button)
    end
end

function HealBot_updAllAuxDebuffBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxDebuffBars")
end

function HealBot_updAllAuxRangeBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_OORBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxRangeBars")
end

function HealBot_updAllAuxInRangeBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxInRangeBars")
end

function HealBot_UpdateAllUnitBars(playersOnly)
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.update=true
    end
    if not playersOnly then
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.status.update=true
        end
    end
      --HealBot_setCall("HealBot_UpdateAllUnitBars")
end

function HealBot_CheckAllPartyGUIDs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
      --HealBot_setCall("HealBot_CheckAllPartyGUIDs")
end

function HealBot_CheckAllPetGUIDs()
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
      --HealBot_setCall("HealBot_CheckAllPetGUIDs")
end

function HealBot_GetUnitGuild(button)
    if button.isplayer and GetGuildInfo(button.unit) then
        button.guild, button.guildrank, button.guildranki=GetGuildInfo(button.unit)
    else
        button.guild=false
    end
end

function HealBot_CheckUnitStatus(button)
    button.status.nextcheck=HealBot_TimeNow+3
    HealBot_SetUnitDisconnect(button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_Action_UpdateTheDeadButton(button)
        if button.health.current==0 then
            button.status.change=true
            button.status.update=true
        end
    end
      --HealBot_setCall("HealBot_CheckUnitStatus")
end

function HealBot_UpdateUnitClear(button, GUIDchange, unitExists)
    if not unitExists or button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
        HealBot_Aura_ClearBuff(button)
        HealBot_Aura_ClearDebuff(button)
        HealBot_Aura_RemoveIcons(button)
        button.adaptive.current=12
    else
        HealBot_UpdateUnitRange(button)
        button.aura.debuff.update=true
        button.aura.buff.update=true
        HealBot_FastUnitUpdateDebuff(button)
        HealBot_FastUnitUpdateBuff(button)
    end
    button.health.init=true
    button.mana.init=true
    HealBot_FastUnitUpdateRefresh(button)
    HealBot_Aux_clearAllBars(button)
    HealBot_Aggro_ClearUnitAggro(button)
    if HealBot_luVars["pluginAuraWatch"] then
        HealBot_Plugin_AuraWatch_CancelNoIndex(button, GUIDchange)
    end
	HealBot_ActionIcons_UnitDied(button.guid, button.unit)
    HealBot_Action_DisableButtonGlowType(button, "ALL")
    HealBot_Action_DisableBorderHazard(button)
    HealBot_Action_UpdateBackground(button)
    button.status.incombat=false
    button.status.hostile=false
    button.spec=" "
      --HealBot_setCall("HealBot_UpdateUnitClear")
end

local uuUnitClassEN="XXXX"
function HealBot_UpdateUnitNotExists(button, isSetHealButton)
    HealBot_Action_setState(button, HealBot_Unit_Status["RESERVED"])
    button.status.update=true
    button.status.change=true
    HealBot_UpdateUnitClear(button)
    HealBot_UnitHealth(button)
    HealBot_Text_setNameTag(button)
    HealBot_Text_UpdateNameButton(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]~=4 then button.text.healthupdate=true end
    HealBot_Text_UpdateText(button)
    HealBot_Action_UpdateAllIndicators(button)
    HealBot_Action_EmergBarCheck(button, true)
    button.status.classknown=false
    button.guid=button.unit
    if not isSetHealButton then
        if button.status.unittype==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcVehicle")
        elseif button.status.unittype==8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
        end
    end
    if button.status.dirarrowshown>0 then HealBot_Action_HideDirectionArrow(button) end
      --HealBot_setCall("HealBot_UpdateUnitNotExists - c="..button.status.current)
end

function HealBot_UpdateUnit(button)
    if button.status.classknown then 
        button.status.update=false
        button.status.postupdate=true
        HealBot_OnEvent_UnitManaUpdate(button)
        HealBot_Aux_UpdBar(button)
        HealBot_OnEvent_ClassificationChanged(button)
        HealBot_UnitAffectingCombat(button)
        HealBot_Check_UnitAura(button)
        HealBot_Action_ResetUnitButtonOpacity(button)
        HealBot_OnEvent_UnitHealth(button)
        HealBot_Action_AdaptiveOORUpdate(button)
        HealBot_Action_UpdateBackground(button)
        HealBot_Action_EmergBarCheck(button, true)
        button.level=UnitLevel(button.unit) or 1
        button.status.rangenextcheck=0
		if button.status.guidupdate then
			button.status.guidupdate=false
			button.status.guidchange=true
		end
    else
        button.guid=button.unit
    end
      --HealBot_setCall("HealBot_UpdateUnit")
end

function HealBot_UpdateUnitGUIDChange(button, notRecalc)
    if button.status.current==HealBot_Unit_Status["RESERVED"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
    HealBot_QueueClearGUID(button)
    button.guid=UnitGUID(button.unit) or button.unit
    HealBot_UnitClass(button, notRecalc)
    if button.status.classknown then
        HealBot_UpdateUnitClear(button, notRecalc, true)
        if notRecalc then 
            HealBot_Panel_updDataStore(button) 
        end
        button.status.update=true
        button.status.change=true
        button.status.guidupdate=true
        HealBot_SpecUpdate(button, HealBot_TimeNow)
    else
        HealBot_UpdateUnitClear(button, notRecalc)
    end
      --HealBot_setCall("HealBot_UpdateUnitGUIDChange")
end

function HealBot_CheckUpdateUnitGUIDChange(button)
    if button.guid~=UnitGUID(button.unit) then
        if button.unit=="target" then
            HealBot_TargetChanged()
        else
            HealBot_UpdateUnitGUIDChange(button, true)
        end
    else
        button.status.change=true
        button.status.update=true
    end
end

local guName=false
function HealBot_UnitClass(button)
    if HealBot_Action_getGuidData(button.guid, "CLASSKNOWN") then
        button.player=HealBot_Action_getGuidData(button.guid, "PLAYER")
        button.isplayer=HealBot_Action_getGuidData(button.guid, "ISPLAYER")
        button.text.classtrim=HealBot_Action_getGuidData(button.guid, "CLASSTRIM")
        button.text.r=HealBot_Action_getGuidData(button.guid, "CLASSR")
        button.text.g=HealBot_Action_getGuidData(button.guid, "CLASSG")
        button.text.b=HealBot_Action_getGuidData(button.guid, "CLASSB")
        button.name=HealBot_Action_getGuidData(button.guid, "NAME")
        button.status.classknown=true
    else
        button.name=false
        if UnitIsUnit(button.unit, "player") then
            button.player=true
            button.isplayer=true
            button.status.range=1
        else
            button.player=false
            if UnitIsPlayer(button.unit) then
                button.isplayer=true
            else
                button.isplayer=false
            end
        end
        _, uuUnitClassEN = UnitClass(button.unit);
        if uuUnitClassEN then
            button.status.classknown=true
            button.text.classtrim = strsub(uuUnitClassEN,1,4)
            button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit, button.text.classtrim)
            if HealBot_Panel_RaidPetUnitGUID(button.guid) then
                guName=HealBot_customTempUserName[button.guid] or UnitName(button.unit) or false
                if guName and guName~=HEALBOT_WORDS_UNKNOWN then
                    button.name=guName
                    HealBot_Action_setGuidData(button, "CLASSKNOWN", true)
                    HealBot_Action_setGuidData(button, "PLAYER", button.player)
                    HealBot_Action_setGuidData(button, "ISPLAYER", button.isplayer)
                    HealBot_Action_setGuidData(button, "CLASSTRIM", button.text.classtrim)
                    HealBot_Action_setGuidData(button, "CLASSR", button.text.r)
                    HealBot_Action_setGuidData(button, "CLASSG", button.text.g)
                    HealBot_Action_setGuidData(button, "CLASSB", button.text.b)
                    HealBot_Action_setGuidData(button, "NAME", guName)
                end
            end 
        elseif button.isplayer then
            button.status.classknown=false
        else
            button.status.classknown=true
            button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit)
        end
    end
    if button.health.hpct>890 then button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.text.r, button.text.g, button.text.b end
        --HealBot_setCall("HealBot_UnitClass")
end

function HealBot_UpdateUnitExists(button)
    if not button.status.classknown then 
        button.guid=button.unit
    else
        if button.status.current==HealBot_Unit_Status["RESERVED"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
        button.status.change=false
        button.status.postchange=true
        if not button.status.duplicate and button.status.unittype<7 then 
            button.status.plugin=true
        else
            button.status.plugin=false
        end
        HealBot_Text_setNameTag(button)
        HealBot_Text_UpdateNameButton(button)
        button.text.health=""
        HealBot_Text_setHealthText(button)
        HealBot_UpdateUnit(button)
    end
        --HealBot_setCall("HealBot_UpdateUnitExists")
end

function HealBot_RecalcParty(changeType)
    HealBot_RefreshTypes[changeType]=false
    if changeType==5 and not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcEnemy")
    else
        HealBot_Action_resetShouldHealSomeFrames()
        HealBot_ClearPlayerButtonCache()
        HealBot_Panel_PartyChanged(HealBot_Data["UILOCK"], changeType)
        if not HealBot_luVars["TestBarsOn"] then
            HealBot_RefreshLists()
        end
    end
    --HealBot_setCall("HealBot_RecalcParty")
end

function HealBot_CheckZone()
    HealBot_Timers_Set("LAST","ZoneUpdate")
    HealBot_Timers_Set("LAST","MountsPetsZone")
    --HealBot_setCall("HealBot_CheckZone")
end

function HealBot_CheckSubZone()
    if HealBot_luVars["mapAreaID"]==125 then
        HealBot_Timers_Set("LAST","MountsPetsZone")
    end
    --HealBot_setCall("HealBot_CheckZone")
end

function HealBot_Update_BuffsForSpecDD(ddId,bType)
    if bType=="Debuff" then
        for z=1,4 do
            if HealBot_Config_Cures.HealBotDebuffDropDown[ddId] and not HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId]=HealBot_Config_Cures.HealBotDebuffDropDown[ddId] 
            elseif not HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId]=4
            end
            if HealBot_Config_Cures.HealBotDebuffText[ddId] and not HealBot_Config_Cures.HealBotDebuffText[z..ddId] then 
                local sName = HealBot_Config_Cures.HealBotDebuffText[ddId]
                if HEALBOT_GAME_VERSION>3 then
                    if sName == HEALBOT_NATURES_CURE and z ~= 4 then 
                        sName = HEALBOT_REMOVE_CORRUPTION
                    elseif sName == HEALBOT_REMOVE_CORRUPTION and z == 4 then 
                        sName = HEALBOT_NATURES_CURE
                    elseif sName == HEALBOT_PURIFY_SPIRIT and z ~= 3 then 
                        sName = HEALBOT_CLEANSE_SPIRIT
                    elseif sName == HEALBOT_CLEANSE_SPIRIT and z == 3 then 
                        sName = HEALBOT_PURIFY_SPIRIT
                    end
                end
                HealBot_Config_Cures.HealBotDebuffText[z..ddId]=sName
            elseif not HealBot_Config_Cures.HealBotDebuffText[z..ddId] then 
                HealBot_Config_Cures.HealBotDebuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    else
        if HealBot_Config_Buffs.HealBotBuffText[ddId] and tonumber(HealBot_Config_Buffs.HealBotBuffText[ddId]) then
            HealBot_Config_Buffs.HealBotBuffText[ddId]=HEALBOT_WORDS_NONE
            HealBot_Config_Buffs.HealBotBuffDropDown[ddId]=4
        end
        for z=1,4 do
            if HealBot_Config_Buffs.HealBotBuffText[z..ddId] and tonumber(HealBot_Config_Buffs.HealBotBuffText[z..ddId]) then
                HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId]=nil
                HealBot_Config_Buffs.HealBotBuffText[z..ddId]=nil
            end
            if HealBot_Config_Buffs.HealBotBuffDropDown[ddId] and not HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId]=HealBot_Config_Buffs.HealBotBuffDropDown[ddId]
            elseif not HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId]=4
            end
            if HealBot_Config_Buffs.HealBotBuffText[ddId] and not HealBot_Config_Buffs.HealBotBuffText[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffText[z..ddId]=HealBot_Config_Buffs.HealBotBuffText[ddId]
            elseif not HealBot_Config_Buffs.HealBotBuffText[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    end
    --HealBot_setCall("HealBot_Update_BuffsForSpecDD")
end

function HealBot_Update_BuffsForSpec(buffType)
    if buffType then
        if buffType=="Debuff" then
            for x=1,4 do
                HealBot_Update_BuffsForSpecDD(x,"Debuff")
            end
        else
            for x=1,8 do
                HealBot_Update_BuffsForSpecDD(x,"Buff")
            end
        end
    else
        for x=1,4 do
            HealBot_Update_BuffsForSpecDD(x,"Debuff")
        end
        for x=1,8 do
            HealBot_Update_BuffsForSpecDD(x,"Buff")
        end
    end
    --HealBot_setCall("HealBot_Update_BuffsForSpec")
end

function HealBot_Update_SpellCombo(combo, maxButtons)
    local x=""
    local n=3
    if HEALBOT_GAME_VERSION<3 then
        n=1
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then 
        n=4 
    end
    if combo then
        for y=1,maxButtons do
            local button = HealBot_Options_ComboClass_Button(y)
            for z=1,n do
                x=z
                x=z..HealBot_Config.CurrentLoadout
                combo[button..x] = combo[button]
                combo["Shift"..button..x] = combo["Shift"..button]
                combo["Ctrl"..button..x] = combo["Ctrl"..button]
                combo["Alt"..button..x] = combo["Alt"..button]
                combo["Ctrl-Shift"..button..x] = combo["Ctrl-Shift"..button]
                combo["Alt-Shift"..button..x] = combo["Alt-Shift"..button]
                combo["Alt-Ctrl"..button..x] = combo["Alt-Ctrl"..button]
                combo["Alt-Ctrl-Shift"..button..x] = combo["Alt-Ctrl-Shift"..button]
            end
        end
    end
end

function HealBot_Update_SpellCombos()
    HealBot_Update_SpellCombo(HealBot_Config_Spells.EnabledKeyCombo, 20)
    HealBot_Update_SpellCombo(HealBot_Config_Spells.EnemyKeyCombo, 20)
    HealBot_Update_SpellCombo(HealBot_Config_Spells.EmergKeyCombo, 5)
      --HealBot_setCall("HealBot_Update_SpellCombos")
end

function HealBot_DoReset_Spells(pClassTrim)
    HealBot_Config_Spells.EnabledKeyCombo = {}
    HealBot_Config_Spells.EnemyKeyCombo = {}
    HealBot_Config_Spells.EnabledSpellTarget = {}
    HealBot_Config_Spells.EnemySpellTarget = {}
    HealBot_Config_Spells.EmergSpellTarget = {}
    HealBot_Config_Spells.EnabledSpellTrinket1 = {}
    HealBot_Config_Spells.EnemySpellTrinket1 = {}
    HealBot_Config_Spells.EmergSpellTrinket1 = {}
    HealBot_Config_Spells.EnabledSpellTrinket2 = {}
    HealBot_Config_Spells.EnemySpellTrinket2 = {}
    HealBot_Config_Spells.EmergSpellTrinket2 = {}
    HealBot_Config_Spells.EnabledAvoidBlueCursor = {}
    HealBot_Config_Spells.EnemyAvoidBlueCursor = {}
    HealBot_Config_Spells.EmergAvoidBlueCursor = {}
    local bandage=HealBot_GetBandageType() or ""
    local x=""
    if pClassTrim=="DRUI" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_REGROWTH))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_REMOVE_CORRUPTION))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEALING_TOUCH))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_NATURES_CURE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_REJUVENATION))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_NOURISH))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HBC_NOURISH))
    elseif pClassTrim=="MONK" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_SURGING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_REVIVAL))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_DETOX))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_RENEWING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_UPLIFT))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_LIFE_COCOON))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", GetSpellInfo(HEALBOT_ZEN_MEDITATION))
    elseif pClassTrim=="EVOK" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_LIVING_FLAME))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_REVERSION))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_REWIND))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_NATURALIZE))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_CAUTERIZING_FLAME))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_SPIRITBLOOM))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_ECHO))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_EMERALD_BLOSSOM))
    elseif pClassTrim=="PALA" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_FLASH_OF_LIGHT))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_LIGHT_OF_DAWN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_CLEANSE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_WORD_OF_GLORY))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_HOLY_RADIANCE))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HOLY_LIGHT))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HBC_HOLY_LIGHT))
        end
    elseif pClassTrim=="PRIE" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_FLASH_HEAL))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_BINDING_HEAL))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_PURIFY))
        if HEALBOT_GAME_VERSION>3 or HealBot_Data["PLEVEL"]<40 then
            HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_HOLY_WORD_SERENITY))
        else
            HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HBC_HEAL))
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_MASS_DISPEL))
        else
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HBC_PRIEST_ABOLISH_DISEASE))
        end
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_RENEW))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_PRAYER_OF_MENDING))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", GetSpellInfo(HEALBOT_PRAYER_OF_HEALING))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_DIVINE_HYMN))
        if HEALBOT_GAME_VERSION>3 or HealBot_Data["PLEVEL"]>39 then
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEAL))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HBC_HEAL))
        end 
    elseif pClassTrim=="SHAM" then
        if HealBot_Config.CurrentSpec==3 then
            x=GetSpellInfo(HEALBOT_PURIFY_SPIRIT);
        else
            x=GetSpellInfo(HEALBOT_CLEANSE_SPIRIT);
        end
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEALING_SURGE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_HEALING_RAIN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", x)
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", x)
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_CHAIN_HEAL))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_HEALING_STREAM_TOTEM))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_HEALING_WAVE))
        else
            HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HBC_HEALING_WAVE))
        end
    elseif pClassTrim=="MAGE" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_REMOVE_CURSE))
    end
    HealBot_Action_SetSpell("ENABLED", "ShiftButton4", HEALBOT_DISABLED_TARGET)
    HealBot_Action_SetSpell("ENABLED", "ShiftButton5", HEALBOT_ASSIST)
    HealBot_Action_SetSpell("ENABLED", "Button4", HEALBOT_MENU)
    HealBot_Action_SetSpell("ENABLED", "Button5", HEALBOT_HBMENU)
      --HealBot_setCall("HealBot_DoReset_Spells")
end

function HealBot_DoReset_Cures(pClassTrim)
    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE}
    HealBot_Config_Cures.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4}
    local i=1
    if pClassTrim=="DRUI" then
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Spell_Names[HBC_DRUID_REMOVE_CURSE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_DRUID_REMOVE_CURSE]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_REMOVE_CURSE
                i=i+1
            end
            if HealBot_Spell_Names[HBC_DRUID_ABOLISH_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_DRUID_ABOLISH_POISON]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_ABOLISH_POISON
            elseif HealBot_Spell_Names[HBC_DRUID_CURE_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_DRUID_CURE_POISON]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_CURE_POISON
            end
        else
            if HealBot_Spell_Names[HEALBOT_NATURES_CURE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_NATURES_CURE]) then
                if HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURES_CURE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim=="MONK" then
        if HealBot_Spell_Names[HEALBOT_DETOX] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_DETOX]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_DETOX,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PALA" then
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Spell_Names[HEALBOT_CLEANSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HEALBOT_CLEANSE
                i=i+1
            end
            if HealBot_Spell_Names[HBC_PURIFY] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_PURIFY]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_PURIFY
            end
        else
            if HealBot_Spell_Names[HEALBOT_CLEANSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spell_Names[HEALBOT_CLEANSE_TOXIN] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_TOXIN]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_TOXIN,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_Spell_Names[HEALBOT_PURIFY] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY]) then
            if HealBot_Spell_Names[HBC_PRIEST_ABOLISH_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_PRIEST_ABOLISH_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HBC_PRIEST_ABOLISH_DISEASE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spell_Names[HEALBOT_MASS_DISPEL] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_MASS_DISPEL]) then
                if HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_PURIFY_DISEASE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_MASS_DISPEL] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_MASS_DISPEL]) then
            if HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="SHAM" then
        if HEALBOT_GAME_VERSION<3 then
            if HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON]) then
                if HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HBC_SHAMAN_CURE_DISEASE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HEALBOT_GAME_VERSION<4 then
            if HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON]) then
                if HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_CLEANSE_SPIRIT,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        else
            if HealBot_Spell_Names[HEALBOT_PURIFY_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_SPIRIT]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_Spell_Names[HEALBOT_REMOVE_CURSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CURSE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="EVOK" then
        if HealBot_Spell_Names[HEALBOT_NATURALIZE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_NATURALIZE]) then
            if HealBot_Spell_Names[HEALBOT_CAUTERIZING_FLAME] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CAUTERIZING_FLAME]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURALIZE,[2]=HEALBOT_CAUTERIZING_FLAME,[3]=HEALBOT_WORDS_NONE}
            else 
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURALIZE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_EXPUNGE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_EXPUNGE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_EXPUNGE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
      --HealBot_setCall("HealBot_DoReset_Cures")
end

local HealBot_GetContainerNumSlots=GetContainerNumSlots
local HealBot_GetContainerItemID=GetContainerItemID
HealBot_GetItemCooldown=GetItemCooldown
if C_Container then
    HealBot_GetItemCooldown=C_Container.GetItemCooldown
    HealBot_GetContainerNumSlots=C_Container.GetContainerNumSlots or GetContainerNumSlots
    HealBot_GetContainerItemID=C_Container.GetContainerItemID or GetContainerItemID
end

local HealBot_WellFedItems={}
local HealBot_ManaDrinkItems={}
local HealBot_BuffExtraItems={}
local HealBot_ConsumableItems={}
local hbCacheItemIcons={}

function HealBot_retWellFedItems()
    return HealBot_WellFedItems
end

function HealBot_retManaDrinkItems()
    return HealBot_ManaDrinkItems
end

function HealBot_retBuffExtraItems()
    return HealBot_BuffExtraItems
end

function HealBot_retConsumableItems()
    return HealBot_ConsumableItems
end

function HealBot_retItemIcon(name)
    return hbCacheItemIcons[name]
end

local function EnumerateTooltipLines_helper(pattern, ...)
    local prevText,region=nil,nil
    for i = 1, select("#", ...) do
        region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            if region:GetText() then
                if string.find(region:GetText(), pattern) then
                    return prevText or region:GetText()
                elseif not prevText then
                    prevText=region:GetText()
                end
            end
        end
    end
    return false
end

local hbBagScanExcludeItems={[82800]=true}
local hbBagScanIncludeItems={}
local hbCacheItemNames={}
local function HealBot_IncludeScanItem(id, name, iType)
    if not hbBagScanIncludeItems[id] then hbBagScanIncludeItems[id]={} end
    hbBagScanIncludeItems[id][iType]=name
end
local function HealBot_CacheItemIdsInBag(id, bag, slot)
    HealBot_ItemsInBags[id]={}
    HealBot_ItemsInBags[id].bag=bag
    HealBot_ItemsInBags[id].slot=slot
    if not hbCacheItemNames[id] then
        local itemName, _, _, _, _, _, _, _, _, itemTexture, _, classID = GetItemInfo(id)
        if itemName then
            hbCacheItemNames[id]=itemName
            hbCacheItemIcons[itemName]=itemTexture
            if GetItemClassInfo(classID)=="Consumable" then
                HealBot_ConsumableItems[id]=itemName
            end
        end
    end
    if hbCacheItemNames[id] then
        HealBot_ItemsInBags[hbCacheItemNames[id]]=true
    end
end
local function HealBot_ItemIdsInBag(bag, slot, firstScan)
    if slot<=HealBot_luVars["MaxBagSlots"] then
        local itemId=HealBot_GetContainerItemID(bag,slot) or 0
        if itemId>0 then
            HealBot_CacheItemIdsInBag(itemId, bag, slot)
            if not hbBagScanExcludeItems[itemId] then
                if not hbBagScanIncludeItems[itemId] then
                    HealBot_SetToolTip(HealBot_ScanTooltip)
                    local itemText=""
                    HealBot_ScanTooltip:SetBagItem(bag, slot)
                    itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_WELLFED, HealBot_ScanTooltip:GetRegions())
                    if itemText and HealBot_ConsumableItems[itemId] then
                        HealBot_WellFedItems[itemText]=true
                        HealBot_IncludeScanItem(itemId, itemText, "WellFed")
                    end
                    itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_RESTOREMANA, HealBot_ScanTooltip:GetRegions())
                    if itemText and HealBot_ConsumableItems[itemId] then
                        HealBot_ManaDrinkItems[itemText]=true
                        HealBot_IncludeScanItem(itemId, itemText, "ManaDrink")
                    end
                    itemText=false
                    for j=1, #HEALBOT_STRING_MATCH_EXTRABUFFS do
                        if not itemText then
                            itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_EXTRABUFFS[j], HealBot_ScanTooltip:GetRegions())
                        end
                    end
                    if itemText and HealBot_ConsumableItems[itemId] then
                        HealBot_BuffExtraItems[itemText]=true
                        HealBot_IncludeScanItem(itemId, itemText, "Extra")
                    end
                    if not hbBagScanIncludeItems[itemId] and not firstScan then
                        hbBagScanExcludeItems[itemId]=true
                    end
                else
                    if hbBagScanIncludeItems[itemId]["WellFed"] then
                        HealBot_WellFedItems[hbBagScanIncludeItems[itemId]["WellFed"]]=true
                    end
                    if hbBagScanIncludeItems[itemId]["ManaDrink"] then
                        HealBot_ManaDrinkItems[hbBagScanIncludeItems[itemId]["ManaDrink"]]=true
                    end
                    if hbBagScanIncludeItems[itemId]["Extra"] then
                        HealBot_BuffExtraItems[hbBagScanIncludeItems[itemId]["Extra"]]=true
                    end
                end
            end
        end
        C_Timer.After(0.01, function() HealBot_ItemIdsInBag(bag, slot+1, firstScan) end)
    elseif bag<NUM_BAG_SLOTS then
        HealBot_luVars["MaxBagSlots"]=HealBot_GetContainerNumSlots(bag+1)
        C_Timer.After(0.01, function() HealBot_ItemIdsInBag(bag+1, 1, firstScan) end)
    elseif firstScan then
        if not HealBot_luVars["InvFirstRunDone"] then
            HealBot_luVars["InvFirstRunDone"]=true
            HealBot_Timers_Set("PLAYER","InvReady")
        else
            HealBot_luVars["InvReady"]=true
            HealBot_Timers_Set("PLAYER","InvChange")
        end
    else
        HealBot_Options_SetBuffExtraItemText()
        HealBot_luVars["BagsScanned"]=true
        HealBot_Timers_Set("LAST","InitItemsData")
        HealBot_Timers_Set("OOC","ActionIconsValidateItems")
    end
end

function HealBot_ItemIdsInBags(firstScan)
    for x,_ in pairs(HealBot_ItemsInBags) do
        HealBot_ItemsInBags[x]=nil;
    end
    for x,_ in pairs(HealBot_WellFedItems) do
        HealBot_WellFedItems[x]=nil
    end
    for x,_ in pairs(HealBot_ManaDrinkItems) do
        HealBot_ManaDrinkItems[x]=nil
    end
    for x,_ in pairs(HealBot_BuffExtraItems) do
        HealBot_BuffExtraItems[x]=nil
    end
    HealBot_luVars["MaxBagSlots"]=HealBot_GetContainerNumSlots(0)
    C_Timer.After(0.01, function() HealBot_ItemIdsInBag(0, 1, firstScan) end)
      --HealBot_setCall("HealBot_retItemIdsInBag")
end

function HealBot_DoReset_Buffs(pClassTrim)
    HealBot_Config_Buffs.HealBotBuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    HealBot_Config_Buffs.HealBotBuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=2,[10]=2}
    if pClassTrim=="DRUI" then
        if HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD)
        end
        if HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
        if HealBot_KnownSpell(HBC_THORNS) then
            HealBot_Config_Buffs.HealBotBuffText[3]=HealBot_KnownSpell(HBC_THORNS)
            HealBot_Config_Buffs.HealBotBuffDropDown[3]=15
        end
    elseif pClassTrim=="MONK" then
        local i=1
        if HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR) and HealBot_Config.CurrentSpec==3 then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR)
            i=i+1
        elseif HealBot_KnownSpell(HEALBOT_LEGACY_WHITETIGER) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_LEGACY_WHITETIGER)
        end
    elseif pClassTrim=="PALA" then
        local i=1
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1 
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE)
        elseif HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE)
        end
        local i=2
        if HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) and HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_FEAR_WARD) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_FEAR_WARD)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=15
            i=i+1
        end
        if HealBot_KnownSpell(HBC_INNER_FIRE) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_INNER_FIRE)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=2
            i=i+1
        end
        if HealBot_KnownSpell(HBC_DIVINE_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_DIVINE_SPIRIT)
            i=i+1
        end
        if HealBot_KnownSpell(HBC_PRAYER_OF_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_PRAYER_OF_SPIRIT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i-1]=2
            i=i+1
        end
        if HealBot_KnownSpell(HBC_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_SHADOW_PROTECTION)
            i=i+1
        end
        if HealBot_KnownSpell(HBC_PRAYER_OF_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_PRAYER_OF_SHADOW_PROTECTION)
            HealBot_Config_Buffs.HealBotBuffDropDown[i-1]=2
            i=i+1
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_KnownSpell(HEALBOT_WATER_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_WATER_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
        if HealBot_KnownSpell(HEALBOT_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HEALBOT_EARTH_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=15
        elseif HealBot_KnownSpell(HBC_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HBC_EARTH_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=15
        end
        if HealBot_KnownSpell(HEALBOT_SPIRIT_OF_THE_ALPHA) then
            HealBot_Config_Buffs.HealBotBuffText[3]=HealBot_KnownSpell(HEALBOT_SPIRIT_OF_THE_ALPHA)
            HealBot_Config_Buffs.HealBotBuffDropDown[3]=1
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE)
        end
        if HealBot_KnownSpell(HBC_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HBC_ARCANE_BRILLIANCE)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
    elseif pClassTrim=="WARR" then
        if HealBot_KnownSpell(HEALBOT_COMMANDING_SHOUT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_COMMANDING_SHOUT)
        end
        if HealBot_KnownSpell(HEALBOT_VIGILANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HEALBOT_VIGILANCE)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=2
        end
    elseif pClassTrim=="WARL" then
        if HealBot_KnownSpell(HEALBOT_DARK_INTENT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_DARK_INTENT)
        end
    elseif pClassTrim=="EVOK" then
    end
      --HealBot_setCall("HealBot_DoReset_Buffs")
end

function HealBot_InitNewChar()
    if not HealBot_Config_Spells.EnemyKeyCombo then
        HealBot_Config_Spells.EnemyKeyCombo={}
    end
    if HealBot_Config_Spells.EnabledKeyCombo["New"] then
        HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
        HealBot_Config_Buffs.HealBotBuffColR = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColG = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColB = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
    end
    if HealBot_Config.CurrentSpec==9 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end
      --HealBot_setCall("HealBot_InitNewChar")
end

function HealBot_Register_Events()
    if HealBot_Config.DisabledNow==0 then
        if HEALBOT_GAME_VERSION>1 then
            HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
        end
        if HEALBOT_GAME_VERSION>2 then
            HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
            if HEALBOT_GAME_VERSION==3 then
                HealBot:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            end
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:RegisterEvent("COMPANION_LEARNED");
            HealBot:RegisterEvent("PET_BATTLE_OPENING_START");
            HealBot:RegisterEvent("PET_BATTLE_OVER");
            HealBot:RegisterEvent("INCOMING_SUMMON_CHANGED")
            HealBot:RegisterEvent("PLAYER_ROLES_ASSIGNED");
            HealBot:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
            HealBot:RegisterEvent("NEW_MOUNT_ADDED")
            if HEALBOT_GAME_VERSION>9 then
                HealBot:RegisterEvent("TRAIT_CONFIG_UPDATED")
            end
        end
        HealBot:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
        HealBot:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        HealBot:RegisterEvent("SPELL_UPDATE_CHARGES")
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        local regPower=false
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("PLAYER_LEVEL_UP");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
        HealBot:RegisterEvent("INSPECT_READY");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");
        HealBot:RegisterEvent("CURSOR_CHANGED")

        HealBot:RegisterEvent("ROLE_CHANGED_INFORM");
        local regThis={}
        for j=1,10 do
            if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][j]["SHOW"] then regThis["RAIDTARGET"]=true end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["SHOWRC"] then regThis["READYCHECK"]=true end
        end
        if regThis["RAIDTARGET"] then HealBot:RegisterEvent("RAID_TARGET_UPDATE") end
        if regThis["READYCHECK"] then HealBot_Register_ReadyCheck() end
        HealBot:RegisterEvent("UNIT_SPELLCAST_SENT");
        HealBot:RegisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:RegisterEvent("PLAYER_CONTROL_LOST");
        HealBot:RegisterEvent("PLAYER_UPDATE_RESTING");
        HealBot:RegisterEvent("BAG_UPDATE");
        HealBot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        HealBot:RegisterEvent("DISPLAY_SIZE_CHANGED")
        HealBot:RegisterEvent("UI_SCALE_CHANGED")
    end
    HealBot:RegisterEvent("GET_ITEM_INFO_RECEIVED");
    HealBot:RegisterEvent("GROUP_ROSTER_UPDATE");
    HealBot:RegisterEvent("RAID_ROSTER_UPDATE");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    HealBot:RegisterEvent("PLAYER_GUILD_UPDATE")
    if HEALBOT_GAME_VERSION>2 and HEALBOT_GAME_VERSION<9 then
        HealBot:RegisterEvent("ZONE_CHANGED");
        HealBot:RegisterEvent("ZONE_CHANGED_INDOORS");
    end
    HealBot:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
      --HealBot_setCall("HealBot_Register_Events")
end

function HealBot_SetResSpells()
    HealBot_ResSpells={[GetSpellInfo(HEALBOT_MASS_RESURRECTION) or "x"]=2,
                       [GetSpellInfo(HEALBOT_MASS_RETURN) or "x"]=2,
                       [GetSpellInfo(HEALBOT_ABSOLUTION) or "x"]=2,
                       [GetSpellInfo(HEALBOT_ANCESTRAL_VISION) or "x"]=2,
                       [GetSpellInfo(HEALBOT_REAWAKEN) or "x"]=2,
                       [GetSpellInfo(HEALBOT_REVITALIZE) or "x"]=2,
                       [GetSpellInfo(HEALBOT_RESURRECTION) or "x"]=1,
                       [GetSpellInfo(HEALBOT_RETURN) or "x"]=1,
                       [GetSpellInfo(HEALBOT_ANCESTRALSPIRIT) or "x"]=1,
                       [GetSpellInfo(HEALBOT_REBIRTH) or "x"]=1,
                       [GetSpellInfo(HEALBOT_REDEMPTION) or "x"]=1,
                       [GetSpellInfo(HEALBOT_REVIVE) or "x"]=1,
                       [GetSpellInfo(HEALBOT_RESUSCITATE) or "x"]=1,
                       [GetSpellInfo(HEALBOT_INTERCESSION) or "x"]=1}
end

function HealBot_Load()
    if not HealBot_luVars["Loaded"] then
        HealBot_FastFuncs()
        HealBot_Timers_TurboOn(5)
        HealBot_Init_Spells_Defaults()
        HealBot_InitNewChar()
        HealBot_luVars["CurrentSpec"]=HealBot_Config.CurrentSpec
        for x=16,20 do  -- This can be remove when 9.2.x check is replace with defaults due to old version
            if not HealBot_Config_Spells.Binds[x] then HealBot_Config_Spells.Binds[x]=1 end
        end
        HealBot_Options_LoadProfile()
        hbPhaseShift=GetSpellInfo(HBC_PHASE_SHIFT)
        HealBot_Skins_ResetSkin("init")
        HealBot_Timers_InitSpells()
        HealBot_Action_SetCustomClassCols()
        HealBot_Action_SetCustomRoleCols()
        HealBot_Action_SetCustomPowerCols()
        HealBot_MMButton_Init()
        HealBot_Aura_SetAuraWarningFlags()
        HealBot_Options_Override_ChatUse_Toggle()
        HealBot_Options_Override_EffectsUse_Toggle()
        HealBot_Options_Override_FramesUse_Toggle()
        HealBot_Options_Override_ColoursClassUse_Toggle()
        HealBot_Options_Override_ColoursRoleUse_Toggle()
        HealBot_Options_Override_ColoursPowerUse_Toggle()
        HealBot_Options_Override_ColoursAdaptiveUse_Toggle()
        HealBot_Action_StickyFrameIndCols()
        HealBot_Register_IncHeals()
        HealBot_PartyUpdate_CheckSkin()
        HealBot_Timers_SetCurrentSkin()
        HealBot_Action_ResetGlobalDimming()
        HealBot_Vers[UnitName("player")]=HEALBOT_VERSION
        HealBot_Comms_PerfLevel()
        HealBot_ActionIcons_InitFrames()
        HealBot_Timers_Set("INIT","CheckTalentInfo")
        HealBot_Timers_Set("INIT","SeparateInHealsAbsorbs")
        HealBot_Timers_Set("INIT","InitPlugins")
        HealBot_Timers_Set("INIT","RegEvents")
        HealBot_Timers_Set("SKINS","RaidTargetUpdate")
        HealBot_Timers_Set("SKINS","TextExtraCustomCols")
        HealBot_Timers_Set("SKINS","PowerIndicator")
        HealBot_Timers_Set("AURA","InitAuraData")
        HealBot_Timers_Set("LAST","LowManaTrig")
        HealBot_Timers_Set("LAST","CheckFramesOnCombat")
        HealBot_Timers_Set("INIT","LastLoad")
        HealBot_Timers_Set("LAST","UpdateMaxUnitsAdj",1)
        HealBot_Timers_Set("LAST","PerfRangeFreq")
        HealBot_luVars["UpdateSlowNext"]=HealBot_TimeNow+1
        HealBot_Globals.FirstLoad=false
    end
          --HealBot_setCall("HealBot_Load")
end

function HealBot_Loaded()
    HealBot_luVars["Loaded"]=true
end

function HealBot_FullReload()
    if not HealBot_luVars["UILOCK"] then
        HealBot_ReloadAddon()
    else
        HealBot_Timers_Set("OOC","FullReload")
    end
end

function HealBot_Reload()
    HealBot_Timers_Set("RESET","Quick")
end

function HealBot_UnRegister_Events()
    if HealBot_Config.DisabledNow==1 then
        if HEALBOT_GAME_VERSION>1 then
            HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
        end
        if HEALBOT_GAME_VERSION>2 then
            HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
            if HEALBOT_GAME_VERSION==3 then
                HealBot:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            end
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:UnregisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:UnregisterEvent("COMPANION_LEARNED");
            HealBot:UnregisterEvent("INCOMING_SUMMON_CHANGED")
            HealBot:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
            if HEALBOT_GAME_VERSION>9 then
                HealBot:UnregisterEvent("TRAIT_CONFIG_UPDATED")
            end
        end
        HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
        if HEALBOT_GAME_VERSION>2 and HEALBOT_GAME_VERSION<9 then
            HealBot:UnregisterEvent("ZONE_CHANGED");
            HealBot:UnregisterEvent("ZONE_CHANGED_INDOORS");
        end
        HealBot:UnregisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:UnregisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:UnregisterEvent("PLAYER_TARGET_CHANGED");
        HealBot_UnRegister_ReadyCheck()
        HealBot:UnregisterEvent("UNIT_PET");
        HealBot:UnregisterEvent("ROLE_CHANGED_INFORM");
        HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_LOST");
        HealBot:UnregisterEvent("PLAYER_UPDATE_RESTING");
        HealBot:UnregisterEvent("BAG_UPDATE");
        HealBot:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
    end
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
        HealBot:UnregisterEvent("PET_BATTLE_OVER");
        HealBot:UnregisterEvent("NEW_MOUNT_ADDED")
    end
    HealBot:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
    HealBot:UnregisterEvent("SPELL_UPDATE_CHARGES")
    HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    HealBot:UnregisterEvent("PLAYER_LEVEL_UP");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
      --HealBot_setCall("HealBot_UnRegister_Events")
end

function HealBot_EndAggro()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
      --HealBot_setCall("HealBot_EndAggro")
end

function HealBot_Reset_Full()
    HealBot_UnRegister_Events()
    HealBot_Panel_ClearBlackList()
    HealBot_Panel_ClearHealTargets()
    HealBot_Action_ResethbInitButtons()
    HealBot_EndAggro()  
    HealBot_Timers_Set("SKINS","AllFramesChanged")
    HealBot_Timers_Set("LAST","ZoneUpdate")
    HealBot_Timers_AuraReset()
    HealBot_Timers_Set("INIT","RegEvents")
      --HealBot_setCall("HealBot_Reset_Full")
end

function HealBot_Reset_Quick()
    HealBot_Aura_ClearAllBuffs()
    HealBot_Aura_ClearAllDebuffs()
    HealBot_Timers_Set("SKINS","AllFramesChanged")
end

local idGUID,idUnit,idButton,pidButton,eidButton=false,false,false,false,false
function HealBot_UnitID(unit, incEnemy)
    if UnitIsUnit(unit, "player") then
        if HealBot_Unit_Button[HealBot_Data["PUNIT"]] or HealBot_Private_Button[HealBot_Data["PUNIT"]] then
            unit=HealBot_Data["PUNIT"]
        end
        idButton=HealBot_Unit_Button[unit] or HealBot_Unit_Button["player"]
        pidButton=HealBot_Private_Button[unit] or HealBot_Private_Button["player"]
    else
        idButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit] or HealBot_Extra_Button[unit] or HealBot_Vehicle_Button[unit]
        pidButton=HealBot_Private_Button[unit]
    end
    if idButton or pidButton then
        return unit, idButton, pidButton
    end
    idUnit=HealBot_Panel_RaidPetUnitGUID(UnitGUID(unit) or "x")
    if idUnit and UnitIsUnit(unit,idUnit) then
        if HealBot_Unit_Button[idUnit] or HealBot_Private_Button[idUnit] then
            return idUnit, HealBot_Unit_Button[idUnit], HealBot_Private_Button[idUnit]
        elseif HealBot_Pet_Button[idUnit] then
            return idUnit, HealBot_Pet_Button[idUnit], false
        elseif HealBot_Vehicle_Button[idUnit] then
            return idUnit, HealBot_Vehicle_Button[idUnit], false
        end
    elseif incEnemy and HealBot_Enemy_Button[unit] then
        return unit, HealBot_Enemy_Button[unit], false
    end
      --HealBot_setCall("HealBot_UnitID")
    return false,false,false
end

function HealBot_OverHealText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]>1 then
        HealBot_Text_setOverHealText(button)
    end
end

local hiuOverHeal,hiuPlayerInHeal=0
function HealBot_OverHeal(button)
    if HealBot_luVars["overhealUnit"]==button.unit then
        hiuPlayerInHeal=UnitGetIncomingHeals(button.unit, "player") or 0
        hiuOverHeal=(button.health.current+hiuPlayerInHeal)-button.health.max
        if hiuOverHeal<1 then hiuOverHeal=0 end
    else
        hiuOverHeal=(button.health.current+button.health.auxincoming)-button.health.max
        if hiuOverHeal<1 then hiuOverHeal=0 end
    end
    if button.health.overheal~=hiuOverHeal then
        button.health.overheal=hiuOverHeal
        HealBot_OverHealText(button)
        HealBot_Aux_UpdateOverHealBar(button)
        HealBot_Action_AdaptiveOverhealsUpdate(button)
    end
      --HealBot_setCall("HealBot_OverHeal")
end

local hiuHealAmount=0
local hiuCHCAmount, hiuBlizzAmount=0,0
function HealBot_HealsInAmountV1(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        --hiuHealAmount=(libCHC:GetHealAmount(button.guid, libCHC.ALL_HEALS, HealBot_TimeNow+HealBot_Globals.ClassicHoTTime) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        hiuHealAmount=(libCHC:GetHealAmount(button.guid, libCHC.HOT_HEALS+libCHC.BOMB_HEALS, HealBot_TimeNow+HealBot_Globals.ClassicHoTTime) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        hiuCHCAmount=(libCHC:GetHealAmount(button.guid, libCHC.CASTED_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        hiuBlizzAmount=UnitGetIncomingHeals(button.unit) or 0
        if hiuCHCAmount>hiuBlizzAmount then
            hiuHealAmount=hiuHealAmount+hiuCHCAmount
        else
            hiuHealAmount=hiuHealAmount+hiuBlizzAmount
        end
    else
        hiuHealAmount=0
    end
end

function HealBot_HealsInAmountV4(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hiuHealAmount=(UnitGetIncomingHeals(button.unit) or 0)
    else
        hiuHealAmount=0
    end
end

local HealBot_HealsInAmount=HealBot_HealsInAmountV4
if HEALBOT_GAME_VERSION<4 and libCHC then
    HealBot_HealsInAmount=HealBot_HealsInAmountV1
end

function HealBot_HealsInUpdate(button)
    button.health.updinheal=false
    HealBot_HealsInAmount(button)
    if hiuHealAmount>0 and button.status.range>0 then
        if button.health.incoming~=hiuHealAmount then
            button.health.incoming=hiuHealAmount
            HealBot_Action_UpdateHealsInButton(button)
            HealBot_Text_setInHealAbsorbsText(button)
        end
    elseif button.health.incoming>0 or button.gref["InHeal"]:GetValue()>0 then
        button.health.incoming=0
        button.gref["InHeal"]:SetValue(0)
        button.health.inheala=0
        HealBot_Action_UpdateInHealStatusBarColor(button)
        HealBot_Text_setInHealAbsorbsText(button)
    end
    if button.health.auxincoming~=hiuHealAmount then
        button.health.auxincoming=hiuHealAmount
        HealBot_OverHeal(button)
        HealBot_Aux_UpdateHealInBar(button)
    end
end

function HealBot_OnEvent_HealsInUpdate(button)
    if HealBot_Globals.EventQueues["INHEALS"] then
        button.health.updinheal=true
        if not HealBot_BarQueue[button.id] then
            HealBot_BarQueue[button.id]=true
            HealBot_InsertFastUnitQueue(button.id, "BAR")
        end
    else
        HealBot_HealsInUpdate(button)
    end
      --HealBot_setCall("HealBot_OnEvent_HealsInUpdate")
end

local thauHealAmount=0
function HealBot_OnEvent_TotalHealAbsorbs(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        thauHealAmount=(UnitGetTotalHealAbsorbs(button.unit) or 0)
    else
        thauHealAmount=0
    end
    if button.health.healabsorbs~=thauHealAmount then
        button.health.healabsorbs=thauHealAmount
        HealBot_Aux_UpdateTotalHealAbsorbsBar(button)
    end
      --HealBot_setCall("HealBot_OnEvent_TotalHealAbsorbs")
end

function HealBotClassic_HealsInDoUpdate(button)
    HealBot_OnEvent_HealsInUpdate(button)
    HealBot_OnEvent_AbsorbsUpdate(button)
end

local chiTargetGUID=false
function HealBotClassic_HealsInUpdate(spellId, ...)
    for i=1, select("#", ...) do
        chiTargetGUID = select(i, ...)
        if chiTargetGUID and HealBot_Panel_AllUnitGUID(chiTargetGUID) then
            xUnit,xButton,pButton = HealBot_UnitID(HealBot_Panel_AllUnitGUID(chiTargetGUID))
            if xUnit and HealBot_Extra_Button["target"] and xUnit~="target" and UnitExists("target") and UnitIsUnit("target", xUnit) then
                HealBotClassic_HealsInDoUpdate(HealBot_Extra_Button["target"])
            end
            if xButton then HealBotClassic_HealsInDoUpdate(xButton) end
            if pButton then HealBotClassic_HealsInDoUpdate(pButton) end
        end
    end
end

local abuAbsorbAmount=0
function HealBot_Classic_AbsorbsUpdate(button, amount)
    if button.health.absorbs>0 then 
        button.health.absorbs=button.health.absorbs-amount
        if button.health.absorbs<0 then button.health.absorbs=0 end
        button.health.auxabsorbs=button.health.absorbs
        HealBot_Action_UpdateAbsorbsButton(button)
        HealBot_Text_setInHealAbsorbsText(button)
        HealBot_Aux_UpdateAbsorbBar(button)
    end
end

function HealBot_AbsorbsAmountV1(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
            button.health.auraabsorbs=0
        end
        abuAbsorbAmount=button.health.auraabsorbs
    else
        abuAbsorbAmount=0
    end
end

function HealBot_AbsorbsAmountV5(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        abuAbsorbAmount=(UnitGetTotalAbsorbs(button.unit) or 0)
    else
        abuAbsorbAmount=0
    end
end

local HealBot_AbsorbsAmount=HealBot_AbsorbsAmountV1
if HEALBOT_GAME_VERSION>4 then
    HealBot_AbsorbsAmount=HealBot_AbsorbsAmountV5
end

function HealBot_AbsorbsUpdate(button)
    button.health.updabsorb=false
    HealBot_AbsorbsAmount(button)
    if button.status.range>0 and abuAbsorbAmount>0 then
        if button.health.absorbs~=abuAbsorbAmount then
            button.health.absorbs=abuAbsorbAmount
            button.health.absorbspctc=floor((button.health.absorbs/button.health.max)*1000)
            HealBot_Action_UpdateHealthHotBar(button)
            HealBot_Action_UpdateAbsorbsButton(button)
            HealBot_Text_setInHealAbsorbsText(button)
            HealBot_Action_AdaptiveAbsorbsUpdate(button)
        end
    elseif button.health.absorbs>0 or button.gref["Absorb"]:GetValue()>0 then
        button.health.absorbs=0
        button.health.absorbspctc=0
        HealBot_Text_setInHealAbsorbsText(button)
        button.health.absorba=0
        button.gref["Absorb"]:SetValue(0)
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
        HealBot_Action_AdaptiveAbsorbsUpdate(button)
    end
    if button.health.auxabsorbs~=abuAbsorbAmount then
        button.health.auxabsorbs=abuAbsorbAmount
        HealBot_Aux_UpdateAbsorbBar(button)
    end
      --HealBot_setCall("HealBot_OnEvent_AbsorbsUpdate")
end

function HealBot_OnEvent_AbsorbsUpdate(button)
    if HealBot_Globals.EventQueues["ABSORBS"] then
        button.health.updabsorb=true
        if not HealBot_BarQueue[button.id] then
            HealBot_BarQueue[button.id]=true
            HealBot_InsertFastUnitQueue(button.id, "BAR")
        end
    else
        HealBot_AbsorbsUpdate(button)
    end
end

function HealBot_ResetCustomDebuffs()
    HealBot_Globals.HealBot_Custom_Debuffs=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs)
    HealBot_Globals.Custom_Debuff_Categories=HealBot_Options_copyTable(HealBot_GlobalsDefaults.Custom_Debuff_Categories)
    HealBot_Globals.FilterCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.FilterCustomDebuff)
    HealBot_Globals.CDCBarColour=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCBarColour)
    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs_ShowBarCol)
    HealBot_Globals.IgnoreCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.IgnoreCustomDebuff)
    HealBot_Globals.CDCTag=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCTag)
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_setLuVars("customdebufftextpage", 1)
    HealBot_Options_ResetUpdate()
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
    HealBot_Aura_ClearCustomDebuffsDone()
    HealBot_Timers_Set("AURA","CustomDebuffListPrep")
      --HealBot_setCall("HealBot_ResetCustomDebuffs")
end

function HealBot_ResetSkins()
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_OPTIONS_GROUPHEALS], true)
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_OPTIONS_RAID25], true)
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_OPTIONS_RAID40], true)
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_SKINS_STD], true)
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Update_Skins()
    HealBot_Timers_Set("INIT","ResetSkinAllElements")
    HealBot_Timers_Set("SKINS","AllFramesChanged")
      --HealBot_setCall("HealBot_ResetSkins")
end

function HealBot_Reset_Button(button)
    button.status.change=true
    button.status.update=true
    if HealBot_Action_AlwaysEnabled(button.guid) then HealBot_Action_Toggle_Enabled(button.unit); end
end

function HealBot_Reset_Unit(unit)
    _,xButton,pButton = HealBot_UnitID(unit, true)
    if xButton then
        HealBot_Reset_Button(xButton)
    end
    if pButton then
        HealBot_Reset_Button(pButton)
    end
      --HealBot_setCall("HealBot_Reset_Unit")
end

local ksName=false
function HealBot_KnownSpell(spellID)
    if not spellID then return nil end
    if HealBot_Spell_IDs[spellID] and HealBot_Spell_IDs[spellID].known then   
        return HealBot_Spell_IDs[spellID].name; 
    else
        ksName=GetSpellInfo(spellID) or false
        if ksName and HealBot_Spell_Names[ksName] then
            return ksName
        end
    end
      --HealBot_setCall("HealBot_KnownSpell")
    return nil;
end

function HealBot_IncHeals_ClearUnit(button)
    if button.health.incoming>0 then
        button.health.incoming=0
        button.health.auxincoming=0
        button.health.overheal=0
        HealBot_Aux_UpdateOverHealBar(button)
        HealBot_Action_UpdateHealsInButton(button)
        HealBot_Aux_UpdateHealInBar(button)
    end
    if button.health.absorbs>0 then
        button.health.absorbs=0
        button.health.auxabsorbs=0
        HealBot_Action_UpdateAbsorbsButton(button)
        HealBot_Aux_UpdateAbsorbBar(button)
    end
end

function HealBot_IncHeals_ClearAll()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
      --HealBot_setCall("HealBot_IncHeals_ClearAll")
end

function HealBot_OnLoad()
    HealBot:RegisterEvent("VARIABLES_LOADED");
    HealBot:RegisterEvent("ADDON_LOADED");
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    SLASH_HEALBOT1 = "/healbot";
    SLASH_HEALBOT2 = "/hb";
    SlashCmdList["HEALBOT"] = function(msg)
        HealBot_SlashCmd(msg);
    end
      --HealBot_setCall("HealBot_OnLoad")
end

local prevCPU,prevCPUadj,prevFPS=0,99,0
function HealBot_Update_CPUUsage()
    prevCPU=HealBot_Globals.CPUUsage
    prevFPS=HealBot_Globals.FPS
    HealBot_luVars["FPS"][0]=ceil((HealBot_luVars["FPS"][1][0]+HealBot_luVars["FPS"][2][0]+HealBot_luVars["FPS"][3][0])/3) 
    if HealBot_luVars["CPUProfilerOn"] then
        if HealBot_luVars["FPS"][0]<40 then
            HealBot_Globals.CPUUsage=1
        elseif HealBot_luVars["FPS"][0]<70 then
            HealBot_Globals.CPUUsage=2
        elseif HealBot_luVars["FPS"][0]<100 then
            HealBot_Globals.CPUUsage=3
        else
            HealBot_Globals.CPUUsage=4
        end
        if HealBot_luVars["CPUProfilerOn"] and not HealBot_luVars["warnCPUProfiler"] then
            HealBot_AddDebug("CPUUsage="..HealBot_Globals.CPUUsage.." CPU profiler running", "Perf", true)
            HealBot_AddChat("WARNING: CPU profiler is running - FPS might be reduced.")
            HealBot_luVars["warnCPUProfiler"]=true
        end
    elseif HealBot_Globals.FPS~=HealBot_luVars["FPS"][0] or HealBot_luVars["cpuAdj"]~=prevCPUadj then
        prevCPUadj=HealBot_luVars["cpuAdj"]
        HealBot_Globals.FPS=HealBot_luVars["FPS"][0]
        if HealBot_Globals.FPS<20 then
            HealBot_Globals.CPUUsage=1
        elseif HealBot_Globals.FPS<30 then
            HealBot_Globals.CPUUsage=2
        elseif HealBot_Globals.FPS<40 then
            HealBot_Globals.CPUUsage=3
        elseif HealBot_Globals.FPS<50 then
            HealBot_Globals.CPUUsage=4
        elseif HealBot_Globals.FPS<60 then
            HealBot_Globals.CPUUsage=5
        elseif HealBot_Globals.FPS<70 then
            HealBot_Globals.CPUUsage=6
        elseif HealBot_Globals.FPS<85 then
            HealBot_Globals.CPUUsage=7
        elseif HealBot_Globals.FPS<100 then
            HealBot_Globals.CPUUsage=8
        else
            HealBot_Globals.CPUUsage=9
        end
        HealBot_Globals.CPUUsage=HealBot_Globals.CPUUsage+HealBot_luVars["cpuAdj"]
        if HealBot_Globals.CPUUsage<1 then 
            HealBot_Globals.CPUUsage=1
        elseif HealBot_Globals.CPUUsage>14 then
            HealBot_Globals.CPUUsage=14
        end
    end
    if prevCPU~=HealBot_Globals.CPUUsage then
        HealBot_AddDebug("CPUUsage="..HealBot_Globals.CPUUsage, "Perf", true)
        HealBot_Timers_Set("SKINS","FluidFlashInUse")
        HealBot_Timers_Set("LAST","UpdateMaxUnitsAdj")
        HealBot_Comms_PerfLevel()
    elseif prevFPS~=HealBot_Globals.FPS then
        HealBot_Comms_PerfLevel()
    end
end

function HealBot_UpdateMaxUnitsAdj()
    if HealBot_Globals.PerfMode==3 then
        HealBot_luVars["UpdateMaxUnits"]=floor(HealBot_Globals.CPUUsage*1.75)+4
    elseif HealBot_Globals.PerfMode==2 then
        HealBot_luVars["UpdateMaxUnits"]=floor(HealBot_Globals.CPUUsage*1.25)+3
    else
        HealBot_luVars["UpdateMaxUnits"]=ceil(HealBot_Globals.CPUUsage*0.75)+2
    end
    if HealBot_luVars["UpdateMaxUnits"]<5 then
        HealBot_luVars["UpdateMaxUnits"]=5
    end
    HealBot_UpdateNumUnits()
    HealBot_AddDebug("UpdateMaxUnits="..HealBot_luVars["UpdateMaxUnits"], "Perf", true)
end

function HealBot_UpdateNumUnits()
    if HealBot_Globals.PerfMode==3 then
        HealBot_luVars["UpdateNumUnits"]=ceil(HealBot_luVars["NumUnitsInQueue"]*0.7)
    elseif HealBot_Globals.PerfMode==2 then
        HealBot_luVars["UpdateNumUnits"]=ceil(HealBot_luVars["NumUnitsInQueue"]*0.45)
    else
        HealBot_luVars["UpdateNumUnits"]=ceil(HealBot_luVars["NumUnitsInQueue"]*0.2)
    end
    HealBot_luVars["UpdateUnitRecall"]=true
    if HealBot_luVars["NumUnitsInQueue"]>15 then
        HealBot_luVars["UpdateNumUnits"]=HealBot_luVars["UpdateNumUnits"]+5
    elseif HealBot_luVars["NumUnitsInQueue"]>8 then
        HealBot_luVars["UpdateNumUnits"]=HealBot_luVars["UpdateNumUnits"]+3
    elseif HealBot_luVars["NumUnitsInQueue"]>4 then
        HealBot_luVars["UpdateNumUnits"]=HealBot_luVars["UpdateNumUnits"]+1
    else
        HealBot_luVars["UpdateUnitRecall"]=false
    end
    if HealBot_luVars["UpdateNumUnits"]>HealBot_luVars["UpdateMaxUnits"] then
        HealBot_luVars["UpdateNumUnits"]=HealBot_luVars["UpdateMaxUnits"]
    end
    HealBot_AddDebug("UpdateNumUnits="..HealBot_luVars["UpdateNumUnits"], "Perf", true)
end

function HealBot_OnEvent_RangeUpdate(button)
    button.status.rangenextcheck=0
    --HealBot_UpdateUnitRange(button)
end

function HealBot_PerfRangeFreq()
    if HealBot_Globals.PerfMode==3 then
        HealBot_luVars["rangeCheckAdj"]=0.6-(HealBot_luVars["cpuAdj"]/20)
        HealBot_luVars["rangeCheckAdjEnabled"]=0.3-(HealBot_luVars["cpuAdj"]/20)
        HealBot_luVars["RecalcDelay"]=0.1
    elseif HealBot_Globals.PerfMode==2 then
        HealBot_luVars["rangeCheckAdj"]=1-(HealBot_luVars["cpuAdj"]/20)
        HealBot_luVars["rangeCheckAdjEnabled"]=0.5-(HealBot_luVars["cpuAdj"]/20)
        HealBot_luVars["RecalcDelay"]=0.2
    else
        HealBot_luVars["rangeCheckAdj"]=1.4-(HealBot_luVars["cpuAdj"]/20)
        HealBot_luVars["rangeCheckAdjEnabled"]=0.7-(HealBot_luVars["cpuAdj"]/20)
        HealBot_luVars["RecalcDelay"]=0.3
    end
    if HealBot_luVars["rangeCheckAdjEnabled"]<0.2 then HealBot_luVars["rangeCheckAdjEnabled"]=0.2 end
    if HealBot_luVars["rangeCheckAdj"]<0.5 then HealBot_luVars["rangeCheckAdj"]=0.5 end
    HealBot_AddDebug("rangeCheckAdj="..HealBot_luVars["rangeCheckAdj"], "Perf", true)
    HealBot_AddDebug("rangeCheckAdjEnabled="..HealBot_luVars["rangeCheckAdjEnabled"], "Perf", true)
end

function HealBot_SetEventQueues()
    if not HealBot_luVars["pluginPerformance"] then
        HealBot_Globals.EventQueues["BUFF"]=true
        HealBot_Globals.EventQueues["DEBUFF"]=true
        if HealBot_Globals.PerfMode<3 then
            HealBot_Globals.EventQueues["POWER"]=true
            if HealBot_Globals.PerfMode<2 then
                HealBot_Globals.EventQueues["HEALTH"]=true
                HealBot_Globals.EventQueues["INHEALS"]=true
                HealBot_Globals.EventQueues["ABSORBS"]=true
            else
                HealBot_Globals.EventQueues["HEALTH"]=false
                HealBot_Globals.EventQueues["INHEALS"]=false
                HealBot_Globals.EventQueues["ABSORBS"]=false
            end
        else
            HealBot_Globals.EventQueues["POWER"]=false
            HealBot_Globals.EventQueues["HEALTH"]=false
            HealBot_Globals.EventQueues["INHEALS"]=false
            HealBot_Globals.EventQueues["ABSORBS"]=false
        end
    end
end

function HealBot_PerfPlugin_adj(cpuAdj)
    HealBot_luVars["cpuAdj"]=HealBot_Options_retLuVars("perfCPUAdj")
    HealBot_Update_CPUUsage()
    HealBot_Timers_Set("LAST","PerfRangeFreq")
    HealBot_Timers_Set("LAST","UpdateMaxUnitsAdj")
end

local fpsRow,fpsCol=1,1
function HealBot_Set_FPS()
    if HealBot_luVars["qaFRNext"]<HealBot_TimeNow then
        local fpsCurRate=GetFramerate()
        if fpsCurRate>150 then fpsCurRate=150 end
        if fpsCurRate<15 then fpsCurRate=15 end
        HealBot_luVars["FPS"][fpsRow][fpsCol]=fpsCurRate
        fpsCol=fpsCol+1
        if fpsCol>3 then 
            fpsCol=1 
            fpsRow=fpsRow+1
            if fpsRow>3 then fpsRow=1 end
        elseif fpsCol==3 then
            HealBot_luVars["FPS"][fpsRow][0]=HealBot_Comm_round((HealBot_luVars["FPS"][fpsRow][1]+HealBot_luVars["FPS"][fpsRow][2]+HealBot_luVars["FPS"][fpsRow][3])/3, 2)
            HealBot_Update_CPUUsage()
        end
    end
end

function HealBot_Include_Skin(skinName, internal)
    if not Healbot_Config_Skins.Author[skinName] and HealBot_Config_SkinsData[skinName] then
        HealBot_Share_SkinLoad(HealBot_Config_SkinsData[skinName], internal)
    end
end

function HealBot_UpdateBuffItem(buff, item)
    if buff and item then
        if string.len(HealBot_Config_Buffs.CustomBuffName[1])<3 and string.len(HealBot_Config_Buffs.CustomItemName[1])<3 then
            HealBot_Config_Buffs.CustomBuffName[1]=buff
            HealBot_Config_Buffs.CustomItemName[1]=item
            HealBot_Config_Buffs.CustomBuffCheck[1]=true
        elseif string.len(HealBot_Config_Buffs.CustomBuffName[2])<3 and string.len(HealBot_Config_Buffs.CustomItemName[2])<3 then
            HealBot_Config_Buffs.CustomBuffName[2]=buff
            HealBot_Config_Buffs.CustomItemName[2]=item
            HealBot_Config_Buffs.CustomBuffCheck[2]=true
        elseif string.len(HealBot_Config_Buffs.CustomBuffName[3])<3 and string.len(HealBot_Config_Buffs.CustomItemName[3])<3 then
            HealBot_Config_Buffs.CustomBuffName[3]=buff
            HealBot_Config_Buffs.CustomItemName[3]=item
            HealBot_Config_Buffs.CustomBuffCheck[3]=true
        end
    end
end

function HealBot_Update_Skins()
    local oldVersion=9
    if HealBot_Config.LastVersionSkinUpdate then HealBot_Config.LastVersionSkinUpdate=nil end
    
    local foundSkin=false
    for x in pairs (Healbot_Config_Skins.Skins) do
        if not HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] then 
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] = {[HEALBOT_WORD_SOLO]=false, 
                                                                         [HEALBOT_WORD_PARTY]=false, 
                                                                         [HEALBOT_OPTIONS_RAID10]=false, 
                                                                         [HEALBOT_OPTIONS_RAID25]=false, 
                                                                         [HEALBOT_OPTIONS_RAID40]=false,
                                                                         [HEALBOT_WORD_ARENA]=false, 
                                                                         [HEALBOT_WORD_BG10]=false, 
                                                                         [HEALBOT_WORD_BG15]=false, 
                                                                         [HEALBOT_WORD_BG40]=false, 
                                                                         [HEALBOT_WORD_PETBATTLE]=false}
        end
        if Healbot_Config_Skins.Skins[x]==Healbot_Config_Skins.Current_Skin then foundSkin=true end
    end
    if not foundSkin then 
        local retryWithSkin = HealBot_getDefaultSkin()
        HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true, true)
    end
    if HealBot_Globals.CacheSize then HealBot_Globals.CacheSize=nil end
    if HealBot_Globals.AutoCacheSize then HealBot_Globals.AutoCacheSize=nil end
    local tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Globals.LastVersionSkinUpdate)
    if not HealBot_luVars["ResetGlobalOld"] and tonumber(tMajor)<=oldVersion then
        HealBot_luVars["ResetGlobalOld"]=true
        HealBot_Options_SetDefaults(true)
    elseif HealBot_Globals.LastVersionSkinUpdate~=HealBot_Global_Version() then
        for x in pairs (Healbot_Config_Skins.Skins) do
            HealBot_Skins_Check_Skin(Healbot_Config_Skins.Skins[x])
        end
        if not HealBot_luVars["UpdateMsg"] then
            HealBot_luVars["UpdateMsg"]=true
            HealBot_Globals.OneTimeMsg["VERSION"]=false
        end
        if tonumber(tMajor)==10 then
            if tonumber(tMinor)==0 then
                if tonumber(tPatch)==0 then
                    if tonumber(tHealbot)<4 then
                        if HealBot_Globals.Tooltip_SetScale==false then 
                            HealBot_Globals.Tooltip_Scale=1
                            HealBot_Globals.Tooltip_SetScale=nil
                        end
                        if HealBot_Globals.Tooltip_SetAlpha==false then 
                            HealBot_Globals.Tooltip_Alpha=1
                            HealBot_Globals.Tooltip_SetAlpha=nil
                        else
                            HealBot_Globals.Tooltip_Alpha=HealBot_Globals.Tooltip_SetAlphaValue or 1
                        end
                    end
                end
                if tonumber(tPatch)==0 or (tonumber(tPatch)<8 and tonumber(tHealbot)<4) then
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Buffs_IconSet) do
                        if type(id)=="number" and not HealBot_Globals.HealBot_Custom_Buffs[id] then
                            HealBot_Globals.HealBot_Custom_Buffs_IconSet[id]=nil
                        end
                    end
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Buffs_IconGlow) do
                        if type(id)=="number" and not HealBot_Globals.HealBot_Custom_Buffs[id] then
                            HealBot_Globals.HealBot_Custom_Buffs_IconGlow[id]=nil
                        end
                    end
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Debuffs_IconSet) do
                        if type(id)=="number" and not HealBot_Globals.HealBot_Custom_Debuffs[id] then
                            HealBot_Globals.HealBot_Custom_Debuffs_IconSet[id]=nil
                        end
                    end
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Debuffs_IconGlow) do
                        if type(id)=="number" and not HealBot_Globals.HealBot_Custom_Debuffs[id] then
                            HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[id]=nil
                        end
                    end
                end
                if not HealBot_Globals.WatchHoT["EVOK"] then HealBot_Globals.WatchHoT["EVOK"]={} end
                if not HealBot_Globals.WatchHoT["EVOK"][HEALBOT_REVERSION] then
                    local HealBot_EvokHoTClass=HealBot_GlobalsDefaults.WatchHoT["EVOK"]
                    for id,x  in pairs(HealBot_EvokHoTClass) do
                        HealBot_Globals.WatchHoT["EVOK"][id]=x
                    end
                end
                if type(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC])~="number" then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=4
                end
                if type(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"])~="number" then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"]=4
                end
                for id,_  in pairs(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol) do
                    if type(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[id])~="number" then
                        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[id]=4
                    end
                end
                for id,_  in pairs(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol) do
                    if type(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[id])~="number" then
                        HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[id]=4
                    end
                end
            end
            if tonumber(tMinor)<2 and tonumber(tMinor)==0 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    for f=1,10 do
                        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]>2 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]+1
                        end
                        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]>5 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]+3
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]>4 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]+2
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]>2 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]+1
                        end
                        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]>6 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]+3
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]>5 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]+2
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]>3 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]+1
                        end
                        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["IC"]>2 then
                            Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["IC"]=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["IC"]+2
                        end
                        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["AC"]>2 then
                            Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["AC"]=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["AC"]+2
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["NAME"]>2 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["NAME"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["NAME"]+1
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]>2 and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]<6 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]+1
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["STATE"]>2 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["STATE"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["STATE"]+1
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["AGGRO"]>2 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["AGGRO"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["AGGRO"]+1
                        end
                        if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Skins[x]][f]["BARCOL"]>2 then
                            Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Skins[x]][f]["BARCOL"]=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Skins[x]][f]["BARCOL"]+1
                        end
                        for z=1,9 do
                            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Skins[x]][z][f]["COLOUR"]==3 then
                                Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Skins[x]][z][f]["COLOUR"]=4
                            end
                            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Skins[x]][z][f]["COLTYPE"]==3 then
                                Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Skins[x]][z][f]["COLTYPE"]=4
                            end
                        end
                    end
                end
            end
            if tonumber(tMinor)<2 or (tonumber(tMinor)==2 and tonumber(tPatch)==0) then
                if not HealBot_Globals.SwitchAllowPlayerRoles then
                    HealBot_Globals.SwitchAllowPlayerRoles=true
                    HealBot_Globals.AllowPlayerRoles=true
                end
            end
            if HealBot_Globals.InHealAbsorbDiv then
                HealBot_Globals.AbsorbDiv=HealBot_Globals.InHealAbsorbDiv
                HealBot_Globals.InHealDiv=HealBot_Globals.InHealAbsorbDiv
                HealBot_Globals.InHealAbsorbDiv=nil
            end
        end
        if not HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"] then
            HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"]=4
        end
        if not HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol["DEFAULT"] then
            HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol["DEFAULT"]=4
        end
        if HealBot_Globals.UltraPerf~=nil then
            if HealBot_Globals.UltraPerf then
                HealBot_Globals.PerfMode=3
            end
            HealBot_Globals.UltraPerf=nil
        end
        HealBot_Update_BuffsForSpec("Debuff")
        if not HealBot_Globals.OverrideColours["TANK"] then HealBot_Skins_SetRoleCol(nil, "TANK", true) end         -- This is old when 10.0 is old.
        if not HealBot_Globals.OverrideColours["HEALER"] then HealBot_Skins_SetRoleCol(nil, "HEALER", true) end
        if not HealBot_Globals.OverrideColours["DAMAGER"] then HealBot_Skins_SetRoleCol(nil, "DAMAGER", true) end
        if not HealBot_Globals.OverrideColours["DEMO"] then HealBot_Skins_SetClassCol(nil, "DEMO", true) end
        if not HealBot_Globals.OverrideColours["DRUI"] then HealBot_Skins_SetClassCol(nil, "DRUI", true) end
        if not HealBot_Globals.OverrideColours["HUNT"] then HealBot_Skins_SetClassCol(nil, "HUNT", true) end
        if not HealBot_Globals.OverrideColours["MAGE"] then HealBot_Skins_SetClassCol(nil, "MAGE", true) end
        if not HealBot_Globals.OverrideColours["MONK"] then HealBot_Skins_SetClassCol(nil, "MONK", true) end
        if not HealBot_Globals.OverrideColours["PALA"] then HealBot_Skins_SetClassCol(nil, "PALA", true) end
        if not HealBot_Globals.OverrideColours["PRIE"] then HealBot_Skins_SetClassCol(nil, "PRIE", true) end
        if not HealBot_Globals.OverrideColours["ROGU"] then HealBot_Skins_SetClassCol(nil, "ROGU", true) end
        if not HealBot_Globals.OverrideColours["SHAM"] then HealBot_Skins_SetClassCol(nil, "SHAM", true) end
        if not HealBot_Globals.OverrideColours["WARL"] then HealBot_Skins_SetClassCol(nil, "WARL", true) end
        if not HealBot_Globals.OverrideColours["DEAT"] then HealBot_Skins_SetClassCol(nil, "DEAT", true) end
        if not HealBot_Globals.OverrideColours["WARR"] then HealBot_Skins_SetClassCol(nil, "WARR", true) end
        if not HealBot_Globals.OverrideColours["EVOK"] then HealBot_Skins_SetClassCol(nil, "EVOK", true) end
        if not HealBot_Globals.OverrideColours["MANA"] then HealBot_Skins_SetPowerCol(nil, "MANA", true) end
        if not HealBot_Globals.OverrideColours["RAGE"] then HealBot_Skins_SetPowerCol(nil, "RAGE", true) end
        if not HealBot_Globals.OverrideColours["FOCUS"] then HealBot_Skins_SetPowerCol(nil, "FOCUS", true) end
        if not HealBot_Globals.OverrideColours["ENERGY"] then HealBot_Skins_SetPowerCol(nil, "ENERGY", true) end
        if not HealBot_Globals.OverrideColours["RUNIC_POWER"] then HealBot_Skins_SetPowerCol(nil, "RUNIC_POWER", true) end
        if not HealBot_Globals.OverrideColours["INSANITY"] then HealBot_Skins_SetPowerCol(nil, "INSANITY", true) end
        if not HealBot_Globals.OverrideColours["LUNAR_POWER"] then HealBot_Skins_SetPowerCol(nil, "LUNAR_POWER", true) end
        if not HealBot_Globals.OverrideColours["MAELSTROM"] then HealBot_Skins_SetPowerCol(nil, "MAELSTROM", true) end
        if not HealBot_Globals.OverrideColours["FURY"] then HealBot_Skins_SetPowerCol(nil, "FURY", true) end
        if not HealBot_Globals.OverrideEffects["HEALTHDROPTIME"] then HealBot_Globals.OverrideEffects["HEALTHDROPTIME"]=3 end
        if not HealBot_Globals.OverrideEffects["HEALTHDROPCANCEL"] then HealBot_Globals.OverrideEffects["HEALTHDROPCANCEL"]=200 end
        if not HealBot_Globals.OverrideColours["USEADAPTIVE"] then HealBot_Globals.OverrideColours["USEADAPTIVE"]=1 end
        HealBot_Globals.LastVersionSkinUpdate=HealBot_Global_Version()
    else
        HealBot_Skins_Check(Healbot_Config_Skins.Current_Skin)
    end

    if HealBot_Config.LastVersionUpdate then HealBot_Config.LastVersionUpdate=nil end
    
    if not HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_BLEED_en] then HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_BLEED_en]=9 end -- This is old when 10.2 is old.
    if not HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en] then -- This is old when 10.2 is old.
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en]={}
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en].R=0.58
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en].G=0.02
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en].B=0.02
    end
    for x=1,5 do -- This is old when 10.2 is old.
        if not HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(x)] then
            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(x)]=HEALBOT_WORDS_NONE
        end
        if not HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(x)] then
            HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(x)]=1
        end
    end
    if not HealBot_Config.SpellsUpdatedToV10 then  -- When removing this check, also remove from HealBot_Action_GetComboWithSpec - This is old when 10.0 is old.
        if not HealBot_Config_Spells.EnabledKeyCombo["New"] then
            HealBot_Share_ExportSpells()
            HealBot_Config.SpellsUpdatedToV10=true
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledKeyCombo,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemyKeyCombo,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergKeyCombo,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledSpellTarget,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemySpellTarget,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergSpellTarget,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledSpellTrinket1,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemySpellTrinket1,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergSpellTrinket1,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledSpellTrinket2,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemySpellTrinket2,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergSpellTrinket2,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledAvoidBlueCursor,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemyAvoidBlueCursor,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergAvoidBlueCursor,5)
            HealBot_Share_LoadSpells(HealBot_Options_ShareSpellsExternalEditBox:GetText())
            HealBot_Options_ShareSpellsExternalEditBox:SetText("")
            StaticPopupDialogs["SpellsUpdatedToV10"] = {
                text = "HealBot\n\nCharacter spells have been updated\nCheck the spells tab\n\nOpen options now?",
                    button1 = HEALBOT_WORDS_YES,
                    button2 = HEALBOT_WORDS_NO,
                    OnAccept = function()
                        HealBot_Options_ShowHide()
                    end,
                    timeout = 0,
                    whileDead = 1,
                    hideOnEscape = 1
            };
            StaticPopup_Show("SpellsUpdatedToV10");
        else
            HealBot_Config.SpellsUpdatedToV10=true
        end
    end
      --HealBot_setCall("HealBot_Update_Skins")
end

function HealBot_UpdateSpellsOnVersionChange(combo,maxButtons)
    local button,newKey,oldKey=nil,nil,nil
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    for x=1,4 do
        for z=1,maxButtons do
            button = HealBot_Options_ComboClass_Button(z)
            for y=1, getn(HealBot_Keys_List), 1 do
                newKey=HealBot_Action_GetComboWithSpec(HealBot_Keys_List[y], button, x)
                oldKey=HealBot_Keys_List[y]..button..x
                if combo[oldKey] then
                    if not combo[newKey] then combo[newKey]=combo[oldKey] end
                end
                combo[oldKey]=nil
            end
        end
    end
end

function HealBot_setTooltipUpdateInterval()
    if not HealBot_Data["TIPUSE"] then
        HealBot_luVars["TipUpdateFreq"]=900
    else
        HealBot_luVars["TipUpdateFreq"]=0.058
    end
      --HealBot_setCall("HealBot_setTooltipUpdateInterval")
end

function HealBot_IsUnitDead(button)
    if (UnitIsDeadOrGhost(button.unit) or HealBot_Aura_CurrentBuff(button.guid, HEALBOT_SPIRIT_OF_REDEMPTION_NAME)) and not UnitIsFeignDeath(button.unit) then
        return true
    else
        return false
    end
end

function HealBot_SetPlayerData()
    local pClass, pClassEN=UnitClass("player")
    HealBot_Data["PCLASSTRIM"]=strsub(pClassEN,1,4)
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    local pRace, pRaceEN=UnitRace("player")
    HealBot_Data["PRACE_EN"]=pRaceEN
    if UnitIsDeadOrGhost("player") and not UnitIsFeignDeath("player") then 
        HealBot_Data["PALIVE"]=false
    else
        HealBot_Data["PALIVE"]=true
    end
    HealBot_Data["POWERTYPE"]=UnitPowerType("player") or 0
    if HealBot_Data["POWERTYPE"]<0 or HealBot_Data["POWERTYPE"]>9 then HealBot_Data["POWERTYPE"]=0 end
    HealBot_Data["PGUID"]=UnitGUID("player")
    if HealBot_Data["PGUID"] and HealBot_Data["PCLASSTRIM"] and HealBot_Data["PLEVEL"] and HealBot_Data["PRACE_EN"] and HealBot_Data["POWERTYPE"] then
        HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
        HealBot_Timers_Set("PLAYER","SaveProfile",5)
    else
        HealBot_Timers_Set("LAST","SetPlayerData",1)
        HealBot_AddDebug("RECALL SetPlayerData")
    end
end

function HealBot_ReloadAddon()
    if HealBot_luVars["VarsLoaded"] then
        HealBot_luVars["Loaded"]=false
        HealBot_luVars["AddonLoaded"]=false
        HealBot_luVars["VarsLoaded"]=false
        HealBot_OnEvent_AddOnLoaded("HealBot")
        HealBot_VariablesLoaded()
    else
        C_Timer.After(1, HealBot_ReloadAddon)
    end
end

function HealBot_OnEvent_AddOnLoaded(addonName)
    if addonName=="HealBot" and not HealBot_luVars["AddonLoaded"] then
        HealBot_Timers_Lang()
        HealBot_globalVars()
        HealBot_Lang_InitVars()
        HealBot_Data_InitVars()
        HealBot_Panel_Init()
        table.foreach(HealBot_ConfigDefaults, function (key,val)
            if HealBot_Config[key]==nil then
                HealBot_Config[key] = val;
            end
        end);
        table.foreach(HealBot_GlobalsDefaults, function (key,val)
            if HealBot_Globals[key]==nil then
                HealBot_Globals[key] = val;
            end
        end);
        table.foreach(HealBot_Config_SkinsDefaults, function (key,val)
            if Healbot_Config_Skins[key]==nil then
                Healbot_Config_Skins[key] = val;
            end
        end);
        HealBot_Action_InitFrames()
        table.foreach(HealBot_Config_SpellsDefaults, function (key,val)
            if HealBot_Config_Spells[key]==nil then
                HealBot_Config_Spells[key] = val;
            end
        end);
        table.foreach(HealBot_Config_BuffsDefaults, function (key,val)
            if HealBot_Config_Buffs[key]==nil then
                HealBot_Config_Buffs[key] = val;
            end
        end);
        table.foreach(HealBot_Config_CuresDefaults, function (key,val)
            if HealBot_Config_Cures[key]==nil then
                HealBot_Config_Cures[key] = val;
            end
        end);
        for x=1,3 do
            for z=0,3 do
                HealBot_luVars["FPS"][x][z]=HealBot_Globals.FPS
            end
        end
        if HealBot_Config.CurrentLoutout then
            HealBot_Config.CurrentLoadout=HealBot_Config.CurrentLoutout
            HealBot_Config.CurrentLoutout=nil
            HealBot_Config.LastLoadout=HealBot_Config.CurrentLoadout
        end
        HealBot_luVars["FPS"][0]=HealBot_Globals.FPS
        C_ChatInfo.RegisterAddonMessagePrefix(HEALBOT_HEALBOT)
        HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
        HealBot_SetToolTip(HealBot_ScanTooltip)
        local g
        for x=1,8 do
            HealBot_ScanTooltip:AddDoubleLine(" "," ",1,1,1,1,1,1)
            g=_G["HealBot_ScanTooltipTextLeft"..x]
            g:SetFont(HealBot_Default_Fonts[15].file, 12)
            g=_G["HealBot_ScanTooltipTextRight"..x]
            g:SetFont(HealBot_Default_Fonts[15].file, 12)
        end
        if HealBot_Config.LastLoadout==0 then HealBot_Action_UpdateLoadoutId() end
        HealBot_Config.LastAutoSkinChangeTime=0
        HealBot_Timers_Set("LAST","SetAutoClose", 12)
        HealBot_Timers_Set("LAST","LoadTips", 2)
        HealBot:SetScript("OnUpdate", HealBot_OnUpdate)
        HealBot_luVars["AddonLoaded"]=true
    end
end

HealBot_luVars["WaitedOnAddonLoaded"]=false
function HealBot_OnEvent_VariablesLoaded()
    if HealBot_luVars["AddonLoaded"] then
        HealBot_VariablesLoaded()
    elseif not HealBot_luVars["WaitedOnAddonLoaded"] then
        HealBot_luVars["WaitedOnAddonLoaded"]=true
        C_Timer.After(0.5, HealBot_OnEvent_VariablesLoaded)
    else
        C_Timer.After(1, HealBot_FullReload)
    end
end

function HealBot_VariablesLoaded()
    HealBot_SetPlayerData()
    if LSM then
        for i = 1, #HealBot_Default_Textures do
            LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
        end
        for i = 1, #HealBot_Default_Sounds do
            LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
        end
        for i = 1, #HealBot_Default_Fonts do
            LSM:Register("font", HealBot_Default_Fonts[i].name, HealBot_Default_Fonts[i].file)
        end
    end
    HealBot_globalVars()
    HealBot_Lang_InitVars()
    HealBot_Data_InitVars()
    HealBot_Options_InitVars()
    HealBot_Include_Skin(HEALBOT_SKINS_STD, true)
    if HealBot_Globals.FirstLoad then
        HealBot_Include_Skin(HEALBOT_OPTIONS_GROUPHEALS, true)
        HealBot_Include_Skin(HEALBOT_OPTIONS_RAID25, true)
        HealBot_Include_Skin(HEALBOT_OPTIONS_RAID40, true)
    end
    HealBot_Update_Skins()
    HealBot_Data["PGUID"]=UnitGUID("player") or "x"
    HealBot_Options_setClassEn()
    HealBot_Options_setLists()
    HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
    HealBot_setTooltipUpdateInterval()
    HealBot_Panel_InitOptBars()
    HealBot_luVars["CPUProfilerOn"]=GetCVarBool("scriptProfile")
    HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
    HealBot_Options_IgnoreDebuffsDuration_setAura()
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_Text_sethbNumberFormat()
    HealBot_Text_sethbAggroNumberFormat()
    HealBot_Options_SetFrames()
    HealBot_Init_ClassicSpecs()
    HealBot_Load()
    HealBot_luVars["VarsLoaded"]=true
      --HealBot_setCall("HealBot_OnEvent_VariablesLoaded")
end

function HealBot_OnEvent_ItemInfoReceived(self, itemId)
    HealBot_luVars["ItemDataReady"]=true
    HealBot_Timers_Set("PLAYER","InitSmartCast",1)
end

function HealBot_CheckLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.mana.lowcheck=true
    end
      --HealBot_setCall("HealBot_CheckLowMana")
end

function HealBot_UpdateAllEmergBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.status.emergupd=true
    end
      --HealBot_setCall("HealBot_CheckLowMana")
end

function HealBot_GetSpec(unit)
    local s,i=nil,nil
    if UnitExists(unit) then
        i = GetInspectSpecialization(unit)
        if i then
            _, s, _, _, _, _ = GetSpecializationInfoByID(i)
        end
    end
    return i,s
end

function HealBot_UpdateSpellsOnSpecChange(combo,maxButtons,cType)
    local button,newKey,oldKey=nil,nil,nil
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    for z=1,maxButtons do
        button = HealBot_Options_ComboClass_Button(z)
        for y=1, getn(HealBot_Keys_List), 1 do
            newKey=HealBot_Action_GetComboWithSpec(HealBot_Keys_List[y], button, HealBot_luVars["CurrentSpec"])
            oldKey=HealBot_Keys_List[y]..button..HealBot_Config.CurrentSpec..HealBot_Config.CurrentLoadout
            if not combo[newKey] and combo[oldKey] then --and HealBot_Options_ProfileSpellCheck(combo[oldKey],cType) then
                --combo[newKey]=combo[oldKey]
                HealBot_Action_SetSpell(cType, newKey, combo[oldKey])
            end
        end
    end
end

function HealBot_ResetOnSpecChange()
    if HealBot_Config.CurrentLoadout~=HealBot_Config.LastLoadout or HealBot_Config.CurrentSpec~=HealBot_luVars["CurrentSpec"] then
        HealBot_UpdateSpellsOnSpecChange(HealBot_Config_Spells.EnabledKeyCombo,20,"ENABLED")
        HealBot_UpdateSpellsOnSpecChange(HealBot_Config_Spells.EnemyKeyCombo,20,"ENEMY")
        HealBot_UpdateSpellsOnSpecChange(HealBot_Config_Spells.EmergKeyCombo,5,"EMERG")
        HealBot_Config.CurrentSpec=HealBot_luVars["CurrentSpec"] or 1
        HealBot_Config.CurrentLoadout=HealBot_Config.LastLoadout
        if HealBot_Config.Profile==3 and HealBot_Class_Spells["GLOBAL"] then
            local globalSpells=HealBot_Class_Spells["GLOBAL"]
            HealBot_Options_hbProfile_setGlobalSpells(HealBot_Config_Spells.EnabledKeyCombo, globalSpells.EnabledKeyCombo, 20, "ENABLED")
            HealBot_Options_hbProfile_setGlobalSpells(HealBot_Config_Spells.EnemyKeyCombo, globalSpells.EnemyKeyCombo, 20, "ENEMY")
            HealBot_Options_hbProfile_setGlobalSpells(HealBot_Config_Spells.EmergKeyCombo, globalSpells.EmergKeyCombo, 5, "EMERG")
        end
        HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
        HealBot_Timers_Set("PLAYER","CheckSpellsValid",0.25)
        HealBot_ActionIcons_LoadSpec(true)
    end
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    HealBot_Timers_InitSpells()
    HealBot_Timers_Set("INIT","SpellsResetTabs")
    HealBot_Timers_Set("AURA","ConfigClassHoT")
    HealBot_Timers_AuraReset()
end

function HealBot_GetTalentInfo(button)
    local i,s=nil,nil
    if HEALBOT_GAME_VERSION>5 then
        if button.player then
            i = GetSpecialization()
            if i then
                _, s, _, _, _, _ = GetSpecializationInfo(i,false,false) 
            end
        elseif HealBot_luVars["inspectGUID"]==button.guid then
            i,s = HealBot_GetSpec(button.unit)
        end
    elseif HEALBOT_GAME_VERSION>2 then
        local tCount, mCount, isNotPlayer, canInspect= 0, 0, true, false
        if UnitIsUnit(button.unit, "player") then
            isNotPlayer=false
            canInspect=true
        elseif button.isplayer and UnitExists(button.unit) and UnitInRange(button.unit) and UnitGUID(button.unit)==button.guid and HealBot_luVars["inspectGUID"]==button.guid and CanInspect(button.unit) then
            canInspect=true
        end
        if canInspect then
            local group=GetActiveTalentGroup(isNotPlayer)
            for tab = 1, 3 do
                tCount = select(3, GetTalentTabInfo(tab,isNotPlayer,nil,group))
                if tCount > mCount then
                    i = tab
                    mCount = tCount
                end
            end
            if i then
                s=HealBot_Init_retSpec(button.text.classtrim,i)
            end
        end
    elseif button.player then
        i=1
    end
    if button.player then
        button.specupdate=0
        if i then
            HealBot_Action_UpdateLoadoutId()
            if HealBot_Config.CurrentLoadout~=HealBot_Config.LastLoadout or HealBot_Config.CurrentSpec~=i or HealBot_Data["PLEVEL"]~=UnitLevel("player") then
                HealBot_luVars["CurrentSpec"]=i
                HealBot_Timers_Set("PLAYER","SpecUpdate",0.25)
            end
            if s then
                HealBot_Config.Spec=s
            end
        end
    end
    if s then
        if button.unit=="target" then
            button.spec = " "..s.." " 
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        elseif button.spec~=" "..s.." " then
            if HealBot_Panel_RaidUnitGUID(button.guid) then 
                HealBot_Action_setGuidSpec(button, s)
                HealBot_Comms_SendInstantAddonMsg("U:"..button.guid.."~"..s)
            else
                button.spec = " "..s.." "
            end
            HealBot_Action_setButtonManaBarCol(button)
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        end
    end
    HealBot_OnEvent_UnitMana(button)
      --HealBot_setCall("HealBot_GetTalentInfo")
end

function HealBot_ResetClassIconTexture()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
end

function HealBot_InitPlugins()
    local loaded, reason = LoadAddOn("HealBot_Plugin_Threat")
    HealBot_luVars["pluginThreatReason"]=reason or ""
    HealBot_luVars["pluginThreatLoaded"]=loaded
    if loaded and HealBot_Globals.PluginThreat then 
        HealBot_Plugin_Threat_Init()
        HealBot_Aggro_setLuVars("pluginThreat", true)
        HealBot_luVars["pluginThreat"]=true
        HealBot_Action_setLuVars("pluginThreat", true)
        HealBot_Timers_setLuVars("pluginThreat", true)
    else
        HealBot_Aggro_setLuVars("pluginThreat", false)
        HealBot_luVars["pluginThreat"]=false
        HealBot_Action_setLuVars("pluginThreat", false)
        HealBot_Timers_setLuVars("pluginThreat", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_TimeToDie")
    HealBot_luVars["pluginTimeToDieReason"]=reason or ""
    HealBot_luVars["pluginTimeToDieLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToDie then 
        HealBot_Plugin_TimeToDie_Init()
        HealBot_luVars["pluginTimeToDie"]=true
        HealBot_Action_setLuVars("pluginTimeToDie", true)
        HealBot_Timers_setLuVars("pluginTimeToDie", true)
    else
        HealBot_luVars["pluginTimeToDie"]=false
        HealBot_Action_setLuVars("pluginTimeToDie", false)
        HealBot_Timers_setLuVars("pluginTimeToDie", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_TimeToLive")
    HealBot_luVars["pluginTimeToLiveReason"]=reason or ""
    HealBot_luVars["pluginTimeToLiveLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToLive then 
        HealBot_Plugin_TimeToLive_Init()
        HealBot_luVars["pluginTimeToLive"]=true
        HealBot_Action_setLuVars("pluginTimeToLive", true)
        HealBot_Timers_setLuVars("pluginTimeToLive", true)
    else
        HealBot_luVars["pluginTimeToLive"]=false
        HealBot_Action_setLuVars("pluginTimeToLive", false)
        HealBot_Timers_setLuVars("pluginTimeToLive", false)
    end
        
    loaded, reason = LoadAddOn("HealBot_Plugin_ExtraButtons")
    HealBot_luVars["pluginExtraButtonsReason"]=reason or ""
    HealBot_luVars["pluginExtraButtonsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginExtraButtons then 
        HealBot_luVars["pluginExtraButtons"]=true
        HealBot_Action_setLuVars("pluginExtraButtons", true)
        HealBot_Timers_Set("OOC","RegisterForClicks")
    else
        HealBot_luVars["pluginExtraButtons"]=false
        HealBot_Action_setLuVars("pluginExtraButtons", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_CombatProt")
    HealBot_luVars["pluginCombatProtReason"]=reason or ""
    HealBot_luVars["pluginCombatProtLoaded"]=loaded
    if loaded and HealBot_Globals.PluginCombatProt then 
        HealBot_Plugin_CombatProt_Init()
        HealBot_luVars["pluginCombatProt"]=true
        HealBot_Timers_setLuVars("pluginCombatProt", true)
    else
        HealBot_luVars["pluginCombatProt"]=false
        HealBot_Globals.UseCrashProt=false
        HealBot_Timers_setLuVars("pluginCombatProt", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_Performance")
    HealBot_luVars["pluginPerformanceReason"]=reason or ""
    HealBot_luVars["pluginPerformanceLoaded"]=loaded
    if loaded and HealBot_Globals.PluginPerformance then 
        HealBot_Plugin_Performance_Init()
        HealBot_luVars["pluginPerformance"]=true
        HealBot_Timers_setLuVars("pluginPerformance", true)
    else
        HealBot_luVars["pluginPerformance"]=false
        HealBot_Timers_setLuVars("pluginPerformance", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_Tweaks")
    HealBot_luVars["pluginTweaksReason"]=reason or ""
    HealBot_luVars["pluginTweaksLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTweaks then 
        HealBot_Plugin_Tweaks_Init()
        HealBot_luVars["pluginTweaks"]=true
        HealBot_Timers_setLuVars("pluginTweaks", true)
    else
        HealBot_luVars["pluginTweaks"]=false
        HealBot_Timers_setLuVars("pluginTweaks", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_Requests")
    HealBot_luVars["pluginRequestsReason"]=reason or ""
    HealBot_luVars["pluginRequestsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginRequests then 
        HealBot_Plugin_Requests_Init()
        HealBot_luVars["pluginRequests"]=true
    else
        HealBot_luVars["pluginRequests"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_AuraWatch")
    HealBot_luVars["pluginAuraWatchReason"]=reason or ""
    HealBot_luVars["pluginAuraWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginAuraWatch then 
        HealBot_Plugin_AuraWatch_Init()
        HealBot_luVars["pluginAuraWatch"]=true
    else
        HealBot_luVars["pluginAuraWatch"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_HealthWatch")
    HealBot_luVars["pluginHealthWatchReason"]=reason or ""
    HealBot_luVars["pluginHealthWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginHealthWatch then 
        HealBot_Plugin_HealthWatch_Init()
        HealBot_Action_setLuVars("pluginHealthWatch", true)
        HealBot_luVars["pluginHealthWatch"]=true
        HealBot_Timers_setLuVars("pluginHealthWatch", true)
    else
        HealBot_Action_setLuVars("pluginHealthWatch", false)
        HealBot_luVars["pluginHealthWatch"]=false
        HealBot_Timers_setLuVars("pluginHealthWatch", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_ManaWatch")
    HealBot_luVars["pluginManaWatchReason"]=reason or ""
    HealBot_luVars["pluginManaWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginManaWatch then 
        HealBot_Plugin_ManaWatch_Init()
        HealBot_luVars["pluginManaWatch"]=true
        HealBot_Timers_setLuVars("pluginManaWatch", true)
    else
        HealBot_luVars["pluginManaWatch"]=false
        HealBot_Timers_setLuVars("pluginManaWatch", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_MyCooldowns")
    HealBot_luVars["pluginMyCooldownsReason"]=reason or ""
    HealBot_luVars["pluginMyCooldownsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginMyCooldowns then 
        HealBot_Plugin_MyCooldowns_Init()
        HealBot_luVars["pluginMyCooldowns"]=true
        HealBot_Timers_setLuVars("pluginMyCooldowns", true)
    else
        HealBot_luVars["pluginMyCooldowns"]=false
        HealBot_Timers_setLuVars("pluginMyCooldowns", false)
    end

    HealBot_Timers_Set("LAST","RegAggro")
end

function HealBot_Timer_FramesRefresh()
    if not HealBot_luVars["ProcessRefresh"] then
        if HealBot_luVars["ProcessRefreshTime"]<=HealBot_TimeNow then
            HealBot_luVars["ProcessRefreshTime"]=HealBot_TimeNow+0.2
            HealBot_luVars["ProcessRefreshDelay"]=false
            HealBot_luVars["ProcessRefresh"]=true
            HealBot_ProcessRefreshTypes()
        elseif not HealBot_luVars["ProcessRefreshDelay"] then
            HealBot_luVars["ProcessRefreshDelay"]=true
            C_Timer.After(((HealBot_luVars["ProcessRefreshTime"]+0.125)-HealBot_TimeNow), HealBot_Timer_FramesRefresh)
        end
    end
end

function HealBot_Timer_TogglePartyFrames()
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDEPARTYF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["PARTY"]=true
            HealBot_Options_DisableEnablePartyFrame(false)
            HealBot_Options_PlayerTargetFrames:Enable()
            if HealBot_luVars["HIDEPTF"] then
                HealBot_trackHiddenFrames["PLAYER"]=true
                HealBot_Options_DisableEnablePlayerFrame(false)
                HealBot_Options_DisableEnablePetFrame(false)
                HealBot_Options_DisableEnableTargetFrame(false)
            elseif HealBot_trackHiddenFrames["PLAYER"] then 
                HealBot_trackHiddenFrames["PLAYER"]=false
                HealBot_Options_DisableEnablePlayerFrame(true)
                HealBot_Options_DisableEnablePetFrame(true)
                HealBot_Options_DisableEnableTargetFrame(true)
            end
        elseif HealBot_trackHiddenFrames["PARTY"] then
            HealBot_trackHiddenFrames["PARTY"]=false
            HealBot_Options_DisableEnablePartyFrame(true)
            HealBot_Options_PlayerTargetFrames:Disable()
            if HealBot_trackHiddenFrames["PLAYER"] then 
                HealBot_trackHiddenFrames["PLAYER"]=false
                HealBot_Options_DisableEnablePlayerFrame(true)
                HealBot_Options_DisableEnablePetFrame(true)
                HealBot_Options_DisableEnableTargetFrame(true)
            end
        end
    else
        HealBot_Timers_Set("OOC","TogglePartyFrames")
    end
end

function HealBot_Timer_ToggleFocusFrame()
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDEFOCUSF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["FOCUS"]=true
            HealBot_Options_DisableEnableFocusFrame(false)
        elseif HealBot_trackHiddenFrames["FOCUS"] then
            HealBot_trackHiddenFrames["FOCUS"]=false
            HealBot_Options_DisableEnableFocusFrame(true)
        end
    else
        HealBot_Timers_Set("OOC","ToggleFocusFrame")
    end
end

function HealBot_Timer_ToggleMiniBossFrames()
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDEBOSSF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableEnableMiniBossFrame(false)
        elseif HealBot_trackHiddenFrames["MINIBOSS"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=false
            HealBot_Options_DisableEnableMiniBossFrame(true)
        end
    else
        HealBot_Timers_Set("OOC","ToggleMiniBossFrames")
    end
end

function HealBot_Timer_ToggleRaidFrames()
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDERAIDF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["RAID"]=true
            HealBot_Options_DisableEnableRaidFrame(false)
        elseif HealBot_trackHiddenFrames["RAID"] then
            HealBot_trackHiddenFrames["RAID"]=false
            HealBot_Options_DisableEnableRaidFrame(true)
        end
    else
        HealBot_Timers_Set("OOC","ToggleRaidFrames")
    end
end

function HealBot_CheckVersions()
    if not HealBot_luVars["GetVersions"] then HealBot_luVars["GetVersions"]=HealBot_TimeNow+15 end
    HealBot_SendVersion()
    if HealBot_luVars["DoSendGuildVersion"] then
        HealBot_SendGuildVersion()
        HealBot_luVars["DoSendGuildVersion"]=false
    end
end

function HealBot_SendVersion()
    if not HealBot_luVars["SendVersion"] then HealBot_luVars["SendVersion"]=HealBot_TimeNow+10 end
end

function HealBot_SendGuildVersion()
    if not HealBot_luVars["SendGuildVersion"] then HealBot_luVars["SendGuildVersion"]=HealBot_TimeNow+10 end
end

function HealBot_ZoneType()
    local inInst,inType = IsInInstance()
    if inInst==nil then inInst=false end
    if not inType then inType="None" end
    return inInst,inType
end

function HealBot_Timer_ZoneUpdate()
    local inInst,inType = HealBot_ZoneType()
    HealBot_Comms_SendTo(inInst,inType)
    if HealBot_luVars["InInstance"]~=inInst then
        HealBot_luVars["InInstance"]=inInst
        HealBot_Timers_Set("LAST","CheckVersions",5)
        if HealBot_Config_Buffs.ExtraBuffsOnlyInInstance then
            HealBot_Timers_Set("LAST","InitItemsData")
        end
        HealBot_ActionIcons_InstanceState(inInst)
        if HealBot_luVars["auraWatchNotifyZone"] then
            C_Timer.After(0.1, function() HealBot_Plugin_AuraWatch_ValidateZone(inInst) end)
        end
    end
    if HEALBOT_GAME_VERSION<9 then
        HealBot_Aura_SetBossHealth(inInst)
    end
        
    local mapAreaID = C_Map.GetBestMapForUnit("player")
    local mapName=HEALBOT_WORD_OUTSIDE
    if mapAreaID and mapAreaID>0 then
        mapName=C_Map.GetMapInfo(mapAreaID).name or mapName
        HealBot_luVars["mapAreaID"]=mapAreaID 
    elseif inType and inType=="arena" then 
        mapName="Arena"
    end
    if HealBot_luVars["mapName"]~=mapName then
        HealBot_luVars["mapName"]=mapName
        HealBot_Aura_setLuVars("mapName", mapName)
        HealBot_Options_setLuVars("mapName", mapName)
        HealBot_Options_SetEnableDisableCDBtn()
        HealBot_Options_SetEnableDisableBuffBtn()
        HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
    end
    HealBot_Panel_setLuVars("MAPID", mapAreaID)
    HealBot_Timers_Set("PLAYER","PlayerCheck")
end

function HealBot_Timer_EmoteOOM()
    if HealBot_luVars["NoSpamOOM"]<HealBot_TimeNow and 
      (((UnitPower("player", 0)/UnitPowerMax("player", 0))*100) < HealBot_luVars["EOCOOMV"]) then
        HealBot_luVars["NoSpamOOM"]=HealBot_TimeNow+15
        DoEmote(HEALBOT_EMOTE_OOM)
    end
end

local hbCombatState=false
function HealBot_UnitAffectingCombat(button)
    if button.isplayer and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWCOMBAT"] then
        hbCombatState=UnitAffectingCombat(button.unit)
    else
        hbCombatState=false
    end
    if button.status.incombat~=hbCombatState then
        button.status.incombat=hbCombatState
        HealBot_Aura_UpdateState(button)
    end
end

function HealBot_ValidLivingEnemy(pUnit, eUnit)
    if UnitExists(pUnit) and UnitExists(eUnit) and not UnitIsFriend("player", eUnit) and UnitHealthMax(eUnit)>99 and
       UnitHealth(eUnit)>(UnitHealthMax(eUnit)/20) then
        return true
    end
    return false
end

function HealBot_OnEvent_UnitThreat(button)
    if UnitAffectingCombat(button.unit) then
        if HealBot_luVars["UpdateEnemyFrame"] and not HealBot_Data["UILOCK"] and HealBot_Data["PALIVE"] then
            if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["UNITINCOMBAT"]>1 and button.status.range>0 and 
               HealBot_ValidLivingEnemy(button.unit, button.unit.."target") and UnitIsUnit(button.unit, button.unit.."targettarget") then
                if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["UNITINCOMBAT"]==3 then
                    HealBot_OnEvent_PlayerRegenDisabled()
                else
                    HealBot_UnitInCombat()
                end
            end
        end
        HealBot_CalcThreat(button)
    end
      --HealBot_setCall("HealBot_OnEvent_UnitThreat")
end

function HealBot_Clear_HealthDropAuxBar(button)
    if button.status.lasthealthdrop<HealBot_TimeNow then
        HealBot_Aux_ClearHealthDropBar(button)
        if HealBot_AuxAssigns["NameOverlayHealthDrop"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 2, false)
        end
        if HealBot_AuxAssigns["HealthOverlayHealthDrop"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 2, false)
        end
    else
        C_Timer.After((button.status.lasthealthdrop-HealBot_TimeNow)+0.05, function() HealBot_Clear_HealthDropAuxBar(button) end)
    end
end

function HealBot_Update_HealthDropAuxBar(button)
    HealBot_luVars["HealthDropBarSetCTimerSet"]=false
    if HealBot_AuxAssigns["HealthDrop"][button.frame] then
        if button.status.lasthealthdrop<HealBot_TimeNow then
            HealBot_Aux_UpdateHealthDropBar(button)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["NameOverlayHealthDrop"][button.frame] then
        if button.status.lasthealthdrop<HealBot_TimeNow then
            HealBot_Aux_UpdateNameOverLay(button, 2, true)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["HealthOverlayHealthDrop"][button.frame] then
        if button.status.lasthealthdrop<HealBot_TimeNow then
            HealBot_Aux_UpdateHealthOverLay(button, 2, true)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    
    if HealBot_luVars["HealthDropBarSetCTimerSet"] then
        C_Timer.After(0.75, function() HealBot_Clear_HealthDropAuxBar(button) end)
    end
    button.status.lasthealthdrop=HealBot_TimeNow+0.7
end

function HealBot_EnClass(unit)
  local playerClass, enClass = UnitClass(unit);
  return enClass;
end

local hbHealthWatch={}
local hbAuraWatchHealth={}
local hbActionHealthWatch={}
local hbHealthExtra={}
function HealBot_HealthExtra(guid, state)
    if state then
        hbHealthExtra[guid]=true
    elseif not hbAuraWatchHealth[guid] and not hbActionHealthWatch[guid] and not hbHealthWatch[guid] then
        hbHealthExtra[guid]=nil
    end
end

function HealBot_HealthWatch(guid, state)
    if state then
        hbHealthWatch[guid]=true
    else
        hbHealthWatch[guid]=nil
    end
    HealBot_HealthExtra(guid, state)
end

function HealBot_AuraWatchHealth(guid, state)
    if state then
        hbAuraWatchHealth[guid]=true
    else
        hbAuraWatchHealth[guid]=nil
    end
    HealBot_HealthExtra(guid, state)
end

function HealBot_ActionWatchHealth(guid, state)
    if state then
        hbActionHealthWatch[guid]=true
    else
        hbActionHealthWatch[guid]=nil
    end
    HealBot_HealthExtra(guid, state)
end

function HealBot_HealthWatchClear()
    hbHealthWatch={}
end

function HealBot_HealthWatchClear()
    hbAuraWatchHealth={}
end

local HealBot_Health80 = {
  ["DRUID"] = 15000,
  ["MAGE"] = 14000,
  ["HUNTER"] = 15000,
  ["PALADIN"] = 24000,
  ["PRIEST"] = 14000,
  ["ROGUE"] = 15000,
  ["SHAMAN"] = 14000,
  ["WARLOCK"] = 14000,
  ["WARRIOR"] = 25000,
  ["DEATHKNIGHT"] = 25000,
} 
local health,healthMax=0,0
function HealBot_UnitHealth(button)
    button.health.updhlth=false
    if button.status.current<HealBot_Unit_Status["DC"] then
        if HealBot_IsUnitDead(button) then
            healthMax=button.health.max
            health=0
            if healthMax==0 then healthMax=1 end
        else
            if HealBot_UnitInVehicle[button.unit] and UnitExists(HealBot_UnitInVehicle[button.unit]) then
                health,healthMax=UnitHealth(HealBot_UnitInVehicle[button.unit]),UnitHealthMax(HealBot_UnitInVehicle[button.unit])
                button.health.updhlth=true
            elseif UnitIsFeignDeath(button.unit) then
                health=button.health.current
                healthMax=UnitHealthMax(button.unit)
            else
                health,healthMax=UnitHealth(button.unit),UnitHealthMax(button.unit)
            end
            if health==0 then health=1 end
            if healthMax==100 and (button.unit=="target" or button.unit=="focus" or not button.isplayer) then
                local class = HealBot_EnClass(button.unit)
                if HealBot_Health80[class] and button.level>0 then
                    if button.level<75 then
                        healthMax=math.floor((HealBot_Health80[class]/150)*(button.level+(button.level/10)))
                    else
                        healthMax=math.floor((HealBot_Health80[class]/80)*(button.level+0.5))
                    end
                    health=floor((healthMax/100)*health)
                end
            end
        end
        if health>healthMax then healthMax=health end
        if (health~=button.health.current) or (healthMax~=button.health.max) then
            if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then 
                HealBot_Plugin_TimeToDie_UnitUpdate(button, health) 
            end
            if button.isplayer and not HealBot_Data["UILOCK"] then
                if HealBot_luVars["regAggro"] and health<button.health.current then
                    HealBot_OnEvent_UnitThreat(button)
                end
                if healthMax>(button.health.max*1.1) or healthMax<(button.health.max*0.9) then
                    if button.player then HealBot_Timers_Set("LAST", "SetInHealAbsorbMax") end
                    if HEALBOT_GAME_VERSION==3 then HealBot_OnEvent_SpecChange(button) end
                end
            end
            if button.frame<10 and health<button.health.current and HealBot_luVars["HealthDropPct"]<=(button.health.hpct-floor((health/healthMax)*1000))
               and not button.health.init and health>0 and (button.status.unittype<7 or HealBot_luVars["UILOCK"]) then
                button.health.hlthdrop=true
            else
                button.health.hlthdrop=false
            end
            button.health.current=health
            button.health.max=healthMax
            if button.status.current<HealBot_Unit_Status["DEAD"] then 
                if health>0 then
                    HealBot_OverHeal(button)
                else
                    HealBot_CheckUnitStatus(button)
                end
            elseif health>0 then
                HealBot_CheckUnitStatus(button)
            end
            HealBot_Action_UpdateHealthButton(button, true)
            if hbHealthExtra[button.guid] then
                if hbHealthWatch[button.guid] then
                    HealBot_Plugin_HealthWatch_UnitUpdate(button)
                end
                if hbAuraWatchHealth[button.guid] then
                    HealBot_Plugin_AuraWatch_HealthUpdate(button)
                end
                if hbActionHealthWatch[button.guid] then
                    HealBot_ActionIcons_UpdateHealth(button.guid, floor(button.health.pct*100))
                end
            end
            if button.mouseover and HealBot_Data["TIPBUTTON"] then 
                HealBot_Action_RefreshTooltip() 
            end
            if button.health.hlthdrop then
                if HealBot_luVars["UseHealthDrop"] then
                    button.hazard.hpct=button.health.hpct+HealBot_luVars["HealthDropCancelPct"]
                    if button.hazard.hpct>800 then button.hazard.hpct=800 end
                    HealBot_Action_EnableBorderHazardType(button, button.health.mixcolr, button.health.mixcolg, button.health.mixcolb, "HLTHDROP")
                end
                HealBot_Update_HealthDropAuxBar(button)
            elseif button.hazard.hlthdrop and (button.health.current==0 or button.health.hpct>button.hazard.hpct) then
                HealBot_Action_DisableBorderHazardType(button, "HLTHDROP")
            end
        end
    elseif button.health.current>0 then
        button.health.current=0
        button.status.alpha=0
        button.gref["Bar"]:SetValue(0)
        --button.health.init=true
        HealBot_OnEvent_HealsInUpdate(button)
        HealBot_OnEvent_AbsorbsUpdate(button)
        if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then 
            HealBot_Plugin_TimeToDie_UnitUpdate(button, 0) 
        end
    end
      --HealBot_setCall("HealBot_OnEvent_UnitHealth")
end

function HealBot_OnEvent_UnitHealth(button)
    if HealBot_Globals.EventQueues["HEALTH"] then
        button.health.updhlth=true
        if not HealBot_BarQueue[button.id] then
            HealBot_BarQueue[button.id]=true
            HealBot_InsertFastUnitQueue(button.id, "BAR")
        end
    else
        HealBot_UnitHealth(button)
    end
end

function HealBot_Plugin_TTDUpdate(guid)
    xButton,pButton = HealBot_Panel_RaidPetUnitButton(guid)
    if xButton and xButton.status.plugin then
        HealBot_Plugin_TimeToDie_UnitUpdate(xButton, xButton.health.current)
    elseif pButton and pButton.status.plugin then
        HealBot_Plugin_TimeToDie_UnitUpdate(pButton, pButton.health.current)
    else
        HealBot_Plugin_TTDRemoveUnit(guid)
    end
end

function HealBot_retIsInVehicle(unit)
      --HealBot_setCall("HealBot_retIsInVehicle")
    return HealBot_UnitInVehicle[unit]
end

function HealBot_UnitInVehicleUpdate(button)
    if HEALBOT_GAME_VERSION>2 then
        local vUnit=HealBot_UnitPet(button.unit)
        if vUnit and UnitHasVehicleUI(button.unit) then
            if not HealBot_UnitInVehicle[button.unit] then
                HealBot_DoVehicleChange(button, true)
            end
        elseif HealBot_UnitInVehicle[button.unit] then
            HealBot_DoVehicleChange(button, nil)
        end
    end
end

function HealBot_DoVehicleChange(button, enterVehicle)
    --HealBot_Text_setHealthText(button)
    local doRefresh=false
    if enterVehicle then
        local vUnit=HealBot_UnitPet(button.unit)
        if vUnit and UnitHasVehicleUI(button.unit) then
            _,xButton,pButton = HealBot_UnitID(vUnit)
            if not HealBot_UnitInVehicle[unit] or HealBot_UnitInVehicle[unit]~=vUnit then
                HealBot_UnitInVehicle[button.unit]=vUnit
                doRefresh=true
            end
            if xButton then 
                HealBot_OnEvent_UnitHealth(xButton)
            end
            if pButton then 
                HealBot_OnEvent_UnitHealth(pButton)
            end
        end
    elseif HealBot_UnitInVehicle[button.unit] then
        HealBot_UnitInVehicle[button.unit]=nil 
        doRefresh=true
    end
    if doRefresh then
        button.health.updhlth=true
        --HealBot_OnEvent_UnitHealth(button)
        --HealBot_RefreshUnit(button)
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcVehicle")
        end
        if UnitIsUnit(button.unit,"player") then HealBot_PlayerCheck() end
    end
end

function HealBot_OnEvent_VehicleChange(unit, enterVehicle)
    _,xButton,pButton = HealBot_UnitID(unit, true)
    if xButton then
        HealBot_DoVehicleChange(xButton, enterVehicle)
    end
    if pButton then
        HealBot_DoVehicleChange(pButton, enterVehicle)
    end
      --HealBot_setCall("HealBot_OnEvent_VehicleChange")
end

function HealBot_OnEvent_UnitPhase(button)
    if button.status.range==1 then button.status.range=-3 end
    button.status.rangenextcheck=0
end

local hbRaidTargetIconsChecked={[1]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [2]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [3]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [4]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [5]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [6]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [7]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [8]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [9]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                               [10]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                               }
function HealBot_setRaidTargetChecked()
    for x=1,10 do
        hbRaidTargetIconsChecked[x][1]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["STAR"]
        hbRaidTargetIconsChecked[x][2]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["CIRCLE"]
        hbRaidTargetIconsChecked[x][3]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["DIAMOND"]
        hbRaidTargetIconsChecked[x][4]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["TRIANGLE"]
        hbRaidTargetIconsChecked[x][5]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["MOON"]
        hbRaidTargetIconsChecked[x][6]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["SQUARE"]
        hbRaidTargetIconsChecked[x][7]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["CROSS"]
        hbRaidTargetIconsChecked[x][8]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["SKULL"]
    end
end

function HealBot_OnEvent_RaidTargetUpdate(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] and Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
        local x=GetRaidTargetIndex(button.unit)
        if x and hbRaidTargetIconsChecked[button.frame][x] then
            HealBot_Aura_RaidTargetUpdate(button, x)
        else
            HealBot_Aura_RaidTargetUpdate(button, 0)
        end
    else
        HealBot_Aura_RaidTargetUpdate(button, 0)
    end
      --HealBot_setCall("HealBot_OnEvent_RaidTargetUpdate")
end

function HealBot_OnEvent_RaidTargetUpdateAll()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
      --HealBot_setCall("HealBot_OnEvent_RaidTargetUpdateAll")
end

function HealBot_getDefaultSkin(preCombat)
    local LastAutoSkinChangeType="None"
    local newSkinName=Healbot_Config_Skins.Current_Skin
    local skinFound=false
    if not HealBot_Options_checkSkinName(Healbot_Config_Skins.Current_Skin) then
        newSkinName=HEALBOT_SKINS_STD
    end
    if HEALBOT_GAME_VERSION>1 and HealBot_Config.SkinSpecEnabled[HealBot_Config.Spec] then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinSpecEnabled[HealBot_Config.Spec]==Healbot_Config_Skins.Skins[x] then
                LastAutoSkinChangeType=HealBot_Config.Spec
                newSkinName=Healbot_Config_Skins.Skins[x]
                skinFound=true
                break
            end
        end
    end
    if not skinFound and HealBot_Config.SkinZoneEnabled[HealBot_luVars["mapName"]] then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinZoneEnabled[HealBot_luVars["mapName"]]==Healbot_Config_Skins.Skins[x] then
                LastAutoSkinChangeType=HealBot_luVars["mapName"]
                newSkinName=Healbot_Config_Skins.Skins[x]
                skinFound=true
                break
            end
        end
    end
    if not skinFound then
        local _,z = IsInInstance()
        local numMembers=GetNumGroupMembers()
        local inRaid=IsInRaid()
        local inGroup=IsInGroup()
        if preCombat and HealBot_Globals.UseCrashProt then
            local mName=HealBot_Panel_retLuVars("cpMacro")
            if mName then
                local mbody=GetMacroBody(mName) or "Solo:0"
                local cpCrashType, cpCrashNum = string.split(":", mbody)
                --cpCrashType, cpCrashNum="r","25"
                if cpCrashType~="Solo" then
                    numMembers=tonumber(cpCrashNum)
                    if numMembers>5 then
                        inRaid=true
                    else
                        inGroup=true
                    end
                    z="CrashProt"
                end
            end
        end
        if z=="arena" then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_ARENA] then
                    LastAutoSkinChangeType="Arena"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        elseif z=="pvp" then
            local y=GetRealZoneText()
            if numMembers>29 or y==HEALBOT_ZONE_AV or y==HEALBOT_ZONE_IC then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG40] then
                        LastAutoSkinChangeType="BG40"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>11 or y==HEALBOT_ZONE_SA or y==HEALBOT_ZONE_ES or y==HEALBOT_ZONE_AB then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG15] then
                        LastAutoSkinChangeType="BG15"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            else
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG10] then
                        LastAutoSkinChangeType="BG10"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            end
        elseif inRaid then
            if numMembers>29 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID40] then
                        LastAutoSkinChangeType="Raid40"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>14 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID25] then
                        LastAutoSkinChangeType="Raid25"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            else
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID10] then
                        LastAutoSkinChangeType="Raid10"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            end
        elseif inGroup and numMembers>0 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_PARTY] then
                    LastAutoSkinChangeType="Party"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        elseif HEALBOT_GAME_VERSION>3 and C_PetBattles.IsInBattle() and HealBot_luVars["lastPetBattleEvent"]~="PET_BATTLE_OVER" then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_PETBATTLE] then
                    LastAutoSkinChangeType="Pet"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        else
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_SOLO] then
                    LastAutoSkinChangeType="Solo"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        end
    end
    return newSkinName,LastAutoSkinChangeType
end

function HealBot_PartyUpdate_CheckSolo()
    local PrevSolo, PrevRaid=HealBot_luVars["IsSolo"],HealBot_luVars["IsRaid"]
    if IsInRaid() then
        HealBot_luVars["IsSolo"]=false
        HealBot_luVars["IsRaid"]=true
    elseif IsInGroup() then
        HealBot_luVars["IsSolo"]=false
        HealBot_luVars["IsRaid"]=false
    else
        HealBot_luVars["IsSolo"]=true
        HealBot_luVars["IsRaid"]=false
    end
    if PrevSolo~=HealBot_luVars["IsSolo"] or PrevRaid~=HealBot_luVars["IsRaid"] then
        local inInst,inType = HealBot_ZoneType()
        HealBot_Comms_SendTo(inInst,inType)
        if PrevSolo~=HealBot_luVars["IsSolo"] then
            HealBot_Timers_Set("AURA","PlayerCheckExtended")
            HealBot_Timers_Set("LAST","DisableCheck")
            HealBot_ActionIcons_SoloState(HealBot_luVars["IsSolo"])
            if HealBot_luVars["auraWatchNotifySolo"] then
                C_Timer.After(0.1, function() HealBot_Plugin_AuraWatch_ValidateSolo(HealBot_luVars["IsSolo"]) end)
            end
        end
    end
end

function HealBot_PartyUpdate_CheckSkin(preCombat)
    local newSkinName,LastAutoSkinChangeType=HealBot_getDefaultSkin(preCombat)
    if preCombat or LastAutoSkinChangeType~=HealBot_Config.LastAutoSkinChangeType or HealBot_Config.LastAutoSkinChangeTime<HealBot_TimeNow then
        if preCombat or newSkinName~=Healbot_Config_Skins.Current_Skin then
            HealBot_Options_Set_Current_Skin(newSkinName, nil, nil, true)
        end
        HealBot_Config.LastAutoSkinChangeType=LastAutoSkinChangeType
    end
    HealBot_Timers_Set("LAST","PartyUpdateCheckSolo")
      --HealBot_setCall("HealBot_PartyUpdate_CheckSkin")
end

function HealBot_HealthAlertLevel(preCombat, button)
    if button then
        if preCombat then
            button.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIC"]
        else
            button.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTOC"]
        end
    elseif preCombat then
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
             xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
             xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
    end
end

function HealBot_AfterCombatCleanup()
    if HealBot_luVars["RegenDisabled"] then
        HealBot_luVars["RegenDisabled"]=false
        for guid in pairs(HealBot_MobGUID) do
            HealBot_MobGUID[guid]=nil
        end
        for name in pairs(HealBot_MobNames) do
            HealBot_MobNames[name]=nil
        end
        if HealBot_luVars["healthFactor"]~=1 then
            HealBot_luVars["healthFactor"]=1
            HealBot_Timers_Set("LAST","UpdateAllHealth")
        end
        HealBot_Timers_Set("LAST","ResetUnitStatus")
        HealBot_Timers_Set("SKINS","TextUpdateNames")
        HealBot_Timers_Set("LAST","EndAggro")
        if HealBot_luVars["CheckFramesOnCombat"] then HealBot_Timers_Set("LAST","CheckHideFrames") end
        HealBot_Timers_Set("LAST","CheckLowMana")
        HealBot_Timers_Set("PLAYER","PlayerTargetChanged")
        HealBot_Timers_Set("LAST","TargetFocusUpdate")
        HealBot_UnlockEnemyFrame()
        HealBot_Timers_Set("LAST","IconNotInCombat")
        HealBot_UpdateAllUnitBars(true)
        if HealBot_luVars["pluginThreat"] then HealBot_Plugin_Threat_TogglePanel() end
    elseif not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_UnlockEnemyFrame()
    end
end

function HealBot_UnlockEnemyFrame()
    HealBot_luVars["UpdateEnemyFrame"]=true
    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcEnemy")
end

function HealBot_Not_Fighting()
    if not InCombatLockdown() then
        if HealBot_Data["UILOCK"] then
            HealBot_Data["UILOCK"]=false
            HealBot_luVars["CheckAuraFlags"]=true
            HealBot_PlayerCheck()
            HealBot_Timers_Set("INIT","HealthAlertLevel")
            if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
                HealBot_Action_RefreshTooltip()
            end
            if HealBot_luVars["EOCOOM"] and HealBot_Data["POWERTYPE"]==0 then
                _,xButton,pButton = HealBot_UnitID("player")
                if xButton and xButton.status.current<HealBot_Unit_Status["DEAD"] then
                    HealBot_Timers_Set("PLAYER","EmoteOOM",0.2)
                elseif pButton and pButton.status.current<HealBot_Unit_Status["DEAD"] then
                    HealBot_Timers_Set("PLAYER","EmoteOOM",0.2)
                end
            end
            HealBot_luVars["TargetNeedReset"]=true
            HealBot_Timers_Set("LAST","AfterCombatCleanup")
            HealBot_ActionIcons_CombatState(false)
            if HealBot_luVars["pluginTimeToLive"] then C_Timer.After(0.1, function() HealBot_Plugin_TimeToLive_TogglePanel() end) end
            if HealBot_luVars["pluginAuraWatch"] then C_Timer.After(0.2, function() HealBot_Plugin_AuraWatch_CombatState(false) end) end
            if HealBot_luVars["pluginHealthWatch"] then C_Timer.After(0.3, function() HealBot_Plugin_HealthWatch_CombatState(false) end) end
            if HealBot_luVars["pluginManaWatch"] then C_Timer.After(0.4, function() HealBot_Plugin_ManaWatch_CombatState(false) end) end
        elseif not HealBot_luVars["UpdateEnemyFrame"] then
            HealBot_UnlockEnemyFrame()
        end
    elseif HealBot_Data["UILOCK"] then
        HealBot_luVars["DropCombat"]=1
    end
      --HealBot_setCall("HealBot_Not_Fighting")
end

function HealBot_OnEvent_DoReadyCheckClear(button)
    button.icon.extra.readycheck=false
    HealBot_Aura_UpdateState(button)
end

function HealBot_OnEvent_ReadyCheckClear(noAFK)
    if noAFK then
        HealBot_Aura_RemoveExtraIcons(93)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_OnEvent_DoReadyCheckClear(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_OnEvent_DoReadyCheckClear(xButton)
        end
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckClear")
end

function HealBot_SetUnitDisconnectChange(button, state)
    HealBot_Action_setState(button, state)
    HealBot_Text_setNameTag(button)
    button.status.change=true
    button.status.update=true
end

function HealBot_SetUnitCconnected(button, offlineStart)
    if offlineStart or button.status.current==HealBot_Unit_Status["DC"] then
        if offlineStart then
            HealBot_Action_setGuidData(button, "OFFLINE", false)
        end
        HealBot_SetUnitDisconnectChange(button, HealBot_Unit_Status["CHECK"])
    end
end

function HealBot_SetUnitDisconnect(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        local offlineStart=HealBot_Action_getGuidData(button.guid, "OFFLINE")
        if button.isplayer then
            if UnitIsConnected(button.unit) then
                HealBot_SetUnitCconnected(button, offlineStart)
            elseif not offlineStart or button.status.current~=HealBot_Unit_Status["DC"] then
                if not offlineStart then
                    HealBot_Action_setGuidData(button, "OFFLINE", HealBot_TimeNow)
                end
                HealBot_SetUnitDisconnectChange(button, HealBot_Unit_Status["DC"])
            end
        else
            HealBot_SetUnitCconnected(button, offlineStart)
        end
    end
end

local hbActionFallWatch={}
local hbActionSwimWatch={}
function HealBot_ActionWatchFalling(guid, state)
    if state then
        hbActionFallWatch[guid]=true
    else
        hbActionFallWatch[guid]=nil
    end
end

function HealBot_ActionWatchSwimming(guid, state)
    if state then
        hbActionSwimWatch[guid]=true
    else
        hbActionSwimWatch[guid]=nil
    end
end

function HealBot_UnitSlowUpdate(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if button.guid~=UnitGUID(button.unit) then
            if button.unit=="target" then
                HealBot_TargetChanged()
            else
                HealBot_UpdateUnitGUIDChange(button, true)
            end
        elseif button.status.postchange then
            button.status.postchange=false
            HealBot_CheckUnitStatus(button)
            HealBot_OnEvent_UnitHealth(button)
            HealBot_OnEvent_HealsInUpdate(button)
            HealBot_OnEvent_AbsorbsUpdate(button)
            HealBot_Update_AuxRange(button)
            HealBot_Aura_Update_AllIcons(button)
            HealBot_Text_setNameTag(button)
            HealBot_Text_setNameText(button)
        elseif button.status.guidchange then
			button.status.guidchange=false
			HealBot_ActionIcons_UnitChange(button.guid, button.unit)
            if HealBot_luVars["pluginAuraWatch"] then
                HealBot_Plugin_AuraWatch_UpdateButton(button)
            end
            HealBot_Event_UnitAura(button)
            HealBot_GetUnitGuild(button)
            HealBot_RefreshUnit(button)
        elseif button.specchange then
            HealBot_SpecChange(button)
        elseif button.specupdate>0 and button.specupdate<HealBot_TimeNow and not button.status.isdead and HealBot_luVars["TalentQueryEnd"]<HealBot_TimeNow then
            if button.frame<10 then
                if button.player then
                    HealBot_GetTalentInfo(button)
                elseif button.isplayer then
                    HealBot_TalentQuery(button)
                else
                    button.specupdate=0
                end
            else
                button.specupdate=0
            end
        elseif button.status.postupdate then
            button.status.postupdate=false
            HealBot_OnEvent_UnitFlagsChanged(button)
            HealBot_Text_UpdateNameButton(button)
            button.text.health=""
            HealBot_Text_setHealthText(button)
            HealBot_ReadyCheckUnit(button)
            HealBot_OnEvent_RaidTargetUpdate(button)
            HealBot_Action_SetClassIconTexture(button)
            HealBot_Text_setNameTag(button)
            button.text.name=""
            HealBot_Text_setNameText(button)
            HealBot_Aux_CheckOverLays(button)
            HealBot_UnitInVehicleUpdate(button)
            if hbHealthWatch[button.guid] then
                HealBot_Plugin_HealthWatch_UnitUpdate(button)
            end
            if hbManaWatch[button.guid] then
                HealBot_Plugin_ManaWatch_UnitUpdate(button)
            end
            if hbActionHealthWatch[button.guid] then
                HealBot_ActionIcons_UpdateHealth(button.guid, floor(button.health.pct*100))
            end
            if hbActionManaWatch[button.guid] then
                HealBot_ActionIcons_UpdateMana(button.guid, button.mana.pct)
            end
            if hbActionFallWatch[button.guid] then
                HealBot_ActionIcons_UpdateFalling(button.guid, button.status.falling)
            end
            if hbActionSwimWatch[button.guid] then
                HealBot_ActionIcons_UpdateSwimming(button.guid, button.status.swimming)
            end
        elseif button.status.fallstart and (button.status.fallstart<HealBot_TimeNow or not IsFalling(button.unit)) then
            button.status.fallstart=false
            button.status.falling=IsFalling(button.unit)
            HealBot_ActionIcons_UpdateFalling(button.guid, button.status.falling)
        elseif hbActionFallWatch[button.guid] and button.status.falling~=IsFalling(button.unit) then
            button.status.falling=IsFalling(button.unit)
            if not button.status.falling then
                button.status.fallstart=false
                HealBot_ActionIcons_UpdateFalling(button.guid, button.status.falling)
            elseif not button.status.fallstart then
                button.status.fallstart=HealBot_TimeNow+0.9
            end
        elseif hbActionSwimWatch[button.guid] and button.status.swimming~=IsSwimming(button.unit) then
            button.status.swimming=IsSwimming(button.unit)
            HealBot_ActionIcons_UpdateSwimming(button.guid, button.status.swimming)
        elseif button.frame<10 then
            if button.status.castend>0 and button.status.castend<(HealBot_TimeNow*1000) then
                HealBot_Aux_ClearCastBar(button)
            elseif button.health.updhlth then
                HealBot_OnEvent_UnitHealth(button)
            elseif not HealBot_Data["UILOCK"] then
                if not HealBot_luVars["onTaxi"] and button.aura.buff.nextcheck and button.aura.buff.nextcheck<HealBot_TimeNow then
                    if button.aura.buff.resetcheck then
                        HealBot_Aura_ResetCheckBuffsTime(button)
                    else
                        button.aura.buff.nextcheck=false
                        HealBot_Check_UnitBuff(button)
                    end
                elseif button.isplayer then
                    if button.status.summons and C_IncomingSummon.IncomingSummonStatus(button.unit)~=1 then
                        HealBot_UnitSummonsUpdate(button, false)
                    elseif button.status.nextcheck<HealBot_TimeNow and (not UnitIsConnected(button.unit) or HealBot_Action_getGuidData(button.guid, "OFFLINE")) then 
                        HealBot_CheckUnitStatus(button)
                    elseif button.health.current<2 then
                        HealBot_OnEvent_UnitHealth(button)
                    elseif button.mana.nextcheck<HealBot_TimeNow and button.mana.max==0 then
                        HealBot_OnEvent_UnitManaUpdate(button)
                    elseif button.status.incombat then
                        HealBot_UnitAffectingCombat(button)
                    end
                    if button.text.nameonly=="" then HealBot_Text_setNameText(button) end
                elseif button.health.current<2 then
                    HealBot_OnEvent_UnitHealth(button)
                end
            elseif button.aggro.threatpct>0 then 
                HealBot_CalcThreat(button)
            elseif not button.status.incombat then 
                HealBot_UnitAffectingCombat(button)
            end
            if button.status.emergupd then
                button.status.emergupd=false
                HealBot_Action_EmergBarCheck(button, true)
            elseif button.mana.lowcheck then
                button.mana.lowcheck=false
                HealBot_Action_CheckUnitLowMana(button)
            end
        end
    end
      --HealBot_setCall("HealBot_UnitSlowUpdate")
end

function HealBot_ProcessRefreshTypes()
      --HealBot_setCall("HealBot_ProcessRefreshTypes")
    if not InCombatLockdown() then
        if HealBot_RefreshTypes[0] then
            HealBot_RecalcParty(0)
        elseif HealBot_RefreshTypes[6] then
            HealBot_RecalcParty(6)
            if not HealBot_RefreshTypes[5] then
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcEnemy")
            end
        elseif HealBot_RefreshTypes[1] then 
            HealBot_RecalcParty(1) 
        elseif HealBot_RefreshTypes[2] then 
            HealBot_RecalcParty(2)
        elseif HealBot_RefreshTypes[3] then 
            HealBot_RecalcParty(3)
        elseif HealBot_RefreshTypes[4] then 
            HealBot_RecalcParty(4)
        elseif HealBot_RefreshTypes[5] then 
            HealBot_RecalcParty(5)
        elseif HealBot_luVars["pluginClearDown"]>0 then
            if HealBot_luVars["pluginClearDown"]<2 then
                HealBot_Timers_Set("OOC","ActionIconsValidateTarget")
                HealBot_luVars["pluginClearDown"]=2
            elseif HealBot_luVars["pluginClearDown"]<3 then
                HealBot_Timers_Set("SKINS","ActionIconsPlayerNames")
                HealBot_luVars["pluginClearDown"]=3
            elseif HealBot_luVars["pluginClearDown"]<4 and HealBot_luVars["pluginThreat"] then 
                HealBot_Plugin_Threat_Cleardown()
                HealBot_luVars["pluginClearDown"]=4
            elseif HealBot_luVars["pluginClearDown"]<5 and HealBot_luVars["pluginAuraWatch"] then
                HealBot_Plugin_AuraWatch_Validate()
                HealBot_luVars["pluginClearDown"]=5
            elseif HealBot_luVars["pluginClearDown"]<6 and HealBot_luVars["pluginHealthWatch"] then 
                HealBot_Plugin_HealthWatch_Validate()
                HealBot_luVars["pluginClearDown"]=6
            elseif HealBot_luVars["pluginClearDown"]<7 and HealBot_luVars["pluginManaWatch"] then 
                HealBot_Plugin_ManaWatch_Validate()
                HealBot_luVars["pluginClearDown"]=7
            elseif HealBot_luVars["pluginClearDown"]<8 and HealBot_luVars["pluginTimeToLive"] then
                HealBot_Plugin_TimeToLive_Cleardown()
                HealBot_luVars["pluginClearDown"]=8
            elseif HealBot_luVars["pluginClearDown"]<9 and HealBot_luVars["pluginTimeToDie"] then
                HealBot_Plugin_TimeToDie_Cleardown()
                HealBot_luVars["pluginClearDown"]=9
            else
                HealBot_luVars["pluginClearDown"]=0
            end
        else
            HealBot_luVars["ProcessRefresh"]=false
            if HealBot_Panel_retLuVars("resetAuxText") then
                HealBot_Panel_setLuVars("resetAuxText", false)
                HealBot_Aux_ResetTextButtons()
            end
            HealBot_Skins_setLuVars("AuxReset", false)
            C_Timer.After(0.01, HealBot_SetTargetBar)
            return
        end
        C_Timer.After(0.05, HealBot_ProcessRefreshTypes)
    else
        HealBot_Timers_Set("OOC","ProcessRefreshTypes")
    end
end

function HealBot_Update_Slow()
    if not HealBot_Data["UILOCK"] then
        HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
        if HealBot_luVars["slowSwitch"]<2 then
            if HealBot_luVars["GetVersions"] and HealBot_luVars["GetVersions"]<HealBot_TimeNow then
                HealBot_Timers_Set("LAST","GetVersion")
                HealBot_luVars["GetVersions"]=false
            elseif HealBot_luVars["SendVersion"] and HealBot_luVars["SendVersion"]<HealBot_TimeNow then
                HealBot_Timers_Set("LAST","SendVersion")
                HealBot_luVars["SendVersion"]=false
            elseif HealBot_luVars["SendGuildVersion"] and HealBot_luVars["SendGuildVersion"]<HealBot_TimeNow then
                HealBot_Timers_Set("LAST","SendGuildVersion")
                HealBot_luVars["SendGuildVersion"]=false
            end
        elseif HealBot_luVars["slowSwitch"]<3 then
            if not HealBot_luVars["ProcessRefresh"] then
                for guid,_ in pairs(HealBot_ClearGUIDQueue) do
                    HealBot_ClearGUIDQueue[guid]=HealBot_ClearGUIDQueue[guid]+1
                    if HealBot_ClearGUIDQueue[guid]>2 then
                        HealBot_ClearGUID(guid)
                        HealBot_ClearGUIDQueue[guid]=nil
                        break
                    end
                end
            end
        else
            if HealBot_luVars["MaxCount"]>0 then
                HealBot_Debug_UpdateCalls()
                HealBot_AddDebug("#Calls active")
            end
            if HealBot_DebugMsg[1] then
                HealBot_AddChat(HealBot_DebugMsg[1])
                table.remove(HealBot_DebugMsg,1)
            end
            HealBot_Comms_SendAddonMessage()
            HealBot_luVars["slowSwitch"]=0
        end
        for xUnit,xGroup in pairs(HealBot_notVisible) do
            if UnitIsVisible(xUnit) then
                HealBot_nextRecalcParty(xGroup)
                HealBot_notVisible[xUnit]=nil
            end
        end
    elseif HealBot_luVars["DropCombat"]>0 then
        if HealBot_luVars["UILOCK"] then
            if not InCombatLockdown() then
                HealBot_luVars["DropCombat"]=HealBot_luVars["DropCombat"]+1
                if HealBot_luVars["DropCombat"]>2 then
                    HealBot_luVars["DropCombat"]=0
                    HealBot_UpdateLocalUILock(false)
                    HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow
                end
            else
                HealBot_luVars["DropCombat"]=1
            end
        else
            HealBot_luVars["DropCombat"]=0
            HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow
        end            
    end
    if HealBot_luVars["Help"] then 
        if HealBot_luVars["HelpCnt1"] then
            HealBot_luVars["HelpCnt1"]=HealBot_luVars["HelpCnt1"]+1
            if HealBot_luVars["HelpCnt1"]>#HEALBOT_HELP then
                HealBot_luVars["HelpCnt1"]=nil
            else
                HealBot_AddChat(HEALBOT_HELP[HealBot_luVars["HelpCnt1"]])
            end
        end
        if HealBot_luVars["HelpCnt2"] then
            HealBot_luVars["HelpCnt2"]=HealBot_luVars["HelpCnt2"]+1
            if HealBot_luVars["HelpCnt2"]>#HEALBOT_HELP2 then
                HealBot_luVars["HelpCnt2"]=nil
            else
                HealBot_AddChat(HEALBOT_HELP2[HealBot_luVars["HelpCnt2"]])
            end
        end
        if not HealBot_luVars["HelpCnt1"] and not HealBot_luVars["HelpCnt2"] then
            HealBot_luVars["Help"]=false
        end
    end
    if HealBot_luVars["EnableErrorSpeech"] then
        HealBot_luVars["EnableErrorSpeech"]=false
        SetCVar("Sound_EnableErrorSpeech", "1");
    end
    if HealBot_luVars["EnableErrorText"] then
        HealBot_luVars["EnableErrorText"]=false
        UIErrorsFrame:Clear()
        UIErrorsFrame:Show()
    end
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<HealBot_TimeNow then
        HealBot_luVars["rcEnd"]=false
        HealBot_OnEvent_ReadyCheckClear(false)
    end
    if HealBot_luVars["UpdateAllAura"]>0 then
        HealBot_luVars["UpdateAllAura"]=HealBot_luVars["UpdateAllAura"]-1
        if HealBot_luVars["UpdateAllAura"]==1 then
            HealBot_Aura_setLuVars("updateAll", false)
        end
    end
      --HealBot_setCall("HealBot_Update_Slow")
end
        
local hbStartTime, hbDuration, hbCDTime, hbCDEnd=0,0,0,0
function HealBot_SpellCooldown(spellName, spellId)
    hbStartTime, hbDuration=GetSpellCooldown(spellName)
    hbCDEnd=(hbStartTime or 0)+(hbDuration or 0)
    hbCDTime=hbCDEnd-HealBot_TimeNow
    if hbCDTime>2 then
        if HealBot_luVars["pluginMyCooldowns"] then
            HealBot_Plugin_MyCooldowns_PlayerUpdate(spellName, spellId, hbStartTime, hbDuration)
        end
    --        HealBot_AddDebug("CD for spell "..spellName,"Cooldown",true)
    --        HealBot_AddDebug("Start="..(hbStartTime or "nil").."  hbCDEnd="..hbCDEnd.."  floor="..floor(hbCDEnd),"Cooldown",true)
    end
    if hbCDTime>0.4 then
        HealBot_ActionIcons_SelfCD(spellName, hbCDTime, hbCDEnd)
        if HealBot_luVars["pluginAuraWatch"] then
            HealBot_Plugin_AuraWatch_SelfCD(spellName, hbCDTime, hbCDEnd)
        end
    end
end

function HealBot_Check_SpellCooldown(spellId)
    if HealBot_Spell_IDs[spellId] and (HealBot_luVars["pluginMyCooldowns"] or HealBot_luVars["pluginAuraWatch"]) then
        scName=GetSpellInfo(spellId)
        if scName then HealBot_CDQueue[spellId]=scName end
    end
end

local LogSourceGUID, LogDestGUID, LogEvent, LogUnit, LogAbsorbAmount, Log12, Log14, Log15, Log17 = "","","","",0,"",0,"",0
function HealBot_OnEvent_Combat_Log()
    _, LogEvent, _, LogSourceGUID, _, _, _, LogDestGUID, _, _, _, Log12, _, Log14, Log15, _, Log17 = CombatLogGetCurrentEventInfo()
    if HEALBOT_GAME_VERSION<4 then
        if LogEvent=="SWING_MISSED" or LogEvent=="SPELL_MISSED" then
            if Log12=="ABSORB" then
                LogAbsorbAmount=Log14 or 0
            elseif Log15=="ABSORB" then
                LogAbsorbAmount=Log17 or 0
            else
                LogAbsorbAmount=0
            end
            if LogAbsorbAmount>0 then
                xButton,pButton = HealBot_Panel_RaidPetUnitButton(LogDestGUID)
                if xButton then HealBot_Classic_AbsorbsUpdate(xButton, LogAbsorbAmount) end
                if pButton then HealBot_Classic_AbsorbsUpdate(pButton, LogAbsorbAmount) end
            end
        end
    end
    
    if HealBot_Data["PGUID"]==LogSourceGUID then
        if LogEvent=="SPELL_HEAL" then
            xButton,pButton = HealBot_Panel_RaidPetUnitButton(LogDestGUID)
            if xButton then HealBot_Update_RecentHealsBar(xButton) end
            if pButton then HealBot_Update_RecentHealsBar(pButton) end
        end
        --if type(Log12)=="number" then 
        --    C_Timer.After(0.02, function() HealBot_Check_SpellCooldown(Log12) end)
        --end
    end

      --HealBot_setCall("HealBot_OnEvent_Combat_Log")
end

function HealBot_CheckUnitRangeIC(button)
    if button.status.range<1 or not UnitInRange(button.unit) then
        return true
    else
        return false
    end
end

function HealBot_CheckUnitRangeOOC(button)
    if button.status.range<1 or not CheckInteractDistance(button.unit, 4) then
        return true
    else
        return false
    end
end
local HealBot_CheckUnitRange=HealBot_CheckUnitRangeOOC

function HealBot_FastUnitUpdateDebuff(button)
    HealBot_DebuffQueue[button.id]=false
    HealBot_Aura_CheckUnitAuras(button, true)
end

function HealBot_FastUnitUpdateBuff(button)
    HealBot_BuffQueue[button.id]=false
    HealBot_Aura_CheckUnitAuras(button, false)
end

function HealBot_FastUnitUpdateRefresh(button)
    HealBot_RefreshQueue[button.id]=false
    HealBot_Action_UpdateDebuffButton(button)
end

function HealBot_FastUnitUpdateBar(button)
    HealBot_BarQueue[button.id]=false
    if button.health.updhlth then
        HealBot_UnitHealth(button)
    end
    if button.health.updinheal then
        HealBot_HealsInUpdate(button)
    end
    if button.health.updabsorb then
        HealBot_HealsInUpdate(button)
    end
    if button.mana.update then
        HealBot_UnitMana(button)
    end
end

local hbFastUnitUpdateFuncs={["DEBUFF"]=HealBot_FastUnitUpdateDebuff,
                             ["BUFF"]=HealBot_FastUnitUpdateBuff,
                             ["REFRESH"]=HealBot_FastUnitUpdateRefresh,
                             ["BAR"]=HealBot_FastUnitUpdateBar,}
--local hbSpecialStates={[HealBot_Unit_Status["DEAD"]]=true, [HealBot_Unit_Status["RES"]]=true, [HealBot_Unit_Status["DC"]]=true}
function HealBot_UnitUpdateButton(button, recall)
    if UnitExists(button.unit) then
        if button.guid~=UnitGUID(button.unit) then
            if button.unit=="target" then
                HealBot_TargetChanged()
            else
                HealBot_UpdateUnitGUIDChange(button, true)
            end
        elseif button.status.update then
            if button.status.change then
                HealBot_UpdateUnitExists(button)
            else
                HealBot_UpdateUnit(button)
            end
		elseif HealBot_FastQueue[button.id][1] then
            hbFastUnitUpdateFuncs[HealBot_FastQueue[button.id][1]](button)
            table.remove(HealBot_FastQueue[button.id], 1)
        elseif button.status.resstart>0 or button.status.isdead then
            HealBot_Action_UpdateTheDeadButton(button)
        elseif button.status.dirarrowshown>0 and button.status.dirarrowshown<HealBot_TimeNow then 
            HealBot_Action_ShowDirectionArrow(button)
        elseif recall then 
            HealBot_UpdateUnit_Button(false)
        end
        if button.status.rangenextcheck<HealBot_TimeNow then
            if HealBot_CheckUnitRange(button) then
                HealBot_UpdateUnitRange(button)
            else
                HealBot_UpdateRangeCheckTime(button, button.status.range)
            end
        end
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        if button.unit=="target" then
            HealBot_TargetChanged()
        else
            HealBot_UpdateUnitNotExists(button)
        end
    elseif recall then
        HealBot_UpdateUnit_Button(false)
    end
end

local addonMsg=""
HealBot_luVars["updateEnemieGUID"]="ALL"
local euName, euStartTime, euEndTime, euChan="",0,false,false
function HealBot_EnemyUpdateAura(button)
    if UnitIsFriend("player",button.unit) then 
        if button.status.dirarrowshown>0 and button.status.dirarrowshown<HealBot_TimeNow then HealBot_Action_ShowDirectionArrow(button) end
        if button.status.castend>0 then HealBot_Aux_ClearCastBar(button) end
    elseif HealBot_AuxAssigns["CastBar"][button.frame] then
        euChan=false
        euName, _, _, euStartTime, euEndTime = UnitCastingInfo(button.unit) 
        if not euEndTime then
            euChan=true
            euName, _, _, euStartTime, euEndTime = UnitChannelInfo(button.unit) 
        end
        if not euEndTime and button.status.castend>0 then
            HealBot_Aux_ClearCastBar(button)
        elseif euEndTime and floor(button.status.castend/1000)~=floor(euEndTime/1000) then
            button.status.castend=euEndTime
            HealBot_Aux_UpdateCastBar(button, euName, euStartTime, euEndTime, euChan)
        end
    elseif button.status.castend>0 then 
        HealBot_Aux_ClearCastBar(button)
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["SHOWDEBUFFS"] then
        button.aura.debuff.update=true
        HealBot_Check_UnitDebuff(button)
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["SHOWBUFFS"] then
        button.aura.buff.update=true
        HealBot_Check_UnitBuff(button)
    end
end

local hbAuraTargetWatch={}
function HealBot_TargetWatch(guid, enable)
    if enable then
        hbAuraTargetWatch[guid]=true
    else
        hbAuraTargetWatch[guid]=nil
    end
end

function HealBot_UpdateAllEnemyAWTarget()
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.awtarget=true
    end
end

local hbEnemyAura={}
function HealBot_EnemyUpdateButton(button)
    if UnitExists(button.unit) then
        if button.status.rangenextcheck<HealBot_TimeNow then
            if HealBot_CheckUnitRange(button) then
                HealBot_UpdateUnitRange(button)
            else
                HealBot_UpdateRangeCheckTime(button, button.status.range)
            end
        end
        if button.guid~=UnitGUID(button.unit) then
            HealBot_UpdateUnitGUIDChange(button, true)
            if hbAuraTargetWatch[button.guid] then
                button.awtarget=true
            end
        elseif button.status.update then
            if button.status.change then
                HealBot_UpdateUnitExists(button)
            else
                HealBot_UpdateUnit(button)
            end
            HealBot_EnemyUpdateAura(button)
        elseif button.awtarget then
            button.awtarget=false
            HealBot_Plugin_AuraWatch_TargetUpdate(button)		
        elseif HealBot_FastQueue[button.id][1] then
            hbFastUnitUpdateFuncs[HealBot_FastQueue[button.id][1]](button)
            table.remove(HealBot_FastQueue[button.id], 1)
        elseif hbEnemyAura[button.id] then
            hbEnemyAura[button.id]=false
            HealBot_EnemyUpdateAura(button)
        elseif button.status.resstart>0 or button.status.isdead then
            HealBot_Action_UpdateTheDeadButton(button)
        else
            hbEnemyAura[button.id]=true
            HealBot_OnEvent_UnitHealth(button)
            HealBot_OnEvent_HealsInUpdate(button)
            HealBot_OnEvent_AbsorbsUpdate(button)
            HealBot_OnEvent_UnitMana(button)
        end
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        HealBot_UpdateUnitNotExists(button)
        if hbAuraTargetWatch[button.guid] then
            HealBot_Plugin_AuraWatch_TargetUpdate(button)
        end
    end
end

function HealBot_UpdateUnit_Button(recall)
    HealBot_luVars["UpdateID"]=HealBot_luVars["UpdateID"]+1
    if HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["UpdateID"]]] then
        HealBot_UnitUpdateButton(HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["UpdateID"]]], recall)
    elseif HealBot_luVars["UpdateID"]>HealBot_luVars["NumUnitsInQueue"] then
        HealBot_luVars["UpdateID"]=0
    end
end

function HealBot_UpdateUnit_Buttons()
    for u=1,HealBot_luVars["UpdateNumUnits"] do
        HealBot_UpdateUnit_Button(HealBot_luVars["UpdateUnitRecall"])
    end
end

function HealBot_UpdateTimers()
    for spellId, spellName in pairs(HealBot_CDQueue) do
        HealBot_SpellCooldown(spellName, spellId)
        HealBot_CDQueue[spellId]=nil
    end
    if HealBot_luVars["HealBot_RunTimers"] then
        HealBot_Timers_Run()
    end
end

function HealBot_UpdateEnemy_Buttons()
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_EnemyUpdateButton(xButton)
    end
end

function HealBot_UpdateSlow()
    HealBot_luVars["slowUpdateID"]=HealBot_luVars["slowUpdateID"]+1
    if HealBot_Buttons[HealBot_SlowUpdateQueue[HealBot_luVars["slowUpdateID"]]] then
        HealBot_UnitSlowUpdate(HealBot_Buttons[HealBot_SlowUpdateQueue[HealBot_luVars["slowUpdateID"]]])
    elseif HealBot_luVars["slowUpdateID"]>#HealBot_SlowUpdateQueue then
        HealBot_luVars["slowUpdateID"]=0
    end
    HealBot_UpdateTimers()
end

function HealBot_UpdateLast()
    HealBot_luVars["fastSwitch"]=0
    HealBot_UpdateSlow()
    HealBot_Update_Final()
end

HealBot_luVars["TestFramesRefresh"]=0
function HealBot_Update_Test()
    HealBot_UpdateTimers()
    if HealBot_luVars["TestFramesRefresh"]<HealBot_TimeNow then
        HealBot_luVars["TestFramesRefresh"]=HealBot_TimeNow+0.05
        HealBot_Update_OutOfCombat()
        HealBot_Update_Final()
    end
end

function HealBot_Update_Final()
    if HealBot_luVars["MovingFrame"]>0 then
        HealBot_Action_CheckForStickyFrame(HealBot_luVars["MovingFrame"],false)
    elseif HealBot_luVars["NextTipUpdate"]<HealBot_TimeNow then
        HealBot_luVars["NextTipUpdate"]=HealBot_TimeNow+HealBot_luVars["TipUpdateFreq"]
        if HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip()
        elseif HealBot_Data["TIPICON"] then
            HealBot_Tooltip_UpdateIconTooltip()
        end
    end
end

local ouNoneInCombat=true
function HealBot_Update_OutOfCombat()
    if (HealBot_Data["UILOCK"] or not HealBot_luVars["UpdateEnemyFrame"]) and HealBot_luVars["AllOutOfCombatCheck"]<=HealBot_TimeNow then
        ouNoneInCombat=true
        for xUnit,xButton in pairs(HealBot_Private_Button) do
            if xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.status.range>-1 and UnitAffectingCombat(xUnit) and 
               HealBot_ValidLivingEnemy(xUnit, xUnit.."target") and UnitIsUnit(xButton.unit, xButton.unit.."targettarget") then
                ouNoneInCombat=false
                break
            end
        end  
        if ouNoneInCombat then
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                if xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.status.range>-1 and UnitAffectingCombat(xUnit) and 
                   HealBot_ValidLivingEnemy(xUnit, xUnit.."target") and UnitIsUnit(xButton.unit, xButton.unit.."targettarget") then
                    ouNoneInCombat=false
                    break
                end
            end
        end
        if ouNoneInCombat then
            HealBot_Not_Fighting()
            HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+1
        else
            HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+0.2
        end
              --HealBot_setCall("HealBot_OnUpdate-CombatCheck")
    else
        HealBot_Set_FPS()
        HealBot_UpdateTimers()
    end
end

local hbFastFuncs={[1]=HealBot_UpdateTimers,           [2]=HealBot_UpdateLast,}
function HealBot_FastFuncs()
    if HealBot_luVars["UILOCK"] then
        hbFastFuncs={[1]=HealBot_UpdateEnemy_Buttons,  [2]=HealBot_UpdateUnit_Buttons,
                     [3]=HealBot_UpdateSlow,           [4]=HealBot_UpdateUnit_Buttons,
                     [5]=HealBot_UpdateEnemy_Buttons,  [6]=HealBot_UpdateUnit_Buttons,
                     [7]=HealBot_UpdateSlow,           [8]=HealBot_UpdateUnit_Buttons,
                     [9]=HealBot_UpdateEnemy_Buttons, [10]=HealBot_UpdateLast, }
    else
        hbFastFuncs={[1]=HealBot_UpdateUnit_Buttons,   [2]=HealBot_UpdateSlow,
                     [3]=HealBot_UpdateEnemy_Buttons,  [4]=HealBot_UpdateUnit_Buttons,
                     [5]=HealBot_Update_OutOfCombat,   [6]=HealBot_UpdateUnit_Buttons,
                     [7]=HealBot_UpdateEnemy_Buttons,  [8]=HealBot_UpdateSlow,
                     [9]=HealBot_UpdateUnit_Buttons,  [10]=HealBot_UpdateLast,}
    end
end

function HealBot_UpdateLocalUILock(state)
    if HealBot_luVars["UILOCK"]~=state then
        HealBot_luVars["UILOCK"]=state
        HealBot_FastFuncs()
    end
end

function HealBot_Update_Fast()
    if HealBot_luVars["MaskAuraCheckDebuff"] and HealBot_luVars["MaskAuraCheckDebuff"]<HealBot_TimeNow then
        HealBot_luVars["MaskAuraCheckDebuff"]=false
        HealBot_luVars["CheckAllActiveDebuffs"]=false
        HealBot_CheckAllDebuffs()
    elseif HealBot_luVars["CheckAllActiveDebuffs"] then
        HealBot_luVars["CheckAllActiveDebuffs"]=false
        HealBot_CheckAllActiveDebuffs()
    elseif HealBot_luVars["CheckAllActiveBuffs"] then
        HealBot_luVars["CheckAllActiveBuffs"]=false
        HealBot_CheckAllActiveBuffs()
    else
        HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
        hbFastFuncs[HealBot_luVars["fastSwitch"]]()
    end
end

HealBot_luVars["auraWatchIncEnemy"]=false
function HealBot_Update_RefreshList(button, uQueue, pClear)
    table.insert(HealBot_SlowUpdateQueue,button.id)
    if uQueue then
        table.insert(HealBot_UpdateQueue,button.id)
    end
    if pClear and not hbPrevGUIDs[button.guid] then
        HealBot_luVars["pluginClearDown"]=1
        hbPrevGUIDs[button.guid]=true
    end
end

local hbFastCur=HealBot_Update_Fast
function HealBot_Update_ResetRefreshLists1()
    for guid,_ in pairs(hbPrevGUIDs) do
        if not HealBot_Panel_AllUnitGUID(guid) then
            HealBot_luVars["pluginClearDown"]=1
            hbPrevGUIDs[guid]=nil
        end
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_RefreshList(xButton, true, true)
    end
    hbFastCur=HealBot_Update_ResetRefreshLists2
end

function HealBot_Update_ResetRefreshLists2()
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_RefreshList(xButton, true, true)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_RefreshList(xButton, true, false)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_RefreshList(xButton, true, false)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_RefreshList(xButton, true, false)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_RefreshList(xButton, false, HealBot_luVars["auraWatchIncEnemy"])
    end
    if HealBot_luVars["NumUnitsInQueue"]~=#HealBot_UpdateQueue then
        HealBot_luVars["NumUnitsInQueue"]=#HealBot_UpdateQueue
        HealBot_UpdateNumUnits()
    end
    HealBot_TestBarsState(HealBot_luVars["TestBarsOn"])
end

function HealBot_RefreshLists()
    hbFastCur=HealBot_Update_ResetRefreshLists1
end

function HealBot_TestBarsState(state)
    if state then
        hbFastCur=HealBot_Update_Test
    else
        hbFastCur=HealBot_Update_Fast
    end
    HealBot_luVars["TestBarsOn"]=state
end

function HealBot_OnUpdate()
    HealBot_TimeNow=GetTime()
    if HealBot_luVars["UpdateSlowNext"]<HealBot_TimeNow then
        HealBot_luVars["UpdateSlowNext"]=HealBot_TimeNow+1
        HealBot_Update_Slow()
    else
        hbFastCur()
    end
end

function HealBot_Register_IncHeals()
    if HEALBOT_GAME_VERSION<4 then
        libCHC = libCHC or HealBot_Libs_CHC()
        if libCHC and not HealBot_luVars["LibCHCLoaded"] then
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStarted", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealUpdated", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealDelayed", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStopped", 
                function(event, casterGUID, spellID, healType, interrupted, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
            
            HealBot_luVars["LibCHCLoaded"]=true
        end
    end
      --HealBot_setCall("HealBot_Register_IncHeals")
end

function HealBot_Register_ReadyCheck()
    HealBot:RegisterEvent("READY_CHECK")
    HealBot:RegisterEvent("READY_CHECK_CONFIRM")
    HealBot:RegisterEvent("READY_CHECK_FINISHED")
      --HealBot_setCall("HealBot_Register_ReadyCheck")
end

function HealBot_UnRegister_ReadyCheck()
    HealBot:UnregisterEvent("READY_CHECK")
    HealBot:UnregisterEvent("READY_CHECK_CONFIRM")
    HealBot:UnregisterEvent("READY_CHECK_FINISHED")
    HealBot_luVars["rcEnd"]=HealBot_TimeNow
      --HealBot_setCall("HealBot_UnRegister_ReadyCheck")
end

local ctEnemyUnit=false
local UnitThreatData={["status"]=0,["threatpct"]=0,["threatvalue"]=0,["threatname"]=false,["mobname"]=false,["mobGUID"]=false,["tmpstatus"]=0,["tmppct"]=0,["tmpvalue"]=0}
function HealBot_CalcThreat(button)
    UnitThreatData["threatpct"],UnitThreatData["status"],UnitThreatData["threatvalue"],ctEnemyUnit,UnitThreatData["threatname"]=0,0,0,false,""
    if button.status.current<HealBot_Unit_Status["DEAD"] and UnitIsFriend("player",button.unit) then
        if HealBot_ValidLivingEnemy(button.unit, button.unit.."target") then 
            ctEnemyUnit=button.unit.."target"
        elseif HealBot_ValidLivingEnemy(HealBot_luVars["TankUnit"], HealBot_luVars["TankUnit"].."target") then 
            ctEnemyUnit=HealBot_luVars["TankUnit"].."target"
        elseif HealBot_ValidLivingEnemy(button.unit, "boss1") then 
            ctEnemyUnit="boss1"
        elseif HealBot_ValidLivingEnemy(button.unit, "boss2") then 
            ctEnemyUnit="boss2"
        elseif HealBot_ValidLivingEnemy("player", "target") then 
            ctEnemyUnit="playertarget"
        end
        if ctEnemyUnit then
            _, UnitThreatData["tmpstatus"], UnitThreatData["tmppct"], _, UnitThreatData["tmpvalue"] = UnitDetailedThreatSituation(button.unit, ctEnemyUnit)
            UnitThreatData["threatpct"]=ceil(UnitThreatData["tmppct"] or 0)
            UnitThreatData["status"]=UnitThreatData["tmpstatus"] or 0
            UnitThreatData["threatvalue"]=UnitThreatData["tmpvalue"] or 0
            UnitThreatData["mobGUID"]=UnitGUID(ctEnemyUnit) or "-nil"
            if not HealBot_MobGUID[UnitThreatData["mobGUID"]] then
                UnitThreatData["mobname"]=UnitName(ctEnemyUnit)
                if UnitThreatData["mobname"] then
                    if HealBot_MobNames[UnitThreatData["mobname"]] then
                        HealBot_MobNames[UnitThreatData["mobname"]]=HealBot_MobNames[UnitThreatData["mobname"]]+1
                        HealBot_MobGUID[UnitThreatData["mobGUID"]]=UnitThreatData["mobname"].." "..HealBot_MobNames[UnitThreatData["mobname"]]
                    else
                        HealBot_MobNames[UnitThreatData["mobname"]]=1
                        HealBot_MobGUID[UnitThreatData["mobGUID"]]=UnitThreatData["mobname"]
                    end
                else
                    HealBot_MobGUID[UnitThreatData["mobGUID"]]=""
                end
            end
            UnitThreatData["threatname"]=HealBot_MobGUID[UnitThreatData["mobGUID"]] or ""
            if HealBot_luVars["pluginThreat"] and button.status.plugin then 
                HealBot_Plugin_Threat_UpdateMobRT(UnitThreatData["threatname"], (GetRaidTargetIndex(ctEnemyUnit) or 0)) 
            end
            if not UnitThreatData["status"] then UnitThreatData["status"]=0 end
        else
            UnitThreatData["status"]=UnitThreatSituation(button.unit) or 0
            if UnitThreatData["status"]>0 then
                UnitThreatData["threatpct"]=button.aggro.threatpct
                UnitThreatData["threatvalue"]=button.aggro.threatvalue
                UnitThreatData["threatname"]=button.aggro.mobname or ""
            end
        end
        if UnitThreatData["threatpct"]>=HealBot_Globals.aggro3pct then
            UnitThreatData["status"]=3
            if UnitThreatData["threatpct"]>100 then UnitThreatData["threatpct"]=100 end
        elseif UnitThreatData["threatpct"]>=HealBot_Globals.aggro2pct then
            UnitThreatData["status"]=2
        elseif (UnitThreatData["threatpct"]>0 or UnitThreatData["threatvalue"]>0) then
            if UnitThreatData["status"]<1 then UnitThreatData["status"]=1 end
            if UnitThreatData["threatpct"]<1 then UnitThreatData["threatpct"]=1 end
            UnitThreatData["status"]=1
        else
            UnitThreatData["status"]=0
        end
        if UnitThreatData["status"]<1 then
            HealBot_Aggro_ClearUnitAggro(button)
        elseif button.aggro.status~=UnitThreatData["status"] or UnitThreatData["threatpct"]~=button.aggro.threatpct or UnitThreatData["threatvalue"]~=button.aggro.threatvalue or UnitThreatData["threatname"]~=button.aggro.mobname then
            HealBot_Aggro_UpdateUnit(button,true,UnitThreatData)
        end
        if not button.status.incombat then HealBot_UnitAffectingCombat(button) end
    else
        HealBot_Aggro_ClearUnitAggro(button)
    end
      --HealBot_setCall("HealBot_CalcThreat")
end

function HealBot_Plugin_ThreatUpdate(guid)
    xButton,pButton = HealBot_Panel_RaidPetUnitButton(guid)
    if xButton and xButton.status.plugin then
        HealBot_CalcThreat(xButton)
        HealBot_Plugin_Threat_UnitUpdate(xButton)
    elseif pButton and pButton.status.plugin then
        HealBot_CalcThreat(pButton)
        HealBot_Plugin_Threat_UnitUpdate(pButton)
    else
        HealBot_Plugin_ThreatRemoveUnit(guid)
    end
      --HealBot_setCall("HealBot_Plugin_ThreatUpdate")
end

local hbNameOnly=false
function HealBot_UnitNameOnly(unitName)
    hbNameOnly=false
    if unitName then
        hbNameOnly=strtrim(string.match(unitName, "^[^-]*"))
    end
      --HealBot_setCall("HealBot_UnitNameOnly")
    return hbNameOnly
end

local amSenderId=false
function HealBot_OnEvent_AddonMsg(addon_id,msg,distribution,sender_id)
    if addon_id==HEALBOT_HEALBOT then
        amSenderId = HealBot_UnitNameOnly(sender_id)
        if amSenderId and msg then
            local datatype, datamsg = string.split(":", msg)
            if datatype then
                if datatype=="R" then
                    if amSenderId~=UnitName("player") then
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                        HealBot_SendVersion()
                        if not HealBot_Vers[amSenderId] then
                            HealBot_Comms_SendAddonMsg("W", 2, amSenderId)
                            HealBot_Aura_SendClassicData(amSenderId)
                        end
                    end
                elseif datatype=="G" then
                    if amSenderId~=UnitName("player") then
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                        HealBot_SendGuildVersion()
                        if not HealBot_Vers[amSenderId] then
                            HealBot_Comms_SendAddonMsg("W", 2, amSenderId)
                            HealBot_Aura_SendClassicData(amSenderId)
                        end
                    end
                elseif datatype=="S" then
                    if datamsg then
                        HealBot_Vers[amSenderId]=datamsg
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId.." Version="..datamsg,"Comms",true)
                        HealBot_Comms_CheckVer(amSenderId, datamsg)
                    end
                elseif datatype=="W" then
                    HealBot_Comms_SendAddonMsg("S:"..HEALBOT_VERSION, 2, amSenderId)
                elseif datatype=="U" then
                    if datamsg then
                        local guid,s=strsplit("~", datamsg)
                        if guid and s then
                            xButton,pButton = HealBot_Panel_RaidUnitButton(guid)
                            if xButton and xButton.spec~=" "..s.." " then
                                HealBot_Action_setGuidSpec(xButton, s)
                            elseif pButton and pButton.spec~=" "..s.." " then
                                HealBot_Action_setGuidSpec(pButton, s)
                            end
                        end
                    end
                elseif datatype=="H" then
                    HealBot_Aura_RecClassicData(datamsg)
                elseif datatype=="L" then
                    HealBot_Share_LinkMsg(datamsg, amSenderId)
                end
            end
        end
    end
      --HealBot_setCall("HealBot_OnEvent_AddonMsg")
end

function HealBot_GetInfo()
      --HealBot_setCall("HealBot_GetInfo")
    return HealBot_Vers
end

function HealBot_Player_InvCheck()
    HealBot_luVars["invCheck"]=false
    HealBot_luVars["BagsScanned"]=false
    HealBot_ItemIdsInBags(false)
end

function HealBot_OnEvent_InvChange()
    HealBot_Timers_Set("PLAYER","InvChange")
end

function HealBot_Player_InvChange()
    if HealBot_luVars["InvReady"] then
        if not HealBot_luVars["invCheck"] then
            HealBot_luVars["invCheck"]=true
            C_Timer.After(0.05, HealBot_Player_InvCheck)
        end
    else
        HealBot_Timers_Set("PLAYER","InvChange",1) -- All recall require a delay
    end
end

function HealBot_Player_InvReady()
    if not HealBot_luVars["InvReady"] then
        HealBot_ItemIdsInBags(true)
    end
end

function HealBot_RefreshUnit(button, hlthevent)
    if not HealBot_RefreshQueue[button.id] then
        HealBot_RefreshQueue[button.id]=true
        HealBot_InsertFastUnitQueue(button.id, "REFRESH")
    end
end

function HealBot_Check_UnitAura(button)
    if (button.id % 2 == 0) then
        HealBot_Check_UnitDebuff(button)
        HealBot_Check_UnitBuff(button)
    else
        HealBot_Check_UnitBuff(button)
        HealBot_Check_UnitDebuff(button)
    end
end

function HealBot_Event_UnitAura(button)
    button.aura.buff.update=true
    button.aura.debuff.update=true
    HealBot_Check_UnitAura(button)
end

function HealBot_InsertFastUnitQueue(id, uType)
    table.insert(HealBot_FastQueue[id], uType)
end

function HealBot_FastQueueInit(id)
    HealBot_FastQueue[id]={}
end

function HealBot_Check_UnitDebuff(button)
    if HealBot_Globals.EventQueues["DEBUFF"] then
        if not HealBot_DebuffQueue[button.id] then
            HealBot_DebuffQueue[button.id]=true
            HealBot_InsertFastUnitQueue(button.id, "DEBUFF")
        end
    else
        HealBot_Aura_CheckUnitAuras(button, true)
    end
end

function HealBot_Check_UnitBuff(button)
    if HealBot_Globals.EventQueues["BUFF"] then
        if not HealBot_BuffQueue[button.id] then
            HealBot_BuffQueue[button.id]=true
            HealBot_InsertFastUnitQueue(button.id, "BUFF")
        end
    else
        HealBot_Aura_CheckUnitAuras(button, false)
    end
end

function HealBot_UpdateAllHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllHealth")
end

function HealBot_OnEvent_SpecChange(button)
    button.specchange=true
end

function HealBot_SpecChange(button)
    button.specchange=false
    if button.frame<10 and HEALBOT_GAME_VERSION>2 and button.level>10 and button.isplayer then
        if button.player then
            HealBot_Timers_Set("PLAYER","TalentsChanged",1)
            HealBot_OnEvent_SpellsChanged(1)
        else
            if HealBot_Panel_RaidUnitGUID(button.guid) then HealBot_Action_setGuidData(button, "TMPSPEC", " ") end
            HealBot_SpecUpdate(button, HealBot_TimeNow)
        end
    elseif button.specupdate>0 then
        button.specupdate=0
    end
end

function HealBot_SpecUpdate(button, upTime)
    if button.specupdate<upTime then
        button.specupdate=upTime
    end
end

local hbHostile=false
function HealBot_OnEvent_ClassificationChanged(button)
    hbHostile=false
    if not UnitIsFriend("player",button.unit) then
        if not button.status.hostile then
            button.status.hostile=true
            HealBot_Action_SetRangeSpell(button)
        end
    elseif button.status.hostile then
        button.status.hostile=false
        HealBot_Action_SetRangeSpell(button)
    end
    if button.status.hostile~=button.icon.extra.hostile then
        if not button.status.hostile or Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWHOSTILE"] then
            button.icon.extra.hostile=button.status.hostile
            HealBot_Aura_UpdateState(button)
        end
    end
end

local hbafk=false
function HealBot_OnEvent_UnitFlagsChanged(button)
    hbafk=false
    if UnitIsAFK(button.unit) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWAFK"] then
        hbafk=true
    end
    if button.status.afk~=hbafk then
        button.status.afk=hbafk
        HealBot_Aura_UpdateState(button)
    end
end

function HealBot_OnEvent_UnitTarget(button)
    if button.status.current<HealBot_Unit_Status["DC"] and button.isplayer then
        if not HealBot_Data["UILOCK"] then
            if HealBot_Panel_IsTargetingEnemy(button.unit) then
                HealBot_nextRecalcDelay(5,0.025)
            end
        else
            HealBot_CalcThreat(button)
        end
    else
        HealBot_CheckUnitStatus(button)
    end
end

local hbCurrentTargetButton={}
function HealBot_SetTargetBar()
    if UnitExists("target") then
        xButton, pButton=HealBot_Panel_AllUnitButton(UnitGUID("target"))
        if xButton and xButton.unit~="target" then
            if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
                HealBot_Aux_UpdateTargetBar(xButton)
                if HealBot_AuxAssigns["NameOverlayTarget"][xButton.frame] then
                    HealBot_Aux_UpdateNameOverLay(xButton, 6, true)
                end
                if HealBot_AuxAssigns["HealthOverlayTarget"][xButton.frame] then
                    HealBot_Aux_UpdateHealthOverLay(xButton, 6, true)
                end
            end
            HealBot_Action_AdaptiveTargetEnable(xButton)
            hbCurrentTargetButton[xButton]=true
        end
        if pButton and pButton.unit~="target" then
            if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
                HealBot_Aux_UpdateTargetBar(pButton)
                if HealBot_AuxAssigns["NameOverlayTarget"][pButton.frame] then
                    HealBot_Aux_UpdateNameOverLay(pButton, 6, true)
                end
                if HealBot_AuxAssigns["HealthOverlayTarget"][pButton.frame] then
                    HealBot_Aux_UpdateHealthOverLay(pButton, 6, true)
                end
            end
            HealBot_Action_AdaptiveTargetEnable(pButton)
            hbCurrentTargetButton[pButton]=true
        end
    else
        HealBot_ClearTargetBar()
    end
end

local function HealBot_AuxClearTargetBar(button)
    HealBot_Aux_ClearTargetBar(button)
    if HealBot_AuxAssigns["NameOverlayTarget"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 6, false)
    end
    if HealBot_AuxAssigns["HealthOverlayTarget"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 6, false)
    end
end

function HealBot_ClearTargetBar()
    for xButton,_ in pairs(hbCurrentTargetButton) do
        if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
            HealBot_AuxClearTargetBar(xButton)
        end
        HealBot_Action_AdaptiveTargetDisable(xButton)
        hbCurrentTargetButton[xButton]=nil
    end
end

function HealBot_TargetChangedInCombat()
    HealBot_luVars["TargetChangedInCombat"]=false
    if HealBot_luVars["UILOCK"] then
        if UnitExists("target") then
            HealBot_UpdateUnitGUIDChange(HealBot_Extra_Button["target"], true)
        else
            HealBot_UpdateUnitNotExists(HealBot_Extra_Button["target"])
        end
    end
    HealBot_nextRecalcParty(3)
end

function HealBot_TargetChanged()
    if HealBot_Extra_Button["target"] and HealBot_luVars["UILOCK"] then
        if not HealBot_luVars["TargetChangedInCombat"] then
            HealBot_luVars["TargetChangedInCombat"]=true
            C_Timer.After(0.025,HealBot_TargetChangedInCombat)
        end
    else
        HealBot_nextRecalcDelay(3,0.025)
    end
end

HealBot_luVars["AuxTargetInUse"]=false
function HealBot_OnEvent_PlayerTargetChanged()
    HealBot_ClearTargetBar()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        if HealBot_luVars["TargetNeedReset"] and not HealBot_luVars["UILOCK"] then
            if UnitExists("target") and HealBot_retHbFocus("target") then
                if not UnitExists("focus") or not HealBot_retHbFocus("focus") then
                    HealBot_Panel_clickToFocus("Show")
                else
                    HealBot_Panel_clickToFocus("hide")
                end
            else
                HealBot_Panel_clickToFocus("hide")
            end
            HealBot_Panel_TargetChangedCheckFocus()
        end
        HealBot_TargetChanged()
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"] then
        HealBot_nextRecalcDelay(5,0.05)
    end
    C_Timer.After(0.07, HealBot_SetTargetBar)
    HealBot_Options_FramesActionIconsSetLists(true)
      --HealBot_setCall("HealBot_OnEvent_PlayerTargetChanged")
end

function HealBot_DoClearLowMana(button)
    button.gref.icon["Icontm1"]:SetAlpha(0)
    button.gref.icon["Icontm2"]:SetAlpha(0)
    button.gref.icon["Icontm3"]:SetAlpha(0)
end

function HealBot_ClearLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_DoClearLowMana(xButton)
    end
      --HealBot_setCall("HealBot_ClearLowMana")
end

local prdCheckActiveFrames={[1]=false, [2]=false, [3]=false, [4]=false, [5]=false, [6]=false, [7]=false, [8]=false, [9]=false, [10]=false}
function HealBot_UnitInCombat()
    if HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_luVars["UpdateEnemyFrame"]=false
        HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+1
        HealBot_Panel_PartyChanged(true, 5)
        if HealBot_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_Validate() end
    end
end

function HealBot_CheckFramesOnCombatFrame(frame)
    local check=true
    if (frame==8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8
                 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1)
        or
       (frame==9 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9
                 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1) then
        check=false
    end
    if check and prdCheckActiveFrames[frame] and Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]>1 then
        HealBot_luVars["CheckFramesOnCombat"]=true
    end
end

function HealBot_CheckActiveFrames(frame, active)
    if prdCheckActiveFrames[frame]~=active then
        prdCheckActiveFrames[frame]=active
        HealBot_Timers_Set("LAST","CheckFramesOnCombat")
    end
end

function HealBot_CheckFramesOnCombat()
    HealBot_luVars["CheckFramesOnCombat"]=false
    for f=1,10 do
        HealBot_CheckFramesOnCombatFrame(f)
    end
end

function HealBot_OnEvent_PlayerRegenDisabled()
    HealBot_Data["UILOCK"]=true
    HealBot_luVars["RegenDisabled"]=true
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_PlayerCheck()
    if HealBot_RefreshTypes[0] or HealBot_RecalcQueue[0] then
        HealBot_RefreshTypes[1]=true
        HealBot_RefreshTypes[2]=true
        HealBot_RefreshTypes[3]=true
        HealBot_RefreshTypes[4]=true
        HealBot_RefreshTypes[6]=true
        HealBot_RefreshTypes[0]=false
        HealBot_RecalcQueue[0]=false
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1 then
                HealBot_Action_HidePanel(9)
            elseif not HealBot_Action_FrameIsVisible(9) and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then
                HealBot_RefreshTypes[4]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]~=2 then
            HealBot_RefreshTypes[6]=true
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1 then
                HealBot_Action_HidePanel(8)
            elseif not HealBot_Action_FrameIsVisible(8) and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
                HealBot_RefreshTypes[3]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]~=2 then
            HealBot_RefreshTypes[6]=true
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] then
                HealBot_RefreshTypes[1]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] then
            HealBot_RefreshTypes[6]=true
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] then
                HealBot_RefreshTypes[2]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] then
            HealBot_RefreshTypes[6]=true
        end
    end
    
    if HealBot_RecalcQueue[6] then HealBot_RecalcQueue[6]=false; HealBot_RefreshTypes[6]=true; end
    if HealBot_RecalcQueue[1] then HealBot_RecalcQueue[1]=false; HealBot_RefreshTypes[1]=true; end
    if HealBot_RecalcQueue[2] then HealBot_RecalcQueue[2]=false; HealBot_RefreshTypes[2]=true; end
    if HealBot_RecalcQueue[3] then HealBot_RecalcQueue[3]=false; HealBot_RefreshTypes[3]=true; end
    if HealBot_RecalcQueue[4] then HealBot_RecalcQueue[4]=false; HealBot_RefreshTypes[4]=true; end
    
    if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
    if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
    if HealBot_RefreshTypes[2] then HealBot_RecalcParty(2); end
    if HealBot_RefreshTypes[3] then HealBot_RecalcParty(3); end
    if HealBot_RefreshTypes[4] then HealBot_RecalcParty(4); end
    
    HealBot_UnitInCombat()
    HealBot_UpdateAllUnitBars(true)
    if HealBot_luVars["CheckFramesOnCombat"] then
        for f=1,10 do
            if prdCheckActiveFrames[f] and Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][f]["AUTOCLOSE"]>1 then
                if not HealBot_Action_FrameIsVisible(f) then
                    HealBot_Action_ShowPanel(f)
                end
            end
        end
    end
    HealBot_HealthAlertLevel(true)
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
        HealBot_Action_HideTooltipFrame()
    end

    if not HealBot_luVars["hlPlayerBarsIC"] and HealBot_luVars["HighlightTarget"] then
        HealBot_OnEvent_PlayerTargetChanged()
    end
    if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] then HealBot_ClearLowMana() end
    HealBot_Timers_Set("LAST","ResetUnitStatus")
    if HealBot_luVars["rcEnd"] then
        HealBot_luVars["rcEnd"]=false
        HealBot_OnEvent_ReadyCheckClear(true)
    end
    HealBot_luVars["TimerDelay"]=0.1
    C_Timer.After(HealBot_luVars["TimerDelay"], function() HealBot_ActionIcons_CombatState(true) end)
    if HealBot_luVars["pluginTimeToLive"] then
        HealBot_luVars["TimerDelay"]=HealBot_luVars["TimerDelay"]+0.05
        C_Timer.After(HealBot_luVars["TimerDelay"], function() HealBot_Plugin_TimeToLive_EnteringCombat() end) 
    end
    if HealBot_luVars["pluginAuraWatch"] then 
        HealBot_luVars["TimerDelay"]=HealBot_luVars["TimerDelay"]+0.05
        C_Timer.After(HealBot_luVars["TimerDelay"], function() HealBot_Plugin_AuraWatch_CombatState(true) end)
    end
    if HealBot_luVars["pluginHealthWatch"] then 
        HealBot_luVars["TimerDelay"]=HealBot_luVars["TimerDelay"]+0.05
        C_Timer.After(HealBot_luVars["TimerDelay"], function() HealBot_Plugin_HealthWatch_CombatState(true) end) 
    end
    if HealBot_luVars["pluginManaWatch"] then 
        HealBot_luVars["TimerDelay"]=HealBot_luVars["TimerDelay"]+0.05
        C_Timer.After(HealBot_luVars["TimerDelay"], function() HealBot_Plugin_ManaWatch_CombatState(true) end) 
    end
    --HealBot_Options_RaidTargetUpdate()
      --HealBot_setCall("HealBot_OnEvent_PlayerRegenDisabled")
end

function HealBot_PlayerCheck()
    if HealBot_luVars["isResting"] then
        if not IsResting() then
            HealBot_luVars["isResting"]=false
            HealBot_FastFuncs()
            if HealBot_Config_Buffs.NoAuraWhenRested then HealBot_luVars["CheckAuraFlags"]=true end
            HealBot_Timers_Set("PLAYER","SetRestingState")
        end
    elseif IsResting() then
        HealBot_luVars["isResting"]=true
        HealBot_FastFuncs()
        if HealBot_Config_Buffs.NoAuraWhenRested then HealBot_luVars["CheckAuraFlags"]=true end
        HealBot_Timers_Set("PLAYER","SetRestingState")
    end
    if HealBot_luVars["onTaxi"] then
        if not UnitOnTaxi("player") then
            HealBot_luVars["onTaxi"]=false
            HealBot_luVars["CheckAuraFlags"]=true
        end
    elseif UnitOnTaxi("player") then
        HealBot_luVars["onTaxi"]=true
        HealBot_luVars["CheckAuraFlags"]=true
    end
    if not HealBot_Config_Cures.DebuffWatchWhenMounted then
        if HealBot_luVars["debuffMounted"] then
            if not IsMounted() then
                HealBot_luVars["debuffMounted"]=false
                HealBot_luVars["CheckAuraFlags"]=true
                HealBot_Aura_setLuVars("PlayerMounted", false)
            end
        elseif IsMounted() then
            HealBot_luVars["debuffMounted"]=true
            HealBot_Aura_setLuVars("PlayerMounted", true)
            HealBot_luVars["CheckAuraFlags"]=true
        end
    end
    if not HealBot_Config_Buffs.BuffWatchWhenMounted then
        if HealBot_luVars["buffMounted"] then
            if not IsMounted() then
                HealBot_luVars["buffMounted"]=false
                HealBot_luVars["CheckAuraFlags"]=true
                HealBot_Aura_setLuVars("PlayerMounted", false)
            end
        elseif IsMounted() then
            HealBot_luVars["buffMounted"]=true
            HealBot_Aura_setLuVars("PlayerMounted", true)
            HealBot_luVars["CheckAuraFlags"]=true
        end
    end
    if HealBot_luVars["inVehicle"] then
        if not HealBot_UnitInVehicle["player"] then
            HealBot_luVars["inVehicle"]=false
            HealBot_luVars["CheckAuraFlags"]=true
        end
    elseif HealBot_UnitInVehicle["player"] then
        HealBot_luVars["inVehicle"]=true
        HealBot_luVars["CheckAuraFlags"]=true
    end
    if HealBot_luVars["CheckAuraFlags"] then
        HealBot_luVars["CheckAuraFlags"]=false
        HealBot_Aura_SetAuraCheckFlags(HealBot_luVars["debuffMounted"], HealBot_luVars["buffMounted"], HealBot_luVars["onTaxi"], HealBot_luVars["isResting"], HealBot_luVars["inVehicle"])
    end
end

function HealBot_PlayerCheckExtended()
    if HealBot_Config_Buffs.BuffWatchWhenMounted then
        HealBot_luVars["buffMounted"]=false
    end
    if HealBot_Config_Cures.DebuffWatchWhenMounted then
        HealBot_luVars["debuffMounted"]=false
    end
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_PlayerCheck()
end

function HealBot_AuraCheck()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    --HealBot_setCall("HealBot_AuraCheck")
end

function HealBot_CheckAllDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
        --HealBot_setCall("HealBot_CheckAllActiveDebuffs")
end

function HealBot_CheckAllActiveDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
        --HealBot_setCall("HealBot_CheckAllActiveDebuffs")
end

function HealBot_CheckAllActiveBuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
        --HealBot_setCall("HealBot_CheckAllActiveBuffs")
end

function HealBot_UpdateAllIcons()
    if not HealBot_luVars["TestBarsOn"] then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
    end
end

function HealBot_GetUnitName(button)
    return button.name or UnitName(button.unit) or button.unit or HEALBOT_WORDS_UNKNOWN
end

function HealBot_SetUnitName(name, hbGUID)
    HealBot_customTempUserName[hbGUID]=name
    xButton,pButton = HealBot_Panel_RaidPetUnitButton(hbGUID)
    if xButton then
        xButton.name=name
        HealBot_Action_setGuidData(xButton, "NAME", name)
        HealBot_Text_setNameText(xButton)
    end
    if pButton then 
        pButton.name=name
        HealBot_Action_setGuidData(pButton, "NAME", name) 
        HealBot_Text_setNameText(pButton)
    end
end

function HealBot_DelUnitName(hbGUID)
    HealBot_customTempUserName[hbGUID]=nil
    xButton,pButton = HealBot_Panel_RaidPetUnitButton(hbGUID)
    if xButton and UnitExists(xButton.unit) then
        xButton.name=UnitName(xButton.unit)
        HealBot_Action_setGuidData(xButton, "NAME", xButton.name) 
        HealBot_Text_setNameText(xButton)
    end
    if pButton and UnitExists(pButton.unit) then
        pButton.name=UnitName(pButton.unit)
        HealBot_Action_setGuidData(pButton, "NAME", pButton.name) 
        HealBot_Text_setNameText(pButton)
    end
end

local upUnit=false
function HealBot_UnitPet(unit)
    upUnit=false
    if strsub(unit,1,4)=="raid" then
        upUnit="raidpet"..strsub(unit,5)
    elseif UnitIsUnit(unit,"player") then
        upUnit="pet"
    elseif strsub(unit,1,5)=="party" then
        upUnit="partypet"..strsub(unit,6)
    end
      --HealBot_setCall("HealBot_UnitPet")
    return upUnit
end

function HealBot_PartyMembersChanged()
    HealBot_luVars["PartyMembersChanged"]=false
    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
    if HealBot_Data["UILOCK"] then 
        HealBot_CheckAllPartyGUIDs()
    end
      --HealBot_setCall("HealBot_PartyMembersChanged")
end

function HealBot_OnEvent_PartyMembersChanged()
    if not HealBot_luVars["PartyMembersChanged"] then
        HealBot_luVars["PartyMembersChanged"]=true
        C_Timer.After(0.1, HealBot_PartyMembersChanged)
    end
end

function HealBot_OnEvent_PetsChanged()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
    end
    if HealBot_Data["UILOCK"] then 
        HealBot_CheckAllPetGUIDs()
    end
end

function HealBot_retHighlightTarget()
      --HealBot_setCall("HealBot_retHighlightTarget")
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unit)
    local unitName=UnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if HealBot_Globals.FocusMonitor[unitName]=="all" then
            return true
        else
            local _,z = IsInInstance()
            if z=="pvp" or z == "arena" then 
                if HealBot_Globals.FocusMonitor[unitName]=="bg" then
                    return true
                end
            elseif z==HealBot_Globals.FocusMonitor[unitName] then
                return true
            else
                z = GetRealZoneText()
                if z==HealBot_Globals.FocusMonitor[unitName] then
                    return true
                end
            end
        end
    end
      --HealBot_setCall("HealBot_retHbFocus")
    return false
end

function HealBot_OnEvent_ReadyCheckUpdate(button,response)
    if HealBot_luVars["rcEnd"] and button.isplayer and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRC"] then
        if response then
            button.icon.extra.readycheck=HealBot_ReadyCheckStatus["READY"]
        else
            button.icon.extra.readycheck=HealBot_ReadyCheckStatus["NOTREADY"]
        end
        HealBot_Aura_UpdateState(button)
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckUpdate")
end

function HealBot_ReadyCheckUnit(button)
    if HealBot_luVars["rcEnd"] and button.isplayer and HealBot_Panel_RaidUnitGUID(button.guid) and HealBot_luVars["rcEnd"]>HealBot_TimeNow then
        button.icon.extra.readycheck=HealBot_Action_getGuidData(button.guid, "READYCHECK")
    else
        button.icon.extra.readycheck=false
    end
    HealBot_Aura_UpdateState(button)
end

function HealBot_ReadyCheck()
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]>HealBot_TimeNow then
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.icon.extra.readycheck=HealBot_Action_getGuidData(xButton.guid, "READYCHECK")
            HealBot_Aura_UpdateState(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.icon.extra.readycheck=HealBot_Action_getGuidData(xButton.guid, "READYCHECK")
            HealBot_Aura_UpdateState(xButton)
        end
    end
end

function HealBot_OnEvent_ReadyCheck(unitName,timer)
    if HealBot_UnitNameOnly(unitName) then
        local lUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(unitName))
        HealBot_luVars["rcEnd"]=HealBot_TimeNow+timer
        for _,xButton in pairs(HealBot_Unit_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
                xButton.icon.extra.readycheck=HealBot_ReadyCheckStatus["WAITING"]
                HealBot_Aura_UpdateState(xButton)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then
                xButton.icon.extra.readycheck=HealBot_ReadyCheckStatus["WAITING"]
                HealBot_Aura_UpdateState(xButton)
            end
        end
        if lUnit then
            _,xButton,pButton = HealBot_UnitID(lUnit)
            if xButton then HealBot_OnEvent_ReadyCheckUpdate(xButton,true) end
            if pButton then HealBot_OnEvent_ReadyCheckUpdate(pButton,true) end
        end
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheck")
end

function HealBot_OnEvent_ReadyCheckConfirmed(unit,response)
    _,xButton,pButton = HealBot_UnitID(unit)
    if xButton then HealBot_OnEvent_ReadyCheckUpdate(xButton,response) end
    if pButton then HealBot_OnEvent_ReadyCheckUpdate(pButton,response) end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckConfirmed")
end

function HealBot_RaidTargetToggle(switch)
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_OnEvent_RaidTargetUpdateAll()
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        for _,xButton in pairs(HealBot_Unit_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
    end
      --HealBot_setCall("HealBot_RaidTargetToggle")
end

function HealBot_FocusChangedInCombat()
    HealBot_luVars["FocusChangedInCombat"]=false
    if HealBot_Data["UILOCK"] and HealBot_Extra_Button["focus"] then
        if UnitExists("focus") then
            HealBot_UpdateUnitGUIDChange(HealBot_Extra_Button["focus"], true)
        else
            HealBot_UpdateUnitNotExists(HealBot_Extra_Button["focus"])
        end
    end
    HealBot_nextRecalcParty(4)
end

function HealBot_FocusChanged()
    if HealBot_Extra_Button["focus"] and HealBot_luVars["UILOCK"] then
        if not HealBot_luVars["FocusChangedInCombat"] then
            HealBot_luVars["FocusChangedInCombat"]=true
            C_Timer.After(0.025,HealBot_FocusChangedInCombat)
        end
    else
        HealBot_nextRecalcDelay(4,0.025)
    end
end

function HealBot_OnEvent_FocusChanged()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCFOCUS"] then
        HealBot_nextRecalcDelay(5,0.05)
    end
    HealBot_FocusChanged()
    HealBot_Options_FramesActionIconsSetLists(true)
      --HealBot_setCall("HealBot_OnEvent_FocusChanged")
end

function HealBot_Player_TalentsChanged()
    _,xButton,pButton = HealBot_UnitID("player")
    if xButton then xButton.spec = " " end
    if pButton then pButton.spec = " " end
    HealBot_Timers_Set("INIT","CheckTalentInfo")
    HealBot_Timers_Set("AURA","CheckPlayer")
      --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
end

function HealBot_OnEvent_SpellsChanged(arg1)
    if arg1==0 then return; end
    HealBot_Timers_Set("LAST","InitLoadSpells",0.2)
      --HealBot_setCall("HealBot_OnEvent_SpellsChanged")
end

function HealBot_resetLuVars()
    HealBot_luVars["ProcessRefresh"]=false
    HealBot_luVars["invCheck"]=false
    HealBot_Text_setLuVars("FluidTextAlphaInUse", false)
    HealBot_Aux_setLuVars("AuxFluidBarAlphaInUse", false)
    HealBot_Aux_setLuVars("AuxCastBarInUse", false)
    HealBot_Aux_setLuVars("AuxFluidBarInUse", false)
    HealBot_Aux_setLuVars("AuxFlashBarsInUse", false)
    HealBot_Action_setLuVars("DeleteMarkedButtonsActive", false)
    HealBot_Action_setLuVars("FluidBarAlphaInUse", false)
    HealBot_Action_setLuVars("FluidBarInUse", false)
end

function HealBot_OnEvent_PlayerEnteringWorld()
    HealBot_resetLuVars()
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_luVars["DropCombat"]=1
    HealBot_Timers_Set("INIT","EnteringWorld")
    HealBot_luVars["qaFRNext"]=HealBot_TimeNow+5
      --HealBot_setCall("HealBot_OnEvent_PlayerEnteringWorld")
end

function HealBot_OnEvent_PlayerLeavingWorld()
    HealBot_luVars["qaFRNext"]=HealBot_TimeNow+90
    HealBot_Timers_Set("LAST","EndAggro")
    --HealBot_UnRegister_Events();
      --HealBot_setCall("HealBot_OnEvent_PlayerLeavingWorld")
end

HealBot_luVars["massResTime"]=0
HealBot_luVars["massResUnit"]="-nil"
HealBot_luVars["massResAltTime"]=0
HealBot_luVars["massResAltUnit"]="-nil"

function HealBot_UnitSummonsUpdate(button, state)
    if button.status.summons and not state then
        button.status.summons=false
        HealBot_Text_setNameTag(button)
        HealBot_Aux_ClearSummonsBar(button)
    elseif not button.status.summons then
        button.status.summons=true
        HealBot_Text_setNameTag(button)
        HealBot_Aux_UpdateSummonsBar(button, HEALBOT_WORD_SUMMONS, HealBot_TimeNow*1000, (HealBot_TimeNow+120)*1000, true)
    end
end

function HealBot_OnEvent_IncomingSummons(unit)
    _,xButton,pButton = HealBot_UnitID(unit, true)
    if C_IncomingSummon.IncomingSummonStatus(unit)==1 then
        if xButton then HealBot_UnitSummonsUpdate(xButton, true) end
        if pButton then HealBot_UnitSummonsUpdate(pButton, true) end
    else
        if xButton then HealBot_UnitSummonsUpdate(xButton, false) end
        if pButton then HealBot_UnitSummonsUpdate(pButton, false) end
    end
end

function HealBot_OnEvent_UnitSpellCastStart(button, unitTarget, castGUID, spellID)
    if button.status.current<HealBot_Unit_Status["DC"] then
        if HealBot_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
            scName, _, _, scStartTime, scEndTime = UnitCastingInfo(button.unit) 
            if scEndTime then
                button.status.castend=scEndTime
                HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, false)
            end
        else
            scName=GetSpellInfo(spellID) or spellID or "x"
        end
        if HealBot_ResSpells[scName] then
            if HealBot_ResSpells[scName]==2 then
                if HealBot_luVars["massResTime"]<HealBot_TimeNow then
                    HealBot_luVars["massResUnit"]=button.unit
                    HealBot_luVars["massResTime"]=HealBot_TimeNow+10
                elseif HealBot_luVars["massResAltTime"]<HealBot_TimeNow and HealBot_luVars["massResUnit"]~=button.unit then
                    HealBot_luVars["massResAltUnit"]=button.unit
                    HealBot_luVars["massResAltTime"]=HealBot_TimeNow+10
                end
            end
        end
    else
        HealBot_CheckUnitStatus(button)
    end
    if button.player then C_Timer.After(0.02, function() HealBot_Check_SpellCooldown(spellID) end) end
end

function HealBot_OnEvent_UnitSpellChanStart(button, unitTarget, castGUID, spellID)
    if HealBot_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
        scName, _, _, scStartTime, scEndTime = UnitChannelInfo(button.unit) 
        if scEndTime then
            button.status.castend=scEndTime
            HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, true)
        end
    end
    if button.player then C_Timer.After(0.02, function() HealBot_Check_SpellCooldown(spellID) end) end
end

function HealBot_OnEvent_UnitSpellCastStop(button, unitTarget, castGUID, spellID)
    if castGUID==HealBot_luVars["overhealCastID"] then
        _,xButton,pButton = HealBot_UnitID(HealBot_luVars["overhealUnit"], true)
        HealBot_luVars["overhealUnit"]="-nil-"
        HealBot_luVars["overhealCastID"]="-nil-"
        if xButton and xButton.health.overheal>0 then
            xButton.health.overheal=0
            HealBot_Aux_UpdateOverHealBar(xButton)
            HealBot_OverHealText(xButton)
            HealBot_Action_AdaptiveOverhealsUpdate(button)
        end
        if pButton and pButton.health.overheal>0 then
            pButton.health.overheal=0
            HealBot_Aux_UpdateOverHealBar(pButton)
            HealBot_OverHealText(pButton)
            HealBot_Action_AdaptiveOverhealsUpdate(button)
        end
    end
    if button.status.castend>0 and button.status.unittype~=11 then
        HealBot_Aux_ClearCastBar(button)
    end

    if HealBot_luVars["massResUnit"]==button.unit then HealBot_luVars["massResUnit"]="-nil" end
    if HealBot_luVars["massResAltUnit"]==button.unit then HealBot_luVars["massResAltUnit"]="-nil" end
    if button.player then C_Timer.After(0.02, function() HealBot_Check_SpellCooldown(spellID) end) end
end

function HealBot_OnEvent_UnitSpellCastComplete(button, unitTarget, castGUID, spellID)
    if button.player then
        if (HealBot_Config_Cures.IgnoreOnCooldownDebuffs and HealBot_Options_retIsDebuffSpell(spellID)) then
            HealBot_luVars["CheckAllActiveDebuffs"]=true
        elseif HealBot_Aura_IsBuffSpell(spellID) then  
            HealBot_luVars["CheckAllActiveBuffs"]=true
        end
        C_Timer.After(0.02, function() HealBot_Check_SpellCooldown(spellID) end)
    end
end

function HealBot_OnEvent_UnitSpellCastFailed(button, unitTarget, castGUID, spellID)
    if HealBot_luVars["massResUnit"]==button.unit then
        HealBot_luVars["massResTime"]=0
        HealBot_luVars["massResUnit"]="-nil"
    elseif HealBot_luVars["massResAltUnit"]==button.unit then
        HealBot_luVars["massResAltTime"]=0
        HealBot_luVars["massResAltUnit"]="-nil"
    end
end

function HealBot_MassRes()
    if HealBot_luVars["massResTime"]>HealBot_TimeNow or HealBot_luVars["massResAltTime"]>HealBot_TimeNow then
        return true
    else
        return false
    end
end

local uscUnit, uscUnitName, uscSpellName=nil,false,false
function HealBot_OnEvent_UnitSpellCastSent(caster,unitName,castGUID,spellID)
    if UnitIsUnit("player",caster) then
        uscUnit=nil
        uscUnitName = HealBot_UnitNameOnly(unitName)
        uscSpellName = GetSpellInfo(spellID) or spellID
        
        if uscUnitName == HEALBOT_WORDS_UNKNOWN then
            uscUnitName = HealBot_GetCorpseName(uscUnitName)
        end
        
        if uscUnitName=="" then
            if spellID==HEALBOT_MENDPET and UnitExists("pet") then
                uscUnitName=UnitName("pet")
                uscUnit="pet"
            end
        else
            uscUnit=HealBot_Panel_RaidUnitName(uscUnitName)
            if uscUnit and not UnitExists(uscUnit) then uscUnit=nil end
        end

        if uscUnit and uscUnitName then
            _,xButton,pButton=HealBot_UnitID(uscUnit)
            if (xButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["OVERHEAL"]<3) or
               (pButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][pButton.frame]["OVERHEAL"]<3) then
                HealBot_luVars["overhealUnit"]=uscUnit
                HealBot_luVars["overhealCastID"]=castGUID
            end
        end
        if HealBot_luVars["ChatNOTIFY"]>1 then
            if HealBot_luVars["ChatRESONLY"] then
                if HealBot_ResSpells[uscSpellName] then
                    if HealBot_ResSpells[uscSpellName]==2 then           
                        HealBot_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,uscSpellName,(uscUnit or ""))
                    elseif uscUnit and uscUnitName then
                        HealBot_CastNotify(uscUnitName,uscSpellName,uscUnit)
                    end
                end
            elseif HealBot_Spell_Names[uscSpellName] and uscUnit and uscUnitName then
                HealBot_CastNotify(uscUnitName,uscSpellName,uscUnit)
            end
        end
        C_Timer.After(0.05, function() HealBot_Check_SpellCooldown(spellID) end)
    end
    --HealBot_setCall("HealBot_OnEvent_UnitSpellCastSent")
end

function HealBot_GetCorpseName(cName)
    local z = _G["GameTooltipTextLeft1"];
    local x = z:GetText();
    if (x) then
        cName = string.gsub(x, HEALBOT_TOOLTIP_CORPSE, "")
    end
      --HealBot_setCall("HealBot_GetCorpseName")
    return cName
end

function HealBot_CastNotify(unitName,spell,unit)
    local z = HealBot_luVars["ChatNOTIFY"];
    local s = gsub(HealBot_luVars["ChatMSG"],"#s",spell)
    s = gsub(s,"#l",GetSpellLink(spell, ""))
    s = gsub(s,"#n",unitName)
    local w=nil;

    if z==3 and UnitIsPlayer(unit) and UnitPlayerControlled(unit) and not UnitIsUnit("player",unit) then
        s = gsub(s,unitName,HEALBOT_WORDS_YOU)
        HealBot_Comms_SendInstantMsg(s,unitName)
    elseif z==5 then
        HealBot_Comms_SendInstantMsg(s,false,true)
    elseif z==6 then
        HealBot_Comms_SendInstantMsg(s,false,false,true)
    elseif z==4 then
        HealBot_Comms_SendInstantMsg(s)
    else
        HealBot_AddChat(s);
    end
      --HealBot_setCall("HealBot_CastNotify")   
end

function HealBot_ToggelFocusMonitor(unit, zone)
    local unitName=UnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if UnitExists("target") and unitName==UnitName("target") then HealBot_Panel_clickToFocus("hide") end
        HealBot_Globals.FocusMonitor[unitName] = nil
    else
        HealBot_Globals.FocusMonitor[unitName] = zone
        if UnitExists("target") and HealBot_Globals.FocusMonitor[UnitName("target")] then HealBot_Panel_clickToFocus("Show") end
    end
      --HealBot_setCall("HealBot_ToggelFocusMonitor")
end

local hbSounds={}
hbSounds["TIME"]=0
hbSounds["CALLBACKTIME"]=0
function HealBot_PlaySound(id, channel)
    hbSounds["SOUNDID"]=LSM:Fetch('sound',id)
    if hbSounds["SOUNDID"] then 
        if hbSounds["TIME"]<HealBot_TimeNow then
                hbSounds["TIME"]=HealBot_TimeNow+0.5
                hbSounds["LASTID"]=id
                hbSounds["CHANNEL"]=channel or "SFX"
                PlaySoundFile(hbSounds["SOUNDID"], hbSounds["CHANNEL"]); 
        elseif id~=hbSounds["LASTID"] and hbSounds["CALLBACKTIME"]<HealBot_TimeNow then
            hbSounds["DELAY"]=0.01+(hbSounds["TIME"]-HealBot_TimeNow)
            hbSounds["CALLBACKTIME"]=HealBot_TimeNow+hbSounds["DELAY"]
            C_Timer.After(hbSounds["DELAY"], function() HealBot_PlaySound(id, channel) end)
        end
    end
      --HealBot_setCall("HealBot_PlaySound")
end

function HealBot_InitSmartCast()
    HealBot_SetResSpells()
    HealBot_Action_SetrSpell()
    HealBot_Init_SmartCast();
end

function HealBot_InitSpells()
    HealBot_Init_Spells_Defaults();
    HealBot_Options_InitDebuffTypes()
    HealBot_Timers_Set("PLAYER","InitSmartCast",1)
      --HealBot_setCall("HealBot_InitSpells")
end

function HealBot_Cycle_Skins()
    local n=getn(Healbot_Config_Skins.Skins)
    if n==Healbot_Config_Skins.Skin_ID then
        n=1
    else
        n=Healbot_Config_Skins.Skin_ID+1
    end
    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[n])
      --HealBot_setCall("HealBot_Cycle_Skins")
end

local ldb=nil
function HealBot_MMButton_Init()
    if LDBIcon and ldb and not LDBIcon:IsRegistered(HEALBOT_HEALBOT) then
        LDBIcon:Register(HEALBOT_HEALBOT, ldb, HealBot_Globals.MinimapIcon)
        HealBot_MMButton_Toggle()
    end
      --HealBot_setCall("HealBot_MMButton_Init")
end

if LDB11 then
    ldb = LDB11:NewDataObject(HEALBOT_HEALBOT, {
        type = "data source",
        label = HEALBOT_HEALBOT,
        icon = "Interface\\AddOns\\HealBot\\Images\\HealBot",
    })

    function ldb.OnClick(self, button)
        if button == "LeftButton" then
            if IsShiftKeyDown() then
                HealBot_Cycle_Skins()
            else
                HealBot_Options_ShowHide()
            end
        elseif button == "RightButton" then
            if IsShiftKeyDown() then
                if HealBot_Config.DisableHealBot then
                    HealBot_Config.DisableHealBot=false
                else
                    HealBot_Config.DisableHealBot=true
                end
                HealBot_Options_DisableHealBotOpt:SetChecked(HealBot_Config.DisableHealBot)
                HealBot_Timers_Set("LAST","DisableCheck")
            else
                HealBot_SetResetFlag("SOFT")
            end
        else
            HealBot_Options_ShowHide()
        end
    end

    function ldb.OnTooltipShow(tt)
        tt:AddLine(HEALBOT_ADDON)
        tt:AddLine(" ")
        tt:AddLine(HEALBOT_LDB_LEFT_TOOLTIP)
        tt:AddLine(HEALBOT_LDB_SHIFTLEFT_TOOLTIP)
        tt:AddLine(" ")
        tt:AddLine(HEALBOT_LDB_RIGHT_TOOLTIP)
        tt:AddLine(HEALBOT_LDB_SHIFTRIGHT_TOOLTIP)
    end
end

function HealBot_MMButton_Toggle()
    if LDBIcon then
        if not HealBot_Globals.MinimapIcon.hide then
            LDBIcon:Show(HEALBOT_HEALBOT)
        else
            LDBIcon:Hide(HEALBOT_HEALBOT)
        end
    end
      --HealBot_setCall("HealBot_MMButton_Toggle")
end

function HealBot_Update_AuxRange(button)
    HealBot_Update_OORBar(button)
    HealBot_Update_InRangeBar(button)
end

function HealBot_AuxResetRange()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_AuxRange(xButton)
    end
end

function HealBot_Update_OORBar(button)
    if button.status.range==1 then
        if HealBot_AuxAssigns["OORBar"][button.frame] then
            HealBot_Aux_ClearOORBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 7, false)
        end
        if HealBot_AuxAssigns["HealthOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 7, false)
        end
    else
        if HealBot_AuxAssigns["OORBar"][button.frame] then
            HealBot_Aux_UpdateOORBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 7, true)
        end
        if HealBot_AuxAssigns["HealthOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 7, true)
        end
    end
end

function HealBot_Update_InRangeBar(button)
    if HealBot_AuxAssigns["InRangeBar"][button.frame] then
        if not button.player and button.status.range>0 then
            HealBot_Aux_UpdateInRangeBar(button)
        else
            HealBot_Aux_ClearInRangeBar(button)
        end
    end
end

function HealBot_Clear_RecentHealsBar(button)
    if button.status.playerlastheal<HealBot_TimeNow then
        if HealBot_AuxAssigns["RecentHeals"][button.frame] then
            HealBot_Aux_ClearRecentHealsBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 1, false)
        end
        if HealBot_AuxAssigns["HealthOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 1, false)
        end
        HealBot_Action_AdaptiveRecentHealsDisable(button)
    else
        C_Timer.After((button.status.playerlastheal-HealBot_TimeNow)+0.05, function() HealBot_Clear_RecentHealsBar(button) end)
    end
end

function HealBot_Update_RecentHealsBar(button)
    if button.status.playerlastheal<HealBot_TimeNow then
        if HealBot_AuxAssigns["RecentHeals"][button.frame] then
            HealBot_Aux_UpdateRecentHealsBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 1, true)
        end
        if HealBot_AuxAssigns["HealthOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 1, true)
        end
        HealBot_Action_AdaptiveRecentHealsEnable(button)
    end
    
    C_Timer.After(0.35, function() HealBot_Clear_RecentHealsBar(button) end)
    button.status.playerlastheal=HealBot_TimeNow+0.3
end

local uRange,sRange=0,0
function HealBot_UnitInRange(button, spellName)
    if not HealBot_UnitInPhase(button) then 
        uRange = -2
    elseif button.player then
        uRange = 1
    elseif not UnitIsVisible(button.unit) then 
        uRange = -1
    elseif not HealBot_Data["UILOCK"] and CheckInteractDistance(button.unit, 4) then
        uRange = 1
    else
        if spellName and HealBot_Spell_Names[spellName] then
            sRange=IsSpellInRange(spellName, button.unit)
            if type(sRange)~="number" then
                if sRange or UnitInRange(button.unit) then
                    uRange = 1
                else
                    uRange = 0
                end
            else
                uRange = sRange
            end
        elseif UnitInRange(button.unit) then
            uRange = 1
        else
            uRange = 0
        end
    end
    --HealBot_setCall("HealBot_UnitInRange")
    return uRange
end

local hbRangeRequests={}
function HealBot_Requests(guid, state)
    if state then
        hbRangeRequests[guid]=true
    else
        hbRangeRequests[guid]=nil
    end
end

function HealBot_RequestsClearButton(button)
    if button.request.colbar>0 then
        if button.request.colbar==4 then 
            HealBot_Action_DisableBorderHazardType(button, "PLUGIN") 
        elseif button.request.colbar==5 then
            HealBot_Action_DisableButtonGlowType(button, "PLUGIN", "R")
        end
        button.request.colbar=0
        HealBot_Action_UpdateRequestButton(button)
    end
end

function HealBot_RequestsClear()
    hbRangeRequests={}
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_RequestsClearButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_RequestsClearButton(xButton)
    end
end

local hbActionIconsInRange={}
function HealBot_ActionIconsInRange(guid, state)
    if state then
        hbActionIconsInRange[guid]=true
    else
        hbActionIconsInRange[guid]=nil
    end
end

function HealBot_UpdateRangeCheckTime(button, range)
    if range>-1 then
        if not HealBot_Data["UILOCK"] then
            if CheckInteractDistance(button.unit, 4) then
                button.status.rangenextcheck=HealBot_TimeNow+HealBot_luVars["rangeCheckAdj"]
            else
                button.status.rangenextcheck=HealBot_TimeNow+HealBot_luVars["rangeCheckAdjEnabled"]
            end
        else
            button.status.rangenextcheck=HealBot_TimeNow+HealBot_luVars["rangeCheckAdjEnabled"]
        end
    else
        button.status.rangenextcheck=HealBot_TimeNow+HealBot_luVars["rangeCheckAdj"]
    end
end

local newRange,oldRange=-99,99
function HealBot_UpdateUnitRange(button) 
    if button.status.current<HealBot_Unit_Status["DC"] then
        newRange=HealBot_UnitInRange(button, button.status.rangespell)
        HealBot_UpdateRangeCheckTime(button, newRange)
        if newRange~=button.status.range then
            oldRange=button.status.range
            button.status.range=newRange
            if button.status.enabled or button.status.range==1 or oldRange==1 then
                HealBot_Update_AuxRange(button)
                HealBot_RefreshUnit(button)
                if button.status.range<0 or oldRange<0 then 
                    HealBot_OnEvent_HealsInUpdate(button)
                    HealBot_OnEvent_AbsorbsUpdate(button)
                end
                HealBot_Action_AdaptiveOORUpdate(button)
                HealBot_Update_InRangeBar(button)
                if hbHealthWatch[button.guid] then HealBot_Plugin_HealthWatch_UnitUpdate(button) end
                if hbManaWatch[button.guid] then HealBot_Plugin_ManaWatch_UnitUpdate(button) end
                if hbActionIconsInRange[button.guid] then
                    if button.status.range==1 then
                        HealBot_ActionIcons_UpdateRange(button.unit, button.guid, true)
                    else
                        HealBot_ActionIcons_UpdateRange(button.unit, button.guid, false)
                    end
                end
                if button.status.dirarrowshown>0 or (Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and button.status.range==0) then
                    HealBot_Action_ShowDirectionArrow(button)
                end
                if HealBot_Emerg_Button[button.id].state>0 then
                    HealBot_Action_EmergBarCheck(button, true)
                end
                if button.status.isdead then
                    HealBot_Text_UpdateButton(button)
                else
                    HealBot_Text_setNameTag(button)
                end
                if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][button.frame]["OORLAST"] then
                    if button.status.unittype<7 then 
                        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
                    elseif button.status.unittype<9 then
                        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
                    end
                end
                if button.mouseover and HealBot_Data["TIPBUTTON"] then 
                    HealBot_Action_RefreshTooltip() 
                end
                HealBot_Action_UpdateHealthHotBar(button)
                if button.frame<10 then 
                    if button.aura.buff.name then 
                        HealBot_Aura_BuffWarnings(button, button.aura.buff.name, true) 
                    end
                    if button.aura.debuff.id>0 then 
                        HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true, 0) 
                    end
                end
            end
            if hbRangeRequests[button.guid] and button.status.range>-1 then
                HealBot_Plugin_Requests_CancelGUID(button.guid)
                hbRangeRequests[button.guid]=nil
            end
            if HealBot_luVars["pluginAuraWatch"] then
                HealBot_Plugin_AuraWatch_RangeUpdate(button)
            end
        end
    else
        button.status.range=-3
    end
        --HealBot_setCall("HealBot_UpdateUnitRange")
end

local hbPi = math.pi
local hbaTan2 = math.atan2
local hbdMod = 108 / math.pi / 2;
local dcDirection, dcX, dcY = false,false,false
local dcPlayerX, dcPlayerY, dcPlayerFacing=false, false, false
local dcUnitX, dcUnitY=false,false
function HealBot_Direction_Check(unit) 
    dcDirection, dcX, dcY = false,false,false
    dcPlayerX, dcPlayerY = HealBot_getUnitCoords("player")
    if dcPlayerX then
        dcUnitX, dcUnitY = HealBot_getUnitCoords(unit)
        if dcUnitX then
            dcPlayerFacing = GetPlayerFacing();
            if dcPlayerFacing then
                dcPlayerFacing = dcPlayerFacing < 0 and dcPlayerFacing + hbPi * 2 or dcPlayerFacing;
                dcDirection = hbPi - hbaTan2(dcPlayerX - dcUnitX, dcUnitY - dcPlayerY) - dcPlayerFacing;
                dcDirection = floor(dcDirection * hbdMod + 0.5) % 108
                dcX, dcY = (dcDirection % 9) * 0.109375, floor(dcDirection / 9) * 0.08203125;
            end
        end
    end
      --HealBot_setCall("HealBot_Direction_Check")
    return dcX, dcY, dcDirection;
end

local gucUIMapID, gucPos=false,false
function HealBot_getUnitCoords(unit)
      --HealBot_setCall("HealBot_getUnitCoords")
    if UnitIsPlayer(unit) then
        gucUIMapID=C_Map.GetBestMapForUnit(unit)
        if gucUIMapID then
            gucPos=C_Map.GetPlayerMapPosition(gucUIMapID, unit)
            if gucPos and gucPos.x and gucPos.y and gucPos.x > 0 and gucPos.y > 0 then
                return gucPos.x, gucPos.y
            end
        end
    end
    return nil, nil
end

function HealBot_getCurrentMapContinent()
    local mapInfo = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
    while mapInfo.mapType~=2 do
        mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
    end
      --HealBot_setCall("HealBot_getCurrentMapContinent")
    return mapInfo.mapID
end

function HealBot_Options_ResetSetting(resetTab)
    if resetTab=="BUFF" then
        local msg="Healbot recommends resetting the buffs tab \n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["BUFF"]="9.1.0.0"
                HealBot_Reset_Buffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    elseif resetTab=="CDEBUFF" then
        local msg="Healbot recommends resetting the custom debuffs tab \n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["CDEBUFF"]="9.1.0.0"
                HealBot_ResetCustomDebuffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    elseif resetTab=="ICONS" then
        local msg="Healbot recommends resetting HoT/buff icons\n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["ICONS"]="10.0.0.0"
                HealBot_Reset_Icons()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    end

    StaticPopup_Show ("HEALBOT_OPTIONS_RESETSETTING");
      --HealBot_setCall("HealBot_Options_ResetSetting")
end

function HealBot_Copy_SpellCombo(combo, maxButtons)
    if combo then
        for y=1,maxButtons do
            local button = HealBot_Options_ComboClass_Button(y)
            combo[button] = combo[HealBot_Action_GetComboSpec("", button)]
            combo["Shift"..button] = combo[HealBot_Action_GetComboSpec("Shift", button)]
            combo["Ctrl"..button] = combo[HealBot_Action_GetComboSpec("Ctrl", button)]
            combo["Alt"..button] = combo[HealBot_Action_GetComboSpec("Alt", button)]
            combo["Ctrl-Shift"..button] = combo[HealBot_Action_GetComboSpec("Ctrl-Shift", button)]
            combo["Alt-Shift"..button] = combo[HealBot_Action_GetComboSpec("Alt-Shift", button)]
            combo["Alt-Ctrl"..button] = combo[HealBot_Action_GetComboSpec("Alt-Ctrl", button)]
            combo["Alt-Ctrl-Shift"..button] = combo[HealBot_Action_GetComboSpec("Alt-Ctrl-Shift", button)]
        end
    end
end

function HealBot_Copy_SpellCombos()
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EnabledKeyCombo, 20)
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EnemyKeyCombo, 20)
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EmergKeyCombo, 5)
    HealBot_Update_SpellCombos()
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMSPELLCOPY)
      --HealBot_setCall("HealBot_Copy_SpellCombos")
end

function HealBot_Reset_Spells()
    HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
    HealBot_Update_SpellCombos()
    HealBot_Timers_InitExtraOptions()
    HealBot_Timers_Set("INIT","SpellsTabText")
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMSPELLRESET)
      --HealBot_setCall("HealBot_Reset_Spells")
end

function HealBot_Reset_Buffs()
    HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
    HealBot_Config_Buffs.BuffWatch=HealBot_Config_BuffsDefaults.BuffWatch
    HealBot_Config_Buffs.BuffWatchInCombat=HealBot_Config_BuffsDefaults.BuffWatchInCombat
    HealBot_Config_Buffs.BuffWatchWhenGrouped=HealBot_Config_BuffsDefaults.BuffWatchWhenGrouped
    HealBot_Config_Buffs.BuffWatchWhenMounted=HealBot_Config_BuffsDefaults.BuffWatchWhenMounted
    HealBot_Config_Buffs.ExtraBuffsOnlyInInstance=HealBot_Config_BuffsDefaults.ExtraBuffsOnlyInInstance
    HealBot_Config_Buffs.ShortBuffTimer=HealBot_Config_BuffsDefaults.ShortBuffTimer
    HealBot_Config_Buffs.LongBuffTimer=HealBot_Config_BuffsDefaults.LongBuffTimer
    HealBot_Config_Buffs.SoundBuffWarning=HealBot_Config_BuffsDefaults.SoundBuffWarning
    HealBot_Config_Buffs.SoundBuffPlay=HealBot_Config_BuffsDefaults.SoundBuffPlay
    HealBot_Config_Buffs.ShowBuffWarning=HealBot_Config_BuffsDefaults.ShowBuffWarning
    HealBot_Config_Buffs.CBshownHB=HealBot_Config_BuffsDefaults.CBshownHB
    HealBot_Config_Buffs.CustomBuffCheck=HealBot_Config_BuffsDefaults.CustomBuffCheck
    HealBot_Config_Buffs.CustomBuffName=HealBot_Config_BuffsDefaults.CustomBuffName
    HealBot_Config_Buffs.CustomItemName=HealBot_Config_BuffsDefaults.CustomItemName
    HealBot_Update_BuffsForSpec("Buff")
    HealBot_Timers_InitExtraOptions()
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMBUFFSRESET)
    HealBot_Timers_Set("AURA","BuffReset")
      --HealBot_setCall("HealBot_Reset_Buffs")
end

function HealBot_Reset_Cures()
    HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
    HealBot_Config_Cures.SoundDebuffWarning=HealBot_Config_CuresDefaults.SoundDebuffWarning
    HealBot_Config_Cures.DebuffWatch=HealBot_Config_CuresDefaults.DebuffWatch
    HealBot_Config_Cures.IgnoreFastDurDebuffs=HealBot_Config_CuresDefaults.IgnoreFastDurDebuffs
    HealBot_Config_Cures.IgnoreFastDurDebuffsSecs=HealBot_Config_CuresDefaults.IgnoreFastDurDebuffsSecs
    HealBot_Config_Cures.IgnoreOnCooldownDebuffs=HealBot_Config_CuresDefaults.IgnoreOnCooldownDebuffs
    HealBot_Config_Cures.SoundDebuffPlay=HealBot_Config_CuresDefaults.SoundDebuffPlay
    HealBot_Config_Cures.DebuffWatchInCombat=HealBot_Config_CuresDefaults.DebuffWatchInCombat
    HealBot_Config_Cures.DebuffWatchWhenGrouped=HealBot_Config_CuresDefaults.DebuffWatchWhenGrouped
    HealBot_Config_Cures.DebuffWatchWhenMounted=HealBot_Config_CuresDefaults.DebuffWatchWhenMounted
    HealBot_Config_Cures.ShowDebuffWarning=HealBot_Config_CuresDefaults.ShowDebuffWarning
    HealBot_Config_Cures.CDCshownHB=HealBot_Config_CuresDefaults.CDCshownHB
    HealBot_Update_BuffsForSpec("Debuff")
    HealBot_Timers_InitExtraOptions()
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMCURESRESET)
    HealBot_Timers_Set("AURA","DebuffReset")
      --HealBot_setCall("HealBot_Reset_Cures")
end

function HealBot_Reset_Icons()
    HealBot_Globals.IgnoreCustomBuff={}
    HealBot_Globals.HealBot_Custom_Buffs={}
    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol={}
    HealBot_Globals.CustomBuffBarColour = {[HEALBOT_CUSTOM_en.."Buff"] = { R = 0.25, G = 0.58, B = 0.8, },}
    HealBot_Globals.WatchHoT=HealBot_Options_copyTable(HealBot_GlobalsDefaults.WatchHoT)
    HealBot_Globals.CustomBuffTag=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CustomBuffTag)
    HealBot_Timers_InitExtraOptions()
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMICONRESET)
      --HealBot_setCall("HealBot_Reset_Icons")
end

function HealBot_IsItemInBag(itemID)
      --HealBot_setCall("HealBot_IsItemInBag")
    if itemID then
        return HealBot_ItemsInBags[itemID]
    else
        return false
    end
end

function HealBot_IsKnownItem(name)
    if HealBot_IsItemInBag(name) or IsUsableItem(name) then
        return true
    else
        return false
    end
end


function HealBot_runDefaults()
    HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
    HealBot_Update_BuffsForSpec()
    HealBot_Update_SpellCombos()
    HealBot_Aura_ClearAllBuffs()
    HealBot_Aura_ClearAllDebuffs()
      --HealBot_setCall("HealBot_runDefaults")
end

function HealBot_ClearGUID(guid)
    if guid and not HealBot_Panel_AllUnitGUID(guid) then
        C_Timer.After(0.1, function() HealBot_Action_ClearGUID(guid) end)
        C_Timer.After(0.2, function() HealBot_Aura_ClearGUID(guid) end)
        C_Timer.After(0.3, function() HealBot_Panel_ClearGUID(guid) end)
        C_Timer.After(0.4, function() HealBot_Aggro_ClearGUID(guid) end)
        C_Timer.After(0.5, function() HealBot_ActionIcons_ClearGUID(guid) end)
        if HealBot_luVars["pluginAuraWatch"] then C_Timer.After(0.6, function() HealBot_Plugin_AuraWatch_ClearGUID(guid) end) end
        hbRangeRequests[guid]=nil
        hbHealthWatch[guid]=nil
        hbManaWatch[guid]=nil
        hbActionHealthWatch[guid]=nil
        hbHealthExtra[guid]=nil
        hbActionManaWatch[guid]=nil
        hbAuraWatchMana[guid]=nil
        hbAuraWatchHealth[guid]=nil
        hbAuraTargetWatch[guid]=nil
        hbManaExtra[guid]=nil
        hbActionFallWatch[guid]=nil
        hbActionSwimWatch[guid]=nil
        hbActionIconsInRange[guid]=nil
        if HealBot_Data["TIPUSE"] then C_Timer.After(0.7, function() HealBot_Tooltip_ClearGUID(guid) end) end
    end
end

function HealBot_QueueClearGUID(button)
    if string.len(button.guid)>12 then
        HealBot_ClearGUIDQueue[button.guid]=0
    end
end

local eButton,ePrivate=false,false
function HealBot_EventSpellCD()
    if HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
    if HealBot_luVars["pluginMyCooldowns"] then 
        HealBot_Plugin_MyCooldowns_PlayerUpdateAll()
    end
    if HealBot_luVars["pluginAuraWatch"] then
        HealBot_Plugin_AuraWatch_UpdateAllCDs()
    end
    HealBot_ActionIcons_UpdateAllCDs()
end

function HealBot_EventSpellCharges()
    HealBot_Timers_Set("SKINS","SelfCountTextUpdate")
end

function HealBot_EventRegenDisabled()
    --if HealBot_Options:IsVisible() then
    --    HealBot_TogglePanel(HealBot_Options, true)
    --end
    if HealBot_luVars["AddonLoaded"] and not HealBot_luVars["VarsLoaded"] then
        HealBot_VariablesLoaded()
    end
    if HealBot_luVars["VarsLoaded"] and not HealBot_luVars["Loaded"] then
        HealBot_Init_Spells_Defaults()
        HealBot_Options_InitDebuffTypes()
        HealBot_InitSmartCast()
        HealBot_Options_InitBuffList()
        HealBot_Options_ComboClass_Text()
        HealBot_Options_BarFreq_setVars()
        HealBot_Options_FluidFlashInUse()
        HealBot_Action_SetFocusGroups()
        HealBot_Options_AuxBarFlashAlphaMinMaxSet()
        HealBot_Options_Buff_Reset()
        HealBot_Aura_ConfigClassHoT()
        HealBot_Aura_ResetBuffCache()
        HealBot_Options_Debuff_Reset()
        HealBot_Options_setDebuffPriority()
        HealBot_Action_ResetAllButtons()
        HealBot_Aura_InitData()
        HealBot_Action_setAdaptive()
        HealBot_Register_Events()
        HealBot_PartyUpdate_CheckSkin(true)
        HealBot_Options_SetSkins()
        HealBot_Options_setAuxBars()
        HealBot_UpdateAllAuxBars()
        HealBot_Action_ResetFrameAlias()
        HealBot_RefreshTypes[0]=true
    end
    HealBot_CheckUnitRange=HealBot_CheckUnitRangeIC
    HealBot_OnEvent_PlayerRegenDisabled();
    HealBot_UpdateLocalUILock(true)
    if HealBot_luVars["VarsLoaded"] and not HealBot_luVars["Loaded"] then
        HealBot_Timers_PowerIndicator()
        HealBot_updAllThreat()
        HealBot_Timers_Set("OOC","FullReload",1)
    end
end

function HealBot_EventRegenEnabled()
    HealBot_UpdateLocalUILock(false)
    HealBot_CheckUnitRange=HealBot_CheckUnitRangeOOC
end

function HealBot_EventRosterUpdate()
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin",0.05)
    HealBot_OnEvent_PartyMembersChanged();
end

function HealBot_EventTargetUpdate()
    HealBot_luVars["TargetNeedReset"]=true
    HealBot_OnEvent_PlayerTargetChanged()
end

function HealBot_EventModifierChange()
    HealBot_Action_SetCurrentModKeys()
    if HealBot_Data["TIPBUTTON"] then 
        HealBot_Action_RefreshTooltip()
--        HealBot_AddDebug("RefreshTooltip","Tooltip",true)
    elseif HealBot_Data["TIPICON"] then
        HealBot_Tooltip_UpdateIconTooltip()
    end
    if not HealBot_Data["UILOCK"] then HealBot_Action_ModKey() end
    HealBot_UpdateAllRangeSpells()
end

function HealBot_EventPlayerCheck()
    HealBot_Timers_Set("AURA","PlayerCheckExtended")
end

function HealBot_EventCursorChanged(isDefault, newCursorType)
    HealBot_Options_CursorChanged(isDefault, newCursorType)
    HealBot_ActionIcons_CursorChanged(isDefault, newCursorType)
end

function HealBot_EventUnitRoleChange()
    HealBot_OnEvent_PartyMembersChanged()
    HealBot_Timers_Set("AURA","ResetClassIconTexture",0.05)
end

function HealBot_EventUnitEnteredVehicle(unitTarget)
    HealBot_OnEvent_VehicleChange(unitTarget, true)
end

function HealBot_EventUnitExitedVehicle(unitTarget)
    HealBot_OnEvent_VehicleChange(unitTarget, false)
end

function HealBot_EventInspectReady(inspecteeGUID)
    eButton,ePrivate = HealBot_Panel_AllUnitButton(inspecteeGUID)
    if eButton then
        HealBot_GetTalentInfo(eButton) 
    end
    if ePrivate then
        HealBot_GetTalentInfo(ePrivate)
    end
    HealBot_luVars["TalentQueryEnd"]=HealBot_TimeNow
end

function HealBot_EventZoneChange()
    HealBot_Timers_Set("LAST","CheckZone")
end

function HealBot_EventSubZoneChange()
    HealBot_Timers_Set("LAST","CheckSubZone")
end

function HealBot_EventPetBattleStart()
    HealBot_luVars["lastPetBattleEvent"]="PET_BATTLE_OPENING_START"
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
end

function HealBot_EventPetBattleOver()
    HealBot_luVars["lastPetBattleEvent"]="PET_BATTLE_OVER"
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
end

function HealBot_EventReadyCheckFinished()
    HealBot_luVars["rcEnd"]=HealBot_TimeNow+3
end

function HealBot_EventPlayerLevelSpellChange(arg1)
    HealBot_OnEvent_SpellsChanged(arg1);
    HealBot_Timers_Set("LAST","MountsPetsUse")
    HealBot_Timers_Set("PLAYER","TalentsChanged",1)
end

function HealBot_EventPlayerTalentUpdate()
    HealBot_Timers_Set("PLAYER","TalentsChanged",1)
    HealBot_OnEvent_SpellsChanged(1)
end

function HealBot_EventCheckMount()
    HealBot_Timers_Set("LAST","MountsPetsUse")
end

function HealBot_EventUIDisplayChange()
    HealBot_Timers_Set("SKINS","FramesSetPoint")
end

function HealBot_EventGuildUpdate()
    HealBot_Timers_Set("LAST","GuildUpdate")
end

function HealBot_EventUnitGuildUpdate(unitTarget)
    if UnitIsUnit(unitTarget, "player") then
        HealBot_Timers_Set("LAST","GuildUpdate")
    end
    local _,xButton,pButton = HealBot_UnitID(unitTarget)
    if xButton then HealBot_GetUnitGuild(xButton) end
    if pButton then HealBot_GetUnitGuild(pButton) end
end

local hbEventFuncs={["UNIT_SPELLCAST_SENT"]=HealBot_OnEvent_UnitSpellCastSent,
                    ["SPELL_UPDATE_COOLDOWN"]=HealBot_EventSpellCD,
                    ["SPELL_UPDATE_CHARGES"]=HealBot_EventSpellCharges,
                    ["COMBAT_LOG_EVENT_UNFILTERED"]=HealBot_OnEvent_Combat_Log,
                    ["PLAYER_REGEN_DISABLED"]=HealBot_EventRegenDisabled,
                    ["PLAYER_REGEN_ENABLED"]=HealBot_EventRegenEnabled,
                    ["GROUP_ROSTER_UPDATE"]=HealBot_EventRosterUpdate,
                    ["RAID_ROSTER_UPDATE"]=HealBot_EventRosterUpdate,
                    ["RAID_TARGET_UPDATE"]=HealBot_OnEvent_RaidTargetUpdateAll,
                    ["PLAYER_TARGET_CHANGED"]=HealBot_EventTargetUpdate,
                    ["PLAYER_FOCUS_CHANGED"]=HealBot_OnEvent_FocusChanged,
                    ["MODIFIER_STATE_CHANGED"]=HealBot_EventModifierChange,
                    ["UNIT_PET"]=HealBot_OnEvent_PetsChanged,
                    ["PLAYER_CONTROL_GAINED"]=HealBot_EventPlayerCheck,
                    ["PLAYER_CONTROL_LOST"]=HealBot_EventPlayerCheck,
                    ["PLAYER_UPDATE_RESTING"]=HealBot_EventPlayerCheck,
                    ["CURSOR_CHANGED"]=HealBot_EventCursorChanged,
                    ["ROLE_CHANGED_INFORM"]=HealBot_EventUnitRoleChange,
                    ["PLAYER_ROLES_ASSIGNED"]=HealBot_EventUnitRoleChange,
                    ["INCOMING_SUMMON_CHANGED"]=HealBot_OnEvent_IncomingSummons,
                    ["PLAYER_MOUNT_DISPLAY_CHANGED"]=HealBot_EventPlayerCheck,
                    ["UNIT_ENTERED_VEHICLE"]=HealBot_EventUnitEnteredVehicle,
                    ["UNIT_EXITED_VEHICLE"]=HealBot_EventUnitExitedVehicle,
                    ["INSPECT_READY"]=HealBot_EventInspectReady,
                    ["ZONE_CHANGED_NEW_AREA"]=HealBot_EventZoneChange,
                    ["ZONE_CHANGED"]=HealBot_EventSubZoneChange,
                    ["ZONE_CHANGED_INDOORS"]=HealBot_EventSubZoneChange,
                    ["CHAT_MSG_ADDON"]=HealBot_OnEvent_AddonMsg,
                    ["BAG_UPDATE"]=HealBot_OnEvent_InvChange,
                    ["PLAYER_EQUIPMENT_CHANGED"]=HealBot_OnEvent_InvChange,
                    ["PET_BATTLE_OPENING_START"]=HealBot_EventPetBattleStart,
                    ["PET_BATTLE_OVER"]=HealBot_EventPetBattleOver,
                    ["READY_CHECK"]=HealBot_OnEvent_ReadyCheck,
                    ["READY_CHECK_CONFIRM"]=HealBot_OnEvent_ReadyCheckConfirmed,
                    ["READY_CHECK_FINISHED"]=HealBot_EventReadyCheckFinished,
                    ["PLAYER_ENTERING_WORLD"]=HealBot_OnEvent_PlayerEnteringWorld,
                    ["PLAYER_LEAVING_WORLD"]=HealBot_OnEvent_PlayerLeavingWorld,
                    ["LEARNED_SPELL_IN_TAB"]=HealBot_EventPlayerLevelSpellChange,
                    ["PLAYER_LEVEL_UP"]=HealBot_EventPlayerLevelSpellChange,
                    ["PLAYER_TALENT_UPDATE"]=HealBot_EventPlayerTalentUpdate,
                    ["CHARACTER_POINTS_CHANGED"]=HealBot_EventPlayerTalentUpdate,
                    ["TRAIT_CONFIG_UPDATED"]=HealBot_EventPlayerTalentUpdate,
                    ["PLAYER_SPECIALIZATION_CHANGED"]=HealBot_EventPlayerTalentUpdate,
                    ["ACTIVE_TALENT_GROUP_CHANGED"]=HealBot_EventPlayerTalentUpdate,
                    ["COMPANION_LEARNED"]=HealBot_EventCheckMount,
                    ["NEW_MOUNT_ADDED"]=HealBot_EventCheckMount,
                    ["VARIABLES_LOADED"]=HealBot_OnEvent_VariablesLoaded,
                    ["ADDON_LOADED"]=HealBot_OnEvent_AddOnLoaded,
                    ["GET_ITEM_INFO_RECEIVED"]=HealBot_OnEvent_ItemInfoReceived,
                    ["DISPLAY_SIZE_CHANGED"]=HealBot_EventUIDisplayChange,
                    ["UI_SCALE_CHANGED"]=HealBot_EventUIDisplayChange,
                    ["PLAYER_GUILD_UPDATE"]=HealBot_EventUnitGuildUpdate,
                   }
function HealBot_OnEvent(self, event, ...)
    --HealBot_AddDebug("Event "..event,"events",true)
    hbEventFuncs[event](...)
end

--[[

  HealBot Contined
    
]]

local HealBot_Loaded=nil
local HealBot_IamRessing = nil;
local HealBot_RequestVer=nil;
local HealBot_BarCheck = {};
local HealBot_CheckTalents=GetTime()
local HealBot_Player_HoT={};
local HealBot_Player_HoT_Icons={};
local HealBot_Watch_HoT={};
local HealBot_HoT_Count={};
local HealBot_InCombatUpdate=false
local HealBot_SmartCast_Spells={};
local HealBot_AddonMsgType=3;
local HealBot_HoT_Texture={};
local HealBot_SpamCnt=0;
local HealBot_SpamCut={}
local HealBot_Ressing = {};
local HealBot_RessingCD = {};
local HealBot_DelayBuffCheck = {};
local HealBot_DelayDebuffCheck = {};
local HealBot_DelayAuraBCheck = {};
local HealBot_DelayAuraDCheck = {};
local HealBot_Vers={}
local HealBot_CTRATanks={};
local HealBot_MainTanks={};
local HealBot_MainAssists={};
local HealBot_CastingTarget = "player";
local i=nil
local w=nil
local x=nil
local y=nil
local z=nil
local strfind=strfind
local strsub=strsub
local gsub=gsub
local HealBot_ThrottleTh=9
local HealBot_ThrottleCnt=HealBot_ThrottleTh*4
local HealBot_Reset_flag=nil
local HB_Timer1=0.01
local HB_Timer2=0.2
local HB_Timer3=0.5
local HealBot_UpUnitInCombat={}
local HealBot_InCombatUpdCnt=0
local HealBot_InCombatUpdCntFlag=nil
local k=nil
local s=nil
local HealBot_BuffNameSwap = {}   
local HealBot_BuffNameSwap2 = {}         
local HealBot_VehicleCheck={};   
local HealBot_ReCheckBuffsTime=nil
local HealBot_ReCheckBuffsTimed={}
local HealBot_cleanGUIDs={}
local HealBot_HealsAbsorb={}
local hbInsName=HEALBOT_WORD_OUTSIDE
local _, spellId, skillType, r = nil,nil,nil,nil
local HealBot_Ignore_Class_Debuffs = {
    ["WARR"] = { [HEALBOT_DEBUFF_ANCIENT_HYSTERIA] = true,    
                          [HEALBOT_DEBUFF_IGNITE_MANA] = true, 
                          [HEALBOT_DEBUFF_TAINTED_MIND] = true, 
                          [HEALBOT_DEBUFF_VIPER_STING] = true,
                          [HEALBOT_DEBUFF_IMPOTENCE] = true,
                          [HEALBOT_DEBUFF_DECAYED_INT] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["ROGU"] = {   [HEALBOT_DEBUFF_SILENCE] = true,    
                          [HEALBOT_DEBUFF_ANCIENT_HYSTERIA] = true, 
                          [HEALBOT_DEBUFF_IGNITE_MANA] = true, 
                          [HEALBOT_DEBUFF_TAINTED_MIND] = true, 
                          [HEALBOT_DEBUFF_VIPER_STING] = true,
                          [HEALBOT_DEBUFF_IMPOTENCE] = true,
                          [HEALBOT_DEBUFF_DECAYED_INT] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["HUNT"] = {  [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true, 
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["MAGE"] = {    [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true, 
                          [HEALBOT_DEBUFF_DECAYED_STR] = true,
                          [HEALBOT_DEBUFF_CRIPPLE] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["DRUI"] = {   [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["PALA"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["PRIE"] = {  [HEALBOT_DEBUFF_DECAYED_STR] = true,
                          [HEALBOT_DEBUFF_CRIPPLE] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["SHAM"] = {  [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["WARL"] = { [HEALBOT_DEBUFF_DECAYED_STR] = true,
                          [HEALBOT_DEBUFF_CRIPPLE] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["DEAT"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["MONK"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
};

local HealBot_Ignore_Movement_Debuffs = {
                                  [HEALBOT_DEBUFF_FROSTBOLT] = true,
                                  [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true,
                                  [HEALBOT_DEBUFF_SLOW] = true,
                                  [HEALBOT_DEBUFF_CHILLED] = true,
                                  [HEALBOT_DEBUFF_CONEOFCOLD] = true,
                                  [HEALBOT_DEBUFF_CONCUSSIVESHOT] = true,
                                  [HEALBOT_DEBUFF_HOWLINGSCREECH] = true,
                                  [HEALBOT_DEBUFF_FROST_SHOCK] = true,
};

local HealBot_Ignore_NonHarmful_Debuffs = {
                                  [HEALBOT_DEBUFF_HUNTERS_MARK] = true,
                                  [HEALBOT_DEBUFF_MAJOR_DREAMLESS] = true,
                                  [HEALBOT_DEBUFF_GREATER_DREAMLESS] = true,
                                  [HEALBOT_DEBUFF_DREAMLESS_SLEEP] = true,
};

local HealBot_Timer1,HealBot_Timer2,HealBot_Timer3 = 0,0,0;
local Ti=nil
local inc_msg=nil
local datatype=nil
local datamsg=nil
local sender=nil
local arr=nil
local arrg = {}
local HoTActive=nil
local DebuffType=nil
local debuff_type=nil
local dName=nil
local HealBot_Ignore_Debuffs_Class=nil
local bName=nil
local PlayerBuffs = {}
local HealBot_dSpell=HEALBOT_HEAVY_RUNECLOTH_BANDAGE
local bar=nil
local iconName=nil
local id=0
local sID=nil
local sName=nil
local sRank=nil
local uName=nil
local xUnit=nil
local xGUID = nil
local utGUID=nil
local uClass=nil
local LSM = LibStub("LibSharedMedia-3.0")
local TalentQuery = LibStub:GetLibrary("LibTalentQuery-1.0")
local HealBot_PlayerBuff={}
local HealBot_CheckBuffs = {}
local HealBot_ShortBuffs = {}
local HealBot_CheckBuffsTime=nil
local HealBot_CheckBuffsTimehbGUID=nil
local HealBot_QueueCheckBuffs={}
local PlayerBuffsGUID=nil
local huUnit,huHoTtime,huHoTicon=nil,nil,nil
local HealBot_TrackWS={}
local HealBot_BuffWatch={}
local HealBot_DeBuff_Texture={}
local iTexture, bCount, expirationTime, caster, spellID=nil,nil,nil,nil,nil
local DeBuff_Count={}
local HealBot_unitHealth={}
local HealBot_unitHealthMax={}
local BuffClass=nil
local HasWeaponBuff=false
local CheckWeaponBuffs={[HEALBOT_ROCKBITER_WEAPON]=true, 
                        [HEALBOT_FLAMETONGUE_WEAPON]=true, 
                        [HEALBOT_EARTHLIVING_WEAPON]=true, 
                        [HEALBOT_WINDFURY_WEAPON]=true,
                        [HEALBOT_FROSTBRAND_WEAPON]=true,}
local CooldownBuffs={[HEALBOT_FEAR_WARD]=true, 
                     [HEALBOT_PAIN_SUPPRESSION]=true, 
                     [HEALBOT_POWER_INFUSION]=true,
                     [HEALBOT_DIVINE_PLEA]=true,
                     [HEALBOT_DIVINE_FAVOR]=true,
                     [HEALBOT_NATURES_GRASP]=true,}
local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
local HealBot_VehicleUnit={}
local HealBot_UnitInVehicle={}
local hGUID=nil
local hUnit=nil
local vGUID=nil
local vUnit=nil
local tGUID=nil
local HBvUnits=nil
local HealBot_TargetIcons={}
local HealBot_PetGUID={}
local HealBot_debuffTargetIcon={}
local hotName=nil
local HealBot_luVars={}
local HealBot_endAggro={}
local HealBot_notVisible={}
local HealBot_CustomDebuff_RevDurLast={}
local hbManaPlayers={}
local hbCurLowMana={}
local HealBot_UnitAbsorbs={}
local mana,maxmana=0,0
local calibrateHBScale, hbScale = 0,0

function HealBot_UpdTargetUnitID(unit)
    HealBot_luVars["TargetUnitID"]=unit
end

function HealBot_Check_WeaponBuffs(spellName)
    if CheckWeaponBuffs[spellName] then
        HealBot_luVars["WeaponBuffCheck"]=3
    end
end

--function HealBot_setluVar(key,value)
--    HealBot_luVars[key]=value
--end

function HealBot_setNotVisible(hbGUID,unit)
    HealBot_notVisible[hbGUID]=unit
end

function HealBot_Clear_BuffWatch()
    for x,_ in pairs(HealBot_BuffWatch) do
        HealBot_BuffWatch[x]=nil;
    end
end

function HealBot_Set_BuffWatch(buffName)
    table.insert(HealBot_BuffWatch,buffName);
end

function HealBot_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Set_CheckBuffs(buffName)
    if not CheckWeaponBuffs[buffName] and not CooldownBuffs[buffName] and not HealBot_CheckBuffs[buffName] then
        HealBot_CheckBuffs[buffName]=buffName;
    end
end

function HealBot_Set_debuffSpell(debuffName)
    HealBot_dSpell=debuffName
end

function HealBot_Queue_MyBuffsCheck(hbGUID,unit)
    if UnitIsPlayer(unit) then
        HealBot_QueueCheckBuffs[hbGUID]=unit
    end
end

local function HealBot_Queue_AllActiveMyBuffs()
    for z,y in pairs(HealBot_UnitID) do
        HealBot_Queue_MyBuffsCheck(z,y)
    end
end

function HealBot_RetMyBuffTime(hbGUID,buffName)
    if not HealBot_PlayerBuff[hbGUID] or not HealBot_PlayerBuff[hbGUID][buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return HealBot_PlayerBuff[hbGUID][buffName]+HealBot_Config.ShortBuffTimer
    else
        return HealBot_PlayerBuff[hbGUID][buffName]+HealBot_Config.LongBuffTimer
    end
end

function HealBot_retHealBot_MainTanks()
    return HealBot_MainTanks
end

function HealBot_retHealBot_CTRATanks()
    return HealBot_CTRATanks
end

function HealBot_retHealBot_MainAssists()
    return HealBot_MainAssists
end

function HealBot_retHealBot_UseCrashProtection()
    return HealBot_luVars["UseCrashProtection"]
end

function HealBot_rethbInsName()
    return hbInsName
end

function HealBot_cpQueue(id, mName, mBody)
    HealBot_luVars["cpMacro"]=GetTime()+8
    if id==0 then
        HealBot_luVars["cpSave0"]=true
        HealBot_luVars["cpName0"]=mName
        HealBot_luVars["cpBody0"]=mBody
    elseif id==1 then
        HealBot_luVars["cpSave1"]=true
        HealBot_luVars["cpName1"]=mName
        HealBot_luVars["cpBody1"]=mBody
    elseif id==2 then
        HealBot_luVars["cpSave2"]=true
        HealBot_luVars["cpName2"]=mName
        HealBot_luVars["cpBody2"]=mBody
    elseif id==3 then
        HealBot_luVars["cpSave3"]=true
        HealBot_luVars["cpName3"]=mName
        HealBot_luVars["cpBody3"]=mBody
    else
        HealBot_luVars["cpSave4"]=true
        HealBot_luVars["cpName4"]=mName
        HealBot_luVars["cpBody4"]=mBody
    end
end

local function HealBot_cpSaveAll()
    HealBot_luVars["cpMacro"]=nil
    if HealBot_luVars["cpSave0"] then
        HealBot_luVars["cpSave0"]=nil
        HealBot_cpSave(HealBot_luVars["cpName0"], HealBot_luVars["cpBody0"])
    end
    if HealBot_luVars["cpSave1"] then
        HealBot_luVars["cpSave1"]=nil
        HealBot_cpSave(HealBot_luVars["cpName1"], HealBot_luVars["cpBody1"])
    end
    if HealBot_luVars["cpSave2"] then
        HealBot_luVars["cpSave2"]=nil
        HealBot_cpSave(HealBot_luVars["cpName2"], HealBot_luVars["cpBody2"])
    end
    if HealBot_luVars["cpSave3"] then
        HealBot_luVars["cpSave3"]=nil
        HealBot_cpSave(HealBot_luVars["cpName3"], HealBot_luVars["cpBody3"])
    end
    if HealBot_luVars["cpSave4"] then
        HealBot_luVars["cpSave4"]=nil
        HealBot_cpSave(HealBot_luVars["cpName4"], HealBot_luVars["cpBody4"])
    end
    HBmsg=HEALBOT_CP_MACRO_SAVE.."   "..date("%H:%M:%S", time())
    HealBot_Options_cpMacroSave:SetText(HBmsg)
    HealBot_Options_SetcpMacroSave(HBmsg)
end

function HealBot_cpSave(mName, mBody)
    z=GetMacroIndexByName(mName)
    if (z or 0) == 0 then
        z = CreateMacro(mName, 12, mBody, 1)
    else
        z = EditMacro(z, mName, 12, mBody)
    end
end

function HealBot_SetResetFlag(mode)
    if mode=="HARD" then
        ReloadUI()
    else
        HealBot_Reset_flag=1
    end
end

function HealBot_AltBuffNames(buffName)
    return HealBot_BuffNameSwap[buffName]
end

function HealBot_GetHealBot_AddonMsgType()
    return HealBot_AddonMsgType;
end

function HealBot_RetHealBot_Ressing(hbGUID)
    return HealBot_Ressing[hbGUID] or HealBot_RessingCD[hbGUID];
end

function HealBot_UnsetHealBot_Ressing(hbGUID)
    HealBot_Ressing[hbGUID]=nil;
    HealBot_RessingCD[hbGUID]=nil;
end

function HealBot_TooltipInit()
    if ( HealBot_ScanTooltip:IsOwned(HealBot) ) then return; end;
    HealBot_ScanTooltip:SetOwner(HealBot, 'ANCHOR_NONE' );
    HealBot_ScanTooltip:ClearLines();
end

function HealBot_AddChat(HBmsg)
    DEFAULT_CHAT_FRAME:AddMessage(HBmsg, 0.7, 0.7, 1.0);
end

function HealBot_AddDebug(HBmsg)
    local hbDebugChan=HealBot_Comms_GetChan("HBmsg");
    if (HealBot_SpamCut[HBmsg] or 0)<GetTime() and hbDebugChan and HealBot_SpamCnt < 28 then
        HealBot_SpamCnt=HealBot_SpamCnt+1;  
        HealBot_SpamCut[HBmsg]=GetTime()+2;        
        HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
        SendChatMessage(HBmsg , "CHANNEL", nil, hbDebugChan);
    end
end

--function HealBot_AddError(HBmsg)
--    UIErrorsFrame:AddMessage(HBmsg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
--    HealBot_AddDebug(HBmsg);
--end

function HealBot_TogglePanel(HBpanel)
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HideUIPanel(HBpanel);
    else
        ShowUIPanel(HBpanel);
    end
end

function HealBot_StartMoving(HBframe)
    if ( not HBframe.isMoving ) and ( HBframe.isLocked ~= 1 ) then
        HBframe:StartMoving();
        HBframe.isMoving = true;
    end
end

function HealBot_StopMoving(HBframe,ActionFrame)
    if ( HBframe.isMoving ) then
        HBframe:StopMovingOrSizing();
        HBframe.isMoving = false;
    end
    if ActionFrame then
        HealBot_CheckActionFrame()
    end
end

function HealBot_CheckActionFrame()
    if HealBot_Config.DisabledNow==1 then return end
    if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-20 or Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-20 then 
        Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=ceil(GetScreenHeight()/2);
        Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=ceil(GetScreenWidth()/2); 
    else
        if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetTop();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetLeft()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetBottom();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetLeft()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetTop();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetRight()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetBottom();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetRight()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==5 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetTop();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetCenter()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==6 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = ceil((HealBot_Action:GetTop()+HealBot_Action:GetBottom())/2);
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetLeft()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==7 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = ceil((HealBot_Action:GetTop()+HealBot_Action:GetBottom())/2);
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetRight()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==8 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetBottom();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetCenter()
        end
    end
    HealBot_CheckFrame()
end

function HealBot_CheckFrame()
    if HealBot_Config.DisabledNow==1 then return end
    if not GetScreenWidth() or not Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin] then return end
    if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-9 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=-9
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+12 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+12
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-9 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=-9
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+8) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+8
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+12 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+12
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+8) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+8
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==5 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<1 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=1
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+1) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+1
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==6 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-9 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=-9
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=1 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+1
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==7 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+8) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+8
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=1 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+1
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==8 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<1 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=1
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+1) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+1
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    end
end

function HealBot_SlashCmd(HBcmd)
    if not HBcmd then HBcmd="" end
    HBcmd, x, y, z = string.split(" ", HBcmd)
    HBcmd=string.lower(HBcmd) 
    if (HBcmd=="") then
        HealBot_TogglePanel(HealBot_Action);
    elseif (HBcmd=="o" or HBcmd=="options" or HBcmd=="opt" or HBcmd=="config" or HBcmd=="cfg") then
        HealBot_TogglePanel(HealBot_Options);
    elseif (HBcmd=="d" or HBcmd=="defaults") then
        HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults);
    elseif (HBcmd=="ui") then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_HARDRELOAD)
        HealBot_SetResetFlag("HARD")
    elseif (HBcmd=="ri" or (HBcmd=="reset" and x and string.lower(x)=="healbot")) then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SOFTRELOAD)
        HealBot_SetResetFlag("SOFT")
    elseif (HBcmd=="rc" or (HBcmd=="reset" and x and string.lower(x)=="customdebuffs")) then
        HealBot_Reset_flag=2
    elseif (HBcmd=="rs" or (HBcmd=="reset" and x and string.lower(x)=="skin")) then
        HealBot_Reset_flag=3
    elseif (HBcmd=="info" or HBcmd=="ver" or HBcmd=="status") then
        HealBot_Comms_Info()
    elseif (HBcmd=="show") then
        HealBot_Action_Reset()
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
    elseif (HBcmd=="disable") then
        HealBot_Options_DisableHealBotOpt:SetChecked(1)
        HealBot_Options_DisableHealBot(1)
    elseif (HBcmd=="enable") then
        HealBot_Options_DisableHealBotOpt:SetChecked(0)
        HealBot_Options_DisableHealBot(0)
    elseif (HBcmd=="t") then
        if HealBot_Config.DisabledNow==0 then
            HealBot_Options_DisableHealBotOpt:SetChecked(1)
            HealBot_Options_DisableHealBot(1)
        else
            HealBot_Options_DisableHealBotOpt:SetChecked(0)
            HealBot_Options_DisableHealBot(0)
        end
    elseif (HBcmd=="tinfo") then
        if UnitExists("target") then
            HealBot_Comms_TargetInfo()
        else
            HealBot_AddDebug( "No Target" );
        end
    elseif (HBcmd=="comms") then
        HealBot_Comms_Zone()
    elseif (HBcmd=="help" or HBcmd=="h") then
        HealBot_luVars["HelpCnt1"]=0
    elseif (HBcmd=="hs") then
        HealBot_luVars["HelpCnt2"]=0
    elseif (HBcmd=="skin" and x) then
        if y then x=x.." "..y end
        if z then x=x.." "..z end
        HealBot_Options_Set_Current_Skin(x)
    elseif (HBcmd=="ss" and x and y) then
        HealBot_Options_ShareSkinSend("A", x, y)
    elseif (HBcmd=="as") then
        HealBot_ToggleAcceptSkins()
    elseif (HBcmd=="use10") then
        if HealBot_Config.MacroUse10==1 then
            HealBot_Config.MacroUse10=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10OFF)
        else
            HealBot_Config.MacroUse10=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10ON)
        end
    elseif (HBcmd=="suppress" and x) then
        x=string.lower(x)
        HealBot_ToggleSuppressSetting(x)
    elseif (HBcmd=="test" and x) then
        if tonumber(x) and tonumber(x)>4 and tonumber(x)<51 then
            HealBot_TestBars(x)
        end
    elseif (HBcmd=="tr" and x) then
        HealBot_Panel_SethbTopRole(x)
    elseif (HBcmd=="ssp") then
        HealBot_Panel_SetSubSortPlayer()
    elseif (HBcmd=="spt") then
        if Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]==1 then
            Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSOFF)
        else
            Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSON)
        end
        if Delay_RecalcParty<1 then Delay_RecalcParty=1; end
    elseif (HBcmd=="ws") then
        if HealBot_Globals.ShowWSicon==1 then
            HealBot_Globals.ShowWSicon=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_DEBUFF_WEAKENED_SOUL.." - "..HEALBOT_WORD_OFF)
        else
            HealBot_Globals.ShowWSicon=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_DEBUFF_WEAKENED_SOUL.." - "..HEALBOT_WORD_ON)
        end
    elseif (HBcmd=="cp") then
        if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then
            Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]=0
        else
            Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]=1
        end
    elseif (HBcmd=="bt") then
        if HealBot_Config.BuffWatch==1 then
            HealBot_Config.BuffWatch=0
        else
            HealBot_Config.BuffWatch=1
        end
        HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config.BuffWatch)
        HealBot_Options_MonitorBuffs_Toggle()
    elseif (HBcmd=="dt") then
        if HealBot_Config.DebuffWatch==1 then
            HealBot_Config.DebuffWatch=0
        else
            HealBot_Config.DebuffWatch=1
        end
        HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config.DebuffWatch)
        HealBot_Options_MonitorDebuffs_Toggle()
    elseif (HBcmd=="pcs" and x) then
		if (tonumber(x)<25) and ((Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin]-tonumber(x))>0) then
			HealBot_Globals.PowerChargeTxtSizeMod=tonumber(x)
			HealBot_SetResetFlag("SOFT")
		end
	elseif (HBcmd=="debug") then
		if CanInspect("target") then HealBot_TalentQuery("target") end
    elseif (HBcmd=="rld" and x) then
        if tonumber(x) and tonumber(x)>0 and tonumber(x)<=30 then
            HealBot_Globals.ResLagDuration=ceil(x)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESLAG_INDICATOR.." "..ceil(x).." "..HEALBOT_WORDS_SEC)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESLAG_INDICATOR_ERROR)
        end
    elseif (HBcmd=="flb") then
        if HealBot_Globals.ByPassLock==1 then
            HealBot_Globals.ByPassLock=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_FRAMELOCK_BYPASS_OFF)
        else
            HealBot_Globals.ByPassLock=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_FRAMELOCK_BYPASS_ON)
        end
    elseif (HBcmd=="rtb") then
        if HealBot_Globals.TargetBarRestricted==1 then
            HealBot_Globals.TargetBarRestricted=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESTRICTTARGETBAR_OFF)
        else
            HealBot_Globals.TargetBarRestricted=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESTRICTTARGETBAR_ON)
        end
    elseif (HBcmd=="plo") then
        if HealBot_Globals.preloadOptions==1 then
            HealBot_Globals.preloadOptions=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_PRELOADOPTIONS_OFF)
        else
            HealBot_Globals.preloadOptions=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_PRELOADOPTIONS_ON)
        end
        HealBot_Options_idleInitMod()
    elseif (HBcmd=="dm") then
        if HealBot_Action_retFuncUse()=="YES" then HealBot_MountsPets_DislikeMount() end
    elseif (HBcmd=="afr") then
        HealBot_AddChat("qaFR="..HealBot_luVars["qaFR"])
    elseif (HBcmd=="aggro" and x and y) then
        if tonumber(x) and tonumber(x)==2 then
            if tonumber(y) and tonumber(y)>24 and tonumber(x)<96 then
                HealBot_Globals.aggro2pct=tonumber(y)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO2_SET_MSG..y)
            else
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO2_ERROR_MSG)
            end
        elseif tonumber(x) and tonumber(x)==3 then
            if tonumber(y) and tonumber(y)>74 and tonumber(y)<101 then
                HealBot_Globals.aggro3pct=tonumber(y)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO3_SET_MSG..y)
            else
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO3_ERROR_MSG)
            end
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO_ERROR_MSG)
        end
    elseif (HBcmd=="calistats") then
        local hbcaliSoft, hbcaliCount, hbcaliReset, hbcaliPtc = HealBot_Range_calibrateStats()
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Range calibration - SoftCount = "..hbcaliSoft)
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Range calibration - Count = "..hbcaliCount)
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Range calibration - Reset = "..hbcaliReset)
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Range calibration - %Calibrated = "..hbcaliPtc)
    elseif (HBcmd=="lang" and x) then
        HealBot_Options_Lang(x)
    elseif (HBcmd=="cw") then  -- Clear Warnings
        HealBot_Globals.OneTimeMsg={}
    elseif (HBcmd=="test") then
        local i = GetSpecialization()
        local sID, s = 0,"None"
        if i then
            sID, s = GetSpecializationInfo(i,false,false) 
        end
        HealBot_AddDebug("Spec ID="..sID.." Name="..s)
    else
        if x then HBcmd=HBcmd.." "..x end
        if y then HBcmd=HBcmd.." "..y end
        if z then HBcmd=HBcmd.." "..z end
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_UNKNOWNCMD..HBcmd)
        HealBot_luVars["HelpCnt1"]=0
    end
end

function HealBot_setResetFlagCode(resetCode)
    HealBot_Reset_flag=resetCode
end

function HealBot_ToggleAcceptSkins()
    if HealBot_Globals.AcceptSkins==1 then
        HealBot_Globals.AcceptSkins=0
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ACCEPTSKINOFF)
    else
        HealBot_Globals.AcceptSkins=1
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ACCEPTSKINON)
    end
    HealBot_Comms_AcceptSkins()
end

function HealBot_ToggleSuppressSetting(settingType)
    if settingType=="sound" then
        if HealBot_Globals.MacroSuppressSound==1 then
            HealBot_Globals.MacroSuppressSound=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDON)
        else
            HealBot_Globals.MacroSuppressSound=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDOFF)
        end
        HealBot_Action_SetAllAttribs()
        HealBot_Comms_MacroSuppressSound()
    elseif settingType=="error" then
        if HealBot_Globals.MacroSuppressError==1 then
            HealBot_Globals.MacroSuppressError=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERRORON)
        else
            HealBot_Globals.MacroSuppressError=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERROROFF)
        end
        HealBot_Action_SetAllAttribs()
        HealBot_Comms_MacroSuppressError()
    end
end

function HealBot_TestBars(noBars)
    local numBars=noBars or HealBot_Globals.noTestBars
    HealBot_Panel_SetNumBars(numBars)
    HealBot_Panel_ToggleTestBars()
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_Reset()
    HealBot_UnRegister_Events()
    HB_Timer1=0.04
    HB_Timer2=0.1
    HB_Timer3=0.2
    HealBot_Panel_ClearBlackList()
    HealBot_Panel_ClearHealTarget()
    HealBot_Action_ResethbInitButtons()
    HealBot_ClearAggro(true)
    HealBot_Panel_ClearBarArrays()
    HealBot_Loaded=1
    HealBot_setOptions_Timer(150)
    HealBot_PlayerGUID=nil
 --   HealBot_Load("hbReset") 
    HealBot_setOptions_Timer(420)
    HealBot_setOptions_Timer(7950)
end

function HealBot_ResetCustomDebuffs()
    HealBot_Globals.HealBot_Custom_Debuffs = HealBot_GlobalsDefaults.HealBot_Custom_Debuffs
    HealBot_Globals.Custom_Debuff_Categories = HealBot_GlobalsDefaults.Custom_Debuff_Categories
    HealBot_Globals.FilterCustomDebuff = HealBot_GlobalsDefaults.FilterCustomDebuff
    for s in pairs(HealBot_Globals.CDCBarColour) do
        if not HealBot_GlobalsDefaults.CDCBarColour[s] then
            HealBot_Globals.CDCBarColour[s]=nil
        end
    end
    HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en]=HealBot_GlobalsDefaults.CDCBarColour[HEALBOT_CUSTOM_en]
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
end

function HealBot_ResetSkins()
    Healbot_Config_Skins = HealBot_Config_SkinsDefaults
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Config.LastVersionSkinUpdate="0.1"
    HealBot_Reset_flag=1
end

function HealBot_Reset_Unit(hbGUID)
    HealBot_Action_ClearUnitDebuffStatus(hbGUID)
    HealBot_ClearAllBuffs(hbGUID)
    HealBot_ClearAllDebuffs(hbGUID)
    HealBot_Reset_UnitHealth(hbGUID)
    if HealBot_UnitID[hbGUID] then
        HealBot_ClearUnitAggro(HealBot_UnitID[hbGUID], hbGUID)
        HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
    end
    if HealBot_Action_RetMyTarget(hbGUID) then  HealBot_Action_Toggle_Enabled(hbGUID); end
end

function HealBot_GetSpellName(id)
    if (not id) then return nil end
    local sName, sRank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo(id);
    if (not sName) then
        return nil;
    end
    return sName, sRank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange
end

function HealBot_GetSpellId(spellName)
    if (not spellName) then return nil end
    if (HealBot_PlayerClassTrim=="SHAM") then
        if (strsub(GetLocale(),1,2)=="en") then
            if (spellName==HEALBOT_PURIFY_SPIRIT and HealBot_Config.CurrentSpec~=3) or (spellName==HEALBOT_CLEANSE_SPIRIT and HealBot_Config.CurrentSpec==3) then
                return nil
            end
        end
    end
    if HealBot_Spells[spellName] and HealBot_Spells[spellName].id and HealBot_Spells[spellName].Level then   
        sName = GetSpellInfo(HealBot_Spells[spellName].id)
        if spellName == sName then
            if tonumber(HealBot_Spells[spellName].Level)<=UnitLevel("player") then
                return HealBot_Spells[spellName].id; 
            else
                return nil
            end
        elseif not HealBot_Globals.OneTimeMsg[spellName] and (strsub(GetLocale(),1,2)=="en") then
            HealBot_Globals.OneTimeMsg[spellName]=true
            HealBot_AddChat("HealBot: Invalid spellID for "..spellName.." - Please report to "..HEALBOT_ABOUT_URL)
        end   
    end
    _, spellId = GetSpellBookItemInfo(spellName)
	if spellId and not IsSpellKnown(spellId) then return nil end
    return spellId;
end

function HealBot_UnitHealth(hbGUID, unit)
    x,y=nil,nil
    if HealBot_unitHealth[hbGUID] then
        x=HealBot_unitHealth[hbGUID]
        y=HealBot_unitHealthMax[hbGUID]
    elseif unit and UnitExists(unit) and UnitHealth(unit) then
        x=UnitHealth(unit)
        y=UnitHealthMax(unit)
    end
    if not x or not y then
        x=500
        y=1000
    elseif y<1 then
        y=1
    end
    return x,y;
end

function HealBot_UnitMana(unit)
    x,y=nil,nil
    if unit and UnitExists(unit) and UnitPowerType(unit)==0 then
        x=UnitMana(unit)
        y=UnitManaMax(unit)
    end
    return x,y;
end

local dFlags = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID, COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_TYPE_PET)
local bBand = bit.band

function HealBot_OnEvent_Combat_Log(self, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
    if HealBot_unitHealth[destGUID] then
        xUnit=HealBot_UnitID[destGUID]
        if xUnit and bBand(destFlags, dFlags)>0 then
            if HealBot_HealsAbsorb[destGUID] then HealBot_IncHeals_HealsInUpdate(destGUID) end
            x=0
            y=0
            if (event == "SWING_DAMAGE") then
                x = -select(1,...)
            elseif (event == "SPELL_PERIODIC_DAMAGE" or event == "SPELL_DAMAGE" or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD") then
                x = -select(4, ...)
            elseif (event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL") then
                x = select(4, ...)
            elseif (event == "ENVIRONMENTAL_DAMAGE") then
                x = -select(2, ...)
            elseif (event == "SPELL_AURA_APPLIED") then
                if spellID==12975 then
                    x=floor(HealBot_unitHealthMax[destGUID]*0.3)
                    y=x
                elseif spellID == 469 then
                    HealBot_CheckHealth(destGUID)
                end
            elseif (event == "SPELL_AURA_REMOVED") then
                if spellID==12975 then
                    x=floor-(HealBot_unitHealthMax[destGUID]*0.3)
                    y=x
                elseif spellID == 469 then
                    HealBot_CheckHealth(destGUID)
                end
            end
            if x~=0 or y~=0 then
                HealBot_unitHealthMax[destGUID]=HealBot_unitHealthMax[destGUID]+y
                if HealBot_unitHealth[destGUID]+x>HealBot_unitHealthMax[destGUID] then
                    HealBot_unitHealth[destGUID]=HealBot_unitHealthMax[destGUID]
                else
                    HealBot_unitHealth[destGUID]=HealBot_unitHealth[destGUID]+x
                end
            --    HealBot_AddDebug("Updated hlth x="..x.."  y="..y)
                HealBot_RecalcHeals(destGUID)
                if HealBot_BarCheck[destGUID] then
                    if HealBot_BarCheck[destGUID]=="H" then 
                        HealBot_BarCheck[destGUID]="D"
                    end
                else
                    HealBot_BarCheck[destGUID]="D"
                end
            end
        end
    end
end

function HealBot_RecalcHeals(hbGUID)
    if HealBot_luVars["DoUpdates"] then
        HealBot_Action_Refresh(hbGUID);
    end
end

function HealBot_RecalcParty(HealBot_PreCombat)
    Delay_RecalcParty=0
    HealBot_Action_PartyChanged(HealBot_PreCombat, nil);
end

function HealBot_OnLoad(self)
    HealBot_PlayerClass, HealBot_PlayerClassEN=UnitClass("player")
    HealBot_PlayerClassTrim=strsub(HealBot_PlayerClassEN,1,4)
    HealBot_Init_Spells_Defaults(HealBot_PlayerClassEN);
    HealBot_PlayerRace, HealBot_PlayerRaceEN=UnitRace("player")
    HealBot_PlayerName=UnitName("player")
    HealBot:RegisterEvent("VARIABLES_LOADED");
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    SLASH_HEALBOT1 = "/healbot";
    SLASH_HEALBOT2 = "/hb";
    SlashCmdList["HEALBOT"] = function(msg)
        HealBot_SlashCmd(msg);
    end
end

local ouName=nil
local aSwitch=0

function HealBot_Set_Timers()
    if HealBot_Config.DisabledNow==0 then
        if HealBot_luVars["qaFR"]<20 then
            HB_Timer1=0.8
            HB_Timer2=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/3, 4)   
            HB_Timer3=0.5
        elseif HealBot_luVars["qaFR"]<30 then
            HB_Timer1=0.55
            HB_Timer2=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/6, 4)   
            HB_Timer3=0.25
        elseif HealBot_luVars["qaFR"]<40 then
            HB_Timer1=0.4
            HB_Timer2=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/9, 4)   
            HB_Timer3=0.2
        elseif HealBot_luVars["qaFR"]<60 then
            HB_Timer1=0.25
            HB_Timer2=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/15, 4)   
            HB_Timer3=0.1
        else
            HB_Timer1=0.1
            HB_Timer2=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/20, 4)   
            HB_Timer3=0.05
        end
        HealBot_AddDebug("qaFR="..HealBot_luVars["qaFR"])
    else
        HB_Timer1=4
        HB_Timer2=(HealBot_Globals.RangeCheckFreq*2)
        HB_Timer3=2
    end
end

local HealBot_Options_Timer={}
function HealBot_setOptions_Timer(value)
    HealBot_luVars["HealBot_Options_Timer"]=value
    HealBot_Options_Timer[value]=true
    if value==500 then HB_Timer1=0.01 end
end

local HealBot_ErrorNum=0
local HealBot_testBarInit={}
local HealBot_trackPartyFrames=false
local hbRequestTime=0
function HealBot_initTestBar(b)
    table.insert(HealBot_testBarInit,b)
end

local lTimer,eTimer=0,GetTime()
function HealBot_OnUpdate(self)
    lTimer=GetTime()-eTimer
    eTimer=GetTime()
    HealBot_Timer1 = HealBot_Timer1+lTimer;
    HealBot_Timer2 = HealBot_Timer2+lTimer;
    HealBot_Timer3 = HealBot_Timer3+lTimer;
    if HealBot_Loaded then
        if not HealBot_PlayerGUID then
            HealBot_Load("onUpdate")      
        elseif HealBot_Timer1>=HB_Timer1 then
            HealBot_SpamCnt = 0;
            HealBot_Timer1 = 0;
            Ti=0
            HealBot_luVars["tmpFR"]=GetFramerate()
            if HealBot_luVars["tmpFR"]>100 then HealBot_luVars["tmpFR"]=100 end
            if HealBot_luVars["tmpFR"]>HealBot_luVars["maxFR"] then HealBot_luVars["maxFR"]=HealBot_luVars["tmpFR"] end
            if (HealBot_luVars["tmpFR"]*2)>HealBot_luVars["maxFR"] then
                HealBot_luVars["qaFR"]=HealBot_Comm_round((HealBot_luVars["tmpFR"]+HealBot_luVars["qaFR1"]+HealBot_luVars["qaFR2"]+HealBot_luVars["qaFR3"]+HealBot_luVars["qaFR4"])/5, 2)
                HealBot_luVars["qaFR1"]=HealBot_luVars["qaFR"]
                HealBot_luVars["qaFR2"]=HealBot_luVars["qaFR1"]
                HealBot_luVars["qaFR3"]=HealBot_luVars["qaFR2"]
                HealBot_luVars["qaFR4"]=HealBot_luVars["qaFR3"]
            end
            if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<GetTime() then
                HealBot_OnEvent_ReadyCheckClear()
                HealBot_luVars["rcEnd"]=nil
            end
            if not HealBot_IsFighting and not InCombatLockdown() then
                if HealBot_Reset_flag then
                    if HealBot_Reset_flag==1 then
                        HealBot_Reset()
                    elseif HealBot_Reset_flag==2 then
                        HealBot_ResetCustomDebuffs()
                    elseif HealBot_Reset_flag==3 then
                        HealBot_ResetSkins()
                    end
                    HealBot_Reset_flag=nil
                elseif HealBot_luVars["UseCrashProtection"] and HealBot_luVars["UseCrashProtection"]<GetTime() then 
                        HealBot_luVars["UseCrashProtection"]=nil
                        if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
                elseif Delay_RecalcParty>0 then
                    Delay_RecalcParty=Delay_RecalcParty+1
                    if Delay_RecalcParty>2 and HealBot_luVars["CheckSkin"] then
                        HealBot_PartyUpdate_CheckSkin()
                    elseif Delay_RecalcParty>3 then
                        HealBot_RecalcParty(nil);
                        HealBot_InCombatUpdCnt=0
                    end
                elseif HealBot_CheckTalents and HealBot_CheckTalents<GetTime() then
                    HealBot_CheckTalents=false; 
                    HealBot_Options_setDebuffTypes()
                    HealBot_GetTalentInfo(HealBot_PlayerGUID, "player")
                    HealBot_setOptions_Timer(5)
                    HealBot_setOptions_Timer(15)
                    HealBot_Options_ResetDoInittab(10)
                    HealBot_Options_ResetDoInittab(5)
                    HealBot_Options_ResetDoInittab(4)
                    HealBot_setOptions_Timer(40)
                    HealBot_setOptions_Timer(50)
                    HealBot_ClearAllBuffs()
                    HealBot_ClearAllDebuffs()
                    HealBot_setOptions_Timer(400)
                    HealBot_setOptions_Timer(10)
                    HealBot_Action_setpcClass()
                elseif HealBot_CheckBuffsTimehbGUID and HealBot_CheckBuffsTime<GetTime() and not HealBot_UnitBuff[HealBot_CheckBuffsTimehbGUID] then
                    if HealBot_UnitID[HealBot_CheckBuffsTimehbGUID] then
                        PlayerBuffsGUID=HealBot_PlayerBuff[HealBot_CheckBuffsTimehbGUID]
                        Ti=0
                        if PlayerBuffsGUID then
                            for bName,_ in pairs (PlayerBuffsGUID) do
                                if PlayerBuffsGUID[bName] < GetTime() then
                                    HealBot_DelayAuraBCheck[HealBot_CheckBuffsTimehbGUID]=GetTime()
                                    HealBot_luVars["DelayAuraBCheck"]=true
                                    Ti=1
                                    do break end
                                end
                            end
                        end
                        if Ti==0 then
                            HealBot_CheckMyBuffs(HealBot_CheckBuffsTimehbGUID)
                        end
                    end
                    HealBot_PlayerBuff[HealBot_CheckBuffsTimehbGUID]=nil
                    HealBot_ResetCheckBuffsTime()
                elseif HealBot_ReCheckBuffsTime and HealBot_ReCheckBuffsTime<GetTime() then
                    HealBot_CheckAllBuffs(HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime])
                    HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=nil
                    z=HealBot_ReCheckBuffsTime+1000000
                    HealBot_ReCheckBuffsTime=nil 
                    for Time,_ in pairs (HealBot_ReCheckBuffsTimed) do
                        if Time < z then
                            z=Time
                            HealBot_ReCheckBuffsTime=Time
                        end
                    end
                elseif HealBot_luVars["WeaponBuffCheck"] then
                    HealBot_luVars["WeaponBuffCheck"]=HealBot_luVars["WeaponBuffCheck"]-1
                    if HealBot_luVars["WeaponBuffCheck"]<=0 then HealBot_luVars["WeaponBuffCheck"]=nil end
                    if HealBot_UnitBuff[HealBot_PlayerGUID] then 
                        HealBot_DelayAuraBCheck[HealBot_PlayerGUID]=GetTime() 
                        HealBot_luVars["DelayAuraBCheck"]=true
                    end
                else
                    for xGUID,_ in pairs(HealBot_DelayDebuffCheck) do
                        if Ti<7 then
                            HealBot_CheckUnitDebuffs(xGUID)
                            Ti=Ti+1
                            HealBot_DelayDebuffCheck[xGUID] = nil;
                        end
                    end
                    for xGUID,_ in pairs(HealBot_DelayBuffCheck) do
                        if Ti<11 then
                            HealBot_CheckUnitBuffs(xGUID)
                            Ti=Ti+1
                            HealBot_DelayBuffCheck[xGUID] = nil;
                        end
                    end
                    for xGUID,xUnit in pairs(HealBot_QueueCheckBuffs) do
                        if Ti<3 then
                            HealBot_CheckMyBuffs(xGUID)
                            if not HealBot_DelayAuraBCheck[xGUID] then
                                HealBot_DelayAuraBCheck[xGUID]=GetTime()
                                HealBot_luVars["DelayAuraBCheck"]=true
                            end
                            HealBot_QueueCheckBuffs[xGUID]=nil
                            Ti=Ti+1
                        end
                    end
                    for xGUID,x in pairs(HealBot_cleanGUIDs) do
                        if Ti<2 then
                            HealBot_ClearLocalArr(xGUID, x)
                            HealBot_cleanGUIDs[xGUID]=nil
                            Ti=Ti+1
                        end
                    end
                --    if calibrateHBScale and Ti<1 and UnitExists("party2") then HealBot_Range_softCalibrateScale("party1", "party2") end
                    if HealBot_RequestVer then
                        HealBot_Comms_SendAddonMsg("HealBot", "S:"..HEALBOT_VERSION, HealBot_AddonMsgType, HealBot_PlayerName)
                        HealBot_RequestVer=nil;
                    end
                    if HealBot_luVars["cpMacro"] and HealBot_luVars["cpMacro"]<GetTime() then 
                        HealBot_cpSaveAll()
                    end
                    for xGUID,xUnit in pairs(HealBot_notVisible) do
                        if UnitIsVisible(xUnit) then
                            if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
                            HealBot_notVisible[xGUID]=nil
                        end
                    end
                end
                if HealBot_luVars["HealBot_Options_Timer"] then
                    if HealBot_Options_Timer[150] then
                        HealBot_Options_Timer[150]=nil
                        HealBot_Action_ResetSkin("init")
                    elseif HealBot_Options_Timer[5] then
                        HealBot_Options_Timer[5]=nil
                        HealBot_Options_InitBuffList()
                    elseif HealBot_Options_Timer[10] then
                        HealBot_Options_Timer[10]=nil
                        if HealBot_Config.NoAuraWhenRested==1 and not IsResting() then HealBot_Queue_AllActiveMyBuffs() end
                    elseif HealBot_Options_Timer[15] then
                        HealBot_Options_Timer[15]=nil
                        HealBot_Options_ComboClass_Text()
                    elseif HealBot_Options_Timer[20] then
                        HealBot_Options_Timer[20]=nil
                        HealBot_CheckAllDebuffs()
                    elseif HealBot_Options_Timer[30] then
                        HealBot_Options_Timer[30]=nil
                        HealBot_CheckAllBuffs()
                    elseif HealBot_Options_Timer[40] then
                        HealBot_Options_Timer[40]=nil
                        HealBot_Options_Buff_Reset()
                    elseif HealBot_Options_Timer[50] then
                        HealBot_Options_Timer[50]=nil
                        HealBot_Options_Debuff_Reset()
                    elseif HealBot_Options_Timer[60] then
                        HealBot_Options_Timer[60]=nil
                        HealBot_Options_EmergencyFilter_Reset()
                    elseif HealBot_Options_Timer[70] then
                        HealBot_Options_Timer[70]=nil
                        HealBot_Options_CheckCombos()
                    elseif HealBot_Options_Timer[80] then
                        HealBot_Options_Timer[80]=nil
                        HealBot_Action_ResetUnitStatus()
                        HealBot_Action_sethbNumberFormat()
                    elseif HealBot_Options_Timer[85] then
                        HealBot_Options_Timer[85]=nil
                        HealBot_Action_ResetUnitStatus()
                        HealBot_Action_sethbAggroNumberFormat()
                    elseif HealBot_Options_Timer[90] then
                        HealBot_Options_Timer[90]=nil
                        HealBot_SetSkinColours();
                    elseif HealBot_Options_Timer[100] then
                        HealBot_Options_Timer[100]=nil
                        HealBot_SetBuffBarColours()
                    elseif HealBot_Options_Timer[110] then
                        HealBot_Options_Timer[110]=nil
                        HealBot_Action_setRegisterForClicks()
                    elseif HealBot_Options_Timer[120] then
                        HealBot_Options_Timer[120]=nil
                        HealBot_CheckZone();
                    elseif HealBot_Options_Timer[125] then
                        HealBot_Options_Timer[125]=nil
                        if HealBot_retChangeNumBars() then
                            hbRequestTime=GetTime()+2
                            HealBot_setOptions_Timer(130)
                        end
                    elseif HealBot_Options_Timer[130] and hbRequestTime<GetTime() then
                        HealBot_Options_Timer[130]=nil
                        HealBot_Comms_SendAddonMsg("HealBot", "R", HealBot_AddonMsgType, HealBot_PlayerName)
                        hbRequestTime=GetTime()+5
                    elseif HealBot_Options_Timer[140] and hbRequestTime<GetTime() then
                        HealBot_Options_Timer[140]=nil
                        if GetGuildInfo("player") then HealBot_Comms_SendAddonMsg("HealBot", "G", 5, HealBot_PlayerName) end
                        x=GetNumFriends()
                        if x>0 then
                            for y=1,x do
                                uName, _, _, _, z = GetFriendInfo(y)
                                if z then HealBot_Comms_SendAddonMsg("HealBot", "F", 4, uName) end
                            end
                        end
                        HealBot_GetTalentInfo(HealBot_PlayerGUID, "player")
                        hbRequestTime=GetTime()+5
                    elseif HealBot_Options_Timer[160] then
                        HealBot_Options_Timer[160]=nil
                        HealBot_Options_SetSkinBars()
                    elseif HealBot_Options_Timer[170] then
                        HealBot_Options_Timer[170]=nil                        
                        HealBot_configClassHoT(HealBot_PlayerClassTrim, strsub(HealBot_PlayerRaceEN,1,3))
                    elseif  HealBot_Options_Timer[180] then
                        HealBot_Options_Timer[180]=nil
                        if Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Current_Skin]==1 then
                            HealBot_trackPartyFrames=true
                            HealBot_Options_DisablePartyFrame()
                            HealBot_Options_PlayerTargetFrames:Enable();
                            if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
                                HealBot_Options_DisablePlayerFrame()
                                HealBot_Options_DisablePetFrame()
                                HealBot_Options_DisableTargetFrame()
                            else
                                HealBot_Options_EnablePlayerFrame()
                                HealBot_Options_EnablePetFrame()
                                HealBot_Options_EnableTargetFrame()
                            end
                        elseif HealBot_trackPartyFrames then
                            if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
                                HealBot_Options_EnablePlayerFrame();
                                HealBot_Options_EnablePetFrame()
                                HealBot_Options_EnableTargetFrame()
                                Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]=0;
                                HealBot_Options_PlayerTargetFrames:SetChecked(Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]);
                            end
                            HealBot_Options_PlayerTargetFrames:Disable();
                            HealBot_Options_EnablePartyFrame()
                            HealBot_trackPartyFrames=nil
                        end
                    elseif HealBot_Options_Timer[190] then
                        HealBot_Options_Timer[190]=nil
                        HealBot_setOptions_Timer(195)
                        HealBot_luVars["CheckSkin"]=true
                        HealBot_Loaded=9
                    elseif HealBot_Options_Timer[195] then
                        HealBot_Options_InitSub(318)
                        HealBot_Options_Timer[195]=nil
                    elseif HealBot_Options_Timer[200] then
                        HealBot_GetTalentInfo(HealBot_PlayerGUID, "player")
                        HealBot_Options_Timer[200]=nil
                    elseif  HealBot_Options_Timer[400] then
                        HealBot_Options_Timer[400]=nil
                        HealBot_Action_SetAllAttribs()
                    elseif  HealBot_Options_Timer[405] then
                        HealBot_Options_Timer[405]=nil
                        HealBot_Action_InitFuncUse()
                    elseif  HealBot_Options_Timer[410] then
                        HealBot_Options_Timer[410]=nil
                        if HealBot_Action_retFuncUse()=="YES" then HealBot_MountsPets_InitMount() end
                    elseif  HealBot_Options_Timer[420] then
                        HealBot_Options_Timer[420]=nil
                        HealBot_OnEvent_RaidRosterUpdate();
                    elseif HealBot_Options_Timer[500] or HealBot_Options_Timer[501] or HealBot_Options_Timer[502] then
                        if HealBot_Options_Timer[500] then
                         --   HealBot_SetResetFlag("SOFT")
                            HealBot_Register_Events()
                            if Delay_RecalcParty<3 then Delay_RecalcParty=3; end
                            ShowUIPanel(HealBot_Action)
                            HealBot_Options_Timer[500]=nil
                        elseif HealBot_Options_Timer[501] then
                            if not HealBot_IsFighting then
                                HealBot_Action_PartyChanged(nil, true);
                                HealBot_Options_Timer[501]=nil
                                HealBot_Options_Timer[502]=true
                            end
                        else
                            HealBot_UnRegister_Events()
                            HealBot_Register_Events()
                            HideUIPanel(HealBot_Action)
                            HealBot_Options_Timer[502]=nil
                            --     HealBot_SetResetFlag("SOFT")
                        end
                    elseif HealBot_Options_Timer[550] then
                        HealBot_Options_Timer[550]=nil
                        HealBot_InitSpells()
                    elseif  HealBot_Options_Timer[950] then
                        HealBot_Options_Timer[950]=nil
                        _,z = GetNumMacros()
                        if z>12 then
                            HealBot_useCrashProtection()
                        end
                    elseif  HealBot_Options_Timer[990] then
                        HealBot_Options_Timer[990]=nil
                        HealBot_AddChat("  "..HEALBOT_ADDON .. HEALBOT_LOADED);
                        HealBot_AddChat(HEALBOT_HELP[1])
                    elseif HealBot_Options_Timer[4910] then
                        HealBot_Options_Timer[4910]=nil
                        HealBot_setLowManaTrig()
                        HealBot_CheckLowMana()
                    elseif HealBot_Options_Timer[5000] then
                        HealBot_Set_Timers()
                        HealBot_Action_Set_Timers()
                        HealBot_Options_Timer[5000]=nil
                    elseif HealBot_Options_Timer[7950] then
                        if GetTime()>HealBot_luVars["hbInsName"] then
                            HealBot_Options_Timer[7950]=nil
                            HealBot_luVars["hbInsName"]=nil
                            HealBot_setOptions_Timer(30)
                            local inBG=nil
                            y,z = IsInInstance()
                            if (y or 0)==1 then
                                x = GetRealZoneText()
                                hbInsName=x
                            else
                                hbInsName=HEALBOT_WORD_OUTSIDE
                            end
                            hbScale=(HealBot_Globals.mapScale[hbInsName] or 0) 
                            calibrateHBScale=0
                            HealBot_Options_SetEnableDisableCDBtn()
                            if z=="pvp" or z == "arena" then inBG=true end
                            HealBot_SetAddonComms(inBG)
                            for xGUID,_ in pairs(HealBot_UnitID) do
                                HealBot_CheckHealth(xGUID)
                            end
                        end
                    elseif HealBot_Options_Timer[8000] then
                        HealBot_Options_Timer[8000]=HealBot_Options_idleInit()
                        if HealBot_Options_Timer[8000] then
                            HealBot_luVars["Timer8000"]=(HealBot_luVars["Timer8000"] or 0)+1
                        else
                            HealBot_AddDebug("Timer 8000 called #"..HealBot_luVars["Timer8000"])
                            HealBot_luVars["Timer8000"]=0
                            HealBot_Set_Timers()
                        end
                    else
                        HealBot_luVars["HealBot_Options_Timer"]=nil
                    end
                end
            elseif HealBot_luVars["IsReallyFighting"] then
                if not InCombatLockdown() then
                    HealBot_luVars["IsReallyFighting"] = nil
                    HealBot_IsFighting = nil;
                    HealBot_Not_Fighting()
                end
            end
            for xGUID,bType in pairs(HealBot_BarCheck) do
                if Ti<5 then
                    if bType=="D" then
                        HealBot_BarCheck[xGUID]="H"
                    elseif bType=="H" then
                        if HealBot_UnitID[xGUID] and UnitExists(HealBot_UnitID[xGUID]) then 
                            HealBot_OnEvent_UnitHealth(nil,HealBot_UnitID[xGUID],UnitHealth(HealBot_UnitID[xGUID]),UnitHealthMax(HealBot_UnitID[xGUID])) 
                        end
                    elseif bType=="P" then
                        if HealBot_UnitID[xGUID] and UnitExists(HealBot_UnitID[xGUID]) then 
                            HealBot_OnEvent_UnitMana(nil,HealBot_UnitID[xGUID],UnitPowerType(HealBot_UnitID[xGUID])); 
                        end
                    elseif HealBot_UnitID[xGUID] and UnitExists(HealBot_UnitID[xGUID]) then 
                        HealBot_OnEvent_UnitHealth(nil,HealBot_UnitID[xGUID],UnitHealth(HealBot_UnitID[xGUID]),UnitHealthMax(HealBot_UnitID[xGUID])) 
                        HealBot_OnEvent_UnitMana(nil,HealBot_UnitID[xGUID],UnitPowerType(HealBot_UnitID[xGUID])) 
                    end
                    HealBot_BarCheck[xGUID]=nil
                    Ti=Ti+1
                end
            end
            for xGUID in pairs(HealBot_RessingCD) do
                if HealBot_RessingCD[xGUID]<GetTime() then 
                    HealBot_RessingCD[xGUID]=nil;
                    if HealBot_UnitID[xGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]) end
                end
            end
        end
        if HealBot_Timer3>=HB_Timer3 and HealBot_Loaded then
            HealBot_Timer3=0
        --    if not HealBot_luVars["DelayAuraCheck"] then
                for xGUID in pairs(HealBot_Player_HoT) do
                    huHoTtime=HealBot_Player_HoT[xGUID]
                    for sName in pairs(huHoTtime) do
                        if huHoTtime[sName]<20 then
                            huHoTtime[sName]=huHoTtime[sName]-1
                            if huHoTtime[sName]<2 then
                                if HealBot_Player_HoT_Icons[xGUID][sName]>0 then
                                    HealBot_HoT_Update(xGUID, sName)
                                else
                                    huHoTtime[sName]=nil
                                end
                            end
                        elseif floor(huHoTtime[sName]-GetTime())<=Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Current_Skin] then
                            HealBot_HoT_Update(xGUID, sName)
                        end
                    end
                end
        --    end
            if HealBot_luVars["DebuffSpell"] then
                if HealBot_luVars["DebuffSpell"]<GetTime()+2 then
                    HealBot_DebuffMask()
                else
                    HealBot_luVars["DebuffSpell"]=nil
                end
            end
            if HealBot_ThrottleCnt>0 then
                HealBot_ThrottleCnt=HealBot_ThrottleCnt-HealBot_ThrottleTh
                if HealBot_ThrottleCnt<0 then HealBot_ThrottleCnt=0 end
            end
            for xUnit,z in pairs(HealBot_VehicleCheck) do
                if z<4 then
                    HealBot_VehicleCheck[xUnit]=HealBot_VehicleCheck[xUnit]+1
                else
                    HealBot_VehicleCheck[xUnit]=nil
                end
                HealBot_OnEvent_VehicleChange(nil, xUnit, true)
            end
            if HealBot_InCombatUpdate then
                HealBot_IC_PartyMembersChanged()
            elseif HealBot_luVars["HelpCnt1"] then
                HealBot_luVars["HelpCnt1"]=HealBot_luVars["HelpCnt1"]+1
                if HealBot_luVars["HelpCnt1"]>#HEALBOT_HELP then
                    HealBot_luVars["HelpCnt1"]=nil
                else
                    HealBot_AddChat(HEALBOT_HELP[HealBot_luVars["HelpCnt1"]])
                end
            elseif HealBot_luVars["HelpCnt2"] then
                HealBot_luVars["HelpCnt2"]=HealBot_luVars["HelpCnt2"]+1
                if HealBot_luVars["HelpCnt2"]>#HEALBOT_HELP2 then
                    HealBot_luVars["HelpCnt2"]=nil
                else
                    HealBot_AddChat(HEALBOT_HELP2[HealBot_luVars["HelpCnt2"]])
                end
            end
            if HealBot_testBarInit[1] then
                HealBot_Action_setTestBar(HealBot_testBarInit[1])
                table.remove(HealBot_testBarInit,1)
            end
        end
        if HealBot_Timer2>HB_Timer2 then
            HealBot_Timer2=0
            aSwitch=aSwitch+1
            if aSwitch<2 and HealBot_luVars["DelayAuraBCheck"] then
                HealBot_doAuraBuff()
            elseif aSwitch<3 and HealBot_luVars["DelayAuraDCheck"] then
                HealBot_doAuraDebuff()
                aSwitch=2
            elseif aSwitch<4 and HealBot_luVars["DelayClearAggro"] then
                HealBot_doClearAggro()
                aSwitch=3
            elseif aSwitch<5 and Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then 
                HealBot_Action_CheckAggro()
                aSwitch=4
            elseif aSwitch<6 and HealBot_useTips and HealBot_Globals.TooltipUpdate==1 and (HealBot_Action_TooltipUnit or HealBot_Action_DisableTooltipUnit) then  
                if HealBot_Action_TooltipUnit then
                    HealBot_Action_RefreshTooltip(HealBot_Action_TooltipUnit,"Enabled");
                elseif HealBot_Action_DisableTooltipUnit then
                    HealBot_Action_RefreshTooltip(HealBot_Action_DisableTooltipUnit,"Disabled");
                end
                aSwitch=5
            else
                HealBot_Action_RefreshButtons()
                aSwitch=0
            end
        end
    end
end

function HealBot_doClearAggro()
    for xUnit,xGUID in pairs(HealBot_endAggro) do
        HealBot_ClearUnitAggro(xUnit, xGUID)
        HealBot_endAggro[xUnit] = nil
    end
    HealBot_luVars["DelayClearAggro"]=nil
end

function HealBot_doAuraDebuff()
    HealBot_luVars["DelayAuraDCheck"]=nil
    for xGUID,aTime in pairs(HealBot_DelayAuraDCheck) do
        if aTime<=GetTime() then
            if HealBot_Config.DebuffWatch==1  and (HealBot_Config.DebuffWatchWhenGrouped==0 or GetNumGroupMembers()>0) then
                if HealBot_Config.DebuffWatchInCombat==0 and HealBot_IsFighting then
                    HealBot_DelayDebuffCheck[xGUID]="S";
                else
                    HealBot_CheckUnitDebuffs(xGUID)
                end
            end  
            HealBot_DelayAuraDCheck[xGUID] = nil;
        else
            HealBot_luVars["DelayAuraDCheck"]=true
        end
    end
end

function HealBot_doAuraBuff()
    HealBot_luVars["DelayAuraBCheck"]=nil
    for xGUID,aTime in pairs(HealBot_DelayAuraBCheck) do
        if HealBot_Config.BuffWatch==1 and (HealBot_Config.BuffWatchWhenGrouped==0 or GetNumGroupMembers()>0) then 
            if HealBot_Config.BuffWatchInCombat==0 and HealBot_IsFighting then
                HealBot_DelayBuffCheck[xGUID]="S";
            else
                HealBot_CheckUnitBuffs(xGUID)
            end
        end
        if Healbot_Config_Skins.ShowHoTicons[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_HasMyBuffs(xGUID) 
        end
        xUnit=HealBot_UnitID[xGUID]
        if xUnit then
            local hbAbsorbs=UnitGetTotalAbsorbs(xUnit)
            if hbAbsorbs>0 and Healbot_Config_Skins.AbsorbBarColour[Healbot_Config_Skins.Current_Skin]>=2 then
                if not HealBot_UnitAbsorbs[xGUID] or (HealBot_UnitAbsorbs[xGUID]~=hbAbsorbs) then
                    HealBot_UnitAbsorbs[xGUID]=hbAbsorbs
                    HealBot_IncHeals_HealsInUpdate(xGUID)
                end
            end
        end
        HealBot_DelayAuraBCheck[xGUID] = nil;
    end
end

function HealBot_RetVersion()
    return HEALBOT_VERSION
end

function HealBot_OnEvent(self, event, ...)
    local arg1,arg2,arg3,arg4 = ...;
    if (event=="CHAT_MSG_ADDON") then
        HealBot_OnEvent_AddonMsg(self,arg1,arg2,arg3,arg4);
    elseif (event=="COMBAT_LOG_EVENT_UNFILTERED") then
        HealBot_OnEvent_Combat_Log(self,...)
    elseif (event=="UNIT_AURA") then
        HealBot_OnEvent_UnitAura(self,arg1);
    elseif (event=="UNIT_HEALTH") or (event=="UNIT_MAXHEALTH") then
        HealBot_OnEvent_UnitHealth(self,arg1,UnitHealth(arg1),UnitHealthMax(arg1));
    elseif (event=="UNIT_COMBAT") or (event=="UNIT_THREAT_SITUATION_UPDATE") or (event=="UNIT_THREAT_LIST_UPDATE") then
        if arg1 then HealBot_OnEvent_UnitCombat(self,arg1); end
    elseif (event=="UNIT_HEAL_PREDICTION") then
        HealBot_IncHeals_updHealsIn(arg1)
    elseif (event=="UNIT_SPELLCAST_START") then
        HealBot_OnEvent_UnitSpellcastStart(self,arg1,arg2)
    elseif (event=="UNIT_SPELLCAST_STOP") or (event=="UNIT_SPELLCAST_SUCCEEDED") then
        HealBot_OnEvent_UnitSpellcastStop(self,arg1,arg2);
    elseif (event=="UNIT_SPELLCAST_FAILED") or (event=="UNIT_SPELLCAST_INTERRUPTED") then
        HealBot_OnEvent_UnitSpellcastFail(self,arg1,arg2);
    elseif (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellcastSent(self,arg1,arg2,arg3,arg4);  
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled(self);
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_OnEvent_PlayerRegenEnabled(self);
    elseif (event=="UNIT_NAME_UPDATE") then
        HealBot_OnEvent_UnitNameUpdate(self,arg1)
    elseif (event=="UNIT_POWER") then
        HealBot_OnEvent_UnitMana(self,arg1,arg2);
    elseif (event=="UNIT_MAXPOWER") then 
        HealBot_OnEvent_UnitMaxMana(self,arg1,arg2);
    elseif (event=="CHAT_MSG_SYSTEM") then
        HealBot_OnEvent_SystemMsg(self,arg1);
    elseif (event=="GROUP_ROSTER_UPDATE") then
        HealBot_OnEvent_PartyMembersChanged(self);
    elseif (event=="RAID_TARGET_UPDATE") then
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(self); end
    elseif (event=="PLAYER_TARGET_CHANGED") then
        HealBot_OnEvent_PlayerTargetChanged(self);
    elseif (event=="PLAYER_FOCUS_CHANGED") then
        HealBot_OnEvent_FocusChanged(self);
    elseif (event=="MODIFIER_STATE_CHANGED") then
        HealBot_OnEvent_ModifierStateChange(self,arg1,arg2);
    elseif (event=="UNIT_PET") then
        HealBot_OnEvent_PartyPetChanged(self);
    elseif (event=="ROLE_CHANGED_INFORM") then
        HealBot_setOptions_Timer(420)
    elseif (event=="UNIT_ENTERED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, true)
    elseif (event=="UNIT_EXITED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, nil)
    elseif (event=="UNIT_EXITING_VEHICLE") then
        HealBot_OnEvent_LeavingVehicle(self, arg1)
    elseif (event=="PLAYER_ENTERING_WORLD") then
        HealBot_OnEvent_PlayerEnteringWorld(self);
    elseif (event=="PLAYER_LEAVING_WORLD") then
        HealBot_OnEvent_PlayerLeavingWorld(self);
    elseif (event=="CHARACTER_POINTS_CHANGED") then
        HealBot_OnEvent_TalentsChanged(self);
    elseif (event=="INSPECT_READY") then
        HealBot_GetUnitTalentInfo(nil, arg1)
    elseif (event=="TalentQuery_Ready") or (event=="TalentQuery_Ready_Outsider") then
        HealBot_GetUnitTalentInfoReady(arg1, arg2, arg3, arg4)
    elseif (event=="UNIT_CONNECTION") then
        HealBot_Action_ResetUnitStatus(arg1)
    elseif (event=="ZONE_CHANGED_NEW_AREA") then
        HealBot_OnEvent_ZoneChanged(self);
    elseif (event=="READY_CHECK") then
        HealBot_OnEvent_ReadyCheck(self,arg1,arg2);
    elseif (event=="READY_CHECK_CONFIRM") then
        HealBot_OnEvent_ReadyCheckConfirmed(self,arg1,arg2);
    elseif (event=="READY_CHECK_FINISHED") then
        HealBot_OnEvent_ReadyCheckFinished(self);
    elseif (event=="UPDATE_MACROS") then
        HealBot_setOptions_Timer(950)
    elseif (event=="LEARNED_SPELL_IN_TAB") then
        HealBot_OnEvent_SpellsChanged(self,arg1);
        HealBot_setOptions_Timer(410)
   -- elseif (event=="PLAYER_TALENT_UPDATE") then
    --    HealBot_OnEvent_TalentsChanged(self)
    elseif (event=="COMPANION_LEARNED") then
        HealBot_setOptions_Timer(410)
    elseif (event=="VARIABLES_LOADED") then
        HealBot_OnEvent_VariablesLoaded(self);
    else
        HealBot_AddDebug("OnEvent (" .. event .. ")");
    end
end

function HealBot_OnEvent_VariablesLoaded(self)
    table.foreach(HealBot_ConfigDefaults, function (key,val)
        if not HealBot_Config[key] then
            HealBot_Config[key] = val;
        end
    end);
    table.foreach(HealBot_GlobalsDefaults, function (key,val)
        if not HealBot_Globals[key] then
            HealBot_Globals[key] = val;
        end
    end);
    table.foreach(HealBot_Config_SkinsDefaults, function (key,val)
        if not Healbot_Config_Skins[key] then
            Healbot_Config_Skins[key] = val;
        end
    end);
    if HealBot_Globals.HealBot_Enable_MouseWheel==1 then
        HealBot_Action:EnableMouseWheel(1)  
        HealBot_Action:SetScript("OnMouseWheel", function(self, delta)
            HealBot_Action_HealUnit_Wheel(delta)
        end)
    end
    if HealBot_Globals.localLang then
        HealBot_Options_Lang(HealBot_Globals.localLang)
    elseif strsub(GetLocale(),1,2)~="en" then
        HealBot_Options_Lang(GetLocale())
    end
    RegisterAddonMessagePrefix("HealBot")
    HealBot_Globals.scaleCaliStats["Resets"]=0
    HealBot_Globals.scaleCaliStats["Count"]=0
    HealBot_Globals.scaleCaliStats["SoftCount"]=0
    HealBot_Update_Skins()    
    HealBot_PlayerClass, HealBot_PlayerClassEN=UnitClass("player")
    HealBot_PlayerRace, HealBot_PlayerRaceEN=UnitRace("player")
    HealBot_PlayerName=UnitName("player")
--    HealBot_InitSpells()
    HealBot_Options_InitBuffClassList()
    HealBot_setOptions_Timer(5)
    --HealBot_Options_InitBuffList()
    HealBot_Vers[HealBot_PlayerName]=HEALBOT_VERSION
	HealBot_luVars["TargetUnitID"]="player"
    HealBot_luVars["qaFR"]=40
    HealBot_luVars["qaFR1"]=40
    HealBot_luVars["qaFR2"]=40
    HealBot_luVars["qaFR3"]=40
    HealBot_luVars["qaFR4"]=40
    HealBot_luVars["maxFR"]=30
    HealBot_luVars["IsSolo"]=true
    HealBot_BuffNameSwap={}
    HealBot_BuffNameSwap2={}
    if HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_ShortBuffs[HEALBOT_LEVITATE]=true
        HealBot_BuffNameSwap = {[HEALBOT_POWER_WORD_FORTITUDE] = HEALBOT_COMMANDING_SHOUT,
                                [HEALBOT_INNER_FIRE] = HEALBOT_INNER_WILL,
                                [HEALBOT_INNER_WILL] = HEALBOT_INNER_FIRE}
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_BuffNameSwap = {[HEALBOT_MARK_OF_THE_WILD] = HEALBOT_BLESSING_OF_KINGS}
        HealBot_BuffNameSwap2 = {[HEALBOT_MARK_OF_THE_WILD] = HEALBOT_LEGACY_EMPEROR}
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_ShortBuffs[HEALBOT_BEACON_OF_LIGHT]=true
        HealBot_ShortBuffs[HEALBOT_SACRED_SHIELD]=true
        HealBot_BuffNameSwap = {[HEALBOT_BLESSING_OF_KINGS] = HEALBOT_MARK_OF_THE_WILD,
                                [HEALBOT_DEVOTION_AURA] = HEALBOT_STONEKIN_TOTEM}
        HealBot_BuffNameSwap2 = {[HEALBOT_BLESSING_OF_KINGS] = HEALBOT_LEGACY_EMPEROR}
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_MONK] then
        HealBot_BuffNameSwap = {[HEALBOT_LEGACY_EMPEROR] = HEALBOT_MARK_OF_THE_WILD,
                                [HEALBOT_LEGACY_WHITETIGER] = HEALBOT_ARCANE_BRILLIANCE}
        HealBot_BuffNameSwap2 = {[HEALBOT_LEGACY_EMPEROR] = HEALBOT_BLESSING_OF_KINGS,
                                 [HEALBOT_LEGACY_WHITETIGER] = HEALBOT_DALARAN_BRILLIANCE}
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_WARRIOR] then
      --  HealBot_HoT_Texture[HEALBOT_VIGILANCE] = "Interface\\Icons\\Ability_Warrior_Vigilance";
        HealBot_ShortBuffs[HEALBOT_BATTLE_SHOUT]=true
        HealBot_ShortBuffs[HEALBOT_COMMANDING_SHOUT]=true
        HealBot_BuffNameSwap = {[HEALBOT_COMMANDING_SHOUT] = HEALBOT_POWER_WORD_FORTITUDE}
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_MAGE] then
		HealBot_BuffNameSwap = {[HEALBOT_DALARAN_BRILLIANCE] = HEALBOT_ARCANE_BRILLIANCE,
		                        [HEALBOT_ARCANE_BRILLIANCE] = HEALBOT_DALARAN_BRILLIANCE}
        HealBot_ShortBuffs[HEALBOT_ICE_WARD]=true
	elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_WARLOCK] then
	elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
		HealBot_ShortBuffs[HEALBOT_HORN_OF_WINTER]=true
    end
    TalentQuery.RegisterCallback(self, "TalentQuery_Ready", function(event, name, realm, unitid, guid)
        HealBot_OnEvent(self, "TalentQuery_Ready", name, realm, unitid, guid)
    end);
    TalentQuery.RegisterCallback(self, "TalentQuery_Ready_Outsider", function(event, name, realm, unitid, guid)
        HealBot_OnEvent(self, "TalentQuery_Ready_Outsider", name, realm, unitid, guid)
    end);
  --  HealBot_Options_Init(1)
    HealBot_Options_Init(11)
    HealBot_setOptions_Timer(60)
    HealBot_setOptions_Timer(70)
    HealBot_setOptions_Timer(50)
    HealBot_setOptions_Timer(40)
  --  HealBot_setOptions_Timer(85)
    HealBot_Action_setRegisterForClicks()
	HealBot_Action_setpcClass()
    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    HealBot_Tooltip:SetBackdropColor(0,0,0,HealBot_Globals.ttalpha)
    bar = HealBot_Action_HealthBar(HealBot_Action_OptionsButton);
    bar:SetStatusBarColor(0.1,0.1,0.4,0);
    bar.txt = _G[bar:GetName().."_text"];
    bar.txt:SetTextColor(0.8,0.8,0.2,0.85);
    bar.txt:SetText(HEALBOT_ACTION_OPTIONS);
    HealBot_Loaded=1;
    HealBot_CheckFrame()
    HealBot_CheckMyBuffs(HealBot_PlayerGUID)
    HealBot_Action_SetDebuffAggroCols()
    HealBot_Action_SetHightlightAggroCols()
    HealBot_Action_SetAggroCols()
    HealBot_Panel_SetNumBars(HealBot_Globals.noTestBars)
  --  HealBot_Action_sethbNumberFormat()
    HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
    HealBot_SkinsSubFrameSelectHealAlertFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsSubFrameSelectHealRaidFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsSubFrameSelectHealSortFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsSubFrameSelectHealHideFrame:GetStatusBarTexture():SetHorizTile(false)
    x=HealBot_Globals.ttalpha+0.12
    if x>1 then x=1 end
    HealBot_Tooltip:SetBackdropBorderColor(0.32,0.32,0.4, x)
    HealBot_MMButton_Init();
    HealBot_setOptions_Timer(200)
    HealBot_luVars["UseCrashProtection"]=GetTime()+HealBot_Config.CrashProtStartTime
    HealBot_luVars["BodyAndSoul"]=0
    HealBot_setOptions_Timer(410)
    HealBot_setOptions_Timer(405)
    HealBot_setLowManaTrig()
    HealBot_Options_MonitorBuffs_Toggle()
    HealBot_Options_MonitorDebuffs_Toggle()
end

function HealBot_useCrashProtection()
    _,z = GetNumMacros()
    x=18-z
    if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then
        y=0
        for z=0,5 do
            w=GetMacroBody(HealBot_Config.CrashProtMacroName.."_"..z)
            if w then
                x=x+1
            end
        end
    end
    if x<5 then
        Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]=0
        HealBot_Options_CrashProt:SetChecked(Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin])
        HealBot_Options_CrashProt:Disable();
    end
end

function HealBot_Load(hbCaller)
    HealBot_InitSpells()
    HealBot_useCrashProtection()
    HealBot_Options_Set_Current_Skin()
    HealBot_Action_ResetSkin("init")
    if not HealBot_Config.DisabledKeyCombo then 
        HealBot_InitNewChar(HealBot_PlayerClassEN)
    else
        HealBot_Options_SetSkins();
    end
    HealBot_PlayerGUID=UnitGUID("player")
    HealBot_PlayerBuff[HealBot_PlayerGUID]={}
    if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==0 then HealBot_Config.ActionVisible=1; end
    if HealBot_Config.DisabledNow==0 and HealBot_Config.ActionVisible==1 then HealBot_Action:Show() end
    if not HealBot_IsFighting then
        HealBot_RecalcParty(nil);
    else
        HealBot_RecalcParty(true);
    end
    HealBot_configClassHoT(HealBot_PlayerClassTrim, strsub(HealBot_PlayerRaceEN,1,3))
  --  HealBot_CheckTalents=GetTime()+2
    if HealBot_AddonMsgType==2 then HealBot_Comms_SendAddonMsg("CTRA", "SR", HealBot_AddonMsgType, HealBot_PlayerName) end
    if not HealBot_luVars["HelpNotice"] then
        HealBot_setOptions_Timer(990)
        HealBot_luVars["HelpNotice"]=true
    end
    HealBot_Panel_SetmaxHealDiv(UnitLevel("player"))
    HealBot_Options_RaidTargetUpdate()
    HealBot_Loaded=2
    if hbCaller~="playerEW" then
        HealBot_OnEvent_PlayerEnteringWorld()
    end
    HealBot_setOptions_Timer(140)
    if HealBot_Globals.ShowTooltip==1 then
        HealBot_Options_LoadTips()
    end
end


function HealBot_configClassHoT(class, race)
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for sName,_ in pairs(HealBot_Watch_HoT) do
        HealBot_Watch_HoT[sName]=nil
    end
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for sName,x  in pairs(HealBot_configClassHoTClass) do
            if xClass=="ALL" and x==3 then x=4; end
            if (x==4) or (x==3 and xClass==class) then
                HealBot_Watch_HoT[sName]="A"
            elseif x==2 and xClass==class then
                HealBot_Watch_HoT[sName]="C"
            else
                HealBot_Watch_HoT[sName]=nil
            end
            if sName==HEALBOT_RENEW then HealBot_AddDebug("HealBot_configClassHoT Renew  x=="..x) end
            if sName==HEALBOT_GIFT_OF_THE_NAARU and race=="Dra" then HealBot_Watch_HoT[sName]="C" end
        end
    end
end

function HealBot_Register_Events()
    if HealBot_Config.DisabledNow==0 then
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
        HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
        HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
        HealBot:RegisterEvent("UNIT_EXITING_VEHICLE");
        HealBot:RegisterEvent("UNIT_HEALTH");
        HealBot:RegisterEvent("UNIT_MAXHEALTH");
        HealBot:RegisterEvent("UNIT_MAXMANA")
        if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
			HealBot_Register_Mana() 
		elseif Healbot_Config_Skins.PowerCounter[Healbot_Config_Skins.Current_Skin]==1 and  
           (HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_MONK]) then
			HealBot_Register_Mana() 
        elseif (Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin])>1 then
            HealBot_Register_Mana() 
		end
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        --HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
        HealBot:RegisterEvent("UNIT_SPELLCAST_START");
        HealBot:RegisterEvent("UNIT_AURA");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
		HealBot:RegisterEvent("INSPECT_READY");
        HealBot:RegisterEvent("CHAT_MSG_SYSTEM");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");
        HealBot:RegisterEvent("UNIT_NAME_UPDATE");
        if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Register_Aggro() end

		HealBot:RegisterEvent("ROLE_CHANGED_INFORM");
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot:RegisterEvent("RAID_TARGET_UPDATE") end
        if Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Register_ReadyCheck() end
        if Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin]>=2 then HealBot_Register_IncHeals() end
        HealBot:RegisterEvent("UNIT_SPELLCAST_SENT");
        HealBot:RegisterEvent("UNIT_SPELLCAST_STOP");
        HealBot:RegisterEvent("UNIT_SPELLCAST_FAILED");
        HealBot:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
        HealBot:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
        HealBot:RegisterEvent("UPDATE_MACROS");
        HealBot:RegisterEvent("UNIT_CONNECTION");
        HealBot:RegisterEvent("COMPANION_LEARNED");
        if HealBot_Globals.EnLibQuickHealth==1 then HealBot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end
    end
    HealBot:RegisterEvent("GROUP_ROSTER_UPDATE");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    HealBot_setOptions_Timer(125)
    HealBot_setOptions_Timer(5000)
end

function HealBot_Register_Aggro()
    HealBot:RegisterEvent("UNIT_COMBAT")
    HealBot:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    HealBot:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
end

function HealBot_UnRegister_Aggro()
    HealBot:UnregisterEvent("UNIT_COMBAT")
    HealBot:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    HealBot:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
    HealBot_ClearAggro(true)
end

function HealBot_Register_IncHeals()
    HealBot:RegisterEvent("UNIT_HEAL_PREDICTION")
end

function HealBot_UnRegister_IncHeals()
    HealBot:UnregisterEvent("UNIT_HEAL_PREDICTION")
    HealBot_IncHeals_ClearAll()
end


function HealBot_Register_ReadyCheck()
    HealBot:RegisterEvent("READY_CHECK")
    HealBot:RegisterEvent("READY_CHECK_CONFIRM")
    HealBot:RegisterEvent("READY_CHECK_FINISHED")
end

function HealBot_UnRegister_ReadyCheck()
    HealBot:UnregisterEvent("READY_CHECK")
    HealBot:UnregisterEvent("READY_CHECK_CONFIRM")
    HealBot:UnregisterEvent("READY_CHECK_FINISHED")
    HealBot_OnEvent_ReadyCheckFinished(nil);
end

function HealBot_Register_Mana()
    HealBot:RegisterEvent("UNIT_POWER")
    HealBot:RegisterEvent("UNIT_MAXPOWER")
    for xGUID,_ in pairs(HealBot_UnitID) do
        HealBot_CheckPower(xGUID)
    end
end

function HealBot_UnRegister_Mana()
    HealBot:UnregisterEvent("UNIT_POWER")
    HealBot:UnregisterEvent("UNIT_MAXPOWER")
end

function HealBot_UnRegister_Events()
    HB_Timer1=0.5
    HB_Timer2=0.2
    HB_Timer3=0.25
    if HealBot_Config.DisabledNow==1 then
        HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
        HealBot:UnregisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:UnregisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
        HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
        HealBot:UnregisterEvent("UNIT_EXITING_VEHICLE");
        HealBot:UnregisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
        HealBot:UnregisterEvent("GROUP_ROSTER_UPDATE");
        HealBot:UnregisterEvent("UNIT_HEALTH");
        HealBot_UnRegister_Mana()
        HealBot_UnRegister_ReadyCheck()
        HealBot_UnRegister_IncHeals()
        HealBot:UnregisterEvent("UNIT_AURA");
        HealBot:UnregisterEvent("CHAT_MSG_SYSTEM");
        HealBot_UnRegister_Aggro()
        HealBot:UnregisterEvent("UNIT_PET");
        HealBot:UnregisterEvent("UNIT_NAME_UPDATE");
		HealBot:UnregisterEvent("ROLE_CHANGED_INFORM");
       -- HealBot:UnregisterEvent("PLAYER_TALENT_UPDATE");
        HealBot:UnregisterEvent("COMPANION_LEARNED");
        HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
        HB_Timer1=2
        HB_Timer2=0.4
        HB_Timer3=1
    end

    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_START");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_STOP");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_FAILED");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    
    HealBot_Action_Set_Timers(true)
    
end

local eUnit=nil
local aTrack={}

function HealBot_CheckUnitAggro(unit)
    if UnitExists(unit) then
        local z,y,x=0,0,0
        z, y=HealBot_CalcThreat(unit)
        xGUID=HealBot_UnitGUID(unit)
        x=y+z
        if x==0 then
            HealBot_qClearUnitAggro(unit, xGUID)
        elseif (aTrack[unit] or 0)~=((1000*y)+z) then
            aTrack[unit]=(1000*y)+z
            HealBot_Action_UpdateAggro(unit,true,y,xGUID,z)
        end
    else
        HealBot_qClearUnitAggro(unit, "nil")
    end
end

function HealBot_CalcThreat(unit)
    local z,y=0,0
    if UnitExists(unit.."target") and UnitIsEnemy(unit, unit.."target") then 
        if UnitIsUnit(unit, unit.."targettarget") then
            z=100
        else
            _, _, z, _, _ = UnitDetailedThreatSituation(unit, unit.."target")
            z=floor(z or 0)
        end
    elseif eUnit and UnitExists(eUnit) and UnitIsEnemy(unit, eUnit) then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, eUnit)
        z=floor(z or 0)
    elseif UnitExists("playertarget") and UnitIsEnemy("player", "playertarget") then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, "playertarget") 
        z=floor(z or 0)
    end
    if not z then z=0 end
    if z>=HealBot_Globals.aggro3pct then
        y=3
    else
        if UnitExists(unit.."target") and UnitIsEnemy(unit, unit.."target") then 
            y = UnitThreatSituation(unit, unit.."target")
        elseif eUnit and UnitExists(eUnit) and UnitIsEnemy(unit, eUnit) then
            y = UnitThreatSituation(unit, eUnit)
        elseif UnitExists("playertarget") and UnitIsEnemy("player", "playertarget") then 
            y = UnitThreatSituation(unit, "playertarget")
        else
            y = UnitThreatSituation(unit)
        end
        if not y then y=0 end
        if z>=HealBot_Globals.aggro2pct then
            if y<2 then y=2 end
        elseif z>0 then
            if y<1 then y=1 end
        end
    end
    return z, y
end

function HealBot_qClearUnitAggro(unit, hbGUID)
    HealBot_endAggro[unit]=hbGUID
    HealBot_luVars["DelayClearAggro"]=true
end

function HealBot_ClearUnitAggro(unit, hbGUID)
    if UnitExists(unit) and HealBot_UnitID[hbGUID] then
        local z,y,x=0,0,0
        z, y=HealBot_CalcThreat(unit)
        x=y+z
        if x==0 then
            aTrack[unit]=0
            HealBot_Action_UpdateAggro(unit,false,nil,hbGUID, 0)
        elseif (aTrack[unit] or 0)~=((1000*y)+z) then
            aTrack[unit]=(1000*y)+z
            HealBot_Action_UpdateAggro(unit,true,y,hbGUID,z)
        end
    elseif unit then 
        aTrack[unit]=0
        HealBot_Action_UpdateAggro(unit,false,nil,hbGUID, 0)
    end
    if hbGUID then HealBot_Action_SetThreatPct(hbGUID, -5) end
end

function HealBot_SetAggro(unit)
 --   uName=UnitName(unit.."targettarget")
 --   aGUID=HealBot_Derive_GUID_fuName(uName)
    if UnitExists(unit.."target") and UnitIsEnemy(unit, unit.."target") and UnitExists(unit.."targettarget") and UnitIsEnemy(unit.."target", unit.."targettarget") then
        aGUID=UnitGUID(unit.."targettarget")
        if HealBot_PetGUID[aGUID] then aGUID=HealBot_PetGUID[aGUID] end
        xUnit=HealBot_UnitID[aGUID]
    else
        xUnit=nil
    end
    if not eUnit or not UnitIsEnemy(unit, eUnit) then
        if xUnit and UnitIsEnemy(xUnit, xUnit.."target") then
            eUnit=xUnit.."target"
            HealBot_unitHealthMax["eUnit"]=UnitHealthMax(eUnit) or 2
            HealBot_unitHealth["eUnit"]=UnitHealth(eUnit) or 1
        elseif UnitIsEnemy(unit, unit.."target") then
            eUnit=unit.."target"
            HealBot_unitHealthMax["eUnit"]=UnitHealthMax(eUnit) or 2
            HealBot_unitHealth["eUnit"]=UnitHealth(eUnit) or 1
        else
            eUnit=nil
        end
    elseif UnitIsEnemy(unit, unit.."target") and UnitHealthMax(unit.."target")>HealBot_unitHealthMax["eUnit"] or (UnitHealthMax(unit.."target")==HealBot_unitHealthMax["eUnit"] and UnitHealth(unit.."target")>HealBot_unitHealth["eUnit"]) then
        eUnit=unit.."target"
        HealBot_unitHealthMax["eUnit"]=UnitHealthMax(eUnit)
        HealBot_unitHealth["eUnit"]=UnitHealth(eUnit)
    end
    local z,y,x=0,0,0
    if xUnit and xUnit~="target" then
        z, y=HealBot_CalcThreat(xUnit)
        x=y+z
        if x>0 then
            if (aTrack[unit] or 0)~=((1000*y)+z) then
                aTrack[unit]=(1000*y)+z
                HealBot_Action_UpdateAggro(xUnit,true,y,aGUID,z)
            end
        end
    else
        aGUID=UnitGUID(unit)
        if HealBot_PetGUID[aGUID] then aGUID=HealBot_PetGUID[aGUID] end
        if HealBot_UnitID[aGUID] then
            z, y=HealBot_CalcThreat(unit)
            x=y+z
            if x>0 then
                if (aTrack[unit] or 0)~=((1000*y)+z) then
                    aTrack[unit]=(1000*y)+z
                    HealBot_Action_UpdateAggro(unit,true,y,aGUID,z)
                end
            end
        end
    end
end

function HealBot_nileUnit()
    eUnit=nil
    HealBot_unitHealth["eUnit"]=0
    HealBot_unitHealthMax["eUnit"]=0
end

function HealBot_ClearAggro(force, unit)
    if unit then
        xGUID=HealBot_UnitGUID(unit)
        if force and xGUID then
            aTrack[unit]=0
            HealBot_Action_UpdateAggro(unit,false,nil,xGUID, 0)
            HealBot_Action_SetThreatPct(xGUID, -7)
        else
            HealBot_qClearUnitAggro(unit, xGUID)
        end
    elseif force then 
        HealBot_Action_EndAggro() 
        HealBot_nileUnit()
        for xUnit,_ in pairs(aTrack) do
            aTrack[xUnit]=0
        end
    end
end

local HealBotAddonSummary={}
local HealBotAddonIncHeals={}
local hbExtra1, hbExtra2=nil, nil
function HealBot_OnEvent_AddonMsg(self,addon_id,msg,distribution,sender_id)
--  inc_msg = gsub(msg, "%$", "s");
--  inc_msg = gsub(inc_msg, "�", "S");
    inc_msg=msg
    sender_id = HealBot_UnitNameOnly(sender_id)
    utGUID=nil
    if not HealBotAddonSummary[sender_id..": "..addon_id] then
        HealBotAddonSummary[sender_id..": "..addon_id]=string.len(inc_msg)
    else
        HealBotAddonSummary[sender_id..": "..addon_id]=HealBotAddonSummary[sender_id..": "..addon_id]+string.len(inc_msg)
    end
    if addon_id=="HealBot" then
        datatype, datamsg, hbExtra1, hbExtra2 = string.split(":", inc_msg)
      --  xxx=datamsg or " "
      --  HealBot_AddDebug("Addon Msg ("..datatype.."):"..strsub(xxx,1,20))
        if datatype=="R" then
            HealBot_RequestVer=sender_id
            if HealBot_Options_Timer[130] then HealBot_Options_Timer[130]=nil end
        elseif datatype=="S" then
            HealBot_Vers[sender_id]=datamsg
            HealBot_AddDebug(sender_id..":  "..datamsg);
            HealBot_Comms_CheckVer(sender_id, datamsg)
            HealBot_setOptions_Timer(5000)
        elseif datatype=="G" then
            HealBot_Comms_SendAddonMsg("HealBot", "H:"..HEALBOT_VERSION, 4, sender_id)
            if not HealBot_Vers[sender_id] then
                HealBot_Comms_SendAddonMsg("HealBot", "G", 4, sender_id)
            end
        elseif datatype=="F" then
            HealBot_Comms_SendAddonMsg("HealBot", "C:"..HEALBOT_VERSION, 4, sender_id)
            if not HealBot_Vers[sender_id] then
                HealBot_Comms_SendAddonMsg("HealBot", "F", 4, sender_id)
            end
        elseif datatype=="H" then
            HealBot_Vers[sender_id]=datamsg
            HealBot_AddDebug(sender_id..":  "..datamsg);
            HealBot_Options_setMyGuildMates(sender_id)
            HealBot_Comms_CheckVer(sender_id, datamsg)
        elseif datatype=="C" then
            HealBot_Vers[sender_id]=datamsg
            HealBot_AddDebug(sender_id..":  "..datamsg);
            HealBot_Options_setMyFriends(sender_id)
            HealBot_Comms_CheckVer(sender_id, datamsg)
        elseif datatype=="X" and HealBot_Globals.AcceptSkins==1 then
            HealBot_Options_ShareSkinRec("X", sender_id.."!"..datamsg)
        elseif datatype=="Y" then
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SHARESKINACPT..sender_id);
            HealBot_Options_ShareSkinSend("Z", datamsg, sender_id)
        elseif datatype=="Z" then
            HealBot_Options_ShareSkinRec("Z", hbExtra1, datamsg)
        elseif datatype=="RC" and Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Current_Skin]==1 then
            if datamsg=="I" then
                HealBot_OnEvent_hbReadyCheck(hbExtra1,hbExtra2)
            else
                HealBot_OnEvent_hbReadyCheckConfirmed(hbExtra1,hbExtra2)
            end
        end
    elseif addon_id=="CTRA" then
        if ( strfind(inc_msg, "#") ) then
            arr = HealBot_Split(inc_msg, "#");
            for k in pairs(arr) do
                HealBot_ParseCTRAMsg(sender_id, arr[k]);
            end
        else
            HealBot_ParseCTRAMsg(sender_id, inc_msg);
        end
    end
end

function HealBot_RetHealBotAddonSummary()
    return HealBotAddonSummary
end

function HealBot_GetInfo()
    return HealBot_Vers
end

function HealBot_Split(msg, char)
    for x,_ in pairs(arrg) do
        arrg[x]=nil;
    end
    while (strfind(msg, char) ) do
        x, y = strfind(msg, char);
        tinsert(arrg, strsub(msg, 1, x-1));
        msg = strsub(msg, y+1, strlen(msg));
    end
    if ( strlen(msg) > 0 ) then
        tinsert(arrg, msg);
    end
    return arrg;
end

function HealBot_ParseCTRAMsg(sender_id, inc_msg)
    if ( strsub(inc_msg, 1, 3) == "RES" ) then
        if ( inc_msg == "RESNO" ) then
            for j in pairs(HealBot_Ressing) do
                if HealBot_Ressing[j]==sender_id then
                    HealBot_Ressing[j] = nil;
                    HealBot_RessingCD[j] = GetTime()+HealBot_Globals.ResLagDuration;
                    break
                end
            end
        else
            _,_, uName = strfind(inc_msg, "^RES (.+)$");
            if ( uName ) then
                xGUID = HealBot_Derive_GUID_fuName(uName)
                if HealBot_UnitID[xGUID] then
                    HealBot_Ressing[xGUID] = sender_id;
                    HealBot_RecalcHeals(xGUID);
                end
            end
        end
    elseif ( strsub(inc_msg, 1, 4) == "SET " ) then
        _,_, x, uName = strfind(inc_msg, "^SET (%d+) (.+)$");
        if ( x and uName ) then
            xGUID = HealBot_Derive_GUID_fuName(uName)
            if HealBot_UnitID[xGUID] then
                for k in pairs(HealBot_CTRATanks) do
                    if ( HealBot_CTRATanks[k] == xGUID ) then
                        HealBot_CTRATanks[k] = nil;
                    end
                end
            end
            HealBot_CTRATanks[tonumber(x)] = xGUID;
        end
        HealBot_addPrivateTanks()
    elseif ( strsub(inc_msg, 1, 2) == "R " ) then
        _,_, uName = strfind(inc_msg, "^R (.+)$");
        if ( uName ) then
            xGUID = HealBot_Derive_GUID_fuName(uName)
            if HealBot_UnitID[xGUID] then
                for k in pairs(HealBot_CTRATanks) do
                    if ( HealBot_CTRATanks[k] == xGUID ) then
                        HealBot_CTRATanks[k] = nil;
                    end
                end
            end
        end
        HealBot_addPrivateTanks()
    end
end

local dGUID,uGUID=nil,nil
local hbTempUnitNames={}
function HealBot_Derive_GUID_fuName(unitName)
    if not unitName then return end
    dGUID=HealBot_RetUnitNameGUIDs(unitName)
    if not dGUID then
        xUnit=HealBot_RaidUnit(hbTempUnitNames[unitName],nil,unitName)
        if xUnit then
            hbTempUnitNames[unitName]=xUnit
            dGUID=HealBot_UnitGUID(xUnit)
        end
    end
    return dGUID
end

function HealBot_OnEvent_RaidRosterUpdate()
    for x,_ in pairs(HealBot_MainTanks) do
        HealBot_MainTanks[x]=nil;
    end
    for x,_ in pairs(HealBot_MainAssists) do
        HealBot_MainAssists[x]=nil;
    end
    y = 0
    w = 0
	for i=1,GetNumGroupMembers() do
		xUnit = "raid"..i
		xGUID=UnitGUID(xUnit)
		if xGUID then
			_,_,_,_,_,_,_,_,_,z,_ = GetRaidRosterInfo(i)
			if z and string.lower(z)=="maintank" then
				y = y + 1
				HealBot_MainTanks[y]=xGUID
			elseif z and string.lower(z)=="mainassist" then
				w = w + 1
				HealBot_MainAssists[w]=xGUID
			end
		end
	end
    HealBot_addPrivateTanks()
end

function HealBot_addPrivateTanks()
    local PrivTanks = HealBot_Panel_retPrivateTanks()
    table.foreach(PrivTanks, function (i,xGUID)
        HealBot_addExtraTank(xGUID)
    end)
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_addExtraTank(hbGUID)
    z = true
    for i=1, #HealBot_MainTanks do
        if hbGUID==HealBot_MainTanks[i] then
            z = false
            break;
        end
    end
    if z then
        HealBot_MainTanks[#HealBot_MainTanks+1]=hbGUID
    end
end

function HealBot_removePrivateTanks(hbGUID)
    for i=1, #HealBot_MainTanks do
        if hbGUID==HealBot_MainTanks[i] then
            y=i
            break;
        end
    end
    if y>0 then
        HealBot_MainTanks[y]=nil
        if #HealBot_MainTanks>y then
            for i=y, #HealBot_MainTanks-1 do
                HealBot_MainTanks[i]=HealBot_MainTanks[i+1]
            end
        end
    end
end

function HealBot_OnEvent_UnitHealth(self,unit,health,healthMax)
    hGUID=HealBot_UnitGUID(unit)
    if not hGUID then 
        if HealBot_Unit_Button[unit] then 
            if HealBot_unitHealth[unit] then
                HealBot_unitHealth[unit]=health
                HealBot_unitHealthMax[unit]=healthMax
            end
            HealBot_Action_ResetUnitStatus(unit) 
        end
        return 
    end
    if hGUID and HealBot_VehicleUnit[unit] and not HealBot_UnitID[hGUID] then
        HealBot_UnitID[hGUID]=unit
    end
    hUnit=HealBot_IDs(unit,hGUID)
    if not hUnit then return end
    if HealBot_VehicleUnit[hUnit] then
        HBvUnits=HealBot_VehicleUnit[hUnit]
        for xUnit,_ in pairs(HBvUnits) do
            HealBot_Action_ResetUnitStatus(xUnit)
        end
        if not HealBot_Unit_Button[hUnit] then
            y = UnitThreatSituation(hUnit) or 0
            if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and (UnitIsEnemy(hUnit, hUnit.."target") or y>0) then
                HealBot_Action_SetVAggro(hGUID, true)
            else
                HealBot_Action_SetVAggro(hGUID, nil)
            end
            HealBot_VehicleSetHealth(hUnit, health, healthMax)
            return
        end
    end
    if not HealBot_unitHealth[hGUID] then 
        HealBot_unitHealth[hGUID]=-1
        HealBot_unitHealthMax[hGUID]=-1
    end
    if HealBot_unitHealth[hGUID]~=health or HealBot_unitHealthMax[hGUID]~=healthMax then
        if HealBot_useTips and HealBot_unitHealthMax[hGUID]~=healthMax then 
            HealBot_talentSpam(hGUID,"update",1)
        end
        HealBot_unitHealth[hGUID]=health
        HealBot_unitHealthMax[hGUID]=healthMax
        HealBot_RecalcHeals(hGUID)
        if HealBot_IsFighting then HealBot_OnEvent_UnitCombat(nil,hGUID) end
    end
end

function HealBot_Reset_UnitHealth(hbGUID)
    if hbGUID and HealBot_UnitID[hbGUID] then
        HealBot_OnEvent_UnitHealth(nil,HealBot_UnitID[hbGUID],UnitHealth(HealBot_UnitID[hbGUID]),UnitHealthMax(HealBot_UnitID[hbGUID]))
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            HealBot_OnEvent_UnitHealth(nil,xUnit,UnitHealth(xUnit),UnitHealthMax(xUnit))
        end
    end
end

function HealBot_VehicleHealth(unit)
    vGUID=HealBot_UnitGUID(unit)
    if not vGUID then
        HealBot_NoVehicle(unit)
        return 100,100
    end
    if not HealBot_unitHealth[vGUID] then 
        HealBot_unitHealth[vGUID]=UnitHealth(unit)
        HealBot_unitHealthMax[vGUID]=UnitHealthMax(unit)
    end
    return HealBot_unitHealth[vGUID], HealBot_unitHealthMax[vGUID]
end

function HealBot_NoVehicle(unit)
    HBvUnits=HealBot_VehicleUnit[unit]
    if not HBvUnits then 
        HealBot_AddDebug("HBvUnits is NIL in HealBot_NoVehicle")
    else
        for xUnit,_ in pairs(HBvUnits) do
            if HealBot_UnitInVehicle[xUnit] then HealBot_UnitInVehicle[xUnit]=nil end
        end
    end
	if HealBot_VehicleUnit[unit] then HealBot_VehicleUnit[unit]=nil end
    vGUID=HealBot_UnitGUID(unit)
    if vGUID then
      if HealBot_unitHealth[vGUID] then
          HealBot_unitHealth[vGUID]=nil
          HealBot_unitHealthMax[vGUID]=nil
      end
      if HealBot_UnitID[vGUID] then
          HealBot_UnitID[vGUID]=nil
      end
    end
end

function HealBot_VehicleSetHealth(unit, health, healthMax)
    vGUID=HealBot_UnitGUID(unit)
    if not vGUID then
        HealBot_NoVehicle(unit)
    else
        HealBot_unitHealth[vGUID]=health
        HealBot_unitHealthMax[vGUID]=healthMax
    end
end

function HealBot_OnEvent_VehicleChange(self, unit, enterVehicle)
    xUnit, xGUID = HealBot_validUnit(unit)
    if not xUnit then return end

    if enterVehicle then
        vUnit=HealBot_UnitPet(xUnit)
        if vUnit and UnitHasVehicleUI(xUnit) then
            if HealBot_VehicleCheck[xUnit] then HealBot_VehicleCheck[xUnit]=nil end
            if not HealBot_VehicleUnit[vUnit] then HealBot_VehicleUnit[vUnit]={} end
            HealBot_VehicleUnit[vUnit][xUnit]=true
            HealBot_UnitInVehicle[xUnit]=vUnit
            xGUID=HealBot_UnitGUID(vUnit)
            if xGUID and not HealBot_UnitID[xGUID] then 
                HealBot_UnitID[xGUID]=vUnit 
            end
            HealBot_OnEvent_UnitHealth(self,vUnit,UnitHealth(vUnit),UnitHealthMax(vUnit))
        elseif self then
            HealBot_VehicleCheck[xUnit]=1
        end
    elseif HealBot_UnitInVehicle[xUnit] then
        vUnit=HealBot_UnitInVehicle[xUnit]
        HealBot_NoVehicle(vUnit)
    end
    HealBot_Action_ResetUnitStatus(xUnit)
    Delay_RecalcParty=1
end

function HealBot_OnEvent_LeavingVehicle(self, unit)
    xUnit, xGUID = HealBot_validUnit(unit)
    if not xUnit then return end

    if HealBot_UnitInVehicle[xUnit] then
        vUnit=HealBot_UnitInVehicle[xUnit]
        HealBot_Action_SetVAggro(HealBot_UnitGUID(vUnit), nil)
    end
end

function HealBot_retIsInVehicle(unit)
    return HealBot_UnitInVehicle[unit]
end

function HealBot_CheckAllUnitVehicle(unit)
    if unit then
        HealBot_VehicleCheck[unit]=2
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            HealBot_VehicleCheck[xUnit]=1
        end
    end
end

function HealBot_OnEvent_UnitMana(self,unit,pType,maxpower)
    xUnit, xGUID = HealBot_validUnit(unit)
    if not xUnit then return end
    if maxpower and HealBot_useTips then 
        HealBot_talentSpam(xGUID,"update",1) 
    else
        if hbCurLowMana[xGUID] then 
            HealBot_CheckLowMana(xGUID) 
        elseif Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]>1 then
            if Healbot_Config_Skins.LowManaIndIC[Healbot_Config_Skins.Current_Skin]==1 or not HealBot_IsFighting then HealBot_CheckLowMana(xGUID) end
        end
        HealBot_Action_SetBar3Value(HealBot_Unit_Button[xUnit])
    end
end

function HealBot_OnEvent_UnitMaxMana(self,unit,pType)
    HealBot_OnEvent_UnitMana(self,unit,pType,true)
end

function HealBot_OnEvent_UnitCombat(self,unit)
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then
        xUnit, xGUID = HealBot_validUnit(unit)
        if not xUnit then return end
        HealBot_SetAggro(xUnit)
    end
end

function HealBot_OnEvent_ModifierStateChange(self,arg1,arg2)
    if HealBot_useTips then
        if HealBot_Action_TooltipUnit then
            HealBot_Action_RefreshTooltip(HealBot_Action_TooltipUnit,"Enabled");
        elseif HealBot_Action_DisableTooltipUnit then
            HealBot_Action_RefreshTooltip(HealBot_Action_DisableTooltipUnit,"Disabled");
        end
    end
end

function HealBot_OnEvent_ZoneChanged(self)
    HealBot_setOptions_Timer(120)
end

function HealBot_CheckZone()
    HealBot_Set_Timers()
    HealBot_setOptions_Timer(410)
    HealBot_setOptions_Timer(10)
    HealBot_luVars["hbInsName"]=GetTime()+5
    HealBot_setOptions_Timer(7950)
  --  Delay_RecalcParty=1
end

local uaUnit=nil
local uaGUID=nil
function HealBot_OnEvent_UnitAura(self,unit)
    if HealBot_IsFighting or HealBot_Config.NoAuraWhenRested<(IsResting() or 2) then
        uaUnit, uaGUID = HealBot_validUnit(unit)
        if not uaUnit then 
            return 
		end
        if not HealBot_DelayAuraDCheck[uaGUID] then
            HealBot_DelayAuraDCheck[uaGUID]=GetTime()
            HealBot_luVars["DelayAuraDCheck"]=true
        end
        if not HealBot_DelayAuraBCheck[uaGUID] then
            HealBot_DelayAuraBCheck[uaGUID]=GetTime()
            HealBot_luVars["DelayAuraBCheck"]=true
        end
    end
end

function HealBot_DebuffMask()
    for xGUID,_ in pairs(HealBot_UnitDebuff) do
        if not HealBot_DelayAuraDCheck[xGUID] then HealBot_DelayAuraDCheck[xGUID]=GetTime() end
    end
    HealBot_luVars["DelayAuraDCheck"]=true
end

function HealBot_SetUnitBuffTimer(hbGUID,buffName,endtime)

    if not HealBot_PlayerBuff[hbGUID] then
        HealBot_PlayerBuff[hbGUID]={}
    end

    if HealBot_ShortBuffs[buffName] then 
        HealBot_PlayerBuff[hbGUID][buffName] = endtime-HealBot_Config.ShortBuffTimer
    else
        HealBot_PlayerBuff[hbGUID][buffName] = endtime-HealBot_Config.LongBuffTimer
    end
--  HealBot_AddDebug("Set bufftimer.buffName="..buffName.."  hbGUID="..hbGUID.."  endtime="..endtime)
    if not HealBot_CheckBuffsTime or HealBot_PlayerBuff[hbGUID][buffName] < HealBot_CheckBuffsTime then
        HealBot_CheckBuffsTime=HealBot_PlayerBuff[hbGUID][buffName]
        HealBot_CheckBuffsTimehbGUID=hbGUID
    end
end

function HealBot_HasBuff(buffName, unit)
    x,_,iTexture,bCount,_,_,expirationTime, caster,_,_,_,spellID = UnitBuff(unit,buffName)
    if x then
        if not HealBot_HoT_Texture["t"..spellID] then HealBot_HoT_Texture["t"..spellID]=iTexture end
        return true, expirationTime, caster, bCount;
    end
    return false;
end

local hbExcludeSpells = { [67358]="Rejuvenating",
                          [58597]="Sacred Shield",
                          --[65148]="Sacred Shield",
                        }
                        
local hbExcludeBuffSpells = { [65148]="Sacred Shield",
                        }
                        
function HealBot_HasUnitBuff(buffName, unit, casterUnitID)
    if UnitExists(unit) then
        k = 1
        while true do
            x,_,iTexture,bCount,_,_,expirationTime, caster,_,_,spellID = UnitAura(unit, k, "HELPFUL"); 
            if x then
                if x==buffName and casterUnitID==caster and not hbExcludeSpells[spellID] then
                    if not HealBot_HoT_Texture["t"..spellID] then HealBot_HoT_Texture["t"..spellID]=iTexture end
                    return true, expirationTime, bCount
                end
                k=k+1
            else
                do break end
            end
        end
    end
    return false;
end

function HealBot_HasDebuff(debuffName, unit)
    x,_,_,_,_,_,_,_,_ = UnitDebuff(unit,debuffName)
    if x then
        return true;
    end
    return false;
end

local hbHoTcaster="!";
local hbFoundHoT={}
local hbNoEndTime=GetTime()+604800
function HealBot_HasMyBuffs(hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    if UnitExists(xUnit) then
        for x,_ in pairs(hbFoundHoT) do
            hbFoundHoT[x]=nil;
        end
        k = 1
        HoTActive=nil
        while true do
            bName,_,iTexture,bCount,_,_,expirationTime, caster,_,_,spellID = UnitAura(xUnit, k, "HELPFUL"); 
            if bName and caster then
                if not hbExcludeSpells[spellID] then
                    y=HealBot_Watch_HoT[bName] or "nil"
                    if (y=="A" or (y=="C" and caster=="player")) then
                        hbHoTcaster=UnitGUID(caster).."!" 
                        local hbSpellID="!"..spellID
                        hbFoundHoT[hbHoTcaster..bName..hbSpellID]=true
                        if UnitIsVisible(xUnit) then 
                            if (expirationTime or 0)==0 then expirationTime=hbNoEndTime end
                            if not HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]={} end
                            if not HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]={} end
                            if not HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..bName..hbSpellID] then HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..bName..hbSpellID]=0 end
                            if not HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID] then HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID]=expirationTime+1 end
                            if (bCount and bCount>1) or HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID] then
                                if (Healbot_Config_Skins.ShowIconTextCountSelfCast[Healbot_Config_Skins.Current_Skin]==1 and caster~="player") or Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Current_Skin]==0 then
                                    if HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID] then HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID]=nil end
                                else
                                    if not HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID] then HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID]={} end
                                    if bCount~=(HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID][hbGUID] or 0) then
                                        HealBot_HoT_Count[hbHoTcaster..bName..hbSpellID][hbGUID]=bCount
                                        HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID]=expirationTime+1
                                    end
                                end
                            end    
                            if bName==HEALBOT_POWER_WORD_SHIELD then
                                HoTActive=HEALBOT_POWER_WORD_SHIELD
                                if (HealBot_TrackWS[hbGUID] or "-")=="-" and expirationTime>GetTime()+12 then
                                    HealBot_TrackWS[hbGUID]="+"
                                    HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID]=expirationTime+1
                                elseif HealBot_TrackWS[hbGUID] and not HealBot_HasDebuff(HEALBOT_DEBUFF_WEAKENED_SOUL, xUnit) then
                                    HealBot_TrackWS[hbGUID]=nil
                                    HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID]=expirationTime+1
                                end
                            end
                            if not HealBot_HoT_Texture["t"..spellID] then 
                                HealBot_HoT_Texture["t"..spellID]=iTexture
                            end  
                            if HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID]~=expirationTime then
                                HealBot_Player_HoT[hbGUID][hbHoTcaster..bName..hbSpellID]=expirationTime
                                HealBot_HoT_Update(hbGUID, hbHoTcaster..bName..hbSpellID)
                            end
                        end
                    end
                end
                k=k+1
            else
                do break end
            end
        end
        if not HoTActive and (HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="A" or HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="C") then
            bName,_,iTexture,bCount,_,_,expirationTime, caster,_,_,spellID = UnitDebuff(xUnit, HEALBOT_DEBUFF_WEAKENED_SOUL); 
            if bName and caster then
                if (HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="A" or (HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="C" and caster=="player")) then
                    hbHoTcaster=UnitGUID(caster).."!" 
                    if not HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"] then HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"]=0 end
                    if not HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"] then 
                        HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"]=expirationTime+1
                    end
                    HealBot_HoT_Texture["t"..spellID]=iTexture
                    HealBot_TrackWS[hbGUID]="-"
                    if HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"]~=expirationTime then
                        HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"]=expirationTime
                        HealBot_HoT_Update(hbGUID, hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17")
                    end
                    hbFoundHoT[hbHoTcaster..HEALBOT_POWER_WORD_SHIELD.."!17"]=true
                elseif HealBot_TrackWS[hbGUID] then
                    HealBot_TrackWS[hbGUID]=nil
                end
            end
        end
        huHoTtime=HealBot_Player_HoT[hbGUID]
        if huHoTtime then
            for sName, expirationTime in pairs(huHoTtime) do
                if not hbFoundHoT[sName] then
                    _, hotName, sID=string.split("!", sName)
                    if HealBot_Watch_HoT[hotName] then
                        huHoTtime[sName]=1
                        if HealBot_Player_HoT_Icons[hbGUID][sName]>0 then
                            HealBot_HoT_Update(hbGUID, sName)
                        else
                            huHoTtime[sName]=nil
                            HealBot_Player_HoT_Icons[hbGUID][sName]=nil
                            if HealBot_HoT_Count[sName] and HealBot_HoT_Count[sName][hbGUID] then HealBot_HoT_Count[sName][hbGUID]=nil end
                        end
                    end
                end
            end
        end
    end
end

function HealBot_CheckMyBuffs(hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    if not xUnit then return end
    for bName,_ in pairs(HealBot_CheckBuffs) do
        _,_,_,_,_,_,z,_,_ = HealBot_HasUnitBuff(xUnit,bName,"player")
        if z then
            HealBot_SetUnitBuffTimer(hbGUID,bName,z)
        elseif HealBot_PlayerBuff[hbGUID] and HealBot_PlayerBuff[hbGUID][bName] then
            if HealBot_PlayerBuff[hbGUID][bName]==HealBot_CheckBuffsTime then
                HealBot_PlayerBuff[hbGUID][bName]=nil
                HealBot_ResetCheckBuffsTime()
            else
                HealBot_PlayerBuff[hbGUID][bName]=nil
            end
        end
    end
end

function HealBot_CheckAllBuffs(hbGUID)
    if HealBot_Config.NoAuraWhenRested==(IsResting() or 2) then 
        HealBot_ClearAllBuffs()
    elseif HealBot_Config.BuffWatch==1 then
        if hbGUID then
            if HealBot_UnitID[hbGUID] and UnitIsPlayer(HealBot_UnitID[hbGUID]) and not HealBot_DelayAuraBCheck[hbGUID] then
                HealBot_DelayAuraBCheck[hbGUID]=GetTime()
                HealBot_luVars["DelayAuraBCheck"]=true
            end
        else
            for xGUID,xUnit  in pairs(HealBot_UnitID) do
                if not HealBot_DelayAuraBCheck[xGUID] and UnitIsPlayer(xUnit) then
                    HealBot_DelayAuraBCheck[xGUID]=GetTime()
                    HealBot_luVars["DelayAuraBCheck"]=true
                end
            end
        end
    end
end

function HealBot_ClearAllBuffs(hbGUID)
    if hbGUID then
        if HealBot_DelayBuffCheck[hbGUID] then 
            HealBot_DelayBuffCheck[hbGUID]=nil
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
        end
    else
        for xGUID,_ in pairs(HealBot_UnitBuff) do
            HealBot_UnitBuff[xGUID]=nil
            if HealBot_UnitID[xGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]) end
        end
        for xGUID,_ in pairs(HealBot_DelayBuffCheck) do
            HealBot_DelayBuffCheck[xGUID]=nil;
            if HealBot_UnitID[xGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]) end
        end
    end
end

function HealBot_CheckAllDebuffs(hbGUID)
    if HealBot_Config.NoAuraWhenRested==(IsResting() or 2) then 
        HealBot_ClearAllDebuffs()
    elseif HealBot_Config.DebuffWatch==1 and HealBot_Config.NoAuraWhenRested<(IsResting() or 2) then 
        if hbGUID then
            if not HealBot_DelayAuraDCheck[hbGUID] then
                HealBot_DelayAuraDCheck[hbGUID]=GetTime()
                HealBot_luVars["DelayAuraDCheck"]=true
            end
        else
            for xGUID,_ in pairs(HealBot_UnitID) do
                if not HealBot_DelayAuraDCheck[xGUID] then
                    HealBot_DelayAuraDCheck[xGUID]=GetTime()
                    HealBot_luVars["DelayAuraDCheck"]=true
                end
            end
        end
    end
end

function HealBot_ClearAllDebuffs(hbGUID)
    if hbGUID then
        if HealBot_DelayDebuffCheck[hbGUID] then 
            HealBot_DelayDebuffCheck[hbGUID]=nil 
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
        end
    else
        for xGUID,_ in pairs(HealBot_UnitDebuff) do
            HealBot_UnitDebuff[xGUID]=nil
            if HealBot_UnitID[xGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]) end
        end
        for xGUID,_ in pairs(HealBot_DelayDebuffCheck) do
            HealBot_DelayDebuffCheck[xGUID]=nil;
            if HealBot_UnitID[xGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]) end
        end
    end
end

local DebuffNameIn="x"
local curDebuffs={}
local DebuffClass=nil
local myhTargets={}
local inSpellRange = 0 -- added by Diacono
local dPrio=100
local debuffDuration=nil
local trackdebuffIcon={}
                        
local function HealBot_addCurDebuffs(dName,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,hbGUID,spellId,unitCaster)
    local x, y=HealBot_Options_retDebuffPriority(dName, debuff_type)
    if y>x then
        if HealBot_Globals.IgnoreCustomDebuff[dName] and HealBot_Globals.IgnoreCustomDebuff[dName][hbInsName] then 
            x=y+1
        elseif (HealBot_Globals.FilterCustomDebuff[dName] or 1)>1 then
            if unitCaster and unitCaster=="player" then
                curDebuffs[dName]["unitCaster"]=4
            elseif unitCaster and not UnitIsEnemy("player",unitCaster) then
                curDebuffs[dName]["unitCaster"]=3
            else
                curDebuffs[dName]["unitCaster"]=2
            end
            if curDebuffs[dName]["unitCaster"]~=HealBot_Globals.FilterCustomDebuff[dName] then 
                x=y+1
            end
        end
    elseif x>20 and HealBot_Config.HealBot_Custom_Defuffs_All[debuff_type]==1 then
        y=x+1
    end
    if y>x then
        curDebuffs[dName]={}
        debuff_type=HEALBOT_CUSTOM_en
        curDebuffs[dName]["priority"]=x
        curDebuffs[dName]["isCustom"]=true
    elseif HealBot_Config.IgnoreFriendDebuffs==0 or not unitCaster or UnitIsEnemy("player",unitCaster) then
        local checkthis=true;
        if HealBot_Config.IgnoreMovementDebuffs==1 and HealBot_Ignore_Movement_Debuffs[dName] then
            checkthis=false;
        elseif HealBot_Config.IgnoreFastDurDebuffs==1 and debuffDuration and debuffDuration<HealBot_Config.IgnoreFastDurDebuffsSecs then
            checkthis=false;
        elseif HealBot_Config.IgnoreNonHarmfulDebuffs==1 and HealBot_Ignore_NonHarmful_Debuffs[dName] then
            checkthis=false;
        elseif HealBot_Config.IgnoreClassDebuffs==1 then
            HealBot_Ignore_Debuffs_Class=HealBot_Ignore_Class_Debuffs[strsub(DebuffClass,1,4)];
            if HealBot_Ignore_Debuffs_Class[dName] then
                checkthis=false;
            end
        end
        if checkthis then
            curDebuffs[dName]={}
            curDebuffs[dName]["priority"]=y
        end
    end
    if curDebuffs[dName] then
        curDebuffs[dName]["type"]=debuff_type
        curDebuffs[dName]["duration"]=debuffDuration
        curDebuffs[dName]["texture"]=deBuffTexture
        curDebuffs[dName]["bCount"]=bCount
        curDebuffs[dName]["expirationTime"]=expirationTime
        curDebuffs[dName]["spellId"]=spellId
        if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[dName] then
            if not HealBot_CustomDebuff_RevDurLast[dName] then HealBot_CustomDebuff_RevDurLast[dName]={} end
            if not HealBot_CustomDebuff_RevDurLast[dName][hbGUID] or HealBot_CustomDebuff_RevDurLast[dName][hbGUID]<(expirationTime-debuffDuration) then
                HealBot_CustomDebuff_RevDurLast[dName][hbGUID]=GetTime()
            end
        end
    end
end

function HealBot_CheckUnitDebuffs(hbGUID)
    if HealBot_Config.NoAuraWhenRested==(IsResting() or 2) then 
        HealBot_ClearAllDebuffs()
        return 
    end
    xUnit=HealBot_UnitID[hbGUID]
    if not xUnit or not HealBot_Unit_Button[xUnit] or not UnitExists(xUnit) then return end
    _,DebuffClass=UnitClass(xUnit)
    if not DebuffClass then DebuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end
    DebuffType=nil;
    if HealBot_UnitDebuff[hbGUID] then
        DebuffNameIn=HealBot_UnitDebuff[hbGUID]["name"]
    else
        DebuffNameIn="x"
    end
    for x,_ in pairs(curDebuffs) do
        curDebuffs[x]=nil;
    end
    z=1
    while true do
        local dName,_,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,unitCaster,_,_,spellId,_,isBossDebuff = UnitDebuff(xUnit,z)
        if dName then
            z = z +1
            HealBot_addCurDebuffs(dName,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,hbGUID,spellId,unitCaster)
        else
            do break end
        end 
    end
    z=1
    while true do
        local dName,_,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,unitCaster,_,_,spellId,_,isBossDebuff  = UnitBuff(xUnit,z)
        if dName then
            z = z +1
            if HealBot_Globals.HealBot_Custom_Debuffs[dName] then 
                HealBot_addCurDebuffs(dName,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,hbGUID,spellId,unitCaster)
            end
        else
            do break end
        end 
    end
	for dName,_ in pairs(HealBot_CustomDebuff_RevDurLast) do
		if not curDebuffs[dName] and HealBot_CustomDebuff_RevDurLast[dName][hbGUID] then HealBot_CustomDebuff_RevDurLast[dName][hbGUID]=nil end
	end
    dPrio = 100
    local DebuffSpellId=nil
    for dName,_ in pairs(curDebuffs) do
        if curDebuffs[dName]["priority"]<dPrio then
            debuff_type=curDebuffs[dName]["type"]
            debuffDuration=curDebuffs[dName]["duration"]
            local spellCD=0
            if HealBot_Config.IgnoreOnCooldownDebuffs==1 then 
                spellCD=HealBot_Options_retDebuffWatchTargetCD(debuff_type)
                if spellCD>1.5 then DebuffNameIn="x" end
            end
            local checkthis=false;
            local WatchTarget, WatchGUID=nil,nil
            if dName~=DebuffNameIn then
                if curDebuffs[dName]["isCustom"] then  -- HealBot_Globals.HealBot_Custom_Debuffs[dName] or 
                    WatchTarget={["Raid"]=true,} 
                elseif spellCD<=1.5 then    
                    WatchTarget, WatchGUID=HealBot_Options_retDebuffWatchTarget(debuff_type,hbGUID);
                end
      
                if WatchTarget then 
                    if WatchTarget["Raid"] then
                        checkthis=true;
                    elseif WatchTarget["Party"] and (UnitInParty(xUnit) or hbGUID==HealBot_PlayerGUID) then
                        checkthis=true;
                    elseif WatchTarget["Self"] and hbGUID==HealBot_PlayerGUID then
                        checkthis=true
                    elseif WatchTarget[strsub(DebuffClass,1,4)] then
                        checkthis=true;
                    elseif WatchTarget["PvP"] and UnitIsPVP("player") then
                        checkthis=true;
                    elseif WatchTarget["Name"] and hbGUID==WatchGUID then
                        checkthis=true;
                    elseif WatchTarget["Focus"] and UnitIsUnit(xUnit, "focus") then
                        checkthis=true;
                    elseif WatchTarget["MainTanks"] then
                        for i=1, #HealBot_MainTanks do
                            if hbGUID==HealBot_MainTanks[i] then
                                checkthis=true;
                                break;
                            end
                        end
                        for i=1, #HealBot_MainAssists do
                            if hbGUID==HealBot_MainAssists[i] then
                                checkthis=true;
                                break;
                            end
                        end
                        for i=1, #HealBot_CTRATanks do
                            if hbGUID==HealBot_CTRATanks[i] then
                                checkthis=true;
                                break;
                            end
                        end
                    elseif WatchTarget["MyTargets"] then
                        myhTargets=HealBot_GetMyHealTargets();
                        for i=1, #myhTargets do
                            if hbGUID==myhTargets[i] then
                                checkthis=true;
                                break;
                            end
                        end
                    end

                elseif spellCD>1.5 then
                    HealBot_DelayAuraDCheck[hbGUID]=GetTime()+spellCD
                    HealBot_DebuffMask()
                end
            else
                checkthis=true
            end
            if checkthis then
                if not HealBot_UnitDebuff[hbGUID] then HealBot_UnitDebuff[hbGUID]={} end
                HealBot_UnitDebuff[hbGUID]["type"]=debuff_type
                HealBot_UnitDebuff[hbGUID]["name"]=dName
                HealBot_UnitDebuff[hbGUID]["spellId"]=curDebuffs[dName]["spellId"]
                DebuffType=debuff_type;
                dPrio = curDebuffs[dName]["priority"]
            end
        end 
    end
    
    if not DebuffType then 
        if HealBot_UnitDebuff[hbGUID] then
            if HealBot_Player_HoT[hbGUID] and HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..HealBot_UnitDebuff[hbGUID]["name"].."!"..HealBot_UnitDebuff[hbGUID]["spellId"]] then
                HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..HealBot_UnitDebuff[hbGUID]["name"].."!"..HealBot_UnitDebuff[hbGUID]["spellId"]]=1
                HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..HealBot_UnitDebuff[hbGUID]["name"].."!"..HealBot_UnitDebuff[hbGUID]["spellId"])
                trackdebuffIcon[hbGUID]=nil
            end
            HealBot_UnitDebuff[hbGUID] = nil;
            if HealBot_ThrottleCnt>HealBot_ThrottleTh then
                HealBot_Action_ResetUnitStatus(xUnit)
            else
                HealBot_RecalcHeals(hbGUID)
            end
            HealBot_ThrottleCnt=HealBot_ThrottleCnt+1
            if HealBot_Config.CDCshownAB==1 then
                HealBot_Action_SetUnitDebuffStatus(hbGUID)
            end
        end
    end
    
    if HealBot_UnitDebuff[hbGUID] then
        if HealBot_UnitDebuff[hbGUID]["name"]~=DebuffNameIn then
            DebuffNameIn=HealBot_UnitDebuff[hbGUID]["name"]
            inSpellRange = HealBot_UnitInRange(HealBot_dSpell, xUnit)
            if HealBot_Config.CDCshownAB==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Aggro-3) and (HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[DebuffNameIn] or 1)==1 then
                HealBot_Action_SetUnitDebuffStatus(hbGUID,debuffCodes[DebuffType])
                HealBot_Action_UpdateAggro(xUnit,"debuff",debuffCodes[DebuffType],hbGUID, 0)
            end
            if HealBot_Config.ShowDebuffWarning==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Screen-3) then
                if HealBot_Globals.CDCBarColour[DebuffNameIn] then
                    UIErrorsFrame:AddMessage(UnitName(xUnit).." suffers from "..DebuffNameIn, 
                                             HealBot_Globals.CDCBarColour[DebuffNameIn].R,
                                             HealBot_Globals.CDCBarColour[DebuffNameIn].G,
                                             HealBot_Globals.CDCBarColour[DebuffNameIn].B,
                                             1, UIERRORS_HOLD_TIME);
                elseif DebuffType == HEALBOT_CUSTOM_en then
                    UIErrorsFrame:AddMessage(UnitName(xUnit).." suffers from "..DebuffNameIn,                                             
                                             HealBot_Globals.CDCBarColour[DebuffType].R,
                                             HealBot_Globals.CDCBarColour[DebuffType].G,
                                             HealBot_Globals.CDCBarColour[DebuffType].B,
                                             1, UIERRORS_HOLD_TIME);
                else
                    UIErrorsFrame:AddMessage(UnitName(xUnit).." suffers from "..DebuffNameIn, 
                                             HealBot_Config.CDCBarColour[DebuffType].R,
                                             HealBot_Config.CDCBarColour[DebuffType].G,
                                             HealBot_Config.CDCBarColour[DebuffType].B,
                                             1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config.SoundDebuffWarning==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config.SoundDebuffPlay)
            end

            if inSpellRange >-1 then
                if HealBot_ThrottleCnt>HealBot_ThrottleTh then
                    HealBot_Action_ResetUnitStatus(xUnit)
                else
                    HealBot_RecalcHeals(hbGUID)
                end
                HealBot_ThrottleCnt=HealBot_ThrottleCnt+1
            else
                HealBot_Action_ResetUnitStatus(xUnit)
            end
            if HealBot_IsFighting then HealBot_OnEvent_UnitCombat(nil,xUnit) end
        else
            DebuffNameIn=HealBot_UnitDebuff[hbGUID]["name"]
        end
        if Healbot_Config_Skins.ShowDebuffIcon[Healbot_Config_Skins.Current_Skin]==1 and (HealBot_PlayerGUID==hbGUID or UnitIsVisible(xUnit)) then
            if DebuffNameIn then
                DebuffSpellId=HealBot_UnitDebuff[hbGUID]["spellId"]
                if not HealBot_DeBuff_Texture["t"..DebuffSpellId] and curDebuffs[DebuffNameIn]["texture"] then HealBot_DeBuff_Texture["t"..DebuffSpellId]=curDebuffs[DebuffNameIn]["texture"] end
                if (curDebuffs[DebuffNameIn]["expirationTime"] or 0)==0 then curDebuffs[DebuffNameIn]["expirationTime"]=hbNoEndTime end
                if HealBot_DeBuff_Texture["t"..DebuffSpellId] then
                    if not trackdebuffIcon[hbGUID] then 
                        trackdebuffIcon[hbGUID]=DebuffNameIn
                    elseif trackdebuffIcon[hbGUID]~=DebuffNameIn and HealBot_Player_HoT[hbGUID] and HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..trackdebuffIcon[hbGUID].."!"..DebuffSpellId] then
                        HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..trackdebuffIcon[hbGUID].."!"..DebuffSpellId]=1
                        HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..trackdebuffIcon[hbGUID].."!"..DebuffSpellId)
                        DeBuff_Count[hbGUID]=-1
                        trackdebuffIcon[hbGUID]=DebuffNameIn
                    end
                    if not curDebuffs[DebuffNameIn]["bCount"] then curDebuffs[DebuffNameIn]["bCount"]=1 end
                    if not HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]={} end
                    if (DeBuff_Count[hbGUID] or -1)~=curDebuffs[DebuffNameIn]["bCount"] then
                        DeBuff_Count[hbGUID]=curDebuffs[DebuffNameIn]["bCount"]
                        if not HealBot_Globals.HealBot_Custom_Debuffs_RevDur[DebuffNameIn] then
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=curDebuffs[DebuffNameIn]["expirationTime"]+1
                        else
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=99
                        end
                    elseif not HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId] then 
                        if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[DebuffNameIn] then
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=99
                        else
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=curDebuffs[DebuffNameIn]["expirationTime"]+1 
                        end
                    end
                    if not HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId] then HealBot_Player_HoT_Icons[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=0 end
                    if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[DebuffNameIn] then
                        if HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]==99 then
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=HealBot_CustomDebuff_RevDurLast[DebuffNameIn][hbGUID]
                            HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId)
                        end
                    else
                        if HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]~=curDebuffs[DebuffNameIn]["expirationTime"] then
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=curDebuffs[DebuffNameIn]["expirationTime"]
                            HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId)
                        end
                    end
                end
            elseif HealBot_Player_HoT[hbGUID] and HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId] then
                HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId]=1
                HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..DebuffNameIn.."!"..DebuffSpellId)
                trackdebuffIcon[hbGUID]=nil
            end
        end
    end
end

local hbStanceBuffs = {
    [HEALBOT_SEAL_OF_TRUTH]=1,
    [HEALBOT_SEAL_OF_RIGHTEOUSNESS]=2,
    [HEALBOT_SEAL_OF_INSIGHT]=3,
    [HEALBOT_STANCE_MONK_SERPENT]=1,
    [HEALBOT_STANCE_MONK_TIGER]=2,
    }
    
function HealBot_CheckUnitBuffs(hbGUID)
    if HealBot_Config.NoAuraWhenRested==(IsResting() or 2) then 
        HealBot_ClearAllBuffs()
        return 
    end
    xUnit=HealBot_UnitID[hbGUID]
    if not UnitIsPlayer(xUnit) then return end
    if not xUnit or not HealBot_Unit_Button[xUnit] or not UnitExists(xUnit) then return end
    _,BuffClass=UnitClass(xUnit)
    if not BuffClass then BuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end
    y = 1;

    for x,_ in pairs(PlayerBuffs) do
        PlayerBuffs[x]=nil;
    end

    while true do
        bName,_,_,_,_,_,w,_,_,_, spellID, canApplyAura = UnitAura(xUnit,y,"HELPFUL") 
        if bName then
            y = y + 1;
            if not hbExcludeBuffSpells[spellID] then
                PlayerBuffs[bName]=true
               -- HealBot_AddDebug("HealBot_CheckBuffs added PlayerBuffs buff="..bName)
                if HealBot_CheckBuffs[bName] then
                    if w-GetTime()>0 then
                        HealBot_SetUnitBuffTimer(hbGUID,bName,w)
                    elseif HealBot_PlayerBuff[hbGUID] and HealBot_PlayerBuff[hbGUID][bName] then
                        if HealBot_PlayerBuff[hbGUID][bName]==HealBot_CheckBuffsTime then
                            HealBot_PlayerBuff[hbGUID][bName]=nil
                            HealBot_ResetCheckBuffsTime()
                        else
                            HealBot_PlayerBuff[hbGUID][bName]=nil
                        end
                    --	HealBot_AddDebug("HealBot_CheckBuffs buff="..z)
                    end
                end
            end
        else
            do break end
        end
    end 

    if HealBot_PlayerBuff[hbGUID] then
        PlayerBuffsGUID=HealBot_PlayerBuff[hbGUID]
        for z,_ in pairs (PlayerBuffsGUID) do
            if not PlayerBuffs[z] then
            --  HealBot_AddDebug("Removed buff="..z)
                if PlayerBuffsGUID[z]==HealBot_CheckBuffsTime then
                    PlayerBuffsGUID[z]=nil
                    HealBot_ResetCheckBuffsTime()
                else
                    PlayerBuffsGUID[z]=nil
                end
            end
        end
        for x,_ in pairs(PlayerBuffs) do
            if HealBot_PlayerBuff[hbGUID][x] and HealBot_PlayerBuff[hbGUID][x] < GetTime() then
                PlayerBuffs[x]=nil
             --   HealBot_AddDebug("HealBot_CheckBuffs removed PlayerBuffs buff="..bName)
            end
        end
    end
    
    HasWeaponBuff=GetWeaponEnchantInfo()
    bName=nil;
    for k in pairs(HealBot_BuffWatch) do
        --HealBot_AddDebug("HealBot_CheckUnitBuffs checking for buff "..HealBot_BuffWatch[k])
        if not PlayerBuffs[HealBot_BuffWatch[k]] then
            local checkthis=false;
            local WatchTarget, WatchGUID=HealBot_Options_retBuffWatchTarget(HealBot_BuffWatch[k], hbGUID);
            z, x, _ = GetSpellCooldown(HealBot_BuffWatch[k]);
            if not x then
                -- Spec change within that last few secs - buff outdated so do nothing
                   -- HealBot_AddDebug("HealBot_CheckUnitBuffs spec change")
            elseif x<2 then
                if hbStanceBuffs[HealBot_BuffWatch[k]] then
                    local index = GetShapeshiftForm() or 0
                    if hbStanceBuffs[HealBot_BuffWatch[k]]~=index then checkthis=true end
                elseif WatchTarget["Raid"] then
                    checkthis=true;
                elseif WatchTarget["Party"] then 
					if (UnitInParty(xUnit) or hbGUID==HealBot_PlayerGUID) then checkthis=true; end
                elseif WatchTarget["Self"] then
                    if hbGUID==HealBot_PlayerGUID then checkthis=true end
                elseif WatchTarget[strsub(BuffClass,1,4)] then
                    checkthis=true
                elseif WatchTarget["PvP"] then
				    if UnitIsPVP(xUnit) then checkthis=true; end
				elseif WatchTarget["PvE"] then
				    if not UnitIsPVP(xUnit) then checkthis=true; end
                elseif WatchTarget["Name"] then
				    if hbGUID==WatchGUID then checkthis=true; end
                elseif WatchTarget["Focus"] then
				    if UnitIsUnit(xUnit, "focus") then checkthis=true; end
                elseif WatchTarget["MainTanks"] then
                    for i=1, #HealBot_MainTanks do
                        if hbGUID==HealBot_MainTanks[i] then
                            checkthis=true;
                            break;
                        end
                    end
                    for i=1, #HealBot_MainAssists do
                        if hbGUID==HealBot_MainAssists[i] then
                            checkthis=true;
                            break;
                        end
                    end
                    for i=1, #HealBot_CTRATanks do
                        if hbGUID==HealBot_CTRATanks[i] then
                            checkthis=true;
                            break;
                        end
                    end
                elseif WatchTarget["MyTargets"] then
                    myhTargets=HealBot_GetMyHealTargets();
                    for i=1, #myhTargets do
                        if hbGUID==myhTargets[i] then
                            checkthis=true;
                            break;
                        end
                    end
                end
            elseif not HealBot_ReCheckBuffsTime or HealBot_ReCheckBuffsTime>z+x then
                HealBot_ReCheckBuffsTime=z+x
                HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=hbGUID
            elseif HealBot_ReCheckBuffsTime<z+x then
                HealBot_ReCheckBuffsTimed[z+x]=hbGUID
            end
            if CheckWeaponBuffs[HealBot_BuffWatch[k]] and HasWeaponBuff then checkthis=false end
            if  (HealBot_BuffWatch[k]==HEALBOT_POWER_WORD_FORTITUDE or HealBot_BuffWatch[k]==HEALBOT_COMMANDING_SHOUT)
            and (PlayerBuffs[HEALBOT_BLOOD_PACT] or PlayerBuffs[HEALBOT_ZAMAELS_PRAYER]) then checkthis=false end
            if checkthis then
                if HealBot_BuffNameSwap[HealBot_BuffWatch[k]] or HealBot_BuffNameSwap2[HealBot_BuffWatch[k]] then
                    local altActive=nil
                    if HealBot_BuffNameSwap[HealBot_BuffWatch[k]] then
                        checkthis=HealBot_BuffNameSwap[HealBot_BuffWatch[k]];
                        if PlayerBuffs[checkthis] then
                            altActive=true
                        end
                    end
                    if not altActive and HealBot_BuffNameSwap2[HealBot_BuffWatch[k]] then
                        checkthis=HealBot_BuffNameSwap2[HealBot_BuffWatch[k]];
                        if PlayerBuffs[checkthis] then
                            altActive=true
                        end
                    end
                    if not altActive then
                        bName=HealBot_BuffWatch[k];
                        break
                    end
                else
                    bName=HealBot_BuffWatch[k];
                    break
                end
            end
        end
    end
    if bName then
        if HealBot_UnitBuff[hbGUID] and HealBot_UnitBuff[hbGUID]==bName then
            return
        else
            HealBot_UnitBuff[hbGUID]=bName;
            HealBot_Action_ResetUnitStatus(xUnit)
        end
    elseif HealBot_UnitBuff[hbGUID] then 
        HealBot_UnitBuff[hbGUID]=nil
        if HealBot_ThrottleCnt>HealBot_ThrottleTh then
            HealBot_Action_ResetUnitStatus(xUnit)
        else
            HealBot_RecalcHeals(hbGUID)
        end
        HealBot_ThrottleCnt=HealBot_ThrottleCnt+1
    end
end

local needReset=nil
function HealBot_OnEvent_PlayerRegenDisabled(self)
    if not HealBot_Loaded then return end
    if not HealBot_PlayerGUID then
        HealBot_Load("playerRD")      
        needReset=true
    elseif (Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 and UnitExists("target") and not UnitIsEnemy("target", "player")) or HealBot_Panel_retTestBars() or HealBot_Loaded<9 then
        HealBot_RecalcParty(true);
    else
        HealBot_EnteringCombat()
    end
    if HealBot_Config.BuffWatch==1 and HealBot_Config.BuffWatchInCombat==0 then
        for xGUID,_ in pairs(HealBot_UnitBuff) do
            HealBot_UnitBuff[xGUID]=nil
            if HealBot_UnitID[xGUID] and HealBot_Unit_Button[HealBot_UnitID[xGUID]] then
                HealBot_RecalcHeals(xGUID)
                if not HealBot_DelayAuraBCheck[xGUID] then
                    HealBot_DelayAuraBCheck[xGUID]=GetTime()
                    HealBot_luVars["DelayAuraBCheck"]=true
                end
            end
        end
    end
    
    if HealBot_Config.DebuffWatch==1 and HealBot_Config.DebuffWatchInCombat==0 then
        for xGUID,_ in pairs(HealBot_UnitDebuff) do
            HealBot_UnitDebuff[xGUID]=nil
            if HealBot_UnitID[xGUID] and HealBot_Unit_Button[HealBot_UnitID[xGUID]] then
                HealBot_RecalcHeals(xGUID)
                if not HealBot_DelayAuraDCheck[xGUID] then
                    HealBot_DelayAuraDCheck[xGUID]=GetTime()
                    HealBot_luVars["DelayAuraDCheck"]=true
                end
            end
        end
    end
    if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Config.ActionVisible==0 and HealBot_Config.DisabledNow==0 then HealBot_TogglePanel(HealBot_Action) end
    if Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Current_Skin]==0 and HealBot_luVars["HighlightTarget"] then
        if (HealBot_Action_retAggro(HealBot_UnitGUID(HealBot_luVars["HighlightTarget"])) or "z")=="h" then
            HealBot_Action_UpdateAggro(HealBot_luVars["HighlightTarget"],"off",nil,HealBot_UnitGUID(HealBot_luVars["HighlightTarget"]), 0)
            HealBot_luVars["HighlightTarget"]=nil
        end
    end        
    if Healbot_Config_Skins.LowManaIndIC[Healbot_Config_Skins.Current_Skin]==0 then HealBot_ClearLowMana() end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_OnEvent_PlayerRegenEnabled(self)
    HealBot_luVars["IsReallyFighting"] = true
end

function HealBot_Not_Fighting()
    if Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 and UnitExists("target") and not UnitIsEnemy("target", "player") then
        HealBot_RecalcParty(nil) 
    end
    if needReset then
        HealBot_Reset_flag=true 
        needReset=nil
    end
    if HealBot_Globals.DisableToolTipInCombat==1 then
        if HealBot_Action_TooltipUnit then
            HealBot_Action_ShowTooltip(HealBot_Action_TooltipUnit)
        elseif HealBot_Action_DisableTooltipUnit then
            HealBot_Action_ShowDisabledTooltip(HealBot_Action_DisableTooltipUnit)
        end
    end
    if HealBot_InCombatUpdCntFlag then
        HealBot_InCombatUpdCntFlag=nil
        HealBot_Reset_UnitHealth()
    end
    HealBot_ClearAggro(true)
    if Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.LowManaIndIC[Healbot_Config_Skins.Current_Skin]==0 then
        HealBot_CheckLowMana()
    end
end


function HealBot_CheckLowMana(hbGUID)
    if hbGUID then
        HealBot_CheckUnitLowMana(hbGUID)
    else
        for xGUID,_ in pairs(hbManaPlayers) do
            HealBot_CheckUnitLowMana(xGUID)
        end
    end
end

function HealBot_ClearLowMana()
    for xGUID,_ in pairs(hbCurLowMana) do
        xUnit=HealBot_UnitID[xGUID]
        bar = HealBot_Action_HealthBar(HealBot_Unit_Button[xUnit]);
        if bar then
            iconName = _G[bar:GetName().."Icontm1"];
            iconName:SetAlpha(0)
            iconName = _G[bar:GetName().."Icontm2"];
            iconName:SetAlpha(0)
            iconName = _G[bar:GetName().."Icontm3"];
            iconName:SetAlpha(0)
            hbCurLowMana[xGUID]=nil
        end
    end
end

local hbLowManaTrig={[1]=1,[2]=2,[3]=3}

function HealBot_setLowManaTrig()
    if Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]==2 then
        hbLowManaTrig={[1]=10,[2]=20,[3]=30}
    elseif Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]==3 then
        hbLowManaTrig={[1]=15,[2]=30,[3]=45}
    elseif Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]==4 then
        hbLowManaTrig={[1]=20,[2]=40,[3]=60}
    elseif Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]==5 then
        hbLowManaTrig={[1]=25,[2]=50,[3]=75}
    elseif Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Current_Skin]==6 then
        hbLowManaTrig={[1]=30,[2]=60,[3]=90}
    else
        hbLowManaTrig={[1]=1,[2]=2,[3]=3}
    end
end

function HealBot_CheckUnitLowMana(hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    bar = HealBot_Action_HealthBar(HealBot_Unit_Button[xUnit]);
    if bar then
        mana,maxmana=HealBot_UnitMana(xUnit)
        if mana and maxmana then
            if maxmana==0 then maxmana=1 end
            z=floor((mana/maxmana)*100)
            y=0
            if z<hbLowManaTrig[1] then
                y=1
            elseif z<hbLowManaTrig[2] then
                y=2
            elseif z<hbLowManaTrig[3] then
                y=3
            end
            if y==1 then
                iconName = _G[bar:GetName().."Icontm1"];
                iconName:SetAlpha(1)
                iconName = _G[bar:GetName().."Icontm2"];
                iconName:SetAlpha(0)
                iconName = _G[bar:GetName().."Icontm3"];
                iconName:SetAlpha(0)
                hbCurLowMana[hbGUID]=3
            elseif y==2 then
                iconName = _G[bar:GetName().."Icontm1"];
                iconName:SetAlpha(1)
                iconName = _G[bar:GetName().."Icontm2"];
                iconName:SetAlpha(1)
                iconName = _G[bar:GetName().."Icontm3"];
                iconName:SetAlpha(0)
                hbCurLowMana[hbGUID]=2
            elseif y==3 then
                iconName = _G[bar:GetName().."Icontm1"];
                iconName:SetAlpha(1)
                iconName = _G[bar:GetName().."Icontm2"];
                iconName:SetAlpha(1)
                iconName = _G[bar:GetName().."Icontm3"];
                iconName:SetAlpha(1)
                hbCurLowMana[hbGUID]=1
            else
                iconName = _G[bar:GetName().."Icontm1"];
                iconName:SetAlpha(0)
                iconName = _G[bar:GetName().."Icontm2"];
                iconName:SetAlpha(0)
                iconName = _G[bar:GetName().."Icontm3"];
                iconName:SetAlpha(0)
                hbCurLowMana[hbGUID]=nil
            end
        else
            iconName = _G[bar:GetName().."Icontm1"];
            iconName:SetAlpha(0)
            iconName = _G[bar:GetName().."Icontm2"];
            iconName:SetAlpha(0)
            iconName = _G[bar:GetName().."Icontm3"];
            iconName:SetAlpha(0)
            hbCurLowMana[hbGUID]=nil
        end
    end
end



function HealBot_CheckPlayerMana(hbGUID, unit)
    if ((UnitPowerType(unit) or 1)==0) then
        hbManaPlayers[hbGUID]=UnitName(unit)
    else
        _,uClass=UnitClass(unit)
        uClass=strsub((uClass or "XXXX"),1,4)
        if uClass=="DRUI" then
            hbManaPlayers[hbGUID]=UnitName(unit)
        end
    end
end

function HealBot_EnteringCombat()
    if HealBot_Globals.DisableToolTipInCombat==1 and (HealBot_Action_TooltipUnit or HealBot_Action_DisableTooltipUnit) then
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_IsFighting = true;
end

function HealBot_OnEvent_UnitNameUpdate(self,unit)
    xGUID=HealBot_UnitGUID(unit)
    if HealBot_UnitID[xGUID] then
        if unit==HealBot_UnitID[xGUID] then
            HealBot_Action_ResetUnitStatus(unit)    
        elseif HealBot_IsFighting then 
            HealBot_InCombatUpdate=true
        else
            HealBot_UnitNameUpdate(unit,HealBot_UnitGUID(unit))
        end
    end
end

function HealBot_UnitNameUpdate(unUnit,unGUID)
    if unGUID and unGUID==HealBot_PlayerGUID then unUnit="player" end
    if HealBot_Unit_Button[unUnit] and UnitIsFriend("player",unUnit) then
        if UnitExists(unUnit) and unGUID then
            HealBot_UnitName[unGUID]=UnitName(unUnit)
            HealBot_UnitID[unGUID]=unUnit
            if HealBot_notVisible[unGUID] then HealBot_notVisible[unGUID]=unUnit end
            HealBot_CheckAllDebuffs(unGUID)
            HealBot_CheckAllBuffs(unGUID)
            if HealBot_HoT_Active_Button[unGUID] then
                b=HealBot_Unit_Button[unUnit]
                if HealBot_HoT_Active_Button[unGUID]~=b then
                    HealBot_HoT_MoveIcon(HealBot_HoT_Active_Button[unGUID], b, unGUID)
                    HealBot_HoT_Active_Button[unGUID]=b
                end
            end    
            HealBot_unitHealth[unGUID]=nil
            HealBot_BarCheck[unGUID]="A"
            HealBot_ClearUnitAggro(unUnit, unGUID)
            HealBot_CheckAllUnitVehicle(unUnit)
            HealBot_Queue_MyBuffsCheck(unGUID,unUnit)
        end
        HealBot_Action_ResetUnitStatus(unUnit) 
    end
   -- if Delay_RecalcParty<1 then Delay_RecalcParty=1; end
end

function HealBot_UnitNameOnly(unitName)
    uName=string.match(unitName, "^[^-]*") or "noName"
    return uName
end

function HealBot_CheckHealth(hbGUID)
    if not HealBot_BarCheck[hbGUID] then 
        HealBot_BarCheck[hbGUID]="H" 
    else
        HealBot_BarCheck[hbGUID]="A"
    end
end

function HealBot_CheckPower(hbGUID)
    if not HealBot_BarCheck[hbGUID] then 
        HealBot_BarCheck[hbGUID]="P" 
    else
        HealBot_BarCheck[hbGUID]="A"
    end
end

function HealBot_IDs(unit,hbGUID)
    xUnit=HealBot_UnitID[hbGUID] or HealBot_UnitID[unit]
    if xUnit and not UnitIsUnit(unit,xUnit) then
        xUnit=HealBot_RaidUnit("unknown",hbGUID,nil)
        HealBot_UnitNameUpdate(xUnit,hbGUID)
    end
    return xUnit
end

function HealBot_RaidUnit(unit,hbGUID,unitName)
    if unitName then
        if not unit or UnitName(unit)~=unitName then
            unit=nil
            if unitName==HealBot_PlayerName then
                unit="player"
            elseif GetNumGroupMembers()>0 then
                for j=1,40 do
                    xUnit = "raid"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                    xUnit = "raidpet"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                end
            elseif GetNumGroupMembers()>0 then
                for j=1,4 do
                    xUnit = "party"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                    xUnit = "partypet"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                end
            end
            if not unit then
                if UnitName("focus")==unitName then
                    unit="focus"
                elseif UnitName("target")==unitName then
                    unit="target"
                end
            end
        end
    else
        if hbGUID==HealBot_PlayerGUID then
            unit="player"
        elseif HealBot_UnitGUID("pet")==hbGUID then
            unit="pet"
        elseif Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitGUID("focus")==hbGUID then
            unit="focus"
        elseif HealBot_UnitID[hbGUID] and HealBot_UnitGUID(HealBot_UnitID[hbGUID])==hbGUID then
            unit=HealBot_UnitID[hbGUID]
        elseif unit and GetNumGroupMembers()>0 then
            for j=1,40 do
                xUnit = "raid"..j
                if UnitGUID(xUnit)==hbGUID then
                    unit=xUnit
                    do break end
                end
                xUnit = "raidpet"..j
                if HealBot_UnitGUID(xUnit)==hbGUID then
                    unit=xUnit
                    do break end
                end
            end
        elseif unit and GetNumGroupMembers()>0 then
            for j=1,4 do
                xUnit = "party"..j
                if UnitGUID(xUnit)==hbGUID then
                    unit=xUnit
                    do break end
                end
                xUnit = "partypet"..j
                if HealBot_UnitGUID(xUnit)==hbGUID then
                    unit=xUnit
                    do break end
                end
            end
        end
    end
    return unit
end

function HealBot_UnitGUID(unit)
    local isPet=false
    if not unit or not UnitExists(unit) then
        xGUID=nil
    else
        if unit=="pet" then
            s=string.gsub(UnitName(unit), " ", "")
            xGUID=UnitGUID("player")..s
            HealBot_PetGUID[UnitGUID(unit)]=xGUID
            isPet=true
        elseif strsub(unit,1,7)=="raidpet" then
            if strsub(unit,8) and UnitGUID("raid"..strsub(unit,8)) then
                s=string.gsub(UnitName(unit), " ", "")
                xGUID=UnitGUID("raid"..strsub(unit,8))..s
                HealBot_PetGUID[UnitGUID(unit)]=xGUID
            else
                HealBot_AddDebug("No owner found for pet "..unit.." ("..s..")")
                xGUID=UnitGUID(unit)
            end
            isPet=true
        elseif strsub(unit,1,8)=="partypet" then
            if strsub(unit,9) and UnitGUID("party"..strsub(unit,9)) then
                s=string.gsub(UnitName(unit), " ", "")
                xGUID=UnitGUID("party"..strsub(unit,9))..s
                HealBot_PetGUID[UnitGUID(unit)]=xGUID
            else
                HealBot_AddDebug("No owner found for pet "..unit.." ("..s..")")
                xGUID=UnitGUID(unit)
            end
            isPet=true
        else
            xGUID=UnitGUID(unit)
        end
    end
    return xGUID, isPet
end

function HealBot_retPetGUID(hbGUID)
    return HealBot_PetGUID[hbGUID]
end

function HealBot_UnitPet(unit)
    vUnit=nil
    if unit=="player" then
        vUnit="pet"
    elseif strsub(unit,1,4)=="raid" then
        vUnit="raidpet"..strsub(unit,5)
    elseif strsub(unit,1,5)=="party" then
        vUnit="partypet"..strsub(unit,6)
    end
    return vUnit
end

function HealBot_IC_PartyMembersChanged()
    z=false
    HealBot_InCombatUpdCnt=HealBot_InCombatUpdCnt+1
    if HealBot_InCombatUpdCnt<15 then
        for x,_ in pairs(HealBot_UpUnitInCombat) do
            HealBot_UpUnitInCombat[x]=nil
        end
        for xGUID,xUnit in pairs(HealBot_UnitID) do
            if HealBot_UnitGUID(xUnit) and HealBot_UnitGUID(xUnit)~=xGUID then
            --    HealBot_ClearAggro(nil, xUnit)
            --    HealBot_ClearAggro(nil, HealBot_GetUnitID(xGUID))
                HealBot_UpUnitInCombat[xGUID]=xUnit
            end
       end
        for zGUID,zUnit in pairs(HealBot_UpUnitInCombat) do
            HealBot_UnitNameUpdate(HealBot_GetUnitID(zGUID),zGUID)
            HealBot_UnitNameUpdate(zUnit,HealBot_UnitGUID(zUnit))
            z=true
        end
    end
    if z then
        HealBot_InCombatUpdCnt=HealBot_InCombatUpdCnt+1
        HealBot_InCombatUpdCntFlag=true
    else
       -- HealBot_AddDebug("HealBot_InCombatUpdCnt="..HealBot_InCombatUpdCnt)
        HealBot_InCombatUpdate=false
        HealBot_InCombatUpdCnt=0
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(nil) end
    end
end

function HealBot_GetUnitID(hbGUID)
    xUnit=nil
    for _,zUnit in pairs(HealBot_UnitID) do
        if HealBot_UnitGUID(zUnit)==hbGUID then
            xUnit=zUnit
            do break end
        end
    end
    return xUnit
end

function HealBot_OnEvent_PartyMembersChanged(self)
    if HealBot_IsFighting then HealBot_InCombatUpdate=true end
    HealBot_luVars["CheckSkin"]=true
    if HealBot_luVars["IsSolo"] and HealBot_Config.DisableSolo==1 then
        HealBot_Options_DisableCheck()
        HealBot_Timer1=5
        HealBot_AddDebug("Set HealBot_Timer1=5 - Event_PartyMembersChanged")
    end
    Delay_RecalcParty=2;
    if Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 then
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if not UnitExists(xUnit) then
                HealBot_UnitName[xUnit]=HEALBOT_WORD_RESERVED..":"..xUnit
                HealBot_Action_ResetUnitStatus(xUnit) 
            end
        end
        HealBot_Action_CheckReserved()
    end
end

function HealBot_PartyUpdate_CheckSkin()
    _,z = IsInInstance()
    HealBot_luVars["IsSolo"]=nil
    HealBot_luVars["CheckSkin"]=nil
    if z == "arena" then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=7 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==7 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif z=="pvp" then
        y=GetRealZoneText()
        if GetNumGroupMembers()>27 or y==HEALBOT_ZONE_AV or y==HEALBOT_ZONE_IC then
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=10 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==10 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        elseif GetNumGroupMembers()>12 or y==HEALBOT_ZONE_SA or y==HEALBOT_ZONE_ES or y==HEALBOT_ZONE_AB then
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=9 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==9 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        else
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=8 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==8 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        end
    elseif IsInRaid() then
        if GetNumGroupMembers()>29 then
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=6 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==6 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        elseif GetNumGroupMembers()>14 then
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=5 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==5 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        else
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=4 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==4 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        end
    elseif GetNumGroupMembers()>0 then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=3 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==3 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    else
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=2 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==2 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
        HealBot_luVars["IsSolo"]=true
        HealBot_Options_DisableCheck()
    end
    if Delay_RecalcParty>2 then
        HealBot_RecalcParty(nil);
    end
end

function HealBot_OnEvent_PlayerTargetChanged(self)
    if Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 then
        Delay_RecalcParty=2; 
        if not HealBot_IsFighting then HealBot_RecalcParty(nil) end
        if UnitExists("target") and not UnitIsEnemy("target", "player") then
            HealBot_OnEvent_UnitAura(nil,"target")
        end
        if Healbot_Config_Skins.TargetBarAlwaysShow[Healbot_Config_Skins.Current_Skin]==1 then
            if not UnitExists("target") and HealBot_Unit_Button["target"] then 
                HealBot_UnitName["target"]=HEALBOT_WORD_RESERVED..":".."target"
            --    HealBot_ClearAggro(nil, "target")
            end
            HealBot_RecalcHeals(HealBot_UnitGUID("target") or "target")
            HealBot_Action_ResetUnitStatus("target") 
        end
    end
    if UnitName("target") and HealBot_retHbFocus(UnitName("target")) then
        HealBot_Panel_clickToFocus("Show")
    end
    if Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_luVars["HighlightTargetFound"]=false
        if not HealBot_IsFighting or Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Current_Skin]==1 then
            if UnitExists("target") and not UnitIsDeadOrGhost("target") and not UnitIsEnemy("target", "player") then
                for _,xUnit in pairs(HealBot_UnitID) do
                    if xUnit~="target" then 
                        if UnitIsUnit(xUnit, "target") then
                            if xUnit~="target" then 
                                if HealBot_luVars["HighlightTarget"] and 
                                   HealBot_luVars["HighlightTarget"]~=xUnit and 
                                   (HealBot_Action_retAggro(HealBot_UnitGUID(HealBot_luVars["HighlightTarget"])) or "z")=="h" then
                                    HealBot_Action_UpdateAggro(HealBot_luVars["HighlightTarget"],"off",nil,HealBot_UnitGUID(HealBot_luVars["HighlightTarget"]), 0)
                                end
                                HealBot_luVars["HighlightTargetFound"]=true
                                HealBot_luVars["HighlightTarget"]=xUnit
                               -- HealBot_AddDebug("Aggro Target")
                            end
                            z=HealBot_Action_RetUnitThreat(hbGUID)
                            HealBot_Action_UpdateAggro(xUnit,"target",z,HealBot_UnitGUID(xUnit),0)
                        end
                    end
                end
            end
        end
        if not HealBot_luVars["HighlightTargetFound"] and HealBot_luVars["HighlightTarget"] and 
          (HealBot_Action_retAggro(HealBot_UnitGUID(HealBot_luVars["HighlightTarget"])) or "z")=="h" then
            HealBot_Action_UpdateAggro(HealBot_luVars["HighlightTarget"],"off",HealBot_Action_RetUnitThreat(HealBot_luVars["HighlightTarget"]),HealBot_UnitGUID(HealBot_luVars["HighlightTarget"]), 0)
            HealBot_luVars["HighlightTarget"]=nil
        end    
    end
end

function HealBot_retHighlightTarget()
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unitName)
    if HealBot_Globals.FocusMonitor[unitName] then
        if HealBot_Globals.FocusMonitor[unitName]=="all" then
            return true
        else
            _,z = IsInInstance()
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
    return false
end

function HealBot_OnEvent_ReadyCheck(self,unitName,timer)
    local isLeader = UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")
    if isLeader then
        HealBot_luVars["rcEnd"]=nil
        HealBot_luVars["isLeader"]=true
        HealBot_Comms_SendAddonMsg("HealBot", "RC:I:"..unitName..":"..timer, HealBot_AddonMsgType, HealBot_PlayerName)
    else
        HealBot_luVars["isLeader"]=false
    end
end

function HealBot_OnEvent_hbReadyCheck(unitName,timer)
    local lUnit=HealBot_RaidUnit(hbTempUnitNames[unitName],nil,unitName)
    if not HealBot_luVars["rcEnd"] or HealBot_luVars["rcEnd"]<GetTime()+timer then
        if lUnit then
            hbTempUnitNames[unitName]=lUnit
            HealBot_luVars["rcEnd"]=GetTime()+timer
            if HealBot_Unit_Button[lUnit] then HealBot_OnEvent_ReadyCheckUpdate(lUnit,"Y") end
            for xUnit,_ in pairs(HealBot_Unit_Button) do
                if xUnit~=lUnit and strsub(xUnit,1,8)~="partypet" and strsub(xUnit,1,7)~="raidpet" then
                    HealBot_OnEvent_ReadyCheckUpdate(xUnit,"W")
                end
            end
        end
    end
end

function HealBot_OnEvent_ReadyCheckConfirmed(self,unit,response)
    xUnit, xGUID = HealBot_validUnit(unit)
    if not xUnit then return end
    if HealBot_Unit_Button[xUnit] then 
		local hbResponse="N"
        if response then hbResponse="Y" end
		if HealBot_luVars["isLeader"] then HealBot_OnEvent_ReadyCheckUpdate(xUnit,hbResponse) end
        HealBot_Comms_SendAddonMsg("HealBot", "RC:U:"..xGUID..":"..hbResponse, HealBot_AddonMsgType, HealBot_PlayerName)
    end
end

function HealBot_OnEvent_hbReadyCheckConfirmed(hbGUID,response)
    unit=HealBot_UnitID[hbGUID] or hbGUID
    if HealBot_Unit_Button[unit] and not HealBot_luVars["isLeader"] then
        HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    end
end

function HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    bar = HealBot_Action_HealthBar(HealBot_Unit_Button[unit]);
    if bar then
        iconName = _G[bar:GetName().."Icon16"];
        if response=="Y" then
            iconName:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
        elseif response=="W" then
            iconName:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting")
        else
            iconName:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady")
        end
        iconName:SetAlpha(1);
    end
end

function HealBot_OnEvent_ReadyCheckFinished(self)
	HealBot_luVars["rcEnd"]=GetTime()
end

function HealBot_OnEvent_ReadyCheckClear()
    for _,z in pairs(HealBot_Unit_Button) do
        bar = HealBot_Action_HealthBar(z);
        if bar then
            iconName = _G[bar:GetName().."Icon16"];
            iconName:SetAlpha(0);
        end
    end
    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(nil) end
end

function HealBot_OnEvent_RaidTargetUpdate(self)
    for _,xUnit in pairs(HealBot_UnitID) do
        if UnitExists(xUnit) and UnitIsFriend("player",xUnit) then 
            x=GetRaidTargetIndex(xUnit)
            if x then
                if HealBot_RaidTargetChecked(x) then
                    HealBot_TargetIcons[xUnit]=x
                    if HealBot_debuffTargetIcon[xUnit] then HealBot_debuffTargetIcon[xUnit]=x end
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit], x, xUnit)
                end
            else
                if HealBot_debuffTargetIcon[xUnit] then
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit], nil, xUnit)
                    HealBot_debuffTargetIcon[xUnit]=0
                end
                if HealBot_TargetIcons[xUnit] then
                    HealBot_TargetIcons[xUnit]=nil
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit], nil, xUnit)
                end
            end
        end
    end
end

function HealBot_RaidTargetChecked(iconID)
    z=nil
    if iconID==1 then
        if Healbot_Config_Skins.ShowRaidIconStar[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==2 then
        if Healbot_Config_Skins.ShowRaidIconCircle[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==3 then
        if Healbot_Config_Skins.ShowRaidIconDiamond[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==4 then
        if Healbot_Config_Skins.ShowRaidIconTriangle[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==5 then
        if Healbot_Config_Skins.ShowRaidIconMoon[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==6 then
        if Healbot_Config_Skins.ShowRaidIconSquare[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==7 then
        if Healbot_Config_Skins.ShowRaidIconCross[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==8 then
        if Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    end
    return z
end

local HealBot_TargetIconsTextures = {[1]=[[Interface\Addons\HealBot\Images\Star.tga]],
                                     [2]=[[Interface\Addons\HealBot\Images\Circle.tga]],
                                     [3]=[[Interface\Addons\HealBot\Images\Diamond.tga]],
                                     [4]=[[Interface\Addons\HealBot\Images\Triangle.tga]],
                                     [5]=[[Interface\Addons\HealBot\Images\Moon.tga]],
                                     [6]=[[Interface\Addons\HealBot\Images\Square.tga]],
                                     [7]=[[Interface\Addons\HealBot\Images\Cross.tga]],
                                     [8]=[[Interface\Addons\HealBot\Images\Skull.tga]],}
                                     
function HealBot_RaidTargetUpdate(button, iconID, unit)
    bar = HealBot_Action_HealthBar(button);
    if not bar then return end
    if (Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1) or HealBot_debuffTargetIcon[unit] then
        iconName = _G[bar:GetName().."Icon16"];
    else
        iconName = _G[bar:GetName().."Icon15"];
    end
    if iconID then
        iconName:SetTexture(HealBot_TargetIconsTextures[iconID])
        iconName:SetAlpha(1);
    else
        iconName:SetAlpha(0);
    end
end

function HealBot_RaidTargetToggle(switch)
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_OnEvent_RaidTargetUpdate(nil)
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        for _,xUnit in pairs(HealBot_UnitID) do
            if HealBot_TargetIcons[xUnit] then
                HealBot_TargetIcons[xUnit]=nil
                HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit],nil,xUnit)
            end
        end
    end
end

function HealBot_OnEvent_FocusChanged(self)
    if Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]==1 then 
        Delay_RecalcParty=3; 
        if Healbot_Config_Skins.TargetBarAlwaysShow[Healbot_Config_Skins.Current_Skin]==1 then
            if not UnitExists("focus") and HealBot_Unit_Button["focus"] then 
                HealBot_UnitName["focus"]=HEALBOT_WORD_RESERVED..":".."focus"
            --    HealBot_ClearAggro(nil, "focus")
            end
            HealBot_RecalcHeals(HealBot_UnitGUID("focus") or "focus")
            HealBot_Action_ResetUnitStatus("focus") 
        end
    end
end

function HealBot_TalentQuery(unit)
    if unit and UnitIsVisible(unit) and UnitIsConnected(unit) and CheckInteractDistance(unit, 1) and CanInspect(unit) then 
       -- NotifyInspect(unit); 
       TalentQuery:Query(unit)
    end
end

function HealBot_GetUnitTalentInfoReady(unitName, realm, unit, hbGUID)
    HealBot_GetUnitTalentInfo(unit, hbGUID)
end

function HealBot_GetUnitTalentInfo(unit, hbGUID)
	if not hbGUID then return end
    xUnit=unit or HealBot_UnitID[hbGUID]
    if xUnit and UnitExists(xUnit) then HealBot_GetTalentInfo(hbGUID, xUnit) end
end

function HealBot_GetTalentInfo(hbGUID, unit)

    if HealBot_UnitID[hbGUID] then
        s,r=nil,nil
        if hbGUID==HealBot_PlayerGUID then
            i = GetSpecialization()
            if i then
                _, s, _, _, _, r = GetSpecializationInfo(i,false,false) 
                if HealBot_Config.CurrentSpec~=i then 
                    HealBot_Config.CurrentSpec=i 
                    HealBot_InitSpells()
                    HealBot_Options_ResetDoInittab(50)
                    HealBot_Options_ResetDoInittab(40)
                end
            end
        else
            i = GetInspectSpecialization(unit)
            if i then
                _, s = GetSpecializationInfoByID(i) 
                r = GetSpecializationRoleByID(i)
            end
        end
        if s then
            HealBot_UnitSpec[hbGUID] = s.." " 
            if r and r=="TANK" or r=="HEALER" or r=="DAMAGER" then
                HealBot_UnitRole[hbGUID] = r
            elseif s=="TANK" or s=="HEALER" or s=="DAMAGER" then
                HealBot_UnitRole[hbGUID] = s
            end
            if HealBot_useTips then HealBot_talentSpam(hbGUID,"update",0) end
        end
    end
  --  ClearInspectPlayer()
end

function HealBot_SetAddonComms(hbInBG)
    if not hbInBG then
        if GetNumGroupMembers()>5 then
            HealBot_AddonMsgType=2;
        elseif GetNumGroupMembers()>0 then
            HealBot_AddonMsgType=3;
        else
            HealBot_AddonMsgType=4;
        end
    else
        HealBot_AddonMsgType=1;
    end
end

function HealBot_OnEvent_PartyPetChanged(self)
    if Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Current_Skin]==1 and Delay_RecalcParty<2 then
        Delay_RecalcParty=2
    end
end

function HealBot_OnEvent_SystemMsg(self,msg)
    if type(msg)=="string" then
        if (string.find(msg, HB_ONLINE)) or (string.find(msg, HB_OFFLINE)) then
            msg = gsub(msg, "|Hplayer:([^%c^%d^%s^%p]+)|h(.+)|h", "%1")
            uName = msg:match("([^%c^%d^%s^%p]+)")
            xGUID=HealBot_Derive_GUID_fuName(uName)
            if HealBot_UnitID[xGUID] then
                if (string.find(msg, HB_ONLINE)) then
                    HealBot_Action_UnitIsOffline(xGUID,-1)
                else
                    HealBot_Action_UnitIsOffline(xGUID,time())
                end
                HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]);
            end
        end
    end
end

function HealBot_OnEvent_SpellsChanged(self, arg1)
    if arg1==0 then return; end
    if UnitIsDeadOrGhost("player") then return end
    HealBot_OnEvent_TalentsChanged(self)
    HealBot_setOptions_Timer(550)
end

function HealBot_OnEvent_TalentsChanged(self)
    HealBot_UnitSpec[HealBot_PlayerGUID] = " "
    HealBot_CheckTalents=GetTime()+1
end

function HealBot_OnEvent_PlayerEnteringWorld(self)
    if not HealBot_Loaded then 
        return 
    elseif not HealBot_PlayerGUID then
        HealBot_Load("playerEW")      
    end
    HealBot_luVars["DoUpdates"]=true
    
    if Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_trackPartyFrames=true
        HealBot_Options_DisablePartyFrame()
        HealBot_Options_PlayerTargetFrames:Enable();
        
        if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Options_DisablePlayerFrame()
            HealBot_Options_DisablePetFrame()
            HealBot_Options_DisableTargetFrame()
        else
            HealBot_Options_EnablePlayerFrame()
            HealBot_Options_EnablePetFrame()
            HealBot_Options_EnableTargetFrame()
        end
    end
    HealBot_setOptions_Timer(190)
    HealBot_Register_Events()
    HealBot_OnEvent_ZoneChanged(self)
    HealBot_CheckAllUnitVehicle()
    --HealBot_ClearAggro(true)
    HealBot_setOptions_Timer(410)
end

function HealBot_retHealBot_trackPartyFrames()
    return HealBot_trackPartyFrames
end

function HealBot_OnEvent_PlayerLeavingWorld(self)
    HealBot_luVars["DoUpdates"]=false
    HealBot_ClearAggro(true)
  --  if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then HealBot_cpSave(HealBot_Config.CrashProtMacroName.."_0", "Clean") end
    HealBot_UnRegister_Events();
   -- if Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Current_Skin]==1 then
   --     HealBot_Options_EnablePartyFrame()
   -- end
   -- if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
   --     HealBot_Options_EnablePlayerFrame()
   --     HealBot_Options_EnablePetFrame()
   --     HealBot_Options_EnableTargetFrame()
   -- end
end

local uscSpell,uscName,uscGUID=nil,nil,nil
function HealBot_OnEvent_UnitSpellcastSent(self,caster,spellName,spellRank,unitName)
    uscGUID=nil
    uscName = HealBot_UnitNameOnly(unitName)
    if uscName=="" then
        if spellName==HEALBOT_MASS_RESURRECTION or spellName==HEALBOT_PRAYER_OF_HEALING or spellName==HEALBOT_WILD_GROWTH or spellName==HEALBOT_TRANQUILITY then 
            uscName=HealBot_PlayerName 
            uscGUID=HealBot_PlayerGUID
        elseif spellName==HEALBOT_MENDPET then
            uscName=UnitName("pet")
            uscGUID=HealBot_UnitGUID("pet")
        end
    end
    if caster=="player" and uscName == HEALBOT_WORDS_UNKNOWN then
        uscName = HealBot_GetCorpseName(uscName)
    end
    if not uscGUID then
        if uscName==UnitName(HealBot_luVars["TargetUnitID"]) then
            uscGUID=HealBot_UnitGUID(HealBot_luVars["TargetUnitID"])
        elseif HealBot_Derive_GUID_fuName(uscName) then
            uscGUID=HealBot_Derive_GUID_fuName(uscName)
        elseif UnitName("target") and UnitName("target")==uscName then
            xUnit="target"
            uscGUID=HealBot_UnitGUID("target")
        end
    end
    xUnit = HealBot_UnitID[uscGUID];
    if caster=="player" and uscGUID and UnitExists(xUnit) then
        uscSpell=spellName
        if spellName==HEALBOT_MASS_RESURRECTION or spellName==HEALBOT_RESURRECTION or spellName==HEALBOT_ANCESTRALSPIRIT or spellName==HEALBOT_REBIRTH or spellName==HEALBOT_REDEMPTION or spellName==HEALBOT_REVIVE or spellName==HEALBOT_RESUSCITATE then
            if spellName~=HEALBOT_MASS_RESURRECTION then
                HealBot_IamRessing = uscName;
                if HealBot_IamRessing then
                    HealBot_Comms_SendAddonMsg("CTRA", "RES "..HealBot_IamRessing, HealBot_AddonMsgType, HealBot_PlayerName)
                end
                HealBot_CastingTarget = xUnit;
            end
            if Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Current_Skin]==1 then
                if spellName==HEALBOT_MASS_RESURRECTION then           
                    HealBot_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,spellName,xUnit)
                else
                    HealBot_CastNotify(uscName,spellName,xUnit)
                end
            end
        elseif HealBot_Spells[uscSpell] then
            HealBot_CastingTarget = xUnit;
        end
        if HealBot_Spells[uscSpell] or HealBot_OtherSpells[uscSpell] then
            if Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Current_Skin]==0 then
                HealBot_CastNotify(uscName,spellName,xUnit)
            end
        end
        if caster=="player" and HealBot_Options_retIsDebuffSpell(spellName) then
            HealBot_luVars["DebuffSpell"]=GetTime()
        end
    end
end

function HealBot_setHealsAbsorb(hbGUID, state)
    HealBot_HealsAbsorb[hbGUID]=state
end

function HealBot_GetCorpseName(cName)
    z = _G["GameTooltipTextLeft1"];
    x = z:GetText();
    if (x) then
        cName = string.gsub(x, HEALBOT_TOOLTIP_CORPSE, "")
    end
    return cName
end

function HealBot_ResetCheckBuffsTime()
    HealBot_CheckBuffsTime=GetTime()+10000200
    for z,_ in pairs(HealBot_PlayerBuff) do
        if HealBot_PlayerBuff[z] then
            PlayerBuffsGUID=HealBot_PlayerBuff[z]
            for y,_ in pairs (PlayerBuffsGUID) do
                if PlayerBuffsGUID[y]<0 then
                    PlayerBuffsGUID[y]=nil
                elseif PlayerBuffsGUID[y] < HealBot_CheckBuffsTime then
                    HealBot_CheckBuffsTime=PlayerBuffsGUID[y]
                    HealBot_CheckBuffsTimehbGUID=z
                end
            end
        end
    end
    if HealBot_CheckBuffsTime>GetTime()+10000000 then
        HealBot_CheckBuffsTime=nil
        HealBot_CheckBuffsTimehbGUID=nil
    end
end

function HealBot_CastNotify(unitName,spell,unit)
    z = Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Current_Skin];
    s = gsub(Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Current_Skin],"#s",spell)
    s = gsub(s,"#n",unitName)
    w=nil;
    if z==6 then
        w=HealBot_Comms_GetChan(Healbot_Config_Skins.NotifyChan[Healbot_Config_Skins.Current_Skin]) 
        if not w then z=2 end
    end
    if z==5 and not UnitInRaid("player") then z = 4 end
    if z==4 and not UnitInParty("player") then z = 2 end
    if z==3 and UnitIsPlayer(HealBot_CastingTarget) and UnitPlayerControlled(HealBot_CastingTarget) and HealBot_CastingTarget~="player" then
        s = gsub(s,unitName,HEALBOT_WORDS_YOU)
        SendChatMessage(s,"WHISPER",nil,unitName);
    elseif z==4 then
        local inInst=IsInInstance()
        if inInst then
            SendChatMessage(s,"INSTANCE_CHAT",nil,nil);
        else
            SendChatMessage(s,"PARTY",nil,nil);
        end
    elseif z==5 then
        local inInst=IsInInstance()
        if inInst then
            SendChatMessage(s,"INSTANCE_CHAT",nil,nil);
        else
            SendChatMessage(s,"RAID",nil,nil);
        end
    elseif z==6 then
        SendChatMessage(s,"CHANNEL",nil,w);
    else
        HealBot_AddChat(s);
    end
end

function HealBot_OnEvent_UnitSpellcastStart(self,unit,spellName)
    if not HealBot_Unit_Button[unit] then return end
    if HealBot_IsFighting then HealBot_OnEvent_UnitCombat(nil,unit) end
end

function HealBot_OnEvent_UnitSpellcastStop(self,unit,spellName)
    if not HealBot_Unit_Button[unit] then return end
    if UnitGUID(unit)==HealBot_PlayerGUID and HealBot_IamRessing then
        HealBot_Comms_SendAddonMsg("CTRA", "RESNO", HealBot_AddonMsgType, HealBot_PlayerName)
        HealBot_IamRessing=nil;
    end
end

function HealBot_OnEvent_UnitSpellcastFail(self,unit,spellName)
    if not HealBot_Unit_Button[unit] then return end
    if UnitGUID(unit)==HealBot_PlayerGUID and HealBot_IamRessing then
        HealBot_Comms_SendAddonMsg("CTRA", "RESNO", HealBot_AddonMsgType, HealBot_PlayerName)
        HealBot_IamRessing=nil;
    end
end

local HoTtxt2=nil
local temp_caster={}
local temp_HoT={}
local temp_sID={}
function HealBot_HoT_Update(hbGUID, hotID)
    huUnit=HealBot_UnitID[hbGUID]
    huHoTtime=HealBot_Player_HoT[hbGUID]
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    _, hotName, sID=string.split("!", hotID)
    iTexture=HealBot_Icon_Texture(sID)
    if huHoTtime[hotID]>10 then
        if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[hotName] then
            secLeft=ceil(GetTime()-huHoTtime[hotID])
        else
            secLeft=floor(huHoTtime[hotID]-GetTime())
        end
    else
        secLeft=-1
    end
    if huHoTicon[hotID]>0 then
        if secLeft<0 then
            HealBot_HoT_UpdateIcon(HealBot_Unit_Button[huUnit], huHoTicon[hotID], -1)
            huHoTtime[hotID]=9
            huHoTicon[hotID]=0
            if HealBot_HoT_Count[hotID] and HealBot_HoT_Count[hotID][hbGUID] then
                HealBot_HoT_Count[hotID][hbGUID]=nil
            end
            if not HealBot_DeBuff_Texture["t"..sID] then 
                HealBot_HoT_RefreshIcons(hbGUID,HealBot_Unit_Button[huUnit]) 
            else
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    HealBot_Action_SetClassIconTexture(HealBot_Unit_Button[huUnit], huUnit)
                    if HealBot_debuffTargetIcon[huUnit] then HealBot_debuffTargetIcon[huUnit]=nil end
                elseif HealBot_debuffTargetIcon[huUnit] and HealBot_debuffTargetIcon[huUnit]>0 then
                    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_RaidTargetUpdate(HealBot_Unit_Button[huUnit], nil, huUnit) end
                    HealBot_debuffTargetIcon[huUnit]=nil
                    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_RaidTargetUpdate(HealBot_Unit_Button[huUnit], HealBot_TargetIcons[huUnit], huUnit) end
                end
            end
        else
            HealBot_HoT_UpdateIcon(HealBot_Unit_Button[huUnit], huHoTicon[hotID], secLeft, iTexture, hotID, hbGUID)
        end
    else
        HealBot_HoT_UpdateNoIcon(hbGUID, hotID, huUnit, huHoTicon, sID, iTexture, secLeft)
    end
end

function HealBot_HoT_UpdateNoIcon(hbGUID, hotID, huUnit, huHoTicon, sID, iTexture, secLeft)
    if HealBot_DeBuff_Texture["t"..sID] then
        i=15
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then
            if HealBot_TargetIcons[huUnit] then
                HealBot_debuffTargetIcon[huUnit]=HealBot_TargetIcons[huUnit]
                HealBot_RaidTargetUpdate(HealBot_Unit_Button[huUnit], HealBot_TargetIcons[huUnit], huUnit)
            else
                HealBot_debuffTargetIcon[huUnit]=0
            end
        end
    else
        i=1
        for k,z in pairs(huHoTicon) do 
            local _,_, tsID=string.split("!", k)
            if z>0 and not HealBot_DeBuff_Texture["t"..tsID] then 
                i=i+1
            end 
        end  
    end
    if HealBot_DeBuff_Texture["t"..sID] or i<15 then 
        huHoTicon[hotID]=i
        HealBot_HoT_UpdateIcon(HealBot_Unit_Button[huUnit], huHoTicon[hotID], secLeft, iTexture, hotID, hbGUID)
        HealBot_HoT_Active_Button[hbGUID]=HealBot_Unit_Button[huUnit]
    end
end

function HealBot_retdebuffTargetIcon(unit)
    if HealBot_debuffTargetIcon[unit] and HealBot_debuffTargetIcon[unit]>0 then
        return true
    else
        return false
    end
end

local temp_icons={}
function HealBot_HoT_RefreshIcons(hbGUID,button)
    huHoTtime=HealBot_Player_HoT[hbGUID]
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    if not huHoTtime then 
        HealBot_HoT_RemoveIcon(hbGUID)
        HealBot_AddDebug("huHoTtime==nil in HealBot_HoT_RefreshIcons")
    else
        z=0
        for bName,k in pairs(huHoTicon) do
            temp_caster[k],temp_HoT[k], temp_sID[k]=string.split("!", bName)
            if k>0 and not HealBot_DeBuff_Texture["t"..temp_sID[k]] then 
                temp_icons[k]=bName
                z=z+1
            end
        end
        if z>0 then
            for i=1,13 do
                if not temp_icons[i] then
                    if temp_icons[i+1] then
                        HealBot_HoT_UpdateIcon(button, i+1, -1)
                        secLeft=floor(huHoTtime[temp_icons[i+1]]-GetTime())
                        iTexture=HealBot_Icon_Texture(temp_sID[i+1])
                        HealBot_HoT_UpdateIcon(button, i, secLeft, iTexture, temp_icons[i+1], hbGUID)
                        -- HealBot_HoT_Update(hbGUID, temp_icons[i+1])
                        huHoTicon[temp_icons[i+1]]=i
                        temp_icons[i+1]=nil
                    end
                end
                temp_icons[i]=nil
            end
        else
            HealBot_HoT_Active_Button[hbGUID]=nil
        end
    end
end

function HealBot_retHoTdetails(hbGUID)
    return HealBot_Player_HoT_Icons[hbGUID], HealBot_Player_HoT[hbGUID]
end

function HealBot_retHoTcount(hotID,hbGUID)
    if HealBot_HoT_Count[hotID] then
        return HealBot_HoT_Count[hotID][hbGUID]
    end
end

function HealBot_HoT_MoveIcon(oldButton, newButton, hbGUID)
    huHoTtime=HealBot_Player_HoT[hbGUID]
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    if not huHoTicon then 
        -- HealBot_AddDebug("huHoTicon is NIL in HealBot_HoT_MoveIcon")
        return 
    end
    for bName,i in pairs(huHoTicon) do
        if i>0 then
            HealBot_HoT_UpdateIcon(oldButton, huHoTicon[bName], -1)
            if huHoTtime[bName] then
                secLeft=floor(huHoTtime[bName]-GetTime())
            else
                secLeft=99
            end
            _,w, sID=string.split("!", bName)
            iTexture=HealBot_Icon_Texture(sID)
            HealBot_HoT_UpdateIcon(newButton, i, secLeft, iTexture, bName, hbGUID)
        end
    end
    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 and HealBot_debuffTargetIcon[huUnit] and HealBot_debuffTargetIcon[huUnit]>0 then
        HealBot_RaidTargetUpdate(oldButton, nil, huUnit)
        HealBot_RaidTargetUpdate(newButton, HealBot_debuffTargetIcon[huUnit], huUnit)
    end
end

function HealBot_HoT_RemoveIcon(hbGUID)
    z=HealBot_HoT_Active_Button[hbGUID];
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    if not huHoTicon then 
      --  HealBot_AddDebug("huHoTicon is NIL in HealBot_HoT_RemoveIcon")
        return 
    end
    for _,i in pairs(huHoTicon) do
        if i>0 then
            HealBot_HoT_UpdateIcon(z, i, -1)
        end
    end
    HealBot_HoT_Active_Button[hbGUID]=nil;
end

function HealBot_HoT_RemoveIconButton(button,removeAll)
    for i=1,15 do
        HealBot_HoT_UpdateIcon(button, i, -1)
    end
    if HealBot_debuffTargetIcon[button.unit] and HealBot_debuffTargetIcon[button.unit]>0 then
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_RaidTargetUpdate(button, nil, button.unit) end
        HealBot_debuffTargetIcon[button.unit]=nil
    end
    if not removeAll then
        if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Action_SetClassIconTexture(button, button.unit)
        end
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 and HealBot_TargetIcons[button.unit] then
            HealBot_OnEvent_RaidTargetUpdate(nil)
        end
    end
end

local iconTxt=nil
local hbiconcount=nil
local hbiconcount2=nil

function HealBot_HoT_UpdateIcon(button, index, secLeft, Texture, hotID, hbGUID)
    if not button then return; end;
    bar = HealBot_Action_HealthBar(button);
    iconName = _G[bar:GetName().."Icon"..index];
    if not iconName then
        HealBot_AddDebug("iconName is nil index="..index)
        return
    end
    hbiconcount = _G[bar:GetName().."Count"..index];
    hbiconcount2 = _G[bar:GetName().."Count"..index.."a"];
    x=HealBot_HoT_AlphaValue(secLeft)
    if index==15 then
        iconName:SetTexCoord(0,1,0,1);
        if x>0 then x=1 end
    end
    iconName:SetAlpha(x)
    if x==0 then 
        hbiconcount:SetTextColor(1,1,1,0);
        hbiconcount2:SetTextColor(1,1,1,0)
        hbiconcount:SetText(" ");
        hbiconcount2:SetText(" ");
    else
        xGUID, sName, sID=string.split("!", hotID or "H!B!C")
        if (Healbot_Config_Skins.ShowIconTextCountSelfCast==1 and xGUID~=HealBot_PlayerGUID) or Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Current_Skin]==0 then
            iconTxt=nil
        else
            if HealBot_HoT_Count[hotID] and HealBot_HoT_Count[hotID][hbGUID] then
                iconTxt=HealBot_HoT_Count[hotID][hbGUID]
            elseif sName==HEALBOT_POWER_WORD_SHIELD and HealBot_TrackWS[hbGUID] then
                if HealBot_TrackWS[hbGUID]=="-" and HealBot_Globals.ShowWSicon==1 then
                    Texture=HealBot_HoT_Texture["t6788"]  -- HEALBOT_DEBUFF_WEAKENED_SOUL
                    iconTxt=nil
                else
                    iconTxt=HealBot_TrackWS[hbGUID]
                end
            elseif HealBot_DeBuff_Texture["t"..sID] and DeBuff_Count[hbGUID]>0 then
                iconTxt=DeBuff_Count[hbGUID]
            else
                iconTxt=nil
            end
        end
        if Texture then iconName:SetTexture(Texture); end
        if iconTxt then
            hbiconcount2:SetText(iconTxt);
            hbiconcount2:SetTextColor(1,1,1,1);
        else
            hbiconcount2:SetText(" ");
            hbiconcount2:SetTextColor(1,1,1,0);
        end
        if (Healbot_Config_Skins.ShowIconTextDurationSelfCast==1 and xGUID~=HealBot_PlayerGUID) or Healbot_Config_Skins.ShowIconTextDuration[Healbot_Config_Skins.Current_Skin]==0 then
            iconTxt=nil
        else
            iconTxt=secLeft
        end
        hbiconcount:SetText(iconTxt or " ");
        if not iconTxt or (iconTxt<0) or (iconTxt>Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Current_Skin]) then
            hbiconcount:SetTextColor(1,1,1,0);
        elseif iconTxt<=Healbot_Config_Skins.IconTextDurationWarn[Healbot_Config_Skins.Current_Skin] and not HealBot_DeBuff_Texture["t"..sID] then
                -- HEALBOT_REJUVENATION = 774    HEALBOT_REGROWTH = 8936
            if (Texture==HealBot_HoT_Texture["t774"] or Texture==HealBot_HoT_Texture["t8936"]) then
                y, x, _ = GetSpellCooldown(HEALBOT_SWIFTMEND);
                if x and y and (x+y)==0 then
                    hbiconcount:SetTextColor(0,1,0,1);
                else
                    hbiconcount:SetTextColor(1,0,0,1);        
                end
            else
                hbiconcount:SetTextColor(1,0,0,1);           
            end
        else
            hbiconcount:SetTextColor(1,1,1,1);
        end   
    end    
end 

function HealBot_HoT_AlphaValue(secLeft)
    if not UnitIsDeadOrGhost("player") then
        if secLeft>=0 and secLeft<6 then
            return (secLeft/9)+.4
        elseif secLeft<0 then
            return 0
        else
            return 1
        end
    end
    return 0
end

function HealBot_Icon_Texture(spellID)
    local tspellID="t"..spellID
    if HealBot_HoT_Texture[tspellID] then
        return HealBot_HoT_Texture[tspellID]
    elseif HealBot_DeBuff_Texture[tspellID] then
        return HealBot_DeBuff_Texture[tspellID]
    else
        return nil
    end
end

function HealBot_ToggelFocusMonitor(unitName, zone)
    if HealBot_Globals.FocusMonitor[unitName] then
        if UnitName("target") and unitName==UnitName("target") then HealBot_Panel_clickToFocus("hide") end
        HealBot_Globals.FocusMonitor[unitName] = nil
    else
        HealBot_Globals.FocusMonitor[unitName] = zone
        if UnitName("target") and HealBot_Globals.FocusMonitor[UnitName("target")] then HealBot_Panel_clickToFocus("Show") end
    end
end

function HealBot_PlaySound(id)
    if HealBot_Loaded then
        PlaySoundFile(LSM:Fetch('sound',id));
    end
end

function HealBot_InitSpells()
    local iSpell = nil
    z = 0; 
    for x,_ in pairs(HealBot_SmartCast_Spells) do
        HealBot_SmartCast_Spells[x]=nil;
    end
  
    HealBot_Init_Spells_Defaults(HealBot_PlayerClassEN);
  
    for iSpell in pairs(HealBot_Spells) do
        if HealBot_GetSpellId(iSpell) then
            HealBot_InitClearSpellNils(iSpell)
            HealBot_InitGetSpellData(iSpell);
            z = z + 1;
        end
    end

    if HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PRIEST] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_GREATER_HEAL))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_GREATER_HEAL]="L"
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HEAL))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_HEAL]="S"
        else
            sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_FLASH_HEAL))
            if sName then
                HealBot_SmartCast_Spells[HEALBOT_FLASH_HEAL]="S"
            end
        end
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_DRUID] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HEALING_TOUCH))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_TOUCH]="L"
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_REJUVENATION))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_REJUVENATION]="S"
        end
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PALADIN] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_DIVINE_LIGHT))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_DIVINE_LIGHT]="L"
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HOLY_LIGHT))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_HOLY_LIGHT]="S"
        else
            sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_FLASH_OF_LIGHT))
            if sName then
                HealBot_SmartCast_Spells[HEALBOT_FLASH_OF_LIGHT]="S"
            end
        end
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_SHAMAN] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_GREATER_HEALING_WAVE))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_GREATER_HEALING_WAVE]="L"
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HEALING_WAVE))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_WAVE]="S"
        end
    elseif HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_MONK] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_ENVELOPING_MIST))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_ENVELOPING_MIST]="L"
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_SOOTHING_MIST))
        if sName then
            HealBot_SmartCast_Spells[HEALBOT_SOOTHING_MIST]="S"
        end
    end
    HealBot_Action_SetrSpell()
    HealBot_AddDebug("Initiated HealBot with ".. z .." Spells");
    HealBot_Options_CheckCombos();
    HealBot_Init_SmartCast();
end

function HealBot_InitNewChar(PlayerClassEN)
    if HealBot_Config.EnabledKeyCombo then
        HealBot_Config.DisabledKeyCombo=HealBot_Config.EnabledKeyCombo
    else
        HealBot_DoReset_Spells(PlayerClassEN)
        HealBot_DoReset_Cures(PlayerClassEN)
        HealBot_DoReset_Buffs(PlayerClassEN)
        HealBot_Config.HealBotBuffColR = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1}
        HealBot_Config.HealBotBuffColG = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1}
        HealBot_Config.HealBotBuffColB = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1}
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
        HealBot_Action_setPoint()
        HealBot_Action_unlockFrame()
    end
end

function HealBot_ToggleOptions()
    HealBot_TogglePanel(HealBot_Options)
    HealBot_TogglePanel(HealBot_Options0)
end

function HealBot_HasTalent(tab,icon,talentName)
    s,_,_,_,z,_ = GetTalentInfo(tab,icon);
    if s then
        if s~=talentName then
            HealBot_AddDebug("ERROR: in function HealBot_HasTalent");
            HealBot_AddDebug("found talent "..s.." when expecting "..talentName);
            z=0
        end
    else
        z=0
    end
    return z
end

function HealBot_MMButton_UpdatePosition()
    HealBot_MMButton:SetPoint(
        "TOPLEFT",
        "Minimap",
        "TOPLEFT",
        54 - (HealBot_Globals.HealBot_ButtonRadius * cos(HealBot_Globals.HealBot_ButtonPosition)),
        (HealBot_Globals.HealBot_ButtonRadius * sin(HealBot_Globals.HealBot_ButtonPosition)) - 55
    );
end

function HealBot_MMButton_Init()
    if HealBot_Globals.ButtonShown==1 then
        HealBot_MMButton:Show();
        HealBot_MMButton_UpdatePosition()
    else
        HealBot_MMButton:Hide();
    end
end

function HealBot_MMButton_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT");
    GameTooltip:SetText(HEALBOT_BUTTON_TOOLTIP);
    GameTooltipTextLeft1:SetTextColor(1, 1, 1);
    GameTooltip:Show();
end

function HealBot_MMButton_OnClick(self,button)
    HealBot_ToggleOptions()
end

function HealBot_MMButton_BeingDragged()
    w,x = GetCursorPosition() 
    y,z = Minimap:GetLeft(), Minimap:GetBottom() 
    w = y-w/UIParent:GetScale()+70 
    x = x/UIParent:GetScale()-z-70 
    HealBot_MMButton_SetPosition(math.deg(math.atan2(x,w)));
end

function HealBot_MMButton_SetPosition(c)
    if(c < 0) then
        c = c + 360;
    end

    HealBot_Globals.HealBot_ButtonPosition = c;
    HealBot_MMButton_UpdatePosition();
end

local valUnit, valGUID = nil, nil
function HealBot_validUnit(unit, hGUID)
    valGUID=hGUID or HealBot_UnitGUID(unit)
    if not valGUID or not HealBot_UnitID[valGUID] then
        valGUID=nil
        valUnit=nil
    else
        valUnit=HealBot_IDs(unit,valGUID)
        if not HealBot_Unit_Button[valUnit] then
            if UnitName("target")==UnitName(valUnit) then
                valUnit="target"
                valGUID=HealBot_UnitGUID(valUnit)
                if not valGUID or not HealBot_UnitID[valGUID] then 
                    valGUID=nil
                    valUnit=nil
                end
            else
                return;
            end
        end
    end
    return valUnit, valGUID
end

local sSwitch=UnitLevel("player")*50
function HealBot_SmartCast(hbGUID,hlthDelta)
    s=nil;
    for sName,sType in pairs(HealBot_SmartCast_Spells) do
        if (HealBot_Spells[sName]) then
            if sType=="L" then
                if hlthDelta>sSwitch then s=sName end
            elseif not s then
                s=sName
            end
        end
    end
    return s;
end

function HealBot_UnitInRange(spellName, unit) -- added by Diacono of Ursin
    local uRange=0
    if UnitGUID(unit)==HealBot_PlayerGUID then
        uRange = 1
    elseif (spellName or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then
        if UnitInRange(unit) == 1 then
            uRange = 1
        else
            uRange = CheckInteractDistance(unit,1) or 0
        end
    elseif IsSpellInRange(spellName, unit) ~= nil then
        uRange = IsSpellInRange(spellName, unit)
    elseif IsItemInRange(spellName, unit) ~= nil then
        uRange = IsItemInRange(spellName, unit)
    elseif UnitInRange(unit) == 1 then
        uRange = 1
    else
        uRange = CheckInteractDistance(unit,1) or 0
    end
    if uRange==0 and not UnitIsVisible(unit) then 
        uRange=-1 
    end
    return uRange
end

function HealBot_Range_Check(srcUnit, trgUnit, range) 
    local inRange, hbDist = 0,0
    local tx, ty, sx, sy, px, py = 0,0,0,0,0,0
    local hbresetScale=0
    if (UnitIsVisible(trgUnit) == 1) and (UnitIsVisible(srcUnit) == 1) then
        tx, ty = GetPlayerMapPosition(trgUnit)
        sx, sy = GetPlayerMapPosition(srcUnit)
        
        if not range then range=40; end

        if calibrateHBScale then
            px, py = GetPlayerMapPosition("player")
            if (CheckInteractDistance(trgUnit, 4)) then
                hbDist = sqrt((px - tx)^2 + (py - ty)^2)
                hbresetScale=1
                if hbDist > hbScale and (px > 0 or py > 0) then
                    HealBot_Range_newScale(hbDist)
                    hbresetScale=9
                end
            end
            if (CheckInteractDistance(srcUnit, 4)) then
                hbDist = sqrt((px - sx)^2 + (py - sy)^2)
                if hbresetScale<1 then hbresetScale=1 end
                if hbDist > hbScale and (px > 0 or py > 0) then
                    HealBot_Range_newScale(hbDist)
                    hbresetScale=9
                end
            end
            if hbresetScale==1 then HealBot_Range_ticScale() end
        end

        if (tx > 0 or ty > 0) and (sx > 0 or sy > 0) then
            hbDist = sqrt((sx - tx)^2 + (sy - ty)^2)
            if hbDist <=(hbScale*range/27) then inRange=1 end
        end
    end
    return inRange;
end

function HealBot_Range_softCalibrateScale(srcUnit, trgUnit)
    local hbDist = 0
    local tx, ty, sx, sy, px, py = 0,0,0,0,0,0
    local hbresetScale=0
    px, py = GetPlayerMapPosition("player")
    if CheckInteractDistance(trgUnit, 4) then
        tx, ty = GetPlayerMapPosition(trgUnit)
        hbDist = sqrt((px - tx)^2 + (py - ty)^2)
        hbresetScale=1
        if hbDist > hbScale and (px > 0 or py > 0) then 
            HealBot_Range_newScale(hbDist)
            hbresetScale=9
        end
    end
    if CheckInteractDistance(srcUnit, 4) then
        sx, sy = GetPlayerMapPosition(srcUnit)
        hbDist = sqrt((px - sx)^2 + (py - sy)^2)
        if hbresetScale<1 then hbresetScale=1 end
        if hbDist > hbScale and (px > 0 or py > 0) then 
            HealBot_Range_newScale(hbDist)
            hbresetScale=9
        end
    end
    if hbresetScale==1 then HealBot_Globals.scaleCaliStats["SoftCount"]=HealBot_Globals.scaleCaliStats["SoftCount"]+1 end
end

function HealBot_Range_newScale(sDist)
    hbScale = sDist
    HealBot_Globals.mapScale[hbInsName]=hbScale
    HealBot_Globals.scaleCaliStats["Count"]=HealBot_Globals.scaleCaliStats["Count"]+calibrateHBScale
    HealBot_Globals.scaleCaliStats["Resets"]=HealBot_Globals.scaleCaliStats["Resets"]+1
    calibrateHBScale=0
end

function HealBot_Range_ticScale()
    calibrateHBScale=calibrateHBScale+1
    if calibrateHBScale>(500*HealBot_Globals.rangeCalibrationWeight) then calibrateHBScale=nil end
end

function HealBot_Range_calibrateStats()
    local cPct=floor(calibrateHBScale/(500*HealBot_Globals.rangeCalibrationWeight))
    return HealBot_Globals.scaleCaliStats["SoftCount"], HealBot_Globals.scaleCaliStats["Count"]+calibrateHBScale, HealBot_Globals.scaleCaliStats["Resets"], cPct;
end

function HealBot_ClearLocalArr(hbGUID, getTime)
    if (HealBot_UnitTime[hbGUID] or 0)<getTime then
        if HealBot_PlayerBuff[hbGUID] then HealBot_PlayerBuff[hbGUID]=nil end
        if HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]=nil end
        if HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]=nil end
        if HealBot_UnitRole[hbGUID] then HealBot_UnitRole[hbGUID]=nil end
		if HealBot_UnitAbsorbs[hbGUID] then HealBot_UnitAbsorbs[hbGUID]=nil end
        if DeBuff_Count[hbGUID] then DeBuff_Count[hbGUID]=nil end
        if HealBot_HealsAbsorb[hbGUID] then HealBot_HealsAbsorb[hbGUID]=nil end
        if HealBot_unitHealth[hbGUID] then
            HealBot_unitHealth[hbGUID]=nil
            HealBot_unitHealthMax[hbGUID]=nil
        end
        for k in pairs(HealBot_MainTanks) do
            if ( HealBot_MainTanks[k] == hbGUID ) then
                HealBot_MainTanks[k] = nil;
            end
        end
        for k in pairs(HealBot_CTRATanks) do
            if ( HealBot_CTRATanks[k] == hbGUID ) then
                HealBot_CTRATanks[k] = nil;
            end
        end
        for k in pairs(HealBot_MainAssists) do
            if ( HealBot_MainAssists[k] == hbGUID ) then
                HealBot_MainAssists[k] = nil;
            end
        end
        for k in pairs(HealBot_CustomDebuff_RevDurLast) do
            if HealBot_CustomDebuff_RevDurLast[k][hbGUID] then
                HealBot_CustomDebuff_RevDurLast[k][hbGUID] = nil;
            end
        end
        if HealBot_DelayBuffCheck[hbGUID] then HealBot_DelayBuffCheck[hbGUID]=nil end
        HealBot_ClearAllDebuffs(hbGUID)
        HealBot_UnitBuff[hbGUID]=nil
        HealBot_UnitDebuff[hbGUID]=nil
        for k in pairs(HealBot_PetGUID) do
            if ( HealBot_PetGUID[k] == hbGUID ) then
                HealBot_PetGUID[k] = nil;
            end
        end
        if HealBot_CheckBuffsTimehbGUID==hbGUID then HealBot_ResetCheckBuffsTime() end
        if HealBot_PetGUID[hbGUID] then HealBot_PetGUID[hbGUID]=nil end
        if hbManaPlayers[hbGUID] then hbManaPlayers[hbGUID]=nil end
        HealBot_UnitTime[hbGUID]=nil
        if HealBot_useTips then HealBot_talentSpam(hbGUID,"remove",nil) end
        HealBot_Action_ClearLocalArr(hbGUID)
        HealBot_IncHeals_ClearLocalArr(hbGUID)
    end
end

function HealBot_immediateClearLocalArr(hbGUID)
    HealBot_ClearUnitAggro(HealBot_UnitID[hbGUID], hbGUID)
    HealBot_UnitName[hbGUID]=nil
    HealBot_UnitSpec[hbGUID]=nil
    HealBot_UnitID[hbGUID]=nil
end

function HealBot_setClearLocalArr(hbGUID)
    HealBot_cleanGUIDs[hbGUID]=GetTime()
end

function HealBot_Update_Skins()

    if HealBot_Config.Skin_Version then
        Healbot_Config_Skins.Skin_Version=1
        HealBot_Config.Skin_Version=nil
    end
  
    if HealBot_Config.Current_Skin then
        HealBot_Config.Current_Skin = nil
    end
	
	if not HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en] then
		HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en] = { R = 0.45, G = 0, B = 0.26, }
    end

    if not HealBot_Config.SkinDefault then HealBot_Config.SkinDefault={} end
    
    local _,class=UnitClass("player")
    class=strsub(class,1,4)

    if HealBot_Config.LastVersionSkinUpdate~=HEALBOT_VERSION then
        local hbClassHoTwatchDef=HealBot_GlobalsDefaults.WatchHoT
        for class,x  in pairs(hbClassHoTwatchDef) do
            if not HealBot_Globals.WatchHoT[class] then
                HealBot_Globals.WatchHoT[class]={} 
            end
            local hbClassHoTwatchDefClass=HealBot_Globals.WatchHoT[class]
            for sName,x  in pairs(hbClassHoTwatchDefClass) do
                if HealBot_Globals.WatchHoT[class][sName] and HealBot_Globals.WatchHoT[class][sName]==1 then
                    HealBot_Globals.WatchHoT[class][sName]=nil
                end
            end
        end
		HealBot_Globals.OneTimeMsg={}
        HealBot_Config.hbMountsReported={}
        
        if HealBot_Globals.RangeCheckFreq and HealBot_Globals.RangeCheckFreq>0.4 then
            HealBot_Globals.RangeCheckFreq=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/2, 1)
        end
        
        for x in pairs (Healbot_Config_Skins.Skins) do
            if not Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Skin_Version = 1 end
            if not Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Skins[x]] = 3 end
            if not Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Font end
            if not Healbot_Config_Skins.headtextfont[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtextfont[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Font end
            if not Healbot_Config_Skins.btextoutline[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextoutline[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.headtextoutline[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtextoutline[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.headtextheight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtextheight[Healbot_Config_Skins.Skins[x]] = 10 end
            if not Healbot_Config_Skins.numcols[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.numcols[Healbot_Config_Skins.Skins[x]] = 2 end
            if not Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Textures[8].name end
            if Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]] == "Empty" then Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]]="Smooth" end
            if not Healbot_Config_Skins.bcspace[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bcspace[Healbot_Config_Skins.Skins[x]] = 4 end
            if not Healbot_Config_Skins.brspace[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.brspace[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Skins[x]] = 144 end
            if not Healbot_Config_Skins.bheight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bheight[Healbot_Config_Skins.Skins[x]] = 22 end
            if not Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextdisbledcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcolr[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextdisbledcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcolg[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextdisbledcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcolb[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextcursecolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecolr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextcursecolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextcursecolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextcursecola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecola[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.backcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcola[Healbot_Config_Skins.Skins[x]] = 0.02 end
            if not Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Skins[x]] = 0.9 end
            if not Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Skins[x]] = 0.45 end
            if not Healbot_Config_Skins.backcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcolr[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.backcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcolg[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.backcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcolb[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.barbackcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barbackcolr[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.barbackcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barbackcolg[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.barbackcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barbackcolb[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.barbackcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barbackcola[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.barabsorbcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barabsorbcola[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.HlthBackColour[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HlthBackColour[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.borcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcolr[Healbot_Config_Skins.Skins[x]] = 0.4    end  
            if not Healbot_Config_Skins.borcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcolg[Healbot_Config_Skins.Skins[x]] = 0.4    end 
            if not Healbot_Config_Skins.borcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcolb[Healbot_Config_Skins.Skins[x]] = 0.4    end
            if not Healbot_Config_Skins.borcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcola[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Skins[x]] = 10 end
            if not Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Skins[x]] = 0.28 end
            if not Healbot_Config_Skins.bareora[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bareora[Healbot_Config_Skins.Skins[x]] = 0.45 end
            if not Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowHeader[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowHeader[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.headbarcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcolr[Healbot_Config_Skins.Skins[x]] = 0.1 end
            if not Healbot_Config_Skins.headbarcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcolg[Healbot_Config_Skins.Skins[x]] = 0.1 end
            if not Healbot_Config_Skins.headbarcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcolb[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.headbarcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcola[Healbot_Config_Skins.Skins[x]] = 0.25 end
            if not Healbot_Config_Skins.headtxtcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcolr[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.headtxtcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcolg[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.headtxtcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcolb[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.headtxtcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcola[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.headtexture[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtexture[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Textures[6].name end
            if not Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Skins[x]] = 0.72 end
            if not Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroText[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowAggroInd[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroInd[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.LowManaInd[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.LowManaIndIC[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.LowManaIndIC[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroIndAlertLevel[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroIndAlertLevel[Healbot_Config_Skins.Skins[x]] = 2 end
            if not Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Skins[x]] = 5 end
            if not Healbot_Config_Skins.ShowHoTicons[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowHoTicons[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Skins[x]] = 0  end
            if not Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Skins[x]] = 2  end
            if not Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Skins[x]] = 3  end
            if not Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.ShowDebuffIcon[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowDebuffIcon[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowIconTextCountSelfCast[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextCountSelfCast[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowIconTextDuration[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextDuration[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowIconTextDurationSelfCast[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextDurationSelfCast[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.IconTextScale[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconTextScale[Healbot_Config_Skins.Skins[x]] = 0.55 end
            if not Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Skins[x]] = 2 end
            if not Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ihbarcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ihbarcolr[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.ihbarcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ihbarcolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ihbarcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ihbarcolb[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.asbarcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.asbarcolr[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.asbarcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.asbarcolg[Healbot_Config_Skins.Skins[x]] = 0.1 end
            if not Healbot_Config_Skins.asbarcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.asbarcolb[Healbot_Config_Skins.Skins[x]] = 0.9 end
            if not Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowRole[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRole[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.highcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.highcolr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.highcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.highcolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.highcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.highcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.targetcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.targetcolr[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.targetcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.targetcolg[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.targetcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.targetcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]] == 3 then Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]] = 1 end
            if Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]] == 4 then Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]] = 2 end
            if not Healbot_Config_Skins.AggroColr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroColr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroColg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroColg[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroColb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroColb[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroBarsMaxAlpha[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarsMaxAlpha[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroBarsMinAlpha[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarsMinAlpha[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.AggroBarsFreq[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarsFreq[Healbot_Config_Skins.Skins[x]] = 0.03 end
            if not Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Skins[x]] = 9 end
            if not Healbot_Config_Skins.IconTextDurationWarn[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconTextDurationWarn[Healbot_Config_Skins.Skins[x]] = 3 end
            if not Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Skins[x]] = GetScreenHeight()/2 end
            if not Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Skins[x]] = GetScreenWidth()/2 end
            if not HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] then HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]]=2 end
            if not Healbot_Config_Skins.headhight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headhight[Healbot_Config_Skins.Skins[x]]=0.75 end
            if not Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.SelfHeals or 0 end
            if not Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.PetHeals or 0 end
            if not Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.GroupHeals or 1 end
            if not Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TankHeals or 1 end
            if not Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Skins[x]]=HealBot_Config.SelfPet or 0 end
            if not Healbot_Config_Skins.MainAssistHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.MainAssistHeals[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.EmergencyHeals or 1 end
            if not Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Skins[x]]=HealBot_Config.SetFocusBar or 1 end
            if not Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.VehicleHeals or 1 end
            if not Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ShowMyTargetsList or 1 end
            if not Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetHeals or 1 end
            if not Healbot_Config_Skins.TargetIncSelf[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncSelf[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncSelf or 0 end
            if not Healbot_Config_Skins.TargetIncGroup[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncGroup[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncGroup or 0 end
            if not Healbot_Config_Skins.TargetIncRaid[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncRaid[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncRaid or 1 end
            if not Healbot_Config_Skins.TargetIncPet[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncPet[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncPet or 0 end
            if not Healbot_Config_Skins.TargetBarAlwaysShow[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetBarAlwaysShow[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.FocusBarAlwaysShow[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.FocusBarAlwaysShow[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.GroupPetsBy5[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.GroupPetsBy5[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Skins[x]]=HealBot_Config.AlertLevel or 82 end
            if not Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Skins[x]]=HealBot_Config.HidePartyFrames or 0 end
            if not Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Skins[x]]=HealBot_Config.HidePlayerTarget or 0 end
            if not Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Skins[x]]=HealBot_Config.CastNotify or 1 end
            if not Healbot_Config_Skins.NotifyChan[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.NotifyChan[Healbot_Config_Skins.Skins[x]]=HealBot_Config.NotifyChan or "" end
            if not Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Skins[x]]=HealBot_Config.NotifyOtherMsg or HEALBOT_NOTIFYOTHERMSG end
            if not Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Skins[x]]=HealBot_Config.CastNotifyResOnly or 1 end
            if not Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Skins[x]]=HealBot_Config.EmergIncMonitor or 1 end
            if not Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ExtraOrder or 3 end
            if not Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]=HealBot_Config.Panel_Anchor or 1 end
            if not Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]] then 
                if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==1 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==2 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==3 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=3
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==4 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=3
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==5 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==6 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==7 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=3
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==8 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                end
            end
            if not Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Skins[x]] then 
                Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Skins[x]]={[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
            end
            if not Healbot_Config_Skins.GroupsPerCol[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.GroupsPerCol[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ActionLocked or 0 end
            if not Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Skins[x]]=HealBot_Config.AutoClose or 0 end
            if not Healbot_Config_Skins.PanelSounds[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PanelSounds[Healbot_Config_Skins.Skins[x]]=HealBot_Config.PanelSounds or 0 end
            if not Healbot_Config_Skins.SubSortIncGroup[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncGroup[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncPet[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncPet[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncVehicle[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncVehicle[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncTanks[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncTanks[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncMyTargets[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncMyTargets[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.ShowRaidIconStar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconStar[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconCircle[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconCircle[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconDiamond[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconDiamond[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconTriangle[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconTriangle[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconMoon[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconMoon[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconSquare[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconSquare[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconCross[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconCross[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CombatProtRaid[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CombatProtRaid[Healbot_Config_Skins.Skins[x]]=0 end
			if not Healbot_Config_Skins.PowerCounter[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PowerCounter[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.HlthBarColour[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HlthBarColour[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Skins[x]] = 4 end
            if not Healbot_Config_Skins.AbsorbBarColour[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AbsorbBarColour[Healbot_Config_Skins.Skins[x]] = 3 end
            if not Healbot_Config_Skins.HideBars[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HideBars[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HideIncTank[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HideIncTank[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HideIncGroup[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HideIncGroup[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.HideIncFocus[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HideIncFocus[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HideIncMyTargets[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HideIncMyTargets[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TooltipPos[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TooltipPos or 5 end
            if not Healbot_Config_Skins.FrameScale[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.FrameScale[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.Author[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Author[Healbot_Config_Skins.Skins[x]] = HEALBOT_WORDS_UNKNOWN end
            if Healbot_Config_Skins.AbsorbBarColour[Healbot_Config_Skins.Skins[x]]>3 then Healbot_Config_Skins.AbsorbBarColour[Healbot_Config_Skins.Skins[x]] = 2 end
        end
        HealBot_Config.LastVersionSkinUpdate=HEALBOT_VERSION
    end
    for x in pairs (Healbot_Config_Skins.Skins) do
        if HealBot_Config_SkinsDefaults.Author[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Author[Healbot_Config_Skins.Skins[x]] = HealBot_Config_SkinsDefaults.Author[Healbot_Config_Skins.Skins[x]] end
    end    
    
    HealBot_BarAbsorbCustomColourb:Hide();
    HealBot_BarAbsorbCustomColour:Hide();
    
    if HealBot_Config.CurrentSpec==9 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end

    for dName, _ in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if not tonumber(HealBot_Globals.HealBot_Custom_Debuffs[dName]) then
            HealBot_Globals.HealBot_Custom_Debuffs[dName]=10
        end
    end
    
    for dName,x in pairs(HealBot_Globals.Custom_Debuff_Categories) do
        if x>14 then
            HealBot_Globals.Custom_Debuff_Categories[dName]=HealBot_Globals.Custom_Debuff_Categories[dName]-6 
        end
    end
    
end

function HealBot_Update_SpellCombos()
    local combo=nil
    local button=nil

    for x=1,2 do
        if x==1 then
            combo = HealBot_Config.EnabledKeyCombo;
        else
            combo = HealBot_Config.DisabledKeyCombo;
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            for z=1,4 do
                if combo then
                    combo[button..z] = combo[button]
                    combo["Shift"..button..z] = combo["Shift"..button]
                    combo["Ctrl"..button..z] = combo["Ctrl"..button]
                    combo["Alt"..button..z] = combo["Alt"..button]
                    combo["Ctrl-Shift"..button..z] = combo["Ctrl-Shift"..button]
                    combo["Alt-Shift"..button..z] = combo["Alt-Shift"..button]
                end
            end
        end
    end
end

function HealBot_Copy_SpellCombos()
    local combo=nil
    local button=nil

    for x=1,2 do
        if x==1 then
            combo = HealBot_Config.EnabledKeyCombo;
        else
            combo = HealBot_Config.DisabledKeyCombo;
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            if combo then
                combo[button] = combo[button..HealBot_Config.CurrentSpec]
                combo["Shift"..button] = combo["Shift"..button..HealBot_Config.CurrentSpec]
                combo["Ctrl"..button] = combo["Ctrl"..button..HealBot_Config.CurrentSpec]
                combo["Alt"..button] = combo["Alt"..button..HealBot_Config.CurrentSpec]
                combo["Ctrl-Shift"..button] = combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec]
                combo["Alt-Shift"..button] = combo["Alt-Shift"..button..HealBot_Config.CurrentSpec]
            end
        end
    end
    HealBot_Update_SpellCombos()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLCOPY)
end

function HealBot_Reset_Spells()
    HealBot_DoReset_Spells(HealBot_PlayerClassEN)
    HealBot_Globals.SmartCast=HealBot_GlobalsDefaults.SmartCast
    HealBot_Globals.SmartCastDebuff=HealBot_GlobalsDefaults.SmartCastDebuff
    HealBot_Globals.SmartCastBuff=HealBot_GlobalsDefaults.SmartCastBuff
    HealBot_Globals.SmartCastHeal=HealBot_GlobalsDefaults.SmartCastHeal
    HealBot_Globals.SmartCastRes=HealBot_GlobalsDefaults.SmartCastRes
    HealBot_Config.EnableHealthy=HealBot_ConfigDefaults.EnableHealthy
    HealBot_Update_SpellCombos()
    HealBot_Options_ResetDoInittab(2)
    HealBot_Options_Init(2)
    HealBot_Options_ComboClass_Text()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLRESET)
end

function HealBot_Reset_Buffs()
    HealBot_DoReset_Buffs(HealBot_PlayerClassEN)
    HealBot_Config.BuffWatch=HealBot_ConfigDefaults.BuffWatch
    HealBot_Config.BuffWatchInCombat=HealBot_ConfigDefaults.BuffWatchInCombat
    HealBot_Config.ShortBuffTimer=HealBot_ConfigDefaults.ShortBuffTimer
    HealBot_Config.LongBuffTimer=HealBot_ConfigDefaults.LongBuffTimer
    HealBot_Update_BuffsForSpec("Buff")
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_Init(5)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMBUFFSRESET)
end

function HealBot_Reset_Cures()
    HealBot_DoReset_Cures(HealBot_PlayerClassEN)
    HealBot_Config.SoundDebuffWarning=HealBot_ConfigDefaults.SoundDebuffWarning
    HealBot_Config.DebuffWatch=HealBot_ConfigDefaults.DebuffWatch
    HealBot_Config.IgnoreClassDebuffs=HealBot_ConfigDefaults.IgnoreClassDebuffs
    HealBot_Config.IgnoreNonHarmfulDebuffs=HealBot_ConfigDefaults.IgnoreNonHarmfulDebuffs
    HealBot_Config.IgnoreFastDurDebuffs=HealBot_ConfigDefaults.IgnoreFastDurDebuffs
    HealBot_Config.IgnoreFastDurDebuffsSecs=HealBot_ConfigDefaults.IgnoreFastDurDebuffsSecs
    HealBot_Config.IgnoreOnCooldownDebuffs=HealBot_ConfigDefaults.IgnoreOnCooldownDebuffs
    HealBot_Config.IgnoreMovementDebuffs=HealBot_ConfigDefaults.IgnoreMovementDebuffs
    HealBot_Config.SoundDebuffPlay=HealBot_ConfigDefaults.SoundDebuffPlay
    HealBot_Config.DebuffWatchInCombat=HealBot_ConfigDefaults.DebuffWatchInCombat
    HealBot_Config.ShowDebuffWarning=HealBot_ConfigDefaults.ShowDebuffWarning
    HealBot_Config.CDCshownHB=HealBot_ConfigDefaults.CDCshownHB
    HealBot_Config.CDCshownAB=HealBot_ConfigDefaults.CDCshownAB
    HealBot_Update_BuffsForSpec("Debuff")
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_Init(4)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCURESRESET)
end

function HealBot_DoReset_Buffs(PlayerClassEN)
    HealBot_Config.HealBotBuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    HealBot_Config.HealBotBuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    if strsub(PlayerClassEN,1,4)=="DRUI" then
        if HealBot_GetSpellId(HEALBOT_MARK_OF_THE_WILD) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_MARK_OF_THE_WILD,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                              [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="MONK" then
        if HealBot_GetSpellId(HEALBOT_LEGACY_WHITETIGER) and HealBot_Config.CurrentSpec==3 then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_LEGACY_EMPEROR,[2]=HEALBOT_LEGACY_WHITETIGER,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        elseif HealBot_GetSpellId(HEALBOT_LEGACY_EMPEROR) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_LEGACY_EMPEROR,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="PALA" then
        if HealBot_GetSpellId(HEALBOT_DEVOTION_AURA) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_DEVOTION_AURA,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        end
        HealBot_Config.HealBotBuffDropDown = {[1]=4,[2]=2,[3]=2,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    elseif strsub(PlayerClassEN,1,4)=="PRIE" then
        if HealBot_GetSpellId(HEALBOT_SHADOW_PROTECTION) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_POWER_WORD_FORTITUDE,[2]=HEALBOT_INNER_FIRE,[3]=HEALBOT_SHADOW_PROTECTION,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        elseif HealBot_GetSpellId(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_POWER_WORD_FORTITUDE,[2]=HEALBOT_INNER_FIRE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        end
        HealBot_Config.HealBotBuffDropDown = {[1]=4,[2]=2,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    elseif strsub(PlayerClassEN,1,4)=="SHAM" then
        if HealBot_GetSpellId(HEALBOT_WATER_SHIELD) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_WATER_SHIELD,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        end
        HealBot_Config.HealBotBuffDropDown = {[1]=2,[2]=2,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    elseif strsub(PlayerClassEN,1,4)=="MAGE" then
        if HealBot_GetSpellId(HEALBOT_ARCANE_BRILLIANCE) then
            HealBot_Config.HealBotBuffText = {[1]=HEALBOT_ARCANE_BRILLIANCE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                              [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
        end
    end
end


function HealBot_DoReset_Cures(PlayerClassEN)
    HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    HealBot_Config.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4}
    if strsub(PlayerClassEN,1,4)=="DRUI" then
        if HealBot_GetSpellId(HEALBOT_NATURES_CURE) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_GetSpellId(HEALBOT_REMOVE_CORRUPTION) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="MONK" then
        if HealBot_GetSpellId(HEALBOT_DETOX) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_DETOX,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="PALA" then
        if HealBot_GetSpellId(HEALBOT_CLEANSE) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_CLEANSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="PRIE" then
        if HealBot_GetSpellId(HEALBOT_PURIFY) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="SHAM" then
        if HealBot_GetSpellId(HEALBOT_PURIFY_SPIRIT) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_PURIFY_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_GetSpellId(HEALBOT_CLEANSE_SPIRIT) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif strsub(PlayerClassEN,1,4)=="MAGE" then
        if HealBot_GetSpellId(HEALBOT_REMOVE_CURSE) then
            HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
end

function HealBot_DoReset_Spells(PlayerClassEN)
    HealBot_Config.EnabledKeyCombo = {}
    HealBot_Config.DisabledKeyCombo = {}
    local bandage=HealBot_GetBandageType()
    if strsub(PlayerClassEN,1,4)=="DRUI" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_REGROWTH,
          ["CtrlLeft"] =  HEALBOT_REMOVE_CORRUPTION,
          ["Right"] = HEALBOT_HEALING_TOUCH,
          ["CtrlRight"] =  HEALBOT_NATURES_CURE,
          ["Middle"] = HEALBOT_REJUVENATION,
          ["ShiftMiddle"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = HEALBOT_MARK_OF_THE_WILD,
          ["Right"] = HEALBOT_ASSIST,
          ["Middle"] = HEALBOT_REJUVENATION,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="MONK" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_SOOTHING_MIST,
          ["ShiftLeft"] = HEALBOT_SURGING_MIST,
          ["ShiftRight"] = HEALBOT_REVIVAL,
          ["CtrlLeft"] =  HEALBOT_DETOX,
          ["Right"] = HEALBOT_ENVELOPING_MIST,
          ["Middle"] =  HEALBOT_RENEWING_MIST,
          ["ShiftMiddle"] = HEALBOT_UPLIFT,
          ["CtrlMiddle"] = HEALBOT_LIFE_COCOON,
          ["AltMiddle"] = HEALBOT_ZEN_MEDITATION,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Middle"] =  HEALBOT_RENEWING_MIST,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="PALA" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_FLASH_OF_LIGHT,
          ["ShiftLeft"] = HEALBOT_DIVINE_LIGHT,
          ["ShiftRight"] = HEALBOT_LIGHT_OF_DAWN,
          ["CtrlLeft"] =  HEALBOT_CLEANSE,
          ["Right"] = HEALBOT_HOLY_LIGHT,
          ["Middle"] =  HEALBOT_WORD_OF_GLORY,
          ["ShiftMiddle"] = HEALBOT_HOLY_RADIANCE,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Middle"] =  HEALBOT_HAND_OF_SALVATION,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="PRIE" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_HEAL,
          ["ShiftLeft"] = HEALBOT_BINDING_HEAL,
          ["CtrlLeft"] = HEALBOT_PURIFY,
          ["Right"] = HEALBOT_GREATER_HEAL,
          ["ShiftRight"] = HEALBOT_POWER_WORD_SHIELD,
          ["CtrlRight"] = HEALBOT_PURIFY,
          ["Middle"] = HEALBOT_RENEW,
          ["ShiftMiddle"] = HEALBOT_PRAYER_OF_MENDING,
          ["AltMiddle"] = HEALBOT_PRAYER_OF_HEALING,
          ["CtrlMiddle"] = HEALBOT_DIVINE_HYMN,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_FLASH_HEAL,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Right"] = HEALBOT_ASSIST,
          ["AltLeft"] = HEALBOT_RESURRECTION,
          ["ShiftRight"] = HEALBOT_POWER_WORD_SHIELD,
          ["Middle"] = HEALBOT_RENEW,
          ["Ctrl-ShiftLeft"] = HEALBOT_FLASH_HEAL,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="SHAM" then
        if HealBot_Config.CurrentSpec==3 then
            x=HEALBOT_PURIFY_SPIRIT;
        else
            x=HEALBOT_CLEANSE_SPIRIT;
        end
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_HEALING_WAVE,
          ["CtrlLeft"] =  x,
          ["Right"] = HEALBOT_GREATER_HEALING_WAVE,
          ["CtrlRight"] = x,
          ["ShiftLeft"] = HEALBOT_CHAIN_HEAL,
		  ["Middle"] = HEALBOT_HEALING_RAIN,
          ["ShiftMiddle"] = HEALBOT_HEALING_SURGE,
          ["AltLeft"] = HEALBOT_HEALING_STREAM_TOTEM,
          ["AltRight"] = HEALBOT_MANA_STREAM_TOTEM,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="MAGE" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_REMOVE_CURSE,
          ["ShiftLeft"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = bandage,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    else
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = bandage,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    end
end


function HealBot_Update_BuffsForSpec(buffType)
    if buffType then
        if buffType=="Debuff" then
            for x=1,3 do
                HealBot_Update_BuffsForSpecDD(x,"Debuff")
            end
        else
            for x=1,10 do
                HealBot_Update_BuffsForSpecDD(x,"Buff")
            end
        end
    else
        for x=1,3 do
            HealBot_Update_BuffsForSpecDD(x,"Debuff")
        end
        for x=1,10 do
            HealBot_Update_BuffsForSpecDD(x,"Buff")
        end
    end
end

function HealBot_Update_BuffsForSpecDD(ddId,bType)
    if bType=="Debuff" then
        for z=1,4 do
            if HealBot_Config.HealBotDebuffDropDown[ddId] and not HealBot_Config.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config.HealBotDebuffDropDown[z..ddId]=HealBot_Config.HealBotDebuffDropDown[ddId] 
            elseif not HealBot_Config.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config.HealBotDebuffDropDown[z..ddId]=4
            end
            if HealBot_Config.HealBotDebuffText[ddId] and not HealBot_Config.HealBotDebuffText[z..ddId] then 
                HealBot_Config.HealBotDebuffText[z..ddId]=HealBot_Config.HealBotDebuffText[ddId]
            elseif not not HealBot_Config.HealBotDebuffText[z..ddId] then 
                HealBot_Config.HealBotDebuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    else
        for z=1,4 do
            if HealBot_Config.HealBotBuffDropDown[ddId] and not HealBot_Config.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config.HealBotBuffDropDown[z..ddId]=HealBot_Config.HealBotBuffDropDown[ddId]
            elseif not HealBot_Config.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config.HealBotBuffDropDown[z..ddId]=4
            end
            if HealBot_Config.HealBotBuffText[ddId] and not HealBot_Config.HealBotBuffText[z..ddId] then 
                HealBot_Config.HealBotBuffText[z..ddId]=HealBot_Config.HealBotBuffText[ddId]
            elseif not HealBot_Config.HealBotBuffText[z..ddId] then 
                HealBot_Config.HealBotBuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    end
end

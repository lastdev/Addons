local class=nil
local HealBot_UnitStatus={};
local HealBot_PlayerDead=false;
local HealBot_CheckGroup=0;
local HealBot_Enabled={};
local HealBot_PetMaxH={};
local HealBot_PetMaxHcnt1={};
local HealBot_PetMaxHcnt2={};
local HealBot_AttribStatus={};
local HealBot_UnitRange={}
local HealBot_UnitRangeSpell={}
local HealBot_UnitRanger={}
local HealBot_UnitRangeg={}
local HealBot_UnitRangeb={}
local HealBot_UnitRangea={}
local HealBot_UnitRangeb3a={}
local HealBot_UnitRangeitr={}
local HealBot_UnitRangeitg={}
local HealBot_UnitRangeitb={}
local HealBot_UnitRangeotr={}
local HealBot_UnitRangeotg={}
local HealBot_UnitRangeotb={}
local HealBot_UnitRangeota={}
local HealBot_curUnitHealth={}
local HealBot_UnitBarUpdate={}
local HealBot_UnitOffline={}
local HealBot_ResetAttribs=nil
local ceil=ceil;
local b=nil
local btHBbarText=nil
local bttextlen=0
local bthlthdelta=0
local floor=floor
local strsub=strsub
local HealBot_ButtonStore={}
local HealBot_hSpell=nil
local HealBot_bSpell=nil
local HealBot_dSpell=nil
local HealBot_rSpell=nil

local HealBot_ButtonArray1={}
local HealBot_ButtonArray2={}
local HealBot_ButtonArray=1
local HealBot_Aggro={}
local HealBot_AggroIndicator={}
local HealBot_AggroBar4={}
local HealBot_AggroBarA=0.8
local HealBot_AggroBarAup=true
local HealBot_MyTargets={}
local HB_Action_Timer1 = 2000
local HB_Action_Timer2 = 2000

local HealBot_Unit_Bar1={}
local HealBot_Unit_Bar2={}
local HealBot_Unit_Bar3={}
local HealBot_Unit_Bar4={}
local HealBot_Unit_Bar5={}
local HealBot_pcClass=false
local HealBot_pcMax=3
local rangeSpell=nil
local sID=nil
local sName=nil
local uHealIn=nil
local uHlth=nil
local uMaxHlth=nil
local uName=nil
local xButton=nil
local xUnit=nil
local xGUID=nil
local i=nil
local x=nil
local y=nil
local z=nil
local vUnit=nil
local HealBot_FrameMoving=nil
local LSM = LibStub("LibSharedMedia-3.0")
local HealBot_UnitThreat={}
local HealBot_ResetBarSkinDone={}
local HealBot_curGUID=nil
local HealBot_Hightlight={}
local HealBot_GUID={}
local HealBot_Reserved={}
local _

-- Register Default HealBot Media
for i = 1, #HealBot_Default_Textures do
    LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
end
for i = 1, #HealBot_Default_Sounds do
    LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
end

local barName=nil
local mainBar=nil
local barTemp=nil
local HealBot_prevUnitThreat={}
local Healbot_tempUnitThreat=0
local UnitDebuffStatus={}
local HealBot_UnitThreatPct={}
local HealBot_UnitAggro={}
local hbprevThreatPct=-3
-- local HealBot_resetUnitStatus=nil
function HealBot_Action_UpdateAggro(unit,status,threatStatus,hbGUID,threatPct)
    if HealBot_UnitAggro[unit] then HealBot_UnitAggro[unit]=nil end
    uName=UnitName(unit)
    barName=HealBot_Unit_Bar4[unit]
    if unit and not hbGUID then hbGUID=HealBot_GUID[unit] end
    
    if not barName or not uName or not hbGUID then 
        return 
    end    
    if UnitIsDeadOrGhost(unit) and not UnitIsFeignDeath(unit) then
        status=nil
        threatPct=0
        if threatStatus then threatStatus=0 end
    end
    hbprevThreatPct=HealBot_UnitThreatPct[hbGUID] or -4
    if threatStatus and (Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 or Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Current_Skin]==1) then
        if not threatPct then threatPct,_=HealBot_CalcThreat(unit) end
        if threatPct>0 then
            HealBot_UnitThreatPct[hbGUID]=threatPct
            if threatStatus==0 then
                threatStatus=1
                if not status then status=true end
            end
        elseif threatStatus==3 then
            HealBot_UnitThreatPct[hbGUID]=100
        elseif threatStatus==2 then
            if not HealBot_UnitThreatPct[hbGUID] then
                HealBot_UnitThreatPct[hbGUID]=75
            elseif HealBot_UnitThreatPct[hbGUID]<90 then 
                HealBot_UnitThreatPct[hbGUID]=HealBot_UnitThreatPct[hbGUID]+1
            end
        elseif threatStatus==1 then
            if not HealBot_UnitThreatPct[hbGUID] then
                HealBot_UnitThreatPct[hbGUID]=25
            elseif HealBot_UnitThreatPct[hbGUID]>10 then 
                HealBot_UnitThreatPct[hbGUID]=HealBot_UnitThreatPct[hbGUID]-1
            end
        elseif threatStatus>4 then 
            if not HealBot_UnitThreatPct[hbGUID] then
                HealBot_UnitThreatPct[hbGUID]=50
            end
        else
            HealBot_UnitThreatPct[hbGUID]=0
        end
        if HealBot_UnitThreatPct[hbGUID]>0 then HealBot_UnitAggro[unit]=true end
    else
        if not threatStatus then threatStatus=0 end
        HealBot_UnitThreatPct[hbGUID]=0
        if status and not UnitIsFriend("player",unit) then status=nil end
    end
    if HealBot_UnitThreatPct[hbGUID]>=100 then
        HealBot_UnitThreatPct[hbGUID]=100
    else
        HealBot_UnitThreatPct[hbGUID]=ceil(HealBot_UnitThreatPct[hbGUID])
    end
    if status then
        if HealBot_Config.CDCshownAB==1 and UnitDebuffStatus[hbGUID] then
            HealBot_Aggro[hbGUID]="d"
            HealBot_UnitThreat[hbGUID]=UnitDebuffStatus[hbGUID]
        elseif Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and 
               threatStatus>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]) then
            HealBot_UnitThreat[hbGUID]=threatStatus
            HealBot_Aggro[hbGUID]="a"
            HealBot_UnitAggro[unit]=true
        elseif status=="target" and Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Aggro[hbGUID]="h"
            HealBot_UnitThreat[hbGUID]=-2
            HealBot_Hightlight[hbGUID]="T"
        elseif status=="highlight" and Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Aggro[hbGUID]="h"
            HealBot_UnitThreat[hbGUID]=-1
            HealBot_Hightlight[hbGUID]="M"
        elseif HealBot_Aggro[hbGUID] and HealBot_Aggro[hbGUID]=="h" then
            if status~="off" then
                if (HealBot_Hightlight[hbGUID] or "M")=="M" then 
                    HealBot_UnitThreat[hbGUID]=-1
                else    
                    HealBot_UnitThreat[hbGUID]=-2
                end
            else
                HealBot_Aggro[hbGUID]=nil
                HealBot_UnitThreat[hbGUID]=threatStatus
            end
        else
            HealBot_UnitThreat[hbGUID]=threatStatus
            HealBot_Aggro[hbGUID]="a"
        end
        if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and
            Healbot_Config_Skins.ShowAggroInd[Healbot_Config_Skins.Current_Skin]==1 and
            (HealBot_AggroIndicator[hbGUID] or -11) ~= threatStatus then
                HealBot_Action_aggoIndicatorUpd(unit, hbGUID, threatStatus)
        end
    else
        HealBot_UnitThreat[hbGUID]=threatStatus
        HealBot_Aggro[hbGUID]=nil
        if HealBot_AggroIndicator[hbGUID] then
            HealBot_AggroIndicator[hbGUID]=nil
            HealBot_Action_aggoIndicatorUpd(unit, hbGUID, 0)
        end
    end
    if status and 
       (HealBot_Aggro[hbGUID]=="d" or HealBot_Aggro[hbGUID]=="h" or 
       (HealBot_Aggro[hbGUID]=="a" and Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==1 and
       threatStatus>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]))) then
        if not HealBot_AggroBar4[hbGUID] then
            if HealBot_UnitThreat[hbGUID]>-1 and HealBot_UnitThreat[hbGUID]<4 and Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 then
                barName:SetValue(HealBot_UnitThreatPct[hbGUID])
            else
                barName:SetValue(100)
            end
            HealBot_AggroBar4[hbGUID]=barName
        elseif HealBot_AggroBar4[hbGUID]~=barName then
            barTemp=HealBot_AggroBar4[hbGUID]
            barTemp:SetStatusBarColor(1,0,0,0)
            HealBot_AggroBar4[hbGUID]=barName
        elseif HealBot_UnitThreat[hbGUID]>-1 and HealBot_UnitThreat[hbGUID]<4 and Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 then
            barName:SetValue(HealBot_UnitThreatPct[hbGUID])
        else
            barName:SetValue(100)
        end
    elseif HealBot_Hightlight[hbGUID] then
        HealBot_Hightlight[hbGUID]=nil
        if HealBot_AggroBar4[hbGUID] then
            barName=HealBot_AggroBar4[hbGUID]
            barName:SetStatusBarColor(1,0,0,0)
            HealBot_AggroBar4[hbGUID]=nil
        end
    elseif HealBot_AggroBar4[hbGUID] then
        barName=HealBot_AggroBar4[hbGUID]
        barName:SetStatusBarColor(1,0,0,0)
        HealBot_AggroBar4[hbGUID]=nil
    end
    HealBot_Action_ResetUnitStatus(unit)
end

function HealBot_Action_aggoIndicatorUpd(unit, hbGUID, threatStatus)
    mainBar=HealBot_Unit_Bar1[unit]
    HealBot_AggroIndicator[hbGUID]=threatStatus
    if threatStatus>=Healbot_Config_Skins.AggroIndAlertLevel[Healbot_Config_Skins.Current_Skin] then
        if threatStatus==1 then
            iconName = _G[mainBar:GetName().."Iconal1"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconal2"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconal3"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconar1"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconar2"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconar3"];
            iconName:SetAlpha(0)
        elseif threatStatus==2 then
            iconName = _G[mainBar:GetName().."Iconal1"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconal2"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconal3"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconar1"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconar2"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconar3"];
            iconName:SetAlpha(0)
        elseif threatStatus==3 then
            iconName = _G[mainBar:GetName().."Iconal1"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconal2"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconal3"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconar1"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconar2"];
            iconName:SetAlpha(1)
            iconName = _G[mainBar:GetName().."Iconar3"];
            iconName:SetAlpha(1)
        end
    elseif threatStatus>-1 and threatStatus<4 then
        iconName = _G[mainBar:GetName().."Iconal1"];
        iconName:SetAlpha(0)
        iconName = _G[mainBar:GetName().."Iconal2"];
        iconName:SetAlpha(0)
        iconName = _G[mainBar:GetName().."Iconal3"];
        iconName:SetAlpha(0)
        iconName = _G[mainBar:GetName().."Iconar1"];
        iconName:SetAlpha(0)
        iconName = _G[mainBar:GetName().."Iconar2"];
        iconName:SetAlpha(0)
        iconName = _G[mainBar:GetName().."Iconar3"];
        iconName:SetAlpha(0)
    end
end

function HealBot_Action_SetThreatPct(hbGUID, threatPct)
    if not threatPct then return end
    hbprevThreatPct=HealBot_UnitThreatPct[hbGUID] or -2
    HealBot_UnitThreatPct[hbGUID]=threatPct
    if HealBot_UnitThreatPct[hbGUID]~=hbprevThreatPct then HealBot_Action_ResetUnitStatus(unit) end
end

function HealBot_Action_SetVAggro(hbGUID, threatStatus)
    if threatStatus and hbGUID then
        HealBot_Aggro[hbGUID]="a"
    elseif hbGUID then
        HealBot_Aggro[hbGUID]=nil
    end
end

function HealBot_Action_retAggro(hbGUID)
    return HealBot_Aggro[hbGUID]
end

function HealBot_Action_EndAggro()
    for hbGUID,_ in pairs(HealBot_Aggro) do
        if HealBot_UnitID[hbGUID] then
            HealBot_Action_UpdateAggro(HealBot_UnitID[hbGUID],false,nil,hbGUID)
        end
    end
    for hbGUID,barName in pairs(HealBot_AggroBar4) do
        barName:SetStatusBarColor(1,0,0,0)
        HealBot_AggroBar4[hbGUID]=nil
    end
end

function HealBot_Action_SetUnitDebuffStatus(hbGUID,status)
    if not status then
        UnitDebuffStatus[hbGUID]=nil
    else
        UnitDebuffStatus[hbGUID]=status
    end
end

function HealBot_Action_ClearUnitDebuffStatus(hbGUID)
    if hbGUID then
        UnitDebuffStatus[hbGUID]=nil
    else
        for x,_ in pairs(UnitDebuffStatus) do
            UnitDebuffStatus[x]=nil;
        end
    end
end

function HealBot_Action_RetUnitThreat(hbGUID)
    return HealBot_UnitThreat[hbGUID] or -9
end

function HealBot_Action_RetUnitThreatPct(hbGUID)
    return HealBot_UnitThreatPct[hbGUID] or -1
end

function HealBot_Action_RetHealBot_UnitStatus(unit)
    return HealBot_UnitStatus[unit] or -9
end

function HealBot_Action_setpcClass()
	if Healbot_Config_Skins.PowerCounter[Healbot_Config_Skins.Current_Skin]==1 and (HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_MONK]) then
        local prevHealBot_pcMax=HealBot_pcMax;
		if HealBot_PlayerClassTrim==HealBot_Class_En[HEALBOT_PALADIN] then
            HealBot_pcClass=9
            if UnitLevel("player")<85 then
                HealBot_pcMax=3
            else
                HealBot_pcMax=5
            end
        else
            HealBot_pcClass=12
            local _, talent = GetTalentRowSelectionInfo(3)
            if talent==8 then
                HealBot_pcMax=5
            else
                HealBot_pcMax=4
            end
        end     
        if prevHealBot_pcMax~=HealBot_pcMax then
            HealBot_Action_clearResetBarSkinDone()
            if Delay_RecalcParty<1 then Delay_RecalcParty=1; end
        end
	else
		HealBot_pcClass=false
        barName = HealBot_Unit_Bar3["player"]
        if barName then
            for y=1,5 do
                local iconName = _G[barName:GetName().."Icon"..y];
                iconName:SetAlpha(0)
            end
        end
	end
end

function HealBot_Action_SetrSpell()
	HealBot_hSpell=nil
	HealBot_bSpell=nil
	HealBot_dSpell=nil
	HealBot_rSpell=nil
	x=HealBot_GetBandageType()
    if HealBot_PlayerClassTrim=="DRUI" then
        if HealBot_GetSpellId(HEALBOT_REMOVE_CORRUPTION) then 
			HealBot_dSpell=HEALBOT_REMOVE_CORRUPTION
			x=HEALBOT_REMOVE_CORRUPTION
		end
        if HealBot_GetSpellId(HEALBOT_REVIVE) then 
			HealBot_rSpell=HEALBOT_REVIVE
			x=HEALBOT_REVIVE
		end
        if HealBot_GetSpellId(HEALBOT_MARK_OF_THE_WILD) then 
			HealBot_bSpell=HEALBOT_MARK_OF_THE_WILD
			x=HEALBOT_MARK_OF_THE_WILD
		end
        if HealBot_GetSpellId(HEALBOT_REJUVENATION) then 
			HealBot_hSpell=HEALBOT_REJUVENATION 
			x=HEALBOT_REJUVENATION
		end
    elseif HealBot_PlayerClassTrim=="MAGE" then
		if HealBot_GetSpellId(HEALBOT_REMOVE_CURSE) then 
			HealBot_dSpell=HEALBOT_REMOVE_CURSE
			x=HEALBOT_REMOVE_CURSE
		end
		if HealBot_GetSpellId(HEALBOT_ARCANE_BRILLIANCE) then 
			HealBot_bSpell=HEALBOT_ARCANE_BRILLIANCE
			x=HEALBOT_ARCANE_BRILLIANCE
		end
    elseif HealBot_PlayerClassTrim=="PALA" then
		if HealBot_GetSpellId(HEALBOT_REDEMPTION) then 
			HealBot_rSpell=HEALBOT_REDEMPTION
			x=HEALBOT_REDEMPTION
		end
		if HealBot_GetSpellId(HEALBOT_CLEANSE) then 
			HealBot_dSpell=HEALBOT_CLEANSE
			x=HEALBOT_CLEANSE
		end
		if HealBot_GetSpellId(HEALBOT_BLESSING_OF_KINGS) then 
			HealBot_bSpell=HEALBOT_BLESSING_OF_KINGS
			x=HEALBOT_BLESSING_OF_KINGS
		end
		if HealBot_GetSpellId(HEALBOT_HOLY_LIGHT) then 
			HealBot_hSpell=HEALBOT_HOLY_LIGHT
			x=HEALBOT_HOLY_LIGHT
		end
    elseif HealBot_PlayerClassTrim=="PRIE" then
		if HealBot_GetSpellId(HEALBOT_RESURRECTION) then 
			HealBot_rSpell=HEALBOT_RESURRECTION
			x=HEALBOT_RESURRECTION
		end
		if HealBot_GetSpellId(HEALBOT_PURIFY) then 
			HealBot_dSpell=HEALBOT_PURIFY
			x=HEALBOT_PURIFY
		end
		if HealBot_GetSpellId(HEALBOT_POWER_WORD_FORTITUDE) then 
			HealBot_bSpell=HEALBOT_POWER_WORD_FORTITUDE
			x=HEALBOT_POWER_WORD_FORTITUDE
		end
		if HealBot_GetSpellId(HEALBOT_FLASH_HEAL) then 
			HealBot_hSpell=HEALBOT_FLASH_HEAL
			x=HEALBOT_FLASH_HEAL
		end
    elseif HealBot_PlayerClassTrim=="SHAM" then
		if HealBot_GetSpellId(HEALBOT_ANCESTRALSPIRIT) then 
			HealBot_rSpell=HEALBOT_ANCESTRALSPIRIT
			x=HEALBOT_ANCESTRALSPIRIT
		end
		if HealBot_GetSpellId(HEALBOT_PURIFY_SPIRIT) then 
			HealBot_dSpell=HEALBOT_PURIFY_SPIRIT
			x=HEALBOT_PURIFY_SPIRIT
        elseif HealBot_GetSpellId(HEALBOT_CLEANSE_SPIRIT) then 
			HealBot_dSpell=HEALBOT_CLEANSE_SPIRIT
			x=HEALBOT_CLEANSE_SPIRIT
		end
		if HealBot_GetSpellId(HEALBOT_EARTH_SHIELD) then 
			HealBot_bSpell=HEALBOT_EARTH_SHIELD
			x=HEALBOT_EARTH_SHIELD
		end
		if HealBot_GetSpellId(HEALBOT_HEALING_WAVE) then 
			HealBot_hSpell=HEALBOT_HEALING_WAVE
			x=HEALBOT_HEALING_WAVE
		end
    elseif HealBot_PlayerClassTrim=="MONK" then
		if HealBot_GetSpellId(HEALBOT_RESUSCITATE) then 
			HealBot_rSpell=HEALBOT_RESUSCITATE
			x=HEALBOT_RESUSCITATE
		end
		if HealBot_GetSpellId(HEALBOT_DETOX) then 
			HealBot_dSpell=HEALBOT_DETOX
			x=HEALBOT_DETOX
		end
		if HealBot_GetSpellId(HEALBOT_LEGACY_EMPEROR) then 
			HealBot_bSpell=HEALBOT_LEGACY_EMPEROR
			x=HEALBOT_LEGACY_EMPEROR
		end
		if HealBot_GetSpellId(HEALBOT_SOOTHING_MIST) then 
			HealBot_hSpell=HEALBOT_SOOTHING_MIST
			x=HEALBOT_SOOTHING_MIST
		end
    elseif HealBot_PlayerClassTrim=="WARL" then
		if HealBot_GetSpellId(HEALBOT_UNENDING_BREATH) then 
			HealBot_bSpell=HEALBOT_UNENDING_BREATH
			x=HEALBOT_UNENDING_BREATH
		end
    elseif HealBot_PlayerClassTrim=="WARR" then
        if HealBot_GetSpellId(HEALBOT_VIGILANCE) then 
			HealBot_bSpell=HEALBOT_VIGILANCE 
			x=HEALBOT_VIGILANCE
		end
    end
	if (HealBot_hSpell or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_hSpell=x end
	if (HealBot_bSpell or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_bSpell=x end
	if (HealBot_dSpell or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_dSpell=x end
	if (HealBot_rSpell or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_rSpell=x end
    HealBot_Set_debuffSpell(HealBot_dSpell)
--    HealBot_SetrSpells(HealBot_hSpell,HealBot_bSpell,HealBot_dSpell,HealBot_rSpell)
end

function HealBot_GetBandageType()
    local bandage = ""
    if IsUsableItem(HEALBOT_DENSE_EMBERSILK_BANDAGE) then bandage = HEALBOT_DENSE_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_EMBERSILK_BANDAGE) then bandage = HEALBOT_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) then bandage = HEALBOT_HEAVY_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_RUNECLOTH_BANDAGE) then bandage = HEALBOT_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_SILK_BANDAGE) then bandage = HEALBOT_HEAVY_SILK_BANDAGE
    elseif IsUsableItem(HEALBOT_SILK_BANDAGE) then bandage = HEALBOT_SILK_BANDAGE
    else
        bandage = HEALBOT_WORDS_UNKNOWN
    end
    return bandage
end

function HealBot_HealthColor(unit,hlth,maxhlth,tooltipcol,hbGUID,UnitDead,Member_Buff,Member_Debuff,healin,getBar5)
    local hca,hcr,hir,hcg,hig,hcb,hib,hbr,hbg,hbb=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    local hcaggro,hcta,hcpct,hipct,hrpct=nil,nil,nil,nil,100
    if UnitDead then
        hcpct=0
        hipct=0
        hrpct=0
    else
        hipct = hlth+healin
        if hipct<maxhlth then
            hipct=hipct/maxhlth
        else
            hipct=1;
        end
        hcpct=hlth/maxhlth
        if maxhlth == 0 then
            hrpct = 100;
        else
            hrpct=floor((hlth/maxhlth)*100)
        end
    end
  
    if HealBot_Aggro[hbGUID] and (HealBot_UnitThreat[hbGUID] or 0)>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]) and UnitIsConnected(unit) then
        hcaggro=true
    else
        hcaggro=nil
    end
    
    if not tooltipcol then
        HealBot_UnitStatus[unit]=1
        if UnitDead then
            HealBot_UnitStatus[unit]=8
        elseif Member_Debuff and UnitIsConnected(unit) then
            if HealBot_Config.CDCshownHB==1 and HealBot_UnitInRange(HealBot_dSpell, unit)>(HealBot_Config.HealBot_CDCWarnRange_Bar-3) and (HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_UnitDebuff[hbGUID]["name"]] or 1)==1  then
                if HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]] then
                    hcr = HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].R
                    hcg = HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].G
                    hcb = HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].B
                    hca = Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin]
                    hcta = Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
                elseif Member_Debuff == HEALBOT_CUSTOM_en then
                    hcr = HealBot_Globals.CDCBarColour[Member_Debuff].R
                    hcg = HealBot_Globals.CDCBarColour[Member_Debuff].G
                    hcb = HealBot_Globals.CDCBarColour[Member_Debuff].B
                    hca = Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin]
                    hcta = Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
                else
                    hcr = HealBot_Config.CDCBarColour[Member_Debuff].R
                    hcg = HealBot_Config.CDCBarColour[Member_Debuff].G
                    hcb = HealBot_Config.CDCBarColour[Member_Debuff].B
                    hca = Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin]
                    hcta = Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
                end
                if (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] <= 3) then
                    hir=hcr
                    hig=hcg
                    hib=hcb
                elseif (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] == 4) then
                    hir, hig = HealBot_Action_BarColourPct(hipct)
                else
                    hir=Healbot_Config_Skins.ihbarcolr[Healbot_Config_Skins.Current_Skin]
                    hig=Healbot_Config_Skins.ihbarcolg[Healbot_Config_Skins.Current_Skin]
                    hib=Healbot_Config_Skins.ihbarcolb[Healbot_Config_Skins.Current_Skin]
                end
                return hcr,hcg,hcb,hca,hrpct,hcta,hir,hig,hib
            end
        elseif Member_Buff and UnitIsConnected(unit) then
            hcr,hcg,hcb=HealBot_Options_RetBuffRGB(Member_Buff)
            hca = Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin]
            hcta = Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
            if (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] <= 3) then
                hir=hcr
                hig=hcg
                hib=hcb
            elseif (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] == 4) then
                hir, hig = HealBot_Action_BarColourPct(hipct)
            else
                hir=Healbot_Config_Skins.ihbarcolr[Healbot_Config_Skins.Current_Skin]
                hig=Healbot_Config_Skins.ihbarcolg[Healbot_Config_Skins.Current_Skin]
                hib=Healbot_Config_Skins.ihbarcolb[Healbot_Config_Skins.Current_Skin]
            end
            return hcr,hcg,hcb,hca,hrpct,hcta,hir,hig,hib
        elseif hlth>maxhlth*Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin] and not hcaggro then
            vUnit=HealBot_retIsInVehicle(unit)
            if vUnit then
                x,y=HealBot_VehicleHealth(vUnit)
                if x>y*Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin] and not hcaggro then
                    HealBot_UnitStatus[unit]=0;
                end
            else
                HealBot_UnitStatus[unit]=0;
            end
        end
    end

    hcr,hcg,hcb,hir,hig,hib = 1.0, 1.0, 0.0, 1.0, 1.0, 0.0
    if HealBot_UnitStatus[unit]~=0 then --(hipct<=Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin] or HealBot_Aggro[hbGUID]) then -- 
        hca=Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin]
        hcta=Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
    else
        hca=Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]
        hcta=Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Current_Skin]
    end
  
    if UnitDead then
        hcr = 0
        hcg = 0
        hcb = 0
    elseif (Healbot_Config_Skins.HlthBarColour[Healbot_Config_Skins.Current_Skin] >= 2) and not tooltipcol then
        if (Healbot_Config_Skins.HlthBarColour[Healbot_Config_Skins.Current_Skin] == 2) then
            hcr,hcg,hcb = HealBot_Action_ClassColour(hbGUID, unit)
        else
            hcr=Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Current_Skin]
            hcg=Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Current_Skin]
            hcb=Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Current_Skin]
        end
        if (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] == 5) then -- Incoming Heal Bar Colour = "Custom"
            hir=Healbot_Config_Skins.ihbarcolr[Healbot_Config_Skins.Current_Skin]
            hig=Healbot_Config_Skins.ihbarcolg[Healbot_Config_Skins.Current_Skin]
            hib=Healbot_Config_Skins.ihbarcolb[Healbot_Config_Skins.Current_Skin]
	    elseif (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] == 4) then -- Incoming Heal Bar Colour = "Custom"
            hir, hig = HealBot_Action_BarColourPct(hipct)
            hib=0
        else
			hir=hcr
			hig=hcg
			hib=hcb
        end
    else
        if (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] <= 2) then -- Incoming Heal Bar Colour = "Same as Health (Current Health)" or "Do not show"
            hcr, hcg = HealBot_Action_BarColourPct(hcpct)
            hir=hcr
            hig=hcg
            hib=hcb
        elseif (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] == 3) then -- Incoming Heal Bar Colour = "Same as Health (Future Health)"
            hcr, hcg = HealBot_Action_BarColourPct(hipct)
            hir=hcr
            hig=hcg
            hib=hcb
        elseif (Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] == 4) then  -- Incoming Heal Bar Colour = "Future Health"
            hcr, hcg = HealBot_Action_BarColourPct(hcpct)
            if hcpct~=hipct then
                hir, hig = HealBot_Action_BarColourPct(hipct)
            else
                hir=hcr
                hig=hcg
            end
			hib=hcb
        else  -- Incoming Heal Bar Colour = "Custom"
            hcr, hcg = HealBot_Action_BarColourPct(hcpct)
            hir=Healbot_Config_Skins.ihbarcolr[Healbot_Config_Skins.Current_Skin]
            hig=Healbot_Config_Skins.ihbarcolg[Healbot_Config_Skins.Current_Skin]
            hib=Healbot_Config_Skins.ihbarcolb[Healbot_Config_Skins.Current_Skin]
        end
    end
    
    if getBar5 then
        if Healbot_Config_Skins.HlthBarColour[Healbot_Config_Skins.Current_Skin]==Healbot_Config_Skins.HlthBackColour[Healbot_Config_Skins.Current_Skin] and not UnitDead then
            hbr,hbg,hbb=hcr,hcg,hcb
        elseif Healbot_Config_Skins.HlthBackColour[Healbot_Config_Skins.Current_Skin]==1 then
            if Healbot_Config_Skins.IncHealBarColour[Healbot_Config_Skins.Current_Skin] > 2 then
                hbr,hbg = HealBot_Action_BarColourPct(hipct)
            else
                hbr,hbg = HealBot_Action_BarColourPct(hcpct)
            end
            hbb=0
        elseif Healbot_Config_Skins.HlthBackColour[Healbot_Config_Skins.Current_Skin]==2 then
            hbr,hbg,hbb = HealBot_Action_ClassColour(hbGUID, unit)
        else
            hbr=Healbot_Config_Skins.barbackcolr[Healbot_Config_Skins.Current_Skin]
            hbg=Healbot_Config_Skins.barbackcolg[Healbot_Config_Skins.Current_Skin]
            hbb=Healbot_Config_Skins.barbackcolb[Healbot_Config_Skins.Current_Skin]
        end
    end

    return hcr,hcg,hcb,hca,hrpct,hcta,hir,hig,hib,hbr,hbg,hbb
end

local hcpr, hcpg = nil,nil
function HealBot_Action_BarColourPct(hlthPct)
    hcpr, hcpg = 1,1
    if hlthPct>=0.98 then 
        hcpr = 0.0
    elseif hlthPct<0.98 and hlthPct>=0.65 then 
        hcpr=2.94-(hlthPct*3)
    elseif hlthPct<=0.64 and hlthPct>0.31 then 
        hcpg=(hlthPct-0.31)*3
    elseif hlthPct<=0.31 then 
        hcpg = 0.0 
    end
    return hcpr, hcpg
end

function HealBot_Action_HealthBar(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar"];
end

function HealBot_Action_HealthBar2(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar2"];
end

function HealBot_Action_HealthBar3(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar3"];
end

function HealBot_Action_HealthBar4(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar4"];
end

function HealBot_Action_HealthBar5(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar5"];
end

function HealBot_Action_ShouldHealSome(hbGUID)
    if HealBot_Enabled[hbGUID] then 
        return true
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if HealBot_Enabled[HealBot_UnitGUID(xUnit)] then
                return true
            end
        end
    end
end

function HealBot_MayHeal(unit, unitName)
    if unitName then
        if unit ~= 'target' then 
            return true 
        end
        if UnitCanAttack("player",unit) then 
            return false 
        end
        return true;
    else
        return false;
    end
end

function HealBot_Action_SetBar3Value(button)
    if not button then return end
    barName = HealBot_Unit_Bar3[button.unit]
    if HealBot_pcClass and button.unit=="player" then
		x = UnitPower("player", HealBot_pcClass)
        if x==1 then
            iconName = _G[barName:GetName().."Icon"..1];
            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_red.tga]]);
            iconName:SetAlpha(1)
            iconName = _G[barName:GetName().."Icon"..2];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..3];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..4];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(0)
        elseif x==2 then
            if HealBot_pcMax<4 then
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                iconName:SetAlpha(1)
            else
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_orange.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_orange.tga]]);
                iconName:SetAlpha(1)
            end
            iconName = _G[barName:GetName().."Icon"..3];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..4];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(0)
        elseif x==3 then
            if HealBot_pcMax<4 then
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..3];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)

            elseif HealBot_pcMax<5 then
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..3];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)

            else
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..3];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                iconName:SetAlpha(1)
            end
            iconName = _G[barName:GetName().."Icon"..4];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(0)
        elseif x==4 then
            if HealBot_pcMax<5 then
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..3];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..4];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                iconName:SetAlpha(1)

            else
                iconName = _G[barName:GetName().."Icon"..1];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..2];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..3];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)
                iconName = _G[barName:GetName().."Icon"..4];
                iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                iconName:SetAlpha(1)
            end
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(0)
        elseif x==5 then
            iconName = _G[barName:GetName().."Icon"..1];
            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
            iconName:SetAlpha(1)
            iconName = _G[barName:GetName().."Icon"..2];
            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
            iconName:SetAlpha(1)
            iconName = _G[barName:GetName().."Icon"..3];
            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
            iconName:SetAlpha(1)
            iconName = _G[barName:GetName().."Icon"..4];
            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
            iconName:SetAlpha(1)
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(1)
        else
            iconName = _G[barName:GetName().."Icon"..1];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..2];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..3];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..4];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(0)
        end
	--	for y=1,3 do
    --        iconName = _G[barName:GetName().."Icon"..y];
    --        if y>x then
    --            iconName:SetAlpha(0)
    --        else
    --            iconName:SetAlpha(1)
    --        end
--		end
    end
	if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]==0 then return end
    if UnitManaMax(button.unit)==0 then
        x=100
    else
        x=UnitManaMax(button.unit)
    end
    y=floor((UnitMana(button.unit)/x)*100)
    hcr,hcg,hcb=HealBot_Action_GetManaBarCol(button.unit)
    barName:SetValue(y);
    barName:SetStatusBarColor(hcr,hcg,hcb,HealBot_UnitRangeb3a[button.unit] or Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin])
end

function HealBot_Action_GetManaBarCol(unit)
    z=UnitPowerType(unit);
    if z==0 then
        return 0.1,0.1,1 -- Mana
    elseif z==1 then
        return 1,0.1,0.1 -- Rage
    elseif z==4 then
        return 0,1,1 -- Happy
    elseif z==6 then
        return 0.1,0.8,1 -- Rune
    end
    return 1,1,0 -- Energy
end

local hbPetLevel = 1
function HealBot_CorrectPetHealth(unit,hlth,maxhlth,hbGUID)
    if maxhlth==0 then maxhlth=hlth end
    if not hbGUID then return maxhlth end
    if not HealBot_PetMaxH[hbGUID] then
        hbPetLevel=UnitLevel(unit)
        if hbPetLevel>80 then
            if hlth<8100 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*100
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>70 then
            if hlth<5325 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*75
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>60 then
            if hlth<3050 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*50
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>40 then
            if hlth<1640 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*40
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>20 then
            if hlth<735 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*35
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>5 then
            if hlth<180 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*30
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        else
            if hlth<25 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*25
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        end
    elseif hlth>HealBot_PetMaxH[hbGUID] then
        HealBot_PetMaxH[hbGUID]=hlth;
    elseif not HealBot_IsFighting then
        if not HealBot_PetMaxHcnt1[hbGUID] then
            HealBot_PetMaxHcnt1[hbGUID]=1
            HealBot_PetMaxHcnt2[hbGUID]=HealBot_PetMaxH[hbGUID];
        else
            if HealBot_PetMaxHcnt2[hbGUID]~=hlth then
                HealBot_PetMaxHcnt2[hbGUID]=hlth;
                HealBot_PetMaxHcnt1[hbGUID]=1;
            else
                HealBot_PetMaxHcnt1[hbGUID]=HealBot_PetMaxHcnt1[hbGUID]+1;
                if HealBot_PetMaxHcnt1[hbGUID]>9 then
                    HealBot_PetMaxH[hbGUID]=HealBot_PetMaxHcnt2[hbGUID];
                    HealBot_PetMaxHcnt1[hbGUID]=1;
                end
            end
        end
    end
    return HealBot_PetMaxH[hbGUID]
end

local activeUnit = true
function HealBot_Action_EnableButton(button, hbGUID)
    local ebUnit=button.unit
    local ebubar,ebubar2,ebubar5,ebuicon15=nil,nil,nil,nil
    local ebusr,ebusg,ebusb,ebusa=nil,nil,nil,nil
    local ebur,ebir,ebug,ebig,ebub,ebib,ebua,hbr,hbg,hbb=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    local ebpct,ebipct,ebtext=1,0,nil
    local ebufastenable,ebuProcessThis=nil,nil
    local ebuUnitDead,ebuHealBot_UnitDebuff,ebuHealBot_UnitBuff=nil,nil,nil


--    if not uName then return end
--    if not uName then uName=HEALBOT_WORDS_UNKNOWN end

    ebubar = HealBot_Unit_Bar1[ebUnit]
    ebubar2 = HealBot_Unit_Bar2[ebUnit]
    ebubar5 = HealBot_Unit_Bar5[ebUnit]
    ebuicon15 = _G[ebubar:GetName().."Icon15"];
    HealBot_UnitRangeSpell[ebUnit]=HealBot_hSpell

    if UnitExists(ebUnit) and UnitIsFriend("player",ebUnit) then
        activeUnit = true
        uName=UnitName(ebUnit)
        uHlth,uMaxHlth=HealBot_UnitHealth(hbGUID, ebUnit)
        uHealIn = HealBot_IncHeals_retHealsIn(hbGUID)

        ebuUnitDead = UnitIsDeadOrGhost(ebUnit)
        if HealBot_UnitDebuff[hbGUID] then
            ebuHealBot_UnitDebuff=HealBot_UnitDebuff[hbGUID]["type"]
        else
            ebuHealBot_UnitDebuff=nil
        end
        ebuHealBot_UnitBuff=HealBot_UnitBuff[hbGUID]
        
        if uHlth>uMaxHlth then uMaxHlth=HealBot_CorrectPetHealth(ebUnit,uHlth,uMaxHlth,hbGUID) end
    
        if ebuUnitDead then
            if UnitIsFeignDeath(ebUnit) then
                ebuUnitDead = nil
            else
                if uHealIn>0 then
                    uHealIn=0
                end
                if HealBot_Aggro[hbGUID] then
                    HealBot_Action_SetUnitDebuffStatus(hbGUID)
                    HealBot_Action_UpdateAggro(ebUnit,false,HealBot_UnitThreat[hbGUID] or 0,hbGUID)
                    HealBot_Aggro[hbGUID]=nil
                end
                if HealBot_UnitDebuff[hbGUID] then
                    HealBot_UnitDebuff[hbGUID]=nil
                end
                if HealBot_HoT_Active_Button[hbGUID] then 
                    HealBot_HoT_RemoveIconButton(button)
                end
            end
            if uName==HealBot_PlayerName and not HealBot_PlayerDead then
                HealBot_Action_ResetActiveUnitStatus()
                HealBot_PlayerDead=true
            end
        elseif uName==HealBot_PlayerName and HealBot_PlayerDead then
            HealBot_Action_ResetActiveUnitStatus()
            HealBot_PlayerDead=false
        end

        if uHealIn>0 then
            ebipct = uHlth+uHealIn
            if ebipct<uMaxHlth then
                ebipct=ebipct/uMaxHlth
            else
                ebipct=1;
            end
            ebipct=floor(ebipct*100)
            ebubar2:SetValue(ebipct);
        elseif ebubar2:GetValue()>0 then
            ebubar2:SetValue(0)
        end    
    
        ebur,ebug,ebub,ebua,ebpct,ebusa,ebir,ebig,ebib,hbr,hbg,hbb = HealBot_HealthColor(ebUnit,uHlth,uMaxHlth,false,hbGUID,ebuUnitDead,ebuHealBot_UnitBuff,ebuHealBot_UnitDebuff,uHealIn,true)

        if Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Current_Skin]==1 then
            ebusr,ebusg,ebusb = HealBot_Action_ClassColour(hbGUID, ebUnit);
        elseif ebuHealBot_UnitDebuff then
            ebusr=Healbot_Config_Skins.btextcursecolr[Healbot_Config_Skins.Current_Skin];
            ebusg=Healbot_Config_Skins.btextcursecolg[Healbot_Config_Skins.Current_Skin];
            ebusb=Healbot_Config_Skins.btextcursecolb[Healbot_Config_Skins.Current_Skin];
        else
            ebusr=Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Current_Skin] or 1;
            ebusg=Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Current_Skin] or 1;
            ebusb=Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Current_Skin] or 1;
        end

        if uMaxHlth<1 then 
            uHlth=1 
        end
  
        if Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Current_Skin]==0 then
            if ebuUnitDead then
                if HealBot_UnitInRange(HealBot_rSpell, ebUnit)==1 and not UnitIsGhost(ebUnit) then
                    ebubar:SetValue(100)
                else
                    ebubar:SetValue(0)
                end
                ebubar2:SetValue(0)
            else
                ebubar:SetValue(ebpct)
            end
        else
            if HealBot_curUnitHealth[ebubar]~=ebpct then
                if ebuUnitDead then
                    if HealBot_UnitInRange(HealBot_rSpell, ebUnit)==1 and not UnitIsGhost(ebUnit) then
                        ebubar:SetValue(100)
                    else
                        ebubar:SetValue(0)
                    end
                    ebubar2:SetValue(0)
                else
                    HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
                end
                HealBot_curUnitHealth[ebubar]=ebpct
            end
        end
    
        ebuProcessThis=true
        ebufastenable=false
        if HealBot_Globals.ProtectPvP==1 then
            if UnitIsPVP(ebUnit) and not UnitIsPVP("player") then 
                ebuProcessThis=false
            end
        end
        if not ebuUnitDead and not HealBot_PlayerDead and ebuProcessThis then
            if ebuHealBot_UnitDebuff then
                HealBot_UnitRangeSpell[ebUnit]=HealBot_dSpell
                if HealBot_UnitInRange(HealBot_dSpell, ebUnit)==1 then ebufastenable=true end
            elseif ebuHealBot_UnitBuff then
                HealBot_UnitRangeSpell[ebUnit]=HealBot_bSpell
                if HealBot_UnitInRange(HealBot_bSpell, ebUnit)==1 then ebufastenable=true end
            end
            if not ebufastenable and (uHlth<=(uMaxHlth*Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin]) or HealBot_MyTargets[hbGUID]) and HealBot_UnitInRange(HealBot_hSpell, ebUnit)==1 then
                ebufastenable=true
                HealBot_UnitRangeSpell[ebUnit]=HealBot_hSpell
            elseif not ebufastenable and HealBot_Aggro[hbGUID] and (HealBot_UnitThreat[hbGUID] or 0)>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]) and HealBot_UnitInRange(HealBot_hSpell, ebUnit)==1 then
                ebufastenable=true
                HealBot_UnitRangeSpell[ebUnit]=HealBot_hSpell
            end
        end
        if ebufastenable then
            ebusa = Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin];
            HealBot_Enabled[hbGUID]=true
            ebubar:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
            ebubar5:SetStatusBarColor(hbr,hbg,hbb,Healbot_Config_Skins.barbackcola[Healbot_Config_Skins.Current_Skin]);
            HealBot_UnitRangeb3a[ebUnit]=Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]
            if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then -- and HealBot_retdebuffTargetIcon(ebUnit) then
                ebuicon15:SetAlpha(1) --Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
            end
            HealBot_UnitRangeitr[ebUnit]=ebusr
            HealBot_UnitRangeitg[ebUnit]=ebusg
            HealBot_UnitRangeitb[ebUnit]=ebusb
            HealBot_UnitRangeotr[ebUnit]=ebusr
            HealBot_UnitRangeotg[ebUnit]=ebusg
            HealBot_UnitRangeotb[ebUnit]=ebusb
            if ebUnit==HealBot_Action_DisableTooltipUnit then
                HealBot_Action_TooltipUnit = ebUnit;
                HealBot_Action_DisableTooltipUnit = nil;
            end
            if ebUnit==HealBot_Action_TooltipUnit then
                HealBot_Action_RefreshTooltip(ebUnit,"Enabled")
            end
            if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Action_ShowPanel() end
        else
            HealBot_Enabled[hbGUID]=false
            if Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Current_Skin]==0 then
                ebusr=Healbot_Config_Skins.btextdisbledcolr[Healbot_Config_Skins.Current_Skin]
                ebusg=Healbot_Config_Skins.btextdisbledcolg[Healbot_Config_Skins.Current_Skin]
                ebusb=Healbot_Config_Skins.btextdisbledcolb[Healbot_Config_Skins.Current_Skin]
            end
            if HealBot_RetHealBot_Ressing(hbGUID) then
                if ebuUnitDead then
                    ebusr=0.2
                    ebusg=1.0
                    ebusb=0.2
                    ebusa=1
                else
                    HealBot_UnsetHealBot_Ressing(hbGUID)
                end
                HealBot_UnitRangeitr[ebUnit]=0.2
                HealBot_UnitRangeitg[ebUnit]=1
                HealBot_UnitRangeitb[ebUnit]=0.2
                HealBot_UnitRangeotr[ebUnit]=0.2
                HealBot_UnitRangeotg[ebUnit]=1
                HealBot_UnitRangeotb[ebUnit]=0.2
            elseif ebuUnitDead and uName~=HealBot_PlayerName then
                if HealBot_rSpell then
                    HealBot_UnitRangeSpell[ebUnit]=HealBot_rSpell
                    if HealBot_UnitInRange(HealBot_rSpell, ebUnit)==1 and not UnitIsGhost(ebUnit) then
                        ebusr=1;
                        ebusg=0.2;
                        ebusb=0.2;
                        ebusa=1;
                    else
                        ebusr=0.8;
                        ebusg=0;
                        ebusb=0;
                        ebusa=1;
                    end
                    if not UnitIsGhost(ebUnit) then
                        HealBot_UnitRangeitr[ebUnit]=1
                        HealBot_UnitRangeitg[ebUnit]=0.2
                        HealBot_UnitRangeitb[ebUnit]=0.2
                    else
                        HealBot_UnitRangeitr[ebUnit]=0.8
                        HealBot_UnitRangeitg[ebUnit]=0
                        HealBot_UnitRangeitb[ebUnit]=0
                    end
                    HealBot_UnitRangeotr[ebUnit]=0.8
                    HealBot_UnitRangeotg[ebUnit]=0
                    HealBot_UnitRangeotb[ebUnit]=0
                end
            else
                HealBot_UnitRangeitr[ebUnit]=ebusr
                HealBot_UnitRangeitg[ebUnit]=ebusg
                HealBot_UnitRangeitb[ebUnit]=ebusb
                HealBot_UnitRangeotr[ebUnit]=ebusr
                HealBot_UnitRangeotg[ebUnit]=ebusg
                HealBot_UnitRangeotb[ebUnit]=ebusb
                --ebua=Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]
            end
            if UnitIsVisible(ebUnit) then
                ebubar:SetStatusBarColor(ebur,ebug,ebub,ebua);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then -- and HealBot_retdebuffTargetIcon(ebUnit) then
                    ebuicon15:SetAlpha(ebua);
                end
            else
                ebubar:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then -- and HealBot_retdebuffTargetIcon(ebUnit) then
                    ebuicon15:SetAlpha(Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
                end
            end
            ebubar5:SetStatusBarColor(hbr,hbg,hbb,Healbot_Config_Skins.barbackcola[Healbot_Config_Skins.Current_Skin]);
            if not HealBot_IsFighting and HealBot_Config.EnableHealthy==0 then
                if ebUnit==HealBot_Action_TooltipUnit then
                    HealBot_Action_TooltipUnit = nil;
                    HealBot_Action_DisableTooltipUnit = ebUnit;
                end
                if ebUnit==HealBot_Action_DisableTooltipUnit then
                    HealBot_Action_RefreshTooltip(ebUnit,"Disabled")
                end
            end
            HealBot_UnitRangeb3a[ebUnit]=ebua
        end
        HealBot_UnitRanger[ebUnit]=ebur
        HealBot_UnitRangeg[ebUnit]=ebug
        HealBot_UnitRangeb[ebUnit]=ebub
        HealBot_UnitRangea[ebUnit]=ebua
        HealBot_UnitRangeota[ebUnit]=ebusa
    else
        uHlth,uMaxHlth=1,1
        uHealIn = 0
        ebusr,ebusg,ebusb=0.7,0.7,0.7
        ebubar:SetStatusBarColor(0,1,0,0)
        ebubar5:SetStatusBarColor(0,0,0,0);
        HealBot_UnitRanger[ebUnit]=0
        HealBot_UnitRangeg[ebUnit]=1
        HealBot_UnitRangeb[ebUnit]=0
        HealBot_UnitRangea[ebUnit]=ebua or 0.1
        HealBot_UnitRangeb3a[ebUnit]=ebua or 0.1
        HealBot_UnitRangeota[ebUnit]=ebusa or 0.01
        activeUnit = false
        if hbGUID==ebUnit then
            uName=HEALBOT_WORD_RESERVED..":"..ebUnit
            HealBot_Reserved[ebUnit]=true
        else
            uName=HEALBOT_WORDS_UNKNOWN
            if Delay_RecalcParty<1 then Delay_RecalcParty=1 end
            HealBot_UnitStatus[ebUnit]=9
        end
    end
    
    if uHealIn>0 then
        ebubar2:SetStatusBarColor(ebir,ebig,ebib,Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Current_Skin]);
        if HealBot_UnitRangeb3a[ebUnit]<Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Current_Skin] then
            HealBot_UnitRangeb3a[ebUnit]=Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Current_Skin]
        end
    else
        ebubar2:SetStatusBarColor(ebur,ebug,ebub,0);
    end
  
  --  ebubar.txt = _G[ebubar:GetName().."_text"];
    ebtext=HealBot_Action_HBText(uHlth,uMaxHlth,uName,ebUnit,uHealIn, hbGUID)
    ebubar.txt:SetText(ebtext);
    if activeUnit and UnitIsVisible(ebUnit) then
        ebubar.txt:SetTextColor(ebusr,ebusg,ebusb,ebusa);
    else
        ebubar.txt:SetTextColor(ebusr,ebusg,ebusb,Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Current_Skin]);
    end
    if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
        HealBot_Action_SetBar3Value(HealBot_Unit_Button[ebUnit]);
    end
    HealBot_UnitRange[ebUnit]=HealBot_UnitInRange(HealBot_UnitRangeSpell[ebUnit], ebUnit)
end

local hpPerc=nil
local r,g,b=nil,nil,nil
local hbFont=nil
local hbFontAdj=nil
local hbFontVal={ ["Accidental Presidency"]=3,
                  ["Alba Super"]=1.4,
                  ["Anime Ace"]=1,
                  ["Ariel Narrow"]=3,
                  ["Blazed"]=1.1,
                  ["Designer Block"]=1.7,
                  ["DestructoBeam BB"]=1.4,
                  ["Diogenes"]=2.1,
                  ["Disko"]=1.9,
                  ["DreamSpeak"]=3,
                  ["Drummon"]=1.5,
                  ["Dustismo"]=1.9,
                  ["Electrofied"]=1.1,
                  ["Emblem"]=1.7,
                  ["Frakturika Spamless"]=2.4,
                  ["Friz Quadrata TT"]=1.6,
                  ["Impact"]=2,
                  ["Liberation Sans"]=1.6,
                  ["Liberation Serif"]=1.8,
                  ["Morpheus"]=1.9,
                  ["Mystic Orbs"]=1.2,
                  ["Pokemon Solid"]=1.9,
                  ["Rock Show Whiplash"]=2.4,
                  ["SF Diego Sans"]=1.5,
                  ["SF Laundromatic"]=3,
                  ["Skurri"]=2.2,
                  ["Solange"]=1.4,
                  ["Star Cine"]=1,
                  ["Trashco"]=1.6,
                  ["Waltograph UI"]=1,
                  ["X360"]=1.4,
                  ["Zekton"]=1.6,
                }
                

local hbNumFormatPlaces=-1
local hbNumFormatSurL="("
local hbNumFormatSurR=")"
local hbNumFormatSuffix="K"
function HealBot_Action_sethbNumberFormat()
    if Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==2 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==5 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==8 then
        hbNumFormatPlaces=0
    elseif Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==3 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==6 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==9 then
        hbNumFormatPlaces=1
    elseif Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==4 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==7 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==10 then
        hbNumFormatPlaces=2
    else
        hbNumFormatPlaces=-1
    end
    if Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]<5 then
        hbNumFormatSuffix="K"
    elseif Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]>4 and Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]<8 then
        hbNumFormatSuffix="k"
    else
        hbNumFormatSuffix=""
    end
    if Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==2 then
        hbNumFormatSurL="("
        hbNumFormatSurR=")"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==3 then
        hbNumFormatSurL="["
        hbNumFormatSurR="]"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==4 then
        hbNumFormatSurL="{"
        hbNumFormatSurR="}"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==5 then
        hbNumFormatSurL="<"
        hbNumFormatSurR=">"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==6 then
        hbNumFormatSurL="~"
        hbNumFormatSurR=""
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==7 then
        hbNumFormatSurL=":"
        hbNumFormatSurR=":"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==8 then
        hbNumFormatSurL="*"
        hbNumFormatSurR="*"
    else
        hbNumFormatSurL=""
        hbNumFormatSurR=""
    end
    if hbNumFormatPlaces==-1 then
        hbNumFormatSuffix=""
    end
end

local hbNumFormatSurLa="["
local hbNumFormatSurRa="]"
function HealBot_Action_sethbAggroNumberFormat()
    if Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==2 then
        hbNumFormatSurLa="("
        hbNumFormatSurRa=")"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==3 then
        hbNumFormatSurLa="["
        hbNumFormatSurRa="]"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==4 then
        hbNumFormatSurLa="{"
        hbNumFormatSurRa="}"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==5 then
        hbNumFormatSurLa="<"
        hbNumFormatSurRa=">"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==6 then
        hbNumFormatSurLa="~"
        hbNumFormatSurRa=""
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==7 then
        hbNumFormatSurLa=":"
        hbNumFormatSurRa=":"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==8 then
        hbNumFormatSurLa="*"
        hbNumFormatSurRa="*"
    else
        hbNumFormatSurLa=""
        hbNumFormatSurRa=""
    end
end

local clTxt, hbRole=nil,nil
function HealBot_Action_HBText(hlth,maxhlth,unitName,unit,healin, hbGUID)
    btHBbarText=" "
    
    if not activeUnit then
        return unitName;
    else
        if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==2 and UnitClass(unit) then
            if Healbot_Config_Skins.ShowRole[Healbot_Config_Skins.Current_Skin]==1 then
                hbRole=UnitGroupRolesAssigned(unit)    
                if hbRole=="NONE" and HealBot_UnitRole[hbGUID] then
                    hbRole=HealBot_UnitRole[hbGUID]
                end
                if hbRole=="DAMAGER" then
                    clTxt=HEALBOT_WORD_DAMAGER
                elseif hbRole=="HEALER" then
                    clTxt=HEALBOT_WORD_HEALER
                elseif hbRole=="TANK" then
                    clTxt=HEALBOT_WORD_TANK
                elseif hbRole=="LEADER" then
                    clTxt=HEALBOT_WORD_LEADER
                else
                    clTxt=UnitClass(unit)
                end
            else
                clTxt=UnitClass(unit)
            end
            if Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Current_Skin]==1 then
                uName=clTxt..":"..unitName;
            else
                uName=clTxt;
            end
        elseif Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Current_Skin]==1 then
            uName=unitName;
        else
            uName=" "
        end
        hbFont=Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Current_Skin]
        hbFontAdj=hbFontVal[hbFont] or 2
        bttextlen = floor((hbFontAdj*2)+2+(((Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]*1.88)/Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin])-(Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin]/hbFontAdj)))
        if Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Current_Skin]==1 and maxhlth then
            if Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Current_Skin]==1 then
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==2 then
                    bthlthdelta=hlth+healin
                    if bthlthdelta>maxhlth then bthlthdelta=maxhlth end
                else
                    bthlthdelta=hlth;
                end
                if hbNumFormatPlaces>-1 then bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormatPlaces) end
                btHBbarText=btHBbarText..hbNumFormatSurL..bthlthdelta..hbNumFormatSuffix..hbNumFormatSurR;
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==3 and healin>0 then
                    if hbNumFormatPlaces>-1 then healin=HealBot_Comm_round(healin/1000,hbNumFormatPlaces) end
                    btHBbarText=btHBbarText.." +"..healin..hbNumFormatSuffix
                end
            elseif Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Current_Skin]==2 then
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==2 then
                    bthlthdelta=(hlth+healin)-maxhlth;
                else
                    bthlthdelta=hlth-maxhlth;
                end
                if hbNumFormatPlaces>-1 then bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormatPlaces) end
                if bthlthdelta>0 then
                    btHBbarText=btHBbarText.." "..hbNumFormatSurL.."+"..bthlthdelta..hbNumFormatSuffix..hbNumFormatSurR;
                else
                    btHBbarText=btHBbarText..hbNumFormatSurL..bthlthdelta..hbNumFormatSuffix..hbNumFormatSurR;
                end
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==3 and healin>0 then
                    if hbNumFormatPlaces>-1 then healin=HealBot_Comm_round(healin/1000,hbNumFormatPlaces) end
                    btHBbarText=btHBbarText.." +"..healin..hbNumFormatSuffix
                end
            else
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==2 then
                    btHBbarText=btHBbarText..hbNumFormatSurL..floor(((hlth+healin)/maxhlth)*100).."%"..hbNumFormatSurR
                else
                    btHBbarText=btHBbarText..hbNumFormatSurL..floor((hlth/maxhlth)*100).."%"..hbNumFormatSurR
                end
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==3 and healin>0 then
                    btHBbarText=btHBbarText.." +"..floor((healin/maxhlth)*100).."%"
                end
            end
        end
        
        if HealBot_Action_UnitIsOffline(hbGUID) then
            uName=HEALBOT_DISCONNECTED_TEXT.." "..uName;
        end    -- added by Diacono of Ursin
        if Healbot_Config_Skins.ShowAggroText[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Aggro[hbGUID] and HealBot_Aggro[hbGUID]=="a" and 
           (HealBot_UnitThreat[hbGUID] or 0)>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]) and uName then
            uName=">> "..uName.." <<"
            --uName=">"..HealBot_UnitThreat[hbGUID].."> "..uName.." <"..HealBot_UnitThreat[hbGUID].."<"
        end
        vUnit=HealBot_retIsInVehicle(unit)
        if vUnit then
            x,y=HealBot_VehicleHealth(vUnit)
            hpPerc = floor((x/y)*100)
            if hpPerc < 0 then 
                hpPerc = 0
            end
            bthlthdelta="  "..string.format("|cff%s%d%%|r", HealBot_PercentToHexColor(hpPerc), hpPerc)
            if bttextlen>9 then 
                y=bttextlen-7
            else
                y=3
            end
            if UnitName(vUnit) and string.utf8len(UnitName(vUnit))>y then
                bthlthdelta = string.utf8sub(UnitName(vUnit),1,y).. '..'..bthlthdelta
            elseif UnitExists(vUnit) then
                bthlthdelta = UnitName(vUnit)..bthlthdelta
            else
                HealBot_CheckAllUnitVehicle(unit)
                if HealBot_retIsInVehicle(unit) then
                    bthlthdelta = HEALBOT_VEHICLE..bthlthdelta
                end
            end
        end
    end
    if Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitThreatPct[hbGUID] and HealBot_UnitThreatPct[hbGUID]>0 then 
        btHBbarText=btHBbarText.."  "..hbNumFormatSurLa..HealBot_UnitThreatPct[hbGUID].."%"..hbNumFormatSurRa
    end
    if Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Current_Skin]==0 then
        bttextlen=bttextlen-string.utf8len(btHBbarText)
        if bttextlen<1 then 
            bttextlen=1
        end
        if uName and string.utf8len(uName)>bttextlen then
            btHBbarText = string.utf8sub(uName,1,bttextlen) .. '.'..btHBbarText;
        elseif uName then
            btHBbarText = uName..btHBbarText;
        end
        if vUnit then
            btHBbarText = btHBbarText.."\n".." "..bthlthdelta
        end
    else
        if bttextlen<1 then 
            bttextlen=1
        end
        if uName and string.utf8len(uName)>bttextlen then
            btHBbarText = string.utf8sub(uName,1,bttextlen) .. '.'.."\n"..btHBbarText;
        elseif uName then
            btHBbarText = uName.."\n"..btHBbarText;
        end
        if vUnit then
            btHBbarText = btHBbarText.." "..bthlthdelta
        end
    end
    return btHBbarText;
end

function HealBot_PercentToHexColor(percent)
    percent = percent/100
    r,g,b = 2-percent*2,1,0
    if percent <= 0 then
        r,g,b = 1,0,0
    elseif percent <= 0.5 then
        r,g,b = 1,percent*2,0
    elseif percent >= 1 then
        r,g,b = 0,1,0
    end 
    return string.format("%02x%02x%02x",r*255,g*255,b*255)
end

function HealBot_Action_UnitIsOffline(hbGUID,preset) -- added by Diacono of Ursin
    x = nil;
    if not HealBot_UnitID[hbGUID] then return end
    if preset then
        HealBot_UnitOffline[hbGUID]=preset
    else
        if HealBot_UnitOffline[hbGUID] then
            if time() - HealBot_UnitOffline[hbGUID] <= 2 then
                x = true;
            end
        end
        if not UnitIsConnected(HealBot_UnitID[hbGUID]) or x then
            if not HealBot_UnitOffline[hbGUID] then
                HealBot_UnitOffline[hbGUID] = time();
            elseif HealBot_UnitOffline[hbGUID] == -1 then
                HealBot_UnitOffline[hbGUID] = nil;
            end
        else
            HealBot_UnitOffline[hbGUID] = nil;
        end
        return HealBot_UnitOffline[hbGUID]
    end
end

function HealBot_Action_retUnitOffline(hbGUID)
    return HealBot_UnitOffline[hbGUID]
end

function HealBot_Action_RefreshButton(button, hbGUID)
    if not button or not hbGUID then return end
--  if type(button)~="table" then DEFAULT_CHAT_FRAME:AddMessage("***** "..type(button)) end
    HealBot_Action_EnableButton(button, hbGUID)
    if UnitExists("target") and HealBot_UnitGUID("target")==hbGUID and button.unit~="target" and HealBot_Unit_Button["target"] then
        HealBot_Action_EnableButton(HealBot_Unit_Button["target"], hbGUID)
    end
end

local HealBot_resetSkinTo=""
local HealBot_initSkin={}
function HealBot_Action_ResetSkin(barType,button,numcols)
local frameScale = Healbot_Config_Skins.FrameScale[Healbot_Config_Skins.Current_Skin];
local bwidth = Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]*frameScale;
local bheight=Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]*frameScale;
local b2Size = ceil(Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]*frameScale)
local br=Healbot_Config_Skins.headbarcolr[Healbot_Config_Skins.Current_Skin];  
local bg=Healbot_Config_Skins.headbarcolg[Healbot_Config_Skins.Current_Skin];
local bb=Healbot_Config_Skins.headbarcolb[Healbot_Config_Skins.Current_Skin];
local ba=Healbot_Config_Skins.headbarcola[Healbot_Config_Skins.Current_Skin];
local sr=Healbot_Config_Skins.headtxtcolr[Healbot_Config_Skins.Current_Skin];  
local sg=Healbot_Config_Skins.headtxtcolg[Healbot_Config_Skins.Current_Skin];
local sb=Healbot_Config_Skins.headtxtcolb[Healbot_Config_Skins.Current_Skin];
local sa=Healbot_Config_Skins.headtxtcola[Healbot_Config_Skins.Current_Skin];
local btexture=Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin];
local btextheight=Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin]*frameScale;
local btextoutline=Healbot_Config_Skins.btextoutline[Healbot_Config_Skins.Current_Skin];
local b,bar,bar2,bar3,bar4,icon,txt,icon1,icon15,icon16,icon1t,icon15t,icon1ta,icon15ta,pIcon,icont,iconta
local barScale,h,hwidth,hheight,iScale,itScale,x,hcpct,bar5
local abSize = ceil((Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Current_Skin] or 2)*frameScale)
local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
  
    if barType=="bar" then
        if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==0 and 
           Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and
           Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then 
            abSize=0 
        end
        if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
            iScale=floor(((bheight*Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Current_Skin])-2)*0.485)
        else
            iScale=(bheight*Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Current_Skin])-2
        end
        itScale=ceil(iScale*Healbot_Config_Skins.IconTextScale[Healbot_Config_Skins.Current_Skin])
         --for x=1,51 do
        b=button;
        HealBot_ResetBarSkinDone[b.id]=true
        bar = HealBot_Action_HealthBar(b);
        bar2 = HealBot_Action_HealthBar2(b);
        bar3 = HealBot_Action_HealthBar3(b);
        bar4 = HealBot_Action_HealthBar4(b)
        bar5 = HealBot_Action_HealthBar5(b)
        bar.txt = _G[bar:GetName().."_text"];
        bar3.txt=_G[bar3:GetName().."Power".."1"];
        bar:SetHeight(bheight);
        bar:SetWidth(bwidth)
        bar5:SetHeight(bheight);
        bar5:SetWidth(bwidth)
        bar5:SetPoint("TOPLEFT",bar,"TOPLEFT",0,0);
        bar5:SetFrameLevel(bar4:GetFrameLevel()+ 1);
        bar2:SetFrameLevel(bar5:GetFrameLevel()+ 1);
        bar:SetFrameLevel(bar2:GetFrameLevel()+ 1);
		bar3:SetFrameLevel(bar:GetFrameLevel()+ 1);
     --   bar:SetTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]),false);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Current_Skin]),btextheight,HealBot_Font_Outline[btextoutline]);
        bar.txt:ClearAllPoints();
        bar5:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar5:GetStatusBarTexture():SetHorizTile(false)
        if Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Current_Skin]==1 then
            bar.txt:SetPoint("LEFT",bar,"LEFT",4,0)
        elseif Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Current_Skin]==2 then
            bar.txt:SetPoint("CENTER",bar,"CENTER")
        else
            bar.txt:SetPoint("RIGHT",bar,"RIGHT",-4,0)
        end
    --bar.txt:SetTextHeight(btextheight);
        bar2:SetHeight(bheight);
        bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar2:GetStatusBarTexture():SetHorizTile(false)
        bar3:SetHeight(b2Size);
        bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar3:GetStatusBarTexture():SetHorizTile(false)
        bar4:ClearAllPoints();
        bar4:SetPoint("TOPLEFT",bar,"TOPLEFT",0,abSize);
        bar4:SetPoint("TOPRIGHT",bar,"TOPRIGHT",0,abSize);
        if b2Size==0 then
            bar4:SetHeight(bheight+(abSize*2))
        else
            bar4:SetHeight(b2Size+bheight+(abSize*2))
        end
        bar4:SetStatusBarTexture('Interface\\Addons\\HealBot\\Images\\aggro'..abtSize[abSize]..'.tga')
        bar4:GetStatusBarTexture():SetHorizTile(false)
        bar4:SetStatusBarColor(1,0,0,0)
        bar4:SetMinMaxValues(0,100)
        bar4:SetValue(100)
        b:SetHeight(bheight); 
        b:SetWidth(bwidth)
        for x=2,14 do
            icon=_G[bar:GetName().."Icon"..x];
            icont=_G[bar:GetName().."Count"..x];
            iconta=_G[bar:GetName().."Count"..x.."a"];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            icont:SetTextHeight(itScale)
            iconta:SetTextHeight(itScale)
        end
        icon1 = _G[bar:GetName().."Icon1"];
        icon1t = _G[bar:GetName().."Count1"];
        icon1ta = _G[bar:GetName().."Count1a"];
        icon15 = _G[bar:GetName().."Icon15"];
        icon16 = _G[bar:GetName().."Icon16"];
        icon15t = _G[bar:GetName().."Count15"]; 
        icon15ta = _G[bar:GetName().."Count15a"];   
        for x=1,3 do
            pIcon = _G[bar:GetName().."Iconal"..x];
            pIcon:SetAlpha(0);
            pIcon = _G[bar:GetName().."Iconar"..x];
            pIcon:SetAlpha(0);
            pIcon = _G[bar:GetName().."Icontm"..x];
            pIcon:SetAlpha(0);
        end
        for x=1,5 do
            pIcon = _G[bar3:GetName().."Icon"..x];
            pIcon:SetAlpha(0);
        end
        if HealBot_pcMax==3 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-9","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","9","0");
        elseif HealBot_pcMax==4 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-12","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-4","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","4","0");
            pIcon = _G[bar3:GetName().."Icon4"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","12","0");
        else
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-14","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-7","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon4"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","7","0");
            pIcon = _G[bar3:GetName().."Icon5"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","14","0");
        end
        icon1:SetHeight(iScale);
        icon1:SetWidth(iScale);
        icon1t:SetTextHeight(itScale)
        icon1ta:SetTextHeight(itScale)        
        icon15:SetHeight(iScale);
        icon15:SetWidth(iScale);
        icon15t:SetTextHeight(itScale)
        icon15ta:SetTextHeight(itScale)
        icon16:SetHeight(iScale);
        icon16:SetWidth(iScale);
        if not HealBot_initSkin[b.id] then
            HealBot_initSkin[b.id]=true
            b:Enable();
            bar:SetMinMaxValues(0,100)
            bar2:SetMinMaxValues(0,100);
            bar3:SetMinMaxValues(0,100)
            bar5:SetMinMaxValues(0,100)
            bar:SetStatusBarColor(0,1,0,Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
            bar5:SetStatusBarColor(0,1,0,Healbot_Config_Skins.barbackcola[Healbot_Config_Skins.Current_Skin]);
            if not HealBot_curUnitHealth[bar] then
                uHlth,uMaxHlth=HealBot_UnitHealth(hbGUID, b.unit)
                if uHlth>uMaxHlth then uMaxHlth=HealBot_CorrectPetHealth(b.unit,uHlth,uMaxHlth,hbGUID) end
                if uHlth<uMaxHlth then
                    hcpct=floor(uHlth/uMaxHlth)*100
                else
                    hcpct=100;
                end
                HealBot_curUnitHealth[bar]=hcpct
            end
            bar:SetValue(HealBot_curUnitHealth[bar])
            HealBot_Panel_SetBarArrays(b)
            bar2:SetValue(0);
            bar5:SetValue(100);
            bar2:SetStatusBarColor(0,1,0,0);
        end
        if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
            icon15:SetTexture([[Interface\AddOns\HealBot\Images\icon_class.tga]]);
        else
        --    icon15:SetTexCoord(0,1,0,1);
            icon15:SetAlpha(0);
        end
        if Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-1,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",5,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMLEFT",icon15,"TOPLEFT",0,1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",5,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",-1,0);
            end
        elseif Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Current_Skin]==2 then
            HealBot_Panel_SetMultiColHoToffset((iScale+1)*5)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMLEFT",icon15,"TOPLEFT",0,1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",5,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",-1,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-1,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",5,0);
            end
        else
            HealBot_Panel_SetMultiColHoToffset(0)
            if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                HealBot_Panel_SetMultiRowHoToffset((iScale*2)+1)
            else
                HealBot_Panel_SetMultiRowHoToffset(iScale+1)
            end
            if Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPLEFT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",0,-1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,-1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-1,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",5,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",0,-1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("TOPLEFT",icon15,"BOTTOMRIGHT",0,-1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",5,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",-1,0);
            end
        end

        if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]==0 then
            bar3:SetHeight(1);
            bar3:SetValue(0);
            bar3:SetStatusBarColor(0,0,0,0)
        end
        if Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==0 and 
           Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and
           Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then
            bar4:SetMinMaxValues(0,100)
            bar4:SetValue(0)
            bar4:SetStatusBarColor(0,0,0,0)
        end
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
        barScale = bar2:GetScale();
        bar2:SetScale(barScale + 0.01);
        bar2:SetScale(barScale);
        barScale = bar3:GetScale();
        bar3:SetScale(barScale + 0.01);
        bar3:SetScale(barScale);
        barScale = bar4:GetScale();
        bar4:SetScale(barScale + 0.01);
        bar4:SetScale(barScale);
        barScale = bar5:GetScale();
        bar5:SetScale(barScale + 0.01);
        bar5:SetScale(barScale);
    elseif barType=="header" then
          --for x=1,15 do
        h=button
        bar = HealBot_Action_HealthBar(h);
        hwidth = ceil(bwidth*Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Current_Skin])
        hheight = ceil(bheight*Healbot_Config_Skins.headhight[Healbot_Config_Skins.Current_Skin])
        local headtextoutline = Healbot_Config_Skins.headtextoutline[Healbot_Config_Skins.Current_Skin]
        HealBot_Panel_SetHeadArrays(h)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.headtexture[Healbot_Config_Skins.Current_Skin]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar:SetMinMaxValues(0,100);
        bar:SetValue(100);
        bar:SetStatusBarColor(br,bg,bb,ba);
        bar:SetHeight(hheight);
        bar:SetWidth(hwidth);
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.headtextfont[Healbot_Config_Skins.Current_Skin]),Healbot_Config_Skins.headtextheight[Healbot_Config_Skins.Current_Skin]*frameScale,HealBot_Font_Outline[headtextoutline]);
        bar.txt:SetTextColor(sr,sg,sb,sa);
        h:Disable();
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    elseif barType=="hbfocus" then
        HealBot_Action_hbFocusButtonBar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        HealBot_Action_hbFocusButtonBar:GetStatusBarTexture():SetHorizTile(false)

        HealBot_Action_hbFocusButtonBar:SetStatusBarColor(1,1,1,1);
        HealBot_Action_hbFocusButtonBar.txt = _G[HealBot_Action_hbFocusButtonBar:GetName().."_text"];
        HealBot_Action_hbFocusButtonBar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Current_Skin]),btextheight,HealBot_Font_Outline[btextoutline]);
        HealBot_Action_hbFocusButtonBar.txt:SetTextColor(0,0,0,1);
        iScale=0.84
        iScale=iScale+(numcols/10)
        HealBot_Action_hbFocusButtonBar:SetWidth(bwidth*iScale)
        HealBot_Action_hbFocusButton:SetWidth(bwidth*iScale)
        HealBot_Action_hbFocusButtonBar:SetHeight(bheight); 
        HealBot_Action_hbFocusButton:SetHeight(bheight); 
        HealBot_Action_hbFocusButtonBar.txt:SetText(HEALBOT_ACTION_HBFOCUS)
        barScale = HealBot_Action_hbFocusButtonBar:GetScale();
        HealBot_Action_hbFocusButtonBar:SetScale(barScale + 0.01);
        HealBot_Action_hbFocusButtonBar:SetScale(barScale);
    else
        HealBot_Action_SetAddHeight()
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        HealBot_Action_sethbNumberFormat()
        HealBot_setOptions_Timer(85)
        if HealBot_resetSkinTo~=Healbot_Config_Skins.Current_Skin then
            HealBot_resetSkinTo=Healbot_Config_Skins.Current_Skin
            HealBot_Options_RaidTargetUpdate()
            HealBot_CheckFrame()
        end
        if Delay_RecalcParty<3 then 
            Delay_RecalcParty=3; 
        end
    end
end

function HealBot_Action_RefreshButtons(hbGUID)
    if hbGUID then
        HealBot_Action_RefreshButton(HealBot_Unit_Button[HealBot_UnitID[hbGUID]], hbGUID)
    else
        if HealBot_ButtonArray==1 then
            for xUnit,xButton in pairs(HealBot_ButtonArray1) do
                HealBot_Action_CheckRange(xUnit, xButton)
            end
            HealBot_ButtonArray=2
        else
            for xUnit,xButton in pairs(HealBot_ButtonArray2) do
                HealBot_Action_CheckRange(xUnit, xButton)
            end
            HealBot_ButtonArray=1
        end
    end
end

function HealBot_Action_CheckAggro(unit)
    if unit then
        HealBot_CheckUnitAggro(unit)
    elseif HealBot_IsFighting then
        if HealBot_ButtonArray==1 then
            for xUnit,_ in pairs(HealBot_ButtonArray1) do
                HealBot_CheckUnitAggro(xUnit)
            end
        else
            for xUnit,_ in pairs(HealBot_ButtonArray2) do
                HealBot_CheckUnitAggro(xUnit)
            end
        end
    else
        for xUnit,_ in pairs(HealBot_UnitAggro) do
            HealBot_CheckUnitAggro(xUnit)
        end
    end
end

local uRange=0
local db1=nil
local db2=nil
local tdebugtime=GetTime()
function HealBot_Action_CheckRange(unit, button)
    if not HealBot_UnitStatus[unit] then return end
    if HealBot_UnitStatus[unit]>0 then
        uRange=HealBot_UnitInRange(HealBot_UnitRangeSpell[unit] or HealBot_hSpell, unit)
        if unit~="player" and HealBot_UnitStatus[unit]==8 and UnitHealth(unit)>1 then 
            HealBot_OnEvent_UnitHealth(nil,unit,UnitHealth(unit),UnitHealthMax(unit)) 
        end
        if HealBot_UnitRange[unit]==-2 then
            --HealBot_AddDebug("HealBot_UnitRange[unit]==-2 unit="..unit)
            xGUID=HealBot_UnitGUID(unit)
            if xGUID then
                HealBot_Action_RefreshButton(button, xGUID)
            elseif unit==button.guid then
                HealBot_Action_RefreshButton(button, button.guid)
            end
        elseif uRange~=HealBot_UnitRange[unit] then
            ebubar = HealBot_Unit_Bar1[unit]
            ebubar.txt=_G[ebubar:GetName().."_text"];
            ebuicon15 = _G[ebubar:GetName().."Icon15"];
            HealBot_UnitRange[unit]=uRange
            if uRange==1 and not HealBot_PlayerDead then
                ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin])
                ebubar.txt:SetTextColor(HealBot_UnitRangeitr[unit],HealBot_UnitRangeitg[unit],HealBot_UnitRangeitb[unit],Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    ebuicon15:SetAlpha(Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
                end
                if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
                    HealBot_UnitRangeb3a[unit]=Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]
                    HealBot_Action_SetBar3Value(HealBot_Unit_Button[unit]);
                end
                if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Action_ShowPanel() end
            elseif uRange==0 then
                --ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin])
                ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],HealBot_UnitRangea[unit])
                ebubar.txt:SetTextColor(HealBot_UnitRangeitr[unit],HealBot_UnitRangeitg[unit],HealBot_UnitRangeitb[unit],HealBot_UnitRangeota[unit]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    ebuicon15:SetAlpha(HealBot_UnitRangea[unit]);
                end
                if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
                    HealBot_UnitRangeb3a[unit]=HealBot_UnitRangea[unit]
                    HealBot_Action_SetBar3Value(HealBot_Unit_Button[unit]);
                end
            else
                ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin])
                ebubar.txt:SetTextColor(HealBot_UnitRangeotr[unit],HealBot_UnitRangeotg[unit],HealBot_UnitRangeotb[unit],Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Current_Skin]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    ebuicon15:SetAlpha(Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
                end
                if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
                    HealBot_UnitRangeb3a[unit]=Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]
                    HealBot_Action_SetBar3Value(HealBot_Unit_Button[unit]);
                end
            end
        end
    end
end

function HealBot_Action_CheckReserved()
    for xUnit,_ in pairs(HealBot_Reserved) do
        if HealBot_UnitGUID(xUnit) then
            HealBot_UnitNameUpdate(xUnit,HealBot_UnitGUID(xUnit))
            HealBot_Reserved[xUnit]=nil
        end
    end
end

function HealBot_Action_ShowPanel()
    if HealBot_Config.ActionVisible==0 and HealBot_Config.DisabledNow==0 then
        HealBot_Config.ActionVisible=1
        ShowUIPanel(HealBot_Action)
    end
end

function HealBot_Action_ResetUnitStatus(unit)
    if unit then
        HealBot_UnitStatus[unit]=1;
        HealBot_UnitRange[unit]=-2
    else
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitStatus[xUnit]=1;
            HealBot_UnitRange[xUnit]=-2
        end
    end
end

function HealBot_Action_ResetActiveUnitStatus()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if HealBot_UnitStatus[xUnit]>0 or UnitHealth(xUnit)<2 then
            HealBot_UnitRange[xUnit]=-2
        end
    end
end

local shb=nil
local shbar=nil

function HealBot_Action_clearResetBarSkinDone()
    for x,_ in pairs(HealBot_ResetBarSkinDone) do
        HealBot_ResetBarSkinDone[x]=nil;
    end
end

function HealBot_Action_SetHealButton(index,unit,hbGUID)
    if hbGUID then
        if not HealBot_Unit_Button[unit] then
            if not HealBot_ButtonStore[1] then
                return nil
            else
                shb=HealBot_ButtonStore[1]
                table.remove(HealBot_ButtonStore,1)
                HealBot_Unit_Button[unit]="init"
            end
        else
            shb=HealBot_Unit_Button[unit]
        end
        if not HealBot_UnitSpec[hbGUID] then
            HealBot_UnitID[hbGUID]="init"
            HealBot_Unit_Button[unit]="init"
            HealBot_UnitSpec[hbGUID] = " "
            HealBot_UnitTime[hbGUID]=GetTime()
            HealBot_CheckPlayerMana(hbGUID, unit)
        end
        if HealBot_UnitID[hbGUID]~=unit then
            HealBot_UnitID[hbGUID]=unit
            HealBot_CheckAllBuffs(hbGUID)
            HealBot_CheckAllDebuffs(hbGUID)
            HealBot_Unit_Button[unit]="init"
            HealBot_GUID[unit]=hbGUID
        end
        if HealBot_Unit_Button[unit]~=shb or not shb.guid then
            shb.unit=unit
            shb.guid=hbGUID
            shb:SetAttribute("unit", unit);
            HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            HealBot_Unit_Button[unit]=shb
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
            HealBot_Unit_Bar1[unit]=HealBot_Action_HealthBar(shb)
            HealBot_Unit_Bar2[unit]=HealBot_Action_HealthBar2(shb)
            HealBot_Unit_Bar3[unit]=HealBot_Action_HealthBar3(shb)
            HealBot_Unit_Bar4[unit]=HealBot_Action_HealthBar4(shb)
            HealBot_Unit_Bar5[unit]=HealBot_Action_HealthBar5(shb)
            HealBot_UnitRangeSpell[unit]=HealBot_hSpell
            HealBot_Enabled[hbGUID]=false
            HealBot_CheckHealth(hbGUID)
            shb:Show()
        elseif hbGUID~=shb.guid then
            shb.guid=hbGUID
            HealBot_CheckHealth(hbGUID)
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
        end
        if not HealBot_ResetBarSkinDone[shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end
    else
        return nil
    end
    return shb
end

function HealBot_Action_SetTargetHealButton(unit,hbGUID)
    if hbGUID then
        shb=_G["HealBot_Action_HealUnit56"];
        if not HealBot_UnitSpec[hbGUID] then
            HealBot_Unit_Button[unit]="init"
            HealBot_UnitSpec[hbGUID] = " "
            HealBot_UnitTime[hbGUID]=GetTime()
        end
        if HealBot_Unit_Button[unit]~=shb or not shb.guid then
            shb.unit=unit
            shb.guid=hbGUID
            shb:SetAttribute("unit", unit);
            HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            HealBot_Unit_Button[unit]=shb
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
            HealBot_Unit_Bar1[unit]=HealBot_Action_HealthBar(shb)
            HealBot_Unit_Bar2[unit]=HealBot_Action_HealthBar2(shb)
            HealBot_Unit_Bar3[unit]=HealBot_Action_HealthBar3(shb)
            HealBot_Unit_Bar4[unit]=HealBot_Action_HealthBar4(shb)
            HealBot_Unit_Bar5[unit]=HealBot_Action_HealthBar5(shb)
            HealBot_CheckHealth(hbGUID)
            HealBot_UnitRangeSpell[unit]=HealBot_hSpell
        elseif hbGUID~=shb.guid then
            shb.guid=hbGUID
            HealBot_CheckHealth(hbGUID)
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
        end
        if not HealBot_ResetBarSkinDone[shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end 
        if not HealBot_UnitID[hbGUID] then
            HealBot_UnitID[hbGUID]=unit
            HealBot_CheckAllBuffs(hbGUID)
            HealBot_CheckAllDebuffs(hbGUID)
        end
        HealBot_GUID[unit]=hbGUID
        shb:Show()
    else
        return nil
    end
    return shb
end

function HealBot_Action_SetTestButton(index)
    shb=nil
    if HealBot_ButtonStore[1] then
        shb=HealBot_ButtonStore[1]
        table.remove(HealBot_ButtonStore,1)
        shb.unit=HEALBOT_WORD_TEST.." "..index
      --  shb.guid=index
    end
    if shb and not HealBot_ResetBarSkinDone[shb.id] then
        HealBot_Action_ResetSkin("bar",shb)
    end 
    return shb
end

local HealBotButtonMacroAttribs={}
function HealBot_Action_SetAllAttribs()
 --   HealBot_AddDebug("In HealBot_Action_SetAllAttribs")
    HealBot_ResetAttribs=true
    Delay_RecalcParty=1
end

local HB_button,HB_prefix=nil
local HB_combo_prefix=nil
local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl"}
local hbAttribsMinReset = {}
function HealBot_Action_SetAllButtonAttribs(button,status)
    for x=1,15 do
  --      HB_button=HealBot_Options_ComboClass_Button(x) ' Cannot use this as 2 returns Middle and 3 returns Right, this function is older than Blizzards secure templates.
        if x==1 then 
            HB_button="Left";
        elseif x==2 then 
            HB_button="Right";
        elseif x==3 then 
            HB_button="Middle";
        elseif x==4 then 
            HB_button="Button4";
        elseif x==5 then 
            HB_button="Button5";
        elseif x==6 then 
            HB_button="Button6";
        elseif x==7 then 
            HB_button="Button7";
        elseif x==8 then 
            HB_button="Button8";
        elseif x==9 then 
            HB_button="Button9";
        elseif x==10 then 
            HB_button="Button10";
        elseif x==11 then
            HB_button="Button11";
        elseif x==12 then
            HB_button="Button12";
        elseif x==13 then
            HB_button="Button13";
        elseif x==14 then
            HB_button="Button14";
        elseif x==15 then
            HB_button="Button15";
        end
    
        for y=1, getn(HealBot_Keys_List), 1 do
            if strlen(HealBot_Keys_List[y])>1 then
                HB_prefix = strlower(HealBot_Keys_List[y]).."-"
            else
                HB_prefix = "";
            end
            if not hbAttribsMinReset[button.id..HB_prefix..status..x] then
                HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],status,x)
            end
        end
    end
end

--local mUnit=nil
local mText=nil
local showmenu=nil
local showHBmenu=nil
local setDropdown=nil
local partyNo=nil
local sTar, sTrin1, sTrin2=0, 0, 0
local curGUID=nil
function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,status,j)
 
    if strlen(bkey)>1 then
        HB_prefix = strlower(bkey).."-"
    else
        HB_prefix = "";
    end
    
    HB_combo_prefix = bkey..bbutton..HealBot_Config.CurrentSpec;
    if status=="Enabled" then
        sName, sTar, sTrin1, sTrin2 = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    elseif status=="Disabled" then
        sName, sTar, sTrin1, sTrin2 = HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    else
        sName=nil;
    end
    if sName then
        hbAttribsMinReset[button.id..HB_prefix..status..j]=false
        local mId=GetMacroIndexByName(sName)
        if strlower(sName)==strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_FOCUS) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strsub(strlower(sName),1,4)==strlower(HEALBOT_TELL) then
            mText='/script local n=UnitName("hbtarget");SendChatMessage("hbMSG","WHISPER",nil,n)'
            mText=string.gsub(mText,"hbtarget",button.unit)
            mText=string.gsub(mText,"hbMSG", strtrim(strsub(sName,5)))
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showmenu")
            showmenu = function()
                if button.unit=="player" then
                    setDropdown=PlayerFrameDropDown
                elseif button.unit=="target" then
                    setDropdown=TargetFrameDropDown
                elseif button.unit=="pet" then
                    setDropdown=PetFrameDropDown
                else
                    xUnit=HealBot_Action_UnitID(button.unit)
                    partyNo = tonumber(xUnit:match('party(%d+)')) or 0
                    if partyNo > 0 then
                        setDropdown = _G['PartyMemberFrame' .. partyNo .. 'DropDown']
                    else
                        partyNo = tonumber(xUnit:match('raid(%d+)')) or 0
                        if partyNo == 0 then
                            partyNo=button.id
                        end
                        FriendsDropDown.name = UnitName(xUnit);    
                        FriendsDropDown.id = partyNo;    
                        FriendsDropDown.unit = xUnit;    
                        FriendsDropDown.initialize = RaidFrameDropDown_Initialize;    
                        FriendsDropDown.displayMode = "MENU";    
                        setDropdown=FriendsDropDown
                    end
                end
                ToggleDropDownMenu(1, nil, setDropdown, "cursor", 10, -8)  
            end
            button.showmenu = showmenu 
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) and HealBot_UnitGUID(button.unit) then
            curGUID=HealBot_UnitGUID(button.unit)
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu = function()
                local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                HBFriendsDropDown.unit = button.unit
                HBFriendsDropDown.name = UnitName(button.unit)
                HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
                HBFriendsDropDown.displayMode = "MENU"
                ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
            end
            button.showhbmenu = showHBmenu
        elseif strlower(sName)==strlower(HEALBOT_MAINTANK) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "maintank")
            button:SetAttribute(HB_prefix.."type-maintank"..j, "toggle")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_MAINASSIST) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "mainassist")
            button:SetAttribute(HB_prefix.."type-mainassist"..j, "toggle")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif HealBot_GetSpellId(sName) then
            if sTar==1 or sTrin1==1 or sTrin2==1 then
                mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, button.unit, HB_combo_prefix)
                button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix.."helpbutton"..j, "heal"..j);
                button:SetAttribute(HB_prefix.."type-heal"..j, "spell");
                button:SetAttribute(HB_prefix.."spell-heal"..j, sName);
                hbAttribsMinReset[button.id..HB_prefix..status..j]=true
            end
        elseif mId ~= 0 then
            _,_,mText=GetMacroInfo(mId)
 --        mUnit = button.unit
            if UnitExists(HealBot_UnitPet(button.unit)) then
                mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(button.unit))
            end
            mText=string.gsub(mText,"hbtargettargettarget",button.unit.."targettarget")
            mText=string.gsub(mText,"hbtargettarget",button.unit.."target")
            mText=string.gsub(mText,"hbtarget",button.unit)
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j,"macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            if status=="Enabled" then
                HealBotButtonMacroAttribs[HB_prefix..j]=sName
            end
        elseif IsUsableItem(sName) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "item"..j);
            button:SetAttribute(HB_prefix.."type-item"..j, "item");
            button:SetAttribute(HB_prefix.."item-item"..j, sName);
        else
            if sTar==1 or sTrin1==1 or sTrin2==1 then
                mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, button.unit, HB_combo_prefix)
                button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix.."helpbutton"..j, "heal"..j);
                button:SetAttribute(HB_prefix.."type-heal"..j, "spell");
                button:SetAttribute(HB_prefix.."spell-heal"..j, sName);
                hbAttribsMinReset[button.id..HB_prefix..status..j]=true
            end
        end
        button:SetAttribute(HB_prefix.."checkselfcast"..j, "false")
    else
        button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
    end
end

function HealBot_Action_SethbFocusButtonAttrib(button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

local smName={}
local sysSoundSFX = strsub(GetCVar("Sound_EnableSFX") or "nil",1,1)

function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, unit, combo)
    if not smName[combo..unit] then
        smName[combo..unit]=""
        if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 0;\n" end
        if HealBot_Globals.MacroSuppressError==1 then smName[combo..unit]=smName[combo..unit].."/script UIErrorsFrame:Hide();\n" end
        if spellTar==1 then smName[combo..unit]=smName[combo..unit].."/target "..unit..";\n" end
        if spellTrin1==1 then smName[combo..unit]=smName[combo..unit].."/use 13;\n" end
        if spellTrin2==1 then smName[combo..unit]=smName[combo..unit].."/use 14;\n" end
        if HealBot_Config.MacroUse10==1 then smName[combo..unit]=smName[combo..unit].."/use 10;\n" end
        if HealBot_Globals.MacroSuppressError==1 then smName[combo..unit]=smName[combo..unit].."/script UIErrorsFrame:Clear(); UIErrorsFrame:Show();\n" end
        if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 1;\n" end
        smName[combo..unit]=smName[combo..unit].."/cast [@"..unit.."] "..spellName..";"
        if strlen(smName[combo..unit])>255 then
            smName[combo..unit]=""
            if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 0;\n" end
            if spellTar==1 then smName[combo..unit]=smName[combo..unit].."/target "..UnitName(unit)..";\n" end
            if spellTrin1==1 then smName[combo..unit]=smName[combo..unit].."/use 13;\n" end
            if spellTrin2==1 then smName[combo..unit]=smName[combo..unit].."/use 14;\n" end
            if HealBot_Config.MacroUse10==1 then smName[combo..unit]=smName[combo..unit].."/use 10;\n" end
            if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 1;\n" end
            smName[combo..unit]=smName[combo..unit].."/cast [@"..unit.."] "..spellName..";"
            if strlen(smName[combo..unit])>255 then
                smName[combo..unit]=""
                if spellTar==1 then smName[combo..unit]=smName[combo..unit].."/target "..UnitName(unit)..";\n" end
                if spellTrin1==1 then smName[combo..unit]=smName[combo..unit].."/use 13;\n" end
                if spellTrin2==1 then smName[combo..unit]=smName[combo..unit].."/use 14;\n" end
                if HealBot_Config.MacroUse10==1 then smName[combo..unit]=smName[combo..unit].."/use 10;\n" end
                smName[combo..unit]=smName[combo..unit].."/cast [@"..unit.."] "..spellName..";"
                if strlen(smName[combo..unit])>255 then
                    smName[combo..unit]=spellName
                end
            end
        end
    end
    return smName[combo..unit]
end

function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level)
    local info
    level = level or 1;
    if level==1 then
 
        info = UIDropDownMenu_CreateInfo();
        info.isTitle = 1
        info.text = self.name
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Action_RetMyTarget(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_SKIN_DISTEXT;
        else
            info.text = HEALBOT_SKIN_ENTEXT;
        end
        info.func = function() HealBot_Action_Toggle_Enabled(HealBot_UnitGUID(self.unit)); end
        UIDropDownMenu_AddButton(info, 1);

        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_TARGETHEALS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_TARGETHEALS
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(HealBot_UnitGUID(self.unit)); end;
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(HealBot_UnitGUID(self.unit)); end;
        UIDropDownMenu_AddButton(info, 1);

        info = UIDropDownMenu_CreateInfo();
        info.notCheckable = true;
        if HealBot_retHbFocus(self.name) then
            info.text = HEALBOT_WORD_CLEAR.." "..HEALBOT_WORD_HBFOCUS;
            info.hasArrow = false;
            info.func = function() HealBot_ToggelFocusMonitor(self.name); end;
        else
            info.text = HEALBOT_WORD_SET.." "..HEALBOT_WORD_HBFOCUS
            info.hasArrow = true; 
        end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_RESET
        info.func = function() HealBot_Reset_Unit(HealBot_UnitGUID(self.unit)); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_PANEL_BLACKLIST
        info.func = function() HealBot_Panel_AddBlackList(HealBot_UnitGUID(self.unit)); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_CANCEL
        UIDropDownMenu_AddButton(info, 1);
    end
    if level==2 then
        info = UIDropDownMenu_CreateInfo();
        _,z = IsInInstance()
        info.text = HEALBOT_WORD_ALLZONE
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.name, "all"); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        _,z = IsInInstance()
        if z=="pvp" or z == "arena" then 
            z = "bg"
            info.text = HEALBOT_WORD_BATTLEGROUND
        elseif z~="none" then
            z = GetRealZoneText()
            info.text=z
        else
            info.text = HEALBOT_WORD_OUTSIDE
        end
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.name, z); end;
        UIDropDownMenu_AddButton(info, 2);
    end
end

function HealBot_Action_UnitID(unit)
    if strsub(unit,1,4)=="raid" then
        if UnitIsUnit(unit,"party1") then
            unit="party1"
        elseif UnitIsUnit(unit,"party2") then
            unit="party2"
        elseif UnitIsUnit(unit,"party3") then
            unit="party3"
        elseif UnitIsUnit(unit,"party4") then
            unit="party4"
        end
    end
    return unit
end

local hbCombos, hbTarget, hbTrinket1, hbTrinket2=nil, nil, nil, nil
function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    hbCombos = HealBot_Config.EnabledKeyCombo
    hbTarget = HealBot_Config.EnabledSpellTarget
    hbTrinket1 = HealBot_Config.EnabledSpellTrinket1
    hbTrinket2 = HealBot_Config.EnabledSpellTrinket2
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or 0, hbTrinket1[HB_combo_prefix] or 0, hbTrinket2[HB_combo_prefix] or 0
end

function HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    hbCombos = HealBot_Config.DisabledKeyCombo
    hbTarget = HealBot_Config.DisabledSpellTarget
    hbTrinket1 = HealBot_Config.DisabledSpellTrinket1
    hbTrinket2 = HealBot_Config.DisabledSpellTrinket2
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or 0, hbTrinket1[HB_combo_prefix] or 0, hbTrinket2[HB_combo_prefix] or 0
end

local hbInitButtons=false
function HealBot_Action_ResethbInitButtons()
    hbInitButtons=false
end

local uCnt=0
function HealBot_Action_PartyChanged(HealBot_PreCombat, disableHealBot)
    if HealBot_Config.DisabledNow==1 and not disableHealBot then return end
    if InCombatLockdown() then 
        HealBot_IsFighting=true
    elseif HealBot_IsFighting then 
        HealBot_PreCombat=true
        HealBot_IsFighting=nil
    end
    if not HealBot_IsFighting and HealBot_PlayerGUID then
        if HealBot_FrameMoving and HealBot_PreCombat then
            HealBot_Action_OnDragStop(self)
        elseif HealBot_FrameMoving then
            Delay_RecalcParty=1
            return
        end
  
        if not HealBot_PreCombat and HealBot_ResetAttribs then
            for j=1,56 do
                b=_G["HealBot_Action_HealUnit"..j]
                b.guid=nil
            end
            for x,_ in pairs(HealBot_UnitID) do
                HealBot_UnitID[x]=nil;
            end
            for x,_ in pairs(HealBotButtonMacroAttribs) do
                HealBotButtonMacroAttribs[x]=nil;
            end
            for x,_ in pairs(smName) do
                smName[x]=nil;
            end
            for x,_ in pairs(hbAttribsMinReset) do
                hbAttribsMinReset[x]=nil;
            end
            HealBot_ResetAttribs=nil
        end

        if not hbInitButtons then
            for x,_ in pairs(HealBot_ButtonStore) do
                HealBot_ButtonStore[x]=nil;
            end
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                HealBot_Unit_Button[xUnit]=nil
            end 
            for x=1,55 do
                b=_G["HealBot_Action_HealUnit"..x];
                HealBot_Action_InsButtonStore(b)
                b.id=x
            end
            b=_G["HealBot_Action_HealUnit56"]
            b.id=56
            hbInitButtons=true
        end
        
        if HealBot_PreCombat then 
            HealBot_EnteringCombat()
        end
  
        if Healbot_Config_Skins.ShowHeader[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Panel_PartyChanged(true, disableHealBot)
        else
            HealBot_Panel_PartyChanged(false, disableHealBot)
        end
        uCnt=0
        HealBot_ButtonArray=1
        for x,_ in pairs(HealBot_ButtonArray1) do
            HealBot_ButtonArray1[x]=nil;
        end
        for x,_ in pairs(HealBot_ButtonArray2) do
            HealBot_ButtonArray2[x]=nil;
        end
    
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            uCnt=uCnt+1
            if HealBot_ButtonArray==1 then
                HealBot_ButtonArray1[xUnit]=xButton
                if uCnt==1 then HealBot_ButtonArray2[xUnit]=xButton end
                HealBot_ButtonArray=2
            else
                HealBot_ButtonArray2[xUnit]=xButton
                HealBot_ButtonArray=1
            end
            if HealBot_UnitStatus[xUnit]==9 then
                HealBot_Action_ResetUnitStatus(xUnit)
            end
        end
    elseif Delay_RecalcParty<2 then 
        Delay_RecalcParty=2; 
    end
end

function HealBot_Action_InsButtonStore(b)
    if not HealBot_ButtonStore[b] then
        table.insert(HealBot_ButtonStore,b)
        HealBot_HoT_RemoveIconButton(b,true)
        if b.guid then 
            if HealBot_AggroBar4[b.guid] then
                barName=HealBot_AggroBar4[b.guid]
                barName:SetStatusBarColor(1,0,0,0)
                HealBot_AggroBar4[b.guid]=nil
            end
            b.guid=nil
        end
        b:Hide();
        HealBot_Panel_SetBarArrays(b)
    end
end

function HealBot_Action_retButtonStoreCnt()
    return getn(HealBot_ButtonStore)
end

function HealBot_Action_Reset()
    Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]=0
    Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()/2
    Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()/2
    HealBot_Action_setPoint()
    HealBot_Action:Show()
    HealBot_Action_unlockFrame()
end

function HealBot_Action_unlockFrame()
    Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin]=0
    HealBot_Options_ActionLocked:SetChecked(Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin])
end

function HealBot_Action_setPoint()
    if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==5 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("TOP","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==6 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("LEFT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==7 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("RIGHT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==8 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("BOTTOM","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    end
end

local hbClassCols = {
          ["DRUI"] = {r=1.0,  g=0.49, b=0.04, },
          ["HUNT"] = {r=0.67, g=0.83, b=0.45, },
          ["MAGE"] = {r=0.41, g=0.8,  b=0.94, },
          ["MONK"] = {r=0.0,  g=1.0,  b=0.59, },
          ["PALA"] = {r=0.96, g=0.55, b=0.73, },
          ["PRIE"] = {r=1.0,  g=1.0,  b=1.0,  },
          ["ROGU"] = {r=1.0,  g=0.96, b=0.41, },
          ["SHAM"] = {r=0.14, g=0.35, b=1.0,  },
          ["WARL"] = {r=0.58, g=0.51, b=0.79, },
          ["DEAT"] = {r=0.78, g=0.04, b=0.04, },
          ["WARR"] = {r=0.78, g=0.61, b=0.43, },
      }
      
function HealBot_Action_ClassColour(hbGUID, unit)
    class=nil
    if unit and UnitClass(unit) then
        _,class=UnitClass(unit)
    elseif hbGUID and HealBot_UnitID[hbGUID] and UnitClass(HealBot_UnitID[hbGUID]) then
        _,class=UnitClass(HealBot_UnitID[hbGUID])        
    end
    if class then
        class = strsub(class,1,4)
    else
        class = "WARR"
    end
    return hbClassCols[class].r, hbClassCols[class].g, hbClassCols[class].b
end

function HealBot_Action_ShowTooltip(unit)
    if HealBot_Globals.ShowTooltip==0 then return end
    HealBot_Action_TooltipUnit = unit;
    HealBot_Action_DisableTooltipUnit = nil;
    HealBot_Action_RefreshTooltip(unit,"Enabled");
end

function HealBot_Action_ShowDisabledTooltip(unit)
    if HealBot_Globals.ShowTooltip==0 then return end
    HealBot_Action_TooltipUnit = nil;
    HealBot_Action_DisableTooltipUnit = unit;
    HealBot_Action_RefreshTooltip(unit,"Disabled");
end

function HealBot_Action_HideTooltip(self)
    HealBot_Action_TooltipUnit = nil;
    HealBot_Action_DisableTooltipUnit = nil;
    HealBot_Action_HideTooltipFrame()
    HealBot_InspectUnit=false
end

function HealBot_Action_HideTooltipFrame()
    if HealBot_Globals.UseGameTooltip==1 then
        GameTooltip:Hide();
    else
        HealBot_Tooltip:Hide();
    end
end

function HealBot_Action_Refresh(hbGUID)
    if HealBot_PlayerDead then
        if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Config.ActionVisible~=0 and not HealBot_IsFighting then
            HideUIPanel(HealBot_Action); 
        else
            HealBot_Action_RefreshButtons(hbGUID);
        end
        return;
    end
    HealBot_Action_RefreshButtons(hbGUID);
    if not HealBot_IsFighting then
        if HealBot_Config.ActionVisible==0 and HealBot_Config.DisabledNow==0 then
            if HealBot_Action_ShouldHealSome(hbGUID) then
                ShowUIPanel(HealBot_Action)
            end
        elseif Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 then 
            if not HealBot_Action_ShouldHealSome(hbGUID) then
                HideUIPanel(HealBot_Action);
            end
        end
    end
end

function HealBot_Action_SpellPattern(button,state)
    if state and state=="Disabled" then
        hbCombos = HealBot_Config.DisabledKeyCombo
    else
        hbCombos = HealBot_Config.EnabledKeyCombo
    end
    if not hbCombos then return nil end
    x = button;
    if IsShiftKeyDown() then 
        if IsAltKeyDown() then 
            x = "Alt-Shift"..x
        elseif IsControlKeyDown() then 
            x = "Ctrl-Shift"..x
        else
            x = "Shift"..x
        end
    elseif IsAltKeyDown() then 
        if IsControlKeyDown() then 
             x = "Alt-Ctrl"..x
        else
            x = "Alt"..x
        end
    elseif IsControlKeyDown() then 
        x = "Ctrl"..x 
    end
    x=x..HealBot_Config.CurrentSpec
    return hbCombos[x]
end

function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    xGUID=HealBot_UnitGUID(self.unit)
    HealBot_curGUID=xGUID
    if HealBot_IsFighting then
        if HealBot_Globals.DisableToolTipInCombat==0 then
            HealBot_Action_ShowTooltip(self.unit);
        else
            HealBot_Action_TooltipUnit = self.unit
        end
    elseif UnitAffectingCombat(self.unit)==1 then
        HealBot_Action_ShowTooltip(self.unit);
    elseif HealBot_Enabled[xGUID] or HealBot_Config.EnableHealthy==1 then 
        HealBot_Action_ShowTooltip(self.unit);
    else
        if not HealBot_PlayerDead then
            HealBot_Action_ShowDisabledTooltip(self.unit);
        end
    end
    if Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 and not UnitIsDeadOrGhost(self.unit) and HealBot_retHighlightTarget()~=self.unit then
        z=false
        if HealBot_IsFighting then
            if Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Current_Skin]==1 then z=true end
        else
            z=true
        end
        if z then
            HealBot_Action_UpdateAggro(self.unit,"highlight",HealBot_UnitThreat[xGUID] or 0,xGUID, HealBot_UnitThreatPct[xGUID])
        end
    end
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELUP", "HealBot_Action_HealUnit"..self.id,"Button4");
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELDOWN", "HealBot_Action_HealUnit"..self.id,"Button5");
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    xGUID=HealBot_UnitGUID(self.unit)
    if Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Hightlight[xGUID] and HealBot_Hightlight[xGUID]=="M" then
        if HealBot_Aggro[xGUID] and HealBot_Aggro[xGUID]=="h" then
            HealBot_Action_UpdateAggro(self.unit,"off",HealBot_UnitThreat[xGUID] or 0,xGUID)
        end
    end
    HealBot_curGUID=nil
   -- ClearOverrideBindings(HealBot_Action)
end

local HealBot_MouseWheelCmd=nil

function HealBot_Action_HealUnit_Wheel(delta)
    if not HealBot_curGUID then return end
    xUnit=HealBot_UnitID[HealBot_curGUID] or "none"
    if not UnitExists(xUnit) then return end
    
    y="None"
    if IsShiftKeyDown() then
        if not IsControlKeyDown() and not IsAltKeyDown() then 
            y="Shift" 
        else
            y=""
        end
    elseif IsControlKeyDown() then
        if not IsShiftKeyDown() and not IsAltKeyDown() then 
            y="Ctrl" 
        else
            y=""
        end

    elseif IsAltKeyDown() then
        if not IsControlKeyDown() and not IsShiftKeyDown() then 
            y="Alt" 
        else
            y=""
        end
    end    
    if delta>0 then
        y=y.."Up"
    else
        y=y.."Down"
    end
    if HealBot_Globals.HealBot_MouseWheelTxt[y] then
        HealBot_MouseWheelCmd=HealBot_Globals.HealBot_MouseWheelTxt[y]
    else
        HealBot_MouseWheelCmd=HEALBOT_WORDS_NONE
    end
    
    if HealBot_MouseWheelCmd==HEALBOT_BLIZZARD_MENU then
        if xUnit=="player" then
            setDropdown=PlayerFrameDropDown
        elseif xUnit=="target" then
            setDropdown=TargetFrameDropDown
        elseif xUnit=="pet" then
            setDropdown=PetFrameDropDown
        else
            partyNo = tonumber(xUnit:match('party(%d+)')) or 0
            if partyNo > 0 then
                setDropdown = _G['PartyMemberFrame' .. partyNo .. 'DropDown']
            else
                partyNo = tonumber(strmatch(xUnit, "(%d+)"))
                FriendsDropDown.name = UnitName(xUnit);    
                FriendsDropDown.id = partyNo;    
                FriendsDropDown.unit = xUnit;    
                FriendsDropDown.initialize = RaidFrameDropDown_Initialize;    
                FriendsDropDown.displayMode = "MENU";    
                setDropdown=FriendsDropDown
            end
        end
        ToggleDropDownMenu(1, nil, setDropdown, "cursor", 10, -8)  
    elseif HealBot_MouseWheelCmd==HEALBOT_HB_MENU then
        local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
        HBFriendsDropDown.unit = xUnit
        HBFriendsDropDown.name = UnitName(xUnit)
        HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
        HBFriendsDropDown.displayMode = "MENU"
        ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
    elseif HealBot_MouseWheelCmd==HEALBOT_FOLLOW then
        FollowUnit(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TRADE then
        InitiateTrade(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_PROMOTE_RA then
        PromoteToAssistant(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_DEMOTE_RA then
        DemoteAssistant(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_ENABLED then
        HealBot_Action_Toggle_Enabled(HealBot_curGUID)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_MYTARGETS then
        HealBot_Panel_ToggelHealTarget(HealBot_curGUID)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_PRIVATETANKS then
        HealBot_Panel_ToggelPrivateTanks(HealBot_curGUID)
    elseif HealBot_MouseWheelCmd==HEALBOT_RESET_BAR then
        HealBot_Reset_Unit(HealBot_curGUID)
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMMOUNT and UnitIsUnit(xUnit,"player") and not UnitAffectingCombat("player") then
        HealBot_Action_ToggelMount("all")
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMGOUNDMOUNT and UnitIsUnit(xUnit,"player") and not UnitAffectingCombat("player") then
        HealBot_Action_ToggelMount("ground")
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMPET and UnitIsUnit(xUnit,"player") then
        HealBot_Action_RandomPet()   
    end

end

function HealBot_Action_OptionsButton_OnLoad(self)
    HealBot_Action_OptionsButtonBar:SetMinMaxValues(0,100);
    HealBot_Action_OptionsButtonBar:SetValue(0);
end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options);
end

function HealBot_Action_hbFocusButton_OnLoad(self)
    HealBot_Action_hbFocusButtonBar:SetMinMaxValues(0,100);
    HealBot_Action_hbFocusButtonBar:SetValue(100);
    HealBot_Action_SethbFocusButtonAttrib(_G["HealBot_Action_hbFocusButton"])
    b=_G["HealBot_Action_hbFocusButton"]
    b.id=999
    HealBot_Action_OnLoad(self)
end

function HealBot_Action_OnLoad(self)
    self:SetScript("PreClick", HealBot_Action_PreClick); 
    self:SetScript("PostClick", HealBot_Action_PostClick)
end

function HealBot_Action_setRegisterForClicks()
    if HealBot_Config.ButtonCastMethod==1 then
        for x=1,56 do
            b=_G["HealBot_Action_HealUnit"..x];
            b:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                               "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
         end
         HealBot_Action_hbFocusButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
    else
        for x=1,56 do
            b=_G["HealBot_Action_HealUnit"..x];
            b:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
        end
        HealBot_Action_hbFocusButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    end
end

local HealBot_Action_Timer1,HealBot_Action_Timer2 = -2,-2

function HealBot_Action_Set_Timers(override)
    if HealBot_Panel_retTestBars() then
        HB_Action_Timer1 = 0.02
    else
        if HealBot_Config.DisabledNow==0 and Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Current_Skin]==1 then
            if not override then
                HB_Action_Timer1 = 0.02
            else
                HB_Action_Timer1 = 0.5
            end
        else
            HB_Action_Timer1 = 5
        end
    end
    if HealBot_Config.DisabledNow==0 and ((Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1) or 
                                             (Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 or Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==1)) then
        if not override then
            HB_Action_Timer2 = Healbot_Config_Skins.AggroBarsFreq[Healbot_Config_Skins.Current_Skin]
        else
            HB_Action_Timer2 = 0.5
        end
    else
        HB_Action_Timer2 = 2
    end
end

local HealBot_AggroBarColr = {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroBarColg = {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroBarColb = {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroUnitThreat=1
local HealBot_HasAggro=false

function HealBot_Action_SetDebuffAggroCols()
    HealBot_AggroBarColr[5]=HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].R
    HealBot_AggroBarColg[5]=HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].G
    HealBot_AggroBarColb[5]=HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].B 
    HealBot_AggroBarColr[6]=HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].R
    HealBot_AggroBarColg[6]=HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].G
    HealBot_AggroBarColb[6]=HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].B 
    HealBot_AggroBarColr[7]=HealBot_Config.CDCBarColour[HEALBOT_POISON_en].R
    HealBot_AggroBarColg[7]=HealBot_Config.CDCBarColour[HEALBOT_POISON_en].G
    HealBot_AggroBarColb[7]=HealBot_Config.CDCBarColour[HEALBOT_POISON_en].B 
    HealBot_AggroBarColr[8]=HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].R
    HealBot_AggroBarColg[8]=HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].G
    HealBot_AggroBarColb[8]=HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].B 
    HealBot_AggroBarColr[9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en].R
    HealBot_AggroBarColg[9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en].G
    HealBot_AggroBarColb[9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en].B
end

function HealBot_Action_SetHightlightAggroCols()
    HealBot_AggroBarColr[-1]=Healbot_Config_Skins.highcolr[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[-1]=Healbot_Config_Skins.highcolg[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[-1]=Healbot_Config_Skins.highcolb[Healbot_Config_Skins.Current_Skin]
end

function HealBot_Action_SetHightlightTargetAggroCols()
    HealBot_AggroBarColr[-2]=Healbot_Config_Skins.targetcolr[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[-2]=Healbot_Config_Skins.targetcolg[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[-2]=Healbot_Config_Skins.targetcolb[Healbot_Config_Skins.Current_Skin]
end

function HealBot_Action_SetAggroCols()
    HealBot_AggroBarColr[2]=Healbot_Config_Skins.AggroColr[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[2]=Healbot_Config_Skins.AggroColg[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[2]=Healbot_Config_Skins.AggroColb[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColr[3]=Healbot_Config_Skins.AggroColr[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[3]=Healbot_Config_Skins.AggroColg[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[3]=Healbot_Config_Skins.AggroColb[Healbot_Config_Skins.Current_Skin]
end

function HealBot_Action_setTestBar(b)
    HealBot_UnitBarUpdate[b]=0
    HealBot_curUnitHealth[b]=100
end

local lTimer,eTimer=0,GetTime()
function HealBot_Action_OnUpdate(self)
    lTimer=GetTime()-eTimer
    eTimer=GetTime()
    HealBot_Action_Timer1 = HealBot_Action_Timer1+lTimer
    HealBot_Action_Timer2 = HealBot_Action_Timer2+lTimer
    if HealBot_Action_Timer1>HB_Action_Timer1 then
        HealBot_Action_Timer1 = 0
        for ebubar,value in pairs(HealBot_UnitBarUpdate) do 
            if value>HealBot_curUnitHealth[ebubar] then
                if value-Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]<=HealBot_curUnitHealth[ebubar] then
                    HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
                else
                    HealBot_UnitBarUpdate[ebubar]=value-Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]
                end
            elseif value+Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]>=HealBot_curUnitHealth[ebubar] then
                HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
            else
                HealBot_UnitBarUpdate[ebubar]=value+Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]
            end
            ebubar:SetValue(HealBot_UnitBarUpdate[ebubar])
            if HealBot_UnitBarUpdate[ebubar]==HealBot_curUnitHealth[ebubar] then
                HealBot_UnitBarUpdate[ebubar]=nil
            end
        end
    end
    if HealBot_Action_Timer2>HB_Action_Timer2 then
        HealBot_Action_Timer2 = 0
        for xGUID,bar4 in pairs(HealBot_AggroBar4) do
            HealBot_AggroUnitThreat=HealBot_UnitThreat[xGUID] or 2
            if HealBot_AggroUnitThreat==9 and HealBot_UnitDebuff[xGUID] and HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]] then
                bar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].R,
                                       HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].G,
                                       HealBot_Globals.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].B,HealBot_AggroBarA)
            else
                bar4:SetStatusBarColor(HealBot_AggroBarColr[HealBot_AggroUnitThreat],HealBot_AggroBarColg[HealBot_AggroUnitThreat],HealBot_AggroBarColb[HealBot_AggroUnitThreat],HealBot_AggroBarA)
            end
        end
        if HealBot_AggroBarAup then
            if HealBot_AggroBarA>=Healbot_Config_Skins.AggroBarsMaxAlpha[Healbot_Config_Skins.Current_Skin] then
                HealBot_AggroBarAup=false
                HealBot_AggroBarA=HealBot_AggroBarA-0.05
            else
                HealBot_AggroBarA=HealBot_AggroBarA+0.05
            end
        else
            if HealBot_AggroBarA<=Healbot_Config_Skins.AggroBarsMinAlpha[Healbot_Config_Skins.Current_Skin] then
                HealBot_AggroBarAup=true
                HealBot_AggroBarA=HealBot_AggroBarA+0.05
            else
                HealBot_AggroBarA=HealBot_AggroBarA-0.05
            end
        end
    end
end

function HealBot_Action_OnShow(self)
    if Healbot_Config_Skins.PanelSounds[Healbot_Config_Skins.Current_Skin]==1 then
        PlaySound("igAbilityOpen");
    end
    HealBot_Config.ActionVisible = 1
    HealBot_Action:SetBackdropColor(
    Healbot_Config_Skins.backcolr[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.backcolg[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.backcolb[Healbot_Config_Skins.Current_Skin], 
    Healbot_Config_Skins.backcola[Healbot_Config_Skins.Current_Skin]);
    HealBot_Action:SetBackdropBorderColor(
    Healbot_Config_Skins.borcolr[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.borcolg[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.borcolb[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.borcola[Healbot_Config_Skins.Current_Skin]);
end

function HealBot_Action_OnHide(self)
    HealBot_StopMoving(self,true);
    HealBot_Config.ActionVisible = 0
end

function HealBot_Action_OnMouseDown(self,button)
    if button=="LeftButton" then
        if Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin]==0 or (HealBot_Globals.ByPassLock==1 and IsControlKeyDown() and IsAltKeyDown()) then
            HealBot_FrameMoving=true
            HealBot_StartMoving(self);
        end
    end
end

function HealBot_Action_OnMouseUp(self,button)
    if button=="LeftButton" then
        HealBot_StopMoving(self,true);
        HealBot_FrameMoving=nil
    elseif button=="RightButton" and not HealBot_IsFighting and HealBot_Globals.RightButtonOptions~=0 then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_OnDragStart(self)
    if Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin]==0 then
        HealBot_FrameMoving=true
        HealBot_StartMoving(self);
    end
end

function HealBot_Action_OnDragStop(self)
 --   HealBot_StopMoving(self,true);
    HealBot_FrameMoving=nil
end

local usedSmartCast=nil
local ModKey=nil
local abutton=nil
local aj=nil
function HealBot_Action_PreClick(self,button)
    if self.id<100 then
        HealBot_UpdTargetUnitID(self.unit)
        xGUID=HealBot_UnitGUID(self.unit)
        usedSmartCast=false;
        ModKey=""
        if IsShiftKeyDown() then 
            if IsControlKeyDown() then 
                ModKey="Ctrl-Shift"
            elseif IsAltKeyDown() then 
                ModKey="Alt-Shift"
            else
                ModKey="Shift" 
            end
        elseif IsControlKeyDown() then 
            ModKey="Ctrl"
        elseif IsAltKeyDown() then 
            ModKey="Alt"
        end
        if button=="LeftButton" then 
            abutton="Left"
            aj=1
        elseif button=="RightButton" then 
            abutton="Right"
            aj=2
        elseif button=="MiddleButton" then 
            abutton="Middle"
            aj=3
        else
            abutton=button
            aj=tonumber(strmatch(button, "(%d+)"))
        end
        if self.unit=="target" and HealBot_Globals.TargetBarRestricted==1 then
            if button=="RightButton" then
                if HealBot_UnitID[xGUID] then
                    HealBot_Panel_ToggelHealTarget(xGUID)
                    if HealBot_Globals.ShowTooltip==1 then 
                        HealBot_Action_RefreshTargetTooltip(xGUID, self.unit) 
                    end
                end
            elseif button=="LeftButton" and HealBot_Globals.SmartCast==1 and not IsModifierKeyDown() then
                HealBot_Action_UseSmartCast(self,xGUID)
            end
        elseif IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown() and (button=="LeftButton" or button=="MiddleButton" or button=="RightButton") then
            if button=="LeftButton" then
                HealBot_Action_Toggle_Enabled(xGUID)
            elseif button=="RightButton" then
                HealBot_Panel_ToggelHealTarget(xGUID)
            elseif xGUID and xGUID~=HealBot_PlayerGUID and button=="MiddleButton" then
                HealBot_Panel_AddBlackList(xGUID)
            end
        elseif not HealBot_IsFighting then
            if UnitAffectingCombat(self.unit)==1 then 
                return
            end
            if HealBot_Globals.ProtectPvP==1 then
                if UnitIsPVP(self.unit) and not UnitIsPVP("player") then 
                    HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"nil",aj)
                    usedSmartCast=true;
                end
            end
            if button=="LeftButton" and HealBot_Globals.SmartCast==1 and not IsModifierKeyDown() then
                HealBot_Action_UseSmartCast(self,xGUID)
            end
            if not HealBot_Enabled[xGUID] and HealBot_Config.EnableHealthy==0 and not usedSmartCast then
                HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Disabled",aj)
                usedSmartCast=true;
            end
        end
    end
end

function HealBot_Action_Toggle_Enabled(hbGUID)
    if HealBot_MyTargets[hbGUID] then
        HealBot_MyTargets[hbGUID]=nil
    else
        HealBot_MyTargets[hbGUID]=true
    end
    if HealBot_UnitID[hbGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID]) end
end

function HealBot_Action_UseSmartCast(bp,hbGUID)
    sName=HealBot_Action_SmartCast(hbGUID);
    if sName then
        sID=HealBot_GetSpellId(sName)
        if sID then
            if HealBot_UnitInRange(sName, bp.unit)==1 or hbGUID==HealBot_PlayerGUID then
                bp:SetAttribute("helpbutton1", "heal1");
                bp:SetAttribute("type-heal1", "spell");
                bp:SetAttribute("spell-heal1", sName);
            end
        else
            mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
                _,_,mText=GetMacroInfo(mId)
     --        mUnit = bp.unit
                if UnitExists(HealBot_UnitPet(bp.unit)) then
                    mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(bp.unit))
                end
                mText=string.gsub(mText,"hbtarget",bp.unit)
                mText=string.gsub(mText,"hbtargettarget",bp.unit.."target")
                mText=string.gsub(mText,"hbtargettargettarget",bp.unit.."targettarget")
                bp:SetAttribute("type1","macro")
                bp:SetAttribute("macrotext1", mText)
            else
                bp:SetAttribute("helpbutton1", "item1");
                bp:SetAttribute("type-item1", "item");
                bp:SetAttribute("item-item1", sName);
            end
        end
        usedSmartCast=true;
        HealBot_Check_WeaponBuffs(sName)
    end
end

function HealBot_Action_PostClick(self,button)
    if self.id==999 and not IsModifierKeyDown() then
        HealBot_Panel_clickToFocus("hide")
    elseif usedSmartCast then
        if self.unit=="target" then
            if aj==1 then
                self:SetAttribute(HB_prefix.."helpbutton"..aj, "target"..aj);
                self:SetAttribute(HB_prefix.."type"..aj, "target")
                self:SetAttribute(HB_prefix.."type-target"..aj, "target")
            end
        else
            HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enabled",aj)
        end
    end
end

function HealBot_Action_RetMyTarget(hbGUID)
    return HealBot_MyTargets[hbGUID]
end

local scuSpell, scuHlth, scuMaxHlth, scuHealsIn, scuMinHlth = nil,nil,nil,nil, UnitLevel("player")*20
function HealBot_Action_SmartCast(hbGUID)
    scuSpell=nil
    rangeSpell=HealBot_hSpell
    if HealBot_PlayerDead or not HealBot_UnitID[hbGUID] then return nil; end
  
    if HealBot_Globals.SmartCastRes==1 and UnitIsDead(HealBot_UnitID[hbGUID]) and not UnitIsGhost(HealBot_UnitID[hbGUID]) then
        scuSpell=HealBot_Init_retSmartCast_Res();
        rangeSpell=HealBot_rSpell
    elseif HealBot_UnitDebuff[hbGUID] and HealBot_Globals.SmartCastDebuff==1 then
        scuSpell=HealBot_DebuffSpell[HealBot_UnitDebuff[hbGUID]["type"]];
        rangeSpell=HealBot_dSpell
    elseif HealBot_UnitBuff[hbGUID] and HealBot_Globals.SmartCastBuff==1 then
        scuSpell=HealBot_UnitBuff[hbGUID];
        rangeSpell=HealBot_bSpell
    elseif HealBot_Globals.SmartCastHeal==1 then
        scuHealsIn = HealBot_IncHeals_retHealsIn(hbGUID);
        scuHlth, scuMaxHlth = HealBot_UnitHealth(hbGUID, HealBot_UnitID[hbGUID]);
        x = scuMaxHlth-(scuHlth+scuHealsIn);
        if x>scuMinHlth then
            scuSpell=HealBot_SmartCast(hbGUID,x)
        end
    end
    if scuSpell and hbGUID~=HealBot_PlayerGUID then
        if HealBot_UnitInRange(rangeSpell, HealBot_UnitID[hbGUID])~=1 then return nil; end
    end
    return scuSpell;
end

function HealBot_Action_RetHealBot_ClassCol(hbGUID, unit)
    return HealBot_Action_ClassColour(hbGUID, unit)
end

function HealBot_Action_immediateClearLocalArr(hbGUID)
    HealBot_Enabled[hbGUID]=nil
    HealBot_UnitOffline[hbGUID]=nil
    HealBot_UnitThreatPct[hbGUID]=nil
    UnitDebuffStatus[hbGUID]=nil
end

function HealBot_Action_ClearLocalArr(hbGUID)
    if HealBot_AggroBar4[hbGUID] then HealBot_AggroBar4[hbGUID]=nil end
    if HealBot_Aggro[hbGUID] then HealBot_Aggro[hbGUID]=nil end
    if HealBot_Hightlight[hbGUID] then HealBot_Hightlight[hbGUID]=nil end
    if HealBot_AggroIndicator[hbGUID] then HealBot_AggroIndicator[hbGUID]=nil end
end

local HealBot_Mounts = {}

function HealBot_Action_initMountData()
HealBot_Mounts = {
      [458]="G", 
      [470]="G",
      [472]="G",
      [579]="G",
      [580]="G",
     [3363]="F",
     [5784]="G",
     [6648]="G",
     [6653]="G",
     [6654]="G",
     [6777]="G",
     [6898]="G",
     [6899]="G",
     [8394]="G",
     [8395]="G", 
    [10789]="G", 
    [10793]="G", 
    [10795]="G", 
    [10796]="G", 
    [10799]="G", 
    [10873]="G",
    [10969]="G", 
    [13819]="G", 
    [15779]="G", 
    [15780]="G", 
    [15781]="G", 
    [16055]="G", 
    [16056]="G", 
    [16058]="G", 
    [16059]="G", 
    [16060]="G",
    [16080]="G", 
    [16081]="G", 
    [16082]="G", 
    [16083]="G", 
    [16084]="G", 
    [17229]="G", 
    [17450]="G", 
    [17453]="G", 
    [17454]="G", 
    [17455]="G",
    [17456]="G", 
    [17458]="G", 
    [17459]="G", 
    [17460]="G", 
    [17461]="G", 
    [17462]="G", 
    [17463]="G", 
    [17464]="G", 
    [17465]="G", 
    [17481]="G",
    [18363]="G", 
    [18989]="G", 
    [18990]="G", 
    [18991]="G", 
    [18992]="G", 
    [22717]="G", 
    [22722]="G", 
    [23246]="G", 
    [22718]="G", 
    [22719]="G",
    [22720]="G", 
    [22721]="G", 
    [22723]="G", 
    [22724]="G", 
    [23161]="G", 
    [23214]="G", 
    [23219]="G", 
    [23220]="G", 
    [23221]="G", 
    [23222]="G",
    [23223]="G", 
    [23225]="G", 
    [23227]="G", 
    [23228]="G", 
    [23229]="G", 
    [23238]="G", 
    [23239]="G", 
    [23240]="G", 
    [23241]="G", 
    [23242]="G",
    [23243]="G", 
    [23247]="G", 
    [23248]="G", 
    [23249]="G", 
    [23250]="G", 
    [23251]="G", 
    [23252]="G", 
    [23338]="G", 
    [23509]="G", 
    [23510]="G",
    [24242]="G", 
    [24252]="G", 
    [25953]="A", 
    [26054]="A", 
    [26055]="A", 
    [26056]="A", 
    [26656]="A", 
    [28828]="F",
    [30174]="G", 
    [32235]="F", 
    [32239]="F", 
    [32240]="F", 
    [32242]="F", 
    [32243]="F", 
    [32244]="F", 
    [32245]="F", 
    [32246]="F",
    [32289]="F", 
    [32290]="F", 
    [32292]="F", 
    [32295]="F", 
    [32296]="F", 
    [32297]="F", 
    [32345]="F", 
    [33176]="F", 
    [33182]="F", 
    [33184]="F", 
    [33630]="G", 
    [33660]="G", 
    [34406]="G", 
    [34407]="G", 
    [34767]="G", 
    [34769]="G", 
    [34790]="G", 
    [34795]="G",
    [34896]="G", 
    [34897]="G", 
    [34898]="G", 
    [34899]="G", 
    [35018]="G", 
    [35020]="G", 
    [35022]="G", 
    [35025]="G", 
    [35027]="G", 
    [35028]="G",
    [35710]="G", 
    [35711]="G", 
    [35712]="G", 
    [35713]="G", 
    [35714]="G", 
    [36702]="G", 
    [37011]="F", 
    [37015]="F", 
    [39798]="F", 
    [39800]="F",
--    [37815]="O", 
--    [37859]="O", 
--    [37860]="O",
    [37011]="F", 
    [37015]="F", 
    [39315]="G", 
    [39316]="G", 
    [39317]="G", 
    [39318]="G",
    [39319]="G", 
    [39798]="F", 
    [39800]="F", 
    [39801]="F", 
    [39802]="F", 
    [39803]="F", 
    [40192]="F", 
    [41252]="G", 
    [41513]="F", 
    [41514]="F", 
    [41515]="F", 
    [41516]="F", 
    [41517]="F", 
    [41518]="F",
    [42776]="G", 
    [42777]="G", 
    [43688]="G", 
    [43810]="F", 
    [43899]="G", 
    [43900]="G", 
    [43927]="F", 
    [44151]="F", 
    [44153]="F", 
    [44221]="F", 
    [44229]="F", 
    [44317]="F", 
    [44744]="F", 
    [46197]="F", 
    [46199]="F",
    [46628]="G", 
    [47037]="G", 
    [48025]="GF",
    [48027]="G", 
    [48778]="G", 
    [48954]="G", 
    [49193]="F", 
    [49322]="G", 
    [49378]="G", 
    [49379]="G", 
    [50281]="G", 
    [50869]="G", 
    [51412]="G", 
    [51960]="F", 
    [54729]="F", 
    [54753]="G",
    [55164]="F", 
    [55531]="G", 
    [58615]="F", 
    [59567]="F", 
    [59568]="F", 
    [59569]="F", 
    [59570]="F",
    [59571]="F", 
    [59572]="G", 
    [59573]="G", 
    [59650]="F", 
    [59785]="G", 
    [59788]="G", 
    [59791]="G", 
    [59793]="G", 
    [59797]="G", 
    [59799]="G", 
    [59802]="G",
    [59804]="G", 
    [59810]="G", 
    [59811]="G", 
    [59961]="F", 
    [59976]="F", 
    [59996]="F", 
    [60002]="F", 
    [60021]="F", 
    [60024]="F", 
    [60025]="F",
    [60114]="G", 
    [60116]="G", 
    [60118]="G", 
    [60119]="G", 
    [60136]="G", 
    [60140]="G", 
    [60424]="G",
    [61229]="F",
    [61230]="F", 
    [61294]="F", 
    [61309]="F", 
    [61425]="G", 
    [61442]="F", 
    [61444]="F", 
    [61446]="F", 
    [61447]="G", 
    [61451]="F", 
    [61465]="G", 
    [61466]="G", 
    [61467]="G", 
    [61469]="G", 
    [61470]="G", 
    [61996]="F", 
    [61997]="F", 
    [62048]="F",
    [63232]="G", 
    [63234]="G", 
    [63635]="G",
    [63636]="G", 
    [63637]="G", 
    [63638]="G", 
    [63639]="G", 
    [63640]="G", 
    [63641]="G", 
    [63642]="G", 
    [63643]="G", 
    [63796]="F",
    [63844]="F", 
    [63956]="F", 
    [63963]="F", 
    [64657]="G", 
    [64658]="G",
    [64659]="G", 
    [64731]="GS", 
    [64927]="F", 
    [65439]="F", 
    [64977]="G", 
    [65637]="G", 
    [65638]="G", 
    [65639]="G", 
    [65640]="G", 
    [65641]="G", 
    [65642]="G", 
    [65643]="G",
    [65644]="G", 
    [65645]="G", 
    [65646]="G", 
    [66087]="F", 
    [66088]="F", 
    [66091]="G", 
    [66846]="G", 
    [66847]="G", 
    [66906]="G", 
    [67336]="F", 
    [67466]="G",
    [68056]="G", 
    [68188]="G", 
    [69395]="F", 
    [71342]="F",
    [71810]="F",
    [72286]="GF",     
    [72808]="F", 
    [72807]="F", 
    [72808]="F",
    [73313]="G",
    [73629]="G", 
    [73630]="G",        
    [74856]="F", 
    [74918]="G", 
    [75207]="V", 
    [75596]="F", 
    [75614]="GF", 
    [75973]="F", 
    [84751]="G",
    [87090]="G",
    [87091]="G", 
    [88331]="F", 
    [88335]="F", 
    [88718]="F", 
    [88741]="F", 
    [88742]="F", 
    [88744]="F", 
    [88746]="F", 
    [88748]="G", 
    [88749]="G", 
    [88750]="G", 
    [88990]="F", 
    [92155]="A", 
    [92231]="G",
    [92232]="G",        
    [93623]="F",
    [93644]="G",
    [97359]="F",
    [98204]="G",
    [98727]="G",
    [129552]="G",
};
end

-- Codes
--
-- A  - Ahn'Qiraj
-- F  - Flying
-- G  - Ground
-- GF - Ground and Flying
-- GS - Ground and Swiming
-- O  - The Oculus
-- S  - Swimming
-- V  - Swimming in Vashj'ir

local HealBot_GMount = {}
local HealBot_PrevGMounts = {}
local HealBot_FMount = {}
local HealBot_PrevFMounts = {}
local HealBot_SMount = {}
local HealBot_mountData = {}

function HealBot_Action_InitFuncUse()
    if (HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["AltUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["AltUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["AltUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["AltDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["AltDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["AltDown"]==HEALBOT_RANDOMGOUNDMOUNT)) then
        HealBot_Action_initMountData()
        HealBot_mountData["FuncUsed"]="YES"
        HealBot_setOptions_Timer(410)
    else
        HealBot_mountData["FuncUsed"]="NO"
    end
end

function HealBot_Action_retFuncUse()
    return HealBot_mountData["FuncUsed"] or "YES"
end

function HealBot_Action_InitMount()
    if not HealBot_mountData["FuncUsed"] then 
        HealBot_Action_InitFuncUse()
        return
    end
    SetMapToCurrentZone()
    if IsSpellKnown(54197) then
        HealBot_mountData["ColdFlying"]=true
    else
        HealBot_mountData["ColdFlying"]=false
    end
    if IsSpellKnown(90267) then
        HealBot_mountData["CataFlying"]=true
    else
        HealBot_mountData["CataFlying"]=false
    end
    y = GetCurrentMapContinent();
    if (y==3 or y>4) or (y == 4 and HealBot_mountData["ColdFlying"]) or (y<3 and HealBot_mountData["CataFlying"]) then
        HealBot_mountData["IncFlying"]=true
    else
        HealBot_mountData["IncFlying"]=false
    end
    if IsInInstance() and GetRealZoneText()==HEALBOT_ZONE_AQ40 then
        HealBot_mountData["IncGround"]="aq40"
    else
        HealBot_mountData["IncGround"]="grd"
        if GetRealZoneText()==HEALBOT_ZONE_VASHJIR1 or GetRealZoneText()==HEALBOT_ZONE_VASHJIR2 or GetRealZoneText()==HEALBOT_ZONE_VASHJIR3 or GetRealZoneText()==HEALBOT_ZONE_VASHJIR then
            HealBot_mountData["IncVashjir"]=GetRealZoneText()
        else
            HealBot_mountData["IncVashjir"]=false
        end
    end
    HealBot_mountData["#Ground"]=0
    HealBot_mountData["OculusID"]=nil
    for z,_ in pairs(HealBot_GMount) do
        HealBot_GMount[z]=nil;
    end
    for z,_ in pairs(HealBot_FMount) do
        HealBot_FMount[z]=nil;
    end
    for z,_ in pairs(HealBot_SMount) do
        HealBot_SMount[z]=nil;
    end
    for z,_ in pairs(HealBot_PrevGMounts) do
        HealBot_PrevGMounts[z]=nil;
    end
    for z,_ in pairs(HealBot_PrevFMounts) do
        HealBot_PrevFMounts[z]=nil;
    end

    x = GetNumCompanions("MOUNT");
	for z=1,x do
 		_, sName, sID, _, _ = GetCompanionInfo("MOUNT", z);
        
        if HealBot_Mounts[sID] then
            if HealBot_Mounts[sID]=="F" then
                if HealBot_mountData["IncFlying"] then
                    table.insert(HealBot_FMount, sName);
                end
            elseif HealBot_Mounts[sID]=="G" then
                if HealBot_mountData["IncGround"]=="grd" then
                    table.insert(HealBot_GMount, sName);
                    HealBot_mountData["#Ground"]=HealBot_mountData["#Ground"]+1
                end
            elseif HealBot_Mounts[sID]=="GF" then
                if HealBot_mountData["IncFlying"] then
                    table.insert(HealBot_FMount, sName);
                end
                if HealBot_mountData["IncGround"]=="grd" then
                    table.insert(HealBot_GMount, sName);
                    HealBot_mountData["#Ground"]=HealBot_mountData["#Ground"]+1
                end
            elseif HealBot_Mounts[sID]=="GS" then
                if HealBot_mountData["IncGround"]=="grd" then
                    table.insert(HealBot_GMount, sName);
                    HealBot_mountData["#Ground"]=HealBot_mountData["#Ground"]+1
                end
                table.insert(HealBot_SMount, sName);
            elseif HealBot_Mounts[sID]=="A" then
                if HealBot_mountData["IncGround"]=="aq40" then
                    table.insert(HealBot_GMount, sName);
                    HealBot_mountData["#Ground"]=HealBot_mountData["#Ground"]+1
                end
--            elseif HealBot_Mounts[sID]=="O" then
--                HealBot_mountData["OculusID"]=sID
            elseif HealBot_Mounts[sID]=="S" then
                table.insert(HealBot_SMount, sName);
            elseif HealBot_Mounts[sID]=="V" and HealBot_mountData["IncVashjir"] then
                table.insert(HealBot_SMount, sName);
            end
        elseif HealBot_mountData["FuncUsed"] and HealBot_mountData["FuncUsed"]=="YES" then
            HealBot_ReportMissingMount(sName, sID)
            HealBot_Mounts[sID]="G"
        end
	end   
    
    if #HealBot_FMount<3 then
        HealBot_mountData["PrevFlying#"]=0
    elseif #HealBot_FMount<5 then
        HealBot_mountData["PrevFlying#"]=1
    elseif #HealBot_FMount<7 then
        HealBot_mountData["PrevFlying#"]=2
    elseif #HealBot_FMount<9 then
        HealBot_mountData["PrevFlying#"]=3
    elseif #HealBot_FMount<11 then
        HealBot_mountData["PrevFlying#"]=4
    elseif #HealBot_FMount<14 then
        HealBot_mountData["PrevFlying#"]=5
    elseif #HealBot_FMount<17 then
        HealBot_mountData["PrevFlying#"]=6
    elseif #HealBot_FMount<21 then
        HealBot_mountData["PrevFlying#"]=7
    elseif #HealBot_FMount<25 then
        HealBot_mountData["PrevFlying#"]=8
    else
        HealBot_mountData["PrevFlying#"]=9
    end
    if HealBot_mountData["#Ground"]<3 then
        HealBot_mountData["PrevGround#"]=0
    elseif HealBot_mountData["#Ground"]<5 then
        HealBot_mountData["PrevGround#"]=1
    elseif HealBot_mountData["#Ground"]<7 then
        HealBot_mountData["PrevGround#"]=2
    elseif HealBot_mountData["#Ground"]<9 then
        HealBot_mountData["PrevGround#"]=3
    elseif HealBot_mountData["#Ground"]<11 then
        HealBot_mountData["PrevGround#"]=4
    elseif HealBot_mountData["#Ground"]<14 then
        HealBot_mountData["PrevGround#"]=5
    elseif HealBot_mountData["#Ground"]<17 then
        HealBot_mountData["PrevGround#"]=6
    elseif HealBot_mountData["#Ground"]<21 then
        HealBot_mountData["PrevGround#"]=7
    elseif HealBot_mountData["#Ground"]<25 then
        HealBot_mountData["PrevGround#"]=8
    else
        HealBot_mountData["PrevGround#"]=9
    end

    if HealBot_mountData["#Ground"]==0 and #HealBot_FMount==0 then
        HealBot_mountData["ValidUse"]=false
    else
        HealBot_mountData["ValidUse"]=true
    end

end

function HealBot_Action_ToggelMount(mountType)
    if IsMounted() then
        Dismount()
	elseif CanExitVehicle() then	
		VehicleExit()
    elseif HealBot_mountData["ValidUse"] and IsOutdoors() and not HealBot_IsFighting then
        sName = nil
        if mountType=="all" and not IsSwimming() and IsFlyableArea() and #HealBot_FMount>0 then
            i = math.random(1, #HealBot_FMount);
            sName = HealBot_FMount[i];
            if HealBot_Globals.dislikeMount[sName] then
                if HealBot_Globals.dislikeMount[sName]>0 then
                    HealBot_Globals.dislikeMount[sName]=HealBot_Globals.dislikeMount[sName]-1
                    z = math.random(1, #HealBot_FMount);
                    if z==i then 
                        z = math.random(1, #HealBot_FMount); 
                        if z==i then 
                            i = math.random(1, #HealBot_FMount); 
                            if z==i then 
                                i = math.random(1, #HealBot_FMount); 
                            else
                                i=z
                            end
                        else
                            i=z
                        end
                    else
                        i=z
                    end
                    sName = HealBot_FMount[i];
                else
                    HealBot_Globals.dislikeMount[sName]=250
                end
            end
            if HealBot_mountData["PrevFlying#"]>0 then
                table.insert(HealBot_PrevFMounts, HealBot_FMount[i]);
                table.remove(HealBot_FMount,i)
            end
            if #HealBot_PrevFMounts>HealBot_mountData["PrevFlying#"] then
                table.insert(HealBot_FMount, HealBot_PrevFMounts[1]);
                table.remove(HealBot_PrevFMounts,1)
            end
        elseif IsSwimming() and #HealBot_SMount>0 then
            i = math.random(1, #HealBot_SMount);
            sName = HealBot_SMount[i];
        elseif #HealBot_GMount>0 then
            i = math.random(1, #HealBot_GMount);
            sName = HealBot_GMount[i];
            if HealBot_Globals.dislikeMount[sName] then
                if HealBot_Globals.dislikeMount[sName]>0 then
                    HealBot_Globals.dislikeMount[sName]=HealBot_Globals.dislikeMount[sName]-1
                    z = math.random(1, #HealBot_GMount);
                    if z==i then 
                        z = math.random(1, #HealBot_GMount);
                        if z==i then 
                            i = math.random(1, #HealBot_GMount);
                            if z==i then 
                                i = math.random(1, #HealBot_GMount);
                            else
                                i=z
                            end
                        else
                            i=z
                        end
                    else
                        i=z
                    end
                    sName = HealBot_GMount[i];
                else
                    HealBot_Globals.dislikeMount[sName]=250
                end
            end
            if HealBot_mountData["PrevGround#"]>0 then
                table.insert(HealBot_PrevGMounts, HealBot_GMount[i]);
                table.remove(HealBot_GMount,i)
            end
            if #HealBot_PrevGMounts>HealBot_mountData["PrevGround#"] then
                table.insert(HealBot_GMount, HealBot_PrevGMounts[1]);
                table.remove(HealBot_PrevGMounts,1)
            end
        end
        if sName then HealBot_Action_Mount(sName) end
    end
end

function HealBot_Action_DislikeMount()
    local z = GetNumCompanions("MOUNT");
    local mount=nil
	for i=1,z do
 		local _, x, _, _, y = GetCompanionInfo("MOUNT", i);
 		if y then
 			mount=x
            do break end
 		end
 	end
    if mount then
        if HealBot_Globals.dislikeMount[mount] then
            HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_OFF.." "..mount)
            HealBot_Globals.dislikeMount[mount]=nil
        else
            HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_ON.." "..mount)
            HealBot_Globals.dislikeMount[mount]=75
        end
    end
end

function HealBot_Action_Mount(mountName)
	z = GetNumCompanions("MOUNT");
	for i=1,z do
 		_, sName, _, _, _ = GetCompanionInfo("MOUNT", i);
 		if sName==mountName then
 			CallCompanion("MOUNT", i);
            do break end
 		end
 	end
end

function HealBot_Action_RandomPet()
    SummonRandomCritter();
end

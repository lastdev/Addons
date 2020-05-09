local HealBot_ActiveButtons={[0]=1}
local HealBot_RangeSpells={}
local HealBot_AlwaysEnabled={}
local HealBot_pcClass={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0") 
local HealBot_ResetBarSkinDone={}
local HealBot_Action_rCalls={}
local _
local HealBot_Action_luVars={}
HealBot_Action_luVars["FrameMoving"]=false
HealBot_Action_luVars["ResetAttribs"]=false
HealBot_Action_luVars["UnitPowerMax"]=3
HealBot_Action_luVars["resetSkinTo"]=""
HealBot_Action_luVars["updateBucket"]=1
HealBot_Action_luVars["CacheSize"]=4
HealBot_Action_luVars["clearSpellCache"]=true
HealBot_Action_luVars["TestBarsOn"]=false
HealBot_Action_luVars["ShapeshiftForm"]=-1
HealBot_Action_luVars["FLUIDFREQ"]=50

function HealBot_Action_setLuVars(vName, vValue)
    HealBot_Action_luVars[vName]=vValue
    --HealBot_setCall("HealBot_Action_setLuVars")
end

function HealBot_Action_retLuVars(vName)
    --HealBot_setCall("HealBot_Action_retLuVars")
    return HealBot_Action_luVars[vName]
end

function HealBot_Action_clearResetBarSkinDone()
    for x,_ in pairs(HealBot_ResetBarSkinDone) do
        HealBot_ResetBarSkinDone[x]=false;
    end
end

function HealBot_Action_setpcClass()
    for j=1,5 do
        if (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK]) and 
            Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j] and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] then
            local prevHealBot_pcMax=HealBot_Action_luVars["UnitPowerMax"];
            if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
                HealBot_pcClass[j]=9
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 9);
            else
                HealBot_pcClass[j]=12
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 12);
            end     
            if prevHealBot_pcMax~=HealBot_Action_luVars["UnitPowerMax"] then
                HealBot_Action_clearResetBarSkinDone()
                HealBot_setOptions_Timer(596)
            end
        else
            HealBot_pcClass[j]=false
            local xButton=HealBot_Unit_Button["player"]
            if xButton then
                --for y=1,5 do
                --    local iconName = _G["HealBot_Action_HealUnit"..xButton.id.."Bar3Icon"..y];
                --    iconName:SetAlpha(0)
                --end
            end
        end
    end
end

function HealBot_Action_SetrSpell()
	HealBot_RangeSpells["HEAL"]=nil
	HealBot_RangeSpells["BUFF"]=nil
	HealBot_RangeSpells["CURE"]=nil
	HealBot_RangeSpells["RES"]=nil
    HealBot_RangeSpells["HARM"]=nil
	local x=HealBot_GetBandageType() or HEALBOT_WORDS_UNKNOWN
    local sName=nil
    if HealBot_Data["PCLASSTRIM"]=="DRUI" then
        sName=HealBot_KnownSpell(HEALBOT_WRATH)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_HURRICANE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
        end
        sName=HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD)
        if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		else
            sName=HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD)
            if sName then 
                HealBot_RangeSpells["BUFF"]=sName
                x=sName
            end
        end
        sName=HealBot_KnownSpell(HEALBOT_REMOVE_CORRUPTION)
        if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_REVIVE)
        if sName then 
			HealBot_RangeSpells["RES"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_REJUVENATION)
        if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
        sName=HealBot_KnownSpell(HEALBOT_FROSTFIRE_BOLT)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_FIRE_BLAST)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
        end
        sName=HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE)
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_REMOVE_CURSE)
		if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        sName=HealBot_KnownSpell(HEALBOT_HOLY_SHOCK)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_JUDGMENT)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
		end
        sName=HealBot_KnownSpell(HEALBOT_REDEMPTION)
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_CLEANSE)
		if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_REDEMPTION)
		if sName then 
			HealBot_RangeSpells["RES"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_FLASH_OF_LIGHT)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
        sName=HealBot_KnownSpell(HEALBOT_SHADOW_WORD_PAIN)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_PENANCE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            else
                sName=HealBot_KnownSpell(HEALBOT_SMITE)
                if sName then 
                    HealBot_RangeSpells["HARM"]=sName
                    x=sName
                end
            end
        end
        sName=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE)
        if not sName and HEALBOT_GAME_VERSION<4 then sName=HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) end
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_PURIFY)
		if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_RESURRECTION)
		if sName then 
			HealBot_RangeSpells["RES"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_FLASH_HEAL)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_PENANCE)
            if sName then 
                HealBot_RangeSpells["HEAL"]=sName
                x=sName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        sName=HealBot_KnownSpell(HEALBOT_LIGHTNING_BOLT)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_EARTH_SHIELD)
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_PURIFY_SPIRIT)
		if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_CLEANSE_SPIRIT)
            if sName then 
                HealBot_RangeSpells["CURE"]=sName
                x=sName
            else
                sName=HealBot_KnownSpell(HEALBOT_HEALING_SURGE)
                if sName then 
                    HealBot_RangeSpells["CURE"]=sName
                    x=sName
                end
            end
		end
        sName=HealBot_KnownSpell(HEALBOT_ANCESTRALSPIRIT)
		if sName then 
			HealBot_RangeSpells["RES"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_HEALING_SURGE)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        sName=HealBot_KnownSpell(HEALBOT_CRACKLING_JADE_LIGHTNING)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR)
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_DETOX)
		if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_RESUSCITATE)
		if sName then 
			HealBot_RangeSpells["RES"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_SOOTHING_MIST)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="WARL" then
        sName=HealBot_KnownSpell(HEALBOT_CORRUPTION)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_FEAR)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
		end
        sName=HealBot_KnownSpell(HEALBOT_UNENDING_BREATH)
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="WARR" then
        sName=HealBot_KnownSpell(HEALBOT_TAUNT)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_VIGILANCE)
        if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_BATTLE_SHOUT)
            if sName then 
                HealBot_RangeSpells["BUFF"]=sName
                x=sName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
        sName=HealBot_KnownSpell(HEALBOT_ARCANE_SHOT)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_CONCUSSIVE_SHOT)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            else
                sName=HealBot_KnownSpell(HEALBOT_AIMED_SHOT)
                if sName then 
                    HealBot_RangeSpells["HARM"]=sName
                    x=sName
                end
            end
		end
        sName=HealBot_KnownSpell(HEALBOT_MENDPET)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="ROGU" then
        sName=HealBot_KnownSpell(HEALBOT_THROW)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_GOUGE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="DEAT" then
        sName=HealBot_KnownSpell(HEALBOT_DEATH_COIL)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_PLAGUE_STRIKE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=HsName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="DEMO" then
    end
	if (HealBot_RangeSpells["HEAL"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HEAL"]=x end
	if (HealBot_RangeSpells["BUFF"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["BUFF"]=x end
	if (HealBot_RangeSpells["CURE"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["CURE"]=x end
	if (HealBot_RangeSpells["RES"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["RES"]=x end
    if (HealBot_RangeSpells["HARM"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HARM"]=x end
end

function HealBot_GetBandageType()
    local bandage = nil
    if IsUsableItem(HEALBOT_TIDESPRAY_LINEN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_TIDESPRAY_LINEN_BANDAGE) then bandage = HEALBOT_TIDESPRAY_LINEN_BANDAGE
    elseif IsUsableItem(HEALBOT_DEEP_SEA_BANDAGE) or HealBot_IsItemInBag(HEALBOT_DEEP_SEA_BANDAGE) then bandage = HEALBOT_DEEP_SEA_BANDAGE
    elseif IsUsableItem(HEALBOT_SILKWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_SILKWEAVE_BANDAGE) then bandage = HEALBOT_SILKWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_ASHRAN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_ASHRAN_BANDAGE) then bandage = HEALBOT_ASHRAN_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_WINDWOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_WINDWOOL_BANDAGE) then bandage = HEALBOT_HEAVY_WINDWOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_WINDWOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_WINDWOOL_BANDAGE) then bandage = HEALBOT_WINDWOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_DENSE_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_DENSE_EMBERSILK_BANDAGE) then bandage = HEALBOT_DENSE_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_EMBERSILK_BANDAGE) then bandage = HEALBOT_HEAVY_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_EMBERSILK_BANDAGE) then bandage = HEALBOT_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_FROSTWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_NETHERWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) then bandage = HEALBOT_HEAVY_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_RUNECLOTH_BANDAGE) or HealBot_IsItemInBag(HEALBOT_RUNECLOTH_BANDAGE) then bandage = HEALBOT_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_MAGEWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_SILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_SILK_BANDAGE) then bandage = HEALBOT_HEAVY_SILK_BANDAGE
    elseif IsUsableItem(HEALBOT_SILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_SILK_BANDAGE) then bandage = HEALBOT_SILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_WOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_WOOL_BANDAGE) then bandage = HEALBOT_HEAVY_WOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_WOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_WOOL_BANDAGE) then bandage = HEALBOT_WOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_LINEN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_LINEN_BANDAGE) then bandage = HEALBOT_HEAVY_LINEN_BANDAGE
    elseif IsUsableItem(HEALBOT_LINEN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_LINEN_BANDAGE) then bandage = HEALBOT_LINEN_BANDAGE
    end
    return bandage
end


local hbAuxAbsorbAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxHealInAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Action_clearAuxAssigned()
    for f=1,10 do
        hbAuxAbsorbAssigned[f]={};
        hbAuxHealInAssigned[f]={};
    end
end

function HealBot_Action_setAuxAssigned(aType, frame, id)
    if aType=="ABSORB" then
        table.insert(hbAuxAbsorbAssigned[frame], id)
    else
        table.insert(hbAuxHealInAssigned[frame], id)
    end
end

local function HealBot_Action_UpdateAuxAbsorbBar(button, r, g, b, value)
    table.foreach(hbAuxAbsorbAssigned[button.frame], function (x,id)
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=r
            button.aux[id]["G"]=g
            button.aux[id]["B"]=b
        end
        HealBot_setAuxBar(button, id, value, true)
    end)
end

function HealBot_Action_ClearAuxAbsorbBar(button)
    table.foreach(hbAuxAbsorbAssigned[button.frame], function (x,id)
        HealBot_clearAuxBar(button, id)
    end)
end

local function HealBot_Action_UpdateAuxHealInBar(button, r, g, b, value)
    table.foreach(hbAuxHealInAssigned[button.frame], function (x,id)
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=r
            button.aux[id]["G"]=g
            button.aux[id]["B"]=b
        end
        HealBot_setAuxBar(button, id, value, true)
    end)
end

function HealBot_Action_ClearAuxHealInBar(button)
    table.foreach(hbAuxHealInAssigned[button.frame], function (x,id)
        HealBot_clearAuxBar(button, id)
    end)
end


local auhiHiR, auhiHiG, auhiHiB, auhiHiPct, auhiHiHealsIn=0,0,0,1,0
function HealBot_Action_UpdateHealsInButton(button)
    auhiHiHealsIn=button.health.incoming
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then auhiHiHealsIn=0 end
    
    if auhiHiHealsIn>0 and button.status.current<9 then
        auhiHiPct = button.health.current+button.health.incoming
        auhiHiR, auhiHiG, auhiHiB = 0, 0, 0
        if auhiHiPct<button.health.max then 
            auhiHiPct=auhiHiPct/button.health.max  
         else
            auhiHiPct=1;
        end
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            auhiHiR=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
            auhiHiG=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
            auhiHiB=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            HealBot_Action_BarColourPct(button, auhiHiPct)
            auhiHiR, auhiHiG = button.health.rcol, button.health.gcol
        else
            auhiHiR,auhiHiG,auhiHiB = button.gref["Bar"]:GetStatusBarColor();
        end
        button.gref["InHeal"]:SetStatusBarColor(auhiHiR,auhiHiG,auhiHiB,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]);
        button.gref["InHeal"]:SetValue(floor(auhiHiPct*1000));
        HealBot_Action_UpdateAuxHealInBar(button, auhiHiR, auhiHiG, auhiHiB, floor(auhiHiPct*1000))
    else
        button.gref["InHeal"]:SetValue(0)
        button.gref["InHeal"]:SetStatusBarColor(0,0,0,0);
        HealBot_Action_ClearAuxHealInBar(button)
    end
    HealBot_Text_SetText(button)
    --HealBot_setCall("HealBot_Action_UpdateHealsInButton")
end

local auaHaR, auaHaG, auaHaB, auaHaPct, auaHbPct, auaUnitHealsIn, auaUnitAbsorbsIn=0,0,0,1,1,0,0
function HealBot_Action_UpdateAbsorbsButton(button)
    auaUnitAbsorbsIn=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then auaUnitAbsorbsIn=0 end
    
    if auaUnitAbsorbsIn>0 and button.status.current<9 then
        auaUnitHealsIn=button.health.incoming
        auaHaR, auaHaG, auaHaB = 0, 0, 0
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then auaUnitHealsIn=0 end
        auaHaPct = button.health.current+auaUnitHealsIn+auaUnitAbsorbsIn
        if auaHaPct<button.health.max then
            auaHaPct=auaHaPct/button.health.max
        else
            auaHaPct=1;
        end
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            auaHaR=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"]
            auaHaG=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"]
            auaHaB=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"]
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            auaHbPct=auaHaPct
            if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 1 then
                auaHbPct=button.health.current+auaUnitAbsorbsIn
                if auaHbPct<button.health.max then
                    auaHbPct=auaHbPct/button.health.max
                else
                    auaHbPct=1;
                end
            end
            HealBot_Action_BarColourPct(button, auaHbPct)
            auaHaR, auaHaG = button.health.rcol, button.health.gcol
        else
            auaHaR,auaHaG,auaHaB = button.gref["Bar"]:GetStatusBarColor();
        end
        button.gref["Absorb"]:SetStatusBarColor(auaHaR,auaHaG,auaHaB,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]);
        button.gref["Absorb"]:SetValue(floor(auaHaPct*1000));
        HealBot_Action_UpdateAuxAbsorbBar(button, auaHaR, auaHaG, auaHaB, floor(auaHaPct*1000))
    else
        button.gref["Absorb"]:SetValue(0)
        button.gref["Absorb"]:SetStatusBarColor(0,0,0,0);
        HealBot_Action_ClearAuxAbsorbBar(button)
    end
    HealBot_Text_SetText(button)
    --HealBot_setCall("HealBot_Action_UpdateAbsorbsButton")
end
               
local ubbHcR, ubbHcG, ubbHcB=0,0,0
function HealBot_Action_UpdateBackgroundButton(button)
    if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]>1 then
        if not UnitExists(button.unit) then
            button.gref["Back"]:SetStatusBarColor(0, 0, 0, 0)
        else
            ubbHcR,ubbHcG,ubbHcB = 0, 0, 0
            if button.status.current<9 then
                if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==2 then
                    ubbHcR,ubbHcG,ubbHcB = button.text.r,button.text.g,button.text.b
                else
                    ubbHcR=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BR"]
                    ubbHcG=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BG"]
                    ubbHcB=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BB"]
                end
            end
            button.gref["Back"]:SetStatusBarColor(ubbHcR,ubbHcG,ubbHcB,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"]);
        end
    else
        HealBot_Action_UpdateHealthButton(button)
    end
    --HealBot_setCall("HealBot_Action_UpdateBackgroundButton")
end

function HealBot_Action_dSpell()
    return HealBot_RangeSpells["CURE"]
end

function HealBot_Action_bSpell()
    return HealBot_RangeSpells["BUFF"]
end

function HealBot_Action_setEnabled(button, state)
    if button.status.enabled~=state then
        button.status.enabled=state
        HealBot_Action_ShowHideFrames(button) 
        HealBot_Text_UpdateButton(button)
        HealBot_UpdAuxBar(button)
    end
end

local audHcR, audHcG, audHcB, audIsDebuff=0,0,0,false
local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
function HealBot_Action_UpdateDebuffButton(button)
    if button.aura.debuff.type and UnitExists(button.unit) and button.status.current<9 then
        if HealBot_Config_Cures.CDCshownHB then
            HealBot_UpdateUnitRange(button,false)
            audIsDebuff=true
            if button.aura.buff.priority<button.aura.debuff.priority then
                if button.aura.buff.name and HealBot_Config_Buffs.CBshownHB and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Bar-3) then
                    audIsDebuff=false
                end
            end
            if audIsDebuff and button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) then 
                audHcR,audHcG,audHcB = 0, 0, 0

                if button.aura.debuff.type == HEALBOT_CUSTOM_en then
                    if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
                        if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] then
                            audHcR = HealBot_Globals.CDCBarColour[button.aura.debuff.id].R
                            audHcG = HealBot_Globals.CDCBarColour[button.aura.debuff.id].G
                            audHcB = HealBot_Globals.CDCBarColour[button.aura.debuff.id].B
                        else
                            button.status.current=6
                            HealBot_Action_UpdateBuffButton(button)
                            return
                        end
                    else
                        if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] or 
                          (not HealBot_Globals.HealBot_Custom_Debuffs[button.aura.debuff.id]
                           and button.aura.debuff.priority==15
                           and HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]) then
                            audHcR = HealBot_Globals.CDCBarColour[customDebuffPriority].R
                            audHcG = HealBot_Globals.CDCBarColour[customDebuffPriority].G
                            audHcB = HealBot_Globals.CDCBarColour[customDebuffPriority].B
                        else
                            button.status.current=6
                            HealBot_Action_UpdateBuffButton(button)
                            return
                        end
                    end
                else
                    audHcR = HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].R
                    audHcG = HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].G
                    audHcB = HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].B
                end
                button.status.current=8
                HealBot_Text_setHealthText(button)
                if button.status.range==1 then  
                    HealBot_Action_setEnabled(button, true)
                    button.gref["Bar"]:SetStatusBarColor(audHcR,audHcG,audHcB,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
                else
                    HealBot_Action_setEnabled(button, false)
                    button.gref["Bar"]:SetStatusBarColor(audHcR,audHcG,audHcB,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]);
                end
            else
                button.status.current=6
                HealBot_Action_UpdateBuffButton(button)
            end
            HealBot_Text_SetText(button)
        else
            button.status.current=1
            HealBot_Action_UpdateBuffButton(button)
        end
    else
        if button.status.current==9 then 
            HealBot_Action_UpdateTheDeadButton(button)
        else
            button.status.current=1 
            HealBot_Action_UpdateBuffButton(button)
        end
    end
    --HealBot_setCall("HealBot_Action_UpdateDebuffButton")
end

local aubHcR, aubHcG, aubHcB=0,0,0
function HealBot_Action_UpdateBuffButton(button)
    if button.aura.buff.name and button.status.current<8 and UnitExists(button.unit) then
        if HealBot_Config_Buffs.CBshownHB and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Bar-3) then
            if button.aura.buff.name~=HEALBOT_CUSTOM_en then button.spells.rangecheck=button.aura.buff.name end
            HealBot_UpdateUnitRange(button,false)
            aubHcR,aubHcG,aubHcB = 0, 0, 0
            aubHcR,aubHcG,aubHcB=HealBot_Options_RetBuffRGB(button)  
            button.status.current=7
            HealBot_Text_setHealthText(button)
            if button.status.range==1 then  
                HealBot_Action_setEnabled(button, true)
                button.gref["Bar"]:SetStatusBarColor(aubHcR,aubHcG,aubHcB,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
            else
                HealBot_Action_setEnabled(button, false)
                button.gref["Bar"]:SetStatusBarColor(aubHcR,aubHcG,aubHcB,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]);
            end
            HealBot_Text_SetText(button)
        else
            button.status.current=5
            HealBot_Action_UpdateHealthButton(button)
        end
    else
        if button.status.current==9 then 
            HealBot_Action_UpdateTheDeadButton(button)
        else
            button.status.current=1 
            HealBot_Action_UpdateHealthButton(button)
        end
    end
    --HealBot_setCall("HealBot_Action_UpdateBuffButton")
end

local ripHasRes={}
local ripPlayerBuffsList={}
function HealBot_Action_UpdateTheDeadButton(button)
     if button.status.current==9 then
        if not UnitIsDeadOrGhost(button.unit) then
            button.status.current=2
            button.aura.check=true
            button.health.updhealth=true
            button.health.update=true
            ripHasRes[button.id]=nil
            button.text.nameupdate=true
            button.spells.rangecheck=HealBot_RangeSpells["HEAL"]
            HealBot_UpdateUnitRange(button,false)
            HealBot_Action_UpdateBackgroundButton(button)
            if UnitIsUnit(button.unit,"player") then 
                HealBot_Action_ResetActiveUnitStatus() 
            end
            HealBot_Text_setNameTag(button)
            HealBot_Action_Refresh(button)
        elseif UnitHasIncomingResurrection(button.unit) then
            if not ripHasRes[button.id] then
                ripHasRes[button.id]=true
                button.text.nameupdate=true
            end
        elseif ripHasRes[button.id] then
            ripHasRes[button.id]=nil
            button.text.nameupdate=true
        end
    elseif UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit) then
        button.status.current=9
        button.health.updincoming=true
        button.health.updabsorbs=true
        button.aura.buff.nextcheck=false
        button.text.nameupdate=true
        HealBot_OnEvent_UnitHealth(button)
        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
            button.gref["Back"]:SetStatusBarColor(1,0,0,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"]);
        else
            HealBot_Action_UpdateBackgroundButton(button)
        end
        if button.aura.debuff.name then  
            HealBot_Aura_ClearDebuff(button)
        end
        if button.aggro.status>0 then
            HealBot_Action_UpdateAggro(button,false,0,0,"")
        end
        HealBot_Aura_RemoveIcons(button)
        if UnitIsUnit(button.unit,"player") then
            HealBot_Action_ResetActiveUnitStatus() 
        else
            HealBot_Action_Refresh(button)
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
            HealBot_Action_SetClassIconTexture(button)
        end
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
            HealBot_OnEvent_RaidTargetUpdate(button)
        end
        button.spells.rangecheck=HealBot_RangeSpells["RES"]
        HealBot_UpdateUnitRange(button,false)
        HealBot_Text_setHealthText(button)
        HealBot_Text_setNameTag(button)
        HealBot_clearAllAuxBar(button)
        ripPlayerBuffsList=button.aura.buff.recheck
        for name,_ in pairs (ripPlayerBuffsList) do
            ripPlayerBuffsList[name]=nil
        end
        button.gref["Bar"]:SetValue(0)
    end
    HealBot_Text_SetText(button)
    --HealBot_setCall("HealBot_Action_UpdateTheDeadButton")
end

local HealBot_Fluid_Buttons={}
local aufbPct,aufbActive=1000,false
function HealBot_Action_UpdateFluidBar()
    aufbActive=false
    for xUnit,xButton in pairs(HealBot_Fluid_Buttons) do
        if xButton.status.current==9 then
            xButton.gref["Bar"]:SetValue(0)
            HealBot_Fluid_Buttons[xUnit]=nil
        else
            if xButton.health.current<xButton.health.max then
                aufbPct=floor((xButton.health.current/xButton.health.max)*1000)
            else
                aufbPct=1000
            end
            local barValue=xButton.gref["Bar"]:GetValue()
            if barValue>aufbPct then
                local setValue=barValue-HealBot_Action_luVars["FLUIDFREQ"]
                if setValue<aufbPct then
                    setValue=aufbPct
                end
                xButton.gref["Bar"]:SetValue(setValue)
                aufbActive=true
            elseif barValue<aufbPct then
                local setValue=barValue+HealBot_Action_luVars["FLUIDFREQ"]
                if setValue>aufbPct then
                    setValue=aufbPct
                end
                xButton.gref["Bar"]:SetValue(setValue)
                aufbActive=true
            else
                HealBot_Fluid_Buttons[xUnit]=nil
            end
        end
    end
    return aufbActive
end

local auhbPtc=0
local auhbHcR, auhbHcG, auhbHcB, auhbHcA, auhbHcT = 0, 0, 0, 0, 0
function HealBot_Action_UpdateHealthButton(button)
    if not HealBot_Action_luVars["TestBarsOn"] then 
        auhbPtc=0
        if UnitExists(button.unit) then
            auhbHcR,auhbHcG,auhbHcB,auhbHcA,auhbHcT = 0, 0, 0, 0, 0
            auhbHcT = button.health.current/button.health.max
            auhbPtc=floor(auhbHcT*1000)
            HealBot_Action_BarColourPct(button, auhbHcT)
            if button.status.current==9 or (UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit)) then
                HealBot_Action_UpdateTheDeadButton(button)
                return
            elseif button.status.current<7 then 
                button.spells.rangecheck=HealBot_RangeSpells["HEAL"]
                HealBot_UpdateUnitRange(button,false)
                if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] >= 2) then
                    if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
                        auhbHcR,auhbHcG,auhbHcB = button.text.r,button.text.g,button.text.b
                    else
                        auhbHcR=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
                        auhbHcG=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
                        auhbHcB=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
                    end
                else
                    auhbHcR, auhbHcG = button.health.rcol, button.health.gcol
                end
                if button.aggro.status==3 or HealBot_AlwaysEnabled[button.guid] or
                  (HealBot_Data["UILOCK"] and button.health.current<=(button.health.max*Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIC"])) or
                 (not HealBot_Data["UILOCK"] and button.health.current<=(button.health.max*Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTOC"])) then
                    if button.status.current<5 then button.status.current=4 end
                    if button.status.range==1 then
                        HealBot_Action_setEnabled(button, true)
                        auhbHcA=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                    else
                        HealBot_Action_setEnabled(button, false)
                        auhbHcA=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
                    end
                else
                    if button.status.current<5 then button.status.current=0 end
                    HealBot_Action_setEnabled(button, false)
                    auhbHcA=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
                end
                button.gref["Bar"]:SetStatusBarColor(auhbHcR,auhbHcG,auhbHcB,auhbHcA);
                HealBot_Text_setHealthText(button)
                HealBot_Text_SetText(button)
            else
                HealBot_Text_setHealthText(button)
                HealBot_Text_SetText(button)
            end
            if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
                button.gref["Back"]:SetStatusBarColor(button.health.rcol, button.health.gcol,0,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"]);
            end
        else
            button.status.current=2
            button.health.current=0
            HealBot_Text_setHealthText(button)
            button.gref["Bar"]:SetStatusBarColor(0.2,0.2,0.2,0.4);
            button.gref["Back"]:SetStatusBarColor(0, 0, 0, 0)
            HealBot_Text_SetText(button)
        end
        
                                    
        if button.gref["Bar"]:GetValue()~=auhbPtc then
            if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] then
                button.gref["Bar"]:SetValue(auhbPtc)
            else
                HealBot_Fluid_Buttons[button.unit]=button
            end
        end
        if button.status.current>3 and button.status.current<9 and button.status.range==1 then
            if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
            if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
        else
            HealBot_HealsInUpdate(button)
            HealBot_AbsorbsUpdate(button)
        end
    end
    --HealBot_setCall("HealBot_Action_UpdateHealthButton")
end

local hacpr, hacpg=1,1 
function HealBot_Action_BarColourPct(button, hlthPct)
    hacpr, hacpg = 1,1
    if hlthPct>=0.98 then 
        hacpr = 0
    elseif hlthPct<0.98 and hlthPct>=0.65 then 
        hacpr=2.94-(hlthPct*3)
    elseif hlthPct<=0.64 and hlthPct>0.31 then 
        hacpg=(hlthPct-0.31)*3
    elseif hlthPct<=0.31 then 
        hacpg = 0
    end
    button.health.rcol=hacpr
    button.health.gcol=hacpg
    --HealBot_setCall("HealBot_Action_BarColourPct")
end

function HealBot_Action_ShouldHealSome(hbCurFrame)
    --HealBot_setCall("HealBot_Action_ShouldHealSome")
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.frame==hbCurFrame and xButton.status.enabled then
            return true
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.frame==hbCurFrame and xButton.status.enabled then
            return true
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.frame==hbCurFrame and xButton.status.enabled then
            return true
        end
    end
    return false
end

function HealBot_Action_ShouldHealSomePet(hbCurFrame)
    --HealBot_setCall("HealBot_Action_ShouldHealSome")
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.frame==hbCurFrame and xButton.status.enabled then
            return true
        end
    end
    return false
end

local vBar3Text=""
local function HealBot_Action_SetBar3ColAlpha(barName, pct, r, g, b, a, sName)
    barName:SetValue(pct);
    barName:SetStatusBarColor(r,g,b,a);
    button.gref.txt["enemycast"]:SetText(sName or "")
    --HealBot_setCall("HealBot_Action_SetBar3ColAlpha")
end

local vPowerBarInfo={}
local vPowerBarType,vPowerBarToken,vPowerBarR,vPowerBarG,vPowerBarB=0,"MANA",0,0,0
local function HealBot_Action_GetManaBarCol(button)
    vPowerBarType, vPowerBarToken, vPowerBarR, vPowerBarG, vPowerBarB=UnitPowerType(button.unit);
    if vPowerBarType then button.mana.type=vPowerBarType end
    vPowerBarInfo=PowerBarColor[vPowerBarToken]
    if vPowerBarInfo then
        return vPowerBarInfo.r, vPowerBarInfo.g, vPowerBarInfo.b
    elseif not vPowerBarR then
        vPowerBarInfo = PowerBarColor[vPowerBarType] or PowerBarColor["MANA"];
        return vPowerBarInfo.r, vPowerBarInfo.g, vPowerBarInfo.b
    else
        return vPowerBarR, vPowerBarG, vPowerBarB
    end
end

function HealBot_Action_setButtonManaBarCol(button)
    button.mana.r,button.mana.g,button.mana.b=HealBot_Action_GetManaBarCol(button)
end

local tSetBar3Value={["BarName"]="",["Cast"]="",["PowerType"]=0,["IconName"]="",["PowerMax"]=100,["Power"]=0}
function HealBot_Action_ClearBar3(button)
    if not button then return end
    tSetBar3Value["BarName"] = _G["HealBot_Action_HealUnit"..button.id.."Bar3"]
    tSetBar3Value["IconName"] = _G[tSetBar3Value["BarName"]:GetName().."Icon"..1];
    tSetBar3Value["IconName"]:SetAlpha(0)
    tSetBar3Value["IconName"] = _G[tSetBar3Value["BarName"]:GetName().."Icon"..2];
    tSetBar3Value["IconName"]:SetAlpha(0)
    tSetBar3Value["IconName"] = _G[tSetBar3Value["BarName"]:GetName().."Icon"..3];
    tSetBar3Value["IconName"]:SetAlpha(0)
    tSetBar3Value["IconName"] = _G[tSetBar3Value["BarName"]:GetName().."Icon"..4];
    tSetBar3Value["IconName"]:SetAlpha(0)
    tSetBar3Value["IconName"] = _G[tSetBar3Value["BarName"]:GetName().."Icon"..5];
    tSetBar3Value["IconName"]:SetAlpha(0)
    HealBot_Action_SetBar3ColAlpha(tSetBar3Value["BarName"], 0, 0, 0, 0, 0)
end

local hbAuxPowerAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Action_clearAuxPowerAssigned()
    for f=1,10 do
        hbAuxPowerAssigned[f]={};
    end
end

function HealBot_Action_setAuxPowerAssigned(frame, id)
    table.insert(hbAuxPowerAssigned[frame], id)
end

function HealBot_Action_setPowerBars(button, sName)
    table.foreach(hbAuxPowerAssigned[button.frame], function (x,id)
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=button.mana.r
            button.aux[id]["G"]=button.mana.g
            button.aux[id]["B"]=button.mana.b
        end
        HealBot_setAuxBar(button, id, floor((button.mana.current/button.mana.max)*1000), true)
    end)
    --HealBot_setCall("HealBot_Action_setPowerBars")
end

local hbLowManaTrig={[1] = {[1]=1,[2]=2,[3]=3},
                     [2] = {[1]=1,[2]=2,[3]=3},
                     [3] = {[1]=1,[2]=2,[3]=3},
                     [4] = {[1]=1,[2]=2,[3]=3},
                     [5] = {[1]=1,[2]=2,[3]=3},
                     [6] = {[1]=1,[2]=2,[3]=3},
                     [7] = {[1]=1,[2]=2,[3]=3},
                     [8] = {[1]=1,[2]=2,[3]=3},
                     [9] = {[1]=1,[2]=2,[3]=3},
                     [10] = {[1]=1,[2]=2,[3]=3},
                    }

function HealBot_Action_setLowManaTrig()
    for j=1,10 do
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==2 then
            hbLowManaTrig[j][1]=10
            hbLowManaTrig[j][2]=20
            hbLowManaTrig[j][3]=30
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==3 then
            hbLowManaTrig[j][1]=15
            hbLowManaTrig[j][2]=30
            hbLowManaTrig[j][3]=45
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==4 then
            hbLowManaTrig[j][1]=20
            hbLowManaTrig[j][2]=40
            hbLowManaTrig[j][3]=60
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==5 then
            hbLowManaTrig[j][1]=25
            hbLowManaTrig[j][2]=50
            hbLowManaTrig[j][3]=75
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==6 then
            hbLowManaTrig[j][1]=30
            hbLowManaTrig[j][2]=60
            hbLowManaTrig[j][3]=90
        else
            hbLowManaTrig[j][1]=1
            hbLowManaTrig[j][2]=2
            hbLowManaTrig[j][3]=3
        end
    end
    --HealBot_setCall("HealBot_Action_setLowManaTrig")
end

local tCheckLowMana={["MPCT"]=0,["MIND"]=0}
function HealBot_Action_CheckUnitLowMana(button)
    if button and button.mana.type==0 then
        if UnitExists(button.unit) and button.mana.current>0 and button.mana.max>0 and 
           Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["LOWMANA"]>1 then
            tCheckLowMana["MPCT"]=floor((button.mana.current/button.mana.max)*100)
            tCheckLowMana["MIND"]=0
            if tCheckLowMana["MPCT"]<hbLowManaTrig[button.frame][1] then
                tCheckLowMana["MIND"]=1
            elseif tCheckLowMana["MPCT"]<hbLowManaTrig[button.frame][2] then
                tCheckLowMana["MIND"]=2
            elseif tCheckLowMana["MPCT"]<hbLowManaTrig[button.frame][3] then
                tCheckLowMana["MIND"]=3
            end
            if tCheckLowMana["MIND"]==1 then
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m1" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m1"
                    button.gref.indicator.mana["Icontm1"]:SetAlpha(1)
                    button.gref.indicator.mana["Icontm2"]:SetAlpha(0)
                    button.gref.indicator.mana["Icontm3"]:SetAlpha(0)
                end
            elseif tCheckLowMana["MIND"]==2 then
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m2" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m2"
                    button.gref.indicator.mana["Icontm1"]:SetAlpha(1)
                    button.gref.indicator.mana["Icontm2"]:SetAlpha(1)
                    button.gref.indicator.mana["Icontm3"]:SetAlpha(0)
                end
            elseif tCheckLowMana["MIND"]==3 then
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m3" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m3"
                    button.gref.indicator.mana["Icontm1"]:SetAlpha(1)
                    button.gref.indicator.mana["Icontm2"]:SetAlpha(1)
                    button.gref.indicator.mana["Icontm3"]:SetAlpha(1)
                end
            else
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m0" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m0"
                    button.gref.indicator.mana["Icontm1"]:SetAlpha(0)
                    button.gref.indicator.mana["Icontm2"]:SetAlpha(0)
                    button.gref.indicator.mana["Icontm3"]:SetAlpha(0)
                end
            end
        else
            if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m0" then
                HealBot_Action_rCalls[button.unit]["manaIndicator"]="m0"
                button.gref.indicator.mana["Icontm1"]:SetAlpha(0)
                button.gref.indicator.mana["Icontm2"]:SetAlpha(0)
                button.gref.indicator.mana["Icontm3"]:SetAlpha(0)
            end
        end
    elseif HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m0" then
        HealBot_Action_rCalls[button.unit]["manaIndicator"]="m0"
        button.gref.indicator.mana["Icontm1"]:SetAlpha(0)
        button.gref.indicator.mana["Icontm2"]:SetAlpha(0)
        button.gref.indicator.mana["Icontm3"]:SetAlpha(0)
    end
    --HealBot_setCall("HealBot_Action_CheckUnitLowMana")
end

function HealBot_Action_ShowDirectionArrow(button)
    if button.status.range==0 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and
       (not Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIRMOUSE"] or button==(HealBot_Data["TIPBUTTON"] or "x")) then
        local hbX, hbY, hbD = HealBot_Direction_Check(button.unit)
        if hbD then
            if not button.status.dirarrowshown then 
                button.gref.icon["IconDirArrow"]:SetTexture("Interface\\AddOns\\HealBot\\Images\\arrow.blp")
                button.gref.icon["IconDirArrow"]:SetTexCoord(hbX, hbX + 0.109375, hbY, hbY + 0.08203125)
                button.status.dirarrowcords=hbD
                button.status.dirarrowshown=true
                button.gref.icon["IconDirArrow"]:Show()
            elseif button.status.dirarrowcords~=hbD then
                button.gref.icon["IconDirArrow"]:SetTexCoord(hbX, hbX + 0.109375, hbY, hbY + 0.08203125)
                button.status.dirarrowcords=hbD
            end
        elseif button.status.dirarrowshown then
            HealBot_Action_HideDirectionArrow(button)
        end
    elseif button.status.dirarrowshown then
        HealBot_Action_HideDirectionArrow(button)
    end
    --HealBot_setCall("HealBot_Action_ShowDirectionArrow")
end

function HealBot_Action_HideDirectionArrow(button)
    button.status.dirarrowshown=false
    button.gref.icon["IconDirArrow"]:Hide()
    --HealBot_setCall("HealBot_Action_HideDirectionArrow")
end

local grpFrame={}
function HealBot_Action_InitFrames()
    for x=1,10 do
        grpFrame[x]=_G["f"..x.."_HealBot_Action"]
        if not grpFrame[x]:GetLeft() then
            if not InCombatLockdown() then
                grpFrame[x]:ClearAllPoints()
                grpFrame[x]:SetPoint("TOPLEFT","UIParent","TOPLEFT",0,0)
            else
                HealBot_setOptions_Timer(9960)
            end
        end
    end
end

function HealBot_Action_ShowPanel(hbCurFrame)
    if HealBot_Config.DisabledNow==0 then
        if not grpFrame[hbCurFrame]:IsVisible() then 
            ShowUIPanel(grpFrame[hbCurFrame])
        end
        HealBot_Skins_ResetSkin("frameheader",nil,hbCurFrame)
    end
    --HealBot_setCall("HealBot_Action_ShowPanel"..hbCurFrame)
end

function HealBot_Action_HidePanel(hbCurFrame)
    if grpFrame[hbCurFrame]:IsVisible() then 
        HideUIPanel(grpFrame[hbCurFrame])
    end
    --HealBot_setCall("HealBot_Action_HidePanel"..hbCurFrame)
end

function HealBot_Action_ResetUnitStatus()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_Refresh(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_Refresh(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_Refresh(xButton)
    end
    --HealBot_setCall("HealBot_Action_ResetUnitStatus")
end

function HealBot_Action_ResetActiveUnitStatus()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if not xButton.status.reserved and xButton.status.current>3 then
            HealBot_Action_Refresh(xButton)
        end
    end
    for xUnit,xButton in pairs(HealBot_Private_Button) do
        if not xButton.status.reserved and xButton.status.current>3 then
            HealBot_Action_Refresh(xButton)
        end
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        if not xButton.status.reserved and xButton.status.current>3 then
            HealBot_Action_Refresh(xButton)
        end
    end
    --HealBot_setCall("HealBot_Action_ResetActiveUnitStatus")
    --HealBot_setCall("HealBot_Action_ResetActiveUnitStatus")
end

local function HealBot_Action_ResetrCallsUnit(unit)
    if not HealBot_Action_rCalls[unit] then HealBot_Action_rCalls[unit]={} end
    HealBot_Action_rCalls[unit]["powerIndicator"]="notSet"
    HealBot_Action_rCalls[unit]["manaIndicator"]="notSet"
    HealBot_Action_rCalls[unit]["barText"]="notSet"
    HealBot_Aggro_ResetrCallsUnit(unit)
    --HealBot_setCall("HealBot_Action_ResetrCallsUnit")
end

function HealBot_Action_ResetrCalls()
    for xUnit,_ in pairs(HealBot_Unit_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
    for xUnit,_ in pairs(HealBot_Private_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
    for xUnit,_ in pairs(HealBot_Pet_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
    for xUnit,_ in pairs(HealBot_Enemy_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
    --HealBot_setCall("HealBot_Action_ResetrCalls")
end 

local function HealBot_Action_InitButton(button)
    HealBot_Action_setRegisterForClicks(button)
    button.aura={}
    button.aura.buff={}
    button.aura.buff.recheck={}
    button.aura.debuff={}
    button.status={}
    button.update={}
    button.checks={}
    button.health={}
    button.spells={}
    button.aggro={}
    button.mana={}
    button.text={}
    button.icon={}
    button.icon.debuff={}
    button.icon.buff={}
    button.aux={}
    for x=1,10 do
        button.aux[x]={}
    end
    button.gref={}
    button.gref.aux={}
    button.gref.txt={}
    button.gref.txt.expire={}
    button.gref.txt.count={}
    button.gref.icon={}
    button.gref.indicator={}
    button.gref.indicator.aggro={}
    button.gref.indicator.mana={}
    button.gref.indicator.power={}
    button.gref["Bar"]=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
    button.gref["Bar"]:UnregisterAllEvents()
    button.gref["Bar"]:SetMinMaxValues(0,1000)
    button.gref["InHeal"]=_G["HealBot_Action_HealUnit"..button.id.."Bar2"]
    button.gref["InHeal"]:UnregisterAllEvents()
    button.gref["InHeal"]:SetMinMaxValues(0,1000)
    button.gref["InHeal"]:SetValue(0)
    button.gref["Back"]=_G["HealBot_Action_HealUnit"..button.id.."Bar5"]
    button.gref["Back"]:UnregisterAllEvents()
    button.gref["Back"]:SetValue(100)
    button.gref["Back"]:SetMinMaxValues(0,100)
    button.gref["Absorb"]=_G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    button.gref["Absorb"]:UnregisterAllEvents()
    button.gref["Absorb"]:SetMinMaxValues(0,1000)
    button.gref["Absorb"]:SetValue(0)
    button.gref["DirArrow"]=_G["HealBot_Action_HealUnit"..button.id.."BarDir"]
    button.gref["DirArrow"]:UnregisterAllEvents()
    button.gref["DirArrow"]:ClearAllPoints();
    button.gref["DirArrow"]:SetPoint("TOP",button,"TOP",-1,0);
    button:Enable();
    button.gref.aux[1]=_G["HealBot_Action_HealUnit"..button.id.."Aux1"]
    button.gref.aux[2]=_G["HealBot_Action_HealUnit"..button.id.."Aux2"]
    button.gref.aux[3]=_G["HealBot_Action_HealUnit"..button.id.."Aux3"]
    button.gref.aux[4]=_G["HealBot_Action_HealUnit"..button.id.."Aux4"]
    button.gref.aux[5]=_G["HealBot_Action_HealUnit"..button.id.."Aux5"]
    button.gref.aux[6]=_G["HealBot_Action_HealUnit"..button.id.."Aux6"]
    button.gref.aux[7]=_G["HealBot_Action_HealUnit"..button.id.."Aux7"]
    button.gref.aux[8]=_G["HealBot_Action_HealUnit"..button.id.."Aux8"]
    button.gref.aux[9]=_G["HealBot_Action_HealUnit"..button.id.."Aux9"]
    for x=1,9 do
        button.gref.aux[x]:UnregisterAllEvents()
        button.gref.aux[x]:SetMinMaxValues(0,1000)
    end
    button.gref.txt["text"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text"]
    button.gref.txt["text2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text2"]
    button.gref.txt["enemycast"]=_G["HealBot_Action_HealUnit"..button.id.."Aux2_text"]
    button.gref.icon["Icontm1"]=_G["HealBot_Action_HealUnit"..button.id.."BarIcontm1"]
    button.gref.icon["Icontm2"]=_G["HealBot_Action_HealUnit"..button.id.."BarIcontm2"]
    button.gref.icon["Icontm3"]=_G["HealBot_Action_HealUnit"..button.id.."BarIcontm3"]
    button.gref.icon["IconDirArrow"]=_G["HealBot_Action_HealUnit"..button.id.."BarDirIcon17"]
    button.gref.icon[1]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon1"]
    button.gref.icon[2]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon2"]
    button.gref.icon[3]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon3"]
    button.gref.icon[4]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon4"]
    button.gref.icon[5]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon5"]
    button.gref.icon[6]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon6"]
    button.gref.icon[7]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon7"]
    button.gref.icon[8]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon8"]
    button.gref.icon[9]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon9"]
    button.gref.icon[10]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon10"]
    button.gref.icon[51]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon51"]
    button.gref.icon[52]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon52"]
    button.gref.icon[53]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon53"]
    button.gref.icon[54]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon54"]
    button.gref.icon[55]=_G["HealBot_Action_HealUnit"..button.id.."BarIcon55"]
    button.gref.txt.expire[1]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire1"]
    button.gref.txt.count[1]=_G["HealBot_Action_HealUnit"..button.id.."BarCount1"]
    button.gref.txt.expire[2]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire2"]
    button.gref.txt.count[2]=_G["HealBot_Action_HealUnit"..button.id.."BarCount2"]
    button.gref.txt.expire[3]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire3"]
    button.gref.txt.count[3]=_G["HealBot_Action_HealUnit"..button.id.."BarCount3"]
    button.gref.txt.expire[4]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire4"]
    button.gref.txt.count[4]=_G["HealBot_Action_HealUnit"..button.id.."BarCount4"]
    button.gref.txt.expire[5]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire5"]
    button.gref.txt.count[5]=_G["HealBot_Action_HealUnit"..button.id.."BarCount5"]
    button.gref.txt.expire[6]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire6"]
    button.gref.txt.count[6]=_G["HealBot_Action_HealUnit"..button.id.."BarCount6"]
    button.gref.txt.expire[7]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire7"]
    button.gref.txt.count[7]=_G["HealBot_Action_HealUnit"..button.id.."BarCount7"]
    button.gref.txt.expire[8]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire8"]
    button.gref.txt.count[8]=_G["HealBot_Action_HealUnit"..button.id.."BarCount8"]
    button.gref.txt.expire[9]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire9"]
    button.gref.txt.count[9]=_G["HealBot_Action_HealUnit"..button.id.."BarCount9"]
    button.gref.txt.expire[10]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire10"]
    button.gref.txt.count[10]=_G["HealBot_Action_HealUnit"..button.id.."BarCount10"]
    button.gref.txt.expire[51]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire51"]
    button.gref.txt.count[51]=_G["HealBot_Action_HealUnit"..button.id.."BarCount51"]
    button.gref.txt.expire[52]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire52"]
    button.gref.txt.count[52]=_G["HealBot_Action_HealUnit"..button.id.."BarCount52"]
    button.gref.txt.expire[53]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire53"]
    button.gref.txt.count[53]=_G["HealBot_Action_HealUnit"..button.id.."BarCount53"]
    button.gref.txt.expire[54]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire54"]
    button.gref.txt.count[54]=_G["HealBot_Action_HealUnit"..button.id.."BarCount54"]
    button.gref.txt.expire[55]=_G["HealBot_Action_HealUnit"..button.id.."BarExpire55"]
    button.gref.txt.count[55]=_G["HealBot_Action_HealUnit"..button.id.."BarCount55"]
    button.gref.indicator.aggro["Iconal1"]=_G["HealBot_Action_HealUnit"..button.id.."BarIconal1"]
    button.gref.indicator.aggro["Iconal2"]=_G["HealBot_Action_HealUnit"..button.id.."BarIconal2"]
    button.gref.indicator.aggro["Iconal3"]=_G["HealBot_Action_HealUnit"..button.id.."BarIconal3"]
    button.gref.indicator.aggro["Iconar1"]=_G["HealBot_Action_HealUnit"..button.id.."BarIconar1"]
    button.gref.indicator.aggro["Iconar2"]=_G["HealBot_Action_HealUnit"..button.id.."BarIconar2"]
    button.gref.indicator.aggro["Iconar3"]=_G["HealBot_Action_HealUnit"..button.id.."BarIconar3"]
    button.gref.indicator.mana["Icontm1"]=_G["HealBot_Action_HealUnit"..button.id.."BarIcontm1"]
    button.gref.indicator.mana["Icontm2"]=_G["HealBot_Action_HealUnit"..button.id.."BarIcontm2"]
    button.gref.indicator.mana["Icontm3"]=_G["HealBot_Action_HealUnit"..button.id.."BarIcontm3"]
    button.gref.indicator.power[1]=_G["HealBot_Action_HealUnit"..button.id.."Aux1Icon1"]
    button.gref.indicator.power[2]=_G["HealBot_Action_HealUnit"..button.id.."Aux1Icon2"]
    button.gref.indicator.power[3]=_G["HealBot_Action_HealUnit"..button.id.."Aux1Icon3"]
    button.gref.indicator.power[4]=_G["HealBot_Action_HealUnit"..button.id.."Aux1Icon4"]
    button.gref.indicator.power[5]=_G["HealBot_Action_HealUnit"..button.id.."Aux1Icon5"]
    --HealBot_setCall("HealBot_Action_InitButton")
end

local tPrepButton=""
local function HealBot_Action_PrepButton(button)
    button.guid="nil"
    button.unit="nil"
    button.health.current=99
    button.health.max=100
    button.health.incoming=0
    button.health.absorbs=0
    button.health.overheal=0
    button.health.update=false
    button.health.updhealth=false
    button.health.updincoming=false
    button.health.updabsorbs=false
    button.health.rcol=0
    button.health.gcol=0
    button.mana.current=0
    button.mana.max=0
    button.mana.type=-1
    button.mana.r=0
    button.mana.g=0
    button.mana.b=1
    button.status.current=0
    button.status.range=-9
    button.status.unittype=1
    button.status.offline=false
    button.status.enabled=false
    button.status.dirarrowcords=0 
    button.status.dirarrowshown=false 
    button.status.reserved=false
    button.status.throttle=0
    button.spells.castpct=-1
    button.spells.rangecheck=HealBot_RangeSpells["HEAL"]
    button.aura.buff.name=false
    button.aura.buff.id=0
    button.icon.buff.count=0
    button.aura.buff.priority=99
    button.aura.buff.nextcheck=false
    button.aura.buff.nextupdate=GetTime()
    button.aura.debuff.type=false
    button.aura.debuff.name=false
    button.aura.debuff.id=0
    button.icon.debuff.count=0
    button.icon.debuff.targeticon=0
    button.icon.debuff.classtexture=false
    button.icon.debuff.readycheck=false
    button.aura.debuff.priority=99
    button.aura.debuff.nextupdate=GetTime()
    button.aura.check=true
    button.aggro.status=0
    button.aggro.threatpct=0
    button.text.health="100"
    button.text.name=" "
    button.text.tag=""
    button.text.r=1
    button.text.g=1
    button.text.b=1
    button.text.classtrim="XXXX"
    button.text.nameupdate=true
    button.text.healthupdate=true
    button.spec=" "
    button.reset=true 
    button.gref["Bar"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Bar"]:SetValue(1000)
    button.gref["InHeal"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Back"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]:SetStatusBarColor(0, 0, 0, 0)
    for x=1,9 do
        button.gref.aux[x]:SetStatusBarColor(0, 0, 0, 0)
    end
    --HealBot_setCall("HealBot_Action_PrepButton")
end
 
local function HealBot_Action_CreateButton(hbCurFrame)
    if HealBot_ActiveButtons[0]>998 then HealBot_ActiveButtons[0]=1 end
    local tryId,freeId=HealBot_ActiveButtons[0],nil
    if not HealBot_ActiveButtons[tryId] then
        freeId=tryId
    else
        for i=1,998 do
            if not HealBot_ActiveButtons[i] then
                freeId=i
                break
            end
        end
    end
    if freeId then 
        HealBot_ActiveButtons[freeId]=true 
        local gn="HealBot_Action_HealUnit"..freeId
        local ghb=_G[gn]
        if not ghb then 
            ghb=CreateFrame("Button", gn, grpFrame[hbCurFrame], "HealBotButtonSecureTemplate") 
            ghb.id=freeId
            HealBot_Action_InitButton(ghb)
            HealBot_Action_PrepButton(ghb)
            ghb.frame=hbCurFrame
        end
        HealBot_ActiveButtons[0]=freeId+1
        return ghb
    else
        return nil
    end
    --HealBot_setCall("HealBot_Action_CreateButton")
end

local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl"}
local hbAttribsMinReset = {}
local HB_button,HB_prefix=nil,nil
local showHBmenu=nil

local function HealBot_Action_SpellCmdCodes(cType, cText)
    local cID=nil
    if cType == "ENEMY" then
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_FOCUS then
            cID="B"
        end
    else
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_ASSIST then
            cID="B"
        elseif cText == HEALBOT_FOCUS then
            cID="C"
        elseif cText == HEALBOT_MENU then
            cID="D"
        elseif cText == HEALBOT_HBMENU then
            cID="E"
        elseif cText == HEALBOT_STOP then
            cID="F"
        elseif cText == HEALBOT_TELL.." ..." then
            cID="G"
        end
    end
    --HealBot_setCall("HealBot_Action_SpellCmdCodes")
    return cID
end

local function HealBot_Action_SpellCmdText(cType, cID)
    local cText=nil
    if cType == "ENEMY" then
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_FOCUS
        end
    else
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_ASSIST
        elseif cID == "C" then
            cText=HEALBOT_FOCUS
        elseif cID == "D" then
            cText=HEALBOT_MENU
        elseif cID == "E" then
            cText=HEALBOT_HBMENU
        elseif cID == "F" then
            cText=HEALBOT_STOP
        elseif cID == "G" then
            cText=HEALBOT_TELL.." ..."
        end
    end
    --HealBot_setCall("HealBot_Action_SpellCmdText")
    return cText
end

function HealBot_Action_SetSpell(cType, cKey, sText)
    if sText and HealBot_Text_Len(sText)>0 then
        local cID = HealBot_Action_SpellCmdCodes(cType, sText)
        if cID then 
            sText = "C:"..cID 
        else
            local _, _, _, _, _, _, spellId = GetSpellInfo(sText)
            if spellId then 
                sText = "S:"..spellId
            else
                local itemID = GetItemInfoInstant(sText)
                if itemID then sText = "I:"..itemID end
            end
        end
    end
    if cType == "ENABLED" then
        HealBot_Config_Spells.EnabledKeyCombo[cKey] = sText
    elseif cType == "DISABLED" then
        HealBot_Config_Spells.DisabledKeyCombo[cKey] = sText
    else
        HealBot_Config_Spells.EnemyKeyCombo[cKey] = sText
    end
    --HealBot_setCall("HealBot_Action_SetSpell")
end

local HealBot_Action_SpellCache={}
HealBot_Action_SpellCache["ENABLED"]={}
HealBot_Action_SpellCache["DISABLED"]={}
HealBot_Action_SpellCache["ENEMY"]={}

function HealBot_Action_ClearSpellCache()
    HealBot_Action_SpellCache["ENABLED"]={}
    HealBot_Action_SpellCache["DISABLED"]={}
    HealBot_Action_SpellCache["ENEMY"]={}
    --HealBot_setCall("HealBot_Action_ClearSpellCache")
end

local vSpellText=nil
function HealBot_Action_GetSpell(cType, cKey)
    vSpellText=HealBot_Action_SpellCache[cType][cKey]
    if not vSpellText then
        if cType == "ENABLED" then
            vSpellText=HealBot_Config_Spells.EnabledKeyCombo[cKey]
        elseif cType == "DISABLED" then
            vSpellText=HealBot_Config_Spells.DisabledKeyCombo[cKey]
        else
            vSpellText=HealBot_Config_Spells.EnemyKeyCombo[cKey]
        end
        if vSpellText and HealBot_Text_Len(vSpellText)>2 then
            local sType,sID = string.split(":", vSpellText)
            if sType and sID then
                if sType == "C" then
                    vSpellText=HealBot_Action_SpellCmdText(cType, sID)
                elseif sType == "I" then
                    vSpellText=GetItemInfo(sID)
                else
                    vSpellText=GetSpellInfo(sID)
                    if HEALBOT_GAME_VERSION<4 then
                        local rank = GetSpellSubtext(sID)
                        if rank then
                            local knownHealSpells=HealBot_Init_retFoundHealSpells()
                            if knownHealSpells[vSpellText] then
                                vSpellText=vSpellText.."("..rank..")"
                            end
                        end
                    end
                end
            end
        end
        if vSpellText then HealBot_Action_SpellCache[cType][cKey]=vSpellText end
        --HealBot_setCall("HealBot_Action_GetSpell")
    end
    return vSpellText
end

local vAttribSpellName=""
function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("ENABLED", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnabledSpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledSpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledSpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledAvoidBlueCursor[HB_combo_prefix]
    else
        return nil 
    end
    --HealBot_setCall("HealBot_Action_AttribSpellPattern")
end

function HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("DISABLED", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.DisabledSpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.DisabledSpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.DisabledSpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.DisabledAvoidBlueCursor[HB_combo_prefix]
    else
        return nil 
    end
    --HealBot_setCall("HealBot_Action_AttribDisSpellPattern")

end

function HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("ENEMY", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnemySpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnemyAvoidBlueCursor[HB_combo_prefix]
    else
        return nil 
    end
    --HealBot_setCall("HealBot_Action_AttribEnemySpellPattern")

end

local hbCustomName={}
local function HealBot_Action_CustomName(cName)
    local xGUID=hbCustomName["GUID"]
    local isAdd=hbCustomName["isAdd"]
    local isPerm=hbCustomName["isPerm"]
    if isAdd then
        if isPerm then
            HealBot_Globals.HealBot_customPermUserName[xGUID]=cName
        end
        HealBot_customTempUserName[xGUID]=cName
    else
        if isPerm then
            HealBot_Globals.HealBot_customPermUserName[xGUID]=nil
        else
            HealBot_customTempUserName[xGUID]=nil
        end
    end
end

local function HealBot_Action_GetCustomNameDialog(hbGUID, isAdd, isPerm)
    local dText=HEALBOT_WORDS_ADDTEMPCUSTOMNAME
    local cName = nil
    hbCustomName["GUID"]=hbGUID
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    if isPerm then dText=HEALBOT_WORDS_ADDPERMCUSTOMNAME end
    StaticPopupDialogs["HEALBOT_WORDS_CUSTOMNAME"] = {
        text = dText,
        button1 = HEALBOT_WORDS_CUSTOMNAME,
        button2 = HEALBOT_WORD_CANCEL,
        hasEditBox = 1,
        whileDead = 1,
        hideOnEscape = 1,
        timeout = 0,
        OnShow = function(self)
            getglobal(self:GetName().."EditBox"):SetText("");
        end,
        OnAccept = function(self)
              cName = getglobal(self:GetName().."EditBox"):GetText();
              HealBot_Action_CustomName(cName)
        end,
    };
    StaticPopup_Show("HEALBOT_WORDS_CUSTOMNAME");
end

local function HealBot_Action_DelCustomName(hbGUID, isAdd, isPerm)
    hbCustomName["GUID"]=hbGUID
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    HealBot_Action_CustomName()
    --HealBot_setCall("HealBot_Action_DelCustomName")
end

local function HealBot_Action_ToggelMyFriend(unit)
    local xGUID=UnitGUID(unit)
    if xGUID then
        if HealBot_Config.MyFriend==xGUID then
            HealBot_Config.MyFriend="x"
        else
            HealBot_Config.MyFriend=xGUID
        end
    end
    HealBot_AuraCheck(unit)
    --HealBot_setCall("HealBot_Action_ToggelMyFriend")
end

local function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
    local info
    level = level or 1;
    if level==1 then
        info = UIDropDownMenu_CreateInfo();
        info.isTitle = true
        info.text = HealBot_GetUnitName(self.unit)
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_AlwaysEnabled[UnitGUID(self.unit)] then
            info.text = HEALBOT_SKIN_DISTEXT;
        else
            info.text = HEALBOT_SKIN_ENTEXT;
        end
        info.func = function() HealBot_Action_Toggle_Enabled(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Config.MyFriend==UnitGUID(self.unit) then
            info.text = HEALBOT_WORDS_UNSET.." "..HEALBOT_OPTIONS_MYFRIEND;
        else
            info.text = HEALBOT_WORDS_SETAS.." "..HEALBOT_OPTIONS_MYFRIEND
        end
        info.func = function() HealBot_Action_ToggelMyFriend(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 1);

        if UnitIsPlayer(self.unit) then
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_WORDS_CUSTOMNAME
            info.hasArrow = true; 
            info.menuList = "cNames"
            UIDropDownMenu_AddButton(info, 1);

            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_MYTARGET
            info.hasArrow = true; 
            info.menuList = "myHeals"
            UIDropDownMenu_AddButton(info, 1);
            
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_PRIVATETANKS
            info.hasArrow = true; 
            info.menuList = "pTanks"
            UIDropDownMenu_AddButton(info, 1);
            
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_PRIVATEHEALERS
            info.hasArrow = true; 
            info.menuList = "pHeals"
            UIDropDownMenu_AddButton(info, 1);
        else
            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_customTempUserName[UnitGUID(self.unit)] then
                info.text = HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
                info.func = function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, false); end;
            else
                info.text = HEALBOT_WORDS_ADDTEMPCUSTOMNAME
                info.func = function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, false); end;
            end
            UIDropDownMenu_AddButton(info, 1);
            
            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetMyHealTarget(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET
            end
            info.func = function() HealBot_Panel_ToggelHealTarget(self.unit, true); end;
            UIDropDownMenu_AddButton(info, 1);

            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetPrivateTanks(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
            end
            info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);

            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetPrivateHealers(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
            end
            info.func = function() HealBot_Panel_ToggelPrivateHealers(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);
        end

        if HEALBOT_GAME_VERSION>3 then 
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            if HealBot_retHbFocus(self.unit) then
                info.text = HEALBOT_WORD_CLEAR.." "..HEALBOT_WORD_HBFOCUS;
                info.hasArrow = false;
                info.func = function() HealBot_ToggelFocusMonitor(self.unit); end;
            else
                info.text = HEALBOT_WORD_SET.." "..HEALBOT_WORD_HBFOCUS
                info.hasArrow = true; 
                info.menuList = "hbFocus"
            end
            UIDropDownMenu_AddButton(info, 1);
        end
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_RESET
        info.func = function() HealBot_Reset_Unit(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_PANEL_BLACKLIST
        info.func = function() HealBot_Panel_AddBlackList(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_CANCEL
        UIDropDownMenu_AddButton(info, 1);
    elseif menuList=="cNames" then
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Globals.HealBot_customPermUserName[UnitGUID(self.unit)] then
            info.text = HEALBOT_WORDS_REMOVEPERMCUSTOMNAME
            info.func = function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, true); end;
        else
            info.text = HEALBOT_WORDS_ADDPERMCUSTOMNAME
            info.func = function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, true); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_customTempUserName[UnitGUID(self.unit)] then
            info.text = HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
            info.func = function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, false); end;
        else
            info.text = HEALBOT_WORDS_ADDTEMPCUSTOMNAME
            info.func = function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, false); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="myHeals" then        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
           
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_MYTARGET;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_MYTARGET
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="pTanks" then
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="pHeals" then
		info = UIDropDownMenu_CreateInfo();
		info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateHealers(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
        end
        info.func = function() HealBot_Panel_ToggelPrivateHealers(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
		info = UIDropDownMenu_CreateInfo();
		info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateHealers(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
        end
        info.func = function() HealBot_Panel_ToggelPrivateHealers(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="hbFocus" and HEALBOT_GAME_VERSION>3 then
        info = UIDropDownMenu_CreateInfo();
        info.text = HEALBOT_WORD_ALLZONE
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.unit, "all"); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        local _,z = IsInInstance()
        if z=="pvp" or z == "arena" then 
            info.text = HEALBOT_WORD_BATTLEGROUND
        elseif z~="none" then
            info.text=GetRealZoneText()
        else
            info.text = HEALBOT_WORD_OUTSIDE
        end
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.unit, z); end;
        UIDropDownMenu_AddButton(info, 2);
    end
    --HealBot_setCall("HealBot_Action_hbmenuFrame_DropDown_Initialize")
end

local function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, spellAvoidBC, unit, status)
    local smName=""
    local scText=""
    local spellType="help"
    if status=="Enemy" then spellType="harm" end
    scText="/cast [@"..unit..","..spellType.."] "..spellName..";\n"

    if HealBot_Globals.MacroSuppressError==1 then smName=smName..'/hb se3\n' end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName..'/hb se1\n' end
    if spellTar then smName=smName.."/target "..unit..";\n" end
    if spellTrin1 then smName=smName.."/use 13;\n" end
    if spellTrin2 then smName=smName.."/use 14;\n" end
    if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se2\n" end
    if HealBot_Globals.MacroSuppressError==1 then smName=smName..'/hb se4\n' end
    smName=smName..scText
    if spellAvoidBC then smName=smName.."/use 4;" end
    if strlen(smName)>255 then
        smName=""
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se1\n" end
        if spellTar then smName=smName.."/target "..unit..";\n" end
        if spellTrin1 then smName=smName.."/use 13;\n" end
        if spellTrin2 then smName=smName.."/use 14;\n" end
        if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se2\n" end
        smName=smName..scText
        if spellAvoidBC then smName=smName.."/use 4;" end
        if strlen(smName)>255 then
            smName=""
            if spellTar then smName=smName.."/target "..unit..";\n" end
            if spellTrin1 then smName=smName.."/use 13;\n" end
            if spellTrin2 then smName=smName.."/use 14;\n" end
            if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
            smName=smName..scText
            if spellAvoidBC then smName=smName.."/use 4;" end
            if strlen(smName)>255 then
                smName=""
                if spellTrin1 then smName=smName.."/use 13;\n" end
                if spellTrin2 then smName=smName.."/use 14;\n" end
                smName=smName..scText
                if spellAvoidBC then smName=smName.."/use 4;" end
                if strlen(smName)>255 then
                    smName=spellName
                end
            end
        end
    end
    --HealBot_setCall("HealBot_Action_AlterSpell2Macro")
    return smName
end

local function HealBot_Action_UnitID(unit)
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
    --HealBot_setCall("HealBot_Action_UnitID")
    return unit
end

local function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,status,j)
    local HB_prefix = "";
    local buttonType="helpbutton"
    local sType="heal"
    if strlen(bkey)>1 then
        HB_prefix = strlower(bkey).."-"
    end
    local HB_combo_prefix = bkey..bbutton..HealBot_Config.CurrentSpec;
    local sName,sTar,sTrin1,sTrin2,AvoidBC=nil,0, 0, 0, 0
    if status=="Enabled" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    elseif status=="Disabled" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    elseif status=="Enemy" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
        buttonType="harmbutton"
        sType="harm"
    elseif status=="Fixed" then
        if j==1 then
            sName=strlower(HEALBOT_MENU)
        elseif j==2 then
            sName=strlower(HEALBOT_HBMENU)
        end
    end
    if sName then
        hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=false
        local mId=GetMacroIndexByName(sName)
        if strlower(sName)==strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix..buttonType..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_FOCUS) then
            button:SetAttribute(HB_prefix..buttonType..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix..buttonType..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strsub(strlower(sName),1,4)==strlower(HEALBOT_TELL) then
            local mText='/script local n=UnitName("hbtarget");SendChatMessage("hbMSG","WHISPER",nil,n)'
            mText=string.gsub(mText,"hbtarget",button.unit)
            mText=string.gsub(mText,"hbMSG", strtrim(strsub(sName,5)))
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "togglemenu")
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) and UnitGUID(button.unit) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu = function()
                local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                HBFriendsDropDown.unit = button.unit
                HBFriendsDropDown.name = HealBot_GetUnitName(button.unit, button.guid)
                HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
                HBFriendsDropDown.displayMode = "MENU"
                ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
            end
            button.showhbmenu = showHBmenu
        elseif HealBot_Spell_Names[sName] then
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, button.unit, status)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
            end
        elseif mId ~= 0 then
            local _,_,mText=GetMacroInfo(mId)
            if HealBot_UnitPet(button.unit) and UnitExists(HealBot_UnitPet(button.unit)) then
                mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(button.unit))
            end
            mText=string.gsub(mText,"hbtargettargettarget",button.unit.."targettarget")
            mText=string.gsub(mText,"hbtargettarget",button.unit.."target")
            mText=string.gsub(mText,"hbtarget",button.unit)
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j,"macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
        elseif IsUsableItem(sName) or HealBot_IsItemInBag(sName) then
            button:SetAttribute(HB_prefix..buttonType..j, "item"..j);
            button:SetAttribute(HB_prefix.."type-item"..j, "item");
            button:SetAttribute(HB_prefix.."item-item"..j, sName);
        else
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, button.unit, status)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
            end
        end
        button:SetAttribute(HB_prefix.."checkselfcast"..j, "false")
    else
        button:SetAttribute(HB_prefix..buttonType..j, nil);
    end
    --HealBot_setCall("HealBot_Action_SetButtonAttrib")
end

local function HealBot_Action_SetAllButtonAttribs(button,status)
    if HealBot_Action_luVars["clearSpellCache"] then
        HealBot_Action_luVars["clearSpellCache"]=false
        HealBot_Action_ClearSpellCache()
    end
    for x=1,15 do
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
            if not hbAttribsMinReset[button.frame..button.id..HB_prefix..status..x] then
                HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],status,x)
            end
        end
        HealBot_Action_SetButtonAttrib(button,"Left","Alt-Ctrl-Shift","Fixed",1)
        HealBot_Action_SetButtonAttrib(button,"Right","Alt-Ctrl-Shift","Fixed",2)
    end
    --HealBot_setCall("HealBot_Action_SetAllButtonAttribs")
end

local tSetHealButton={}
local vSetHealUnitUpdate=false
local vEnemyUnitsWithEvents={["boss1"]=true,["boss2"]=true,["boss3"]=true,["boss4"]=true,
                             ["arena1"]=true,["arena2"]=true,["arena3"]=true,["arena4"]=true,["arena5"]=true}
function HealBot_Action_SetHealButton(unit,hbGUID,hbCurFrame,unitType)
    tSetHealButton=false
    if hbGUID then
        vSetHealUnitUpdate=false
        if unitType<5 then
            tSetHealButton=HealBot_Private_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        elseif unitType>10 then
            tSetHealButton=HealBot_Enemy_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        elseif unitType>6 and unitType<9 then
            tSetHealButton=HealBot_Pet_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        else
            tSetHealButton=HealBot_Unit_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        end
        if not tSetHealButton then return nil end
        if tSetHealButton.frame~=hbCurFrame then
            tSetHealButton:ClearAllPoints()
            tSetHealButton:SetParent(grpFrame[hbCurFrame])
            tSetHealButton.frame=hbCurFrame
            HealBot_ResetBarSkinDone[tSetHealButton.id]=false
        end
        if tSetHealButton.unit~=unit or tSetHealButton.reset or tSetHealButton.guid~=hbGUID then
            tSetHealButton.reset=false
            tSetHealButton.unit=unit
            tSetHealButton.guid=hbGUID
            if unitType>10 then
                HealBot_Enemy_Button[unit]=tSetHealButton
                if vEnemyUnitsWithEvents[unit] then
                    tSetHealButton.status.unittype = 12
                else
                    tSetHealButton.status.unittype = 11
                end
            elseif unitType>6 and unitType<9 then
                HealBot_Pet_Button[unit]=tSetHealButton    -- 1=Tanks  2=Healers  3=Self  4=Private  5=Raid  6=Group
                tSetHealButton.status.unittype = unitType  -- 7=vehicle  8=pet  9=target  10=focus  11=enemy without events  12=enemy with events        
            elseif unitType<5 then
                HealBot_Private_Button[unit]=tSetHealButton
                tSetHealButton.status.unittype = unitType
            else
                HealBot_Unit_Button[unit]=tSetHealButton 
                tSetHealButton.status.unittype = unitType
            end
            if tSetHealButton.status.offline and UnitIsConnected(unit) then
                tSetHealButton.status.offline=false
            end
            tSetHealButton:SetAttribute("unit", unit);
            HealBot_Action_SetAllButtonAttribs(tSetHealButton,"Enemy")
            HealBot_Action_SetAllButtonAttribs(tSetHealButton,"Enabled")
            vSetHealUnitUpdate=true
        end
        if vSetHealUnitUpdate or unit=="target" or unit=="focus" or unitType==9 then
            tSetHealButton.text.r,tSetHealButton.text.g,tSetHealButton.text.b=HealBot_Action_ClassColour(unit)
            tSetHealButton.text.nameupdate=true
            tSetHealButton.text.healthupdate=true
            HealBot_Action_ResetrCallsUnit(unit)
            HealBot_Aura_setUnitIcons(tSetHealButton.id)
            if tSetHealButton.status.throttle<GetTime() then
                HealBot_BumpThrottleCtl(tSetHealButton)
            end
            tSetHealButton.spells.rangecheck=HealBot_RangeSpells["HEAL"]
            if unitType<9 then
                tSetHealButton.status.update=true
            else
                HealBot_UpdateUnit(tSetHealButton)
            end
            tSetHealButton.status.range=-9
        else
            HealBot_Action_SetClassIconTexture(tSetHealButton)
        end
        if not HealBot_ResetBarSkinDone[tSetHealButton.id] then
            HealBot_Skins_ResetSkin("bar",tSetHealButton)
            HealBot_ResetBarSkinDone[tSetHealButton.id]=true
        elseif hbCurFrame==10 and Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGET"] then
            HealBot_Skins_ResetSkinWidth(tSetHealButton)
        end
        if HealBot_Unit_Button[unit] then
            HealBot_Action_luVars["updateBucket"]=HealBot_Action_luVars["updateBucket"]+1
            if HealBot_Action_luVars["updateBucket"]>3 then HealBot_Action_luVars["updateBucket"]=1 end
            HealBot_AddPlayerButtonCache(unit, HealBot_Action_luVars["updateBucket"])
        end
    else
        return nil
    end
    --HealBot_setCall("HealBot_Action_SetHealButton")
    return tSetHealButton
end

function HealBot_Action_SetTestButton(hbCurFrame, unitText)
    local thb=HealBot_Unit_Button[unitText] or HealBot_Action_CreateButton(hbCurFrame)
    if thb then
        thb.unit=unitText
        thb.guid="TestBar"
        HealBot_Action_ResetrCallsUnit(thb.unit)
        HealBot_Unit_Button[unitText]=thb
        if thb.frame~=hbCurFrame then
            thb:ClearAllPoints()
            thb:SetParent(grpFrame[hbCurFrame])
            thb.frame=hbCurFrame
        end
        HealBot_Skins_ResetSkin("bar",thb)
    end
    return thb
end

function HealBot_Action_SetAllAttribs()
    HealBot_Action_luVars["ResetAttribs"]=true
    HealBot_nextRecalcParty(0)
end

function HealBot_Action_SethbFocusButtonAttrib(button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

local hbInitButtons=false
function HealBot_Action_ResethbInitButtons()
    hbInitButtons=false
end

function HealBot_Action_PartyChanged(changeType)
    if not InCombatLockdown() and HealBot_Data["PGUID"] then
        if HealBot_Action_luVars["ResetAttribs"] then
            for _,xButton in pairs(HealBot_Unit_Button) do
                xButton.reset=true
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                xButton.reset=true
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                xButton.reset=true
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                xButton.reset=true
            end
            for x,_ in pairs(hbAttribsMinReset) do
                hbAttribsMinReset[x]=false;
            end
            HealBot_Action_luVars["ResetAttribs"]=false
            HealBot_Action_luVars["clearSpellCache"]=true
        end
        if not hbInitButtons then
            for _,xButton in pairs(HealBot_Unit_Button) do
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            for _,xButton in pairs(HealBot_Private_Button) do
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            for _,xButton in pairs(HealBot_Enemy_Button) do
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            for _,xButton in pairs(HealBot_Pet_Button) do
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            hbInitButtons=true
            HealBot_nextRecalcParty(changeType)
        else
            HealBot_Panel_PartyChanged(HealBot_Data["UILOCK"], changeType)
        end
    else
        HealBot_nextRecalcParty(changeType)
    end
end

function HealBot_Action_DeleterCallsUnit(unit)
    HealBot_Action_rCalls[unit]=nil
end

local function HealBot_Action_DeleteButton(hbBarID)
    local dg=_G["HealBot_Action_HealUnit"..hbBarID]
    dg.unit="nil"
    HealBot_Action_PrepButton(dg)
    HealBot_Aura_RemoveIcons(dg)
    HealBot_clearAllAuxBar(dg)
    HealBot_Aura_delUnitIcons(hbBarID)
    HealBot_ActiveButtons[hbBarID]=false
    if hbBarID<HealBot_ActiveButtons[0] then HealBot_ActiveButtons[0]=hbBarID end
    --HealBot_AddDebug("Deleted button "..hbBarID)
end

HealBot_Action_luVars["PreCacheBars"]=1
local hbMarkedDeleteButtons={}
function HealBot_Action_DeleteMarkedButtons()
    if hbMarkedDeleteButtons[1] then
        HealBot_Action_DeleteButton(hbMarkedDeleteButtons[1])
        table.remove(hbMarkedDeleteButtons,1)
    elseif HealBot_Action_luVars["PreCacheBars"]<HealBot_Action_luVars["CacheSize"] then
        HealBot_Action_luVars["PreCacheBars"]=HealBot_Action_luVars["PreCacheBars"]+1
        local ghb=_G["HealBot_Action_HealUnit"..HealBot_Action_luVars["PreCacheBars"]]
        if not ghb then 
            HealBot_ActiveButtons[HealBot_Action_luVars["PreCacheBars"]]=true
            local gp=_G["f10_HealBot_Action"]
            ghb=CreateFrame("Button", "HealBot_Action_HealUnit"..HealBot_Action_luVars["PreCacheBars"], gp, "HealBotButtonSecureTemplate") 
            ghb.id=HealBot_Action_luVars["PreCacheBars"]
            HealBot_Action_InitButton(ghb)
            ghb.frame=0
            ghb.guid="nil"
            ghb.unit="nil"
            HealBot_Action_MarkDeleteButton(ghb)
        end
    end
end

function HealBot_Action_MarkDeleteButton(button)
    button:Hide()
    if button.status.unittype and button.status.unittype<5 then
        if HealBot_Private_Button[button.unit] then HealBot_Private_Button[button.unit]=nil end
    else
        if HealBot_Unit_Button[button.unit] then HealBot_Unit_Button[button.unit]=nil end
    end
    if HealBot_Enemy_Button[button.unit] then HealBot_Enemy_Button[button.unit]=nil end
    if HealBot_Pet_Button[button.unit] then HealBot_Pet_Button[button.unit]=nil end
    table.insert(hbMarkedDeleteButtons, button.id)
end

function HealBot_Action_Reset()
    local screenWidth = (ceil(GetScreenWidth()/2)) or 700
    local screenHeight = (ceil(GetScreenHeight()/2)) or 500
    for i=1, 10 do
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["X"]=(49+i)
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["Y"]=(49+i)
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"]=false
        if HealBot_Config.DisabledNow==0 and HealBot_FrameVisible[i] then
            HealBot_Action_setPoint(i)
            HealBot_Action_ShowPanel(i)
        end
        HealBot_Action_unlockFrame(i)
    end
end

function HealBot_Action_unlockFrame(hbCurFrame)
    Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]=false
    HealBot_Options_ActionLocked:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"])
end

local hbFrameSetPoint={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, setPoint)
    if setPoint then
        hbFrameSetPoint[hbCurFrame]=true
    else
        hbFrameGetCoords[hbCurFrame]=true
    end
    HealBot_setLuVars("reCheckActionFrames", true)
end

function HealBot_Action_CheckFrameSetPoint()
    for x=1,10 do
        if hbFrameSetPoint[x] then
            hbFrameSetPoint[x]=false
            hbFrameGetCoords[x]=false
            HealBot_Action_setPoint(x)
        elseif hbFrameGetCoords[x] then
            hbFrameGetCoords[x]=false
            HealBot_Action_CheckFrame(x, grpFrame[x])
        end
    end
end

local hbStickyFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_CheckStuckFrames(hbCurFrame)
    for x=hbCurFrame,10 do
        if hbStickyFrameGetCoords[x] then
            HealBot_Action_CheckFrame(x, grpFrame[x])
        end
    end
end

function HealBot_Action_CheckFrame(hbCurFrame, HBframe)
    if HBframe:GetTop() then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
            local fTop=HealBot_Comm_round(((HBframe:GetTop()/GetScreenHeight())*100),2)
            local fLeft=HealBot_Comm_round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fTop
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fLeft
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
            local fBottom=HealBot_Comm_round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
            local fLeft=HealBot_Comm_round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fBottom
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fLeft
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
            local fTop=HealBot_Comm_round(((HBframe:GetTop()/GetScreenHeight())*100),2)
            local fRight=HealBot_Comm_round(((HBframe:GetRight()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fTop
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fRight
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
            local fBottom=HealBot_Comm_round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
            local fRight=HealBot_Comm_round(((HBframe:GetRight()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fBottom
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fRight
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
            local fTop=HealBot_Comm_round(((HBframe:GetTop()/GetScreenHeight())*100),2)
            local fHcenter=HealBot_Comm_round(((HBframe:GetCenter()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fTop
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fHcenter
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
            local fVcenter=HealBot_Comm_round(((((HBframe:GetTop()+HBframe:GetBottom())/2)/GetScreenHeight())*100),2)
            local fLeft=HealBot_Comm_round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fVcenter
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fLeft
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
            local fVcenter=HealBot_Comm_round(((((HBframe:GetTop()+HBframe:GetBottom())/2)/GetScreenHeight())*100),2)
            local fRight=HealBot_Comm_round(((HBframe:GetRight()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fVcenter
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fRight
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
            local fBottom=HealBot_Comm_round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
            local fHcenter=HealBot_Comm_round(((HBframe:GetCenter()/GetScreenWidth())*100),2)
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fBottom
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fHcenter
        end
        HealBot_CheckFrame(hbCurFrame, HBframe) 
    elseif HealBot_FrameVisible[hbCurFrame] then
        HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, false)
    end
    --HealBot_setCall("HealBot_CheckActionFrame")
end

local vFrameSetPointX,vFrameSetPointY=0,0
function HealBot_Action_FrameSetPoint(hbCurFrame, gaf)
    gaf:ClearAllPoints();
    vFrameSetPointY=GetScreenHeight()*(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]/100)
    vFrameSetPointX=GetScreenWidth()*(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]/100)
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
        gaf:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
        gaf:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
        gaf:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
        gaf:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
        gaf:SetPoint("TOP","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
        gaf:SetPoint("LEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
        gaf:SetPoint("RIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
        gaf:SetPoint("BOTTOM","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
    end
end

function HealBot_Action_setPoint(hbCurFrame)
    if not hbCurFrame then return end
    if not InCombatLockdown() then  -- not InCombatLockdown() -- not HealBot_Data["UILOCK"]
        HealBot_Action_CheckFrame(hbCurFrame, grpFrame[hbCurFrame])
        if not HealBot_Action_StickyFrame(hbCurFrame, grpFrame[hbCurFrame]) then
            HealBot_Action_FrameSetPoint(hbCurFrame, grpFrame[hbCurFrame])
        end
        if hbCurFrame<10 then
            HealBot_Action_CheckStuckFrames(hbCurFrame)
        end
    else
        HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, true)
    end
end

local hbClassCols = {
          ["DEMO"] = {r=0.8,  g=0.1, b=0.8, },
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
      
function HealBot_Action_ClassColour(unit)
    local xClass=nil
    if unit and UnitClass(unit) then
        _,xClass=UnitClass(unit)    
    end
    if xClass then
        xClass = strsub(xClass,1,4)
    else
        xClass = "WARR"
    end
    return hbClassCols[xClass].r, hbClassCols[xClass].g, hbClassCols[xClass].b
end

function HealBot_Action_HideTooltip(self)
    if HealBot_Data["TIPBUTTON"] then
        HealBot_Data["TIPBUTTON"] = false;
        HealBot_setLuVars("ouTipUpdate", false)
        HealBot_Data["TIPTYPE"] = "NONE";
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_Data["INSPECT"] = false;
end

function HealBot_Action_HideTooltipFrame()
    if HealBot_Data["TIPUSE"] then
        if HealBot_Globals.UseGameTooltip then
            GameTooltip:Hide();
        else
            HealBot_Tooltip:Hide();
        end
    end
end

local hideFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Action_CheckHideFrames()
    for j=1,10 do
        hideFrame[j]=true
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
            break
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
            break
        end
    end
    for i=1, 10 do
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"] and HealBot_FrameVisible[i] and hideFrame[i] then
            HealBot_Action_HidePanel(i)
        end
    end
end

function HealBot_Action_ShowHideFrames(button)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["AUTOCLOSE"] then 
        if not InCombatLockdown() then
            if not HealBot_FrameVisible[button.frame] and HealBot_Config.DisabledNow==0 then
                if button.status.enabled then
                    HealBot_Action_ShowPanel(button.frame);
                end
            elseif HealBot_FrameVisible[button.frame] then
                if not button.status.enabled then
                    if button.status.unittype>6 or button.status.unittype<9 then
                        if not HealBot_Action_ShouldHealSomePet(button.frame) then
                            HealBot_Action_HidePanel(button.frame);
                        end
                    elseif not HealBot_Action_ShouldHealSome(button.frame) then
                        HealBot_Action_HidePanel(button.frame);
                    end
                end
            end
        end
    end
end

function HealBot_Action_Refresh(button)
    if button then
        HealBot_Action_UpdateDebuffButton(button)
        if UnitExists("target") and HealBot_Unit_Button["target"] and button.unit~="target" and UnitIsUnit("target",button.unit) then
            HealBot_Action_UpdateDebuffButton(HealBot_Unit_Button["target"])
        end
        if HEALBOT_GAME_VERSION>3 and UnitExists("focus") and HealBot_Unit_Button["focus"] and button.unit~="focus" and UnitIsUnit("focus",button.unit) then
            HealBot_Action_UpdateDebuffButton(HealBot_Unit_Button["focus"])
        end
    end
end

local hbAuxHightlightAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Action_clearAuxHightlightAssigned()
    for f=1,9 do
        hbAuxHightlightAssigned[f]={};
    end
end

function HealBot_Action_setAuxHightlightAssigned(frame, id)
    table.insert(hbAuxHightlightAssigned[frame], id)
end

local function HealBot_Action_UpdateHighlightBar(button)
    table.foreach(hbAuxHightlightAssigned[button.frame], function (x,id)
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=1
        end
        HealBot_setAuxBar(button, id, 1000, false)
    end)
end

local function HealBot_Action_ClearHighlightBar(button)
    table.foreach(hbAuxHightlightAssigned[button.frame], function (x,id)
        HealBot_clearAuxBar(button, id)
    end)
end

function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    HealBot_Action_ShowDirectionArrow(self)
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] and UnitExists(self.unit) then
        HealBot_Data["TIPBUTTON"] = self
        if not UnitIsFriend("player",self.unit) then
            HealBot_Data["TIPTYPE"] = "Enemy"
        elseif HealBot_Data["UILOCK"] and HealBot_Globals.DisableToolTipInCombat==false then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif UnitAffectingCombat(self.unit) then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif self.status.enabled or HealBot_Config.EnableHealthy then 
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif self.status.current<9 then
            HealBot_Data["TIPTYPE"] = "Disabled"
        end
        HealBot_Action_RefreshTooltip();
    end
    if self and self.aux then HealBot_Action_UpdateHighlightBar(self) end
    HealBot_MountsPets_lastbutton(self)
    --HealBot_setCall("HealBot_Action_HealUnit_OnEnter")
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELUP", "HealBot_Action_HealUnit"..self.id,"Button4");
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELDOWN", "HealBot_Action_HealUnit"..self.id,"Button5");
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    if self.status and self.status.dirarrowshown and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then
        HealBot_Action_HideDirectionArrow(self)
    end
    if self and self.aux then HealBot_Action_ClearHighlightBar(self) end
    HealBot_MountsPets_lastbutton(false)
   -- ClearOverrideBindings(HealBot_Action)
end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options);
end

local usedSmartCast=nil
local ModKey=nil
local abutton=nil
local aj=nil

local function HealBot_Action_UseSmartCast(bp)
    local sName=HealBot_Action_SmartCast(bp);
    if sName then
        if HealBot_Spell_Names[sName] then
            if bp.status.range>0 then
                bp:SetAttribute("helpbutton1", "heal1");
                bp:SetAttribute("type-heal1", "spell");
                bp:SetAttribute("spell-heal1", sName);
            end
        else
            local mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
               local _,_,mText=GetMacroInfo(mId)
                if HealBot_UnitPet(bp.unit) and UnitExists(HealBot_UnitPet(bp.unit)) then
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
    end
end

local function HealBot_Action_PreClick(self,button)
    --local xButton=self
    if self.id<999 and UnitExists(self.unit) and UnitIsFriend("player",self.unit) then
        HealBot_setLuVars("TargetUnitID", self.unit)
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
                HealBot_Panel_ToggelHealTarget(self.unit)
                if HealBot_Data["TIPUSE"] and HealBot_Globals.ShowTooltip then 
                    HealBot_Action_RefreshTargetTooltip(self) 
                end
            elseif button=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() and not HealBot_Data["UILOCK"] then
                HealBot_Action_UseSmartCast(self)
            end
        elseif IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown() and button=="MiddleButton" then
            HealBot_Action_Toggle_Enabled(self.unit)
        elseif not HealBot_Data["UILOCK"] then
            if HealBot_Globals.ProtectPvP then
                if UnitIsPVP(self.unit) and not UnitIsPVP("player") then 
                    HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"nil",aj)
                    usedSmartCast=true;
                end
            end
            if button=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
                HealBot_Action_UseSmartCast(self)
            end
            if not self.status.enabled and HealBot_Config.EnableHealthy==false and not usedSmartCast then
                HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Disabled",aj)
                usedSmartCast=true;
            end
        end
    end
end

local function HealBot_Action_PostClick(self,button)
    if self.id==999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif UnitExists(self.unit) and UnitIsFriend("player",self.unit) and usedSmartCast then
        HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enemy",aj)
        HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enabled",aj)
    end
end

function HealBot_Action_OnLoad(self)
    self:SetScript("PreClick", HealBot_Action_PreClick); 
    self:SetScript("PostClick", HealBot_Action_PostClick)
end

function HealBot_Action_setRegisterForClicks(button)
    if button then
        if HealBot_Config_Spells.ButtonCastMethod==1 then
            button:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
        else
            button:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                        "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                        "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
        end
    else
        if HealBot_Config_Spells.ButtonCastMethod==1 then
            for _,xButton in pairs(HealBot_Unit_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
        else
            for _,xButton in pairs(HealBot_Unit_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
        end
    end
end

local HealBot_Action_Init={}
function HealBot_Action_OnShow(self, hbCurFrame)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OPENSOUND"] then
        PlaySound(SOUNDKIT.IG_ABILITY_OPEN);
    end
    HealBot_FrameVisible[hbCurFrame]=true
    if not HealBot_Action_Init[hbCurFrame] then
        self:SetBackdropColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKB"], 
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKA"]);
        self:SetBackdropBorderColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERA"]);
        HealBot_Action_Init[hbCurFrame]=true
        HealBot_Action_SetAlias(hbCurFrame)
        HealBot_Action_SetAliasFontSize(hbCurFrame)
    end
end

function HealBot_Action_SetAlias(hbCurFrame)
    local g=_G["f"..hbCurFrame.."_HealBot_Action_Title"]
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame] and
       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAME"] and 
       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
        g:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAME"])
    else
        g:SetText("")
    end
    HealBot_Skins_ResetSkin("frameheader",nil,hbCurFrame)
end

function HealBot_Action_SetAliasFontSize(hbCurFrame)
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame] and Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FONT"] then
        local g=_G["f"..hbCurFrame.."_HealBot_Action_Title"]
        g:SetTextColor(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["R"],
                               Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["G"],
                               Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["B"],
                               Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["A"]);
        g:SetFont(LSM:Fetch('font',Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FONT"]),
                                           Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SIZE"],
                                           HealBot_Font_Outline[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OUTLINE"]]);
        g:SetTextHeight(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SIZE"])
        g:ClearAllPoints();
        g:SetPoint("CENTER",0,Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OFFSET"]);
    end
end

function HealBot_Action_OnHide(self, hbCurFrame)
    HealBot_FrameVisible[hbCurFrame]=false
end

function HealBot_Action_OnMouseDown(self,button, hbCurFrame)
    if button=="LeftButton" then
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]==false or (HealBot_Globals.ByPassLock==1 and IsControlKeyDown() and IsAltKeyDown()) then
            HealBot_Action_luVars["FrameMoving"]=true
            HealBot_StartMoving(self);
        end
    end
end

function HealBot_Action_OnMouseUp(self,button,bID)
    if button=="LeftButton" and HealBot_Action_luVars["FrameMoving"] then
        HealBot_StopMoving(self,bID);
        HealBot_Action_luVars["FrameMoving"]=false
    elseif button=="RightButton" and not HealBot_Data["UILOCK"] and HealBot_Globals.RightButtonOptions then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_OnDragStart(self, hbCurFrame)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]==false then
        HealBot_Action_luVars["FrameMoving"]=true
        HealBot_StartMoving(self);
    end
end

function HealBot_Action_Toggle_Enabled(unit)
    local xGUID=UnitGUID(unit)
    if HealBot_AlwaysEnabled[xGUID] then
        HealBot_AlwaysEnabled[xGUID]=nil
    else
        HealBot_AlwaysEnabled[xGUID]=true
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Action_AlwaysEnabled(hbGUID)
    return HealBot_AlwaysEnabled[hbGUID]
end

function HealBot_Action_SmartCast(button)
    if button.status.current==9 and UnitIsUnit("player",button.unit) then return nil; end
    local scuSpell = nil
    local rSpell=HealBot_RangeSpells["HEAL"]
 
    if HealBot_Globals.SmartCastRes and button.status.current==9 then
        local mrSpell = HealBot_Init_retSmartCast_MassRes();
		scuSpell=HealBot_Init_retSmartCast_Res();
        rSpell=HealBot_RangeSpells["RES"]
    elseif button.aura.debuff.type and HealBot_Globals.SmartCastDebuff then
        scuSpell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type);
        rSpell=HealBot_RangeSpells["CURE"]
    elseif button.aura.buff.name and HealBot_Globals.SmartCastBuff then
        scuSpell=button.aura.buff.name
        rSpell=HealBot_RangeSpells["BUFF"]
    elseif HealBot_Globals.SmartCastHeal then
        local hptc=floor(((button.health.current+button.health.incoming)/button.health.max)*100)
        if hptc<98 then
            local uLvlDiff=(UnitLevel(button.unit) or HealBot_Data["PLEVEL"])-HealBot_Data["PLEVEL"]
            hptc=hptc-uLvlDiff
            scuSpell=HealBot_SmartCast(hptc)
        end
    end
 
    if not UnitIsUnit("player",button.unit) and HealBot_UnitInRange(button.unit, rSpell, false)<1 then
        return nil
    end
    return scuSpell;
end

function HealBot_Action_StickyFrameClearStuck(hbCurFrame)
    if hbCurFrame then
        Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCK"]=false
    else
        for x=1,10 do
            Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][x]["STUCK"]=false
            hbStickyFrameGetCoords[x]=false
        end
    end
end

function HealBot_Action_hbStickyFrameGetCoords(hbCurFrame)
    return hbStickyFrameGetCoords[hbCurFrame]
end

local vSticktSetPointX,vSticktSetPointY,vSticktSetPointOptionUpd=0,0,false
function HealBot_Action_StickyFrameSetPoint(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
    hbStickyFrameGetCoords[hbCurFrame]=true
    vSticktSetPointX,vSticktSetPointY=0,0
    if (stuckPoint=="BOTTOMLEFT" or stuckPoint=="BOTTOM" or stuckPoint=="BOTTOMRIGHT") and
       (stuckToPoint=="TOPLEFT" or stuckToPoint=="TOP" or stuckToPoint=="TOPRIGHT") then
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][stuckTo]["SHOW"] then
            vSticktSetPointY=Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][stuckTo]["HEIGHT"]
        end
    elseif (stuckToPoint=="BOTTOMLEFT" or stuckToPoint=="BOTTOM" or stuckToPoint=="BOTTOMRIGHT") and
           (stuckPoint=="TOPLEFT" or stuckPoint=="TOP" or stuckPoint=="TOPRIGHT") then
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
            vSticktSetPointY=0-Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]
        end
    end
    vSticktSetPointX=vSticktSetPointX+Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SFOFFSETH"]
    vSticktSetPointY=vSticktSetPointY+Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SFOFFSETV"]
    HBframe:ClearAllPoints();
    HBframe:SetPoint(stuckPoint,cf,stuckToPoint,vSticktSetPointX,vSticktSetPointY)
    vSticktSetPointOptionUpd=false
    if stuckPoint=="TOPLEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=1 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=1
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="BOTTOMLEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=2 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=2
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="TOPRIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=3 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=3
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="BOTTOMRIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=4 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=4
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="TOP" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=5 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=5
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="LEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=6 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=6
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="RIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=7 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=7
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="BOTTOM" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=8 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=8
        vSticktSetPointOptionUpd=true
    end
    if vSticktSetPointOptionUpd then
        HealBot_Options_ActionAnchor_UpdateDropDown()
    end
end

local function HealBot_Action_StickyFrameStuckTo(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCK"]=true
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"]=stuckTo
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKPOINT"]=stuckPoint
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTOPOINT"]=stuckToPoint
    HealBot_Action_StickyFrameSetPoint(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
end

local vStickyFrameIsSticky,vStickyFrameLeft,vStickyFrameRight,vStickyFrameTop,vStickyFrameBottom,vStickyFrameSen=false,0,0,0,0,0
function HealBot_Action_StickyFrame(hbCurFrame, HBframe)
    vStickyFrameIsSticky=false
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] and hbCurFrame>1 then
        if Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCK"] and
           HealBot_FrameVisible[Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"]] then
            HealBot_Action_StickyFrameSetPoint(hbCurFrame,
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"],
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKPOINT"],
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTOPOINT"],
                                               HBframe,
                                               grpFrame[Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"]])
            vStickyFrameIsSticky=true
        elseif HBframe:GetLeft() then
            local left=HBframe:GetLeft()
            local right=HBframe:GetRight()
            local top=HBframe:GetTop()
            local bottom=HBframe:GetBottom()
            vStickyFrameSen=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYSENSITIVITY"]
            for x=1,hbCurFrame-1 do
                if HealBot_FrameVisible[x] then
                    if grpFrame[x]:GetLeft() then
                        if grpFrame[x]:GetLeft()>(right-vStickyFrameSen) and grpFrame[x]:GetLeft()<(right+vStickyFrameSen) and
                           grpFrame[x]:GetTop()>(top-vStickyFrameSen) and grpFrame[x]:GetTop()<(top+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPRIGHT","TOPLEFT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetLeft()>(left-vStickyFrameSen) and grpFrame[x]:GetLeft()<(left+vStickyFrameSen) and
                           grpFrame[x]:GetTop()>(bottom-vStickyFrameSen) and grpFrame[x]:GetTop()<(bottom+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMLEFT","TOPLEFT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetRight()>(right-vStickyFrameSen) and grpFrame[x]:GetRight()<(right+vStickyFrameSen) and
                           grpFrame[x]:GetTop()>(bottom-vStickyFrameSen) and grpFrame[x]:GetTop()<(bottom+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMRIGHT","TOPRIGHT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetRight()>(left-vStickyFrameSen) and grpFrame[x]:GetRight()<(left+vStickyFrameSen) and
                           grpFrame[x]:GetTop()>(top-vStickyFrameSen) and grpFrame[x]:GetTop()<(top+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPLEFT","TOPRIGHT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetRight()>(left-vStickyFrameSen) and grpFrame[x]:GetRight()<(left+vStickyFrameSen) and
                           grpFrame[x]:GetBottom()>(bottom-vStickyFrameSen) and grpFrame[x]:GetBottom()<(bottom+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMLEFT","BOTTOMRIGHT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetRight()>(right-vStickyFrameSen) and grpFrame[x]:GetRight()<(right+vStickyFrameSen) and
                           grpFrame[x]:GetBottom()>(top-vStickyFrameSen) and grpFrame[x]:GetBottom()<(top+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPRIGHT","BOTTOMRIGHT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetLeft()>(left-vStickyFrameSen) and grpFrame[x]:GetLeft()<(left+vStickyFrameSen) and
                           grpFrame[x]:GetBottom()>(top-vStickyFrameSen) and grpFrame[x]:GetBottom()<(top+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPLEFT","BOTTOMLEFT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetLeft()>(right-vStickyFrameSen) and grpFrame[x]:GetLeft()<(right+vStickyFrameSen) and
                           grpFrame[x]:GetBottom()>(bottom-vStickyFrameSen) and grpFrame[x]:GetBottom()<(bottom+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMRIGHT","BOTTOMLEFT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetTop()>(bottom-vStickyFrameSen) and grpFrame[x]:GetTop()<(bottom+vStickyFrameSen) and
                               ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)>(((left+right)/2)-vStickyFrameSen) and
                               ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)<(((left+right)/2)+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOM","TOP",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetBottom()>(top-vStickyFrameSen) and grpFrame[x]:GetBottom()<(top+vStickyFrameSen) and
                               ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)>(((left+right)/2)-vStickyFrameSen) and
                               ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)<(((left+right)/2)+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOP","BOTTOM",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetLeft()>(right-vStickyFrameSen) and grpFrame[x]:GetLeft()<(right+vStickyFrameSen) and
                               ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)>(((top+bottom)/2)-vStickyFrameSen) and
                               ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)<(((top+bottom)/2)+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"RIGHT","LEFT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        elseif grpFrame[x]:GetRight()>(left-vStickyFrameSen) and grpFrame[x]:GetRight()<(left+vStickyFrameSen) and
                               ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)>(((top+bottom)/2)-vStickyFrameSen) and
                               ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)<(((top+bottom)/2)+vStickyFrameSen) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"LEFT","RIGHT",HBframe,grpFrame[x])
                            vStickyFrameIsSticky=true
                            break
                        end
                    end
                end
            end
        else
            HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, true)
        end
        if not vStickyFrameIsSticky then
            hbStickyFrameGetCoords[hbCurFrame]=false
        end
        HealBot_Options_ActionAnchor_SetAlpha(hbCurFrame)
    end
    return vStickyFrameIsSticky
end
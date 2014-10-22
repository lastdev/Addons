local SmartCast_Res=nil;
local tonumber=tonumber
local _

function HealBot_Init_retSmartCast_Res()
    return SmartCast_Res
end

function HealBot_FindSpellRangeCast(id, spellName)

    if ( not id ) then return nil; end

    local spell, _, _, msCast, _, _ = HealBot_GetSpellInfo(id);
    if ( not spell ) then return nil; end
    if not spellName then spellName=spell end
    
    if spell==HEALBOT_HOLY_WORD_SERENITY then 
        id=HealBot_GetSpellId(HEALBOT_HOLY_WORD_CHASTISE)
        _, _, _, msCast, _, _ = HealBot_GetSpellInfo(id);
    end
    
    local hbCastTime=tonumber(msCast or 0);
    if hbCastTime>999 then hbCastTime=HealBot_Comm_round(hbCastTime/1000,2) end
    
    HealBot_Spells[spellName]={}
    HealBot_Spells[spellName].CastTime=hbCastTime;
    HealBot_Spells[spellName].Mana=0

    return true
end

function HealBot_Init_Spells_Defaults()
    local i = GetSpecialization()
    local specID = 0
    if i then specID = GetSpecializationInfo(i,false,false) end
    HealBot_Spells={}
    
    local nTabs=GetNumSpellTabs()
    for j=1,nTabs do
        local _, _, offset, numEntries, _, offspecID = GetSpellTabInfo(j)
        if offspecID==0 then
            for s=offset+1,offset+numEntries do
                local sName = GetSpellBookItemName(s, BOOKTYPE_SPELL)
                local sType, sId = GetSpellBookItemInfo(s, BOOKTYPE_SPELL)
                if sType == "SPELL" and not IsPassiveSpell(sId) then
                    HealBot_Init_Spells_addSpell(sId, sName)
                elseif spellType == "FLYOUT" then
                    local _, _, numFlyoutSlots, flyoutKnown = GetFlyoutInfo(sId)
                    if flyoutKnown then
                        for f=1,numFlyoutSlots do
                            local fId, _, fKnown, fName = GetFlyoutSlotInfo(sId, f)
                            if fKnown and not IsPassiveSpell(fId) then
                                HealBot_Init_Spells_addSpell(fId, fName)
                            end
                        end
                    end
                end
            end
        end
    end
    if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        if specID==262 then  -- Elemental
    		if HealBot_FindSpellRangeCast(51886, HEALBOT_CLEANSE_SPIRIT) then
				HealBot_Spells[HEALBOT_CLEANSE_SPIRIT].id=51886
                HealBot_Spells[HEALBOT_CLEANSE_SPIRIT].known = true
			end
        elseif specID==263 then  -- Enhancement 
			if HealBot_FindSpellRangeCast(51886, HEALBOT_CLEANSE_SPIRIT) then
				HealBot_Spells[HEALBOT_CLEANSE_SPIRIT].id=51886
                HealBot_Spells[HEALBOT_CLEANSE_SPIRIT].known = true
			end
        elseif specID==264 then -- Restoration
            if HealBot_FindSpellRangeCast(77130, HEALBOT_PURIFY_SPIRIT) then
				HealBot_Spells[HEALBOT_PURIFY_SPIRIT].id=77130
                HealBot_Spells[HEALBOT_PURIFY_SPIRIT].known = true
            end
        end
--    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
--        if specID==268 then  -- Brewmaster
--        elseif specID==269 then  -- Windwalker
--        elseif specID==270 then  -- Mistweaver
--        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
        if specID==257 then -- Holy
            if HealBot_FindSpellRangeCast(88684, HEALBOT_HOLY_WORD_SERENITY) then
                HealBot_Spells[HEALBOT_HOLY_WORD_SERENITY].id=88684
                HealBot_Spells[HEALBOT_HOLY_WORD_SERENITY].known = true
            end
--        elseif specID==256 then -- Disp
--        elseif specID==258 then -- Shadow
        end
        local _, talent = GetTalentRowSelectionInfo(3)
        if talent and talent==8 then
            if HealBot_FindSpellRangeCast(123040, HEALBOT_MINDBENDER) then
                HealBot_Spells[HEALBOT_MINDBENDER].id=123040
                HealBot_Spells[HEALBOT_MINDBENDER].known = true
            end
        end
        local _, talent = GetTalentRowSelectionInfo(4)
        if talent and talent==10 then
            if HealBot_FindSpellRangeCast(19236, HEALBOT_DESPERATE_PRAYER) then
                HealBot_Spells[HEALBOT_DESPERATE_PRAYER].id=19236
                HealBot_Spells[HEALBOT_DESPERATE_PRAYER].known = true
            end
        end
        local _, talent = GetTalentRowSelectionInfo(6)
        if talent and talent==16 then
            if HealBot_FindSpellRangeCast(121135, HEALBOT_CASCADE) then
                HealBot_Spells[HEALBOT_CASCADE].id=121135
                HealBot_Spells[HEALBOT_CASCADE].known = true
            end
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        --if sID==102 then  -- Balanced
        --elseif sID==103 then  -- Feral
        --elseif sID==104 then  -- Guardian
        --elseif sID==105 then  -- Restoration
        --end
        local _, talent = GetTalentRowSelectionInfo(2)
        if talent and talent==6 then
            if HealBot_FindSpellRangeCast(102351, HEALBOT_CENARION_WARD) then
                HealBot_Spells[HEALBOT_CENARION_WARD].id=102351
                HealBot_Spells[HEALBOT_CENARION_WARD].known = true
            end
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then   
        --if sID==65 then  -- Holy
        --elseif sID==66 then  -- Protection
        --elseif sID==70 then  -- Retribution 
        --end
        local _, talent = GetTalentRowSelectionInfo(1)
        if talent and talent==1 then
            if HealBot_FindSpellRangeCast(85499, HEALBOT_SPEED_OF_LIGHT) then
                HealBot_Spells[HEALBOT_SPEED_OF_LIGHT].id=85499
                HealBot_Spells[HEALBOT_SPEED_OF_LIGHT].known = true
            end
        end
        local _, talent = GetTalentRowSelectionInfo(3)
        if talent then
            if talent==8 then
                if HealBot_FindSpellRangeCast(114163, HEALBOT_ETERNAL_FLAME) then
                    HealBot_Spells[HEALBOT_ETERNAL_FLAME].id=114163
                    HealBot_Spells[HEALBOT_ETERNAL_FLAME].known = true
                end
            elseif talent==9 then
                if HealBot_FindSpellRangeCast(20925, HEALBOT_SACRED_SHIELD) then
                    HealBot_Spells[HEALBOT_SACRED_SHIELD].id=20925
                    HealBot_Spells[HEALBOT_SACRED_SHIELD].known = true
                end
            end
        end
        local _, talent = GetTalentRowSelectionInfo(4)
        if talent and talent==10 then
            if HealBot_FindSpellRangeCast(114039, HEALBOT_HAND_OF_PURITY) then
                HealBot_Spells[HEALBOT_HAND_OF_PURITY].id=114039
                HealBot_Spells[HEALBOT_HAND_OF_PURITY].known = true
            end
        end
        local _, talent = GetTalentRowSelectionInfo(6)
        if talent then
            if talent==16 then
                HealBot_Spells[HEALBOT_HOLY_PRISM]          = {}
                if HealBot_FindSpellRangeCast(114165, HEALBOT_HOLY_PRISM) then
                    HealBot_Spells[HEALBOT_HOLY_PRISM].id=114165
                    HealBot_Spells[HEALBOT_HOLY_PRISM].known = true
                end
            elseif talent==18 then
                if HealBot_FindSpellRangeCast(114157, HEALBOT_EXECUTION_SENTENCE) then
                    HealBot_Spells[HEALBOT_EXECUTION_SENTENCE].id=114157
                    HealBot_Spells[HEALBOT_EXECUTION_SENTENCE].known = true
                end
            end
        end
    end
end

function HealBot_Init_Spells_addSpell(spellId, spellName)
    if HealBot_FindSpellRangeCast(spellId, spellName) then
        HealBot_Spells[spellName].id=spellId
        HealBot_Spells[spellName].known=IsSpellKnown(spellId)
    end
end

function HealBot_Init_SmartCast()
    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
        SmartCast_Res=HEALBOT_RESURRECTION;
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
        SmartCast_Res=HEALBOT_REVIVE;
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        SmartCast_Res=HEALBOT_RESUSCITATE;
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        SmartCast_Res=HEALBOT_REDEMPTION;
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        SmartCast_Res=HEALBOT_ANCESTRALSPIRIT;
    end
end

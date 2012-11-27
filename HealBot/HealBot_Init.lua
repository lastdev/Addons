local i=nil
local HB_mana=nil
local HB_cast=nil
local tmpText=nil
local line=nil
local tmpTest=nil
local tmpTest2=nil
local hbHealsMin=nil
local hbHealsMax=nil
local spell=nil
local line1=nil
local line2=nil
local line3=nil
local SmartCast_Res=nil;
local HealBot_Spec = {}
local TempSkins = {}
local tonumber=tonumber
local strfind=strfind
local floor=floor
local strsub=strsub
local hb_=nil

function HealBot_Init_retSmartCast_Res()
    return SmartCast_Res
end

function HealBot_InitGetSpellData(spell)

    if ( not spell ) then return end
  
    HB_cast=nil
    HB_mana=nil
    
   -- name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange 
    hb_, hb_, hb_, HB_mana, hb_, hb_, HB_cast, hb_, hb_ = GetSpellInfo(spell)

    if HB_cast then HB_cast=HealBot_Comm_round(HB_cast/1000,2) end

    if HB_cast then
        HealBot_Spells[spell].CastTime=tonumber(HB_cast);
    end
    if HB_mana then
        HealBot_Spells[spell].Mana=tonumber(HB_mana);
    end
    HealBot_InitClearSpellNils(spell)
end

function HealBot_InitClearSpellNils(spell)
    if not HealBot_Spells[spell].CastTime then
        HealBot_Spells[spell].CastTime=0;
    end
    if not HealBot_Spells[spell].Mana then
        HealBot_Spells[spell].Mana=10*UnitLevel("player");
    end
    if not HealBot_Spells[spell].Level then
        HealBot_Spells[spell].Level = 1;
    end
end

function HealBot_Generic_Patten(matchStr,matchPattern)
    tmpTest2,tmpTest2,hbHealsMin,hbHealsMax = strfind(matchStr, matchPattern ); 
    return tmpTest2,hbHealsMin,hbHealsMax;
end

function HealBot_FindSpellRangeCast(id)

    if ( not id ) then return; end
  
    spell, hb_, hb_, HB_mana, hb_, hb_, HB_cast, hb_, hb_ = HealBot_GetSpellName(id);
    if spell==HEALBOT_HOLY_WORD_SERENITY then 
        spell=HEALBOT_HOLY_WORD_CHASTISE 
        id=HealBot_GetSpellId(HEALBOT_HOLY_WORD_CHASTISE)
        hb_, hb_, hb_, HB_mana, hb_, hb_, HB_cast, hb_, hb_ = HealBot_GetSpellName(id);
    end

    if ( not spell ) then return; end
    HealBot_OtherSpells[spell] = {spell = {}};
    if not HB_cast then
        HealBot_OtherSpells[spell].CastTime=0;
    else
        HealBot_OtherSpells[spell].CastTime=tonumber(HB_cast);
    end
    if not HB_mana then
        HealBot_OtherSpells[spell].Mana=10*UnitLevel("player");
    else
        HealBot_OtherSpells[spell].Mana=tonumber(HB_mana);
    end
end

function HealBot_Init_Spells_Defaults(class)

  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then
-- PALADIN
    HealBot_Spells = {
        [HEALBOT_HOLY_LIGHT] = {
            id = 635, CastTime = 2.5, Mana =  35, Level = 34 },

        [HEALBOT_FLASH_OF_LIGHT] = {
            id = 19750, CastTime = 1.5, Mana =  35, Level = 16 },
    
        [HEALBOT_WORD_OF_GLORY] = {
            id = 85673, CastTime = 0, Mana =  35, Level = 9 },
         
        [HEALBOT_DIVINE_LIGHT] = {
            id = 82326, CastTime = 3, Mana =  35, Level = 54 },        
        
        [HEALBOT_HOLY_RADIANCE] = {
            id = 82327, CastTime = 0, Mana = 200, Level = 28}, 

        [HEALBOT_HOLY_PRISM] = {
            id = 114165, CastTime = 0, Mana = 200, Level = 25}, 
            
        [HEALBOT_LIGHT_OF_DAWN] = {
            id = 85222, CastTime = 0, Mana =  35, Level = 70 },
            
        [HEALBOT_REDEMPTION] = {
            id = 7328, CastTime = 10, Mana = 155, Level = 12 }, 
           
        [HEALBOT_LAY_ON_HANDS] = {
            id = 633, CastTime = 0, Mana = 155, Level = 16 }, 
            
        [HEALBOT_SEAL_OF_INSIGHT] = {
            id = 20165, CastTime = 0, Mana = 155, Level = 32 }, 
            
        [HEALBOT_CLEANSE] = {
            id = 4987, CastTime = 0, Mana = 155, Level = 20 }, 
            
        [HEALBOT_DIVINE_PLEA] = {
            id = 54428, CastTime = 0, Mana = 155, Level = 44 }, 
            
        [HEALBOT_SEAL_OF_RIGHTEOUSNESS] = {
            id = 20154, CastTime = 0, Mana = 155, Level = 42 }, 
        
  --      [HEALBOT_DEVOTION_AURA] = {
  --          id = 465, CastTime = 0, Mana = 155, Level = 5 }, 
            
        [HEALBOT_HAND_OF_PROTECTION] = {
            id = 1022, CastTime = 0, Mana = 155, Level = 48 }, 
            
        [HEALBOT_BLESSING_OF_KINGS] = {
            id = 20217, CastTime = 0, Mana = 155, Level = 30 }, 
            
        [HEALBOT_RIGHTEOUS_DEFENSE] = {
            id = 31789, CastTime = 0, Mana = 155, Level = 36 }, 
            
        [HEALBOT_DIVINE_SHIELD] = {
            id = 642, CastTime = 0, Mana = 155, Level = 18 }, 
            
        [HEALBOT_HAND_OF_FREEDOM] = {
            id = 1044, CastTime = 0, Mana = 155, Level = 52 }, 
            
        [HEALBOT_HAND_OF_SALVATION] = {
            id = 1038, CastTime = 0, Mana = 155, Level = 66 }, 
            
        [HEALBOT_HAND_OF_SACRIFICE] = {
            id = 6940, CastTime = 0, Mana = 155, Level = 80 }, 
            
        [HEALBOT_SEAL_OF_TRUTH] = {
            id = 31801, CastTime = 0, Mana = 155, Level = 24 }, 
            
        [HEALBOT_BLESSING_OF_MIGHT] = {
            id = 19740, CastTime = 0, Mana = 155, Level = 81 }, 
        
        [HEALBOT_HOLY_SHOCK] = { 
            id = 20473, CastTime = 0, Mana = 35, Level = 10},
           
        
    };
    
    local _, talent = GetTalentRowSelectionInfo(1)
    if talent and talent==1 then
        HealBot_Spells[HEALBOT_SPEED_OF_LIGHT] = { id = 85499, CastTime = 0, Mana = 3.5, Level = 15}
    end
    
    local _, talent = GetTalentRowSelectionInfo(3)
    if talent then
        if talent==8 then
            HealBot_Spells[HEALBOT_ETERNAL_FLAME] = { id = 114163, CastTime = 0, Mana = 3.5, Level = 45}
        elseif talent==9 then
            HealBot_Spells[HEALBOT_SACRED_SHIELD] = { id = 20925, CastTime = 0, Mana = 3.5, Level = 45}
        end
    end

    local _, talent = GetTalentRowSelectionInfo(4)
    if talent and talent==10 then
        HealBot_Spells[HEALBOT_HAND_OF_PURITY] = { id = 114039, CastTime = 0, Mana = 7, Level = 60}
    end
    
    local _, talent = GetTalentRowSelectionInfo(6)
    if talent then
        if talent==16 then
            HealBot_Spells[HEALBOT_HOLY_PRISM] = { id = 114165, CastTime = 0, Mana = 3.5, Level = 90}
        elseif talent==18 then
            HealBot_Spells[HEALBOT_EXECUTION_SENTENCE] = { id = 114157, CastTime = 0, Mana = 3.5, Level = 90}
        end
    end
    
  end

  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
-- DRUID
    HealBot_Spells = {

        [HEALBOT_REJUVENATION] = { 
            id = 774, CastTime = 0, Mana =  25, Level =  3, HoT=HEALBOT_REJUVENATION},

        [HEALBOT_HEALING_TOUCH] = {
            id = 5185, CastTime = 1.5, Mana =  25, Level  = 26 },
 
        [HEALBOT_NOURISH] = {
            id = 50464, CastTime = 1.5, Mana = 1400, Level = 8 },
 
        [HEALBOT_REGROWTH] = {
            id = 8936, CastTime = 2, Mana =  80, Level = 18, HoT=HEALBOT_REGROWTH},
    
        [HEALBOT_LIFEBLOOM] = {
            id = 33763, CastTime = 0, Mana = 220, Level = 36, HoT=HEALBOT_LIFEBLOOM},

        [HEALBOT_WILD_GROWTH] = {
            id = 48438, CastTime = 0, Mana = 200, Level = 76, HoT=HEALBOT_WILD_GROWTH}, 

        [HEALBOT_TRANQUILITY] = {
            id = 740, CastTime = 0, Mana = 200, Level = 74},  

        [HEALBOT_REVIVE] = {
            id = 50769, CastTime = 0, Mana = 155, Level = 12 },  

        [HEALBOT_OMEN_OF_CLARITY] = {
            id = 16864, CastTime = 0, Mana = 155, Level = 38 },                   

        [HEALBOT_REBIRTH] = {
            id = 20484, CastTime = 0, Mana = 155, Level = 56 },  

        [HEALBOT_REMOVE_CORRUPTION] = {
            id = 2782, CastTime = 0, Mana = 155, Level = 24 },  
            
        [HEALBOT_NATURES_CURE] = {
            id = 88423, CastTime = 0, Mana = 155, Level = 22 },  

        [HEALBOT_MARK_OF_THE_WILD] = {
            id = 1126, CastTime = 0, Mana = 155, Level = 62 },  

    --    [HEALBOT_THORNS] = {
    --        id = 467, CastTime = 0, Mana = 155, Level = 5 },  
            
        [HEALBOT_NATURES_GRASP] = {
            id = 16689, CastTime = 0, Mana = 155, Level = 52 },  

        [HEALBOT_INNERVATE] = {
            id = 29166, CastTime = 0, Mana = 155, Level = 54 },  

        [HEALBOT_BARKSKIN] = {
            id = 22812, CastTime = 0, Mana = 155, Level = 44 },  

    };
    
    local _, talent = GetTalentRowSelectionInfo(2)
    if talent and talent==6 then
        HealBot_Spells[HEALBOT_CENARION_WARD] = { id = 102351, CastTime = 0, Mana = 14.8, Level = 30}
    end
    
  end

  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then
-- PRIEST
    HealBot_Spells = {

        [HEALBOT_HEAL] = {
            id = 2050, CastTime = 3.0, Mana = 155, Level = 28 }, 

        [HEALBOT_GREATER_HEAL] = {
            id = 2060, CastTime = 3.0, Mana =  370, Level = 38 }, 
    
        [HEALBOT_BINDING_HEAL] = {
            id = 32546, CastTime = 1.5, Mana =  705, Level = 48 }, 
    
        [HEALBOT_PRAYER_OF_MENDING] = {
            id = 33076, CastTime = 0, Mana =  390, Level = 68 }, 
    
        [HEALBOT_PRAYER_OF_HEALING] = {
            id = 596, CastTime = 3.0, Mana =  410, Level = 44 }, 

        [HEALBOT_PENANCE] = {
            id = 47540, CastTime = 0, Mana =  400, Level =  10}, 
            
        [HEALBOT_RENEW] = {
            id = 139, CastTime = 0, Mana =  30, Level =  26, HoT=HEALBOT_RENEW}, 
    
        [HEALBOT_FLASH_HEAL] = {
            id = 2061, CastTime = 1.5, Mana = 125, Level = 3 }, 
    
        [HEALBOT_POWER_WORD_SHIELD] = {
            id = 17, CastTime = 0, Mana =  45, Level = 5 }, 
            
        [HEALBOT_SPIRIT_SHELL] = {
            id = 109964, CastTime = 0, Mana =  45, Level = 28 }, 
            
        [HEALBOT_DIVINE_HYMN] = {
            id = 64843, CastTime = 0, Mana =  30, Level = 78}, 

        [HEALBOT_HOLY_NOVA] = {
            id = 15237, CastTime = 3.0, Mana = 155, Level = 46 }, 
            
        [HEALBOT_INNER_FIRE] = {
            id = 588, CastTime = 0, Mana = 155, Level = 7 }, 
            
        [HEALBOT_INNER_WILL] = {
            id = 73413, CastTime = 0, Mana = 155, Level = 83 }, 
            
        [HEALBOT_RESURRECTION] = {
            id = 2006, CastTime = 0, Mana = 155, Level = 14 }, 
            
        [HEALBOT_PURIFY] = {
            id = 527, CastTime = 0, Mana = 155, Level = 26 },
            
        [HEALBOT_POWER_WORD_FORTITUDE] = {
            id = 21562, CastTime = 0, Mana = 155, Level = 22},

        [HEALBOT_LEVITATE] = {
            id = 1706, CastTime = 0, Mana = 155, Level = 34 },
            
        [HEALBOT_FEAR_WARD] = {
            id = 6346, CastTime = 0, Mana = 155, Level = 54 },
            
    --    [HEALBOT_SHADOW_PROTECTION] = {
    --        id = 27683, CastTime = 0, Mana = 155, Level = 52},
            
        [HEALBOT_LEAP_OF_FAITH] = {
            id = 73325, CastTime = 0, Mana = 155, Level = 85},
            
        [HEALBOT_HOLY_WORD_SERENITY] = {
            id = 88684, CastTime = 0, Mana = 2, Level = 20},
            
    };
    
    local _, talent = GetTalentRowSelectionInfo(4)
    if talent and talent==10 then
        HealBot_Spells[HEALBOT_DESPERATE_PRAYER] = { id = 19236, CastTime = 0, Mana = 7, Level = 60}
    end
    
    local _, talent = GetTalentRowSelectionInfo(6)
    if talent and talent==16 then
        HealBot_Spells[HEALBOT_CASCADE] = { id = 121135, CastTime = 0, Mana = 9, Level = 90}
    end
    
  end

  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then
-- SHAMAN
    HealBot_Spells = {

        [HEALBOT_HEALING_WAVE] = {
            id = 331, CastTime = 1.5, Mana =  25, Level =  20 }, 

        [HEALBOT_GREATER_HEALING_WAVE] = {
            id = 77472, CastTime = 3, Mana = 105,Level = 60 }, 
    
        [HEALBOT_CHAIN_HEAL] = {
            id = 1064, CastTime = 2.5, Mana = 260, Level = 40 },

        [HEALBOT_EARTH_SHIELD] = {
            id = 974, CastTime = 0, Mana = 0, Level = 26 },

        [HEALBOT_WATER_SHIELD] = {
            id = 52127, CastTime = 0, Mana = 155, Level = 20 }, 
            
        [HEALBOT_LIGHTNING_SHIELD] = {
            id = 324, CastTime = 0, Mana = 155, Level = 8 }, 

        [HEALBOT_RIPTIDE] = {
            id = 61295, CastTime = 0, Mana = 250, Level = 10, HoT=HEALBOT_RIPTIDE },
			
        [HEALBOT_HEALING_RAIN] = {
            id = 73920, CastTime = 0, Mana = 250, Level = 60 },
            
        [HEALBOT_HEALING_SURGE] = {
           id = 8004, CastTime = 1.5, Mana = 105, Level = 7 }, 
           
        [HEALBOT_ANCESTRALSPIRIT] = {
            id = 2008, CastTime = 0, Mana = 155, Level = 12 }, 
            
        [HEALBOT_PURIFY_SPIRIT] = {
            id = 77130, CastTime = 0, Mana = 155, Level = 18 }, 
            
        [HEALBOT_CLEANSE_SPIRIT] = {
            id = 51886, CastTime = 0, Mana = 155, Level = 18 }, 
            
        [HEALBOT_EARTHLIVING_WEAPON] = {
            id = 51730, CastTime = 0, Mana = 155, Level = 30 }, 
            
        [HEALBOT_FLAMETONGUE_WEAPON] = {
            id = 8024, CastTime = 0, Mana = 155, Level = 10 }, 
            
        [HEALBOT_FROSTBRAND_WEAPON] = {
            Cid = 8033, astTime = 0, Mana = 155, Level = 46 }, 
            
        [HEALBOT_WINDFURY_WEAPON] = {
            id = 8232, CastTime = 0, Mana = 155, Level = 32 }, 
            
        [HEALBOT_ROCKBITER_WEAPON] = {
            id = 8017, CastTime = 0, Mana = 155, Level = 75 }, 
            
        [HEALBOT_WATER_WALKING] = {
            id = 546, CastTime = 0, Mana = 155, Level = 24 }, 
            
      --  [HEALBOT_WATER_BREATHING] = {
      --      id = 131, CastTime = 0, Mana = 155, Level = 46 }, 
            
    };
  end

  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_MONK] then
--  Monk
    HealBot_Spells = {

        [HEALBOT_DETOX] = {
            id = 115450, CastTime = 0, Mana = 155, Level = 20 }, 
            
        [HEALBOT_RESUSCITATE] = {
            id = 115178, CastTime = 0, Mana = 155, Level = 18 }, 

        [HEALBOT_LEGACY_EMPEROR] = {
            id = 115921, CastTime = 0, Mana = 155, Level = 22 }, 
            
        [HEALBOT_SOOTHING_MIST] = {
            id = 115175, CastTime = 0, Mana = 101, Level = 10 }, 
            
        [HEALBOT_ZEN_MEDITATION] = {
            id = 115176, CastTime = 0, Mana = 101, Level = 82 }, 
            
        [HEALBOT_LIFE_COCOON] = {
            id = 116849, CastTime = 0, Mana = 101, Level = 50 }, 
            
        [HEALBOT_REVIVAL] = {
            id = 115310, CastTime = 0, Mana = 101, Level = 78 }, 
            
        [HEALBOT_RENEWING_MIST] = {
            id = 115151, CastTime = 0, Mana = 101, Level = 42 }, 
            
        [HEALBOT_UPLIFT] = {
            id = 116670, CastTime = 0, Mana = 101, Level = 62 }, 
            
        [HEALBOT_SURGING_MIST] = {
            id = 116694, CastTime = 0, Mana = 101, Level = 32 }, 
            
        [HEALBOT_ZEN_SPHERE] = {
            id = 124081, CastTime = 0, Mana = 101, Level = 30 },
                
        [HEALBOT_ENVELOPING_MIST] = {
            id = 132120, CastTime = 0, Mana = 101, Level = 34 },
                
        [HEALBOT_CHI_WAVE] = {
            id = 132463, CastTime = 0, Mana = 101, Level = 30 },
        
        [HEALBOT_CHI_BURST] = {
            id = 130651, CastTime = 0, Mana = 101, Level = 30 },
            
    };
  end

  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_HUNTER] then
--  Hunter
    HealBot_Spells = {
        [HEALBOT_MENDPET] = {
            id = 136, CastTime = 0, Mana =  40, Level = 16}, 
            
        [HEALBOT_A_FOX] = {
            id = 82661, CastTime = 0, Mana = 155, Level = 83 }, 
    };
  end
  
  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_MAGE] then
--  Mage
    HealBot_Spells = {
        [HEALBOT_FROST_ARMOR] = {
            id = 7302, CastTime = 0, Mana =  40, Level = 54}, 

    };
  end

end


function HealBot_Init_SmartCast()
    if HealBot_PlayerClassTrim=="PRIE" then
        SmartCast_Res=HEALBOT_RESURRECTION;
    elseif HealBot_PlayerClassTrim=="DRUI" then
        SmartCast_Res=HEALBOT_REVIVE;
    elseif HealBot_PlayerClassTrim=="MONK" then
        SmartCast_Res=HEALBOT_RESUSCITATE;
    elseif HealBot_PlayerClassTrim=="PALA" then
        SmartCast_Res=HEALBOT_REDEMPTION;
    elseif HealBot_PlayerClassTrim=="SHAM" then
        SmartCast_Res=HEALBOT_ANCESTRALSPIRIT;
    end
end

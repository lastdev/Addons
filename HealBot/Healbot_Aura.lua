local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={}
local HealBot_BuffNameTypes = {}
local HealBot_AuraBuffCache={}
local HealBot_AuraDebuffCache={[-1]={},[-2]={},[-3]={}}
local HealBot_ExcludeBuffInCache={}
local HealBot_ExcludeDebuffInCache={}
local HealBot_ExcludeEnemyInCache={}
local HealBot_iconUpdate={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,}
local HealBot_Watch_HoT={};
local HealBot_CheckBuffs = {}
local HealBot_ShortBuffs = {}
local HealBot_BuffWatch={}
local PlayerBuffs = {}
local PlayerBuffTypes = {}
local CooldownBuffs={}
local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
local TimeNow=GetTime()
local HealBot_SpellID_LookupData={}
local HealBot_SpellID_LookupIdx={}
local _
local HealBot_Buff_Aura2Item={};
local buffCheck, generalBuffs, debuffCheck=false,false,false
local tmpBCheck, tmpCBuffs, tmpGBuffs, tmpDCheck=false,false,false,false
local uaName, uaTexture, uaCount, uaDebuffType, uaDuration = false,false,false,false,false
local uaExpirationTime, uaUnitCaster, uaSpellId, uaIsBossDebuff = false,false,false,false

local hbExcludeBuffSpells = { [65148]="Sacred Shield",
                        }

local hbExcludeSpells = { [67358]="Rejuvenating",
                          [58597]="Sacred Shield",
                          --[65148]="Sacred Shield",
                        }
                        
local HealBot_Aura_luVars={}
HealBot_Aura_luVars["lastBuffMsg"]="nil"
HealBot_Aura_luVars["TankUnit"]="x"
HealBot_Aura_luVars["hbInsName"]=HEALBOT_WORD_OUTSIDE
HealBot_Aura_luVars["prevDebuffType"]="x"
HealBot_Aura_luVars["prevDebuffID"]=0
HealBot_Aura_luVars["MaskAuraDCheck"]=0
HealBot_Aura_luVars["MinIconUpdate"]=0.32
HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]=-1

function HealBot_Aura_setLuVars(vName, vValue)
    HealBot_Aura_luVars[vName]=vValue
    --HealBot_setCall("HealBot_setLuVars")
end

function HealBot_Aura_retLuVars(vName)
    --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_Aura_luVars[vName]
end

function HealBot_Aura_ResetCache()
    for x,_ in pairs(HealBot_AuraDebuffCache) do
        HealBot_AuraDebuffCache[x]=nil
    end
    HealBot_AuraDebuffCache[-1]={}
    HealBot_AuraDebuffCache[-2]={}
    HealBot_AuraDebuffCache[-3]={}
    for x,_ in pairs(HealBot_ExcludeDebuffInCache) do
        HealBot_ExcludeDebuffInCache[x]=nil
    end
end

local function HealBot_Aura_RemoveIcon(button, index)
    if not button then return; end;
    button.gref.icon[index]:SetAlpha(0)
    button.gref.txt.expire[index]:SetTextColor(1,1,1,0);
    button.gref.txt.count[index]:SetTextColor(1,1,1,0)
    button.gref.txt.expire[index]:SetText(" ");
    button.gref.txt.count[index]:SetText(" ");
    --HealBot_setCall("HealBot_Aura_RemoveIcon")
end

local function HealBot_Aura_RemoveBuffIcons(button)
    if HealBot_UnitBuffIcons[button.id] then
        for i=1,10 do
            HealBot_UnitBuffIcons[button.id][i].current=false
            HealBot_UnitBuffIcons[button.id][i].nextUpdate=TimeNow+1000000
        end
    end
    for i=1,10 do
        HealBot_Aura_RemoveIcon(button, i)
    end
end

local function HealBot_Aura_RemoveDebuffIcons(button)
    if HealBot_UnitDebuffIcons[button.id] then
        for i = 51,55 do
            HealBot_UnitDebuffIcons[button.id][i].current=false
            HealBot_UnitDebuffIcons[button.id][i].nextUpdate=TimeNow+1000000
        end
    end
    for i=51,55 do
        HealBot_Aura_RemoveIcon(button, i)
    end
end

HealBot_Aura_luVars["FadeTimeDiv"]=18
local retAlpha=0
local function HealBot_Aura_Icon_AlphaValue(secLeft, button)
    if secLeft>=0 then
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["FADE"] and 
           secLeft<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["FADESECS"] then
            retAlpha=(secLeft/HealBot_Aura_luVars["FadeTimeDiv"])+.1
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"] then
                if retAlpha>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"] then
                    retAlpha=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                end
            elseif retAlpha>button.status.alpha then
                retAlpha=button.status.alpha
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"] then
            retAlpha=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
        else
            retAlpha=button.status.alpha
        end
    else
        retAlpha=0
    end
    --HealBot_setCall("HealBot_Aura_Icon_AlphaValue")
    return retAlpha
end

HealBot_UpdateIconFreq={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
function HealBot_Aura_SetUpdateIconFreq()
    for j=1,10 do
        if not Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["FADE"] or Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["DURTHRH"]<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["FADESECS"] then
            HealBot_UpdateIconFreq[j]=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][j]["DURTHRH"]
        else
            HealBot_UpdateIconFreq[j]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["FADESECS"]
        end
    end
end

local auSecsLeft,iconAlpha=0,0
local function HealBot_Aura_UpdateIcon(button, iconData, index)
    if not button then return; end;
    if iconData.expirationTime>0 then
        iconAlpha=HealBot_Aura_Icon_AlphaValue(iconData.expirationTime-TimeNow, button)
    elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"] then
        iconAlpha=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
    else
        iconAlpha=button.status.alpha
    end
    button.gref.icon[index]:SetAlpha(iconAlpha)
    if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SDUR"] and iconData.expirationTime>0 then
        auSecsLeft=floor(iconData.expirationTime-TimeNow)
        if auSecsLeft>-1 and auSecsLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURTHRH"] then
            button.gref.txt.expire[index]:SetText(auSecsLeft);
            if auSecsLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURWARN"] then
                if index > 50 and UnitIsFriend("player",button.unit) then
                    button.gref.txt.expire[index]:SetTextColor(0,1,0,iconAlpha);
                else
                    button.gref.txt.expire[index]:SetTextColor(1,0,0,iconAlpha);
                end
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,iconAlpha);
            end  
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
    else
        button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
        button.gref.txt.expire[index]:SetText(" ");
    end
    if iconData.count > 1 then
        button.gref.txt.count[index]:SetText(iconData.count);
        button.gref.txt.count[index]:SetTextColor(1,1,1,iconAlpha);
    else
        button.gref.txt.count[index]:SetTextColor(1,1,1,0)
        button.gref.txt.count[index]:SetText(" ");
    end
    --HealBot_setCall("HealBot_Aura_UpdateIcon")
end

local function HealBot_Aura_AddBuffIcon(button, index)
    if not button then return; end;
    button.gref.icon[index]:SetTexture(HealBot_UnitBuffIcons[button.id][index]["texture"])
    HealBot_Aura_UpdateIcon(button, HealBot_UnitBuffIcons[button.id][index], index)
    --HealBot_setCall("HealBot_Aura_AddBuffIcon")
end

local function HealBot_Aura_DebuffAddIcon(button, index)
    if not button then return; end;
    button.gref.icon[index]:SetTexture(HealBot_UnitDebuffIcons[button.id][index]["texture"])
    HealBot_Aura_UpdateIcon(button, HealBot_UnitDebuffIcons[button.id][index], index)
    --HealBot_setCall("HealBot_Aura_DebuffAddIcon")
end

local rtuPrevId=false
function HealBot_Aura_RaidTargetUpdate(button, iconID)
    rtuPrevId=button.icon.debuff.targeticon
    button.icon.debuff.targeticon=iconID
    if button.icon.debuff.targeticon~=rtuPrevId then
        button.aura.check=true
    end
    --HealBot_setCall("HealBot_Aura_RaidTargetUpdate")
end

local function HealBot_Aura_InitUnitBuffIcons(buttonId)
    HealBot_UnitBuffIcons[buttonId]={}
    for i = 1,10 do
        HealBot_UnitBuffIcons[buttonId][i]={}
        HealBot_UnitBuffIcons[buttonId][i]["count"]=0
        HealBot_UnitBuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitBuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitBuffIcons[buttonId][i]["texture"]=""
        HealBot_UnitBuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitBuffIcons[buttonId][i].current=false
        HealBot_UnitBuffIcons[buttonId][i].nextUpdate=TimeNow+1000000
    end
end

local function HealBot_Aura_ResetUnitBuffIcons(buttonId)
    for i = 1,10 do
        HealBot_UnitBuffIcons[buttonId][i].current=false
    end
end

local function HealBot_Aura_InitUnitDebuffIcons(buttonId)
    HealBot_UnitDebuffIcons[buttonId]={}
    for i = 51,55 do
        HealBot_UnitDebuffIcons[buttonId][i]={}
        HealBot_UnitDebuffIcons[buttonId][i]["count"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["texture"]=""
        HealBot_UnitDebuffIcons[buttonId][i].current=false
        HealBot_UnitDebuffIcons[buttonId][i].nextUpdate=TimeNow+1000000
    end
end

local function HealBot_Aura_ResetUnitDebuffIcons(buttonId)
    for i = 51,55 do
        HealBot_UnitDebuffIcons[buttonId][i].current=false
    end
end

function HealBot_Aura_setUnitIcons(buttonId)
    if not HealBot_UnitDebuffIcons[buttonId] then 
        HealBot_Aura_InitUnitDebuffIcons(buttonId) 
    else    
        HealBot_Aura_ResetUnitDebuffIcons(buttonId)
    end
    if not HealBot_UnitBuffIcons[buttonId] then 
        HealBot_Aura_InitUnitBuffIcons(buttonId) 
    else
        HealBot_Aura_ResetUnitBuffIcons(buttonId)
    end
    --HealBot_setCall("HealBot_Aura_setUnitIcons")
end

function HealBot_Aura_delUnitIcons(buttonId)
    HealBot_UnitDebuffIcons[buttonId]=nil
end

local function HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
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
            if dID==name then 
                HealBot_Options_DeleteCDebuff(name)
            else
                HealBot_Options_CDebuffResetList()
                button.aura.check=true
            end
            break
        end
    end
end

function HealBot_Aura_ResetBuffCache(spellId)
    if HealBot_AuraBuffCache[spellId] then
        HealBot_AuraBuffCache[spellId]=nil
    else
        for spellId,_ in pairs(HealBot_AuraBuffCache) do
            HealBot_AuraBuffCache[spellId].always=false
        end
    end
    HealBot_Aura_DeleteExcludeBuffInCache()
end

function HealBot_Aura_ResetDebuffCache(spellId)
    if spellId then
        if HealBot_AuraDebuffCache[spellId] then
            HealBot_AuraDebuffCache[spellId]=nil
        end
    else
        for spellId,_ in pairs(HealBot_AuraDebuffCache) do
            HealBot_AuraDebuffCache[spellId].always=false
        end
    end
    HealBot_Aura_DeleteExcludeDebuffInCache()
end

local debuffIconCount, debuffMaxIcons=0,0
local function HealBot_Aura_BumpDebuffIcon(button,id)
    debuffIconCount=button.icon.debuff.count
    debuffMaxIcons=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"]-1
    if debuffIconCount>debuffMaxIcons then
        debuffIconCount=debuffMaxIcons
        button.icon.debuff.count=button.icon.debuff.count-1
    end
    for x=debuffIconCount+50,id,-1 do
        HealBot_UnitDebuffIcons[button.id][x+1]["count"]=HealBot_UnitDebuffIcons[button.id][x]["count"]
        HealBot_UnitDebuffIcons[button.id][x+1]["expirationTime"]=HealBot_UnitDebuffIcons[button.id][x]["expirationTime"]
        HealBot_UnitDebuffIcons[button.id][x+1]["spellId"]=HealBot_UnitDebuffIcons[button.id][x]["spellId"]
        HealBot_UnitDebuffIcons[button.id][x+1]["texture"]=HealBot_UnitDebuffIcons[button.id][x]["texture"]
        HealBot_UnitDebuffIcons[button.id][x+1].current=false
    end
    --HealBot_setCall("HealBot_Aura_BumpDebuffIcon")
end

local function HealBot_Aura_SetDebuffIcon(button, id)
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=uaSpellId then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=uaCount
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaExpirationTime
        HealBot_UnitDebuffIcons[button.id][id]["spellId"]=uaSpellId
        HealBot_UnitDebuffIcons[button.id][id]["texture"]=uaTexture
        HealBot_UnitDebuffIcons[button.id][id].current=false
        if HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]>0 then
            HealBot_UnitDebuffIcons[button.id][id].nextUpdate=(HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]-1)-HealBot_UpdateIconFreq[button.frame]
        else
            HealBot_UnitDebuffIcons[button.id][id].nextUpdate=TimeNow+1000000
        end
    elseif HealBot_UnitDebuffIcons[button.id][id]["count"]~=uaCount or HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=uaExpirationTime then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=uaCount
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaExpirationTime
        HealBot_UnitDebuffIcons[button.id][id].nextUpdate=TimeNow
        button.aura.debuff.nextupdate=TimeNow
    end
    --HealBot_setCall("HealBot_Aura_SetDebuffIcon")
end

local bbIconCount,bbMaxIcons=0,0
local function HealBot_Aura_BumpBuffIcon(button,id)
    bbIconCount=button.icon.buff.count
    bbMaxIcons=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"]-1
    if bbIconCount>bbMaxIcons then 
        bbIconCount=bbMaxIcons 
        button.icon.buff.count=button.icon.buff.count-1
    end
    for x=bbIconCount,id,-1 do
        HealBot_UnitBuffIcons[button.id][x+1]["count"]=HealBot_UnitBuffIcons[button.id][x]["count"]
        HealBot_UnitBuffIcons[button.id][x+1]["spellId"]=HealBot_UnitBuffIcons[button.id][x]["spellId"]
        HealBot_UnitBuffIcons[button.id][x+1]["expirationTime"]=HealBot_UnitBuffIcons[button.id][x]["expirationTime"]
        HealBot_UnitBuffIcons[button.id][x+1]["unitCaster"]=HealBot_UnitBuffIcons[button.id][x]["unitCaster"]
        HealBot_UnitBuffIcons[button.id][x+1]["texture"]=HealBot_UnitBuffIcons[button.id][x]["texture"]
        HealBot_UnitBuffIcons[button.id][x+1].current=false
    end
    --HealBot_setCall("HealBot_Aura_BumpBuffIcon")
end

local function HealBot_Aura_CacheBuffIcon(button, id)
    if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=uaSpellId then
        HealBot_UnitBuffIcons[button.id][id]["spellId"]=uaSpellId
        HealBot_UnitBuffIcons[button.id][id]["texture"]=uaTexture
        HealBot_UnitBuffIcons[button.id][id]["count"]=uaCount
        HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaExpirationTime
        HealBot_UnitBuffIcons[button.id][id].current=false
        if HealBot_UnitBuffIcons[button.id][id]["expirationTime"]>0 then
            HealBot_UnitBuffIcons[button.id][id].nextUpdate=(HealBot_UnitBuffIcons[button.id][id]["expirationTime"]-1)-HealBot_UpdateIconFreq[button.frame]
        else
            HealBot_UnitBuffIcons[button.id][id].nextUpdate=TimeNow+1000000
        end
    elseif HealBot_UnitBuffIcons[button.id][id]["count"]~=uaCount or HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=uaExpirationTime then
        HealBot_UnitBuffIcons[button.id][id]["count"]=uaCount
        HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaExpirationTime
        HealBot_UnitBuffIcons[button.id][id].nextUpdate=TimeNow
        button.aura.buff.nextupdate=TimeNow
    end
    HealBot_UnitBuffIcons[button.id][id]["unitCaster"]=uaUnitCaster
    --HealBot_setCall("HealBot_Aura_CacheBuffIcon")
end

local debuffIndex=0
local HealBot_TargetIconsTextures = {[1]=[[Interface\Addons\HealBot\Images\Star.tga]],
                                     [2]=[[Interface\Addons\HealBot\Images\Circle.tga]],
                                     [3]=[[Interface\Addons\HealBot\Images\Diamond.tga]],
                                     [4]=[[Interface\Addons\HealBot\Images\Triangle.tga]],
                                     [5]=[[Interface\Addons\HealBot\Images\Moon.tga]],
                                     [6]=[[Interface\Addons\HealBot\Images\Square.tga]],
                                     [7]=[[Interface\Addons\HealBot\Images\Cross.tga]],
                                     [8]=[[Interface\Addons\HealBot\Images\Skull.tga]],}
local function HealBot_Aura_CheckUnitDebuffIcons(button)
    if button.icon.debuff.classtexture and button.icon.debuff.count<5 then
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIndex=50+button.icon.debuff.count
        if HealBot_UnitDebuffIcons[button.id][debuffIndex]["spellId"]~=-1 or
           HealBot_UnitDebuffIcons[button.id][debuffIndex]["texture"]~=button.icon.debuff.classtexture then
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["texture"]=button.icon.debuff.classtexture
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["count"]=0
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["expirationTime"]=0
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["spellId"]=-1
            HealBot_UnitDebuffIcons[button.id][debuffIndex].current=false
            HealBot_UnitDebuffIcons[button.id][debuffIndex].nextUpdate=TimeNow+1000000
        end
    end
    if button.icon.debuff.targeticon>0 and button.icon.debuff.count<5 then
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIndex=50+button.icon.debuff.count
        if HealBot_UnitDebuffIcons[button.id][debuffIndex]["spellId"]~=-2 or
           HealBot_UnitDebuffIcons[button.id][debuffIndex]["texture"]~=HealBot_TargetIconsTextures[button.icon.debuff.targeticon] then
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["texture"]=HealBot_TargetIconsTextures[button.icon.debuff.targeticon]
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["count"]=0
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["expirationTime"]=0
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["spellId"]=-2
            HealBot_UnitDebuffIcons[button.id][debuffIndex].current=false
            HealBot_UnitDebuffIcons[button.id][debuffIndex].nextUpdate=TimeNow+1000000
        end
    end
    if button.icon.debuff.readycheck and button.icon.debuff.count<5 then
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIndex=50+button.icon.debuff.count
        if HealBot_UnitDebuffIcons[button.id][debuffIndex]["spellId"]~=-3 or
           HealBot_UnitDebuffIcons[button.id][debuffIndex]["texture"]~=button.icon.debuff.readycheck then
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["texture"]=button.icon.debuff.readycheck
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["count"]=0
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["expirationTime"]=0
            HealBot_UnitDebuffIcons[button.id][debuffIndex]["spellId"]=-3
            HealBot_UnitDebuffIcons[button.id][debuffIndex].current=false
            HealBot_UnitDebuffIcons[button.id][debuffIndex].nextUpdate=TimeNow+1000000
        end
    end
    
    if button.icon.debuff.count<HealBot_Aura_luVars["prevIconCount"] then 
        for i = HealBot_Aura_luVars["prevIconCount"], button.icon.debuff.count+1, -1 do
            debuffIndex=50+i
            HealBot_UnitDebuffIcons[button.id][debuffIndex].current=false
            HealBot_Aura_RemoveIcon(button, debuffIndex)
            HealBot_UnitDebuffIcons[button.id][debuffIndex].nextUpdate=TimeNow+1000000
        end
    end    
    if button.icon.debuff.count>0 then
        for i = 51, 50+button.icon.debuff.count do
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                --if HealBot_UnitDebuffIcons[button.id][i]["spellId"]~=0 then
                    HealBot_UnitDebuffIcons[button.id][i].current=true
                    HealBot_Aura_DebuffAddIcon(button, i)
                --else
                --    HealBot_AddDebug("Found SPELLID==0 unit="..button.unit.."  index="..i)
                --    HealBot_setOptions_Timer(30)
                --end
            end
        end
        if button.aura.debuff.nextupdate>TimeNow+HealBot_iconUpdate[button.frame] then
            button.aura.debuff.nextupdate=TimeNow+HealBot_iconUpdate[button.frame]
        end
    end
    --HealBot_setCall("HealBot_Aura_CheckUnitDebuffIcons")
end

local hasBuffTypes, ownBlessing = false, false
local function HealBot_Aura_HasBuffTypes(spellName, pBuffTypes)
    hasBuffTypes = false
    if HealBot_BuffNameTypes[spellName] then
        if pBuffTypes[HealBot_BuffNameTypes[spellName]] or (ownBlessing and HealBot_BuffNameTypes[spellName]<7 and HealBot_Config_Buffs.PalaBlessingsAsOne) then
            hasBuffTypes = true
        end
    end
    --HealBot_setCall("HealBot_Aura_HasBuffTypes")
    return hasBuffTypes
end

local curBuffName=false,false,false,false
local buffCheckThis, buffWatchTarget, buffSpellCD=false,false,false
local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
local function HealBot_Aura_CheckGeneralBuff(button)  
    PlayerBuffsList=button.aura.buff.recheck
    for bName,nexttime in pairs (PlayerBuffsList) do
        if not PlayerBuffs[bName] then
            PlayerBuffsList[bName]=nil
            button.aura.buff.nextcheck=1
        elseif nexttime < TimeNow then
            PlayerBuffs[bName]=false
        end
    end
    for bName,_ in pairs(HealBot_BuffWatch) do
        if not PlayerBuffs[bName] and not HealBot_Aura_HasBuffTypes(bName, PlayerBuffTypes) then
            buffCheckThis=false;
            buffWatchTarget=HealBot_Options_retBuffWatchTarget(bName);
            if buffWatchTarget["Raid"] then
                buffCheckThis=true;
            elseif buffWatchTarget[button.text.classtrim] then
                buffCheckThis=true
            elseif buffWatchTarget["Party"] and (UnitInParty(button.unit) or button.guid==HealBot_Data["PGUID"]) then 
                buffCheckThis=true
            elseif buffWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                buffCheckThis=true;
            elseif buffWatchTarget["SingleTank"] and UnitIsUnit(button.unit, HealBot_Aura_luVars["TankUnit"]) then
                buffCheckThis=true
            elseif buffWatchTarget["Self"] and button.guid==HealBot_Data["PGUID"] then
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
                curBuffName=bName;
                break
            end
        end
    end
    --HealBot_setCall("HealBot_Aura_CheckGeneralBuff")
end

local buffCustomType,scbUnitClassEN,scbUnitClassTrim="nil","nil","nil"
local function HealBot_Aura_ShowCustomBuff(button)
    buffCustomType=HealBot_Watch_HoT[uaSpellId] or HealBot_Watch_HoT[uaName]
    if buffCustomType then
        if buffCustomType=="A" then
            if HealBot_AuraBuffCache[uaSpellId] then HealBot_AuraBuffCache[uaSpellId].always=true end
            return true
        elseif buffCustomType=="C" then
            _, scbUnitClassEN = UnitClass(uaUnitCaster)
            scbUnitClassTrim = strsub(scbUnitClassEN or "XXXX",1,4)
            if HealBot_Data["PCLASSTRIM"]==scbUnitClassTrim then
                return true
            end
        elseif buffCustomType=="S" and uaUnitCaster=="player" then
            return true
        end
    end
    return false
end

local ciCustomBuff=false
local function HealBot_Aura_CheckCurBuff(button)
    ciCustomBuff=HealBot_Aura_ShowCustomBuff(button)
    if ciCustomBuff or HealBot_BuffWatch[uaName] or HealBot_BuffNameTypes[uaName] then
        if not HealBot_AuraBuffCache[uaSpellId] then
            HealBot_AuraBuffCache[uaSpellId]={}
            HealBot_AuraBuffCache[uaSpellId].always=false
            HealBot_AuraBuffCache[uaSpellId]["priority"]=HealBot_Globals.HealBot_Custom_Buffs[spellId] or 10
            if HealBot_SpellID_LookupData[uaName] and HealBot_SpellID_LookupData[uaName]["CHECK"] then
                HealBot_SpellID_LookupData[uaName]["CHECK"]=false
                HealBot_SpellID_LookupData[uaName]["ID"]=uaSpellId
                table.insert(HealBot_SpellID_LookupIdx,uaName)
            end
        end
        HealBot_AuraBuffCache[uaSpellId].custom=ciCustomBuff
        return true
    else
        return false
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
end

local buffIconSet, buffPrio, buffCPrio=false,10,true
local function HealBot_Aura_SetBuffIcon(button)
    if (hbCustomBuffsDisabled[uaSpellId] and (hbCustomBuffsDisabled[uaSpellId][HealBot_Aura_luVars["hbInsName"]] or hbCustomBuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomBuffsDisabled[uaName] and (hbCustomBuffsDisabled[uaName][HealBot_Aura_luVars["hbInsName"]] or hbCustomBuffsDisabled[uaName]["ALL"])) then
        -- Ignore it
    else
        buffIconSet=false
        buffPrio=HealBot_Globals.HealBot_Custom_Buffs[uaSpellId] or 10
        buffCPrio=true
        if button.icon.buff.count>0 then
            for x=1, button.icon.buff.count do
                if HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][x]["spellId"]]["priority"]>buffPrio then
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then
                        HealBot_Aura_BumpBuffIcon(button,x) 
                        button.icon.buff.count=button.icon.buff.count+1
                        HealBot_Aura_CacheBuffIcon(button, x)
                        buffIconSet=true
                    end
                    break
                elseif HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[HealBot_UnitBuffIcons[button.id][x]["spellId"]] then
                    buffCPrio=false
                end
            end
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] and 
           not buffIconSet and button.icon.buff.count<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"] then
            button.icon.buff.count=button.icon.buff.count+1
            HealBot_Aura_CacheBuffIcon(button, button.icon.buff.count)
        end
        if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[uaSpellId] and buffCPrio then
            return true
        end
    end
    --HealBot_setCall("HealBot_Aura_SetBuffIcon")
    return false
end

local function HealBot_Aura_CatchAltDebuffIDs(name, spellId)
    if HealBot_Globals.CatchAltDebuffIDs[name] then
        if not HealBot_Globals.HealBot_Custom_Debuffs[spellId] then
            HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
        else
            HealBot_Globals.CatchAltDebuffIDs[name]=nil
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

local hbCustomDebuffsCastBy={}
local hbCustomDebuffsDisabled={}
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
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        if not hbCustomDebuffsDisabled[id] then hbCustomDebuffsDisabled[id]=nil end
    end
end

local dNamePriority, dTypePriority=99,99
local spellCD, debuffIsCurrent, cDebuffPrio, debuffIsAlways, debuff_Type, debuffIsCustom, debuffIsNever=0, true, 15, false, debuffType, false, false
local ccdbCasterID, ccdbUnitCasterID, ccdbCheckthis, ccdbAlways=0,1,false,false
local ccdbWatchTarget={}
local function HealBot_Aura_CheckCurCustomDebuff(button, canBeAlways)
    ccdbCasterID=hbCustomDebuffsCastBy[uaName] or hbCustomDebuffsCastBy[uaSpellId] or HealBot_Globals.CureCustomDefaultCastBy
    if ccdbCasterID~=castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] then
        if uaUnitCaster=="player" then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            if ccdbCasterID==castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] then 
                ccdbCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            end
        elseif UnitIsFriend("player",uaUnitCaster) then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND]
        else
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY]
        end
    else
        ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE]
    end
    if ccdbUnitCasterID==ccdbCasterID then 
        debuff_Type=HEALBOT_CUSTOM_en
        cDebuffPrio=dNamePriority
        if ccdbCasterID==1 and canBeAlways then --hbCastByEveryone then 
            debuffIsAlways=true 
            debuffIsCustom=true
        end
    else
        debuffIsCurrent=false
    end
end

local function HealBot_Aura_CheckCurDebuff(button)
    spellCD, debuffIsCurrent, cDebuffPrio, debuffIsAlways, debuff_Type, debuffIsCustom, debuffIsNever=0, true, 20, false, uaDebuffType, false, false
    if HealBot_Config_Cures.IgnoreOnCooldownDebuffs then
        spellCD=HealBot_Options_retDebuffWatchTargetCD(uaDebuffType)
        if spellCD>2.0 then
            HealBot_Aura_luVars["prevDebuffID"]=0
            if spellCD<12 and HealBot_Aura_luVars["MaskAuraDCheck"]<TimeNow then 
                HealBot_Aura_luVars["MaskAuraDCheck"]=(TimeNow+spellCD)-0.249
                HealBot_setLuVars("MaskAuraDCheck", HealBot_Aura_luVars["MaskAuraDCheck"])
                HealBot_setLuVars("MaskAuraReCheck", true)
                HealBot_CheckAllActiveDebuffs()
                HealBot_Update_FastEveryFrame(4)
            end
        elseif HealBot_Aura_luVars["MaskAuraDCheck"]<TimeNow then
            spellCD=0
        end
    end
    dNamePriority, dTypePriority=HealBot_Options_retDebuffPriority(uaSpellId, uaName, uaDebuffType)
    if (hbCustomDebuffsDisabled[uaSpellId] and (hbCustomDebuffsDisabled[uaSpellId][HealBot_Aura_luVars["hbInsName"]] or hbCustomDebuffsDisabled[uaSpellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaName] and (hbCustomDebuffsDisabled[uaName][HealBot_Aura_luVars["hbInsName"]] or hbCustomDebuffsDisabled[uaName]["ALL"])) then
        debuffIsCurrent=false
        if not HealBot_Spell_Names[uaName] then debuffIsNever=true end
    elseif dTypePriority>dNamePriority and dNamePriority<21 then
        HealBot_Aura_CheckCurCustomDebuff(button, true)
    else
        ccdbCheckthis=false
        if dTypePriority<21 and spellCD<0.25 and 
          (not HealBot_Config_Cures.IgnoreFriendDebuffs or not UnitIsFriend("player",uaUnitCaster)) and
          (uaDuration==0 or uaDuration>=HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]) then
            ccdbWatchTarget=HealBot_Options_retDebuffWatchTarget(uaDebuffType);
            if ccdbWatchTarget then
                if ccdbWatchTarget["Raid"] then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget[button.text.classtrim] then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["Party"] and (UnitInParty(button.unit) or button.guid==HealBot_Data["PGUID"]) then 
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["SingleTank"] and UnitIsUnit(button.unit, HealBot_Aura_luVars["TankUnit"]) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Self"] and button.guid==HealBot_Data["PGUID"] then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Name"] and xGUID==HealBot_Config.MyFriend then
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
            if not HealBot_Config_Cures.IgnoreOnCooldownDebuffs then debuffIsAlways=true end
        elseif dNamePriority<15 then
            HealBot_Aura_CheckCurCustomDebuff(button, false)
        elseif uaIsBossDebuff and HealBot_Config_Cures.AlwaysShowBoss and (UnitExists("boss1") or not HealBot_Config_Cures.AlwaysShowBossStrict) then
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=15
        elseif HealBot_Config_Cures.HealBot_Custom_Defuffs_All[uaDebuffType] and not UnitIsFriend(uaUnitCaster, "player") then
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=15
            if dTypePriority>15 then
                if HealBot_AuraDebuffCache[uaSpellId] then
                    HealBot_AuraDebuffCache[uaSpellId].customType=true
                    HealBot_AuraDebuffCache[uaSpellId].always=true
                else
                    debuffIsAlways=true 
                    debuffIsCustom=true
                end
            end
        elseif dNamePriority<21 then
            HealBot_Aura_CheckCurCustomDebuff(button, false)
        elseif UnitIsUnit(uaUnitCaster,"player") and not UnitIsFriend("player",button.unit) then
            debuff_Type=HEALBOT_CUSTOM_en
            cDebuffPrio=20
        else
            debuffIsCurrent=false
            if dTypePriority>20 and not HealBot_Spell_Names[uaName] then 
                debuffIsNever=true
            end
        end
    end
    if debuffIsCurrent then
        if not HealBot_AuraDebuffCache[uaSpellId] then
            HealBot_AuraDebuffCache[uaSpellId]={}
            HealBot_AuraDebuffCache[uaSpellId].customType=debuffIsCustom
            HealBot_AuraDebuffCache[uaSpellId].always=debuffIsAlways
            HealBot_Aura_CatchAltDebuffIDs(uaName, uaSpellId)
        end
        HealBot_AuraDebuffCache[uaSpellId]["priority"]=cDebuffPrio
    end
    --HealBot_setCall("HealBot_Aura_CheckCurDebuff")
    return debuffIsCurrent, debuff_Type, debuffIsNever
end


local hbAuxBuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxDebuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aura_clearAuxAssigned()
    for f=1,9 do
        hbAuxBuffAssigned[f]={};
        hbAuxDebuffAssigned[f]={};
    end
end

function HealBot_Aura_setAuxAssigned(aType, frame, id)
    if aType=="BUFF" then
        table.insert(hbAuxBuffAssigned[frame], id)
    else
        table.insert(hbAuxDebuffAssigned[frame], id)
    end
end

local function HealBot_Aura_UpdateAuraBuffBars(button)
    table.foreach(hbAuxBuffAssigned[button.frame], function (x,id)
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            if HealBot_BuffWatch[button.aura.buff.name] and HealBot_Config_Buffs.HealBotBuffColR[HealBot_BuffWatch[button.aura.buff.name]] then
                button.aux[id]["R"]=HealBot_Config_Buffs.HealBotBuffColR[HealBot_BuffWatch[button.aura.buff.name]]
                button.aux[id]["G"]=HealBot_Config_Buffs.HealBotBuffColG[HealBot_BuffWatch[button.aura.buff.name]]
                button.aux[id]["B"]=HealBot_Config_Buffs.HealBotBuffColB[HealBot_BuffWatch[button.aura.buff.name]]
            else
                button.aux[id]["R"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["R"]
                button.aux[id]["G"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["G"]
                button.aux[id]["B"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["B"]
            end
        end
        HealBot_setAuxBar(button, id, 1000, false)
    end)
end

local function HealBot_Aura_ClearAuraBuffBars(button)
    table.foreach(hbAuxBuffAssigned[button.frame], function (x,id)
        HealBot_clearAuxBar(button, id)
    end)
end

local buffUnitRange, WarnBuffName=0,false
local function HealBot_Aura_BuffWarnings(button)
    if button.aura.buff.name~=curBuffName or curBuffName==HEALBOT_CUSTOM_en then
        if curBuffName~=HEALBOT_CUSTOM_en then 
            HealBot_UpdateUnitRange(button,false)
            buffUnitRange=button.status.range
        else
            buffUnitRange=HealBot_UnitInRange(button.unit, HealBot_Action_bSpell())
        end
        button.aura.buff.name=curBuffName;
        if HealBot_Config_Buffs.SoundBuffWarning and buffUnitRange>(HealBot_Config_Buffs.HealBot_CBWarnRange_Sound-3) then
            HealBot_PlaySound(HealBot_Config_Buffs.SoundBuffPlay)
        end
        if HealBot_Config_Buffs.ShowBuffWarning and buffUnitRange>(HealBot_Config_Buffs.HealBot_CBWarnRange_Screen-3) then
            if HealBot_BuffWatch[button.aura.buff.name] and HealBot_Config_Buffs.HealBotBuffColR[HealBot_BuffWatch[button.aura.buff.name]] then
                UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." requires "..button.aura.buff.name, 
                                         HealBot_Config_Buffs.HealBotBuffColR[HealBot_BuffWatch[button.aura.buff.name]],
                                         HealBot_Config_Buffs.HealBotBuffColG[HealBot_BuffWatch[button.aura.buff.name]],
                                         HealBot_Config_Buffs.HealBotBuffColB[HealBot_BuffWatch[button.aura.buff.name]],
                                         1, UIERRORS_HOLD_TIME);
            else
                WarnBuffName=GetSpellInfo(button.aura.buff.id)
                if WarnBuffName and HealBot_Aura_luVars["lastBuffMsg"]~=WarnBuffName then
                    HealBot_Aura_luVars["lastBuffMsg"]=WarnBuffName
                    if HealBot_Globals.CustomBuffBarColour[button.aura.buff.id] then
                        UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." benefits from "..WarnBuffName, 
                                                 HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].R,
                                                 HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].G,
                                                 HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].B,
                                                 1, UIERRORS_HOLD_TIME);
                    else
                        UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." benefits from "..WarnBuffName,
                                                 HealBot_Globals.CustomBuffBarColour[customBuffPriority].R,
                                                 HealBot_Globals.CustomBuffBarColour[customBuffPriority].G,
                                                 HealBot_Globals.CustomBuffBarColour[customBuffPriority].B,
                                                 1, UIERRORS_HOLD_TIME);
                    end
                end
            end
        end
    end
    if button.status.range>-1 then 
        HealBot_Aura_UpdateAuraBuffBars(button) 
    else
        HealBot_Aura_ClearAuraBuffBars(button)
    end
    HealBot_Action_UpdateDebuffButton(button)
    --HealBot_setCall("HealBot_Aura_BuffWarnings")
end

local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
local function HealBot_Aura_UpdateAuraDebuffBars(button)
    if button and button.frame then
        table.foreach(hbAuxDebuffAssigned[button.frame], function (x,id)
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
                    button.aux[id]["R"]=HealBot_Globals.CDCBarColour[button.aura.debuff.id].R
                    button.aux[id]["G"]=HealBot_Globals.CDCBarColour[button.aura.debuff.id].G
                    button.aux[id]["B"]=HealBot_Globals.CDCBarColour[button.aura.debuff.id].B
                elseif button.aura.debuff.type == HEALBOT_CUSTOM_en then
                    button.aux[id]["R"]=HealBot_Globals.CDCBarColour[customDebuffPriority].R
                    button.aux[id]["G"]=HealBot_Globals.CDCBarColour[customDebuffPriority].G
                    button.aux[id]["B"]=HealBot_Globals.CDCBarColour[customDebuffPriority].B
                elseif HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type] then
                    button.aux[id]["R"]=HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].R
                    button.aux[id]["G"]=HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].G
                    button.aux[id]["B"]=HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].B
                else
                    button.aux[id]["R"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["R"]
                    button.aux[id]["G"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["G"]
                    button.aux[id]["B"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["B"]
                end
            end
            HealBot_setAuxBar(button, id, 1000, false)
        end)
    end
end

local function HealBot_Aura_ClearAuraDebuffBars(button)
    table.foreach(hbAuxDebuffAssigned[button.frame], function (x,id)
        HealBot_clearAuxBar(button, id)
    end)
end

local dbUnitRange=0
local function HealBot_Aura_DebuffWarnings(button)
    if button.aura.debuff.type~=HEALBOT_CUSTOM_en and button.status.current<9  then  
        HealBot_UpdateUnitRange(button,false)
        dbUnitRange=button.status.range
    else
        dbUnitRange=HealBot_UnitInRange(button.unit, HealBot_Action_dSpell())
    end
    if button.status.range>-1 then 
        HealBot_Aura_UpdateAuraDebuffBars(button) 
    else
        HealBot_Aura_ClearAuraDebuffBars(button)
    end
    if HealBot_Config_Cures.ShowDebuffWarning and dbUnitRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Screen-3) then
        if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
            UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name, 
                                     HealBot_Globals.CDCBarColour[button.aura.debuff.id].R,
                                     HealBot_Globals.CDCBarColour[button.aura.debuff.id].G,
                                     HealBot_Globals.CDCBarColour[button.aura.debuff.id].B,
                                     1, UIERRORS_HOLD_TIME);
        elseif button.aura.debuff.type == HEALBOT_CUSTOM_en then
            UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name,
                                     HealBot_Globals.CDCBarColour[customDebuffPriority].R,
                                     HealBot_Globals.CDCBarColour[customDebuffPriority].G,
                                     HealBot_Globals.CDCBarColour[customDebuffPriority].B,
                                     1, UIERRORS_HOLD_TIME);
        else
            UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name, 
                                     HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].R,
                                     HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].G,
                                     HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].B,
                                     1, UIERRORS_HOLD_TIME);
        end
    end
    if HealBot_Config_Cures.SoundDebuffWarning and dbUnitRange>(HealBot_Config_Cures.HealBot_CDCWarnRange_Sound-3) then
        HealBot_PlaySound(HealBot_Config_Cures.SoundDebuffPlay)
    end
    if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDEBUFF"] then
        button.text.nameupdate=true
    end
    if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HDEBUFF"] then
        button.text.healthupdate=true
    end
    HealBot_Action_UpdateDebuffButton(button)
    --HealBot_setCall("HealBot_Aura_DebuffWarnings")
end

local asbtPrevEndTime=0
local function HealBot_Aura_SetUnitBuffTimer(button)
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

local function HealBot_Aura_CheckUnitBuffIcons(button)
    if button.icon.buff.count<HealBot_Aura_luVars["prevBuffIconCount"] then 
        for i = HealBot_Aura_luVars["prevBuffIconCount"], button.icon.buff.count+1, -1 do
            HealBot_UnitBuffIcons[button.id][i].current=false
            HealBot_UnitBuffIcons[button.id][i].nextUpdate=TimeNow+1000000
            HealBot_Aura_RemoveIcon(button, i)
        end
    end    
    if button.icon.buff.count>0 then
        for i = 1, button.icon.buff.count do
            if i==1 then
                if HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][i]["spellId"]] then
                    button.aura.buff.priority=HealBot_AuraBuffCache[HealBot_UnitBuffIcons[button.id][i]["spellId"]]["priority"] or 99
                else
                    button.aura.buff.priority=10
                end
            end
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        end
        if button.aura.buff.nextupdate>TimeNow+HealBot_iconUpdate[button.frame] then
            button.aura.buff.nextupdate=TimeNow+HealBot_iconUpdate[button.frame]
        end
    end
    --HealBot_setCall("HealBot_Aura_CheckUnitBuffIcons")
end

local uaIsCurrent, uaNever, uaDbType, uaZ=false, false, false, 1
local dbPrio, oPrio, dbIconSet, onlyPlayers=99, 99, false, false
function HealBot_Aura_CheckUnitAuras(button)
    button.aura.check=false
    TimeNow=GetTime()
    uaZ=1
    uaIsCurrent=false
    HealBot_Aura_luVars["prevIconCount"]=button.icon.debuff.count
    button.icon.debuff.count=0
    if debuffCheck and button.status.current<9 then
        HealBot_Aura_luVars["prevDebuffID"]=button.aura.debuff.id or 0
        HealBot_Aura_luVars["prevDebuffType"]=button.aura.debuff.type or "x"
        button.aura.debuff.type=false
        dbPrio = 99  
        while true do
            uaName=false
            if HEALBOT_GAME_VERSION<4 and libCD then
                uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId = libCD:UnitAura(button.unit,uaZ,"HARMFUL")
                if uaUnitCaster and UnitClassification(uaUnitCaster)=="worldboss" then
                    uaIsBossDebuff=true
                else
                    uaIsBossDebuff=false
                end
            else
                uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff = UnitDebuff(button.unit,uaZ)
            end
            if uaName then
                uaZ=uaZ+1
                --if uaName=="Strange Aura" then uaDebuffType=HEALBOT_CURSE_en end
                if not HealBot_ExcludeDebuffInCache[uaSpellId] and uaExpirationTime then
                    uaIsCurrent, uaNever=true, false
                    if not uaUnitCaster then uaUnitCaster="nil" end
                    if not HealBot_AuraDebuffCache[uaSpellId] or not HealBot_AuraDebuffCache[uaSpellId].always then
                        uaIsCurrent, uaDbType, uaNever=HealBot_Aura_CheckCurDebuff(button) 
                    elseif HealBot_AuraDebuffCache[uaSpellId].customType then
                        uaDbType=HEALBOT_CUSTOM_en
                    else
                        uaDbType=uaDebuffType
                    end
                    if uaIsCurrent then
                        if HealBot_AuraDebuffCache[uaSpellId]["priority"]<dbPrio then
                            button.aura.debuff.type=uaDbType
                            button.aura.debuff.name=uaName
                            button.aura.debuff.id=uaSpellId
                            button.aura.debuff.priority=HealBot_AuraDebuffCache[uaSpellId]["priority"]
                            dbPrio=HealBot_AuraDebuffCache[uaSpellId]["priority"]
                        end
                        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDEBUFF"] and button.status.range>-1 then
                            dbIconSet=false
                            if button.icon.debuff.count>0 then
                                for x=1, button.icon.debuff.count do
                                    oPrio=HealBot_AuraDebuffCache[HealBot_UnitDebuffIcons[button.id][50+x]["spellId"]]["priority"] or 99
                                    if oPrio>HealBot_AuraDebuffCache[uaSpellId]["priority"] then
                                        if x<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then 
                                            HealBot_Aura_BumpDebuffIcon(button,50+x) 
                                            button.icon.debuff.count=button.icon.debuff.count+1
                                        end
                                        HealBot_Aura_SetDebuffIcon(button, 50+x)
                                        dbIconSet=true
                                        break
                                    end
                                end
                            end
                            if not dbIconSet and button.icon.debuff.count < Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then
                                button.icon.debuff.count=button.icon.debuff.count+1
                                HealBot_Aura_SetDebuffIcon(button, 50+button.icon.debuff.count)
                            end
                        end
                    elseif uaNever then
                        HealBot_ExcludeDebuffInCache[uaSpellId]=true
                    end
                end
            else
                break
            end
        end
        if not button.aura.debuff.type then 
            HealBot_Aura_ClearDebuff(button)
        elseif UnitIsFriend("player",button.unit) then
            HealBot_Aura_DebuffWarnings(button)
            if HEALBOT_GAME_VERSION<4 then HealBot_OnEvent_UnitThreat(button) end
        end
    else
        HealBot_Aura_ClearDebuff(button)
    end
    HealBot_Aura_CheckUnitDebuffIcons(button)
    
    if UnitOnTaxi("player") then
        button.aura.buff.nextcheck=TimeNow
    elseif buffCheck and button.status.current<9 then 
        uaZ=1
        HealBot_Aura_luVars["prevBuffIconCount"]=button.icon.buff.count
        button.icon.buff.count=0
        curBuffName=false;
        if generalBuffs then
            if UnitIsUnit("player", button.unit) then
                onlyPlayers=true
            elseif HEALBOT_GAME_VERSION>3 then
                onlyPlayers=UnitIsPlayer(button.unit)
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
        while true do
            uaName=false
            if HEALBOT_GAME_VERSION<4 and libCD then
                uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId = libCD:UnitAura(button.unit,uaZ,"HELPFUL")
                if uaUnitCaster and UnitClassification(uaUnitCaster)=="worldboss" then
                    uaIsBossDebuff=true
                else
                    uaIsBossDebuff=false
                end
            else
                uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff = UnitBuff(button.unit,uaZ)
            end
            if uaName then
                uaZ=uaZ+1
                if HealBot_Buff_Aura2Item[uaSpellId] then
                    uaName=GetItemInfo(HealBot_Buff_Aura2Item[uaSpellId]) or uaName
                end
                if not HealBot_ExcludeBuffInCache[uaSpellId] and uaExpirationTime then
                    if not hbExcludeSpells[acSpellId] then
                        uaIsCurrent=true
                        if not uaUnitCaster then uaUnitCaster="nil" end
                        if not HealBot_AuraBuffCache[uaSpellId] or not HealBot_AuraBuffCache[uaSpellId].always then
                            uaIsCurrent=HealBot_Aura_CheckCurBuff(button)
                        end
                        if uaIsCurrent then
                            if HealBot_AuraBuffCache[uaSpellId].custom then
                                if HealBot_Aura_SetBuffIcon(button) then
                                    curBuffName=HEALBOT_CUSTOM_en
                                    button.aura.buff.id=uaSpellId
                                end
                            end
                            if generalBuffs and onlyPlayers and (HealBot_BuffWatch[uaName] or HealBot_BuffNameTypes[uaName]) then
                                if HealBot_BuffNameTypes[uaName] and (not button.aura.buff.recheck[uaName] or button.aura.buff.recheck[uaName]>TimeNow) then
                                    if HealBot_BuffNameTypes[uaName] then
                                        if HealBot_BuffNameTypes[uaName]<7 and button.unit==uaUnitCaster then ownBlessing=true end
                                        PlayerBuffTypes[HealBot_BuffNameTypes[uaName]]=true
                                    end
                                end
                                if not hbExcludeBuffSpells[uaSpellId] then
                                    PlayerBuffs[uaName]=true
                                    if HealBot_CheckBuffs[uaName] and uaExpirationTime>0 and (HEALBOT_GAME_VERSION>3 or UnitIsUnit(uaUnitCaster,"player")) then
                                        HealBot_Aura_SetUnitBuffTimer(button)
                                    elseif button.aura.buff.recheck[uaName] then
                                        button.aura.buff.recheck[uaName]=nil
                                        button.aura.buff.nextcheck=1
                                    end
                                end
                            end
                        elseif not HealBot_Watch_HoT[uaName] and not HealBot_Watch_HoT[uaSpellId] then
                            HealBot_ExcludeBuffInCache[uaSpellId]=true
                        end
                    end
                end
            else
                break
            end
        end
        if generalBuffs and onlyPlayers then
            HealBot_Aura_CheckGeneralBuff(button) 
        end
        HealBot_Aura_CheckUnitBuffIcons(button)
        if curBuffName then
            HealBot_Aura_BuffWarnings(button)
        elseif button.aura.buff.name then 
            HealBot_Aura_ClearBuff(button)
        end
    else
        HealBot_Aura_ClearBuff(button)
    end
end

local vUpdateIcons=false
function HealBot_Aura_CheckIcons(button)
    vUpdateIcons=false
    if HealBot_UnitBuffIcons[button.id] then
        for i=1,10 do
            if HealBot_UnitBuffIcons[button.id][i].current and HealBot_UnitBuffIcons[button.id][i]["spellId"]>0 then
                vUpdateIcons=true
                break
            end
        end
    end
    if not vUpdateIcons and HealBot_UnitDebuffIcons[button.id] then
        for i = 51,55 do
            if HealBot_UnitDebuffIcons[button.id][i].current and HealBot_UnitDebuffIcons[button.id][i]["spellId"]>0 then
                vUpdateIcons=true
                break
            end
        end
    end
    if vUpdateIcons then
        if button.status.unittype<11 then 
            HealBot_Aura_CheckUnitAuras(button) 
        else
            HealBot_Aura_RefreshEnemyAuras(button)
        end
    end
end

local lowTime=0
local PlayerBuffsList={}
function HealBot_Aura_ResetCheckBuffsTime(button)
    TimeNow=GetTime()
    lowTime=TimeNow+10000000
    PlayerBuffsList=button.aura.buff.recheck
    button.aura.buff.nextcheck=false
    for name,nexttime in pairs (PlayerBuffsList) do
        if nexttime<0 then
            PlayerBuffsList[name]=nil
        elseif nexttime < lowTime then
            lowTime=nexttime
            button.aura.buff.nextcheck=nexttime
        end
    end
    --HealBot_setCall("HealBot_Aura_ResetCheckBuffsTime")
end

function HealBot_Aura_SetBuffCheckFlags()
    tmpBCheck=buffCheck
    tmpGBuffs=generalBuffs
    tmpDCheck=debuffCheck
    
    if HealBot_Config_Buffs.NoAuraWhenRested and IsResting() then 
        buffCheck=false 
    elseif HealBot_Config_Buffs.BuffWatch then
        buffCheck=true
        if (not HealBot_Config_Buffs.BuffWatchWhenGrouped or GetNumGroupMembers()>0) and (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) then
            generalBuffs=true
        else
            generalBuffs=false
        end
    else
        buffCheck=false 
    end
    
    if HealBot_Config_Buffs.NoAuraWhenRested and IsResting() then 
        debuffCheck=false 
    elseif HealBot_Config_Cures.DebuffWatch and 
           (not HealBot_Config_Cures.DebuffWatchWhenGrouped or GetNumGroupMembers()>0) and 
           (HealBot_Config_Cures.DebuffWatchInCombat or not HealBot_Data["UILOCK"])  then
        debuffCheck=true
    else
        debuffCheck=false
    end
    
    if tmpBCheck~=buffCheck or tmpGBuffs~=generalBuffs or tmpDCheck~=debuffCheck then
        HealBot_AuraCheck()
    end
end

function HealBot_Aura_ClearDebuff(button)
	if button.aura.debuff.name then
		button.aura.debuff.type = false;
		button.aura.debuff.name = false;
        button.aura.debuff.id=0
		button.aura.debuff.priority = 99;
        HealBot_Aura_ClearAuraDebuffBars(button)
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDEBUFF"] then
            button.text.nameupdate=true
        end
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HDEBUFF"] then
            button.text.healthupdate=true
        end
        HealBot_Action_UpdateDebuffButton(button)
	end
    --HealBot_setCall("HealBot_Aura_ClearDebuff")
end

function HealBot_Aura_ClearBuff(button)
    if button.aura.buff.name then
        button.aura.buff.name=false
        button.aura.buff.priority=99
        HealBot_Action_UpdateDebuffButton(button)
        HealBot_Aura_luVars["lastBuffMsg"]="nil"
        HealBot_Aura_ClearAuraBuffBars(button)
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
    --HealBot_setCall("HealBot_Aura_ClearAllDebuffs")
end

local eaName, eaTexture, eaCount, eaExpirationTime, eaUnitCaster, eaSpellId, eaZ = false,false,false,false,false,false,1
local function HealBot_Aura_SetEnemyDebuffIcon(button, id)
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=eaSpellId then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=eaCount
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=eaExpirationTime
        HealBot_UnitDebuffIcons[button.id][id]["spellId"]=eaSpellId
        HealBot_UnitDebuffIcons[button.id][id]["texture"]=eaTexture
        HealBot_UnitDebuffIcons[button.id][id].current=false
        if HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]>0 then
            HealBot_UnitDebuffIcons[button.id][id].nextUpdate=(HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]-1)-HealBot_UpdateIconFreq[button.frame]
        else
            HealBot_UnitDebuffIcons[button.id][id].nextUpdate=TimeNow+1000000
        end
    elseif HealBot_UnitDebuffIcons[button.id][id]["count"]~=eaCount or HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=eaExpirationTime then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=eaCount
        HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=eaExpirationTime
        HealBot_UnitDebuffIcons[button.id][id].nextUpdate=TimeNow
        button.aura.debuff.nextupdate=TimeNow
    end
    --HealBot_setCall("HealBot_Aura_SetEnemyDebuffIcon")
end

function HealBot_Aura_RefreshEnemyAuras(button)
    eaZ=1        
    HealBot_Aura_luVars["prevIconCount"]=button.icon.debuff.count
    button.icon.debuff.count=0
    TimeNow=GetTime()
    while true do
        eaName=false
        if HEALBOT_GAME_VERSION<4 and libCD then
            eaName, eaTexture, eaCount, _, _, eaExpirationTime, eaUnitCaster, _, _, eaSpellId = libCD:UnitAura(button.unit,eaZ,"HARMFUL")
        else
            eaName, eaTexture, eaCount, _, _, eaExpirationTime, eaUnitCaster, _, _, eaSpellId = UnitDebuff(button.unit,eaZ)
        end
        if eaSpellId then
            eaZ=eaZ+1
            if not HealBot_ExcludeEnemyInCache[eaSpellId] and eaExpirationTime then
                if not eaUnitCaster then eaUnitCaster="nil" end
                if not UnitIsFriend("player",button.unit) and eaUnitCaster=="player" and not hbExcludeSpells[eaSpellId] then
                    if button.icon.debuff.count < Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then
                        button.icon.debuff.count=button.icon.debuff.count+1
                        HealBot_Aura_SetEnemyDebuffIcon(button, 50+button.icon.debuff.count)
                    end
                elseif not HealBot_Spell_IDs[eaSpellId] or not HealBot_Spell_IDs[eaSpellId].known then
                    HealBot_ExcludeEnemyInCache[eaSpellId]=true
                end
            end
        else
            break
        end
    end
    HealBot_Aura_CheckUnitDebuffIcons(button)
end

function HealBot_Aura_ClearBuffWatch()
    for x,_ in pairs(HealBot_BuffWatch) do
        HealBot_BuffWatch[x]=nil;
    end
    --HealBot_setCall("HealBot_Aura_ClearBuffWatch")
end

function HealBot_Aura_retBuffWatch(bName)
    --HealBot_setCall("HealBot_Aura_retBuffWatch")
    return HealBot_BuffWatch[bName]
end

function HealBot_Aura_DeleteExcludeDebuffInCache()
    for id,_ in pairs(HealBot_ExcludeDebuffInCache) do
        HealBot_ExcludeDebuffInCache[id]=nil
    end
end

function HealBot_Aura_DeleteExcludeBuffInCache()
    for id,_ in pairs(HealBot_ExcludeBuffInCache) do
        HealBot_ExcludeBuffInCache[id]=nil
    end
end

function HealBot_Aura_SetBuffWatch(buffName, ddId)
   -- table.insert(HealBot_BuffWatch,buffName);
    HealBot_BuffWatch[buffName]=ddId
    HealBot_Aura_DeleteExcludeBuffInCache()
    --HealBot_setCall("HealBot_Aura_SetBuffWatch")
end

function HealBot_Aura_ClearCheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
    --HealBot_setCall("HealBot_Aura_ClearCheckBuffs")
end

function HealBot_Aura_SetCheckBuffs(buffName)
    if not CooldownBuffs[buffName] then
        HealBot_CheckBuffs[buffName]=true;
    end
    --HealBot_setCall("HealBot_Aura_SetCheckBuffs")
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
function HealBot_Aura_retDebufftype(unit, id)
    --HealBot_setCall("HealBot_Aura_retDebufftype")
    rdType=HEALBOT_CUSTOM_en
    if HealBot_AuraDebuffCache[id] then rdType=HealBot_AuraDebuffCache[id]["debuffType"] end
    return rdType
end

function HealBot_Aura_SetIconUpdateInterval()
    HealBot_Aura_luVars["MinIconUpdate"]=0.32
    for f=1,10 do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][f]["FADE"] then
            HealBot_iconUpdate[f]=0.2
            HealBot_Aura_luVars["MinIconUpdate"]=0.064
        else
            HealBot_iconUpdate[f]=1
        end
    end
    --HealBot_setCall("HealBot_Aura_SetIconUpdateInterval")
end

function HealBot_Aura_Update_UnitBuffIcons(button)
    TimeNow=GetTime()
    button.aura.buff.nextupdate=TimeNow+10000
    for i=1,10 do
        if HealBot_UnitBuffIcons[button.id][i].current then
            if HealBot_UnitBuffIcons[button.id][i].nextUpdate<=TimeNow then
                HealBot_UnitBuffIcons[button.id][i].nextUpdate=HealBot_UnitBuffIcons[button.id][i].nextUpdate+HealBot_iconUpdate[button.frame]
                HealBot_Aura_UpdateIcon(button, HealBot_UnitBuffIcons[button.id][i], i)
            end
            if button.aura.buff.nextupdate>HealBot_UnitBuffIcons[button.id][i].nextUpdate then
                button.aura.buff.nextupdate=HealBot_UnitBuffIcons[button.id][i].nextUpdate
            end
        end
    end
end

function HealBot_Aura_Update_UnitAllIcons(button)
    if button then
        for i=1,10 do
            if HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_Aura_UpdateIcon(button, HealBot_UnitBuffIcons[button.id][i], i)
            end
        end
        for i=51,55 do
            if HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_Aura_UpdateIcon(button, HealBot_UnitDebuffIcons[button.id][i], i)
            end
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=1,10 do
                if HealBot_UnitBuffIcons[xButton.id][i].current then
                    HealBot_Aura_UpdateIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i)
                end
            end
            for i=51,55 do
                if HealBot_UnitDebuffIcons[xButton.id][i].current then
                    HealBot_Aura_UpdateIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i)
                end
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=1,10 do
                if HealBot_UnitBuffIcons[xButton.id][i].current then
                    HealBot_Aura_UpdateIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i)
                end
            end
            for i=51,55 do
                if HealBot_UnitDebuffIcons[xButton.id][i].current then
                    HealBot_Aura_UpdateIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i)
                end
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=1,10 do
                if HealBot_UnitBuffIcons[xButton.id][i].current then
                    HealBot_Aura_UpdateIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i)
                end
            end
            for i=51,55 do
                if HealBot_UnitDebuffIcons[xButton.id][i].current then
                    HealBot_Aura_UpdateIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i)
                end
            end
        end
    end
end

function HealBot_Aura_ReturnHoTdetails(buttonId)
    --HealBot_setCall("HealBot_Aura_ReturnHoTdetails")
    return HealBot_UnitBuffIcons[buttonId]
end

function HealBot_Aura_ReturnDebuffdetails(buttonId)
    --HealBot_setCall("HealBot_Aura_ReturnDebuffdetails")
    return HealBot_UnitDebuffIcons[buttonId]
end

function HealBot_Aura_RemoveIcons(button)
    HealBot_Aura_RemoveBuffIcons(button)
    HealBot_Aura_RemoveDebuffIcons(button)
    HealBot_Aura_RaidTargetUpdate(button, 0)
    --HealBot_setCall("HealBot_Aura_RemoveIcons")
end

function HealBot_Aura_Update_UnitDebuffIcons(button)
    TimeNow=GetTime()
    button.aura.debuff.nextupdate=TimeNow+10000
    for i=51,55 do
        if HealBot_UnitDebuffIcons[button.id][i].current then
            if HealBot_UnitDebuffIcons[button.id][i].nextUpdate<=TimeNow then
                HealBot_UnitDebuffIcons[button.id][i].nextUpdate=HealBot_UnitDebuffIcons[button.id][i].nextUpdate+HealBot_iconUpdate[button.frame]
                HealBot_Aura_UpdateIcon(button, HealBot_UnitDebuffIcons[button.id][i], i)
            end
            if button.aura.debuff.nextupdate>HealBot_UnitDebuffIcons[button.id][i].nextUpdate then
                button.aura.debuff.nextupdate=HealBot_UnitDebuffIcons[button.id][i].nextUpdate
            end
        end
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
            HealBot_Options_DeleteBuffHoT(class, sName)
        end
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
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARRIOR] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MAGE] then
        sName=GetSpellInfo(HEALBOT_ICE_WARD)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_ICE_BARRIER)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_DAMPEN_MAGIC)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        sName=GetSpellInfo(HEALBOT_HORN_OF_WINTER)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_HUNTER] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEMONHUNTER] then
        -- short buffs
    end
        
    CooldownBuffs={[HEALBOT_FEAR_WARD]=true, 
                   [HEALBOT_PAIN_SUPPRESSION]=true, 
                   [HEALBOT_POWER_INFUSION]=true,}
    HealBot_Buff_Aura2Item = {
        [HEALBOT_WHISPERS_OF_INSANITY] = HEALBOT_ORALIUS_WHISPERING_CRYSTAL,
        [HEALBOT_BLOOM] = HEALBOT_EVER_BLOOMING_FROND,
        [HEALBOT_FEL_FOCUS] = HEALBOT_REPURPOSED_FEL_FOCUSER,
        [HEALBOT_BATTLE_SCARRED_AUGMENT] = HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE,
        [HEALBOT_LIGHTNING_FORGED_AUGMENT] = HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE,
        [HEALBOT_TAILWIND] = HEALBOT_TAILWIND_SAPPHIRE,
        [HEALBOT_SHADOW_TOUCHED] = HEALBOT_AMETHYST_OF_THE_SHADOW_KING,
    };
        
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

        if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) or "x")] = HBC_STATS_ID,
                [(GetSpellInfo(HBC_GIFT_OF_THE_WILD) or "x")] = HBC_STATS_ID,
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
                [(GetSpellInfo(HBC_DETECT_LESSER_INVISIBILITY) or "x")] = HBC_SP_ID,
                [(GetSpellInfo(HBC_DETECT_INVISIBILITY) or "x")] = HBC_SP_ID,
                [(GetSpellInfo(HBC_DETECT_GREATER_INVISIBILITY) or "x")] = HBC_SP_ID,
            }
        else
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HEALBOT_TRUESHOT_AURA) or "x")] = HBC_STAMINA_ID,
                [(GetSpellInfo(HEALBOT_BATTLE_SHOUT) or "x")] = HBC_STAMINA_ID,
            }
        end
        HealBot_setOptions_Timer(9920)
    else
        -- Don't see the point of this in current retail (8.2)
        -- Aura checks are often done and this adds unnecessary looping
        -- Should it be required in the future, consider only sticky buffs and exclude in range buffs
        -- Also simplifying by only including the primary buff, using int instead of table
        
        --local HEALBOT_STATS_ID = 1 --RAID_BUFF_1 --Stats
        --local HEALBOT_STAMINA_ID = 2 --RAID_BUFF_2 --Stamina
        --local HEALBOT_ATTACK_POWER_ID = 3 --RAID_BUFF_3 --Attack Power
        --local HEALBOT_HASTE_ID = 4 --RAID_BUFF_4 --Haste
        --local HEALBOT_SPELL_POWER_ID = 5 --RAID_BUFF_5 --Spell Power
        --local HEALBOT_CRITICAL_STRIKE_ID = 6 --RAID_BUFF_6 --Critical Strike
        --local HEALBOT_MASTERY_ID = 7 --RAID_BUFF_7 --Mastery
        --local HEALBOT_MULTISTRIKE_ID = 8 --RAID_BUFF_8 --Multistrike
        --local HEALBOT_VERSATILITY_ID = 9 --RAID_BUFF_9 --Versatility

        HealBot_BuffNameTypes = {
            -- Death Knight
        --    [(GetSpellInfo(HEALBOT_HORN_OF_WINTER) or "x")] = HEALBOT_ATTACK_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_POWER_OF_THE_GRAVE) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_UNHOLY_AURA) or "x")] = HEALBOT_HASTE_ID,
            -- Druid
        --    [(GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_MOONKIN_AURA) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_LEADER_OF_THE_PACK) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
            -- Hunter
        --    [(GetSpellInfo(HEALBOT_TRUESHOT_AURA) or "x")] = HEALBOT_ATTACK_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_LW_FORTITUDE_OF_THE_BEAR) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_LW_POWER_OF_THE_PRIMATES) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_LW_WISDOM_OF_THE_SERPENT) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_LW_GRACE_OF_THE_CAT) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_LW_HASTE_OF_THE_HYENA) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_LW_FEROCITY_OF_THE_RAPTOR) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Hunter Pets
        --    [(GetSpellInfo(HEALBOT_BARK_OF_THE_WILD) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_BLESSING_OF_KONGS) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_EMBRACE_OF_THE_SHALE_SPIDER) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_STRENGTH_OF_THE_EARTH) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_INVIGORATING_ROAR) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_STURDINESS) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_SAVAGE_VIGOR) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_QIRAJI_FORTITUDE) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_SERPENTS_CUNNING) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_STILL_WATER) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_ROAR_OF_COURAGE) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_KEEN_SENSES) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_SPIRIT_BEAST_BLESSING) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_PLAINSWALKING) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_CACKLING_HOWL) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_ENERGIZING_SPORES) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_SPEED_OF_THE_SWARM) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_TERRIFYING_ROAR) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_FEARLESS_ROAR) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_STRENGTH_OF_THE_PACK) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_FURIOUS_HOWL) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_SONIC_FOCUS) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_WILD_STRENGTH) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_DOUBLE_BITE) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_SPRY_ATTACKS) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_BREATH_OF_THE_WINDS) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_TENACITY) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_INDOMITABLE) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_DEFENSIVE_QUILLS) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_CHITINOUS_ARMOR) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_GRACE) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Mage
        --    [(GetSpellInfo(HEALBOT_ARCANE_BRILLIANCE) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_DALARAN_BRILLIANCE) or "x")] = HEALBOT_SPELL_POWER_ID,
            -- Monk
        --    [(GetSpellInfo(HEALBOT_LEGACY_EMPEROR) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_LEGACY_WHITETIGER) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_WINDFLURRY) or "x")] = HEALBOT_MULTISTRIKE_ID,
            -- Paladin
        --    [(GetSpellInfo(HEALBOT_BLESSING_OF_KINGS) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_BLESSING_OF_MIGHT) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_SANCTITY_AURA) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Priest
        --    [(GetSpellInfo(HEALBOT_POWER_WORD_FORTITUDE) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_MIND_QUICKENING) or "x")] = HEALBOT_HASTE_ID,
            -- Warlock
        --    [(GetSpellInfo(HEALBOT_BLOOD_PACT) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_DARK_INTENT) or "x")] = HEALBOT_SPELL_POWER_ID,
            -- Warrior
        --    [(GetSpellInfo(HEALBOT_COMMANDING_SHOUT) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_BATTLE_SHOUT) or "x")] = HEALBOT_ATTACK_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_INSPIRING_PRESENCE) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Rogue
        --    [(GetSpellInfo(HEALBOT_SWIFTBLADES_CUNNING) or "x")] = HEALBOT_HASTE_ID,
            -- Shaman
        --    [(GetSpellInfo(HEALBOT_GRACE_OF_AIR) or "x")] = HEALBOT_MASTERY_ID,
        }
    end
end
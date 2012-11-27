local HealBotAddonMsgType=nil
local tmpttl=0
local HealBotcAddonIncHeals={}
local HealBotcAddonSummary={}
local HealBotcommAddonSummary={}
local HealBotAddonSummaryNoCommsCPU={}
local HealBotAddonSummaryNoCommsMem={}
local HealBotAddonSummaryNoCommsSort={}
local sortorder={}
local AddonName=nil
local AddonEnabled=nil
local hbcommver={}
local hbtmpver={}
local linenum=0
local addon_id=nil
local sender_id=nil
local i,v,x,z=nil,nil,nil,nil
local g=nil
local HBclient=nil
local HB_errtext=nil
local _

function HealBot_Comms_About()
    hbcommver=HealBot_GetInfo()
    HealBotcAddonIncHeals=HealBot_RetHealBotAddonIncHeals()

    for x,_ in pairs(hbtmpver) do
        hbtmpver[x]=nil
    end
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end
    for z,x in pairs(HealBotcAddonIncHeals) do
        table.insert(sortorder,z)
    end
    table.sort(sortorder,function (a,b)
        if HealBotcAddonIncHeals[a]>HealBotcAddonIncHeals[b] then return true end
        if HealBotcAddonIncHeals[a]<HealBotcAddonIncHeals[b] then return false end
        return a<b
    end)

    linenum=1
    table.foreach(sortorder, function (index,z)
        tmpttl=HealBotcAddonIncHeals[z] or 0
        _,_,addon_id, sender_id = string.find(z, "(.+) : (.+)")
        if linenum<29 and addon_id and sender_id then
            addon_id=hbcommver[sender_id] or "HealBot"
            if hbcommver[sender_id] then hbtmpver[sender_id]=true end
            HealBot_Comms_Print_IncHealsSum(sender_id,addon_id,tmpttl,linenum)
            linenum=linenum+1
        end
    end)

    for x,v in pairs(hbcommver) do
        if not hbtmpver[x] and linenum<29 then
            HealBot_Comms_Print_IncHealsSum(x,v,0,linenum)
            linenum=linenum+1
        end
    end

    HealBot_Error_Clientx:SetText(HEALBOT_WORD_CLIENT.."="..GetLocale())
    HealBot_Error_Versionx:SetText(HEALBOT_WORD_VERSION.."="..HEALBOT_VERSION)
    HealBot_Error_Classx:SetText(HEALBOT_SORTBY_CLASS.."="..HealBot_PlayerClassEN)
    HealBot_Comms_AcceptSkins()
    HealBot_Comms_MacroSuppressError()
    HealBot_Comms_MacroSuppressSound()
end

function HealBot_Comms_Info()

    UpdateAddOnCPUUsage()
    UpdateAddOnMemoryUsage()
    HealBotcAddonSummary=HealBot_RetHealBotAddonSummary()

    linenum=1
    for x,_ in pairs(HealBotAddonSummaryNoCommsCPU) do
        HealBotAddonSummaryNoCommsCPU[x]=nil;
        HealBotAddonSummaryNoCommsSort[x]=nil;
        HealBotAddonSummaryNoCommsMem[x]=nil;
    end
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end
    for i=1, GetNumAddOns() do
        AddonName,_,_,AddonEnabled = GetAddOnInfo(i);
        if AddonEnabled and not HealBotAddonSummaryNoCommsSort[AddonName] then
            if HealBot_Options_CPUProfiler:GetChecked() then
                z=HealBot_Comm_round(GetAddOnCPUUsage(AddonName)/1000, 2)
                if z>0 then
                    HealBotAddonSummaryNoCommsCPU[AddonName]=z
                    HealBotAddonSummaryNoCommsMem[AddonName]=HealBot_Comm_round(GetAddOnMemoryUsage(AddonName)/1024, 2)
                    HealBotAddonSummaryNoCommsSort[AddonName]=HealBotAddonSummaryNoCommsCPU[AddonName]
                    table.insert(sortorder,AddonName)
                end
            else
                z=HealBot_Comm_round(GetAddOnMemoryUsage(AddonName)/1024, 2)
                if z>0 then
                    HealBotAddonSummaryNoCommsCPU[AddonName]="--"
                    HealBotAddonSummaryNoCommsMem[AddonName]=z
                    HealBotAddonSummaryNoCommsSort[AddonName]=HealBotAddonSummaryNoCommsMem[AddonName]
                    table.insert(sortorder,AddonName)
                end
            end
            
        end
    end
    table.sort(sortorder,function (a,b)
        if HealBotAddonSummaryNoCommsSort[a]>HealBotAddonSummaryNoCommsSort[b] then return true end
        if HealBotAddonSummaryNoCommsSort[a]<HealBotAddonSummaryNoCommsSort[b] then return false end
        return a<b
    end)
    table.foreach(sortorder, function (index,z)
        if linenum<39 then
            HealBot_Comms_Print_AddonCPUSum(z,HealBotAddonSummaryNoCommsCPU[z],HealBotAddonSummaryNoCommsMem[z],linenum)
            linenum=linenum+1
        end
    end)
    linenum=1
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end
    for x,_ in pairs(HealBotcommAddonSummary) do
        HealBotcommAddonSummary[x]=nil;
    end
    for z,x in pairs(HealBotcAddonSummary) do
        HealBotcommAddonSummary[z]=HealBot_Comm_round(x/1024,2)
    end
    for z,x in pairs(HealBotcommAddonSummary) do
        table.insert(sortorder,z)
    end
    table.sort(sortorder,function (a,b)
        if HealBotcommAddonSummary[a]>HealBotcommAddonSummary[b] then return true end
        if HealBotcommAddonSummary[a]<HealBotcommAddonSummary[b] then return false end
        return a<b
    end)
    table.foreach(sortorder, function (index,z)
        if linenum<39 and HealBotcommAddonSummary[z]>0 then 
            HealBot_Comms_Print_AddonCommsSum(z,HealBotcommAddonSummary[z],linenum)
            linenum=linenum+1
        end
    end)
end

function HealBot_Comms_Print_IncHealsSum(sender_id,addon_id,HealsCnt,linenum)
    g=_G["HBIncH"..linenum.."Healer"]
    g:SetText(sender_id);
    g=_G["HBIncH"..linenum.."Ver"]
    g:SetText(addon_id);
end

function HealBot_Comms_Print_AddonCPUSum(Addon,CPU,MEM,linenum)
    g=_G["HBMod"..linenum.."Name1"]
    g:SetText(Addon);
    g=_G["HBMod"..linenum.."CPU"]
    g:SetText(CPU);
    g=_G["HBMod"..linenum.."Mem"]
    g:SetText(MEM);
end

function HealBot_Comms_Print_AddonCommsSum(Addon,Comms,linenum)
    g=_G["HBMod"..linenum.."Name2"]
    g:SetText(Addon);
    g=_G["HBMod"..linenum.."Comm"]
    g:SetText(Comms);
end

function HealBot_Comms_TargetInfo()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."  UnitHealth="..UnitHealth("target").."   UnitHealthMax="..UnitHealthMax("target"))
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."  UnitMana="..UnitMana("target").."   UnitManaMax="..UnitManaMax("target"))
end

function HealBot_Comms_Zone()
    HealBotAddonMsgType=HealBot_GetHealBot_AddonMsgType()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Zone="..GetRealZoneText())
    if HealBotAddonMsgType==1 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=BATTLEGROUND")
    elseif HealBotAddonMsgType==2 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=RAID")
    elseif HealBotAddonMsgType==3 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=PARTY")
    elseif HealBotAddonMsgType==4 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=WHISPER")
    end
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."#Group="..GetNumGroupMembers())
end

local mult = 0
function HealBot_Comm_round(num, idp)
    mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local HealBot_MsgUpdateAvail=nil
local hbMajor, hbMinor, hbPatch, hbHealbot = string.split(".", HEALBOT_VERSION)
local tMajor, tMinor, tPatch, tHealbot = 0,0,0,0
local hbVersionChecked = {}
local tNewVer=nil
function HealBot_Comms_CheckVer(userName, version)
    if not hbVersionChecked[userName] then
        tNewVer=nil
		hbMajor, hbMinor, hbPatch, hbHealbot = string.split(".", HEALBOT_VERSION)
        hbVersionChecked[userName]=true
        tMajor, tMinor, tPatch, tHealbot = string.split(".", version)
        if tonumber(tMajor)>tonumber(hbMajor) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)>tonumber(hbMinor) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)==tonumber(hbMinor) and tonumber(tPatch)>tonumber(hbPatch) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)==tonumber(hbMinor) and tonumber(tPatch)==tonumber(hbPatch) and tonumber(tHealbot)>tonumber(hbHealbot) then 
            tNewVer=true
        end
        if tNewVer then
            hbMajor=tMajor
            hbMinor=tMinor
            hbPatch=tPatch
            hbHealbot=tHealbot
            if HealBot_Globals.UpdateMsg and not HealBot_MsgUpdateAvail then
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWVERSION1)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWVERSION2)
				HealBot_Globals.UpdateMsg=false
            end
            HealBot_MsgUpdateAvail = hbMajor.."."..hbMinor.."."..hbPatch.."."..hbHealbot
        end
        HealBot_setOptions_Timer(190)
    end
end

function HealBot_Comms_ReportVer()
    return HealBot_MsgUpdateAvail
end

function HealBot_Comms_OnShow(self)

end

function HealBot_Comms_AcceptSkins()
    if HealBot_Globals.AcceptSkins==1 then
        HealBot_Info_AcceptSkinsVal:SetText("ON")
        HealBot_Info_AcceptSkinsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_AcceptSkinsVal:SetText("OFF")
        HealBot_Info_AcceptSkinsVal:SetTextColor(0.88,0.1,0.1)
    end
end

function HealBot_Comms_MacroSuppressError()
    if HealBot_Globals.MacroSuppressError==1 then
        HealBot_Info_SuppressErrorsVal:SetText("ON")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressErrorsVal:SetText("OFF")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.88,0.1,0.1)
    end
end

function HealBot_Comms_MacroSuppressSound()
    if HealBot_Globals.MacroSuppressSound==1 then
        HealBot_Info_SuppressSoundsVal:SetText("ON")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressSoundsVal:SetText("OFF")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.88,0.1,0.1)
    end
end    
    
function HealBot_Comms_OnHide(self)
    HealBot_StopMoving(self);
end

function HealBot_Comms_OnDragStart(self)
    HealBot_StartMoving(self);
end

function HealBot_Comms_OnDragStop(self)
    HealBot_StopMoving(self);
end

local hbMountsReported={}
function HealBot_ReportMissingMount(mountName, mountID)
    if not HealBot_Config.hbMountsReported[mountID] then
        HealBot_AddChat("HealBot: Missing Mount: "..mountName.." ("..mountID..")");
        HealBot_Config.hbMountsReported[mountID]=mountName
    end
end

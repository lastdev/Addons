
local HealBot_Mounts = {}

function HealBot_MountsPets_initMountData()
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
    [103081]="G",
    [107203]="GF",
    [107842]="F",
    [120395]="G",
    [124659]="G",
    [127286]="G",
    [127287]="G",
    [127288]="G",
    [127290]="G",
    [129552]="G",
    [130092]="F",
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

function HealBot_MountsPets_InitMount()
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
 		local _, sName, sID, _, _ = GetCompanionInfo("MOUNT", z);
        
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

function HealBot_MountsPets_ToggelMount(mountType)
    if IsMounted() then
        Dismount()
	elseif CanExitVehicle() then	
		VehicleExit()
    elseif HealBot_mountData["ValidUse"] and IsOutdoors() and not HealBot_IsFighting then
        local sName = nil
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
        if sName then HealBot_MountsPets_Mount(sName) end
    end
end

function HealBot_MountsPets_DislikeMount()
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

function HealBot_MountsPets_Mount(mountName)
	local z = GetNumCompanions("MOUNT");
	for i=1,z do
 		local _, sName, _, _, _ = GetCompanionInfo("MOUNT", i);
 		if sName==mountName then
 			CallCompanion("MOUNT", i);
            do break end
 		end
 	end
end

function HealBot_MountsPets_RandomPet()
    C_PetJournal.SummonRandomPet("CRITTER");
end
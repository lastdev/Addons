local HealBot_GMount = {}
local HealBot_PrevGMounts = {}
local HealBot_FMount = {}
local HealBot_PrevFMounts = {}
local HealBot_SMount = {}
local HealBot_AQMount = {}
local HealBot_mountData = {}
local HealBot_MountIndex = {}
local HealBot_MountsPets_luVars={}
HealBot_MountsPets_luVars["dislikeRetry"]=75
local hbMountTypes={[230]="G",
                    [231]="G",
                    [232]="S",
                    [241]="AQ",
                    [242]="F",
                    [247]="F",
                    [248]="F",
                    [254]="S",
                    [269]="G",
                    [284]="F",
                    [398]="F",
                    [402]="F",
                    [407]="F",
                    [408]="F",
                    [412]="F",
                    [424]="F",
                    [428]="F",
                    }

local function HealBot_MountsPets_CanMount()
    if not HealBot_Data["UILOCK"] and not IsIndoors() then
        return true
    else
        return false
    end
end

function HealBot_MountsPets_Dismount()
    if IsMounted() then
        Dismount()
    elseif HEALBOT_GAME_VERSION>2 and CanExitVehicle() then    
        VehicleExit()
    end
end

function HealBot_MountsPets_FavMount()
    if HealBot_MountsPets_CanMount() then
        if IsMounted() then
            Dismount()
        elseif HEALBOT_GAME_VERSION>2 and CanExitVehicle() then    
            VehicleExit()
        elseif C_MountJournal then 
            if HealBot_mountData["incFlying"] then
                C_MountJournal.SummonByID(0)
            else
                HealBot_MountsPets_ToggelMount("ground")
            end
        elseif HealBot_mountData["incFlying"] and HealBot_Config.FavMount and HealBot_MountIndex[HealBot_Config.FavMount] then
            CallCompanion("MOUNT", HealBot_MountIndex[HealBot_Config.FavMount])
        elseif HealBot_Config.FavGroundMount and HealBot_MountIndex[HealBot_Config.FavGroundMount] then
            CallCompanion("MOUNT", HealBot_MountIndex[HealBot_Config.FavGroundMount])
        end
    end
end

function HealBot_MountsPets_RandomPet(isFav)
    if not HealBot_Data["UILOCK"] then
        C_PetJournal.SummonRandomPet(isFav)
    end
end

function HealBot_MountsPets_Mount(mount)
    if HealBot_MountIndex[mount] then 
        if HealBot_MountsPets_CanMount() then
            if C_MountJournal then
                C_MountJournal.SummonByID(HealBot_MountIndex[mount]) 
            else
                CallCompanion("MOUNT", HealBot_MountIndex[mount])
            end
        end
    else
        HealBot_Timers_Set("LAST","MountsPetsUse")
        HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
    end
end

local vToggleMountIndex=0
function HealBot_MountsPets_ToggelMount(mountType)
    if HealBot_MountsPets_CanMount() then
        if IsMounted() then
            Dismount()
        elseif HEALBOT_GAME_VERSION>2 and CanExitVehicle() then    
            VehicleExit()
        elseif HealBot_mountData["ValidUse"] and IsOutdoors() then
            local mount = nil
            vToggleMountIndex=0
            if mountType=="all" and not IsSwimming() and HealBot_mountData["incFlying"] and #HealBot_FMount>0 then
                for x=1,20 do
                    vToggleMountIndex = math.random(1, #HealBot_FMount);
                    mount = HealBot_FMount[vToggleMountIndex];
                    if not HealBot_Globals.dislikeMount[mount] then
                        break
                    else
                        if HealBot_Globals.dislikeMount[mount]>0 then
                            HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                        else
                            HealBot_AddDebug("Mounting a disliked mount "..mount,"Mount",true)
                            HealBot_Globals.dislikeMount[mount]=HealBot_MountsPets_luVars["dislikeRetry"]
                            break
                        end
                    end
                end
                if HealBot_mountData["PrevFlying#"]>0 then
                    table.insert(HealBot_PrevFMounts, HealBot_FMount[vToggleMountIndex]);
                    table.remove(HealBot_FMount,vToggleMountIndex)
                end
                if #HealBot_PrevFMounts>HealBot_mountData["PrevFlying#"] then
                    table.insert(HealBot_FMount, HealBot_PrevFMounts[1]);
                    table.remove(HealBot_PrevFMounts,1)
                end
            elseif IsSwimming() and #HealBot_SMount>0 then
                vToggleMountIndex = math.random(1, #HealBot_SMount);
                mount = HealBot_SMount[vToggleMountIndex];
            elseif HealBot_mountData["incAQ"] then
                if #HealBot_AQMount>0 then
                    vToggleMountIndex = math.random(1, #HealBot_AQMount);
                    mount = HealBot_AQMount[vToggleMountIndex];
                end
            elseif #HealBot_GMount>0 then
                for x=1,20 do
                    vToggleMountIndex = math.random(1, #HealBot_GMount);
                    mount = HealBot_GMount[vToggleMountIndex];
                    if not HealBot_Globals.dislikeMount[mount] then
                        break
                    else
                        if HealBot_Globals.dislikeMount[mount]>0 then
                            HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                        else
                            HealBot_Globals.dislikeMount[mount]=HealBot_MountsPets_luVars["dislikeRetry"]
                            HealBot_AddDebug("Mounting a disliked mount "..mount,"Mount",true)
                            break
                        end
                    end
                end
                if HealBot_mountData["PrevGround#"]>0 then
                    table.insert(HealBot_PrevGMounts, HealBot_GMount[vToggleMountIndex]);
                    table.remove(HealBot_GMount,vToggleMountIndex)
                end
                if #HealBot_PrevGMounts>HealBot_mountData["PrevGround#"] then
                    table.insert(HealBot_GMount, HealBot_PrevGMounts[1]);
                    table.remove(HealBot_PrevGMounts,1)
                end
            end
            if mount then HealBot_MountsPets_Mount(mount) end
        end
    end
end

function HealBot_MountsPets_InitUse()
    if HEALBOT_GAME_VERSION>2 then
        HealBot_Timers_Set("LAST","MountsPetsInit")
    end
end

function HealBot_MountsPets_ClassicDalaranCheck()
    local mapPos = C_Map.GetPlayerMapPosition(125, "player")
    if mapPos then
        local x, y = mapPos:GetXY()
        if x>0.6 and y<0.5 then
            HealBot_mountData["incFlying"]=true
        else
            HealBot_mountData["incFlying"]=false
        end
        --HealBot_AddDebug("Zone x="..x.." y="..y,"Mount",true)
        --if HealBot_mountData["incFlying"] then
        --    HealBot_AddDebug("Zone Is Flyable","Mount",true)
        --else
        --    HealBot_AddDebug("Zone Not Flyable","Mount",true)
        --end
    else
        HealBot_mountData["incFlying"]=false
    end
end

function HealBot_MountsPets_ZoneChange()
    HealBot_mountData["incAQ"]=false
    if IsFlyableArea() then
        if HEALBOT_GAME_VERSION>4 then
            HealBot_mountData["incFlying"]=true
            --HealBot_AddDebug("Zone Is Flyable","Mount",true)
        else    
            local mapAreaID = C_Map.GetBestMapForUnit("player") or 0
            if mapAreaID>112 and mapAreaID<124 and not IsSpellKnown(54197) then
                HealBot_mountData["incFlying"]=false
                --HealBot_AddDebug("In Northrend no Cold Weather Flying")
            elseif mapAreaID>99 and mapAreaID<112 and not IsSpellKnown(34092) then
                HealBot_mountData["incFlying"]=false
                --HealBot_AddDebug("In Outlands no Expert Flying")
            elseif mapAreaID>0 then
                if mapAreaID==125 then
                    HealBot_Timers_Set("LAST","MountsPetsDalaran",2)
                else
                    HealBot_mountData["incFlying"]=true
                end
            end
            --if HealBot_mountData["incFlying"] then
            --    HealBot_AddDebug("Zone mapAreaID="..mapAreaID.." Is Flyable","Mount",true)
            --else
            --    HealBot_AddDebug("Zone mapAreaID="..mapAreaID.." Not Flyable","Mount",true)
            --end
        end
    else
        HealBot_mountData["incFlying"]=false
        local _, _, _, _, _, _, _, instanceID = GetInstanceInfo()
        if instanceID==531 then
            HealBot_mountData["incAQ"]=true
        end
        --HealBot_AddDebug("Zone Not Flyable","Mount",true)
    end
end

function HealBot_MountsPets_InitMount()
    --SetMapToCurrentZone()
    local HealBot_SlowMount={}
    local HealBot_SlowFMount={}
    for z,_ in pairs(HealBot_GMount) do
        HealBot_GMount[z]=nil;
    end
    for z,_ in pairs(HealBot_AQMount) do
        HealBot_AQMount[z]=nil;
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
    for z,_ in pairs(HealBot_MountIndex) do
        HealBot_MountIndex[z]=nil;
    end

    local mount, sID, isUsable, faction, isCollected, mountType
    if C_MountJournal then
    
        HealBot_mountData["playerFaction"]=0 -- Horde
        local _,raceId = UnitRace("player");
        if raceId=="Dwarf" or raceId=="Draenei" or raceId=="Gnome" or raceId=="Human" or raceId=="NightElf" or raceId=="Worgen" then
            HealBot_mountData["playerFaction"]=1
        elseif raceId=="Pandaren" then
            if UnitFactionGroup("player")=="Alliance" then
                HealBot_mountData["playerFaction"]=1
            end
        end
        
        for _, z in pairs(C_MountJournal.GetMountIDs()) do
            mount, sID, _, _, isUsable, _, _, _, faction, _, isCollected = C_MountJournal.GetMountInfoByID(z)
            _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(z)
            if faction and isUsable and isCollected then
                local englishFaction = UnitFactionGroup("player")
                if (faction~=HealBot_mountData["playerFaction"]) then
                    isUsable=nil
                end
            end
            
            if sID and isUsable and isCollected and not HealBot_Globals.excludeMount[mount] then
                if hbMountTypes[mountType]=="F" then
                    table.insert(HealBot_FMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif hbMountTypes[mountType]=="S" then
                    table.insert(HealBot_SMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif hbMountTypes[mountType]=="G" then
                    table.insert(HealBot_GMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif hbMountTypes[mountType]=="AQ" then
                    table.insert(HealBot_AQMount, mount);
                    HealBot_MountIndex[mount]=z
                else
                    HealBot_AddDebug("unknown mount "..mount.."="..sID.." mountType="..(mountType or "nil"),"Mount",true)
                end
                --HealBot_AddDebug("mount "..mount.."="..sID.." mountType="..(mountType or "nil"),"Mount",true)
            elseif not sID then
                HealBot_AddDebug("No id for Name="..(mount or "NoName").."  z="..z,"Mount",true)
            end
        end
    else
        for z=1,GetNumCompanions("MOUNT") do
            _, mount, sID, _, _, mountType = GetCompanionInfo("MOUNT", z)
            if sID and not HealBot_Globals.excludeMount[mount] then
                if not mountType then
                    if sID<25900 or sID==34896 or sID==43688 or sID==348459 or sID==46628 then
                        if sID<10000 then
                            table.insert(HealBot_SlowMount, mount);
                            HealBot_AddDebug("Slow Ground Mount id="..sID.." Name="..mount,"Mount",true)
                        else
                            table.insert(HealBot_GMount, mount);
                            HealBot_Config.FavGroundMount=HealBot_Config.FavGroundMount or mount
                            HealBot_AddDebug("Fast Ground Mount id="..sID.." Name="..mount,"Mount",true)
                        end
                        HealBot_MountIndex[mount]=z
                    elseif sID>26100 then
                        if sID>32200 and sID<32250 then
                            table.insert(HealBot_SlowFMount, mount);
                            HealBot_AddDebug("Slow Flying Mount id="..sID.." Name="..mount,"Mount",true)
                        else
                            table.insert(HealBot_FMount, mount);
                            HealBot_Config.FavMount=HealBot_Config.FavMount or mount
                            HealBot_AddDebug("Fast  Flying Mount id="..sID.." Name="..mount,"Mount",true)
                        end
                        HealBot_MountIndex[mount]=z
                    end
                elseif (mountType==15 or mountType==31) then
                    table.insert(HealBot_FMount, mount);
                    HealBot_MountIndex[mount]=z
                    HealBot_Config.FavMount=HealBot_Config.FavMount or mount
                elseif (mountType==12) then
                    table.insert(HealBot_SMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif (mountType==29) then
                    table.insert(HealBot_GMount, mount);
                    HealBot_MountIndex[mount]=z
                    HealBot_Config.FavGroundMount=HealBot_Config.FavGroundMount or mount
                end
                --HealBot_AddDebug("mount "..mount.."="..sID.." mountType="..(mountType or "nil"),"Mount",true)
            elseif not sID then
                HealBot_AddDebug("No id for Name="..(mount or "NoName").."  z="..z,"Mount",true)
            end
        end
    end   
    
    if #HealBot_GMount==0 and #HealBot_SlowMount>0 then
        for z,_ in pairs(HealBot_SlowMount) do
            HealBot_GMount[z]=HealBot_SlowMount[z]
        end
    end
    if #HealBot_FMount==0 and #HealBot_SlowFMount>0 then
        for z,_ in pairs(HealBot_SlowFMount) do
            HealBot_FMount[z]=HealBot_SlowFMount[z]
        end
    end
    HealBot_mountData["PrevFlying#"]=floor(#HealBot_FMount/3) 
    HealBot_mountData["PrevGround#"]=floor(#HealBot_GMount/3)

    if #HealBot_GMount==0 and #HealBot_FMount==0 then
        HealBot_mountData["ValidUse"]=false
    else
        HealBot_mountData["ValidUse"]=true
    end
    HealBot_Timers_Set("LAST","MountsPetsZone")
end

function HealBot_MountsPets_FavClassicMount()
    if not IsMounted() then
        HealBot_AddChat("ERROR: Not Mounted\nMount first before setting favourite mount")
    else
        local z = GetNumCompanions("MOUNT")
        local mount=false
        for i=1,z do
            local _, creatureName, _, _, active = GetCompanionInfo("MOUNT", i)
            if active then
                mount=creatureName
                break
            end
        end
        if mount then
            for z,_ in pairs(HealBot_FMount) do
                if HealBot_FMount[z]==mount then
                    HealBot_Config.FavMount=mount
                    HealBot_AddChat(mount.." set as Favourite flying mount")
                    mount=nil
                    break
                end
            end
        end
        if mount then
            for z,_ in pairs(HealBot_PrevFMounts) do
                if HealBot_PrevFMounts[z]==mount then
                    HealBot_Config.FavMount=mount
                    HealBot_AddChat(mount.." set as Favourite flying mount")
                    mount=nil
                    break
                end
            end
        end
        if mount then
            for z,_ in pairs(HealBot_GMount) do
                if HealBot_GMount[z]==mount then
                    HealBot_Config.FavGroundMount=mount
                    HealBot_AddChat(mount.." set as Favourite ground mount")
                    mount=nil
                    break
                end
            end
        end
        if mount then
            for z,_ in pairs(HealBot_PrevGMounts) do
                if HealBot_PrevGMounts[z]==mount then
                    HealBot_Config.FavGroundMount=mount
                    HealBot_AddChat(mount.." set as Favourite ground mount")
                    break
                end
            end
        end
    end
end

function HealBot_MountsPets_DislikeMount(action)
    if not IsMounted() then
        HealBot_AddChat("ERROR: Not Mounted\nMount first before toggling exclude mount")
    else
        local z = 0
        local mount,creatureName,active=nil,nil,nil
        if HEALBOT_GAME_VERSION>3 then
            z = C_MountJournal.GetNumMounts()
        else
            z = GetNumCompanions("MOUNT")
        end
        for i=1,z do
            if HEALBOT_GAME_VERSION>3 then
                creatureName, _, _, active = C_MountJournal.GetMountInfoByID(i)
            else
                _, creatureName, _, _, active = GetCompanionInfo("MOUNT", i)
            end
            if active then
                mount=creatureName
                break
            end
        end
        if mount then
            if action=="Exclude" then
                if HealBot_Globals.excludeMount[mount] then
                    HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_OFF.." "..mount)
                    HealBot_Globals.excludeMount[mount]=nil
                else
                    HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
                    HealBot_Globals.excludeMount[mount]=true
                end
                HealBot_Timers_Set("LAST","MountsPetsUse")
            else
                if HealBot_Globals.dislikeMount[mount] then
                    HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_OFF.." "..mount)
                    HealBot_Globals.dislikeMount[mount]=nil
                else
                    HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_ON.." "..mount)
                    HealBot_Globals.dislikeMount[mount]=HealBot_MountsPets_luVars["dislikeRetry"]
                end
            end
        end
    end
end
local srcNames = {};
local srcClasses = {};
local healingDone = {};
local overhealingDone = {};
local absorbedDone = {};
local criticalDone = {};
local lastShotTime = {};
local combatStartTime = {};

local statistics = {};
local HISTORY_SIZE = 10;
local statisticsPos = nil;

local events = {
    RANGE_HEAL = true,
    SPELL_HEAL = true,
    SPELL_PERIODIC_HEAL = true,
    SPELL_BUILDING_HEAL = true,
}


function MistWeaver_InitStatistics()

    local frame = CreateFrame("Frame");
    
    frame:RegisterEvent("PLAYER_REGEN_ENABLED"); 
    frame:RegisterEvent("PLAYER_REGEN_DISABLED"); 
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED"); 
    
    frame:HookScript("OnEvent", MistWeaver_StatisticsOnEvent);
end

function MistWeaver_StatisticsOnEvent(self, event, ...)
    if (event == "PLAYER_REGEN_ENABLED") then
        MistWeaver_Statistics_StopCombat();
    end
    if (event == "PLAYER_REGEN_DISABLED") then
        MistWeaver_Statistics_StartCombat();
    end
    if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
        local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellId, spellName, spellSchool, amount, overhealing, absorbed, critical = ...;
        MistWeaver_Statistics_Calculate(timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, overhealing, absorbed, critical);
    end
end

function MistWeaver_Statistics_StartCombat()
    srcNames = {};
    srcClasses = {};
    healingDone = {};
    overhealingDone = {};
    absorbedDone = {};
    criticalDone = {};
    lastShotTime = {};
    combatStartTime = {};
end

function MistWeaver_Statistics_StopCombat()
	if (MistWeaver_IsActive()) then
		local data = {};
	    
	    data.date = date();
	    
		data.srcNames = srcNames;
		data.srcClasses = srcClasses;
		data.healingDone = healingDone;
		data.overhealingDone = overhealingDone;
		data.absorbedDone = absorbedDone;
		data.criticalDone = criticalDone;
	    
	    tinsert(statistics, 1, data);
	    
	    while (#statistics > HISTORY_SIZE) do
	    	tremove(statistics, HISTORY_SIZE + 1);
	    end
	    
	    mw_info("MistWeaver: Statistics have been saved.");
    end
end

function MistWeaver_Statistics_Show(arg)

    local channel, sendTo = strsplit(" ", arg);

    local ordered = {};
    
    for index, srcName in pairs(srcNames) do          
        local healingDoneValue = healingDone[srcName] or 0;
        local overhealingDoneValue = overhealingDone[srcName] or 0;
        
        local netto = healingDoneValue - overhealingDoneValue;
        
        ordered[netto] = {name = srcName, healing = healingDoneValue, overhealing = overhealingDoneValue};
    end 
    
    MistWeaver_Statistics_Send(channel, sendTo, "MistWeaver "..STATISTICS);
    
    local color, str_healing, str_amount, str_overhealing;
    
    for netto, data in mw_pairsByKeysDesc(ordered) do
        color = "909090";
        
        if (srcClasses[data.name]) then
            classColor = RAID_CLASS_COLORS[srcClasses[data.name]];
            
            if (classColor) then
                color = mw_rgb2hex(classColor.r, classColor.g, classColor.b);
            end
        end
        
        str_healing = BreakUpLargeNumbers(netto);
        str_amount = BreakUpLargeNumbers(data.healing);
        str_overhealing = BreakUpLargeNumbers(data.overhealing);
               
        if (not channel or channel == "") then
            mw_info("  - |cff"..color..data.name..FONT_COLOR_CODE_CLOSE.."     healing: "..str_healing.."    (amount: "..str_amount..", overhealing: "..str_overhealing..")");
        else
            MistWeaver_Statistics_Send(channel, sendTo, "  - "..data.name.."     healing: "..str_healing.."    (amount: "..str_amount..", overhealing: "..str_overhealing..")");
        end
    end
end

function CleanUI_ShowHealingTooltip(self)
	statisticsPos = nil;
	
	local data = {};
    
    data.date = nil;
    
	data.srcNames = srcNames;
	data.srcClasses = srcClasses;
	data.healingDone = healingDone;
	data.overhealingDone = overhealingDone;
	data.absorbedDone = absorbedDone;
	data.criticalDone = criticalDone;
	
	CleanUI_ShowHealingTooltipWithData(self, data);
end

function CleanUI_ShowHealingTooltipWithDelta(self, delta)
	local data;
	
	local oldPos = statisticsPos;
	
	if (not statisticsPos) then
		statisticsPos = 1;
		data = statistics[1];
	else
		if ( delta > 0 ) then
			statisticsPos = statisticsPos + 1;
			if (statisticsPos > HISTORY_SIZE) then
				statisticsPos = 1;
			end
		elseif ( delta < 0 ) then
			statisticsPos = statisticsPos - 1;
			if (statisticsPos <1) then
				statisticsPos = HISTORY_SIZE;
			end
		end
		data = statistics[statisticsPos];
	end
	
	if (data) then
		CleanUI_ShowHealingTooltipWithData(self, data);
	else
		statisticsPos = oldPos;
	end
end

function CleanUI_ShowHealingTooltipWithData(self, data)
    local ordered = {};
    
    for index, srcName in pairs(data.srcNames) do   
        local healingDoneValue = data.healingDone[srcName] or 0;
        local overhealingDoneValue = data.overhealingDone[srcName] or 0;
        
        local netto = healingDoneValue - overhealingDoneValue;
        
        ordered[netto] = {name = srcName, healing = healingDoneValue, overhealing = overhealingDoneValue};
    end 
    
    GameTooltip_SetDefaultAnchor(GameTooltip, self);
    GameTooltip:SetText("MistWeaver "..STATISTICS);
    
    if (data.date) then
    	GameTooltip:AddLine(data.date);
    else
    	GameTooltip:AddLine("(last combat)");
    end
    
	GameTooltip:AddLine("");
    
    local color, str_healing, str_amount, str_overhealing;
    
    for netto, entry in mw_pairsByKeysDesc(ordered) do
        color = "909090";
        
        if (data.srcClasses[entry.name]) then
            classColor = RAID_CLASS_COLORS[data.srcClasses[entry.name]];
            
            if (classColor) then
                color = mw_rgb2hex(classColor.r, classColor.g, classColor.b);
            end
        end
        
        str_healing = BreakUpLargeNumbers(netto);
        str_amount = BreakUpLargeNumbers(entry.healing);
        str_overhealing = BreakUpLargeNumbers(entry.overhealing);
        
        GameTooltip:AddDoubleLine("|cff"..color..entry.name..FONT_COLOR_CODE_CLOSE, "|cffffffff"..str_healing.."  (amount: "..str_amount..", overhealing: "..str_overhealing..")"..FONT_COLOR_CODE_CLOSE, nil, nil, nil, nil, nil, nil);
    end
        
    GameTooltip:Show();
end

function MistWeaver_Statistics_Send(channel, sendTo, message)    
    if (channel == "p") then
        SendChatMessage(message, "PARTY", nil, sendTo);
    elseif (channel == "ra") then
        SendChatMessage(message, "RAID", nil, sendTo);
    elseif (channel == "g") then
        SendChatMessage(message, "GUILD", nil, sendTo);
    elseif (channel == "bg") then
        SendChatMessage(message, "BATTLEGROUND", nil, sendTo);
    elseif (channel == "s") then
        SendChatMessage(message, "SAY", nil, sendTo);
    elseif (channel == "w") then
        if (not sendTo or sendTo == "") then
            sendTo = UnitName("target");
        end
        
        if (sendTo) then
            SendChatMessage(message, "WHISPER", nil, sendTo);
        end
    end
end

function MistWeaver_Statistics_Calculate(timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, amount, overhealing, absorbed, critical)
    if (InCombatLockdown() == nil) then
        return;
    end
    
    if (not srcName) then
        return;
    end
    
    if (not events[eventType]) then
        return;
    end
    
    if (not srcNames[srcName]) then
        srcNames[srcName] = srcName;
    end
    
    if (not srcClasses[srcName]) then
        local locClass, engClass, locRace, engRace, gender = GetPlayerInfoByGUID(srcGUID);
        srcClasses[srcName] = engClass;
    end
    
    lastShotTime[srcName] = GetTime();
    
    -- collect values   
    if (amount and amount > 0) then
        local dd = (healingDone[srcName] or 0) + amount;
        healingDone[srcName] = dd;
        
        if (not combatStartTime[srcName]) then
            combatStartTime[srcName] = GetTime();
        end
    end
    
    if (overhealing and overhealing > 0) then
        local dd = (overhealingDone[srcName] or 0) + overhealing;
        overhealingDone[srcName] = dd;
    end
    
    if (absorbed and absorbed > 0) then
        local dd = (absorbedDone[srcName] or 0) + absorbed;
        absorbedDone[srcName] = dd;
    end
    
    if (critical and critical > 0) then
        local dd = (criticalDone[srcName] or 0) + critical;
        criticalDone[srcName] = dd;
    end
end
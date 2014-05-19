local _
local frame	= CreateFrame("Frame", nil, UIParent)
local textframe = CreateFrame("Frame", "MoPRaresText", UIParent)
textframe:SetSize(220,25)
textframe:SetPoint("LEFT",200,100)
textframe:SetMovable(true)
textframe:EnableMouse(true)
textframe:RegisterForDrag("LeftButton")
textframe:SetScript("OnDragStart", frame.StartMoving)
textframe:SetScript("OnDragStop", frame.StopMovingOrSizing)
textframe:SetUserPlaced(true)
textframe.bg = textframe:CreateTexture(nil, "BACKGROUND")
textframe.bg:SetAllPoints(textframe)
textframe.bg:SetTexture(0,0,0,0.7)
textframe.text = textframe:CreateFontString(nil, "OVERLAY")
textframe.text:SetPoint("TOPLEFT", 10, -10)
textframe.text:SetFont("Fonts\\ARIALN.TTF",13,"OUTLINE")
textframe.text:SetTextColor(1,0.8,0,1)
local mobs = {
	-- npc_id = {message sent, died time, name, death reported}
	[50358] = {0, 0, 0, 0},
	[69664] = {0, 0, 0, 0},
	[69996] = {0, 0, 0, 0},
	[69997] = {0, 0, 0, 0},
	[69998] = {0, 0, 0, 0},
	[69999] = {0, 0, 0, 0},
	[70000] = {0, 0, 0, 0},
	[70001] = {0, 0, 0, 0},
	[70002] = {0, 0, 0, 0},
	[70003] = {0, 0, 0, 0},
	[73158] = {0, 0, 0, 0},
	[73160] = {0, 0, 0, 0},
	[73161] = {0, 0, 0, 0},
	[72909] = {0, 0, 0, 0},
	[72245] = {0, 0, 0, 0},
	[71919] = {0, 0, 0, 0},
	[72193] = {0, 0, 0, 0},
	[72045] = {0, 0, 0, 0},
	[71864] = {0, 0, 0, 0},
	[73854] = {0, 0, 0, 0},
	[72048] = {0, 0, 0, 0},
	[72769] = {0, 0, 0, 0},
	[73277] = {0, 0, 0, 0},
	[72775] = {0, 0, 0, 0},
	[73282] = {0, 0, 0, 0},
	[72808] = {0, 0, 0, 0},
	[73166] = {0, 0, 0, 0},
	[73163] = {0, 0, 0, 0},
	[73157] = {0, 0, 0, 0},
	[73170] = {0, 0, 0, 0},
	[73169] = {0, 0, 0, 0},
	[73171] = {0, 0, 0, 0},
	[73175] = {0, 0, 0, 0},
	[73173] = {0, 0, 0, 0},
	[73172] = {0, 0, 0, 0},
	[73167] = {0, 0, 0, 0},
	[72970] = {0, 0, 0, 0},
	[73279] = {0, 0, 0, 0},
	[73281] = {0, 0, 0, 0},
	[73174] = {0, 0, 0, 0},
	[72032] = {0, 0, 0, 0},
	[73666] = {0, 0, 0, 0},
	[73281] = {0, 0, 0, 0},
	[73854] = {0, 0, 0, 0},
	[72775] = {0, 0, 0, 0},
	[73704] = {0, 0, 0, 0},
	--[69384] = {0, 0, 0}, --test crab
}
local message
local message_mob_id
local timer, throttle = 0, 3
local text_timer, text_throttle = 0, 10
local general_chat

local function DeathTimes(self,elapsed)
	text_timer = text_timer + elapsed
	if text_timer >= text_throttle then
		local t = ""
		local c = 0
		for k,v in pairs(mobs) do
			if mobs[k][2] > 0 then
				t = t .. mobs[k][3] .. " : " .. SecondsToTime(GetTime() - mobs[k][2], true) .. "\n"
				c = c + 1
			end
		end
		textframe.text:SetText(t)
		textframe:SetHeight(25 + c*13)
		text_timer = 0
	end
end

local function getGeneral(id, name, ...)
	if id and name then
		if strfind(name, GENERAL) then
			return id
		end
	return getGeneral(...)
	end
end
	
local function init()
    local current_map_id = GetCurrentMapAreaID();
	if current_map_id == 928 or current_map_id == 951 then
		frame:RegisterEvent("CHAT_MSG_CHANNEL")
		frame:RegisterEvent("PLAYER_TARGET_CHANGED")
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		textframe:Show()
		textframe:SetScript("OnUpdate", DeathTimes)
	else
		frame:UnregisterEvent("CHAT_MSG_CHANNEL")
		frame:UnregisterEvent("PLAYER_TARGET_CHANGED")
		frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		textframe:Hide()
		textframe:SetScript("OnUpdate", nil)
	end
end

local function update(self,elapsed)
	timer = timer + elapsed;
	if timer >= throttle then
		general_chat = getGeneral(GetChannelList())
		if mobs[message_mob_id][4] == true then -- npc death reported
			timer = 0
		elseif mobs[message_mob_id][2] > 0 then -- npc died but not reported
			SendChatMessage(message , "CHANNEL", nil, general_chat)
			mobs[message_mob_id][4] = true
		elseif mobs[message_mob_id][1] + 30 < GetTime() then -- npc spotted but not not reported
			SendChatMessage(message , "CHANNEL", nil, general_chat)
		end
        timer = 0
		frame:SetScript("OnUpdate", nil)
	end
end

local function RandomizeTime()
	throttle = math.random()*2
	frame:SetScript("OnUpdate", update)
end

local function events(frame, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _,event_type,_,_,_,_,_,guid,name = select(1, ...)
		if event_type == "UNIT_DIED" and guid == UnitGUID("target") then
			local id = tonumber(guid:sub(6, 10), 16)
			if not mobs[id] then return end
			mobs[id][2] = GetTime()
			mobs[id][3] = name
			message = "npc"..id..": "..name.." (0%)"
			message_mob_id = id
			RandomizeTime()
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		local guid = UnitGUID("target")
		if guid and mobs[tonumber(guid:sub(6, 10), 16)] and not UnitIsDead("target") then
			local id = tonumber(guid:sub(6, 10), 16)
			local name = UnitName("target")
			local x, y = GetPlayerMapPosition("player")
			local hp = math.floor(UnitHealth("target")*100/UnitHealthMax("target"))
			mobs[id][2] = 0
			mobs[id][4] = false
			message = "npc"..id..": "..name.." ("..hp.."%). @ "..math.floor(x*100)..", "..math.floor(y*100)
			message_mob_id = id
			RandomizeTime()
		end
	elseif event == "CHAT_MSG_CHANNEL" then
		local msg,_,_,_,_,_,_,channel = select(1, ...)
		if channel == 1 and string.sub(msg,1,3) == "npc" then
			local id = tonumber(string.sub(msg,4,8))
			if mobs[id] then 
				mobs[id][1] = GetTime()
				if string.find(msg,'%(0%%%)') then 
					mobs[id][2] = GetTime()
					mobs[id][4] = true
					mobs[id][3] = string.match(msg,"[^\(]*",11)
				else
					mobs[id][2] = 0
					mobs[id][4] = false
				end
			end
		end
	elseif(event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA") then
		init()
	end
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", events)

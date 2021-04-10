local frame = CreateFrame("Frame")

function LUSTDETECTORMSG(msg)
	local LUSTDETECTORType = LUSTDETECTORMode
	if LUSTDETECTORMode=="SELF" then
		print(msg)
		return
	elseif LUSTDETECTORMode == "TEST" then
		LUSTDETECTORype="TEST"
	elseif LUSTDETECTORMode=="RAID_WARNING" or LUSTDETECTORMode == "GROUP" then
		if IsInRaid() and LUSTDETECTORMode=="RAID_WARNING" and (IsEveryoneAssistant() or UnitIsGroupAssistant("player") or UnitIsGroupLeader("player") or UnitIsRaidOfficer("player")) then
			LUSTDETECTORTypeType = "RAID_WARNING"
		elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			LUSTDETECTORType = "INSTANCE_CHAT"
		elseif IsInRaid() then
			LUSTDETECTORType = "RAID"
		elseif IsInGroup() then
			LUSTDETECTORType = "PARTY"
		end
	end
	SendChatMessage(msg,LUSTDETECTORType)
end
	
local function handler (msg)
	msg=string.upper(msg)
	if msg == 'ON' or msg == 'OFF' then
		LUSTDETECTOR = (msg == 'ON')
		if LUSTDETECTOR then
			frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		else
			frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
		print("Lust Detector is now |cff0042ff"..(LUSTDETECTOR and "On" or "Off").."|r.")
		
	elseif msg == 'SAY' or msg == 'GROUP' or msg == 'SELF' or msg == 'YELL' then
		LUSTDETECTORMode = msg
		print("Lust Detector is now set for announcing to |cffff0000"..LUSTDETECTORMode.."|r.")
		
	elseif msg=="RW" or msg=="RAIDWARNING" then
		LUSTDETECTORMode="RAID_WARNING"
		print("Lust Detector is now set for announcing to |cffff0000"..LUSTDETECTOR.."|r.")
		
	elseif msg == 'TEST' then
		LUSTDETECTORMSG("[Test message] ADDON: Lust Detector is working correctly!")
		
	else
		print("Lust Detector Status: is |cff1cb619"..(LUSTDETECTOR and "On" or "Off").."|r and announcing to: |cff1cb619"..LUSTDETECTORMode.."|r.\nCommands:\non/off,say/yell/group/self/test")
	end
end

SlashCmdList["LUSTDETECTOR"] = handler;
SlashCmdList["WL2"] = handler;
SLASH_LUSTDETECTOR1 = "/lustdetector"
SLASH_WL21 = "/ld"

local warpSpells = {
	[2825] = true, -- Bloodlust
	[178207] = true, -- Drums of Fury
	[256740] = true, -- Drums of the Maelstrom
	[230935] = true, -- Drums of the Mountain
	[32182] = true, -- Heroism
	[264667] = true, -- Primal Rage
	[275200] = true, -- Primal Rage
	[1626] = true, -- Primal Rage
	[272678] = true, -- Primal Rage
	[204276] = true, -- Primal Rage
	[80353] = true, -- Time Warp
	[121546] = true, -- Time Warp
	[293076] = true, -- Mallet of Thunderous Skins
	[309658] = true, -- Drums of Deathly Ferocity
	[146613] = true, -- Drums of Rage 
	
	
}

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		if LUSTDETECTOR == nil then
			LUSTDETECTOR = true
		end
		
		if LUSTDETECTORMode == nil then
			LUSTDETECTORMode = "GROUP"
		elseif LUSTDETECTORMode ~= string.upper(LUSTDETECTORMode) then
			LUSTDETECTORMode = string.upper(LUSTDETECTORMode)
		end
		
		if LUSTDETECTOR == true then
			frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		else
			frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end

	else
		local _, event, _, _, sourceName, _, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()		
		local pNum=GetNumGroupMembers()
		if LUSTDETECTOR and warpSpells[spellID] and pNum > 0 and (event=="SPELL_CAST_SUCCESS") then
			if (UnitPlayerOrPetInParty(sourceName) or UnitPlayerOrPetInRaid(sourceName)) then
				if UnitIsPlayer(sourceName) then
					LUSTDETECTORMSG("Lust Detector: "..sourceName.." Used an haste spell or drum on the party "..GetSpellLink(spellID).."!")
				else
					if UnitIsUnit("pet", sourceName) then
						sourceName = ("%s"):format(UnitName("player"))
					elseif IsInRaid() then
						for x = 1, pNum do
							if UnitIsUnit(("raidpet%i"):format(x), sourceName ) then
								sourceName = ("%s"):format(UnitName(("raid%i"):format(x)))
								break
							end
						end
					elseif IsInGroup() then 
						for x = 1, pNum do
							if UnitIsUnit(("partypet%i"):format(x), sourceName ) then
								sourceName = ("%s"):format(UnitName(("party%i"):format(x)))
								break
							end
						end
					end
					LUSTDETECTORMSG("Lust Detector: [HUNTER] "..sourceName.."\'s hunter's Pet Used "..GetSpellLink(spellID).."And increased +30% Haste on your party!")
				end
			end
		end
	end
end)
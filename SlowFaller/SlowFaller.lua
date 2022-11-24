local _, L = ...

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_ENTERING_WORLD");

local spellID = 130
local buffID = 130
if select(2, UnitClassBase("player")) == 5 then
	spellID = 1706
	buffID = 111759
elseif select(2, UnitClassBase("player")) == 8 then
	spellID = 130
	buffID = 130
elseif select(2, UnitClassBase("player")) == 11 then
	spellID = 164862
	buffID = 164862
	--[[
elseif select(2, UnitClassBase("player")) == 4 then -- a silly rogue test
	spellID = 56814
	buffID = 56814
	]]
else
	f:SetScript("OnEvent", function()
		DEFAULT_CHAT_FRAME:AddMessage(L["Oh no!"])
	end)
	
	--Hello friend! The SlowFaller addon is enabled but will not run any code because this class does not have slow fall, flap, or levitate.
	--DEFAULT_CHAT_FRAME:AddMessage(L["Hello!"])
	return
end
f:SetScript("OnEvent", function()
	DEFAULT_CHAT_FRAME:AddMessage(L["Hello!"])
end)

--Hello friend! The SlowFaller addon is now enabled on a class with a slow fall ability. Double-jump to activate slow fall, flap, or levitate. Does not work in combat or while mounted.
--DEFAULT_CHAT_FRAME:AddMessage(L["Hello!"])

local INVALID_SPELL = {
	302677, -- Anti-Gravity Pack
	303841, -- Anti-Gravity Pack
	313053, -- Faerie's Blessing
	323695, -- Faerie Dust
	356280, -- Dragon Companion's Vigilance
	383363, -- Lift Off
	--1459, -- Arcane Intellect test
};

local SlowFallEvent = CreateFrame("Frame")

--SlowFallEvent:RegisterEvent("ADDON_LOADED");
SlowFallEvent:RegisterEvent("PLAYER_ENTERING_WORLD");

function SlowFallEvent:OnEvent(event,arg1)

	if event ~= "PLAYER_ENTERING_WORLD" then
		ClearOverrideBindings(SlowFallEvent);
	end

	if event == "PLAYER_ENTERING_WORLD" then
		SlowFallEvent:RegisterEvent("PLAYER_LOGOUT");
		SlowFallEvent:RegisterEvent("PLAYER_REGEN_DISABLED");
		SlowFallEvent:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED");

		local spell = Spell:CreateFromSpellID(spellID);
		local buff = Spell:CreateFromSpellID(buffID);
		local key1, key2 = GetBindingKey("JUMP");
		--local badBuff = C_UnitAuras.GetPlayerAuraBySpellID(INVALID_SPELL[spellID]);

		function SlowFallEvent.Jumpy(self, key)
			if UnitAffectingCombat("player") or IsMounted() or select(1, IsUsableSpell(spellID)) == false  then --or (not badBuff) or (not C_UnitAuras.GetPlayerAuraBySpellID(INVALID_SPELL[k]))
				return
			else
				key1, key2 = GetBindingKey("JUMP");
				local aura = C_UnitAuras.GetPlayerAuraBySpellID(spellID) or C_UnitAuras.GetPlayerAuraBySpellID(buffID);
				if key == ( key1 or key2 ) then
					for k,v in pairs(INVALID_SPELL) do
						if C_UnitAuras.GetPlayerAuraBySpellID(INVALID_SPELL[k]) then
							return
						end
					end
					if IsFalling() == true then
						if aura then
							CancelSpellByName(spell:GetSpellName());
							ClearOverrideBindings(SlowFallEvent);
							return
						else
							SetOverrideBinding(SlowFallEvent, true, key1, "SPELL " .. spell:GetSpellName());
						end
					end
					if IsFalling() == false then
						ClearOverrideBindings(SlowFallEvent);
					end
				end
			end
		end

		SlowFallEvent:SetScript("OnKeyDown", SlowFallEvent.Jumpy);
		SlowFallEvent:SetPropagateKeyboardInput(true);
	end
end
SlowFallEvent:SetScript("OnEvent",SlowFallEvent.OnEvent);
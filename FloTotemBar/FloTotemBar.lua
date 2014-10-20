-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

local VERSION = "6.0.34"

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
local _

local SCHOOL_COLORS = {
	[""] = { 1.0, 0.7, 0.0 },
	[1] = { 1.0, 0.3, 0.0 },
	[2] = { 0.5, 0.5, 1.0 },
	[3] = { 0.0, 1.0, 0.0 },
	[4] = { 1.0, 0.7, 0.0 },
	[5] = { 1.0, 0.7, 0.0 }
};

local ALGO_TRAP;

local SHOW_WELCOME = true;
local FLOTOTEMBAR_OPTIONS_DEFAULT = { [1] = { scale = 1, borders = true, barLayout = "1row", barSettings = {} }, active = 1 };
FLOTOTEMBAR_OPTIONS = FLOTOTEMBAR_OPTIONS_DEFAULT;
local FLOTOTEMBAR_BARSETTINGS_DEFAULT = {
	["CALL"] = { buttonsOrder = {}, position = "auto", color = { 0.49, 0, 0.49, 0.7 }, hiddenSpells = {} },
	["TRAP"] = { buttonsOrder = {}, position = "auto", color = { 0.49, 0.49, 0, 0.7 }, hiddenSpells = {} },
	["EARTH"] = { buttonsOrder = {}, position = "auto", color = { 0, 0.49, 0, 0.7 }, hiddenSpells = {} },
	["FIRE"] = { buttonsOrder = {}, position = "auto", color = { 0.49, 0, 0, 0.7 }, hiddenSpells = {} },
	["WATER"] = { buttonsOrder = {}, position = "auto", color = { 0, 0.49, 0.49, 0.7 }, hiddenSpells = {} },
	["AIR"] = { buttonsOrder = {}, position = "auto", color = { 0, 0, 0.99, 0.7 }, hiddenSpells = {} },
};
FLO_CLASS_NAME = nil;
local ACTIVE_OPTIONS = FLOTOTEMBAR_OPTIONS[1];

local FLO_TOTEMIC_CALL_SPELL = GetSpellInfo(TOTEM_MULTI_CAST_RECALL_SPELLS[1]);

-- Ugly
local changingSpec = true;

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- Executed on load, calls general set-up functions
function FloTotemBar_OnLoad(self)

	ALGO_TRAP = {
		[1] = FloTotemBar_CheckTrapLife,
		[2] = FloTotemBar_CheckTrapLife,
		[3] = FloTotemBar_CheckTrap2Life,
		[4] = function() end,
		[5] = FloTotemBar_CheckTrapLauncherTime
	};
	
	-- Re-anchor the first button, link it to the timer
	local thisName = self:GetName();
	local button = _G[thisName.."Button1"];

	if thisName == "FloBarTRAP" then
		button:SetPoint("LEFT", thisName.."Countdown4", "RIGHT", 5, 0);
	elseif thisName ~= "FloBarCALL" then
		button:SetPoint("LEFT", thisName.."Countdown", "RIGHT", 5, 0);
	end

	-- Class-based setup, abort if not supported
	_, FLO_CLASS_NAME = UnitClass("player");
	FLO_CLASS_NAME = strupper(FLO_CLASS_NAME);

	local classSpells = FLO_TOTEM_SPELLS[FLO_CLASS_NAME];

	if classSpells == nil then
		return;
	end
	
	self.totemtype = string.sub(thisName, 7);

	-- Store the spell list for later
	self.availableSpells = classSpells[self.totemtype];
	if self.availableSpells == nil then
		return;
	end

	-- Init the settings variable
	ACTIVE_OPTIONS.barSettings[self.totemtype] = FLOTOTEMBAR_BARSETTINGS_DEFAULT[self.totemtype];

	self.spells = {};
	self.SetupSpell = FloTotemBar_SetupSpell;
	self.OnSetup = FloTotemBar_OnSetup;
	self.menuHooks = { SetPosition = FloTotemBar_SetPosition, SetBorders = FloTotemBar_SetBorders };
	if FLO_CLASS_NAME == "SHAMAN" then
		if self.totemtype ~= "CALL" then
			self.slot = _G[self.totemtype.."_TOTEM_SLOT"];
		end
		self.menuHooks.SetLayoutMenu = FloTotemBar_SetLayoutMenu;
	end
	self:EnableMouse(1);
	
	if SHOW_WELCOME then
		DEFAULT_CHAT_FRAME:AddMessage( "FloTotemBar "..VERSION.." loaded." );
		SHOW_WELCOME = nil;

		SLASH_FLOTOTEMBAR1 = "/flototembar";
		SLASH_FLOTOTEMBAR2 = "/ftb";
		SlashCmdList["FLOTOTEMBAR"] = FloTotemBar_ReadCmd;

		self:RegisterEvent("ADDON_LOADED");
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	end
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("LEARNED_SPELL_IN_TAB");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("PLAYER_ALIVE");
	self:RegisterEvent("PLAYER_LEVEL_UP");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	self:RegisterEvent("UPDATE_BINDINGS");
	self:RegisterEvent("GLYPH_ADDED");
	self:RegisterEvent("GLYPH_REMOVED");

	if self.totemtype ~= "CALL" then
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player");
		self:RegisterEvent("PLAYER_DEAD");

		-- Destruction detection
		if FLO_CLASS_NAME == "SHAMAN" then
			self:RegisterEvent("PLAYER_TOTEM_UPDATE");
		else
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			self:RegisterUnitEvent("UNIT_AURA", "player");
		end
	end
end

function FloTotemBar_OnEvent(self, event, arg1, ...)

	if event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_TAB" or event == "PLAYER_ALIVE" or event == "PLAYER_LEVEL_UP" or event == "CHARACTER_POINTS_CHANGED" or event == "GLYPH_ADDED" or event == "GLYPH_REMOVED" then
		if not changingSpec then
			FloLib_Setup(self);

			if FLO_CLASS_NAME == "HUNTER" then
				-- check trap launcher
				local name = GetSpellInfo(77769);
				local buff = UnitBuff("player", name);
				if buff ~= nil then
					FloTotemBar_StartTimer(self, name);
				end
			end
		end

	elseif event == "UNIT_AURA" then
		-- check trap launcher
		local name = GetSpellInfo(77769);
		local buff = UnitBuff("player", name);
		if buff ~= nil then
			FloTotemBar_StartTimer(self, name);
		end

	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		if arg1 == "player" then
			FloTotemBar_StartTimer(self, ...);
		end

	elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
		local spellName = ...;
		if arg1 == "player" and (spellName == FLOLIB_ACTIVATE_SPEC_1 or spellName == FLOLIB_ACTIVATE_SPEC_2) then
			changingSpec = false;
		end

	elseif event == "SPELL_UPDATE_COOLDOWN" or event == "ACTIONBAR_UPDATE_USABLE" then
		FloTotemBar_TryAddFixupTrapAction();
		FloLib_UpdateState(self);

	elseif event == "PLAYER_DEAD" then
		FloTotemBar_ResetTimers(self);

	elseif event == "ADDON_LOADED" and arg1 == "FloTotemBar" then
		FloTotemBar_MigrateVars();
		FloTotemBar_CheckTalentGroup(FLOTOTEMBAR_OPTIONS.active);

		-- Hook the UIParent_ManageFramePositions function
		hooksecurefunc("UIParent_ManageFramePositions", FloTotemBar_UpdatePositions);
		hooksecurefunc("SetActiveSpecGroup", function() changingSpec = true; end);

	elseif event == "UPDATE_BINDINGS" then
		local totemtype = self.totemtype;
		if totemtype == "TRAP" then totemtype = "EARTH" end
		FloLib_UpdateBindings(self, "FLOTOTEM"..totemtype);

	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
		if FLOTOTEMBAR_OPTIONS.active ~= arg1 then
			FloTotemBar_TalentGroupChanged(arg1);
		end

	else
		-- Events used for totem destruction detection
		local k, v;
		for k, v in pairs(SCHOOL_COLORS) do
			if arg1 and self["activeSpell"..k] and self.spells[self["activeSpell"..k]] then
				self.spells[self["activeSpell"..k]].algo(self, arg1, self["activeSpell"..k], ...);
			end
		end
	end
end

function FloTotemBar_SetFixupTrap(pos)

	local i;
	ACTIVE_OPTIONS.baseActionTrap = pos;
	for i = 1, #FLO_TOTEM_SPELLS.HUNTER.TRAP do
		local name = GetSpellInfo(FLO_TOTEM_SPELLS.HUNTER.TRAP[i].id);
		PickupSpellBookItem(name);
		PlaceAction(pos - 1 + i);
		ClearCursor();
	end
end

function FloTotemBar_FindEmptyActions(qty)

	local a, remain, start;

	start = nil;
	remain = qty;
	a = 73;
	while a <= 120 and remain > 0 do
		if GetActionInfo(a) then
			start = nil;
			remain = qty;
		else
			if start == nil then
				start = a;
			end
			remain = remain - 1;
		end
		a = a + 1;
	end
	if remain > 0 then
		start = nil;
	end
	return start;
end

function FloTotemBar_TryAddFixupTrapAction()

	if ACTIVE_OPTIONS.baseActionTrap == nil then
		local pos = FloTotemBar_FindEmptyActions(#FLO_TOTEM_SPELLS.HUNTER.TRAP);

		if pos then
			FloTotemBar_SetFixupTrap(pos);
		end
	end
end

function FloTotemBar_TalentGroupChanged(grp)

	local k, v;
	-- Save old spec position
	for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
		if v.position ~= "auto" then
			local bar = _G["FloBar"..k];
			v.refPoint = { bar:GetPoint() };
		end
	end

	FloTotemBar_CheckTalentGroup(grp);
	for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
		local bar = _G["FloBar"..k];
		FloLib_Setup(bar);
		-- Restore position
		if v.position ~= "auto" and v.refPoint then
			bar:ClearAllPoints();
			bar:SetPoint(unpack(v.refPoint));
		end
	end
end

function FloTotemBar_CheckTalentGroup(grp)

	local k, v;
	changingSpec = false;

	FLOTOTEMBAR_OPTIONS.active = grp;
	ACTIVE_OPTIONS = FLOTOTEMBAR_OPTIONS[grp];
	-- first time talent activation ?
	if not ACTIVE_OPTIONS then
		-- Copy primary spec options into other spec
		FLOTOTEMBAR_OPTIONS[grp] = {};
		FloLib_CopyPreserve(FLOTOTEMBAR_OPTIONS[1], FLOTOTEMBAR_OPTIONS[grp]);
		ACTIVE_OPTIONS = FLOTOTEMBAR_OPTIONS[grp];
	end
	for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
		local bar = _G["FloBar"..k];
		bar.globalSettings = ACTIVE_OPTIONS;
		bar.settings = v;
		FloTotemBar_SetPosition(nil, bar, v.position);
	end
	FloTotemBar_SetScale(ACTIVE_OPTIONS.scale);
	FloTotemBar_SetBorders(nil, ACTIVE_OPTIONS.borders);

end

function FloTotemBar_MigrateVars()

	local k, v;
	-- Check new dual spec vars
	if not FLOTOTEMBAR_OPTIONS[1] then
		local tmp = FLOTOTEMBAR_OPTIONS;
		FLOTOTEMBAR_OPTIONS = { [1] = tmp };
	end

	-- Copy new variables
	FloLib_CopyPreserve(FLOTOTEMBAR_OPTIONS_DEFAULT, FLOTOTEMBAR_OPTIONS);
	if FLOTOTEMBAR_OPTIONS[2] then
		FloLib_CopyPreserve(FLOTOTEMBAR_OPTIONS_DEFAULT[1], FLOTOTEMBAR_OPTIONS[2]);
	end

	ACTIVE_OPTIONS = FLOTOTEMBAR_OPTIONS[1];

	-- Import old variables
	if FLOTOTEMBAR_LAYOUT then
		for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
			v.position = FLOTOTEMBAR_LAYOUT;
		end
	elseif ACTIVE_OPTIONS.layout then
		for k, v in pairs(ACTIVE_OPTIONS.buttonsOrder) do
			if k ~= "TRAP" then
				ACTIVE_OPTIONS.barSettings[k] = FLOTOTEMBAR_BARSETTINGS_DEFAULT[k];
				ACTIVE_OPTIONS.barSettings[k].position = ACTIVE_OPTIONS.layout;
			end
		end
		ACTIVE_OPTIONS.layout = nil;
	end
	if FLOTOTEMBAR_SCALE then
		ACTIVE_OPTIONS.scale = FLOTOTEMBAR_SCALE;
	end
	if FLOTOTEMBAR_BUTTONS_ORDER then
		for k, v in pairs(FLOTOTEMBAR_BUTTONS_ORDER) do
			if k ~= "TRAP" then
				ACTIVE_OPTIONS.barSettings[k].buttonsOrder = v;
			end
		end
	elseif ACTIVE_OPTIONS.buttonsOrder then
		for k, v in pairs(ACTIVE_OPTIONS.buttonsOrder) do
			if k ~= "TRAP" then
				ACTIVE_OPTIONS.barSettings[k].buttonsOrder = v;
			end
		end
		ACTIVE_OPTIONS.buttonsOrder = nil;
	end

	for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
		FloLib_CopyPreserve(FLOTOTEMBAR_BARSETTINGS_DEFAULT[k], v);
	end

end

function FloTotemBar_ReadCmd(line)

	local i, v;
	local cmd, var = strsplit(' ', line or "");

	if cmd == "scale" and tonumber(var) then
		FloTotemBar_SetScale(var);
	elseif cmd == "lock" or cmd == "unlock" or cmd == "auto" then
		for i, v in ipairs({FloBarTRAP, FloBarCALL, FloBarEARTH, FloBarFIRE, FloBarWATER, FloBarAIR}) do
			FloTotemBar_SetPosition(nil, v, cmd);
		end
	elseif cmd == "borders" then
		FloTotemBar_SetBorders(nil, true);
	elseif cmd == "noborders" then
		FloTotemBar_SetBorders(nil, false);
	elseif cmd == "panic" or cmd == "reset" then
		FloLib_ResetAddon("FloTotemBar");
	elseif cmd == "clearfixup" then
		if ACTIVE_OPTIONS.baseActionTrap then
			ACTIVE_OPTIONS.baseActionTrap = nil;
			for i = 73, 120 do
				local t, id = GetActionInfo(i);
				if t == "spell" and (id == 13795 or id == 1499 or id == 13809 or id == 13813 or id == 34600 or id == 77769) then
					PickupAction(i);
					ClearCursor();
				end
			end
		end
	elseif cmd == "addfixup" then
		FloTotemBar_TryAddFixupTrapAction();
	else
		DEFAULT_CHAT_FRAME:AddMessage( "FloTotemBar usage :" );
		DEFAULT_CHAT_FRAME:AddMessage( "/ftb lock|unlock : lock/unlock position" );
		DEFAULT_CHAT_FRAME:AddMessage( "/ftb borders|noborders : show/hide borders" );
		DEFAULT_CHAT_FRAME:AddMessage( "/ftb auto : Automatic positioning" );
		DEFAULT_CHAT_FRAME:AddMessage( "/ftb scale <num> : Set scale" );
		DEFAULT_CHAT_FRAME:AddMessage( "/ftb panic||reset : Reset FloTotemBar" );
		return;
	end
end

function FloTotemBar_UpdateTotem(self, slot)

	if self.slot == slot then

		local duration = GetTotemTimeLeft(slot);
		if duration == 0 then
			FloTotemBar_ResetTimer(self, "");
		end
	end
end

function FloTotemBar_CheckTrapLife(self, timestamp, spellIdx, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, ...)

	local spell = self.spells[spellIdx];
	local name = string.upper(spell.name);

	if event ~= nil and strsub(event, 1, 5) == "SPELL" and event ~= "SPELL_CAST_SUCCESS" and event ~= "SPELL_CREATE" and string.find(string.upper(spellName), name, 1, true) then
		if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE) then
			FloTotemBar_ResetTimer(self, spell.school);
		else
			FloTotemBar_TimerRed(self, spell.school);
		end
	end
end

function FloTotemBar_CheckTrap2Life(self, timestamp, spellIdx, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)

	local spell = self.spells[spellIdx];
	local name = string.upper(spell.name);
	local COMBATLOG_FILTER_MY_GUARDIAN = bit.bor(
		COMBATLOG_OBJECT_AFFILIATION_MINE,
		COMBATLOG_OBJECT_REACTION_FRIENDLY,
		COMBATLOG_OBJECT_CONTROL_PLAYER,
		COMBATLOG_OBJECT_TYPE_GUARDIAN
		);

	if event ~= nil and strsub(event, 1, 5) == "SWING" and CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_GUARDIAN) then
		FloTotemBar_ResetTimer(self, spell.school);
	end
end

-- Dummy, do nothing here
function FloTotemBar_CheckTrapLauncherTime(self, timestamp, spellIdx, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, ...)

	local spell = self.spells[spellIdx];
	local name = string.upper(spell.name);

	if event == "SPELL_AURA_REMOVED" and string.find(string.upper(spellName), name, 1, true) then
		if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_ME) then
			FloTotemBar_ResetTimer(self, spell.school);
		end
	end
end

function FloTotemBar_SetupSpell(self, spell, pos)

	local duration, algo, school, glyphed, spellName, spellTexture;

        if spell.glyph and FloLib_IsGlyphActive(spell.glyph) then
                school = spell.glyphedSchool;
                glyphed = spell.glyphed;
                spellName = spell.glyphedName;
                spellTexture = spell.glyphedTexture;
        else
                school = spell.school;
                spellName = spell.name;
                spellTexture = spell.texture;
        end

	-- Avoid tainting
	if not InCombatLockdown() then
		local name, button, icon;
		name = self:GetName();
		button = _G[name.."Button"..pos];
		icon = _G[name.."Button"..pos.."Icon"];

		button:SetAttribute("type", "spell");
		button:SetAttribute("spell", spell.name);

		icon:SetTexture(spellTexture);
	end

	if FLO_CLASS_NAME == "SHAMAN" then
		algo = FloTotemBar_UpdateTotem;
	elseif FLO_CLASS_NAME == "HUNTER" then
		duration = spell.duration or 60;
		algo = ALGO_TRAP[school];
	end

	self.spells[pos] = { id = spell.id, name = spellName, addName = spell.addName, duration = duration, algo = algo, school = school, talented = spell.talented, glyphed = glyphed };

end

function FloTotemBar_OnSetup(self)

	if next(self.spells) == nil then
		UnregisterStateDriver(self, "visibility")
	else
		local stateCondition = "nopetbattle,nooverridebar,novehicleui,nopossessbar"
		RegisterStateDriver(self, "visibility", "["..stateCondition.."] show; hide")
	end

	FloTotemBar_ResetTimers(self);
end

function FloTotemBar_UpdatePosition(self)

	-- Avoid tainting when in combat
	if InCombatLockdown() then
		return;
	end

	-- non auto positionning
	if not self.settings or self.settings.position ~= "auto" then
		return;
	end

	local layout = FLO_TOTEM_LAYOUTS[ACTIVE_OPTIONS.barLayout];

	self:ClearAllPoints();
	if self == FloBarEARTH or self == FloBarTRAP then
		local yOffset = -3;
		local yOffset1 = 0;
		local yOffset2 = 0;
		local anchorFrame;

		if not MainMenuBar:IsShown() and not (VehicleMenuBar and VehicleMenuBar:IsShown()) then
			anchorFrame = UIParent;
			yOffset = 110-UIParent:GetHeight();
		else
			anchorFrame = MainMenuBar;
			if ReputationWatchBar:IsShown() and MainMenuExpBar:IsShown() then
				yOffset = yOffset + 9;
			end

			if MainMenuBarMaxLevelBar:IsShown() then
				yOffset = yOffset - 5;
			end

			if SHOW_MULTI_ACTIONBAR_2 then
				yOffset2 = yOffset2 + 45;
			end

			if SHOW_MULTI_ACTIONBAR_1 then
				yOffset1 = yOffset1 + 45;
			end
		end

		if FLO_CLASS_NAME == "HUNTER" then
                        if FloAspectBar ~= nil then
                                self:SetPoint("LEFT", FloAspectBar, "RIGHT", 10/ACTIVE_OPTIONS.scale, 0);
                        else
			        self:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", 512/ACTIVE_OPTIONS.scale, (yOffset + yOffset2)/ACTIVE_OPTIONS.scale);
                        end
		else
			local finalOffset = layout.offset * self:GetHeight();
			self:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", FloBarCALL:GetWidth() + 464, (yOffset + yOffset1)/ACTIVE_OPTIONS.scale + finalOffset);
		end

	elseif FLO_CLASS_NAME == "SHAMAN" then

		self:SetPoint(unpack(layout[self:GetName()]));
	end
end

function FloTotemBar_UpdatePositions()

	local k, j;
	-- Avoid tainting when in combat
	if InCombatLockdown() then
		return;
	end

	for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
		if v.position == "auto" then
			FloTotemBar_UpdatePosition(_G["FloBar"..k])
		end
	end
end

function FloTotemBar_SetBarDrag(frame, enable)

	local countdown = _G[frame:GetName().."Countdown"];
	if enable then
		FloLib_ShowBorders(frame);
		frame:RegisterForDrag("LeftButton");
		if countdown then
			countdown:RegisterForDrag("LeftButton");
		end
	else
		if ACTIVE_OPTIONS.borders then
			FloLib_ShowBorders(frame);
		else
			FloLib_HideBorders(frame);
		end
	end
end

function FloTotemBar_SetBorders(self, visible)

	local k, j;
	ACTIVE_OPTIONS.borders = visible;
	for k, v in pairs(ACTIVE_OPTIONS.barSettings) do
		local bar = _G["FloBar"..k];
		if visible or v.position == "unlock" then
			FloLib_ShowBorders(bar);
		else
			FloLib_HideBorders(bar);
		end
	end

end

function FloTotemBar_SetPosition(self, bar, mode)

	local unlocked = (mode == "unlock");

	-- Close all dropdowns
	CloseDropDownMenus();

	if bar.settings then
		local savePoints = bar.settings.position ~= mode;
		bar.settings.position = mode;
		DEFAULT_CHAT_FRAME:AddMessage(bar:GetName().." position "..mode);

		FloTotemBar_SetBarDrag(bar, unlocked);

		if mode == "auto" then
			-- Force the auto positionning
			FloTotemBar_UpdatePosition(bar);
		else
			-- Force the game to remember position
			bar:StartMoving();
			bar:StopMovingOrSizing();
			if savePoints then
				bar.settings.refPoint = { bar:GetPoint() };
			end
		end
	end
end

function FloTotemBar_SetLayoutMenu()

	local i;
	-- Add the possible values to the menu
	for i = 1, #FLO_TOTEM_LAYOUTS_ORDER do
		local value = FLO_TOTEM_LAYOUTS_ORDER[i];
		local info = UIDropDownMenu_CreateInfo();
		info.text = FLO_TOTEM_LAYOUTS[value].label;
		info.value = value;
		info.func = FloTotemBar_SetLayout;
		info.arg1 = value;

		if value == ACTIVE_OPTIONS.barLayout then
			info.checked = 1;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end

end

function FloTotemBar_SetLayout(self, layout)

	-- Close all dropdowns
	CloseDropDownMenus();

	ACTIVE_OPTIONS.barLayout = layout;
	FloTotemBar_UpdatePositions();
end

function FloTotemBar_SetScale(scale)

	local i, v;
	scale = tonumber(scale);
	if not scale or scale <= 0 then
		DEFAULT_CHAT_FRAME:AddMessage( "FloTotemBar : scale must be >0 ("..scale..")" );
		return;
	end

	local setPoints = ACTIVE_OPTIONS.scale ~= scale;
	ACTIVE_OPTIONS.scale = scale;

	for i, v in ipairs({FloBarTRAP, FloBarCALL, FloBarEARTH, FloBarFIRE, FloBarWATER, FloBarAIR}) do
		local p, a, rp, ox, oy = v:GetPoint();
		local os = v:GetScale();
		v:SetScale(scale);
		if setPoints and p and (a == nil or a == UIParent or a == MainMenuBar) then
			v:SetPoint(p, a, rp, ox*os/scale, oy*os/scale);
		end
	end
	FloTotemBar_UpdatePositions();

end

function FloTotemBar_ResetTimer(self, school)

	self["startTime"..school] = 0;
	FloTotemBar_OnUpdate(self);
end

function FloTotemBar_ResetTimers(self)

	self.startTime = 0;
	self.startTime1 = 0;
	self.startTime2 = 0;
	self.startTime3 = 0;
	FloTotemBar_OnUpdate(self);
end

function FloTotemBar_TimerRed(self, school)

	local countdown = _G[self:GetName().."Countdown"..school];
	if countdown then
		countdown:SetStatusBarColor(0.5, 0.5, 0.5);
	end

end

function FloTotemBar_StartTimer(self, spellName, rank)

	local founded = false;
	local haveTotem, name, startTime, duration, icon;
	local countdown;
	local school;
	local i;

	-- Special case for Totemic Call
	if spellName == FLO_TOTEMIC_CALL_SPELL then
		FloTotemBar_ResetTimer(self, "");
		return;
	end

	-- Find spell
	for i = 1, #self.spells do
		if string.lower(self.spells[i].name) == string.lower(spellName) then
			founded = i;

			if FLO_CLASS_NAME == "SHAMAN" then
				haveTotem, name, startTime, duration, icon = GetTotemInfo(self.slot);
				school = "";
			else
				duration = self.spells[i].duration;
				startTime = GetTime();
				school = self.spells[i].school;
			end
			break;
		end
	end

	if founded and school then

		self["activeSpell"..school] = founded;
		self["startTime"..school] = startTime;

		countdown = _G[self:GetName().."Countdown"..school];
		if countdown then
			countdown:SetMinMaxValues(0, duration);
			countdown:SetStatusBarColor(unpack(SCHOOL_COLORS[school]));
		end
		FloTotemBar_OnUpdate(self);

	end

end

function FloTotemBar_OnUpdate(self)

	local isActive;
	local button;
	local countdown;
	local timeleft;
	local duration;
	local name, spell;
	local i, k, v;

	for i=1, #self.spells do

		name = self:GetName();
		button = _G[name.."Button"..i];

		spell = self.spells[i];

		isActive = false;
		for k, v in pairs(SCHOOL_COLORS) do

			if self["activeSpell"..k] == i then

				countdown = _G[name.."Countdown"..k];
				if countdown then
					_, duration = countdown:GetMinMaxValues();

					timeleft = self["startTime"..k] + duration - GetTime();
					isActive = timeleft > 0;

					if (isActive) then
						countdown:SetValue(timeleft);
						break;
					else
						self["activeSpell"..k] = nil;
						countdown:SetValue(0);
					end
				else
					isActive = self["startTime"..k] ~= 0;
				end
			end
		end

		if isActive then
			button:SetChecked(true);
		else
			button:SetChecked(false);
		end
	end
end

function FloTotemBar_OnEnter(self)
	FloLib_Button_SetTooltip(self);
end

function FloTotemBar_OnLeave(self)
	GameTooltip:Hide();
end


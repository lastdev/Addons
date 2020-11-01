local AceGUI = LibStub('AceGUI-3.0');
local lsm = LibStub('AceGUISharedMediaWidgets-1.0');
local media = LibStub('LibSharedMedia-3.0');
local ADDON_NAME, ADDON_TABLE = ...;
local version = GetAddOnMetadata(ADDON_NAME, "Version");
local addoninfo = 'Main: Ver ' .. version;

BINDING_HEADER_ConRO = "ConRO Hotkeys"
BINDING_NAME_CONROUNLOCK = "Lock/Unlock ConRO"
BINDING_NAME_CONROTOGGLE = "Target Set Toggle (Single/AoE)"
BINDING_NAME_CONROBOSSTOGGLE = "Enemy Set Toggle (Burst/Full)"

ConRO = LibStub('AceAddon-3.0'):NewAddon('ConRO', 'AceConsole-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

ConRO.Textures = {
	['Ping'] = 'Interface\\Cooldown\\ping4',
	['Star'] = 'Interface\\Cooldown\\star4',
	['Starburst'] = 'Interface\\Cooldown\\starburst',
	['Shield'] = 'Interface\\AddOns\\ConRO\\images\\shield2',
	['Skull'] = 'Interface\\AddOns\\ConRO\\images\\skull',
};
ConRO.FinalTexture = nil;

ConRO.Colors = {
	Info = '|cFF1394CC',
	Error = '|cFFF0563D',
	Success = '|cFFBCCF02',
	[1] = '|cFFC79C6E',
	[2] = '|cFFF58CBA',
	[3] = '|cFFABD473',
	[4] = '|cFFFFF569',
	[5] = '|cFFFFFFFF',
	[6] = '|cFFC41F3B',
	[7] = '|cFF0070DE',
	[8] = '|cFF69CCF0',
	[9] = '|cFF9482C9',
	[10] = '|cFF00FF96',
	[11] = '|cFFFF7D0A',
	[12] = '|cFFA330C9',
}

ConRO.Classes = {
	[1] = 'Warrior',
	[2] = 'Paladin',
	[3] = 'Hunter',
	[4] = 'Rogue',
	[5] = 'Priest',
	[6] = 'DeathKnight',
	[7] = 'Shaman',
	[8] = 'Mage',
	[9] = 'Warlock',
	[10] = 'Monk',
	[11] = 'Druid',
	[12] = 'DemonHunter',
}

local defaultOptions = {
	profile = {
		disabledInfo = false,
		enableWindow = true,
		enableDefenseWindow = false,
		enableInterruptWindow = true,
		enablePurgeWindow = true,
		combatWindow = false,
		enableWindowCooldown = true,
		unlockWindow = true,
		enableWindowSpellName = true,
		enableWindowKeybinds = true,	
		transparencyWindow = 0.6,
		burstDefault = false,
		windowIconSize = 50,
		flashIconSize = 50,
		toggleButtonOrientation = 2,
		toggleButtonSize = 1.2,
		interval = 0.20,
		overlayScale = 1,
		damageOverlayAlpha = true,
		defenseOverlayAlpha = true,
		notifierOverlayAlpha = true,
		damageOverlayColor = {r = 0.8,g = 0.8,b = 0.8,a = 1},
		cooldownOverlayColor = {r = 1,g = 0.6,b = 0,a = 1},
		defenseOverlayColor = {r = 0,g = 0.7,b = 1,a = 1},
		interruptOverlayColor = {r = 1,g = 1,b = 1,a = 1},
		purgeOverlayColor = {r = 0.6,g = 0,b = .9,a = 1},
		raidbuffsOverlayColor = {r = 0,g = 0.6,b = 0, a = 1},
		tauntOverlayColor = {r = 0.8,g = 0,b = 0, a = 1},
		movementOverlayColor = {r = 0.2,g = 0.9,b = 0.2, a = 1},
	}
}	

local orientations = {
		"Vertical",
		"Horizontal",
}

local _, _, classIdv = UnitClass('player');
local cversion = GetAddOnMetadata('ConRO_' .. ConRO.Classes[classIdv], 'Version');
local classinfo = " ";

	if cversion ~= nil then
		classinfo = ConRO.Classes[classIdv] .. ': Ver ' .. cversion;
	end

local options = {
	type = 'group',
	name = '-= |cffFFFFFFConRO  (Conflict Rotation Optimizer)|r =-',
	inline = false,
	args = {
		authorPull = {
			order = 1,
			type = "description",
			width = "full",
			name = "Author: Vae",
		},
		versionPull = {
			order = 2,
			type = "description",
			width = "full",
			name = addoninfo,
		},
		cversionPull = {
			order = 3,
			type = "description",
			width = "full",
			name = classinfo,
		},		
		spacer4 = {
			order = 4,
			type = "description",
			width = "full",
			name = "\n\n",
		},
		interval = {
			name = 'Interval in seconds',
			desc = 'Sets how frequent rotation updates will be. Low value will result in fps drops.',
			type = 'range',
			order = 5,
			hidden = true,
			min = 0.01,
			max = 2,
			set = function(info,val) ConRO.db.profile.interval = val end,
			get = function(info) return ConRO.db.profile.interval end
		},
		disabledInfo = {
			name = 'Disable info messages',
			desc = 'Enables / disables info messages, if you have issues with addon, make sure to deselect this.',
			type = 'toggle',
			width = 'double',
			order = 6,
			set = function(info, val)
				ConRO.db.profile.disabledInfo = val;
			end,
			get = function(info) return ConRO.db.profile.disabledInfo end
		},
		reloadButton = {
			name = 'ReloadUI',
			desc = 'Reloads UI after making changes that need it.',
			type = 'execute',
			width = 'normal',
			order = 7,
			func = function(info)
				ReloadUI();
			end
		},
		unlockWindow = {
			name = 'Unlock ConRO',
			desc = 'Make display windows movable.',
			type = 'toggle',
			width = 'normal',
			order = 8,
			set = function(info, val)
				ConRO.db.profile.unlockWindow = val;
				ConROWindow:EnableMouse(ConRO.db.profile.unlockWindow);
				ConRODefenseWindow:EnableMouse(ConRO.db.profile.unlockWindow);
				ConROInterruptWindow:EnableMouse(ConRO.db.profile.unlockWindow);
				ConROPurgeWindow:EnableMouse(ConRO.db.profile.unlockWindow);		
				if val == true and ConRO.db.profile.enableInterruptWindow == true then
					ConROInterruptWindow:Show();				
				else
					ConROInterruptWindow:Hide();				
				end	
				if val == true and ConRO.db.profile.enablePurgeWindow == true then
					ConROPurgeWindow:Show();					
				else
					ConROPurgeWindow:Hide();					
				end			
			end,
			get = function(info) return ConRO.db.profile.unlockWindow end
		},		
		spacer10 = {
			order = 10,
			type = "description",
			width = "full",
			name = "\n\n",
		},
		overlaySettings = {
			type = 'header',
			name = 'Overlay Settings',
			order = 11,
		},
		damageOverlayAlpha = {
			name = 'Show Damage Overlay',
			desc = 'Turn damage overlay on and off.',
			type = 'toggle',
			width = 'default',
			order = 12,
			set = function(info, val)
				ConRO.db.profile.damageOverlayAlpha = val;
			end,
			get = function(info) return ConRO.db.profile.damageOverlayAlpha end
		},
		damageOverlayColor = {
			name = 'Damage Color',
			desc = 'Change damage overlay color.',
			type = 'color',
			hasAlpha = true,
			width = 'default',
			order = 13,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.damageOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.damageOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		cooldownOverlayColor = {
			name = 'Cooldown Color',
			desc = 'Change cooldown burst overlay color.',
			type = 'color',
			hasAlpha = true,
			order = 14,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.cooldownOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.cooldownOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		defenseOverlayAlpha = {
			name = 'Show Defense Overlay',
			desc = 'Turn defense overlay on and off.',
			type = 'toggle',
			width = 'default',
			order = 15,
			set = function(info, val)
				ConRO.db.profile.defenseOverlayAlpha = val;
			end,
			get = function(info) return ConRO.db.profile.defenseOverlayAlpha end
		},
		defenseOverlayColor = {
			name = 'Defense Color',
			desc = 'Change defense overlay color.',
			type = 'color',
			hasAlpha = true,
			order = 16,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.defenseOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.defenseOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		tauntOverlayColor = {
			name = 'Taunt Color',
			desc = 'Change taunt overlay color.',
			type = 'color',
			hasAlpha = true,
			order = 17,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.tauntOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.tauntOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		notifierOverlayAlpha = {
			name = 'Show Notifier Overlay',
			desc = 'Turn interrupt, raid buff and purge overlays on and off.',
			type = 'toggle',
			width = 'default',
			order = 18,
			set = function(info, val)
				ConRO.db.profile.notifierOverlayAlpha = val;
			end,
			get = function(info) return ConRO.db.profile.notifierOverlayAlpha end
		},
		interruptOverlayColor = {
			name = 'Interrupt Color',
			desc = 'Change Interrupt overlay color.',
			type = 'color',
			hasAlpha = true,
			order = 19,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.interruptOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.interruptOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		purgeOverlayColor = {
			name = 'Purgable Color',
			desc = 'Change purge overlay color.',
			type = 'color',
			hasAlpha = true,
			order = 20,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.purgeOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.purgeOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		spacer21 = {
			order = 21,
			type = "description",
			width = "normal",
			name = "\n\n",
		},
		raidbuffsOverlayColor = {
			name = 'Raid Buffs Color',
			desc = 'Change raid buffs overlay color.',
			type = 'color',
			width = "default",
			hasAlpha = true,
			order = 22,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.raidbuffsOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.raidbuffsOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		movementOverlayColor = {
			name = 'Movement Color',
			desc = 'Change movement overlay color.',
			type = 'color',
			width = "default",
			hasAlpha = true,
			order = 23,
			set = function(info, r, g, b, a)
				local t = ConRO.db.profile.movementOverlayColor;
				t.r, t.g, t.b, t.a = r, g, b, a;
			end,
			get = function(info)
				local t = ConRO.db.profile.movementOverlayColor;
				return t.r, t.g, t.b, t.a;
			end
		},
		overlayScale = {
			name = 'Change Overlay Size',
			desc = 'Sets the scale of the Overlays.',
			type = 'range',
			width = 'normal',
			order = 24,
			min = .5,
			max = 1.5,
			step = .1,
			set = function(info,val)
			ConRO.db.profile.overlayScale = val
			end,
			get = function(info) return ConRO.db.profile.overlayScale end
		},
		spacer30 = {
			order = 30,
			type = "description",
			width = "full",
			name = "\n\n",
		},
		toggleButtonSettings = {
			type = 'header',
			name = 'Toggle Button Settings',
			order = 31,
		},
		toggleButtonOrientation = {
			name = 'Toggle Button Orientation',
			desc = 'Sets the orientation of the button for the toggle buttons.',
			type = 'select',
			width = 'normal',
			order = 32,
			values = orientations,
			style = "dropdown",
			set = function(info,val)
				ConRO.db.profile.toggleButtonOrientation = val
				local vert = 2;
				local hori = 1;
					if val == 1 then
						vert = 2;
						hori = 1;
					elseif val == 2 then
						vert = 1;
						hori = 2;
					end
				ConROButtonFrame:SetSize((40 * hori) + 14, (15 * vert) + 14)
					
			end,
			get = function(info) return ConRO.db.profile.toggleButtonOrientation end
		},
		spacer33 = {
			order = 33,
			type = "description",
			width = "normal",
			name = "\n\n",
		},
		spacer34 = {
			order = 34,
			type = "description",
			width = "normal",
			name = "\n\n",
		},

		toggleButtonSize = {
			name = 'Toggle Button Size',
			desc = 'Sets the scale of the toggle buttons.',
			type = 'range',
			width = 'default',
			order = 35,
			min = 1,
			max = 2,
			step = .1,
			set = function(info,val)
			ConRO.db.profile.toggleButtonSize = val
			ConROButtonFrame:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_AutoButton:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_SingleButton:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_AoEButton:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_FullButton:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_BurstButton:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_BlockBurstButton:SetScale(ConRO.db.profile.toggleButtonSize)
			ConRO_BlockAoEButton:SetScale(ConRO.db.profile.toggleButtonSize)			
			end,
			get = function(info) return ConRO.db.profile.toggleButtonSize end
		},
		spacer36 = {
			order = 36,
			type = "description",
			width = "normal",
			name = "\n\n",
		},
		burstDefault = {
			name = 'Burst Rotation',
			desc = 'Make "Burst" rotation the default setting.',
			type = 'toggle',
			width = 'default',
			order = 37,
			set = function(info, val)
				ConRO.db.profile.burstDefault = val;
				if ConROButtonFrame:IsVisible() and not ConRO_BlockBurstButton:IsVisible() then
					if val == true then
						ConRO_FullButton:Hide();
						ConRO_BurstButton:Show();
					else
						ConRO_FullButton:Show();
						ConRO_BurstButton:Hide();
					end
				end
			end,
			get = function(info) return ConRO.db.profile.burstDefault end
		},		
		spacer40 = {
			order = 40,
			type = "description",
			width = "full",
			name = "\n\n",
		},
		displayWindowSettings = {
			type = 'header',
			name = 'Display Window Settings',
			order = 41,
		},
		enableWindow = {
			name = 'Enable Display Window',
			desc = 'Show movable display window.',
			type = 'toggle',
			width = 'default',
			order = 42,
			set = function(info, val)
				ConRO.db.profile.enableWindow = val;
				if val == true and not ConRO:HealSpec() then
					ConROWindow:Show();
				else
					ConROWindow:Hide();
				end
			end,
			get = function(info) return ConRO.db.profile.enableWindow end
		},
		combatWindow = {
			name = 'Only Display with Hostile',
			desc = 'Show display window only when hostile target selected.',
			type = 'toggle',
			width = 'default',
			order = 43,
			set = function(info, val)
				ConRO.db.profile.combatWindow = val;
				if val == true then
					ConROWindow:Hide();
					ConRODefenseWindow:Hide();
				else
					ConROWindow:Show();
					ConRODefenseWindow:Show();				
				end
			end,
			get = function(info) return ConRO.db.profile.combatWindow end
		},
		enableWindowCooldown = {
			name = 'Enable Cooldown Swirl',
			desc = 'Show cooldown swirl on Display Windows. REQUIRES RELOAD',
			type = 'toggle',
			width = 'normal',
			order = 44,
			set = function(info, val)
				ConRO.db.profile.enableWindowCooldown = val;		
			end,
			get = function(info) return ConRO.db.profile.enableWindowCooldown end
		},		
		enableWindowSpellName = {
			name = 'Show Spellname',
			desc = 'Show spellname above Display Windows.',
			type = 'toggle',
			width = 'normal',
			order = 45,
			set = function(info, val)
				ConRO.db.profile.enableWindowSpellName = val;
				if val == true then
					ConROWindow.font:Show();
					ConRODefenseWindow.font:Show();
				else 
					ConROWindow.font:Hide();
					ConRODefenseWindow.font:Hide();
				end
			end,
			get = function(info) return ConRO.db.profile.enableWindowSpellName end
		},
		enableWindowKeybinds = {
			name = 'Show Keybind',
			desc = 'Show keybinds below Display Windows.',
			type = 'toggle',
			width = 'normal',
			order = 46,
			set = function(info, val)
				ConRO.db.profile.enableWindowKeybinds = val;
				if val == true then
					ConROWindow.fontkey:Show();
					ConRODefenseWindow.fontkey:Show();
				else 
					ConROWindow.fontkey:Hide();
					ConRODefenseWindow.fontkey:Hide();
				end
			end,
			get = function(info) return ConRO.db.profile.enableWindowKeybinds end
		},
		spacer47 = {
			order = 47,
			type = "description",
			width = "normal",
			name = "\n\n",
		},		
		transparencyWindow = {
			name = 'Window Transparency',
			desc = 'Change transparency of your windows and texts.',
			type = 'range',
			width = 'normal',
			order = 48,
			min = 0,
			max = 1,
			step = 0.01,
			set = function(info, val)
				ConRO.db.profile.transparencyWindow = val;
			end,
			get = function(info) return ConRO.db.profile.transparencyWindow end
		},	
		windowIconSize = {
			name = 'Display windows Icon size.',
			desc = 'Sets the size of the icon in your display windows. REQUIRES RELOAD',
			type = 'range',
			width = 'normal',
			order = 49,
			min = 20,
			max = 100,
			step = 2,
			set = function(info, val)
				ConRO.db.profile.windowIconSize = val;
			end,
			get = function(info) return ConRO.db.profile.windowIconSize end
		},
		flashIconSize = {
			name = 'Flasher Icon size.',
			desc = 'Sets the size of the icon that flashes for Interrupts and Purges.',
			type = 'range',
			width = 'normal',
			order = 50,
			min = 20,
			max = 100,
			step = 2,
			set = function(info, val)
				ConRO.db.profile.flashIconSize = val;
				ConROInterruptWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
				ConROPurgeWindow:SetSize(ConRO.db.profile.flashIconSize * .25, ConRO.db.profile.flashIconSize * .25);
			end,
			get = function(info) return ConRO.db.profile.flashIconSize end
		},		
		enableDefenseWindow = {
			name = 'Enable Defense Window',
			desc = 'Show movable defense window.',
			type = 'toggle',
			width = 'default',
			order = 51,
			set = function(info, val)
				ConRO.db.profile.enableDefenseWindow = val;
				if val == true then
					ConRODefenseWindow:Show();
				else
					ConRODefenseWindow:Hide();
				end				
			end,
			get = function(info) return ConRO.db.profile.enableDefenseWindow end
		},
		enableInterruptWindow = {
			name = 'Enable Interrupt Window',
			desc = 'Show movable interrupt window.',
			type = 'toggle',
			width = 'default',
			order = 52,			
			set = function(info, val)
				ConRO.db.profile.enableInterruptWindow = val;			
				if val == true and ConRO.db.profile.unlockWindow == true then
					ConROInterruptWindow:Show();				
				else
					ConROInterruptWindow:Hide();
				end	
			end,
			get = function(info) return ConRO.db.profile.enableInterruptWindow end
		},
		enablePurgeWindow = {
			name = 'Enable Purge Window',
			desc = 'Show movable interrupt window.',
			type = 'toggle',
			width = 'default',
			order = 53,		
			set = function(info, val)
				ConRO.db.profile.enablePurgeWindow = val;			
				if val == true and ConRO.db.profile.unlockWindow == true then
					ConROPurgeWindow:Show();
				else
					ConROPurgeWindow:Hide();
				end	
			end,
			get = function(info) return ConRO.db.profile.enablePurgeWindow end
		},
		spacer52 = {
			order = 54,
			type = "description",
			width = "double",
			name = "\n\n",
		},		
		resetExtraWindows = {
			name = 'Reset Positions',
			desc = ('Back to Default. RELOAD REQUIRED'),
			type = 'execute',
			width = 'default',
			order = 55,
			confirm = true,			
			func = function(info)
				ConRO.db.profile.unlockWindow = false;
				ConROInterruptWindow:SetPoint("RIGHT", "ConROWindow", "LEFT", -5, 0);
				ConROPurgeWindow:SetPoint("LEFT", "ConROWindow", "RIGHT", 5, 0);
				ReloadUI();
			end
		},
		resetButton = {
			name = 'Reset Settings',
			desc = 'Resets options back to default. RELOAD REQUIRED',
			type = 'execute',
			width = 'full',
			order = 61,
			confirm = true,
			func = function(info)
				ConRO.db:ResetProfile();
				ConRO.db.profile.unlockWindow = false;
				ConROWindow:SetPoint("CENTER", -200, 50);
				ConRODefenseWindow:SetPoint("CENTER", -250, 50);
				ConROInterruptWindow:SetPoint("RIGHT", "ConROWindow", "LEFT", -5, 0);
				ConROPurgeWindow:SetPoint("LEFT", "ConROWindow", "RIGHT", 5, 0);				
				ReloadUI();
			end
		},
	},
}

function ConRO:GetTexture()
	if self.db.profile.customTexture ~= '' and self.db.profile.customTexture ~= nil then
		self.FinalTexture = self.db.profile.customTexture;
		return self.FinalTexture;
	end

	self.FinalTexture = self.Textures[self.db.profile.texture];
	if self.FinalTexture == '' or self.FinalTexture == nil then
		self.FinalTexture = 'Interface\\Cooldown\\ping4';
	end

	return self.FinalTexture;
end

function ConRO:OnInitialize()
	LibStub('AceConfig-3.0'):RegisterOptionsTable('ConRO', options, {'conro'});
	self.db = LibStub('AceDB-3.0'):New('ConROPreferences', defaultOptions);
	self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('ConRO', 'ConRO');
	self.DisplayWindowFrame();
	self.DefenseWindowFrame();
	self.InterruptWindowFrame();
	self.PurgeWindowFrame();
	self.DisplayToggleFrame();
	self:CreateAutoButton();
	self:CreateSingleButton();
	self:CreateAoEButton();
	self:CreateBurstButton();
	self:CreateFullButton();
	self:CreateBlockBurstButton();
	self:CreateBlockAoEButton();
end

ConRO.DefaultPrint = ConRO.Print;
function ConRO:Print(...)
	if self.db.profile.disabledInfo then
		return;
	end
	ConRO:DefaultPrint(...);
end

function ConRO:EnableRotation()
	if self.NextSpell == nil or self.rotationEnabled then
		self:Print(self.Colors.Error .. 'Failed to enable addon!');
		return;
	end
	
	self.Fetch();
	self:CheckTalents();
	self:CheckPvPTalents();
	
	if self.ModuleOnEnable then
		self.ModuleOnEnable();
	end

	self:EnableRotationTimer();
	self.rotationEnabled = true;
end

function ConRO:EnableDefense()
	if self.NextDef == nil or self.defenseEnabled then
		self:Print(self.Colors.Error .. 'Failed to enable defense module!');
		return;
	end
	
	self.FetchDef();
	self:CheckTalents();
	self:CheckPvPTalents();
	
	if self.ModuleOnEnable then
		self.ModuleOnEnable();
	end

	self:EnableDefenseTimer();
	self.defenseEnabled = true;
end

function ConRO:EnableRotationTimer()
	self.RotationTimer = self:ScheduleRepeatingTimer('InvokeNextSpell', self.db.profile.interval);
end

function ConRO:EnableDefenseTimer()
	self.DefenseTimer = self:ScheduleRepeatingTimer('InvokeNextDef', self.db.profile.interval);
end

function ConRO:DisableRotation()
	if not self.rotationEnabled then
		return;
	end

	self:DisableRotationTimer();

					
	self:DestroyDamageOverlays();
	self:DestroyInterruptOverlays();
	self:DestroyCoolDownOverlays();
	self:DestroyPurgableOverlays();
	self:DestroyRaidBuffsOverlays();
	self:DestroyMovementOverlays();	
	self:DestroyTauntOverlays();
	
	self.Spell = nil;
	self.rotationEnabled = false;
end

function ConRO:DisableDefense()
	if not self.defenseEnabled then
		return;
	end

	self:DisableDefenseTimer();

	self:DestroyDefenseOverlays();
	
	self.Def = nil;
	self.defenseEnabled = false;
end

function ConRO:DisableRotationTimer()
	if self.RotationTimer then
		self:CancelTimer(self.RotationTimer);
	end
end

function ConRO:DisableDefenseTimer()
	if self.DefenseTimer then
		self:CancelTimer(self.DefenseTimer);
	end
end

function ConRO:OnEnable()
	self:RegisterEvent('PLAYER_TARGET_CHANGED');
	self:RegisterEvent('PLAYER_TALENT_UPDATE');
	self:RegisterEvent('ACTIONBAR_SLOT_CHANGED');
	self:RegisterEvent('PLAYER_REGEN_DISABLED');
--	self:RegisterEvent('PLAYER_REGEN_ENABLED');	
	self:RegisterEvent('PLAYER_ENTERING_WORLD');

	self:RegisterEvent('ACTIONBAR_HIDEGRID');
	self:RegisterEvent('ACTIONBAR_PAGE_CHANGED');
	self:RegisterEvent('LEARNED_SPELL_IN_TAB');
	self:RegisterEvent('CHARACTER_POINTS_CHANGED');
	self:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED');
	self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED');
	self:RegisterEvent('UPDATE_MACROS');
	self:RegisterEvent('VEHICLE_UPDATE');

	self:RegisterEvent('UNIT_ENTERED_VEHICLE');
	self:RegisterEvent('UNIT_EXITED_VEHICLE');
	self:RegisterEvent('PLAYER_CONTROL_LOST');
	self:RegisterEvent('PLAYER_CONTROL_GAINED');	

	self:RegisterEvent('PET_BATTLE_OPENING_START');
	self:RegisterEvent('PET_BATTLE_OVER');

	self:Print(self.Colors.Info .. 'Initialized');
end

function ConRO:PLAYER_TALENT_UPDATE()
	self:DisableRotation();
	self:DisableDefense();
	self:LoadModule();
	self:EnableRotation();
	self:EnableDefense();
	
	if ConRO:HealSpec() then
		ConROWindow:Hide();
	elseif ConRO.db.profile.enableWindow and not ConRO.db.profile.combatWindow then
		ConROWindow:Show();
	else
		ConROWindow:Hide();	
	end
end

function ConRO:ACTIONBAR_HIDEGRID()
	if self.rotationEnabled then
		if self.fetchTimer then
			self:CancelTimer(self.fetchTimer);
			self:CancelTimer(self.fetchdefTimer);
		end
		self.fetchTimer = self:ScheduleTimer('Fetch', 0.5);
		self.fetchdefTimer = self:ScheduleTimer('FetchDef', 0.5);
	end

	self:DestroyInterruptOverlays();
	self:DestroyCoolDownOverlays();
	self:DestroyPurgableOverlays();
	self:DestroyRaidBuffsOverlays();
	self:DestroyMovementOverlays();
	self:DestroyTauntOverlays();
end

function ConRO:UNIT_ENTERED_VEHICLE(event, unit)
--	self:Print(self.Colors.Success .. 'Vehicle!');
	if unit == 'player' and self.ModuleLoaded then
		self:DisableRotation();
		self:DisableDefense();
	end
end

function ConRO:UNIT_EXITED_VEHICLE(event, unit)
	if unit == 'player' then
		self:DisableRotation();
		self:DisableDefense();
		self:EnableRotation();
		self:EnableDefense();
	end
end

function ConRO:PET_BATTLE_OPENING_START()
--	self:Print(self.Colors.Success .. 'Pet Battle Started!');

	self:DisableRotation();
	self:DisableDefense();
	ConROWindow:Hide();
	ConRODefenseWindow:Hide();
end

function ConRO:PET_BATTLE_OVER()
--	self:Print(self.Colors.Success .. 'Pet Battle Over!');

	self:DisableRotation();
	self:DisableDefense();
	self:EnableRotation();
	self:EnableDefense();

	if ConRO.db.profile.enableWindow and (ConRO.db.profile.combatWindow or ConRO:HealSpec()) and ConRO:TarHostile() then
		ConROWindow:Show();	
	elseif ConRO.db.profile.enableWindow and not (ConRO.db.profile.combatWindow or ConRO:HealSpec()) then
		ConROWindow:Show();		
	else
		ConROWindow:Hide();			
	end
	
	if ConRO.db.profile.enableDefenseWindow and ConRO.db.profile.combatWindow and ConRO:TarHostile() then
		ConRODefenseWindow:Show();			
	elseif ConRO.db.profile.enableDefenseWindow and not ConRO.db.profile.combatWindow then
		ConRODefenseWindow:Show();			
	else
		ConRODefenseWindow:Hide();			
	end
end

function ConRO:PLAYER_CONTROL_LOST()
--	self:Print(self.Colors.Success .. 'Lost Control!');
		self:DisableRotation();
		self:DisableDefense();
end

function ConRO:PLAYER_CONTROL_GAINED()
	if not C_PetBattles.IsInBattle() then
--		self:Print(self.Colors.Success .. 'Control Gained!');

		self:DisableRotation();
		self:DisableDefense();
		self:EnableRotation();
		self:EnableDefense();
	end
end

function ConRO:PLAYER_ENTERING_WORLD()
	self:UpdateButtonGlow();
	if not self.rotationEnabled then
		self:Print(self.Colors.Success .. 'Auto enable on login!');
		self:Print(self.Colors.Info .. 'Loading class module');
		self:LoadModule();
		self:EnableRotation();
		self:EnableDefense();
	end
end

function ConRO:PLAYER_TARGET_CHANGED()
--	self:Print(self.Colors.Success .. 'Target Changed!');
	
	if self.rotationEnabled then
		if (UnitIsFriend('player', 'target')) then
			return;
		else
			self:DestroyInterruptOverlays();
			self:DestroyPurgableOverlays();
			self:InvokeNextSpell();
		end

		if ConRO.db.profile.enableWindow and (ConRO.db.profile.combatWindow or ConRO:HealSpec()) and ConRO:TarHostile() then
			ConROWindow:Show();	
		elseif ConRO.db.profile.enableWindow and not (ConRO.db.profile.combatWindow or ConRO:HealSpec()) then
			ConROWindow:Show();		
		else
			ConROWindow:Hide();			
		end
		
		if ConRO.db.profile.enableDefenseWindow and ConRO.db.profile.combatWindow and ConRO:TarHostile() then
			ConRODefenseWindow:Show();			
		elseif ConRO.db.profile.enableDefenseWindow and not ConRO.db.profile.combatWindow then
			ConRODefenseWindow:Show();			
		else
			ConRODefenseWindow:Hide();			
		end
	end
end

function ConRO:PLAYER_REGEN_DISABLED()
	local plvl = UnitLevel("player");
	if plvl <= 9 then
		return;
	else
		if not self.rotationEnabled and not UnitHasVehicleUI("player") then
			self:Print(self.Colors.Success .. 'Auto enable on combat!');
			self:Print(self.Colors.Info .. 'Loading class module');
			self:LoadModule();
			self:EnableRotation();
			self:EnableDefense();
		end
	end
end

function ConRO:ButtonFetch()
	if self.rotationEnabled then
		if self.fetchTimer then
			self:CancelTimer(self.fetchTimer);
			self:CancelTimer(self.fetchdefTimer);
		end
		self.fetchTimer = self:ScheduleTimer('Fetch', 0.5);
		self.fetchdefTimer = self:ScheduleTimer('FetchDef', 0.5);
	end
end

ConRO.ACTIONBAR_SLOT_CHANGED = ConRO.ButtonFetch;
--ConRO.ACTIONBAR_HIDEGRID = ConRO.ButtonFetch;
ConRO.ACTIONBAR_PAGE_CHANGED = ConRO.ButtonFetch;
ConRO.LEARNED_SPELL_IN_TAB = ConRO.ButtonFetch;
ConRO.CHARACTER_POINTS_CHANGED = ConRO.ButtonFetch;
ConRO.PLAYER_SPECIALIZATION_CHANGED = ConRO.ButtonFetch;
ConRO.ACTIVE_TALENT_GROUP_CHANGED = ConRO.ButtonFetch;
ConRO.UPDATE_MACROS = ConRO.ButtonFetch;
ConRO.VEHICLE_UPDATE = ConRO.ButtonFetch;

function ConRO:InvokeNextSpell()
	local oldSkill = self.Spell;

	local timeShift, currentSpell, gcd = ConRO:EndCast();
	
	self.Spell = self:NextSpell(timeShift, currentSpell, gcd, self.PlayerTalents, self.PvPTalents);
	ConRO:UpdateRotation();
	ConRO:UpdateButtonGlow();
	local spellName, _, spellTexture = GetSpellInfo(self.Spell);


	if (oldSkill ~= self.Spell or oldSkill == nil) and self.Spell ~= nil then
		self:GlowNextSpell(self.Spell);
		ConROWindow.texture:SetTexture(spellTexture);
		ConROWindow.font:SetText(spellName);
		ConROWindow.fontkey:SetText(ConRO:FindKeybinding(self.Spell));
	end
	
	if self.Spell == nil and oldSkill ~= nil then
		self:GlowClear();
		ConROWindow.texture:SetTexture('Interface\\AddOns\\ConRO\\images\\Bigskull');
		ConROWindow.font:SetText(" ");
		ConROWindow.fontkey:SetText(" ");
	end
end

function ConRO:InvokeNextDef()
	local oldSkill = self.Def;

	local timeShift, currentSpell, gcd = ConRO:EndCast();
	
	self.Def = self:NextDef(timeShift, currentSpell, gcd, self.PlayerTalents, self.PvPTalents);
	local spellName, _, spellTexture = GetSpellInfo(self.Def);
	local color = ConRO.db.profile.defenseOverlayColor;
	
	if (oldSkill ~= self.Def or oldSkill == nil) and self.Def ~= nil then
		self:GlowNextDef(self.Def);
		ConRODefenseWindow.texture:SetTexture(spellTexture);
		ConRODefenseWindow.texture:SetVertexColor(1, 1, 1);
		ConRODefenseWindow.font:SetText(spellName);
		ConRODefenseWindow.fontkey:SetText(ConRO:FindKeybinding(self.Def));
	end
	
	if self.Def == nil and oldSkill ~= nil then
		self:GlowClearDef();
		ConRODefenseWindow.texture:SetTexture('Interface\\AddOns\\ConRO\\images\\shield2');
		ConRODefenseWindow.texture:SetVertexColor(color.r, color.g, color.b);
		ConRODefenseWindow.font:SetText(" ");
		ConRODefenseWindow.fontkey:SetText(" ");
	end
end

function ConRO:LoadModule()
	local _, _, classId = UnitClass('player');
	
	if self.Classes[classId] == nil then
		self:Print(self.Colors.Error, 'Invalid player class, please contact author of addon.');
		return;
	end

	local module = 'ConRO_' .. self.Classes[classId];
	local _, _, _, loadable, reason = GetAddOnInfo(module);
	
	if IsAddOnLoaded(module) then
		local mode = GetSpecialization();
		
		self:EnableRotationModule(mode);
		self:EnableDefenseModule(mode);
		return;
	end

	if reason == 'MISSING' or reason == 'DISABLED' then
		self:Print(self.Colors.Error .. 'Could not find class module ' .. module .. ', reason: ' .. reason);
		return;
	end

	LoadAddOn(module)

	local mode = GetSpecialization();

	self:EnableRotationModule(mode);
	self:EnableDefenseModule(mode);
	self:Print(self.Colors[classId] .. self.Description);

	self:Print(self.Colors.Info .. 'Finished Loading class module');
	self.ModuleLoaded = true;
end

function ConRO:CheckSpecialization()
	local mode = GetSpecialization();

	self:EnableRotationModule(mode);
	self:EnableDefenseModule(mode);
end

function ConRO:HealSpec()
	local _, _, classId = UnitClass('player');
	local specId = GetSpecialization();
	--[[[1] = 'Warrior',
		[2] = 'Paladin',
		[3] = 'Hunter',
		[4] = 'Rogue',
		[5] = 'Priest',
		[6] = 'DeathKnight',
		[7] = 'Shaman',
		[8] = 'Mage',
		[9] = 'Warlock',
		[10] = 'Monk',
		[11] = 'Druid',
		[12] = 'DemonHunter',]]
		
	if (classId == 2 and specId == 1) or
	(classId == 5 and specId == 2) or
	(classId == 7 and specId == 3) or
	(classId == 10 and specId == 2) or
	(classId == 11 and specId == 4)	then
		return true;
	end
	return false;
end

function ConRO:MeleeSpec()
	local _, _, classId = UnitClass('player');
	local specId = GetSpecialization();
	--[[[1] = 'Warrior',
		[2] = 'Paladin',
		[3] = 'Hunter',
		[4] = 'Rogue',
		[5] = 'Priest',
		[6] = 'DeathKnight',
		[7] = 'Shaman',
		[8] = 'Mage',
		[9] = 'Warlock',
		[10] = 'Monk',
		[11] = 'Druid',
		[12] = 'DemonHunter',]]
		
	if classId == 1 or classId == 2 or (classId == 3 and specId == 3) or classId == 4 or classId == 6 or (classId == 7 and specId == 2) or classId == 10 or (classId == 11 and (specId == 2 or specId == 3)) or classId == 12 then
		return true;
	end
	return false;
end
local addonName = ...

local DBM = DBM

local function copyTable(source, dest)
	for k, v in pairs(source) do
		dest[k] = v
	end
end

local defaults = {
	profile = DBM.DefaultOptions,
}

local barDefaultProperties = {}

local barDefaults = {
	profile = {
		-- ["*"] = barDefaultProperties,
		["DBM"] = barDefaultProperties,
	},
}

local barMT = getmetatable(DBT:New().options)

-- create a dummy mod to get the mod metatable
local dummyMod = DBM:NewMod("DBM-ProfilesDummy")
tremove(DBM.Mods)

local bossModPrototype = getmetatable(dummyMod).__index

local function setWarningType(self, color)
	self.announces[#self.announces].warningType = color
end

local function setWarningType1(self, _, color)
	setWarningType(self, color or 1)
end

local function setWarningType2(self, _, color)
	setWarningType(self, color or 2)
end

local function setWarningType3(self, _, color)
	setWarningType(self, color or 3)
end

local optionHooks = {
	NewAnnounce = setWarningType1,
	NewTargetAnnounce = setWarningType2,
	NewTargetCountAnnounce = setWarningType2,
	NewSpellAnnounce = setWarningType3,
	NewEndAnnounce = setWarningType3,
	NewFadesAnnounce = setWarningType3,
	NewAddsLeftAnnounce = setWarningType2,
	NewCountAnnounce = setWarningType3,
	NewStackAnnounce = setWarningType2,
	NewCastAnnounce = setWarningType3,
	NewSoonAnnounce = setWarningType1,
	NewPreWarnAnnounce = function(self, spellId, time, color)
		setWarningType1(self, color)
	end,
	NewPhaseAnnounce = setWarningType1,
	NewPrePhaseAnnounce = setWarningType1,
}

for k, v in pairs(optionHooks) do
	hooksecurefunc(bossModPrototype, k, v)
end

local oldOptions = {}

local namespaces = {}

local addon = CreateFrame("Frame")
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("PLAYER_LOGOUT")
addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local function setTexts(panel, label, type)
	local stats = panel.mod.stats
	local bestTime = stats[type.."BestTime"]
	panel[label.."a"]:SetText(stats[type.."Kills"])
	panel[label.."b"]:SetText(stats[type.."Pulls"] - stats[type.."Kills"])
	panel[label.."c"]:SetText(bestTime and format("%d:%02d", floor(bestTime / 60), bestTime % 60) or "-")
end

local function statsOnShow(panel)
	setTexts(panel, "top1", "normal")
	if panel.mod.type == "PARTY" or panel.mod.type == "SCENARIO" then
		setTexts(panel, "top2", "heroic")
		setTexts(panel, "top3", "challenge")
	else
		setTexts(panel, "top2", "normal25")
		setTexts(panel, "top3", "lfr25")
		setTexts(panel, "bot1", "heroic")
		setTexts(panel, "bot2", "heroic25")
		setTexts(panel, "bot3", "flex")
	end
end

function addon:ADDON_LOADED(addon)
	if addon == "DBM-GUI" then
		DBM:RegisterOnGuiLoadCallback(function()
			local panel = DBM_GUI_Frame:CreateNewPanel("Profiles", "option")
			local area = panel:CreateArea(nil, nil, nil, true)
			AceDBUI:CreateUI("DBM-Profiles-UI", self.db, area.frame)
		end)
		
		local function setOnShow(addon, panel, subtab)
			if addon.noStatistics then return end
			local area = panel.areas[1]
			local frame = area.frame
			wipe(area.onshowcall)
			local n = 0
			
			for _, mod in ipairs(DBM.Mods) do
				if mod.modId == addon.modId and (not subtab or subtab == mod.subTab) and not mod.isTrashMod and not mod.noStatistics then
					local p = {mod = mod}
					local _
					p.top1a, p.top1b, p.top1c, _, _, _, _, p.top2a, p.top2b, p.top2c, _, _, _, _, p.top3a, p.top3b, p.top3c, _, _, _, _,
						p.bot1a, p.bot1b, p.bot1c, _, _, _, _, p.bot2a, p.bot2b, p.bot2c, _, _, _, _, p.bot3a, p.bot3b, p.bot3c
						= select(9 + 6 + (43 * n), frame:GetRegions())
					n = n + 1
					tinsert(area.onshowcall, p)
				end
			end
			frame:SetScript("OnShow", function(self)
				for _, v in pairs(area.onshowcall) do
					statsOnShow(v)
				end
			end)
		end
		
		local loadedSubTabs = {}
		
		local orig_UpdateModList = DBM_GUI.UpdateModList
		function DBM_GUI:UpdateModList()
			orig_UpdateModList(self)
			for k, addon in ipairs(DBM.AddOns) do
				if not IsAddOnLoaded(addon.modId) then
					-- this relies on the Load button being the only child of this frame
					local button = addon.panel.frame:GetChildren()
					local onClick = button:GetScript("OnClick")
					button:SetScript("OnClick", function(self)
						onClick(self)
						self:SetScript("OnClick", onClick)
						setOnShow(self.modid, self.modid.panel)
					end)
				else
					setOnShow(addon, addon.panel)
					if addon.subTabs then
						for k, v in pairs(addon.subTabs) do
							if addon.subPanels[k] then
								setOnShow(addon, addon.subPanels[k], k)
							end
						end
						loadedSubTabs[addon.modId] = true
					end
				end
			end
			-- restore original function and hook it to hook not yet loaded panels
			self.UpdateModList = orig_UpdateModList
			hooksecurefunc(DBM_GUI, "UpdateModList", function(self)
				for k, addon in ipairs(DBM.AddOns) do
					if not loadedSubTabs[addon.modId] and addon.subTabs and IsAddOnLoaded(addon.modId) then
						for k, v in pairs(addon.subTabs) do
							if addon.subPanels[k] then
								setOnShow(addon, addon.subPanels[k], k)
							end
						end
						loadedSubTabs[addon.modId] = true
					end
				end
			end)
		end
	elseif addon == addonName then
		self.db = LibStub("AceDB-3.0"):New("DeadlyBossModsDB", defaults, true)
		self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
		self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
		self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
		LibStub("LibDualSpec-1.0"):EnhanceDatabase(self.db, "DeadlyBossMods")
  
		local barDB = self.db:RegisterNamespace("DeadlyBarTimers", barDefaults)
		self.bars = barDB
		
		self:RefreshConfig()
		
		local defaultStats = {}
		
		-- precreate all addon namespaces so profiles can be copied without the addons being loaded
		for i, v in ipairs(DBM.AddOns) do
			local modDefaults = {
				profile = {
					options = {},
					stats = defaultStats,
				}
			}
			
			local db = self.db:RegisterNamespace(v.modId, modDefaults)
			db.RegisterCallback(self, "OnProfileChanged", "RefreshModConfig")
			db.RegisterCallback(self, "OnProfileCopied", "RefreshModConfig")
			db.RegisterCallback(self, "OnProfileReset", "RefreshModConfig")
		end
	elseif GetAddOnMetadata(addon, "X-DBM-Mod") then
		local modId = addon
		local db = self.db:GetNamespace(modId)
		
		namespaces[db] = modId
		
		local varPrefix = modId:gsub("-", "")
		-- redefine the old saved variables to "trick" the modules into referring to our profiles instead
		_G[varPrefix.."_SavedVars"] = db.profile.options
		_G[varPrefix.."_SavedStats"] = db.profile.stats
		oldOptions[varPrefix.."_SavedVars"] = true
		oldOptions[varPrefix.."_SavedStats"] = true
		
		for i, v in ipairs(DBM.Mods) do
			if v.modId == modId then
				-- db.defaults.profile.options[v.id] = v.DefaultOptions
				db.defaults.profile.stats[v.id] = {
					["*"] = 0,
				}
			end
		end
	end
end

function addon:PLAYER_LOGOUT()
	-- nil out the original saved variables as they won't be used from now on
	for k in pairs(oldOptions) do
		_G[k] = nil
	end
end

function addon:RefreshConfig(event, db, profile)
	DBM.Options = self.db.profile
	DBM.Bars.options = setmetatable(self.bars.profile.DBM, barMT)
	
	DBMMinimapButton:SetShown(self.db.profile.ShowMinimapButton)
	local pos = self.db.profile.RaidWarningPosition
	RaidWarningFrame:ClearAllPoints()
	RaidWarningFrame:SetPoint(pos.Point, UIParent, pos.X, pos.Y)
	DBM:UpdateSpecialWarningOptions()
	local hpAnchor = DBMBossHealthDropdown and DBMBossHealthDropdown:GetParent()
	if hpAnchor then
		hpAnchor:ClearAllPoints()
	end
	DBM.BossHealth:UpdateSettings()
	-- announces uses color tables directly for their options, need to remap these upon changing profile
	for i, v in ipairs(DBM.Mods) do
		for i, v in ipairs(v.announces) do
			v.color = self.db.profile.WarningColors[v.warningType] or self.db.profile.WarningColors[1]
		end
	end
	
	local self = DBM.Bars
	self.mainAnchor:ClearAllPoints()
	self.mainAnchor:SetPoint(self.options.TimerPoint, UIParent, self.options.TimerPoint, self.options.TimerX, self.options.TimerY)
	self.secAnchor:ClearAllPoints()
	self.secAnchor:SetPoint(self.options.HugeTimerPoint, UIParent, self.options.HugeTimerPoint, self.options.HugeTimerX, self.options.HugeTimerY)
	for bar in self:GetBarIterator() do
		if not bar.dummy then
			if bar.moving == "enlarge" then
				bar.enlarged = true
				bar.moving = false
				self.owner.hugeBars:Append(self)
				bar:ApplyStyle()
			end
			bar.moving = nil
			bar:SetPosition()
			if not self.movable then
				bar.frame:EnableMouse(not self.options.ClickThrough)
			end
		end
	end
	DBM.Bars:ApplyStyle()
end

function addon:RefreshModConfig(event, db)
	for i, v in ipairs(DBM.Mods) do
		if v.modId and v.modId == namespaces[db] then
			v.Options = db.profile.options[v.id]
			v.stats = db.profile.stats[v.id]
		end
	end
end
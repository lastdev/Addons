local Amr = LibStub("AceAddon-3.0"):GetAddon("AskMrRobot")
local L = LibStub("AceLocale-3.0"):GetLocale("AskMrRobot", true)
local AceGUI = LibStub("AceGUI-3.0")

local _lblLogging = nil
local _btnToggle = nil
local _panelUndoWipe = nil
local _chkAutoAll = nil
local _autoChecks = nil

local function createDifficultyCheckBox(instanceId, difficultyId, container)
	local chk = AceGUI:Create("AmrUiCheckBox")
	container:AddChild(chk)
	chk:SetText(L.DifficultyNames[difficultyId])
	chk:SetCallback("OnClick", function(widget)
		Amr:ToggleAutoLog(instanceId, difficultyId)
	end)
	
	_autoChecks[instanceId][difficultyId] = chk
	return chk
end

-- render a group of controls for auto-logging of a raid zone
local function renderAutoLogSection(instanceId, container, i, autoLbls, autoChks)
	_autoChecks[instanceId] = {}
	
	local lbl = AceGUI:Create("AmrUiLabel")
	container:AddChild(lbl)
	lbl:SetWidth(200)
	lbl:SetText(L.InstanceNames[instanceId])
	lbl:SetFont(Amr.CreateFont("Regular", 20, Amr.Colors.White))
	
	if i == 1 then
		lbl:SetPoint("TOPLEFT", _chkAutoAll.frame, "BOTTOMLEFT", -1, -15)
	elseif i % 2 == 0 then
		lbl:SetPoint("TOPLEFT", autoLbls[i - 1].frame, "TOPRIGHT", 40, 0)
	else
		lbl:SetPoint("TOPLEFT", autoChks[i - 2].frame, "BOTTOMLEFT", 0, -30)
	end

	local line = AceGUI:Create("AmrUiPanel")
	container:AddChild(line)
	line:SetHeight(1)
	line:SetBackgroundColor(Amr.Colors.White)
	line:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 1, -7)
	line:SetPoint("TOPRIGHT", lbl.frame, "BOTTOMRIGHT", 0, -7)
	
	local chkMythic = createDifficultyCheckBox(instanceId, Amr.Difficulties.Mythic, container)
	chkMythic:SetPoint("TOPLEFT", line.frame, "BOTTOMLEFT", 0, -8)

	local chkNormal = createDifficultyCheckBox(instanceId, Amr.Difficulties.Normal, container)
	chkNormal:SetPoint("TOPLEFT", line.frame, "BOTTOMLEFT", 0, -30)

	-- find the widest of mythic/normal
	local w = math.max(chkMythic:GetWidth(), chkNormal:GetWidth())
	
	local chkHeroic = createDifficultyCheckBox(instanceId, Amr.Difficulties.Heroic, container)
	chkHeroic:SetPoint("TOPLEFT", line.frame, "BOTTOMLEFT", w + 20, -8)
	
	local chkLfr = createDifficultyCheckBox(instanceId, Amr.Difficulties.Lfr, container)
	chkLfr:SetPoint("TOPLEFT", line.frame, "BOTTOMLEFT", w + 20, -30)
		
	return lbl, chkNormal
end

-- renders the main UI for the Combat Log tab
function Amr:RenderTabLog(container)

	-- main commands
	_btnToggle = AceGUI:Create("AmrUiButton")
	container:AddChild(_btnToggle)
	_btnToggle:SetText(L.LogButtonStartText)
	_btnToggle:SetBackgroundColor(Amr.Colors.Green)
	_btnToggle:SetFont(Amr.CreateFont("Bold", 16, Amr.Colors.White))
	_btnToggle:SetWidth(200)
	_btnToggle:SetHeight(26)
	_btnToggle:SetCallback("OnClick", function() Amr:ToggleLogging() end)
	_btnToggle:SetPoint("TOPLEFT", container.content, "TOPLEFT", 0, -40)
	
	_lblLogging = AceGUI:Create("AmrUiLabel")
	container:AddChild(_lblLogging)
	_lblLogging:SetText(L.LogNote)
	_lblLogging:SetWidth(200)	
	_lblLogging:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.BrightGreen))
	_lblLogging:SetJustifyH("MIDDLE")
	_lblLogging:SetPoint("TOP", _btnToggle.frame, "BOTTOM", 0, -5)
	
	local btnReload = AceGUI:Create("AmrUiButton")
	container:AddChild(btnReload)
	btnReload:SetText(L.LogButtonReloadText)
	btnReload:SetBackgroundColor(Amr.Colors.Blue)
	btnReload:SetFont(Amr.CreateFont("Bold", 16, Amr.Colors.White))
	btnReload:SetWidth(200)
	btnReload:SetHeight(26)
	btnReload:SetCallback("OnClick", ReloadUI)
	btnReload:SetPoint("TOPLEFT", _btnToggle.frame, "TOPRIGHT", 40, 0)
	
	--[[
	local lbl = AceGUI:Create("AmrUiLabel")
	lbl:SetText(L.LogReloadNote)
	lbl:SetWidth(200)	
	lbl:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.TextTan))
	lbl:SetJustifyH("MIDDLE")
	lbl:SetPoint("TOP", btnReload.frame, "BOTTOM", 0, -5)
	container:AddChild(lbl)
	
	-- container for undo wipe so we can hide/show it all
	_panelUndoWipe = AceGUI:Create("AmrUiPanel")
	_panelUndoWipe:SetLayout("None")
	_panelUndoWipe:SetBackgroundColor(Amr.Colors.Black, 0)
	_panelUndoWipe:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -40)
	container:AddChild(_panelUndoWipe)
	
	local btnUndoWipe = AceGUI:Create("AmrUiButton")
	btnUndoWipe:SetText(L.LogButtonUndoWipeText)
	btnUndoWipe:SetBackgroundColor(Amr.Colors.Orange)
	btnUndoWipe:SetFont(Amr.CreateFont("Bold", 16, Amr.Colors.White))
	btnUndoWipe:SetWidth(200)
	btnUndoWipe:SetHeight(26)
	btnUndoWipe:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -40)
	btnUndoWipe:SetCallback("OnClick", function() Amr:UndoWipe() end)
	_panelUndoWipe:AddChild(btnUndoWipe)
	
	lbl = AceGUI:Create("AmrUiLabel")
	lbl:SetText(L.LogUndoWipeNote)
	lbl:SetWidth(200)	
	lbl:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.TextTan))
	lbl:SetJustifyH("MIDDLE")
	lbl:SetPoint("TOP", btnUndoWipe.frame, "BOTTOM", 0, -5)
	_panelUndoWipe:AddChild(lbl)
	
	local lbl2 = AceGUI:Create("AmrUiLabel")
	lbl2:SetText(L.LogUndoWipeDate(date("%B %d", time()), date("%I:%M %p", time())))
	lbl2:SetWidth(200)	
	lbl2:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.TextTan))
	lbl2:SetJustifyH("MIDDLE")
	lbl2:SetPoint("TOP", lbl.frame, "BOTTOM", 0, -2)
	_panelUndoWipe:AddChild(lbl2)
	
	local btnWipe = AceGUI:Create("AmrUiButton")
	btnWipe:SetText(L.LogButtonWipeText)
	btnWipe:SetBackgroundColor(Amr.Colors.Orange)
	btnWipe:SetFont(Amr.CreateFont("Bold", 16, Amr.Colors.White))
	btnWipe:SetWidth(200)
	btnWipe:SetHeight(26)
	btnWipe:SetPoint("TOPRIGHT", btnUndoWipe.frame, "TOPLEFT", -40, 0)
	btnWipe:SetCallback("OnClick", function() Amr:Wipe() end)
	container:AddChild(btnWipe)
	
	lbl = AceGUI:Create("AmrUiLabel")
	lbl:SetText(L.LogWipeNote)
	lbl:SetWidth(200)	
	lbl:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.TextTan))
	lbl:SetJustifyH("MIDDLE")
	lbl:SetPoint("TOP", btnWipe.frame, "BOTTOM", 0, -5)
	container:AddChild(lbl)
	
	lbl2 = AceGUI:Create("AmrUiLabel")
	lbl2:SetText(L.LogWipeNote2("/amr wipe"))
	lbl2:SetWidth(200)	
	lbl2:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.TextTan))
	lbl2:SetJustifyH("MIDDLE")
	lbl2:SetPoint("TOP", lbl.frame, "BOTTOM", 0, -2)
	container:AddChild(lbl2)
	]]
	
	-- auto-logging controls
	local lbl = AceGUI:Create("AmrUiLabel")
	container:AddChild(lbl)
	lbl:SetWidth(600)
	lbl:SetText(L.LogAutoTitle)
	lbl:SetFont(Amr.CreateFont("Bold", 24, Amr.Colors.TextHeaderActive))
	lbl:SetPoint("TOPLEFT", _btnToggle.frame, "BOTTOMLEFT", 0, -40)
	
	_chkAutoAll = AceGUI:Create("AmrUiCheckBox")
	container:AddChild(_chkAutoAll)
	_chkAutoAll:SetText(L.LogAutoAllText)
	_chkAutoAll:SetCallback("OnClick", function(widget) Amr:ToggleAllAutoLog() end)
	_chkAutoAll:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 1, -15)
	
	_autoChecks = {}
	
	-- go through all supported instances, rendering in a left->right pattern, 2 per row
	local autoLbls = {}
	local autoChks = {}
	for i, instanceId in ipairs(Amr.InstanceIdsOrdered) do
		local autoLbl, autoChk = renderAutoLogSection(instanceId, container, i, autoLbls, autoChks)		
		
		table.insert(autoLbls, autoLbl)
		table.insert(autoChks, autoChk)
	end
	autoLbls = nil
	autoChks = nil

	-- instructions
	--[[
	lbl = AceGUI:Create("AmrUiLabel")
	lbl:SetText(L.LogInstructionsTitle)
	lbl:SetWidth(480)	
	lbl:SetFont(Amr.CreateFont("Italic", 24, Amr.Colors.Text))
	lbl:SetPoint("TOPRIGHT", container.content, "TOPRIGHT", 0, -40)
	container:AddChild(lbl)
	
	lbl2 = AceGUI:Create("AmrUiLabel")
	lbl2:SetText(L.LogInstructions)
	lbl2:SetWidth(480)	
	lbl2:SetFont(Amr.CreateFont("Italic", 14, Amr.Colors.Text))
	lbl2:SetPoint("TOPLEFT", lbl.frame, "BOTTOMLEFT", 0, -10)
	container:AddChild(lbl2)
	]]
	
	-- initialize state of controls
	Amr:RefreshLogUi()
end

function Amr:ReleaseTabLog()
	_lblLogging = nil
	_btnToggle = nil
	_panelUndoWipe = nil
	_chkAutoAll = nil
	_autoChecks = nil
end

-- update the game's logging state
local function updateGameLogging(enabled)
	if enabled then
		-- always enable advanced combat logging via our addon, gathers more detailed data for better analysis
		SetCVar("advancedCombatLogging", 1)
		LoggingCombat(true)
	else
		LoggingCombat(false)
	end
end

local function isAnyAutoLoggingEnabled()
	local anyChecked = false
	for i, instanceId in ipairs(Amr.InstanceIdsOrdered) do
		for k, difficultyId in pairs(Amr.Difficulties) do
			if Amr.db.profile.Logging.Auto[instanceId][difficultyId] then
				anyChecked = true
				break
			end
		end
		if anyChecked then break end
	end
	
	return anyChecked
end

local function isAllAutoLoggingEnabled()
	-- see if all auto-logging options are enabled
	local allChecked = true
	for i, instanceId in ipairs(Amr.InstanceIdsOrdered) do
		for k, difficultyId in pairs(Amr.Difficulties) do
			if not Amr.db.profile.Logging.Auto[instanceId][difficultyId] then
				allChecked = false
				break
			end
		end
		if not allChecked then break end
	end
	
	return allChecked
end

-- check current zone and auto-logging settings, and enable logging if appropriate
local function updateAutoLogging(force, noWait)
	
	local hasAuto = isAnyAutoLoggingEnabled()
	
	-- before doing anything, make sure logging matches the user's current setting, deals with any inconsistency due to a crash or disconnect
	if hasAuto then
		updateGameLogging(Amr:IsLogging())
	end
	
	-- get the info about the instance
	local zone, _, difficultyId, _, _, _, _, instanceId = GetInstanceInfo()

	if Amr.IsSupportedInstanceId(instanceId) and difficultyId == 0 and not noWait then
		-- the game is sometimes returning no difficulty id for raid zones... not sure why, wait 10 seconds and check again
		Amr.Wait(10, function()
			updateAutoLogging(false, false)
		end)
		return
	end
	
	if not force and zone == Amr.db.char.Logging.LastZone and difficultyId == Amr.db.char.Logging.LastDiff then
	  -- do nothing if the zone hasn't actually changed, otherwise we may override the user's manual enable/disable
		return
	end

	Amr.db.char.Logging.LastZone = zone
	Amr.db.char.Logging.LastDiff = difficultyId

	if Amr.IsSupportedInstanceId(instanceId) then
		if not Amr.db.profile.Logging.Auto[tonumber(instanceId)] then
			Amr.db.profile.Logging.Auto[tonumber(instanceId)] = {}
		end
	end
	
	if Amr.IsSupportedInstanceId(instanceId) and Amr.db.profile.Logging.Auto[tonumber(instanceId)][tonumber(difficultyId)] then
		-- we are in a supported zone that we want to auto-log, turn logging on 
		
		-- (supported check is probably redundant, but just in case someone has old settings lying around)
		if not Amr:IsLogging() then
			Amr:StartLogging()
		end
	elseif hasAuto then
		-- not in a zone that we want to auto-log, turn logging off
		if Amr:IsLogging() then
			Amr:StopLogging()
		end
	end
end

-- sometimes the game doesn't repaint checkboxes when it should... doing this forces it to do so
local function setCheckboxChecked(chk, val)
	chk:SetChecked(val)
	chk:SetChecked(not val)
	chk:SetChecked(val)
	chk:SetText(chk:GetText())
end

-- refresh the state of the tab based on current settings
function Amr:RefreshLogUi()
	if not _btnToggle then return end
	
	-- set state of logging button based on whether it is on or off
	if self:IsLogging() then
		_btnToggle:SetBackgroundColor(Amr.Colors.Red)
		_btnToggle:SetText(L.LogButtonStopText)
	else
		_btnToggle:SetBackgroundColor(Amr.Colors.Green)
		_btnToggle:SetText(L.LogButtonStartText)
	end
	
	_lblLogging:SetVisible(self:IsLogging())
	
	-- hide/show undo wipe button based on whether a wipe has been called recently
	if _panelUndoWipe then
		_panelUndoWipe:SetVisible(Amr.db.char.Logging.LastWipe and true or false)
	end
	
	local all = isAllAutoLoggingEnabled()
	--setCheckboxChecked(_chkAutoAll, all)
	_chkAutoAll:SetChecked(all)
	
	for i, instanceId in ipairs(Amr.InstanceIdsOrdered) do
		if not Amr.db.profile.Logging.Auto[instanceId] then
			Amr.db.profile.Logging.Auto[instanceId] = {}
		end
		for k, difficultyId in pairs(Amr.Difficulties) do
			setCheckboxChecked(_autoChecks[instanceId][difficultyId], Amr.db.profile.Logging.Auto[instanceId][difficultyId])
			--_autoChecks[instanceId][difficultyId]:SetChecked(Amr.db.profile.Logging.Auto[instanceId][difficultyId])
		end
	end
end

function Amr:IsLogging()
	return Amr.db.char.Logging.Enabled
end

function Amr:ToggleLogging()
	if not Amr.db.char.Logging.Enabled then
		Amr:StartLogging()
	else
		Amr:StopLogging()
	end
end

function Amr:StartLogging()

	--[[
	local now = time()
	local oldDuration = 60 * 60 * 24 * 10
	
	-- prune out entries in log data that are more than 10 days old

	-- player data
	local playerData = Amr.db.global.Logging.PlayerData
	if playerData then
		for name, timeList in pairs(playerData) do
			for timestamp, dataString in pairs(timeList) do
				if difftime(now, tonumber(timestamp)) > oldDuration then
					timeList[timestamp] = nil
				end
			end
			
			if next(timeList) == nil then
				playerData[name] = nil
			end
		end
	end
	
	-- same idea with extra info (auras, pets, whatever we end up adding to it)
	local extraData = Amr.db.global.Logging.PlayerExtras
	if extraData then
		for name, timeList in pairs(extraData) do
			for timestamp, dataString in pairs(timeList) do
				if difftime(now, tonumber(timestamp)) > oldDuration then
					timeList[timestamp] = nil
				end
			end
			
			if next(timeList) == nil then
				extraData[name] = nil
			end
		end
	end

	-- delete wipes that are more than 10 days old
	if Amr.db.global.Logging.Wipes then
		local wipes = Amr.db.global.Logging.Wipes
		local i = 1
		while i <= #wipes do
			local t = wipes[i]
			if difftime(now, t) > oldDuration then
		        table.remove(wipes, i)
		    else
		        i = i + 1
		    end
		end
	end

	-- delete the last wipe date if it is more than 10 days old
	if Amr.db.char.Logging.LastWipe and difftime(now, Amr.db.char.Logging.LastWipe) > oldDuration then
		Amr.db.char.Logging.LastWipe = nil
	end
	]]
	
	-- enable game log file
	updateGameLogging(true)
	Amr.db.char.Logging.Enabled = true
	
	self:Print(L.LogChatStart)
	
	self:UpdateMinimap()
	self:RefreshLogUi()
end

function Amr:StopLogging()
	
	updateGameLogging(false)
	Amr.db.char.Logging.Enabled = false
	
	self:Print(L.LogChatStop)
	
	self:UpdateMinimap()
	self:RefreshLogUi()
end

function Amr:Wipe()

	--[[
	local t = time()
	table.insert(Amr.db.global.Logging.Wipes, t)
	Amr.db.char.Logging.LastWipe = t

	self:Print(L.LogChatWipe(date('%I:%M %p', t)))

	self:RefreshLogUi()
	]]
end

function Amr:UndoWipe()

	--[[
	local t = Amr.db.char.Logging.LastWipe
	local wipes = Amr.db.global.Logging.Wipes
	
	if not t then
		self:Print(L.LogChatNoWipes)
	else
		-- find this wipe and remove it, may not be the last one if this person is raiding on multiple characters
		for i = #wipes, 1, -1 do
			if wipes[i] == t then
				table.remove(wipes, i)
				break
			end			
		end
		
		Amr.db.char.Logging.LastWipe = nil
		self:Print(L.LogChatUndoWipe(date('%I:%M %p', t)))
	end
	
	self:RefreshLogUi()
	]]
end

function Amr:ToggleAutoLog(instanceId, difficultyId)

	local byDiff = Amr.db.profile.Logging.Auto[instanceId]	
	byDiff[difficultyId] = not byDiff[difficultyId]
	
	self:RefreshLogUi()
	
	-- see if we should turn logging on right now	
	updateAutoLogging(true)
end

function Amr:ToggleAllAutoLog()
	
	local val = not isAllAutoLoggingEnabled()
	
	for i, instanceId in ipairs(Amr.InstanceIdsOrdered) do
		for k, difficultyId in pairs(Amr.Difficulties) do
			Amr.db.profile.Logging.Auto[instanceId][difficultyId] = val
		end
	end
	
	self:RefreshLogUi()
	
	-- see if we should turn logging on right now	
	updateAutoLogging(true)
end

function Amr:ProcessPlayerSnapshot(msg)
	--[[
	if not self:IsLogging() then return end
	
    -- message will be of format: timestamp\nregion\nrealm\nname\n[stuff]
    local parts = {}
	for part in string.gmatch(msg, "([^\n]+)") do
		table.insert(parts, part)
	end
    
    local timestamp = tonumber(parts[1])
    local name = parts[2] .. ":" .. parts[3] .. ":" .. parts[4]
    local setup = parts[5]

	-- initialize the player's table
	local playerList = Amr.db.global.Logging.PlayerData[name]
	if not playerList then
		playerList = {}
		Amr.db.global.Logging.PlayerData[name] = playerList
	end

	-- find the most recent setup already recorded for this player
	local previousSetup = nil
	local previousTime = 0
	for t, v in pairs(playerList) do
		if t > previousTime then
			previousSetup = v
			previousTime = t
		end
	end
	
	-- if the previous setup is more than 12 hours old, don't consider it
	if previousSetup and difftime(timestamp, previousTime) > 60 * 60 * 12 then
		previousSetup = nil
	end
	
	-- we only need to keep this setup if it is different than the previous
	if setup ~= previousSetup then
		playerList[timestamp] = setup
	end
	]]
end

-- read auras and pet mapping info (pet may not be necessary anymore... but doesn't hurt)
local function getPlayerExtraData(data, unitId, petId)
	--[[
	local guid = UnitGUID(unitId)
	if guid == nil then return end
	
	local fields = {}

	local buffs = {}
    for i=1,40 do
    	local _,_,_,count,_,_,_,_,_,_,spellId = UnitAura(unitId, i, "HELPFUL")
    	table.insert(buffs, spellId)
    end
	if not buffs or #buffs == 0 then
		table.insert(fields, "_")
	else
		table.insert(fields, Amr.Serializer:ToCompressedNumberList(buffs))
	end

	local petGuid = UnitGUID(petId)
	if petGuid then
		table.insert(fields, guid .. "," .. petGuid)
    else
		table.insert(fields, '_')
	end

	local name = GetUnitName(unitId, true) -- GetRaidRosterInfo(rosterIndex)
    local realm = GetRealmName()
    local region = Amr.RegionNames[GetCurrentRegion()]
    local splitPos = string.find(name, "-")
    if splitPos ~= nil then
        realm = string.sub(name, splitPos + 1)
        name = string.sub(name, 1, splitPos - 1)
    end

	data[region .. ":" .. realm .. ":" .. name] = table.concat(fields, ";")
	]]
end

local function logPlayerExtraData()
	--[[
	if not Amr:IsLogging() or not Amr:IsSupportedInstance() then return end

	local timestamp = time()
    local units = {}
    local petUnits = {}
    
    if IsInRaid() then
        for i = 1,40 do
            table.insert(units, "raid" .. i)
            table.insert(petUnits, "raidpet" .. i)
        end
    elseif IsInGroup() then
        table.insert(units, "player")
        table.insert(petUnits, "pet")
        for i = 1,4 do
            table.insert(units, "party" .. i)
            table.insert(petUnits, "partypet" .. i)
        end
    else
        return
    end

	local data = {}
    for i = 1,#units do
        getPlayerExtraData(data, units[i], petUnits[i])
    end
    
	for name, val in pairs(data) do
		-- record aura stuff, we never check for duplicates, need to know it at each point in time
		if Amr.db.global.Logging.PlayerExtras[name] == nil then
			Amr.db.global.Logging.PlayerExtras[name] = {}
		end
		Amr.db.global.Logging.PlayerExtras[name][timestamp] = val
	end
	]]
end

function Amr:InitializeCombatLog()
	updateAutoLogging()
end

Amr:AddEventHandler("UPDATE_INSTANCE_INFO", updateAutoLogging)
Amr:AddEventHandler("PLAYER_DIFFICULTY_CHANGED", updateAutoLogging)
Amr:AddEventHandler("ENCOUNTER_START", updateAutoLogging)
--Amr:AddEventHandler("PLAYER_REGEN_DISABLED", logPlayerExtraData)

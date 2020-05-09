--[[----------------------------------------------------------------------------
	AzeritePowerWeights

	Helps you pick the best Azerite powers on your gear for your class and spec.

	(c) 2018 -
	Sanex @ EU-Arathor / ahak @ Curseforge
----------------------------------------------------------------------------]]--
local ADDON_NAME, n = ...

local _G = _G
local L = n.L

-- Libs
local ACD = LibStub("AceConfigDialog-3.0")
local ACR = LibStub("AceConfigRegistry-3.0")
local AceGUI = LibStub("AceGUI-3.0")

-- Default DB settings
local dbVersion = 3
local dbDefaults = {
	customScales = {},
	char = {},
	dbVersion = dbVersion
}
local charDefaults = { -- Remember to update the ticket-tool when changing this
	debug = false,
	enableTraits = true,
	enableEssences = true,
	onlyOwnClassDefaults = true,
	onlyOwnClassCustoms = false,
	importingCanUpdate = true,
	defensivePowers = true,
	rolePowers = true,
	rolePowersNoOffRolePowers = false,
	zonePowers = true,
	professionPowers = false,
	pvpPowers = false,
	addILvlToScore = false,
	scaleByAzeriteEmpowered = false,
	addPrimaryStatToScore = false,
	relativeScore = false,
	showOnlyUpgrades = false,
	showTooltipLegend = true,
	outlineScores = true,
	preferBiSMarjor = true,
	specScales = {},
	tooltipScales = {}
}

-- Slots for Azerite Gear
local azeriteSlots = {
	[1] = true, -- Head
	[3] = true, -- Shoulder
	[5] = true -- Chest
}

-- Weight Editor
--[[
	Version history:
	1 - 8.0 -> 8.1.5: Initial release version of the ImportStrings
	2 - 8.2 -> x.x: Added support for Azerite Essences to the ImportStrings
]]--
local importVersion = 2

-- Score Strings
local reallyBigNumber = 2^31 - 1 -- 2147483647, go over this and errors are thrown
local activeTStrings, activeEStrings = {}, {} -- Pointers of score strings in use are save in this table
local scoreData = {} -- Current active scales are saved to this table
-- 8.2 Azerite Essences
local essenceScoreData = {}

-- Pointers and Eventframe
local customScales, cfg
local db, lastOpenScale
local playerClassID, playerSpecID
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	return self[event] and self[event](self, event, ...)
end)
f:RegisterEvent("ADDON_LOADED")

-- Help functions
local function Debug(text, ...)
	if not cfg or not cfg.debug then return end

	if text then
		if text:match("%%[dfqsx%d%.]") then
			(DEBUG_CHAT_FRAME or ChatFrame3):AddMessage("|cffff9999"..ADDON_NAME..":|r " .. format(text, ...))
		else
			(DEBUG_CHAT_FRAME or ChatFrame3):AddMessage("|cffff9999"..ADDON_NAME..":|r " .. strjoin(" ", text, tostringall(...)))
		end
	end
end

local function Print(text, ...)
	if text then
		if text:match("%%[dfqs%d%.]") then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00".. ADDON_NAME ..":|r " .. format(text, ...))
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00".. ADDON_NAME ..":|r " .. strjoin(" ", text, tostringall(...)))
		end
	end
end

local function initDB(db, defaults) -- This function copies values from one table into another:
	if type(db) ~= "table" then db = {} end
	if type(defaults) ~= "table" then return db end
	for k, v in pairs(defaults) do
		if type(v) == "table" then
			db[k] = initDB(db[k], v)
		elseif type(v) ~= type(db[k]) then
			db[k] = v
		end
	end
	return db
end

local function shallowcopy(orig) -- http://lua-users.org/wiki/CopyTable
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

local function _isInteger(number)
	return number == floor(number)
end

local function _getDecimals(number)
	local num, decimals = strsplit(".", tostring(number))
	return decimals and strlen(decimals) or 0
end

local function _activeSpec() -- Get current active spec for scoreData population etc.
	local currentSpec = GetSpecialization()
	if currentSpec then
		local specID = GetSpecializationInfo(currentSpec)
		if specID then
			playerSpecID = specID
		end
	end
end

local traitStack, essenceStack = {}, {}
local function _populateWeights() -- Populate scoreData with active spec's scale
	if not playerSpecID then return end -- No playerSpecID yet, return
	local scaleKey = cfg.specScales[playerSpecID].scaleID
	local groupSet, classID, specNum, scaleName = strsplit("/", scaleKey)
	if groupSet and classID and specNum and scaleName then
		classID = tonumber(classID)
		specNum = tonumber(specNum)
		for _, dataSet in ipairs(groupSet == "C" and customScales or n.defaultScalesData) do
			if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
				wipe(scoreData)
				local scoreCount = 0
				for k, v in pairs(dataSet[4]) do
					scoreData[k] = v
					scoreCount = scoreCount + 1
				end
				traitStack.loading = scoreCount
				-- 8.2 Azerite Essences
				wipe(essenceScoreData)
				local essenceCount = 0
				for k, v in pairs(dataSet[5]) do
					essenceScoreData[k] = v
					essenceCount = essenceCount + 1
				end
				essenceStack.loading = essenceCount
				if n.guiContainer then
					--n.guiContainer:SetStatusText(format(L.WeightEditor_CurrentScale, scaleName))
					n.guiContainer:SetStatusText(format(L.WeightEditor_CurrentScale, groupSet == "D" and (n.defaultNameTable[scaleName] or cfg.specScales[playerSpecID].scaleName) or cfg.specScales[playerSpecID].scaleName))
				end

				Debug("Populated scoreData", groupSet, classID, specNum, scaleName)
				return
			end
		end
		Debug("Couldn't populate scoreData", 2, groupSet, classID, specNum, scaleName)
	else
		Debug("Couldn't populate scoreData", 1, groupSet, classID, specNum, scaleName)
	end
end

local AcquireString, ReleaseString
do
	local string_cache = {}

	function AcquireString(parent, text)
		local string

		if #string_cache > 0 then
			string = tremove(string_cache)
		else
			string = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		end

		local fontName, fontHeight, fontFlags = string:GetFont()
		if cfg.outlineScores then
			string:SetFont(fontName, fontHeight, "OUTLINE")
		else
			string:SetFont(fontName, fontHeight, "")
		end

		string:Show()
		string:SetPoint("CENTER", parent)
		string:SetText(text)

		--f:SetFrameStrata(parent:GetFrameStrata())
		f:SetFrameStrata("HIGH") -- parent:GetFrameStrata() returns MEDIUM after a while for some reason?
		--f:SetToplevel()
		--f:Raise()

		return string
	end

	function ReleaseString(string)
		string:SetText("")
		string:Hide()
		string:ClearAllPoints()

		string_cache[#string_cache + 1] = string
	end
end -- StringPool

-- Delay function
local lock
local function delayedUpdate()
	if not lock then
		lock = true
		C_Timer.After(0, f.UpdateValues) -- Wait until next frame
	end
end

-- Scale weight editor related functions
local function _customSort(a, b)
	if a.value and b.value then -- Sorting Tree
		if a.text ~= b.text then
			return a.text < b.text
		else
			return a.value < b.value
		end
	else -- Sorting Custom Scales save-table
		if a[1] ~= b[1] then
			return a[1] < b[1]
		elseif a[2] ~= b[2] then
			return a[2] < b[2]
		else
			return a[3] < a[3]
		end
	end
end

local pvpPairs = { -- Used for Exporting/Importing. These powers have same effects, but are different powers
	-- Horde
	[486] = 6,
	[487] = 6,
	[488] = 6,
	[489] = 6,
	[490] = 6,
	[491] = 6,

	-- Alliance
	[492] = -6,
	[493] = -6,
	[494] = -6,
	[495] = -6,
	[496] = -6,
	[497] = -6
}
local function insertCustomScalesData(scaleName, classIndex, specID, powerData, essenceData, scaleMode) -- Insert into table
	local t, e = {}, {}
	if powerData and powerData ~= "" then -- String to table
		for _, weight in pairs({ strsplit(",", powerData) }) do
			local azeritePowerID, value = strsplit("=", strtrim(weight))
			azeritePowerID = tonumber(azeritePowerID) or nil
			value = tonumber(value) or nil

			if azeritePowerID and value and value > 0 then
				value = value > reallyBigNumber and reallyBigNumber or value
				t[azeritePowerID] = value
				if pvpPairs[azeritePowerID] then -- Mirror PvP Powers for both factions
					t[azeritePowerID + pvpPairs[azeritePowerID]] = value
				end
			end
		end
	end

	-- 8.2 Azerite Essences
	if essenceData and essenceData ~= "" then -- String to table
		for _, weight in pairs({ strsplit(",", essenceData) }) do
			local essenceID, valuePair = strsplit("=", strtrim(weight))
			if essenceID and valuePair then
				local majorValue, minorValue = strsplit("/", strtrim(valuePair))
				essenceID = tonumber(essenceID) or nil
				majorValue = tonumber(majorValue) or nil
				minorValue = tonumber(minorValue) or nil

				if essenceID and (majorValue or minorValue) and (majorValue > 0 or minorValue > 0) then
					majorValue = majorValue and (majorValue > reallyBigNumber and reallyBigNumber or majorValue) or 0
					minorValue = minorValue and (minorValue > reallyBigNumber and reallyBigNumber or minorValue) or 0
					e[essenceID] = { majorValue, minorValue }
				end
			end
		end
	end

	local updated = false
	-- Check if we have scale with same name already and update it
	for key, dataSet in ipairs(customScales) do
		if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classIndex and dataSet[3] == specID then
			dataSet[4] = t
			-- 8.2 Azerite Essences
			--dataSet[5] = time() -- Timestamp
			--dataSet[6] = 2 -- Set scaleMode to 2 (Only Imports should update scales)
			dataSet[5] = e
			dataSet[6] = time() -- Timestamp
			dataSet[7] = 2 -- Set scaleMode to 2 (Only Imports should update scales)
			updated = true
			break
		end
	end

	-- Create new scale if we didn't find existing set
	if not updated then
		customScales[#customScales + 1] = {
			scaleName,
			classIndex,
			specID,
			t,
			e,
			time(), -- Timestamp
			scaleMode -- Set scaleMode either 1 (Created) or 2 (Imported)
		}
	end

	sort(customScales, _customSort)

	return updated -- Return info if we created new or updated old
end

local function _buildTree(t)
	local t = {}

	t[1] = {
		value = 1,
		text = L.ScalesList_CustomGroupName,
		disabled = true,
		children = {}
	}
	t[2] = {
		value = 2,
		text = L.ScalesList_DefaultGroupName,
		disabled = true,
		children = {}
	}

	playerClassID = playerClassID or select(3, UnitClass("player"))

	for _, dataSet in ipairs(customScales) do
		local classDisplayName, classTag, classID = GetClassInfo(dataSet[2])
		local specID, name, description, iconID, role, class = GetSpecializationInfoByID(dataSet[3])
		local c = _G.RAID_CLASS_COLORS[classTag]

		--if (dataSet) then
		if (dataSet) and ((cfg.onlyOwnClassCustoms and classID == playerClassID) or (not cfg.onlyOwnClassCustoms)) then -- Hide custom scales of other classes if enabled
			t[1].children[#t[1].children + 1] = {
				value = "C/"..dataSet[2].."/"..dataSet[3].."/"..dataSet[1],
				text = ("|c%s%s|r"):format(c.colorStr, dataSet[1]),
				icon = iconID
			}
		end
	end

	sort(t[1].children, _customSort)
	tinsert(t[1].children, 1, { -- Make sure Create New/Import is the first item on the list
		value = ADDON_NAME.."Import",
		text = L.ScalesList_CreateImportText,
		icon = 134400
	})

	for _, dataSet in ipairs(n.defaultScalesData) do
		local classDisplayName, classTag, classID = GetClassInfo(dataSet[2])
		local specID, name, description, iconID, role, isRecommended, isAllowed = GetSpecializationInfoForClassID(classID, dataSet[3])
		local c = _G.RAID_CLASS_COLORS[classTag]

		--local scaleName = n.defaultNameTable[ dataSet[1] ] and classDisplayName .. " - " .. name .. " (" .. dataSet[1] .. ")" or classDisplayName .. " - " .. name
		local scaleName = (n.defaultNameTable[ dataSet[1] ] and n.defaultNameTable[ dataSet[1] ] ~= L.DefaultScaleName_Default) and classDisplayName .. " - " .. name .. " (" .. n.defaultNameTable[ dataSet[1] ] .. ")" or classDisplayName .. " - " .. name
		if (dataSet) and ((cfg.onlyOwnClassDefaults and classID == playerClassID) or (not cfg.onlyOwnClassDefaults)) then
			t[2].children[#t[2].children + 1] = {
				value = "D/"..dataSet[2].."/"..dataSet[3].."/"..dataSet[1],
				text = ("|c%s%s|r"):format(c.colorStr, scaleName),
				icon = iconID
			}
		end
	end

	return t
end

local function _SelectGroup(widget, callback, group)
	local dataGroup, scaleKey = strsplit("\001", group)

	if dataGroup and not scaleKey then
		scaleKey = dataGroup
	end

	local groupSet, classID, specNum, scaleName = strsplit("/", scaleKey, 4) -- Fixes the non-selectable scales if the scalename includes a slash-sign ('/') [Issue #46, https://www.curseforge.com/wow/addons/azeritepowerweights/issues/46]
	Debug(">>", dataGroup, ">", scaleKey, ">", groupSet, ">", classID, ">", specNum, ">", scaleName)

	if scaleKey == ADDON_NAME.."Import" then -- Create New / Import
		--Debug("!!! Import")
		n:CreateImportGroup(n.scalesScroll)
	else -- Scaleset
		classID = tonumber(classID)
		specNum = tonumber(specNum)
	
		if groupSet == "C" then -- Custom Scales
			--Debug("!!! Custom")

			for _, dataSet in ipairs(customScales) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
					--n:CreateWeightEditorGroup(true, n.scalesScroll, dataSet[1], dataSet[4], scaleKey, cfg.specScales[playerSpecID].scaleID == scaleKey, classID, specNum) -- specNum is actually specID here
					n:CreateWeightEditorGroup(true, n.scalesScroll, dataSet, scaleKey, cfg.specScales[playerSpecID].scaleID == scaleKey, classID, specNum, nil) -- specNum is actually specID here, nil is mode

					break
				end
			end

		elseif groupSet == "D" then -- Default Scales
			--Debug("!!! Default")

			for _, dataSet in ipairs(n.defaultScalesData) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
					local classDisplayName, classTag, classID = GetClassInfo(dataSet[2])
					local specID, name, description, iconID, role, isRecommended, isAllowed = GetSpecializationInfoForClassID(classID, dataSet[3])

					--n:CreateWeightEditorGroup(false, n.scalesScroll, ("%s - %s (%s)"):format(classDisplayName, name, dataSet[1]), dataSet[4], scaleKey, cfg.specScales[playerSpecID].scaleID == scaleKey, classID, specID)
					n:CreateWeightEditorGroup(false, n.scalesScroll, dataSet, scaleKey, cfg.specScales[playerSpecID].scaleID == scaleKey, classID, specID, nil) -- nil is mode

					break
				end
			end

		else -- ???
			Debug("!!! Else")
		end
	end

	delayedUpdate()
end

local function _enableScale(powerWeights, essenceWeights, scaleKey)
	Debug("Enable Scale:", scaleKey)
	wipe(scoreData)
	local scoreCount = 0
	for k, v in pairs(powerWeights) do
		scoreData[k] = v
		scoreCount = scoreCount + 1
	end
	traitStack.loading = scoreCount
	-- 8.2 Azerite Essences
	wipe(essenceScoreData)
	local essenceCount = 0
	for k, v in pairs(essenceWeights) do
		essenceScoreData[k] = v
		essenceCount = essenceCount + 1
	end
	essenceStack.loading = essenceCount

	local groupSet, _, _, scaleName = strsplit("/", scaleKey)
	--n.guiContainer:SetStatusText(format(L.WeightEditor_CurrentScale, scaleName))
	n.guiContainer:SetStatusText(format(L.WeightEditor_CurrentScale, groupSet == "D" and (n.defaultNameTable[scaleName] or scaleName) or scaleName))

	cfg.specScales[playerSpecID].scaleID = scaleKey
	cfg.specScales[playerSpecID].scaleName = scaleName
	--cfg.specScales[playerSpecID].scaleName = groupSet == "D" and (n.defaultNameTable[scaleName] or scaleName) or scaleName
	n.treeGroup:SelectByValue(cfg.specScales[playerSpecID].scaleID)
end

local function _checkForNameCollisions(nameString, previousName, classID, specID)
	local collision = true
	local testName = nameString
	local c = 1
	while collision == true do
		collision = false
		for key, dataSet in ipairs(customScales) do
			if (dataSet) and dataSet[1] == testName and dataSet[2] == classID and dataSet[3] == specID then
				Debug("!!! Name collisions:", nameString, testName)
				collision = true
				testName = ("%s (%d)"):format(nameString, c)
				c = c + 1

				if previousName and testName == previousName then -- Earlier name had (x) in it and we hit the same number, don't increase it
					collision = false
				end

				break
			end
		end
	end

	return testName
end

local function _exportScale(powerWeights, essenceWeights, scaleName, classID, specID) -- Create export string and show export popup
	local template = "( %s:%d:\"%s\":%d:%d:%s:%s )"
	local t, e = {}, {}
	local isHorde = UnitFactionGroup("player") == "Horde"
	for k, v in pairs(powerWeights) do
		if type(tonumber(v)) == "number" and tonumber(v) > 0 then
			if pvpPairs[tonumber(k)] then
				if isHorde and pvpPairs[tonumber(k)] > 0 then -- Horde player and Horde power
					t[#t + 1] = k.."="..v
				elseif not isHorde and pvpPairs[tonumber(k)] < 0 then -- Alliance player and Alliance power
					t[#t + 1] = k.."="..v
				end
			else
				t[#t + 1] = k.."="..v
			end
		end
	end
	sort(t)
	for k, v in pairs(essenceWeights) do
		e[#e + 1] = k.."="..(v[1] or 0).."/"..(v[2] or 0)
	end

	local exportString = format(template, ADDON_NAME, importVersion, scaleName, classID, specID, #t > 0 and " "..strjoin(", ", unpack(t)) or "", #e > 0 and " "..strjoin(", ", unpack(e)) or "")
	--Debug("%d - %s", #t, s)

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Export", L.ExportPopup_Title, format(L.ExportPopup_Desc, NORMAL_FONT_COLOR_CODE .. scaleName .. FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE), exportString)
end

local importStack = {}
local function _importScale(importMode) -- Show import popup and parse input
	local template = "^%s*%(%s*" .. ADDON_NAME .. "%s*:%s*(%d+)%s*:%s*\"([^\"]+)\"%s*:%s*(%d+)%s*:%s*(%d+)%s*:%s*(.+)%s*:%s*(.+)%s*%)%s*$"
	wipe(importStack)

	local callbackFunction = function(widget, callback, ...)
		local function _saveString(importString, version)
			importStack[#importStack + 1] = ("Version: %s"):format(tostring(version))
			importStack[#importStack + 1] = importString

			if version and version == 1 then
				template = "^%s*%(%s*" .. ADDON_NAME .. "%s*:%s*(%d+)%s*:%s*\"([^\"]+)\"%s*:%s*(%d+)%s*:%s*(%d+)%s*:%s*(.+)%s*%)%s*$"
			end
			local startPos, endPos, stringVersion, scaleName, classID, specID, powerWeights, essenceWeights = strfind(importString, template)

			importStack[#importStack + 1] = ("startPos: %s, endPos: %s, stringVersion: %s, scaleName: %s, classID: %s, specID: %s"):format(tostring(startPos), tostring(endPos), tostring(stringVersion), tostring(scaleName), tostring(classID), tostring(specID))
			importStack[#importStack + 1] = ("powerWeights: %s"):format(tostring(powerWeights))
			importStack[#importStack + 1] = ("essenceWeights: %s"):format(tostring(essenceWeights))

			stringVersion = tonumber(stringVersion) or 0
			scaleName = scaleName or L.ScaleName_Unnamed
			powerWeights = powerWeights or ""
			essenceWeights = essenceWeights or ""
			classID = tonumber(classID) or nil
			specID = tonumber(specID) or nil

			if stringVersion == 0 then -- Try to find string version if we didn't find it previously
				startPos, endPos, stringVersion = strfind(importString, "^%s*%(%s*" .. ADDON_NAME .. "%s*:%s*(%d+)%s*:.*%)%s*$")
				stringVersion = tonumber(stringVersion) or 0

				importStack[#importStack + 1] = ("Fixed stringVersion: %s"):format(tostring(stringVersion))
			end

			if (not cfg.importingCanUpdate) or (version and version > 0) then -- No updating for you, get collision free name
				scaleName = _checkForNameCollisions(scaleName, false, classID, specID)
			end

			if (version and stringVersion < version) or (not version and stringVersion < importVersion) then -- String version is old and not supported
				Debug("Version:", tostring(stringVersion), tostring(importVersion), tostring(version))

				importStack[#importStack + 1] = ("String version is old: %s / %s / %s"):format(tostring(stringVersion), tostring(importVersion), tostring(version))
				if not version then
					importStack[#importStack + 1] = "-> First retry...\n"
					Print(L.ImportPopup_Error_OldStringRetry)
					_saveString(importString, (importVersion - 1))
				elseif version > 1 then
					importStack[#importStack + 1] = "-> Still retrying...\n"
					_saveString(importString, (version - 1))
				else
					importStack[#importStack + 1] = "-> Too old or malformed, can't figure this out...\n> END"
					Print(L.ImportPopup_Error_OldStringVersion)
				end
			elseif type(classID) ~= "number" or classID < 1 or type(specID) ~= "number" or specID < 1 then -- No class or no spec, this really shouldn't happen ever
				importStack[#importStack + 1] = ("Problem with classID %s or specID %s, bailing out...\n> END"):format(tostring(classID), tostring(specID))
				Print(L.ImportPopup_Error_MalformedString)
			else -- Everything seems to be OK
				importStack[#importStack + 1] = "Everything seems to be OK"
				local result = insertCustomScalesData(scaleName, classID, specID, powerWeights, essenceWeights, 2) -- Set scaleMode 2 for Imported

				-- Rebuild Tree
				n.treeGroup.tree = _buildTree(n.treeGroup.tree)
				n.treeGroup:SelectByValue("C/"..classID.."/"..specID.."/"..scaleName)
				n.treeGroup:RefreshTree(true)

				if result then -- Updated old scale
					importStack[#importStack + 1] = "- Updated old scale.\n> END"
					Print(L.ImportPopup_UpdatedScale, scaleName)
					-- Update the scores just incase if it is the scale actively in use
					_populateWeights()
					delayedUpdate()
				else -- Created new
					importStack[#importStack + 1] = "- Created new scale\n> END"
					Print(L.ImportPopup_CreatedNewScale, scaleName)
				end
			end

			Debug(">", stringVersion, classID, specID, scaleName, "-", powerWeights, "-", essenceWeights)
		end

		local input = widget:GetUserData("importString") or ""
		--Debug(tostringall(strfind(input, template)))

		if importMode then
			Debug("Mass Import")
			local t = { strsplit("\r\n", input) }
			if #t > 0 then
				for k, v in pairs(t) do
					Debug(">", k, v)
					if v then -- Let's make sure there is something
						_saveString(v)
					end
				end
			else
				Print(L.ImportPopup_Error_MalformedString)
			end

		else
			Debug("Single Import")
			_saveString(input)
		end

		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	if importMode then -- Mass Import
		importStack[#importStack + 1] = "=== MassImport"
		n.CreatePopUp("MassImport", L.MassImportPopup_Title, format(L.MassImportPopup_Desc, NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), "", callbackFunction)
	else -- Import
		importStack[#importStack + 1] = "=== Import"
		n.CreatePopUp("Import", L.ImportPopup_Title, format(L.ImportPopup_Desc, NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), "", callbackFunction)
	end
	Debug("Import", importMode)
end

local function _createScale() -- Show create popup and parse input
	local callbackFunction = function(widget, callback, ...)
		local classID = widget:GetUserData("classID")
		local specID = widget:GetUserData("specID")
		local nameString = widget:GetUserData("nameString")

		Debug(">", nameString, classID, specID)
		if not nameString or nameString == "" then
			nameString = L.ScaleName_Unnamed
		end
		if not classID then
			classID = 1 -- Warrior
			specID = 71 -- Arms
		end

		local scaleName = _checkForNameCollisions(nameString, false, classID, specID)
		Debug(">>", scaleName)
		if scaleName then
			local result = insertCustomScalesData(scaleName, classID, specID, nil, nil, 1) -- Set scaleMode 1 for Created

			-- Rebuild Tree
			n.treeGroup.tree = _buildTree(n.treeGroup.tree)
			n.treeGroup:SelectByValue("C/"..classID.."/"..specID.."/"..scaleName)
			n.treeGroup:RefreshTree(true)


			if result then -- Updated old instead of creating new, which should never happen
				Print(L.CreatePopup_Error_UnknownError, scaleName)
			else -- Expected result
				Print(L.CreatePopup_Error_CreatedNewScale, scaleName)
			end
		end


		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Create", L.CreatePopup_Title, format(L.CreatePopup_Desc, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), "", callbackFunction)
end

local function _renameScale(scaleName, classID, specID, isCurrentScales) -- Show rename popup and check for name collisions
	local callbackFunction = function(widget, callback, ...)
		local renameString = widget:GetUserData("renameString")

		if not renameString or renameString == "" then
			renameString = L.ScaleName_Unnamed
		end

		if renameString ~= scaleName then -- Check if name actually changed
			local finalName = _checkForNameCollisions(renameString, scaleName, classID, specID)

			local scaleWeights, essenceWeights
			for key, dataSet in ipairs(customScales) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specID then
					Debug("> Renamed:", scaleName, "to", finalName)
					dataSet[1] = finalName
					scaleWeights = dataSet[4]
					-- 8.2 Azerite Essences
					essenceWeights = dataSet[5]

					break
				end
			end

			Print(L.RenamePopup_RenamedScale, scaleName, finalName)

			n.treeGroup.tree = _buildTree(n.treeGroup.tree)
			n.treeGroup:SelectByValue("C/"..classID.."/"..specID.."/"..finalName)
			n.treeGroup:RefreshTree(true)

			if isCurrentScales and scaleWeights then
				Debug("> New Key: C/%d/%d/%s", classID, specID, finalName)
				_enableScale(scaleWeights, essenceWeights, "C/"..classID.."/"..specID.."/"..finalName)
			end

			-- Check if we have to rename scaleKeys for other tooltips
			for realmName, realmData in pairs(db.char) do
				for charName, charData in pairs(realmData) do
					if charData.tooltipScales and #charData.tooltipScales > 0 then
						for i, tooltipData in ipairs(charData.tooltipScales) do
							if tooltipData.scaleName == scaleName and tooltipData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, update scaleKey
								Debug("> Changing scaleKey for tooltipScales", i, charName, realmName)
								tooltipData.scaleID = "C/"..classID.."/"..specID.."/"..finalName
								tooltipData.scaleName = finalName
							end
						end
					end
				end
			end

			-- Check if we have to rename scaleKeys for other characters using same scale
			for realmName, realmData in pairs(db.char) do
				for charName, charData in pairs(realmData) do
					for spec, specData in pairs(charData.specScales) do
						if spec == specID and specData.scaleName == scaleName and specData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, update scaleKey
							Debug("> Changing scaleKey for specScales", charName, realmName)
							specData.scaleID = "C/"..classID.."/"..specID.."/"..finalName
							specData.scaleName = finalName
						end
					end
				end
			end
		end

		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Rename", L.RenamePopup_Title, format(L.RenamePopup_Desc, NORMAL_FONT_COLOR_CODE .. scaleName .. FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), scaleName, callbackFunction)
end

local function _deleteScale(scaleName, classID, specID, isCurrentScales) -- Show delete popup and remove scale
	local callbackFunction = function(widget, callback, ...)
		local index
		-- Find where in the table scaleKey to be removed is
		for key, dataSet in ipairs(customScales) do
			if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specID then
				Debug("> Delete:", key, scaleName)
				index = key

				break
			end
		end

		-- Remove without breaking the indexing
		tremove(customScales, index)
		Print(L.DeletePopup_DeletedScale, scaleName)

		n.treeGroup.tree = _buildTree(n.treeGroup.tree)
		n.treeGroup:SelectByValue(ADDON_NAME.."Import")
		n.treeGroup:RefreshTree(true)

		-- If removed scaleKey was in use, revert back to default option
		if isCurrentScales then
			local specNum = GetSpecialization()
			playerClassID = playerClassID or select(3, UnitClass("player"))
			local scaleKey = n.GetDefaultScaleSet(playerClassID, specNum)
			local _, _, _, defaultScaleName = strsplit("/", scaleKey)
			
			for _, dataSet in ipairs(n.defaultScalesData) do
				if (dataSet) and dataSet[1] == defaultScaleName and dataSet[2] == playerClassID and dataSet[3] == specNum then
					Debug("Reverting to", scaleKey)
					_enableScale(dataSet[4], dataSet[5], scaleKey)

					break
				end
			end

			Print(L.DeletePopup_DeletedDefaultScale)
		end

		-- Check if this scale was in tooltips
		for realmName, realmData in pairs(db.char) do
			for charName, charData in pairs(realmData) do
				if charData.tooltipScales and #charData.tooltipScales > 0 then
					for i = #charData.tooltipScales, 1 , -1 do -- Go backwards to prevent holes and errors
						local tooltipData = charData.tooltipScales[i]
						if tooltipData.scaleName == scaleName and tooltipData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, remove scaleKey
							Debug("> Deleting scaleKey from tooltipScales", i, charName, realmName)
							tremove(charData.tooltipScales, i)
						end
					end
				end
			end
		end

		-- Check if someone used this scale and remove it so they can revert back to default on their next login
		for realmName, realmData in pairs(db.char) do
			for charName, charData in pairs(realmData) do
				for spec, specData in pairs(charData.specScales) do
					if spec == specID and specData.scaleName == scaleName and specData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, remove scaleKey
						Debug("> Deleting scaleKey from specScales", specID, charName, realmName)
						charData.specScales[spec] = nil
					end
				end
			end
		end

		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Delete", L.DeletePopup_Title, format(L.DeletePopup_Desc, NORMAL_FONT_COLOR_CODE .. scaleName .. FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), L.DeletePopup_Warning, callbackFunction)
end

function n:CreateImportGroup(container)
	container:ReleaseChildren()

	local version = AceGUI:Create("Label")
	version:SetText(format(L.WeightEditor_VersionText, GetAddOnMetadata(ADDON_NAME, "Version")))
	version:SetJustifyH("RIGHT")
	version:SetFullWidth(true)
	container:AddChild(version)

	local title = AceGUI:Create("Heading")
	title:SetText(L.ScalesList_CreateImportText)
	title:SetFullWidth(true)
	container:AddChild(title)

	local newButton = AceGUI:Create("Button")
	newButton:SetText(L.WeightEditor_CreateNewText)
	newButton:SetFullWidth(true)
	newButton:SetCallback("OnClick", function()
		-- Call _createScale
		_createScale()
	end)
	container:AddChild(newButton)

	local importButton = AceGUI:Create("Button")
	importButton:SetText(L.WeightEditor_ImportText)
	importButton:SetFullWidth(true)
	importButton:SetCallback("OnClick", function()
		-- Call _importScale
		_importScale()
	end)
	container:AddChild(importButton)

	local massImportButton = AceGUI:Create("Button")
	massImportButton:SetText(L.WeightEditor_MassImportText)
	massImportButton:SetFullWidth(true)
	massImportButton:SetCallback("OnClick", function()
		-- Call _importScale
		_importScale(true)
	end)
	container:AddChild(massImportButton)

	local line = AceGUI:Create("Heading")
	line:SetFullWidth(true)
	container:AddChild(line)

	lastOpenScale = ADDON_NAME.."Import"
end

--function n:CreateWeightEditorGroup(isCustomScale, container, titleText, powerWeights, scaleKey, isCurrentScales, classID, specID)
function n:CreateWeightEditorGroup(isCustomScale, container, dataSet, scaleKey, isCurrentScales, classID, specID, mode)
	local classDisplayName = GetClassInfo(dataSet[2])
	local _, specName = GetSpecializationInfoForClassID(classID, dataSet[3])
	local titleText = isCustomScale and dataSet[1] or ("%s - %s (%s)"):format(classDisplayName, specName, dataSet[1])
	local powerWeights = dataSet[4]
	-- 8.2 Azerite Essences
	local essenceWeights = dataSet[5]
	local currentMode = mode or ((_G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown()) and 1 or 0)

	container:ReleaseChildren()

	local title = AceGUI:Create("Heading")
	title:SetText(titleText)
	title:SetFullWidth(true)
	container:AddChild(title)

	local useButton = AceGUI:Create("Button")
	if isCurrentScales then
		useButton:SetText(GRAY_FONT_COLOR_CODE .. L.WeightEditor_EnableScaleText .. FONT_COLOR_CODE_CLOSE)
	else
		useButton:SetText(L.WeightEditor_EnableScaleText)
	end
	useButton:SetRelativeWidth(.5)
	useButton:SetDisabled(isCurrentScales)
	useButton:SetCallback("OnClick", function()
		-- Call _enableScale
		_enableScale(powerWeights, essenceWeights, scaleKey)
	end)
	container:AddChild(useButton)

	local exportButton = AceGUI:Create("Button")
	exportButton:SetText(L.WeightEditor_ExportText)
	exportButton:SetRelativeWidth(.5)
	exportButton:SetCallback("OnClick", function()
		-- Call _exportScale
		_exportScale(powerWeights, essenceWeights, titleText, classID, specID)
	end)
	container:AddChild(exportButton)

	if isCustomScale then
		local renameButton = AceGUI:Create("Button")
		renameButton:SetText(L.WeightEditor_RenameText)
		renameButton:SetRelativeWidth(.5)
		renameButton:SetCallback("OnClick", function()
			-- Call _renameScale
			_renameScale(titleText, classID, specID, isCurrentScales)
		end)
		container:AddChild(renameButton)

		local deleteButton = AceGUI:Create("Button")
		deleteButton:SetText(L.WeightEditor_DeleteText)
		deleteButton:SetRelativeWidth(.5)
		deleteButton:SetCallback("OnClick", function()
			-- Call _deleteScale
			_deleteScale(titleText, classID, specID, isCurrentScales)
		end)
		container:AddChild(deleteButton)
	end

	-- Tooltip start
	local tooltipCheckbox = AceGUI:Create("CheckBox")
	tooltipCheckbox:SetLabel(L.WeightEditor_TooltipText)
	--tooltipCheckbox:SetFullWidth(true)
	tooltipCheckbox:SetRelativeWidth(.5)
	tooltipCheckbox:SetValue(false)
	tooltipCheckbox:SetCallback("OnValueChanged", function(widget, callback, checked)
		if checked == true then
			local groupSet, _, _, thisScaleName = strsplit("/", scaleKey)
			cfg.tooltipScales[#cfg.tooltipScales + 1] = {
				scaleID = scaleKey,
				--scaleName = thisScaleName
				scaleName = groupSet == "D" and (n.defaultNameTable[thisScaleName] or thisScaleName) or thisScaleName
			}
		else
			if #cfg.tooltipScales > 0 then
				for i = #cfg.tooltipScales, 1, -1 do -- Just to make sure if for any erroneous reason, there are multiple copies of same scale, they all get removed.
					local v = cfg.tooltipScales[i]
					if v.scaleID == scaleKey then
						tremove(cfg.tooltipScales, i)
					end
				end
			end
		end
		widget:SetValue(checked)
	end)
	container:AddChild(tooltipCheckbox)

	for _, v in ipairs(cfg.tooltipScales) do
		if v.scaleID == scaleKey then
			tooltipCheckbox:SetValue(true)
			break -- No need to iterate more
		end
	end
	-- Tooltip end

	local modeButton = AceGUI:Create("Button")
	modeButton:SetText(currentMode == 1 and L.WeightEditor_ModeToTraits or L.WeightEditor_ModeToEssences)
	modeButton:SetRelativeWidth(.5)
	modeButton:SetCallback("OnClick", function()
		-- Change Mode
		n:CreateWeightEditorGroup(isCustomScale, container, dataSet, scaleKey, isCurrentScales, classID, specID, currentMode == 1 and 0 or 1)
	end)
	container:AddChild(modeButton)

	-- Timestamp start
	local timestampText = AceGUI:Create("Label")
	container:AddChild(timestampText)

	local function _updateTimestamp()
		-- dataSet[5] == timestamp
		-- dataSet[6] = scaleMode: 0 = Default/Updated, 1 = Created, 2 = Imported
		-- 8.2 Azerite Essences
		-- timestamp 5->6, scaleMode 6->7
		if dataSet[7] == 1 then
			timestampText:SetText(format(L.WeightEditor_TimestampText_Created, date("%Y.%m.%d", (dataSet[6] or 0))))
		elseif dataSet[7] == 2 then
			timestampText:SetText(format(L.WeightEditor_TimestampText_Imported, date("%Y.%m.%d", (dataSet[6] or 0))))
		else -- dataSet[6] 0, Default or Updated
			--timestampText:SetText(format(L.WeightEditor_TimestampText_Created, date("%Y.%m.%d %H:%M", (dataSet[5] or 0)))) -- Debug
			timestampText:SetText(format(L.WeightEditor_TimestampText_Updated, date("%Y.%m.%d", (dataSet[6] or 0))))
		end
	end

	_updateTimestamp()
	-- Timestamp end

	local spacer = AceGUI:Create("Label")
	spacer:SetText(" \n ")
	spacer:SetFullWidth(true)
	container:AddChild(spacer)

	local isHorde = UnitFactionGroup("player") == "Horde"
	local roleBits = 0x0
	local BIT_DAMAGER = 0x1
	local BIT_TANK = 0x2
	local BIT_HEALER = 0x4
	for i = 1, GetNumSpecializationsForClassID(classID) do
		local spec, _, _, _, role = GetSpecializationInfoForClassID(classID, i)
		if spec and ((cfg.rolePowersNoOffRolePowers and spec == specID) or (not cfg.rolePowersNoOffRolePowers)) then -- Check if only powers suitable for the spec
			if role == "DAMAGER" then
				roleBits = bit.bor(roleBits, BIT_DAMAGER)
			elseif role == "TANK" then
				roleBits = bit.bor(roleBits, BIT_TANK)
			elseif role == "HEALER" then
				roleBits = bit.bor(roleBits, BIT_HEALER)
			end
		end
	end

	local e = {}
	local c = 1

	local function _saveValue(widget, callback, text)
		local value = tonumber(text) or 0
		value = value > reallyBigNumber and reallyBigNumber or value
		local pointer = widget:GetUserData("dataPointer")
		local pairPointer = widget:GetUserData("pairPointer")
		-- Save to DB
		powerWeights[pointer] = value
		widget:SetText(text == "" and "" or (value and value or ""))
		AceGUI:ClearFocus()
		if pairPointer then
			powerWeights[pairPointer] = value
		end
		if isCurrentScales then
			-- Update visible numbers
			scoreData[pointer] = value
			delayedUpdate()
		end

		-- Update scaleMode and timestamp
		-- 8.2 Azerite Essences
		--dataSet[5] = time()
		--dataSet[6] = 0
		dataSet[6] = time()
		dataSet[7] = 0
		_updateTimestamp()
	end

	local function _saveEssenceValue(widget, callback, text)
		local value = tonumber(text) or 0
		value = value > reallyBigNumber and reallyBigNumber or value
		local pointer = widget:GetUserData("essencePointer")
		local major = widget:GetUserData("essenceMajor")
		--Debug("Major:", tostring(major))
		-- Save to DB
		essenceWeights[pointer] = essenceWeights[pointer] or {}
		if major then
			essenceWeights[pointer][1] = value
		else
			essenceWeights[pointer][2] = value
		end
		widget:SetText(text == "" and "" or (value and value or ""))
		AceGUI:ClearFocus()

		if isCurrentScales then
			-- Update visible numbers
			essenceScoreData[pointer] = essenceScoreData[pointer] or {}
			if major then
				essenceScoreData[pointer][1] = value
			else
				essenceScoreData[pointer][2] = value
			end
			delayedUpdate()
		end

		-- Update scaleMode and timestamp
		dataSet[6] = time()
		dataSet[7] = 0
		_updateTimestamp()
	end

	if currentMode == 0 then -- _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() or both UIs hidden
		-- Class Powers title
		local classTitle = AceGUI:Create("Heading")
		classTitle:SetText(L.PowersTitles_Class)
		classTitle:SetFullWidth(true)
		container:AddChild(classTitle)

		-- Center Power
		local cname = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(n.sourceData.center.azeritePowerID).spellID)
		e[c] = AceGUI:Create("EditBox")
		e[c]:SetLabel(format("  |T%d:18|t %s", n.sourceData.center.icon, cname or n.sourceData.center.name))
		e[c]:SetText(powerWeights[n.sourceData.center.azeritePowerID] or "")
		e[c]:SetRelativeWidth(.5)
		if isCustomScale then
			e[c]:SetUserData("dataPointer", n.sourceData.center.azeritePowerID)
			e[c]:SetCallback("OnEnterPressed", _saveValue)
		else
			e[c]:SetDisabled(true)
		end
		container:AddChild(e[c])
		c = c + 1

		-- Class Powers
		for i, powerData in ipairs(n.sourceData.class[classID][specID]) do
			local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
			e[c] = AceGUI:Create("EditBox")
			e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
			e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
			e[c]:SetRelativeWidth(.5)
			if isCustomScale then
				e[c]:SetUserData("dataPointer", n.sourceData.class[classID][specID][i].azeritePowerID)
				e[c]:SetCallback("OnEnterPressed", _saveValue)
			else
				e[c]:SetDisabled(true)
			end
			container:AddChild(e[c])
			c = c + 1
		end

		if cfg.defensivePowers then
			local defTitle = AceGUI:Create("Heading")
			defTitle:SetText(L.PowersTitles_Defensive)
			defTitle:SetFullWidth(true)
			container:AddChild(defTitle)

			-- Defensive Powers
			for i, powerData in ipairs(n.sourceData.defensive[classID]) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.defensive[classID][i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			for i, powerData in ipairs(n.sourceData.defensive.common) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.defensive.common[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end

		if cfg.rolePowers then
			local roleTitle = AceGUI:Create("Heading")
			roleTitle:SetText(L.PowersTitles_Role)
			roleTitle:SetFullWidth(true)
			container:AddChild(roleTitle)

			-- Role Powers
			for i, powerData in ipairs(n.sourceData.role.common) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0:3:::64:16:16:64:0:16|t" -- Tank, DPS & Healer
				e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.role.common[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end

			-- Non-Healer Powers
			if bit.band(roleBits, bit.bor(BIT_DAMAGER, BIT_TANK)) ~= 0 then
				for i, powerData in ipairs(n.sourceData.role.nonhealer) do
					local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
					e[c] = AceGUI:Create("EditBox")
					local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0:2:::64:16:16:48:0:16|t" -- Tank & DPS
					e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
					e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
					e[c]:SetRelativeWidth(.5)
					if isCustomScale then
						e[c]:SetUserData("dataPointer", n.sourceData.role.nonhealer[i].azeritePowerID)
						e[c]:SetCallback("OnEnterPressed", _saveValue)
					else
						e[c]:SetDisabled(true)
					end
					container:AddChild(e[c])
					c = c + 1
				end
			end
			-- Tank Powers
			if bit.band(roleBits, BIT_TANK) ~= 0 then
				for i, powerData in ipairs(n.sourceData.role.tank) do
					local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
					e[c] = AceGUI:Create("EditBox")
					local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:32:48:0:16|t" -- Tank
					e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
					e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
					e[c]:SetRelativeWidth(.5)
					if isCustomScale then
						e[c]:SetUserData("dataPointer", n.sourceData.role.tank[i].azeritePowerID)
						e[c]:SetCallback("OnEnterPressed", _saveValue)
					else
						e[c]:SetDisabled(true)
					end
					container:AddChild(e[c])
					c = c + 1
				end
			end
			-- Healer Powers
			if bit.band(roleBits, BIT_HEALER) ~= 0 then
				for i, powerData in ipairs(n.sourceData.role.healer) do
					local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
					e[c] = AceGUI:Create("EditBox")
					local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:48:64:0:16|t" -- Healer
					e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
					e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
					e[c]:SetRelativeWidth(.5)
					if isCustomScale then
						e[c]:SetUserData("dataPointer", n.sourceData.role.healer[i].azeritePowerID)
						e[c]:SetCallback("OnEnterPressed", _saveValue)
					else
						e[c]:SetDisabled(true)
					end
					container:AddChild(e[c])
					c = c + 1
				end
			end
		end

		if cfg.zonePowers then
			local zoneTitle = AceGUI:Create("Heading")
			zoneTitle:SetText(L.PowersTitles_Zone)
			zoneTitle:SetFullWidth(true)
			container:AddChild(zoneTitle)

			-- Raid Powers
			for i, powerData in ipairs(n.sourceData.raid) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t*%s*", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.raid[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- Zone Powers
			-- 8.0:
			local startPoint = 1
			local endPoint = 15
			for i = startPoint, endPoint do
				local powerData = n.sourceData.zone[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.zone[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- Different Zone traits for Alliance and Horde in 8.1
			local tidesStart = isHorde and 18 or 16
			local tidesEnd = isHorde and 19 or 17
			for i = tidesStart, tidesEnd do
				local powerData = n.sourceData.zone[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.zone[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- 8.2 ->
			for i = 20, #n.sourceData.zone do
				local powerData = n.sourceData.zone[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.zone[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end

		if cfg.professionPowers then
			local professionTitle = AceGUI:Create("Heading")
			professionTitle:SetText(L.PowersTitles_Profession)
			professionTitle:SetFullWidth(true)
			container:AddChild(professionTitle)

			-- Profession Powers
			for i, powerData in ipairs(n.sourceData.profession) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.profession[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end

		if cfg.pvpPowers then
			local pvpTitle = AceGUI:Create("Heading")
			pvpTitle:SetText(L.PowersTitles_PvP)
			pvpTitle:SetFullWidth(true)
			container:AddChild(pvpTitle)

			-- PvP Powers
			-- 8.0:
			local startPoint = isHorde and 1 or 7
			local endPoint = isHorde and 6 or 12
			for i = startPoint, endPoint do
				local powerData = n.sourceData.pvp[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.pvp[i].azeritePowerID)
					e[c]:SetUserData("pairPointer", n.sourceData.pvp[i].pair)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- 8.1:
			for i = 13, #n.sourceData.pvp do
				local powerData = n.sourceData.pvp[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.pvp[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		traitStack.editor = #e or 0
	elseif currentMode == 1 then -- _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown()
		local topLine = AceGUI:Create("Heading")
		topLine:SetFullWidth(true)
		container:AddChild(topLine)

		for i, essenceData in ipairs(n.essenceData.common) do
			local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0:3:::64:16:16:64:0:16|t" -- Tank, DPS & Healer
			local essenceTitle = AceGUI:Create("Heading")
			essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
			essenceTitle:SetRelativeWidth(.5)
			container:AddChild(essenceTitle)

			e[c] = AceGUI:Create("EditBox")
			e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Major))
			e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
			e[c]:SetRelativeWidth(.25)
			if isCustomScale then
				e[c]:SetUserData("essencePointer", n.essenceData.common[i].essenceID)
				e[c]:SetUserData("essenceMajor", true)
				e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
			else
				e[c]:SetDisabled(true)
			end
			container:AddChild(e[c])
			c = c + 1

			e[c] = AceGUI:Create("EditBox")
			e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Minor))
			e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
			e[c]:SetRelativeWidth(.25)
			if isCustomScale then
				e[c]:SetUserData("essencePointer", n.essenceData.common[i].essenceID)
				e[c]:SetUserData("essenceMajor", false)
				e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
			else
				e[c]:SetDisabled(true)
			end
			container:AddChild(e[c])
			c = c + 1
		end

		-- Tank Powers
		if bit.band(roleBits, BIT_TANK) ~= 0 then
			for i, essenceData in ipairs(n.essenceData.tank) do
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:32:48:0:16|t" -- Tank
				local essenceTitle = AceGUI:Create("Heading")
				essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
				essenceTitle:SetRelativeWidth(.5)
				container:AddChild(essenceTitle)

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Major))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.tank[i].essenceID)
					e[c]:SetUserData("essenceMajor", true)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Minor))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.tank[i].essenceID)
					e[c]:SetUserData("essenceMajor", false)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		-- Healer Powers
		if bit.band(roleBits, BIT_HEALER) ~= 0 then
			for i, essenceData in ipairs(n.essenceData.healer) do
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:48:64:0:16|t" -- Healer
				local essenceTitle = AceGUI:Create("Heading")
				essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
				essenceTitle:SetRelativeWidth(.5)
				container:AddChild(essenceTitle)

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Major))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.healer[i].essenceID)
					e[c]:SetUserData("essenceMajor", true)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Minor))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.healer[i].essenceID)
					e[c]:SetUserData("essenceMajor", false)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		-- DPS Powers
		if bit.band(roleBits, BIT_DAMAGER) ~= 0 then
			for i, essenceData in ipairs(n.essenceData.damager) do
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:16:32:0:16|t" -- Damager
				local essenceTitle = AceGUI:Create("Heading")
				essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
				essenceTitle:SetRelativeWidth(.5)
				container:AddChild(essenceTitle)

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Major))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.damager[i].essenceID)
					e[c]:SetUserData("essenceMajor", true)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, L.WeightEditor_Minor))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.damager[i].essenceID)
					e[c]:SetUserData("essenceMajor", false)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		essenceStack.editor = #e or 0
	end

	Debug("C-Elements:", #e, "Mode:", currentMode, mode)

	local line = AceGUI:Create("Heading")
	line:SetFullWidth(true)
	container:AddChild(line)

	lastOpenScale = scaleKey
end

local function _toggleEditorUI(widget, handler, button, down)
	if not n.guiContainer then return end

	n.guiContainer:ClearAllPoints()
	--if _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() then
	if widget == n.TenableButton then
		n.guiContainer:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI, "TOPRIGHT", 10, 0)
		n.guiContainer:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMRIGHT", 10, 0)
	--elseif _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown() then
	elseif widget == n.EenableButton then
		n.guiContainer:SetPoint("TOPLEFT", _G.AzeriteEssenceUI, "TOPRIGHT", 10, 0)
		n.guiContainer:SetPoint("BOTTOMLEFT", _G.AzeriteEssenceUI, "BOTTOMRIGHT", 10, 0)
	else
		n.guiContainer:SetPoint("CENTER", _G.UIParent)
	end

	if n.guiContainer:IsShown() then
		n.guiContainer:Hide()
	else
		n.guiContainer:Show()
	end
end

-- Hook and Init functions
local function _setupStringAndEnableButton() -- Move string and enableButton between AzeriteEmpoweredItemUI and AzeriteEssenceUI
	C_Timer.After(0, function() -- Fire on next frame instead of current frame
		if cfg.enableTraits and _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() then
			if not n.Tstring then
				local s = AcquireString(_G.AzeriteEmpoweredItemUI, "")

				local scale = _G.AzeriteEmpoweredItemUI:GetEffectiveScale() or 1
				local fontName, fontHeight, fontFlags = s:GetFont()
				s:SetFont(fontName, fontHeight * scale, "")

				s:SetJustifyH("LEFT")
				s:SetJustifyV("TOP")
				n.Tstring = s
			end

			if _G.AzeriteEmpoweredItemUIPortrait:IsShown() then -- Default UI etc. who show Portrait
				n.Tstring:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame, 10, -50)
			else -- ElvUI etc. who hides Portrait
				n.Tstring:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame, 10, -10)
			end
			n.Tstring:Show()

			n.TenableButton:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMLEFT", 10, 10)
			n.TenableButton.frame:SetParent(_G.AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame) -- Fix enableButton hiding behind AzeriteEmpoweredItemUI elements with ElvUI if the AzeriteUI skinning is disabled.
			n.TenableButton.frame:Show()
		else
			Debug("!!! string and enableButton !AzeriteEmpoweredItemUI", cfg.enableTraits)
			if n.Tstring then
				n.Tstring:Hide()
			end
			n.TenableButton.frame:Hide()
		end
		
		if cfg.enableEssences and _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown() then
			if not n.Estring then
				local s = AcquireString(_G.AzeriteEssenceUI, "")

				local scale = _G.AzeriteEssenceUI:GetEffectiveScale() or 1
				local fontName, fontHeight, fontFlags = s:GetFont()
				s:SetFont(fontName, fontHeight * scale, "")

				s:SetJustifyH("LEFT")
				s:SetJustifyV("TOP")
				n.Estring = s
			end

			if ElvUI and ElvUI[3] and ElvUI[3].skins and ElvUI[3].skins.blizzard and ElvUI[3].skins.blizzard.AzeriteEssence then -- ElvUI etc. who hides Portrait
				n.Estring:SetPoint("TOPLEFT", _G.AzeriteEssenceUI.LeftInset, 10, -10)
			else -- Default UI etc. who show Portrait
				n.Estring:SetPoint("TOPLEFT", _G.AzeriteEssenceUI.LeftInset, 10, -50)
			end
			n.Estring:Show()

			n.EenableButton:SetPoint("BOTTOMLEFT", _G.AzeriteEssenceUI, "BOTTOMLEFT", 10, 10)
			n.EenableButton.frame:SetParent(_G.AzeriteEssenceUI.LeftInset)
			n.EenableButton.frame:Show()
		else
			Debug("!!! string and enableButton !AzeriteEssenceUI", cfg.enableEssences)
			if n.Estring then
				n.Estring:Hide()
			end
			n.EenableButton.frame:Hide()

			--return
		end
	end)
end

function f:HookAzeriteUI() -- Set Parents and Anchors
	if not playerSpecID then return end -- No playerSpecID yet, return
	Debug("HOOK Azerite UI")
	self:InitUI()

	_setupStringAndEnableButton()

	_G.AzeriteEmpoweredItemUI:HookScript("OnHide", function() -- Hide strings on frame hide
		Debug("== HIDING 1 ==", #activeTStrings)
		while #activeTStrings > 0 do
			local s = tremove(activeTStrings)
			ReleaseString(s)
		end

		if n.guiContainer then
			n.scalesScroll:ReleaseChildren()
			Debug("Releasing children")
			lastOpenScale = nil
			f:RefreshConfig()

			n.guiContainer:Hide()
			if n.Tstring then
				n.Tstring:Hide()
			end
			n.TenableButton.frame:Hide()
		end
		Debug("== HIDDEN 1 ==", #activeTStrings)
	end)
end

function f:HookAzeriteEssenceUI() -- Set Parents and Anchors for the 8.2 AzeriteEssenceUI
	if not playerSpecID then return end -- No playerSpecID yet, return
	Debug("HOOK Essence UI")
	self:InitUI()

	_setupStringAndEnableButton()

	_G.AzeriteEssenceUI:HookScript("OnHide", function() -- Hide strings on frame hide
		Debug("== HIDING 2 ==", #activeEStrings)
		while #activeEStrings > 0 do
			local s = tremove(activeEStrings)
			ReleaseString(s)
		end

		if n.guiContainer then
			n.scalesScroll:ReleaseChildren()
			Debug("Releasing children")
			lastOpenScale = nil
			f:RefreshConfig()

			n.guiContainer:Hide()
			if n.Estring then
				n.Estring:Hide()
			end
			n.EenableButton.frame:Hide()
		end
		Debug("== HIDDEN 2 ==", #activeEStrings)
	end)
end

local initDone
function f:InitUI() -- Build UI and set up some initial data
	if initDone then return end
	initDone = true

	Debug("INIT UI")

	-- Enable Buttons
	local TenableButton = AceGUI:Create("Button")
	--enableButton:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMLEFT", 10, 10)
	TenableButton:SetText(ADDON_NAME)
	TenableButton:SetAutoWidth(true)
	TenableButton:SetCallback("OnClick", _toggleEditorUI)
	n.TenableButton = TenableButton

	local EenableButton = AceGUI:Create("Button")
	EenableButton:SetText(ADDON_NAME)
	EenableButton:SetAutoWidth(true)
	EenableButton:SetCallback("OnClick", _toggleEditorUI)
	n.EenableButton = EenableButton

	-- Editor GUI
	n.guiContainer = n.CreateUI()
	--n.guiContainer:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI, "TOPRIGHT", 10, 0)
	--n.guiContainer:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMRIGHT", 10, 0)

	-- TreeGroup Hacks for QoL
	n.treeGroup:SetCallback("OnGroupSelected", _SelectGroup)
	n.treeGroup.tree = _buildTree(n.treeGroup.tree)
	local statusTable = {}
	for i = 1, #n.treeGroup.tree do
		statusTable[#statusTable + 1] = true
	end
	n.treeGroup:SetStatusTable({
		groups = statusTable,
		treesizable = false,
		selected = ("%d\001%s"):format(1, ADDON_NAME.."Import")
	}) -- Expand groups

	-- Content Area
	n:CreateImportGroup(n.scalesScroll)

	-- Check if we have spec
	if not (playerSpecID and cfg and cfg.specScales[playerSpecID] and cfg.specScales[playerSpecID].scaleID) then
		Debug("No playerSpecID detected", playerSpecID, cfg.specScales[playerSpecID] and cfg.specScales[playerSpecID].scaleID or "!No specScales", GetRealmName(), UnitName("player"), GetSpecializationInfo(GetSpecialization()))
		_activeSpec()
	end
	-- Populate scoreData
	_populateWeights()
end

function f:UpdateValues() -- Update scores
	lock = nil
	if not (_G.AzeriteEmpoweredItemUI or _G.AzeriteEssenceUI) then return end
	Debug("UPDATE VALUES")

	-- TRAITS
	if cfg.enableTraits and _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() then
		local currentScore, currentPotential, maxScore, currentLevel, maxLevel, midTrait = 0, 0, 0, 0, 0, 0
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		if azeriteItemLocation then
			currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		end

		-- Update score strings and calculate current score
		while #activeTStrings > 0 do
			local s = tremove(activeTStrings)
			ReleaseString(s)
		end

		-- Calculate maxScore for the item
		local allTierInfo = _G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetAllTierInfo()
		if not allTierInfo then
			local itemID = _G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItem():GetItemID()
			if not itemID then return end
			allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemID)
		end

		--[[
			Dump: value=C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(158041)
			[1]={
				[1]={
					azeritePowerIDs={
						[1]=195,
						[2]=186,
						[3]=385,
						[4]=184
					},
					unlockLevel=10
				},
				[2]={
					azeritePowerIDs={
						[1]=218,
						[2]=83
					},
					unlockLevel=15
				},
				[3]={
					azeritePowerIDs={
						[1]=13
					},
					unlockLevel=20
				}
			}
		]]

		local tierMaximumInfo = {} -- Keep track of best trait for every tier
		for tierIndex, tierInfo in ipairs(allTierInfo) do
			local maximum, tierMaximum = 0, 0
			local scoreTmp = "> Tier " .. tierIndex .. ":"
			for _, azeritePowerID in ipairs(tierInfo.azeritePowerIDs) do
				local score = 0
				local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(azeritePowerID)
				if powerInfo then
					score = scoreData[powerInfo.azeritePowerID] or scoreData[powerInfo.spellID] or 0
				end

				if maximum < score then
					maximum = score
					--tierMaximumInfo[tierIndex] = azeritePowerID
					tierMaximumInfo[tierIndex] = score -- Get best score for tier instead of azeritePowerID
				end
				if tierInfo.unlockLevel <= currentLevel and tierMaximum < score then
					tierMaximum = score
				end
				scoreTmp = scoreTmp .. " " .. (azeritePowerID or "?") .. ":" .. (scoreData[powerInfo.azeritePowerID] or "!") .. ":" .. (scoreData[azeritePowerID] or "!")
				--Debug("> Tier:", tierIndex, "Trait:", powerInfo.azeritePowerID, "Score:", score)
			end

			Debug(scoreTmp)
			--Debug(tierIndex, maximum)
			maxScore = maxScore + maximum
			currentPotential = currentPotential + tierMaximum
			if maxLevel < tierInfo.unlockLevel then
				maxLevel = tierInfo.unlockLevel
			end
		end

		-- Update scores on the traits
		traitStack.scoreData = traitStack.scoreData or {}
		wipe(traitStack.scoreData)

		local container = _G.AzeriteEmpoweredItemUI.ClipFrame.PowerContainerFrame
		local children = { container:GetChildren() }
		local frameTmp = "> Frames:"
		for _, frame in ipairs(children) do
			if frame and frame:IsShown() then
				--Debug(">" frame.azeritePowerID, frame.spellID, frame.unlockLevel)
				--Debug(">>", frame.isSelected)

				local score = 0
				local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(frame.azeritePowerID)
				if powerInfo then
					score = scoreData[powerInfo.azeritePowerID] or scoreData[powerInfo.spellID] or 0
				end

				if frame.isSelected == true then
					currentScore = currentScore + score

					if powerInfo.azeritePowerID == 13 then -- Middle
						midTrait = midTrait + 1
						Debug("UpdateValues Middle is selected")
					end
				end

				local tier = frame:GetTierIndex()
				Debug("Tier", tier, powerInfo.azeritePowerID)
				if currentLevel < frame.unlockLevel then
					score = GRAY_FONT_COLOR_CODE .. score .. FONT_COLOR_CODE_CLOSE
				--elseif tier and tierMaximumInfo[tier] == powerInfo.azeritePowerID then -- Best trait for tier
				elseif tier and tierMaximumInfo[tier] == score then -- Best score for tier
					score = ITEM_QUALITY_COLORS[7].hex .. score .. FONT_COLOR_CODE_CLOSE
				end

				if not C_AzeriteEmpoweredItem.IsPowerAvailableForSpec(frame.azeritePowerID, playerSpecID) then -- Recolor unusable powers
					score = RED_FONT_COLOR_CODE .. score .. FONT_COLOR_CODE_CLOSE
				end
				frameTmp = frameTmp .. " " .. (frame.azeritePowerID or "?") .. ":" .. (scoreData[powerInfo.azeritePowerID] or "!") .. ":" .. (scoreData[frame.azeritePowerID] or "!")
				--Debug("> Frame:", frame.azeritePowerID, frame.spellID, frame.unlockLevel, frame.isSelected, score)
				local s = AcquireString(frame, score)
				activeTStrings[#activeTStrings + 1] = s

				if powerInfo then
					traitStack.scoreData[#traitStack.scoreData + 1] = ("%s = %s"):format(tostring(powerInfo.azeritePowerID), tostring(score))
				end
			end
		end
		Debug(frameTmp)

		-- Update the string
		if currentLevel >= maxLevel then
			midTrait = midTrait + 1 -- 0 = Middle is locked, 1 = Middle is open, 2 = Middle is open and selected
			if midTrait == 1 then
				Debug("UpdateValues Middle is open")
			end
		else
			Debug("UpdateValues Middle is locked")
		end

		local effectiveILvl = _G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItem():GetCurrentItemLevel()
		if cfg.addILvlToScore and effectiveILvl then
			local middleTraitValue = midTrait == 1 and 5 or 0
			if cfg.scaleByAzeriteEmpowered then
				local azeriteEmpoweredWeight = scoreData and scoreData[13] or 0
				effectiveILvl = effectiveILvl / 5 * azeriteEmpoweredWeight -- Azerite Empowered is +5ilvl
				middleTraitValue = middleTraitValue / 5 * azeriteEmpoweredWeight
			end

			currentScore = currentScore + effectiveILvl + middleTraitValue
			currentPotential = currentPotential + effectiveILvl + middleTraitValue
			maxScore = maxScore + effectiveILvl + (midTrait == 2 and 0 or middleTraitValue)
		end

		local stats = GetItemStats(_G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItem():GetItemLink())
		if cfg.addPrimaryStatToScore and stats then
			local statScore = stats["ITEM_MOD_AGILITY_SHORT"] or stats["ITEM_MOD_INTELLECT_SHORT"] or stats["ITEM_MOD_STRENGTH_SHORT"] or 0

			currentScore = currentScore + statScore
			currentPotential = currentPotential + statScore
			maxScore = maxScore + statScore
		end

		-- Integer or Float?
		local cS, cP, mS
		if _isInteger(currentScore) and _isInteger(currentPotential) and _isInteger(maxScore) then
			cS, cP, mS = currentScore, currentPotential, maxScore
		else
			local decimals = max(_getDecimals(currentScore), _getDecimals(currentPotential), _getDecimals(maxScore))
			cS = (currentScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentScore)
			cP = (currentPotential == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentPotential)
			mS = (maxScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(maxScore)
		end

		local baseScore = format(L.PowersScoreString, cS, cP, mS, currentLevel, maxLevel)

		local groupSet, _, _, scaleName = strsplit("/", cfg.specScales[playerSpecID].scaleID)

		--n.string:SetText(format("%s\n%s", NORMAL_FONT_COLOR_CODE .. (cfg.specScales[playerSpecID].scaleName or L.ScaleName_Unknown) .. FONT_COLOR_CODE_CLOSE, baseScore))
		if n.Tstring then
			n.Tstring:SetText(format("%s\n%s", NORMAL_FONT_COLOR_CODE .. ((groupSet == "D" and (n.defaultNameTable[scaleName] or cfg.specScales[playerSpecID].scaleName) or cfg.specScales[playerSpecID].scaleName) or L.ScaleName_Unknown) .. FONT_COLOR_CODE_CLOSE, baseScore))
		else
			delayedUpdate()
		end

		traitStack.scoreData.current = cS
		traitStack.scoreData.potential = cP
		traitStack.scoreData.maximum = mS

		Debug("Score:", currentScore, maxScore, currentLevel, #activeTStrings, itemID)
	end
	-- ESSENCES
	if cfg.enableEssences and _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown() then -- 8.2 Azerite Essences
		-- Update score strings and calculate current score
		while #activeEStrings > 0 do
			local s = tremove(activeEStrings)
			ReleaseString(s)
		end

		essenceStack.scoreData = essenceStack.scoreData or {}
		wipe(essenceStack.scoreData)

		local essences = C_AzeriteEssence.GetEssences()
		local maxMajors, maxMinors = {}, {}
		local potMajors, potMinors = {}, {}
		for i = 1, #essences do
			--[[
				[8]={
					valid=true,
					name="Nullification Dynamo",
					ID=13,
					icon=3015741,
					unlocked=false,
					rank=0
				},
			]]--
			local essence = essences[i]
			if essenceScoreData[essence.ID] then
				if essence.valid then
					maxMajors[essence.ID] = essenceScoreData[essence.ID][1] or 0
					maxMinors[essence.ID] = essenceScoreData[essence.ID][2] or 0

					if essence.unlocked then
						potMajors[essence.ID] = essenceScoreData[essence.ID][1] or 0
						potMinors[essence.ID] = essenceScoreData[essence.ID][2] or 0
					end
				end

				local majorS = essenceScoreData[essence.ID][1] or 0
				local minorS = essenceScoreData[essence.ID][2] or 0
				local combinedS = majorS + minorS
				if not essence.unlocked then
					majorS = GRAY_FONT_COLOR_CODE .. majorS .. FONT_COLOR_CODE_CLOSE
					minorS = GRAY_FONT_COLOR_CODE .. minorS .. FONT_COLOR_CODE_CLOSE
					combinedS = GRAY_FONT_COLOR_CODE .. combinedS .. FONT_COLOR_CODE_CLOSE
				end

				essenceStack.scoreData[#essenceStack.scoreData + 1] = ("%s = %s (%s/%s)"):format(tostring(essence.ID), tostring(combinedS), tostring(majorS), tostring(minorS))
			end
		end

		--[[
			=== 8.2:
			Major Slot
			---------------------
			milestoneID		115
			requiredLevel	0
			slot			0
			swirlScale		1

			canUnlock		false
			isDraggable		true
			isMajorSlot		true
			unlocked		true

			-- Perseverance
			milestoneID		110
			requiredLevel	52
			swirlScale		0.5

			Minor Slot 1
			---------------------
			milestoneID		116
			requiredLevel	55
			slot			1
			swirlScale		1

			canUnlock		false
			isDraggable		false
			isMajorSlot		false
			unlocked		false

			-- Perseverance
			milestoneID		111
			requiredLevel	57
			swirlScale		0.5

			-- Perseverance
			milestoneID		112
			requiredLevel	62
			swirlScale		0.5

			Minor Slot 2
			---------------------
			milestoneID		117
			requiredLevel	65
			slot			2
			swirlScale		1

			canUnlock		false
			isDraggable		false
			isMajorSlot		false
			unlocked		false

			-- Perseverance
			milestoneID		113
			requiredLevel	67
			swirlScale		0.5

			=== 8.3:
			-- Perseverance
			milestoneID		118
			requiredLevel	71
			swirlScale		0.5

			Minor Slot 3
			---------------------
			milestoneID		119
			requiredLevel	75
			slot			3
			swirlScale		1

			canUnlock		false
			isDraggable		false
			isMajorSlot		false
			unlocked		false

			-- Perseverance
			milestoneID		120
			requiredLevel	80
			swirlScale		0.5
		]]--
		local milestones = C_AzeriteEssence.GetMilestones()
		local slots = 0
		for i = #milestones, 1, -1 do
			if milestones[i].ID == 119 and milestones[i].unlocked == true then -- Major + 3 minor
				slots = 4
				break
			elseif milestones[i].ID == 117 and milestones[i].unlocked == true then -- Major + 2 Minor
				slots = 3
				break
			elseif milestones[i].ID == 116 and milestones[i].unlocked == true then -- Major + Minor
				slots = 2
				break
			elseif milestones[i].ID == 115 and milestones[i].unlocked == true then -- Major
				slots = 1
				break
			end
		end

		essenceStack.math = essenceStack.math or {}
		wipe(essenceStack.math)

		-- Calculate the best combination for essences
		local finalEssenceScores = finalEssenceScores or {}
		for iterator = 1, 3 do
			essenceStack.math[#essenceStack.math + 1] = ("Iteration %d:\n   ---------------"):format(iterator)

			-- Copy the essence scores so we don't mess up with the original results tainting later iterations
			local tempMaxMajors = shallowcopy(maxMajors)
			local tempMaxMinors = shallowcopy(maxMinors)
			local tempPotMajors = shallowcopy(potMajors)
			local tempPotMinors = shallowcopy(potMinors)

			-- Sort functions
			local function maxMajorSort(a, b) -- Sort from largest to the smallest score
				return ((tempMaxMajors[a] or 0) + (tempMaxMinors[a] or 0)) > ((tempMaxMajors[b] or 0) + (tempMaxMinors[b] or 0))
			end
			local function maxMinorSort(a, b) -- Sort from smallest to the largest score
				return (tempMaxMinors[a] or 0) < (tempMaxMinors[b] or 0)
			end

			local function potMajorSort(a, b) -- Sort from largest to the smallest score
				return ((tempPotMajors[a] or 0) + (tempPotMinors[a] or 0)) > ((tempPotMajors[b] or 0) + (tempPotMinors[b] or 0))
			end
			local function potMinorSort(a, b) -- Sort from smallest to the largest score
				return (tempPotMinors[a] or 0) < (tempPotMinors[b] or 0)
			end

			-- Find Maximum score
			-- Find best Major score
			local maxMajorIDs = {}
			for essenceID in pairs(tempMaxMajors) do
				maxMajorIDs[#maxMajorIDs + 1] = essenceID
			end

			sort(maxMajorIDs, maxMajorSort)
			local maxMajorID = tremove(maxMajorIDs, iterator) -- Remove Nth element
			local tempMax = ((tempMaxMajors[maxMajorID] or 0) + (tempMaxMinors[maxMajorID] or 0))
			local maxScore = tempMax

			essenceStack.math[#essenceStack.math + 1] = ("MAX Major: %s + %s = %s (%d)"):format(tostring(tempMax-(tempMaxMinors[maxMajorID] or 0)), tostring(tempMaxMinors[maxMajorID]), tostring(tempMax), maxMajorID)

			Debug("maxScore:", maxScore, tempMax, tempMax-(tempMaxMinors[maxMajorID] or 0), tempMaxMinors[maxMajorID], maxMajorID)
			if tempMaxMinors[maxMajorID] then
				tempMaxMinors[maxMajorID] = nil -- Remove the top Major score's minor score
			end

			-- Find top 3 maximum Minor scores from the rest by putting them into table and sorting them and picking first 3
			local maxMinorIDs = {}
			for essenceID in pairs(tempMaxMinors) do
				maxMinorIDs[#maxMinorIDs + 1] = essenceID
			end

			sort(maxMinorIDs, maxMinorSort)
			essenceStack.math[#essenceStack.math + 1] = "MinorMax:"
			for _, val in ipairs(tempMaxMinors) do
				essenceStack.math[#essenceStack.math] = essenceStack.math[#essenceStack.math] .. (" %s"):format(tostring(val))
			end

			local firstMaxID = tremove(maxMinorIDs)
			local secondMaxID = tremove(maxMinorIDs)
			local thirdMaxID = tremove(maxMinorIDs)

			local firstMax = tempMaxMinors[firstMaxID] or 0
			local secondMax = tempMaxMinors[secondMaxID] or 0
			local thirdMax = tempMaxMinors[thirdMaxID] or 0

			maxScore = maxScore + firstMax + secondMax + thirdMax -- Doing work for 8.3 already
			Debug("maxScore:", maxScore, firstMax, secondMax, thirdMax)

			essenceStack.math[#essenceStack.math + 1] = ("MAX Minor: %s / %s / %s (%d - %d - %d)"):format(tostring(firstMax), tostring(secondMax), tostring(thirdMax), firstMaxID, secondMaxID, thirdMaxID)
			essenceStack.math[#essenceStack.math + 1] = ("MAX Score: %s"):format(tostring(maxScore))

			-- Find Potential score
			-- Find best Major score
			local potMajorIDs = {}
			for essenceID in pairs(tempPotMajors) do
				potMajorIDs[#potMajorIDs + 1] = essenceID
			end

			sort(potMajorIDs, potMajorSort)
			local potMajorID = tremove(potMajorIDs, iterator) -- Remove Nth element
			local tempPot = ((tempPotMajors[potMajorID] or 0) + (tempPotMinors[potMajorID] or 0))
			local currentPotential = tempPot

			essenceStack.math[#essenceStack.math + 1] = ("POT Major: %s + %s = %s (%d)"):format(tostring(tempPot-(tempPotMinors[potMajorID] or 0)), tostring(tempPotMinors[potMajorID]), tostring(tempPot), potMajorID)

			Debug("currentPotential:", currentPotential, tempPot, tempPot-(tempPotMinors[potMajorID] or 0), tempPotMinors[potMajorID], potMajorID)
			if tempPotMinors[potMajorID] then
				tempPotMinors[potMajorID] = nil -- Remove the top Major score's minor score
			end

			-- Find top 3 potential Minor scores from the rest by putting them into table and sorting them and picking first 3
			local potMinorIDs = {}
			for essenceID in pairs(tempPotMinors) do
				potMinorIDs[#potMinorIDs + 1] = essenceID
			end

			sort(potMinorIDs, potMinorSort)
			essenceStack.math[#essenceStack.math + 1] = "MinorPot:"
			for _, val in ipairs(tempPotMinors) do
				essenceStack.math[#essenceStack.math] = essenceStack.math[#essenceStack.math] .. (" %s"):format(tostring(val))
			end

			local firstPotID = tremove(potMinorIDs)
			local secondPotID = tremove(potMinorIDs)
			local thirdPotID = tremove(potMinorIDs)

			local firstPot = tempPotMinors[firstPotID] or 0
			local secondPot = tempPotMinors[secondPotID] or 0
			local thirdPot = tempPotMinors[thirdPotID] or 0

			if slots == 1 then
				--currentPotential = currentPotential -- Previously set Major slot's score
			elseif slots == 2 then
				currentPotential = currentPotential + firstPot
			elseif slots == 3 then
				currentPotential = currentPotential + firstPot + secondPot
			elseif slots == 4 then -- 8.3
				currentPotential = currentPotential + firstPot + secondPot + thirdPot
			else -- Slots == 0
				currentPotential = 0
			end
			Debug("currentPotential:", currentPotential, firstPot, secondPot, thirdPot, slots)

			essenceStack.math[#essenceStack.math + 1] = ("POT Minor: %s / %s / %s (%d - %d - %d)"):format(tostring(firstPot), tostring(secondPot), tostring(thirdPot), firstPotID, secondPotID, thirdPotID)
			essenceStack.math[#essenceStack.math + 1] = ("POT Score: %s (%d)\n   ---------------"):format(tostring(currentPotential), slots)

			finalEssenceScores[iterator] = {
				maxScore, -- 1
				--[[
				maxMajorID, -- 2
				firstMaxID, -- 3
				secondMaxID, -- 4
				thirdMaxID, -- 5
				]]--
				currentPotential, -- 6, 2
				potMajorID, -- 7, 3
				firstPotID, -- 8, 4
				secondPotID, -- 9, 5
				thirdPotID, -- 10, 6
				tempPot, -- 11, 7
				firstPot, -- 12, 8
				secondPot, -- 13, 9
				thirdPot -- 14, 10
			}
		end

		local currentScore, currentPotential, maxScore = 0, 0, 0
		local maxID, potID = 1, 1

		if cfg.preferBiSMarjor then -- Prefer BiS Major essence
			maxScore = finalEssenceScores[1][1]
			currentPotential = finalEssenceScores[1][2]
		else -- Check if we can get better score with non-BiS Major essence
			if finalEssenceScores[1][1] > finalEssenceScores[2][1] and finalEssenceScores[1][1] > finalEssenceScores[3][1] then
				maxID = 1
				maxScore = finalEssenceScores[1][1]
			elseif finalEssenceScores[2][1] > finalEssenceScores[1][1] and finalEssenceScores[2][1] > finalEssenceScores[3][1] then
				maxID = 2
				maxScore = finalEssenceScores[2][1]
			else
				maxID = 3
				maxScore = finalEssenceScores[3][1]
			end

			if finalEssenceScores[1][2] > finalEssenceScores[2][2] and finalEssenceScores[1][2] > finalEssenceScores[3][2] then
				potID = 1
				currentPotential = finalEssenceScores[1][2]
			elseif finalEssenceScores[2][2] > finalEssenceScores[1][2] and finalEssenceScores[2][2] > finalEssenceScores[3][2] then
				potID = 2
				currentPotential = finalEssenceScores[2][2]
			else
				potID = 3
				currentPotential = finalEssenceScores[3][2]
			end
		end
		essenceStack.math[#essenceStack.math + 1] = ("FINAL Score: %s / %s (%d / %d) - %s"):format(tostring(currentPotential), tostring(maxScore), potID, maxID, tostring(cfg.preferBiSMarjor))

		--[[
			maxScore: 10.5 10.5 7 3.5 25
			maxScore: 17.5 4 3
			currentPotential: 9 9 5 4 27
			currentPotential: 9 2 1 1
			currentScore: 7 7
		]]--

		-- Draw scores on the Essences inside the scroll-frame
		--[[
			AzeriteEssenceInfo
			Key			Type
			-------------------
			ID			number
			name		string
			rank		number
			unlocked	bool
			valid		bool
			icon		number
		]]--
		local container = _G.AzeriteEssenceUI.EssenceList.ScrollChild
		local children = { container:GetChildren() }
		for _, frame in ipairs(children) do
			if frame and frame:IsShown() then -- There are 13 buttons, but you can fit only 12 on the screen at any given time or you end up with numbers hovering under or over the frame
				Debug(">", frame.essenceID, frame.rank)

				if frame.essenceID then
					local majorScore, minorScore = 0, 0

					local essenceInfo = C_AzeriteEssence.GetEssenceInfo(frame.essenceID)
					if essenceInfo then
						Debug(">>", essenceInfo.ID, essenceInfo.name, essenceInfo.rank, essenceInfo.unlocked, essenceInfo.valid, essenceInfo.icon)

						if essenceScoreData[essenceInfo.ID] then
							majorScore = essenceScoreData[essenceInfo.ID][1] or 0
							minorScore = essenceScoreData[essenceInfo.ID][2] or 0
						end
					end

					local isBiSMajor, isBiSMinor = false, false
					if not frame.majorString then
						--frame.majorString = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
						frame.majorString = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
						frame.majorString:SetPoint("TOPRIGHT", -2, -5)
					end
					--if finalEssenceScores[potID][3] == essenceInfo.ID then -- BiS Major
					if finalEssenceScores[potID][7] == (majorScore + minorScore) then -- BiS Major score
						isBiSMajor = true
					end
					frame.majorString:SetText(majorScore)

					if not frame.minorString then
						--frame.minorString = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
						frame.minorString = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
						frame.minorString:SetPoint("BOTTOMRIGHT", -2, 5)
					end
					--if finalEssenceScores[potID][4] == essenceInfo.ID or finalEssenceScores[potID][5] == essenceInfo.ID then -- or finalEssenceScores[potID][6] == essenceInfo.ID then -- BiS Minor
					if finalEssenceScores[potID][8] == minorScore or finalEssenceScores[potID][9] == minorScore or finalEssenceScores[potID][10] == minorScore then -- BiS Minor score
						isBiSMinor = true
					end
					frame.minorString:SetText(minorScore)

					if essenceInfo then
						if not essenceInfo.valid then -- Not valid
							frame.majorString:SetText(RED_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(RED_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						elseif not essenceInfo.unlocked then -- Locked
							frame.majorString:SetText(GRAY_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(GRAY_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						elseif isBiSMajor then -- BiS Major
							frame.majorString:SetText(ITEM_QUALITY_COLORS[5].hex .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(ITEM_QUALITY_COLORS[5].hex .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						elseif isBiSMinor then -- BiS Minor
							--frame.majorString:SetText(ITEM_QUALITY_COLORS[7].hex .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(ITEM_QUALITY_COLORS[7].hex .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						end
					end
					--[[
					if essenceInfo and not essenceInfo.valid then
						frame.majorString:SetText(RED_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						frame.minorString:SetText(RED_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
					elseif essenceInfo and not essenceInfo.unlocked then
						frame.majorString:SetText(GRAY_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						frame.minorString:SetText(GRAY_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
					end
					]]--

					Debug("Major:", majorScore, "Minor:", minorScore)
				end

			end
		end

		-- Draw scores for the Essences in the main view of the UI
		local frameTmp = "> Frames:"
		essenceStack.scoreData[#essenceStack.scoreData + 1] = "---"
		for _, slotFrame in ipairs(_G.AzeriteEssenceUI.Slots) do
			local score = 0

			local essenceID = C_AzeriteEssence.GetMilestoneEssence(slotFrame.milestoneID)
			if essenceID then
				if essenceScoreData[essenceID] then
					if slotFrame.isMajorSlot then -- Major Slot
						--score = (essenceScoreData[essenceID][1] or 0) + (essenceScoreData[essenceID][2] or 0)
						-- Show Major/Minor values instead of combined value in the UI
						score = (essenceScoreData[essenceID][1] or 0) .. "\n" .. (essenceScoreData[essenceID][2] or 0)
						currentScore = currentScore + (essenceScoreData[essenceID][1] or 0) + (essenceScoreData[essenceID][2] or 0)
						Debug("currentScore:", currentScore, (essenceScoreData[essenceID][1] or 0), (essenceScoreData[essenceID][2] or 0))
					else -- Minor Slot
						score = essenceScoreData[essenceID][2] or 0
						currentScore = currentScore + score
						Debug("currentScore:", currentScore, score)
					end
				end

				--currentScore = currentScore + score
				--Debug("currentScore:", currentScore, score)

				essenceStack.scoreData[#essenceStack.scoreData + 1] = ("%s = %s/%s"):format(tostring(essenceID), string.gsub(tostring(score), "\n", " - "), tostring(slotFrame.isMajorSlot))
			end

			frameTmp = frameTmp .. " " .. (slotFrame.milestoneID or "?") .. " " .. (slotFrame.requiredLevel or "?") .. " " .. (slotFrame.slot or "?") .. " " .. (slotFrame.swirlScale or "?") .. " " .. tostring(slotFrame.canUnlock) .. " " .. tostring(slotFrame.isDraggable) .. " " .. tostring(slotFrame.isMajorSlot) .. " " .. tostring(slotFrame.unlocked)

			if slotFrame.unlocked then
				local s = AcquireString(slotFrame, score)
				activeEStrings[#activeEStrings + 1] = s
			end
		end
		Debug(frameTmp)

		--n.string:SetText("Cool")
		local currentLevel = _G.AzeriteEssenceUI.powerLevel or 0
		Debug("milestones:", type(milestones), #milestones, milestones[#milestones].requiredLevel)
		local maxLevel = milestones[#milestones].requiredLevel or 0

		-- Integer or Float?
		local cS, cP, mS
		if _isInteger(currentScore) and _isInteger(currentPotential) and _isInteger(maxScore) then
			cS, cP, mS = currentScore, currentPotential, maxScore
		else
			local decimals = max(_getDecimals(currentScore), _getDecimals(currentPotential), _getDecimals(maxScore))
			cS = (currentScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentScore)
			cP = (currentPotential == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentPotential)
			mS = (maxScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(maxScore)
		end

		local baseScore = format(L.PowersScoreString, cS, cP, mS, currentLevel, maxLevel)
		local groupSet, _, _, scaleName = strsplit("/", cfg.specScales[playerSpecID].scaleID)

		if n.Estring then
			n.Estring:SetText(format("%s\n%s", NORMAL_FONT_COLOR_CODE .. ((groupSet == "D" and (n.defaultNameTable[scaleName] or cfg.specScales[playerSpecID].scaleName) or cfg.specScales[playerSpecID].scaleName) or L.ScaleName_Unknown) .. FONT_COLOR_CODE_CLOSE, baseScore))
		else
			delayedUpdate()
		end

		essenceStack.scoreData.current = cS
		essenceStack.scoreData.potential = cP
		essenceStack.scoreData.maximum = mS
		essenceStack.scoreData.slots = slots
	end

	Debug("Active Strings:", #activeEStrings, f:GetFrameStrata())
end

-- Item Tooltip & Hook - Hacked together and probably could be done better
local azeriteEmpoweredItemLocation = ItemLocation:CreateEmpty()
local itemEquipLocToSlot = {
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_SHOULDER"] = 3,
	["INVTYPE_CHEST"] = 5,
	["INVTYPE_ROBE"] = 5
}

local function _getGearScore(dataPointer, itemEquipLoc)
	local currentLevel, maxLevel = 0, 0
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	end

	local itemLink = GetInventoryItemLink("player", itemEquipLoc)

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		local equipLocation = ItemLocation:CreateFromEquipmentSlot(itemEquipLoc)
		local allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemLink)

		local currentScore, currentPotential, maxScore, midTrait = 0, 0, 0, 0
		for tierIndex, tierInfo in ipairs(allTierInfo) do
			local maximum, tierMaximum = 0, 0
			for _, azeritePowerID in ipairs(tierInfo.azeritePowerIDs) do
				local score = 0
				local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(azeritePowerID)
				if powerInfo then
					score = dataPointer[powerInfo.azeritePowerID] or dataPointer[powerInfo.spellID] or 0

					if equipLocation:HasAnyLocation() and C_AzeriteEmpoweredItem.IsPowerSelected(equipLocation, powerInfo.azeritePowerID) then
						currentScore = currentScore + score

						if powerInfo.azeritePowerID == 13 then -- Middle
							midTrait = midTrait + 1
							Debug("_getGearScore Middle is selected")
						end
					end
				end
				
				if maximum < score then
					maximum = score
				end
				if tierInfo.unlockLevel <= currentLevel and tierMaximum < score then
					tierMaximum = score
				end
			end

			maxScore = maxScore + maximum
			currentPotential = currentPotential + tierMaximum
			if maxLevel < tierInfo.unlockLevel then
				maxLevel = tierInfo.unlockLevel
			end
		end

		if currentLevel >= maxLevel then
			midTrait = midTrait + 1 -- 0 = Middle is locked, 1 = Middle is open, 2 = Middle is open and selected
			if midTrait == 1 then
				Debug("_getGearScore Middle is open")
			end
		else
			Debug("_getGearScore Middle is locked")
		end

		return currentScore, currentPotential, maxScore, itemLink, midTrait
	end

	return 0, 0, 0, itemLink, 0
end

local tooltipTable = {}
local function _updateTooltip(tooltip, itemLink)
	local currentLevel, maxLevel = 0, 0
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	end

	--if not tooltipTable.itemLink or tooltipTable.itemLink ~= itemLink then
		wipe(tooltipTable)
		tooltipTable.itemLink = itemLink
		tooltipTable.currentLevel = currentLevel
		tooltipTable.scores = {}
	--end

	local allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemLink)

	--[[
		C_AzeriteEmpoweredItem.GetAllTierInfo
		C_AzeriteEmpoweredItem.GetAllTierInfoByItemID
		C_Cursor.GetCursorItem
	]]

	local currentScore, currentPotential, maxScore, scaleInfo, midTrait = {}, {}, {}, {}, {}
	for i, tooltipScale in ipairs(cfg.tooltipScales) do
		currentScore[i] = 0
		currentPotential[i] = 0
		maxScore[i] = 0
		scaleInfo[i] = {}
		midTrait[i] = 0

		tooltipTable[i] = tooltipTable[i] or {}
		tooltipTable[i].tooltipScale = tooltipScale.scaleID

		local dataPointer
		local groupSet, classID, specNum, scaleName = strsplit("/", tooltipScale.scaleID)
		if groupSet and classID and specNum and scaleName then
			classID = tonumber(classID)
			specNum = tonumber(specNum)
			for _, dataSet in ipairs(groupSet == "C" and customScales or n.defaultScalesData) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
					dataPointer = dataSet[4]

					scaleInfo[i].class = classID
					if groupSet == "C" then
						local _, specName, _, iconID = GetSpecializationInfoByID(specNum)
						scaleInfo[i].icon = iconID
					else
						local _, specName, _, iconID = GetSpecializationInfoForClassID(classID, specNum)
						scaleInfo[i].icon = iconID
					end

					break
				end
			end
		end

		if dataPointer then
			for tierIndex, tierInfo in ipairs(allTierInfo) do

				tooltipTable[i][tierIndex] = tooltipTable[i][tierIndex] or {}
				tooltipTable[i][tierIndex].unlockLevel = tooltipTable[i][tierIndex].unlockLevel or tierInfo.unlockLevel

				local maximum, tierMaximum = 0, 0
				for _, azeritePowerID in ipairs(tierInfo.azeritePowerIDs) do
					local score = 0
					local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(azeritePowerID)
					if powerInfo then
						score = dataPointer[powerInfo.azeritePowerID] or dataPointer[powerInfo.spellID] or 0

						tooltipTable[i][tierIndex][powerInfo.azeritePowerID] = score

						if azeriteEmpoweredItemLocation:HasAnyLocation() and C_AzeriteEmpoweredItem.IsPowerSelected(azeriteEmpoweredItemLocation, powerInfo.azeritePowerID) then
							currentScore[i] = currentScore[i] + score
							--Debug("+++", powerInfo.azeritePowerID, GetSpellInfo(powerInfo.spellID), score)

							tooltipTable[i][tierIndex][powerInfo.azeritePowerID] = ">" .. score .. "<"

							if powerInfo.azeritePowerID == 13 then -- Middle
								midTrait[i] = midTrait[i] + 1
								Debug("_updateTooltip Middle is selected")
							end
						else
							--Debug("---", powerInfo.azeritePowerID, GetSpellInfo(powerInfo.spellID), score)
						end
					end
					
					if maximum < score then
						maximum = score
					end
					if tierInfo.unlockLevel <= currentLevel and tierMaximum < score then
						tierMaximum = score
					end
				end

				--Debug(tierIndex, maximum)
				maxScore[i] = maxScore[i] + maximum
				currentPotential[i] = currentPotential[i] + tierMaximum
				if maxLevel < tierInfo.unlockLevel then
					maxLevel = tierInfo.unlockLevel
				end
			end
		end

		if currentLevel >= maxLevel then
			midTrait[i] = midTrait[i] + 1 -- 0 = Middle is locked, 1 = Middle is open, 2 = Middle is open and selected
			if midTrait[i] == 1 then
				Debug("_updateTooltip Middle is open")
			end
		else
			Debug("_updateTooltip Middle is locked")
		end

		tooltipTable.scores[i] = tooltipTable.scores[i] or {}
		tooltipTable.scores[i].traitScore = currentScore[i]
		tooltipTable.scores[i].traitPotential = currentPotential[i]
		tooltipTable.scores[i].traitMax = maxScore[i]

		local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
		if cfg.addILvlToScore and effectiveILvl then
			local middleTraitValue = midTrait[i] == 1 and 5 or 0
			if cfg.scaleByAzeriteEmpowered then
				local azeriteEmpoweredWeight = dataPointer and dataPointer[13] or 0
				effectiveILvl = effectiveILvl / 5 * azeriteEmpoweredWeight -- Azerite Empowered is +5ilvl
				middleTraitValue = middleTraitValue / 5 * azeriteEmpoweredWeight
			end

			currentScore[i] = currentScore[i] + effectiveILvl + middleTraitValue
			currentPotential[i] = currentPotential[i] + effectiveILvl + middleTraitValue
			maxScore[i] = maxScore[i] + effectiveILvl + (midTrait[i] == 2 and 0 or middleTraitValue)
			Debug("ilvl:", currentScore[i], currentPotential[i], maxScore[i], effectiveILvl, midTrait[i], middleTraitValue)

			tooltipTable.scores[i].midTrait = midTrait[i]
			tooltipTable.scores[i].middleTraitValue = middleTraitValue
			tooltipTable.scores[i].ilvlScore = currentScore[i]
			tooltipTable.scores[i].ilvlPotential = currentPotential[i]
			tooltipTable.scores[i].ilvlMax = maxScore[i]
		end

		tooltipTable.scores.effectiveILvl = effectiveILvl

		local stats = GetItemStats(itemLink)
		if cfg.addPrimaryStatToScore and stats then
			local statScore = stats["ITEM_MOD_AGILITY_SHORT"] or stats["ITEM_MOD_INTELLECT_SHORT"] or stats["ITEM_MOD_STRENGTH_SHORT"] or 0

			currentScore[i] = currentScore[i] + statScore
			currentPotential[i] = currentPotential[i] + statScore
			maxScore[i] = maxScore[i] + statScore

			tooltipTable.scores[i].statAmount = statScore
			tooltipTable.scores[i].statScore = currentScore[i]
			tooltipTable.scores[i].statPotential = currentPotential[i]
			tooltipTable.scores[i].statMax = maxScore[i]
		end

		if cfg.relativeScore and dataPointer then
			local equippedScore, equippedPotential, equippedMax, equippedItemLink, equippedMidTrait = _getGearScore(dataPointer, itemEquipLocToSlot[itemEquipLoc])

			local equippedEffectiveILvl = GetDetailedItemLevelInfo(equippedItemLink)

			tooltipTable.equippedItemLink = equippedItemLink
			tooltipTable.equippedEffectiveILvl = equippedEffectiveILvl
			tooltipTable.scores[i].relTraitScore = equippedScore
			tooltipTable.scores[i].relTraitPotential = equippedPotential
			tooltipTable.scores[i].relTraitMax = equippedMax

			if cfg.addILvlToScore and equippedEffectiveILvl then
				local middleTraitValue = equippedMidTrait == 1 and 5 or 0
				if cfg.scaleByAzeriteEmpowered then
					local azeriteEmpoweredWeight = dataPointer and dataPointer[13] or 0
					equippedEffectiveILvl = equippedEffectiveILvl / 5 * azeriteEmpoweredWeight -- Azerite Empowered is +5ilvl
					middleTraitValue = middleTraitValue / 5 * azeriteEmpoweredWeight
				end

				equippedScore = equippedScore + equippedEffectiveILvl + middleTraitValue
				equippedPotential = equippedPotential + equippedEffectiveILvl + middleTraitValue
				equippedMax = equippedMax + equippedEffectiveILvl + (equippedMidTrait == 2 and 0 or middleTraitValue)
				Debug("ilvl:", equippedScore, equippedPotential, equippedMax, equippedEffectiveILvl, equippedMidTrait, middleTraitValue)

				tooltipTable.scores[i].relMidTrait = equippedMidTrait
				tooltipTable.scores[i].relMiddleTraitValue = middleTraitValue
				tooltipTable.scores[i].relIlvlScore = equippedScore
				tooltipTable.scores[i].relIlvlPotential = equippedPotential
				tooltipTable.scores[i].relIlvlMax = equippedMax
			end

			local equippedStats = GetItemStats(equippedItemLink)
			if cfg.addPrimaryStatToScore and equippedStats then
				local statScore = equippedStats["ITEM_MOD_AGILITY_SHORT"] or equippedStats["ITEM_MOD_INTELLECT_SHORT"] or equippedStats["ITEM_MOD_STRENGTH_SHORT"] or 0
				equippedScore = equippedScore + statScore
				equippedPotential = equippedPotential + statScore
				equippedMax = equippedMax + statScore

				tooltipTable.scores[i].relStatAmount = statScore
				tooltipTable.scores[i].relStatScore = equippedScore
				tooltipTable.scores[i].relStatPotential = equippedPotential
				tooltipTable.scores[i].relStatMax = equippedMax
			end

			currentScore[i] = equippedScore == 0 and 0 or floor((currentScore[i] / equippedScore - 1) * 100 + .5)
			currentPotential[i] = equippedPotential == 0 and 0 or floor((currentPotential[i] / equippedPotential - 1) * 100 + .5)
			maxScore[i] = equippedMax == 0 and 0 or floor((maxScore[i] / equippedMax - 1) * 100 + .5)
		end
	end

	--tooltip:AddLine(" \n"..ADDON_NAME)
	local tooltipLine = " \n" .. ADDON_NAME .. "\n"
	if cfg.showTooltipLegend then
		tooltipLine = tooltipLine .. HIGHLIGHT_FONT_COLOR_CODE .. L.ItemToolTip_Legend .. FONT_COLOR_CODE_CLOSE .. "\n"
	end
	local showTooltipLine = false

	for i = 1, #maxScore do
		if scaleInfo[i].class then
			local _, classTag = GetClassInfo(scaleInfo[i].class)
			local c = _G.RAID_CLASS_COLORS[classTag]

			local string = "|T%d:0|t |c%s%s|r: "
			if cfg.relativeScore then -- Relative score
				string = string .. ("%s%%d%s%s"):format(currentScore[i] < 0 and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE .. "+", "%%", FONT_COLOR_CODE_CLOSE)
				string = string .. " / "
				string = string .. ("%s%%d%s%s"):format(currentPotential[i] < 0 and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE .. "+", "%%", FONT_COLOR_CODE_CLOSE)
				string = string .. " / "
				string = string .. ("%s%%d%s%s"):format(maxScore[i] < 0 and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE .. "+", "%%", FONT_COLOR_CODE_CLOSE)
			elseif _isInteger(currentScore[i]) and _isInteger(currentPotential[i]) and _isInteger(maxScore[i]) then -- All integers
				string = string .. "%d / %d / %d"
			else -- There are some floats
				local decimals = max(_getDecimals(currentScore[i]), _getDecimals(currentPotential[i]), _getDecimals(maxScore[i]))
				--Debug("Decimals:", decimals)
				--string = string .. ("%%.%df / %%.%df / %%.%df"):format(decimals, decimals, decimals)
				string = string .. (currentScore[i] == 0 and "%d" or ("%%.%df"):format(decimals))
				string = string .. " / "
				string = string .. (currentPotential[i] == 0 and "%d" or ("%%.%df"):format(decimals))
				string = string .. " / "
				string = string .. (maxScore[i] == 0 and "%d" or ("%%.%df"):format(decimals))
			end

			if not cfg.showOnlyUpgrades or cfg.showOnlyUpgrades and (currentScore[i] > 0 or currentPotential[i] > 0 or maxScore[i] > 0) then
				--tooltip:AddLine(format(string, scaleInfo[i].icon, c.colorStr, cfg.tooltipScales[i].scaleName, currentScore[i], currentPotential[i], maxScore[i]),  1, 1, 1)
				tooltipLine = tooltipLine .. format(string, scaleInfo[i].icon, c.colorStr, cfg.tooltipScales[i].scaleName, currentScore[i], currentPotential[i], maxScore[i]) .. "\n"
				showTooltipLine = true
			end
		end
	end

	--tooltip:AddLine(format(L.ItemToolTip_AzeriteLevel, currentLevel, maxLevel))
	tooltipLine = tooltipLine .. format(L.ItemToolTip_AzeriteLevel, currentLevel, maxLevel)
	if showTooltipLine then
		tooltip:AddLine(tooltipLine)
	end
	tooltip:Show() -- Make updates visible
end

-- Item from bags
hooksecurefunc(GameTooltip, "SetBagItem", function(self, ...) -- This can be called 4-5 times per second
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local bag, slot = ...
	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromBagAndSlot(bag, slot)

		_updateTooltip(self, itemLink)
	end
end)

-- Equipped item
hooksecurefunc(GameTooltip, "SetInventoryItem", function(self, ...) -- This can be called 4-5 times per second
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local unit, equipLoc = ... -- player 1 nil true
	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromEquipmentSlot(equipLoc)

		_updateTooltip(self, itemLink)
	end
end)

-- Any other item, EJ etc.
hooksecurefunc(GameTooltip, "SetHyperlink", function(self, ...)
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		_updateTooltip(self, itemLink)
	end
end)

-- Vendor item (https://wow.gamepedia.com/Widget_API)
hooksecurefunc(GameTooltip, "SetMerchantItem", function(self, ...) -- ... = merchantSlot
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		--azeriteEmpoweredItemLocation = ItemLocation:CreateFromBagAndSlot(bag, slot) -- WTH have I been thinking or have I just been copy&pasting?

		_updateTooltip(self, itemLink)
	end
end)

-- Comparison tooltip for Vendor items (https://www.townlong-yak.com/framexml/27602/GameTooltip.lua#490)
hooksecurefunc(GameTooltip.shoppingTooltips[1], "SetCompareItem", function(self, ...) -- ... = ShoppingTooltip2, GameTooltip
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromEquipmentSlot(itemEquipLocToSlot[itemEquipLoc])

		_updateTooltip(self, itemLink)
	end
end)

-- Comparison tooltip for WQ items (https://github.com/phanx-wow/PhanxBorder/blob/master/Blizzard.lua#L205)
-- WorldmapTooltip is being deprecated in 8.1.5. GameTooltip should be used instead. (https://www.wowinterface.com/forums/showthread.php?t=56964)
--[[
hooksecurefunc(WorldMapCompareTooltip1, "SetCompareItem", function(self, ...) -- ... = WorldMapCompareTooltip2, WorldMapTooltipTooltip
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromEquipmentSlot(itemEquipLocToSlot[itemEquipLoc])

		_updateTooltip(self, itemLink)
	end
end)
]]

-- World Quest rewards (https://www.townlong-yak.com/framexml/27547/GameTooltip.lua#925)
hooksecurefunc("EmbeddedItemTooltip_SetItemByQuestReward", function(self, questLogIndex, questID)
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local iName, itemTexture, quantity, quality, isUsable, itemID = GetQuestLogRewardInfo(questLogIndex, questID)
	--[[if not itemID or type(itemID) ~= "number" then return end
	local itemName, itemLink = GetItemInfo(itemID)
	if not itemName then return end]]

	-- Fix for GetItemInfo(itemID) returning the base item instead of the properly upgraded item for better geared characters.
	-- This also fixes the missing rings (3 rings vs 5 rings) from calculations for those items.
	if not (iName and itemTexture) then return end
	local itemName, itemLink = self.Tooltip:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		--[[local item = Item:CreateFromItemLink(itemLink) -- Try to cache the item for real itemlevel
		item:ContinueOnItemLoad(function()
			_updateTooltip(self.Tooltip, itemLink)
		end)]]
		_updateTooltip(self.Tooltip, itemLink)
	end
end)

GameTooltip:HookScript("OnHide", function()
	azeriteEmpoweredItemLocation:Clear()
end)

-- Quest rewards (https://www.townlong-yak.com/framexml/27602/QuestInfo.lua#964)
hooksecurefunc(GameTooltip, "SetQuestItem", function(self, ...) -- ... = type, ID
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		_updateTooltip(self, itemLink)
	end
end)


-- Event functions
function f:ADDON_LOADED(event, addon)
	if addon == ADDON_NAME then
		AzeritePowerWeightsDB = initDB(AzeritePowerWeightsDB, dbDefaults)
		db = AzeritePowerWeightsDB

		local playerName = UnitName("player")
		local playerRealm = GetRealmName()

		if db.dbVersion == 1 then -- Changing default-setting for all users because the old system wasn't clear enough for some users.
			for rName, rData in pairs(db.char) do
				for pName, pData in pairs(rData) do
					db.char[rName][pName].rolePowersNoOffRolePowers = false
				end
			end
			db.dbVersion = 2
		end

		if db.dbVersion == 2 then -- Add Azerite Essences to the Custom-scales
			for _, scale in pairs(db.customScales) do
				if type(scale[5]) ~= "table" then -- Old scale, update it with inserting Essence-table and bumping everything else down a notch
					tinsert(scale, 5, {})
				end
			end
			db.dbVersion = 3
		end

		db.char[playerRealm] = db.char[playerRealm] or {}
		db.char[playerRealm][playerName] = initDB(db.char[playerRealm][playerName], charDefaults)

		customScales = db.customScales
		cfg = db.char[playerRealm][playerName]

		self:RegisterEvent("PLAYER_LOGIN")
		self:RegisterEvent("AZERITE_ITEM_POWER_LEVEL_CHANGED")
		self:RegisterEvent("AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED")
		self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
		self:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")

		playerClassID = select(3, UnitClass("player"))
		for i = 1, GetNumSpecializationsForClassID(playerClassID) do
			local specID = GetSpecializationInfoForClassID(playerClassID, i)
			if
				not cfg.specScales[specID]
			or
				-- Localized Default-scalenames were causing issues, trying to revert those to normal state
				(cfg.specScales[specID].scaleName == L.DefaultScaleName_Default or
				cfg.specScales[specID].scaleName == L.DefaultScaleName_Defensive or
				cfg.specScales[specID].scaleName == L.DefaultScaleName_Offensive)
			or
				-- More checks for the above
				(select(3, strmatch(cfg.specScales[specID].scaleID, "D/(%d+)/(%d+)/(.+)")) == L.DefaultScaleName_Default or
				select(3, strmatch(cfg.specScales[specID].scaleID, "D/(%d+)/(%d+)/(.+)")) == L.DefaultScaleName_Defensive or
				select(3, strmatch(cfg.specScales[specID].scaleID, "D/(%d+)/(%d+)/(.+)")) == L.DefaultScaleName_Offensive)
			then

				local scaleKey = n.GetDefaultScaleSet(playerClassID, i)
				local _, _, _, defaultScaleName = strsplit("/", scaleKey)

				cfg.specScales[specID] = {
					scaleID = scaleKey,
					scaleName = defaultScaleName
				}
			end
		end

		self:CreateOptions()

	elseif addon == "Blizzard_AzeriteUI" then
		-- Hook 'em & Cook 'em
		hooksecurefunc(_G.AzeriteEmpoweredItemUI, "UpdateTiers", delayedUpdate)
		--hooksecurefunc(_G.AzeriteEmpoweredItemUI, "Refresh", delayedUpdate)
		hooksecurefunc(_G.AzeriteEmpoweredItemUI, "OnItemSet", delayedUpdate)
		C_Timer.After(0, function() -- Fire on next frame instead of current frame
			delayedUpdate()
			_G.AzeriteEmpoweredItemUI:HookScript("OnShow", function()
				_setupStringAndEnableButton()
				delayedUpdate()
			end)
		end)
		self:HookAzeriteUI()

	elseif addon == "Blizzard_AzeriteEssenceUI" then
		-- Hook 'em & Cook 'em
		hooksecurefunc(_G.AzeriteEssenceUI, "RefreshMilestones", delayedUpdate)
		--hooksecurefunc(_G.AzeriteEssenceUI.EssenceList, "Update", delayedUpdate)
		hooksecurefunc(_G.AzeriteEssenceUI.EssenceList, "Refresh", delayedUpdate)
		--hooksecurefunc(_G.AzeriteEssenceUI.EssenceList, "CalculateScrollOffset", delayedUpdate)

		C_Timer.After(0, function() -- Fire on next frame instead of current frame
			delayedUpdate()
			_G.AzeriteEssenceUI:HookScript("OnShow", function()
				_setupStringAndEnableButton()
				delayedUpdate()
			end)
		end)
		self:HookAzeriteEssenceUI()
	end
end

function f:PLAYER_LOGIN(event)
	_activeSpec()

	if _G.AzeriteEmpoweredItemUI then
		self:HookAzeriteUI()
	end
end

function f:AZERITE_ITEM_POWER_LEVEL_CHANGED(event)
	Debug(event)

	delayedUpdate()
end

function f:AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED(event)
	Debug(event)

	delayedUpdate()
end

function f:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
	if not azeriteSlots[equipmentSlot] then return end
	Debug(event, equipmentSlot, hasCurrent)

	delayedUpdate()
end

function f:PLAYER_SPECIALIZATION_CHANGED(event, ...)
	--Debug(event, tostringall(...)) -- ... = unit == player always

	_activeSpec()

	if _G.AzeriteEmpoweredItemUI then
		_populateWeights()
	end

	delayedUpdate()
end

-- Config
function f:RefreshConfig()
	delayedUpdate()
	if n.treeGroup and n.treeGroup.tree then
		n.treeGroup.tree = _buildTree(n.treeGroup.tree)
		n.treeGroup:RefreshTree(true)

		local lastExists;
		for _, v in ipairs(n.treeGroup.tree) do
			if v.value == lastOpenScale then
				lastExists = true
			end
		end

		n.treeGroup:SelectByValue(lastExists and lastOpenScale or ADDON_NAME.."Import")
	end
end

function f:CreateOptions()
	if self.optionsFrame then return end

	-- Config showing in the Blizzard Options
	local blizzOptions = {
		type = "group",
		name = ADDON_NAME,
		order = 103,
		get = function(info) return cfg[ info[#info] ] end,
		set = function(info, value) cfg[ info[#info] ] = value; self:RefreshConfig(); end,
		args = {
			addonExplanation = {
				type = "description",
				name = NORMAL_FONT_COLOR_CODE .. L.Config_SettingsAddonExplanation .. FONT_COLOR_CODE_CLOSE,
				fontSize = "medium",
				width = "full",
				order = 0,
			},
			scoreExplanation = {
				type = "description",
				name = L.Config_SettingsScoreExplanation,
				width = "full",
				order = 10,
			},
			line = {
				type = "header",
				name = "",
				width = "full",
				order = 20,
			},
			reminder = {
				type = "description",
				name = L.Config_SettingsSavedPerChar,
				fontSize = "large",
				image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew", --"Interface\\DialogFrame\\DialogAlertIcon",
				width = "full",
				order = 30,
			},
			spacer1 = {
				type = "description",
				name = " ",
				width = "full",
				order = 40,
			},
			gEnable = {
				type = "group",
				name = _G.ENABLE,
				inline = true,
				order = 50,
				args = {
					enableTraits = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Enable_Traits .. FONT_COLOR_CODE_CLOSE,
						desc = format(L.Config_Enable_Traits_Desc, ADDON_NAME),
						descStyle = "inline",
						width = "full",
						order = 0,
					},
					enableEssences = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Enable_Essences .. FONT_COLOR_CODE_CLOSE,
						desc = format(L.Config_Enable_Essences_Desc, ADDON_NAME),
						descStyle = "inline",
						width = "full",
						order = 1,
					},
				},
			},
			spacer2 = {
				type = "description",
				name = " ",
				width = "full",
				order = 60,
			},
			gScales = {
				type = "group",
				name = L.Config_Scales_Title,
				inline = true,
				order = 70,
				args = {
					--[[
					scalesText = {
						type = "description",
						name = L.Config_Scales_Desc,
						fontSize = "medium",
						image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew", --"Interface\\DialogFrame\\DialogAlertIcon",
						width = "full",
						order = 0,
					},
					]]--
					onlyOwnClassDefaults = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Scales_OwnClassDefaultsOnly .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Scales_OwnClassDefaultsOnly_Desc,
						descStyle = "inline",
						width = "full",
						--order = 1,
						order = 0,
					},
					onlyOwnClassCustoms = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Scales_OwnClassCustomsOnly .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Scales_OwnClassCustomsOnly_Desc,
						descStyle = "inline",
						width = "full",
						order = 1,
					},
				},
			},
			spacer3 = {
				type = "description",
				name = " ",
				width = "full",
				order = 80,
			},
			gImport = {
				type = "group",
				name = L.Config_Importing_Title,
				inline = true,
				order = 90,
				args = {
					importingCanUpdate = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Importing_ImportingCanUpdate .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Importing_ImportingCanUpdate_Desc,
						descStyle = "inline",
						width = "full",
						order = 0,
					},
					importingUpgrade_Desc = {
						type = "description",
						name = GRAY_FONT_COLOR_CODE .. L.Config_Importing_ImportingCanUpdate_Desc_Clarification .. FONT_COLOR_CODE_CLOSE,
						fontSize = "medium",
						image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertOther",
						width = "full",
						order = 1,
					},
				},
			},
			spacer4 = {
				type = "description",
				name = " ",
				width = "full",
				order = 100,
			},
			gEditor = {
				type = "group",
				name = L.Config_WeightEditor_Title,
				inline = true,
				order = 110,
				args = {
					editorText = {
						type = "description",
						name = L.Config_WeightEditor_Desc,
						fontSize = "medium",
						image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew", --"Interface\\DialogFrame\\DialogAlertIcon",
						width = "full",
						order = 0,
					},
					defensivePowers = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowDefensive .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_WeightEditor_ShowDefensive_Desc,
						descStyle = "inline",
						width = "full",
						order = 1,
					},
					rolePowers = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowRole .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_WeightEditor_ShowRole_Desc,
						descStyle = "inline",
						width = "full",
						order = 2,
					},
					rolePowersNoOffRolePowers = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowRolesOnlyForOwnSpec .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc,
						descStyle = "inline",
						width = "full",
						order = 3,
					},
					zonePowers = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowZone .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_WeightEditor_ShowZone_Desc,
						descStyle = "inline",
						width = "full",
						order = 4,
					},
					zonePowers_Desc = {
						type = "description",
						name = GRAY_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowZone_Desc_Proc .. FONT_COLOR_CODE_CLOSE,
						fontSize = "medium",
						image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertOther",
						width = "full",
						order = 5,
					},
					professionPowers = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowProfession .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_WeightEditor_ShowProfession_Desc,
						descStyle = "inline",
						width = "full",
						order = 6,
					},
					pvpPowers = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowPvP .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_WeightEditor_ShowPvP_Desc,
						descStyle = "inline",
						width = "full",
						order = 7,
					},
					pvpPowers_Desc = {
						type = "description",
						name = GRAY_FONT_COLOR_CODE .. L.Config_WeightEditor_ShowPvP_Desc_Import .. FONT_COLOR_CODE_CLOSE,
						fontSize = "medium",
						image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertOther",
						width = "full",
						order = 8,
					},
				},
			},
			spacer5 = {
				type = "description",
				name = " ",
				width = "full",
				order = 120,
			},
			gScore = {
				type = "group",
				name = L.Config_Score_Title,
				inline = true,
				order = 130,
				args = {
					addILvlToScore = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_AddItemLevelToScore .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Score_AddItemLevelToScore_Desc,
						descStyle = "inline",
						width = "full",
						order = 0,
					},
					scaleByAzeriteEmpowered = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. format(L.Config_Score_ScaleByAzeriteEmpowered, GetSpellInfo(263978) or "Azerite Empowered") .. FONT_COLOR_CODE_CLOSE,
						desc = format(L.Config_Score_ScaleByAzeriteEmpowered_Desc, NORMAL_FONT_COLOR_CODE .. (GetSpellInfo(263978) or "Azerite Empowered") .. FONT_COLOR_CODE_CLOSE),
						descStyle = "inline",
						width = "full",
						order = 1,
					},
					addPrimaryStatToScore = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_AddPrimaryStatToScore .. FONT_COLOR_CODE_CLOSE,
						desc = format(L.Config_Score_AddPrimaryStatToScore_Desc, _G.ITEM_MOD_AGILITY_SHORT, _G.ITEM_MOD_INTELLECT_SHORT, _G.ITEM_MOD_STRENGTH_SHORT),
						descStyle = "inline",
						width = "full",
						order = 2,
					},
					relativeScore = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_RelativeScore .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Score_RelativeScore_Desc,
						descStyle = "inline",
						width = "full",
						order = 3,
					},
					showOnlyUpgrades = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_ShowOnlyUpgrades .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Score_ShowOnlyUpgrades_Desc,
						descStyle = "inline",
						width = "full",
						order = 4,
					},
					showTooltipLegend = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_ShowTooltipLegend .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Score_ShowTooltipLegend_Desc,
						descStyle = "inline",
						width = "full",
						order = 5,
					},
					outlineScores = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_OutlineScores .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Score_OutlineScores_Desc,
						descStyle = "inline",
						width = "full",
						order = 6,
					},
					preferBiSMarjor = {
						type = "toggle",
						name = NORMAL_FONT_COLOR_CODE .. L.Config_Score_PreferBiSMajor .. FONT_COLOR_CODE_CLOSE,
						desc = L.Config_Score_PreferBiSMajor_Desc,
						descStyle = "inline",
						width = "full",
						order = 7,
					},
				},
			},
		},
	}

	ACR:RegisterOptionsTable(ADDON_NAME.."BlizzInfo", blizzOptions, false)
	self.optionsFrame = ACD:AddToBlizOptions(ADDON_NAME.."BlizzInfo", ADDON_NAME)
end

-- Slash
SLASH_AZERITEPOWERWEIGHTS1 = "/azerite"
if L.Slash_Command and L.Slash_Command ~= "/azerite" then
	SLASH_AZERITEPOWERWEIGHTS2 = L.Slash_Command
end

local SlashHandlers = {
	["debug"] = function() -- Debug stuff
		cfg.debug = not cfg.debug
		Print("Debug:", cfg.debug)
	end,
	["reset"] = function()
		wipe(AzeritePowerWeightsDB)

		f:ADDON_LOADED("ADDON_LOADED", ADDON_NAME)
		if n.treeGroup and n.treeGroup.tree then
			n.treeGroup.tree = _buildTree(n.treeGroup.tree)
			n.treeGroup:SelectByValue(ADDON_NAME.."Import")
			n.treeGroup:RefreshTree(true)
		end
		--ReloadUI()
	end,
	["ticket"] = function()
		local text = ("%s %s/%d/%s (%s)\nSettings: Locale: %s"):format(ADDON_NAME, GetAddOnMetadata(ADDON_NAME, "Version"), C_CVar.GetCVar("scriptErrors"), cfg.specScales[playerSpecID].scaleName or L.ScaleName_Unknown, cfg.specScales[playerSpecID].scaleID, GetLocale() or "n/a")
		--local first = true
		local skip = {
			["debug"] = true,
			["enableTraits"] = false,
			["enableEssences"] = false,
			["onlyOwnClassDefaults"] = false,
			["onlyOwnClassCustoms"] = false,
			["importingCanUpdate"] = true,
			["defensivePowers"] = false,
			["rolePowers"] = false,
			["rolePowersNoOffRolePowers"] = false,
			["zonePowers"] = false,
			["professionPowers"] = false,
			["pvpPowers"] = false,
			["addILvlToScore"] = true,
			["scaleByAzeriteEmpowered"] = true,
			["addPrimaryStatToScore"] = true,
			["relativeScore"] = true,
			["showOnlyUpgrades"] = true,
			["showTooltipLegend"] = true,
			["outlineScores"] = true,
			["preferBiSMarjor"] = false,
			["specScales"] = true,
			["tooltipScales"] = true
		}
		for key, _ in pairs(charDefaults) do
			if not skip[key] then
				--if first then
				--	first = false
				--	text = text .. ("%s: %s"):format(key, tostring(cfg[key]))
				--else
					text = text .. (", %s: %s"):format(key, tostring(cfg[key]))
				--end
			end
		end
		if n.Tstring then
			text = text .. ("\nTString: %s, %s"):format(tostring(select(2, n.Tstring:GetPoint()):GetParent():GetParent():GetName()), tostring(n.Tstring:IsShown()))
			text = text .. ("\nTButton: %s, %s, %s/%s, %s/%s"):format(tostring(n.TenableButton.frame:GetParent():GetParent():GetName() or n.TenableButton.frame:GetParent():GetParent():GetParent():GetName()), tostring(n.TenableButton.frame:IsShown()), tostring(n.TenableButton.frame:GetFrameStrata()), tostring(n.TenableButton.frame:GetParent():GetFrameStrata()), tostring(n.TenableButton.frame:GetFrameLevel()), tostring(n.TenableButton.frame:GetParent():GetFrameLevel()))
		else
			text = text .. ("\nNo Tstring / TButton")
		end
		if n.Estring then
			text = text .. ("\nEString: %s, %s"):format(tostring(select(2, n.Estring:GetPoint()):GetParent():GetName()), tostring(n.Estring:IsShown()))
			text = text .. ("\nEButton: %s, %s, %s/%s, %s/%s"):format(tostring(n.EenableButton.frame:GetParent():GetParent():GetName() or n.EenableButton.frame:GetParent():GetParent():GetParent():GetName()), tostring(n.EenableButton.frame:IsShown()), tostring(n.EenableButton.frame:GetFrameStrata()), tostring(n.EenableButton.frame:GetParent():GetFrameStrata()), tostring(n.EenableButton.frame:GetFrameLevel()), tostring(n.EenableButton.frame:GetParent():GetFrameLevel()))
		else
			text = text .. ("\nNo Estring / EButton")
		end
		text = text .. ("\nTrait Scores:\nLoaded: %s, Editor: %s"):format(tostring(traitStack.loading), tostring(traitStack.editor))
		if traitStack.scoreData then
			text = text .. ("\nC/P/M: %s / %s / %s"):format(tostring(traitStack.scoreData.current), tostring(traitStack.scoreData.potential), tostring(traitStack.scoreData.maximum))
			text = text .. "\nNumbers:"
			for _, v in ipairs(traitStack.scoreData) do
				if string.find(v, RED_FONT_COLOR_CODE) then
					v = v .. "R"
				elseif string.find(v, GRAY_FONT_COLOR_CODE) then
					v = v .. "G"
				end

				text = text .. ("\n   %s"):format(tostring(v))
			end
		end
		text = text .. ("\nEssence Scores:\nLoaded: %s, Editor: %s"):format(tostring(essenceStack.loading), tostring(essenceStack.editor))
		if essenceStack.scoreData then
			text = text .. ("\nC/P/M/Slots: %s / %s / %s / %s"):format(tostring(essenceStack.scoreData.current), tostring(essenceStack.scoreData.potential), tostring(essenceStack.scoreData.maximum), tostring(essenceStack.scoreData.slots))
			text = text .. "\nNumbers:"
			for _, v in ipairs(essenceStack.scoreData) do
				if string.find(v, RED_FONT_COLOR_CODE) then
					v = v .. "R"
				elseif string.find(v, GRAY_FONT_COLOR_CODE) then
					v = v .. "G"
				end

				text = text .. ("\n   %s"):format(tostring(v))
			end
		end

		if essenceStack.math then
			text = text .. "\nEssence Math:"
			for _, v in ipairs(essenceStack.math) do
				text = text .. ("\n   %s"):format(tostring(v))
			end
		end

		local frame = AceGUI:Create("Frame")
		frame:SetTitle(ADDON_NAME)
		frame:SetStatusText(L.Debug_CopyToBugReport)
		frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
		frame:SetLayout("Fill")

		local editbox = AceGUI:Create("MultiLineEditBox")
		editbox:SetLabel("")
		editbox:DisableButton(true)
		editbox:SetText(text)
		editbox:SetFocus()
		editbox:HighlightText(0, strlen(text))

		frame:AddChild(editbox)
	end,
	["tt"] = function(...) -- Get tooltip stuff
		local text = string.format("> START\n- - - - - - - - - -\nVer. %s\nClass/Spec: %s / %s\nScale: %s (%s)\n- - - - - - - - - -\n", GetAddOnMetadata(ADDON_NAME, "Version"), playerClassID, playerSpecID, cfg.specScales[playerSpecID].scaleName or L.ScaleName_Unknown, cfg.specScales[playerSpecID].scaleID)

		text = text .. string.format("Score settings:\naddILvlToScore: %s\nscaleByAzeriteEmpowered: %s\naddPrimaryStatToScore: %s\nrelativeScore: %s\nshowOnlyUpgrades: %s\nshowTooltipLegend: %s\n- - - - - - - - - -\n", tostring(cfg.addILvlToScore), tostring(cfg.scaleByAzeriteEmpowered), tostring(cfg.addPrimaryStatToScore), tostring(cfg.relativeScore), tostring(cfg.showOnlyUpgrades), tostring(cfg.showTooltipLegend))

		if tooltipTable.itemLink then
			local _, id = strsplit(":", tooltipTable.itemLink)
			local itemID = tonumber(id) or -1

			text = text .. string.format("HoA level: %s\n\nTooltip:\nItem: %s (%s)\nItemlink: %s\nEffective ilvl: %d\nTraits and scores:\n", tooltipTable.currentLevel or "", tooltipTable.itemLink or "", itemID, string.gsub(tooltipTable.itemLink or "", "\124", "\124\124"), tooltipTable.scores and tooltipTable.scores.effectiveILvl or -1)

			for i, v in ipairs(tooltipTable) do
				text = text .. string.format("> Scale %d: %s\n", i, v.tooltipScale)

				for tierIndex, w in ipairs(v) do
					text = text .. string.format("   T%d (%d):\n     ", tierIndex, w.unlockLevel or -1)

					for azeritePowerID, score in pairs(w) do
						if type(azeritePowerID) == "number" then -- skip "unlockLevel"
							text = text .. string.format(" %d = %s ", azeritePowerID, tostring(score or -1))
						end
					end

					text = text .. "\n"
				end

				if tooltipTable.scores then
					text = text .. string.format("\nTrait Score: %s / %s / %s\n\n" , tostring(tooltipTable.scores[i].traitScore or ""), tostring(tooltipTable.scores[i].traitPotential or ""), tostring(tooltipTable.scores[i].traitMax or ""))

					if cfg.addILvlToScore then
						text = text .. string.format("Ilvl Score: %s / %s / %s\nMiddle Trait: %s (%d)\n\n" , tostring(tooltipTable.scores[i].ilvlScore or ""), tostring(tooltipTable.scores[i].ilvlPotential or ""), tostring(tooltipTable.scores[i].ilvlMax or ""), tostring(tooltipTable.scores[i].middleTraitValue or ""), tooltipTable.scores[i].midTrait or -1)
					end

					if cfg.addPrimaryStatToScore then
						text = text .. string.format("Stat Score: %s / %s / %s\nStat value: %d\n\n" , tostring(tooltipTable.scores[i].statScore or ""), tostring(tooltipTable.scores[i].statPotential or ""), tostring(tooltipTable.scores[i].statMax or ""), tooltipTable.scores[i].statAmount or -1)
					end
				end
			end
			text = text .. "- - - - - - - - - -\n"
		end

		if tooltipTable.equippedItemLink then
			if tooltipTable.itemLink and tooltipTable.itemLink ~= tooltipTable.equippedItemLink then
				local _, eid = strsplit(":", tooltipTable.equippedItemLink)
				local eItemID = tonumber(eid) or -1

				text = text .. string.format("Equipped for relative scores:\nItem: %s (%s)\nItemlink: %s\nEffective ilvl: %d\nTraits and scores:\n", tooltipTable.equippedItemLink or "", eItemID, string.gsub(tooltipTable.equippedItemLink or "", "\124", "\124\124"), tooltipTable.equippedEffectiveILvl or -1)

				for i, v in ipairs(tooltipTable) do
					text = text .. string.format("> Scale %d: %s\n", i, v.tooltipScale)

					if tooltipTable.scores then
						text = text .. string.format("Trait Score: %s / %s / %s\n\n" , tostring(tooltipTable.scores[i].relTraitScore or ""), tostring(tooltipTable.scores[i].relTraitPotential or ""), tostring(tooltipTable.scores[i].relTraitMax or ""))

						if cfg.addILvlToScore then
							text = text .. string.format("Ilvl Score: %s / %s / %s\nMiddle Trait: %s (%d)\n\n" , tostring(tooltipTable.scores[i].relIlvlScore or ""), tostring(tooltipTable.scores[i].relIlvlPotential or ""), tostring(tooltipTable.scores[i].relIlvlMax or ""), tostring(tooltipTable.scores[i].relMiddleTraitValue or ""), tooltipTable.scores[i].relMidTrait or -1)
						end

						if cfg.addPrimaryStatToScore then
							text = text .. string.format("Stat Score: %s / %s / %s\nStat value: %d\n\n" , tostring(tooltipTable.scores[i].relStatScore or ""), tostring(tooltipTable.scores[i].relStatPotential or ""), tostring(tooltipTable.scores[i].relStatMax or ""), tooltipTable.scores[i].relStatAmount or -1)
						end
					end
				end
			elseif not tooltipTable.itemLink then
				text = text .. "Equipped for relative scores:\nItem: Not found!\n"
			else
				text = text .. "Equipped for relative scores:\nItem: Same as in tooltip!\n"
			end

			text = text .. "- - - - - - - - - -\n"
		end

		text = text .. "> END"

		local frame = AceGUI:Create("Frame")
		frame:SetTitle(ADDON_NAME)
		frame:SetStatusText(L.Debug_CopyToBugReport)
		frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
		frame:SetLayout("Fill")

		local editbox = AceGUI:Create("MultiLineEditBox")
		editbox:SetLabel("")
		editbox:DisableButton(true)
		editbox:SetText(text)
		editbox:SetFocus()
		editbox:HighlightText(0, strlen(text))

		frame:AddChild(editbox)
	end,
	["is"] = function()
		local text = string.join("\n", ("> START\nVer. %s"):format(GetAddOnMetadata(ADDON_NAME, "Version")), unpack(importStack))

		local frame = AceGUI:Create("Frame")
		frame:SetTitle(ADDON_NAME)
		frame:SetStatusText(L.Debug_CopyToBugReport)
		frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
		frame:SetLayout("Fill")

		local editbox = AceGUI:Create("MultiLineEditBox")
		editbox:SetLabel("")
		editbox:DisableButton(true)
		editbox:SetText(text)
		editbox:SetFocus()
		editbox:HighlightText(0, strlen(text))

		frame:AddChild(editbox)
	end,
	["bang"] = function(...)
		local number = tonumber(...)
		Print("Bang:", number)
	end,
	["data"] = function()
		Print("Data check start")
		local numSpecs = {
			--		Base count		Healing
			--			TMI/Heal Off		Missing
			[1] =	3	+	1	-	0	-	0, -- Warrior (+1 for TMI)
			[2] =	3	+	1	-	1	-	0, -- Paladin (+1 for TMI, -1 for Holy)
			[3] =	3	+	0	-	0	-	0, -- Hunter
			[4] =	3	+	0	-	0	-	0, -- Rogue
			[5] =	3	+	0	-	1	-	0, -- Priest (-1 for Disc)
			[6] =	3	+	1	-	0	-	0, -- Death Knight (+1 for TMI)
			[7] =	3	+	1	-	1	-	0, -- Shaman (+1 for Resto Off, -1 for Resto)
			[8] =	3	+	0	-	0	-	0, -- Mage
			[9] =	3	+	0	-	0	-	0, -- Warlock
			[10] =	3	+	1	-	1	-	0, -- Monk (+1 for TMI, -1 for MW)
			[11] =	4	+	1	-	1	-	0, -- Druid (+1 for TMI, -1 for Resto)
			[12] =	2	+	1	-	0	-	0, -- Demon Hunter (+1 for TMI)
		}
		--[[
			Holy Paladin
			Disc Priest
			---Holy Priest---
			Restoratio Shaman
			Mistweaver Monk
			Restoration Druid
			---
		]]--
		local emptySpecs = 5
		for _, v in ipairs(n.defaultScalesData) do
			if next(v[4]) or next(v[5]) then -- Check for not empty scales
				numSpecs[v[2]] = numSpecs[v[2]] - 1
			else
				emptySpecs = emptySpecs - 1
			end
		end
		for k, v in ipairs(numSpecs) do
			if v ~= 0 then
				Print("!!!", k, v)
			end
		end
		if emptySpecs ~= 0 then
			Print("Empty specs:", emptySpecs)
		end
		Print("Data check end")
	end,
	["test"] = function(...) -- To test new features
		Print("TEST")
	end,
}

local shouldKnowAboutConfig
SlashCmdList["AZERITEPOWERWEIGHTS"] = function(text)
	local command, params = strsplit(" ", text, 2)

	if SlashHandlers[command] then
		SlashHandlers[command](params)
	else
		if not shouldKnowAboutConfig then
			Print(L.Slash_RemindConfig, ADDON_NAME)
			shouldKnowAboutConfig = true
		end
		if not n.guiContainer then
			if not _G.AzeriteEmpoweredItemUI then
				local loaded, reason = LoadAddOn("Blizzard_AzeriteUI")
				if loaded then
					_toggleEditorUI()
				else
					Print(L.Slash_Error_Unkown)
					Debug(reason)
				end
			end
		else
			_toggleEditorUI()
		end
	end
end

--#EOF
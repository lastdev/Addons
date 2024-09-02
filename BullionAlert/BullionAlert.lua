local addon, ns 			= ...
local f 					= CreateFrame("Frame")
local itemString 			= "Bullion"
local itemID 				= 3010
local sparkID				= 2800
local firstCheer 			= 540070 -- specific dwarf woo -- PlaySoundFile(fileid)
local secondCheer 			= 169957 -- kultiran cheer -- PlaySound(soundid)
--local secondcheer 		= 187694 -- legion legendary loot sound
local soundChannel 			= "Master"
local chatMessageColor 		= BLUE_FONT_COLOR
local altMessageColor 		= YELLOW_FONT_COLOR
local chatOutputFrame 		= SELECTED_CHAT_FRAME
local printStatus 			= true
local instanceOnly 			= true
local levelCap 				= 70
local playerName 			= UnitName("player")
local db 					= {}
local defaults 				= {}

local function isEmpty(t)
	return next(t) == nil
end

local function dumptable(tt, indent)
	local done = {}
	indent = 0 or 0
	if type(tt) == "table" then
		for key, value in pairs(tt) do
			print(string.rep(" ", indent))
			if type(value) == "table" and not done[value] then
				done[value] = true
				print(string.format("[%s] => table\n", tostring(key)))
				print(string.rep(" ", indent + 4))
				print("(\n")
				dumptable(value, indent + 7, done)
				print(string.rep(" ", indent + 4))
				print(")\n")
			else
				print(string.format("[%s] => %s %s\n", tostring(key), tostring(value), tostring(type(value))))
			end
		end
	else
		print(tt .. "\n")
	end
end

local function printf(...)
	local msg = tostring(...)
	local colorString = chatMessageColor:WrapTextInColorCode(msg)
	chatOutputFrame:AddMessage(colorString)
end

local function printm(...)
	local msg = tostring(...)
	local colorString = altMessageColor:WrapTextInColorCode(msg)
	chatOutputFrame:AddMessage(colorString)
end

local function checkSavedVariables()
	if BullionAlertDB == nil or isEmpty(BullionAlertDB) then
		BullionAlertDB = {}
		for key, value in pairs(defaults) do
			BullionAlertDB[key] = value
		end
		printf(addon .. " created new defaults.")
	end
	db = BullionAlertDB
end

local function bullionUpdate()
	local playerLevel = UnitLevel("player")
	if playerLevel < levelCap then return end
	local bullion = C_CurrencyInfo.GetCurrencyInfo(itemID)
	if playerLevel == levelCap then
		db[playerName] = bullion.totalEarned
	end
	printf(playerName.. " has earned " .. bullion.totalEarned .. " of " .. bullion.maxQuantity .. " possible bullion drops.(/ba)")
end

local function sparkUpdate()
	local playerLevel = UnitLevel("player")
	if playerLevel < levelCap then return end
	local spark = C_CurrencyInfo.GetCurrencyInfo(sparkID)
	printf(playerName.. " has collected " .. spark.totalEarned .. " of " .. spark.maxQuantity .. " possible sparks.")
end

local function bullionStatus()
	local playerLevel = UnitLevel("player")
	local bullion = C_CurrencyInfo.GetCurrencyInfo(itemID)
	if playerLevel == levelCap then
		db[playerName] = bullion.totalEarned
	end
	--printf ("Total available this season (".. bullion.maxQuantity + 4 .. ").")
	printf ("Max Bullion from raids (".. bullion.maxQuantity .. "). (/ba s for sparks)")
	for key, value in pairs(db) do
	local mark = " <="
	if tostring(key) ~= playerName then mark = "" end
		if value < bullion.maxQuantity then
			printm(key .. " : " .. value .. mark)
		else
			printf(key .. " : " .. value .. mark)
		end
	end
end

local function lootOpened()
	local itemCount = GetNumLootItems()
	for slot = itemCount, 1, -1 do
		local slotType = GetLootSlotType(slot)
		if slotType == Enum.LootSlotType.Item then
			--local lootIcon, lootName, lootQuantity, currencyID, lootQuality, locked, isQuestItem, questID, isActive = GetLootSlotInfo(slot)
			local _, lootName, _, _, _, _, _, _, _ = GetLootSlotInfo(slot)
			if string.match(lootName, itemString) then
				LootSlot(slot)
				PlaySoundFile(firstCheer, soundChannel)
				PlaySound(secondCheer, soundChannel)
				bullionUpdate()
			end
		end
	end
end

local function OnEvent(self, event, id, ...)
	if event == "QUEST_TURNED_IN" and (id == 80386 or id == 80388 or id == 80385) then
		bullionUpdate()
	elseif event == "PLAYER_LOGIN" and printStatus then -- PLAYER_LOGIN
		checkSavedVariables()
		bullionUpdate()
	else -- LOOT_OPENED
		--print("loot event")
		if instanceOnly then -- instanced loot
			local inInstance = IsInInstance()
			if inInstance then
				lootOpened()
			end
		else
			lootOpened()
		end
	end
end

local function slashHandler(msg)
	if msg == "help" or msg == "h" then
		printf("-")
		printf(addon .. " commands:")
		printf("-")
		printf("/ba help, h - Show the options panel.")
		printf("/ba spark, s - Show spark output.")
		printf("/ba version, v - Show the addon version.")
		printf("/ba reset, r - Reset all saved variables.")
		printf("/ba dump, d - Dump saved variables to chat.")
		return false
	elseif msg == "reset" or msg == "r" then
		dumptable(BullionAlertDB)
		wipe(BullionAlertDB)
		printf(addon .. " saved variables were reset.")
		checkSavedVariables()
		return true
	elseif msg == "dump" or msg == "d" then
		dumptable(BullionAlertDB)
		return true
	elseif msg == "version" or msg == "v" then
		local version = C_AddOns.GetAddOnMetadata(tostring(addon), "version")
		printf(addon .. " v." .. version)
		return true
	elseif msg == "spark" or msg == "s" then
		sparkUpdate()
		return true
	else
		bullionStatus()
		return true
	end
end
SLASH_BULLIONALERT1 = "/ba"
SlashCmdList.BULLIONALERT = slashHandler

f:SetScript("OnEvent", OnEvent)
f:RegisterEvent("LOOT_OPENED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("QUEST_TURNED_IN")

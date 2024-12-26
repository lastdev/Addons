local ADDON_NAME, L = ...

local fullName
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

ChatSoundCustomizer = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0")
ChatSoundCustomizer.title = GetAddOnMetadata(ADDON_NAME, "Title")

ChatSoundCustomizer.eventsSoundTable = {
	-- Guild
	["CHAT_MSG_OFFICER"] = "CSC Sound 1",
	["CHAT_MSG_GUILD"] = "CSC Sound 1",

	-- Whisper
	["CHAT_MSG_WHISPER"] = "CSC Sound 8",
	["CHAT_MSG_BN_WHISPER"] = "CSC Sound 8",

	-- Party (group or /p)
	["CHAT_MSG_PARTY"] = "CSC Sound 3",
	["CHAT_MSG_PARTY_LEADER"] = "CSC Sound 3",

	-- Communities
	["CHAT_MSG_COMMUNITIES_CHANNEL"] = "CSC Sound 4",

	-- Raid and Instances
	["CHAT_MSG_RAID"] = "CSC Sound 5",
	["CHAT_MSG_RAID_LEADER"] = "CSC Sound 5",
	["CHAT_MSG_INSTANCE_CHAT"] = "CSC Sound 5",
	["CHAT_MSG_INSTANCE_CHAT_LEADER"] = "CSC Sound 5",

	-- Say
	["CHAT_MSG_SAY"] = "None",

	-- Yell
	["CHAT_MSG_YELL"] = "None",

	-- Emotes
	["CHAT_MSG_EMOTE"] = "None",
}

function ChatSoundCustomizer:OnInitialize()
	local defaults = { profile = {
		sounds = self.eventsSoundTable,
		channel = "Master",
		soundsOut = {},
		throttling = 1000
	}}
	self.db = LibStub("AceDB-3.0"):New("ChatSoundCustomizerDB", defaults, "Default")
	self.options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.options.args.profile.order = -1

	for event, _ in pairs(ChatSoundCustomizer.eventsSoundTable) do
		self:RegisterEvent(event, "PlaySound")
	end

	local AceConfig = LibStub("AceConfig-3.0")
	AceConfig:RegisterOptionsTable(ADDON_NAME, self.options, { "csc", "chatsound" })

	local AceDialog = LibStub("AceConfigDialog-3.0")
	self.optionsFrame = AceDialog:AddToBlizOptions(ADDON_NAME)
end

function ChatSoundCustomizer:OnEnable()
	local myName, myRealm = UnitFullName("Player")
	fullName = myName .. "-" .. myRealm
end

local priorityCache
function ChatSoundCustomizer:IterateModulesByPriority()
	if not priorityCache then
		priorityCache = {}
		priorityCache.table = {}
		priorityCache.index = {}
		local last = 1000000
		for _, module in self:IterateModules() do
			local priority = module.priority
			if (not priority) then error("The module " .. module:GetName() .. " needs a priority property!") end
			if (priorityCache.table[priority]) then error("duplicated priority registered!") end
			if (priority == -1) then
				priority = last
				last = last + 1
			end
			priorityCache.table[priority] = module
			table.insert(priorityCache.index, priority)
		end
		table.sort(priorityCache.index)
	end

	local i = 0
	return function()
		i = i + 1
		local priority = priorityCache.index[i]
		if priority then
			return priority, priorityCache.table[priority]
		end
	end
end

function ChatSoundCustomizer:ShouldIgnoreEvent(event, text, playerName, ...)
	for _, module in self:IterateModulesByPriority() do
		if module.ShouldIgnoreEvent and module:ShouldIgnoreEvent(event, text, playerName, ...) then
			return true
		end
	end
end

function ChatSoundCustomizer:PlaySound(event, text, playerName, ...)
	if self:ShouldIgnoreEvent(event, text, playerName, ...) then return end

	for _, module in self:IterateModulesByPriority() do
		if module.PlaySound and module:PlaySound(event, text, playerName, ...) then
			return
		end
	end

	local sound
	if self:IsOutput(playerName) then
		sound = self.db.profile.soundsOut[event]
	else
		sound = self.db.profile.sounds[event]
	end

	if sound and sound ~= "None" then
		self:PlaySoundThrottle(event, sound)
		return
	end

end

function ChatSoundCustomizer:IsOutput(playerName)
	return playerName == fullName
end

local function GetDbFromPath(paths)
	local db = paths[1]
	local key = paths[2]
	for i = 2, #paths - 1 do
		db = db[key]
		key = paths[i + 1]
	end
	return db, key
end

function ChatSoundCustomizer:CreateSoundAceOption(name, order, dbPath)
	return {
		type = "select",
		name = name,
		width = "full",
		values = LibStub("LibSharedMedia-3.0"):List("sound"),
		set = function(info, val)
			local db, key = GetDbFromPath(dbPath)
			db[key] = info.option.values[val]
		end,
		get = function(info)
			local db, key = GetDbFromPath(dbPath)
			local selected = db[key] or "None"
			for i, v in ipairs(info.option.values) do
				if selected == v then return i end
			end
		end,
		order = order,
		dialogControl = "Eliote-LSMSound"
	}
end

local throttle = {}
function ChatSoundCustomizer:PlaySoundThrottle(tag, sound)
	local time = GetTime()
	local minDelay = ChatSoundCustomizer.db.profile.throttling / 1000.0
	if not throttle[tag] or (throttle[tag] + minDelay) <= time then
		throttle[tag] = time
		PlaySoundFile(AceGUIWidgetLSMlists.sound[sound], ChatSoundCustomizer.db.profile.channel or "Master")
	end
end

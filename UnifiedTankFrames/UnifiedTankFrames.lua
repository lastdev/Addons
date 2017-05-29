local pairs = _G.pairs
local type = _G.type
local InCombatLockdown = _G.InCombatLockdown
local GetNumGroupMembers = _G.GetNumGroupMembers
local GetNumSubgroupMembers = _G.GetNumSubgroupMembers
local IsInRaid = _G.IsInRaid

local a = CreateFrame("Frame")
_G.UnifiedTankFrames = a
a:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
a:RegisterEvent("ADDON_LOADED")
a.name = "UnifiedTankFrames"

-- default config values
local g_config = {
	showRaid = true,
	showParty = false,
	showSolo = false,
	printInfo = false,
}

-- global runtime helper variables
local g_sources = {} -- holds available tank sources (modules)
local g_events = {} -- registered events to handle and handler function pointers
local g_update_pending = false -- if true, a one time full update of tank frames will be processed after player leaves combat

SLASH_UNIFIEDTANKFRAMES1 = '/utf'
SlashCmdList["UNIFIEDTANKFRAMES"] = function(input, editbox) 
	local args = {strsplit(" ", strtrim(input))}
	if args[1] == "u" or args[1] == "update" then
		a:ClearTanks()
		for name, source in pairs(g_sources) do
			if source.onReSync and type(source.onReSync) == "function" then
				source.onReSync(source, a)
			end
		end
		a:UpdateTankFrames()
		if InCombatLockdown() then
			print(NORMAL_FONT_COLOR_CODE.."UnifiedTankFrames"..FONT_COLOR_CODE_CLOSE..": Updating tank frames. You are in combat, tank changes may not show up before you leave combat.")
			g_update_pending = true
		else
			print(NORMAL_FONT_COLOR_CODE.."UnifiedTankFrames"..FONT_COLOR_CODE_CLOSE..": Updating tank frames.")
		end
    elseif args[1] == "c" or args[1] == "center" then
        a.frames.mover:ClearAllPoints()
        a.frames.mover:SetPoint("CENTER")
        a:UpdateTankFrames()
        print(NORMAL_FONT_COLOR_CODE.."UnifiedTankFrames"..FONT_COLOR_CODE_CLOSE..": Initiated screen positon reset to center.")
    else
		if InCombatLockdown() then
			print(NORMAL_FONT_COLOR_CODE.."UnifiedTankFrames"..FONT_COLOR_CODE_CLOSE..": Called /utf while in combat. Please leave combat and try again.")
		else
			a:UpdateTankFrames()
			InterfaceOptionsFrame_OpenToCategory("UnifiedTankFrames")
		end
	end
end

function a:print(...)
	if self.db.printInfo then
		print(NORMAL_FONT_COLOR_CODE.."UnifiedTankFrames"..FONT_COLOR_CODE_CLOSE..":", ...)
	end
end

function a:ADDON_LOADED(event, addon)
	if addon:lower() ~= "unifiedtankframes" then return end

	-- load config or set defaults
	if UnifiedTankFrames_Config ~= nil then
		self.db = UnifiedTankFrames_Config
	else
		self.db = {}
	end
	for k, v in pairs(g_config) do
		if type(self.db[k]) == "nil" then
			self.db[k] = v
		end
	end
	UnifiedTankFrames_Config = self.db

	self.tanks = {}
	
	if self.db.frames == nil then
		self.db.frames = {}
	end
	if self.db.sources == nil then
		self.db.sources = {}
	end
	
	if assert(self.frames, "No UnitTankFrames TankFrames found!") then
		self.db.frames[self.frames.name] = self.frames:InitFrames(self.db.frames[self.frames.name])
	end
	
	if assert(self.RegisterInterfaceOptions, "No UnitTankFrames Options found!") then
		self.RegisterInterfaceOptions()
	end
	
	-- get and initialize tank source modules
	if _G.UnifiedTankFrames_Sources and type (_G.UnifiedTankFrames_Sources) == "table" then
		g_sources = _G.UnifiedTankFrames_Sources
		local sourceInit, sourceEnable = false, false
		for name, source in pairs(g_sources) do
			if name ~= self.name then 
				-- create new config entry if not found
				if self.db.sources[name] == nil then
					self.db.sources[name] = {
						enabled = source.default,
						config = {},
					}
				end
				
				-- initialize the module
				if source.onInit and type(source.onInit) == "function" then
					sourceInit = source.onInit(source, self, self.db.sources[name].config)
					assert(sourceInit, "Init of UnitTankFrames source "..name.." failed!") 
				end
				
				-- if it's enabled via config then enable the module
				if sourceInit and self.db.sources[name].enabled and source.onEnable and type(source.onEnable) == "function" then
					sourceEnable = source.onEnable(source, self)
					assert(sourceEnable, "Enabling UnitTankFrames source "..name.." failed!") 
				end
			else
				error("A UnifiedTankFrames module with name '"..self.name.."' was found. This is not valid and the module was ignored!")
			end
		end	
	else
		error("UnifiedTankFrames_Sources not found or invalid!")
	end
	
	g_sources[self.name] = self
	self:RegisterEventHandler(self, "GROUP_ROSTER_UPDATE", a.UpdateTankFrames)
	self:RegisterEventHandler(self, "PLAYER_REGEN_ENABLED", a.RegenEnabled)
	
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end

function a:RegisterEventHandler(source, event, func)
	--print("register", source.name, event)
	-- register event and save event function
	if g_events[event] == nil then
		self:RegisterEvent(event)
		g_events[event] = {}
	end
	g_events[event][source.name] = func
	
	-- create event handler if not done yet
	if not self[event] then
		self[event] = function(self, event, ...)
			for name, func in pairs(g_events[event]) do
				func(g_sources[name], self, event, ...)
			end
		end
	end
end

function a:RegisterEventHandlers(source, list)
	for event, func in pairs(list) do
		self:RegisterEventHandler(source, event, func)
	end
end

function a:UnregisterEventHandler(source, event)
	--print("unregister", source.name, event)
	if g_events[event] and g_events[event][name] then
		-- remove from event handler list
		g_events[event][name] = nil
		
		-- check if this was the only handler, if so unregister the event
		local num = 0
		for _,_ in g_events[event] do
			num = num + 1
		end
		if num == 0 then
			g_events[event] = nil
			self:UnregisterEvent(event)
		end
	end
end

function a:UnregisterEventHandlers(source, list)
	for event, func in pairs(list) do
		self:UnregisterEventHandler(source, event, func)
	end
end

function a:AddTank(name, source, position) -- position is not used by now
	local num = 0
	local last = 0
	local new = nil
	
	-- is this tank already in our list?
	for pos, tank in pairs(self.tanks) do
		if type(tank) == "table" then
			if pos > last then
				last = pos
			end
			num = num + 1
			if tank.name == name then
				-- update or add given source
				tank.sources[source] = true
				new = tank
			end
		end
	end
	
	-- add to list if new
	if new == nil then
		self:print("AddTank:", name, source)
		
		-- get first free spot
		local pos = nil
		for i=1, last+1 do
			if pos == nil and (self.tanks[i] == nil or self.tanks[i] == false) then
				pos = i
			end
		end
		
		-- add new tank to the list
		self.tanks[pos] = {
			["name"] = name,
			["sources"] = {[source]=true},
		}
		
		-- update frames
		a:UpdateTankFrames()
	end
end

function a:RemoveTank(name, source)
	-- is there a tank with this name in our list?
	for pos, tank in pairs(self.tanks) do
		if type(tank) == "table" then
			if tank.name == name then
				-- remove given source
				tank.sources[source] = nil
				
				-- check if there are any other sources left
				local num = 0
				for _, _ in pairs(tank.sources) do
					num = num + 1
				end
				if num == 0 then
					-- no other sources found, remove tank
					self.tanks[pos] = false
					
					self:print("RemoveTank:", name, source)
					
					-- update frames
					a:UpdateTankFrames()
				end
				return
			end
		end
	end
end

function a:ClearTanks(source)
	--self:print("ClearTanks:", source)
	if source == nil then
		-- remove all
		self.tanks = {}
	else
		-- remove only those from given source
		for pos, tank in pairs(self.tanks) do
			if type(tank) == "table" then
				-- remove given source
				tank.sources[source] = nil
				
				-- check if there are any other sources left
				local num = 0
				for _, _ in pairs(tank.sources) do
					num = num + 1
				end
				if num == 0 then
					-- no other sources found, remove tank
					self.tanks[pos] = false
				end
			end
		end
	end
	
	-- update frames
	a:UpdateTankFrames()
end

function a:PrintTanks(pre)
	if pre then
		print(pre)
	end
	for pos, tank in pairs(self.tanks) do
		local sources = ""
		local num = 0
		if type(tank) == "table" then
			for source, value in pairs(tank.sources) do
				num = num + 1
				sources = source.." "..sources
			end
		end
		print(pos, tank.name..": "..sources, num)
	end
end

function a:UpdateTankFrames()
	if self.timeSinceLastUpdate == nil then
		self.timeSinceLastUpdate = 0
		self:SetScript("OnUpdate", function(self, elapsed)
			self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed
			if self.timeSinceLastUpdate > .7 then
				a:UpdateShowState()
				self.timeSinceLastUpdate = nil
				self:SetScript("OnUpdate", nil)
			end
		end)
	end
end

function a:UpdateShowState()
	-- if we are in combat set update flag and return
	if InCombatLockdown() then
		-- if we are in combat the frames might not update correctly, so set update flag to update again after combat
		g_update_pending = true
		return
	end
	if IsInRaid() then
		if self.db.showRaid then
			self.frames:TankUpdate(self.tanks)
		else
			self.frames:TankUpdate({})
		end
	elseif GetNumSubgroupMembers() > 0 then
		if self.db.showParty then
			self.frames:TankUpdate(self.tanks)
		else
			self.frames:TankUpdate({})
		end
	else
		if self.db.showSolo then
			self.frames:TankUpdate(self.tanks)
		else
			self.frames:TankUpdate({})
		end
	end
end

function a:RegenEnabled()
	-- if update flag is set do the job
	if g_update_pending then
		self:UpdateShowState()
	end
	g_update_pending = false
end
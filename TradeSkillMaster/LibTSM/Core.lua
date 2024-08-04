-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local ADDON_NAME = select(1, ...)
local TSM = select(2, ...) ---@class TSM
local LibTSMClass = LibStub("LibTSMClass")
local AddonSettings = TSM.LibTSMApp:Include("Lib.AddonSettings")
local private = {
	context = {},
	initOrder = {},
	loadOrder = {},
	frame = nil,
	gotAddonLoaded = false,
	gotPlayerLogin = false,
	gotPlayerLogout = false,
	startSystemTime = GetTimePreciseSec(),
	startTime = time(),
}



-- ============================================================================
-- Module Metatable
-- ============================================================================

---@class TSMModule
local MODULE_METHODS = {}

---Registers the function be called when the module is loaded.
---@protected
---@param func fun() The function to call
function MODULE_METHODS:OnModuleLoad(func)
	local context = private.context[self]
	assert(context and not context.moduleLoadFunc and not context.moduleLoadTime and type(func) == "function")
	context.moduleLoadFunc = func
end

---Registers the function be called with a settings object once available.
---@protected
---@param func fun(db: SettingsDB) The function to call
function MODULE_METHODS:OnSettingsLoad(func)
	local context = private.context[self]
	AddonSettings.RegisterOnLoad(context.path, func)
end

---Registers the function be called once game data is available.
---@protected
---@param func fun() The function to call
function MODULE_METHODS:OnGameDataLoad(func)
	local context = private.context[self]
	assert(context and not context.gameDataLoadFunc and not context.gameDataLoadTime and type(func) == "function")
	context.gameDataLoadFunc = func
end

---Registers the function be called when the module is unloaded.
---@protected
---@param func fun() The function to call
function MODULE_METHODS:OnModuleUnload(func)
	local context = private.context[self]
	assert(context and not context.moduleUnloadFunc and not context.moduleUnloadTime and type(func) == "function")
	context.moduleUnloadFunc = func
end

local MODULE_MT = {
	__index = MODULE_METHODS,
	__newindex = function(self, key, value)
		local context = private.context[self]
		assert(context and not MODULE_METHODS[key] and not context.moduleLoadTime)
		rawset(self, key, value)
	end,
	__metatable = false,
}



-- ============================================================================
-- Addon Object Functions
-- ============================================================================

---Creates a new TSM module.
---@generic T: TSMModule
---@param path `T` The name of the module
---@return T
function TSM.Init(path)
	assert(type(path) == "string")
	if private.context[path] then
		error("Module already exists for path: "..tostring(path))
	end
	local moduleObj = setmetatable({}, MODULE_MT)
	private.context[path] = {
		path = path,
		module = moduleObj,
		moduleLoadFunc = nil,
		moduleLoadTime = nil,
		gameDataLoadFunc = nil,
		gameDataLoadTime = nil,
		moduleUnloadFunc = nil,
		moduleUnloadTime = nil,
	}
	-- store a reference to the context by both the module object and the path
	private.context[moduleObj] = private.context[path]
	tinsert(private.initOrder, path)
	return moduleObj
end

---Returns an existing TSM module.
---@generic T
---@param path `T`
---@return T
function TSM.Include(path)
	local context = private.context[path]
	if not context then
		error("Module doesn't exist for path: "..tostring(path))
	end
	private.ProcessModuleLoad(path)
	return context.module
end

---Returns an iterator over all available modules.
---@return fun(): number, string, number, number, number, number # An iterator with fields: `index`, `path`, `loadTime`, `gameDataLoadTime`, `moduleUnloadTime`
function TSM.ModuleInfoIterator()
	return private.ModuleInfoIterator, nil, 0
end

---Unloads all modules to simulate a logout.
function TSM.DebugLogout()
	private.UnloadAll()
end

---Checks if LibTSM code has loaded.
---@return boolean
function TSM.IsLibTSMLoaded()
	return private.gotAddonLoaded
end

---Returns whether or not we're running a dev version.
---@return boolean
function TSM.IsDev()
	return TSM.LibTSMUtil.IsDevVersion()
end

---Returns whether or not we're running in a test environment.
---@return boolean
function TSM.IsTest()
	return TSM.LibTSMUtil.IsTestVersion()
end

---Gets the current addon version.
---@return string
function TSM.GetVersion()
	return TSM.LibTSMUtil.GetVersionStr()
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.ModuleInfoIterator(_, index)
	index = index + 1
	local path = private.initOrder[index]
	if not path then
		return
	end
	local context = private.context[path]
	assert(context)
	return index, path, context.moduleLoadTime, context.gameDataLoadTime, context.moduleUnloadTime
end

function private.ProcessModuleLoad(path)
	local context = private.context[path]
	assert(context)
	if context.moduleLoadTime then
		-- Already loaded
		return
	end
	tinsert(private.loadOrder, path)
	context.moduleLoadTime = 0
	if context.moduleLoadFunc then
		local startTime = GetTimePreciseSec()
		context.moduleLoadFunc()
		context.moduleLoadTime = GetTimePreciseSec() - startTime
	end
end

function private.ProcessGameDataLoad(path)
	local context = private.context[path]
	assert(context)
	if context.gameDataLoadTime then
		-- Already loaded
		return
	end
	context.gameDataLoadTime = 0
	if context.gameDataLoadFunc then
		local startTime = GetTimePreciseSec()
		context.gameDataLoadFunc()
		context.gameDataLoadTime = GetTimePreciseSec() - startTime
	end
end

function private.ProcessModuleUnload(path)
	local context = private.context[path]
	assert(context)
	if context.moduleUnloadTime then
		-- Already unloaded
		return
	end
	context.moduleUnloadTime = 0
	if context.moduleUnloadFunc then
		local startTime = GetTimePreciseSec()
		context.moduleUnloadFunc()
		context.moduleUnloadTime = GetTimePreciseSec() - startTime
	end
end

function private.UnloadAll()
	-- Unload in the opposite order we loaded
	for i = #private.loadOrder, 1, -1 do
		private.ProcessModuleUnload(private.loadOrder[i])
	end
	TSM.LibTSMCore.UnloadAll()
end

function private.OnEvent(_, event, arg)
	if event == "ADDON_LOADED" and arg == ADDON_NAME and not private.gotAddonLoaded then
		assert(not private.gotPlayerLogin and not private.gotPlayerLogout)
		private.gotAddonLoaded = true
		TSM.LibTSMCore.LoadAll()
		-- Load any module which haven't already
		for _, path in ipairs(private.initOrder) do
			private.ProcessModuleLoad(path)
		end
		-- Load settings
		AddonSettings.LoadDB()
		private.frame:UnregisterEvent("ADDON_LOADED")
	elseif event == "PLAYER_LOGIN" then
		assert(private.gotAddonLoaded and not private.gotPlayerLogin and not private.gotPlayerLogout)
		private.gotPlayerLogin = true
		-- Game data is now available
		for _, path in ipairs(private.loadOrder) do
			private.ProcessGameDataLoad(path)
		end
	elseif event == "PLAYER_LOGOUT" then
		assert(private.gotAddonLoaded and not private.gotPlayerLogout)
		private.gotPlayerLogout = true
		if not private.gotPlayerLogin then
			-- This can happen if the player exits the game during the loading screen, in which case we just ignore it
			return
		end
		private.UnloadAll()
	end
end



-- ============================================================================
-- Initialization Code
-- ============================================================================

do
	-- Configure LibTSMCore
	TSM.LibTSMCore.SetTimeFunction(function()
		return private.startTime + GetTimePreciseSec() - private.startSystemTime
	end)

	-- Only create the frame if we're running in a WoW environment
	if ADDON_NAME then
		-- Create frame to listen for lifecycle events
		private.frame = CreateFrame("Frame")
		private.frame:RegisterEvent("ADDON_LOADED")
		private.frame:RegisterEvent("PLAYER_LOGIN")
		private.frame:RegisterEvent("PLAYER_LOGOUT")
		private.frame:SetScript("OnEvent", private.OnEvent)
		-- Manually register LibTSMClass
		local libTSMClassModule = TSM.Init("LibTSMClass")
		for k, v in pairs(LibTSMClass) do
			libTSMClassModule[k] = v
		end
	end
end

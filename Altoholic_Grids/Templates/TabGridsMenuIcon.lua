local addonName = "Altoholic"
local addon = _G[addonName]

local lastFrame

local function _StartAutoCastShine(frame)
	frame.Shine:ShineStart()
	lastFrame = frame
end

local function _StopAutoCastShine(frame)
	-- stop auto-cast shine on the last frame that was clicked
	if lastFrame then
		lastFrame.Shine:ShineStop()
	end
end

local function _EnableIcon(frame)
	frame:Enable()
	frame.Icon:SetDesaturated(false)
end

local function _DisableIcon(frame)
	frame:Disable()
	frame.Icon:SetDesaturated(true)
end

addon:RegisterClassExtensions("AltoTabGridsMenuIcon", {
	StartAutoCastShine = _StartAutoCastShine,
	StopAutoCastShine = _StopAutoCastShine,
	EnableIcon = _EnableIcon,
	DisableIcon = _DisableIcon,
})

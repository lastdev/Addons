local mod	= DBM:NewMod("LogoutTimerGeneral", "DBM-LogoutTimer")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230706163921")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents("CHAT_MSG_SYSTEM")

mod:AddBoolOption("FlashClientIcon", true)
mod:AddBoolOption("PlaySound", true)

local function ShowAlert()
	if mod.Options.FlashClientIcon then
		FlashClientIcon()
	end
	if mod.Options.PlaySound then
		PlaySound(8585, "Master")
	end
end

local logoutTimer = mod:NewTimer(1500, "TimerLogout", "132212")
local timer30, timer15

local function Cancel()
	logoutTimer:Stop()
	if timer30 then
		timer30:Cancel()
		timer15:Cancel()
	end
	mod:UnregisterShortTermEvents()
end

function mod:CHAT_MSG_SYSTEM(msg)
	if msg == L.IdleMessage or msg:find(L.IdleMessage) then
		logoutTimer:Start()
		timer30 = C_Timer.NewTimer(1470, ShowAlert)
		timer15 = C_Timer.NewTimer(1485, ShowAlert)
		self:RegisterShortTermEvents("ZONE_CHANGED_NEW_AREA")
	elseif msg == L.UnidleMessage or msg:find(L.UnidleMessage) then
		Cancel()
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	Cancel()
end

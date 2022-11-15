if GetLocale() ~= "ruRU" then return end
local L = DBM:GetModLocalization("DBM-LogoutTimer")

L:SetGeneralLocalization({
	name	= "Logout Timer"
})

L:SetTimerLocalization({
	TimerLogout	= "Выход из системы: "
})

L:SetMiscLocalization({
	IdleMessage		= "Вы сейчас отошли: AFK",
	UnidleMessage	= "Вы снова за ПК."
})

if GetLocale() ~= "ruRU" then return end
local L = DBM:GetModLocalization("DBM-LogoutTimer")

L:SetGeneralLocalization({
	name	= "Таймер выхода из системы"
})

L:SetTimerLocalization({
	TimerLogout	= "Выход из системы: "
})

L:SetOptionLocalization({
	FlashClientIcon	= "Мигающий значок клиента при выходе из системы.",
	PlaySound		= "Воспроизводить звуковой эффект при выходе из системы."
})

L:SetMiscLocalization({
	IdleMessage		= "Вы сейчас отошли: AFK",
	UnidleMessage	= "Вы снова за ПК."
})

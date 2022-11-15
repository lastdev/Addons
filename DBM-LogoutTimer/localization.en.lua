local L = DBM:GetModLocalization("DBM-LogoutTimer")

L:SetGeneralLocalization({
	name	= "Logout Timer"
})

L:SetTimerLocalization({
	TimerLogout	= "Logout: "
})

L:SetOptionLocalization({
	FlashClientIcon	= "Flash client icon when about to logout.",
	PlaySound		= "Play sound effect when about to logout."
})

L:SetMiscLocalization({
	IdleMessage		= "You are now Away: AFK",
	UnidleMessage	= "You are no longer Away."
})

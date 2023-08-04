local L = DBM:GetModLocalization("LogoutTimerGeneral")

L:SetGeneralLocalization({
	name	= "General Options"
})

L:SetTimerLocalization({
	TimerLogout	= "Logout: "
})

L:SetOptionLocalization({
	FlashClientIcon	= "Flash client icon when about to logout.",
	PlaySound		= "Play sound effect when about to logout.",
	TimerLogout		= "Show logout timer",
})

L:SetMiscLocalization({
	IdleMessage		= "You are now Away:",
	UnidleMessage	= "You are no longer Away."
})

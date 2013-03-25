local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
	InParty = {
		Widget = "LeftCheckButton1",
		Label = L["Announce Out of Range in Party"],
		Default = true,
	},
	InSay = {
		Widget = "LeftCheckButton2",
		Label = L["Announce Out of Range in Say"],
		Default = false,
	},
	InWhisper = {
		Widget = "LeftCheckButton3",
		Label = L["Announce Out of Range in Whisper"],
		Default = false,
	},
	
	Announcement = {
		Type = "editbox",
		Widget = "LeftEditBox1",
		Label = L["Out of range announcement:"],
		Default = L["<Player> <is/are> out of range of <Atonement>."],
	},
	HealPercent = {
		Type = "editbox",
		Widget = "LeftEditBox2",
		Label = L["Prioritize healing under % health:"],
		MaxCharacters = 2,
		Numeric = true,
		Default = 90,
	},
	ConservePercent = {
		Type = "editbox",
		Widget = "RightEditBox1",
		Label = L["Mana-conscious rotation under % mana:"],
		MaxCharacters = 3,
		Numeric = true,
		Default = 50,
	},
	OnlyHealPercent = {
		Type = "editbox",
		Widget = "RightEditBox2",
		Label = L["Healing only under % mana:"],
		MaxCharacters = 3,
		Numeric = true,
		Default = 25,
	},
}

c.RegisterAddon()

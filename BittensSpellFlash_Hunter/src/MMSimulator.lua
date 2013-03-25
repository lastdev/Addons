local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.MMSim = { }

function a.MMSim.SetToCurState(state)
	state.Power = a.Focus
	state.Regen = a.Regen
	state.FirstSS = a.NextSSIsImproved
	state.Timers.Fervor = c.GetBuffDuration("Fervor")
	state.Timers.RapidFire = c.GetBuffDuration("Rapid Fire")
end

a.MMSim.Handlers = {
	Fervor = function(state)
		state.Regen = state.Regen - 5
	end,
	RapidFire = function(state)
		if c.HasSpell("Rapid Recuperation") then
			state.Regen = state.Regen - 4
		end
		state.Regen = state.Regen / 1.4
	end,
}

local addonName, addonTable = ...;
_G[addonName] = addonTable;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;

local Priest = MaxDps:NewModule('Priest');
addonTable.Priest = Priest;

Priest.spellMeta = {
	__index = function(t, k)
		print('Spell Key ' .. k .. ' not found!');
	end
};

function Priest:Enable()
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Priest.Discipline;
		MaxDps:Print(MaxDps.Colors.Info .. 'Priest - Discipline');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Priest.Holy;
		MaxDps:Print(MaxDps.Colors.Info .. 'Priest - Holy');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Priest.Shadow;
		MaxDps:Print(MaxDps.Colors.Info .. 'Priest - Shadow');
	end

	return true;
end
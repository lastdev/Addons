local _, addonTable = ...;

if not MaxDps then
	return
end

local Priest = addonTable.Priest;

local DI = {
};

setmetatable(DI, Priest.spellMeta);

function Priest:Discipline()
	return nil;
end

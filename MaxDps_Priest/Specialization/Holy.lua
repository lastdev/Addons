local _, addonTable = ...;

if not MaxDps then
	return
end

local Priest = addonTable.Priest;

local HL = {
};

setmetatable(HL, Priest.spellMeta);

function Priest:Holy()
	return nil;
end

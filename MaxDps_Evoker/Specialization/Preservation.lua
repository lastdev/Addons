local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end;

local Evoker = addonTable.Evoker;
local MaxDps = MaxDps;

local PV = {

};

setmetatable(PV, Evoker.spellMeta);

function Evoker:Preservation()
    local fd = MaxDps.FrameData;

end
-- [[ Exported at 2022-12-04 09-23-21 ]] --
-- [[ This code is automatically generated as an export from ]] --
-- [[ an SQLite database and is not meant for manual edit. ]] --

-- [[ Namespaces ]] --
local _, addon = ...;
local objects = addon.Objects;
local menItm = objects.MenuItem;
local data = addon.Data;
data.ExportedPetBattles = {};
local exportedPetBattles = data.ExportedPetBattles;

local function AddEL(m, t, e)
    m:AddExtLinkFull(t, e);
end

local function AddCEL(m, a, c, e)
    return m:AddCritExtLinkFull(a, c, e);
end

function exportedPetBattles.Load(m)
    return;
end


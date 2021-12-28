local addonName, shared = ...;

shared.addon = {};
shared.HandyNotes = _G.LibStub('AceAddon-3.0'):GetAddon('HandyNotes', true)
-- export and import handling
do
  local modules = {};

  function shared.addon.export (moduleName, module)
    modules[moduleName] = module;
  end

  function shared.addon.import (moduleName)
    return modules[moduleName];
  end
end

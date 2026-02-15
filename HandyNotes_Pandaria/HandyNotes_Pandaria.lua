local _, addon = ...;

addon.HandyNotes = _G.LibStub('AceAddon-3.0'):GetAddon('HandyNotes', true)
-- export and import handling

do
  local modules = {};

  function addon.export (moduleName, module)
    assert(modules[moduleName] == nil);
    modules[moduleName] = module;
  end

  function addon.import (moduleName)
    return modules[moduleName];
  end
end

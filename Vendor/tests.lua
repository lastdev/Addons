
local AddonName, Addon = ...

-- Basic test harness tests.
Addon:AddTest(
    "Add Tests",
    "Test", 
    function () Addon:Debug("test", "In Setup") end,
    function () Addon:Debug("test", "In Execution") end,
    function () Addon:Debug("test", "In Cleanup") end) 

Addon:AddTest(
    "Fail Setup",
    "Test", 
    function () error("Setup failed") end,
    function () Addon:Debug("test", "In Execution") end,
    function () Addon:Debug("test", "In Cleanup") end) 

Addon:AddTest(
    "Fail Execution",
    "Test", 
    function () Addon:Debug("test", "In Setup") end,
    function () error("Execution failed") end,
    function () Addon:Debug("test", "In Cleanup") end) 

Addon:AddTest(
    "Fail Cleanup",
    "Test", 
    function () Addon:Debug("test", "In Setup") end,
    function () Addon:Debug("test", "In Execution") end,
    function () error("Cleanup failed") end) 

Addon:AddTest(
    "Fail Execution & Cleanup",
    "Test", 
    function () Addon:Debug("test", "In Setup") end,
    function () error("Execution failed") end,
    function () error("Cleanup failed") end) 

Addon:AddTest(
    "Test Nil Cleanup",
    "Test", 
    nil,

    nil) 

-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
-- only create the TSMDEV table if we're in a dev or test environment
if not TSM.IsDev() and not TSM.IsTest() then
	return
end
TSMDEV = {} ---@class TSMDEV



-- ============================================================================
-- Global TSMDEV Functions
-- ============================================================================

function TSMDEV.Dump(value)
	-- TODO: Implement something for test environments
	assert(not TSM.IsTest())
	C_AddOns.LoadAddOn("Blizzard_DebugTools")
	DevTools_Dump(value)
end

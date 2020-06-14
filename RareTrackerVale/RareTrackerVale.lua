-- Redefine often used functions locally.
local CreateFrame = CreateFrame

-- Redefine global variables locally.
local UIParent = UIParent

-- ####################################################################
-- ##                              Core                              ##
-- ####################################################################

-- Create a primary frame for the addon.
local RTV = CreateFrame("Frame", "RTV", UIParent);

-- The code of the addon.
RTV.addon_code = "RTV"

-- The version of the addon.
RTV.version = 8
-- Version 2: changed the order of the rares.
-- Version 3: death messages now send the spawn id.
-- Version 4: changed the interface of the alive message to include coordinates.
-- Version 6: the time stamp that was used to generate the compressed table is now included in group messages.
-- Version 7: Added Champion Sen-mat.
-- Version 8: Added more rares.

-- Check which assault is currently active.
RTV.assault_id = 0

-- Register the module in the core library.
RT:RegisterZoneModule(RTV)
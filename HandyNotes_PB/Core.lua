--[[
                                ----o----(||)----oo----(||)----o----

                                          Pilgrim's Bounty

                                      v2.03 - 5th November 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local addonName, ns = ...

-- ---------------------------------------------------------------------------------------------------------------------------------

-- This AddOn has been wholly modularised and runs on a standardised core of files.
-- It's data/customisations are found in the _XXXX files.
-- Executable customisations / overrides are to be inserted here.
-- To configure use /mmpt in a chat line.

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Data checks. Must return true or false. Decision as to whether or not to show, regardless of any other checks

--function ns.PassAdditionalQuestChecks( pin )
--function ns.PassAdditionalEventChecks( pin )
--function ns.PassAdditionalAddOnSpecificChecks( pin )

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Preceeds the showing of Tooltips. After the title/name fields. Insert quests/achievements/textures/etc here.

--function ns.AddOnSpecificTooltipLines( pin )

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Should really be in a special purpose Options_xxx file:

--ns.InterfaceOptionsAddOnSpecific() end

-- ---------------------------------------------------------------------------------------------------------------------------------

--	Return manually allocated and sized texture index into ns.textures.

-- function ns.GetAddOnSpecificTextureIndex( pin )
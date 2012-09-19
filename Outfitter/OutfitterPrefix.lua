----------------------------------------
-- Outfitter Copyright 2009, 2010, 2011 John Stephen, wobbleworks.com
-- All rights reserved, unauthorized redistribution is prohibited
----------------------------------------

local _
_, Outfitter = ...

Outfitter.DebugColorCode = "|cff99ffcc"
Outfitter.AddonPath = "Interface\\Addons\\"..select(1, ...).."\\"
Outfitter.UIElementsLibTexturePath = Outfitter.AddonPath
Outfitter.Debug = {}

--

Outfitter.LibBabbleZone = LibStub("LibBabble-Zone-3.0")
Outfitter.LibBabbleSubZone = LibStub("LibBabble-SubZone-3.0")
Outfitter.LibBabbleInventory = LibStub("LibBabble-Inventory-3.0")
Outfitter.LibTipHooker = LibStub("LibTipHooker-1.1")
Outfitter.LibStatLogic = LibStub("LibStatLogic-1.2MC")
Outfitter.LBF = LibStub("LibButtonFacade", true)
Outfitter.LibDropdown = LibStub("LibDropdown-1.0")

Outfitter.LZ = Outfitter.LibBabbleZone:GetLookupTable()
Outfitter.LBI = Outfitter.LibBabbleInventory:GetLookupTable()
Outfitter.LSZ = Outfitter.LibBabbleSubZone:GetLookupTable()
local addonName = ...
_G[addonName] = {}
local addon = _G[addonName]

addon.GUI = CreateFrame("Frame", "TLDRMissionsFrame", UIParent, "BackdropTemplate")
addon.WODGUI = CreateFrame("Frame", "TLDRMissionsWODFrame", UIParent, "BackdropTemplate")

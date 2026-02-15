-- Version Detection Utility
-- WoW 12.0+ (Midnight) only - Housing API required

local AddonName = ...

local VersionDetect = {}

local _, _, _, tocVersion = GetBuildInfo()
VersionDetect.TOC_VERSION = tonumber(tocVersion) or 120000

-- This addon requires WoW 12.0+ (Midnight expansion)
-- Housing API is always available
VersionDetect.HAS_HOUSING_API = true

-- Specific version checks for 12.0.x patches
VersionDetect.IS_12_0_0 = VersionDetect.TOC_VERSION >= 120000 and VersionDetect.TOC_VERSION < 120001
VersionDetect.IS_12_0_1_PLUS = VersionDetect.TOC_VERSION >= 120001

_G.HousingVersionDetect = VersionDetect
return VersionDetect

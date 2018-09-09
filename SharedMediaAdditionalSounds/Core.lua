--[[

Author: Trelis @ Proudmoore
stassart @ curse

Original version SharedMediaAdditionalFonts author: pb_ee1

]]

local LSM3 = LibStub("LibSharedMedia-3.0", true)
local LSM2 = LibStub("LibSharedMedia-2.0", true)
local SML = LibStub("SharedMedia-1.0", true)

SharedMediaAdditionalSounds = {}

SharedMediaAdditionalSounds.registry = { ["sound"] = {} }

local meta_version = GetAddOnMetadata("SharedMediaAdditionalSounds","Version")
local curse_version = GetAddOnMetadata("SharedMediaAdditionalSounds","X-Curse-Packaged-Version")
if (not curse_version) then
	curse_version = ""
end
SharedMediaAdditionalSounds.revision = ("v%s-%s"):format(meta_version, curse_version)

function SharedMediaAdditionalSounds:Register(mediatype, key, data, langmask)
	if LSM3 then
		LSM3:Register(mediatype, key, data, langmask)
	end
	if LSM2 then
		LSM2:Register(mediatype, key, data)
	end
	if SML then
		SML:Register(mediatype, key, data)
	end
	if not SharedMediaAdditionalSounds.registry[mediatype] then
		SharedMediaAdditionalSounds.registry[mediatype] = {}
	end
	table.insert(SharedMediaAdditionalSounds.registry[mediatype], { key, data, langmask})
end

function SharedMediaAdditionalSounds.OnEvent(this, event, ...)
	if not LSM3 then
		LSM3 = LibStub("LibSharedMedia-3.0", true)
		if LSM3 then
			for m,t in pairs(SharedMediaAdditionalSounds.registry) do
				for _,v in ipairs(t) do
					LSM3:Register(m, v[1], v[2], v[3])
				end
			end
		end
	end
	if not LSM2 then
		LSM2 = LibStub("LibSharedMedia-2.0", true)
		if LSM2 then
			for m,t in pairs(SharedMediaAdditionalSounds.registry) do
				for _,v in ipairs(t) do
					LSM2:Register(m, v[1], v[2])
				end
			end
		end
	end
	if not SML then
		SML = LibStub("SharedMedia-1.0", true)
		if SML then
			for m,t in pairs(SharedMediaAdditionalSounds.registry) do
				for _,v in ipairs(t) do
					SML:Register(m, v[1], v[2])
				end
			end
		end
	end
end

SharedMediaAdditionalSounds.frame = CreateFrame("Frame")
SharedMediaAdditionalSounds.frame:SetScript("OnEvent", SharedMediaAdditionalSounds.OnEvent)
SharedMediaAdditionalSounds.frame:RegisterEvent("ADDON_LOADED")


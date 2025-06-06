--[[

Author: Trelis @ Proudmoore
stassart @ curse

Original version SharedMediaAdditionalFonts author: AllInOneMighty

]]

local LSM3 = LibStub("LibSharedMedia-3.0", true)
local LSM2 = LibStub("LibSharedMedia-2.0", true)
local SML = LibStub("SharedMedia-1.0", true)

SharedMediaAdditionalSounds = {}
SharedMediaAdditionalSounds.revision = tonumber(string.sub("$Revision$", 12, -3)) or 1

SharedMediaAdditionalSounds.registry = { ["sound"] = {} }

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


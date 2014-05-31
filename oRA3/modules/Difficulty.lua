local oRA = LibStub("AceAddon-3.0"):GetAddon("oRA3")
local module = oRA:NewModule("Difficulty")

module.VERSION = tonumber(("$Revision: 658 $"):sub(12, -3))

local db = nil

function module:OnRegister()
	oRA.RegisterCallback(self, "OnShutdown")
	oRA.RegisterCallback(self, "OnProfileUpdate", function()
		db = oRA.db.char
	end)
	db = oRA.db.char

	hooksecurefunc("SetRaidDifficultyID", function(difficultyID)
		if difficultyID > 2 and difficultyID < 7 then
			db.lastRaidDifficulty = difficultyID
		end
	end)
end

function module:OnEnable()
	if not IsInGroup() then
		local diff = db.lastRaidDifficulty
		if GetRaidDifficultyID() ~= diff then
			SetRaidDifficultyID(diff)
		end
	end
end

function module:OnShutdown()
	local diff = db.lastRaidDifficulty
	if GetRaidDifficultyID() ~= diff then
		SetRaidDifficultyID(diff)
	end
end


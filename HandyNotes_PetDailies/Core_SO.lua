local _, PetDailies = ...
local addonName = "PetDailies"
local addon = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

function addon:handleSlashCommand(msg)
	if (msg) then
		if (msg == "list") then
			addon.ToggleList()
		end
	end
end

addon.defaults = { profile = { completed = false } }

function addon:OnInitialize()
	addon:RegisterChatCommand("pd","handleSlashCommand")
end


function addon:ToggleList()
	addon.UI:Show()
end

local function ParsePoint(id)
	local point_format = "(%d+)\.([0-9]+):(.+):(.+):(.+):(.*)";
	return id:match(point_format)
end

function addon:BuildData(group)
	local achieves = {
		[9069] = true,
		[12088] = true,
		[12100] = true,
		[13279] = true,
		[13626] = true,
		[13625] = true,
		[14881] = true,
		[14879] = true,
		[14625] = true,
		[16512] = true,
		[16464] = true,
	}
	local points_db = addon.points
	local map = C_Map.GetBestMapForUnit("player")

	if (group == 1) then
		self.UI:AddToScroll(self.UI:CreateHeading(C_Map.GetMapInfo(534).name))

		for _, id in pairs(points_db[534]) do
			if PetDailies:ShouldBeShown(id) then
				self.UI:AddToScroll(self.UI:CreateScrollGroup(false, true, ParsePoint(id)))
			end

		end
	elseif (group == 2) then
		self.UI:AddToScroll(self.UI:CreateHeading(C_Map.GetMapInfo(map).name))

		for _, id in pairs(points_db[map]) do
			if PetDailies:ShouldBeShown(id) then
				self.UI:AddToScroll(self.UI:CreateScrollGroup(false, true, ParsePoint(id)))
			end

		end
	elseif (group == 3) then
		self.UI:AddToScroll(self.UI:CreateHeading(C_Map.GetMapInfo(map).name))
		local achieve = 0
		local newachieve = 1
		local newtrainer = ""
		local idx = 1
		for _, id in pairs(points_db[map]) do
			if PetDailies:ShouldBeShown(id) then
				newachieve, idx, newtrainer = ParsePoint(id)
				newachieve = newachieve + 0
				if (achieves[newachieve] == true) then
					if (achieve ~= newachieve) then
						local _, txt = GetAchievementInfo(13279)
						self.UI:AddToScroll(self.UI:CreateHeading(txt))
					end
					self.UI:AddToScroll(self.UI:CreateScrollGroup(PetDailies:IsComplete(newachieve, idx+0), ParsePoint(id)))

				end
				achieve = newachieve
			end

		end

	end
end
local _, IDTip = ...

local Helpers = {}

function Helpers.GetQuestID()
	if QuestInfoFrame.questLog and C_QuestLog and C_QuestLog.GetSelectedQuest then
		return C_QuestLog.GetSelectedQuest()
	else
		return GetQuestID()
	end
end

function Helpers.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function Helpers.GetGameVersion()
	local _, _, _, version = GetBuildInfo()
	return version
end

function Helpers.IsDragonflight()
	return Helpers.GetGameVersion() > 100000
end

function Helpers.IsPTR()
	return Helpers.GetGameVersion() == 100000
end

function Helpers.IsShadowlands()
	return Helpers.GetGameVersion() > 90000 and Helpers.GetGameVersion() < 100000
end

function Helpers.IsClassic()
	return Helpers.GetGameVersion() < 90000
end

function Helpers.IsEra()
	return Helpers.GetGameVersion() < 20000
end

IDTip.Helpers = Helpers

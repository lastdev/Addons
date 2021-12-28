local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- World Events: The Captain's Booty
A{"TheCapeOfStranglethorn", 3457, 0.4000, 0.7260, season="Pirates' Day", trivia={module="seasonal", category="World Events", name="The Captain's Booty", description="Drink with the Dread Captain DeMeza to join her crew during Pirates' Day.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10}}

-- World Events: Dead Man's Party
A{"unknown", 3456, season="Day of the Dead", trivia={module="seasonal", category="World Events", name="Dead Man's Party", description="Dance with Catrina to become a skeleton during the Day of the Dead.", points=10}}

-- [[ Namespaces ]] --
local _, addon = ...;

function KrowiAF_SearchResultsButton_OnClick(self)
    if self.Achievement then
        addon.GUI.Search.ResultsFrame:Hide();
        KrowiAF_SelectAchievement(self.Achievement);
	end
end
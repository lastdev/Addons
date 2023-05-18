-- [[ Namespaces ]] --
local _, addon = ...;

KrowiAF_CategoriesFrameMixin = {};

local function CreateScrollView(self)
	self.ScrollView = CreateScrollBoxListLinearView();
	self.ScrollView:SetElementInitializer("KrowiAF_CategoryButton_Template", function(button, category)
		button:SetCategory(category);
	end);
	self.ScrollView:SetElementIndentCalculator(function(category)
		if not category then
			return 0;
		end
		return 2 + (category.Level - 1) * addon.Options.db.Categories.Indentation;
	end);
	ScrollUtil.InitScrollBoxListWithScrollBar(self.ScrollBox, self.ScrollBar, self.ScrollView);
end

local function AddManagedScrollBarVisibilityBehavior(self)
	local anchorsWithBar = {
        CreateAnchor("TOPLEFT", self, "TOPLEFT", 0, -5),
        CreateAnchor("BOTTOMRIGHT", self.ScrollBar, "BOTTOMLEFT", 0, 5)
    };

    local anchorsWithoutBar = {
        CreateAnchor("TOPLEFT", self, "TOPLEFT", 0, -5),
        CreateAnchor("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 5)
    };

    ScrollUtil.AddManagedScrollBarVisibilityBehavior(self.ScrollBox, self.ScrollBar, anchorsWithBar, anchorsWithoutBar);
end

function KrowiAF_CategoriesFrameMixin:SetRightPoint()
	self:SetPoint("RIGHT", AchievementFrameCategories, addon.Options.db.Window.CategoriesFrameWidthOffset, 0);
	AchievementFrameCategoriesBG:SetWidth(self:GetWidth() - 4);
end

function KrowiAF_CategoriesFrameMixin:OnLoad()
	self:SetRightPoint();

	self.ScrollBox.wheelPanScalar = addon.Options.db.Categories.MouseWheelPanScalar;
	self.ScrollBar.wheelPanScalar = addon.Options.db.Categories.MouseWheelPanScalar;

	CreateScrollView(self);
	AddManagedScrollBarVisibilityBehavior(self);
end

local function RestoreScrollPosition(frame)
	local selectedTab = addon.GUI.SelectedTab;
	if selectedTab == nil then
		return;
	end
	if selectedTab.SelectedCategory and selectedTab.CategoryScrollPercentage then
		frame.ScrollBox:SetScrollPercentage(selectedTab.CategoryScrollPercentage);
	end
end

function KrowiAF_CategoriesFrameMixin:OnShow()
	self:RegisterEvent("ACHIEVEMENT_EARNED");
	self:SetRightPoint();
	AchievementFrameCategories:Hide();
	AchievementFrame.Header.LeftDDLInset:Show();
	AchievementFrameFilterDropDown:Hide();
	if not addon.IsWrathClassic then
		AchievementFrame.SearchBox:Hide();
	end
	AchievementFrameWaterMark:SetTexture(addon.GUI.SelectedTab and addon.GUI.SelectedTab.WaterMark or "Interface/AchievementFrame/UI-Achievement-AchievementWatermark");

	self:Update(addon.AchievementEarnedUpdateCategoriesFrameOnNextShow);
	addon.AchievementEarnedUpdateCategoriesFrameOnNextShow = nil;

	RestoreScrollPosition(self);
end

function KrowiAF_CategoriesFrameMixin:OnHide()
	self:UnregisterEvent("ACHIEVEMENT_EARNED");
	AchievementFrameCategories:Show();
	AchievementFrameCategoriesBG:SetWidth(195);
	if not AchievementFrameAchievements:IsShown() then
		AchievementFrame.Header.LeftDDLInset:Hide();
		AchievementFrameFilterDropDown:Hide();
	end
	if not addon.IsWrathClassic then
		AchievementFrame.SearchBox:Show();
	end
end

function KrowiAF_CategoriesFrameMixin:OnEvent(event)
	if event ~= "ACHIEVEMENT_EARNED" then
		return;
	end
	addon.DelayFunction("KrowiAF_CategoriesFrame_OnEvent", 1, self.Update, self, true);
end

local function GetDisplayCategories(displayCategories, category, getAchNums)
	if category.NotHidden or category.AlwaysVisible or category.HasFlexibleData then -- If already visible, keep visible
		if (category.NumOfAch == nil or getAchNums or category.HasFlexibleData) and category.Parent.TabName ~= nil then
			-- Huge increase over performance if we cache the achievement numbers and only update them when needed,
			-- only for the top level categories since it works recursive
			if category:GetAchievementNumbers() > 0 or category.AlwaysVisible then
				tinsert(displayCategories, category);
			end
		elseif category.NumOfAch > 0 or category.AlwaysVisible then
			tinsert(displayCategories, category);
		end
	end

	local children = category.Children;
	if children then
		for _, child in next, children do
			GetDisplayCategories(displayCategories, child, getAchNums);
		end
	end
end

local function UpdateDataProvider(self, getAchNums, retainScrollPosition)
	local displayCategories = {};
	local categories = addon.GUI.SelectedTab.Categories;
	for _, category in next, categories do
		GetDisplayCategories(displayCategories, category, getAchNums);
	end

	local newDataProvider = CreateDataProvider();
	for _, category in next, displayCategories do
		newDataProvider:Insert(category);
	end
	self.ScrollBox:SetDataProvider(newDataProvider, retainScrollPosition);
end

function KrowiAF_CategoriesFrameMixin:Update(getAchNums, retainScrollPosition)
	local selectedTab = addon.GUI.SelectedTab;
	if selectedTab == nil then
		return;
	end

	local filters = selectedTab.Filters;
	if filters.Refresh then
		filters.Refresh = nil;
		getAchNums = true;
	end

	UpdateDataProvider(self, getAchNums, retainScrollPosition);
end

local function OpenCloseCategory(targetCategory, category)
	if category.Level == targetCategory.Level and category.Parent == targetCategory.Parent then -- Category on same level and same parent
		category.NotCollapsed = nil;
	end
	if category.Level > targetCategory.Level then -- Category on higher level
		if category.Parent == targetCategory then -- Show child of clicked button
			category.NotHidden = true;
		else
			category.NotHidden = nil; -- Hide the rest
		end
		category.NotCollapsed = nil;
	end

	local children = category.Children;
	if children then
		for _, child in next, children do
			OpenCloseCategory(targetCategory, child);
		end
	end
end

local function ExpandCategory(categories, targetCategory)
	for _, category in next, categories do
		OpenCloseCategory(targetCategory, category);
	end
	targetCategory.NotCollapsed = true;
end

local function HideCategory(targetCategory, category)
	if category.Level > targetCategory.Level then
		category.NotHidden = nil;
	end

	local children = category.Children;
	if children then
		for _, child in next, children do
			HideCategory(targetCategory, child);
		end
	end
end

local function CollapseCategory(categories, targetCategory)
	for _, category in next, categories do
		HideCategory(targetCategory, category);
	end
	targetCategory.NotCollapsed = nil;
end

function KrowiAF_CategoriesFrameMixin:ExpandToCategory(category)
	local selectedTab = addon.GUI.SelectedTab;
	if selectedTab == nil then
		return;
	end

	category = category:GetMergedCategory();
	local categoriesTree = category:GetTree();

	local categories = selectedTab.Categories;
	for i = 1, #categoriesTree do
		ExpandCategory(categories, categoriesTree[i])
	end
	selectedTab.SelectedCategory = category;
end

function KrowiAF_CategoriesFrameMixin:ShowSubFrame(category)
	if category.IsSummary then
		addon.GUI.AchievementsFrame:Hide();
		addon.GUI.SummaryFrame:Show();
	else
		addon.GUI.SummaryFrame:Hide();
		local achievementsFrame = addon.GUI.AchievementsFrame;
		achievementsFrame:Show();
		achievementsFrame:ClearFullSelection();
		achievementsFrame:Update();
	end
end

function KrowiAF_CategoriesFrameMixin:SelectCategory(category)
	local selectedTab = addon.GUI.SelectedTab;
	if not selectedTab then
		return;
	end

	local prevCategory = selectedTab.SelectedCategory;

	local categories = selectedTab.Categories;
	if category == selectedTab.SelectedCategory and category.NotCollapsed then
		CollapseCategory(categories, category);
	else
		ExpandCategory(categories, category);
		selectedTab.SelectedCategory = category;
	end
    self:Update(nil, true);

	if prevCategory == selectedTab.SelectedCategory and prevCategory.HasFlexibleData ~= true then
		-- If this category was selected already, bail after changing collapsed states.
		return;
	end

	self:ShowSubFrame(selectedTab.SelectedCategory);
end
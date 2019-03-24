--- @type StdUi
local StdUi = LibStub and LibStub('StdUi', true);
if not StdUi then
	return;
end

local module, version = 'Tab', 2;
if not StdUi:UpgradeNeeded(module, version) then return end;

---
---local t = {
---	{
---		name = 'firstTab',
---		title = 'First',
---	},
---	{
---		name = 'secondTab',
---		title = 'Second',
---	},
---	{
---		name = 'thirdTab',
---		title = 'Third'
---	}
---}
function StdUi:TabPanel(parent, width, height, tabs, vertical)
	local this = self;
	vertical = vertical or false;

	local buttonHeight = 20;
	local buttonWidth = 160;
	local tabFrame = self:Frame(parent, width, height);
	tabFrame.vertical = vertical;

	tabFrame.tabs = tabs;
	tabFrame.panel = self:Panel(tabFrame);
	if vertical then
		self:GlueAcross(tabFrame.panel, tabFrame, 0, -buttonHeight, 0, 0);
	else
		self:GlueAcross(tabFrame.panel, tabFrame, 0, -buttonHeight, 0, 0);
	end

	function tabFrame:EnumerateTabs(callback)
		for i = 1, #self.tabs do
			local tab = self.tabs[i];
			if callback(tab, self) then
				break;
			end
		end
	end

	function tabFrame:HideAllFrames()
		self:EnumerateTabs(function(tab)
			if tab.frame then
				tab.frame:Hide();
			end
		end);
	end

	function tabFrame:DrawButtons()
		self:EnumerateTabs(function(tab)
			if tab.button then
				tab.button:Hide();
			end
		end);

		local prevBtn;
		self:EnumerateTabs(function(tab, parentTabFrame)
			local btn = tab.button;
			if not btn then
				btn = this:Button(parentTabFrame, nil, buttonHeight);
				tab.button = btn;
				btn.tabFrame = parentTabFrame;

				btn:SetScript('OnClick', function (bt)
					bt.tabFrame:SelectTab(bt.tab.name);
				end);
			end

			btn.tab = tab;
			btn:SetText(tab.title);
			btn:ClearAllPoints();
			if parentTabFrame.vertical then

			else
				this:ButtonAutoWidth(btn);
			end

			if parentTabFrame.vertical then
				if not prevBtn then
					this:GlueTop(btn, parentTabFrame, 0, 0, 'LEFT');
				else
					this:GlueBelow(btn, prevBtn, 0, -1);
				end
			else
				if not prevBtn then
					this:GlueTop(btn, parentTabFrame, 0, 0, 'LEFT');
				else
					this:GlueRight(btn, prevBtn, 5, 0);
				end
			end

			btn:Show();
			prevBtn = btn;
		end);
	end

	function tabFrame:DrawFrames()
		self:EnumerateTabs(function(tab)
			if not tab.frame then
				tab.frame = this:Frame(self.panel);
			end

			tab.frame:ClearAllPoints();
			tab.frame:SetAllPoints();
		end);
	end

	function tabFrame:Update(tabs)
		if tabs then
			self.tabs = tabs;
		end
		self:DrawButtons();
		self:DrawFrames();
	end

	function tabFrame:GetTabByName(name)
		local foundTab;

		self:EnumerateTabs(function(tab)
			if tab.name == name then
				foundTab = tab;
				return true;
			end
		end);
		return foundTab;
	end

	function tabFrame:SelectTab(name)
		self.selected = name;
		if self.selectedTab then
			self.selectedTab.button:Enable();
		end

		self:HideAllFrames();
		local foundTab = self:GetTabByName(name);

		if foundTab.name == name and foundTab.frame then
			foundTab.button:Disable();
			foundTab.frame:Show();
			tabFrame.selectedTab = foundTab;
			return true;
		end
	end

	function tabFrame:GetSelectedTab()
		return self.selectedTab;
	end

	tabFrame:Update();
	if #tabFrame.tabs > 0 then
		tabFrame:SelectTab(tabFrame.tabs[1].name);
	end

	return tabFrame;
end

StdUi:RegisterModule(module, version);
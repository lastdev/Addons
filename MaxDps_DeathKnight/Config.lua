local _, addonTable = ...;
local StdUi = LibStub('StdUi');

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local DeathKnight = addonTable.DeathKnight;

local defaultOptions = {
	unholyApocalypseAsCooldown = false,
	unholyDarkTransformationAsCooldown = false,
	unholyUnholyFrenzyAsCooldown = false,
};

function DeathKnight:GetConfig()
	local config = {
		layoutConfig = { padding = { top = 30 } },
		database     = self.db,
		rows         = {
			[1] = {
				outlaw = {
					type = 'header',
					label = 'Unholy options'
				}
			},
			[2] = {
				unholyApocalypseAsCooldown = {
					type   = 'checkbox',
					label  = 'Apocalypse as cooldown',
					column = 12
				},
			},
			[3] = {
				unholyDarkTransformationAsCooldown = {
					type   = 'checkbox',
					label  = 'Dark Transformation as cooldown',
					column = 12
				},
			},
			[4] = {
				unholyUnholyFrenzyAsCooldown = {
					type   = 'checkbox',
					label  = 'Unholy Frenzy as cooldown',
					column = 12
				},
			},
		},
	};

	return config;
end


function DeathKnight:InitializeDatabase()
	if self.db then return end;

	if not MaxDpsDeathKnightOptions then
		MaxDpsDeathKnightOptions = defaultOptions;
	end

	self.db = MaxDpsDeathKnightOptions;
end

function DeathKnight:CreateConfig()
	if self.optionsFrame then
		return;
	end

	local optionsFrame = StdUi:PanelWithTitle(nil, 100, 100, 'Death Knight Options');
	self.optionsFrame = optionsFrame;
	optionsFrame:Hide();
	optionsFrame.name = 'Death Knight';
	optionsFrame.parent = 'MaxDps';

	StdUi:BuildWindow(self.optionsFrame, self:GetConfig());

	StdUi:EasyLayout(optionsFrame, { padding = { top = 40 } });

	optionsFrame:SetScript('OnShow', function(of)
		of:DoLayout();
	end);

	InterfaceOptions_AddCategory(optionsFrame);
	InterfaceCategoryList_Update();
	InterfaceOptionsOptionsFrame_RefreshCategories();
	InterfaceAddOnsList_Update();
end
--- @type StdUi
local StdUi = LibStub and LibStub('StdUi', true);
if not StdUi then
	return;
end

local module, version = 'Button', 1;
if not StdUi:UpgradeNeeded(module, version) then return end;

local SquareButtonCoords = {
	["UP"] = {     0.45312500,    0.64062500,     0.01562500,     0.20312500};
	["DOWN"] = {   0.45312500,    0.64062500,     0.20312500,     0.01562500};
	["LEFT"] = {   0.23437500,    0.42187500,     0.01562500,     0.20312500};
	["RIGHT"] = {  0.42187500,    0.23437500,     0.01562500,     0.20312500};
	["DELETE"] = { 0.01562500,    0.20312500,     0.01562500,     0.20312500};
};

function StdUi:SquareButton(parent, width, height, icon)
	local button = CreateFrame('Button', nil, parent);
	self:InitWidget(button);
	self:SetObjSize(button, width, height);

	self:ApplyBackdrop(button);

	button.icon = self:Texture(button, 12, 12, [[Interface\Buttons\SquareButtonTextures]]);
	button.icon:SetPoint('CENTER', 0, 0);

	button.iconDisabled = self:Texture(button, 16, 16, [[Interface\Buttons\SquareButtonTextures]]);
	button.iconDisabled:SetDesaturated(true);
	button.iconDisabled:SetPoint('CENTER', 0, 0);

	local hTex = self:HighlightButtonTexture(button);
	button:SetHighlightTexture(hTex);
	button.highlightTexture = hTex;

	button:SetNormalTexture(button.icon);
	button:SetDisabledTexture(button.iconDisabled);

	local coords = SquareButtonCoords[icon];
	if coords then
		button.icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		button.iconDisabled:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
	end

	return button;
end

function StdUi:ButtonLabel(parent, text)
	local label = self:Label(parent, text);
	label:SetJustifyH('CENTER');
	self:GlueAcross(label, parent, 2, -2, -2, 2);
	parent:SetFontString(label);

	return label;
end

function StdUi:HighlightButtonTexture(button)
	local hTex = self:Texture(button, nil, nil, nil);
	hTex:SetColorTexture(
		self.config.highlight.color.r,
		self.config.highlight.color.g,
		self.config.highlight.color.b,
		self.config.highlight.color.a
	);
	hTex:SetAllPoints();

	return hTex;
end

--- Creates a button with only a highlight
--- @return Button
function StdUi:HighlightButton(parent, width, height, text, inherit)
	local button = CreateFrame('Button', nil, parent, inherit);
	self:InitWidget(button);
	self:SetObjSize(button, width, height);
	button.text = self:ButtonLabel(button, text);

	local hTex = self:HighlightButtonTexture(button);
	hTex:SetBlendMode('ADD');

	button:SetHighlightTexture(hTex);
	button.highlightTexture = hTex;

	return button;
end

--- @return Button
function StdUi:Button(parent, width, height, text, inherit)
	local button = self:HighlightButton(parent, width, height, text, inherit)
	button:SetHighlightTexture(nil);

	self:ApplyBackdrop(button);
	self:HookDisabledBackdrop(button);
	self:HookHoverBorder(button);

	return button;
end

function StdUi:ButtonAutoWidth(button, padding)
	padding = padding or 5;
	button:SetWidth(button.text:GetStringWidth() + padding * 2);
end

StdUi:RegisterModule(module, version);
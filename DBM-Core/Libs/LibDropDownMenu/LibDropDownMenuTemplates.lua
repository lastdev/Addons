
local CreateFromMixins,_G,select = CreateFromMixins,_G,select
local ExecuteFrameScript,PlaySound,SOUNDKIT = ExecuteFrameScript,PlaySound,SOUNDKIT;

setfenv(1,LibStub("LibDropDownMenu"));
-- start of content from UIDropDownMenuTemplates.lua

-- Custom dropdown buttons are instantiated by some external system.
-- When calling UIDropDownMenu_AddButton that system sets info.customFrame to the instance of the frame it wants to place on the menu.
-- The dropdown menu creates its button for the entry as it normally would, but hides all elements.  The custom frame is then anchored
-- to that button and assumes responsibility for all relevant dropdown menu operations.
-- The hidden button will request a size that it should become from the custom frame.

DropDownMenuButtonMixin = {}

function DropDownMenuButtonMixin:OnEnter(...)
	ExecuteFrameScript(self:GetParent(), "OnEnter", ...);
end

function DropDownMenuButtonMixin:OnLeave(...)
	ExecuteFrameScript(self:GetParent(), "OnLeave", ...);
end

function DropDownMenuButtonMixin:OnMouseDown(button)
	if self:IsEnabled() then
		ToggleDropDownMenu(nil, nil, self:GetParent());
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end
end

LargeDropDownMenuButtonMixin = CreateFromMixins(DropDownMenuButtonMixin);

function LargeDropDownMenuButtonMixin:OnMouseDown(button)
	if self:IsEnabled() then
		local parent = self:GetParent();
		ToggleDropDownMenu(nil, nil, parent, parent, -8, 8);
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end
end

DropDownExpandArrowMixin = {};

function DropDownExpandArrowMixin:OnEnter()
	local level =  self:GetParent():GetParent():GetID() + 1;

	CloseDropDownMenus(level);

	if self:IsEnabled() then
		local listFrame = _G["LibDropDownMenu_List"..level];
		if ( not listFrame or not listFrame:IsShown() or select(2, listFrame:GetPoint(1)) ~= self ) then
			ToggleDropDownMenu(level, self:GetParent().value, nil, nil, nil, nil, self:GetParent().menuList, self, nil, self:GetParent().menuListDisplayMode);
		end
	end
end

function DropDownExpandArrowMixin:OnMouseDown(button)
	if self:IsEnabled() then
		ToggleDropDownMenu(self:GetParent():GetParent():GetID() + 1, self:GetParent().value, nil, nil, nil, nil, self:GetParent().menuList, self, nil, self:GetParent().menuListDisplayMode);
	end
end

UIDropDownCustomMenuEntryMixin = {};

function UIDropDownCustomMenuEntryMixin:OnEnter()
	UIDropDownMenu_StopCounting(self:GetOwningDropdown());
end

function UIDropDownCustomMenuEntryMixin:OnLeave()
	UIDropDownMenu_StartCounting(self:GetOwningDropdown());
end

function UIDropDownCustomMenuEntryMixin:GetPreferredEntryWidth()
	return self:GetWidth();
end

function UIDropDownCustomMenuEntryMixin:GetPreferredEntryHeight()
	return self:GetHeight();
end

function UIDropDownCustomMenuEntryMixin:OnSetOwningButton()
	-- for derived objects to implement
end

function UIDropDownCustomMenuEntryMixin:SetOwningButton(button)
	self:SetParent(button:GetParent());
	self.owningButton = button;
	self:OnSetOwningButton();
end

function UIDropDownCustomMenuEntryMixin:GetOwningDropdown()
	return self.owningButton:GetParent();
end

function UIDropDownCustomMenuEntryMixin:SetContextData(contextData)
	self.contextData = contextData;
end

function UIDropDownCustomMenuEntryMixin:GetContextData()
	return self.contextData;
end

ColorSwatchMixin = {}

function ColorSwatchMixin:SetColor(color)
	self.Color:SetVertexColor(color:GetRGB());
end

-- copied from SharedXML/NewFeatureLabel.lua; not present in classic
NewFeatureLabelMixin = {};

function NewFeatureLabelMixin:OnLoad()
	self.BGLabel:SetText(self.label);
	self.Label:SetText(self.label);
	self.Label:SetJustifyH(self.justifyH);
	self.BGLabel:SetJustifyH(self.justifyH);
end

function NewFeatureLabelMixin:ClearAlert()
	-- derive
	self:SetShown(false);
end

function NewFeatureLabelMixin:OnShow()
	if self.animateGlow then
		self.Fade:Play();
	end
end

function NewFeatureLabelMixin:OnHide()
	if self.animateGlow then
		self.Fade:Stop();
	end
end

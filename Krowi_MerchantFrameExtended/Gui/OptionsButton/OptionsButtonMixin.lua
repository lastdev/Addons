-- [[ Namespaces ]] --
local _, addon = ...;
local merchantItemsContainer = addon.Gui.MerchantItemsContainer;

KrowiMFE_OptionsButtonMixin = {};

function KrowiMFE_OptionsButtonMixin:ShowHide()
    if addon.Options.db.ShowOptionsButton then
        self:Show();
        return;
    end
    self:Hide();
end

function KrowiMFE_OptionsButtonMixin:AddRadioButton(parentMenu, _menu, text, options, keys, func)
    _menu:AddFull({
		Text = text,
		Checked = function() -- Same
			return addon.Util.ReadNestedKeys(options, keys) == text; -- e.g.: return filters.SortBy.Criteria == addon.L["Default"]
		end,
		Func = function()
			addon.Util.WriteNestedKeys(options, keys, text); -- e.g.: filters.SortBy.Criteria = text;
			parentMenu:SetSelectedName(text);
			func();
		end,
		NotCheckable = false,
		KeepShownOnClick = true
	});
end

local function UpdateView()
	merchantItemsContainer:LoadMaxNumItemSlots();
	MerchantFrame_Update();
end

local media = "Interface\\AddOns\\Krowi_MerchantFrameExtended\\Media\\";
local function ReplaceVarsWithMenu(str, vars)
    if not vars then
        vars = type(str) == "table" and str or {str};
        str = vars[1];
    end
    vars["arrow"] = "|T" .. media .. "ui-backarrow:0|t";
    vars["gameMenu"] = addon.L["Game Menu"];
    vars["interface"] = addon.L["Interface"];
    vars["addOns"] = addon.L["AddOns"];
    vars["addonName"] = addon.MetaData.Title;
    return addon.Util.ReplaceVars(str, vars);
end
string.ReplaceVarsWithMenu = ReplaceVarsWithMenu;

local function HideOptionsButtonCallback(self)
	addon.Options.db.ShowOptionsButton = false;
	self:ShowHide();
end

local menu = LibStub("Krowi_Menu-1.0");
local menuItem = LibStub("Krowi_MenuItem-1.0");
function KrowiMFE_OptionsButtonMixin:BuildMenu()
	-- Reset menu
	menu:Clear();

	local direction = menuItem:New({Text = addon.L["Direction"]});
	self:AddRadioButton(menu, direction, addon.L["Rows first"], addon.Options.db, {"Direction"}, UpdateView);
	self:AddRadioButton(menu, direction, addon.L["Columns first"], addon.Options.db, {"Direction"}, UpdateView);
	menu:Add(direction);

	local rows = menuItem:New({Text = addon.L["Rows"]});
	for i = 1, 10, 1 do
		self:AddRadioButton(menu, rows, i, addon.Options.db, {"NumRows"}, UpdateView);
	end
	menu:Add(rows);

	local columns = menuItem:New({Text = addon.L["Columns"]});
	for i = 2, 6, 1 do
		self:AddRadioButton(menu, columns, i, addon.Options.db, {"NumColumns"}, UpdateView);
	end
	menu:Add(columns);
	menu:AddFull({
		Text = addon.L["Hide"],
		Func = function()
			if not StaticPopup_IsCustomGenericConfirmationShown("KrowiMFE_ConfirmHideOptionsButton") then
				StaticPopup_ShowCustomGenericConfirmation(
					{
						text = addon.L["Are you sure you want to hide the options button?"]:ReplaceVarsWithMenu{
							general = addon.L["General"],
							options = addon.L["Options"]
						},
						callback = function()
							HideOptionsButtonCallback(self);
						end,
						referenceKey = "KrowiMFE_ConfirmHideOptionsButton"
					}
				);
			end
		end
	});
	return menu;
end

function KrowiMFE_OptionsButtonMixin:MyOnMouseDown()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	self:BuildMenu();
    menu:Toggle(self, 96, 15);
end
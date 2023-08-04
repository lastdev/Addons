-- [[ Namespaces ]] --
local addonName, addon = ...;

-- [[ Version data ]] --
local version = (GetBuildInfo());
local major = string.match(version, "(%d+)%.(%d+)%.(%d+)(%w?)");
addon.IsWrathClassic = major == "3";
addon.IsDragonflightRetail = major == "10";

-- [[ Ace ]] --
addon.L = LibStub(addon.Libs.AceLocale):GetLocale(addonName);

-- [[ Load addon ]] --
local loadHelper = CreateFrame("Frame");
loadHelper:RegisterEvent("ADDON_LOADED");

function loadHelper:OnEvent(event, arg1, arg2)
    if event == "ADDON_LOADED" then
        if arg1 == "Krowi_MerchantFrameExtended" then -- This always needs to load
            KrowiMFE_InjectOptions:SetOptionsTable(addon.Options.OptionsTable);
            KrowiMFE_InjectOptions:SetOptions(addon.Options.Defaults.profile);

            addon.Options.Load();

            addon.Gui.MerchantItemsContainer:LoadMaxNumItemSlots();

            addon.Icon.Load();

            addon.Api.Load();
        end
    end
end
loadHelper:SetScript("OnEvent", loadHelper.OnEvent);
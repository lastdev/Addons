local ADDON_NAME, DTH = ...;

local L = DTH.L;

local addonTitle = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Title");
addonTitle = addonTitle:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "");

-- ============================================================
-- Addon Compartment Menu (Blizzard)
-- ============================================================

local function MenuGenerator(owner, rootDescription)
    rootDescription:CreateTitle(addonTitle);

    rootDescription:CreateCheckbox(
        L.AUTO_ACCEPT,
        function()
            return DecorTreasureHuntDB.autoAccept;
        end,
        function()
            DecorTreasureHuntDB.autoAccept = not DecorTreasureHuntDB.autoAccept;
            local message = DecorTreasureHuntDB.autoAccept and L.AUTO_ACCEPT_ENABLED or L.AUTO_ACCEPT_DISABLED;
            print("|cffe6c619" .. addonTitle .. ":|r " .. message);
        end
    );

    rootDescription:CreateCheckbox(
        L.AUTO_TURNIN,
        function()
            return DecorTreasureHuntDB.autoTurnIn;
        end,
        function()
            DecorTreasureHuntDB.autoTurnIn = not DecorTreasureHuntDB.autoTurnIn;
            local message = DecorTreasureHuntDB.autoTurnIn and L.AUTO_TURNIN_ENABLED or L.AUTO_TURNIN_DISABLED;
            print("|cffe6c619" .. addonTitle .. ":|r " .. message);
        end
    );
end

AddonCompartmentFrame:RegisterAddon({
    text = addonTitle,
    icon = "dashboard-panel-homestone-teleport-button",
    func = function(frame, button)
        MenuUtil.CreateContextMenu(frame, MenuGenerator);
    end,
    funcOnEnter = function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT");
        GameTooltip:SetText(addonTitle, 1, 1, 1);
        GameTooltip:AddLine(L.TOOLTIP_TEXT, nil, nil, nil, true);
        GameTooltip:Show();
    end,
    funcOnLeave = function()
        GameTooltip:Hide();
    end
});

-- ============================================================
-- Blizzard Settings (Modern)
-- ============================================================
local category;
function DTH.RegisterSettings()
    category = Settings.RegisterVerticalLayoutCategory(addonTitle);

    do
        local setting = Settings.RegisterAddOnSetting(
            category,
            "DTH_AUTO_ACCEPT",
            "autoAccept",
            DecorTreasureHuntDB,
            Settings.VarType.Boolean,
            L.AUTO_ACCEPT,
            Settings.Default.True
        );

        setting:SetValueChangedCallback(function(_, value)
            local message = value and L.AUTO_ACCEPT_ENABLED or L.AUTO_ACCEPT_DISABLED;
            print("|cffe6c619" .. addonTitle .. ":|r " .. message);
        end);

        Settings.CreateCheckbox(category, setting);
    end

    do
        local setting = Settings.RegisterAddOnSetting(
            category,
            "DTH_AUTO_TURNIN",
            "autoTurnIn",
            DecorTreasureHuntDB,
            Settings.VarType.Boolean,
            L.AUTO_TURNIN,
            Settings.Default.True
        );

        setting:SetValueChangedCallback(function(_, value)
            local message = value and L.AUTO_TURNIN_ENABLED or L.AUTO_TURNIN_DISABLED;
            print("|cffe6c619" .. addonTitle .. ":|r " .. message);
        end);

        Settings.CreateCheckbox(category, setting);
    end

    Settings.RegisterAddOnCategory(category);
end

-- Slash command (optional quick access)
SLASH_DECORTREASUREHUNT1 = "/dth";
SLASH_DECORTREASUREHUNT2 = "/decortreasurehunt";
SlashCmdList.DECORTREASUREHUNT = function()
    Settings.OpenToCategory(category.ID);
end;

-- Contributor: Earthenmist (PR: Blizzard Settings panel + localization)

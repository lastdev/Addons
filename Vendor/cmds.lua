local AddonName, Addon = ...
local L = Addon:GetLocale()

-- This registers all of the commands in this file.
function Addon:SetupConsoleCommands()
    self:RegisterConsoleCommandName(AddonName, "/vendor", "/ven")
    self:AddConsoleCommand(nil, nil, "OpenConfigDialog_Cmd")                        -- Override the default
    self:AddConsoleCommand("rules", L.CMD_RULES_HELP, "OpenConfigDialog_Cmd")
    self:AddConsoleCommand("keys", L.CMD_KEYS_HELP, "OpenKeybindings_Cmd")
    self:AddConsoleCommand("settings", L.CMD_SETTINGS_HELP, "OpenSettings_Cmd")
    self:AddConsoleCommand("withdraw", L.CMD_WITHDRAW_HELP, "Withdraw_Cmd")
    self:AddConsoleCommand("api", L.CMD_API_HELP, "PrintAPI_Cmd")
    self:AddConsoleCommand("history", L.CMD_HISTORY_HELP, "History_Cmd")
    self:AddConsoleCommand("destroy", L.CMD_DESTROY_HELP, "Destroy_Cmd")
    self:AddConsoleCommand("import", "imports", "Import_Cmd")
end

function Addon:Import_Cmd(text)
    local feature = Addon:GetFeature("import")
    if (feature) then
        feature:ShowImportDialog(text)
    end
end

-- This is defunct, but in case we add a hook in...
function Addon:OpenSettings_Cmd()
    Addon:WithFeature("Vendor", function(vendor)
        vendor:ShowDialog("settings")
    end)
end


function Addon:OpenKeybindings_Cmd()
    if Addon.Systems.Info.IsClassicEra then
        -- Blizzard delay-loads the keybinding frame. If it doesn't exist, load it.
        if not KeyBindingFrame then
            KeyBindingFrame_LoadUI()
        end

        -- If we still don't have it, bail.
        if not KeyBindingFrame then
            return
        end

        -- Make sure the buttons and categories exist, and enumerate them.
        if KeyBindingFrameCategoryList and KeyBindingFrameCategoryList.buttons then
            -- Find our category in the list of categories.
            for i, button in pairs(KeyBindingFrameCategoryList.buttons) do
                if button.element and button.element.name and button.element.name == "Vendor Addon" then
                    -- Found it. Click it to set the category.
                    if Addon.Systems.Info.IsClassicEra then
                        KeybindingsCategoryListButton_OnClick(button)
                    else
                        button:OnClick()
                    end
                end
            end
        end

        -- Show the keybinding frame. Even if we dont' find it, its closer.
        KeyBindingFrame:Show()
    else
        Settings.OpenToCategory(54, "Vendor Addon")
    end
end

function Addon:OpenConfigDialog_Cmd()
    Addon:WithFeature("Vendor", function(vendor)
        vendor:ShowDialog("rules")
    end)
end

-- Initiates a manual Auto-Sell. This ignores the auto-sell configuration setting.
function Addon:AutoSell_Cmd()

    local merchant = Addon:GetFeature("Merchant")
    -- Check for merchant not being open.
    if not merchant:IsMerchantOpen() then
        Addon:Output(Addon.Systems.Chat.MessageType.Merchant, L["CMD_AUTOSELL_MERCHANTNOTOPEN"]);
        return
    end

    -- Check for sell in progress.
    if merchant:IsAutoSelling() then
        Addon:Output(Addon.Systems.Chat.MessageType.Merchant, L["CMD_AUTOSELL_INPROGRESS"]);
        return
    end

    -- OK to do the auto-sell.
    Addon:Output(Addon.Systems.Chat.MessageType.Merchant, L["CMD_AUTOSELL_EXECUTING"]);
    merchant:AutoSell()
end

-- Withdraws all items which match your currently enabled rules set
function Addon:Withdraw_Cmd()
    local function findBagWithSpace()
        for i=0,Addon:GetNumTotalEquippedBagSlots()  do
            if C_Container.GetContainerNumFreeSlots(i) ~= 0 then
                return i;
            end
        end
        return -1;
    end

    local items = self:LookForItemsInBank();
    local count = 0;
    if #items then
        for _, item in ipairs(items) do
            local bag, slot, link = unpack(item);
            local tobag = findBagWithSpace();
            if (tobag > 0) then
                Addon:PickupContainerItem(bag, slot);
                PutItemInBag(ContainerIDToInventoryID(tobag));
                Addon:Output(Addon.Systems.Chat.MessageType.Console, L["MERCHANT_WITHDRAW_ITEM"], link);
                count = (count + 1);
            elseif (tobag == 0) then
                PickupContainerItem(bag, slot);
                PutItemInBackpack();
                Addon:Output(Addon.Systems.Chat.MessageType.Console, L["MERCHANT_WITHDRAW_ITEM"], link);
                count = (count + 1);
            else
                break;
            end
        end
    end

    Addon:Output(Addon.Systems.Chat.MessageType.Console, L["MERCHANT_WITHDRAWN_ITEMS"], count);
end

function Addon:Destroy_Cmd()
    Addon:Output(Addon.Systems.Chat.MessageType.Destroy, L.CMD_RUNDESTROY);
    local destroy = Addon:GetFeature("Destroy")
    destroy:DestroyItems()
end

-- Prints the public API
function Addon:PrintAPI_Cmd()
    Addon:PrintPublic()
end

local _, Addon = ...
local locale = Addon:GetLocale()
local Dialog = Addon.CommonUI.Dialog
local EditRuleEvents = Addon.Features.Dialogs.EditRuleEvents

Addon.Features.Dialogs.ItemInfoTab = {

    OnLoad = function(iteminfo)
        iteminfo.itemsFeature = Addon:GetFeature("itemdialog")

        iteminfo.properties.GetClickAction = function(_, model, button, modifier)

            local valueText = model.Value
            if (type(valueText)== "string") then
                valueText = "\"" .. valueText .. "\""
            else
                valueText = tostring(valueText)
            end
    
            if (button == "Right") then
                if not modifier then
                    return model.Name
                elseif modifier == "ALT" then
                    return valueText
                end
            elseif (button == "Left") then
                if not modifier then
                    if (type(model.Value) == "boolean") then
                        return model.Name
                    else
                        return string.format("%s == %s", model.Name, valueText)
                    end
                elseif modifier == "ALT" then
                    if (type(model.Value) == "boolean") then
                        return string.format("not %s", model.Name)
                    else
                        return string.format("%s ~= %s", model.Name, valueText)
                    end
                end
            end
        end

        iteminfo.properties.OnHandleAction = function(_, text)
            iteminfo:TriggerEvent("INSERT_TEXT", iteminfo, text)
        end
    end,

    ShowItemProperties = function(iteminfo, item)
        iteminfo.properties:Rebuild()
    end,

    GetItemProperties = function(iteminfo)
        if (not iteminfo.item:IsItemEmpty()) then
            local itemproperties = Addon:GetSystem("ItemProperties")
            local props = itemproperties:GetItemPropertiesFromItem(iteminfo.item)

            if props then
                return iteminfo.itemsFeature:CreateModels(props)
            end
        end

        iteminfo.item:ClearItem()
        return {}
    end,

    CreatePropertyItem = function(iteminfo, model)
        return iteminfo.itemsFeature:CreateItemForModel(model)
    end,


}
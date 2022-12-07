local AddonName, Addon = ...
local locale = Addon:GetLocale()
local UI = Addon.CommonUI.UI
local ImportRule = {}
local RuleType = Addon.RuleType


-- Common utility?
local function validateString(rule, field)
    local val = rule[field]
    if (type(val) ~= "string") or string.len(val) == 0 then

        return false
    end
    return true
end

--[[ Validate the list payload ]]
function ImportRule:Validate(payload)
    if (type(payload.Items) ~= "table") then

        return false
    end

    local rule = payload.Items[1]

    if (not rule) then

        return false
    end

    if (not validateString(rule, "Name") or
        not validateString(rule, "Description") or
        not validateString(rule, "Script")) then
        return false
    end

    if (not rule.Type) then

        return false
    end

    for _, rtype in pairs(RuleType) do
        if (rule.Type == rtype) then
            return true
        end
    end


    return false
end

--[[ Ensure the imported list has a unique name ]]
function ImportRule:CreateName(imported)
    local rules = Addon:GetFeature("rules")
    local canidate = imported
    local unique = false
    local loop = 1

    while (not unique) do
        unique = true
        local name = string.lower(canidate)
        for _, def in ipairs(rules:GetRules(nil, true)) do
            if (name == string.lower(def.Name)) then
                unique = false
                break
            end
        end

        if (not unique) then
            if (loop == 1) then
                canidate = locale:FormatString("IMPORTLIST_UNIQUE_NAME0", imported)
            else
                canidate = locale:FormatString("IMPORTLIST_UNIQUE_NAME1", imported, loop)
            end
            loop = loop + 1
        end
    end

    return canidate
end

--[[ Create the UI to show what you are importing ]]
function ImportRule:CreateUI(parent, payload)
    local rule = payload.Items[1]
    payload.ImportName = self:CreateName(rule.Name)
    
    local markdown = locale:FormatString("IMPORTRULE_MARKDOWN_FMT", 
            payload.ImportName, rule.Description, 
            payload.Player, payload.Realm)

    return Addon.CommonUI.MarkdownView.Create(parent, markdown)
end

--[[ Handle the importing of the actual list ]]
function ImportRule:Import(payload)
    local rule = payload.Items[1]



    local rules = Addon:GetFeature("rules")
    local ruleDef = Addon.DeepTableCopy(rule)
    ruleDef.Name = payload.ImportName
    ruleDef.ImportedFrom = string.format("%s / %s", payload.Player, payload.Realm)
    ruleDef.IsImported = true

    local newRule = rules:SaveRule(ruleDef, true)
    local editDialog = Addon:GetFeature("dialogs")
    if (editDialog) then
        editDialog:ShowEditRule(newRule.Id, {}, "matches")
    end
end

Addon.Features.Import.ImportRule = ImportRule
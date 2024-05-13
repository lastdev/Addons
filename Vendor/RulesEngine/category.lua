local PackageName, Package = ...;
local CATEGORY_OBJECT_TYPE = (PackageName .. "::Category");

--[[===========================================================================
    | category_Find
    |   Searches this category for a rule which matches the specified id, if
    |   such a rule is found then this returns it, otherwise nil is returned.
    =======================================================================--]]
local function category_Find(self, id)


    for _, rule in ipairs(self.rules) do
        if (rule:CheckMatch(id)) then
            return rule
        end
    end
end

--[[===========================================================================
    | category_Add
    |   Adds the specified rule to the category, if the rule is already in
    |   the category list then this is noop, it will not add the rule a
    |   second time.
    =======================================================================--]]
local function category_Add(self, rule)


    if (not category_Find(self, rule:GetId())) then
        table.insert(self.rules, rule);
    end
end

--[[===========================================================================
    | category_Removes
    |   Removes the provided rule id from this category, if the rule was 
    |   removed then true is returned otherwise false is returned
    =======================================================================--]]
local function category_Remove(self, ruleId)


    local old = self.rules
    self.rules = {}

    for i, rule in ipairs(old) do
        if (not rule:CheckMatch(ruleId)) then
            table.insert(self.rules, rule)
        end
    end

    return (#old ~= #self.rules)
end

--[[===========================================================================
    | category_Reset
    |   This clears all of the rules within this category
    =======================================================================--]]
local function category_Reset(self)
    self.rules = {};
end

--[[===========================================================================
    | category_EvaluateOne
    |   Execute a single rule and return the result
    =======================================================================--]]
local function category_EvaluateOne(self, engine, ruleId, log, environment)
    local rule = category_Find(self, ruleId)
    if (type(rule) == "table") and rule:IsHealthy() then
        log:Write("Evaluating one rule '%s' (weight: %d)", rule:GetId(), 0);
        local success, result, message = rule:Execute(environment)
        if (not success) then
            log:Write("Rule '%s' failed to execute: %s", rule:GetId(), message or "<unknown error>");
            engine.OnRuleStatusChange("UNHEALTHY", self.id, rule:GetId(), rule:GetError())
        else
            log:Write("Rule '%s' evaluated [%s, %s]", rule:GetId(), tostring(result), tostring(message))
            return true, result == true, self.weight + rule:GetWeight()
        end
    end

    return false, false, -1
end

--[[===========================================================================
    | category_Evaluate
    |   This is called to evaluate the rules in this category.  This will
    |   return the rule which evaluated to true otherwise it returns nil.
    |
    |   This only executes healthy rules, the first rule to return a non
    |   false value breaks the loop stops evaluation
    =======================================================================--]]
local function category_Evaluate(self, engine, log, environment)
    local count = 0
    local base = 2 * (#self.rules + 1)
    for index, rule in ipairs(self.rules) do
        if (rule:IsHealthy()) then
            count = count + 1
            
            -- TODO: this should loop and determine the highest weight rule

            log:Write("Evaluating rule '%s' (weight: %d)", rule:GetId(), rule:GetWeight())
            local success, result, message = rule:Execute(environment)
            if (not success) then
                log:Write("Rule '%s' failed to execute: %s", rule:GetId(), message or "<unknown error>");
                engine.OnRuleStatusChange("UNHEALTHY", self.id, rule:GetId(), rule:GetError())
            elseif (result) then
                local weight = rule:GetWeight() or 0
                if (type(weight) == "number" and (weight ~= 0)) then
                    weight = base + weight
                else
                    weight = math.max(0, base - (2 * index))
                end

                log:Write("Evaluated rule '%s' to true (weight: %d)", rule:GetId(), rule:GetWeight())
                return rule, count, nil, (self:GetWeight() + weight)
            end
        else
            -- Skipping rule because it isn't healthy
            log:Write("Skipping rule '%s' (unhealthy)", rule:GetId())
        end
    end

    -- We ran everything and nothing returned a valid result, so we just
    -- want to return the count of rules that we ran.
    return nil, count, nil, 0;
end

--[[===========================================================================
    | category_GetRuleStatus
    |   Queries the health of any rule that matches the arguments and adds
    |   an entry to the table for the health of the rule.
    =======================================================================--]]
local function category_GetRuleStatus(self, status, ...)
    for _, rule in ipairs(self.rules) do
        if (rule:CheckMatch(...)) then
            local health = "HEALTHY";
            if (not rule:IsHealthy()) then
                health = "ERROR";
            end
            table.insert(status, { self.id, rule:GetId(), health, rule:GetExecuteCount(), rule:GetError() });
        end
    end
end

-- Define the category API
local category_API =
{
    Add = category_Add,
    Reset = category_Reset,
    Evaluate = category_Evaluate,
    EvaluateOne = category_EvaluateOne,
    GetName = function(self) return self.name end,
    GetId = function(self) return self.id end,
    GetWeight = function (self) return self.weight end,
    GetRuleStatus = category_GetRuleStatus,
    Find = category_Find,
    Remove = category_Remove,
};

--[[===========================================================================
    | new_Category
    |   Create a new category with the specified name, the name must be a
    |   non-empty string.
    =======================================================================--]]
local function new_Category(id, name, weight)




    local instance =
    {
        name = name,
        id = id,
        rules = {},
        weight = weight or 0
    };

    return Package.CreateObject(CATEGORY_OBJECT_TYPE, instance, category_API);
end

-- Publish the constructor so it's visible to the rest of the package
Package.CreateCategory = new_Category;

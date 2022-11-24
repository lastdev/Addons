local _, Addon = ...;
local RuleConfigObject = {}

-- Helper for debugging


-- Validates if the rule type is valid
local function IsValidRuleType(ruleType)
	if (type(ruleType) ~= "string") then
		return false;
	end

	local valid = false;
	for _, value in pairs(Addon.RuleType)  do
		if (value == ruleType) then
			valid = true;
			break;
		end
	end
	return valid;
end

local function ValidateRuleConfig(config)
	local t = type(config);
	if (t == "string") then	
		local def = Addon.Rules.GetDefinition(config);
		if (not def) then

			return false;
		end

		return true;
	elseif (t == "table") then
		local def = Addon.Rules.GetDefinition(config.rule);
		if (not def) then

			return false;
		end

		return true;
	end
	

	return false;
end

-- Determines if the "rule" matches the specified object.
local function IsRule(rule, ruleId) 
	local t = type(rule);
	if (t == "string") then
		return (rule == ruleId);
	elseif (t == "table") then
		return ((type(rule.rule) == "string") and (rule.rule == ruleId));
	end
	return false;
end

-- Returns the index (if any) of the rule in the list.
local function GetIndexOf(rules, ruleId)

	ruleId = string.lower(ruleId);
	for index, rule in ipairs(rules) do 
		if (IsRule(rule, ruleId)) then
			return index;
		end
	end
end

-- Loads / Populates this object with the contentes of the saved variable.
function RuleConfigObject:Load(saved)

	self.rules = Addon.DeepTableCopy(saved or {});
end

-- Saves our current configuration
function RuleConfigObject:Save()

	return Addon.DeepTableCopy(self.rules or  {});
end

local function CreateConfig(rule)
	local t = type(rule);
	if (t == "string") then
		return t;
	elseif (t == "table") then
		return Addon.DeepTableCopy(rule);
	end

	error("Unknown rule configuration option");
end

-- Adds or updates the configuration for the specified rule.
function RuleConfigObject:Set(ruleId, parameters)
	local rule = ruleId; 
	if (type(parameters) == "table") then
		rule = Addon.DeepTableCopy(parameters);
		rule.rule = ruleId;
	end


	local index = GetIndexOf(self.rules, ruleId);
	if (not index) then

		table.insert(self.rules, rule);
		index = table.getn(self.rules);
	else

		self.rules[index] = rule;
	end

	self:TriggerEvent("OnChanged", self);
	return CreateConfig(self.rules[index]);
end

-- Remove the specified rule from this configuration
function RuleConfigObject:Remove(ruleId)
	local index = GetIndexOf(self.rules, ruleId);
	if (index) then

		table.remove(self.rules, index);
		self:TriggerEvent("OnChanged", self);
		return true
	end
end

-- Returns the config for the specified rule, or nil if there is not rule 
-- in the config with the specified name.
function RuleConfigObject:Get(ruleId)
	local index = GetIndexOf(self.rules, ruleId);
	if (index and (index >= 1)) then
		return CreateConfig(self.rules[index]);
	end
	return nil;
end

function RuleConfigObject:Contains(ruleId)
	local index = GetIndexOf(self.rules, ruleId);
	if (index and (index >= 1)) then
		return true;
	end
	return false;
end

function RuleConfigObject:Commit()
	local profile = assert(Addon:GetProfileManager():GetProfile(), "Expected a valid active profile");
	profile:SetRules(self.type, self.rules);

end

Addon.RuleConfig = {
	-- Create a new empty instance of the rules config object.
	Create = function(self)
		local instance = {
			type = "",
			rules = {},
			profile = falsae,
		};

		return Addon.object("RuleConfig", instance, RuleConfigObject, { "OnChanged" })
	end,

	-- Create instance of the rules config object from the sepcified 
	-- cofiguration variable.
	LoadFrom = function(self, saved)

		local obj = Addon.RuleConfig.Create();
		RuleConfigObject.Load(obj, saved or {});
		return obj;
	end,
}

function Addon.RuleConfig:Get(ruleType)
	if (not IsValidRuleType(ruleType)) then
		error(string.format("The specified rule type '%s' is invalid", ruleType or ""), 2);
	end

	local profile = Addon:GetProfileManager():GetProfile()
	local instance = {
		type = ruleType,
		profile = profile,
		rules = profile:GetRules(ruleType),
	}

	return Addon.object("RuleConfig", instance, RuleConfigObject, { "OnChanged" })
end
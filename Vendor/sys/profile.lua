local AddonName, Addon = ...;
local Profile = {};
local PROFILE_CHANGED = Addon.Events.PROFILE_CHANGED

--[[===========================================================================
   | Retrieves the ID for this profile.
   ==========================================================================]]
function Profile:GetId()

	return self.profileId;
end

--[[===========================================================================
   | Returns true if this state was active
   ==========================================================================]]
function Profile:IsActive()
	return (self.active == true);
end

--[[ Check equallity ]]
function Profile:Equals(other)
	if (other) then
		return self.profileId == other:GetId()
	end
	return false
end

--[[===========================================================================
   | Changes the active state of this profile.
   ==========================================================================]]
function Profile:SetActive(active)
	self.active = (active == true);
end

function Profile:SetDefaultValueSource(source)
	self.defaults = source
end

--[[===========================================================================
   | Called to raise the "OnChanged" event for this profile, gated to handle
   | collesing duplictes.
   ==========================================================================]]
function Profile:RaiseOnChanged()
	--if (self.active) then
		if (self.timer) then
			self.timer:Cancel();
			self.timer = false;
		end

		self.timer = C_Timer.NewTimer(0.15, 
			function() 
				self.timer = false;

				self:TriggerEvent("OnChanged", self);
			end);
	--end	
end

--[[===========================================================================
   | Retrieves the specified value from the profile.
   ==========================================================================]]
function Profile:SetValue(key, value)
	local var = self.profilesVariable:Get(self.profileId) or {};
	--[===[@debug@

	--@end-debug@]===]

	if ((var[key] ~= value) or (type(value) ~= type(var[key]))) then
		if (type(value) ~= "table") then		
			var[key] = value;
		else
			var[key] = Addon.DeepTableCopy(value);
		end


		var["profile:timestamp"] = time();
		self.profilesVariable:Set(self.profileId, var);
		self:RaiseOnChanged();
	end	
end

--[[===========================================================================
   | Sets the sepcified value ini the profile.
   ==========================================================================]]
function Profile:GetValue(key)
	local var = self.profilesVariable:Get(self.profileId) or {};

	--[===[@debug@--

	--@end-debug@]===]

	local value = var[key];	
	if (value == nil) then
		if (type(self.defaults) == "table" and Addon.TableHasKey(key)) then

			local default = self.default[key]
			self:SetValue(key, default)
			value = default
		end
	end
	
	if (type(value) == "table") then
		return Addon.DeepTableCopy(value);
	end

	return value
end

--[[===========================================================================
   | Retrieves the name of this profile.
   ==========================================================================]]
function Profile:GetName()
	return self:GetValue("profile:name") or "<unnamed>";
end

--[[===========================================================================
   | Changes the name of this profile.
   ==========================================================================]]
function Profile:SetName(name)
	if ((type(name) ~= "string") or (string.len(name) == 0)) then
		error("The profile name is invalid it must be a non-empty string")
    end
	self:SetValue("profile:name", name);
end

--[[===========================================================================
   | Creates a new profile with the specified ID (or a new id if not provied)
   ==========================================================================]]
local function CreateProfile(id)
	-- Create the instance data for our profile
	local instance = {
		profileId = id or string.format("%s:%d%04d", AddonName, time(), math.floor(math.random() * 1000)),
		active = false,
		timer = false,
		defaults = false,
		profilesVariable = Addon:CreateSavedVariable("Profiles")
	};
	
	-- Create our object and return it
	return Addon.object("Profile", instance, Addon.TableMerge(Addon.Profile or {}, Profile), { "OnChanged" });
end

Addon.CreateProfile = CreateProfile;

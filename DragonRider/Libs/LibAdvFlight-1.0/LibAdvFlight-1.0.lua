assert(LibStub, "LibStub not found.");

local major, minor = "LibAdvFlight-1.0", 3;

---@class LibAdvFlight-1.0
local LibAdvFlight = LibStub:NewLibrary(major, minor);

if not LibAdvFlight then
    return;
end

--- Event constants - for most cases, contains an 'on' and 'off' event, as well as a toggle event
--- These can be registered using the API functions below, or by just registering a callback w/ the global EventRegistry
---@class LibAdvFlightEvents
local Events = {
    ADV_FLYING_ENABLED = "ADV_FLYING_ENABLED",                              -- Player is able to adv fly (has mounted up)
    ADV_FLYING_DISABLED = "ADV_FLYING_DISABLED",                            -- Player is no longer able to adv fly (dismounted, no flying zone)
    ADV_FLYING_ENABLE_STATE_CHANGED = "ADV_FLYING_ENABLE_STATE_CHANGED",    -- Player's adv flying enable state has changed - args: isAdvFlyEnabled

    ADV_FLYING_START = "ADV_FLYING_START",                                  -- Player has taken off and is flying
    ADV_FLYING_END = "ADV_FLYING_END",                                      -- Player has landed and is no longer flying
    ADV_FLYING_STATE_CHANGED = "ADV_FLYING_STATE_CHANGED",                  -- Player's adv flying state has changed - args: isAdvFlying
                                                                            -- NOTE: vigor levels occasionally return garbage data when you first mount up after logging in
    VIGOR_MAX_CHANGED = "VIGOR_MAX_CHANGED",                                -- Player's max vigor has changed - args: vigorMax
    VIGOR_CHANGED = "VIGOR_CHANGED",                                        -- Player's vigor has changed - args: vigorCurrent
};
LibAdvFlight.Events = Events;


-- Some enum values for standardization
---@enum LibAdvFlightOptionalSpell
local OPTIONAL_SPELLS = {
    SwitchFlightStyle = 436854,
    LightningRush = 447982,
    RideAlong = 447959
};

LibAdvFlight.OptionalSpells = OPTIONAL_SPELLS;

--------------

-- event registry
local Registry = EventRegistry;

--------------

local State = {
    AdvFlyEnabled = false,
    AdvFlying = false,
    VigorCurrent = 0,
    VigorMax = 0,
    ForwardSpeed = 0,
    Heading = 0,
};

--------------

local EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("UNIT_POWER_UPDATE");

function EventFrame:OnEvent(event, ...)
    if type(self[event]) == "function" then
        self[event](self, ...);
    end
end

function EventFrame:OnUpdate()
    local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo();

    -- we are just going off of the changes in our stored state to trigger events
    -- because the relevant events (PLAYER_CAN_GLIDE_CHANGED and PLAYER_IS_GLIDING_CHANGED)
    -- are unreliable

    -- all of these are just
    --  check stored state vs new state
    --  update stored state
    --  fire event and sometimes accompanying toggle event
    -- this code is repetitive but works and is fast enough

    -- adv fly enable state
    if State.AdvFlyEnabled ~= canGlide then
        if State.AdvFlyEnabled and not canGlide then
            State.AdvFlyEnabled = false;
            Registry:TriggerEvent(Events.ADV_FLYING_DISABLED);
        elseif not State.AdvFlyEnabled and canGlide then
            State.AdvFlyEnabled = true;
            Registry:TriggerEvent(Events.ADV_FLYING_ENABLED);
        end

        Registry:TriggerEvent(Events.ADV_FLYING_ENABLE_STATE_CHANGED, State.AdvFlyEnabled);
    end

    -- glide state
    if State.AdvFlying ~= isGliding then
        if State.AdvFlying and not isGliding then
            State.AdvFlying = false;
            Registry:TriggerEvent(Events.ADV_FLYING_END);
        elseif not State.AdvFlying and isGliding then
            State.AdvFlying = true;
            Registry:TriggerEvent(Events.ADV_FLYING_START);
        end

        Registry:TriggerEvent(Events.ADV_FLYING_STATE_CHANGED, State.AdvFlying);
    end

    State.ForwardSpeed = forwardSpeed or 0;
    local heading = GetPlayerFacing();
    State.Heading = heading and heading * (180 / math.pi) or nil;
end

EventFrame:SetScript("OnEvent", EventFrame.OnEvent);
EventFrame:SetScript("OnUpdate", EventFrame.OnUpdate);

local VIGOR_POWER_TYPE = Enum.PowerType.AlternateMount;
function EventFrame:UNIT_POWER_UPDATE(unit, powerType)
    if unit ~= "player" or powerType ~= "ALTERNATE" then
        return;
    end

    local vigorMax = UnitPowerMax("player", VIGOR_POWER_TYPE);
    local vigorCurrent = UnitPower("player", VIGOR_POWER_TYPE);

    -- vigor max
    if State.VigorMax ~= vigorMax then
        State.VigorMax = vigorMax;
        Registry:TriggerEvent(Events.VIGOR_MAX_CHANGED, State.VigorMax);
    end

    -- vigor current
    if State.VigorCurrent ~= vigorCurrent then
        State.VigorCurrent = vigorCurrent;
        Registry:TriggerEvent(Events.VIGOR_CHANGED, State.VigorCurrent);
    end
end

--------------
-- public state accessors

---Returns true if the player has unlocked Skyriding
---@return boolean advFlyUnlocked
function LibAdvFlight.IsAdvFlightUnlocked()
    return C_MountJournal.IsDragonridingUnlocked();
end

--- Returns true if the player has unlocked the ability to switch flight styles
---@return boolean canSwitchFlightStyles
function LibAdvFlight.CanSwitchFlightStyles()
    return LibAdvFlight.HasTalentChoice(OPTIONAL_SPELLS.SwitchFlightStyle);
end

--- Returns true if the player has chosen the lightning rush talent in the Skyriding skill tree
---@return boolean canSwitchFlightStyles
function LibAdvFlight.HasLightningRush()
    return LibAdvFlight.HasTalentChoice(OPTIONAL_SPELLS.LightningRush);
end

--- Returns true if the player has enabled the ability to carry friends with ride along
---@return boolean canSwitchFlightStyles
function LibAdvFlight.HasRideAlongEnabled()
    return LibAdvFlight.HasTalentChoice(OPTIONAL_SPELLS.RideAlong);
end

---@param choice LibAdvFlightOptionalSpell
---@return boolean hasTalent
function LibAdvFlight.HasTalentChoice(choice)
    return IsPlayerSpell(choice)
end

local LIGHTNING_RUSH_AURA_SPELLID = 418590;

---@return number charges Number of lightning rush charges
function LibAdvFlight.GetLightningRushCharges()
    local auraData = C_UnitAuras.GetPlayerAuraBySpellID(LIGHTNING_RUSH_AURA_SPELLID);
    if not auraData then
        return 0;
    end

    return auraData.applications;
end

---Returns true if the player is on a Skyriding mount and can Skyride
---@return boolean advFlyEnabled
function LibAdvFlight.IsAdvFlyEnabled()
    return State.AdvFlyEnabled;
end

---Returns true if the player is currently Skyriding
---@return boolean isAdvFlying
function LibAdvFlight.IsAdvFlying()
    return State.AdvFlying;
end

---@return number vigorMax
function LibAdvFlight.GetMaxVigor()
    return State.VigorMax;
end

---@return number vigorCurrent
function LibAdvFlight.GetCurrentVigor()
    return State.VigorCurrent;
end

---@return number forwardSpeed
function LibAdvFlight.GetForwardSpeed()
    return State.ForwardSpeed;
end

---@return number forwardSpeedRounded
function LibAdvFlight.GetForwardSpeedRounded()
    return Round(State.ForwardSpeed);
end

---Returns current player heading (direction) in degrees
---@return number? heading nil in instances
function LibAdvFlight.GetHeading()
    return State.Heading or nil;
end

---Returns current player heading (direction) in degrees, rounded. 
---@param numDigits number Number of significant digits to round to. If ommitted, will round to the nearest whole number.
---@return number? headingRounded nil in instances
function LibAdvFlight.GetHeadingRounded(numDigits)
    numDigits = numDigits or 0;
    return State.Heading and RoundToSignificantDigits(State.Heading, numDigits) or nil;
end

---Returns current heading (direction) in radians
---@return number? headingRadians nil in instances
function LibAdvFlight.GetHeadingRadians()
    return State.Heading and State.Heading * (math.pi / 180) or nil;
end

--------------
-- public registry accessor

---@class CallbackHandle
---@field Unregister function Unregisters the callback

---@param event string An event from LibAdvFlight.Events
---@param callback function Callback function
---@param owner? table Object passed to callback as the first arg, same as the base CallbackRegistry, if not provided, passes nothing
---@return CallbackHandle handle
function LibAdvFlight.RegisterCallback(event, callback, owner)
    assert(tContains(Events, event), "Invalid event. Expected 'LibAdvFlight.Events' event name.");
    assert(type(callback) == "function", "Invalid callback. Expected 'function'.");

    local handle;
    if owner then
        handle = Registry:RegisterCallbackWithHandle(event, callback, owner);
    else
        local cb = function(_, ...)
            callback(...);
        end
        handle = Registry:RegisterCallbackWithHandle(event, cb);
    end

    return handle;
end
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Simulations", tonumber("20141220081111") or time()) then
   return
end

local UnitPowerMax = UnitPowerMax
local math = math
local pairs = pairs

local sim
local state

function c.SetSim(s)
   sim = s
end

function c.SetSimState(s)
   state = s
end

local function addPower(amount)
--c.Debug("Sim", "addPower", amount)
   state.Power = math.max(0, math.min(
      UnitPowerMax("player"), state.Power + amount))
end

local function advance(toElapse)
--c.Debug("Sim", "advance", toElapse)
   state.Timers.Stop = toElapse
   while true do
      local minTime = 9999999
      local minTimer
      for timer, time in pairs(state.Timers) do
         if time >= 0 and time < minTime then
            minTime = time
            minTimer = timer
         end
      end
      addPower(minTime * state.Regen)
      for timer, time in pairs(state.Timers) do
         state.Timers[timer] = time - minTime
      end
      if minTimer == "Stop" then
         return
      end

      local handler = sim.Handlers[minTimer]
      if handler then
         handler(state)
      end
   end
end

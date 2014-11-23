local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetComboPoints = GetComboPoints
local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local UnitPowerMax = UnitPowerMax
local math = math
local select = select
local string = string

local anticipationTransfer = 0
local relentlessPending = 0
local ruthlessnessPending = 0
local finishers = { 
	"Slice and Dice", "Rupture", "Envenom", "Recuperate", "Eviscerate" 
}
local anticipationTriggers = {
	"Rupture", "Envenom", "Eviscerate"
}

local function triggersRelentless(info)
	return c.InfoMatches(info, finishers)
		and GetComboPoints("player") == 5
		and c.HasSpell("Relentless Strikes")
end

local function processCast(info)
	if triggersRelentless(info) then
		local now = GetTime()
		relentlessPending = now
		if c.InfoMatches(info, anticipationTriggers) then
			anticipationTransfer = now
			c.Debug("Event", "Anticipation Charges will transfer")
		end
--	elseif c.InfoMatches(info, "Expose Armor") then
--		a.ExposePending = true
--		c.Debug("Event", "Expose Armor pending")
	end
end

local function maybeConsumeRelentless(id)
	if id == c.GetID("Relentless Strikes") then
		relentlessPending = 0
	end
end

local function unpendExpose(id)
--	if id == c.ARMOR_DEBUFFS then
--		a.ExposePending = false
--		c.Debug("Event", "Expose Armor applied")
--	end
end

a.Rotations = {}

function a.PreFlash()
	
	-- Calc power
	a.Regen = select(2, GetPowerRegen())
	a.CP = GetComboPoints("player")
	a.Energy = c.GetPower(a.Regen)
	local now = GetTime()
	if now - relentlessPending < .8 
		or triggersRelentless(c.GetQueuedInfo()) then
		
		a.Energy = math.min(UnitPowerMax("player"), a.Energy + 25)
	end
	
	-- Calc cp
--	local bladed = s.Buff(c.GetID("Shadow Blades"), "player") 
--		or c.IsCasting("Shadow Blades")
	local anticipation = c.HasTalent("Anticipation")
	if c.IsCasting("Marked for Death") then
		a.CP = a.CP + 5
	end
	if c.IsCasting("Premeditation") then
		a.CP = a.CP + 2
	end
	if now - ruthlessnessPending < .8 then
		a.CP = a.CP + 1
	end
	if anticipation 
		and (a.CP >= 5 
			or now - anticipationTransfer < .9 
			or c.IsCasting(anticipationTriggers)) then
	
		a.CP = a.CP + c.GetBuffStack("Anticipation")
	end
	if c.IsCasting(
		"Sinister Strike", 
		"Backstab", 
		"Dispatch",
		"Revealing Strike", 
		"Shuriken Toss",
		"Hemorrhage"
--		,"Expose Armor"
		) then
		
		a.CP = a.CP + 1
		if bladed then
			a.CP = a.CP + 1
		end
	elseif c.IsCasting(finishers) then
		if a.CP >= 5 and c.HasSpell("Ruthlessness") then
			a.CP = a.CP - 4
		else
			a.CP = a.CP - 5
		end
	elseif c.IsCasting("Mutilate", "Ambush") then
		a.CP = a.CP + 2
		if bladed then
			a.CP = a.CP + 1
		end
	end
	if anticipation then
		a.CP = math.max(0, math.min(10, a.CP))
		a.EmptyCP = 10 - a.CP
	else
		a.CP = math.max(0, math.min(5, a.CP))
		a.EmptyCP = 5 - a.CP
	end
	
	-- Other frequently used values
	a.Rupture = c.GetMyDebuffDuration("Rupture", false, false, true)
	a.SnD = c.GetBuffDuration("Slice and Dice", false, false, true)
end

----------------------------------------------------------------- Assassination
a.Rotations.Assassination = {
	Spec = 1,
	

--	UsefulStats = { "Agility", "Crit", "Haste", "Melee Hit", "Strength" },
--  UsefulStats = { "Agility", "Crit", "Haste" },
    UsefulStats = { "Agility", "Crit", "Multistrike", "Versatility", "Mastery", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Vendetta",
--			"Shadow Blades",
			"Marked for Death",
--			"Expose Armor",
			"Recuperate",
			"Shiv", 
			"Kick",
			"Death from Above",
			"Shadow Reflection"
			)
		
		if c.HasBuff("Vanish", false, false, true)
			or c.HasBuff("Subterfuge")
			or c.HasBuff("Stealth") then
			
			c.PriorityFlash("Envenom", "Ambush", "Dispatch", "Mutilate")
		else
		    local flashing -- Don't forget to comment this line if you comment if/else
		    
		    if UnitLevel("player") >= 92 then
		        flashing = c.PriorityFlash(
--				    "Envenom to refresh Slice and Dice",
--				    "Slice and Dice for Assassination",
                    "Dispatch pre-Rupture",
		        	"Mutilate pre-Rupture",
		        	"Rupture for Assassination",
		        	"Envenom for Buff",
		        	"Dispatch pre-Envenom",
		        	"Mutilate pre-Envenom",
		        	"Envenom",
--				    "Tricks of the Trade unglyphed",
		        	"Dispatch",
		        	"Mutilate",
		        	"Preparation",
--                  "Tricks of the Trade glyphed",
		        	"Shuriken Toss"
                    )
            else
                flashing = c.PriorityFlash(
				    "Envenom to refresh Slice and Dice",
				    "Slice and Dice for Assassination",
				    "Dispatch pre-Rupture",
				    "Mutilate pre-Rupture",
				    "Rupture for Assassination",
				    "Envenom for Buff",
				    "Dispatch pre-Envenom",
				    "Mutilate pre-Envenom",
				    "Envenom",
--				    "Tricks of the Trade unglyphed",
				    "Dispatch",
				    "Mutilate",
				    "Preparation",
--				    "Tricks of the Trade glyphed",
				    "Shuriken Toss"
				    )
		    end
		    
		    
--			local flashing = c.PriorityFlash( -- "local Flashing" is already declared above of if/else, so remove "local" if you have to
--				"Envenom to refresh Slice and Dice",
--				"Slice and Dice for Assassination",
--				"Dispatch pre-Rupture",
--				"Mutilate pre-Rupture",
--				"Rupture for Assassination",
--				"Envenom for Buff",
--				"Dispatch pre-Envenom",
--				"Mutilate pre-Envenom",
--				"Envenom",
--				"Tricks of the Trade unglyphed",
--				"Dispatch",
--				"Mutilate",
--				"Preparation",
--				"Tricks of the Trade glyphed",
--				"Shuriken Toss",
--		        "Death from Above"
--				)
				
			local vanish = c.GetSpell("Vanish for Assassination")
			if c.HasTalent("Nightstalker") then
				if flashing 
					and string.find(flashing, "Envenom") then
					
					c.MakePredictor(vanish, a.Energy < 35, "yellow")
					c.FlashAll("Vanish for Assassination")
				end
			elseif c.HasTalent("Shadow Focus") then
				if a.EmptyCP >= 3 and a.Energy + 2 * a.Regen < 100 then
					c.MakePredictor(vanish, false, "yellow")
					c.FlashAll("Vanish for Assassination")
				end
			elseif a.EmptyCP >= 3 then
				c.MakePredictor(vanish, a.Energy < 60, "yellow")
				c.FlashAll("Vanish for Assassination")
			end
		end
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
		else
			c.FlashAll("Recuperate Out of Combat")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
		    "Deadly Poison",
		    "Non-Lethal Poison"
--		    ,"Redirect"
		    )
	end,
	
	CastSucceeded = processCast,
	
	Energized = maybeConsumeRelentless,
	
	AuraApplied = unpendExpose,
	
	ExtraDebugInfo = function()
		return string.format("c:%d a:%d c:%d e:%.1f r:%.1f",
			GetComboPoints("player"), 
			c.GetBuffStack("Anticipation"), 
			a.CP, 
			a.Energy, 
			a.Rupture)
	end,
}

------------------------------------------------------------------------ Combat
local guile = 0
a.Rotations.Combat = {
	Spec = 2,
	
--	UsefulStats = { "Agility", "Melee Hit", "Strength", "Crit", "Haste" },
--  UsefulStats = { "Agility", "Crit", "Haste" },
    UsefulStats = { "Agility", "Multistrike", "Versatility", "Crit", "Haste", "Mastery" },
		
	FlashInCombat = function()
		if c.IsQueued("Sinister Strike", "Revealing Strike") then
			a.Guile = guile + 1
		else
			a.Guile = guile
		end
		
		if a.Guile >= 8 and not s.Buff(c.GetID("Deep Insight"), "player") then
			a.DeepInsight = 15
		else
			a.DeepInsight = c.GetBuffDuration("Deep Insight")
		end
		
		c.FlashAll(
--			"Shadow Blades for Combat",
			"Killing Spree",
			"Adrenaline Rush", 
			"Vanish for Combat", 
			"Marked for Death for Combat",
--			"Expose Armor",
			"Recuperate",
			"Shiv", 
			"Kick",
			"Death from Above",
			"Shadow Reflection"
			)
		c.PriorityFlash(
			"Ambush", 
			"Slice and Dice for Combat", 
			"Revealing Strike if Down",
--			"Rupture for Combat",
			"Eviscerate for Combat",
--			"Tricks of the Trade unglyphed",
			"Revealing Strike",
			"Sinister Strike",
			"Preparation",
--			"Tricks of the Trade glyphed",
			"Shuriken Toss"
			)
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
		else
			c.FlashAll("Recuperate Out of Combat")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
		    "Deadly Poison",
		    "Non-Lethal Poison"
--		    ,"Redirect"
		    )
	end,
	
	CastSucceeded = function(info)
		processCast(info)
		if c.InfoMatches(info, "Sinister Strike", "Revealing Strike") then
			guile = guile + 1
			c.Debug("Event", "Guile Bump", guile)
		elseif c.InfoMatches(info, finishers) 
			and GetComboPoints("player") == 5 then
			
			ruthlessnessPending = GetTime()
			c.Debug("Event", "Ruthlessness Pending")
		end
	end,
	
	CastSucceeded_FromLog = function(spellID)
--		if c.IdMatches(spellID, "Ruthlessness Energize") then
--			ruthlessnessPending = 0
--			c.Debug("Event", "Ruthlessness Happened")
--		end
	end,
	
	SpellMissed = function(spellID)
		if c.IdMatches(spellID, "Sinister Strike", "Revealing Strike") then
			guile = guile - 1
			c.Debug("Event", "Never mind on Guile; it missed.")
		elseif c.IdMatches(spellID, finishers) then
			ruthlessnessPending = 0
			c.Debug("Event", "Ruthlessness Missed")
		end
	end,
	
	Energized = maybeConsumeRelentless,
	
	AuraApplied = function(spellID)
		unpendExpose(spellID)
		if spellID == c.GetID("Shallow Insight") then
			if guile < 4 then
				guile = 4
				c.Debug("Event", "Guile Set to 4")
			end
		elseif spellID == c.GetID("Moderate Insight") then
			if guile < 8 then
				guile = 8
				c.Debug("Event", "Guile Set to 8")
			end
		elseif spellID == c.GetID("Deep Insight") then
			guile = 0
			c.Debug("Event", "Guile Set to 0")
		end
	end,
	
	AuraRemoved = function(spellID)
		if c.IdMatches(
			spellID, "Shallow Insight", "Moderate Insight", "Deep Insight") then
			
			guile = 0
			c.Debug("Event", "Guile Reset")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("c:%d c:%d g:%d d:%.1f e:%.1f",
			GetComboPoints("player"), a.CP, a.Guile, a.DeepInsight, a.Energy)
	end,
}

---------------------------------------------------------------------- Subtlety
local lastEnergeticRecovery = 0
a.ConsumedNextRecovery = false

a.Rotations.Subtlety = {
	Spec = 3,
	
--	UsefulStats = { "Agility", "Melee Hit", "Strength", "Crit", "Haste" },
--  UsefulStats = { "Agility", "Crit", "Haste" },
    UsefulStats = { "Agility", "Multistrike", "Crit", "Versatility", "Mastery", "Haste" },
	
	FlashInCombat = function()
		local snd = s.BuffDuration(c.GetID("Slice and Dice"), "player")
		if snd > 5 and c.HasSpell("Energetic Recovery") then
			local nextTick = snd % 2
			local busy = c.GetBusyTime()
			local recentRealTick = GetTime() - lastEnergeticRecovery < 1
			if not recentRealTick and (nextTick <= busy or nextTick > 1.5) then
				a.Energy = math.min(100, a.Energy + 8)
--c.Debug("Recovery", "add energetic", nextTick)
			end
			if nextTick <= busy or (nextTick < .5 and recentRealTick) then
				if nextTick == snd then
					nextTick = -1
				else
					nextTick = nextTick + 2
				end
			end
			a.RecoveryDelay = nextTick - busy
		else
			a.RecoveryDelay = -1
		end
		
		a.NeedsWeakness = 
			not c.HasMyDebuff("Find Weakness", false, false, "Ambush")
		a.NoStealthiness =
			not (c.HasBuff("Shadow Dance", false, false, true)
				or c.HasBuff("Vanish", false, false, true)
				or c.HasBuff("Subterfuge")
				or c.HasBuff("Stealth"))
		
		c.FlashAll(
--			"Shadow Blades",
			"Premeditation", 
			"Recuperate", 
--			"Expose Armor",
			"Shiv", 
			"Kick",
			"Death from Above"
			)
		if c.FlashAll("Ambush for Subtlety") then
			return
		end
		
		c.FlashAll(
			"Shadow Dance",
			"Vanish for Subtlety",
			"Marked for Death",
			"Shadow Reflection"
			)
		
		local bankCharges =
			c.HasTalent("Anticipation")
				and a.CP < 9
				and a.SnD > 5
				and a.Rupture > 5
				and (a.SnD < 6 or a.Rupture < 6)
		if a.CP >= 5 and not bankCharges then
			c.PriorityFlash(
				"Slice and Dice for Subtlety",
				"Rupture for Subtlety",
				"Eviscerate for Subtlety",
				"Preparation"
--				,"Tricks of the Trade"
				)
		elseif bankCharges 
			or a.CP < 4 
			or a.Energy > 80 
			or c.HasTalent("Anticipation")
			or c.IsSolo() then
			
			c.PriorityFlash(
				"Hemorrhage for Bleed",
--				"Tricks of the Trade unglyphed",
				"Backstab",
				"Hemorrhage if no Backstab",
				"Preparation",
--				"Tricks of the Trade",
				"Shuriken Toss"
				)
		else
			c.PriorityFlash(
				"Preparation"
--				,"Tricks of the Trade"
				)
		end
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
		else
			c.FlashAll("Recuperate Out of Combat")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
		    "Deadly Poison",
		    "Non-Lethal Poison"
--		    ,"Redirect"
		    )
	end,
	
	CastSucceeded = processCast,
	
	Energized = function(spellID)
		maybeConsumeRelentless(spellID)
		if c.IdMatches(spellID, "Slice and Dice") then
			lastEnergeticRecovery = GetTime()
--c.Debug("Event", "Energetic Recovery", s.BuffDuration(c.GetID("Slice and Dice"), "player"))
		end
	end,
	
	AuraApplied = function(spellID)
		unpendExpose(spellID)
		if c.IdMatches(spellID, "Slice and Dice")
			and not s.Buff(c.GetID("Slice and Dice", "player")) then
			
			lastEnergeticRecovery = GetTime()
			c.Debug("Event", "New Slice and Dice")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("c:%d e:%.1f r:%.1f b:%.1f r:%.1f s:%.1f", 
			a.CP, 
			a.Energy, 
			a.RecoveryDelay, 
			c.GetBusyTime(),
			a.Rupture,
			a.SnD)
	end,
}

local ADDON, NS = ...
NS.UI = NS.UI or {}

local Goals = NS.UI.LumberTrackGoals or {}
NS.UI.LumberTrackGoals = Goals

local cachedGoals = {}
local cacheValid = false
local reagentCache = {}
local loadAttempts = {}
local LOAD_RETRY_DELAY = 5

local function IsCollected(itemID)
  local Collection = NS.Systems and NS.Systems.Collection
  if Collection and Collection.IsCollected then
    local itemObj = { itemID = itemID }
    local success, result = pcall(Collection.IsCollected, Collection, itemObj)
    if success then return result end
  end
  if NS and NS.Store and NS.Store.GetState then
    local state = NS.Store:GetState()
    if state and state.collection and state.collection.completedItems then
      return state.collection.completedItems[itemID] == true
    end
  end
  local addon = NS and NS.Addon
  local prof = addon and addon.db and addon.db.profile
  local collection = prof and prof.collection
  if collection and collection.completedItems then
    return collection.completedItems[itemID] == true
  end
  return false
end
local function GetRecipeReagentsFromAPI(recipeID)
  if not recipeID then return nil end
  if reagentCache[recipeID] then return reagentCache[recipeID] end
  local now = (time and time()) or GetTime()
  if loadAttempts[recipeID] and (now - loadAttempts[recipeID]) < LOAD_RETRY_DELAY then
    return nil
  end
  local success, schematic = pcall(C_TradeSkillUI.GetRecipeSchematic, recipeID, false)
  if not success or not schematic then
    loadAttempts[recipeID] = now
    return nil
  end
  if not schematic.reagentSlotSchematics or #schematic.reagentSlotSchematics == 0 then
    reagentCache[recipeID] = {}
    return {}
  end
  local reagents = {}
  for si, reagentSlot in ipairs(schematic.reagentSlotSchematics) do
    if reagentSlot.reagents and #reagentSlot.reagents > 0 then
      local reagent = reagentSlot.reagents[1]
      if reagent and reagent.itemID then
        table.insert(reagents, {
          itemID = reagent.itemID,
          count = reagentSlot.quantityRequired or 1
        })
      end
    end
  end
  reagentCache[recipeID] = reagents
  return reagents
end
local function GetReagentsForItem(item)
  if not item then return nil end
  if item.reagents and #item.reagents > 0 then return item.reagents end
  if item.source and item.source.skillID then
    local apiReagents = GetRecipeReagentsFromAPI(item.source.skillID)
    if apiReagents and #apiReagents > 0 then return apiReagents end
  end
  return nil
end
local function CalculateLumberNeedsFromProfessions(lumberItemID)
  if not lumberItemID then return 0 end
  local Professions = NS.Data and NS.Data.Professions
  if not Professions or type(Professions) ~= "table" then return 0 end
  local totalNeeded = 0
  for professionName, professionData in pairs(Professions) do
    if type(professionData) == "table" then
      for expansionName, items in pairs(professionData) do
        if type(items) == "table" then
          for ii, item in ipairs(items) do
            if item and item.source and item.source.itemID then
              local itemID = item.source.itemID
              if not IsCollected(itemID) then
                local reagents = GetReagentsForItem(item)
                if reagents then
                  for ri, reagent in ipairs(reagents) do
                    if reagent.itemID == lumberItemID then
                      local amount = reagent.count or reagent.qty or reagent.amount or 1
                      totalNeeded = totalNeeded + amount
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return totalNeeded
end
function Goals:CalculateGoalForLumber(lumberItemID)
  if not lumberItemID then return 0 end
  return CalculateLumberNeedsFromProfessions(lumberItemID)
end
function Goals:CalculateAllGoals(counts)
  if not counts then return {} end
  local goals = {}
  for lumberItemID in pairs(counts) do
    goals[lumberItemID] = self:CalculateGoalForLumber(lumberItemID)
  end
  return goals
end
function Goals:GetGoal(lumberItemID, ctx)
  local db = ctx and ctx.GetDB and ctx.GetDB()
  local autoGoal = db and db.autoGoal
  if autoGoal then
    if not cacheValid then
      cachedGoals = {}
      cacheValid = true
    end
    if not cachedGoals[lumberItemID] then
      cachedGoals[lumberItemID] = self:CalculateGoalForLumber(lumberItemID)
    end
    return cachedGoals[lumberItemID]
  else
    return tonumber((db and db.goal) or 1000)
  end
end
function Goals:InvalidateCache()
  cacheValid = false
  cachedGoals = {}
end
function Goals:ClearReagentCache()
  reagentCache = {}
  loadAttempts = {}
end
function Goals:RefreshGoals(ctx)
  self:InvalidateCache()
  local Render = NS.UI.LumberTrackRender
  if Render and Render.Refresh then
    Render:Refresh(ctx)
  end
end
function Goals:GetTotalGoal(ctx)
  local db = ctx and ctx.GetDB and ctx.GetDB()
  local autoGoal = db and db.autoGoal
  if not autoGoal then
    return tonumber((db and db.goal) or 1000)
  end
  if not ctx or not ctx.counts then return 0 end
  local total = 0
  for lumberItemID in pairs(ctx.counts) do
    total = total + self:GetGoal(lumberItemID, ctx)
  end
  return total
end
function Goals:CanAutoCalculate()
  local Professions = NS.Data and NS.Data.Professions
  if not Professions or type(Professions) ~= "table" then return false end
  for professionName, professionData in pairs(Professions) do
    if type(professionData) == "table" then
      for expansionName, items in pairs(professionData) do
        if type(items) == "table" and #items > 0 then
          return true
        end
      end
    end
  end
  return false
end
function Goals:GetGoalTooltip(lumberItemID, ctx)
  local goal = self:GetGoal(lumberItemID, ctx)
  local db = ctx and ctx.GetDB and ctx.GetDB()
  local autoGoal = db and db.autoGoal
  if not autoGoal then
    return "Manual Goal: " .. goal .. "\n|cff888888(Set in Settings)|r"
  end
  if goal > 0 then
    return "Auto Goal: " .. goal .. "\n|cff888888Based on housing decor recipes you haven't crafted|r"
  else
    return "Auto Goal: 0\n|cff888888All known housing decor using this lumber is complete|r"
  end
end
function Goals:PreloadRecipeData()
  local Professions = NS.Data and NS.Data.Professions
  if not Professions then return end
  for professionName, professionData in pairs(Professions) do
    if type(professionData) == "table" then
      for expansionName, items in pairs(professionData) do
        if type(items) == "table" then
          for ii, item in ipairs(items) do
            if item and item.source and item.source.skillID then
              if not reagentCache[item.source.skillID] then
                GetRecipeReagentsFromAPI(item.source.skillID)
              end
            end
          end
        end
      end
    end
  end
end
return Goals
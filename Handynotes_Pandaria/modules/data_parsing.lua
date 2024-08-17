local _, addon = ...;

local tinsert = _G.tinsert;

local GetAchievementNumCriteria = _G.GetAchievementNumCriteria;
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo;

local function parseData ()
  local rareInfo = addon.rareData;
  local treasureInfo = addon.treasureData;

  local function parseAchievementdata ()
    local achievementData = addon.achievementData;

    if (achievementData == nil) then return end

    local function addAchievementInfo (infoTable, id, achievementId, criteriaIndex)
      local data;

      infoTable[id] = infoTable[id] or {};
      data = infoTable[id];

      if (data.achievements == nil) then
        data.achievements = achievementId;
        data.criteria = criteriaIndex;
      elseif (type(data.achievements) == 'table') then
        tinsert(data.achievements, achievementId);
        tinsert(data.criteria, criteriaIndex);
      else
        data.achievements = {data.achievements, achievementId};
        data.criteria = {data.criteria, criteriaIndex};
      end

      return data;
    end

    local function parseRareData ()
      local rareAchievementData = achievementData.rares;

      if (rareAchievementData == nil) then return end

      local function addRareAchievementInfo (rareId, achievementId, criteriaIndex)
        local rareData = addAchievementInfo(rareInfo, rareId, achievementId, criteriaIndex);

        if (rareData.name == nil and criteriaIndex > 0) then
          local numCriteria = GetAchievementNumCriteria(achievementId);

          if (numCriteria >= criteriaIndex) then
            local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, criteriaIndex)};

            rareData.name = criteriaInfo[1];
          end
        end
      end

      local function parseDynamicData ()
        local achievementList = rareAchievementData.auto;

        if (achievementList == nil) then return end

        for x = 1, #achievementList, 1 do
          local achievementId = achievementList[x];
          local numCriteria  = GetAchievementNumCriteria(achievementId);

          for y = 1, numCriteria, 1 do
            local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, y)};
            local rareId = criteriaInfo[8];

            -- -- this is for detecting unhandled rares
            -- if (rareId == nil or rareId == 0) then
            --   print(y, criteriaInfo[1], '-', rareId);
            -- end

            addRareAchievementInfo(rareId, achievementId, y);
          end
        end
      end

      local function parseStaticData ()
        local staticData = rareAchievementData.static;

        if (staticData == nil) then return end

        for achievement, rareList in pairs(staticData) do
          for x = 1, #rareList, 1 do
            local rareData = rareList[x];

            if (type(rareData) ~= 'table') then
              rareData = {id = rareData};
            end

            addRareAchievementInfo(rareData.id, achievement, rareData.index or x);
          end
        end
      end

      parseDynamicData();
      parseStaticData();
    end

    local function parseTreasureData ()
      local treasureAchievementData = achievementData.treasures;

      if (treasureAchievementData == nil) then return end

      local function addTreasureAchievementInfo (treasureId, achievementId, criteriaIndex)
        addAchievementInfo(treasureInfo, treasureId, achievementId, criteriaIndex);
      end

      local function parseDynamicData ()
        local achievementList = treasureAchievementData.auto;

        if (achievementList == nil) then return end

        for _, achievementId in ipairs(achievementList) do
          local numCriteria  = GetAchievementNumCriteria(achievementId);

          for x = 1, numCriteria, 1 do
            local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, x)};
            local treasureId = criteriaInfo[8];

            -- -- this is for detecting unhandled rares
            -- if (rareId == nil or rareId == 0) then
            --   print(y, criteriaInfo[1], '-', rareId);
            -- end

            addTreasureAchievementInfo(treasureId, achievementId, x);
          end
        end
      end

      local function parseStaticData ()
        local staticData = treasureAchievementData.static;

        if (staticData == nil) then return end

        for achievement, treasureList in pairs(staticData) do
          for x = 1, #treasureList, 1 do
            local treasureData = treasureList[x];

            if (type(treasureData) ~= 'table') then
              treasureData = {id = treasureData};
            end

            addTreasureAchievementInfo(treasureData.id, achievement,
                treasureData.index or -1);
          end
        end
      end

      parseDynamicData();
      parseStaticData();
    end

    parseRareData();
    parseTreasureData();
  end

  parseAchievementdata();
  addon.achievementData = nil;
end

--[[ Some character and anchievement data is only available after PLAYER_LOGIN
     and event callbacks are not called in order. Therefore waiting for one
     frame after PLAYER_LOGIN is required. ]]
addon.onOnce('PLAYER_LOGIN', function ()
  _G.C_Timer.After(0, function ()
    parseData();
    addon.integrateWithHandyNotes();
  end);
end);

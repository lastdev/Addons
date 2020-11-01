local addonName, shared = ...;

local addon = shared.addon;

local function parseData ()
  local rareInfo = shared.rareData;
  local treasureInfo = shared.treasureData;

  local function parseMountData ()
    local mountData = shared.mountData;

    if (mountData == nil) then return end

    for mountId, rareList in pairs(mountData) do
      if (type(rareList) ~= 'table') then
        rareList = {rareList};
      end

      for x = 1, #rareList, 1 do
        local rareId = rareList[x];
        local rareData = rareInfo[rareId];

        if (rareData == nil) then
          rareInfo[rareId] = {mounts = {mountId}};
        elseif (rareData.mounts == nil) then
          rareData.mounts = {mountId};
        else
          table.insert(rareData.mounts, mountId);
        end
      end
    end

    shared.mountData = nil;
  end

  local function parseToyData ()
    local toyData = shared.toyData;

    if (toyData == nil) then return end

    for toyId, rareList in pairs(toyData) do
      if (type(rareList) ~= 'table') then
        rareList = {rareList};
      end

      for x = 1, #rareList, 1 do
        local rareId = rareList[x];
        local rareData = rareInfo[rareId];

        if (rareData == nil) then
          rareInfo[rareId] = {toys = {toyId}};
        elseif (rareData.toys == nil) then
          rareData.toys = {toyId};
        else
          table.insert(rareData.toys, toyId);
        end
      end
    end

    shared.toyData = nil;
  end


  local function parseAchievementdata ()
    local achievementData = shared.achievementData;

    if (achievementData == nil) then return end

    local function addAchievementInfo (infoTable, id, achievementId, criteriaIndex)
      local data;

      infoTable[id] = infoTable[id] or {};
      data = infoTable[id];

      data.achievements = data.achievements or {};
      table.insert(data.achievements, {
        id = achievementId,
        index = criteriaIndex,
      });
    end

    local function parseRareData ()
      local rareAchievementData = achievementData.rares;

      if (rareAchievementData == nil) then return end

      local function addRareAchievementInfo (rareId, achievementId, criteriaIndex, description)
        local rareData;

        addAchievementInfo(rareInfo, rareId, achievementId, criteriaIndex);

        rareData = rareInfo[rareId];

        if (rareData.name == nil and criteriaIndex > 0) then
          local numCriteria = GetAchievementNumCriteria(achievementId);

          if (numCriteria >= criteriaIndex) then
            local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, criteriaIndex)};

            rareData.name = criteriaInfo[1];
          end
        end

        rareData.description = rareData.description or description;
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

            addRareAchievementInfo(rareData.id, achievement,
                rareData.index or -1, rareData.description);
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
                treasureData.index or -1, treasureData.description);
          end
        end
      end

      parseStaticData();
    end

    parseRareData();
    parseTreasureData();
  end

  parseMountData();
  parseToyData();
  parseAchievementdata();

  shared.achievementData = nil;
  shared.mountData = nil;
end

addon.on('PLAYER_LOGIN', parseData);

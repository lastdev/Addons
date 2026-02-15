function achiInfo(achievementId, depth)
    depth = depth or 0

    local _, achiName = GetAchievementInfo(achievementId)
    local o = string.rep(" ", depth * 2)
    print(o .. "#" .. achievementId)

    local returnData = {
        id = achievementId,
        name = achiName
    }

    local rewards = {}
    local numberOfRewards = GetAchievementNumRewards(achievementId)

    if type(numberOfRewards) == "number" then
        for i = 1, numberOfRewards do
            rewards[i] = {GetAchievementCriteriaInfoByID(achievementId, i)}
        end

        if #rewards > 0 then
            returnData[rewards] = rewards
        end
    end

    local tmpChildren = {}
    local tmpCriteria = {}

    local achiCriteriaNumber = GetAchievementNumCriteria(achievementId)

    for i = 1, achiCriteriaNumber do
        local criteriaString, criteriaType, _, _, _, _, _, assetID, _, criteriaID, _, _, _ = GetAchievementCriteriaInfo(achievementId, i)

        print(o .. " >" .. i .. " - " .. criteriaType)

        if criteriaType == 8 then -- another achievement
            print(o .. ".")
            tmpChildren[#tmpChildren+1] = achiInfo(assetID)
        else
            tmpCriteria[#tmpCriteria+1] = {
                id = criteriaID,
                name = criteriaString,
                criteriaType = criteriaType
            }
        end
    end

    if #tmpChildren > 0 then
        print(o .. "##")
        returnData["children"] = tmpChildren
    end

    if #tmpCriteria > 0 then
        print(o .. ">>")
        returnData["criteria"] = tmpCriteria
    end

    return returnData
end

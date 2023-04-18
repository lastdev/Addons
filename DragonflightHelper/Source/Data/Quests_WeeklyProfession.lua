local SkillIds = DFH_Constants.SkillIds

DFH_Constants.ProfessionQuests.WeeklyProfession = {
  title = "Valdrakken Weekly Profession",
  [SkillIds.Alchemy] = {
    completionCount = 1,
    -- Dhurrel <Trade Liaison>
    { questId = 72427 }, { questId = 66940 }, { questId = 66938 },
    -- Dothenos <Trade Coordinator>
    { questId = 66937 } },
  [SkillIds.Leatherworking] = {
    completionCount = 1,
    -- Dhurrel <Trade Liaison>
    { questId = 66363 },
    -- Temnaayu <Trade Negotiator>
    { questId = 66951 }, { questId = 72407 }, { questId = 66364 } },
  [SkillIds.Blacksmithing] = {
    completionCount = 1,
    -- Dhurrel <Trade Liaison>
    { questId = 66517 }, { questId = 66897 }, { questId = 66941 } },
  [SkillIds.Jewelcrafting] = {
    completionCount = 1,
    -- Temnaayu <Trade Negotiator>
    { questId = 66950 }, { questId = 66949 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { questId = 72428 }, { questId = 66516 } },
  [SkillIds.Enchanting] = {
    completionCount = 1,
    -- Temnaayu <Trade Negotiator>
    { questId = 66900 }, { questId = 66884 }, { questId = 72423 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { questId = 66935 } },
  [SkillIds.Tailoring] = {
    completionCount = 1,
    -- Dothenos <Trade Coordinator>
    { questId = 66952 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { questId = 72410 } },
  [SkillIds.Engineering] = {
    completionCount = 1,
    -- Dothenos <Trade Coordinator>
    { questId = 72396 }, { questId = 66890 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { questId = 66942 }, { questId = 66891 } },
  [SkillIds.Inscription] = {
    completionCount = 1,
    -- Dothenos <Trade Coordinator>
    { questId = 66945 }, { questId = 72438 }, { questId = 66943 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { questId = 66944 } },
}

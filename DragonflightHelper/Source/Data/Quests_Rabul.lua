-- TODO Not yet implemented
local SkillIds = DFH_Constants.SkillIds

DFH_Constants.ProfessionQuests.ValdrakkenRabul = {
  title = "Rabul <Artisan's Consortium Quartermaster>",
  -- Like treatises only single use (i.e. not weekly for future me!); figure out quest ID
  -- also need to attach a renown level requirement to each
  [SkillIds.Herbalism] = { quests = { 71897 }, items = { 200980 } },
  [SkillIds.Mining] = { quests = { 71901 }, items = { 200981 } },
  [SkillIds.Jewelcrafting] = { quests = { 71899 }, items = { 200978 } }
}

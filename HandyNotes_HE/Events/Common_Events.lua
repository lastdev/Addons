local _, ns = ...

-- Define the colours in the Colours_xxx file if indeed this will be used
ns.questTypes = { "One Time", "Seasonal", "Weekly", "Daily", }
ns.questTypesDB = { "OneTime Quests", "Seasonal Quests", "Weekly Quests", "Daily Quests", }
ns.questColours = { ( ns.colour.oneTime or ns.colour.highlight ), ( ns.colour.seasonal or ns.colour.highlight ),
					( ns.colour.weekly or ns.colour.highlight ), ( ns.colour.daily or ns.colour.highlight ), }
ns.achievementTypesDB = { "Achievements Char", "Achievements Acct", }

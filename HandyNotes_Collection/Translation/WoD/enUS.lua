---
--- @file
--- Localization file for Warlords of Draenor in enUS language.
---

local NAME, this = ...
local Text = this.Text

-- We add true as last parameter, since this is default language.
local t = this.AceLocale:NewLocale(NAME, 'enUS', true)

if not t then
  return
end

-- Warlords of Draenor
t['in_cave'] = 'In a cave.'
t['multiple_spawn_note'] = 'Can spawn in multiple locations.'
t['strange_spore_treasure'] = 'Strange Spore'
t['edge_of_reality'] = 'Edge of Reality'
t['edge_of_reality_note'] = 'This portal will take you to a scenario, where you can loot [item(121815)].'
t['missive'] = 'If the required daily quest is not up, you can buy missive with this specific quest in your garrison.'

-- Frostfire Ridge
t['frostfury_giant_note'] = 'You need to use Firefury Stone to summon him. Watch out, lava does damage even when you fly above it.'
t['borrok_devourer_note'] = Text:color('Do not kill him!!', 'white') .. " To get loot, you need to kill 10 [npc(75010)] and carry them near the lava pool. After that, he well threw up Devourer's Gutstone with loot."
t['breaker_of_chains_title'] = 'Breaker of Chains'
t['breaker_of_chains_note'] = 'Easiest way is to free [npc(82680)] from their prison. No quests required and doable any time.'

-- Shadowmoon Valley
t['aqualir_note'] = 'Kill 3 [npc(81542)] near water to make him vulnerable.'
t['malgosh_shadowkeeper_note'] = 'Entrance to his cave is actually in Spires of Arak'
t['voidseer_kalurg_note'] = 'Kill [npc(78135)] in corners of the pit to make him vulnerable.'
t['windfang_matriarch_note'] = 'Talk to [npc(74741)] to summon this rare. Only Alliance players can summon her, but if she is up, horde can kill her also.'
t['its_the_stones_title'] = "It's the Stones!"
t['you_have_been_rylakinated_title'] = 'You Have Been Rylakinated!'
t['you_have_been_rylakinated_note'] = 'Kill goblins until [item(116978)] drops. Take control of [npc(86085)] (time limit will start). Kill 10 [npc(85357)] within 3 minutes.'
t['take_from_them_everything_title'] = 'Take From Them Everything'
t['take_from_them_everything_note'] = [[
To complete this achievement, you need to use 'Supply Crates', 'Draenic Gems' or 'Fruit Baskets'. Each of these items will give you different buff for 2 minutes. The goal is to keep the same buff up for 10 minutes.

Do not leave the quest area, it will remove your buff!
]]

-- Gorgrond
t['poundfist_note'] = 'Has really long respawn between 50 and 90 hours.'
t['trophy_of_glory_note'] = 'You must finish building up your Gorgrond Garrison Outpost to get quest items to drop.'
t['roardan_sky_terror_note'] = 'Flies around Tangleheart and Beastwatch and makes 3 stops on the way.'

t['odd_skull_treasure'] = 'Odd Skull'
t['pile_of_rubble_treasure'] = 'Pile of Rubble'
t['remains_of_balik_orecrusher_treasure'] = 'Remains of Balik Orecrusher'
t['explorer_canister_treasure'] = 'Explorer Canister'
t['discarded_pack_treasure'] = 'Discarded Pack'
t['iron_supply_chest_treasure'] = 'Iron Supply Chest'
t['horned_skull_treasure'] = 'Horned Skull'
t['evermorn_supply_cache_treasure'] = 'Evermorn Supply Cache'
t['harvestable_precious_crystal_treasure'] = 'Harvestable Precious Crystal'
t['femur_of_improbability_treasure'] = 'Femur of Improbability'
t['laughing_skull_cache_treasure'] = 'Laughing Skull Cache'
t['laughing_skull_note'] = 'Up in the tree.'
t['stashed_emergency_rucksack_treasure'] = 'Stashed Emergency Rucksack'
t['strange_looking_dagger_treasure'] = 'Strange Looking Dagger'
t['suntouched_spear_treasure'] = 'Suntouched Spear'
t['warm_goren_egg_treasure'] = 'Warm Goren Egg'
t['warm_goren_egg_note'] = '[item(118705)] incubates in 7 days into [item(118716)].'
t['weapons_cache_treasure'] = 'Weapons Cache'
t['remains_if_balldir_deeprock_treasure'] = 'Remains of Balldir Deeprock'
t['petrified_rylak_egg_treasure'] = 'Petrified Rylak Egg'
t['ockbars_pack_treasure'] = "Ockbar's Pack"
t['sashas_secret_stash_treasure'] = "Sasha's Secret Stash"
t['vindicators_hammer_treasure'] = "Vindicator's Hammer"
t['brokors_sack_treasure'] = "Brokor's Sack"
t['snipers_crossbow_trerasure'] = "Sniper's Crossbow"

t['ninja_pepe_title'] = 'Ninja Pepe'
t['ninja_pepe_note'] = 'Inside the hut sitting on a chair.'
t['attack_plans_title'] = 'Iron Horde Attack Orders'
t['multiple_spawn_plans'] = 'This book can spawn in multiple locations.'
t['attack_plans_tracks'] = 'On the broken train tracks.'
t['attack_plans_crane'] = 'On top of the crane.'
t['attack_plans_tower'] = 'On top of the tower.'

-- Nagrand
t['goldtoes_plunder_title'] = "Goldtoe's Plunder"
t['treasure_of_kullkrosh_title'] = "Treasure of Kull'krosh"
t['spirit_coffer_title'] = 'Spirit Coffer'
t['adventurers_pack_title'] = "Adventurer's Pack"
t['fragment_of_oshugun_title'] = "Fragment of Oshu'gun"
t['void-infused_crystal_title'] = 'Void-Infused Crystal'
t['adventurers_pouch_title'] = "Adventurer's Pouch"
t['warsong_helm_title'] = 'Warsong Helm'
t['golden_kaliri_egg_title'] = 'Golden Kaliri Egg'
t['pokkars_thirteenth_axe_title'] = "Pokkar's Thirteenth Axe"
t['pale_elixir_title'] = 'Pale Elixir'
t['lost_pendant_title'] = 'Lost Pendant'
t['bag_of_herbs_title'] = 'Bag of Herbs'
t['telaar_defender_shield_title'] = 'Telaar Defender Shield'
t['watertight_bag_title'] = 'Watertight Bag'
t['elemental_offering_title'] = 'Elemental Offering'
t['adventurers_sack_title'] = "Adventurer's Sack"
t['freshwater_clam_title'] = 'Freshwater Clam'
t['elemental_shackles_title'] = 'Elemental Shackles'
t['adventurers_staff_title'] = "Adventurer's Staff"
t['bone-carved_dagger_title'] = 'Bone-Carved Dagger'
t['brilliant_dreampetal_title'] = 'Brilliant Dreampetal'
t['highmaul_sledge_title'] = 'Highmaul Sledge'
t['abandoned_cargo_title'] = 'Abandoned Cargo'
t['gamblers_purse_title'] = "Gambler's Purse"
t['polished_saberon_skull_title'] = 'Polished Saberon Skull'
t['adventurers_mace_title'] = "Adventurer's Mace"
t['warsong_spear_title'] = 'Warsong Spear'
t['ogre_beads_title'] = 'Ogre Beads'
t['grizzlemaws_bonepile_title'] = "Grizzlemaw's Bonepile"
t['steamwheedle_supplies_title'] = 'Steamwheedle Supplies'
t['genedar_debris_title'] = 'Genedar Debris'
t['mountain_climbers_pack_title'] = "Mountain Climber's Pack"
t['warsong_lockbox_title'] = 'Warsong Lockbox'
t['warsong_spoils_title'] = 'Warsong Spoils'
t['hidden_stash_title'] = 'Hidden Stash'
t['fungus_covered_chest_title'] = 'Fungus-Covered Chest'
t['goblin_pack_title'] = 'Goblin Pack'
t['warsong_cache_title'] = 'Warsong Cache'
t['pile_of_dirt_title'] = 'A Pile of Dirt'
t['appropriated_warsong_supplies_title'] = 'Appropriated Warsong Supplies'
t['bounty_of_the_elements_title'] = 'Bounty of the Elements'
t['smugglers_cache_title'] = "Smuggler's Cache"
t['warsong_supplies_title'] = 'Warsong Supplies'
t['saberon_stash_title'] = 'Saberon Stash'
t['important_exploration_supplies_title'] = 'Important Exploration Supplies'
t['burning_blade_cache_title'] = 'Burning Blade Cache'
t['adventurers_pouch_title'] = "Adventurer's Pouch"
t['goldtoes_plunder_note'] = 'Parrot has the key.'
t['genedar_debris_note'] = 'Hard to see, it is hidden under the bush.'
t['warsong_note'] = 'In tower watchpost, you have to fly / glide there.'
t['hidden_stash_note'] = 'Grab it from the tree.'
t['goblin_pack_first_note'] = 'On the tree.'
t['goblin_pack_second_note'] = 'On a small platform under the overlook (stone bridge).'
t['bounty_of_the_elements_note'] = 'Use totems to unlock chest (Air, Earth, Water, Fire).'
t['smugglers_cache_note'] = 'Jump over tripwires on the ground.'
t['burning_blade_cache_note'] = 'On the roof.'
t['hyperious_note'] = 'You need to use 3 braziers around the pit to summon him.'
t['explorer_nozzand_note'] = 'In a cave behind a waterfall.'
t['fangler_note'] = 'Click on the Abandoned Fishing Rod at the east of the water pool.'
t['gorepetal_note'] = 'Use Pristine Lily to spawn him.'
t['graveltooth_note'] = 'You needed to kill 15 [npc(84255)] in order for [npc(84263)] to spawn.'
t['krud_eviscerator_note'] = "To be able to attack him, you must kill 15 mobs that spawn around him. There's a counter at the top that tracks progress: 'Tribute remaining: 15'."
t['pit_slayer_note'] = 'Click on blue crystals around the place which will transform you into a ogre. When you are in transformed, you will be able to click "Pit Slayer\'s Trophy" in the middle of the pit to spawn him.'
t['song_silence_note'] = "You need to find [item(120290)] from a random mob in Mok'Gol Watchpost and use Signal Horn, which is hanging right outside the largest hut to summon these 2 rares."
t['viking_pepe_title'] = 'Viking Pepe'
t['viking_pepe_note'] = 'On a box.'
t['buried_treasures_note'] = "You have to kill [npc(86659)] and loot the [npc(87280)]. This transforms you into a [spell(174572)] for 2 minutes. While transformed, find and loot [npc(87530)] which might contain items required for achievement."
t['history_of_violence_note'] = [[
Use [npc(88064)] (small gem on the ground) which will give you buff [spell(175766)] for 2 minutes, allowing you to interact with boulder piles. Piles can contain different loot, including this item.

If you use your mount, buff [spell(175766)] will disappear!.
]]

-- Spires of Arak
t['outcasts_belongings_title'] = "Outcast's Belongings"
t['ephials_dark_grimoire_title'] = "Ephial's Dark Grimoire"
t['ephials_dark_grimoire_note'] = 'Inside the house.'
t['garrison_supplies_title'] = 'Garrison Supplies'
t['orcish_signaling_horn_title'] = 'Orcish Signaling Horn'
t['sun-touched_cache_title'] = 'Sun-Touched Cache'
t['outcasts_belongings_title'] = "Outcast's Belongings"
t['shattered_hand_lockbox_title'] = 'Shattered Hand Lockbox'
t['outcasts_pouch_title'] = "Outcast's Pouch"
t['outcasts_pouch_note'] = 'Walk up on the chain and loot it corpse chained to the tree.'
t['lost_ring_title'] = 'Lost Ring'
t['lost_ring_note'] = 'Really small ring in the middle of the water.'
t['assassins_spear_title'] = "Assassin's Spear"
t['toxicfang_venom_title'] = 'Toxicfang Venom'
t['toxicfang_venom_note'] = 'Behind barrels.'
t['shattered_hand_cache_title'] = 'Shattered Hand Cache'
t['iron_horde_explosives_title'] = 'Iron Horde Explosives'
t['lost_herb_satchel_title'] = 'Lost Herb Satchel'
t['lost_herb_satchel_note'] = 'On a pillar under the bridge. Contains 5 - 10 Draenor herbs.'
t['fractured_sunstone_title'] = 'Fractured Sunstone'
t['fractured_sunstone_note'] = 'In the water at the edge of the broken pillar.'
t['garrison_workmans_hammer_title'] = "Garrison Workman's Hammer"
t['admiral_taylors_coffer_title'] = "Admiral Taylor's Coffer"
t['admiral_taylors_coffer_note'] = 'Inside the Town Hall. You need to get [item(116020)] near mine entrance nearby to open it.'
t['roobys_roo_title'] = "Rooby's Roo"
t['roobys_roo_note'] = 'Buy 3x [item(114835)] from [npc(82432)] on first basement level of The Briny Barnacle pub to feed it to [npc(84332)] on main floor. He will take you to treasure (behind pub).'
t['abandoned_mining_pick_title'] = 'Abandoned Mining Pick'
t['ogron_plunder_title'] = 'Ogron Plunder'
t['mysterious_mushrooms_title'] = 'Mysterious Mushrooms'
t['waterlogged_satchel_title'] = 'Waterlogged Satchel'
t['waterlogged_satchel_note'] = 'Underwater.'
t['sethekk_idol_title'] = 'Sethekk Idol'
t['sethekk_ritual_brew_title'] = 'Sethekk Ritual Brew'
t['spray-o-matic_5000_xt_title'] = 'Spray-O-Matic 5000 XT'
t['spray-o-matic_5000_xt_note'] = 'In the ships trunk.'
t['shredder_parts_title'] = 'Shredder Parts'
t['coinbenders_payment_title'] = "Coinbender's Payment"
t['coinbenders_payment_note'] = 'Underwater. Marked by the buoy on the water surface.'
t['sailor_zazzuks_180-proof_rum_title'] = "Sailor Zazzuk's 180-Proof Rum"
t['sailor_zazzuks_180-proof_rum_note'] = 'In the small room.'
t['campaign_contributions_title'] = 'Campaign Contributions'
t['campaign_contributions_note'] = 'On the upper floor. You need to jump from bed over the shelves.'
t['offering_to_the_raven_mother_title'] = 'Offering to the Raven Mother'
t['gift_of_anzu_title'] = 'Gift of Anzu'
t['gift_of_anzu_note'] = 'You need to loot [item(115463)] from one of the marked points and use it near Shrine to Terokk to see Gift of Anzu. These elixir spawns reset weekly and you cannot use one elixir on 2 shrines (buff disappears, when you leave shrine).'
t['nizzixs_chest_title'] = "Nizzix's Chest"
t['nizzixs_chest_note'] = 'Activate Escape Pod nearby and follow [npc(82303)] to treasure.'
t['relics_of_the_outcasts_title'] = 'Relics of the Outcasts'
t['spires_of_arak_relics_note'] = 'Grants [currency(829)] and sometimes [item(109585)].'
t['relics_tree_note'] = 'On the tree, connected with rope.'
t['sun-touched_cache_title'] = 'Sun-Touched Cache'
t['misplaced_scrolls_title'] = 'Misplaced Scrolls'
t['misplaced_scroll_title'] = 'Misplaced Scroll'
t['smuggled_apexis_artifacts_title'] = 'Smuggled Apexis Artifacts'
t['tent_note'] = 'Inside the tent.'
t['pirate_pepe_title'] = 'Pirate Pepe'
t['pirate_pepe_note'] = 'On a rock in the corner.'
t['void_portal'] = 'Use Void Portal to enter Twisting Nether.'
t['gaze_note'] = 'You must click of Fel Grimoire in the middle of the hut to spawn him.'
t['sunderthorn_note'] = 'Kill several [npc(84905)] and [npc(84909)] until message ' .. Text:color('"Sunderthorn descends from the treetops to protect her hive!"', 'white') .. 'appears and she spawns.'
t['sangrikass_note'] = 'Use [npc(84821)] and kill 4 [npc(84820)] to spawn it.'
t['varasha_note'] = "Use Varasha's Egg to spawn it."
t['kenos_unraveler_note'] = 'Requires 3 people to summon.'
t['fish_gotta_swim_title'] = 'Fish Gotta Swim, Birds Gotta Eat'
t['fish_gotta_swim_note'] = 'You need to hit [npc(84013)], that has buff [spell(168364)] (you will see it dive to water). After being hit, it drops fish on the ground, that you need to loot and eat. Kill any [npc(84013)] that has well fed buff, which might be blocking spawn.'
t['king_of_monsters_note'] = [[
Only one rare can be up at the same time. If you need another, you need to kill the one that is up and wait for respawn. Quest is required only when you are doing achievement.

When you are in Lost Veil Anzu, you should have parasites attached to you. To be evolved, you must [spell(174133)] corpses of killed enemies (right click after looting them). Its better to kill them one by one. 5 should be enough to evolve. Evolution is not infinite.

Best way to get this achievement, is to get quest, find required rare in the area. Evolve and kill it. Rares give around 35% of quest bar, so if you want to do it in one run, you need to abandon quest and take it again.
]]

-- Talador
t['knight_pepe_title'] = 'Knight Pepe'
t['knight_pepe_note'] = 'In a tent near some NPCs.'
t['wandering_vindicator_note'] = 'After defeating him, you need to loot his sword from the stone.'
t['legion_vanguard_note'] = '[npc(88494)] is summoned from portal. Kill [npc(83023)] around portal and any other, that comes out to summon him.'
t['taladorantula_note'] = 'Squish eggs sacks and kill [npc(75258)] around to summon [npc(77634)]. Takes around 3 to 5 minutes of squishing.'
t['shirzir_note'] = 'In underground tomb.'
t['kharazos_galzomar_sikthiss_note'] = '[npc(78710)], [npc(78713)] and [npc(78715)] share the same drop, spawn and path.'
t['bonechewer_remnants_title'] = 'Bonechewer Remnants'
t['bonechewer_spear_title'] = 'Bonechewer Spear'
t['treasure_of_angorosh_title'] = "Treasure of Ango'rosh"
t['aarkos_family_treasure_title'] = "Aarko's Family Treasure"
t['aarkos_family_treasure_note'] = 'Speak with [npc(77664)] and assist him to spawn treasure.'
t['farmers_bounty_title'] = "Farmer's Bounty"
t['light_of_the_sea_title'] = 'Light of the Sea'
t['luminous_shell_title'] = 'Luminous Shell'
t['draenei_weapons_title'] = 'Draenei Weapons'
t['amethyl_crystal_title'] = 'Amethyl Crystal'
t['barrel_of_fish_title'] = 'Barrel of Fish'
t['bright_coin_title'] = 'Bright Coin'
t['bright_coin_note'] = 'In water under the bridge. Its really small and easy to miss.'
t['lightbearer_title'] = 'Lightbearer'
t['burning_blade_cache_title'] = 'Burning Blade Cache'
t['relic_of_aruuna_title'] = 'Relic of Aruuna'
t['relic_of_telmor_title'] = 'Relic of Telmor'
t['charred_sword_title'] = 'Charred Sword'
t['foremans_lunchbox_title'] = "Foreman's Lunchbox"
t['deceptias_smoldering_boots_title'] = "Deceptia's Smoldering Boots"
t['webbed_sac_title'] = 'Webbed Sac'
t['rusted_lockbox_title'] = 'Rusted Lockbox'
t['rusted_lockbox_note'] = 'Deep underwater in lower level of the cave. \n\nContains random green item.'
t['curious_deathweb_egg_title'] = 'Curious Deathweb Egg'
t['curious_deathweb_egg_note'] = 'On the lower floor.'
t['iron_box_title'] = 'Iron Box'
t['ketyas_stash_title'] = "Ketya's Stash"
t['rooks_tacklebox_title'] = "Rook's Tacklebox"
t['jug_of_aged_ironwine_title'] = 'Jug of Aged Ironwine'
t['keluus_belongings_title'] = "Keluu's Belongings"
t['pure_crystal_dust_title'] = 'Pure Crystal Dust'
t['aruuna_mining_cart_title'] = 'Aruuna Mining Cart'
t['aruuna_mining_cart_note'] = 'Jump down to lowest level of the mine.'
t['soulbinders_reliquary_title'] = "Soulbinder's Reliquary"
t['iron_scout_note'] = 'Use body to search it.'
t['gift_of_the_ancients_title'] = 'Gift of the Ancients'
t['gift_of_the_ancients_note'] = 'Turn all statues to face empty stone block in the middle to spawn the treasure.'
t['isaaris_cache_title'] = "Isaari's Cache"
t['yuuris_gift_title'] = "Yuuri's Gift"
t['teroclaw_nest_title'] = 'Teroclaw Nest'
t['teroclaw_nest_note'] = 'Can spawn in multiple places. Pet reward is only from first nest looted.'
t['upper_note'] = 'On the upper floor.'
t['poor_communication_title'] = 'Poor Communication'
t['poor_communication_note'] = 'Use Sargerei Missives scattered all over the quest area.'
t['united_we_stand_title'] = 'United We Stand'
t['united_we_stand_note'] = "NPCs are located all around the quest area in tents. Easy way to do this is to use '/tar Captive' macro."
t['bobbing_for_orcs_title'] = 'Bobbing for Orcs'
t['bobbing_for_orcs_note'] = 'There are floating orc corpses in the water at the harbor. Drag them to dry land and set them on fire to get credit for the achievement. You can use [item(85500)] or flying mount to make dragging faster.'
t['power_is_yours_title'] = 'The Power Is Yours'
t['power_is_yours_note'] = [[
This achievement requires 3 people.

Each player need to use [npc(86904)], [npc(86912)] or [npc(86910)] to acquire different buff ([spell(173904)], [spell(173957)], [spell(173923)]). These buff lasts 5 minutes. You can have only 1 buff on yourself at the same time.

In order to get this achievement, you need to have debuff from each rune on enemy (which will be applied by player with related buff). Orange debuff lasts 4 seconds, green 9 seconds and purple 30 seconds.

Since WoD monsters will have low health (comparing to you), its best to use some toys to apply debuffs to (like [item(88375)] or [item(144339)]).
]]
t['orumo_the_observer_note'] = [[
[npc(87668)] requires 5 people standing on runes before him to be able to kill him.

Alternatively, Warlocks can use [spell(48020)] and Monks [spell(119996)] to teleport on runes, which decreases number of required people to 3.

Another option is to use 5 of your own characters, move them one by one to runes and logout them there.

Last option is to use only one character. Go to rune, lit it up, teleport out and repeat for each rune. Best way is to set up [item(6948)] somewhere close.

You can combine any of methods above to summon [npc(87668)].
]]

-- Tannan Jungle
t['deathtalon_note'] = Text:color('*Shadow Lord Iskar yells: Behind the veil, all you find is death!*', 'red')
t['doomroller_note'] = Text:color("*Siegemaster Mar'tak yells: Hah-ha! Trample their corpses!*", 'red')
t['terrorfist_note'] = Text:color('*Frogan yells: A massive gronnling is heading for Rangari Refuge! We are going to require some assistance!*', 'red')
t['vengeance_note'] = Text:color('*Tyrant Velhari yells: Insects deserve to be crushed!*', 'red')
t['iron_armada_note'] = 'This toy is also buyable on AH and is required for [achievement(10353)].'
t['commander_kraggoth_note'] = 'At the top of the north-east tower.'
t['grannok_note'] = 'At the top of the south-east tower.'
t['szirek_the_twisted_note'] = 'Capture the East Strongpoint to summon this rare.'
t['the_iron_houndmaster_note'] = 'Capture the West Strongpoint to summon this rare.'
t['belgork_thromma_note'] = 'This cave has 2 entrances.'
t['driss_vile_note'] = 'On top of the tower.'
t['overlord_magruth_note'] = 'Kill orcs around camp to spawn it.'
t['mistress_thavra_note'] = 'In a cave on upper floor.'
t['dorg_the_bloody_note'] = 'Kill [npc(89706)] and other enemies at spawn location.'
t['grand_warlock_netherkurse_note'] = 'Kill enemies around spawn point.'
t['ceraxas_note'] = 'Spawns [npc(90426)] with quest for pet after killing it.'
t['commander_orgmok_note'] = 'Rides around on [npc(89676)].'
t['rendrak_note'] = 'Collect 10 [item(124045)] from [npc(89788)] around bog. Combine them to summon rare.'
t['akrrilo_note'] = 'Buy [item(124093)] from [npc(92805)] and use it at Blackfang Challenge Arena.'
t['rendarr_note'] = 'Buy [item(124094)] from [npc(92805)] and use it at Blackfang Challenge Arena.'
t['eyepiercer_note'] = 'Buy [item(124095)] from [npc(92805)] and use it at Blackfang Challenge Arena.'
t['the_night_haunter_note'] = [[
Collect 10 stacks of [spell(183612)] debuff.

You can get debuff by using [npc(92651)] or by finding [npc(92645)] (100% chance).
]]
t['xemirkol_note'] = [[
Buy [item(128502)] or [item(128503)] from [npc(95424)] and use it at spawn point to get teleported to [npc(96235)].

Crystals teleport you to random rare in vicinity, so best chance is to kill [npc(92887)] and use [item(128502)].

[npc(96235)] has long respawn timer (around a day) and best way to get it is after realm restart or by using server jump.
]]

t['discarded_helm_treasure'] = 'Discarded Helm'
t['weathered_axe_treasure'] = 'Weathered Axe'
t['axe_of_the_weeping_wolf_treasure'] = 'Axe of the Weeping Wolf'
t['sacrificial_blade_treasure'] = 'Sacrificial Blade'
t['crystallized_essence_of_the_elements_treasure'] = 'Crystallized Essence of the Elements'
t['snake_charmers_flute_treasure'] = "Snake Charmer's Flute"
t['lodged_hunting_spear_treasure'] = 'Lodged Hunting Spear'
t['looted_mystical_staff_treasure'] = 'Looted Mystical Staff'
t['the_blade_of_kranak_treasure'] = "The Blade of Kra'nak"
t['forgotten_champions_blade_treasure'] = "Forgotten Champion's Blade"
t['rune_etched_femur_treasure'] = 'Rune Etched Femur'
t['book_of_zyzzix_treasure'] = 'Book of Zyzzix'
t['the_commanders_shield_treasure'] = "The Commander's Shield'"
t['scouts_belongings_treasure'] = "Scout's Belongings"
t['polished_crystal_treasure'] = 'Polished Crystal'
t['strange_sapphire_treasure'] = 'Strange Sapphire'
t['censer_of_torment_treasure'] = 'Censer of Torment'
t['overgrown_relic_treasure'] = 'Overgrown Relic'
t['jewel_of_hellfire_treasure'] = 'Jewel of Hellfire'
t['skull_of_the_mad_chief_treasure'] = 'Skull of the Mad Chief'
t['jeweled_arakkoa_effigy_treasure'] = 'Jeweled Arakkoa Effigy'
t['tome_of_secrets_treasure'] = 'Tome of Secrets'
t['the_perfect_blossom_treasure'] = 'The Perfect Blossom'
t['brazier_of_awakening_treasure'] = 'Brazier of Awakening'
t['dazzling_rod_treasure'] = 'Dazzling Rod'
t['crystallized_fel_spike_treasure'] = 'Crystallized Fel Spike'
t['fel_drenched_satchel_treasure'] = 'Fel-Drenched Satchel'
t['the_eye_of_grannok_treasure'] = 'The Eye of Grannok'
t['borrowed_enchanted_spyglass_treasure'] = "'Borrowed' Enchanted Spyglass"
t['bleeding_hollow_mushroom_stash_treasure'] = 'Bleeding Hollow Mushroom Stash'
t['mysterious_corrupted_obelist_treasure'] = 'Mysterious Corrupted Obelisk'
t['spoils_of_war_treasure'] = 'Spoils of War'
t['stolen_captains_chest_treasure'] = "Stolen Captain's Chest"
t['bleeding_hollow_warchest_treasure'] = 'Bleeding Hollow Warchest'
t['looted_bleeding_hollow_treasure_treasure'] = 'Looted Bleeding Hollow Treasure'
t['partially_mined_apexis_crystal_treasure'] = 'Partially Mined Apexis Crystal'
t['pale_removal_equipment_treasure'] = 'Pale Removal Equipment'
t['stashed_iron_sea_booty_treasure'] = 'Stashed Iron Sea Booty'
t['ironbeards_treasure_treasure'] = "Ironbeard's Treasure"
t['forgotten_sack_treasure'] = 'Forgotten Sack'
t['blackfang_island_cache_treasure'] = 'Blackfang Island Cache'
t['fel_tainted_apexis_formation_treasure'] = 'Fel-Tainted Apexis Formation'
t['jewel_of_the_fallen_star_treasure'] = 'Jewel of the Fallen Star'
t['forgotten_shard_of_the_cipher_treasure'] = 'Forgotten Shard of the Cipher'
t['strange_fruit_treasure'] = 'Strange Fruit'
t['stashed_bleeding_hollow_loot_treasure'] = 'Stashed Bleeding Hollow Loot'
t['forgotten_iron_horde_supplies_treasure'] = 'Forgotten Iron Horde Supplies'
t['bejeweled_egg_treasure'] = 'Bejeweled Egg'
t['dead_mans_chest_treasure'] = "Dead Man's Chest"
t['the_commanders_shield_note'] = 'Inside building.'
t['the_eye_of_grannok_note'] = 'On the second floor of tower near the stairs.'
t['tower_chest_note'] = 'At the top of a tower.'
t['spoils_of_war_note'] = 'Inside the hut.'
t['strange_fruit_note'] = '[item(127396)] incubates in 14 days into [item(127394)].'
t['battle_pets_note'] = 'All rewards are contained in [item(127751)] and can be collected daily from each battle. That is 15 [item(127751)] per day per character.'

---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = this.points

---
--- Table with maps names and their respective IDs.
---
--- @link https://wow.tools/dbc/?dbc=uimapgroupmember
---
--- @var table maps
---   Map definitions for easier finding and loading UiMapIDs in specific maps.
---
local maps = {
  -- Classic

  -- Blackfathom Deeps
  ['bfd_pools_of_askar'] = 221,
  ['bfd_moonshrine_sanctum'] = 222,
  ['bfd_forgotten_pool'] = 223,

  -- Blackrock Depths
  ['brd_detention_block'] = 242,
  ['brd_shadowforge_city'] = 243,

  -- Deadmines
  ['dm_deadmines'] = 291,
  ['dm_ironclad_cove'] = 292,

  -- Dire Maul
  ['drm_capital_gardens'] = 236,
  ['drm_court_of_highborne'] = 237,
  ['drm_prison_of_immolthar'] = 238,
  ['drm_warpwood_quarter'] = 239,
  ['drm_shrine_of_eldretharr'] = 240,

  -- Gnomeregan
  ['gm_hall_of_gears'] = 226,
  ['gm_dormitory'] = 227,
  ['gm_launch_bay'] = 228,
  ['gm_tinkers_court'] = 229,

  -- Lower Blackrock Spire
  ['lbrs_tazzalor'] = 250,
  ['lbrs_skitterweb_tunnels'] = 251,
  ['lbrs_hordemar_city'] = 252,
  ['lbrs_hall_of_blackhand'] = 253,
  ['lbrs_halycons_lair'] = 254,
  ['lbrs_chamber_of_battle'] = 255,

  -- Maraudon
  ['mrd_caverns_of_maraudon'] = 280,
  ['mrd_zaetars_grave'] = 281,

  -- Scarlet Halls
  ['sh_training_grounds'] = 431,
  ['sh_athenaeum'] = 432,

  -- Scarlet Monastery
  ['sm_forlorn_cloister'] = 435,
  ['sm_crusaders_chapel'] = 436,

  -- Scholomance
  ['schm_reliquary'] = 476,
  ['schm_chamber_of_summoning'] = 477,
  ['schm_upper_study'] = 478,
  ['schm_headmasters_study'] = 479,

  -- Shadowfang Keep
  ['sfk_courtyard'] = 310,
  ['sfk_dining_hall'] = 311,
  ['sfk_vacant_den'] = 312,
  ['sfk_lower_observatory'] = 313,
  ['sfk_upper_observatory'] = 314,
  ['sfk_lord_godfreys_chamber'] = 315,
  ['sfk_wall_walk'] = 316,

  -- Uldaman
  ['uld_hall_of_keepers'] = 230,
  ['uld_khazgoroths_seat'] = 231,

  -- Ahn'Qiraj
  ['aq_hive_undergrounds'] = 319,
  ['aq_temple_gates'] = 320,
  ['aq_vault_of_cthun'] = 321,

  -- Blackwing Lair
  ['bwl_dragonmaw_garrison'] = 287,
  ['bwl_halls_of_strife'] = 288,
  ['bwl_crimson_laboratories'] = 289,
  ['bwl_nefarians_lair'] = 290,

  -- The Burning Crusade

  -- Auchenai Crypts
  ['auc_halls_of_hereafter'] = 256,
  ['auc_bridge_of_souls'] = 257,

  -- Magisters' Terrace
  ['mgt_grand_magisters_asylum'] = 348,
  ['mgt_observation_grounds'] = 349,

  -- Sethekk Halls
  ['shh_veil_sethekk'] = 258,
  ['shh_halls_of_mourning'] = 259,

  -- The Arcatraz
  ['arc_stasis_block_trion'] = 269,
  ['arc_stasis_block_maximus'] = 270,
  ['arc_containment_core'] = 271,

  -- The Mechanar
  ['mec_mechanar'] = 267,
  ['mec_calculation_chamber'] = 268,

  -- The Steamvault
  ['stv_steamvault'] = 263,
  ['stv_cooling_pools'] = 264,

  -- Karazhan
  ['kz_servants_quarters'] = 350,
  ['kz_upper_livery_stables'] = 351,
  ['kz_banquet_hall'] = 352,
  ['kz_guest_chambers'] = 353,
  ['kz_opera_hall_balcony'] = 354,
  ['kz_masters_terrace'] = 355,
  ['kz_lower_broken_stair'] = 356,
  ['kz_upper_broken_stair'] = 357,
  ['kz_menagerie'] = 358,
  ['kz_guardians_library'] = 359,
  ['kz_repository'] = 360,
  ['kz_upper_library'] = 361,
  ['kz_celestial_watch'] = 362,
  ['kz_gamesmans_hall'] = 363,
  ['kz_medivhs_chambers'] = 364,
  ['kz_power_station'] = 365,
  ['kz_netherspace'] = 366,

  -- Black Temple
  ['bt_black_temple'] = 339,
  ['bt_karabor_sewers'] = 340,
  ['bt_sanctuary_of_shadows'] = 341,
  ['bt_halls_of_anguish'] = 342,
  ['bt_gorefiends_vigil'] = 343,
  ['bt_den_of_mortal_delights'] = 344,
  ['bt_chamber_of_command'] = 345,
  ['bt_temple_summit'] = 346,

  -- Sunwell Plateau
  ['swp_sunwell_plateau'] = 335,
  ['swp_shrine_of_eclipse'] = 336,

  -- Wrath of the Lich King

  -- Azjol-Nerub
  ['azn_brood_pit'] = 157,
  ['azn_hadronoxs_lair'] = 158,
  ['azn_gilded_gate'] = 159,

  -- Drak'Tharon Keep
  ['dtk_vestibules_of_draktharon'] = 160,
  ['dtk_draktharon_overlook'] = 161,

  -- Halls of Lightning
  ['hol_unyielding_garrison'] = 138,
  ['hol_walk_of_makers'] = 139,

  -- The Culling of Stratholme
  ['cos_culling_of_stratholme'] = 130,
  ['cos_stratholme_city'] = 131,

  -- The Oculus
  ['ocl_band_of_variance'] = 143,
  ['ocl_band_of_acceleration'] = 144,
  ['ocl_band_of_transmutation'] = 145,
  ['ocl_band_of_alignment'] = 146,

  -- Utgarde Keep
  ['ugk_njorndir_preparation'] = 133,
  ['ugk_dragonflayer_ascent'] = 134,
  ['ugk_tyrs_terrace'] = 135,

  -- Utgarde Pinnacle
  ['ugp_lower_pinnacle'] = 136,
  ['ugp_upper_pinnacle'] = 137,

  -- Ulduar
  ['ud_ulduar'] = 147,
  ['ud_antechamber_of_ulduar'] = 148,
  ['ud_inner_sanctum_of_ulduar'] = 149,
  ['ud_prison_of_yoggsaron'] = 150,
  ['ud_spark_of_imagination'] = 151,
  ['ud_minds_eye'] = 152,

  -- Naxxramas
  ['nax_construct_quarter'] = 162,
  ['nax_arachnid_quarter'] = 163,
  ['nax_military_quarter'] = 164,
  ['nax_plague_quarter'] = 165,
  ['nax_lower_necropolis'] = 166,
  ['nax_upper_necropolis'] = 167,

  -- Trial of the Crusader
  ['toc_argent_coliseum'] = 172,
  ['toc_icy_depths'] = 173,

  -- Icecrown Citadel
  ['icc_lower_citadel'] = 186,
  ['icc_ramparts_of_skulls'] = 187,
  ['icc_deathbringers_rise'] = 188,
  ['icc_front_queens_lair'] = 189,
  ['icc_upper_reaches'] = 190,
  ['icc_royals_quarters'] = 191,
  ['icc_frozen_throne'] = 192,

  -- Cataclysm

  -- Blackrock Caverns
  ['brc_chamber_of_incineration'] = 283,
  ['brc_twilight_forge'] = 284,

  -- End Time
  ['ent_end_time'] = 401,
  ['ent_azure_dragonshrine'] = 402,
  ['ent_ruby_dragonshrine'] = 403,
  ['ent_obsidian_dragonshrine'] = 404,
  ['ent_emerald_dragonshrine'] = 405,
  ['ent_bronze_dragonshrine'] = 406,

  -- Halls of Origination
  ['hoo_vault_of_lights'] = 297,
  ['hoo_tomb_of_earthrager'] = 298,
  ['hoo_four_seats'] = 299,

  -- Hour of Twilight
  ['hot_hour_of_twilight'] = 399,
  ['hot_wyrmrest_temple'] = 400,

  -- Throne of Tides
  ['thot_abyssal_halls'] = 322,
  ['thot_throne_of_neptulon'] = 323,

  -- Blackwing Descent
  ['bwd_broken_hall'] = 285,
  ['bwd_shadowflame_vault'] = 286,

  -- The Bastion of Twilight
  ['bot_twilight_enclave'] = 294,
  ['bot_throne_of_apocalypse'] = 295,
  ['bot_twilight_caverns'] = 296,

  -- Firelands
  ['fl_firelands'] = 367,
  ['fl_sulfuron_keep'] = 369,

  -- Dragon Soul
  ['ds_dragon_soul'] = 409,
  ['ds_maw_of_gorath'] = 410,
  ['ds_maw_of_shuma'] = 411,
  ['ds_eye_of_eternity'] = 412,
  ['ds_skyfire_airship'] = 413,
  ['ds_spine_of_deathwing'] = 414,
  ['ds_maelstrom'] = 415,

  -- Mists of Pandaria

  -- Gate of the Setting Sun
  ['gss_gate_of_setting_sun'] = 437,
  ['gss_gate_watch_tower'] = 438,

  -- Mogu'shan Palace
  ['msp_crimson_assembly_hall'] = 453,
  ['msp_vaults_of_kings_past'] = 454,
  ['msp_throne_of_ancient_conquerors'] = 455,

  -- Shado-Pan Monastery
  ['spm_shadopan_monastery'] = 443,
  ['spm_cloudstrike_dojo'] = 444,
  ['spm_snowdrift_dojo'] = 445,
  ['spm_sealed_chambers'] = 446,

  -- Siege of Niuzao Temple
  ['snt_siege_of_niuzao_temple'] = 457,
  ['snt_hollowed_out_tree'] = 458,
  ['snt_upper_tree_ring'] = 459,

  -- Stormstout Brewery
  ['ssb_grain_cellar'] = 439,
  ['ssb_stormstout_brewhall'] = 440,
  ['ssb_great_wheel'] = 441,
  ['ssb_tasting_room'] = 442,

  -- Temple of the Jade Serpent
  ['tjs_temple_of_jade_serpent'] = 429,
  ['tjs_scrollkeepers_sanctum'] = 430,

  -- Heart of Fear
  ['hof_oratorium_of_voice'] = 474,
  ['hof_heart_of_fear'] = 475,

  -- Mogus'han Vaults
  ['mv_dais_of_conquerors'] = 471,
  ['mv_repository'] = 472,
  ['mv_forge_of_endless'] = 473,

  -- Throne of Thunder
  ['tot_overgrown_statuary'] = 508,
  ['tot_royal_amphitheater'] = 509,
  ['tot_forgotten_depths'] = 510,
  ['tot_roots_of_jikun'] = 511,
  ['tot_halls_of_fleshshaping'] = 512,
  ['tot_hall_of_kings'] = 513,
  ['tot_pinnacle_of_storms'] = 514,
  ['tot_hidden_cell'] = 515,

  -- Siege of Orgrimmar
  ['soo_siege_of_orgrimmar'] = 556,
  ['soo_pools_of_power'] = 557,
  ['soo_vault_of_yshaarj'] = 558,
  ['soo_gates_of_orgrimmar'] = 559,
  ['soo_valley_of_strength'] = 560,
  ['soo_cleft_of_shadow'] = 561,
  ['soo_descent'] = 562,
  ['soo_korkron_barracks'] = 563,
  ['soo_menagerie'] = 564,
  ['soo_siegeworks'] = 565,
  ['soo_chamber_of_paragons'] = 566,
  ['soo_inner_sanctum'] = 567,

  -- Warlords of Draenor
  ['draenor'] = 572,
  ['frostfire_ridge'] = 525,
  ['tanaan_jungle'] = 534,
  ['talador'] = 535,
  ['shadowmoon_valley'] = 539,
  ['spires_of_arak'] = 542,
  ['gorgrond'] = 543,
  ['nagrand'] = 550,

  -- Minimaps
  ['tomb_of_souls'] = 537,
  ['bloodthorn_cave'] = 540,
  ['cragplume'] = 549,

  -- Grimrail Depot
  ['grd_train_depot'] = 606,
  ['grd_rafters'] = 607,
  ['grd_rear_train_cars'] = 608,
  ['grd_forward_train_cars'] = 609,

  -- Shadowmoon Burial Grounds
  ['sbg_crypt_of_ancients'] = 574,
  ['sbg_altar_of_shadow'] = 575,
  ['sbg_edge_of_reality'] = 576,

  -- Skyreach
  ['skr_lower_quarter'] = 601,
  ['skr_grand_spire'] = 602,

  -- The Everbloom
  ['evb_everbloom'] = 620,
  ['evb_overlook'] = 621,

  -- Upper Blackrock Spire
  ['ubrs_dragonspire_hall'] = 616,
  ['ubrs_rookery'] = 617,
  ['ubrs_hall_of_blackhand'] = 618,

  -- Highmaul
  ['hm_highmaul'] = 610,
  ['hm_gladiators_rest'] = 611,
  ['hm_coliseum'] = 612,
  ['hm_chamber_of_nullification'] = 613,
  ['hm_imperators_rise'] = 614,
  ['hm_throne_of_imperator'] = 615,

  -- Blackrock Foundry
  ['bf_black_forge'] = 596,
  ['bf_slagworks'] = 597,
  ['bf_workshop'] = 598,
  ['bf_iron_assembly'] = 599,
  ['bf_crucible'] = 600,

  -- Hellfire Citadel
  ['hfc_hellfire_citadel'] = 661,
  ['hfc_hellfire_antechamber'] = 662,
  ['hfc_hellfire_passage'] = 663,
  ['hfc_pits_of_mannoroth'] = 664,
  ['hfc_court_of_blood'] = 665,
  ['hfc_grommashs_torment'] = 666,
  ['hfc_felborne_breach'] = 667,
  ['hfc_halls_of_sargerei'] = 668,
  ['hfc_destructors_rise'] = 669,
  ['hfc_black_gate'] = 670,
}

-- Iterate all maps and assign their ids, so we can use them for our points.
for _, id in pairs(maps) do
  points[id] = {}
end

this.maps = maps
this.points = points

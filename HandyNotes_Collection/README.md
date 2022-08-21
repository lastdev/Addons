# HandyNotes: Collection

![GitLab Release (latest by SemVer)](https://img.shields.io/gitlab/v/release/29598319)
[![pipeline status](https://gitlab.com/mulambo/HandyNotes_Collection/badges/master/pipeline.svg)](https://gitlab.com/mulambo/HandyNotes_Collection/-/commits/master)
![Lines of code](https://img.shields.io/tokei/lines/gitlab/mulambo/HandyNotes_Collection)
[![Discord](https://img.shields.io/discord/913407805074055169?logo=Discord)](https://discord.gg/y3BukFRv3D)

This addon will sometime serve as big collection of HandyNotes around the World (of Warcraft).

Currently, this is more like a development project, to learn lua and wow plugin programing.

If you have any comment, issue or feature request, you can leave me a note on Discord (link in icon), create issue on Gitlab or send a me a message where you see fit.

## Configuration

Configuration for this addon can be found under HandyNotes (Interface -> Addons -> HandyNotes -> Plugins -> Collection).

At current time, you can modify configuration for Waypoints and Collection (tracking).

### Waypoints

Waypoints can be enabled or disabled, and you can change their size and opacity.

### Collection (tracking)

You can opt out (hide) collection icons from map. Size and opacity can be configured.

#### Use summary point

Summary point works on continent maps (e.g. map of all Draenor maps). It aggregates all items in specific maps a filters out missing ones.

#### Show completed

Enabling this shows completed (achievement, pets, mounts etc.) points on map.

#### Track transmogs

There is a lot of transmogs from treasures and rares, and it can overcrowd your map. You can disable transmog tracking if you are achievement / mount / pet / toy person only.

#### Show unobtainable transmogs

This switches, if unobtainable items (like cloth on warrior) should be shown on map or in tooltips.

#### Track exact transmogs

This works like in All The Things addon (Completionist Mode). If you enable this, transmogs will track exact Visual ID source for item. If this is disabled, it will check, if you have same Source ID and count it as collected.

## Features

### Waypoints in instances

__This section is deprecated in version 0.11.0 and scheduled for removal in 0.13.0. There will be standalone addon for waypoints.__

This adds waypoints (transitions between maps) to past dungeons and raids like we know it from Legion and onwards.
In the future, this might be expanded to mini maps all over the world (like Caverns of Time).

- Waypoints in all __pre-Legion__ raid instances for easier orientation:

  - __Classic__ raids (_Blackwing Lair, Temple of Ahn'Qiraj_).
  - __Burning Crusade__ raids (_Karazhan, Black Temple, Sunwell Plateau_).
  - __Wrath of the Lich King__ raids (_Naxxramas, Ulduar, Trial of Crusader, Icecrown Citadel_).
  - __Cataclysm__ raids (_Blackwing Descent, Bastion of Twilight, Firelands, Dragon Soul_).
  - __Mists of Pandaria__ raids (_Heart of Fear, Mogu'shan Vaults, Throne of Thunder, Siege of Orgrimmar_).
  - __Warlords of Draenor__ raids (_Highmaul, Blackrock Foundry, Hellfire Citadel_).
- Waypoints in all __pre-Legion__ dungeon instances for easier orientation:
  - __Classic__ dungeons (_Blackfathom Deeps, Blackrock Depths, Dire Maul, Gnomeregan, Lower Blackrock Spire, Maraudon, Scarlet Halls, Scarlet Monastery, Scholomance, Shadowfang Keep, The Deadmines, Uldaman_).
  - __The Burning Crusade__ dungeons (_Auchenai Crypts, Magisters' Terrace, Sethekk Halls, The Arcatraz, The Mechanar, The Steamvault_).
  - __Wrath of the Lich King__ dungeons (_Azjol-Nerub, Culling of Stratholme, Drak'Tharon Keep, Halls of Lightning, The Oculus, Utgarde Keep, Utgarde Pinnacle_).
  - __Cataclysm__ dungeons (_Blackrock Caverns, End Time, Halls of Origination, Hour of Twilight, Throne of Tides_).
  - __Mists of Pandaria__ dungeons (_Gate of the Setting Sun, Mogu'shan Palace, Siege of Niuzao Temple, Shado-Pan Monastery, Stormstout Brewery, Temple of the Jade Serpent_).
  - __Warlords of Draenor__ dungeons (_Grimrail Depot, Shadowmoon Burial Grounds, Skyreach, The Everbloom, Upper Blackrock Spire_).

## Tracking

You can find list of locations and items, that are currently added below.

### Warlords of Draenor

- [Voidtalon](https://www.wowhead.com/item=121815/voidtalon-of-the-dark-star)
- [I Found Pepe!](https://www.wowhead.com/achievement=10053/i-found-pepe) achievement.
- Pet Battles for [Taming Draenor](https://www.wowhead.com/achievement=9724/taming-draenor) achievement.
- Pet Battles for [An Awfully Big Adventure](https://www.wowhead.com/achievement=9069/an-awfully-big-adventure) achievement.

#### Frostfire Ridge

- [Gorok](https://www.wowhead.com/npc=50992/gorok)
- [Nok-Karosh](https://www.wowhead.com/npc=81001/nok-karosh)
- [Breaker of Chains](https://www.wowhead.com/achievement=9533/breaker-of-chains) achievement
- Toys / Pets / Transmogs (chests missing atm.)

#### Shadowmoon Valley

- [Pathrunner](https://www.wowhead.com/npc=50883/pathrunner)
- Rare for [A Demidos of Reality](https://www.wowhead.com/achievement=9437/a-demidos-of-reality) achievement.
- [It's the Stones!](https://www.wowhead.com/achievement=9436/its-the-stones) achievement.
- [Take From Them Everything](https://www.wowhead.com/achievement=9435/take-from-them-everything) achievement.
- [You Have Been Rylakinated!](https://www.wowhead.com/achievement=9481/you-have-been-rylakinated) achievement.
- Toys / Pets / Transmogs (chests missing atm.)

#### Gorgrond

- [Poundfist](https://www.wowhead.com/npc=50985/poundfist)
- Rares for [Gorgrond Monster Hunter](https://www.wowhead.com/achievement=9400/gorgrond-monster-hunter) achievement.
- Rares for [Fight the Power](https://www.wowhead.com/achievement=9655/fight-the-power) achievement.
- Rares for [Ancient No More](https://www.wowhead.com/achievement=9678/ancient-no-more) achievement.
- Treasures for [Grand Treasure Hunter](https://www.wowhead.com/achievement=9728/grand-treasure-hunter) achievement.
- [In Plain Sight](https://www.wowhead.com/achievement=9656/in-plain-sight) achievement.
- Toys / Pets / Transmogs

#### Talador

- [Silthide](https://www.wowhead.com/npc=51015/silthide)
- Rares for [Heralds of the Legion](https://www.wowhead.com/achievement=9638/heralds-of-the-legion) achievement.
- Rares for [Cut off the Head](https://www.wowhead.com/achievement=9633/cut-off-the-head) achievement.
- [Poor Communication](https://www.wowhead.com/achievement=9637/poor-communication) achievement.
- [United We Stand](https://www.wowhead.com/achievement=9636/united-we-stand) achievement.
- [Bobbing for Orcs](https://www.wowhead.com/achievement=9635/bobbing-for-orcs) achivement.
- [The Power Is Yours](https://www.wowhead.com/achievement=9632/the-power-is-yours) achievement.
- Treasures for [Grand Treasure Hunter](https://www.wowhead.com/achievement=9728/grand-treasure-hunter) achievement.
- Toys / Pets / Transmogs

### Spires of Arak

- Rares for [King of the Monsters](https://www.wowhead.com/achievement=9601/king-of-the-monsters) achievement.
- [A-VOID-ance](https://www.wowhead.com/achievement=9433/cut-off-the-head) achievement.
- [Fish Gotta Swim, Birds Gotta Eat](https://www.wowhead.com/achievement=9613/fish-gotta-swim-birds-gotta-eat) achievement.
- Treasures for [Grand Treasure Hunter](https://www.wowhead.com/achievement=9728/grand-treasure-hunter) achievement.
- Toys / Pets / Transmogs

#### Nagrand

- [Luk'hok](https://www.wowhead.com/npc=50981/lukhok)
- [Nakk the Thunderer](https://www.wowhead.com/npc=50990/nakk-the-thunderer)
- Rare for [Making the Cut](https://www.wowhead.com/achievement=9617/making-the-cut) achievement.
- Rares for [The Song of Silence](https://www.wowhead.com/achievement=9541/the-song-of-silence) achievement.
- Rares for [Broke Back Precipice](https://www.wowhead.com/achievement=9571/broke-back-precipice) achievement.
- [History of Violence](https://www.wowhead.com/achievement=9610/history-of-violence) achievement
- [Buried Treasures](https://www.wowhead.com/achievement=9548/buried-treasures) achievement.
- Treasures for [Grand Treasure Hunter](https://www.wowhead.com/achievement=9728/grand-treasure-hunter) achievement.
- Toys / Pets / Transmogs

#### Tanaan Jungle

- Rares for [Jungle Stalker](https://www.wowhead.com/achievement=10070/jungle-stalker) achievement.
- Rares for [Hellbane](https://www.wowhead.com/achievement=10061/hellbane) achievement.
- Pet Battles for [Tiny Terrors in Tanaan](https://www.wowhead.com/achievement=10052/tiny-terrors-in-tanaan) achievement.
- Treasures for [Jungle Treasure Master](https://www.wowhead.com/achievement=10262/jungle-treasure-master) achievement.
- [Predator](https://www.wowhead.com/achievement=10334/predator) Feast of Strength.
- Toys / Pets / Transmogs / Shipyard upgrades

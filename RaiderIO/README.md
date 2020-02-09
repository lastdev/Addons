# Raider.IO Mythic Plus & Raiding

## Overview

This is a companion addon to go along with the Raid and Mythic+ Rankings site, Raider.IO: https://raider.io. With this addon installed, you'll gain access to an easy way to view the Mythic Keystone scores and Raid Progress for players-- all without leaving the game!

Simply hover over a player with your mouse, your guild roster, or even the Group Finder list where you see queued people; if they meet the minimum qualifications then you'll see their score and best run in the tooltip.

![Raider.IO Tooltip Example](https://cdnassets.raider.io/images/addon/tooltip_details_20190225.png "Raider.IO Tooltip Example")

Additionally, you can right-click players from the standard target unit frame to `Copy Raider.IO URL` and then easily look up their full profile on the site. With this functionality you can directly paste these URLs anywhere on Raider.IO to navigate to that player's profile page.

If you have run into any problems, check out our FAQ at https://raider.io/faq, or join us on Discord at: https://discord.gg/raider #addon-discussions -- we always have people around willing to help.

[![Become a Patron](https://cdnassets.raider.io/images/patreon/become_a_patron_button.png "Become a Patron")](https://www.patreon.com/bePatron?u=6788452)

## Getting Started

The easiest way to get started is to use the RaiderIO Desktop App: https://raider.io/addon

Once installed you can load into the game and you will start seeing Scores and Best Runs on players around you. This AddOn works by storing a snapshot of character data from Raider.IO and then using that to populate information on qualified players. To qualify for inclusion in a snapshot, players must meet this criteria:

- Have earned at least 200 points in the current or previous season. _[Honored and higher patrons](https://www.patreon.com/bePatron?u=6788452) do not have a minimum score requirement in order to be shown in the addon._
- Have logged in to the game within the past 21 days


**Remember**: We update the addon with the latest scores and top runs **multiple times each day**. Update regularly to ensure you are seeing the freshest information. _Using the RaiderIO Client you can keep your addon updated automatically!_

## Detailed Addon Usage

Our intent with this AddOn is to provide an easy way for people to get some information at a glance when forming groups. There is no substitute for talking with your fellow players, so be a pal and listen if an applicant whispers you. These are the fields we show, and when we show them:

### Character Raid & Mythic+ Tooltips

Raid information in tooltips simply lists the best progress seen for the player.

Mythic+ tooltips have a lot of parts to them:

- `Raider.IO M+ Score`: This is the overall score for this character. If the score is from a previous season, then the value of the score is rounded to the nearest 10s, and is prefixed with `±`. You can also identify the previous season score by looking for the `(S#)` suffix on the tooltip headline.
- `Best Run`: This will indicate the Mythic+ level for the player's best scoring run, along with the specific dungeon. Up to three plus signs `+` will be prefixed to the keystone level to indicate how much the keystone was upgraded during that run. Note: when this keyword is highlighted green it means that the player's `Best For Dungeon` is also the same as their overall `Best Run`.
- `Best For Dungeon`: You'll see this line when using LFD to form or join a Keystone group. This will show the Mythic+ level of the player's best scoring run for the chosen dungeon.
- `Timed #+ Runs`: These lines indicate how many M+ runs have been completed by this player within the timer over the course of the current season. The player's two highest categories of Timed Runs will show by default.
- `Main's Best M+ Score` / `Main's Current M+ Score`: This indicates the best character score on this player's account, if they have [registered on Raider.IO](https://raider.io/register) and linked their Battle.Net account. This will only show if the Main's Score is greater than the current character's score. If someone has a good score on their main, then much of their prior experience will help them perform better in dungeons while on their alt.

Role icons included on Mythic+ tooltips can be thought of as badges earned by accumulating certain amounts of score while playing as that role. Fully opaque icons indicate they've earned at least 80% of their overall score in that role. Semi-transparent role icons indicate they have earned at least 40% of their overall score in that role.

### Character Profile Tooltips

You can view your personal M+ and Raid Progress profile when you open the Dungeon Finder. This will be shown as a large tooltip alongside the Dungeon Finder frame with additional details about your per-dungeon performance.

This can be used to help understand what dungeons you should try to focus on in order to raise your score.

![Raider.IO Profile](https://cdnassets.raider.io/images/addon/raiderio_profile_20190225.png "Raider.IO Profile")

By default when you are in the Dungeon Finder it will show your own profile. However, you can press a modifier key (Shift/Alt/Ctrl/Cmd) to show the target character's full profile instead. There is also a config option to invert this behavior.

### Keystone Tooltips

You can view additional details when hovering over Mythic+ Keystone items, such as:

- The highest key completed for each member of your group for the dungeon you are in, or queued for.

- `Avg. Timed +# Player Score`: This is the rounded median score of players who have successfully completed Mythic+ runs **in time** at this level. This data is sampled from the past 60 days of runs tracked on Raider.IO, and it excludes the top and bottom 1% of scores at each level. This is intended to provide a guide for the type of score you might consider when forming or joining a group based on data seen across all players.

### Group Search

You can pull up detailed information for all the characters in your group at once by utilizing the Raider.IO Group Search feature.

![Raider.IO Group Search](https://cdnassets.raider.io/images/addon/group_search_in_lfd.png "Raider.IO Group Search")

- Click the magnifying glass icon at the bottom of the Dungeon Finder
- Copy the text in the window that pops up
- Go to https://raider.io and hit Ctrl-V or Cmd-V to paste this while the site is in the foreground.

This will then take you to the Raider.IO Advanced Search page for all the characters in your group.

### Copy Character Raider.IO URL

- Click the "Copy Raider.IO URL" button
- Copy the text in the window that pops up
- Go to https://raider.io and hit Ctrl-V or Cmd-V to paste this while the site is in the foreground.

This will take you to that character's profile page.

### In-Game Character Search (Advanced)

![Raider.IO In-Game Character Search](https://cdnassets.raider.io/images/addon/raiderio_search.png "Raider.IO In-Game Character Search")

You can look up any character in the current database by using the `/rio search` command.

When you type this, you will be presented with a small frame where you can enter the realm name and character name to search for. If they are found, then their information will be pulled up and displayed.

You can type `/rio search` to hide the window.

## Configuring the AddOn

Our recommended settings are enabled by default, but we've provided several options to customize how and where the tooltips might show while in-game. Type ``/raiderio`` to open the Raider.IO options frame. Alternatively, you can also find a shortcut in the ``Interface > AddOn`` settings frame.

Here you can easily enable or disable various features, including whether to show scores from each faction, and various tooltip customization options.

_Remember to click "Save" to save the changes, or "Cancel" to abort and close the dialog._

## Score Color Tiers

Scores map to a specific color based on their range. We've followed the standard WoW quality colors, but added additional gradients between the base values to provide more brackets to ascend through. These tiers are recalculated based on actual scores.

## Patreon Rewards

Interested in supporting development of Raider.IO and getting some rewards while you're at it? We offer multiple levels of rewards.

__Friendly:__

- Browse Raider.IO AD-FREE!
- Friendly Patron rank in Discord

__Honored:__

- Exclusive profile header background options
- Minimum score requirement removed from addon
- Elevated queue priority
- Honored Patron rank in Discord
- Plus all rewards from Friendly tier

__Revered:__

- Desktop client updates scores 4 times a day 
- Custom Vanity URL for your guild or character
- Queue priority elevated above Honored level
- Revered Patron rank in Discord
- Plus all rewards from Friendly and Honored tiers

__Exalted:__

- Desktop client updates scores 8 times a day 
- Utilize up to 2 Custom Vanity URLs
- Queue priority elevated above Revered level
- Automatically qualify for all locked header backgrounds
- Exalted Patron rank in Discord
- Plus all rewards from Friendly, Honored, and Revered tiers


[![Become a Patron](https://cdnassets.raider.io/images/patreon/become_a_patron_button.png "Become a Patron")](https://www.patreon.com/bePatron?u=6788452)

## Developer API

We love our fellow developers! We wanted to provide anyone in the community a simple way to tap into the scores that are a part of this addon. Addon developers can do this by utilizing the ``RaiderIO`` table to access certain APIs we provide.

### RaiderIO.ProfileOutput

A collection of bit fields you can use to combine different types of data you wish to retrieve, or customize the tooltip drawn on the specific GameTooltip widget.

### RaiderIO.TooltipProfileOutput

A collection of functions you can call to dynamically build a combination of bit fields used in ProfileOutput that also respect the modifier key usage and config.

### RaiderIO.DataProvider

A collection of different ID's that are the supported data providers. The profile function if multiple data types are queried will return a group back with dataType properties defined.

### RaiderIO.HasPlayerProfile

A function that can be used to figure out if Raider.IO knows about a specific unit or player, or not. If true it means there is data that can be queried using the profile function.

```
RaiderIO.HasPlayerProfile(unitOrNameOrNameRealm, realmOrNil, factionOrNil) => true | false
  unitOrNameOrNameRealm = "player", "target", "raid1", "Joe" or "Joe-ArgentDawn"
  realmOrNil            = "ArgentDawn" or nil. Can be nil if realm is part of unitOrNameOrNameRealm, or if it's the same realm as the currently logged in character
  factionOrNil          = 1 for Alliance, 2 for Horde, or nil for automatic (looks up both factions, first found is used)
```

### RaiderIO.GetPlayerProfile

A function that returns a table with different data types, based on the type of query specified. Use the explanations above to build the query you need.

```
RaiderIO.GetPlayerProfile(unitOrNameOrNameRealm, realmOrNil, factionOrNil, ...) => nil | profile, hasData, isCached, hasDataFromMultipleProviders

RaiderIO.GetPlayerProfile(0, "target")
RaiderIO.GetPlayerProfile(0, "Joe")
RaiderIO.GetPlayerProfile(0, "Joe-ArgentDawn")
RaiderIO.GetPlayerProfile(0, "Joe", "ArgentDawn")
```

### RaiderIO.ShowTooltip

Use this to draw on a specific GameTooltip widget the same way Raider.IO draws its own tooltips.

```
ShowTooltip(GameTooltip, outputFlag, ...) => true | false
  Use the same API as used in GetPlayerProfile, with the exception of the first two arguments:
    GameTooltip = the tooltip widget you wish to work with
    outputFlag  = a number generated by one of the functions in TooltipProfileOutput, or a bit.bor you create using ProfileOutput as described above.

RaiderIO.ShowTooltip(GameTooltip, RaiderIO.TooltipProfileOutput.DEFAULT(), "target")
```

### RaiderIO.GetScoreColor

Returns a table containing the RGB values for the specified score.

```
RaiderIO.GetScoreColor(5000) => { 1, 0.5, 0 }
```

### Deprecated

Please refrain from using these API as they will be removed in future updates.

```
RaiderIO.GetScore
RaiderIO.GetProfile
```

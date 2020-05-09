### 8.3.11

- Add Holy Priest Default-scale by Simbiawow

### 8.3.10

- Fix error in one of the lines in French translations causing error on login. This fixes [Issue #67](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/67).

### 8.3.9

- Update French translations (thanks to Simbiawow)

### 8.3.8

- Poke the packager.

### 8.3.7

- Updated Default-scales (SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051))
   - I used `target_error=0.05` and it took almost 70 hours to run all the simulations with my old CPU (you are welcome for the CPU time).
   - Because of the time spent, in the future I won't be doing simulations in this accuracy anymore unless I figure out some way to optimize the simulations in order to get the runtime down.
- Fixed a bug causing the Essence UI to only color the top two minor essences instead of top three.

### 8.3.6
- Fix bug where you get error when you close Azerite UI when scores for that UI is disabled or something else went wrong. This fixes [Issue #63](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/63).
- Update Traditional Chinese translations.

### 8.3.5
- Added new feature to enable/disable the scores for Azerite Traits and Azerite Essences as requested in [Issue #60](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/60).
   - You can find these new settings by checking out the config at `ESC -> Interface -> AddOns -> AzeritePowerWeights`.
   - This means 4 new lines for translators to translate at  [Curseforge Localization tool](https://www.curseforge.com/wow/addons/azeritepowerweights/localization).
- Also made other small bug and QoL fixes in order to make the scores show and update more reliably.

### 8.3.4
- Added missing Retribution Paladin Default-scales.
   - Thanks to both Retribution Paladin -players who actually read the change log and didn't report me them missing!

### 8.3.3
- Added missing Protection Warrior -scales (SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051))
   - Still missing Retribution Paladin Default-scale
- Updated all Defensive -scales without external source (SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051))
  - Protection Warrior one is even more all over the place than other classes, so don't trust that.

### 8.3.2

- Updated Default-scales (SimulationCraft 830-01 for World of Warcraft 8.3.0 Live (wow build 33051))
   - Missing Retribution Paladin and Protection Warrior scales

### 8.3.1

- Fix missing changelog from previous update, once again... (Apparetnly it is still too hard for me to press the 'Save'-button in editor before pushing to the Github)
- Fix the addon not loading because of broken if-then-else -evaluation [Issue #50](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/50). Thanks to ganksmacker1 for reporting this.

### 8.3.0

- TOC update
- Added new 8.3 Azerite Traits and Azerite Essences

### 8.2.17

- Updated Default-scales (SimulationCraft 820-02 for World of Warcraft 8.2.0 Live (wow build 31478))

### 8.2.16

- Update Russian translations

### 8.2.15

- Maybe this time we fix the [Issue #47](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/47) for real?
   - There is new setting which is on by default and the addon works like previously prefering the highest scored major essence and selecting best minor essences after that.
   - When the new setting is disabled, the addon will calculate overall scores for couple different high scored major essences and pick the highest scored overall combination.
   - With the introduction of this new setting, there is two more strings for translators at [Curseforge Localization tool](https://www.curseforge.com/wow/addons/azeritepowerweights/localization).
- The addon is now coloring the best traits and essences for you.
   - For azerite traits the addon will color the highest scored trait(s) for every tier with heirloom-color to help you see them faster.
   - For azerite essences the addon will color the highest scored major essence(s) with legendary-color and the minors with heirloom-color to help you see them faster.

### 8.2.14

- Last update didn't solve [Issue #47](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/47) so I'm updating some debug tools to help me find the source of the bug.

### 8.2.13

- Fix bug where minor essences got wrong value in potential and maximum calculations. This should fix [Issue #47](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/47)
- Show both major and minor values in the major slot instead of combined value in EssenceUI.

### 8.2.12

- Update Russian translations
- Fix missing changelog from last update

### 8.2.11

- Updated Default-scales (SimulationCraft 820-02 for World of Warcraft 8.2.0 Live (wow build 31478))
- At least Traditional Chinese translations have been updated
- Minor version TOC bump because it was bothering someone

### 8.2.10

- Fixed a bug where slash-sign ('/') in scales name would make the scale unselectable in the scales list. This solves [Issue #46](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/46)
- New feature: There is a button in scale editor to switch between Trait-weights and Essence-weights of the scale.
   - This adds two new strings for translators to translate at [Curseforge Localization tool](https://www.curseforge.com/wow/addons/azeritepowerweights/localization)
- Updated one API call to match todays standards.
- Changing Github Webhook to BigWigs packager -script
- No changes to the Default-scales. They will follow in another update soon(tm) when I have time to run them first.

### 8.2.9

- Updated Default-scales (SimulationCraft 820-02 for World of Warcraft 8.2.0 Live (wow build 31429))
- New Blood Death Knight Defensive scale by Acherus.
- There has been update on German-translations at some point.

### 8.2.8

- Added missing Default-scale for Enhancement Shaman. This solves [Ticket #40](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/40) by Mastadood.
- Also fixed bug where changes made for the Azerite Essence -scoring was reverted to pre-8.2 code and might have caused weird stuff with timestamps of Default-scales.

### 8.2.7

- Update Default-scales (SimulationCraft 820-02)

### 8.2.6

- Moved misplaced `Person-Computer Interface` from `Professions Powers` to `Zone Powers`. [Ticket #35](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/35)
   - While fixing this, found and fixed bug where `Clockwork Heart` wasn't showing up in the Weight Editor at all (you can find it now also under `Zone Powers`).

### 8.2.5

- Removed two mispalced commas that sabotaged the previous release. [Ticket #34](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/34)

### 8.2.4

- Fixed the missing Azerite Traits (When you automate stuff, remember to update your automation tools also when updating data!) [Ticket #33](https://www.curseforge.com/wow/addons/azeritepowerweights/issues/33)

### 8.2.3

- Fixed Azerite Essences current potential score and maximum score calculations resulting in wrong scores if you scroll the Essence-list down.
- Even more Debug-stuff added.

### 8.2.2

- Added more Debug-stuff to help me to solve tickets in the future.

### 8.2.1

- Update Default-scales (SimulationCraft 820-01)
- Update on translations
   - The new Curseforge page makes it really hard to keep track on what languages has changed and who contributed, so sorry for I can't name you here like I have done in the past.
- Raised the layer where the Azerite Essence scores were drawn on the scoll element on the right side of the UI since they disappeared from me after the weekly reset.

### 8.2.0

- TOC update
- Added support for Azerite Essences, but there isn't any weights for them since I didn't have time to update my tools yet.
- Also Default-scales are old, I'll push out update when the sims are done (I have really slow CPU).
- 5 new strings for translators to translate at [Curseforge Localization tool](https://www.curseforge.com/wow/addons/azeritepowerweights/localization)
- New version of Import-strings supports Azerite Essences, but the old strings should still import
   - If you import old version string, it will create a new copy instead of updating the existing one even if `Importing can update existing scales` is turned on.
- Added outline around the score numbers in Azerite Trait and Azerite Essence UIs to make it easier to read the numbers if they are on top of a light icon.
   - This can be turned off from the config if you don't like the new look.
- Fixed one or two leaking globals.

### 8.1.15

- Update Default-scales (SimulationCraft 815-02)
- Update Russian (Hubbotu) and Traditional Chinese (BNSSNB) translations

### 8.1.14

- Fixed the calculations missing rings from World Quest reward tooltips [Ticket #25](https://wow.curseforge.com/projects/azeritepowerweights/issues/25)
- Added also small tool to help me find the errors in calculations in the future. This adds one new line for translators to be translated.
   - If you want to contribute, go to [Curseforge Localization tool](https://wow.curseforge.com/projects/azeritepowerweights/localization) and help translate, review and/or correct the translations.

### 8.1.13

- Update German (Aurielqt), Russian (dartraiden) and Traditional Chinese (BNSSNB) translations

### 8.1.12

- Update Default-scales to 8.1.5
- Added "Mass Import"-feature, you can now Import multiple scales at once
   - Mass Import accepts normal Import-strings separated by linechange (aka, every Import-string in its own line).
- Added Created/Imported/Updated -feature [Ticket #15](https://wow.curseforge.com/projects/azeritepowerweights/issues/15)
   - This shows the date the scale was Created, Imported or Updated last time.
   - Changing the values on the scale will update the Updated timestamp.
- Added feature to hide Custom-scales for other than your current spec
   - This is off by default, but can be enabled in the Config same place where you setup the hiding of Default-scales for other specs.
- These new features means there are new lines to be translatated.
   - If you want to contribute, go to [Curseforge Localization tool](https://wow.curseforge.com/projects/azeritepowerweights/localization) and help translate, review and/or correct the translations.

### 8.1.11

- 8.1.5 compatibility fixes
- Adds +5 to itemlevel calculations if the center trait is open but not selected. [Ticket #22](https://wow.curseforge.com/projects/azeritepowerweights/issues/22)
- I'll add few new planned features in the near future and redo the Default-scales asap SimulationCraft updates their stuff for 8.1.5

### 8.1.10

- Blizzard made some significant changes to some of the Azerite-traits so I re-simmed the Default-scales with the newest nightly build of SimulationCraft
- While wathing russian streamer who happened to use this addon, I noticed the `PowersScoreString` floored decimals for him. I checked the translations and made changes to German, Korean, Russian and Traditional Chinese translations on that line to let people using those translations also see the decimals in the calculations. Translators should go and make sure the updated line still makes sense.

### 8.1.9

- Update Default-scales (`target_error=0.05`)
   - Protection Warriors seems to be supported now by SimulationCraft so they also get scales this time.

### 8.1.8

- Trying to remove duplicate traits from class traits [Ticket #19](https://wow.curseforge.com/projects/azeritepowerweights/issues/19)
   - Let me know if I missed some or removed something I shouldn't have.

### 8.1.7

- Update French translations.

### 8.1.6

- Fixing error in relative scores with itemlevels on tooltips
- Minor bug fixes

### 8.1.5

- More fixes to the Default-scales not loading on some non-English clients.

### 8.1.4

- Trying to fix the Default-scales not loading on some non-English clients.
- Update Default-scales with more accurate ones (`target_error=0.05`).

### 8.1.3

- Fix the missing class defensive traits for Shamans.
- Updated German translations.

### 8.1.2

- Add support for new 8.1 traits in Weight Editor.
   - Don't hesitate to open a ticket or contact me other ways if you find traits missing or in wrong places.
- Update Default-scales for 8.1 with quick and dirty sim results (using SimC default `target_error=0.2`).
   - I'll add more accurate results in the near future.
   - Don't hesitate to contact me if you want to help me improve the Default-scales or offer your own as Default for class/spec.
- Updated German translations.

### 8.1.1

- Trying to fix the bug where trait scores won't be shown after first time (or after a short period of time if you are fast) you open up the AzeriteItemUI.

### 8.1.0

- TOC update
- This is mostly to fix the invisible score texts.
   - The addon supports new 8.1 traits via importing them (export, edit and import your own scales if you are experienced user), even when they don't show up in the editor yet. Working on it.
   - Also no changes to Default-scales. Updated Default-scales will be delivered as soon as my box of worms has run all the simulations.
- Translators are more than welcome to contribute their efforts at [Curseforge Localization tool](https://wow.curseforge.com/projects/azeritepowerweights/localization)

### 8.0.29

- Update German translations

### 8.0.28

- Update Russian translations

### 8.0.27

- dartraiden fixed few typos in English translations
- Update Russian translations

### 8.0.26

- Update German translations

### 8.0.25

- Update French, German, Russian, Simplified Chinese and Traditional Chinese translations

### 8.0.24

- Added option to add primary stats (Agi/Int/Str) to the score calculations. In Azerite item +1 stat = +1 score in calculations.
- This adds 2 new lines for translators at [Curseforge Localization tool](https://wow.curseforge.com/projects/azeritepowerweights/localization)

### 8.0.23

- Updating Russian translations

### 8.0.22

- Fix visibility of Weight Editor when using addon "Aurora"
- Updating Russian translations

### 8.0.21

- Updated Default-scales because Blizzard has done some balancing on Azerite powers.
- Updating Traditional Chinese translations

### 8.0.20

- Added legend for "Current score / Current potential / Maximum score" for the tooltips. This can be disabled in the config.
- Added also short explanation of different scores to the config.
- Updating Simplified Chinese translations

### 8.0.19

- Updating Russian translations

### 8.0.18

- Fixes to "add itemlevel" calculations when relative values are enabled.
- Adding tooltips for normal quest rewards ([ticket #12](https://wow.curseforge.com/projects/azeritepowerweights/issues/12))

### 8.0.17

- Trying to fix the `attempt to index local 'dataPointer' (a nil value)` error
- Updating Traditional Chinese -translations

### 8.0.16

- Fixing the calculation error in Relative values... Fractions are fun.

### 8.0.15

- **The setting to hide role specific traits for other than your current specs role in the Weight Editor wasn't clear to some people so I changed the default value of that setting for ALL characters (existing and new).**
   - Addon now shows all role specific traits in the Weight Editor by default.
   - If you don't want to see them, you can enable hiding them in the settings.
   - The reason why it was on by default in previous versions was because some hybrid classes has access to quite a lot of traits and I wanted to keep the Weight Editor as clutter free as possible, but this caused some people to not find the trait they were looking for and clearly didn't know about the setting.
- Role specific traits have now icons in front of the trait name to illustrate what roles the traits are aimed for.
   - **If you can see them in the editor, the traits can still appear and you can pick them even if they are marked for different role. It is not a bug for hybrid class to see role traits for other roles than the current specs role.**
- Add itemlevel to score calculations can now be scaled using the weight of Azerite Empowered trait (the center trait) if you don't like the default +1 itemlevel == +1 score.
   - All scores can now be shown as relative to currently equipped items scores in tooltips.
   - Relatives scores can be shown/hidden in the tooltips based on if it has any upgrade potential.
- Few new lines to translate and at least one changed line for translators.
   - Also made a small help page to this addons project page at Curseforge to give translators some context where some of the strings are used at.

### 8.0.14

- Update Russian translations, few first lines translated in Spanish by isaracho.

### 8.0.13

- Translations update

### 8.0.12

- Add scores to comparison tooltips and vendor tooltips

### 8.0.11

- Translation updates for German, Simplified Chinese and Traditional Chinese

### 8.0.10

- New option to add itemlevel to the score calculations.
   - +1 itemlevel is +1 point in score.
   - This is off by default and you can enable it in the config.
- 3 new phrases for translators.
- Translation updates including new Brazilian Portuguese translation by mariogusman

### 8.0.9

- Fix the traits data after I broke it on last update.
- Few more Korean translations by Killberos

### 8.0.8

- Fixed the missing traits for some specializations, if you are still missing specialization specific traits, let me know
- Updated the Default-scales, now they should be little bit more accurate, but still can't promise 100%
- More translations:
   - French by tthegarde
   - Korean by Killberos
   - More Simplified Chinese by plok245
   - **Translators ahoy, L.PowersScoreString has changed. Go check your translations if you need to fix it**
- Small bug fixes

### 8.0.7

- Tying to fix the "'guiContainer' (a nil value)" -errors
- Updating translations (including new Simplified Chinese translations by riggzh)

### 8.0.6

- Additional check for tooltips to prevent errors
- More translations by BNSSNB (Traditional Chinese), dartraiden (Russian) and Sinusquell (German)

### 8.0.5

- Finally fix the [ticket #1](https://wow.curseforge.com/projects/azeritepowerweights/issues/1)
  - And fix it for real this time (I downloaded bdCore to make sure it stays fixed)
- Traditional Chinese (zhTW) translations by BNSSNB

### 8.0.4

- Added scales to tooltips, fixed bugs and updated translations
   - You can now enable scales to be shown on your tooltips
   - You can enable multiple scales to be shown on tooltips at any given time to make it easier for example compare item between single target vs. multi-target without the need to change active scale in the addon.
   - Should work most of the time, but there might be some bugs etc. still around.
- All scales now can show decimals in their scores, the accuracy is up to highest decimal count found on the current items power weights.
   - Thanks to Spookyturbo for pointing this out.
- Tooltips-feature added 2 new strings to the localizations.
- 13 new translations in Germany (deDE), thanks to Sinusquell
- More fixes to [ticket #1](https://wow.curseforge.com/projects/azeritepowerweights/issues/1)

### 8.0.3

- Added Profession created item specific powers and PvP powers.
   - Both of these categories are off by default from the Weight Editor, but powers will be scored with them if they exists in the scales like with every other category.
   - You can turn these categories on by checking config in `ESC -> Interface -> AddOns -> AzeritePowerWeights`.
- Currently only profession created item with Azerite powers are the Engineering goggles, but I named it as `Professions` to keep it future-proof.
- When PvP-category is enabled, you'll only see your own factions powers, but changes made to them will be mirrored so you can use same Custom-scales for characters on different factions.
   - When you Export scale to a string, you'll get export-string with only your own factions powerIDs to keep the string shorter, but these are interchangeable with opposing factions IDs.
   - When you Import scale from string with only one factions PvP powers, the weights will be mirrored to both factions powers.
- Edit the Settings coloring to make it look less restless
- More settings fine tuning.
- Added name of the current active scale to the Weight Editors statusbar at the bottom.

### 8.0.2

- Typo in Strings.lua

### 8.0.1

- Trying to fix [ticket #1](https://wow.curseforge.com/projects/azeritepowerweights/issues/1)

### 8.0.0

- Initial release
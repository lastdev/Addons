# LFG Teleport Button

Retail-only. Shows a **secure teleport button** when your **LFG M+ application is invited**.  
Season coverage: **The War Within – Season 3** (static Group Finder activity IDs embedded).

## What it does
- Pops a 50×50 button at screen `(CENTER, x=0, y=250)`.
- Icon matches the invited dungeon; left-click casts its Teleport spell.
- **Cooldown overlay** is shown and the button text displays the dungeon name.
- If the teleport **is not learned**, the button hides and prints a chat note.
- On **successful cast** or **right-click**, the button hides itself.
- Hover: tooltip shows “Left Click to Teleport” and “Right Click to Close”.

## Dungeons & Spell IDs
- Ara-Kara, City of Echoes — icon **5899326**, spell **445417**  
- The Dawnbreaker — icon **5899330**, spell **445414**  
- Tazavesh: Streets of Wonder — icon **4062727**, spell **367416**  
- Tazavesh: So'leah's Gambit — icon **4062727**, spell **367416**  
- Priory of the Sacred Flame — icon **5899331**, spell **445444**  
- Operation: Floodgate — icon **6392629**, spell **1216786**  
- Halls of Atonement — icon **3601526**, spell **354465**  
- Echo-dome Al'dari — icon **6921877**, spell **1237215**

## Commands
- `/tpbutton lock` — toggles drag lock
- `/tpbutton show` — re-apply current dungeon (if any)
- `/tpbutton test N` — force-show button for dungeon index `N` (1–8)
- `/tpbutton reset` — reset button position to default (CENTER, 0, 250)

## Notes
- Attributes of the secure button cannot change during combat. If the invite arrives in combat, the addon prepares the button after combat ends.
- Matching priority (invite → button):
  1. Any `activityIDs` in the invite using the embedded Season 3 map
  2. The single `activityID` full name (Mythic Keystone only)
  3. Fallback: listing `name`, `comment`, `voiceChat` normalized against triggers
  
  Season 3 Activity IDs used:
  - 1016 (Tazavesh: Streets of Wonder), 1017 (Tazavesh: So’leah’s Gambit)
  - 1284 (Ara-Kara, City of Echoes), 1285 (The Dawnbreaker)
  - 1281 (Priory of the Sacred Flame), 1550 (Operation: Floodgate)
  - 1694 (Eco/Echo-dome Al’dari), 699 (Halls of Atonement)

## Install
Unzip to:  
`World of Warcraft/_retail_/Interface/AddOns/LFGTeleportButton/`

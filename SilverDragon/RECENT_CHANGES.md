## Changed in v90005.0

* Avoid a new issue which caused errors when showing/hiding the popup in 9.0.5 (had to remove some normal API calls here, so there might be subtle issues with the mouse working on a hidden-in-combat popup until this is resolved on Blizzard's end)
* Popups have been rewritten!
    * They're now a stack, rather than a new one immediately replacing the current popup. (If you prefer the old behavior, you can set the stack size to 1 in the options and it'll be about the same.)
    * They should overlap less windows now.
* Don't play multiple sounds at once. This was particularly bad for rares like the Beasts of Bastion, which simultaneously played the announcement four times, making it way too loud.
* Trim the final awwwk off of Ikiss' loot announcement
* Make help tooltips more compact in general
* Add mobs that trigger via the yell for Sire Ladinas
* Ability to toggle the map overlay per-zone by shift-clicking on the broker icon on the world map
* Add various missing questids and improve loot


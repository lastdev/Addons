# HandyNotes: Mists of Pandaria (Treasures and Rares)

## [v40](https://github.com/kemayo/wow-handynotes-lostandfound/tree/v40) (2025-08-16)
[Full Changelog](https://github.com/kemayo/wow-handynotes-lostandfound/compare/v38...v40) [Previous Releases](https://github.com/kemayo/wow-handynotes-lostandfound/releases)

- TOC for 11.2.0  
- Update handler submodule to main (c8ad669)  
    New changes:  
    d7f6bcf Let item rewards be specified with a count  
    4f3ace2 Make new way of creating item rewards backwards-compatible  
    a7fd7a3 Remove some surplus definitions from conditions.GarrisonTalent  
    9941429 Add C\_Traits support to render\_string and conditions  
    b2ba237 Add missing CLASSICERA flag that was interfering with learnable rewards  
    2d24ac2 Copy some more plain item properties in when upgrading them  
    7724067 Use C\_Map.GetMapRectOnMap instead of HereBeDragons for parent translation  
    0605808 Fix Trait condition to actually use the cached configID  
    2b89e07 Fix typo: self.configID not selfconfigID  
    15e13e8 Fix createWaypointForAll  
    0321016 Fall back from HBD to C\_Map instead of the other way around  
    c8ad669 Stop caching the configID for trait checks, as it causes first-load issues  
- Isle of Giants: show Ku'ma and the costs of his wares  
- Update handler submodule to main (faef5c4)  
    New changes:  
    4b24032 New reward type: BattlePet  
    1abeb56 Improve render\_string output for ranked factions  
    600539f Improve the Faction condition  
    a8d17f8 Pass through loot requirements when upgrading the table format  
    faef5c4 Add a way to show all loot regardless of requirements  

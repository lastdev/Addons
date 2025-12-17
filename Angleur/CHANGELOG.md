# Angleur

## [2.6.0](https://github.com/LegolandoBloom/Angleur/tree/2.6.0) (2025-12-15)
[Full Changelog](https://github.com/LegolandoBloom/Angleur/compare/2.5.95...2.6.0) [Previous Releases](https://github.com/LegolandoBloom/Angleur/releases)

- SPELLCAST\_START Random Resetter no longer resets 'previous randomed', only 'alreadyRandomed'  
- Fixed issue with prior mistake with addition of "MIRROR\_TIMER\_START"  
    (stupid lua dev mistake that took me a second to make and 2 hours to figure out)  
    Added Mirror Timer event trigger to Mists as well  
- Vanilla now no longer clears when swimming  
- porting the new action handler to Vanilla 2  
    Updated Angleur.toc(Retail) interface version number  
- porting the new action handler to Vanilla 1  
- porting the new action handler to Mists 2 (done)  
    Updated version number for mists  
- porting the new action handler to Mists  
- Renamed AngleurCata.xml and AngleurCata.lua to AngleurMists  
- Reworking the random system of the random bobber 2 (finished)  
- Reworking the random system of the random bobber 1  
- fixed accidental global mistake on AngleurCata.lua(the file for Mists, forgot to change name)  
- what  
- fixed overlap of standard panel in vanilla  
- did the same thing of last 3 commits with standard tab and tiny tab  
- changed all references of standard\_cata to standard\_mists  
    converted standard\_base, retail, mists into namespace versions instead of globals  
- converted eqMan\_base, retail into namespace versions instead of globals  
- changed all references of items\_cata to items\_mists  
    converted items\_base, retail, mists into namespace versions instead of globals  
- changed all references of toys\_cata to toys\_mists  
    converted toys\_base, retail, mists into namespace versions instead of globals  
- un-defaulted koKR.lua (oops)  
- fixed syntax error with koKR.lua  
    fixed accidental global read instead of local due to misspelling  

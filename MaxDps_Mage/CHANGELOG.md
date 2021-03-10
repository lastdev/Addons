# MaxDps_Mage

## [v9.0.2](https://github.com/kaminaris/MaxDps-Mage/tree/v9.0.2) (2021-02-15)
[Full Changelog](https://github.com/kaminaris/MaxDps-Mage/compare/v9.0.1...v9.0.2) [Previous Releases](https://github.com/kaminaris/MaxDps-Mage/releases)

- v9.0.2 - Frost simcraft  
- Merge pull request #2 from Klatuu82/master  
    Made some changes.  
- Fixed Fireblast in Std Rotation,  
    change to 2.8 closer to cap  
- Fixed Fireblast in Std Rotation,  
    if we are over 25sec cd Combust use it on every proc or if we are near to cap  
    lower 25 but higher 16 we want hold nearly 2 stacks  
    lower 16 we want hold nearly 3 stacks if comes a pro we can use it under 8 we wont  
- All changes are to prevent cap FB or use it if Combust is more than 25 sec on cd in RoP Phase  
    Line 312 not spellHistory[1] == FR.FireBlast must always true so its necessary to check  
    Line 314 we wont check for PhoenixFlames  
    Line 318 You ask telents[FR.Firestarter] in firestarterActive so the firs expression is necessary  
    Line 339 i put Heating up in front we need it to check more and if the buff is there we wont use it no need to check for target hp  
    Line 351 we check if Heating up is up so it cant be not up later  
- Its the RoP Phase, you are only here if RoP is up, it is necessary to check if RoP is up  
- invented Players Health  
    and use it on MirrorImage because it is now an def cd so we can use it on below 50% Health  
- Change the charges from FB and PF to 2.5 and 2.75 for Combustion  
    Change PF in RoP Phase and in Std Phase we wont cast it only to prevent cap  
- no need for that anymore  
- no need for that anymore  
- Show RuneOfPower:  
    no need to check if talents[FR.Firestarter] because you check it in firestarterActive  
    if Combustion is up you will cast Combustion and never befor Rune of Power if cd of cumbustions is under 60 but this you check in the previous one  
    Show Combustion:  
      you will use it with all stacks so PhoenixFlames has to be greater then 2 because we have 3 Stacks  

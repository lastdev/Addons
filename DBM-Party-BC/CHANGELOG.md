# <DBM> Dungeons (BC)

## [r24](https://github.com/DeadlyBossMods/DBM-Dungeons/tree/r24) (2021-03-09)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Dungeons/compare/r23...r24) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Dungeons/releases)

- TOC Bump  
- Update README.md  
- Fix #20 (#21)  
    ```  
    If Babblet reaches the targeted player, she will cast Severe Dusting (Damage), causing heavy damage and blinding the player for 4 seconds  
    Babblet will choose a new Severe Dusting (CD) target each time she casts Severe Dusting (Damage) on her target, or when the 12-second Severe Dusting (CD) channel expires  
    ```  
    Since Babblet reaches the target, it causes the CD to start again. Change the `:Start` call to an `:Update` call to shut up this error.  
- Localized mod names in Russian (#19)  
- Fix two reported timer issues  
- Fixed/Updated Istrivial checks to use cores built in checks instead of hard coded (and incorrect) pre squish levels  
- LuaCheck cleanup (#18)  
- Ci updates from master. Also remove FUNDING as its provided by global… (#17)  
- Update CI  
- Delete .travis.yml  
- Create ci.yml  
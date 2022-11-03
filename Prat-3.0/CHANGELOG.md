# Prat 3.0

## [3.9.4](https://github.com/Legacy-of-Sylvanaar/prat-3-0/tree/3.9.4) (2022-11-02)
[Full Changelog](https://github.com/Legacy-of-Sylvanaar/prat-3-0/compare/3.9.3...3.9.4) [Previous Releases](https://github.com/Legacy-of-Sylvanaar/prat-3-0/releases)

- Fix flashing of tabs.  
    Blizzard causes an additional flash later on under FCFDockOverflowButton\_UpdatePulseState which is triggered if you're not scrolled down fully. Let's just disable that as well while we're at it.  
    Fixes https://github.com/Legacy-of-Sylvanaar/prat-3-0/issues/47  
- Cleaner solution for setting chatframes alpha.  
- Forgot to make clamping respect the "Zero clamp size" option  
- [Fixes #39, Fixes #34] Return to 0 clamp size on main chat window  
- Update issue templates to separate classic and retail  
- [Fixes #38] Undo breakage (removing _G and CLR when Prat uses its own namespace) (#40)  
- More minor cleanup.  
- Minor cleanups.  
- Started basic work on luacheck  
- Minor cleanup  
- [Fixes #36] AltNames ColorPicker broken  
- Fix error from altering localisation string  
- Add initial .luacheckrc  
- Fix single \ in some localisation strings  
- Update build script and tocs (#32)  
- Fixes to remove some taint and errors from Prat for Dragonflight (#29)  
- Update UrlCopy.lua (#27)  
- Replace deprecated function (#30)  
- Replaced SetMinResize with SetResizeBounds. (#28)  
- Update ChatFrames.lua (#25)  
- Update Prat-3.0\_Libraries.toc  
- Update Prat-3.0.toc  
- Update CopyChat.lua  
- Update locales.lua  
- Update locales.lua  
- Update Prat-3.0\_Libraries.toc  
- Update Prat-3.0.toc  
- Update Scrollback.lua  
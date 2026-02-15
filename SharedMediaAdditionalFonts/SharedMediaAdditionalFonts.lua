--[[

----
---- PLEASE READ BEFORE DOING ANYTHING ----
----

Only fonts should be added to this addon. If you wish to add textures, sounds,
... create your own addon or use an existing one if there is one.
All fonts must be able to display special characters such as é, è, à, ü, É, Ç,
... Remember that not all the users use the English client!

Don't add a font that you did not test. All fonts must be tested in game before
upload.

Thanks for your cooperation! ;-)
AllInOneMighty

]]

-- registrations for media from the client itself belongs in LibSharedMedia-3.0

local LSM = LibStub("LibSharedMedia-3.0", true)
local koKR, ruRU, zhCN, zhTW, western = LSM.LOCALE_BIT_koKR, LSM.LOCALE_BIT_ruRU, LSM.LOCALE_BIT_zhCN, LSM.LOCALE_BIT_zhTW, LSM.LOCALE_BIT_western

LSM:Register("font", "Accidental Presidency", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Accidental Presidency.ttf]])
LSM:Register("font", "ACTION MAN", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\ActionMan.ttf]])
LSM:Register("font", "Alba Super", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\ALBAS___.ttf]])
LSM:Register("font", "Arm Wrestler", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\ArmWrestler.ttf]])
LSM:Register("font", "AvantGarde LT Book", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\AvantGarde_LT_Book_Regular.ttf]])
LSM:Register("font", "Baar Sophia", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\BAARS___.TTF]])
LSM:Register("font", "Blazed", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Blazed.ttf]])
LSM:Register("font", "Boris Black Bloxx", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\BorisBlackBloxx.ttf]])
LSM:Register("font", "Boris Black Bloxx Dirty", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\BorisBlackBloxxDirty.ttf]])
LSM:Register("font", "Celestia Redux", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\CelestiaMediumRedux1.55.ttf]])
LSM:Register("font", "Century Gothic", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\centurygothic.ttf]], western + ruRU)
LSM:Register("font", "Collegiate", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\COLLEGIA.ttf]])
LSM:Register("font", "Continuum Medium", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\ContinuumMedium.ttf]])
LSM:Register("font", "DejaVu Sans", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\DejaVuSans.ttf]], western + ruRU)
LSM:Register("font", "DejaVu Sans, Bold", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\DejaVuSans-Bold.ttf]], western + ruRU)
LSM:Register("font", "DieDieDie", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\DieDieDie.ttf]])
LSM:Register("font", "Diogenes", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\DIOGENES.ttf]])
LSM:Register("font", "Disko", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Disko.ttf]])
LSM:Register("font", "Expressway, Bold", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Expressway-Bold.ttf]], western + ruRU)
LSM:Register("font", "Frakturika Spamless", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\FRAKS___.ttf]])
LSM:Register("font", "Gotham Narrow Ultra", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\GothamNarrow-Ultra.ttf]])
LSM:Register("font", "Homespun TT BRK", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Homespun.ttf]], western + ruRU)
LSM:Register("font", "Impact", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\impact.ttf]], western + ruRU)
LSM:Register("font", "JetBrains Mono", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\JetBrainsMono-Regular.ttf]], western + ruRU)
LSM:Register("font", "Liberation Sans", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\LiberationSans-Regular.ttf]], western + ruRU)
LSM:Register("font", "Liberation Serif", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\LiberationSerif-Regular.ttf]], western + ruRU)
LSM:Register("font", "Mystic Orbs", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\MystikOrbs.ttf]])
LSM:Register("font", "NanumGothic", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\NanumGothic-Regular.ttf]])
LSM:Register("font", "Nunito", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Nunito-Regular.ttf]])
LSM:Register("font", "Pokemon Solid", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Pokemon Solid.ttf]])
LSM:Register("font", "Prototype", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Prototype.ttf]])
LSM:Register("font", "PT Sans Narrow, Bold", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\PTSansNarrow-Bold.ttf]], western + ruRU)
LSM:Register("font", "Rock Show Whiplash", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Rock Show Whiplash.ttf]])
LSM:Register("font", "SF Diego Sans", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\SF Diego Sans.ttf]])
LSM:Register("font", "Solange", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Solange.ttf]])
LSM:Register("font", "Star Cine", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\starcine.ttf]])
LSM:Register("font", "Trashco", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\trashco.ttf]])
LSM:Register("font", "Ubuntu Condensed", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Ubuntu-C.ttf]], western + ruRU)
-- Should be "Ubuntu, Light", but has historically bee named this way.
LSM:Register("font", "Ubuntu Light", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Ubuntu-L.ttf]], western + ruRU)
-- Should be "Waltograph UI, Bold", but has historically bee named this way.
LSM:Register("font", "Waltograph UI", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\waltographUI.ttf]])
LSM:Register("font", "Verdana", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\Verdana.ttf]], western + ruRU)
LSM:Register("font", "X360", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\X360.ttf]], western + ruRU)
LSM:Register("font", "Yanone Kaffeesatz Regular", [[Interface\Addons\SharedMediaAdditionalFonts\fonts\YanoneKaffeesatz-Regular.ttf]])

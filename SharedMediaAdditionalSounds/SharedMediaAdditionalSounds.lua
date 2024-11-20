--[[

----
---- PLEASE READ BEFORE DOING ANYTHING ----
----

Only sounds should be added to this addon. If you wish to add textures, fonts, ...
create your own addon or use an existing one if there is one.

Don't add a sound that you did not test. All sounds must be tested in game before upload.

Thanks for your cooperation! ;-)
pb_ee1

If you edit this file, be careful not to overwrite it when you update this addon.

]]

-- registrations for media from the client itself belongs in LibSharedMedia-3.0

if not SharedMediaAdditionalSounds then return end
local revision = tonumber(string.sub("$Revision: 63551 $", 12, -3))
SharedMediaAdditionalSounds.revision = (revision > SharedMediaAdditionalSounds.revision) and revision or SharedMediaAdditionalSounds.revision

-- -----
-- SOUND
-- -----
SharedMediaAdditionalSounds:Register("sound", "Bell Toll Alliance", 566564)
SharedMediaAdditionalSounds:Register("sound", "Bell Toll Horde", 565853)
SharedMediaAdditionalSounds:Register("sound", "Auction Window Close", 567499)
SharedMediaAdditionalSounds:Register("sound", "Quest Failed", 567459)
SharedMediaAdditionalSounds:Register("sound", "Fel Nova", 568582)
SharedMediaAdditionalSounds:Register("sound", "Bad Press", 568975)
SharedMediaAdditionalSounds:Register("sound", "Simon Large Blue", 566076)
SharedMediaAdditionalSounds:Register("sound", "Simon Small Blue", 567002)
SharedMediaAdditionalSounds:Register("sound", "Portcullis Close", 566240)
SharedMediaAdditionalSounds:Register("sound", "Run Away", 552035)
SharedMediaAdditionalSounds:Register("sound", "PvP Flag Taken", 569200)
SharedMediaAdditionalSounds:Register("sound", "Arcane Crystal", 565425)
SharedMediaAdditionalSounds:Register("sound", "Bellow Out", 565530)
SharedMediaAdditionalSounds:Register("sound", "Cannon", 566101)
SharedMediaAdditionalSounds:Register("sound", "Firework 3", 566862)
SharedMediaAdditionalSounds:Register("sound", "Alarm Clock Warning 2", 567399)


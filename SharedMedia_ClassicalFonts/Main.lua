local LSM = LibStub("LibSharedMedia-3.0")
local MediaType_FONT = LSM.MediaType.FONT or "font"

-- Define font list
local fonts = {
    ["Augustus"]                = "AUGUSTUS.ttf",
    ["Augustus Beveled"]        = "Augustus Beveled.ttf",
    ["Caesar"]                  = "CAESAR.ttf",
    ["Diogenes"]                = "DIOGENES.ttf",
    ["Capitalis Type Oasis"]    = "CapitalisTypOasis.ttf",
    ["Ancient Geek"]            = "geek.ttf",
    ["Marathon"]                = "mara2v2.ttf",
    ["Roman SD"]                = "Roman SD.ttf",
    ["Triatlhon In"]            = "Triatlhon In.ttf",
    ["ROMANUM EST ALL CAPS"]    = "Romanum Est.ttf",
    ["King Arthur Legend"]      = "King Arthur Legend.ttf",
    ["Olde English"]            = "OldeEnglish.ttf",
    ["Germanica"]               = "Plain Germanica.ttf",
    ["Germanica Shadowed"]      = "Shadowed Germanica.ttf",
    ["Germanica Embossed"]      = "Embossed Germanica.ttf",
    ["Germanica Fluted"]        = "Fluted Germanica.ttf",
    ["Cleopatra"]               = "Cleopatra.ttf",
}

-- Register fonts
local basePath = "Interface\\AddOns\\SharedMedia_ClassicalFonts\\Fonts\\"
for name, file in pairs(fonts) do
    LSM:Register(MediaType_FONT, name, basePath .. file)
end
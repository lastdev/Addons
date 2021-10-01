local __exports = LibStub:NewLibrary("ovale/ui/Localization", 90108)
if not __exports then return end
local __imports = {}
__imports.__localizationdeDE = LibStub:GetLibrary("ovale/ui/localization/de-DE")
__imports.setDEDE = __imports.__localizationdeDE.setDEDE
__imports.__localizationenUS = LibStub:GetLibrary("ovale/ui/localization/en-US")
__imports.getENUS = __imports.__localizationenUS.getENUS
__imports.__localizationesES = LibStub:GetLibrary("ovale/ui/localization/es-ES")
__imports.setESES = __imports.__localizationesES.setESES
__imports.__localizationesMX = LibStub:GetLibrary("ovale/ui/localization/es-MX")
__imports.setESMX = __imports.__localizationesMX.setESMX
__imports.__localizationfrFR = LibStub:GetLibrary("ovale/ui/localization/fr-FR")
__imports.setFRFR = __imports.__localizationfrFR.setFRFR
__imports.__localizationitIT = LibStub:GetLibrary("ovale/ui/localization/it-IT")
__imports.setITIT = __imports.__localizationitIT.setITIT
__imports.__localizationkoKR = LibStub:GetLibrary("ovale/ui/localization/ko-KR")
__imports.setKOKR = __imports.__localizationkoKR.setKOKR
__imports.__localizationptBR = LibStub:GetLibrary("ovale/ui/localization/pt-BR")
__imports.setPTBR = __imports.__localizationptBR.setPTBR
__imports.__localizationruRU = LibStub:GetLibrary("ovale/ui/localization/ru-RU")
__imports.setRURU = __imports.__localizationruRU.setRURU
__imports.__localizationzhCN = LibStub:GetLibrary("ovale/ui/localization/zh-CN")
__imports.setZHCN = __imports.__localizationzhCN.setZHCN
__imports.__localizationzhTW = LibStub:GetLibrary("ovale/ui/localization/zh-TW")
__imports.setZHTW = __imports.__localizationzhTW.setZHTW
local GetLocale = GetLocale
local setDEDE = __imports.setDEDE
local getENUS = __imports.getENUS
local setESES = __imports.setESES
local setESMX = __imports.setESMX
local setFRFR = __imports.setFRFR
local setITIT = __imports.setITIT
local setKOKR = __imports.setKOKR
local setPTBR = __imports.setPTBR
local setRURU = __imports.setRURU
local setZHCN = __imports.setZHCN
local setZHTW = __imports.setZHTW
__exports.l = getENUS()
local locale = GetLocale()
if locale == "deDE" then
    setDEDE(__exports.l)
elseif locale == "esES" then
    setESES(__exports.l)
elseif locale == "esMX" then
    setESMX(__exports.l)
elseif locale == "frFR" then
    setFRFR(__exports.l)
elseif locale == "itIT" then
    setITIT(__exports.l)
elseif locale == "koKR" then
    setKOKR(__exports.l)
elseif locale == "ptBR" then
    setPTBR(__exports.l)
elseif locale == "ruRU" then
    setRURU(__exports.l)
elseif locale == "zhCN" then
    setZHCN(__exports.l)
elseif locale == "zhTW" then
    setZHTW(__exports.l)
end

local __exports = LibStub:NewLibrary("ovale/ui/Localization", 90047)
if not __exports then return end
local GetLocale = GetLocale
local __localizationdeDE = LibStub:GetLibrary("ovale/ui/localization/de-DE")
local setDEDE = __localizationdeDE.setDEDE
local __localizationenUS = LibStub:GetLibrary("ovale/ui/localization/en-US")
local getENUS = __localizationenUS.getENUS
local __localizationesES = LibStub:GetLibrary("ovale/ui/localization/es-ES")
local setESES = __localizationesES.setESES
local __localizationesMX = LibStub:GetLibrary("ovale/ui/localization/es-MX")
local setESMX = __localizationesMX.setESMX
local __localizationfrFR = LibStub:GetLibrary("ovale/ui/localization/fr-FR")
local setFRFR = __localizationfrFR.setFRFR
local __localizationitIT = LibStub:GetLibrary("ovale/ui/localization/it-IT")
local setITIT = __localizationitIT.setITIT
local __localizationkoKR = LibStub:GetLibrary("ovale/ui/localization/ko-KR")
local setKOKR = __localizationkoKR.setKOKR
local __localizationptBR = LibStub:GetLibrary("ovale/ui/localization/pt-BR")
local setPTBR = __localizationptBR.setPTBR
local __localizationruRU = LibStub:GetLibrary("ovale/ui/localization/ru-RU")
local setRURU = __localizationruRU.setRURU
local __localizationzhCN = LibStub:GetLibrary("ovale/ui/localization/zh-CN")
local setZHCN = __localizationzhCN.setZHCN
local __localizationzhTW = LibStub:GetLibrary("ovale/ui/localization/zh-TW")
local setZHTW = __localizationzhTW.setZHTW
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

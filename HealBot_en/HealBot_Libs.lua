local libLSM = LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
local libLDB11 = LibStub and LibStub("LibDataBroker-1.1", true)
local libLDBIcon = LibStub and LibStub("LibDBIcon-1.0", true)
local libCHC = nil
local libCD = nil
local libCC = nil

function HealBot_Libs_LSM()
    return libLSM
end

function HealBot_Libs_LDB11()
    return libLDB11
end

function HealBot_Libs_LDBIcon()
    return libLDBIcon
end

function HealBot_Libs_CHC()
    return libCHC
end

function HealBot_Libs_CD()
    return libCD
end

function HealBot_Libs_CC()
    return libCC
end

if HealBot_Version_Target() and HEALBOT_GAME_VERSION<4 then
    libCD = libCD or (LibStub and LibStub("LibClassicDurations"))
    libCHC = libCHC or (LibStub and LibStub("LibHealComm-4.0", true))
    libCC = libCC or (LibStub and LibStub("LibClassicCasterino", true))
end
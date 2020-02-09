local libLSM = LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
local libLDB11 = LibStub and LibStub("LibDataBroker-1.1", true)
local libLDBIcon = LibStub and LibStub("LibDBIcon-1.0", true)
local libCHC = nil
local libCTM = nil
local libCD = nil

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

function HealBot_Libs_CTM()
    return libCTM
end

function HealBot_Libs_CD()
    return libCD
end

if HealBot_Version_Target() and HEALBOT_GAME_VERSION<4 then
    libCD = libCD or (LibStub and LibStub("LibClassicDurations"))
    libCTM = libCTM or (LibStub and LibStub("LibThreatClassic2"))
    libCHC = libCHC or (LibStub and LibStub("LibHealComm-4.0", true))
end
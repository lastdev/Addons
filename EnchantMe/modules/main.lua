local _, addon = ...
local main, private = addon.module('main')
local playerHandler
local inspectHandler

main.MIN_UNIT_LEVEL = 61
main.MAX_UNIT_LEVEL = 70

function main.init()
    playerHandler = addon.new(addon.PlayerHandlerMixin)
    inspectHandler = addon.new(addon.InspectHandlerMixin)
end

function main.updateHandlers()
    playerHandler:UpdateIndicators()
    playerHandler:UpdateFlags()

    inspectHandler:UpdateIndicators()
    inspectHandler:UpdateFlags()
end

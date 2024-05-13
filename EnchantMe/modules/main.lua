local _, addon = ...
local main, private = addon.module('main')
local playerHandler
local inspectHandler

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

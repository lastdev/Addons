local _, addon = ...
local plugin = addon.namespace('plugin')
local listenerMap = {}
local playerLoggedIn = false
local pendingEvents = {}

function plugin.on(eventName, callback)
    if not listenerMap[eventName] then
        listenerMap[eventName] = {}
    end

    table.insert(listenerMap[eventName], callback)
end

function plugin.off(eventName, callback)
    if listenerMap[eventName] then
        for i, listener in ipairs(listenerMap[eventName]) do
            if callback == listener then
                table.remove(listenerMap[eventName], i)

                if #listenerMap[eventName] == 0 then
                    listenerMap[eventName] = nil
                end

                return true
            end
        end
    end

    return false
end

function plugin.dispatch(eventName, ...)
    if not playerLoggedIn then
        -- delay plugin events until after PLAYER_LOGIN
        table.insert(pendingEvents, {
            eventName = eventName,
            args = {...},
            argCount = select('#', ...),
        })

        return
    end

    if not listenerMap[eventName] then
        return
    end

    local toClear

    for index, listener in ipairs(listenerMap[eventName]) do
        if listener(...) == false then
            if not toClear then
                toClear = {}
            end

            table.insert(toClear, index)
        end
    end

    if toClear then
        for i = #toClear, 1, -1 do
            table.remove(listenerMap[eventName], toClear[i])
        end

        if #listenerMap[eventName] == 0 then
            listenerMap[eventName] = nil
        end
    end
end

addon.on('PLAYER_LOGIN', function ()
    playerLoggedIn = true

    -- at this point all listeners from enabled addons should be registered
    for _, pendingEvent in ipairs(pendingEvents) do
        plugin.dispatch(pendingEvent.eventName, unpack(pendingEvent.args, 1, pendingEvent.argCount))
    end

    pendingEvents = nil

    return false
end)

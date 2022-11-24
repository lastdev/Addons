--[[===========================================================================
    | thread.lua
    |
    | Sets up coroutine handling and management, simulating thread-like
    | funcionality. This allows you to queue up work and then do it later in
    | the background without causing a perf hit to your client. This can avoid
    | UI hangs and throttling by blizzard, which can disconnect the player.
    | This will wrap the function and execute it as a thread.
    |
    | Methods:
    |   AddThread
    |   GetThread
    |   RemoveThread
    |   AddThreadCompletionCallback
    |
    =======================================================================--]]
local AddonName, Addon = ...
local debugp = function (...) Addon:Debug("threads", ...) end

local threads = {} 

-- This allows adding a callback function whenever a thread of the specified name is completed.
local threadCallbacks = {}
function Addon:AddThreadCompletionCallback(name, func)

    if not threadCallbacks[name] then
        threadCallbacks[name] = {}
    end
    table.insert(threadCallbacks[name], func)
end

-- Accessor for adding a thread to the processor. Duplicate names are allowed.
function Addon:AddThread(func, name, throttle)


    if not throttle then throttle = Addon.c_ThrottleTime end


    if Addon:GetThread(name) then

        return
    end

    local obj = {}
    obj.thread = coroutine.create(func)
    obj.name = name

    local function doWorkOnThread()

        -- check if thread is dead
        -- if yes, clean it up
        if coroutine.status(obj.thread) == "dead" then

            Addon:RemoveThread(name)

            -- execute all callbacks for this thread
            if threadCallbacks[obj.name] then
                for _, cb in pairs(threadCallbacks[name]) do

                    cb()
                end
            end
        else
            -- if not, resume it
            --debugp("Resuming thread %s", obj.name)
            coroutine.resume(obj.thread)
            return
        end

        -- Jobs done!
        -- Stop the timer
        if obj.timer and obj.timer.Cancel and type(obj.timer.Cancel) == "function" then

            obj.timer:Cancel()
        end
    end

    obj.timer = C_Timer.NewTicker(throttle or 0.1, doWorkOnThread)
    table.insert(threads, obj)

end

-- Accessor for getting a thread from the processor
-- Returns the first match if there are duplicates.
function Addon:GetThread(name)
    -- search thread list
    for _, r in pairs(threads) do
        if r.name == name then
            return r
        end
    end
    -- not found
    return nil
end



-- Accessor for removing a thread from the processor.
-- Will remove all that match the name.
-- When a coroutine has no references it is killed after its last yield.
-- LUA is not really multi-threaded so we don't need to worry about synchronization.
function Addon:RemoveThread(name)
    thread = Addon:GetThread(name)

    -- Stop the ticker for this thread.
    if thread.timer and thread.timer.Cancel and type(thread.timer.Cancel) == "function" then

        thread.timer:Cancel()
    end

    -- Clear callbacks for this thread
    threadCallbacks[name] = {}

    -- Remove table entry for this thread
    for k, v in pairs(threads) do
        if v.name == name then
            table.remove(threads, k)
        end
    end


end


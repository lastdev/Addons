do
    local addonName, addon = ...
    local libs = { "Events", "BulletinBoard", "Copyright", "Holidays", "Tooltips", "SavedVariables", "Charms", "Data", "Arrows", "Colors", "UUID", "Locales", "Books" }
    local libIndexes = {}
    local TomCatsLibs = {}
    for i = 1, #libs do libIndexes[libs[i]] = i libs[i] = {} end
    addon.name = addonName
    addon.params = {}
    local function index(_, libname) return libs[libIndexes[libname]] end
    local function newindex() end
    setmetatable(TomCatsLibs, { __index = index, __newindex = newindex })
    local function getTomCatsLibs(_, key)
        if (key == "TomCatsLibs") then
            local stack = debugstack(2, 1, 2)
            if (not string.find(stack, "TomCatsLibs")) then
                setmetatable(addon, {})
                addon.TomCatsLibs = TomCatsLibs
                for i = 1, #libs do
                    local lib = libs[i]
                    if (lib.init) then lib.init() lib.init = nil end
                end
            end
            return TomCatsLibs
        else
            return rawget(addon, key)
        end
    end
    setmetatable(addon, { __index = getTomCatsLibs })
end
do
    local addon = select(2,...)
    rawset(addon.TomCatsLibs,"Events", { })
    local eventFrame = CreateFrame("Frame")
    local onUpdate, eventHandler
    local eventListeners = { }
    local function validateRegisterUnregisterInput(event, listener)
        if ((not event) or (type(event) ~= "string")) then error("Event must be specified", 3) end
        if ((not listener) or (type(listener) ~= "table" and type(listener) ~= "function")) then error("Listener must be specified", 3) end
    end
    function addon.TomCatsLibs.Events.RegisterEvent(event, listener)
        validateRegisterUnregisterInput(event, listener)
        eventListeners[event] = eventListeners[event] or {}
        for i = 1, #eventListeners[event] do
            if (eventListeners[event][i] == listener) then error(tostring(listener) .. " already associated with " .. event, 2) end
        end
        table.insert(eventListeners[event], listener)
        if (#eventListeners[event] == 1) then
            if (event == "ON_UPDATE") then
                eventFrame:SetScript("OnUpdate", onUpdate)
            else
                eventFrame:RegisterEvent(event)
            end
        end
    end
    function addon.TomCatsLibs.Events.UnregisterEvent(event, listener)
        validateRegisterUnregisterInput(event, listener)
        if (eventListeners[event]) then
            for i = 1, #eventListeners[event] do
                if (eventListeners[event][i] == listener) then
                    table.remove(eventListeners[event],i)
                    if (#eventListeners[event] == 0) then
                        if (event == "ON_UPDATE") then
                            eventFrame:SetScript("OnUpdate", nil)
                        else
                            eventFrame:UnregisterEvent(event);
                        end
                    end
                    break;
                end
            end
        end
    end
    function onUpdate()
        eventHandler(nil, "ON_UPDATE")
    end
    function eventHandler(_, event, ...)
        local eventListenersQueue = Mixin({}, eventListeners[event])
        if (eventListenersQueue) then
            for i = 1, #eventListenersQueue do
                if (type(eventListenersQueue[i]) == "table") then
                    if (eventListenersQueue[i][event] and (type(eventListenersQueue[i][event]) == "function")) then
                        eventListenersQueue[i][event](eventListenersQueue[i], event, ...)
                    else
                        error("cannot find a function named " .. event .. " in table " .. tostring(eventListenersQueue[i]))
                    end
                elseif (type(eventListenersQueue[i]) == "function") then
                    eventListenersQueue[i](eventListenersQueue[i], event, ...)
                else
                    error("cannot relay the event for " .. event)
                end
            end
        end
    end
    eventFrame:SetScript("OnEvent", eventHandler)
end
do
    local addon = select(2,...)
    local TCL = addon.TomCatsLibs
    local function ADDON_LOADED(_, event, ...)
        local var1 = select(1, ...)
        if (var1 == addon.name) then
            local varPrefix = string.gsub(addon.name, "-", "_")
            local characterSavedVarsName = varPrefix .. "_Character"
            local accountSavedVarsName = varPrefix .. "_Account"
            _G[characterSavedVarsName] = _G[characterSavedVarsName] or {}
            _G[accountSavedVarsName] = _G[accountSavedVarsName] or {}
            addon.savedVariables = {
                character = _G[characterSavedVarsName],
                account = _G[accountSavedVarsName]
            }
            addon.savedVariables.character.preferences = addon.savedVariables.character.preferences or {}
            TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        end
    end
    TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
end
do
    local addon = select(2,...)
    local TCL = addon.TomCatsLibs
    local seqNum = 1
    local handleSlideBar, handleSexyMap
    function TCL.Charms.Create(buttonInfo)
        TOMCATS_LIBS_ICON_LASTFRAMELEVEL = (TOMCATS_LIBS_ICON_LASTFRAMELEVEL or 7) + 3
        if (MinimapZoneTextButton and MinimapZoneTextButton:GetParent() == MinimapCluster) then
            MinimapZoneTextButton:SetParent(Minimap)
        end
        local name = buttonInfo.name
        if (not name) then
            name = addon.name .. "MinimapButton" .. seqNum
            seqNum = seqNum + 1
        end
        local frame = CreateFrame("Button", name, Minimap, "TomCatsMinimapButtonTemplate")
        frame:SetFrameLevel(TOMCATS_LIBS_ICON_LASTFRAMELEVEL)
        if (buttonInfo.backgroundColor) then
            local background = _G[name .. "Background"]
            background:SetDrawLayer("BACKGROUND", 1)
            background:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMaskSmall")
            background:SetWidth(25)
            background:SetHeight(25)
            background:SetVertexColor(unpack(buttonInfo.backgroundColor))
            frame.backgroundColor = buttonInfo.backgroundColor
        end
        frame.title = buttonInfo.title or name
        if (buttonInfo.iconTexture) then
            _G[name .. "Icon"]:SetTexture(buttonInfo.iconTexture)
        end
        if (buttonInfo.name) then
            local scope = addon.savedVariables[TCL.Charms.scope or "character"].preferences
            if (scope[name]) then
                frame:SetPreferences(scope[name])
            else
                scope[name] = frame:GetPreferences()
            end
        end
        if (buttonInfo.handler_onclick) then
            frame:SetHandler("OnClick",buttonInfo.handler_onclick)
        end
        if not buttonInfo.ignoreSlideBar then
            handleSlideBar(frame)
        end
        if not buttonInfo.ignoreSexyMap then
            handleSexyMap(frame)
        end
        return frame
    end
    -- Begin SexyMap Compatibility --
    local sexyMapPresent = select(4, GetAddOnInfo("SexyMap"))
    local sexyMapQueue = {}
    function handleSexyMap(button, event)
        if (not sexyMapPresent) then return end
        if (IsAddOnLoaded("SexyMap")) then
            if (event) then
                TCL.Events.UnregisterEvent("ADDON_LOADED", handleSexyMap)
            else
                table.insert(sexyMapQueue, button)
            end
            for _, btn in ipairs(sexyMapQueue) do
                local ldbiMock = CreateFromMixins(btn)
                setmetatable(ldbiMock, getmetatable(btn))
                function ldbiMock:GetName() return "LibDBIcon10_" .. btn.title end
                function ldbiMock:SetScript() end
                function ldbiMock:SetPoint() end
                function ldbiMock:SetAllPoints() end
                function ldbiMock:ClearAllPoints() end
                _G[ldbiMock:GetName()] = ldbiMock
                table.insert(LibStub["libs"]["LibDBIcon-1.0"].objects, ldbiMock)
                LibStub["libs"]["LibDBIcon-1.0"].callbacks:Fire("LibDBIcon_IconCreated", ldbiMock, btn.title)
            end
        end
        if (not event) then
            table.insert(sexyMapQueue, button)
            return
        end
    end
    if (sexyMapPresent and (not IsAddOnLoaded("SexyMap"))) then
        TCL.Events.RegisterEvent("ADDON_LOADED", handleSexyMap)
    end
    -- End SexyMap Compatibility --
    -- Begin SlideBar Compatibility --
    local slideBarPresent = select(4, GetAddOnInfo("SlideBar"))
    local slideBarQueue = {}
    function handleSlideBar(button, event)
        if (not slideBarPresent) then return end
        if (LibStub and LibStub.libs and LibStub.libs.SlideBar) then
            if (event) then
                TCL.Events.UnregisterEvent("ADDON_LOADED", handleSlideBar)
            else
                table.insert(slideBarQueue, button)
            end
            for _, btn in ipairs(slideBarQueue) do
                local n = btn:GetName()
                local newButton = LibStub.libs.SlideBar.AddButton(
                    btn.title, _G[n .. "Icon"]:GetTexture(), nil, n .. "SlideBar", true, { OnClick = _G[btn:GetName()]:GetScript("OnClick") }
                )
                local oldOnEnter = newButton:GetScript("OnEnter")
                newButton:SetScript("OnEnter", function(this)
                    if (oldOnEnter) then oldOnEnter(this) end
                    if (btn.tooltip) then btn.tooltip.Show(this) end
                end)
                local oldOnLeave = newButton:GetScript("OnLeave")
                newButton:SetScript("OnLeave", function(this)
                    if (oldOnLeave) then oldOnLeave(this) end
                    if (btn.tooltip) then btn.tooltip.Hide(this) end
                end)
                -- todo: force background color to work in the interface config panel
                if (btn.backgroundColor) then
                    newButton.icon:SetDrawLayer("ARTWORK",1)
                    local bg = _G[btn:GetName() .. "SlideBar"]:CreateTexture("", "BACKGROUND")
                    bg:SetDrawLayer("BACKGROUND", 1)
                    bg:SetTexture("Interface\\AddOns\\"  .. addon.name .. "\\libs\\TomCatsLibs\\images\\00019")
                    bg:SetPoint("TOPLEFT", newButton, "TOPLEFT", 0,0)
                    bg:SetWidth(30)
                    bg:SetHeight(30)
                    bg:SetVertexColor(unpack(btn.backgroundColor))
                end
            end
            slideBarQueue = {}
            return
        end
        if (not event) then
            table.insert(slideBarQueue, button)
        end
    end
    if (slideBarPresent and (not (LibStub and LibStub.libs and LibStub.libs.SlideBar))) then
        TCL.Events.RegisterEvent("ADDON_LOADED", handleSlideBar)
    end
    -- End SlideBar Compatibility --
end
do
    local addon = select(2, ...)
    local lib = addon.TomCatsLibs.Locales
    local isTranslatedLookup = { }
    local isDefaultLanguage = true
    setmetatable(lib, {
        __index = function(_, key)
            return key
        end
    })
    function lib.AddLocaleLookup(locale, lookup)
        if (locale == "enUS") then
            Mixin(lib, lookup)
        elseif (GetLocale() == locale) then
            isDefaultLanguage = false
            for key in pairs(lookup) do
                isTranslatedLookup[key] = true
            end
            Mixin(lib, lookup)
        end
    end
    function lib.IsTranslationNeeded(key)
        if isDefaultLanguage then return false end
        return not (isTranslatedLookup[key] or false)
    end
    lib.init = false
end
do
    local addon = select(2,...)
    local lib = addon.TomCatsLibs.Data
    local recordMetatable = {
        __index = function(table, key)
            return table.record[table.parent.columnNames[key]]
        end,
        __newindex = function(table, key, value)
            if (not table.parent.columnNames[key]) then
                table.parent.columnCount = table.parent.columnCount + 1
                table.parent.columnNames[key] = table.parent.columnCount
            end
            if (table.record[table.parent.columnNames[key]] ~= value) then
                rawset(table.record, table.parent.columnNames[key], value)
                if (table.parent.afterUpdateCallbacks and table.parent.afterUpdateCallbacks[key]) then
                    table.parent.afterUpdateCallbacks[key](table)
                end
            end
        end
    }
    local tableMixin = {
        SetAfterUpdate = function(self, columnName, callback)
            if (not self.afterUpdateCallbacks) then
                rawset(self, "afterUpdateCallbacks",  {})
            end
            self.afterUpdateCallbacks[columnName] = callback
        end
    }
    local tableMetatable = {
        __index = function(self, key)
            return self.records[key]
        end
    }
    function lib.loadData(name, columnNames, records)
        local table = CreateFromMixins(tableMixin)
        table.columnNames = {}
        table.columnCount = #columnNames
        for i = 1, #columnNames, 1 do
            table.columnNames[columnNames[i]] = i
        end
        table.records = {}
        for i = 1, #records, 1 do
            local record = { }
            record.parent = table
            record.record = records[i]
            setmetatable(record, recordMetatable)
            table.records[records[i][1]] = record
        end
        setmetatable(table, tableMetatable)
        lib[name] = table
    end
    function lib.flatten(record)
        local result = {}
        for k, v in pairs(record.parent.columnNames) do
            result[v] = record[k]
        end
        return unpack(result)
    end
end
local Bit32S = { }
do
    local function s32(number)
        if number > 2147483647 then return number - 4294967296 end
        if number < -2147483648 then return number + 4294967296 end
        return number
    end
    function Bit32S.bor(val1, val2)
        return s32(bit.bor(val1, val2))
    end
    function Bit32S.rshift(val, bits)
        return s32(bit.rshift(val,bits))
    end
    function Bit32S.arshift(val, bits)
        return s32(bit.arshift(val,bits))
    end
    function Bit32S.lshift(val, bits)
        return s32(bit.lshift(val,bits))
    end
    function Bit32S.band(val1, val2)
        return s32(bit.band(val1,val2))
    end
    function Bit32S.bnot(val1)
        return s32(bit.bnot(val1))
    end
    function Bit32S.bxor(val1, val2)
        return s32(bit.bxor(val1, val2))
    end
    function Bit32S.s32(val)
        return s32(val)
    end
end
local Sha256 = { }
do
    local function zeroFill(amt)
        local r = {}
        for i = 1, amt do r[i] = 0 end
        return unpack(r)
    end
    local padding = { -128, zeroFill(135) }
    local ROUND_CONSTS = {
        1116352408, 1899447441, -1245643825, -373957723, 961987163, 1508970993, -1841331548, -1424204075,
        -670586216, 310598401, 607225278, 1426881987, 1925078388, -2132889090, -1680079193, -1046744716,
        -459576895, -272742522, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986,
        -1740746414, -1473132947, -1341970488, -1084653625, -958395405, -710438585, 113926993, 338241895,
        666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, -2117940946, -1838011259,
        -1564481375, -1474664885, -1035236496, -949202525, -778901479, -694614492, -200395387, 275423344,
        430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779,
        1955562222, 2024104815, -2067236844, -1933114872, -1866530822, -1538233109, -1090935817, -965641998,
    }
    local INITIAL_STATE = {
        coeff1 = 1779033703,
        coeff2 = -1150833019,
        coeff3 = 1013904242,
        coeff4 = -1521486534,
        coeff5 = 1359893119,
        coeff6 = -1694144372,
        coeff7 = 528734635,
        coeff8 = 1541459225,
        bufOfs = 0,
        bytesProcessed = 0
    }
    local function s8(number)
        if number > 128 then
            return number - 256
        end
        return number
    end
    local function toHex(number)
        local hex = string.format("%08X", number)
        return string.sub(hex, 8 - #hex)
    end
    local function copy(src, srcPos, dest, destPos, len)
        for i = 0, len - 1 do
            dest[destPos + i] = src[srcPos + i]
        end
    end
    local executions = 0;
    local function getIntFromByteArray(buffer, offset)
        return Bit32S.bor(Bit32S.bor(Bit32S.bor(
                Bit32S.lshift(Bit32S.band(buffer[offset], 255), 24),
                Bit32S.lshift(Bit32S.band(buffer[offset + 1], 255),16)),
                Bit32S.lshift(Bit32S.band(buffer[offset + 2], 255),8 )),
                (Bit32S.band(buffer[offset + 3],255)))
    end
    local function i2b4(src, dst, offset)
        dst[offset] = s8(Bit32S.band(Bit32S.arshift(src,24),255))
        dst[offset + 1] = s8(Bit32S.band(Bit32S.arshift(src,16), 255))
        dst[offset + 2] = s8(Bit32S.band(Bit32S.arshift(src,8), 255))
        dst[offset + 3] = s8(Bit32S.band(src, 255))
    end
    local function compress(buffer, offset, state)
        executions = executions + 1;
        local tmp = { }
        for idx = 1, 16 do
            tmp[idx] = getIntFromByteArray(buffer, offset)
            offset = offset + 4
        end
        for idx = 17, 64 do
            tmp[idx] = Bit32S.s32(Bit32S.s32((Bit32S.bxor(Bit32S.bxor(Bit32S.bor(Bit32S.rshift(tmp[idx-2],17), Bit32S.lshift(tmp[idx-2],15)), Bit32S.bor(Bit32S.rshift(tmp[idx-2],19), Bit32S.lshift(tmp[idx-2],13))),Bit32S.rshift(tmp[idx-2],10)))+tmp[idx-7])+Bit32S.s32((Bit32S.bxor(Bit32S.bxor(Bit32S.bor(Bit32S.rshift(tmp[idx-15],7), Bit32S.lshift(tmp[idx-15],25)),Bit32S.bor(Bit32S.rshift(tmp[idx-15],18), Bit32S.lshift(tmp[idx-15],14))),Bit32S.rshift(tmp[idx-15],3)))+tmp[idx-16]))
        end
        local coeff1 = state.coeff1
        local coeff2 = state.coeff2
        local coeff3 = state.coeff3
        local coeff4 = state.coeff4
        local coeff5 = state.coeff5
        local coeff6 = state.coeff6
        local coeff7 = state.coeff7
        local coeff8 = state.coeff8
        for idx = 1, 64 do
            local sum1 = Bit32S.s32(Bit32S.s32(coeff8+(Bit32S.bxor(Bit32S.bxor((Bit32S.bor(Bit32S.rshift(coeff5,6),Bit32S.lshift(coeff5,26))),Bit32S.bor(Bit32S.rshift(coeff5,11),Bit32S.lshift(coeff5,21))),Bit32S.bor(Bit32S.rshift(coeff5,25),Bit32S.lshift(coeff5,7)))))+Bit32S.s32(Bit32S.bxor(Bit32S.band(coeff5,coeff6),Bit32S.band(Bit32S.bnot(coeff5),coeff7))+ROUND_CONSTS[idx])+tmp[idx])
            local sum2 = Bit32S.s32((Bit32S.bxor(Bit32S.bxor(Bit32S.bor(Bit32S.rshift(coeff1,2),Bit32S.lshift(coeff1,30)),Bit32S.bor(Bit32S.rshift(coeff1,13),Bit32S.lshift(coeff1,19))),Bit32S.bor(Bit32S.rshift(coeff1,22),Bit32S.lshift(coeff1,10))))+(Bit32S.bxor(Bit32S.bxor(Bit32S.band(coeff1,coeff2),Bit32S.band(coeff1,coeff3)),Bit32S.band(coeff2,coeff3))))
            coeff8 = coeff7
            coeff7 = coeff6
            coeff6 = coeff5
            coeff5 = Bit32S.s32(coeff4 + sum1)
            coeff4 = coeff3
            coeff3 = coeff2
            coeff2 = coeff1
            coeff1 = Bit32S.s32(sum1 + sum2)
        end
        state.coeff1 = Bit32S.s32(state.coeff1 + coeff1)
        state.coeff2 = Bit32S.s32(state.coeff2 + coeff2)
        state.coeff3 = Bit32S.s32(state.coeff3 + coeff3)
        state.coeff4 = Bit32S.s32(state.coeff4 + coeff4)
        state.coeff5 = Bit32S.s32(state.coeff5 + coeff5)
        state.coeff6 = Bit32S.s32(state.coeff6 + coeff6)
        state.coeff7 = Bit32S.s32(state.coeff7 + coeff7)
        state.coeff8 = Bit32S.s32(state.coeff8 + coeff8)
    end
    local function process(data, len, state)
        local dataPos = 1
        if state.bufOfs ~= 0 then
            local size = math.min(len, 64 - state.bufOfs)
            copy(data, dataPos, state.buffer, state.bufOfs + 1, size)
            state.bufOfs = state.bufOfs + size
            dataPos = dataPos + size
            len = len - size
            if state.bufOfs >= 64 then
                compress(state.buffer, 1, state)
            end
        end
        if len >= 64 then
            local total = dataPos + len
            while dataPos <= total - 64 do
                compress(data, dataPos, state)
                dataPos = dataPos + 64
            end
            len = total - dataPos
        end
        if len > 0 then
            copy(data, dataPos, state.buffer, 1, len)
            state.bufOfs = len
        end
    end
    function Sha256.encode(message)
        local state = CreateFromMixins(INITIAL_STATE)
        state.buffer = { zeroFill(64) }
        local messageBytes = { }
        for idx = 1, #message, 1000 do
            local tmp = { string.byte(message,idx,idx + 1000) }
            for i = 1, #tmp do
                messageBytes[idx + i - 1] = tmp[i]
            end
        end
        process(messageBytes, #messageBytes, state)
        state.bytesProcessed = state.bytesProcessed + #messageBytes
        local var1 = Bit32S.lshift(state.bytesProcessed,3)
        local var2 = Bit32S.band(state.bytesProcessed, 63)
        local var3 = (var2 < 56) and (56 - var2) or (120 - var2)
        process(padding, var3, state)
        i2b4(0, state.buffer, 57)
        i2b4(var1, state.buffer, 61)
        compress(state.buffer, 1, state)
        local var0 = { state.coeff1, state.coeff2, state.coeff3, state.coeff4, state.coeff5, state.coeff6, state.coeff7, state.coeff8 }
        return toHex(var0[1])..toHex(var0[2])..toHex(var0[3])..toHex(var0[4])..toHex(var0[5])
    end
end
local ArrayMath = { }
do
    local pool = { };
    local bnExpModThreshTable = { 25, 81, 241, 673, 1793, 2147483647 };
    bnExpModThreshTable[0] = 7;
    local yield, compare, getLowestSetBit, getLeadingZeroCount, normalize, rightShift, leftShift, mulsub,
    primitiveRightShift, primitiveLeftShift, getInt, setInt, add, subtract, copyAndShift,
    numberOfLeadingZeros, mod, divadd, unsignedIntCompare, divWord, multiply, multiplyToLen,
    bitLengthForInt, modPow, montgomeryMultiply, montgomerySquare, montReduce,
    intArrayCmpToLen, subN, mulAddOne, addToArray, implMulAdd, addOne, modInverse, asInt,
    getIntFrom, arraycopy, acquire, createArrayNumberFromHex, multiplyTruncInts, createIntArrayNumber,
    createArrayNumber, copyArrayNumber, releaseArr, rescale, rescale2, resize, asShort
    local yieldcount = 0;
    local frameRateGoal;
    local maxYieldSkips = 5000;
    yield = function()
        if (coroutine.running()) then
            if (not frameRateGoal) then
                frameRateGoal = GetFramerate() * 0.95;
                print(frameRateGoal)
            end
            yieldcount = yieldcount + 1;
            if (yieldcount >= maxYieldSkips) then
                yieldcount = 0;
                local currentFrameRate = GetFramerate();
                if (currentFrameRate < frameRateGoal) then
                    maxYieldSkips = math.max(maxYieldSkips * 0.9, 2000)
                else
                    maxYieldSkips = maxYieldSkips * 1.1
                end
                coroutine.yield()
            end
        end
    end
    compare = function(n1, n2)
        yield();
        if (n1.len < n2.len) then
            return -1;
        end
        if (n1.len > n2.len) then
            return 1;
        end
        local idx = 0;
        while (idx < n1.len) do
            local x1 = asInt(n1.arr[idx]);
            local x2 = asInt(n2.arr[idx]);
            if (x1 < x2) then
                return -1;
            end
            if (x1 > x2) then
                return 1;
            end
            idx = idx + 1;
        end
        return 0;
    end
    getLowestSetBit = function(n)
        yield();
        local idx = n.len - 1;
        while(idx > 0) do
            if (n.arr[idx] ~= 0) then
                break;
            end
            idx = idx - 1;
        end
        local b1 = Bit32S.lshift(n.len - 1 - idx, 4);
        local b2 = Bit32S.band(n.arr[idx], 65535);
        return b1 + getLeadingZeroCount(Bit32S.band(Bit32S.bnot(b2), b2 - 1));
    end
    getLeadingZeroCount = function(x)
        yield();
        if (x <= 0) then
            return Bit32S.band(x, 16);
        else
            local b = 1;
            if (x > 256) then
                b = b + 8;
                x = Bit32S.rshift(x, 8);
            end
            if (x > 16) then
                b = b + 4;
                x = Bit32S.rshift(x, 4);
            end
            if (x > 4) then
                b = b + 2;
                x = Bit32S.rshift(x, 2);
            end
            return b + Bit32S.rshift(x, 1);
        end
    end
    normalize = function(n)
        yield();
        if (n.len % 2 == 1) then
            rescale(n, 0, 1, n.len + 1);
        end
        if (n.len == 0 or n.arr[0] ~= 0 or n.arr[1] ~= 0) then
            return;
        end
        local idx = 0;
        local len1 = n.len;
        repeat
            idx = idx + 2;
        until (not (idx + 1 < len1 and n.arr[idx] == 0 and n.arr[idx + 1] == 0))
        local len2 = len1 - idx;
        local offs = len2 == 0 and 0 or idx;
        if (len1 ~= len2 or offs ~= 0) then
            rescale(n, offs, 0, len2);
        end
    end
    rightShift = function(n, b1)
        yield();
        local b2 = Bit32S.band(b1, 31);
        local b3 = bitLengthForInt(Bit32S.bor(Bit32S.band(n.arr[1], 65535), Bit32S.lshift(n.arr[0], 16)));
        if (b2 >= b3) then
            primitiveLeftShift(n, 32 - b2);
            rescale(n, 0, 0, n.len - 2);
        else
            primitiveRightShift(n, b2);
        end
    end
    leftShift = function(n, b)
        yield();
        if (n.len == 0) then
            return;
        end
        local b2 = Bit32S.band(b, 15);
        if (b <= 0) then
            primitiveLeftShift(n, b2);
        end
        rescale(n, 0, 0, n.len + Bit32S.rshift(b, 4) + 2);
        primitiveRightShift(n, 32 - b2);
    end
    mulsub = function(n1, n2, x, len, off)
        yield();
        x = Bit32S.band(x, 65535);
        local c = 0;
        off = off + len;
        local idx = len - 1;
        while (idx >= 0) do
            local prod = asInt(n2.arr[idx]) * x + c;
            local diff = n1.arr[off] - prod;
            n1.arr[off] = asShort(diff);
            off = off - 1;
            c = Bit32S.rshift(prod, 16) + ((Bit32S.band(diff, 65535) > (Bit32S.band((Bit32S.bnot(prod)), 65535))) and 1 or 0);
        idx = idx - 1;
        end
        return asShort(c);
    end
    primitiveRightShift = function(n, b)
        yield();
        if (b > 16) then
            local s = Bit32S.rshift(b, 4);
            rescale2(n, 0, s, n.len, n.len - s);
            b = b % 16;
        end
        local n2 = 16 - b;
        local x1 = n.arr[n.len - 1];
        local idx = n.len - 1;
        while (idx > 0) do
            local x2 = x1;
            x1 = n.arr[idx - 1];
            n.arr[idx] = asShort(Bit32S.bor(Bit32S.lshift(Bit32S.band(x1, 65535), n2), (Bit32S.rshift(Bit32S.band(x2, 65535), b))));
            idx = idx - 1
        end
        n.arr[0] = asShort(Bit32S.rshift(Bit32S.band(n.arr[0], 65535), b));
    end
    primitiveLeftShift = function(n, b)
        yield();
        local len = Bit32S.rshift(n.len, 1);
        if (len == 0 or b == 0) then
            return;
        end
        local b2 = 32 - b;
        local x1 = getInt(n, 0);
        local idx = 0;
        while ( idx < len - 1) do
            local x2 = x1;
            x1 = getInt(n, idx + 1);
            setInt(n, idx, Bit32S.bor(Bit32S.lshift(x2, b), Bit32S.rshift(x1, b2)));
            idx = idx + 1;
        end
        setInt(n, len - 1, Bit32S.lshift(getInt(n, len - 1), b));
    end
    getInt = function(n, idx)
        yield();
        return Bit32S.bor(Bit32S.band(n.arr[idx * 2 + 1], 65535), Bit32S.lshift(n.arr[idx * 2], 16));
    end
    setInt = function(n, idx, x)
        yield();
        n.arr[idx * 2] = asShort(Bit32S.rshift(x, 16));
        n.arr[idx * 2 + 1] = asShort(x);
    end
    add = function(n1, n2)
        yield();
        local idx1 = n1.len;
        local idx2 = n2.len;
        local len = math.max(idx1, idx2);
        local n3 = createArrayNumber(len);
        local idx3 = len - 1;
        local sum;
        local carry = 0;
        while (idx1 > 0 and idx2 > 0) do
            idx1 = idx1 - 1;
            idx2 = idx2 - 1;
            sum = asInt(n1.arr[idx1]) + asInt(n2.arr[idx2]) + carry;
            n3.arr[idx3] = asShort(sum);
            idx3 = idx3 - 1;
            carry = Bit32S.rshift(sum, 16);
        end
        while (idx1 > 0) do
            idx1 = idx1 - 1;
            sum = asInt(n1.arr[idx1]) + carry;
            n3.arr[idx3] = asShort(sum);
            idx3 = idx3 - 1;
            carry = Bit32S.rshift(sum, 16);
        end
        while (idx2 > 0) do
            idx2 = idx2 - 1;
            sum = asInt(n2.arr[idx2]) + carry;
            n3.arr[idx3] = asShort(sum);
            idx3 = idx3 - 1;
            carry = Bit32S.rshift(sum, 16);
        end
        if (carry > 0) then
            rescale(n3, 0, 2, n3.len + 2);
            n3.arr[1] = 1;
        end
        n3.sign = n1.sign;
        return n3;
    end
    subtract = function(n1, n2)
        yield();
        local n3 = n1;
        local sign = compare(n1, n2);
        if (sign < 0) then
            local tmp = n3;
            n3 = n2;
            n2 = tmp;
        end
        local idx2 = n2.len;
        local idx3 = n3.len;
        local n4 = createArrayNumber(idx3);
        local diff = 0;
        local idx4 = n4.len - 1;
        while (idx2 > 0) do
            idx3 = idx3 - 1;
            idx2 = idx2 - 1;
            diff = asInt(n3.arr[idx3]) - Bit32S.band(n2.arr[idx2], 65535) + Bit32S.arshift(diff, 16);
            n4.arr[idx4] = asShort(diff);
            idx4 = idx4 - 1;
        end
        while (idx3 > 0) do
            idx3 = idx3 - 1;
            diff = asInt(n3.arr[idx3]) + Bit32S.arshift(diff, 16);
            n4.arr[idx4] = asShort(diff);
            idx4 = idx4 - 1;
        end
        n4.sign = n1.sign * sign;
        normalize(n4);
        return n4;
    end
    copyAndShift = function(n1, len, n2, idx2, b1)
        yield();
        local idx1 = 0
        local b2 = 16 - b1;
        local x1 = n1.arr[idx1];
        local idx3 = 0;
        while(idx3 < len - 1) do
            local x2 = x1;
            idx1 = idx1 + 1;
            x1 = n1.arr[idx1];
            n2.arr[idx2 + idx3] = asShort(Bit32S.bor(Bit32S.lshift(x2, b1), Bit32S.lshift(x1, b2)));
            idx3 = idx3 + 1;
        end
        n2.arr[idx2 + len - 1] = asShort(Bit32S.lshift(x1, b1));
    end
    numberOfLeadingZeros = function(x)
        yield();
        if (x <= 0) then
            return x == 0 and 16 or 0;
        end
        local b = 15;
        if (x >= 256) then
            b = b - 8;
            x = asShort(Bit32S.rshift(x, 8));
        end
        if (x >= 16) then
            b = b - 4;
            x = asShort(Bit32S.rshift(x, 4));
        end
        if (x >= 4) then
            b = b - 2;
            x = asShort(Bit32S.rshift(x, 2));
        end
        return b - Bit32S.rshift(x, 1);
    end
    mod = function(n1, n2)
        yield();
        local len3;
        local b1 = numberOfLeadingZeros(n2.arr[0]);
        local n4;
        local n5;
        if (b1 > 0) then
            n4 = createArrayNumber(n2.len);
            copyAndShift(n2, n2.len, n4, 0, b1);
            if (numberOfLeadingZeros(n1.arr[0]) >= b1) then
                n5 = createArrayNumber((n1.len + 1));
                len3 = n1.len;
                copyAndShift(n1, n1.len, n5, 1, b1);
            else
                n5 = createArrayNumber((n1.len + 2));
                len3 = n1.len + 1;
                local idx1 = 0;
                local x1 = 0;
                local b2 = 16 - b1;
                local idx2 = 1;
                while (idx2 < n1.len + 1) do
                    local x2 = x1;
                    x1 = n1.arr[idx1];
                    n5.arr[idx2] = asShort(Bit32S.bxor(Bit32S.lshift(x2, b1), Bit32S.rshift(x1, b2)));
                    idx2 = idx2 + 1;
                    idx1 = idx1 + 1;
                end
                n5.arr[n1.len + 1] = asShort(Bit32S.lshift(x1, b1));
            end
        else
            n4 = n2;
            n5 = createArrayNumber((n1.len + 1));
            arraycopy(n1.arr, 0, n5.arr, 1, n1.len);
            len3 = n1.len;
        end
        len3 = len3 - n2.len + 1;
        local n5offset = 0;
        n5.arr[0] = 0;
        local x1 = asInt(n4.arr[0]);
        local x7 = n4.arr[1];
        local idx1 = 0;
        while (idx1 < len3 - 1) do
            local x2;
            local x3;
            local t = false;
            local x4 = n5.arr[idx1 + n5offset];
            local x5 = asShort(x4 + 32768);
            local x6 = n5.arr[idx1 + 1 + n5offset];
            if (x4 == n4.arr[0]) then
                x2 = -1;
                x3 = asShort(x4 + x6);
                t = asShort((x3 + 32768)) < x5;
            else
                local x8 = Bit32S.bor(Bit32S.lshift(x4, 16), Bit32S.band(x6, 65535));
                if (x8 >= 0) then
                    x2 = asShort(math.floor(x8 / x1));
                    x3 = asShort((x8 - (x2 * x1)));
                else
                    local tmp = divWord(x8, n4.arr[0]);
                    x2 = asShort(tmp);
                    x3 = asShort(Bit32S.rshift(tmp, 16));
                end
            end
            if (x2 ~= 0) then
                if (not t) then
                    local x9 = asInt(n5.arr[idx1 + 2 + n5offset]);
                    local x10 = Bit32S.bor(Bit32S.lshift(Bit32S.band(x3, 65535), 16), x9);
                    local x11 = Bit32S.band(x7, 65535) * Bit32S.band(x2, 65535);
                    if (unsignedIntCompare(x11, x10)) then
                        x2 = asShort(x2 - 1);
                        x3 = asShort(x3 + x1);
                        if (Bit32S.band(x3, 65535) >= x1) then
                            x11 = x11 - Bit32S.band(x7, 65535);
                            x10 = Bit32S.bor(Bit32S.lshift(Bit32S.band(x3, 65535), 16), x9);
                            if (unsignedIntCompare(x11, x10)) then
                                x2 = asShort(x2 - 1);
                            end
                        end
                    end
                end
                n5.arr[idx1 + n5offset] = 0;
                local c = mulsub(n5, n4, x2, n2.len, idx1 + n5offset);
                if (asShort((c + 32768)) > x5) then
                    divadd(n4, n5, idx1 + 1 + n5offset);
                end
            end
            idx1 = idx1 + 1;
        end
        local x9;
        local x10;
        local t = false;
        local x11 = n5.arr[len3 - 1 + n5offset];
        local x12 = asShort(x11 + 32768);
        local x13 = n5.arr[len3 + n5offset];
        if (x11 == n4.arr[0]) then
            x9 = -1;
            x10 = asShort(x11 + x13);
            t = asShort((x10 + 32768)) < x12;
        else
            local x14 = Bit32S.bor(Bit32S.lshift((x11), 16), Bit32S.band(x13, 65535));
            if (x14 >= 0) then
                x9 = asShort(math.floor(x14 / x1));
                x10 = asShort((x14 - (x9 * x1)));
            else
                local tmp = divWord(x14, n4.arr[0]);
                x9 = asShort(tmp);
                x10 = asShort(Bit32S.rshift(tmp, 16));
            end
        end
        if (x9 ~= 0) then
            if (not t) then
                local x14 = asInt(n5.arr[len3 + 1 + n5offset]);
                local x15 = Bit32S.bor(Bit32S.lshift(Bit32S.band(x10, 65535), 16), x14);
                local x16 = Bit32S.band(x7, 65535) * Bit32S.band(x9, 65535);
                if (unsignedIntCompare(x16, x15)) then
                    x9 = asShort(x9 - 1);
                    x10 = asShort(x10 + x1);
                    if (Bit32S.band(x10, 65535) >= x1) then
                        x16 = x16 - Bit32S.band(x7, 65535);
                        x15 = Bit32S.bor(Bit32S.lshift(Bit32S.band(x10, 65535), 16), x14);
                        if (unsignedIntCompare(x16, x15)) then
                            x9 = asShort((x9 - 1));
                        end
                    end
                end
            end
            local c;
            n5.arr[len3 - 1 + n5offset] = 0;
            c = mulsub(n5, n4, x9, n2.len, len3 - 1 + n5offset);
            if (asShort((c + 32768)) > x12) then
                divadd(n4, n5, len3 - 1 + 1 + n5offset);
            end
        end
        if (b1 > 0) then
            rightShift(n5, b1);
        end
        normalize(n5);
        return n5;
    end
    divadd = function(n1, n2, off)
        yield();
        local c = 0;
        local idx = n1.len - 1;
        while (idx >= 0) do
            local x = asInt(n1.arr[idx]) + Bit32S.band(n2.arr[idx + off], 65535) + c;
            n2.arr[idx + off] = asShort(x);
            c = Bit32S.rshift(x, 16);
            idx = idx - 1;
        end
    end
    unsignedIntCompare = function(x1, x2)
        yield();
        return (x1 + -2147483648) > (x2 - -2147483648);
    end
    divWord = function(x1, x2)
        yield();
        local x3 = Bit32S.band(x2, 65535);
        local x4;
        local x5;
        x5 = math.floor(Bit32S.rshift(x1, 1) / Bit32S.rshift(x3, 1));
        x4 = x1 - multiplyTruncInts(x5, x3);
        while (x4 < 0) do
            x4 = x4 + x3;
            x5 = x5 - 1;
        end
        return Bit32S.bor(Bit32S.lshift(x4, 16), Bit32S.band(x5, 65535));
    end
    multiply = function(n1, n2)
        yield();
        local len1 = (n1.len + (n1.len % 2)) / 2;
        local len2 = (n2.len + (n2.len % 2)) / 2;
        local x1 = n1.sign == n2.sign and 1 or -1;
        local n3 = multiplyToLen(n1, len1, n2, len2);
        local vlen = n3.len;
        local keep = 0;
        while (keep < vlen and n3.arr[keep] == 0) do
            keep = keep + 1;
        end
        if (keep % 2 ~= 0) then
            keep = keep - 1;
        end
        if (keep ~= 0) then
            rescale(n3, keep, 0, vlen - keep);
        end
        n3.sign = n3.len == 0 and 0 or x1;
        return n3;
    end
    multiplyToLen = function(n1, len1, n2, len2)
        yield();
        len1 = len1 * 2;
        len2 = len2 * 2;
        local n3 = createArrayNumber((len1 + len2));
        local c = 0;
        local idx1 = len2 - 1;
        local idx2 = len2 + len1 - 1;
        while (idx1 >= 0) do
            local product = asInt(n2.arr[idx1]) * Bit32S.band(n1.arr[len1 - 1], 65535) + c;
            n3.arr[idx2] = asShort(product);
            c = Bit32S.rshift(product, 16);
            idx1 = idx1 - 1;
            idx2 = idx2 - 1;
        end
        n3.arr[len1 - 1] = asShort(c);
        idx1 = len1 - 2;
        while (idx1 >= 0) do
            c = 0;
            idx2 = len2 - 1;
            local idx3 = len2 + idx1;
            while (idx2 >= 0) do
                local product = asInt(n2.arr[idx2]) * Bit32S.band(n1.arr[idx1], 65535) + Bit32S.band(n3.arr[idx3], 65535) + c;
                n3.arr[idx3] = asShort(product);
                c = Bit32S.rshift(product, 16);
                idx2 = idx2 - 1;
                idx3 = idx3 - 1;
            end
            n3.arr[idx1] = asShort(c);
            idx1 = idx1 - 1;
        end
        return n3;
    end
    bitLengthForInt = function(x)
        yield();
        if (x <= 0) then
            return 32 - (x == 0 and 32 or 0);
        end
        local b = 31;
        if (x >= 65536) then
            b = b - 16;
            x = Bit32S.rshift(x, 16);
        end
        if (x >= 256) then
            b = b - 8;
            x = Bit32S.rshift(x, 8);
        end
        if (x >= 16) then
            b = b - 4;
            x = Bit32S.rshift(x, 4);
        end
        if (x >= 4) then
            b = b - 2;
            x = Bit32S.rshift(x, 2);
        end
        return 32 - (b - Bit32S.rshift(x, 1));
    end
    modPow = function(n1, n2, n3)
        yield();
        local t = (n2.sign < 0);
        local disposables = { };
        local n4;
        if (n1.sign < 0 or compare(n1, n3) >= 0) then
            n4 = mod(n1, n3);
            table.insert(disposables,n4);
        else
            n4 = n1;
        end
        local b1 = 0;
        local b2 = ((n2.len / 2 - 1) * 32) + bitLengthForInt(getIntFrom(n2, 0));
        while (b2 > bnExpModThreshTable[b1]) do
            b1 = b1 + 1;
        end
        local x1 = Bit32S.lshift(1, b1);
        local x2 = getIntFrom(n3, n3.len / 2 - 1);
        local x3 = multiplyTruncInts(x2, (2 - multiplyTruncInts(x2, x2)));
        x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        x3 = -multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        local n6 = createArrayNumber((n3.len + n4.len));
        table.insert(disposables,n6);
        arraycopy(n4.arr, 0, n6.arr, 0, n4.len);
        local idx1 = n4.len;
        while (idx1 < n6.len) do
            n6.arr[idx1] = 0;
            idx1 = idx1 + 1;
        end
        primitiveLeftShift(n6, Bit32S.band(n3.len * 16, 31));
        local a = { };
        a[0] = mod(n6, n3);
        local n7 = montgomerySquare(a[0], n3, n3.len / 2, x3);
        table.insert(disposables,n7);
        local n8 = createArrayNumber(n3.len);
        arraycopy(n7.arr, 0, n8.arr, 0, n3.len);
        idx1 = 1;
        while (idx1 < x1) do
            a[idx1] = montgomeryMultiply(n8, a[idx1 - 1], n3, n3.len / 2, x3);
            idx1 = idx1 + 1;
        end
        releaseArr(n8);
        local b3 = Bit32S.lshift(1, (Bit32S.band((b2 - 1), 31)));
        local x4 = 0;
        local len1 = n2.len / 2;
        idx1 = 0;
        local idx2 = 0;
        while (idx2 <= b1) do
            x4 = Bit32S.bor(Bit32S.lshift(x4, 1), ((Bit32S.band(getIntFrom(n2, idx1), b3) ~= 0) and 1 or 0));
            b3 = Bit32S.rshift(b3, 1);
            idx2 = idx2 + 1;
        end
        b2 = b2 - 1;
        local t1 = true;
        local x5 = b2 - b1;
        while (Bit32S.band(x4, 1) == 0) do
            x4 = Bit32S.rshift(x4, 1);
            x5 = x5 + 1;
        end
        local n9 = a[Bit32S.rshift(x4, 1)];
        x4 = 0;
        if (x5 == b2) then
            t1 = false;
        end
        while (b2 ~= 0) do
            b2 = b2 - 1;
            x4 = Bit32S.lshift(x4, 1);
            if (len1 ~= 0) then
                x4 = Bit32S.bor(x4, (Bit32S.band(getIntFrom(n2, idx1), b3) ~= 0) and 1 or 0);
                b3 = Bit32S.rshift(b3, 1);
                if (b3 == 0) then
                    idx1 = idx1 + 1;
                    b3 = Bit32S.lshift(1, 31);
                    len1 = len1 - 1;
                end
            end
            if (Bit32S.band(x4, x1) ~= 0) then
                x5 = b2 - b1;
                while (Bit32S.band(x4, 1) == 0) do
                    x4 = Bit32S.rshift(x4, 1);
                    x5 = x5 + 1;
                end
                n9 = a[Bit32S.rshift(x4, 1)];
                x4 = 0;
            end
            if (b2 == x5) then
                if (t1) then
                    n7 = n9;
                    t1 = false;
                else
                    n7 = montgomeryMultiply(n7, n9, n3, n3.len / 2, x3);
                    table.insert(disposables,n7);
                end
            end
            if (b2 ~= 0 and (not t1)) then
                n7 = montgomerySquare(n7, n3, n3.len / 2, x3);
                table.insert(disposables,n7);
            end
        end
        rescale2(n7, 0, n3.len, n3.len * 2, n3.len);
        montReduce(n7, n3, n3.len, x3);
        rescale(n7, 0, 0, n7.len / 2);
        if (t) then
            n7 = modInverse(n7, n3);
        end
        for n = 1, #disposables do
            if (disposables[n] ~= n7) then
                releaseArr(disposables[n]);
            end
        end
        for n = 0, #a do
            if (a[n] ~= n7) then
                releaseArr(a[n]);
            end
        end
        return n7;
    end
    montgomeryMultiply = function(n1, n2, n3, len, x)
        yield();
        local n4 = multiplyToLen(n1, len, n2, len);
        montReduce(n4, n3, len * 2, x);
        return n4;
    end
    montgomerySquare = function(n1, n2, len1, x1)
        yield();
        local n3 = createArrayNumber(len1 * 4);
        local x2 = 0;
        local idx1 = 0;
        local idx2 = 0;
        while (idx1 < len1) do
            local n4 = createArrayNumber(2);
            n4.arr[0] = n1.arr[idx1 * 2];
            n4.arr[1] = n1.arr[idx1 * 2 + 1];
            local n5 = ArrayMath.multiply(n4, n4);
            releaseArr(n4);
            if (n5.len < 4) then
                rescale(n5, 0, 4 - n5.len, 4);
            end
            local idx3 = n5.len - 4;
            n3.arr[idx2 * 2] = asShort((Bit32S.lshift(x2, 15) + Bit32S.rshift(asInt(n5.arr[idx3]), 1)));
            n3.arr[idx2 * 2 + 1] = asShort((Bit32S.lshift(asInt(n5.arr[idx3]), 15) + Bit32S.rshift(Bit32S.band(n5.arr[idx3 + 1], 65535), 1)));
            idx2 = idx2 + 1;
            n3.arr[idx2 * 2] = asShort((Bit32S.lshift(asInt(n5.arr[idx3 + 1]), 15) + Bit32S.rshift(Bit32S.band(n5.arr[idx3 + 2], 65535), 1)));
            n3.arr[idx2 * 2 + 1] = asShort((Bit32S.lshift(asInt(n5.arr[idx3 + 2]), 15) + Bit32S.rshift(Bit32S.band(n5.arr[idx3 + 3], 65535), 1)));
            idx2 = idx2 + 1;
            x2 = Bit32S.band(n5.arr[idx3 + 3], 1);
            releaseArr(n5);
            idx1 = idx1 + 1;
        end
        idx1 = len1;
        local off = 1;
        while (idx1 > 0) do
            addOne(n3, off - 1, idx1, implMulAdd(n3, n1, off, idx1 - 1, getIntFrom(n1, idx1 - 1)));
            idx1 = idx1 - 1;
            off = off + 2;
        end
        primitiveLeftShift(n3, 1);
        n3.arr[(len1 * 4) - 1] = asShort((n3.arr[(len1 * 4) - 1] + Bit32S.band(n1.arr[(len1 * 2) - 1], 1)));
        montReduce(n3, n2, len1 * 2, x1);
        return n3;
    end
    montReduce = function(n1, n2, len, x1)
        yield();
        local c = 0;
        local idx = len;
        local off = 0;
        repeat
            local x2 = n1.arr[n1.len - 1 - off];
            c = c + mulAddOne(n1, n2, off, len, multiplyTruncInts(x1, x2), off, len);
            off = off + 1;
            idx = idx - 1;
        until (not(idx > 0));
        while (c > 0) do
            c = c + subN(n1, n2, len);
        end
        while (intArrayCmpToLen(n1, n2, len) >= 0) do
            subN(n1, n2, len);
        end
    end
    intArrayCmpToLen = function(n1, n2, len)
        yield();
        local idx = 0;
        while (idx < len) do
            local x1 = Bit32S.band(Bit32S.rshift(getIntFrom(n1, idx), 16), 65535);
            local x2 = Bit32S.band(Bit32S.rshift(getIntFrom(n2, idx), 16), 65535);
            if (x1 < x2) then
                return -1;
            end
            if (x1 > x2) then
                return 1;
            end
            x1 = Bit32S.band(getIntFrom(n1, idx), 65535);
            x2 = Bit32S.band(getIntFrom(n2, idx), 65535);
            if (x1 < x2) then
                return -1;
            end
            if (x1 > x2) then
                return 1;
            end
            idx = idx + 1;
        end
        return 0;
    end
    subN = function(n1, n2, len)
        yield();
        local x = 0;
        len = len - 1;
        while (len >= 0) do
            x = asInt(n1.arr[len]) - Bit32S.band(n2.arr[len], 65535) + Bit32S.arshift(x, 16);
            n1.arr[len] = asShort(x);
            len = len - 1;
        end
        return asShort(Bit32S.arshift(x, 16));
    end
    mulAddOne = function(n1, n2, off1, len1, x1, off2, len2)
        yield();
        x1 = Bit32S.band(x1, 65535);
        local c = 0;
        off1 = n1.len - off1 - 1;
        local idx = len1 - 1;
        while (idx >= 0) do
            local x2 = asInt(n2.arr[idx]) * x1 + Bit32S.band(n1.arr[off1], 65535) + c;
            n1.arr[off1] = asShort(x2);
            off1 = off1 - 1;
            c = Bit32S.rshift(x2, 16);
            idx = idx - 1;
        end
        off2 = n1.len - 1 - len2 - off2;
        local x2 = asInt(n1.arr[off2]) + Bit32S.band(c, 65535);
        n1.arr[off2] = asShort(x2);
        if (Bit32S.rshift(x2, 16) == 0) then
            return 0;
        end
        while (len2 >= 1) do
            len2 = len2 - 1;
            off2 = off2 - 1;
            if (off2 < 0) then
                return 1;
            else
                n1.arr[off2] = asShort((n1.arr[off2] + 1));
                if (n1.arr[off2] ~= 0) then
                    return 0;
                end
            end
        end
        return 1;
    end
    addToArray = function(a, off, x1)
        yield();
        for idx = off, #a do
            local x2 = Bit32S.band((a[idx] + Bit32S.band(x1, 65535)), 65535);
            x1 = Bit32S.rshift((a[idx] + x1), 16);
            a[idx] = x2;
        end
    end
    implMulAdd = function(n1, n2, idx2, len, x1)
        yield();
        local x2 = 0;
        local x3 = 0;
        local x4 = Bit32S.band(Bit32S.rshift(x1, 16), 65535);
        local x5 = Bit32S.band(x1, 65535);
        idx2 = n1.len / 2 - idx2 - 1;
        local a = { };
        local idx = len - 1;
        while (idx >= 0) do
            local x7 = asInt(n2.arr[idx * 2]);
            local x8 = asInt(n2.arr[idx * 2 + 1]);
            local x9 = asInt(n1.arr[idx2 * 2]);
            local x10 = asInt(n1.arr[idx2 * 2 + 1]);
            a[0] = 0;
            a[1] = 0;
            a[2] = 0;
            a[3] = 0;
            addToArray(a, 2, x7 * x4);
            addToArray(a, 1, x7 * x5);
            addToArray(a, 1, x8 * x4);
            addToArray(a, 1, x2);
            addToArray(a, 1, x9);
            addToArray(a, 0, x8 * x5);
            addToArray(a, 0, x3);
            addToArray(a, 0, x10);
            x2 = a[3];
            x3 = a[2];
            n1.arr[idx2 * 2] = a[1];
            n1.arr[idx2 * 2 + 1] = a[0];
            idx2 = idx2 - 1;
            idx = idx - 1;
        end
        return (x2 * 65536) + x3;
    end
    addOne = function(n1, idx, len, c)
        yield();
        idx = n1.len / 2 - 1 - len - idx;
        local a = { 0, 0, 0 }; a[0] = 0;
        addToArray(a, 0, getIntFrom(n1, idx));
        addToArray(a, 0, c);
        n1.arr[idx * 2] = asShort(a[1]);
        n1.arr[idx * 2 + 1] = asShort(a[0]);
        if (a[2] == 0 and a[3] == 0) then
            return;
        end
        while (len >= -1) do
            len = len - 1;
            idx = idx - 1;
            if (idx < 0) then
                return;
            else
                local x = getIntFrom(n1, idx) + 1;
                n1.arr[idx * 2] = asShort(Bit32S.rshift(x,16));
                n1.arr[idx * 2 + 1] = asShort(x);
                if (getIntFrom(n1, idx) ~= 0) then
                    return;
                end
            end
        end
    end
    modInverse = function(n1, n2)
        yield();
        local n3 = copyArrayNumber(n2);
        local n8 = n1;
        local n4 = createArrayNumber(2);
        n4.arr[0] = 0;
        n4.arr[1] = 1;
        local n5 = createArrayNumber(0);
        local x1 = 0;
        if ((n8.len / 2 == 0) or (Bit32S.band(getIntFrom(n8, n8.len / 2 - 1), 1) == 0)) then
            x1 = getLowestSetBit(n8);
            rightShift(n8, x1);
            leftShift(n5, x1);
        end
        while (not ((n8.len / 2 == 1) and (getIntFrom(n8, 0) == 1))) do
            if (compare(n8, n3) < 0) then
                local n6 = n8;
                n8 = n3;
                n3 = n6;
                n6 = n5;
                n5 = n4;
                n4 = n6;
            end
            if (Bit32S.band(Bit32S.bxor(getIntFrom(n8, n8.len / 2 - 1), getIntFrom(n3, n3.len / 2 - 1)), 3) == 0) then
                local disp1 = n8;
                n8 = subtract(disp1, n3);
                if (disp1 ~= n1) then
                    releaseArr(disp1);
                end
                if (n4.sign == n5.sign) then
                    local disp = n4;
                    n4 = subtract(disp, n5);
                    releaseArr(disp);
                else
                    local disp = n4;
                    n4 = add(disp, n5);
                    releaseArr(disp);
                end
            else
                local disp1 = n8;
                n8 = add(disp1, n3);
                if (disp1 ~= n1) then
                    releaseArr(disp1);
                end
                if (n4.sign == n5.sign) then
                    local disp = n4;
                    n4 = add(disp, n5);
                    releaseArr(disp);
                else
                    local disp = n4;
                    n4 = subtract(n4, n5);
                    releaseArr(disp);
                end
            end
            local x2 = getLowestSetBit(n8);
            rightShift(n8, x2);
            leftShift(n5, x2);
            normalize(n5);
            x1 = x1 + x2;
        end
        if (n3 ~= n1) then
            releaseArr(n3);
        end
        if (n8 ~= n1) then
            releaseArr(n8);
        end
        releaseArr(n5);
        while (n4.sign < 0) do
            local disp = n4;
            n4 = subtract(disp, n2);
            releaseArr(disp);
        end
        local x2 = getIntFrom(n2, n2.len / 2 - 1);
        local x3 = multiplyTruncInts(x2, (2 - multiplyTruncInts(x2, x2)));
        x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        x3 = multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        x3 = -multiplyTruncInts(x3, (2 - multiplyTruncInts(x2, x3)));
        local idx = 0;
        local x4 = Bit32S.rshift(x1, 5);
        while (idx < x4) do
            local x5 = multiplyTruncInts(x3,getIntFrom(n4, n4.len / 2 - 1));
            local n6 = createArrayNumber(2);
            n6.arr[0] = asShort(Bit32S.rshift(x5, 16));
            n6.arr[1] = asShort(x5);
            local disp1 = n4;
            local disp2 = multiply(n2, n6);
            releaseArr(n6);
            n4 = add(disp1, disp2);
            releaseArr(disp1);
            releaseArr(disp2);
            local len = n4.len / 2 - 1;
            if (n4.len / 2 ~= len) then
                resize(n4, len);
            end
            idx = idx + 1;
        end
        local b = Bit32S.band(x1, 31);
        if (b ~= 0) then
            x4 = Bit32S.band(multiplyTruncInts(x3, getIntFrom(n4, n4.len / 2 - 1)), (Bit32S.lshift(1, b) - 1));
            local n6 = createArrayNumber(2);
            n6.arr[0] = asShort(Bit32S.rshift(x4, 16));
            n6.arr[1] = asShort(x4);
            local n7 = multiply(n2, n6);
            releaseArr(n6);
            local disp = n4;
            n4 = add(disp, n7);
            releaseArr(disp);
            releaseArr(n7);
            rightShift(n4, b);
        end
        return n4;
    end
    asInt = function(s)
        yield();
        return Bit32S.band(s, 65535);
    end
    getIntFrom = function(n, idx)
        yield();
        return asInt(n.arr[idx * 2 + 1]) + (Bit32S.lshift(n.arr[idx * 2], 16));
    end
    arraycopy = function(a1, off1, a2, off2, len)
        yield();
        for idx = 0, len do
            a2[idx + off2] = a1[idx + off1];
        end
    end
    acquire = function()
        yield();
        if (#pool == 0) then
            local a = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
            a[0] = 0;
            return a;
        else
            return table.remove(pool);
        end
    end
    createArrayNumberFromHex = function(val)
        yield();
        local n = { };
        val = string.upper(val);
        local cursor = 0;
        while (cursor < #val and val:sub(cursor + 1, cursor + 1) == '0') do
            cursor = cursor + 1;
        end
        while ((#val - cursor) % 8 ~= 0) do
            cursor = cursor - 1;
        end
        while (cursor < 0) do
            val = "0" .. val;
            cursor = cursor + 1;
        end
        local numDigits = #val - cursor;
        local numWords = math.floor(numDigits / 4) + (numDigits % 4 == 0 and 0 or 1);
        n.arr = acquire();
        n.len = numWords;
        n.sign = 1;
        local groupLen = numDigits % 4;
        if (groupLen == 0) then
            groupLen = 4;
        end
        local idx = 0;
        while (idx < numWords) do
            local val1 = val:sub(cursor + 1, cursor + groupLen);
            cursor = cursor + groupLen;
            local i = tonumber(val1, 16);
            if (i > 32767) then
                i = i - 65536;
            end
            n.arr[idx] = asShort(i);
            groupLen = 4;
            idx = idx + 1;
        end
        return n;
    end
    multiplyTruncInts = function(x1, x2)
        yield();
        local n1 = createIntArrayNumber(x1);
        local n2 = createIntArrayNumber(x2);
        local n3 = ArrayMath.multiply(n1, n2);
        if (n3.len == 0) then
            return 0;
        end
        local x3 = getIntFrom(n3, (n3.len / 2) - 1);
        releaseArr(n1);
        releaseArr(n2);
        releaseArr(n3);
        return x3;
    end
    createIntArrayNumber = function(x)
        yield();
        local n2 = { };
        n2.arr = acquire();
        n2.len = 2;
        local x1 = asShort(Bit32S.band((Bit32S.rshift(x, 16)), 65535));
        local x2 = asShort(Bit32S.band(x, 65535));
        if (x1 == 0) then
            n2.sign = 0;
        elseif (x1 > 0) then
            n2.sign = 1;
        else
            n2.sign = -1;
        end
        n2.arr[0] = x1;
        n2.arr[1] = x2;
        return n2;
    end
    createArrayNumber = function(len)
        yield();
        local n = { }
        n.arr = acquire();
        n.len = len;
        n.sign = 1;
        return n;
    end
    copyArrayNumber = function(n1)
        yield();
        local n = { };
        n.arr = acquire();
        arraycopy(n1.arr, 0, n.arr, 0, n1.len);
        n.len = n1.len;
        n.sign = n1.sign;
        return n;
    end
    releaseArr = function(n)
        yield();
        table.insert(pool, n.arr);
        n.arr = nil;
    end
    rescale = function(n, off1, off2, len1)
        yield();
        local len2 = len1;
        if (len2 > n.len - off1) then
            len2 = n.len - off1;
        end
        rescale2(n, off1, off2, len1, len2);
    end
    rescale2 = function(n, off1, off2, len1, len2)
        yield();
        local newArr = acquire();
        arraycopy(n.arr, off1, newArr, off2, len2);
        for idx = 0, off2 - 1 do
            newArr[idx] = 0;
        end
        for idx = off2 + len2, len1 - 1 do
            newArr[idx] = 0;
        end
        releaseArr(n);
        n.arr = newArr;
        n.len = len1;
    end
    resize = function(n, len)
        yield();
        len = len * 2;
        if (len > n.len) then
            len = n.len;
        end
        for idx = n.len, len - 1 do
            n.arr[idx] = 0;
        end
        n.len = len;
    end
    asShort = function(x)
        yield();
        x = Bit32S.band(x, 65535)
        if (x > 32767) then
            x = x - 65536;
        end
        return x;
    end
    ArrayMath.ZERO = createArrayNumber(0);
    ArrayMath.createArrayNumberFromHex = createArrayNumberFromHex;
    ArrayMath.compare = compare;
    ArrayMath.modInverse = modInverse;
    ArrayMath.multiply = multiply;
    ArrayMath.mod = mod;
    ArrayMath.releaseArr = releaseArr;
    ArrayMath.modPow = modPow;
end
local DSA = { }
do
    local verifySignature, getArrayNumber, getArrayNumberForMessage
    getArrayNumber = function(key)
        local num = ArrayMath.createArrayNumberFromHex(key);
        return num;
    end
    getArrayNumberForMessage = function(message)
        local encoded = Sha256.encode(message);
        local num = ArrayMath.createArrayNumberFromHex(encoded);
        return num
    end
    verifySignature = function(message, signature, publicKey, callback)
        local r = getArrayNumber(signature.r);
        local s = getArrayNumber(signature.s);
        local p = getArrayNumber(publicKey.p);
        local q = getArrayNumber(publicKey.q);
        local g = getArrayNumber(publicKey.g);
        local y = getArrayNumber(publicKey.y);
        local hm = getArrayNumberForMessage(message);
        local result = false;
        if (ArrayMath.compare(ArrayMath.ZERO, r) < 0 and ArrayMath.compare(r, q) < 0 and ArrayMath.compare(ArrayMath.ZERO, s) < 0 and ArrayMath.compare(s, q) < 0) then
            local w = ArrayMath.modInverse(s, q);
            local hmw = ArrayMath.multiply(hm, w);
            local u1 = ArrayMath.mod(hmw, q);
            ArrayMath.releaseArr(hmw);
            local rw = ArrayMath.multiply(r, w);
            ArrayMath.releaseArr(w);
            local u2 = ArrayMath.mod(rw, q);
            ArrayMath.releaseArr(rw);
            local gu1 = ArrayMath.modPow(g, u1, p);
            ArrayMath.releaseArr(u1);
            local yu2 = ArrayMath.modPow(y, u2, p);
            ArrayMath.releaseArr(u2);
            local gu1yu2 = ArrayMath.multiply(gu1, yu2);
            ArrayMath.releaseArr(gu1);
            ArrayMath.releaseArr(yu2);
            local gu1yu2p = ArrayMath.mod(gu1yu2, p);
            ArrayMath.releaseArr(gu1yu2);
            local v = ArrayMath.mod(gu1yu2p, q);
            ArrayMath.releaseArr(gu1yu2p);
            result = ArrayMath.compare(v, r) == 0;
            ArrayMath.releaseArr(v);
        end
        if (callback) then
            callback(result)
        end
        return result;
    end
    DSA.verifySignature = verifySignature;
end
DSALib = DSA

local ADDON, NS = ...

local HC = {}
NS.UI = NS.UI or {}
NS.UI.HeaderController = HC

local openExp, openZone, openVendor = nil, nil, nil

local function NormalizeKind(kind)
    if kind == "zone" or kind == "vendor" then
        return kind
    end
    return "exp"
end

function HC:IsOpen(kind, key)
    kind = NormalizeKind(kind)
    if kind == "exp" then return openExp == key end
    if kind == "zone" then return openZone == key end
    if kind == "vendor" then return openVendor == key end
    return false
end

function HC:Toggle(kind, key)
    kind = NormalizeKind(kind)

    if kind == "exp" then
        if openExp == key then
            openExp, openZone, openVendor = nil, nil, nil
        else
            openExp = key
            openZone, openVendor = nil, nil
        end
        return
    end

    if kind == "zone" then
        if openZone == key then
            openZone, openVendor = nil, nil
        else
            openZone = key
            openVendor = nil
        end
        return
    end

    if kind == "vendor" then
        openVendor = (openVendor == key) and nil or key
        return
    end
end

function HC:Reset()
    openExp, openZone, openVendor = nil, nil, nil
end

return HC


local debug = false;
function mw_debug(value, name)
    if (not debug) then
        return;
    end

    if (name) then
        DEFAULT_CHAT_FRAME:AddMessage("debug "..name..": "..(value or "nil"), 1.0, 1.0, 1.0, 1, 10);
    else
        DEFAULT_CHAT_FRAME:AddMessage("debug: "..(value or "nil"), 1.0, 1.0, 1.0, 1, 10);
    end
end

function mw_info(message)
    if (message) then
        DEFAULT_CHAT_FRAME:AddMessage(message, 1.0, 1.0, 1.0, 1, 10);
    end
end

function mw_pairsByKeys(t, f)
    local a = {};

    for n in pairs(t) do
        table.insert(a, n)
    end

    table.sort(a, f);
    local i = 0;      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1;
        if a[i] == nil then
            return nil;
        else
            return a[i], t[a[i]];
        end
    end

    return iter;
end

function mw_pairsByKeysDesc(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, function(a,b) return a>b end)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

function mw_rgb2hex(red, green, blue)

    if (not red) then
        red = 1.0;
    end

    if (not green) then
        green = 1.0;
    end

    if (not blue) then
        blue = 1.0;
    end

    local r = string.format("%x", red * 255);
    local g = string.format("%x", green * 255);
    local b = string.format("%x", blue * 255);

    if (strlen(r) < 2) then
        r = "0"..r;
    end
    if (strlen(g) < 2) then
        g = "0"..g;
    end
    if (strlen(b) < 2) then
        b = "0"..b;
    end

    local color = r..g..b;

    return color;
end

function MistWeaver_RemoveTextures(frame)
    for i, child in ipairs({frame:GetRegions()}) do

        if (child and child:IsObjectType("texture")) then
            child:SetTexture(nil);
        end
    end
end

function MistWeaver_SetBackdrop(frame)

    local background = "Interface\\Addons\\MistWeaver\\images\\frame-background";
    local border = "Interface\\Addons\\MistWeaver\\images\\frame-border";

    if (CleanUIData) then
        background = CleanUI_GetFrameBackground() or "Interface\\Addons\\MistWeaver\\images\\frame-background";
        border = CleanUI_GetFrameBorder() or "Interface\\Addons\\MistWeaver\\images\\frame-border";
    end

    local insetValue = 2;

    frame:SetBackdrop( {
        bgFile = background,
        edgeFile = border, tile = true, tileSize = 64, edgeSize = 16,
        insets = { left = insetValue, right = insetValue, top = insetValue, bottom = insetValue }
    });
end

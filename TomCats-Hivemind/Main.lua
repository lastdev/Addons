local _, addon = ...
local TCL = addon.TomCatsLibs
local TourGuideFrame = _G["TomCats-HivemindTourGuideFrame"]

local function ADDON_LOADED(_, event, ...)
    local var1 = select(1, ...)
    if (var1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        TCL.Charms.Create({
            name = addon.name .. "MinimapButton",
            iconTexture = "Interface\\AddOns\\" .. addon.name .. "\\images\\hivemind-icon",
            backgroundColor = { 0.0,0.0,0.0,1.0 },
            handler_onclick = TourGuideFrame.toggle
        }).tooltip = {
            Show = function(this)
                GameTooltip:ClearLines()
                GameTooltip:SetOwner(this, "ANCHOR_LEFT")
                GameTooltip:SetText("TomCat's Tours:", 1, 1, 1)
                GameTooltip:AddLine("The Hivemind", nil, nil, nil, true)
                GameTooltip:AddLine("(Under Development - Stay tuned!)", nil, nil, nil, true)
                GameTooltip:Show()
            end,
            Hide = function()
                GameTooltip:Hide()
            end
        }
    end
end

TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)

if (TomCats and TomCats.Register) then
    TomCats:Register(
        {
            slashCommands = {
                {
                    command = "HIVEMIND TOGGLE",
                    desc = "Toggle The Hivemind Window",
                    func = TourGuideFrame.toggle
                }
            },
            name = "The Hivemind",
            version = "0.1.6"
        }
    )
end
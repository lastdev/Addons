local ADDON, NS = ...
NS.UI = NS.UI or {}
NS.UI.ProgressBar = {}

function NS.UI.ProgressBar:Create(parent, width)
    local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    bar:SetSize(width or 140, 6)

    bar:SetBackdrop({
        bgFile   = "Interface/Buttons/WHITE8x8",
        edgeFile = "Interface/Buttons/WHITE8x8",
        edgeSize = 1,
    })
    bar:SetBackdropColor(0.10, 0.10, 0.10, 1)
    bar:SetBackdropBorderColor(0, 0, 0, 1)

    bar.inner = CreateFrame("Frame", nil, bar)
    bar.inner:SetPoint("TOPLEFT", 1, -1)
    bar.inner:SetPoint("BOTTOMRIGHT", -1, 1)

    bar.bg = bar.inner:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(0.20, 0.20, 0.20, 1)

    bar.fill = bar.inner:CreateTexture(nil, "ARTWORK")
    bar.fill:SetPoint("LEFT", 1, 0)
    bar.fill:SetHeight(4)
    bar.fill:SetColorTexture(1.0, 0.82, 0.2)

    bar.edge = bar.inner:CreateTexture(nil, "OVERLAY")
    bar.edge:SetPoint("TOPLEFT", 0, 0)
    bar.edge:SetPoint("TOPRIGHT", 0, 0)
    bar.edge:SetHeight(1)
    bar.edge:SetColorTexture(1, 1, 1, 0.08)

    function bar:SetProgress(cur, max)
        if not max or max <= 0 then
            self.fill:SetWidth(0)
            return
        end

        local pct = math.min(cur / max, 1)
        self.fill:SetWidth((self.inner:GetWidth() - 2) * pct)
    end

    return bar
end
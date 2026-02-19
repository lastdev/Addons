local ADDON, NS = ...
NS.UI = NS.UI or {}
NS.UI.ProgressBar = {}

function NS.UI.ProgressBar:Create(parent, width)
    local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    bar:SetSize(width or 140, 8)  

    bar:SetBackdrop({
        bgFile   = "Interface/Buttons/WHITE8x8",
        edgeFile = "Interface/Buttons/WHITE8x8",
        edgeSize = 1,
    })
    bar:SetBackdropColor(0.05, 0.05, 0.06, 0.8) 
    bar:SetBackdropBorderColor(0.15, 0.15, 0.18, 0.9)  

    bar.inner = CreateFrame("Frame", nil, bar)
    bar.inner:SetPoint("TOPLEFT", 1, -1)
    bar.inner:SetPoint("BOTTOMRIGHT", -1, 1)

    bar.bg = bar.inner:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(0.10, 0.10, 0.12, 0.6)  

    bar.fill = bar.inner:CreateTexture(nil, "ARTWORK")
    bar.fill:SetPoint("LEFT", 0, 0)
    bar.fill:SetHeight(6)
    bar.fill:SetColorTexture(0.90, 0.72, 0.18, 1)

    bar.edge = bar.inner:CreateTexture(nil, "OVERLAY")
    bar.edge:SetPoint("TOPLEFT", 0, 0)
    bar.edge:SetPoint("TOPRIGHT", 0, 0)
    bar.edge:SetHeight(1)
    bar.edge:SetColorTexture(1, 1, 1, 0.12)

    function bar:SetProgress(cur, max)
        if not max or max <= 0 then
            self.fill:SetWidth(0.5)  
            return
        end

        local pct = math.min(cur / max, 1)
        local innerWidth = self.inner:GetWidth() or 1
        local w = innerWidth * pct
        if w < 0.5 then w = 0.5 end  
        self.fill:SetWidth(w)
    end

    return bar
end

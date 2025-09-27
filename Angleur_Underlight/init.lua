if C_AddOns.IsAddOnLoaded("Angleur") then
    AngleurUnderlight_AngLoaded = true
end

SLASH_ANGLEURUNDERLIGHTRESET1 = "/undangres"
SlashCmdList["ANGLEURUNDERLIGHTRESET"] = function()
    AngleurUnderlight_FirstInstall = nil
    print("Reset first install variable for: Angleur_Underlight")
end

if AngleurUnderlight_AngLoaded then return end

SLASH_ANGLEURUNDERLIGHTSHOW1 = "/undang"
SlashCmdList["ANGLEURUNDERLIGHTSHOW"] = function() 
    Angleur_Underlight_NoAngleurFrame:Show()
end

function Angleur_BetaPrint(text, ...)
    -- do nothing
end

function Angleur_BetaDump(dump)
    -- do nothing
end

function Angleur_SingleDelayer(delay, timeElapsed, elapsedThreshhold, delayFrame, cycleFunk, endFunk)
    delayFrame:SetScript("OnUpdate", function(self, elapsed)
        timeElapsed = timeElapsed + elapsed
        if timeElapsed > elapsedThreshhold then
            if cycleFunk then
                if cycleFunk() == true then
                    --print("Breaking delayer")
                    self:SetScript("OnUpdate", nil)
                    return
                end
            end
            delay = delay - timeElapsed
            timeElapsed = 0
        end
        
        if delay <= 0 then
            self:SetScript("OnUpdate", nil)
            endFunk()
            return
        end
    end)
end
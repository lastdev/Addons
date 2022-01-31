local start, boss
local pulled = false

local function handler(self, event, p1, p2)
    if event == "ENCOUNTER_START" then
        start = GetTime()
        boss = p2
        pulled = true
    end
    if event == "UNIT_TARGET" then
        if pulled and p1 == "boss1" then
            pulled = false
            local target = UnitName("boss1target") or "unknown"
            DEFAULT_CHAT_FRAME:AddMessage("Encounter " .. boss .. " started.")
            DEFAULT_CHAT_FRAME:AddMessage("First boss target is " .. target .. ".")
            DEFAULT_CHAT_FRAME:AddMessage(string.format("%.3f", GetTime()-start) .. " seconds passed since pull.")
        end
    end
end

local frame = CreateFrame("FRAME", "BossPullFrame")
frame:SetScript("OnEvent", handler)
frame:RegisterEvent("ENCOUNTER_START")
frame:RegisterEvent("UNIT_TARGET")

local __exports = LibStub:NewLibrary("ovale/states/SpellBook", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__uiLocalization.l
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.oneTimeMessage = __imports.__toolstools.oneTimeMessage
local l = __imports.l
local aceEvent = __imports.aceEvent
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local wipe = wipe
local match = string.match
local gsub = string.gsub
local concat = table.concat
local insert = table.insert
local sort = table.sort
local GetActiveSpecGroup = GetActiveSpecGroup
local GetFlyoutInfo = GetFlyoutInfo
local GetFlyoutSlotInfo = GetFlyoutSlotInfo
local GetSpellBookItemInfo = GetSpellBookItemInfo
local GetSpellInfo = GetSpellInfo
local GetSpellLink = GetSpellLink
local GetSpellTabInfo = GetSpellTabInfo
local GetSpellTexture = GetSpellTexture
local GetTalentInfo = GetTalentInfo
local HasPetSpells = HasPetSpells
local IsHarmfulSpell = IsHarmfulSpell
local IsHelpfulSpell = IsHelpfulSpell
local IsSpellKnown = IsSpellKnown
local BOOKTYPE_PET = BOOKTYPE_PET
local BOOKTYPE_SPELL = BOOKTYPE_SPELL
local MAX_TALENT_TIERS = MAX_TALENT_TIERS
local NUM_TALENT_COLUMNS = NUM_TALENT_COLUMNS
local isNumber = __imports.isNumber
local oneTimeMessage = __imports.oneTimeMessage
local parseHyperlink = function(hyperlink)
    local color, linkType, linkData, text = match(hyperlink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d*):?%d?|?h?%[?([^%[%]]*)%]?|?h?|?r?")
    return color, linkType, linkData, text
end

local outputTableValues = function(output, tbl)
    local array = {}
    for k, v in pairs(tbl) do
        insert(array, tostring(v) .. ": " .. tostring(k))
    end
    sort(array)
    for _, v in ipairs(array) do
        output[#output + 1] = v
    end
end

local output = {}
__exports.OvaleSpellBookClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug, ovaleData)
        self.ovale = ovale
        self.ovaleData = ovaleData
        self.ready = false
        self.spell = {}
        self.spellbookId = {
            [BOOKTYPE_PET] = {},
            [BOOKTYPE_SPELL] = {}
        }
        self.isHarmful = {}
        self.isHelpful = {}
        self.texture = {}
        self.talent = {}
        self.talentPoints = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", self.handleUpdate)
            self.module:RegisterEvent("CHARACTER_POINTS_CHANGED", self.handleUpdateTalents)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleUpdate)
            self.module:RegisterEvent("PLAYER_TALENT_UPDATE", self.handleUpdateTalents)
            self.module:RegisterEvent("SPELLS_CHANGED", self.handleUpdateSpells)
            self.module:RegisterEvent("UNIT_PET", self.handleUnitPet)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            self.module:UnregisterEvent("CHARACTER_POINTS_CHANGED")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_TALENT_UPDATE")
            self.module:UnregisterEvent("SPELLS_CHANGED")
            self.module:UnregisterEvent("UNIT_PET")
        end
        self.handleUnitPet = function(unitId)
            if unitId == "player" then
                self.handleUpdateSpells()
            end
        end
        self.handleUpdate = function()
            self.handleUpdateTalents()
            self.handleUpdateSpells()
            self.ready = true
        end
        self.handleUpdateTalents = function()
            self.tracer:debug("Updating talents.")
            wipe(self.talent)
            wipe(self.talentPoints)
            local activeTalentGroup = GetActiveSpecGroup()
            for i = 1, MAX_TALENT_TIERS, 1 do
                for j = 1, NUM_TALENT_COLUMNS, 1 do
                    local talentId, name, _, selected, _, _, _, _, _, _, selectedByLegendary = GetTalentInfo(i, j, activeTalentGroup)
                    if talentId then
                        local combinedSelected = selected or selectedByLegendary
                        self.talent[talentId] = name
                        if combinedSelected then
                            self.talentPoints[talentId] = 1
                        else
                            self.talentPoints[talentId] = 0
                        end
                        self.tracer:debug("    Talent %s (%d) is %s.", name, talentId, (combinedSelected and "enabled") or "disabled")
                    end
                end
            end
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_TalentsChanged")
        end
        self.handleUpdateSpells = function()
            wipe(self.spell)
            wipe(self.spellbookId[BOOKTYPE_PET])
            wipe(self.spellbookId[BOOKTYPE_SPELL])
            wipe(self.isHarmful)
            wipe(self.isHelpful)
            wipe(self.texture)
            for tab = 1, 3, 1 do
                local name, _, offset, numSpells = GetSpellTabInfo(tab)
                if name then
                    self:scanSpellBook(BOOKTYPE_SPELL, numSpells, offset)
                end
            end
            local numPetSpells = HasPetSpells()
            if numPetSpells then
                self:scanSpellBook(BOOKTYPE_PET, numPetSpells)
            end
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_SpellsChanged")
        end
        local debugOptions = {
            spellbook = {
                name = l["spellbook"],
                type = "group",
                args = {
                    spellbook = {
                        name = l["spellbook"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self:debugSpells()
                        end
                    }
                }
            },
            talent = {
                name = l["talents"],
                type = "group",
                args = {
                    talent = {
                        name = l["talents"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self:debugTalents()
                        end
                    }
                }
            }
        }
        for k, v in pairs(debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
        self.module = ovale:createModule("OvaleSpellBook", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    scanSpellBook = function(self, bookType, numSpells, offset)
        offset = offset or 0
        self.tracer:debug("Updating '%s' spellbook starting at offset %d.", bookType, offset)
        for index = offset + 1, offset + numSpells, 1 do
            local skillType, spellId = GetSpellBookItemInfo(index, bookType)
            if skillType == "SPELL" or skillType == "PETACTION" then
                local spellLink = GetSpellLink(index, bookType)
                if spellLink then
                    local _, _, linkData, spellName = parseHyperlink(spellLink)
                    local id = tonumber(linkData)
                    local name = GetSpellInfo(id)
                    if name then
                        self.spell[id] = name
                        self.isHarmful[id] = IsHarmfulSpell(index, bookType)
                        self.isHelpful[id] = IsHelpfulSpell(index, bookType)
                        self.texture[id] = GetSpellTexture(index, bookType)
                        self.spellbookId[bookType][id] = index
                        self.tracer:debug("    %s (%d) is at offset %d (%s).", name, id, index, gsub(spellLink, "|", "_"))
                        if spellId and id ~= spellId then
                            local name
                            if skillType == "PETACTION" and spellName then
                                name = spellName
                            else
                                name = GetSpellInfo(spellId)
                            end
                            if name then
                                self.spell[spellId] = name
                                self.isHarmful[spellId] = self.isHarmful[id]
                                self.isHelpful[spellId] = self.isHelpful[id]
                                self.texture[spellId] = self.texture[id]
                                self.spellbookId[bookType][spellId] = index
                                self.tracer:debug("    %s (%d) is at offset %d.", name, spellId, index)
                            end
                        end
                    end
                end
            elseif skillType == "FLYOUT" then
                local flyoutId = spellId
                local _, _, numSlots, isKnown = GetFlyoutInfo(flyoutId)
                if numSlots > 0 and isKnown then
                    for flyoutIndex = 1, numSlots, 1 do
                        local id, overrideId, isKnown, spellName = GetFlyoutSlotInfo(flyoutId, flyoutIndex)
                        if isKnown then
                            local name = GetSpellInfo(id)
                            if name then
                                self.spell[id] = name
                                self.isHarmful[id] = IsHarmfulSpell(spellName)
                                self.isHelpful[id] = IsHelpfulSpell(spellName)
                                self.texture[id] = GetSpellTexture(index, bookType)
                                self.spellbookId[bookType][id] = nil
                                self.tracer:debug("    %s (%d) is at offset %d.", name, id, index)
                            end
                            if id ~= overrideId then
                                local name = GetSpellInfo(overrideId)
                                if name then
                                    self.spell[overrideId] = name
                                    self.isHarmful[overrideId] = self.isHarmful[id]
                                    self.isHelpful[overrideId] = self.isHelpful[id]
                                    self.texture[overrideId] = self.texture[id]
                                    self.spellbookId[bookType][overrideId] = nil
                                    self.tracer:debug("    %s (%d) is at offset %d.", name, overrideId, index)
                                end
                            end
                        end
                    end
                end
            elseif  not skillType then
                break
            end
        end
    end,
    getCastTime = function(self, spellId)
        if spellId then
            local name, _, _, castTime = self:getSpellInfo(spellId)
            if name then
                if castTime then
                    castTime = castTime / 1000
                else
                    castTime = 0
                end
            else
                return nil
            end
            return castTime
        end
    end,
    getSpellInfo = function(self, spellId)
        local index, bookType = self:getSpellBookIndex(spellId)
        if index and bookType then
            return GetSpellInfo(index, bookType)
        else
            return GetSpellInfo(spellId)
        end
    end,
    getSpellName = function(self, spellId)
        local spellName = self.spell[spellId]
        if  not spellName then
            spellName = self:getSpellInfo(spellId)
        end
        return spellName
    end,
    getSpellTexture = function(self, spellId)
        return self.texture[spellId]
    end,
    getTalentPoints = function(self, talentId)
        local points = 0
        if talentId and self.talentPoints[talentId] then
            points = self.talentPoints[talentId]
        end
        return points
    end,
    addSpell = function(self, spellId, name)
        if spellId and name then
            self.tracer:debug("Adding spell %s (%d)", name, spellId)
            self.spell[spellId] = name
        end
    end,
    isHarmfulSpell = function(self, spellId)
        return (spellId and self.isHarmful[spellId] and true) or false
    end,
    isHelpfulSpell = function(self, spellId)
        return (spellId and self.isHelpful[spellId] and true) or false
    end,
    isKnownSpell = function(self, spellId)
        local isKnown = self.spell[spellId] ~= nil
        if  not isKnown then
            if spellId > 0 then
                isKnown = IsSpellKnown(spellId) or IsSpellKnown(spellId, true)
                if isKnown then
                    self.tracer:log("Spell ID '%s' is not in the spellbook, but is still known.", spellId)
                end
            end
        end
        return (isKnown and true) or false
    end,
    isKnownTalent = function(self, talentId)
        return (talentId and self.talentPoints[talentId] and true) or false
    end,
    getKnownSpellId = function(self, spell)
        if isNumber(spell) then
            return spell
        end
        local spells = self.ovaleData.buffSpellList[spell]
        if  not spells then
            oneTimeMessage("Unknown spell list " .. spell)
            return nil
        end
        for spellId in pairs(spells) do
            if self.spell[spellId] then
                return spellId
            end
        end
        return nil
    end,
    getSpellBookIndex = function(self, spellId)
        local bookType = BOOKTYPE_SPELL
        while true do
            local index = self.spellbookId[bookType][spellId]
            if index then
                return index, bookType
            elseif bookType == BOOKTYPE_SPELL then
                bookType = BOOKTYPE_PET
            else
                break
            end
        end
        return nil, nil
    end,
    isPetSpell = function(self, spellId)
        local _, bookType = self:getSpellBookIndex(spellId)
        return bookType == BOOKTYPE_PET
    end,
    debugSpells = function(self)
        wipe(output)
        outputTableValues(output, self.spell)
        local total = 0
        for _ in pairs(self.spell) do
            total = total + 1
        end
        output[#output + 1] = "Total spells: " .. total
        return concat(output, "\n")
    end,
    debugTalents = function(self)
        wipe(output)
        outputTableValues(output, self.talent)
        return concat(output, "\n")
    end,
})

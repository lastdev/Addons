local _, addon = ...
local ItemMixin = addon.namespace('ItemMixin')
local socketStats = {
    -- generic sockets
    'EMPTY_SOCKET_RED',
    'EMPTY_SOCKET_YELLOW',
    'EMPTY_SOCKET_BLUE',
    'EMPTY_SOCKET_META',
    'EMPTY_SOCKET_PRISMATIC',

    -- 11.0.7 Cyrce's Circlet
    'EMPTY_SOCKET_SINGINGSEA',
    'EMPTY_SOCKET_SINGINGTHUNDER',
    'EMPTY_SOCKET_SINGINGWIND',
}

function ItemMixin:Init(itemLink)
    self._link = itemLink
end

function ItemMixin:GetLink()
    return self._link
end

--- @return table https://warcraft.wiki.gg/wiki/ItemLink
function ItemMixin:GetLinkValues()
    if not self._linkValues then
        local _, _, itemString = string.find(self._link, '|Hitem:(.+)|h')

        self._linkValues = {strsplit(':', itemString or '')}
    end

    return self._linkValues
end

function ItemMixin:GetGemStats()
    local numGems = 0
    local values = self:GetLinkValues()

    for i = 3, 6 do
        if values[i] ~= '' then
            numGems = numGems + 1
        end
    end

    local stats = C_Item.GetItemStats(self._link)

    if stats == nil then
        return numGems, numGems -- no stats available, assume found gems match the number of sockets
    end

    local numSockets = 0

    for _, stat in pairs(socketStats) do
        numSockets = numSockets + (stats[stat] or 0)
    end

    return numGems, numSockets
end

---@return string|nil INVTYPE_X
function ItemMixin:GetInvType()
    return (select(9, C_Item.GetItemInfo(self:GetLinkValues()[1])))
end

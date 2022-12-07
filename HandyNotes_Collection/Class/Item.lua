---
--- @file
--- Methods that operate with items (links, names, transmogs etc.).
---

local _, this = ...

local API = this.API
local Cache = this.Cache
local t = this.t

local Item = {}

---
--- Gets link (formatted name) for item.
---
--- @param id
---   Item ID.
---
--- @return string
---   Item icon.
---
function Item:getLink(id)
  local link = Cache:get(id, 'itemLink')
  if (link == nil) then
    _, link = API:getItemInfo(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (link == nil) then
      return t['fetching_data']
    end

    Cache:set(id, link, 'itemLink')
  end

  return link
end

---
--- Gets icon for item.
---
--- @param id
---   Item ID.
---
--- @return string
---   Formatted item icon.
---
function Item:getIcon(id)
  local icon = Cache:get(id, 'itemIcon')
  if (icon == nil) then
    _, _, _, _, icon = API:getItemInfo(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (icon == nil) then
      return ''
    end

    -- Fix weird positioning in tooltip by moving it 1px down.
    icon = '|T' .. icon .. ':0:0:0:-1|t '
    Cache:set(id, icon, 'itemIcon')
  end

  return icon
end

---
--- Gets subtype (localized subtype name) for item.
---
--- @param id
---   Item ID.
---
--- @return string
---   The localized sub-type name of the item: Bows, Guns, Staves, etc.
---
function Item:getSubtype(id)
  local subtype = Cache:get(id, 'itemSubtype')
  if (subtype == nil) then
    _, _, _, subtype = API:getItemInfo(id)

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (subtype == nil) then
      return ''
    end

    Cache:set(id, subtype, 'itemSubtype')
  end

  return subtype
end

---
--- Checks, whether item is in players bag or not.
---
--- @param itemId
---   Item ID.
---
--- @return boolean
---   True, if player has item, false otherwise.
---
function Item:isInBag(itemId)
  for bagIndex = 0, API.BagSlots do
    for slot = 1, API:getContainerNumSlots(bagIndex) do
      if itemId == API:getContainerItemID(bagIndex, slot) then
        return true
      end
    end
  end

  return false
end

this.Item = Item

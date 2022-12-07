---
--- @file
--- Methods that operate with currencies (name, amount etc.).
---

local _, this = ...

local API = this.API
local Cache = this.Cache
local Text = this.Text
local t = this.t

local Currency = {}

---
--- Gets formatted name with icon for currency.
---
--- @param currencyId
---   Currency ID.
---
--- @return string
---   Currency icon and name.
---
function Currency:getLink(currencyId)
  local link = Cache:get(currencyId, 'currencyLink')
  if (link == nil) then
    local currency = API:getCurrencyInfo(currencyId)

    link = '|T' .. currency.icon .. ':0:0:0:-1|t ' .. Text:color(currency.name, 'white')

    -- Validate, if we got any response and send placeholder data if we didn't.
    if (currency == nil) then
      return t['fetching_data']
    end

    Cache:set(currencyId, link, 'currencyLink')
  end

  return link
end

this.Currency = Currency

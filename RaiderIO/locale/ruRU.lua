local _, ns = ...

if ns:IsSameLocale("ruRU") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "ruRU"

	--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

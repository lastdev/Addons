local _, ns = ...

if ns:IsSameLocale("frFR") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "frFR"

	--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

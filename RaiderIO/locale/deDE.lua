local _, ns = ...

if ns:IsSameLocale("deDE") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "deDE"

	--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

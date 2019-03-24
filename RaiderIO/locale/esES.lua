local _, ns = ...

if ns:IsSameLocale("esES") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "esES"

	--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

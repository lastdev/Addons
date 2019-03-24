local _, ns = ...

if ns:IsSameLocale("zhTW") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "zhTW"

	--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

local _, ns = ...

if ns:IsSameLocale("koKR") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "koKR"

	--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

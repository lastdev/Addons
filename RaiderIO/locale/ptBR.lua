local _, ns = ...

if ns:IsSameLocale("ptBR") then
	local L = ns.L or ns:NewLocale()

	L.LOCALE_NAME = "ptBR"

	--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="blank", escape-non-ascii=false, table-name="L")@

	ns.L = L
end

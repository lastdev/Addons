local _, L = ...; -- Let's use the private table passed to every .lua 

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()

if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.

	L["iconLocation"] = "Icon Location"
	L["iconLocationTT"] = "Places where on the item slot the quality icon will be placed on."
	L["iconScale"] = "Icon Scale"
	L["iconScaleTT"] = "Size factor of the icon."
	L["TOPLEFT"] = "Top Left"
	L["TOP"] = "Top"
	L["TOPRIGHT"] = "Top Right"
	L["LEFT"] = "Left"
	L["CENTER"] = "Center"
	L["RIGHT"] = "Right"
	L["BOTTOMLEFT"] = "Bottom Left"
	L["BOTTOM"] = "Bottom"
	L["BOTTOMRIGHT"] = "Bottom Right"
	L["NONE"] = NONE

return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["iconLocation"] = "Ubicación del Icono"
	L["iconLocationTT"] = "Lugares donde se colocará el icono de calidad en la ranura del objeto."
	L["iconScale"] = "Escala del Icono"
	L["iconScaleTT"] = "Factor de tamaño del icono."
	L["TOPLEFT"] = "Superior Izquierda"
	L["TOP"] = "Superior"
	L["TOPRIGHT"] = "Superior Derecha"
	L["LEFT"] = "Izquierda"
	L["CENTER"] = "Centro"
	L["RIGHT"] = "Derecha"
	L["BOTTOMLEFT"] = "Inferior Izquierda"
	L["BOTTOM"] = "Inferior"
	L["BOTTOMRIGHT"] = "Inferior Derecha"
	L["NONE"] = NONE

return end

if LOCALE == "deDE" then
	-- German translations go here
	L["iconLocation"] = "Symbolposition"
	L["iconLocationTT"] = "Positionen, an denen das Qualitätssymbol im Ausrüstungsplatz angezeigt wird."
	L["iconScale"] = "Symbolskalierung"
	L["iconScaleTT"] = "Größenfaktor des Symbols."
	L["TOPLEFT"] = "Oben Links"
	L["TOP"] = "Oben"
	L["TOPRIGHT"] = "Oben Rechts"
	L["LEFT"] = "Links"
	L["CENTER"] = "Mitte"
	L["RIGHT"] = "Rechts"
	L["BOTTOMLEFT"] = "Unten Links"
	L["BOTTOM"] = "Unten"
	L["BOTTOMRIGHT"] = "Unten Rechts"
	L["NONE"] = NONE

return end

if LOCALE == "frFR" then
	-- French translations go here
	L["iconLocation"] = "Emplacement de l’icône"
	L["iconLocationTT"] = "Emplacements où l’icône de qualité sera affichée sur l’emplacement d’objet."
	L["iconScale"] = "Échelle de l’icône"
	L["iconScaleTT"] = "Facteur de taille de l’icône."
	L["TOPLEFT"] = "En haut à gauche"
	L["TOP"] = "En haut"
	L["TOPRIGHT"] = "En haut à droite"
	L["LEFT"] = "À gauche"
	L["CENTER"] = "Centre"
	L["RIGHT"] = "À droite"
	L["BOTTOMLEFT"] = "En bas à gauche"
	L["BOTTOM"] = "En bas"
	L["BOTTOMRIGHT"] = "En bas à droite"
	L["NONE"] = NONE

return end

if LOCALE == "itIT" then
	-- French translations go here
	L["iconLocation"] = "Posizione dell’icona"
	L["iconLocationTT"] = "Luoghi in cui verrà posizionata l’icona di qualità nello slot dell’oggetto."
	L["iconScale"] = "Scala dell’icona"
	L["iconScaleTT"] = "Fattore di dimensione dell’icona."
	L["TOPLEFT"] = "In alto a sinistra"
	L["TOP"] = "In alto"
	L["TOPRIGHT"] = "In alto a destra"
	L["LEFT"] = "A sinistra"
	L["CENTER"] = "Centro"
	L["RIGHT"] = "A destra"
	L["BOTTOMLEFT"] = "In basso a sinistra"
	L["BOTTOM"] = "In basso"
	L["BOTTOMRIGHT"] = "In basso a destra"
	L["NONE"] = NONE

return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["iconLocation"] = "Local do Ícone"
	L["iconLocationTT"] = "Locais onde o ícone de qualidade será exibido no espaço do item."
	L["iconScale"] = "Escala do Ícone"
	L["iconScaleTT"] = "Fator de tamanho do ícone."
	L["TOPLEFT"] = "Superior Esquerdo"
	L["TOP"] = "Superior"
	L["TOPRIGHT"] = "Superior Direito"
	L["LEFT"] = "Esquerda"
	L["CENTER"] = "Centro"
	L["RIGHT"] = "Direita"
	L["BOTTOMLEFT"] = "Inferior Esquerdo"
	L["BOTTOM"] = "Inferior"
	L["BOTTOMRIGHT"] = "Inferior Direito"
	L["NONE"] = NONE

-- Note that the EU Portuguese WoW client also
-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["iconLocation"] = "Расположение иконки"
	L["iconLocationTT"] = "Места, где будет размещена иконка качества на ячейке предмета."
	L["iconScale"] = "Масштаб иконки"
	L["iconScaleTT"] = "Масштаб (размер) иконки."
	L["TOPLEFT"] = "Верхний левый угол"
	L["TOP"] = "Верх"
	L["TOPRIGHT"] = "Верхний правый угол"
	L["LEFT"] = "Слева"
	L["CENTER"] = "Центр"
	L["RIGHT"] = "Справа"
	L["BOTTOMLEFT"] = "Нижний левый угол"
	L["BOTTOM"] = "Низ"
	L["BOTTOMRIGHT"] = "Нижний правый угол"
	L["NONE"] = NONE

return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["iconLocation"] = "아이콘 위치"
	L["iconLocationTT"] = "품질 아이콘이 아이템 칸에 표시될 위치입니다."
	L["iconScale"] = "아이콘 크기"
	L["iconScaleTT"] = "아이콘의 크기 배율입니다."
	L["TOPLEFT"] = "왼쪽 상단"
	L["TOP"] = "상단"
	L["TOPRIGHT"] = "오른쪽 상단"
	L["LEFT"] = "왼쪽"
	L["CENTER"] = "가운데"
	L["RIGHT"] = "오른쪽"
	L["BOTTOMLEFT"] = "왼쪽 하단"
	L["BOTTOM"] = "하단"
	L["BOTTOMRIGHT"] = "오른쪽 하단"
	L["NONE"] = NONE

return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["iconLocation"] = "图标位置"
	L["iconLocationTT"] = "质量图标在物品栏位中的显示位置。"
	L["iconScale"] = "图标缩放"
	L["iconScaleTT"] = "图标的缩放大小系数。"
	L["TOPLEFT"] = "左上"
	L["TOP"] = "上方"
	L["TOPRIGHT"] = "右上"
	L["LEFT"] = "左侧"
	L["CENTER"] = "中间"
	L["RIGHT"] = "右侧"
	L["BOTTOMLEFT"] = "左下"
	L["BOTTOM"] = "下方"
	L["BOTTOMRIGHT"] = "右下"
	L["NONE"] = NONE

return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["iconLocation"] = "圖示位置"
	L["iconLocationTT"] = "品質圖示將顯示於物品欄位的哪個位置。"
	L["iconScale"] = "圖示縮放"
	L["iconScaleTT"] = "圖示的大小縮放比例。"
	L["TOPLEFT"] = "左上"
	L["TOP"] = "上方"
	L["TOPRIGHT"] = "右上"
	L["LEFT"] = "左側"
	L["CENTER"] = "中間"
	L["RIGHT"] = "右側"
	L["BOTTOMLEFT"] = "左下"
	L["BOTTOM"] = "下方"
	L["BOTTOMRIGHT"] = "右下"
	L["NONE"] = NONE

return end

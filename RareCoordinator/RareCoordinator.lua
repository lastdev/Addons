
RCDB = { }

local function onDragStart(self) self:StartMoving() end

local function onDragStop(self)
	self:StopMovingOrSizing()
	if self:GetName() == "RC" then
		RCDB.x = self:GetLeft()
		RCDB.y = self:GetTop()
		
		RCDB.width = self:GetWidth()
		RCDB.height = self:GetHeight()
	elseif self:GetName() == "RCnotify" then
		RCDB.notifyx = self:GetLeft()
		RCDB.notifyy = self:GetTop()
	end
end

local function OnDragHandleMouseDown(self) self.frame:StartSizing("BOTTOMRIGHT") end

local function OnDragHandleMouseUp(self, button) self.frame:StopMovingOrSizing() end

function onResize(self, width, height)
	local scale = width/260
	
	RCDB.width = width
	RCDB.height = height
	
	if self.RareCount ~= nil then
		height = ((self.RareCount+1)*15.6+4)*scale
		RCDB.height = height
	else
		height = 300
	end
	
	if self:GetName() == "RC" then
		self:SetHeight(height)
	end
	
	RCminimized:SetWidth(self:GetWidth())
	if self.message ~= nil then
		self.message:SetWidth(self:GetWidth())
		self.message:SetHeight(20*scale)
		self.message.text:SetFont("Fonts\\ARIALN.TTF",12*scale, "OUTLINE")
	end
	
	if self.left ~= nil then 
		self.left:SetPoint("TOPLEFT", self, 4*scale, -5*scale)
		self.left:SetHeight(height-9*scale)
		self.left:SetWidth(width/20*15)
		if self.left.text ~= nil then
			local i
			for i=0,table.getn(self.left.text) do
				self.left.text[i]:SetPoint("TOP", "RC.left", 2*scale, (-2 + -15.4*i)*scale)
				if i == 0 then
					self.left.text[i]:SetFont("Fonts\\ARIALN.TTF",12*scale,"OUTLINE")
				else
					self.left.text[i]:SetFont("Fonts\\ARIALN.TTF",12*scale)
				end
			end
		end
		if self.left.icon ~= nil then
			local i
			for i=0,table.getn(self.left.icon) do
				if i == 0 then
					self.left.icon[i]:SetPoint("TOPRIGHT", "RC.left", 6*scale, -3*scale)
					self.left.icon[i]:SetWidth(20*scale)
					self.left.icon[i]:SetHeight(20*scale)
				else
					self.left.icon[i]:SetPoint("TOPRIGHT", "RC.left", -3*scale, (-2 + -15.5*i)*scale)
					self.left.icon[i]:SetWidth(10*scale)
					self.left.icon[i]:SetHeight(10*scale)
				end
			end
		end
		if self.left.settingsicon ~= nil then
			self.left.settingsicon:SetPoint("TOPLEFT", "RC.left", 1*scale, -1*scale)
			self.left.settingsicon:SetWidth(10*scale)
			self.left.settingsicon:SetHeight(10*scale)
		end
		if self.left.minimizeicon ~= nil then
			self.left.settingsicon:SetPoint("TOPLEFT", "RC.left.minimizeicon", "TOPRIGHT", 2*scale, 0*scale)
			self.left.minimizeicon:SetWidth(10*scale)
			self.left.minimizeicon:SetHeight(10*scale)
		end
		if RCminimized.maximizeicon ~= nil then
			RCminimized.maximizeicon:SetPoint("LEFT", "RCminimized", 4*scale, 0)
			RCminimized.maximizeicon:SetWidth(10*scale)
			RCminimized.maximizeicon:SetHeight(10*scale)
		end
		if self.left.nameframe ~= nil then
			local i
			for i=1,table.getn(self.mid.button) do
				self.left.nameframe[i]:SetPoint("TOPLEFT", "RC.left", 0, -2-(15.4*i)*scale)
				self.left.nameframe[i]:SetHeight(13*scale)
				self.left.nameframe[i]:SetWidth(self.left:GetWidth())
			end
		end
		if self.left.gamett and GetCVar("uiScale") then 
			self.left.gamett:SetScale(GetCVar("uiScale"))
		end
	end
	if self.mid ~= nil then
		self.mid:SetHeight(height-9*scale)
		self.mid:SetWidth(width/20*4+4*scale)
		self.mid:SetPoint("TOPLEFT", self.left, "TOPRIGHT", 2*scale, 0)
		if self.mid.text ~= nil then
			local i
			for i=0,table.getn(self.mid.text) do
				self.mid.text[i]:SetPoint("TOP", "RC.mid", 2*scale, (-2 + -15.4*i)*scale)
				if i == 0 then
					self.mid.text[i]:SetFont("Fonts\\ARIALN.TTF",12*scale,"OUTLINE")
				else
					self.mid.text[i]:SetFont("Fonts\\ARIALN.TTF",12*scale)
				end
			end
		end
		if self.mid.button ~= nil then
			local i
			for i=0,table.getn(self.mid.button) do
				self.mid.button[i]:SetPoint("TOPLEFT", "RC.mid", 0, -2-(15.4*i)*scale)
				self.mid.button[i]:SetHeight(13*scale)
				self.mid.button[i]:SetWidth(self.mid:GetWidth())
				self.mid.button[i].icon:SetWidth(10*scale)
				self.mid.button[i].icon:SetHeight(10*scale)
			end
		end
		if self.mid.map ~= nil then 
			local i
			for i=1,table.getn(self.mid.map) do
				if i < table.getn(self.mid.map)/2 then
					self.mid.map[i]:SetPoint("TOPLEFT", "RC.mid.button["..i.."]", "TOPLEFT", 0, 0)
				else
					self.mid.map[i]:SetPoint("TOPLEFT", "RC.mid.button[1]", "TOPLEFT", 0, RC.mid:GetHeight()/2-15.4*i*scale-256/2*(341/512)*scale)
				end
				self.mid.map[i]:SetHeight(256*scale)
				self.mid.map[i]:SetWidth(256*scale)
				self.mid.map[i].text:SetFont("Fonts\\ARIALN.TTF",12*scale,"OUTLINE")
				self.mid.map[i].marker:SetHeight(10*scale)
				self.mid.map[i].marker:SetWidth(10*scale)
			end
		end
	end
	if self.right ~= nil then 
		self.right:SetHeight(height-9*scale) 
		self.right:SetWidth(width/20*4-6*scale)
		self.right:SetPoint("TOPLEFT", self.mid, "TOPRIGHT", 2*scale, 0)
		if self.right.text ~= nil then
			local i
			for i=0,table.getn(self.right.text) do
				self.right.text[i]:SetPoint("TOP", "RC.right", 2*scale, (-2 + -15.4*i)*scale)
				if i == 0 then
					self.right.text[i]:SetFont("Fonts\\ARIALN.TTF",12*scale,"OUTLINE")
				else
					self.right.text[i]:SetFont("Fonts\\ARIALN.TTF",12*scale)
				end
			end
		end
	end
end

--------------------------------

local locked = true
local optshown = false
local minimized = false
local RareIDs = {
	73174, -- Archiereus of Flame Sanctuary
	73666, -- Archiereus of Flame Summoned
	72775, -- Bufo
	73171, -- Champion of the Black Flame
	72045, -- Chelon
	73175, -- Cinderfall
	72049, -- Cranegnasher
--	71826, -- Crystal Event
	73281, -- Dread Ship Vazuvius
	73158, -- Emerald Gander
	73279, -- Evermaw
	73172, -- Flintlord Gairan
	73282, -- Garnia
	72970, -- Golganarr
	73161, -- Great Turtle Furyshell
	72909, -- Gu'chi the Swarmbringer
	73167, -- Huolon 
	73163, -- Imperial Python
	73160, -- Ironfur Steelhorn
	73169, -- Jakur of Ordon
	72193, -- Karkanos
	73277, -- Leafmender
	73166, -- Monstrous Spineclaw
	72048, -- Rattleskew
	73157, -- Rock Moss
	71864, -- Spelurk
	72769, -- Spirit of Jadefire
	73704, -- Stinkbraid 
	72808, -- Tsavo'ka
	73173, -- Urdur the Cauterizer
	73170, -- Watcher Osu
	72245, -- Zesqua
	71919 -- Zhu-Gon the Sour
	--69384  -- Luminescent Crawler - FOR TESTING ONLY
}
local RareCoords = {}
RareCoords[73174] = "next to any cauldron within Ordon Sanctuary" -- Archiereus of Flame Sanctuary
RareCoords[73666] = "on the Tree-Breeze Terrace (34/28)" -- Archiereus of Flame Summoned
RareCoords[72775] = "around 65.4 / 70.0" -- Bufo
RareCoords[73171] = "patrols between the 2 big bridges" -- Champion of the Black Flame
RareCoords[72045] = "25.3 / 35.8" -- Chelon
RareCoords[73175] = "54.0 / 52.4" -- Cinderfall
RareCoords[72049] = "44.5 / 69.0" -- Cranegnasher
--RareCoords[71826] = "47.5 / 73.5" -- Crystal Event
RareCoords[73281] = "25.8 / 23.2" -- Dread Ship Vazuvius
RareCoords[73158] = "varied spawn in the forest" -- Emerald Gander
RareCoords[73279] = "swims around the isle" -- Evermaw
RareCoords[73172] = "varied spawn around Ordon Sanctuary" -- Flintlord Gairan
RareCoords[73282] = "64.8 / 28.8" -- Garnia
RareCoords[72970] = "62.5 / 63.5" -- Golganarr
RareCoords[73161] = "varied spawn around west coast" -- Great Turtle Furyshell
RareCoords[72909] = "varied spawn around Old Pi'jiu village" -- Gu'chi the Swarmbringer
RareCoords[73167] = "varied spawn flying around the bridges" -- Huolon 
RareCoords[73163] = "varied spawn around the forests in the center area" -- Imperial Python
RareCoords[73160] = "varied spawn around the center area" -- Ironfur Steelhorn
RareCoords[73169] = "52.0 / 83.4" -- Jakur of Ordon
RareCoords[72193] = "33.9 / 85.1" -- Karkanos
RareCoords[73277] = "67.3 / 44.1" -- Leafmender
RareCoords[73166] = "varied spawn around the beach" -- Monstrous Spineclaw
RareCoords[72048] = "60.6 / 87.2" -- Rattleskew
RareCoords[73157] = "45.4 / 29.4" -- Rock Moss
RareCoords[71864] = "59.0 / 48.8" -- Spelurk
RareCoords[72769] = "45.4 / 38.9" -- Spirit of Jadefire
RareCoords[73704] = "71.5 / 80.7" -- Stinkbraid 
RareCoords[72808] = "54.6 / 44.3" -- Tsavo'ka
RareCoords[73173] = "45.4 / 26.6" -- Urdur the Cauterizer
RareCoords[73170] = "57.5 / 77.1" -- Watcher Osu
RareCoords[72245] = "47.6 / 87.3" -- Zesqua
RareCoords[71919] = "37.4 / 77.4" -- Zhu-Gon the Sour

local RareCoordsRaw = {}
RareCoordsRaw[73174] = {x=49.7, y=22.2} -- Archiereus of Flame Sanctuary
RareCoordsRaw[73666] = {x=34.9, y=28.9} -- Archiereus of Flame Summoned
RareCoordsRaw[72775] = {x=65.4, y=70.0} -- Bufo
RareCoordsRaw[73171] = {x=0, y=0} -- Champion of the Black Flame
RareCoordsRaw[72045] = {x=25.3, y=35.8} -- Chelon
RareCoordsRaw[73175] = {x=54.0, y=52.4} -- Cinderfall
RareCoordsRaw[72049] = {x=44.5, y=69.0} -- Cranegnasher
--RareCoordsRaw[71826] = {x=47.5, y=73.5} -- Crystal Event
RareCoordsRaw[73281] = {x=25.8, y=23.2} -- Dread Ship Vazuvius
RareCoordsRaw[73158] = {x=0, y=0} -- Emerald Gander
RareCoordsRaw[73279] = {x=0, y=0} -- Evermaw
RareCoordsRaw[73172] = {x=0, y=0} -- Flintlord Gairan
RareCoordsRaw[73282] = {x=64.8, y=28.8} -- Garnia
RareCoordsRaw[72970] = {x=62.5, y=63.5} -- Golganarr
RareCoordsRaw[73161] = {x=0, y=0} -- Great Turtle Furyshell
RareCoordsRaw[72909] = {x=0, y=0} -- Gu'chi the Swarmbringer
RareCoordsRaw[73167] = {x=0, y=0} -- Huolon 
RareCoordsRaw[73163] = {x=0, y=0} -- Imperial Python
RareCoordsRaw[73160] = {x=0, y=0} -- Ironfur Steelhorn
RareCoordsRaw[73169] = {x=52.0, y=83.4} -- Jakur of Ordon
RareCoordsRaw[72193] = {x=33.9, y=85.1} -- Karkanos
RareCoordsRaw[73277] = {x=67.3, y=44.1} -- Leafmender
RareCoordsRaw[73166] = {x=0, y=0} -- Monstrous Spineclaw
RareCoordsRaw[72048] = {x=60.6, y=87.2} -- Rattleskew
RareCoordsRaw[73157] = {x=45.4, y=29.4} -- Rock Moss
RareCoordsRaw[71864] = {x=59.0, y=48.8} -- Spelurk
RareCoordsRaw[72769] = {x=45.4, y=38.9} -- Spirit of Jadefire
RareCoordsRaw[73704] = {x=71.5, y=80.7} -- Stinkbraid 
RareCoordsRaw[72808] = {x=54.6, y=44.3} -- Tsavo'ka
RareCoordsRaw[73173] = {x=45.4, y=26.6} -- Urdur the Cauterizer
RareCoordsRaw[73170] = {x=57.5, y=77.1} -- Watcher Osu
RareCoordsRaw[72245] = {x=47.6, y=87.3} -- Zesqua
RareCoordsRaw[71919] = {x=37.4, y=77.4} -- Zhu-Gon the Sour

local RareNamesLocalized = {};
RareNamesLocalized['enUS'] = {}
RareNamesLocalized['enUS'][73174] = "Archiereus of Flame (Sanctuary)" 
RareNamesLocalized['enUS'][73666] = "Archiereus of Flame (Summoned)"
RareNamesLocalized['enUS'][72775] = "Bufo"
RareNamesLocalized['enUS'][73171] = "Champion of the Black Flame"
RareNamesLocalized['enUS'][72045] = "Chelon"
RareNamesLocalized['enUS'][73175] = "Cinderfall"
RareNamesLocalized['enUS'][72049] = "Cranegnasher"
--RareNamesLocalized['enUS'][71826] = "Crystal Event"
RareNamesLocalized['enUS'][73281] = "Dread Ship Vazuvius"
RareNamesLocalized['enUS'][73158] = "Emerald Gander"
RareNamesLocalized['enUS'][73279] = "Evermaw"
RareNamesLocalized['enUS'][73172] = "Flintlord Gairan"
RareNamesLocalized['enUS'][73282] = "Garnia"
RareNamesLocalized['enUS'][72970] = "Golganarr"
RareNamesLocalized['enUS'][73161] = "Great Turtle Furyshell"
RareNamesLocalized['enUS'][72909] = "Gu'chi the Swarmbringer"
RareNamesLocalized['enUS'][73167] = "Huolon"
RareNamesLocalized['enUS'][73163] = "Imperial Python"
RareNamesLocalized['enUS'][73160] = "Ironfur Steelhorn"
RareNamesLocalized['enUS'][73169] = "Jakur of Ordon"
RareNamesLocalized['enUS'][72193] = "Karkanos"
RareNamesLocalized['enUS'][73277] = "Leafmender"
RareNamesLocalized['enUS'][73166] = "Monstrous Spineclaw"
RareNamesLocalized['enUS'][72048] = "Rattleskew"
RareNamesLocalized['enUS'][73157] = "Rock Moss"
RareNamesLocalized['enUS'][71864] = "Spelurk"
RareNamesLocalized['enUS'][72769] = "Spirit of Jadefire"
RareNamesLocalized['enUS'][73704] = "Stinkbraid "
RareNamesLocalized['enUS'][72808] = "Tsavo'ka"
RareNamesLocalized['enUS'][73173] = "Urdur the Cauterizer"
RareNamesLocalized['enUS'][73170] = "Watcher Osu"
RareNamesLocalized['enUS'][72245] = "Zesqua"
RareNamesLocalized['enUS'][71919] = "Zhu-Gon the Sour"
--RareNamesLocalized['enUS'][69384] = "Luminescent Crawler"
RareNamesLocalized['deDE'] = {}
RareNamesLocalized['deDE'][73174] = "Archiereus der Flamme (Heiligtum)"
RareNamesLocalized['deDE'][73666] = "Archiereus der Flamme (Beschworen)"
RareNamesLocalized['deDE'][72775] = "Bufo"
RareNamesLocalized['deDE'][73171] = "Champion der Schwarzen Flamme"
RareNamesLocalized['deDE'][72045] = "Chelon"
RareNamesLocalized['deDE'][73175] = "Glutfall"
RareNamesLocalized['deDE'][72049] = "Kranichknirscher"
--RareNamesLocalized['deDE'][71826] = "Kristall Event"
RareNamesLocalized['deDE'][73281] = "Schreckensschiff Vazuvius"
RareNamesLocalized['deDE'][73158] = "Smaragdkranich"
RareNamesLocalized['deDE'][73279] = "Tiefenschlund"
RareNamesLocalized['deDE'][73172] = "Funkenlord Gairan"
RareNamesLocalized['deDE'][73282] = "Garnia"
RareNamesLocalized['deDE'][72970] = "Golganarr"
RareNamesLocalized['deDE'][73161] = "Großschildkröte Zornpanzer"
RareNamesLocalized['deDE'][72909] = "Gu'chi der Schwarmbringer"
RareNamesLocalized['deDE'][73167] = "Huolon"
RareNamesLocalized['deDE'][73163] = "Kaiserpython"
RareNamesLocalized['deDE'][73160] = "Eisenfellstahlhorn"
RareNamesLocalized['deDE'][73169] = "Jakur von Ordos"
RareNamesLocalized['deDE'][72193] = "Karkanos"
RareNamesLocalized['deDE'][73277] = "Blattheiler"
RareNamesLocalized['deDE'][73166] = "Monströse Dornzange"
RareNamesLocalized['deDE'][72048] = "Klapperknochen"
RareNamesLocalized['deDE'][73157] = "Steinmoos"
RareNamesLocalized['deDE'][71864] = "Spelurk"
RareNamesLocalized['deDE'][72769] = "Jadefeuergeist"
RareNamesLocalized['deDE'][73704] = "Stinkezopf"
RareNamesLocalized['deDE'][72808] = "Tsavo'ka"
RareNamesLocalized['deDE'][73173] = "Urdur der Kauterisierer"
RareNamesLocalized['deDE'][73170] = "Behüter Osu"
RareNamesLocalized['deDE'][72245] = "Zesqua"
RareNamesLocalized['deDE'][71919] = "Zhu-Gon der Saure"
RareNamesLocalized['esES'] = {}
RareNamesLocalized['esES'][73174] = "Sacerdote i.d.l. llamas (Sanctuaire)"
RareNamesLocalized['esES'][73666] = "Sacerdote i.d.l. llamas (Invocado)"
RareNamesLocalized['esES'][72775] = "Buffo"
RareNamesLocalized['esES'][73171] = "Campeón de la Llama Negra"
RareNamesLocalized['esES'][72045] = "Quelón"
RareNamesLocalized['esES'][73175] = "Carbonos"
RareNamesLocalized['esES'][72049] = "Mascagrullas"
RareNamesLocalized['esES'][73281] = "Barco aterrador Vazuvius"
RareNamesLocalized['esES'][73158] = "Ganso esmeralda"
RareNamesLocalized['esES'][73279] = "Fauce Eterna"
RareNamesLocalized['esES'][73172] = "Señor del sílex Gairan"
RareNamesLocalized['esES'][73282] = "Garnia"
RareNamesLocalized['esES'][72970] = "Golganarr"
RareNamesLocalized['esES'][73161] = "Gran tortuga Irazón"
RareNamesLocalized['esES'][72909] = "Gu'chi el Portaenjambres"
RareNamesLocalized['esES'][73167] = "Huolon"
RareNamesLocalized['esES'][73163] = "Pitón imperial"
RareNamesLocalized['esES'][73160] = "Astado acerado Cueracero"
RareNamesLocalized['esES'][73169] = "Jakur el Ordon"
RareNamesLocalized['esES'][72193] = "Karkanos"
RareNamesLocalized['esES'][73277] = "Sanador de hojas"
RareNamesLocalized['esES'][73166] = "Pinzaespina monstruoso"
RareNamesLocalized['esES'][72048] = "Ossotremulus"
RareNamesLocalized['esES'][73157] = "Musgo de roca"
RareNamesLocalized['esES'][71864] = "Espectrante"
RareNamesLocalized['esES'][72769] = "Espíritu de fuego de jade"
RareNamesLocalized['esES'][73704] = "Barbasucia"
RareNamesLocalized['esES'][72808] = "Tsavo'ka"
RareNamesLocalized['esES'][73173] = "Urdur el Cauterizador"
RareNamesLocalized['esES'][73170] = "Vigía Osu"
RareNamesLocalized['esES'][72245] = "Zesqua"
RareNamesLocalized['esES'][71919] = "Zhu Gon el Agrio"
RareNamesLocalized['frFR'] = {}
RareNamesLocalized['frFR'][73174] = "Archiprêtre de flammes (sanctuaire)"
RareNamesLocalized['frFR'][73666] = "Archiprêtre de flammes (convoqué)"
RareNamesLocalized['frFR'][72775] = "Bufo"
RareNamesLocalized['frFR'][73171] = "Champion de la flamme noire"
RareNamesLocalized['frFR'][72045] = "Chelon"
RareNamesLocalized['frFR'][73175] = "Cendrechute"
RareNamesLocalized['frFR'][72049] = "Croque-grue"
RareNamesLocalized['frFR'][73281] = "Bateau de l’effroi Vazuvius"
RareNamesLocalized['frFR'][73158] = "Jars émeraude"
RareNamesLocalized['frFR'][73279] = "Gueule-Éternelle"
RareNamesLocalized['frFR'][73172] = "Seigneur des silex Gairan"
RareNamesLocalized['frFR'][73282] = "Garnia"
RareNamesLocalized['frFR'][72970] = "Golganarr"
RareNamesLocalized['frFR'][73161] = "Grande tortue Écaille-de-Fureur"
RareNamesLocalized['frFR'][72909] = "Gu’chi l’Essaimeur"
RareNamesLocalized['frFR'][73167] = "Huolon"
RareNamesLocalized['frFR'][73163] = "Python impérial"
RareNamesLocalized['frFR'][73160] = "Corne-d’acier ferpoil"
RareNamesLocalized['frFR'][73169] = "Jakur d’Ordos"
RareNamesLocalized['frFR'][72193] = "Karkanos"
RareNamesLocalized['frFR'][73277] = "Soigne-Feuille"
RareNamesLocalized['frFR'][73166] = "Pincépine monstrueux"
RareNamesLocalized['frFR'][72048] = "Déglingois"
RareNamesLocalized['frFR'][73157] = "Mousse des rochers"
RareNamesLocalized['frFR'][71864] = "Souterrant"
RareNamesLocalized['frFR'][72769] = "Esprit de Jadefeu"
RareNamesLocalized['frFR'][73704] = "Fouettnatte"
RareNamesLocalized['frFR'][72808] = "Tsavo’ka"
RareNamesLocalized['frFR'][73173] = "Urdur le Cautérisateur"
RareNamesLocalized['frFR'][73170] = "Guetteur Osu"
RareNamesLocalized['frFR'][72245] = "Zesqua"
RareNamesLocalized['frFR'][71919] = "Zhu Gon l’Amer"
RareNamesLocalized['ruRU'] = {}
RareNamesLocalized['ruRU'][73174] = "Архиерей пламени (святилище)"
RareNamesLocalized['ruRU'][73666] = "Архиерей пламени (вызванный)"
RareNamesLocalized['ruRU'][72775] = "Буфо"
RareNamesLocalized['ruRU'][73171] = "Защитник Черного Пламени"
RareNamesLocalized['ruRU'][72045] = "Шелон"
RareNamesLocalized['ruRU'][73175] = "Пеплопад"
RareNamesLocalized['ruRU'][72049] = "Журавлецап"
RareNamesLocalized['ruRU'][73281] = "Проклятый корабль Вазувий"
RareNamesLocalized['ruRU'][73158] = "Изумрудный гусак"
RareNamesLocalized['ruRU'][73279] = "Вечножор"
RareNamesLocalized['ruRU'][73172] = "Повелитель кремня Гайран"
RareNamesLocalized['ruRU'][73282] = "Гарния"
RareNamesLocalized['ruRU'][72970] = "Голганарр"
RareNamesLocalized['ruRU'][73161] = "Большая черепаха"
RareNamesLocalized['ruRU'][72909] = "Гу'чи Зовущий Рой"
RareNamesLocalized['ruRU'][73167] = "Хулон "
RareNamesLocalized['ruRU'][73163] = "Императорский питон"
RareNamesLocalized['ruRU'][73160] = "Твердорогий сталемех"
RareNamesLocalized['ruRU'][73169] = "Якур Ордосский"
RareNamesLocalized['ruRU'][72193] = "Карканос"
RareNamesLocalized['ruRU'][73277] = "Целитель листвы"
RareNamesLocalized['ruRU'][73166] = "Огромный хребтохват"
RareNamesLocalized['ruRU'][72048] = "Косохрип"
RareNamesLocalized['ruRU'][73157] = "Пещерный Мох"
RareNamesLocalized['ruRU'][71864] = "Чароброд"
RareNamesLocalized['ruRU'][72769] = "Дух Нефритового Пламени"
RareNamesLocalized['ruRU'][73704] = "Вонекос "
RareNamesLocalized['ruRU'][72808] = "Тсаво'ка"
RareNamesLocalized['ruRU'][73173] = "Урдур Прижигатель"
RareNamesLocalized['ruRU'][73170] = "Смотритель Осу"
RareNamesLocalized['ruRU'][72245] = "Зесква"
RareNamesLocalized['ruRU'][71919] = "Чжу-Гонь Прокисший"
RareNamesLocalized['ptBR'] = {}
RareNamesLocalized['ptBR'][73174] = "Bispo das Chamas (Santuário)" 
RareNamesLocalized['ptBR'][73666] = "Bispo das Chamas (Evocado)"
RareNamesLocalized['ptBR'][72775] = "Bufo"
RareNamesLocalized['ptBR'][73171] = "Campeão da Chama Negra"
RareNamesLocalized['ptBR'][72045] = "Chelon"
RareNamesLocalized['ptBR'][73175] = "Chuva de Cinzas"
RareNamesLocalized['ptBR'][72049] = "Mastigarça"
--RareNamesLocalized['ptBR'][71826] = "Evento do Cristal"
RareNamesLocalized['ptBR'][73281] = "Navio Fantasma Vazúvio"
RareNamesLocalized['ptBR'][73158] = "Ganso Esmeralda"
RareNamesLocalized['ptBR'][73279] = "Bocarra"
RareNamesLocalized['ptBR'][73172] = "Gairan, o Senhor da Centelha"
RareNamesLocalized['ptBR'][73282] = "Garnia"
RareNamesLocalized['ptBR'][72970] = "Golganarr"
RareNamesLocalized['ptBR'][73161] = "Grande Tartaruga Cascofúria"
RareNamesLocalized['ptBR'][72909] = "Gu'chi, o Arauto do Enxame"
RareNamesLocalized['ptBR'][73167] = "Huolon"
RareNamesLocalized['ptBR'][73163] = "Píton Imperial"
RareNamesLocalized['ptBR'][73160] = "Chifreaço Veloférreo"
RareNamesLocalized['ptBR'][73169] = "Jakur de Ordon"
RareNamesLocalized['ptBR'][72193] = "Karkanos"
RareNamesLocalized['ptBR'][73277] = "Remenda-folhas"
RareNamesLocalized['ptBR'][73166] = "Garrespinha Monstruoso"
RareNamesLocalized['ptBR'][72048] = "Chiadeira"
RareNamesLocalized['ptBR'][73157] = "Musgo Rochoso"
RareNamesLocalized['ptBR'][71864] = "Spelurk"
RareNamesLocalized['ptBR'][72769] = "Espírito de Flamejade"
RareNamesLocalized['ptBR'][73704] = "Trança-fétida "
RareNamesLocalized['ptBR'][72808] = "Tsavo'ka"
RareNamesLocalized['ptBR'][73173] = "Urdur, o Cauterizador"
RareNamesLocalized['ptBR'][73170] = "Vigia Osu"
RareNamesLocalized['ptBR'][72245] = "Zesqua"
RareNamesLocalized['ptBR'][71919] = "Zhu-Gon, o Azedo"


-- Going To Need A Bigger Bag Asset IDs
BiggerBagAssetIDs = {}
BiggerBagAssetIDs[73174] = 86574 --Archiereus of Flame (Sanctuary)
BiggerBagAssetIDs[73666] = 86574 --Archiereus of Flame (Summoned)
BiggerBagAssetIDs[72775] = 104169 --Bufo
BiggerBagAssetIDs[73171] = 104302 --Champion of the Black Flame
BiggerBagAssetIDs[72045] = 86584 --Chelon
BiggerBagAssetIDs[73175] = 104299 --Cinderfall
BiggerBagAssetIDs[72049] = 104268 --Cranegnasher
BiggerBagAssetIDs[73281] = 104294 --Dread Ship Vazuvius
BiggerBagAssetIDs[73158] = 104287 --Emerald Gander
--BiggerBagAssetIDs[73279] =  --Evermaw < he drops nothing for the av
BiggerBagAssetIDs[73172] = 104298 --Flintlord Gairan
BiggerBagAssetIDs[73282] = 104159 --Garnia
BiggerBagAssetIDs[72970] = 104262 --Golganarr
BiggerBagAssetIDs[73161] = 86584 --Great Turtle Furyshell
BiggerBagAssetIDs[72909] = 104291 --Gu'chi the Swarmbringer
BiggerBagAssetIDs[73167] = 104269 --Huolon
BiggerBagAssetIDs[73163] = 104161 --Imperial Python
--BiggerBagAssetIDs[73160] =  --Ironfur Steelhorn < nothing
BiggerBagAssetIDs[73169] = 104331 --Jakur of Ordon
BiggerBagAssetIDs[72193] = 104035 --Karkanos
BiggerBagAssetIDs[73277] = 104156 --Leafmender
BiggerBagAssetIDs[73166] = 104168 --Monstrous Spineclaw
BiggerBagAssetIDs[72048] = 104321 --Rattleskew
BiggerBagAssetIDs[73157] = 104313 --Rock Moss
BiggerBagAssetIDs[71864] = 104320 --Spelurk
BiggerBagAssetIDs[72769] = 104307 --Spirit of Jadefire
--BiggerBagAssetIDs[73704] =  --Stinkbraid 
BiggerBagAssetIDs[72808] = 104268 --Tsavo'ka
BiggerBagAssetIDs[73173] = 104306 --Urdur the Cauterizer
BiggerBagAssetIDs[73170] = 104305 --Watcher Osu
BiggerBagAssetIDs[72245] = 104303 --Zesqua
BiggerBagAssetIDs[71919] = 104167 --Zhu-Gon th



local SoundsToPlay = {}
SoundsToPlay['none'] = ""
SoundsToPlay['DIIING'] = "sound\\CREATURE\\MANDOKIR\\VO_ZG2_MANDOKIR_LEVELUP_EVENT_01.ogg"
SoundsToPlay['You are not prepared!'] = "sound\\Creature\\Illidan\\BLACK_Illidan_04.wav"
--SoundsToPlay['Plaaaytime'] = "Sound\\Creature\\Meathook\\CS_Meathook_Spawn.wav"
--SoundsToPlay['Intruder alert'] = "Sound\\Creature\\MobileAlertBot\\MobileAlertBotIntruderAlert01.wav"
SoundsToPlay['BG win soon'] = "Sound\\Interface\\PVPWarningHordeMono.wav"
SoundsToPlay['Flag taken'] = "Sound\\Interface\\PVPFlagTakenMono.wav"
SoundsToPlay['Raid Warning'] = "Sound\\interface\\RaidWarning.wav"
SoundsToPlay['Calm drums'] = "Sound\\interface\\ReadyCheck.wav"


local RareSeen = {}
local RareKilled = {}
local RareAlive = {}
local RareAliveHP = {}
local RareAnnounced = {}
local RareAnnouncedSelf = {}
local RareNotified = {}
local VignetteNotified = {}
local LastSent = {}
local RareAv = {}
local SoundPlayed = {}

--local SoundPlayed = 0
local VersionNotify = false
local myChan = false
local chanchecked = 0

local txt = ""
local currentWaypointX = false
local currentWaypointY = false
local currentWaypointNPCID = false
local Waypoints = {}
local currentLocation = {}

local needStatus = false

-------------------------------
local RC = CreateFrame("Frame", "RC", UIParent)
RC.version = "6.0.2-2"
RC.isAlpha = false
RC.RareCount = #RareIDs

function RC:getLocalRareName(id)
	if RareNamesLocalized[GetLocale()] ~= nil then
		if RareNamesLocalized[GetLocale()][id] ~= nil then
			return RareNamesLocalized[GetLocale()][id]
		end
	end
	if RareNamesLocalized['enUS'][id] ~= nil then
		return RareNamesLocalized['enUS'][id]
	else
		return "Unkown Name"
	end
end

function RC:getTargetPercentHP()
	local currhp = UnitHealth("target")
	local maxhp = UnitHealthMax("target")
	if currhp == 0 and maxhp == 0 then
		return false
	else
		return math.floor(currhp/maxhp * 100) 
	end
end

function RC:getTargetPercentHProunded()
	local per = self:getTargetPercentHP()
	if per then
		return math.floor(per/10)*10
	else
		return false
	end
end

function RC:setWaypoint(id, x, y)
	if TomTom ~= nil and RCDB.tomtom then
		if not RC:IsIgnoredRareID(id) then
			--print(id,x,y)
			if x == nil or y == nil then
				if RareCoordsRaw[id]["x"] ~= 0 and RareCoordsRaw[id]["y"] ~= 0 then
					if Waypoints[id] ~= nil then
						self:removeWaypoint(id)
					end
					Waypoints[id] = TomTom:AddWaypoint(RareCoordsRaw[id]["x"],RareCoordsRaw[id]["y"],self:getLocalRareName(id))
				end
			elseif x ~= nil and y ~= nil then
				if Waypoints[id] ~= nil then
					self:removeWaypoint(id)
				end
				Waypoints[id] = TomTom:AddWaypoint(x,y,self:getLocalRareName(id))
				--print("SetWaypoint to "..x..","..y)
			end
		end
	end
	if id ~= nil and x ~= nil and y ~= nil then
		currentLocation[id] = {x = x, y = y}
	end
end

function RC:removeWaypoint(id)
	if Waypoints[id] ~= nil then
		TomTom:RemoveWaypoint(Waypoints[id])
	end
	if currentLocation[id] ~= nil and RareAlive[id] == nil then
		currentLocation[id] = nil
	end
end

function RC:removeAllWaypoints()
	for k,v in pairs(Waypoints) do
		TomTom:RemoveWaypoint(v)
	end
end

function RC:getRelevantRareTime(id)
	if RareAlive[id] ~= nil then
		return 0
	end
	if RareSeen[id] == nil and RareKilled[id] == nil then
		return time()
	end
	if RareSeen[id] ~= nil and RareKilled[id] == nil then
		return RareSeen[id]
	end
	if RareSeen[id] == nil and RareKilled[id] ~= nil then
		return RareKilled[id]
	end
	if tonumber(RareSeen[id])-tonumber(RareKilled[id]) > 33*60 then
		return RareSeen[id]
	end
	return RareKilled[id]
end

function RC:getRealRareTime(id)
	if RareAlive[id] ~= nil then
		return true
	end
	if RareSeen[id] == nil and RareKilled[id] == nil then
		return false
	end
	if RareSeen[id] ~= nil and RareKilled[id] == nil then
		return RareSeen[id]
	end
	if RareSeen[id] == nil and RareKilled[id] ~= nil then
		return RareKilled[id]
	end
	if tonumber(RareSeen[id])-tonumber(RareKilled[id]) > 30*60 then
		return RareSeen[id]
	end
	return RareKilled[id]
end

function RC:createSortedTable(alphabetical)
	local sorted = {}
	local i
	
	if RC.IsIgnoredRareID == nil then
		for i=1, #RareIDs do
			table.insert(sorted,{id=RareIDs[i], t=tonumber(self:getRelevantRareTime(RareIDs[i])), name=(self:getLocalRareName(RareIDs[i]))})
		end
		return sorted
	end

	for i=1, #RareIDs do
		if self:IsIgnoredRareID(RareIDs[i]) == false then 
			table.insert(sorted,{id=RareIDs[i], t=tonumber(self:getRelevantRareTime(RareIDs[i])), name=(self:getLocalRareName(RareIDs[i]))})
		end
	end

	if alphabetical then
		sort(sorted, function(a,b) return a.name<b.name end)
	else
		sort(sorted, function(a,b) return a.t<b.t end)
	end
	
	--for k,v in pairs(sorted) do
	--	print(self:getLocalRareName(v.id).."-"..(time()-v.t)/60)
	--end
	return sorted
end



local function OnMouseDownAnnounce(id)
	if RareAnnounced[id] == nil then
		if RareAliveHP[id] == nil then
			SendChatMessage("[RareCoordinator] "..RC:getLocalRareName(id)..": "..RareCoords[id].."", "CHANNEL", nil, 1)
		else
			SendChatMessage("[RareCoordinator] "..RC:getLocalRareName(id).." ("..RareAliveHP[id].."%): "..RareCoords[id].."", "CHANNEL", nil, 1)
		end
		SendChatMessage("[RCELVA]"..RC.version.."_"..id.."_announce_"..time().."_", "CHANNEL", nil, RC:getChanID(GetChannelList()))
		RareAnnounced[id] = time()
		RareAnnouncedSelf[id] = time()
	end
end

local function ShowMap(id)
	if RC ~= nil and RC.mid ~= nil and RC.mid.map ~= nil and RC.mid.map[id] ~= nil then
		RC.mid.map[id].map:SetTexture("Interface\\AddOns\\RareCoordinator\\imgs\\"..GetCurrentMapAreaID().."\\map.tga")
		if RCDB.sort then
			local sorted = RC:createSortedTable(false)
			RC.mid.map[id].overlay:SetTexture("Interface\\AddOns\\RareCoordinator\\imgs\\"..GetCurrentMapAreaID().."\\"..sorted[id].id..".tga")
			RC.mid.map[id].text:SetText(RC:getLocalRareName(sorted[id].id))
			
			if currentLocation[sorted[id].id] then
				RC.mid.map[id].marker:SetPoint("TOPLEFT", "RC.mid.map["..id.."]", "TOPLEFT", currentLocation[sorted[id].id].x/100*RC.mid.map[id]:GetWidth()-5, -currentLocation[sorted[id].id].y/100*RC.mid.map[id]:GetHeight()*341/512+5)
				RC.mid.map[id].marker:Show()
			else
				RC.mid.map[id].marker:Hide()
			end
		else
			RC.mid.map[id].overlay:SetTexture("Interface\\AddOns\\RareCoordinator\\imgs\\"..GetCurrentMapAreaID().."\\"..RareIDs[id]..".tga")
			RC.mid.map[id].text:SetText(RC:getLocalRareName(RareIDs[id]))
		end
		RC.mid.map[id]:Show()	
	end
end

local function HideMap(id)
	if RC ~= nil and RC.mid ~= nil and RC.mid.map ~= nil and RC.mid.map[id] ~= nil then
		RC.mid.map[id]:Hide()	
	end
end

local function ShowTooltip(tt, owner)
	tt:SetOwner(owner, "ANCHOR_BOTTOMRIGHT", 0, 0)
	if RCDB.biggerbag then
		tt:SetHyperlink(GetAchievementLink(8728))
	else
		tt:SetHyperlink(GetAchievementLink(8714))
	end
end

local function HideTooltip(tt)
	tt:Hide()
end

local function OnMouseDownTarget(id)
	print("Target")
end

local function OptShowOrHide()
	if optshown then
		RC.opt:Hide()
		optshown = false
	else
		RC.opt:Show()
		UIDropDownMenu_SetText(RC.opt.sound.dropdown, RCDB.sound)
		if locked then
			RC.opt.locked.status:SetText("Frame is |cffff0000locked")
			RC.opt.locked.button:SetText("unlock")
		else
			RC.opt.locked.status:SetText("Frame is |cff00ff00unlocked")
			RC.opt.locked.button:SetText("lock")
		end
		optshown = true
	end
end

local function MinMaximize()
	if minimized then
		RC:Show()
		RCminimized:Hide()
		minimized = false
	else
		RC:Hide()
		RCminimized:Show()
		minimized = true
	end
end

local function RCPlaySoundFile(f, channel)
	if f ~= nil then
		PlaySoundFile(f, channel)
	end
end

local function IsInXRealmGrp()
	local n = GetNumGroupMembers()
	if n == 0 then
		return false
	end
	local xrealmmemberfound = false
	local i = 0
	if IsInRaid() then
		for i=1, n do
			if UnitExists("raid"..i) then
				--local _, realm = UnitName("raid"..i)
				--if realm ~= nil and strlen(realm) > 0 then
				--	xrealmmemberfound = true
				--end
				local realmRelationship = UnitRealmRelationship("raid"..i)
				if realmRelationship == LE_REALM_RELATION_COALESCED then
					xrealmmemberfound = true
				end
			end
		end
		if xrealmmemberfound then
			return true
		else
			return false
		end
	end
	xrealmmemberfound = false
	if IsInGroup() then
		for i=1, n do
			if UnitExists("party"..i) then
				local _, realm = UnitName("party"..i)
				if realm ~= nil and strlen(realm) > 0 then
					xrealmmemberfound = true
				end
			end
		end
		if xrealmmemberfound then
			return true
		else
			return false
		end
	end
end

--- Returns HEX representation of num
--- credits to http://snipplr.com/view/13086/
function num2hex(num)
	local hexstr = '0123456789abcdef'
	local s = ''
	while num > 0 do
		local mod = math.fmod(num, 16)
		s = string.sub(hexstr, mod+1, mod+1) .. s
		num = math.floor(num / 16)
	end
	if s == '' then s = '0' end
	return s
end

local function getNicePlayerPosition()
	local x,y = GetPlayerMapPosition("player")
	x = math.floor(x*100+0.5)
	y = math.floor(y*100+0.5)
	return x,y
end

local function getFormattedCurrentPlayerPosition()
	local x,y = getNicePlayerPosition()
	return ","..x.."-"..y
end

local function ColorfulTime(m)
	if RCDB.colorize == false then
		return m.."m"
	end
	
	if m > 45 then
		return "|cffff0000"..m.."m"
	elseif m < 0 then
		return "-"
	elseif m < 25 then
		return m.."m"
	else
		local color = num2hex(204/20*(45-m))
		if strlen(color) == 1 then color = "0"..color end
		return "|cffff"..color.."00"..m.."m"
		--return m
	end
end

local function GetRareIDsforAssetID(assetid)
	local t = {}
	local atleastoneassetid = false
	for rareid,v in pairs(BiggerBagAssetIDs) do
		if assetid == v then
			table.insert(t, rareid)
			atleastoneassetid = true
		end
	end
	if atleastoneassetid then
		return t
	else
		return false
	end
end

RC:SetWidth(300)
RC:SetHeight(200)
RC:SetFrameStrata("BACKGROUND")
RC:SetPoint("CENTER",0,0)
RC:SetClampedToScreen(true)
RC:SetMinResize(150, 0)
RC:SetMaxResize(500, 0)

RC.texture = RC:CreateTexture(nil,"BACKGROUND")
RC.texture:SetTexture(0,0,0,0.4)
RC.texture:SetAllPoints(RC)


RC.left = CreateFrame("Frame", "RC.left", RC)
RC.left:SetWidth(200)
RC.left:SetHeight(RC:GetHeight()-9)
RC.left:SetPoint("TOPLEFT", RC, 5, -5)
RC.left.texture = RC:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.left.texture:SetTexture(0,0,0,0.2)
RC.left.texture:SetAllPoints(RC.left)

RC.mid = CreateFrame("Frame", "RC.mid", RC)
RC.mid:SetWidth(100)
RC.mid:SetHeight(RC:GetHeight()-9)
RC.mid:SetPoint("TOPLEFT", RC.left, "TOPRIGHT", 2, 0)
RC.mid.texture = RC:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.mid.texture:SetTexture(0,0,0,0.2)
RC.mid.texture:SetAllPoints(RC.mid)

--RC.right = CreateFrame("Frame", "RC.right", RC)
--RC.right:SetWidth(80)
--RC.right:SetHeight(RC:GetHeight()-9)
--RC.right:SetPoint("TOPLEFT", RC.mid, "TOPRIGHT", 2, 0)
--RC.right.texture = RC:CreateTexture(nil,"BACKGROUND", nil, 1)
--RC.right.texture:SetTexture(0,0,0,0.2)
--RC.right.texture:SetAllPoints(RC.right)

RC.res = CreateFrame("Frame", "RC.res", RC)
RC.res.frame = RC
RC.res:SetWidth(16)
RC.res:SetHeight(16)
RC.res:SetPoint("BOTTOMRIGHT", RC, -1, 1)
RC.res:EnableMouse(true)
RC.res:SetScript("OnMouseDown", OnDragHandleMouseDown)
RC.res:SetScript("OnMouseUp", OnDragHandleMouseUp)
RC.res:SetAlpha(0.75)

RC.res.texture = RC.res:CreateTexture(nil, "OVERLAY")
RC.res.texture:SetTexture([[Interface\AddOns\RareCoordinator\resize.tga]])
RC.res.texture:SetWidth(16)
RC.res.texture:SetHeight(16)
RC.res.texture:SetBlendMode("ADD")
RC.res.texture:SetPoint("CENTER", RC.res)

RC.res:Hide()


RC.left.text = {}
local i
for i=0, #RareIDs do
	RC.left.text[i] = RC.left:CreateFontString("RC.left.text["..i.."]", nil, "GameFontNormal")
	RC.left.text[i]:SetPoint("TOP", "RC.left", 2, -2 + -14.5*i)
	RC.left.text[i]:SetFont("Fonts\\ARIALN.TTF",12)
	RC.left.text[i]:SetTextColor(1,1,1)
	if i == 0 then
		RC.left.text[i]:SetText("Rare")
		RC.left.text[i]:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
	else
		RC.left.text[i]:SetText(RC:getLocalRareName(RareIDs[i]))
	end
end

RC.left.gamett = CreateFrame("GameTooltip", "RC.left.gamett", UIParent, "GameTooltipTemplate")

RC.left.icon = {}
local i
for i=0, #RareIDs do
	RC.left.icon[i] = CreateFrame("Frame", "RC.left.icon["..i.."]", RC)

	if i == 0 then
		RC.left.icon[i]:SetPoint("TOPRIGHT", "RC.left", 6, -5)
		RC.left.icon[i]:SetWidth(20)
		RC.left.icon[i]:SetHeight(20)
		RC.left.icon[i].texture = RC.left.icon[i]:CreateTexture(nil, "OVERLAY")
		RC.left.icon[i].texture:SetTexture([[Interface\ACHIEVEMENTFRAME\UI-Achievement-TinyShield]])
		RC.left.icon[i].texture:SetAllPoints(RC.left.icon[i])
		
		RC.left.icon[i]:SetScript("OnEnter", function(self) ShowTooltip(RC.left.gamett,self) end)
		RC.left.icon[i]:SetScript("OnLeave", function(self) HideTooltip(RC.left.gamett) end)
	else
		RC.left.icon[i]:SetPoint("TOPRIGHT", "RC.left", -3, -3 + -14.8*i)
		RC.left.icon[i]:SetWidth(10)
		RC.left.icon[i]:SetHeight(10)
		RC.left.icon[i].texture = RC.left.icon[i]:CreateTexture(nil, "OVERLAY")
		RC.left.icon[i].texture:SetAllPoints(RC.left.icon[i])
	end
end


RC.left.nameframe = {}
for i=0, #RareIDs do
	if i ~= 0 then
		RC.left.nameframe[i] = CreateFrame("Frame", "RC.left.nameframe["..i.."]", RC.left)
		RC.left.nameframe[i]:SetPoint("TOPLEFT", "RC.left", 0, -2 + -14.5*i)
		RC.left.nameframe[i]:SetHeight(13)
		RC.left.nameframe[i]:SetWidth(RC.left:GetWidth())
		--RC.left.nameframe[i].texture = RC.left.nameframe[i]:CreateTexture(nil,"BACKGROUND", nil, 2)
		--RC.left.nameframe[i].texture:SetTexture(0,0.5,0,0.4)
		--RC.left.nameframe[i].texture:SetAllPoints(RC.left.nameframe[i])
	
		RC.left.nameframe[i]:SetScript("OnEnter", function (self) ShowMap(i) end)
		RC.left.nameframe[i]:SetScript("OnLeave", function (self) HideMap(i) end)
		--RC.left.nameframe[i]:Hide()
	end
end
RC.left.minimizeicon = CreateFrame("Frame", "RC.left.minimizeicon", RC.left)
RC.left.minimizeicon:SetPoint("TOPLEFT", "RC.left", 0, 0)
RC.left.minimizeicon:SetWidth(10)
RC.left.minimizeicon:SetHeight(10)
RC.left.minimizeicon.texture = RC.left.minimizeicon:CreateTexture(nil, "OVERLAY")
RC.left.minimizeicon.texture:SetTexture([[Interface\AddOns\RareCoordinator\minus.tga]])
RC.left.minimizeicon.texture:SetAllPoints(RC.left.minimizeicon)

RC.left.settingsicon = CreateFrame("Frame", "RC.left.settingsicon", RC.left)
RC.left.settingsicon:SetPoint("TOPLEFT", "RC.left.minimizeicon", "TOPRIGHT", 0, 0)
RC.left.settingsicon:SetWidth(10)
RC.left.settingsicon:SetHeight(10)
RC.left.settingsicon.texture = RC.left.settingsicon:CreateTexture(nil, "OVERLAY")
RC.left.settingsicon.texture:SetTexture([[Interface\AddOns\RareCoordinator\settings.tga]])
RC.left.settingsicon.texture:SetAllPoints(RC.left.settingsicon)

RC.mid.button = {}
for i=0, #RareIDs do
	RC.mid.button[i] = CreateFrame("Frame", "RC.mid.button["..i.."]", RC)
	RC.mid.button[i]:SetPoint("TOPLEFT", "RC.mid", 0, -2 + -14.5*i)
	RC.mid.button[i]:SetHeight(13)
	RC.mid.button[i]:SetWidth(RC.mid:GetWidth())
	RC.mid.button[i].texture = RC.mid.button[i]:CreateTexture(nil,"BACKGROUND", nil, 2)
	RC.mid.button[i].texture:SetTexture(0,0.5,0,0.4)
	RC.mid.button[i].texture:SetAllPoints(RC.mid.button[i])
	
	RC.mid.button[i].icon = CreateFrame("Frame", "RC.mid.icon["..i.."].icon", RC.mid.button[i])
	RC.mid.button[i].icon:SetPoint("RIGHT", "RC.mid.button["..i.."]", 2, 0)
	RC.mid.button[i].icon:SetWidth(10)
	RC.mid.button[i].icon:SetHeight(10)
	RC.mid.button[i].icon.texture = RC.mid.button[i].icon:CreateTexture(nil, "TOP")
	RC.mid.button[i].icon.texture:SetTexture([[Interface\AddOns\RareCoordinator\announce.tga]])
	RC.mid.button[i].icon.texture:SetAllPoints(RC.mid.button[i].icon)
	if i ~= 0 then
		RC.mid.button[i]:SetScript("OnMouseDown", function (self) OnMouseDownAnnounce(i) end)
	end
	RC.mid.button[i]:Hide()
end
RC.mid.text = {}
local i
for i=0, #RareIDs do
	RC.mid.text[i] = RC.mid:CreateFontString("RC.mid.text["..i.."]", nil, "GameFontNormal")
	RC.mid.text[i]:SetPoint("TOP", "RC.mid", 2, -2 + -14.5*i)
	RC.mid.text[i]:SetFont("Fonts\\ARIALN.TTF",12)
	RC.mid.text[i]:SetTextColor(1,1,1)
	if i == 0 then
		RC.mid.text[i]:SetText("Time")
		RC.mid.text[i]:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
	end
end

RC.mid.map = {}
for i=0, #RareIDs do
	if i ~= 0 then
		RC.mid.map[i] = CreateFrame("Frame", "RC.mid.map["..i.."]", RC.mid)
		RC.mid.map[i]:SetPoint("TOPLEFT", "RC.mid.text["..i.."]", "TOPLEFT", 0, 0)
		RC.mid.map[i]:SetHeight(200)
		RC.mid.map[i]:SetWidth(200)
		
		RC.mid.map[i].map = RC.mid.map[i]:CreateTexture(nil,"OVERLAY", nil, 2)
		RC.mid.map[i].map:SetTexture(0,0.5,0,0.5)
		RC.mid.map[i].map:SetAllPoints(RC.mid.map[i])
		RC.mid.map[i].map:SetDesaturated(true)
		
		RC.mid.map[i].overlay = RC.mid.map[i]:CreateTexture(nil,"OVERLAY", nil, 3)
		RC.mid.map[i].overlay:SetTexture(0.5,0,0,0.5)
		RC.mid.map[i].overlay:SetAllPoints(RC.mid.map[i])
		
		RC.mid.map[i].marker = RC.mid.map[i]:CreateTexture(nil,"OVERLAY", nil, 4)
		RC.mid.map[i].marker:SetTexture([[Interface\AddOns\RareCoordinator\marker.tga]])
		RC.mid.map[i].marker:SetHeight(10)
		RC.mid.map[i].marker:SetWidth(10)
		
		RC.mid.map[i].text = RC.mid.map[i]:CreateFontString("RC.mid.map["..i.."]", nil, "GameFontNormal")
		RC.mid.map[i].text:SetPoint("TOP", "RC.mid.map["..i.."]", 0, 0)
		RC.mid.map[i].text:SetDrawLayer("OVERLAY", 4)
		RC.mid.map[i].text:SetTextColor(1,1,1)
		RC.mid.map[i].text:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
		
		RC.mid.map[i]:Hide()
	end
end


--RC.right.text = {}
--local i
--for i=0, #RareIDs do
--	RC.right.text[i] = RC.right:CreateFontString("RC.right.text["..i.."]", nil, "GameFontNormal")
--	RC.right.text[i]:SetPoint("TOP", "RC.right", 2, -2 + -14.5*i)
--	RC.right.text[i]:SetFont("Fonts\\ARIALN.TTF",12)
--	RC.right.text[i]:SetTextColor(1,1,1)
--	if i == 0 then
--		RC.right.text[i]:SetText("Killed")
--		RC.right.text[i]:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
--	end
--end

RC.opt = CreateFrame("Frame", "RC.opt", RC)
RC.opt:SetWidth(200)
RC.opt:SetHeight(7*25+58)
RC.opt:SetPoint("TOPLEFT", RC, "TOPRIGHT", 1, 0)
RC.opt.texture = RC.opt:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.texture:SetTexture(0,0,0,0.4)
RC.opt.texture:SetAllPoints(RC.opt)

RC.opt.locked = CreateFrame("Frame", "RC.opt.locked", RC.opt)
RC.opt.locked:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.locked:SetHeight(20)
RC.opt.locked:SetPoint("TOPLEFT", RC.opt, 4, -4)
RC.opt.locked.texture = RC.opt.locked:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.locked.texture:SetTexture(0,0,0,0.2)
RC.opt.locked.texture:SetAllPoints(RC.opt.locked)

RC.opt.locked.status = RC.opt.locked:CreateFontString("RC.opt.locked.status", nil, "GameFontNormal")
RC.opt.locked.status:SetPoint("LEFT", "RC.opt.locked", 4, 0)
RC.opt.locked.status:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.locked.status:SetTextColor(1,1,1)
RC.opt.locked.status:SetText("Frame is")

RC.opt.locked.button = CreateFrame("Button", "RC.opt.locked.button", RC.opt.locked, "UIPanelButtonTemplate")
RC.opt.locked.button:SetPoint("RIGHT",-4,0)
RC.opt.locked.button:SetWidth(80)
RC.opt.locked.button:SetHeight(16)
RC.opt.locked.button:SetText("lock")

RC.opt.sound = CreateFrame("Frame", "RC.opt.sound", RC.opt)
RC.opt.sound:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.sound:SetHeight(55)
RC.opt.sound:SetPoint("TOPLEFT", RC.opt.locked, "BOTTOMLEFT", 0, -4)
RC.opt.sound.texture = RC.opt.sound:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.sound.texture:SetTexture(0,0,0,0.2)
RC.opt.sound.texture:SetAllPoints(RC.opt.sound)

RC.opt.sound.caption = RC.opt.sound:CreateFontString("RC.opt.sound.caption", nil, "GameFontNormal")
RC.opt.sound.caption:SetPoint("TOPLEFT", "RC.opt.sound", 4, -4)
RC.opt.sound.caption:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.sound.caption:SetTextColor(1,1,1)
RC.opt.sound.caption:SetText("Sound to play when a rare is found")

RC.opt.sound.dropdown = CreateFrame("Frame", "RC.opt.sound.dropdown", RC.opt.sound, "UIDropDownMenuTemplate")
RC.opt.sound.dropdown:SetPoint("TOPLEFT", "RC.opt.sound", -8, -21)
UIDropDownMenu_SetWidth(RC.opt.sound.dropdown, 160) 
UIDropDownMenu_Initialize(RC.opt.sound.dropdown,function(self)
	local info = UIDropDownMenu_CreateInfo()
	local i = 0
	for k,v in pairs(SoundsToPlay) do
		info.text = k
		info.arg1 = k
		info.func = self.SetValue
		UIDropDownMenu_AddButton(info)
		i = i + 1
	end
end)

function RC.opt.sound.dropdown:SetValue(newValue)
	UIDropDownMenu_SetText(RC.opt.sound.dropdown, newValue)
	RCDB.sound = newValue
	RCPlaySoundFile(SoundsToPlay[newValue], "master")
end

RC.opt.tomtom = CreateFrame("Frame", "RC.opt.tomtom", RC.opt)
RC.opt.tomtom:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.tomtom:SetHeight(20)
RC.opt.tomtom:SetPoint("TOPLEFT", RC.opt.sound, "BOTTOMLEFT", 0, -4)
RC.opt.tomtom.texture = RC.opt.tomtom:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.tomtom.texture:SetTexture(0,0,0,0.2)
RC.opt.tomtom.texture:SetAllPoints(RC.opt.tomtom)

RC.opt.tomtom.status = RC.opt.tomtom:CreateFontString("RC.opt.tomtom.status", nil, "GameFontNormal")
RC.opt.tomtom.status:SetPoint("LEFT", "RC.opt.tomtom", 28, 0)
RC.opt.tomtom.status:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.tomtom.status:SetTextColor(1,1,1)
RC.opt.tomtom.status:SetText("TomTom Support")

RC.opt.tomtom.cb = CreateFrame("CheckButton", "RC.opt.tomtom.cb", RC.opt.tomtom, "ChatConfigCheckButtonTemplate");
RC.opt.tomtom.cb:SetPoint("LEFT", RC.opt.tomtom, 4, 0);
RC.opt.tomtom.cb.tooltip = "Show a TomTom arrow to the location of a rare mob"
RC.opt.tomtom.cb:SetScript("OnClick", 
  function()
	if RC.opt.tomtom.cb:GetChecked() then
		RCDB.tomtom = true
	else
		RCDB.tomtom = false
	end
  end);
  
RC.opt.notify = CreateFrame("Frame", "RC.opt.notify", RC.opt)
RC.opt.notify:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.notify:SetHeight(20)
RC.opt.notify:SetPoint("TOPLEFT", RC.opt.tomtom, "BOTTOMLEFT", 0, -4)
RC.opt.notify.texture = RC.opt.notify:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.notify.texture:SetTexture(0,0,0,0.2)
RC.opt.notify.texture:SetAllPoints(RC.opt.notify)

RC.opt.notify.status = RC.opt.notify:CreateFontString("RC.opt.notify.status", nil, "GameFontNormal")
RC.opt.notify.status:SetPoint("LEFT", "RC.opt.notify", 28, 0)
RC.opt.notify.status:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.notify.status:SetTextColor(1,1,1)
RC.opt.notify.status:SetText("Notification Window")

RC.opt.notify.cb = CreateFrame("CheckButton", "RC.opt.notify.cb", RC.opt.notify, "ChatConfigCheckButtonTemplate");
RC.opt.notify.cb:SetPoint("LEFT", RC.opt.notify, 4, 0);
RC.opt.notify.cb.tooltip = "Show a notification window if a rare mob is near you"
RC.opt.notify.cb:SetScript("OnClick", 
  function()
	if RC.opt.notify.cb:GetChecked() then
		RCDB.notify = true
	else
		RCDB.notify = false
	end
  end);
  
RC.opt.colorize = CreateFrame("Frame", "RC.opt.colorize", RC.opt)
RC.opt.colorize:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.colorize:SetHeight(20)
RC.opt.colorize:SetPoint("TOPLEFT", RC.opt.notify, "BOTTOMLEFT", 0, -4)
RC.opt.colorize.texture = RC.opt.colorize:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.colorize.texture:SetTexture(0,0,0,0.2)
RC.opt.colorize.texture:SetAllPoints(RC.opt.colorize)

RC.opt.colorize.status = RC.opt.colorize:CreateFontString("RC.opt.colorize.status", nil, "GameFontNormal")
RC.opt.colorize.status:SetPoint("LEFT", "RC.opt.colorize", 28, 0)
RC.opt.colorize.status:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.colorize.status:SetTextColor(1,1,1)
RC.opt.colorize.status:SetText("Colorize List")

RC.opt.colorize.cb = CreateFrame("CheckButton", "RC.opt.colorize.cb", RC.opt.colorize, "ChatConfigCheckButtonTemplate");
RC.opt.colorize.cb:SetPoint("LEFT", RC.opt.colorize, 4, 0);
RC.opt.colorize.cb.tooltip = "Colorizes the timers"  

RC.opt.sort = CreateFrame("Frame", "RC.opt.sort", RC.opt)
RC.opt.sort:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.sort:SetHeight(20)
RC.opt.sort:SetPoint("TOPLEFT", RC.opt.colorize, "BOTTOMLEFT", 0, -4)
RC.opt.sort.texture = RC.opt.sort:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.sort.texture:SetTexture(0,0,0,0.2)
RC.opt.sort.texture:SetAllPoints(RC.opt.sort)

RC.opt.sort.status = RC.opt.sort:CreateFontString("RC.opt.sort.status", nil, "GameFontNormal")
RC.opt.sort.status:SetPoint("LEFT", "RC.opt.sort", 28, 0)
RC.opt.sort.status:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.sort.status:SetTextColor(1,1,1)
RC.opt.sort.status:SetText("Sort list by timers")

RC.opt.sort.cb = CreateFrame("CheckButton", "RC.opt.sort.cb", RC.opt.sort, "ChatConfigCheckButtonTemplate");
RC.opt.sort.cb:SetPoint("LEFT", RC.opt.sort, 4, 0);
RC.opt.sort.cb.tooltip = "Sorts the list by timers/alphabetically"

RC.opt.biggerbag = CreateFrame("Frame", "RC.opt.biggerbag", RC.opt)
RC.opt.biggerbag:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.biggerbag:SetHeight(20)
RC.opt.biggerbag:SetPoint("TOPLEFT", RC.opt.sort, "BOTTOMLEFT", 0, -4)
RC.opt.biggerbag.texture = RC.opt.biggerbag:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.biggerbag.texture:SetTexture(0,0,0,0.2)
RC.opt.biggerbag.texture:SetAllPoints(RC.opt.biggerbag)

RC.opt.biggerbag.status = RC.opt.biggerbag:CreateFontString("RC.opt.biggerbag.status", nil, "GameFontNormal")
RC.opt.biggerbag.status:SetPoint("LEFT", "RC.opt.biggerbag", 28, 0)
RC.opt.biggerbag.status:SetFont("Fonts\\ARIALN.TTF",12)
RC.opt.biggerbag.status:SetTextColor(1,1,1)
RC.opt.biggerbag.status:SetText("Track Going To Need A Bigger Bag")

RC.opt.biggerbag.cb = CreateFrame("CheckButton", "RC.opt.biggerbag.cb", RC.opt.biggerbag, "ChatConfigCheckButtonTemplate");
RC.opt.biggerbag.cb:SetPoint("LEFT", RC.opt.biggerbag, 4, 0);
RC.opt.biggerbag.cb.tooltip = "Switches the achievement tracker to the \"Going To Need A Bigger Bag\" achievement instead of \"Timeless Champion\""

RC.opt.moreconfig = CreateFrame("Frame", "RC.opt.moreconfig", RC.opt)
RC.opt.moreconfig:SetWidth(RC.opt:GetWidth() - 8)
RC.opt.moreconfig:SetHeight(20)
RC.opt.moreconfig:SetPoint("TOPLEFT", RC.opt.biggerbag, "BOTTOMLEFT", 0, -4)
RC.opt.moreconfig.texture = RC.opt.moreconfig:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.opt.moreconfig.texture:SetTexture(0,0,0,0.2)
RC.opt.moreconfig.texture:SetAllPoints(RC.opt.moreconfig)

RC.opt.moreconfig.button = CreateFrame("Button", "RC.opt.moreconfig.button", RC.opt.moreconfig, "UIPanelButtonTemplate")
RC.opt.moreconfig.button:SetPoint("LEFT",4,0)
RC.opt.moreconfig.button:SetWidth(185)
RC.opt.moreconfig.button:SetHeight(16)
RC.opt.moreconfig.button:SetText("Select Rares to track")




RC.opt:Hide()

RC.left.settingsicon:SetScript("OnMouseDown", function (self) OptShowOrHide() end)
RC.left.minimizeicon:SetScript("OnMouseDown", function (self) MinMaximize() end)

RC.message = CreateFrame("Frame", "RC.message", RC)
RC.message:SetWidth(RC:GetWidth())
RC.message:SetHeight(20)
RC.message:SetPoint("TOP", RC, "BOTTOM", 0, 0)
RC.message.texture = RC.message:CreateTexture(nil,"BACKGROUND", nil, 1)
RC.message.texture:SetTexture(1,0.5,0,0.6)
RC.message.texture:SetAllPoints(RC.message)
RC.message.text = RC.message:CreateFontString("RC.message.text", nil, "GameFontNormal")
RC.message.text:SetPoint("CENTER", "RC.message", 0, 0)
RC.message.text:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
RC.message.text:SetTextColor(1,1,1)

RC.message.closeicon = CreateFrame("Button", "RC.message.closeicon", RC.message)
RC.message.closeicon:SetPoint("RIGHT", "RC.message", 0, 0)
RC.message.closeicon:SetWidth(16)
RC.message.closeicon:SetHeight(16)
RC.message.closeicon.texture = RC.message.closeicon:CreateTexture(nil, "OVERLAY")
RC.message.closeicon.texture:SetTexture([[Interface\AddOns\RareCoordinator\plus.tga]])
RC.message.closeicon.texture:SetAllPoints(RC.message.closeicon)
RC.message.closeicon.texture:SetRotation((3*math.pi)/4)
RC.message.closeicon:SetScript("OnClick", function (self) RC.message:Hide() end)

RC.message:Hide()


RCminimized = CreateFrame("Frame", "RCminimized", UIParent)
RCminimized:SetWidth(RC:GetWidth())
RCminimized:SetHeight(20)
RCminimized:SetPoint("TOPLEFT", RC, "TOPLEFT", 0, 0)
RCminimized.texture = RCminimized:CreateTexture(nil,"BACKGROUND", nil, 1)
RCminimized.texture:SetTexture(0,0,0,0.6)
RCminimized.texture:SetAllPoints(RCminimized)


RCminimized.maximizeicon = CreateFrame("Frame", "RCminimized.maximizeicon", RCminimized)
RCminimized.maximizeicon:SetPoint("LEFT", "RCminimized", 4, 0)
RCminimized.maximizeicon:SetWidth(10)
RCminimized.maximizeicon:SetHeight(10)
RCminimized.maximizeicon.texture = RCminimized.maximizeicon:CreateTexture(nil, "OVERLAY")
RCminimized.maximizeicon.texture:SetTexture([[Interface\AddOns\RareCoordinator\plus.tga]])
RCminimized.maximizeicon.texture:SetAllPoints(RCminimized.maximizeicon)

RCminimized.title = RCminimized:CreateFontString("RCminimized.title", nil, "GameFontNormal")
RCminimized.title:SetPoint("CENTER", "RCminimized", 0, 0)
RCminimized.title:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
RCminimized.title:SetTextColor(1,1,1)
RCminimized.title:SetText("RareCoordinator")

RCminimized:Hide()
RCminimized.maximizeicon:SetScript("OnMouseDown", function (self) MinMaximize() end)

RCnotify = CreateFrame("Button", "RCnotify", UIParent, "SecureActionButtonTemplate,SecureHandlerShowHideTemplate")
RCnotify:SetWidth(200)
RCnotify:SetHeight(130)
RCnotify.texture = RCnotify:CreateTexture(nil,"BACKGROUND", nil, 1)
RCnotify.texture:SetTexture(0,0,0,0.4)
RCnotify.texture:SetAllPoints(RCnotify)

RCnotify.model = CreateFrame("PlayerModel", "RCnotify.model", RCnotify)
RCnotify.model:SetFrameLevel(5)
RCnotify.model:SetPoint("BOTTOM", "RCnotify", 0, 2)
RCnotify.model:SetWidth(200)
RCnotify.model:SetHeight(110)

RCnotify.name = RCnotify:CreateFontString("RCnotify.name", nil, "GameFontNormal")
RCnotify.name:SetPoint("TOP", "RCnotify", 0, -2)
RCnotify.name:SetFont("Fonts\\ARIALN.TTF",15,"OUTLINE")
RCnotify.name:SetTextColor(1,1,1)

RCnotify.closeicon = CreateFrame("Button", "RCnotify.closeicon", RCnotify, "UIPanelCloseButton")
RCnotify.closeicon:SetPoint("TOPLEFT", "RCnotify", 0, 0)
RCnotify.closeicon:SetWidth(16)
RCnotify.closeicon:SetHeight(16)
RCnotify.closeicon.texture = RCnotify.closeicon:CreateTexture(nil, "OVERLAY")
RCnotify.closeicon.texture:SetTexture([[Interface\AddOns\RareCoordinator\plus.tga]])
RCnotify.closeicon.texture:SetAllPoints(RCnotify.closeicon)
RCnotify.closeicon.texture:SetRotation((3*math.pi)/4)
RCnotify.closeicon:SetScript("OnClick", function (self) RCnotify:Hide() end)

RCnotify.mouseovertexture = RCnotify:CreateTexture(nil,"HIGHLIGHT", nil, 1)
RCnotify.mouseovertexture:SetTexture(1,1,1,0.1)
RCnotify.mouseovertexture:SetAllPoints(RCnotify)

RCnotify:SetAttribute( "type", "macro" );

--RCnotify:SetScript("OnMouseDown", function (self) OnMouseDownTarget() end)

RCnotify:Hide()

function RC:ShowUpdateMessage()
	RCupdatemsg = CreateFrame("Frame", "RCupdatemsg", UIParent)
	RCupdatemsg:SetWidth(350)
	RCupdatemsg:SetHeight(225)
	RCupdatemsg:SetClampedToScreen(true)
	RCupdatemsg:SetPoint("CENTER",0,0)

	RCupdatemsg.texture = RCupdatemsg:CreateTexture(nil,"BACKGROUND")
	RCupdatemsg.texture:SetTexture(0,0,0,0.6)
	RCupdatemsg.texture:SetAllPoints(RCupdatemsg)

	RCupdatemsg.closeicon = CreateFrame("Button", "RCupdatemsg.closeicon", RCupdatemsg, "UIPanelCloseButton")
	RCupdatemsg.closeicon:SetPoint("TOPRIGHT", "RCupdatemsg", 0, 0)
	RCupdatemsg.closeicon:SetWidth(16)
	RCupdatemsg.closeicon:SetHeight(16)
	RCupdatemsg.closeicon.texture = RCupdatemsg.closeicon:CreateTexture(nil, "OVERLAY")
	RCupdatemsg.closeicon.texture:SetTexture([[Interface\AddOns\RareCoordinator\plus.tga]])
	RCupdatemsg.closeicon.texture:SetAllPoints(RCupdatemsg.closeicon)
	RCupdatemsg.closeicon.texture:SetRotation((3*math.pi)/4)
	RCupdatemsg.closeicon:SetScript("OnClick", function (self) RCupdatemsg:Hide() end)
	
	RCupdatemsg.closebutton = CreateFrame("Button", "RCupdatemsg.closebutton", RCupdatemsg, "UIPanelButtonTemplate")
	RCupdatemsg.closebutton:SetPoint("BOTTOM",0,5)
	RCupdatemsg.closebutton:SetWidth(80)
	RCupdatemsg.closebutton:SetHeight(16)
	RCupdatemsg.closebutton:SetText("Okay")
	RCupdatemsg.closebutton:SetScript("OnClick", function(self) RCupdatemsg:Hide() end)
	

	RCupdatemsg:SetScript("OnDragStart", onDragStart)
	RCupdatemsg:SetScript("OnDragStop", onDragStop)	
	RCupdatemsg:EnableMouse(true)
	RCupdatemsg:SetMovable(true)
	RCupdatemsg:RegisterForDrag("LeftButton")
	
	
	RCupdatemsg.title = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.title:SetPoint("TOP", "RCupdatemsg", 0, -4)
	RCupdatemsg.title:SetFont("Fonts\\ARIALN.TTF",14,"OUTLINE")
	RCupdatemsg.title:SetTextColor(1,1,1)
	RCupdatemsg.title:SetText("RareCoordinator")
	
	RCupdatemsg.text = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.text:SetPoint("TOPLEFT", RCupdatemsg, 10, -22)
	RCupdatemsg.text:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.text:SetTextColor(1,1,1)
	RCupdatemsg.text:SetJustifyH("LEFT")
	local v="|cff00ff00"..RC.version.."|r"
	if RC.isAlpha then v=v.."+ (newer alpha)" end
	RCupdatemsg.text:SetText("Thank you for choosing RareCoordinator.\nYou are using v"..v..".")
	
	RCupdatemsg.important = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.important:SetPoint("TOPLEFT", RCupdatemsg.text, 0, -RCupdatemsg.text:GetStringHeight()-5)
	RCupdatemsg.important:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.important:SetTextColor(1,0,0)
	RCupdatemsg.important:SetJustifyH("LEFT")
	RCupdatemsg.important:SetText("Remember to update RareCoordinator after WoD goes live.")
	
	RCupdatemsg.features = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.features:SetPoint("TOPLEFT", RCupdatemsg.important, 0, -RCupdatemsg.important:GetStringHeight()-5)
	RCupdatemsg.features:SetFont("Fonts\\ARIALN.TTF",12,"OUTLINE")
	RCupdatemsg.features:SetTextColor(1,1,1)
	RCupdatemsg.features:SetJustifyH("LEFT")
	RCupdatemsg.features:SetText("New Features:")
	
	RCupdatemsg.feature1 = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.feature1:SetPoint("TOPLEFT", RCupdatemsg.features, 0, -16)
	RCupdatemsg.feature1:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.feature1:SetTextColor(1,1,1)
	RCupdatemsg.feature1:SetJustifyH("LEFT")
	RCupdatemsg.feature1:SetText("• Update for 6.0")
	
	RCupdatemsg.feature2 = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.feature2:SetPoint("TOPLEFT", RCupdatemsg.feature1, 0, -16)
	RCupdatemsg.feature2:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.feature2:SetTextColor(1,1,1)
	RCupdatemsg.feature2:SetJustifyH("LEFT")
	RCupdatemsg.feature2:SetText("• Vignette support (alerts you if a rare is nearby)")
	--[[
	RCupdatemsg.feature3 = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.feature3:SetPoint("TOPLEFT", RCupdatemsg.feature2, 0, -16)
	RCupdatemsg.feature3:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.feature3:SetTextColor(1,1,1)
	RCupdatemsg.feature3:SetJustifyH("LEFT")
	RCupdatemsg.feature3:SetText("• If a Rare is alive, it's approximate position is shown on the map")
	
	RCupdatemsg.feature3button = CreateFrame("Button", "RCupdatemsg.feature3button", RCupdatemsg, "UIPanelButtonTemplate")
	RCupdatemsg.feature3button:SetPoint("LEFT",RCupdatemsg.feature3,42,-1)
	RCupdatemsg.feature3button:SetWidth(80)
	RCupdatemsg.feature3button:SetHeight(16)
	RCupdatemsg.feature3button:SetText("here")
	RCupdatemsg.feature3button:SetScript("OnClick", function(self) InterfaceOptionsFrame_OpenToCategory("List");InterfaceOptionsFrame_OpenToCategory("List") end)

	RCupdatemsg.feature4 = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.feature4:SetPoint("TOPLEFT", RCupdatemsg.feature3, 0, -16)
	RCupdatemsg.feature4:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.feature4:SetTextColor(1,1,1)
	RCupdatemsg.feature4:SetJustifyH("LEFT")
	RCupdatemsg.feature4:SetText("• If a Rare is alive, it's approximate position is shown on the map")
	
	RCupdatemsg.feature5 = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.feature5:SetPoint("TOPLEFT", RCupdatemsg.feature4, 0, -16)
	RCupdatemsg.feature5:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.feature5:SetTextColor(1,1,1)
	RCupdatemsg.feature5:SetJustifyH("LEFT")
	RCupdatemsg.feature5:SetText("  (mouseover it's name)")
	
	RCupdatemsg.feature6 = RCupdatemsg:CreateFontString("RCupdatemsg.name", nil, "GameFontNormal")
	RCupdatemsg.feature6:SetPoint("TOPLEFT", RCupdatemsg.feature5, 0, -16)
	RCupdatemsg.feature6:SetFont("Fonts\\ARIALN.TTF",12)
	RCupdatemsg.feature6:SetTextColor(1,1,1)
	RCupdatemsg.feature6:SetJustifyH("LEFT")
	RCupdatemsg.feature6:SetText("• You can now track the Going To Need A Bigger Back achievement")
	]]--
end



local total = 0
local function updateText(self,elapsed)
	if elapsed == nil then elapsed = 0 end
    total = total + elapsed
    if total >= 10 then
		if RCDB.biggerbag then
			for i = 1,#RareIDs do
				RareAv[RareIDs[i]] = false
			end
			for i=1,GetAchievementNumCriteria(8728) do
				local _, _, completed, _, _, _, _, assetID, _, _ = GetAchievementCriteriaInfo(8728,i)
				local t = GetRareIDsforAssetID(assetID)
				if t then
					for _,rareID in pairs(t) do
						RareAv[rareID] = completed
					end
				end
			end
			for i = 1,#RareIDs do
				if not BiggerBagAssetIDs[RareIDs[i]] then
					RareAv[RareIDs[i]] = nil
				end
			end
		else
			for i=1,GetAchievementNumCriteria(8714) do
				local _, _, completed, _, _, _, _, assetID, _, _ = GetAchievementCriteriaInfo(8714,i)
				if assetID == 73854 then -- Fix for Cranegnasher since he has 2 NPC IDs
					assetID = 72049
				end
				if completed then
					RareAv[assetID] = true
				else
					RareAv[assetID] = false
				end		
			end
		end
		for k,v in pairs(RareSeen) do
			if tonumber(k) == 72970 then -- longer reset for Golganarr
				if tonumber(v)+24*60*60 < time() then
					RareSeen[k] = nil
				end
			else
				if tonumber(v)+3*60*60 < time() then
					RareSeen[k] = nil
				end
			end
		end
		for k,v in pairs(RareKilled) do
			if tonumber(k) == 72970 then -- longer reset for Golganarr
				if tonumber(v)+24*60*60 < time() then
					RareKilled[k] = nil
				end
			else
				if tonumber(v)+3*60*60 < time() then
					RareKilled[k] = nil
				end
			end
		end
		for k,v in pairs(RareAlive) do
			if tonumber(v)+10*60 < time() then
				RareAlive[k] = nil
				RareAliveHP[k] = nil
			end
		end
		local sorted 
		if RCDB.sort then
			sorted = RC:createSortedTable(false)
		else
			sorted = RC:createSortedTable(true)
		end
		
			local i = 0
			for k,v in pairs(sorted) do
				if RC.left ~= nil then
					if RC.left.text ~= nil then
						RC.left.text[k]:SetText(RC:getLocalRareName(v.id))
						RC.left.text[k]:Show()
					end
					if RC.left.nameframe ~= nil then
						RC.left.nameframe[k]:Show()
					end
					if RC.left.icon ~= nil then
						if RareAv[v.id] ~= nil then
							if RareAv[v.id] then
								RC.left.icon[k].texture:SetTexture([[Interface\AddOns\RareCoordinator\green.tga]])
							else
								RC.left.icon[k].texture:SetTexture([[Interface\AddOns\RareCoordinator\red.tga]])
							end
						else
							RC.left.icon[k].texture:SetTexture(nil)
						end
						RC.left.icon[k]:Show()
					end
				end
				
				
				if RC.mid ~= nil then
					if RC.mid.text ~= nil then
						local t = RC:getRealRareTime(v.id)
						if t == true then --alive
							if SoundPlayed[v.id] == nil then
								if not RC:IsIgnoredRareID(v.id) then
									RCPlaySoundFile(SoundsToPlay[RCDB.sound], "MASTER")
									SoundPlayed[v.id] = time()
								end
							elseif time() > SoundPlayed[v.id] + 600 then
								if not RC:IsIgnoredRareID(v.id) then
									RCPlaySoundFile(SoundsToPlay[RCDB.sound], "MASTER")
									SoundPlayed[v.id] = time()
								end
							end
							RC.mid.button[k]:Show()
							if RareAliveHP[v.id] ~= nil then
								RC.mid.text[k]:SetText("|cff00ff00"..RareAliveHP[v.id].."%|r")
							else
								RC.mid.text[k]:SetText("|cff00ff00alive|r")
							end
							RC:setWaypoint(v.id)
						elseif t == false then --nodata
							RC.mid.button[k]:Hide()
							RC.mid.text[k]:SetText("-")
						else
							RC.mid.button[k]:Hide()
							RC.mid.text[k]:SetText(ColorfulTime(math.floor((time()-v.t)/60)))
						end
						RC.mid.text[k]:Show()
					end
					if RC.mid.button ~= nil then
						RC.mid.button[k]:SetScript("OnMouseDown", function (self) OnMouseDownAnnounce(v.id) end)
					end
				end
				i = i + 1
			end

			--Resize the Frame
			--print(i)
			--self.RareCount=i
			--onResize(RC,RC:GetWidth(), RC:GetHeight())
			--local scale = RC:GetWidth()/260
			--RC:SetHeight(i*16.25*scale+8*scale)
			--RC.left:SetHeight(RC:GetHeight()-8*scale)
			--RC.mid:SetHeight(RC.left:GetHeight())
			--print("should be resized by now...")

			i = i + 1
			for i = i,#RareIDs do
				if RC.left ~= nil then
					if RC.left.text ~= nil then
						RC.left.text[i]:Hide()
					end
					if RC.left.nameframe ~= nil then
						RC.left.nameframe[i]:Hide()
					end
					if RC.left.icon ~= nil then
						RC.left.icon[i]:Hide()
					end
					if RC.mid.text ~= nil then
						RC.mid.text[i]:Hide()
					end
				end
			end
		
		--else
		--	
		--	if RC.left ~= nil then
		--	
		--		if RC.left.text ~= nil then
		--			for i=1,table.getn(RC.left.icon) do
		--				RC.left.text[i]:SetText(RC:getLocalRareName(RareIDs[i]))
		--			end
		--		end
		--			
		--		if RC.left.icon ~= nil then
		--			local i
		--			for i=1,table.getn(RC.left.icon) do
		--				if RareAv[RareIDs[i]] ~= nil then
		--					if RareAv[RareIDs[i]] then
		--						RC.left.icon[i].texture:SetTexture([[Interface\AddOns\RareCoordinator\green.tga]])
		--					else
		--						RC.left.icon[i].texture:SetTexture([[Interface\AddOns\RareCoordinator\red.tga]])
		--					end
		--				else
		--					RC.left.icon[i].texture:SetTexture(nil)
		--				end
		--			end
		--		end
		--	end
		--	if RC.mid ~= nil then
		--		if RC.mid.text ~= nil then
		--			local i
		--			for i=1,table.getn(RC.mid.text) do
		--				local t=RC:getRealRareTime(RareIDs[i])
		--				if t == true then
		--					if SoundPlayed[RareIDs[i]] == nil then
		--						if not RC:IsIgnoredRareID(v.id) then
		--							RCPlaySoundFile(SoundsToPlay[RCDB.sound], "MASTER")
		--							SoundPlayed[RareIDs[i]] = time()
		--						end
		--					elseif time() > SoundPlayed[RareIDs[i]] + 600 then
		--						if not RC:IsIgnoredRareID(v.id) then
		--							RCPlaySoundFile(SoundsToPlay[RCDB.sound], "MASTER")
		--							SoundPlayed[RareIDs[i]] = time()
		--						end
		--					end
		--					RC.mid.button[i]:Show()
		--					if RareAliveHP[RareIDs[i]] ~= nil then
		--						RC.mid.text[i]:SetText("|cff00ff00"..RareAliveHP[RareIDs[i]].."%|r")
		--					else
		--						RC.mid.text[i]:SetText("|cff00ff00alive|r")
		--					end
		--					RC:setWaypoint(RareIDs[i])
		--				elseif t == false then
		--					RC.mid.button[i]:Hide()
		--					RC.mid.text[i]:SetText("-")
		--				else
		--					RC.mid.button[i]:Hide()
		--					RC.mid.text[i]:SetText(ColorfulTime(math.floor((time()-t)/60)))
		--				end
		--			end
		--		end
		--		for i=1,table.getn(RC.mid.button) do
		---			if RC.mid.button ~= nil then
		--				RC.mid.button[i]:SetScript("OnMouseDown", function (self) OnMouseDownAnnounce(RareIDs[i]) end)
		--			end
		--		end
		--	end
		--	if RC.right ~= nil then
		--		if RC.right.text ~= nil then
		--			local i
		--			for i=1,table.getn(RC.right.text) do
		--				if RareAliveHP[RareIDs[i]] ~= nil and RareAlive[RareIDs[i]] then
		--					RC.right.text[i]:SetText("|cff00ff00"..RareAliveHP[RareIDs[i]].."%|r")
		--				elseif RareKilled[RareIDs[i]] ~= nil then
		--					RC.right.text[i]:SetText(ColorfulTime(math.floor((time()-RareKilled[RareIDs[i]])/60)))
		--				else
		--					RC.right.text[i]:SetText("never")
		--				end
		--			end
		--		end
		--	end
		--end
        total = 0
    end
end


RC.opt.colorize.cb:SetScript("OnClick", 
  function()
	if RC.opt.colorize.cb:GetChecked() then
		RCDB.colorize = true
	else
		RCDB.colorize = false
	end
	updateText(RC,100)
  end);

RC.opt.sort.cb:SetScript("OnClick", 
  function()
	if RC.opt.sort.cb:GetChecked() then
		RCDB.sort = true
	else
		RCDB.sort = false
	end
	updateText(RC,100)
	onResize(RC, RC:GetWidth(), 0, RareIDs)
  end);
  
RC.opt.biggerbag.cb:SetScript("OnClick", 
  function()
	if RC.opt.biggerbag.cb:GetChecked() then
		RCDB.biggerbag = true
	else
		RCDB.biggerbag = false
	end
	updateText(RC,100)
	onResize(RC, RC:GetWidth(), 0, RareIDs)
  end);
  
  
local function LockOrUnlock()
	if locked then
		print("RareCoordinator is now |cff00ff00unlocked|r. - Type /rc or /rare to lock it")
		
		RC:EnableMouse(true)
		RC:SetMovable(true)
		RC:SetResizable(true)
		RC:SetScript("OnSizeChanged", onResize)
		RC:SetScript("OnDragStart", onDragStart)
		RC:SetScript("OnDragStop", onDragStop)
		RC:RegisterForDrag("LeftButton")
		RC:Show()
		RC.res:Show()
		
		for i=1,table.getn(RC.mid.button) do
			RC.left.nameframe[i]:Hide()
		end
		
		--RCnotify:EnableMouse(true)
		RCnotify:SetMovable(true)
		--RCnotify:SetResizable(true)
		RCnotify:SetScript("OnSizeChanged", onResize)
		RCnotify:SetScript("OnDragStart", onDragStart)
		RCnotify:SetScript("OnDragStop", onDragStop)
		RCnotify:RegisterForDrag("LeftButton")
		RCnotify.model:SetUnit("player")
		RCnotify.name:SetText("Notification Window")
		RCnotify:Show()
		
		RC.opt.locked.status:SetText("Frame is |cff00ff00unlocked")
		RC.opt.locked.button:SetText("lock")
		
		locked = false
	else
		print("RareCoordinator is now |cffff0000locked|r. - Type /rc or /rare to unlock it")	
		
		RC:SetMovable(false)
		RC:EnableMouse(false)
		RC:SetResizable(false)
		RC:RegisterForDrag()
		RC:SetScript("OnDragStart", nil)
		RC:SetScript("OnDragStop", nil)
		RC:SetScript("OnHide", nil)
		RC:ShowOrHide()
		RC.res:Hide()
		
		
		for i=1,table.getn(RC.mid.button) do
			RC.left.nameframe[i]:Show()
		end
		
		RCnotify:SetMovable(false)
		--RCnotify:EnableMouse(false)
		--RCnotify:SetResizable(false)
		RCnotify:RegisterForDrag()
		RCnotify:SetScript("OnDragStart", nil)
		RCnotify:SetScript("OnDragStop", nil)
		RCnotify:SetScript("OnHide", nil)
		RCnotify:Hide()
		
		RC.opt.locked.status:SetText("Frame is |cffff0000locked")
		RC.opt.locked.button:SetText("unlock")
		
		locked = true
	end
end

function RC:OnEvent(event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		self:CombatLog(...)
	end
	if event == "PLAYER_TARGET_CHANGED" then
		self:Target(...)
	end
	if event == "CHAT_MSG_CHANNEL" then
		self:Chat(...)
	end
	if event == "ADDON_LOADED" then
		self:OnLoad(...)
	end
	if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
		self:ShowOrHide(...)
	end
	if event == "CHAT_MSG_ADDON" then
		self:AddonMsg(...)
	end
	if event == "CHANNEL_ROSTER_UPDATE" then
		self:ChanRosterUpdate(...)
	end
	if event == "UNIT_HEALTH" then
		self:UnitHealth(...)
	end
	if event == "PLAYER_REGEN_DISABLED" then
		self:ShowNotifyClose(false)
	end
	if event == "PLAYER_REGEN_ENABLED" then
		self:ShowNotifyClose(true)
	end
	if event == "VIGNETTE_ADDED" then
		self:Vignette(...)
	end
end

function RC:OnLoad(...)
	if select(1, ...) == "RareCoordinator" then
		--print("RareCoordinator loaded - type /rc or /rare for options");
		if RCDB.x == nil or RCDB.y == nil then
			self:SetPoint("CENTER",-200,0)
		else
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", RCDB.x, RCDB.y)
			self:SetWidth(RCDB.width)
			onResize(RC, RC:GetWidth(), 0, RareIDs)
		end
		if RCDB.notifyx == nil or RCDB.notifyy == nil then
			RCnotify:SetPoint("CENTER", 0, -150)
		else
			RCnotify:ClearAllPoints()
			RCnotify:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", RCDB.notifyx, RCDB.notifyy)
		end
		
		if RCDB.sound == nil then
			RCDB.sound = "DIIING"
		end
		
		if RCDB.tomtom == nil then
			RCDB.tomtom = true
		end
		RC.opt.tomtom.cb:SetChecked(RCDB.tomtom)
		
		if RCDB.notify == nil then
			RCDB.notify = true
		end
		RC.opt.notify.cb:SetChecked(RCDB.notify)
		
		if RCDB.colorize == nil then
			RCDB.colorize = true
		end
		RC.opt.colorize.cb:SetChecked(RCDB.colorize)
		
		if RCDB.sort == nil then
			RCDB.sort = true
		end
		RC.opt.sort.cb:SetChecked(RCDB.sort)
		
		if RCDB.biggerbag == nil then
			RCDB.biggerbag = false
		end
		RC.opt.biggerbag.cb:SetChecked(RCDB.biggerbag)
		
		if RCDB.lastVersion == nil then
			RCDB.lastVersion = ""
			LockOrUnlock()
		end
		if RCDB.lastVersion ~= RC.version then
			RC:ShowUpdateMessage()
			RCDB.lastVersion = RC.version
		end
		
		local sorted = RC:createSortedTable(false)
		if #sorted == 0 then
			self.RareCount = #RareIDs
		else
			self.RareCount = #sorted
		end
		onResize(self, self:GetWidth(), self:GetHeight())
		
	end
end

function RC:UnitHealth(unit)
	if unit ~= "target" then return end
	if UnitGUID("target") ~= nil then
		local guid = UnitGUID("target")
		local unittype, _, serverID, instanceID, zoneUID, npcID, spawnUID = strsplit("-", guid or "")
		local id = tonumber(npcID)
		for _,v in pairs(RareIDs) do
			if v == id then
				local per = self:getTargetPercentHProunded()
				if per and per >= 0 then
					if RareAliveHP[id] ~= nil then
						if RareAliveHP[id] > per then
							SendChatMessage("[RCELVA]"..self.version.."_"..id.."_alive"..per..getFormattedCurrentPlayerPosition().."_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
							RareAliveHP[id] = per
							updateText(self, 100)
						end
					else
						SendChatMessage("[RCELVA]"..self.version.."_"..id.."_alive"..per..getFormattedCurrentPlayerPosition().."_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
						RareAliveHP[id] = per
						updateText(self, 100)
					end
				end
			end
		end
	end
end

--894 / 888
function RC:ShowOrHide(...)
	if IsInXRealmGrp() then
		self:Hide()
		RCminimized:Hide()
		LeaveChannelByName("RCELVA")
		self:UnregisterEvent("UNIT_HEALTH")
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("VIGNETTE_ADDED")
		self:removeAllWaypoints()
	else
		if GetCurrentMapAreaID() == 951 then --or GetCurrentMapAreaID() == 888 (nightelf)
			RareAlive = {}
			if minimized then
				RCminimized:Show()
			else
				self:Show()
			end
			myChan = false
			needStatus = true
			chanchecked = 0
			self:SetScript("OnUpdate", RC.join)
			self:RegisterEvent("UNIT_HEALTH")
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:RegisterEvent("PLAYER_TARGET_CHANGED")
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
			self:RegisterEvent("VIGNETTE_ADDED")
			RegisterAddonMessagePrefix("RCELVA")
			updateText(RC,100)
			--RC.updater:SetScript("OnUpdate", updateText)
		else
			self:Hide()
			RCminimized:Hide()
			LeaveChannelByName("RCELVA")
			self:UnregisterEvent("UNIT_HEALTH")
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:UnregisterEvent("PLAYER_TARGET_CHANGED")
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
			self:UnregisterEvent("VIGNETTE_ADDED")
			self:removeAllWaypoints()
		end
	end
end



function RC:Chat(message, sender, language, channelString, target, flags, unknown, channelNumber, channelName, unknown, counter, guid)
	if channelName == "RCELVA" then
		if string.find(message, "[RCELVA]") then
			count = 0
			for match in string.gmatch(message, "_") do count = count + 1 end
			if count == 4 then
				message = string.sub(message, 9)
				local eventVersion,eventRareID,eventType,eventTime
				
				firstSeperator,_ = string.find(message, "_")
				if firstSeperator ~= nil then
					eventVersion = string.sub(message, 0, firstSeperator-1)
					message = string.sub(message, firstSeperator+1)
				end
				
				secondSeperator,_ = string.find(message, "_")
				if secondSeperator ~= nil then
					eventRareID = tonumber(string.sub(message, 0, secondSeperator-1))
					message = string.sub(message, secondSeperator+1)
				end
				
				thirdSeperator,_ = string.find(message, "_")
				if thirdSeperator ~= nil then
					eventType = string.sub(message, 0, thirdSeperator-1)
					message = string.sub(message, thirdSeperator+1)
				end
				
				fourthSeperator,_ = string.find(message, "_")
				if firstSeperator ~= nil then
					eventTime = string.sub(message, 0, fourthSeperator-1)
					message = string.sub(message, fourthSeperator+1)
				end
				
				for _,v in pairs(RareIDs) do
					if v == eventRareID and eventType ~= nil and eventTime ~= nil then
						if eventType == "alive" then
							RareAlive[v] = eventTime
						elseif string.sub(eventType,0,5) == "alive" then
							if string.find(eventType, ",") ~= nil and string.find(eventType, "-") ~= nil then
								local hp,x,y = string.match(eventType, "(%d+),(%d+)-(%d+)")
								hp = tonumber(hp)
								x = tonumber(x)
								y = tonumber(y)
								RareAlive[v] = eventTime
								RareAliveHP[v] = hp
								self:setWaypoint(v,x,y)
							else
								RareAlive[v] = eventTime
								RareAliveHP[v] = tonumber(string.sub(eventType,6))
							end
						elseif eventType == "dead" then
							RareAlive[v] = nil
							RareAliveHP[v] = nil
							self:removeWaypoint(v)
						elseif eventType == "killed" then
							RareKilled[v] = eventTime
							RareAlive[v] = nil
							RareAliveHP[v] = nil
							self:removeWaypoint(v)
						elseif eventType == "seen" then
							RareSeen[v] = eventTime
						elseif eventType == "announce" then
							RareAnnounced[v] = eventTime
						end
						updateText(self, 100)
						self:CompareVersion(eventVersion)
						break
					end
				end
			end
		end
	end
end

function RC:AddonMsg(prefix, message, channel, sender)
	--print(prefix.." - "..channel.." - "..sender.."-"..message)
	if prefix == "RCELVA" then
		if channel == "WHISPER" and message == "GetStatus" then
			for id,timestamp in pairs(RareSeen) do
				SendAddonMessage("RCELVA", self.version.."_"..id.."_seen_"..timestamp.."_", "WHISPER", sender)
			end
			for id,timestamp in pairs(RareKilled) do
				SendAddonMessage("RCELVA", self.version.."_"..id.."_killed_"..timestamp.."_", "WHISPER", sender)
			end
			for id,timestamp in pairs(RareAlive) do
				SendAddonMessage("RCELVA", self.version.."_"..id.."_alive_"..timestamp.."_", "WHISPER", sender)
			end
		end
		if channel == "WHISPER" then
			count = 0
			for match in string.gmatch(message, "_") do count = count + 1 end
			if count == 4 then
				firstSeperator,_ = string.find(message, "_")
				if firstSeperator ~= nil then
					eventVersion = string.sub(message, 0, firstSeperator-1)
					message = string.sub(message, firstSeperator+1)
				end
				
				secondSeperator,_ = string.find(message, "_")
				if secondSeperator ~= nil then
					eventRareID = tonumber(string.sub(message, 0, secondSeperator-1))
					message = string.sub(message, secondSeperator+1)
				end
				
				thirdSeperator,_ = string.find(message, "_")
				if thirdSeperator ~= nil then
					eventType = string.sub(message, 0, thirdSeperator-1)
					message = string.sub(message, thirdSeperator+1)
				end
				
				fourthSeperator,_ = string.find(message, "_")
				if firstSeperator ~= nil then
					eventTime = string.sub(message, 0, fourthSeperator-1)
					message = string.sub(message, fourthSeperator+1)
				end
				
				for _,v in pairs(RareIDs) do
					if v == eventRareID and eventType ~= nil and eventTime ~= nil then
						if eventType == "alive" then
							RareAlive[v] = eventTime
						elseif eventType == "dead" then
							RareAlive[v] = nil
							RareAliveHP[v] = nil
						elseif eventType == "killed" then
							RareKilled[v] = eventTime
							RareAlive[v] = nil
							RareAliveHP[v] = nil
						elseif eventType == "seen" then
							RareSeen[v] = eventTime
						end
						updateText(self, 100)
						self:CompareVersion(eventVersion)
						break
					end
				end
				needStatus = false
			end
		end
	end
end

function RC:CompareVersion(v)
	local i=0
	local newVersion=false
	local myexp, mycpatch, mympatch, myrev, otherexp, othercpatch, othermpatch, otherrev 
	for n in string.gmatch(self.version, "%d+") do
		if     i == 0 then myexp = tonumber(n)
		elseif i == 1 then mycpatch = tonumber(n)
		elseif i == 2 then mympatch = tonumber(n)
		elseif i == 3 then myrev = tonumber(n)
		end
		i = i + 1
	end
	i=0
	for n in string.gmatch(v, "%d+") do
		if     i == 0 then otherexp = tonumber(n)
		elseif i == 1 then othercpatch = tonumber(n)
		elseif i == 2 then othermpatch = tonumber(n)
		elseif i == 3 then otherrev = tonumber(n)
		end
		i = i + 1
	end
	if otherexp > myexp then
		newVersion = true
	end
	if othercpatch > mycpatch and otherexp == myexp then
		newVersion = true
	end
	if othermpatch > mympatch and otherexp == myexp and othercpatch == mycpatch then
		newVersion = true
	end
	if otherrev > myrev and otherexp == myexp and othercpatch == mycpatch and othermpatch == mympatch then
		newVersion = true
	end
	if newVersion and VersionNotify == false then
		--print("RareCoordinator - New Version available: |cff00ff00"..v.."|r (You are using |cffff0000"..RC.version.."|r)")
		VersionNotify = true
		self.message.text:SetText("New Version available: |cff00ff00"..v.."|r")
		self.message:Show()
	end
end

--3/8 18:03:12.537 UNIT_DIED,0x0000000000000000,nil,        0x80000000,  0x80000000,0xF13108BC0004C67E,"Creeping Moor Beast",0x10a48,0x0
function RC:CombatLog(timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	local unittype, _, serverID, instanceID, zoneUID, npcID, spawnUID = strsplit("-", destGUID or "")
	npcID = tonumber(npcID)
	if event == "UNIT_DIED" then
		for _,v in pairs(RareIDs) do
			if v == npcID then
					msg = time() .. " Rare Mob killed: " .. v
					RareKilled[v] = time()
					--self:DebugMsg(msg)
					SendChatMessage("[RCELVA]"..self.version.."_"..npcID.."_killed_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
					RareAlive[v] = nil
					RareAliveHP[v] = nil
					SendChatMessage("[RCELVA]"..self.version.."_"..npcID.."_dead_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
					if RareAnnouncedSelf[v] then
						SendChatMessage("{rt8} [RareCoordinator] "..RC:getLocalRareName(npcID).." is now dead {rt8}", "CHANNEL", nil, 1)
						RareAnnouncedSelf[v] = nil
						RareAnnounced[v] = nil
					end
					self:removeWaypoint(v)
					updateText(self, 100)
				break
			end
		end
	else
		if npcID then
			for _,v in pairs(RareIDs) do
				if v == npcID then
					self:Notify(npcID)
				end
			end
		end
	end
end

function RC:Vignette(id)
	if not id then return end
	if VignetteNotified[id] then return end
	
	VignetteNotified[id] = true
	
	local x, y, name, iconid = C_Vignettes.GetVignetteInfoFromInstanceID(id)
	
	for k,v in pairs(RareIDs) do
		if not RC:IsIgnoredRareID(v) and RC:getLocalRareName(v):match(name)then
			RC:Notify(v)
		end
	end
end

function RC:ChanRosterUpdate(id)
	if needStatus == true then
		--print ("roster update: ".. id)
		--print (GetChannelDisplayInfo(id))
		local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo(id)
		if name == "RCELVA" then
			self:SetScript("OnUpdate", nil)
			--print("Got displayId of "..name..": "..id)
			
			local count = select(5, GetChannelDisplayInfo(id))
			--print("count"..count)
			for i=1,count do
				local name = select(1, GetChannelRosterInfo(id, i))
				local owner = select(2, GetChannelRosterInfo(id, i))
				if owner then
					--print(name .." is the owner right now")
					SendAddonMessage("RCELVA", "GetStatus", "WHISPER", name)
					--print("Requesting update from "..name)
					updateText(self, 100)
				end
			end
		end
	end
end

function RC:getChanID(...)
	if myChan ~= false then
		return myChan
	end
	local gotID = false
	for i = 1, select("#", ...), 2 do
		local id, name = select(i, ...)
		if name == "RCELVA" then
			gotID = true
			myChan = id
			return id
		end
	end
	if gotID == false then
		return false
	end
end

function RC:getChanDisplayID()
	local channels = GetNumDisplayChannels()
	local i = 1 
	
	while i <= channels do
		SetSelectedDisplayChannel(i)
		local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo(i)
		if name == "RCELVA" then
			--print("Got displayId of "..name..": "..i)
			return i
		end
		i = i + 1
	end
end

function RC:getChanOwner()
	local id = self:getChanDisplayID()
	if id ~= nil then
		SetSelectedDisplayChannel(id)
		local count = select(5, GetChannelDisplayInfo(id))
		--print("count"..count)
		for i=1,count do
			local name = select(1, GetChannelRosterInfo(id, i))
			local owner = select(2, GetChannelRosterInfo(id, i))
			if owner then
				return name
			end
		end
	end
end

function RC:Target(...)
--/run print(("NPC ID of %s: %d"):format(UnitName("target"), tonumber(UnitGUID("target"):sub(6, 10), 16)))
--[Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[Spawn UID] 
	if UnitGUID("target") ~= nil then
		local guid = UnitGUID("target")
		local unittype, _, serverID, instanceID, zoneUID, npcID, spawnUID = strsplit("-", guid or "")
		local id = tonumber(npcID)
		for _,v in pairs(RareIDs) do
			if v == id then
					msg = time() .. " Rare Mob targeted: " .. id
					if UnitHealth("target") > 0 then
						local per = self:getTargetPercentHProunded()
						RareAlive[v] = time()
						if per == 100 then
							SendChatMessage("[RCELVA]"..self.version.."_"..id.."_alive100"..getFormattedCurrentPlayerPosition().."_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
						else
							SendChatMessage("[RCELVA]"..self.version.."_"..id.."_alive_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
						end
					else
						RareAlive[v] = nil
						RareAliveHP[v] = nil
						self:removeWaypoint(v)
						SendChatMessage("[RCELVA]"..self.version.."_"..id.."_dead_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
					end
					RareSeen[v] = time()
					if LastSent[v] == nil then
						SendChatMessage("[RCELVA]"..self.version.."_"..id.."_seen_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
						LastSent[v] = time()
					else
						if (LastSent[v] + 30) < time() then
							SendChatMessage("[RCELVA]"..self.version.."_"..id.."_seen_"..time().."_", "CHANNEL", nil, self:getChanID(GetChannelList()))
							LastSent[v] = time()
						end
					end
					--self:DebugMsg(msg)
					updateText(self, 100)
				break
			end
		end
	end
end

local waittime = 0
function RC.join(self, elapsed)
  waittime = waittime + elapsed
  if waittime > 1 then
	local id = self:getChanID(GetChannelList())
	if ( id == false ) then 
		--print("no id, joining")
		JoinChannelByName("RCELVA")
		if RegisterAddonMessagePrefix("RCELVA") ~= true then
			print("RareCoordinator: Couldn't register AddonPrefix")
		end
		chanchecked = 0
		needStatus = true
		--print("getting status from" .. owner)
		--SendAddonMessage("RCELVA", "GetStatus", "WHISPER", owner)
	else
		--self:SetScript("OnUpdate", nil)
		local channels = GetNumDisplayChannels()
		if channels > chanchecked then
			SetSelectedDisplayChannel(channels - chanchecked)
			--print("channel: "..tostring(channels - chanchecked))
			chanchecked = chanchecked + 1 
		else
			chanchecked = 0
		end

	end	
	waittime = 0
  end
end


function RC:ShowNotifyClose(p)
	if p then
		RCnotify.closeicon:Show()
	else
		RCnotify.closeicon:Hide()
	end
end

function RC:Notify(id)
	if RCDB.notify then
		if RareNotified[id] == nil or time()-RareNotified[id] > 10*60 then
			if not InCombatLockdown() then
				RCPlaySoundFile(SoundsToPlay[RCDB.sound], "MASTER")
				SoundPlayed[id] = time()
				
				RCnotify.model:SetCreature(id)
				C_Timer.After(1, function() RCnotify.model:SetCreature(id) end)
				
				RCnotify.name:SetText(self:getLocalRareName(id))
				--RCnotify:SetScript("OnMouseDown", function (self) OnMouseDownTarget() end
				local n=self:getLocalRareName(id)
				if n:find("%(") then
					n = n:sub(0,n:find("%(")-1)
				end
				RCnotify:SetAttribute("macrotext", "/cleartarget\n/targetexact ".. n);
				RCnotify:Show()
				RareNotified[id] = time()
			end
		end
	end
end


SLASH_RARECOORDINATOR1 = "/rare"
SLASH_RARECOORDINATOR2 = "/rarecoordinator"
SLASH_RARECOORDINATOR3 = "/rc"
local function SlashHandler(msg, editbox)
	--print("Usage")
	LockOrUnlock()
end
SlashCmdList["RARECOORDINATOR"] = SlashHandler;

RC.updater = CreateFrame("Frame", "RC.updater", RC)
RC.updater:SetScript("OnUpdate", updateText)

RC:SetScript("OnEvent", RC.OnEvent)


--ONLY FOR TESTING
--		RC:SetScript("OnUpdate", RC.join)
		
		
RC:RegisterEvent("ADDON_LOADED")
RC:RegisterEvent("CHAT_MSG_CHANNEL")
RC:RegisterEvent("CHAT_MSG_ADDON")
RC:RegisterEvent("PLAYER_ENTERING_WORLD")
RC:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RC:RegisterEvent("CHANNEL_ROSTER_UPDATE")
RC:RegisterEvent("GROUP_ROSTER_UPDATE")



RC.opt.locked.button:SetScript("OnClick", function(self) LockOrUnlock() end)
RC.opt.moreconfig.button:SetScript("OnClick", function(self)  InterfaceOptionsFrame_OpenToCategory("List");InterfaceOptionsFrame_OpenToCategory("List") end)

updateText(RC, 100)
onResize(RC, RC:GetWidth(), 0, RareIDs)
RC:Show()


-- API

function RC:GetSortedRareNamesAndIDs()
	local t,i = {},0
	for i=1,#RareIDs do
		t[i] = {id=RareIDs[i], name=self:getLocalRareName(RareIDs[i])}
	end
	sort(t, function(a,b) return a.name<b.name end)
	return t
end

function RC:SetIgnoredRareIDs(t)
	local ignoredRareIDs = {}
	for k,v in pairs(t) do
		table.insert(ignoredRareIDs, v)
	end
	RCDB.ignoredRareIDs = ignoredRareIDs
	
	local sorted = RC:createSortedTable(false)
	self.RareCount = #sorted
	onResize(self, self:GetWidth(), self:GetHeight())
	updateText(self,100)
end

function RC:GetIgnoredRareIDs()
	if RCDB.ignoredRareIDs == nil then return {} end
	local t = {}
	for k,v in ipairs(RCDB.ignoredRareIDs) do
		t[v] = true
	end
	return t
end

function RC:IsIgnoredRareID(id)
	if RCDB.ignoredRareIDs == nil then return false end
	for k,v in ipairs(RCDB.ignoredRareIDs) do
		if v == id then
			return true
		end
	end
	return false
end
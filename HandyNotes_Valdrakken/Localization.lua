local Handynotes_Valdrakken, L = ...; -- Let's use the private table passed to every .lua 

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
    L["Test"] = "Test text"

    --notes
    L["Soragosa"] = "Soragosa"
    L["Pax"] = "Threadfinder Pax\nThreadfinder Fulafong"
    L["Giera"] = "Giera"
    L["Koruz"] = "Hideshaper Koruz\nRalathor the Rugged"
    L["Rostrum"] = "Rostrum of Transformation"
    L["Lithragosa"] = "Lithragosa\n(multi-person dragonriding)"
    L["Expordira"] = "Expordira\nImporigo\nAntiqdormi"
    L["Sekita"] = "Sekita the Burrower"
    L["Kuroko"] = "Metalshaper Kuroko"
    L["Koref"] = "Weaponsmith Koref\nProvisioner Thom\nArmorsmith Terisk"
    L["Shatterboom"] = "Clinkyclick Shatterboom"
    L["Erugosa"] = "Erugosa"
    L["Toklo"] = "Toklo"
    L["Talendara"] = "Talendara"
    L["Conflago"] = "Conflago"
    L["Scaravelle"] = "Scaravelle"
    L["Tuluradormi"] = "Tuluradormi"
    L["Vekkalis"] = "Vekkalis\nNumernormi\nAeoreon"
    L["Visage"] = "Visage of True Self"
    L["Jyhanna"] = "Jyhanna"
    L["Tithris"] = "Tithris"
    L["PortalsOrgSW"] = "Orgrimmar / Stormwind"
    L["Rethelshi"] = "Rethelshi\nMythressa"
    L["Agrikus"] = "Agrikus"
    L["Kaestrasz"] = "Kaestrasz"
    L["Dayelis"] = "Warpweaver Dayelis\nVaultkeeper Aleer"
    L["Mairadormi"] = "Mairadormi"
    L["Lysindra"] = "Lysindra"
    L["Tethalash"] = "Tethalash"
    L["Cereus"] = "Gardener Cereus"
    L["Kama"] = "Groundskeeper Kama"
    L["Unatos"] = "Unatos"
    L["Kritha"] = "Kritha\nEmote '/bow' at the Odd Statue in the Roasted Ram to teleport into the hidden room."
    L["Sorotis"] = "Sorotis"
    L["Malicia"] = "Malicia\nFieldmaster Emberath\nInside Gladiator's Refuge."
    L["GladiatorRefuge"] = "Inside Gladiator's Refuge."
    L["Aluri"] = "Aluri"

    --RP notes
    L["note38"] = "No NPCs\nHas a bed & some ground pillows"
    L["note39"] = "Tea Testing Emporium\nHas some seats"
    L["note40"] = "Cascade's Edge Vista\nHas benches & seats"
    L["note41"] = "Fallingwater Overlook\nSpeak to Cadrestrasz to buy a VIP Pass\nHas consumable teas & foods"
    L["note42"] = "The Petitioner's Concourse\nNo NPCs\nHas seats"
    L["note43"] = "The Petitioner's Concourse\nOpen empty area"
    L["note44"] = "Below Valdrakken, entrance in Thaldraszus"
    L["note45"] = "Little Scales Daycare\nHas a bunch of cute whelps and a few places to sit"
    L["note46"] = "Some interactible NPCs"
    L["note47"] = "Weyrnrest\nSome interactible NPCs\n2 beds & some seats"
    L["note48"] = "Mage Building\nNo NPCs\nHas 1 seat"
    L["note49"] = "The Sapphire Enclave Vista\nSmall ledge with benches"
    L["note50"] = "Azure Archives Annex\nSome interactible NPCs\nPettable cat\nTower Teleport rune outside"
    L["note51"] = "Sabigosa's House\nSome interactible NPCs\nHas seats"
    L["note52"] = "The Literary Vista\nMany NPCs"
    L["note53"] = "Empty Restaurant\nNo NPCs\nHas seats"
    L["note54"] = "Arguing Gardener's Building"
    L["note55"] = "The Ruby Enclave Vista\nSome NPCs\nHas benches"
    L["note56"] = "The Ruby Feast\nMany NPCs\nInteractible foods"
    L["note57"] = "Titanic Watcher Island\nLake area with ducks&fish"
    L["note58"] = "Picnic Area\nNo NPCs"
    L["note59"] = "Mage Building\n1 NPC\nHas 2 seats"
    L["note60"] = "No NPCs\nHas bed & seat"
    L["note61"] = "The Emerald Enclave Vista\nOpen empty area"
    L["note62"] = "Wistera's Dreamroom\nSome NPCs"
    L["note63"] = "The Bronze Enclave Vista\nOpen area"
    L["note64"] = "Rathos's House\n1 NPC\nHas bed"
    L["note65"] = "No NPCs\nHas a bed & some seats"
    L["note66"] = "The Emerald Enclave Vista\nSome NPCs\nHas benches"
    L["note67"] = "Dragon Runestones Vista"
    L["note68"] = "Gardens of Unity Vista\nHas some NPCs and places to explore"
    L["note69"] = "Serene Dreams Spa Cliffside\nHas NPCs\nLower surrounding area has hostiles"
    L["note70"] = "Serene Dreams Spa Floating Island\nRequires flight\nHas NPCs\nLower surrounding area has hostiles"
    L["note71"] = "The Roasted Ram\nHas some NPCs\nHas a few beds & seats and a second floor\nA secret area can be accessed by performing '/bow' at the Odd Statue"
    L["note72"] = "The Badlands (Uldaman)"
    L["note73"] = "Vashj'ir / Gorgrond / Val'sharah / Zuldazar / Drustvar"

    --Titles
    L["renown"] = "Renown Vendor"
    L["petbattle"] = "Pet Charms"
    L["primalist"] = "Primal Research"
    L["mounts"] = "Quartermaster"
    L["pvp"] = "PvP Vendors"
    L["enchanting"] = "Enchanting Trainer"
    L["tailoring"] = "Tailoring Trainer"
    L["leatherworking"] = "Leatherworking Trainer\nSkinning Trainer"
    L["mining"] = "Mining Trainer"
    L["blacksmith"] = "Blacksmithing Trainer"
    L["engineer"] = "Engineering Trainer"
    L["cooking"] = "Cooking Trainer"
    L["fishing"] = "Fishing Trainer"
    L["inscription"] = "Inscription Trainer"
    L["alchemy"] = "Alchemy Trainer"
    L["jewelcraft"] = "Jewelcrafting Trainer"
    L["herb"] = "Herbalism Trainer"
    L["dragonriding"] = "Dragonriding"
    L["auction"] = "Auction House"
    L["craftorder"] = "Crafting Orders"
    L["banking"] = "Bank\nGuild Vault\nGreat Vault"
    L["barber"] = "Barber"
    L["inn"] = "Innkeeper"
    L["portal"] = "Portal"
    L["stables"] = "Stable Master"
    L["transmog"] = "Transmogrifier\nVoid Storage"
    L["dummy"] = "Training Dummies"
    L["taxi"] = "Flight Master"
    L["building"] = "Building"
    L["vista"] = "Vista"
    L["bmah"] = "Black Market Auction House"

return end

if LOCALE == "esES" or LOCALE == "esMX" then
    -- Spanish translations go here

return end

if LOCALE == "deDE" then
    -- German translations go here

return end

if LOCALE == "frFR" then
    -- French translations go here

return end

if LOCALE == "itIT" then
    -- French translations go here

return end

if LOCALE == "ptBR" then
    -- Brazilian Portuguese translations go here

-- Note that the EU Portuguese WoW client also
-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
    -- Russian translations go here

return end

if LOCALE == "koKR" then
    -- Korean translations go here

return end

if LOCALE == "zhCN" then
    -- Simplified Chinese translations go here

return end

if LOCALE == "zhTW" then
    -- Traditional Chinese translations go here

return end

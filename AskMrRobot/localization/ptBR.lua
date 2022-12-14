local L = LibStub("AceLocale-3.0"):NewLocale("AskMrRobot", "ptBR", false)

if L then


--[[----------------------------------------------------------------------
General
------------------------------------------------------------------------]]

L.SpecsShort = {
	[1] = "Blood", -- DeathKnightBlood
    [2] = "Frost", -- DeathKnightFrost
    [3] = "Unholy", -- DeathKnightUnholy
	[4] = "Havoc", -- DemonHunterHavoc
	[5] = "Vengeance", -- DemonHunterVengeance
    [6] = "Moon", -- DruidBalance
    [7] = "Feral", -- DruidFeral
    [8] = "Bear", -- DruidGuardian
    [9] = "Resto", -- DruidRestoration
    [10] = "Devastate", -- EvokerDevastation
    [11] = "Preserve", -- EvokerPreservation
    [12] = "BM", -- HunterBeastMastery
    [13] = "Marks", -- HunterMarksmanship
    [14] = "Survival", -- HunterSurvival
    [15] = "Arcane", -- MageArcane
    [16] = "Fire", -- MageFire
    [17] = "Frost", -- MageFrost
    [18] = "Brew", -- MonkBrewmaster
    [19] = "Mist", -- MonkMistweaver
    [20] = "Wind", -- MonkWindwalker
    [21] = "Holy", -- PaladinHoly
    [22] = "Prot", -- PaladinProtection
    [23] = "Ret", -- PaladinRetribution
    [24] = "Disc", -- PriestDiscipline
    [25] = "Holy", -- PriestHoly
    [26] = "Shadow", -- PriestShadow
    [27] = "Assn", -- RogueAssassination
    [28] = "Outlaw", -- RogueOutlaw
    [29] = "Sub", -- RogueSubtlety
    [30] = "Elem", -- ShamanElemental
    [31] = "Enh", -- ShamanEnhancement
    [32] = "Resto", -- ShamanRestoration
    [33] = "Aff", -- WarlockAffliction
    [34] = "Demo", -- WarlockDemonology
    [35] = "Destro", -- WarlockDestruction
    [36] = "Arms", -- WarriorArms
    [37] = "Fury", -- WarriorFury
    [38] = "Prot", -- WarriorProtection
}

-- stat strings for e.g. displaying gem/enchant abbreviations, make as short as possible without being confusing/ambiguous
L.StatsShort = {
    ["Strength"] = "For",
    ["Agility"] = "Agi",
    ["Intellect"] = "Int",
    ["CriticalStrike"] = "Crit",
    ["Haste"] = "Aceler",
    ["Mastery"] = "Maestria",
    ["Multistrike"] = "Multi",
    ["Versatility"] = "Vers",
    ["BonusArmor"] = "Armad",
    ["Spirit"] = "Esp??r",
    ["Dodge"] = "Esquiva",
    ["Parry"] = "Aparar",
    ["MovementSpeed"] = "Veloc",
    ["Avoidance"] = "Evas??o",
    ["Stamina"] = "Estam",
    ["Armor"] = "Armad",
    ["AttackPower"] = "Pod Ataq",
    ["SpellPower"] = "Pod M??g",
    ["PvpResilience"] = "Resil PvP",
    ["PvpPower"] = "Pod PvP",
}

L.InstanceNames = {
    [1861] = "Uldir",
    [2070] = "Dazar'alor",
    [2096] = "Crucible of Storms",
    [2164] = "The Eternal Palace",
    [2217] = "Ny'alotha",    
    [2296] = "Castle Nathria",
    [2450] = "Sanctum of Domination",
    [2481] = "Sepulcher of the First Ones",
    [2522] = "Vault of the Incarnates"
}

L.DifficultyNames = {
	[17] = "LDR",
	[14] = "Normal",
	[15] = "Her??ico",
	[16] = "M??tico"
}

L.WeaponTypes = {
	None     = "Nenhum",
	Axe      = "Machado",
	Mace     = "Clava",
	Sword    = "Espada",
	Fist     = "Arma de Punho",
	Dagger   = "Adaga",
	Staff    = "Cajado",
	Polearm  = "Arma de Haste",
	OffHand  = "M??o Secund??ria",
	Shield   = "Escudo",
	Wand     = "Varinha",
	Bow      = "Arco",
	Gun      = "Arma de Fogo",
	Crossbow = "Besta",
	Warglaive= "Glaive de Guerra"
}

L.ArmorTypes = {
	None    = "Nenhum",
	Plate   = "Placa",
	Mail    = "Malha",
	Leather = "Couro",
	Cloth   = "Tecido"
}

L.OneHand = "Uma M??o"
L.TwoHand = "Duas M??os"
L.OffHand = "M??o Secund??ria"


--[[----------------------------------------------------------------------
Main UI
------------------------------------------------------------------------]]
L.AlertOk = "OK"
L.CoverCancel = "cancelar"

L.MinimapTooltip = 
[[Clique com o bot??o esquerdo para abrir a janela do Ask Mr. Robot.

Clique com o bot??o direito para alternar entre specs e equipar seu equipamento salvo para cada spec.]]

L.MainStatusText = function(version, url)
	return version .. " carregado. Documenta????o dispon??vel em " .. url
end

L.TabExportText = "Exportar"
L.TabGearText = "Equipamento"
L.TabLogText = "Logs"
L.TabOptionsText = "Op????es"

L.VersionChatTitle = "Vers??o do Addon AMR:"
L.VersionChatNotInstalled = "N??O INSTALADO"
L.VersionChatNotGrouped = "Voc?? n??o est?? em um grupo ou raid!"


--[[----------------------------------------------------------------------
Export Tab
------------------------------------------------------------------------]]
L.ExportTitle = "Instru????es de Exporta????o"
L.ExportHelp1 = "1. Copie o texto abaixo pressionando Ctrl+C (ou Cmd+C em um Mac)"
L.ExportHelp2 = "2. V?? para https://www.askmrrobot.com e clique no seletor de personagem"
L.ExportHelp3 = "3. Cole o texto copiado na caixa de texto da se????o ADDON"

L.ExportSplashTitle = "Come??ando"
L.ExportSplashSubtitle = "Esta ?? a primeira vez que voc?? usa a nova vers??o do addon. Fa??a o seguinte para inicializar o banco de dados dos seus itens:"
L.ExportSplash1 = "1. Ative cada um dos seus specs uma vez e equipe seu equipamento atual para cada spec"
L.ExportSplash2 = "2. Abra seu banco e deixe-o aberto por pelo menos dois segundos"
L.ExportSplashClose = "Continuar"


--[[----------------------------------------------------------------------
Gear Tab
------------------------------------------------------------------------]]
L.GearImportNote = "Clique em Importar para inserir dados do website."
L.GearBlank = "Voc?? ainda n??o carregou nenhum equipamento para essa spec."
L.GearBlank2 = "V?? para askmrrobot.com para otimizar seu equipamento, ent??o use o bot??o importar ?? esquerda."
L.GearButtonEquip = function(spec)
	return string.format("Ativar Spec %s e Usar Equipamento", spec)
end
L.GearButtonJunk = "Mostrar Lista de Junk"
L.GearButtonShop = "Mostrar Lista de Compras"

L.GearEquipErrorCombat = "Imposs??vel trocar spec/equipamento em combate!"
L.GearEquipErrorEmpty = "Nenhum conjunto de equipamento salvo foi encontrado para o spec atual."
L.GearEquipErrorNotFound = "Um item no seu conjunto de equipamento salvo n??o pode ser equipado."
L.GearEquipErrorNotFound2 = "Tente abrir seu banco e execute este comando novamente ou verifique seu banco et??reo."
L.GearEquipErrorBagFull = "N??o h?? espa??o suficiente em suas bolsas para equipar seu conjunto de equipamento salvo."
L.GearEquipErrorSoulbound = function(itemLink)
	return itemLink .. " n??o pode ser equipado porque n??o est?? vinculado a voc??."
end

L.GearButtonImportText = "Importar"
L.GearButtonCleanText = "Bolsas Limpas"

L.GearTipTitle = "DICAS!"
L.GearTipText = 
[[Nas Op????es voc?? pode escolher trocar automaticamente seus conjuntos de equipamento sempre que mudar sua spec.

Ou, voc?? pode clicar com o bot??o direito no ??cone do minimapa para trocar a spec e usar o equipamento.

Ou! Voc?? pode usar linhas de comando:]]

L.GearTipCommands = 
[[/amr equip [1-4]
sem arg = rotaciona]]
-- note to translators: the slash commands are literal and should stay as english

L.GearTalentError1 = "Unable to load your AMR setup talents at this time."


--[[----------------------------------------------------------------------
Import Dialog on Gear Tab
------------------------------------------------------------------------]]
L.ImportHeader = "Aperte Ctrl+V (Cmd+V em um Mac) para colar dados do website na caixa abaixo."
L.ImportButtonOk = "Importar"
L.ImportButtonCancel = "Cancelar"

L.ImportErrorEmpty = "Os dados est??o vazios."
L.ImportErrorFormat = "Os dados n??o est??o no formato correto."
L.ImportErrorVersion = "Os dados s??o de uma vers??o anterior do addon. Por favor, v?? ao website e gere novos dados."
L.ImportErrorChar = function(importChar, yourChar)
	return "Os dados s??o para " .. importChar .. ", mas voc?? est?? com " .. yourChar .. "!"
end
L.ImportErrorRace = "Parece que sua ra??a mudou. Por favor v?? ao website e otimize novamente."
L.ImportErrorFaction = "Parece que sua fac????o mudou. Por favor v?? ao website e otimize novamente."
L.ImportErrorLevel = "Parece que seu n??vel mudou. Por favor v?? ao website e otimize novamente."

L.ImportOverwolfWait = "Executando otimiza????o Melhor nas Bolsas. Por favor n??o aperte ESC ou feche o addon at?? que ele tenha completado!"


--[[----------------------------------------------------------------------
Junk List
------------------------------------------------------------------------]]
L.JunkTitle = "Junk List"
L.JunkEmpty = "You have no junk items"
L.JunkScrap = "Click an item to add to the scrapper"
L.JunkVendor = "Click an item to sell"
L.JunkDisenchant = "Click an item to disenchant"
L.JunkBankText = function(count)
	return count .. " junk items are not in your bags"
end
L.JunkMissingText = function(count)
    return "Warning! " .. count .. " junk items could not be found"
end
L.JunkButtonBank = "Retrieve from Bank"
L.JunkOutOfSync = "An item in your junk list could not be found. Try opening your bank for a few seconds, then export to the website, then import again."
L.JunkItemNotFound = "That item could not be found in your bags. Try closing and opening the Junk List to refresh it."


--[[----------------------------------------------------------------------
Shopping List
------------------------------------------------------------------------]]
L.ShopTitle = "Lista de Compras"
L.ShopEmpty = "N??o h?? lista de compras para esse personagem."
L.ShopSpecLabel = "Spec"
L.ShopHeaderGems = "Gemas"
L.ShopHeaderEnchants  = "Encantamentos"
L.ShopHeaderMaterials = "Materiais de Encantamentos"


--[[----------------------------------------------------------------------
Combat Log Tab
------------------------------------------------------------------------]]
L.LogChatStart = "Agora voc?? est?? logando os combates." -- , e o Mr. Robot est?? logando dados dos personagens para sua raid
L.LogChatStop = "O log de combate foi interrompido."

L.LogChatWipe = function(wipeTime)
	return "Wipe manual invocado em " .. wipeTime .. "."
end
L.LogChatUndoWipe = function(wipeTime)
	return "Wipe manual em " .. wipeTime .. " foi removido."
end
L.LogChatNoWipes = "N??o h?? wipes manuais recentes para serem removidos."

L.LogButtonStartText = "Iniciar Log"
L.LogButtonStopText = "Parar Log"
L.LogButtonReloadText = "Recarregar UI"
L.LogButtonWipeText = "Wipe!"
L.LogButtonUndoWipeText = "Desfazer Wipe"

L.LogNote = "Voc?? est?? fazendo log de combate no momento."
L.LogReloadNote = "Saia do WoW completamente ou recarregue sua UI imediatamente antes de enviar um arquivo de log."
L.LogWipeNote = "A pessoa enviando o log precisa ser a mesma a usar este comando wipe."
L.LogWipeNote2 = function(cmd)
	return "'" .. cmd .. "' tamb??m far?? isso."
end
L.LogUndoWipeNote = "??ltimo wipe chamado:"
L.LogUndoWipeDate = function(day, timeOfDay)
	return day .. " ??s " .. timeOfDay
end

L.LogAutoTitle = "Log Autom??tico"
L.LogAutoAllText = "Alternar Tudo"

L.LogInstructionsTitle = "Instru????es!"
L.LogInstructions = 
[[1.) Clique em Iniciar Log ou habilite o Log Autom??tico para suas raids escolhidas.

2.) Quando estiver pronto para enviar, saia do world of Warcraft* ou recarregue sua UI.**

3.) Execute o Cliente AMR para enviar seu log.


*N??o ?? obrigat??rio sair do WoW, mas ?? altamente recomendado. Isso permitir?? que o Cliente AMR evite que o arquivo de log fique muito grande.

**O addon AMR coleta dados extra no inicio de cada encontro para todos os jogadores na sua raid que estejam com o addon AMR. N??o ?? necess??rio que outros jogadores liguem seus logs! Eles s?? precisam ter o addon instalado e ligado. Esses dados s??o salvos no disco apenas se voc?? sair do WoW ou recarregar sua UI antes de fazer upload.
]]


--[[----------------------------------------------------------------------
Options Tab
------------------------------------------------------------------------]]
L.OptionsHeaderGeneral = "Op????es Gerais"

L.OptionsHideMinimapName = "Esconder ??cone do minimapa"
L.OptionsHideMinimapDesc = "O ??cone do minimapa ?? apenas para conveni??ncia. Todas as a????es tamb??m podem ser executadas via linha de comando ou pela UI."

L.OptionsAutoGearName = "Trocar equipamento automaticamente ao trocar de spec"
L.OptionsAutoGearDesc = "Sempre que trocar a spec (via UI no jogo, outro addon, etc.), suas listas de equipamentos importadas (na guia Equipamento) ser??o equipadas automaticamente."

L.OptionsJunkVendorName = "Automatically show junk list at vendors and scrapper"
L.OptionsJunkVendorDesc = "Whenever you open the scrapper or a vendor, automatically show the junk list window if your list is not empty."

L.OptionsShopAhName = "Mostrar automaticamente a lista de compras na casa de leil??es"
L.OptionsShopAhDesc = "Sempre que voc?? abrir a casa de leil??es, automaticamente ser?? mostrada a janela da lista de compras. Voc?? pode clicar nos itens da lista de compras para procurar rapidamente por eles na casa de leil??es."

L.OptionsDisableEmName = "Desligar cria????o de listas do Gerenciador de Equipamentos"
L.OptionsDisableEmDesc = "Uma lista no Gerenciador de Equipamentos da Blizzard ?? criada sempre que voc?? equipa uma lista de equipamentos do AMR. Isso ?? ??til para marcar itens nas suas listas otimizadas. Marque para desligar este padr??o, se desejar."

L.OptionsDisableTalName = "Do not change talents when changing gear sets"
L.OptionsDisableTalDesc = "A setup sent to the addon contains the selected talents and gear for that setup. Check this if you don't want the addon to automatically choose those talents when swapping gear."
    
L.OptionsUiScaleName = "Escala de tamanho da UI do Ask Mr. Robot"
L.OptionsUiScaleDesc = "Digite um valor entre 0.5 e 1.5 para trocar a escala de tamanho da interface de usu??rio do Ask Mr. Robot, pressione Enter, ent??o feche/abra a janela para fazer efeito. Se o posicionamento ficar bagun??ado, use o comando /amr reset."

end

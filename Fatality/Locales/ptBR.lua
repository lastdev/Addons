-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "ptBR" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "Obrigado por atualizar para a versão mais recente!"
L.welcome2 = "No futuro, para acessar este menu e configurar para cada personagem, digite |cffff9900/fatality|r ou |cffff9900/fat|r."
L.welcome3 = "|cffff0000[Nota]|r Esta mensagem será exibida uma vez por personagem."

-- Addon
L.addon_enabled = "|cff00ff00Ligado|r"
L.addon_disabled = "|cffff0000Desligado|r"

-- Damage
L.damage_overkill = "O: %s"
L.damage_resist = "R: %s"
L.damage_absorb = "A: %s"
L.damage_block = "B: %s"

-- Error Messages
L.error_report = "(%s) O relato não pode ser enviado porque passou do mínimo de caracteres possiveis de 255. Para arrumar isso, digite |cffff9900/fatality|r e ajuste suas configurações corretamente. Alternativamente, você pode configurar |cfffdcf00Configurar 'Saída' para Você mesmo|r."
L.error_options = "|cffFF9933Fatality_Options|r não pôde ser carregado."

-- Configuration: Title
L.config_promoted = "Promovido"
L.config_lfr = "LDR"
L.config_raid = "Raide"
L.config_party = "Grupo"
L.config_overkill = "Overkill"
L.config_resist = "Resistir"
L.config_absorb = "Absorção"
L.config_block = "Bloqueio"
L.config_icons = "Ícones"
L.config_school = "Elementos"
L.config_source = "Fonte"
L.config_short = "Abreviado"
L.config_limit10 = "Limite de Reportações (10 pessoas)"
L.config_limit25 = "Limite de Reportações (25 pessoas)"
L.config_history = "Histórico de Eventos"
L.config_threshold = "Dano mínimo para capturar"
L.config_output_raid = "Saída (Instâncias em raide)"
L.config_output_party = "Saída (Instâncias em grupo)"

-- Configuration: Description
L.config_promoted_desc = "Somente anúnciar se promovido ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "Habilitar dentro do Localizador de Raides"
L.config_raid_desc = "Habilitar dentro de instâncias de raide"
L.config_party_desc = "Habilitar dentro de instâncias em grupo"
L.config_overkill_desc = "Incluir overkill"
L.config_resist_desc = "Incluir dano resistido"
L.config_absorb_desc = "Incluir dano absorvido"
L.config_block_desc = "Incluir dano bloqueado"
L.config_icons_desc = "Incluir ícones de raide"
L.config_school_desc = "Incluir danos por elementos"
L.config_source_desc = "Incluir quem causou o dano"
L.config_short_desc = "Números abreviados [9431 = 9.4k]"
L.config_limit_desc = "Quantas mortes devem ser reportadas por sessão de combate?"
L.config_history_desc = "Quantos eventos de dano devem ser reportados por pessoa?"
L.config_threshold_desc = "Qual a quantidade de dano mínimo necessária para ser capturado?"
L.config_channel_default = "<Nome do Canal>"
L.config_whisper_default = "<Nome do Personagem>"
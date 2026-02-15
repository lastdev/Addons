local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "ptBR")

if not L then return end

-- translated using chatgpt

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Coleções de Khamul para o Filtro de Conquistas do Krowi"
L["Khamul's Meta-Expansion Achievement List"] = "Coleção de meta-montarias do Khamul"
L["Khamul's House Decor Achievement List"] = "Coleção de decorações do Khamul"
L["Khamul's Campsite Achievement List"] = "Coleção de acampamentos do Khamul"
L["Khamul's Battle Pet Achievement List"] = "Coleção de mascotes de batalha do Khamul"

-- Special categories
L["Cross-Expansion"] = "Entre expansões"

-- Missing category titles
L["Hard"] = "Difícil"
L["Nightmare"] = "Pesadelo"

-- Tooltips
L["Tt_ACM_15035"] = "Apenas 4 são necessários para concluir a meta-conquista"
L["Tt_UseMetaAchievementPlugin"] = "Use a categoria \"Coleção de meta-montarias do Khamul\" para obter uma visão detalhada de \"{1}\"."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "O addon Filtro de Conquistas do Krowi não foi carregado!"

-- Options
L["Show List for Expansion Meta Achievements"] = "Mostrar a coleção de meta-montarias"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "Se ativado, será exibida uma coleção com todas as conquistas necessárias para as meta-conquistas da expansão."
L["Show List for Achievements with decors as reward"] = "Mostrar coleção de conquistas com decorações como recompensa"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "Se ativado, será exibida uma coleção com todas as conquistas que concedem uma decoração como recompensa."
L["Show List for Achievements with warband campsites as reward"] = "Mostrar coleção de conquistas com acampamentos de tropa de guerra como recompensa"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "Se ativado, será exibida uma coleção com todas as conquistas que concedem um acampamento de tropa de guerra como recompensa."
L["Show List for Achievements with battle pets as reward"] = "Mostrar coleção de conquistas com mascotes de batalha como recompensa"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "Se ativado, será exibida uma coleção com todas as conquistas que concedem um mascote de batalha como recompensa."
L["Krowi AchievementFilter status: "] = "Status do Krowi AchievementFilter: "
L["detected"] = "detectado"
L["not detected"] = "não detectado"
L["Decor Collection Settings"] = "Configurações da coleção de decorações"
L["Meta-Mount Collection Settings"] = "Configurações da coleção de meta-montarias"
L["Campsite Collection Settings"] = "Configurações da coleção de acampamentos"
L["Pet Collection Settings"] = "Configurações da coleção de mascotes"
L["Flatten collection structure"] = "Simplificar a estrutura da coleção"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "A profundidade da coleção será simplificada e todas as conquistas serão exibidas na categoria da expansão."
L["Include Child Achievements"] = "Incluir conquistas dependentes"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "Se uma conquista tiver outras conquistas como requisito, elas serão exibidas em uma categoria adicional."
L["Changing any option on this page, requires a reload to take affect."] = "Alterar qualquer opção nesta página requer o recarregamento da interface para que tenha efeito."
L["Include Battle-Pet related rewards"] = "Incluir recompensas relacionadas a mascotes de batalha"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "Isso incluirá conquistas com recompensas de batalhas de mascotes, como o desbloqueio de missões diárias, fantasias e brinquedos"
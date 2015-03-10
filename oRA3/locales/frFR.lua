
if GetLocale() ~= "frFR" then return end
local _, tbl = ...
local L = tbl.locale

L["add"] = "Ajouter"
L["autoLootMethod"] = "Définir auto. le mode du butin en rejoignant un groupe"
L["autoLootMethodDesc"] = "Laisse oRA3 définir automatiquement la méthode de fouille selon ce que vous avez spécifié ci-dessous quand vous entrez dans un groupe (de raid)."
L["average"] = "Moyenne"
L["barSettings"] = "Paramètres des barres"
L["battleResLockDesc"] = "Verrouille ou non le moniteur. Ceci masquera le texte d'en-tête, l'arrière-plan, et empêchera son déplacement."
L["battleResShowDesc"] = "Affiche ou cache le moniteur."
L["battleResTitle"] = "Moniteur des rez de combat"
L["blizzMainTank"] = "Tank principal Blizzard"
L["broken"] = "Cassé"
L["byGuildRank"] = "Par rang de guilde"
L["center"] = "Centre"
L["checks"] = "Vérif."
L["cooldowns"] = "Recharges"
L["cooldownSettings"] = "Paramètres des temps de recharge"
L["customColor"] = "Couleur personnalisée"
L["deleteButtonHelp"] = "Enlève ce joueur de la liste des tanks."
L["demoteEveryone"] = "Dégrader tout le monde"
L["demoteEveryoneDesc"] = "Dégrade toutes les personnes présentes dans le groupe actuel."
L["disbandGroup"] = "Dissoudre raid"
L["disbandGroupDesc"] = [=[Dissout votre groupe ou raid actuel en renvoyant ses membres un par un jusqu'à ce que vous soyez le dernier présent.

Comme il s'agit d'une méthode radicale, une fenêtre de dialogue de confirmation vous sera présentée. Maintenez enfoncé la touche Contrôle pour éviter son apparition.]=]
L["disbandGroupWarning"] = "Êtes-vous sûr de vouloir dissoudre votre groupe ?"
L["disbandingGroupChatMsg"] = "Dissolution du groupe de raid."
L["durability"] = "Durabilité"
L["duration"] = "Durée"
L["durationTextSettings"] = "Paramètres du texte de durée"
L["ensureRepair"] = "S'assurer que les réparations de guilde sont activées pour tous les rangs du raid"
L["ensureRepairDesc"] = "Si vous êtes le maître de guilde, à chaque fois que vous rejoignez un groupe de raid dans lequel vous êtes chef ou assistant, ceci s'assurera que les réparations de guilde sont activées pendant la durée du raid (jusqu'à 300po). Une fois que vous quittez le groupe de raid, les marqueurs retrouveront leur état initial |cffff4411à condition que votre jeu ne crash pas pendant le raid.|r"
L["font"] = "Police d'écriture" -- Needs review
L["fontSize"] = "Taille de police" -- Needs review
L["gear"] = "Équipement"
L["growUpwards"] = "Ajouter vers le haut"
L["guildKeyword"] = "Mot-clé de guilde"
L["guildKeywordDesc"] = "Tout membre de votre guilde qui vous chuchote ce mot-clé sera automatiquement et immédiatement invité dans votre groupe de raid."
L["guildRankInvites"] = "Invitation selon le rang de guilde"
L["guildRankInvitesDesc"] = "En cliquant sur un des boutons ci-dessous, vous inviterez toutes les personnes du rang choisi ainsi que ceux des rangs SUPÉRIEURS dans votre groupe de raid. Un délai de 10 secondes est accordé avant l'envoi des invitations."
L["height"] = "Hauteur"
L["hideInCombat"] = "Cacher en combat"
L["hideInCombatDesc"] = "Cache automatiquement la fenêtre d'appel quand vous entrez en combat."
L["hideReadyPlayers"] = "Cacher les joueurs qui sont prêts"
L["hideReadyPlayersDesc"] = "Enlève les joueurs qui sont prêt de la fenêtre."
L["hideWhenDone"] = "Cacher la fenêtre une fois fini"
L["hideWhenDoneDesc"] = "Cache automatiquement la fenêtre quand l'appel est terminé."
L["home"] = "Domicile"
L["icon"] = "Icône"
L["individualPromotions"] = "Promotions individuelles"
L["individualPromotionsDesc"] = "Notez que les noms sont sensibles à la casse. Pour ajouter un joueur, entrez son nom dans la boîte de saisie ci-dessous et appuyez sur Entrée ou cliquez sur le bouton qui apparaît. Pour enlever un joueur, cliquez tout simplement sur son nom dans le menu déroulant ci-dessous."
L["invite"] = "Inviter" -- Needs review
L["inviteDesc"] = "Toute personne vous chuchotant un des mots-clés ci-dessous sera automatiquement invité dans votre groupe de raid. Si vous êtes dans un groupe complet, ce dernier sera converti en groupe de raid. Le mot-clé cessera de fonctionner une fois le groupe de raid complet. Ne mettez rien comme mots-clés pour désactiver cette fonction."
L["inviteGuild"] = "Inviter la guilde"
L["inviteGuildDesc"] = "Invite tous les membres de votre guilde de niveau maximal."
L["inviteGuildRankDesc"] = "Invite tous les membres de votre guilde ayant le rang %s ou supérieur."
L["inviteInRaidOnly"] = "Inviter uniquement par mot-clé si dans un groupe de raid"
L["invitePrintGroupIsFull"] = "Désolé, le groupe de raid est complet."
L["invitePrintMaxLevel"] = "Tous les personnages de niveau maximal seront invités dans le raid dans 10 sec. Veuillez quitter vos groupes."
L["invitePrintRank"] = "Tous les personnages de rang %s ou supérieur seront invités dans le raid dans 10 sec. Veuillez quitter vos groupes."
L["invitePrintZone"] = "Tous les personnages se trouvant à %s seront invités dans le raid rans 10 sec. Veuillez quitter vos groupes."
L["inviteZone"] = "Inviter la zone"
L["inviteZoneDesc"] = "Invite tous les membres de votre guilde se trouvant dans la même zone que vous."
L["itemLevel"] = "Niveau d'objet"
L["keyword"] = "Mot-clé"
L["keywordDesc"] = "Toute personne qui vous chuchote ce mot-clé sera automatiquement et immédiatement invité dans votre groupe de raid."
L["labelAlign"] = "Alignement du libellé"
L["labelTextSettings"] = "Paramètre du texte du libellé"
L["latency"] = "Latence"
L["left"] = "Gauche"
L["lockMonitor"] = "Verrouiller le moniteur"
L["lockMonitorDesc"] = "Notez que le verrouillage du moniteur des temps de regarde cachera le titre et la poignée de saisie, rendant ainsi le moniteur impossible à déplacer ou à redimensionner. Il ne sera également pas possible d'ouvrir le menu des options des barres."
L["makeLootMaster"] = "Laissez vide pour faire de vous le maître du butin."
L["massPromotion"] = "Nomination en masse"
L["minimum"] = "Minimum"
L["missingEnchants"] = "Enchantements manquants"
L["missingGems"] = "Gemmes manquantes"
L["monitorSettings"] = "Paramètres du moniteur"
L["moveTankUp"] = "Cliquez pour faire monter ce tank."
L["name"] = "Nom"
L["neverShowOwnSpells"] = "Ne jamais afficher mes propres sorts"
L["neverShowOwnSpellsDesc"] = "Enlève ou non vos propres temps de recharge de l'affichage des temps de recharge. À cocher par exemple si vous utilisez un autre addon pour afficher vos temps de recharge."
L["noResponse"] = "Pas de réponse"
L["notReady"] = "Pas prêt"
L["offline"] = "Hors ligne"
L["onlyMyOwnSpells"] = "Afficher uniquement mes propres sorts"
L["onlyMyOwnSpellsDesc"] = "Affiche ou non uniquement les temps de recharge concernant votre personnage."
L["openMonitor"] = "Ouvrir le moniteur"
L["options"] = "Options"
L["outline"] = "Contour" -- Needs review
L["printToRaid"] = "Transmettre le résultat des appels au canal Raid"
L["printToRaidDesc"] = "Si vous êtes au moins assistant, transmet le résultat des appels au canal Raid afin que tous les membres du raid puissent voir la raison du retard. Assurez-vous d'être la seule personne à avoir activé ceci."
L["profile"] = "Profil"
L["promote"] = "Nomination"
L["promoteEveryone"] = "Tout le monde"
L["promoteEveryoneDesc"] = "Nomme automatiquement assistants tout le monde."
L["promoteGuild"] = "Guilde"
L["promoteGuildDesc"] = "Nomme automatiquement assistants tous les membres de votre guilde."
L["ready"] = "Prêt"
L["readyCheckSeconds"] = "Appel (%d |4seconde:secondes;)"
L["readyCheckSound"] = "Joue le son de l'appel en utilisant le canal principal du son quand un appel est effectué. Ceci jouera le son même si \"Effets sonores\" est désactivé et à un volume supérieur."
L["remove"] = "Enlever"
L["repairEnabled"] = "Réparations de guilde activées pour %s pendant la durée de ce raid."
L["right"] = "Droite"
L["rightClick"] = "Clic droit pour les options !"
L["save"] = "Sauver"
L["saveButtonHelp"] = "Sauvegarde ce tank dans votre liste personnelle. Chaque fois que vous serez groupé avec ce joueur, il sera indiqué comme étant un tank personnel."
L["scale"] = "Échelle"
L["selectClass"] = "Choix de la classe"
L["selectClassDesc"] = "Choississez les temps de recharge à afficher en vous aidant du menu déroulant et des cases à cocher ci-dessous. Chaque classe possède un nombre limité de sorts que vous pouvez voir via l'affichage par barres. Choissisez une classe via le menu déroulant et configurer ses sorts selon vos besoins."
L["shortSpellName"] = "Nom des sorts raccourcis"
L["show"] = "Afficher"
L["showButtonHelp"] = "Affiche ce tank dans votre affichage des tanks personnels. Cette option n'a des effets que localement et ne changera pas son statut de tank pour tous les autres membres du groupe."
L["showHelpTexts"] = "Afficher l'aide de l'interface"
L["showHelpTextsDesc"] = "L'interface de oRA3 est remplie de textes d'aide permettant de mieux comprendre les différents éléments de l'interface. Désactiver cette option enlèvera ces textes, limitant l'encombrement sur chaque panneau. |cffff4411Nécessite parfois un rechargement de l'interface.|r"
L["showMonitor"] = "Afficher le moniteur"
L["showMonitorDesc"] = "Affiche ou non l'affichage des temps de recharge via des barres."
L["showRoleIcons"] = "Afficher les icônes de rôle sur le panneau raid"
L["showRoleIconsDesc"] = "Affiche les icônes de rôle et le nombre total de chaque rôle sur le panneau de raid Blizzard. Vous devrez réouvrir le panneau de raid pour que les changements de ce paramètre prennent effet."
L["showWindow"] = "Afficher la fenêtre"
L["showWindowDesc"] = "Affiche la fenêtre quand un appel est lancé."
L["slashCommands"] = [=[
oRA3 supporte toute une série de commandes « / » (ou slash) pour vous aider rapidement en raid.

|cff44ff44/radur|r - ouvre la liste des durabilités.
|cff44ff44/ragear|r - ouvre la liste des vérifications de l'équipement.
|cff44ff44/ralag|r - ouvre la liste des latences.
|cff44ff44/razone|r - ouvre la liste des zones.
|cff44ff44/radisband|r - dissout instantanément le raid sans vérification.
|cff44ff44/raready|r - fait l'appel.
|cff44ff44/rainv|r - invite l'entièreté de la guilde dans votre groupe de raid.
|cff44ff44/razinv|r - invite les membres de la guilde situés dans votre zone.
|cff44ff44/rarinv <nom du rang>|r - invite les membres de la guilde du rang donné.
]=]
L["slashCommandsHeader"] = "Commandes « / »"
L["sort"] = "Trier"
L["spawnTestBar"] = "Afficher une barre de test"
L["spellName"] = "Nom du sort"
L["tankButtonHelp"] = "Définit ou non ce joueur comme étant un tank principal Blizzard."
L["tankHelp"] = [=[Les joueurs de la liste du haut sont vos tanks personnels triés. Ils ne sont pas partagés avec le raid, et tout le monde peut avoir une liste de tanks personnelle différente. Cliquer sur un nom de la liste du bas permet d'ajouter le joueur dans votre liste personnelle.

Cliquer sur l'icône en forme de bouclier ajoutera cette personne dans la liste des tanks principaux de Blizzard. Les tanks de Blizzard sont partagées entre tous les membres de votre raid et vous devez être au moins assistant pour faire cela.

Les tanks qui apparaissent dans la liste car ajoutés par quelqu'un d'autre dans la liste des tanks principaux de Blizzard seront enlevés de la liste une fois qu'ils ne sont plus des tanks principaux de Blizzard.

Utiliser la coche pour sauvegarder un tank entre les sessions. La prochaine fois que vous serez dans un raid avec cette personne, il sera automatiquement définit comme étant un tank personnel.]=]
L["tanks"] = "Tanks"
L["tankTabTopText"] = "Cliquez sur les joueurs de la liste du bas pour les nommer tank personnel. Si vous souhaitez obtenir de l'aide, survolez le '?' avec votre souris."
L["texture"] = "Texture"
L["thick"] = "Épais" -- Needs review
L["thin"] = "Mince" -- Needs review
L["togglePane"] = "Panneau oRA3 on/off"
L["toggleWithRaid"] = "Ouvrir avec le panneau de raid"
L["toggleWithRaidDesc"] = "Ouvre et ferme le panneau de oRA3 automatiquement en même temps que le panneau de raid de Blizzard. Si vous désactivez cette option, vous pouvez toujours ouvrir le panneau de oRA3 en utilisant son raccourci clavier ou une commande slash, telle que |cff44ff44/radur|r."
L["unitName"] = "Nom unité"
L["unknown"] = "Inconnu"
L["useClassColor"] = "Couleur de classe"
L["whatIsThis"] = "Qu'est-ce que tout cela ?"
L["world"] = "Monde"
L["zone"] = "Zone"

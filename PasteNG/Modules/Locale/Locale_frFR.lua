--[[
    Copyright (C) 2024 GurliGebis

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")
if not L then return end

L["%s wants to share a paste with you. Do you want to accept it?"] = "%s souhaite partager une Note avec vous.|nSouhaitez-vous l'accepter ?"
L["/pasteng config - Open the configuration"] = "/pasteng config - Ouvre la configuration"
L["/pasteng minimap - Toggle the minimap icon"] = "/pasteng minimap - Afficher / masquer l'icône sur la mini-carte"
L["/pasteng send Saved Paste name - Send a save paste to the default channel"] = "/pasteng send \"Nom de la Note\" - Envoyer une Note enregistrée sur le canal par défaut"
L["/pasteng send Saved Paste name channel - Send a save paste to a specific channel"] = "/pasteng send \"Nom de la Note\" \"Nom du canal\" - Envoyer une Note enregistrée sur un canal spécifique"
L["/pasteng show - Show the pasteng dialog"] = "/pasteng show - Afficher la fenêtre de PasteNG"
L["Battle.net friend not found."] = "Ami Battle.net introuvable"
L["characters"] = "caractères"
L["Clear"] = "Nettoyer"
L["Command-V"] = "Maj + V"
L["Control-V"] = "Ctrl + V"
L["Copy the export data below and save it to a file:"] = "Copier les données d'exportation ci-dessous et enregistrez-les dans un fichier :"
L["Create a key binding to open the PasteNG window"] = "Créer un raccourci pour ouvrir la fenêtre de PasteNG"
L["Delete"] = "Supprimer"
L["Disable announcements"] = "Désactiver les annonces"
L["Disable announcing presence to party/raid members when joining groups"] = "Désactiver l'annonce de présence aux membres du groupe / raid lorsque je rejoins un groupe"
L["Do you want to delete the %s paste?"] = "Souhaitez-vous supprimer la Note « %s » ?"
L["Enable Minimap Icon"] = "Activer l'icône de la mini-carte"
L["Enable sharing with party / raid members"] = "Activer le partage avec les membres du groupe / raid"
L["Export"] = "Exporter"
L["Export Saved Pastes"] = "Exporter les Notes enregistrées"
L["Failed to import pastes:"] = "Échec lors de l'importation des Notes :"
L["General"] = "Général"
L["General settings for PasteNG"] = "Options générales de PasteNG"
L["Import"] = "Importer"
L["Left Click"] = "Clic gauche"
L["lines"] = "lignes"
L["Load"] = "Charger"
L["No pastes to export"] = "Aucune Note à exporter"
L["Open the PasteNG window"] = "Ouvrir la fenêtre PasteNG"
L["Paste"] = "Coller"
L["Paste and Close"] = "Coller et fermer"
L["Paste the export data below to import pastes:"] = "Coller les données d'exportation ci-dessous pour les importer :"
L["Paste to:"] = "Coller vers :"
L["PasteNG isn't compatible with the Paste addon (including the old PasteNG version). Please uninstall or delete the Paste addon folder."] = "PasteNG n'est pas compatible avec l'addon Paste (y compris l'ancienne version de PasteNG). Veuillez désinstaller ou supprimer le dossier de l'addon Paste."
L["PasteNG Usage:"] = "Utilisation de PasteNG :"
L["Player %s does not have PasteNG. Whisper sent."] = "Le joueur %s n'a pas PasteNG. Message privé envoyé."
L["Please enter import data"] = "Veuillez saisir les données d'importation"
L["Please enter the name of your paste:"] = "Veuillez saisir le nom de la Note :"
L["Please install or update the PasteNG addon to receive shared pastes."] = "Veuillez installer ou mettre à jour PasteNG pour recevoir des Notes partagées."
L["Positions and coordinates"] = "Positions et coordonnées"
L["Reset window size and position"] = "Réinitialiser la taille et la position de la fenêtre"
L["Resets the window size and position on screen to the default"] = "Réinitialise la taille et la position de la fenêtre par défaut"
L["Right Click"] = "Clic droit"
L["Save"] = "Sauvegarder"
L["Select paste to delete"] = "Sélectionner la Note à supprimer"
L["Select paste to load"] = "Sélectionner la Note à charger"
L["Select target to send to"] = "Sélectionnez une cible à laquelle envoyer"
L["Send the paste with Shift-Enter"] = "Envoyer la Note via Maj + Entrée"
L["Share"] = "Partager"
L["Sharing"] = "Partage"
L["Sharing with party / raid members"] = "Partage avec les membres du groupe / raid"
L["Shift-Enter to Send"] = "Maj + Entrée pour envoyer"
L["Successfully imported %d pastes"] = "Importation réussie de %d Note(s)"
L["System paste shortcut"] = "raccourci par défaut de votre système d'exploitation"
L["This will overwrite an existing saved paste, are you sure?"] = "Cela écrasera une Note existante, souhaitez-vous continuer ?"
L["to open options"] = "pour ouvrir les options"
L["to show window"] = "afficher la fenêtre"
L["Toggle the minimap icon"] = "Afficher / masquer l'icône de la mini-carte"
L["Unknown error"] = "Erreur inconnue"
L["Use %s to paste the clipboard into this box"] = "Utilisez %s pour coller le contenu de votre presse-papiers dans cette fenêtre"
L["When in a group, allow sending and recieving pastes from group members"] = "Lorsque vous êtes dans un groupe, autorisez l'envoi et la réception de messages de la part des membres du groupe"
L["Window size and position has been reset."] = "La taille et la position de la fenêtre ont été réinitialisées."
L["Your PasteNG version is out of date! A newer version is available."] = "Votre version de PasteNG est obsolète ! Une version plus récente est disponible."

local addonName = ...
local L = AddonFactory:SetLocale(addonName, "frFR")
if not L then return end

L["EXPIRED_EMAILS_WARNING"] = "%s (%s) a du courrier expiré (ou proche de l'expiration)"
L["EXPIRY_ALL_ACCOUNTS_DISABLED"] = "Seul le compte en cours d'utilisation sera pris en considération; les comptes importés seront ignorés."
L["EXPIRY_ALL_ACCOUNTS_ENABLED"] = "La routine de vérification recherchera les courriers expirés sur tous les comptes connus."
L["EXPIRY_ALL_ACCOUNTS_LABEL"] = "Vérifier les expirations sur tous les comptes connus"
L["EXPIRY_ALL_ACCOUNTS_TITLE"] = "Vérifier tous les comptes"
L["EXPIRY_ALL_REALMS_DISABLED"] = "Seul le royaume en cours d'utilisation sera pris en considération; les autres royaumes seront ignorés."
L["EXPIRY_ALL_REALMS_ENABLED"] = "La routine de vérification recherchera les courriers expirés sur tous les royaumes connus."
L["EXPIRY_ALL_REALMS_LABEL"] = "Vérifier les expirations sur tous les royaumes connus"
L["EXPIRY_ALL_REALMS_TITLE"] = "Vérifier tous les royaumes"
L["EXPIRY_CHECK_DISABLED"] = "Aucune vérification ne sera effectuée."
L["EXPIRY_CHECK_ENABLED"] = "Les expirations de courrier seront vérifiées 5 secondes après le login. Les add-ons client en seront informé si au moins un courrier expiré est trouvé."
L["EXPIRY_CHECK_LABEL"] = "Avertis. d'expiration du courrier"
L["EXPIRY_CHECK_TITLE"] = "Vérifier les expirations de courrier"
L["REPORT_EXPIRED_MAILS_DISABLED"] = "Rien ne sera affiché dans la fenêtre de chat."
L["REPORT_EXPIRED_MAILS_ENABLED"] = "Lors de la verification d'expiration du courrier, la liste des personnages ayant du courrier expire sera également affichée dans la fenêtre de chat."
L["REPORT_EXPIRED_MAILS_LABEL"] = "Avertis. d'expiration du courrier (fenêtre de chat)"
L["REPORT_EXPIRED_MAILS_TITLE"] = "Avertis. d'expiration du courrier (fenêtre de chat)"
L["SCAN_MAIL_BODY_DISABLED"] = "Seules les pièces jointes seront lues. Les lettres garderont leur statut 'non-lu'."
L["SCAN_MAIL_BODY_ENABLED"] = "Le corps de chaque lettre sera lu durant le scan de la boîte aux lettres. Tous les courriers seront marqués comme lus."
L["SCAN_MAIL_BODY_LABEL"] = "Lire le courrier (le marque comme lu)"
L["SCAN_MAIL_BODY_TITLE"] = "Lire le corps du courrier"
L["Warn when mail expires in less days than this value"] = "Avertir quand du courrier arrive à expiration dans moins de jours que cette valeur"


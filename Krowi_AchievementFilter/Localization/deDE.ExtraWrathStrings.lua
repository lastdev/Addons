-- [[ Exported at 2023-03-04 12-28-03 ]] --
-- [[ This code is automatically generated as an export from ]] --
-- [[ an SQLite database and is not meant for manual edit. ]] --

-- [[ Namespaces ]] --
local _, addon = ...;
addon.ExtraWrathStrings.deDE = {};
local extraWrathStrings = addon.ExtraWrathStrings.deDE;

function extraWrathStrings.Load(L)
    if not string.match((GetBuildInfo()), "(%d+)%.(%d+)%.(%d+)(%w?)") == "3" then
        return;
    end


    L["EJ_GetInstanceInfo241"] = "Zul'Farrak";
    L["EJ_GetInstanceInfo247"] = "Auchenaikrypta";
    L["EJ_GetInstanceInfo249"] = "Terrasse der Magister";
    L["EJ_GetInstanceInfo742"] = "Pechschwingenhort";
    L["EJ_GetInstanceInfo750"] = "Die Schlacht um den Hyjal";
    L["EJ_GetInstanceInfo255"] = "Der Schwarze Morast";
    L["EJ_GetInstanceInfo258"] = "Die Mechanar";
    L["EJ_GetInstanceInfo262"] = "Der Tiefensumpf";
    L["EJ_GetInstanceInfo274"] = "Gundrak";
    L["EJ_GetInstanceInfo278"] = "Grube von Saron";
    L["EJ_GetInstanceInfo282"] = "Das Oculus";
    L["EJ_GetInstanceInfo286"] = "Turm Utgarde";
    L["EJ_GetInstanceInfo743"] = "Ruinen von Ahn'Qiraj";
    L["EJ_GetInstanceInfo751"] = "Der Schwarze Tempel";
    L["EJ_GetInstanceInfo759"] = "Ulduar";
    L["EJ_GetInstanceInfo1193"] = "Sanktum der Herrschaft";
    L["EJ_GetInstanceInfo744"] = "Tempel von Ahn'Qiraj";
    L["EJ_GetInstanceInfo752"] = "Sonnenbrunnenplateau";
    L["EJ_GetInstanceInfo760"] = "Onyxias Hort";
    L["EJ_GetInstanceInfo259"] = "Die Zerschmetterten Hallen";
    L["EJ_GetInstanceInfo271"] = "Ahn'kahet: Das Alte Königreich";
    L["EJ_GetInstanceInfo275"] = "Hallen der Blitze";
    L["EJ_GetInstanceInfo279"] = "Das Ausmerzen von Stratholme";
    L["EJ_GetInstanceInfo283"] = "Die Violette Festung";
    L["EJ_GetInstanceInfo745"] = "Karazhan";
    L["EJ_GetInstanceInfo753"] = "Archavons Kammer";
    L["EJ_GetInstanceInfo761"] = "Das Rubinsanktum";
    L["EJ_GetInstanceInfo226"] = "Der Flammenschlund";
    L["EJ_GetInstanceInfo228"] = "Schwarzfelstiefen";
    L["EJ_GetInstanceInfo230"] = "Düsterbruch";
    L["EJ_GetInstanceInfo232"] = "Maraudon";
    L["EJ_GetInstanceInfo234"] = "Kral der Klingenhauer";
    L["EJ_GetInstanceInfo236"] = "Stratholme";
    L["EJ_GetInstanceInfo238"] = "Das Verlies";
    L["EJ_GetInstanceInfo240"] = "Höhlen des Wehklagens";
    L["EJ_GetInstanceInfo246"] = "Scholomance";
    L["EJ_GetInstanceInfo248"] = "Höllenfeuerbollwerk";
    L["EJ_GetInstanceInfo250"] = "Managruft";
    L["EJ_GetInstanceInfo252"] = "Sethekkhallen";
    L["EJ_GetInstanceInfo64"] = "Burg Schattenfang";
    L["EJ_GetInstanceInfo256"] = "Der Blutkessel";
    L["EJ_GetInstanceInfo260"] = "Die Sklavenunterkünfte";
    L["EJ_GetInstanceInfo272"] = "Azjol-Nerub";
    L["EJ_GetInstanceInfo276"] = "Hallen der Reflexion";
    L["EJ_GetInstanceInfo280"] = "Die Seelenschmiede";
    L["EJ_GetInstanceInfo284"] = "Prüfung des Champions";
    L["EJ_GetInstanceInfo76"] = "Zul'Gurub";
    L["EJ_GetInstanceInfo77"] = "Zul'Aman";
    L["EJ_GetInstanceInfo747"] = "Magtheridons Kammer";
    L["EJ_GetInstanceInfo316"] = "Das Scharlachrote Kloster";
    L["EJ_GetInstanceInfo1195"] = "Mausoleum der Ersten";
    L["EJ_GetInstanceInfo1190"] = "Schloss Nathria";
    L["EJ_GetInstanceInfo748"] = "Höhle des Schlangenschreins";
    L["EJ_GetInstanceInfo756"] = "Das Auge der Ewigkeit";
    L["EJ_GetInstanceInfo257"] = "Die Botanika";
    L["EJ_GetInstanceInfo261"] = "Die Dampfkammer";
    L["EJ_GetInstanceInfo758"] = "Die Eiskronenzitadelle";
    L["EJ_GetInstanceInfo311"] = "Scharlachrote Hallen";
    L["EJ_GetInstanceInfo273"] = "Feste Drak'Tharon";
    L["EJ_GetInstanceInfo277"] = "Hallen des Steins";
    L["EJ_GetInstanceInfo281"] = "Der Nexus";
    L["EJ_GetInstanceInfo285"] = "Burg Utgarde";
    L["EJ_GetInstanceInfo755"] = "Das Obsidiansanktum";
    L["EJ_GetInstanceInfo63"] = "Todesminen";
    L["EJ_GetInstanceInfo253"] = "Schattenlabyrinth";
    L["EJ_GetInstanceInfo254"] = "Die Arkatraz";
    L["EJ_GetInstanceInfo251"] = "Vorgebirge des Alten Hügellands";
    L["EJ_GetInstanceInfo741"] = "Der Geschmolzene Kern";
    L["EJ_GetInstanceInfo749"] = "Das Auge";
    L["EJ_GetInstanceInfo757"] = "Prüfung des Kreuzfahrers";
    L["EJ_GetInstanceInfo746"] = "Gruuls Unterschlupf";
    L["EJ_GetInstanceInfo227"] = "Tiefschwarze Grotte";
    L["EJ_GetInstanceInfo229"] = "Untere Schwarzfelsspitze";
    L["EJ_GetInstanceInfo231"] = "Gnomeregan";
    L["EJ_GetInstanceInfo233"] = "Hügel der Klingenhauer";
    L["EJ_GetInstanceInfo559"] = "Obere Schwarzfelsspitze";
    L["EJ_GetInstanceInfo237"] = "Der Tempel von Atal'Hakkar";
    L["EJ_GetInstanceInfo239"] = "Uldaman";
    L["EJ_GetInstanceInfo754"] = "Naxxramas";
    L["GetCategoryInfo15218"] = "Tiefenwindschlucht";
    L["GetCategoryInfo15164"] = "Mists of Pandaria";
    L["GetCategoryInfo15234"] = "Klassisch";
    L["GetCategoryInfo15072"] = "Cataclysm";
    L["GetCategoryInfo15266"] = "Ehre";
    L["GetCategoryInfo15305"] = "Battle for Azeroth";
    L["GetCategoryInfo15414"] = "Ashran";
    L["GetCategoryInfo15283"] = "Welt";
    L["GetCategoryInfo15074"] = "Zwillingsgipfel";
    L["GetCategoryInfo15268"] = "Promotionen";
    L["GetCategoryInfo15441"] = "Paktsankten";
    L["GetCategoryInfo15439"] = "Shadowlands";
    L["GetCategoryInfo15292"] = "Brodelnde Küste";
    L["GetCategoryInfo15426"] = "Visionen von N'Zoth";
    L["GetCategoryInfo15246"] = "Sammlungen";
    L["GetCategoryInfo15440"] = "Torghast";
    L["GetCategoryInfo15417"] = "Herz von Azeroth";
    L["GetCategoryInfo15163"] = "Tempel von Katmogu";
    L["GetCategoryInfo15073"] = "Schlacht um Gilneas";
    L["GetCategoryInfo15162"] = "Silberbruchmine";
    L["GetCategoryInfo15272"] = "Dungeons";
    L["GetCategoryInfo15271"] = "Schlachtzüge";
    L["GetCategoryInfo15258"] = "Legion";
    L["GetCategoryInfo15101"] = "Dunkelmond-Jahrmarkt";
    L["GetCategoryInfo15233"] = "Warlords of Draenor";
    L["GetCategoryInfo15117"] = "Haustierkämpfe";
    L["GetCategoryInfo15454"] = "Zeitwanderung";
    L["Completed"] = "Erledigt";
    L["Not Completed"] = "Nicht Erledigt";
end


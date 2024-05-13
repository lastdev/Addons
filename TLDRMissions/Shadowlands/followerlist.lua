local addonName = ...
local addon = _G[addonName]
addon.followerList = {}
addon = addon.followerList

local CAMPAIGN = TRACKER_HEADER_CAMPAIGN_QUESTS
local RENOWN = COVENANT_SANCTUM_TAB_RENOWN
local info = C_Map.GetMapInfo(1645)
local name = ""
if info then name = info.name end
local TORGHAST = name.." "..MYTHIC_PLUS_POWER_LEVEL

-- database of Garrison Follower IDs, from https://wowpedia.fandom.com/wiki/GarrFollowerID
local gDB = {
    [1208] = {["name"] = "Nadjia the Mistblade", covenantID = 2, source = CAMPAIGN,},
    [1209] = {["name"] = "General Draven", covenantID = 2, source = CAMPAIGN,},
    [1210] = {["name"] = "Theotar", covenantID = 2, source = CAMPAIGN,},
    [1213] = {["name"] = "Thela Soulsipper", covenantID = 2, source = string.format(TORGHAST, 1),},
    [1214] = {["name"] = "Dug Gravewell", covenantID = 2, source = string.format(TORGHAST, 3),},
    [1215] = {["name"] = "Nerith Darkwing", covenantID = 2, source = string.format(TORGHAST, 1),},
    [1216] = {["name"] = "Stonehuck", covenantID = 2, source = string.format(TORGHAST, 1),},
    [1217] = {["name"] = "Kaletar", covenantID = 2, source = string.format(TORGHAST, 2),},
    [1220] = {["name"] = "Ayeleth", covenantID = 2, source = string.format(TORGHAST, 3),},
    [1221] = {["name"] = "Teliah", covenantID = 1, source = string.format(TORGHAST, 3),},
    [1222] = {["name"] = "Kythekios", covenantID = 1, source = string.format(TORGHAST, 2),},
    [1223] = {["name"] = "Telethakas", covenantID = 1, source = string.format(TORGHAST, 3),},
    [1250] = {["name"] = "Rahel", covenantID = 2, source = RENOWN.." "..4,},
    [1251] = {["name"] = "Stonehead", covenantID = 2, source = RENOWN.." "..12,},
    [1252] = {["name"] = "Simone", covenantID = 2, source = RENOWN.." "..17,},
    [1253] = {["name"] = "Bogdan", covenantID = 2, source = RENOWN.." "..38,},
    [1254] = {["name"] = "Lost Sybille", covenantID = 2, source = RENOWN.." "..27,},
    [1255] = {["name"] = "Vulca", covenantID = 2, source = RENOWN.." "..33,},
    [1257] = {["name"] = "Meatball", covenantID = 0, source = string.format(TORGHAST, 4),},
    [1258] = {["name"] = "Mikanikos", covenantID = 1, source = CAMPAIGN,},
    [1259] = {["name"] = "Pelagos", covenantID = 1, source = CAMPAIGN,},
    [1260] = {["name"] = "Kleia", covenantID = 1, source = CAMPAIGN,},
    [1261] = {["name"] = "Plague Deviser Marileth", covenantID = 4, source = CAMPAIGN,},
    [1262] = {["name"] = "Bonesmith Heirmir", covenantID = 4, source = CAMPAIGN,},
    [1263] = {["name"] = "Emeni", covenantID = 4, source = CAMPAIGN,},
    [1264] = {["name"] = "Dreamweaver", covenantID = 3, source = CAMPAIGN,},
    [1265] = {["name"] = "Niya", covenantID = 3, source = CAMPAIGN,},
    [1266] = {["name"] = "Hunt-Captain Korayn", covenantID = 3, source = CAMPAIGN,},
    [1267] = {["name"] = "Hala", covenantID = 1, source = string.format(TORGHAST, 1),},
    [1268] = {["name"] = "Molako", covenantID = 1, source = string.format(TORGHAST, 1),},
    [1269] = {["name"] = "Ispiron", covenantID = 1, source = string.format(TORGHAST, 1),},
    [1270] = {["name"] = "Nemea", covenantID = 1, source = RENOWN.." "..4,},
    [1271] = {["name"] = "Pelodis", covenantID = 1, source = RENOWN.." "..4,},
    [1272] = {["name"] = "Sika", covenantID = 1, source = RENOWN.." "..12,},
    [1273] = {["name"] = "Clora", covenantID = 1, source = RENOWN.." "..17,},
    [1274] = {["name"] = "Disciple Kosmas", covenantID = 1, source = RENOWN.." "..38,},
    [1275] = {["name"] = "Bron", covenantID = 1, source = RENOWN.." "..33,},
    [1276] = {["name"] = "Apolon", covenantID = 1, source = RENOWN.." "..27,},
    [1277] = {["name"] = "Blisswing", covenantID = 3, source = string.format(TORGHAST, 4),},
    [1278] = {["name"] = "Duskleaf", covenantID = 3, source = string.format(TORGHAST, 1),},
    [1279] = {["name"] = "Karynmwylyann", covenantID = 3, source = string.format(TORGHAST, 1),},
    [1280] = {["name"] = "Chalkyth", covenantID = 3, source = string.format(TORGHAST, 3),},
    [1281] = {["name"] = "Lloth'wellyn", covenantID = 3, source = string.format(TORGHAST, 1),},
    [1282] = {["name"] = "Yira'lya", covenantID = 3, source = string.format(TORGHAST, 2),},
    [1283] = {["name"] = "Guardian Kota", covenantID = 3, source = RENOWN.." "..4,},
    [1284] = {["name"] = "Master Sha'lor", covenantID = 3, source = RENOWN.." "..17,},
    [1285] = {["name"] = "Te'zan", covenantID = 3, source = RENOWN.." "..12,},
    [1286] = {["name"] = "Qadarin", covenantID = 3, source = RENOWN.." "..27,},
    [1287] = {["name"] = "Watcher Vesperbloom", covenantID = 3, source = RENOWN.." "..33,},
    [1288] = {["name"] = "Groonoomcrooek", covenantID = 3, source = RENOWN.." "..38,},
    [1300] = {["name"] = "Secutor Mevix", covenantID = 4, source = RENOWN.." "..4,},
    [1301] = {["name"] = "Gunn Gorgebone", covenantID = 4, source = RENOWN.." "..12,},
    [1302] = {["name"] = "Rencissa the Dynamo", covenantID = 4, source = RENOWN.." "..17,},
    [1303] = {["name"] = "Khaliiq", covenantID = 4, source = RENOWN.." "..27,},
    [1304] = {["name"] = "Plaguey", covenantID = 4, source = RENOWN.." "..33,},
    [1305] = {["name"] = "Rathan", covenantID = 4, source = RENOWN.." "..38,},
    [1306] = {["name"] = "Gorgelimb", covenantID = 4, source = string.format(TORGHAST, 2),},
    [1307] = {["name"] = "Talethi", covenantID = 4, source = string.format(TORGHAST, 3),},
    [1308] = {["name"] = "Velkein", covenantID = 4, source = string.format(TORGHAST, 3),},
    [1309] = {["name"] = "Assembler Xertora", covenantID = 4, source = string.format(TORGHAST, 1),},
    [1310] = {["name"] = "Rattlebag", covenantID = 4, source = string.format(TORGHAST, 1),},
    [1311] = {["name"] = "Ashraka", covenantID = 4, source = string.format(TORGHAST, 1),},
    [1325] = {["name"] = "Croman", covenantID = 0, source = string.format(TORGHAST, 4),},
    [1326] = {["name"] = "Spore of Marasmius", covenantID = 3, source = string.format(TORGHAST, 5),},
    [1328] = {["name"] = "ELGU - 007", covenantID = 1, source = string.format(TORGHAST, 5),},
    [1329] = {["name"] = "Kiaranyka", covenantID = 1, source = string.format(TORGHAST, 5),},
    [1330] = {["name"] = "Ryuja Shockfist", covenantID = 4, source = string.format(TORGHAST, 5),},
    [1331] = {["name"] = "Kinessa the Absorbent", covenantID = 4, source = string.format(TORGHAST, 5),},
    [1332] = {["name"] = "Steadyhands", covenantID = 2, source = string.format(TORGHAST, 5),},
    [1333] = {["name"] = "Lassik Spinebender", covenantID = 2, source = string.format(TORGHAST, 5),},
    [1334] = {["name"] = "Lyra Hailstorm", covenantID = 4, source = RENOWN.." "..44,},
    [1335] = {["name"] = "Enceladus", covenantID = 4, source = RENOWN.." "..62,},
    [1336] = {["name"] = "Deathfang", covenantID = 4, source = RENOWN.." "..71,},
    [1337] = {["name"] = "Sulanoom", covenantID = 3, source = RENOWN.." "..44,},
    [1338] = {["name"] = "Elwyn", covenantID = 3, source = RENOWN.." "..62,},
    [1339] = {["name"] = "Yanlar", covenantID = 3, source = RENOWN.." "..71,},
    [1327] = {["name"] = "Ella", covenantID = 3, source = string.format(TORGHAST, 5),},
    [1341] = {["name"] = "Hermestes", covenantID = 1, source = RENOWN.." "..44,},
    [1342] = {["name"] = "Cromas the Mystic", covenantID = 1, source = RENOWN.." "..62,},
    [1343] = {["name"] = "Auric Spiritguide", covenantID = 1, source = RENOWN.." "..71,},
    [1345] = {["name"] = "Chachi the Artiste", covenantID = 2, source = RENOWN.." "..44,},
    [1346] = {["name"] = "Madame Iza", covenantID = 2, source = RENOWN.." "..62,},
    [1347] = {["name"] = "Lucia", covenantID = 2, source = RENOWN.." "..71,}, 
}

local FOLLOWER_BUTTON_HEIGHT = 56;
local CATEGORY_BUTTON_HEIGHT = 20;
local FOLLOWER_LIST_BUTTON_OFFSET = -6;
local FOLLOWER_LIST_BUTTON_INITIAL_OFFSET = -7;
local GARRISON_FOLLOWER_LIST_BUTTON_FULL_XP_WIDTH = 205;

local doOnce = true
function addon:Init()
    if not doOnce then return end
    doOnce = false
    
    -- This code was adapted from Blizzard_GarrisonSharedTemplates.lua
    
    local function newUpdateFollowers(self)
        if self.followerType == 123 then
            local dataProvider = self.ScrollBox:GetDataProvider()
            local uncollectedFollowers,known = {},{}
            local index = 1
            
            for garrFollowerID, data in pairs(gDB) do
                dataProvider:ForEach(function(follower)
                    if follower.follower then
                        follower = follower.follower
                        if (garrFollowerID == follower.garrFollowerID) then
                            known[garrFollowerID] = true
                            if (garrFollowerID == 1270) then
                                gDB[1271] = nil
                            end
                            if (garrFollowerID == 1271) then
                                gDB[1270] = nil
                            end
                        end
                    end
                    if follower.index and (follower.index > index) then
                        index = follower.index
                        print(index)
                    end
                end)
            end
            for garrFollowerID, data in pairs(gDB) do
                if (not known[garrFollowerID]) and ((data.covenantID == 0) or (data.covenantID == C_Covenants.GetActiveCovenantID())) then
                    local info = C_Garrison.GetFollowerInfo(garrFollowerID)
                    info.source = data.source
                    info.status = GARRISON_FOLLOWER_INACTIVE
                    table.insert(uncollectedFollowers, info)
                end
            end
            if #uncollectedFollowers > 0 then
                
                --table.insert(followersList, 0)
                --table.insert(categoryLabels, #followersList, FOLLOWERLIST_LABEL_UNCOLLECTED)
                for _, follower in pairs(uncollectedFollowers) do
                    dataProvider:Insert({index=index, follower=follower, followerList=self})
                    --table.insert(followers, follower)
                    --table.insert(followersList, #followers)
                end
                --numFollowers = #followersList
            end
        end
    
    
    end
    
    hooksecurefunc(CovenantMissionFrame.FollowerList, "UpdateFollowers", newUpdateFollowers)
    hooksecurefunc(GarrisonLandingPageFollowerList, "UpdateFollowers", newUpdateFollowers)
    
    local oGFLIB = GarrisonFollowerList_InitButton
    function GarrisonFollowerList_InitButton(frame, elementData)
        if frame.Follower then
            if not frame.Follower.DownArrow then
                frame.Follower.DownArrow = frame.Follower:CreateTexture()
                frame.Follower.DownArrow:SetPoint("TOPRIGHT", -10, -38)
                frame.Follower.DownArrow:SetSize(13, 13)
                frame.Follower.DownArrow:SetTexCoord(0.45312500, 0.64062500, 0.20312500, 0.01562500)
                local norecursion
                hooksecurefunc(frame.Follower.Status, "SetText", function(self, text)
                    if norecursion then return end
                    if text == GARRISON_FOLLOWER_INACTIVE then
                        if self:GetParent().info.source then
                            norecursion = true
                            self:SetText(self:GetParent().info.source)
                            norecursion = false
                        end
                    end
                end)
            end
        end
        oGFLIB(frame, elementData)
    end
end

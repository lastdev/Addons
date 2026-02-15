MetaAchievementConfigurationDB = MetaAchievementConfigurationDB or DefaultSettings()
MetaAchievementTitle = "Meta Achievement Tracker"

MetaAchievementDB = {
    mapIntegration = nil,
    achievementLists = {}
}

WindowTabs = {
    lightUpTheNight = "lightUpTheNight",
    worldSoulSearching = "worldSoulSearching",
    settings = "settings",
    farewellToArms = "farewellToArms",
    backFromTheBeyond = "backFromTheBeyond",
    aWorldAwoken = "aWorldAwoken",
    whatALongStrangeTripItsBeen = "whatALongStrangeTripItsBeen"
}

local mainFrame = MainFrame:new()
MetaAchievementDB.mapIntegration = MapIntegrationBase:new()

if TomTom then
    MetaAchievementDB.mapIntegration:RegisterMapIntegration(MapIntegrationOptions.tomtom, TomTomMap:new())
    MetaAchievementDB.mapIntegration:SetActiveIntegration(MapIntegrationOptions.tomtom)
    mainFrame:RegisterOnEventHander(
        "PLAYER_ENTERING_WORLD",
        function()
            local integration = MetaAchievementDB.mapIntegration:GetIntegrationIfActive(MapIntegrationOptions.tomtom)
            if integration ~= nil then
                integration:OnTomTomLoaded()
            end
        end)
end

local function createAchievementTab(name, tabName, icon, dataSource)
    MetaAchievementDB.achievementLists[tabName] = {
        data = DataList:new(dataSource),
        treeView = nil
    }

    MetaAchievementDB.achievementLists[tabName].treeView = TreeView:new(
        mainFrame:getFrame(),
        MetaAchievementDB.achievementLists[tabName].data,
        name
    )

    mainFrame:addScrollChild(tabName, MetaAchievementDB.achievementLists[tabName].treeView)
    mainFrame:AddAchievementTab(tabName, icon)
end

function EntryPoint()
    SLASH_WORLDSOULSEARCHING1 = "/wss"
    SlashCmdList["WORLDSOULSEARCHING"] = LoadSlashCommands

    MetaAchievementDB.mapIntegration:OnLoaded()

    local settingsFrame = SettingsFrame:new(mainFrame:getFrame())

    RegisterSlashCommand("show",
        function() 
            mainFrame:showWindow()
        end,
        "Show addon window")

    RegisterSlashCommand("hide",
        function()
            mainFrame:hideWindow()
        end,
        "Hide addon window")

    RegisterSlashCommand("reset",
        function() 
            mainFrame:resetFrame()
        end,
        "Reset window position")


    -- Settings
    mainFrame:addScrollChild(WindowTabs.settings, settingsFrame)

    createAchievementTab(
        "Light Up The Night",
        WindowTabs.lightUpTheNight,
        "Interface\\Icons\\inv_12_dualityphoenix_lightvoid_explosion",
        LightUpTheNightAchievements
    )

    createAchievementTab(
        "Worldsoul Searching",
        WindowTabs.worldSoulSearching,
        "Interface\\Icons\\achievement_zone_isleofdorn",
        WorldSoulSearchingAchievements
    )

    createAchievementTab(
        "A World Awoken",
        WindowTabs.aWorldAwoken, 
        "Interface\\Icons\\ability_evoker_furyoftheaspects",
        AWorldAwokenAchievements
    )

    createAchievementTab(
        "Back From The Beyond",
        WindowTabs.backFromTheBeyond, 
        "Interface\\Icons\\inv_torghast",
        BackFromTheBeyondAchievements
    )

    createAchievementTab(
        "A Farewell To Arms",
        WindowTabs.farewellToArms, 
        "Interface\\Icons\\Inv_radientazeriteheart",
        AFarewellToArmsAchievements
    )

    createAchievementTab(
        "What a Long, Strange Trip It's Been",
        WindowTabs.whatALongStrangeTripItsBeen,
        "Interface\\Icons\\achievement_bg_masterofallbgs",
        WhatALongStrangeTripItsBeenAchievements
    )

    -- Draw default
    mainFrame:drawScrollContent(WindowTabs.lightUpTheNight)
end

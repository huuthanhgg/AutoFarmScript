-- AutoFarm GUI v2 by huuthanhgg
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "AutoFarm - AOT",
    LoadingTitle = "Loading Config...",
    LoadingSubtitle = "by huuthanhgg",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "AutoFarmConfig",
       FileName = "AOT_Settings"
    }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- AutoFarm Toggle
MainTab:CreateToggle({
    Name = "AutoFarm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(state)
        autoRunning = state
        if autoRunning then
            autoFarm()
        end
    end
})

-- Auto Mission
MainTab:CreateToggle({
    Name = "Auto Mission (Blades)",
    CurrentValue = false,
    Flag = "AutoMission",
    Callback = function(state)
        autoMission = state
    end
})

-- Auto Raid
MainTab:CreateToggle({
    Name = "Auto Raid (Blades)",
    CurrentValue = false,
    Flag = "AutoRaid",
    Callback = function(state)
        autoRaid = state
    end
})

-- Speed Slider
MainTab:CreateSlider({
    Name = "Fire Speed",
    Range = {0.05, 0.5},
    Increment = 0.01,
    CurrentValue = 0.15,
    Flag = "FireSpeed",
    Callback = function(value)
        shotSpeed = value
    end
})

-- Misc Features
MiscTab:CreateToggle({
    Name = "Titan ESP",
    CurrentValue = false,
    Flag = "TitanESP",
    Callback = function(state)
        titanESP = state
    end
})

MiscTab:CreateButton({
    Name = "Return to Lobby",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

Rayfield:LoadConfiguration()

-- AutoFarm GUI v2 by huuthanhgg (Thunder Spear Fixed)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "AutoFarm - AOT (Thunder Spear)",
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

-- Thunder Spear AutoFarm
MainTab:CreateToggle({
    Name = "Auto Thunder Spear",
    CurrentValue = false,
    Flag = "ThunderSpear",
    Callback = function(state)
        autoThunder = state
    end
})

-- Thunder Spear Shot Count
MainTab:CreateSlider({
    Name = "Thunder Spear Shots",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 5,
    Flag = "SpearShots",
    Callback = function(value)
        spearShots = value
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

-- Function to find Boss
function findBoss()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") and v.Name == "Titan" then
            return v
        end
    end
    return nil
end

-- Function for Thunder Spear AutoFarm
function autoFarm()
    while autoRunning do
        local boss = findBoss()
        if boss and autoThunder then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, -15) -- Di chuyển đến Boss
                wait(0.5)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftShift", false, game) -- Nhấn Shift
                wait(0.2)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "Two", false, game) -- Chọn Thunder Spear
                wait(0.3)
                for i = 1, spearShots do
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1) -- Bắn
                    wait(shotSpeed)
                end
            end
        end
        wait(0.1)
    end
end

Rayfield:LoadConfiguration()


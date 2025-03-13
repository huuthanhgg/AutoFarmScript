-- // Load Rayfield Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Huuthanh Hub - AOT:R",
    LoadingTitle = "Huuthanh Hub - Attack on Titan Revolution",
    LoadingSubtitle = "Script by Huuthanh",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "HuuthanhHub",
        FileName = "AOTR_Config"
    }
})

-- // Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local UtilityTab = Window:CreateTab("Utility", 4483362458)

-- // Variables
local flyEnabled = false
local autoMissionEnabled = false
local autoReplayEnabled = false
local fastTSEnabled = false

-- // Fly (Tránh Titan)
local function Fly()
    local character = game.Players.LocalPlayer.Character
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    if flyEnabled then
        humanoidRootPart.Anchored = true
        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 50, 0) -- Bay lên cao
    else
        humanoidRootPart.Anchored = false
    end
end

-- // Auto Mission
local function AutoMission()
    while autoMissionEnabled do
        for _, mission in pairs(game.Workspace.Missions:GetChildren()) do
            if mission:FindFirstChild("MissionPrompt") then
                fireproximityprompt(mission.MissionPrompt)
            end
        end
        wait(2)
    end
end

-- // Auto Replay Mission/Raid
local function AutoReplay()
    while autoReplayEnabled do
        local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            for _, v in pairs(playerGui:GetChildren()) do
                if v:IsA("ScreenGui") and v:FindFirstChild("ReplayButton") then
                    v.ReplayButton:Activate()
                    wait(5)
                end
            end
        end
        wait(3)
    end
end

-- // Auto Reload
local function AutoReload()
    while true do
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Reload") then
            character["Reload"]:Activate()
        end
        wait(5)
    end
end

-- // Auto Escape
local function AutoEscape()
    while true do
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Escape") then
            character["Escape"]:Activate()
        end
        wait(0.1)
    end
end

-- // Menu
MainTab:CreateToggle({
    Name = "Auto Mission",
    CurrentValue = false,
    Callback = function(value)
        autoMissionEnabled = value
        if value then AutoMission() end
    end
})

MainTab:CreateToggle({
    Name = "Auto Replay (Raid/Mission)",
    CurrentValue = false,
    Callback = function(value)
        autoReplayEnabled = value
        if value then AutoReplay() end
    end
})

MainTab:CreateToggle({
    Name = "Fly (Tránh Titan)",
    CurrentValue = false,
    Callback = function(value)
        flyEnabled = value
        Fly()
    end
})

CombatTab:CreateToggle({
    Name = "Bắn Thunder Spear Nhanh",
    CurrentValue = false,
    Callback = function(value)
        fastTSEnabled = value
    end
})

UtilityTab:CreateButton({
    Name = "Auto Reload",
    Callback = function() AutoReload() end
})

UtilityTab:CreateButton({
    Name = "Auto Escape",
    Callback = function() AutoEscape() end
})

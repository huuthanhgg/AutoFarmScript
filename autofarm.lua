local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- 🎨 Tùy chỉnh giao diện menu
Rayfield:ChangeTheme({
    Background = Color3.fromRGB(10, 10, 20),
    Topbar = Color3.fromRGB(30, 30, 50),
    Accent = Color3.fromRGB(255, 85, 127),
    Text = Color3.fromRGB(255, 255, 255),
    ElementBackground = Color3.fromRGB(20, 20, 40),
    ElementBorder = Color3.fromRGB(60, 60, 90)
})

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

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 🏃‍♂️ Auto Escape (Tự động né Titan)
local function AutoEscape()
    while wait(0.5) do
        local closestTitan = FindClosestTitan()
        if closestTitan then
            local distance = (character.HumanoidRootPart.Position - closestTitan.HumanoidRootPart.Position).Magnitude
            if distance < 15 then
                character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 20)
            end
        end
    end
end

-- 🔄 Auto Reload (Tự động nạp đạn Thunder Spear)
local function AutoReload()
    while wait(1) do
        local tool = character:FindFirstChild("ThunderSpear")
        if tool and tool:FindFirstChild("Ammo") and tool.Ammo.Value == 0 then
            tool:Activate()
            wait(1)
            tool:Deactivate()
        end
    end
end

-- 🎯 Tìm Titan gần nhất
local function FindClosestTitan()
    local closestTitan = nil
    local shortestDistance = math.huge
    for _, titan in pairs(workspace:GetChildren()) do
        if titan:IsA("Model") and titan:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - titan.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                closestTitan = titan
                shortestDistance = distance
            end
        end
    end
    return closestTitan
end

-- 🔥 Auto Raid
local function AutoRaid()
    Rayfield:Notify("Auto Raid", "⚔️ Bắt đầu Raid tự động!", 3)

    while wait(1) do
        local raidExists = workspace:FindFirstChild("RaidArea")
        if not raidExists then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and v.Name == "RaidTeleporter" then
                    player.Character.HumanoidRootPart.CFrame = v.CFrame
                    wait(2)
                end
            end
        else
            local titan = FindClosestTitan()
            if titan then
                character.HumanoidRootPart.CFrame = titan.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                wait(0.5)
                if character:FindFirstChild("CDM") then
                    character.CDM:Activate()
                elseif character:FindFirstChild("ThunderSpear") then
                    character.ThunderSpear:Activate()
                end
            end
        end
    end
end

-- 🎯 Auto Mission
local function AutoMission()
    Rayfield:Notify("Auto Mission", "🎯 Đang làm nhiệm vụ tự động!", 3)

    while wait(1) do
        local missionGui = player.PlayerGui
        if not missionGui:FindFirstChild("MissionActive") then
            game:GetService("ReplicatedStorage").Remotes.Mission:FireServer("Start")
            wait(2)
        else
            local titan = FindClosestTitan()
            if titan then
                character.HumanoidRootPart.CFrame = titan.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                wait(0.5)
                if character:FindFirstChild("CDM") then
                    character.CDM:Activate()
                elseif character:FindFirstChild("ThunderSpear") then
                    character.ThunderSpear:Activate()
                end
            end
        end
    end
end

-- 🔄 Auto Replay
local function AutoReplay()
    while wait(2) do
        local gui = player.PlayerGui
        if gui:FindFirstChild("MissionComplete") or gui:FindFirstChild("MissionFailed") then
            Rayfield:Notify("Auto Replay", "🔄 Đang tự động replay nhiệm vụ!", 3)
            wait(3)
            game:GetService("ReplicatedStorage").Remotes.Raid:FireServer("Replay")
        end
    end
end

-- 🛸 Fly Mode
local flying = false
local flightSpeed = 100

local function StartFlying()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    flying = true
    local bodyVelocity = Instance.new("BodyVelocity", char.HumanoidRootPart)
    bodyVelocity.Velocity = Vector3.new(0, flightSpeed, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    while flying do
        wait(0.1)
        bodyVelocity.Velocity = Vector3.new(0, flightSpeed, 0)
    end
end

local function StopFlying()
    flying = false
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(char.HumanoidRootPart:GetChildren()) do
            if v:IsA("BodyVelocity") then
                v:Destroy()
            end
        end
    end
end

-- ✅ Thêm vào menu
local AutoEscapeToggle = Window:CreateToggle({
    Name = "Auto Escape",
    CurrentValue = false,
    Flag = "AutoEscape",
    Callback = function(Value)
        if Value then
            spawn(AutoEscape)
        end
    end
})

local AutoReloadToggle = Window:CreateToggle({
    Name = "Auto Reload",
    CurrentValue = false,
    Flag = "AutoReload",
    Callback = function(Value)
        if Value then
            spawn(AutoReload)
        end
    end
})

local AutoRaidToggle = Window:CreateToggle({
    Name = "Auto Raid",
    CurrentValue = false,
    Flag = "AutoRaid",
    Callback = function(Value)
        if Value then
            spawn(AutoRaid)
        end
    end
})

local AutoMissionToggle = Window:CreateToggle({
    Name = "Auto Mission",
    CurrentValue = false,
    Flag = "AutoMission",
    Callback = function(Value)
        if Value then
            spawn(AutoMission)
        end
    end
})

local AutoReplayToggle = Window:CreateToggle({
    Name = "Auto Replay Raid/Mission",
    CurrentValue = false,
    Flag = "AutoReplay",
    Callback = function(Value)
        if Value then
            spawn(AutoReplay)
        end
    end
})

local FlyToggle = Window:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        if Value then
            StartFlying()
        else
            StopFlying()
        end
    end
})

Rayfield:LoadConfiguration()

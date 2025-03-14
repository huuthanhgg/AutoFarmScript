local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Giao diện menu đẹp hơn
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

-- // Tìm Titan gần nhất
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

-- // Fly Mode
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

-- // Auto Chém Titan (CDM)
local function AutoSlashTitan()
    while true do
        local titan = FindClosestTitan()
        if titan and character:FindFirstChild("CDM") then
            character.CDM:Activate()
            character.HumanoidRootPart.CFrame = titan.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
        end
        wait(0.5)
    end
end

-- // Auto Bắn Titan (Thunder Spear)
local function AutoShootTitan()
    while true do
        local titan = FindClosestTitan()
        if titan and character:FindFirstChild("ThunderSpear") then
            character.ThunderSpear:Activate()
            character.HumanoidRootPart.CFrame = titan.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
        end
        wait(1)
    end
end

-- // Auto Raid
local function AutoRaid()
    StartFlying()  -- Kích hoạt Fly Mode khi vào Raid

    while true do
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
        wait(1)
    end
end

-- // Auto Mission
local function AutoMission()
    StartFlying()  -- Kích hoạt Fly Mode khi làm Mission

    while true do
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
        wait(1)
    end
end

-- // Auto Replay (Nếu Raid/Mission thắng hoặc thua)
local function AutoReplay()
    while true do
        local gui = player.PlayerGui
        if gui:FindFirstChild("MissionComplete") or gui:FindFirstChild("MissionFailed") then
            wait(3)
            game:GetService("ReplicatedStorage").Remotes.Raid:FireServer("Replay")
        end
        wait(2)
    end
end

-- // Thêm các Toggle vào menu
local AutoFarmToggle = Window:CreateToggle({
    Name = "Auto Farm Titan",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        if Value then
            spawn(AutoSlashTitan)
            spawn(AutoShootTitan)
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

Rayfield:LoadConfiguration()

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- Config
local shotSpeed = 0.15  -- Tốc độ bắn
local bossShots = 8  -- Số lần bắn boss
local enableCombo = true
local autoRunning = false

-- Hàm bắn
function attack()
    mouse1click()
    wait(shotSpeed)
end

-- Nhận diện Enemy
function findEnemy()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hrp then
                LP.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
                attack()
            end
        end
    end
end

-- Nhận diện Boss
function findBoss()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("BossTag") then
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hrp then
                LP.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
                if enableCombo then
                    UIS:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                    wait(0.2)
                    UIS:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
                    wait(0.2)
                end
                for i = 1, bossShots do
                    attack()
                end
            end
        end
    end
end

-- Auto Farm Function
function autoFarm()
    autoRunning = true
    while autoRunning do
        findBoss()
        findEnemy()
        wait(0.05)
    end
end

-- GUI Menu
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local StartButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)

StartButton.Parent = Frame
StartButton.Size = UDim2.new(0, 180, 0, 40)
StartButton.Position = UDim2.new(0, 10, 0, 10)
StartButton.Text = "Start AutoFarm"
StartButton.MouseButton1Click:Connect(autoFarm)

StopButton.Parent = Frame
StopButton.Size = UDim2.new(0, 180, 0, 40)
StopButton.Position = UDim2.new(0, 10, 0, 50)
StopButton.Text = "Stop AutoFarm"
StopButton.MouseButton1Click:Connect(function()
    autoRunning = false
end)

print("AutoFarm Loaded! Press Start to begin.")

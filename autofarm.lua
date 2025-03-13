-- 🚀 Script by huuthanh 🚀
if game:IsLoaded() then
    print("Game is already loaded, executing script.")
else
    game.Loaded:Wait()
end

local GameP = game.PlaceId

-- Function to send notifications (English & Vietnamese)
local function sendNotification(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "[huuthanh] " .. title,
        Text = text,
        Icon = "rbxassetid://13264701341"
    })
end

sendNotification("Notification", "Script by huuthanh - Checking...")
wait(0.1)
sendNotification("Notification", "Checking Place ID...")
wait(0.1)

-- Game script selection
local url

if game.PlaceId == 12137249458 then  
    sendNotification("Game", "Gun Grounds [" .. GameP .. "]")
    url = "https://raw.githubusercontent.com/zerunquist/TekkitAotr/main/gungroundsffa"

elseif game.PlaceId == 2753915549 or game.PlaceId == 4442272183 or game.PlaceId == 7449423635 then
    sendNotification("Game", "Blox Fruits [" .. GameP .. "]")
    url = "https://raw.githubusercontent.com/JD-04/Tekkit/refs/heads/main/Blox%20obf.txt"

elseif game.PlaceId == 286090429 then
    sendNotification("Game", "Arsenal [" .. GameP .. "]")
    url = "https://raw.githubusercontent.com/JD-04/Tekkit/refs/heads/main/Arsenal"

else
    sendNotification("Game", "Aot:R Hub [" .. GameP .. "] Loading...")
    url = "https://api.luarmor.net/files/v3/loaders/705e7fe7aa288f0fe86900cedb1119b1.lua"
end

-- Load and execute script
if url then
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        loadstring(response)()
    else
        sendNotification("Error", "Failed to load script from URL: " .. url)
    end
else
    sendNotification("Error", "No script found for this game.") 
end

-- ==============================
-- 🚀 THUNDER SPEAR AUTO FARM - SHOOT FROM ANYWHERE 🚀
-- ==============================
local function farmThunderSpear()
    sendNotification("AutoFarm", "Script huuthanh - Starting Thunder Spear farm from anywhere!")

    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    while true do
        wait(0.1)

        -- Check for bosses
        local bosses = workspace:FindFirstChild("Bosses")
        if bosses then
            for _, boss in pairs(bosses:GetChildren()) do
                if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    sendNotification("AutoFarm", "💥 huuthanh is shooting the boss from anywhere!")

                    -- Switch to Thunder Spear
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                    wait(0.2)

                    -- Aim at the boss from a distance
                    mouse.TargetFilter = boss
                    mouse.Hit = boss.Head.CFrame
                    wait(0.1)

                    -- Shoot Thunder Spear
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
            end
        end
    end
end

-- Activate Thunder Spear farm
task.spawn(farmThunderSpear)

-- 🔗 โหลดสคริปหลักของมึง
loadstring(game:HttpGet("https://raw.githubusercontent.com/xidin861-star/Script-tsb-boots-fps-o/refs/heads/main/Script.lua"))()

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- 🌌 ลบท้องฟ้า
for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") or v:IsA("Atmosphere") then
        v:Destroy()
    end
end

-- 💇 ลบผมทุกคน
local function removeHair(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("Accessory") then
            local name = v.Name:lower()
            if name:find("hair") or name:find("hat") then
                v:Destroy()
            end
        end
    end
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr.Character then
        removeHair(plr.Character)
    end
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        removeHair(char)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        removeHair(char)
    end)
end)

-- 📱 UI ปุ่ม 1080x1080
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FPS_UI_1080"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,150,0,50)
main.Position = UDim2.new(0,50,0,200)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(1,0,1,0)
btn.Text = "1080×1080 : OFF"
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)

-- 🔄 Toggle
local enabled = false
local oldFov = cam.FieldOfView

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    
    if enabled then
        btn.Text = "1080×1080 : ON"
        
        -- 🎯 ปรับมุมมองให้ดูเป็นสี่เหลี่ยม
        cam.FieldOfView = 50
        
        -- 📐 ใส่ขอบดำ (fake 1080x1080)
        if not gui:FindFirstChild("Bars") then
            local bars = Instance.new("Frame", gui)
            bars.Name = "Bars"
            bars.BackgroundTransparency = 1
            bars.Size = UDim2.new(1,0,1,0)
            
            local left = Instance.new("Frame", bars)
            left.Size = UDim2.new(0.2,0,1,0)
            left.BackgroundColor3 = Color3.new(0,0,0)
            
            local right = left:Clone()
            right.Parent = bars
            right.Position = UDim2.new(0.8,0,0,0)
        end
        
    else
        btn.Text = "1080×1080 : OFF"
        cam.FieldOfView = oldFov
        
        local bars = gui:FindFirstChild("Bars")
        if bars then bars:Destroy() end
    end
end)

print("🔥 1080x1080 UI LOADED")

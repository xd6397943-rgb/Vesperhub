-- Vesper Hub: VesperFly Script
local ScreenGui = Instance.new("ScreenGui")
local FlyButton = Instance.new("TextButton")

-- إعدادات واجهة المستخدم لسكربت VesperFly
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "VesperHubGui"

-- تنسيق الزر (الستايل الأسود والذهبي الفخم)
FlyButton.Name = "VesperFlyBtn"
FlyButton.Parent = ScreenGui
FlyButton.Size = UDim2.new(0, 140, 0, 50)
FlyButton.Position = UDim2.new(0.5, -70, 0.2, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- أسود
FlyButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- ذهبي
FlyButton.Text = "VesperFly"
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.TextSize = 22
FlyButton.BorderSizePixel = 2
FlyButton.BorderColor3 = Color3.fromRGB(255, 215, 0)

-- رسالة ترحيب عند تشغيل السكربت
game.StarterGui:SetCore("SendNotification", {
    Title = "Vesper Hub";
    Text = "VesperFly has been activated!";
    Duration = 5;
})

-- برمجة وظيفة الطيران
local player = game.Players.LocalPlayer
local flying = false
local speed = 50

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    if flying then
        FlyButton.Text = "FLYING: ON"
        FlyButton.TextColor3 = Color3.fromRGB(0, 255, 0) -- يتغير للأخضر عند العمل
        
        local bv = Instance.new("BodyVelocity", character.HumanoidRootPart)
        bv.Name = "VesperVelocity"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0.1, 0)
        
        local bg = Instance.new("BodyGyro", character.HumanoidRootPart)
        bg.Name = "VesperGyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 9e4
        
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                bg.CFrame = workspace.CurrentCamera.CFrame
                task.wait()
            end
            bv:Destroy()
            bg:Destroy()
        end)
    else
        FlyButton.Text = "VesperFly"
        FlyButton.TextColor3 = Color3.fromRGB(255, 215, 0) -- يرجع ذهبي عند الإيقاف
    end
end)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local guiButton = Instance.new("TextButton")
guiButton.Size = UDim2.new(0, 40, 0, 30)
guiButton.Position = UDim2.new(0, 10, 0, 10)
guiButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
guiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
guiButton.Text = "gui"
guiButton.Parent = screenGui

local function createTextBox(name, position, placeholder)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 180, 0, 25)
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 1, 0)
    textBox.Position = UDim2.new(0, 0, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Text = ""
    textBox.PlaceholderText = placeholder
    textBox.Parent = frame
    
    return frame, textBox
end

local frame1, textBox1 = createTextBox("textBox1", UDim2.new(0, 10, 0, 50), "перекрут яичка")
local frame2, textBox2 = createTextBox("textBox2", UDim2.new(0, 10, 0, 80), "сверхзвук")
local frame3, textBox3 = createTextBox("textBox3", UDim2.new(0, 10, 0, 110), "волна")
local frame4, textBox4 = createTextBox("textBox4", UDim2.new(0, 10, 0, 140), "камушек")
local frame5, textBox5 = createTextBox("textBox5", UDim2.new(0, 10, 0, 170), "пакет")
local frame6, textBox6 = createTextBox("textBox6", UDim2.new(0, 10, 0, 200), "рюкзак")

local guiVisible = true

guiButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame1.Visible = guiVisible
    frame2.Visible = guiVisible
    frame3.Visible = guiVisible
    frame4.Visible = guiVisible
    frame5.Visible = guiVisible
    frame6.Visible = guiVisible
end)

local spinning = false
local attacking = false
local waving = false
local throwing = false
local packing = false
local backpacking = false
local spinTarget = nil
local attackTarget = nil
local waveTarget = nil
local throwTarget = nil
local packTarget = nil
local backpackTarget = nil
local spinConnection = nil
local attackConnection = nil
local waveConnection = nil
local throwConnection = nil
local packConnection = nil
local backpackConnection = nil
local attackPhase = "circle"
local attackAngle = 0
local lastAttackTime = 0
local wavePhase = "rush"
local waveAngle = 0
local lastRushTime = 0
local throwPhase = "away"
local throwAngle = 0
local packPhase = "through"
local packAngle = 0
local backpackPhase = "spin"
local backpackTimer = 0
local backpackSpinAngle = 0

local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local highFlyActive = false
local highFlyTimer = 0
local returnPosition = Vector3.new(0, 0, 0)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
    humanoid = newCharacter:WaitForChild("Humanoid")
end)

local highFlyConnection = RunService.Heartbeat:Connect(function()
    if humanoidRootPart and humanoid then
        if (humanoidRootPart.Position.Y > 1000 or humanoidRootPart.Position.Y > 2000) and not highFlyActive then
            highFlyActive = true
            highFlyTimer = tick()
            returnPosition = humanoidRootPart.Position - Vector3.new(0, 1000, 0)
            humanoid.PlatformStand = true
            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
        
        if highFlyActive then
            if tick() - highFlyTimer > 2 then
                humanoidRootPart.CFrame = CFrame.new(returnPosition)
                humanoid.PlatformStand = false
                highFlyActive = false
            end
        end
    end
end)

textBox1:GetPropertyChangedSignal("Text"):Connect(function()
    if textBox1.Text == "" then
        spinning = false
        spinTarget = nil
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
    else
        spinning = true
        spinTarget = nil
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(plr.Name, 1, #textBox1.Text)) == string.lower(textBox1.Text) then
                spinTarget = plr
                break
            end
        end
        
        if spinConnection then
            spinConnection:Disconnect()
        end
        
        spinConnection = RunService.Heartbeat:Connect(function()
            if spinning and spinTarget and spinTarget.Character then
                local targetRoot = spinTarget.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and humanoidRootPart then
                    local angle = tick() * 50
                    local radius = 5
                    local x = math.cos(angle) * radius
                    local z = math.sin(angle) * radius
                    
                    humanoidRootPart.CFrame = CFrame.new(
                        targetRoot.Position.X + x,
                        targetRoot.Position.Y,
                        targetRoot.Position.Z + z
                    )
                end
            end
        end)
    end
end)

textBox2:GetPropertyChangedSignal("Text"):Connect(function()
    if textBox2.Text == "" then
        attacking = false
        attackTarget = nil
        attackPhase = "circle"
        if attackConnection then
            attackConnection:Disconnect()
            attackConnection = nil
        end
    else
        attacking = true
        attackTarget = nil
        attackPhase = "circle"
        attackAngle = 0
        
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(plr.Name, 1, #textBox2.Text)) == string.lower(textBox2.Text) then
                attackTarget = plr
                break
            end
        end
        
        if attackConnection then
            attackConnection:Disconnect()
        end
        
        attackConnection = RunService.Heartbeat:Connect(function()
            if attacking and attackTarget and attackTarget.Character then
                local targetRoot = attackTarget.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and humanoidRootPart then
                    
                    if attackPhase == "circle" then
                        attackAngle = attackAngle + 0.1
                        local radius = 5
                        local x = math.cos(attackAngle) * radius
                        local z = math.sin(attackAngle) * radius
                        
                        humanoidRootPart.CFrame = CFrame.new(
                            targetRoot.Position.X + x,
                            targetRoot.Position.Y,
                            targetRoot.Position.Z + z
                        )
                        
                        if tick() - lastAttackTime > 2 then
                            attackPhase = "attack"
                            lastAttackTime = tick()
                        end
                        
                    elseif attackPhase == "attack" then
                        local awayAngle = math.random() * math.pi * 2
                        local awayRadius = 50
                        local awayX = math.cos(awayAngle) * awayRadius
                        local awayZ = math.sin(awayAngle) * awayRadius
                        local awayPos = targetRoot.Position + Vector3.new(awayX, 3, awayZ)
                        
                        humanoidRootPart.CFrame = CFrame.new(awayPos)
                        humanoidRootPart.CFrame = targetRoot.CFrame
                        
                        targetRoot.Velocity = Vector3.new(math.random(-100, 100), 50, math.random(-100, 100))
                        attackPhase = "circle"
                    end
                end
            end
        end)
    end
end)

textBox3:GetPropertyChangedSignal("Text"):Connect(function()
    if textBox3.Text == "" then
        waving = false
        waveTarget = nil
        if waveConnection then
            waveConnection:Disconnect()
            waveConnection = nil
        end
    else
        waving = true
        waveTarget = nil
        wavePhase = "rush"
        waveAngle = 0
        lastRushTime = tick()
        
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(plr.Name, 1, #textBox3.Text)) == string.lower(textBox3.Text) then
                waveTarget = plr
                break
            end
        end
        
        if waveConnection then
            waveConnection:Disconnect()
        end
        
        waveConnection = RunService.Heartbeat:Connect(function()
            if waving and waveTarget and waveTarget.Character then
                local targetRoot = waveTarget.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and humanoidRootPart then
                    
                    if wavePhase == "rush" then
                        local direction = (targetRoot.Position - humanoidRootPart.Position).Unit
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame + direction * 2
                        
                        if (humanoidRootPart.Position - targetRoot.Position).Magnitude < 5 then
                            wavePhase = "circle"
                            lastRushTime = tick()
                        end
                        
                    elseif wavePhase == "circle" then
                        waveAngle = waveAngle + 0.1
                        local radius = 10
                        local x = math.cos(waveAngle) * radius
                        local z = math.sin(waveAngle) * radius
                        local y = math.sin(waveAngle * 3) * 3
                        
                        local wavePos = targetRoot.Position + Vector3.new(x, y + 2, z)
                        humanoidRootPart.CFrame = CFrame.new(wavePos)
                        
                        if tick() - lastRushTime > 2 then
                            wavePhase = "rush"
                            lastRushTime = tick()
                        end
                    end
                end
            end
        end)
    end
end)

textBox4:GetPropertyChangedSignal("Text"):Connect(function()
    if textBox4.Text == "" then
        throwing = false
        throwTarget = nil
        if throwConnection then
            throwConnection:Disconnect()
            throwConnection = nil
        end
    else
        throwing = true
        throwTarget = nil
        throwPhase = "away"
        throwAngle = 0
        
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(plr.Name, 1, #textBox4.Text)) == string.lower(textBox4.Text) then
                throwTarget = plr
                break
            end
        end
        
        if throwConnection then
            throwConnection:Disconnect()
        end
        
        throwConnection = RunService.Heartbeat:Connect(function()
            if throwing and throwTarget and throwTarget.Character then
                local targetRoot = throwTarget.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and humanoidRootPart then
                    
                    if throwPhase == "away" then
                        throwAngle = throwAngle + 0.1
                        local baseRadius = 10
                        if math.random(1, 100) == 1 then
                            baseRadius = 20
                        end
                        local radius = baseRadius
                        local x = math.cos(throwAngle) * radius
                        local z = math.sin(throwAngle) * radius
                        local throwPos = targetRoot.Position + Vector3.new(x, 2, z)
                        
                        humanoidRootPart.CFrame = CFrame.new(throwPos)
                        
                        if (humanoidRootPart.Position - throwPos).Magnitude < 1 then
                            throwPhase = "attack"
                        end
                        
                    elseif throwPhase == "attack" then
                        humanoidRootPart.CFrame = targetRoot.CFrame
                        throwPhase = "away"
                    end
                end
            end
        end)
    end
end)

textBox5:GetPropertyChangedSignal("Text"):Connect(function()
    if textBox5.Text == "" then
        packing = false
        packTarget = nil
        if packConnection then
            packConnection:Disconnect()
            packConnection = nil
        end
    else
        packing = true
        packTarget = nil
        packPhase = "through"
        packAngle = 0
        
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(plr.Name, 1, #textBox5.Text)) == string.lower(textBox5.Text) then
                packTarget = plr
                break
            end
        end
        
        if packConnection then
            packConnection:Disconnect()
        end
        
        packConnection = RunService.Heartbeat:Connect(function()
            if packing and packTarget and packTarget.Character then
                local targetRoot = packTarget.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and humanoidRootPart then
                    
                    if packPhase == "through" then
                        packAngle = packAngle + 1000000000000
                        local radius = 15
                        local x = math.cos(packAngle) * radius
                        local z = math.sin(packAngle) * radius
                        local throughPos = targetRoot.Position + Vector3.new(x, 2, z)
                        
                        humanoidRootPart.CFrame = CFrame.new(throughPos)
                        
                        if (humanoidRootPart.Position - throughPos).Magnitude < 1 then
                            packPhase = "back"
                        end
                        
                    elseif packPhase == "back" then
                        humanoidRootPart.CFrame = targetRoot.CFrame
                        packPhase = "through"
                    end
                end
            end
        end)
    end
end)

textBox6:GetPropertyChangedSignal("Text"):Connect(function()
    if textBox6.Text == "" then
        backpacking = false
        backpackTarget = nil
        backpackPhase = "spin"
        if backpackConnection then
            backpackConnection:Disconnect()
            backpackConnection = nil
        end
    else
        backpacking = true
        backpackTarget = nil
        backpackPhase = "spin"
        backpackTimer = tick()
        backpackSpinAngle = 0
        
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(string.sub(plr.Name, 1, #textBox6.Text)) == string.lower(textBox6.Text) then
                backpackTarget = plr
                break
            end
        end
        
        if backpackConnection then
            backpackConnection:Disconnect()
        end
        
        backpackConnection = RunService.Heartbeat:Connect(function()
            if backpacking and backpackTarget and backpackTarget.Character then
                local targetRoot = backpackTarget.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and humanoidRootPart then
                    
                    if backpackPhase == "spin" then
                        backpackSpinAngle = backpackSpinAngle + 0.2
                        local radius = 3
                        local x = math.cos(backpackSpinAngle) * radius
                        local z = math.sin(backpackSpinAngle) * radius
                        
                        humanoidRootPart.CFrame = CFrame.new(
                            humanoidRootPart.Position.X + x,
                            humanoidRootPart.Position.Y,
                            humanoidRootPart.Position.Z + z
                        ) * CFrame.Angles(0, backpackSpinAngle, 0)
                        
                        if tick() - backpackTimer > 2 then
                            backpackPhase = "attack"
                            backpackTimer = tick()
                        end
                        
                    elseif backpackPhase == "attack" then
                        local direction = (targetRoot.Position - humanoidRootPart.Position).Unit
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame + direction * 10
                        
                        if (humanoidRootPart.Position - targetRoot.Position).Magnitude < 5 then
                            backpackPhase = "away"
                            backpackTimer = tick()
                        end
                        
                    elseif backpackPhase == "away" then
                        local awayDir = (humanoidRootPart.Position - targetRoot.Position).Unit
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame + awayDir * 8.33
                        
                        if (humanoidRootPart.Position - targetRoot.Position).Magnitude > 20 then
                            backpackPhase = "spin"
                            backpackTimer = tick()
                        end
                    end
                end
            end
        end)
    end
end)

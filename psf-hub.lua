-- PSF Hub for Executors
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Переменные
local ESPEnabled = false
local ChamsEnabled = false
local TracersEnabled = false
local ESPPlayers = {}
local ChamsPlayers = {}
local TracersPlayers = {}

-- Настройки визуалов
local VisualsSettings = {
    ESP = {
        ShowName = true,
        ShowDistance = true,
        TextColor = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        MaxDistance = 1000
    },
    Chams = {
        FillColor = Color3.fromRGB(255, 0, 0),
        OutlineColor = Color3.fromRGB(255, 255, 255),
        FillTransparency = 0.5,
        OutlineTransparency = 0
    },
    Tracers = {
        Color = Color3.fromRGB(0, 255, 0),
        Thickness = 2,
        Transparency = 0.8
    }
}

-- Настройки LocalPlayer
local LocalPlayerSettings = {
    Fly = {
        Enabled = false,
        Speed = 50,
        UpSpeed = 25
    },
    InfiniteJump = {
        Enabled = false
    }
}

-- Настройки Utilities
local UtilitiesSettings = {
    JumpBooster = {
        Enabled = false,
        Multiplier = 2.0
    },
    Platform = {
        Enabled = false
    }
}

-- Переменные для Fly
local flying = false
local flyConnection
local bodyVelocity
local bodyGyro

-- Переменные для Utilities
local jumpBoosterGui
local platformGui
local platformPart
local originalJumpPower
local jumpBoosterConnection

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PSFHub"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- Основная кнопка переключения С ИЗОБРАЖЕНИЕМ
local ToggleButton = Instance.new("ImageButton") -- Изменено на ImageButton
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleButton.BorderSizePixel = 0
ToggleButton.ZIndex = 10

-- === ВАЖНО: ЗАМЕНИТЕ ЭТУ ССЫЛКУ НА ВАШЕ ИЗОБРАЖЕНИЕ ===
-- Как получить ссылку на изображение:
-- 1. Загрузите изображение на любой хостинг (imgur, discord, etc.)
-- 2. Получите прямую ссылку на изображение (должна заканчиваться на .png, .jpg и т.д.)
-- 3. Вставьте ссылку ниже вместо "https://imgur.com/a/e9XGUoL"

ToggleButton.Image = "rbxassetid://0" -- ЗАМЕНИТЕ ЭТУ ССЫЛКУ
ToggleButton.ScaleType = Enum.ScaleType.Fit -- Сохраняет пропорции изображения
ToggleButton.BackgroundTransparency = 1 -- Прозрачный фон

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

ToggleButton.Parent = ScreenGui

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0, 80, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Заголовок для перемещения
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "PSF HUB - Drag to Move"
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Перемещение окна
local dragging = false
local dragStart
local startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

Title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

Title.Parent = MainFrame

-- Табы
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 30)
TabButtons.Position = UDim2.new(0, 0, 0, 30)
TabButtons.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Parent = TabButtons

TabButtons.Parent = MainFrame

-- Контент табов
local TabContent = Instance.new("Frame")
TabContent.Size = UDim2.new(1, -20, 1, -70)
TabContent.Position = UDim2.new(0, 10, 0, 70)
TabContent.BackgroundTransparency = 1
TabContent.Parent = MainFrame

MainFrame.Parent = ScreenGui

-- Табы
local Tabs = {
    {Name = "LocalPlayer", Color = Color3.fromRGB(0, 170, 255)},
    {Name = "Visuals", Color = Color3.fromRGB(255, 85, 0)},
    {Name = "Utilities", Color = Color3.fromRGB(0, 200, 100)}
}

local CurrentTab = nil
local TabFrames = {}

-- Функция для перемещения кнопки на указанные координаты
local function moveButtonToPosition(x, y)
    ToggleButton.Position = UDim2.new(0, x, 0, y)
end

-- Переключение меню
local isMenuVisible = false

ToggleButton.MouseButton1Click:Connect(function()
    isMenuVisible = not isMenuVisible
    MainFrame.Visible = isMenuVisible
    
    -- Анимация
    local tweenInfo = TweenInfo.new(0.2)
    local tween = TweenService:Create(ToggleButton, tweenInfo, {
        Rotation = isMenuVisible and 180 or 0
    })
    tween:Play()
end)

-- ... (остальной код остается без изменений, кроме удаления текстовых ссылок на "PSF")

-- Создание переключателя
local function CreateToggle(name, parent, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.BackgroundTransparency = 1
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.Text = ""
    ToggleButton.BorderSizePixel = 0
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleStatus = Instance.new("Frame")
    ToggleStatus.Size = UDim2.new(0, 20, 0, 20)
    ToggleStatus.Position = UDim2.new(1, -30, 0.5, -10)
    ToggleStatus.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 4)
    StatusCorner.Parent = ToggleStatus
    
    local IsToggled = false
    
    ToggleButton.MouseButton1Click:Connect(function()
        IsToggled = not IsToggled
        if IsToggled then
            ToggleStatus.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            callback(true)
        else
            ToggleStatus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            callback(false)
        end
    end)
    
    ToggleStatus.Parent = ToggleButton
    ToggleLabel.Parent = ToggleButton
    ToggleButton.Parent = ToggleFrame
    
    return ToggleFrame
end

-- ... (остальной код остается без изменений)

print("✅ PSF Hub loaded!")
print("🖼️ Image button ready - replace the image link!")
print("🚀 Added Fly and Infinite Jump features!")
print("🦘 Added Jump Booster with customizable multiplier!")
print("🛠️ Added Utilities tab with Jump Booster and Platform!")
print("🎯 Visuals features with full customization!")

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SubscribeScreen"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.new(0, 0, 0)
background.BorderSizePixel = 0
background.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0.2, 0)
textLabel.Position = UDim2.new(0, 0, 0.4, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "pls subscribe to t.me/psfhub!loading... "
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = screenGui

screenGui.Parent = playerGui

-- Ждем 3 секунды и удаляем
wait(3)
screenGui:Destroy()
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

-- Основная кнопка переключения
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "PSF"
ToggleButton.TextSize = 14
ToggleButton.BorderSizePixel = 0
ToggleButton.ZIndex = 10

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

ToggleButton.Parent = ScreenGui

-- Основное окно (уменьшена высота)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400) -- Уменьшено с 500 до 400
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
Title.Text = "PSF HUB - t.me/psfhub"
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

-- Контент табов (уменьшена высота)
local TabContent = Instance.new("Frame")
TabContent.Size = UDim2.new(1, -20, 1, -70) -- Автоматически адаптируется к уменьшенной высоте MainFrame
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

-- Поле ввода чисел
local function CreateNumberInput(name, parent, default, callback)
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, 0, 0, 40)
    InputFrame.BackgroundTransparency = 1
    
    local InputLabel = Instance.new("TextLabel")
    InputLabel.Size = UDim2.new(0.4, 0, 1, 0)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = name
    InputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputLabel.TextSize = 14
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.4, 0, 0.6, 0)
    TextBox.Position = UDim2.new(0.4, 0, 0.2, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.Text = tostring(default)
    TextBox.TextSize = 14
    TextBox.BorderSizePixel = 0
    TextBox.PlaceholderText = "Enter number..."
    
    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 4)
    TextBoxCorner.Parent = TextBox
    
    local ApplyButton = Instance.new("TextButton")
    ApplyButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    ApplyButton.Position = UDim2.new(0.8, 5, 0.2, 0)
    ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ApplyButton.Text = "Apply"
    ApplyButton.TextSize = 12
    ApplyButton.BorderSizePixel = 0
    
    local ApplyCorner = Instance.new("UICorner")
    ApplyCorner.CornerRadius = UDim.new(0, 4)
    ApplyCorner.Parent = ApplyButton
    
    ApplyButton.MouseButton1Click:Connect(function()
        local value = tonumber(TextBox.Text)
        if value then
            callback(value)
        else
            TextBox.Text = "Invalid"
        end
    end)
    
    InputLabel.Parent = InputFrame
    TextBox.Parent = InputFrame
    ApplyButton.Parent = InputFrame
    
    return InputFrame
end

-- Функция создания выбора цвета
local function CreateColorPicker(name, parent, defaultColor, callback)
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Size = UDim2.new(1, 0, 0, 40)
    ColorFrame.BackgroundTransparency = 1
    
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Size = UDim2.new(0.4, 0, 1, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = name
    ColorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorLabel.TextSize = 14
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Parent = ColorFrame
    
    local ColorPreview = Instance.new("Frame")
    ColorPreview.Size = UDim2.new(0.2, 0, 0.6, 0)
    ColorPreview.Position = UDim2.new(0.4, 0, 0.2, 0)
    ColorPreview.BackgroundColor3 = defaultColor
    ColorPreview.BorderSizePixel = 0
    
    local ColorCorner = Instance.new("UICorner")
    ColorCorner.CornerRadius = UDim.new(0, 4)
    ColorCorner.Parent = ColorPreview
    ColorPreview.Parent = ColorFrame
    
    local ColorButton = Instance.new("TextButton")
    ColorButton.Size = UDim2.new(0.3, 0, 0.6, 0)
    ColorButton.Position = UDim2.new(0.65, 5, 0.2, 0)
    ColorButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    ColorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorButton.Text = "Pick Color"
    ColorButton.TextSize = 12
    ColorButton.BorderSizePixel = 0
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = ColorButton
    
    ColorButton.MouseButton1Click:Connect(function()
        -- Простой выбор цвета через RGB поля
        local RBox = Instance.new("TextBox")
        RBox.Size = UDim2.new(0.2, 0, 1, 0)
        RBox.Position = UDim2.new(0.4, 0, 0, 0)
        RBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        RBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        RBox.Text = tostring(math.floor(defaultColor.R * 255))
        RBox.PlaceholderText = "R"
        RBox.Parent = ColorFrame
        
        local GBox = Instance.new("TextBox")
        GBox.Size = UDim2.new(0.2, 0, 1, 0)
        GBox.Position = UDim2.new(0.65, 5, 0, 0)
        GBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        GBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        GBox.Text = tostring(math.floor(defaultColor.G * 255))
        GBox.PlaceholderText = "G"
        GBox.Parent = ColorFrame
        
        local BBox = Instance.new("TextBox")
        BBox.Size = UDim2.new(0.2, 0, 1, 0)
        BBox.Position = UDim2.new(0.9, 10, 0, 0)
        BBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        BBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        BBox.Text = tostring(math.floor(defaultColor.B * 255))
        BBox.PlaceholderText = "B"
        BBox.Parent = ColorFrame
        
        local ApplyColor = Instance.new("TextButton")
        ApplyColor.Size = UDim2.new(0.3, 0, 1, 0)
        ApplyColor.Position = UDim2.new(1.2, 15, 0, 0)
        ApplyColor.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        ApplyColor.TextColor3 = Color3.fromRGB(255, 255, 255)
        ApplyColor.Text = "Apply"
        ApplyColor.TextSize = 12
        ApplyColor.Parent = ColorFrame
        
        ApplyColor.MouseButton1Click:Connect(function()
            local r = tonumber(RBox.Text) or 255
            local g = tonumber(GBox.Text) or 255
            local b = tonumber(BBox.Text) or 255
            local newColor = Color3.fromRGB(r, g, b)
            ColorPreview.BackgroundColor3 = newColor
            callback(newColor)
            
            RBox:Destroy()
            GBox:Destroy()
            BBox:Destroy()
            ApplyColor:Destroy()
        end)
    end)
    
    ColorButton.Parent = ColorFrame
    
    return ColorFrame
end

-- Функция создания поля для позиционирования кнопки
local function CreatePositionInput(parent)
    local PositionFrame = Instance.new("Frame")
    PositionFrame.Size = UDim2.new(1, 0, 0, 60)
    PositionFrame.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 20)
    Title.BackgroundTransparency = 1
    Title.Text = "Button Position"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = PositionFrame
    
    -- Поля ввода координат
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, 0, 0, 25)
    InputFrame.Position = UDim2.new(0, 0, 0, 30)
    InputFrame.BackgroundTransparency = 1
    
    local XLabel = Instance.new("TextLabel")
    XLabel.Size = UDim2.new(0.1, 0, 1, 0)
    XLabel.BackgroundTransparency = 1
    XLabel.Text = "X:"
    XLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    XLabel.TextSize = 12
    XLabel.TextXAlignment = Enum.TextXAlignment.Left
    XLabel.Parent = InputFrame
    
    local XTextBox = Instance.new("TextBox")
    XTextBox.Size = UDim2.new(0.3, 0, 1, 0)
    XTextBox.Position = UDim2.new(0.1, 5, 0, 0)
    XTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    XTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    XTextBox.Text = "20"
    XTextBox.TextSize = 12
    XTextBox.BorderSizePixel = 0
    XTextBox.PlaceholderText = "X"
    
    local XCorner = Instance.new("UICorner")
    XCorner.CornerRadius = UDim.new(0, 4)
    XCorner.Parent = XTextBox
    XTextBox.Parent = InputFrame
    
    local YLabel = Instance.new("TextLabel")
    YLabel.Size = UDim2.new(0.1, 0, 1, 0)
    YLabel.Position = UDim2.new(0.4, 10, 0, 0)
    YLabel.BackgroundTransparency = 1
    YLabel.Text = "Y:"
    YLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    YLabel.TextSize = 12
    YLabel.TextXAlignment = Enum.TextXAlignment.Left
    YLabel.Parent = InputFrame
    
    local YTextBox = Instance.new("TextBox")
    YTextBox.Size = UDim2.new(0.3, 0, 1, 0)
    YTextBox.Position = UDim2.new(0.5, 5, 0, 0)
    YTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    YTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    YTextBox.Text = "20"
    YTextBox.TextSize = 12
    YTextBox.BorderSizePixel = 0
    YTextBox.PlaceholderText = "Y"
    
    local YCorner = Instance.new("UICorner")
    YCorner.CornerRadius = UDim.new(0, 4)
    YCorner.Parent = YTextBox
    YTextBox.Parent = InputFrame
    
    local MoveButton = Instance.new("TextButton")
    MoveButton.Size = UDim2.new(0.2, 0, 1, 0)
    MoveButton.Position = UDim2.new(0.8, 5, 0, 0)
    MoveButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    MoveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MoveButton.Text = "Move"
    MoveButton.TextSize = 12
    MoveButton.BorderSizePixel = 0
    
    local MoveCorner = Instance.new("UICorner")
    MoveCorner.CornerRadius = UDim.new(0, 4)
    MoveCorner.Parent = MoveButton
    
    MoveButton.MouseButton1Click:Connect(function()
        local x = tonumber(XTextBox.Text) or 0
        local y = tonumber(YTextBox.Text) or 0
        moveButtonToPosition(x, y)
        MoveButton.Text = "Moved!"
        wait(1)
        MoveButton.Text = "Move"
    end)
    MoveButton.Parent = InputFrame
    
    InputFrame.Parent = PositionFrame
    
    return PositionFrame
end

-- Функция создания отдельного GUI для утилит
local function CreateUtilityGUI(name, buttonText, callback)
    local utilityGui = Instance.new("ScreenGui")
    utilityGui.Name = name .. "GUI"
    utilityGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 80)
    mainFrame.Position = UDim2.new(0, 400, 0, 100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = name
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title
    title.Parent = mainFrame
    
    local actionButton = Instance.new("TextButton")
    actionButton.Size = UDim2.new(0.8, 0, 0, 30)
    actionButton.Position = UDim2.new(0.1, 0, 0.5, -15)
    actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    actionButton.Text = buttonText
    actionButton.TextSize = 12
    actionButton.BorderSizePixel = 0
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = actionButton
    
    actionButton.MouseButton1Click:Connect(function()
        callback()
    end)
    
    actionButton.Parent = mainFrame
    mainFrame.Parent = utilityGui
    
    -- Функция для перемещения GUI
    local utilityDragging = false
    local utilityDragStart
    local utilityStartPos
    
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            utilityDragging = true
            utilityDragStart = input.Position
            utilityStartPos = mainFrame.Position
        end
    end)
    
    title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            utilityDragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and utilityDragging then
            local delta = input.Position - utilityDragStart
            mainFrame.Position = UDim2.new(
                utilityStartPos.X.Scale, 
                utilityStartPos.X.Offset + delta.X,
                utilityStartPos.Y.Scale, 
                utilityStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    return utilityGui, actionButton
end

-- Jump Booster функция
local function ToggleJumpBooster()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if UtilitiesSettings.JumpBooster.Enabled then
        -- Включаем Jump Booster
        originalJumpPower = humanoid.JumpPower
        humanoid.JumpPower = originalJumpPower * UtilitiesSettings.JumpBooster.Multiplier
        
        -- Обновляем текст кнопки
        if jumpBoosterButton then
            jumpBoosterButton.Text = "Jump Booster: ON"
            jumpBoosterButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        end
    else
        -- Выключаем Jump Booster
        if originalJumpPower then
            humanoid.JumpPower = originalJumpPower
        else
            humanoid.JumpPower = 50 -- Значение по умолчанию
        end
        
        -- Обновляем текст кнопки
        if jumpBoosterButton then
            jumpBoosterButton.Text = "Jump Booster: OFF"
            jumpBoosterButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        end
    end
end

-- Platform функция
local function CreatePlatform()
    local character = player.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    -- Удаляем старую платформу если есть
    if platformPart then
        platformPart:Destroy()
        platformPart = nil
    end
    
    -- Создаем новую платформу под ногами
    platformPart = Instance.new("Part")
    platformPart.Name = "PlayerPlatform"
    platformPart.Size = Vector3.new(10, 1, 10)
    platformPart.Position = rootPart.Position - Vector3.new(0, 3, 0)
    platformPart.Anchored = true
    platformPart.CanCollide = true
    platformPart.BrickColor = BrickColor.new("Bright blue")
    platformPart.Material = Enum.Material.Plastic
    platformPart.Parent = workspace
    
    -- Добавляем подсветку для видимости
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 100, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0
    highlight.Parent = platformPart
end

local function RemovePlatform()
    if platformPart then
        platformPart:Destroy()
        platformPart = nil
    end
end

-- Fly система
local function StartFly()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    -- Создаем BodyVelocity и BodyGyro для полета
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    bodyVelocity.P = 10000
    bodyVelocity.Parent = rootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
    bodyGyro.P = 1000
    bodyGyro.D = 100
    bodyGyro.Parent = rootPart
    
    flying = true
    
    -- Отключаем гравитацию для персонажа
    humanoid.PlatformStand = true
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flying or not bodyVelocity or not bodyGyro or not rootPart then
            if flyConnection then
                flyConnection:Disconnect()
            end
            return
        end
        
        local direction = Vector3.new()
        
        -- Движение вперед/назад
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + rootPart.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - rootPart.CFrame.LookVector
        end
        
        -- Движение влево/вправо
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - rootPart.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + rootPart.CFrame.RightVector
        end
        
        -- Движение вверх/вниз
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            direction = direction - Vector3.new(0, 1, 0)
        end
        
        -- Нормализуем направление и применяем скорость
        if direction.Magnitude > 0 then
            direction = direction.Unit
            bodyVelocity.Velocity = direction * LocalPlayerSettings.Fly.Speed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        
        -- Обновляем гироскоп для стабилизации
        bodyGyro.CFrame = rootPart.CFrame
    end)
end

local function StopFly()
    flying = false
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoid then
            humanoid.PlatformStand = false
        end
        
        if rootPart then
            if bodyVelocity then
                bodyVelocity:Destroy()
                bodyVelocity = nil
            end
            if bodyGyro then
                bodyGyro:Destroy()
                bodyGyro = nil
            end
        end
    end
end

-- Infinite Jump система
local function StartInfiniteJump()
    local connection
    connection = UIS.JumpRequest:Connect(function()
        if LocalPlayerSettings.InfiniteJump.Enabled then
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        else
            if connection then
                connection:Disconnect()
            end
        end
    end)
end

-- ESP система
local function CreateESP()
    for _, esp in pairs(ESPPlayers) do
        if esp.BillboardGui then
            esp.BillboardGui:Destroy()
        end
    end
    ESPPlayers = {}
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local character = otherPlayer.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESP_" .. otherPlayer.Name
                    billboard.Adornee = humanoidRootPart
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.MaxDistance = VisualsSettings.ESP.MaxDistance
                    billboard.Parent = humanoidRootPart
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = VisualsSettings.ESP.ShowName and otherPlayer.Name or ""
                    nameLabel.TextColor3 = VisualsSettings.ESP.TextColor
                    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextSize = VisualsSettings.ESP.TextSize
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Visible = VisualsSettings.ESP.ShowName
                    nameLabel.Parent = billboard
                    
                    local distanceLabel = Instance.new("TextLabel")
                    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
                    distanceLabel.BackgroundTransparency = 1
                    distanceLabel.TextColor3 = VisualsSettings.ESP.TextColor
                    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    distanceLabel.TextStrokeTransparency = 0
                    distanceLabel.TextSize = VisualsSettings.ESP.TextSize - 2
                    distanceLabel.Font = Enum.Font.Gotham
                    distanceLabel.Visible = VisualsSettings.ESP.ShowDistance
                    distanceLabel.Parent = billboard
                    
                    ESPPlayers[otherPlayer] = {
                        BillboardGui = billboard,
                        NameLabel = nameLabel,
                        DistanceLabel = distanceLabel,
                        Character = character
                    }
                    
                    local function updateDistance()
                        if character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local playerPos = player.Character.HumanoidRootPart.Position
                            local otherPos = humanoidRootPart.Position
                            local distance = (playerPos - otherPos).Magnitude
                            if VisualsSettings.ESP.ShowDistance then
                                distanceLabel.Text = math.floor(distance) .. " studs"
                            end
                        end
                    end
                    
                    RunService.Heartbeat:Connect(updateDistance)
                end
            end
        end
    end
    
    local function playerAdded(newPlayer)
        if newPlayer ~= player then
            newPlayer.CharacterAdded:Connect(function(character)
                wait(1)
                if ESPEnabled and character:FindFirstChild("HumanoidRootPart") then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESP_" .. newPlayer.Name
                    billboard.Adornee = humanoidRootPart
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.MaxDistance = VisualsSettings.ESP.MaxDistance
                    billboard.Parent = humanoidRootPart
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = VisualsSettings.ESP.ShowName and newPlayer.Name or ""
                    nameLabel.TextColor3 = VisualsSettings.ESP.TextColor
                    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextSize = VisualsSettings.ESP.TextSize
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Visible = VisualsSettings.ESP.ShowName
                    nameLabel.Parent = billboard
                    
                    local distanceLabel = Instance.new("TextLabel")
                    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
                    distanceLabel.BackgroundTransparency = 1
                    distanceLabel.TextColor3 = VisualsSettings.ESP.TextColor
                    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    distanceLabel.TextStrokeTransparency = 0
                    distanceLabel.TextSize = VisualsSettings.ESP.TextSize - 2
                    distanceLabel.Font = Enum.Font.Gotham
                    distanceLabel.Visible = VisualsSettings.ESP.ShowDistance
                    distanceLabel.Parent = billboard
                    
                    ESPPlayers[newPlayer] = {
                        BillboardGui = billboard,
                        NameLabel = nameLabel,
                        DistanceLabel = distanceLabel,
                        Character = character
                    }
                end
            end)
        end
    end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        playerAdded(otherPlayer)
    end
    
    Players.PlayerAdded:Connect(playerAdded)
end

-- Обновление ESP настроек
local function UpdateESP()
    for _, esp in pairs(ESPPlayers) do
        if esp.NameLabel then
            esp.NameLabel.TextColor3 = VisualsSettings.ESP.TextColor
            esp.NameLabel.TextSize = VisualsSettings.ESP.TextSize
            esp.NameLabel.Visible = VisualsSettings.ESP.ShowName
            esp.NameLabel.Text = VisualsSettings.ESP.ShowName and esp.NameLabel.Text or ""
        end
        if esp.DistanceLabel then
            esp.DistanceLabel.TextColor3 = VisualsSettings.ESP.TextColor
            esp.DistanceLabel.TextSize = VisualsSettings.ESP.TextSize - 2
            esp.DistanceLabel.Visible = VisualsSettings.ESP.ShowDistance
        end
        if esp.BillboardGui then
            esp.BillboardGui.MaxDistance = VisualsSettings.ESP.MaxDistance
        end
    end
end

-- Удаление ESP
local function RemoveESP()
    for _, esp in pairs(ESPPlayers) do
        if esp.BillboardGui then
            esp.BillboardGui:Destroy()
        end
    end
    ESPPlayers = {}
end

-- Chams система
local function CreateChams()
    for _, chams in pairs(ChamsPlayers) do
        if chams.Highlight then
            chams.Highlight:Destroy()
        end
    end
    ChamsPlayers = {}
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local character = otherPlayer.Character
            if character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "Chams_" .. otherPlayer.Name
                highlight.FillColor = VisualsSettings.Chams.FillColor
                highlight.OutlineColor = VisualsSettings.Chams.OutlineColor
                highlight.FillTransparency = VisualsSettings.Chams.FillTransparency
                highlight.OutlineTransparency = VisualsSettings.Chams.OutlineTransparency
                highlight.Parent = character
                
                ChamsPlayers[otherPlayer] = {
                    Highlight = highlight,
                    Character = character
                }
            end
        end
    end
    
    local function playerAdded(newPlayer)
        if newPlayer ~= player then
            newPlayer.CharacterAdded:Connect(function(character)
                wait(1)
                if ChamsEnabled then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "Chams_" .. newPlayer.Name
                    highlight.FillColor = VisualsSettings.Chams.FillColor
                    highlight.OutlineColor = VisualsSettings.Chams.OutlineColor
                    highlight.FillTransparency = VisualsSettings.Chams.FillTransparency
                    highlight.OutlineTransparency = VisualsSettings.Chams.OutlineTransparency
                    highlight.Parent = character
                    
                    ChamsPlayers[newPlayer] = {
                        Highlight = highlight,
                        Character = character
                    }
                end
            end)
        end
    end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        playerAdded(otherPlayer)
    end
    
    Players.PlayerAdded:Connect(playerAdded)
end

-- Обновление Chams настроек
local function UpdateChams()
    for _, chams in pairs(ChamsPlayers) do
        if chams.Highlight then
            chams.Highlight.FillColor = VisualsSettings.Chams.FillColor
            chams.Highlight.OutlineColor = VisualsSettings.Chams.OutlineColor
            chams.Highlight.FillTransparency = VisualsSettings.Chams.FillTransparency
            chams.Highlight.OutlineTransparency = VisualsSettings.Chams.OutlineTransparency
        end
    end
end

-- Удаление Chams
local function RemoveChams()
    for _, chams in pairs(ChamsPlayers) do
        if chams.Highlight then
            chams.Highlight:Destroy()
        end
    end
    ChamsPlayers = {}
end

-- Tracers система (ИСПРАВЛЕННАЯ)
local function CreateTracers()
    for _, tracer in pairs(TracersPlayers) do
        if tracer.Beam then
            tracer.Beam:Destroy()
        end
        if tracer.Attachment0 then
            tracer.Attachment0:Destroy()
        end
        if tracer.Attachment1 then
            tracer.Attachment1:Destroy()
        end
    end
    TracersPlayers = {}
    
    local function createTracerForPlayer(otherPlayer, character)
        if character and character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local playerRoot = player.Character.HumanoidRootPart
            local otherRoot = character.HumanoidRootPart
            
            -- Создаем аттачменты для начала и конца линии
            local attachment0 = Instance.new("Attachment")
            attachment0.Name = "TracerStart"
            attachment0.Parent = playerRoot
            
            local attachment1 = Instance.new("Attachment")
            attachment1.Name = "TracerEnd"
            attachment1.Parent = otherRoot
            
            -- Создаем луч между аттачментами
            local beam = Instance.new("Beam")
            beam.Name = "Tracer_" .. otherPlayer.Name
            beam.Color = ColorSequence.new(VisualsSettings.Tracers.Color)
            beam.Width0 = VisualsSettings.Tracers.Thickness
            beam.Width1 = VisualsSettings.Tracers.Thickness
            beam.Transparency = NumberSequence.new(VisualsSettings.Tracers.Transparency)
            beam.Attachment0 = attachment0
            beam.Attachment1 = attachment1
            beam.FaceCamera = true
            beam.Parent = playerRoot
            
            TracersPlayers[otherPlayer] = {
                Beam = beam,
                Attachment0 = attachment0,
                Attachment1 = attachment1,
                Character = character
            }
        end
    end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local character = otherPlayer.Character
            if character then
                createTracerForPlayer(otherPlayer, character)
            end
        end
    end
    
    local function playerAdded(newPlayer)
        if newPlayer ~= player then
            newPlayer.CharacterAdded:Connect(function(character)
                wait(1)
                if TracersEnabled then
                    createTracerForPlayer(newPlayer, character)
                end
            end)
        end
    end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        playerAdded(otherPlayer)
    end
    
    Players.PlayerAdded:Connect(playerAdded)
end

-- Обновление Tracers настроек
local function UpdateTracers()
    for _, tracer in pairs(TracersPlayers) do
        if tracer.Beam then
            tracer.Beam.Color = ColorSequence.new(VisualsSettings.Tracers.Color)
            tracer.Beam.Width0 = VisualsSettings.Tracers.Thickness
            tracer.Beam.Width1 = VisualsSettings.Tracers.Thickness
            tracer.Beam.Transparency = NumberSequence.new(VisualsSettings.Tracers.Transparency)
        end
    end
end

-- Удаление Tracers
local function RemoveTracers()
    for _, tracer in pairs(TracersPlayers) do
        if tracer.Beam then
            tracer.Beam:Destroy()
        end
        if tracer.Attachment0 then
            tracer.Attachment0:Destroy()
        end
        if tracer.Attachment1 then
            tracer.Attachment1:Destroy()
        end
    end
    TracersPlayers = {}
end

-- Создание табов
for i, tab in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.5, 0, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Text = tab.Name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 14
    TabButton.BorderSizePixel = 0
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Parent = TabButton
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.ScrollBarThickness = 6
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
    TabFrame.Visible = false
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.Parent = TabFrame
    
    -- Автоматически обновляем размер контента
    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
    end)
    
    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(TabFrames) do
            frame.Visible = false
        end
        TabFrame.Visible = true
        CurrentTab = tab.Name
        for _, btn in pairs(TabButtons:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
        end
        TabButton.BackgroundColor3 = tab.Color
    end)
    
    TabButton.Parent = TabButtons
    TabFrame.Parent = TabContent
    TabFrames[tab.Name] = TabFrame
    
    if tab.Name == "LocalPlayer" then
        -- Основные настройки движения
        local movementTitle = Instance.new("TextLabel")
        movementTitle.Size = UDim2.new(1, 0, 0, 20)
        movementTitle.BackgroundTransparency = 1
        movementTitle.Text = "Movement"
        movementTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        movementTitle.TextSize = 16
        movementTitle.Font = Enum.Font.GothamBold
        movementTitle.TextXAlignment = Enum.TextXAlignment.Left
        movementTitle.Parent = TabFrame
        
        local walkSpeedInput = CreateNumberInput("Walk Speed", TabFrame, 16, function(value)
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = value
            end
        end)
        walkSpeedInput.Parent = TabFrame
        
        local jumpPowerInput = CreateNumberInput("Jump Power", TabFrame, 50, function(value)
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.JumpPower = value
            end
        end)
        jumpPowerInput.Parent = TabFrame
        
        local gravityInput = CreateNumberInput("Gravity", TabFrame, 196.2, function(value)
            workspace.Gravity = value
        end)
        gravityInput.Parent = TabFrame
        
        -- Fly система
        local flyTitle = Instance.new("TextLabel")
        flyTitle.Size = UDim2.new(1, 0, 0, 20)
        flyTitle.BackgroundTransparency = 1
        flyTitle.Text = "Fly"
        flyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        flyTitle.TextSize = 16
        flyTitle.Font = Enum.Font.GothamBold
        flyTitle.TextXAlignment = Enum.TextXAlignment.Left
        flyTitle.Parent = TabFrame
        
        local flyToggle = CreateToggle("Enable Fly", TabFrame, function(state)
            LocalPlayerSettings.Fly.Enabled = state
            if state then
                StartFly()
            else
                StopFly()
            end
        end)
        flyToggle.Parent = TabFrame
        
        local flySpeedInput = CreateNumberInput("Fly Speed", TabFrame, LocalPlayerSettings.Fly.Speed, function(value)
            LocalPlayerSettings.Fly.Speed = value
        end)
        flySpeedInput.Parent = TabFrame
        
        local flyUpSpeedInput = CreateNumberInput("Fly Up Speed", TabFrame, LocalPlayerSettings.Fly.UpSpeed, function(value)
            LocalPlayerSettings.Fly.UpSpeed = value
        end)
        flyUpSpeedInput.Parent = TabFrame
        
        -- Инструкция по управлению Fly
        local flyInstructions = Instance.new("TextLabel")
        flyInstructions.Size = UDim2.new(1, 0, 0, 40)
        flyInstructions.BackgroundTransparency = 1
        flyInstructions.Text = "Fly Controls:\nWASD - Move, Space - Up, Shift - Down"
        flyInstructions.TextColor3 = Color3.fromRGB(200, 200, 200)
        flyInstructions.TextSize = 12
        flyInstructions.TextXAlignment = Enum.TextXAlignment.Left
        flyInstructions.TextYAlignment = Enum.TextYAlignment.Top
        flyInstructions.Parent = TabFrame
        
        -- Infinite Jump система
        local jumpTitle = Instance.new("TextLabel")
        jumpTitle.Size = UDim2.new(1, 0, 0, 20)
        jumpTitle.BackgroundTransparency = 1
        jumpTitle.Text = "Jump"
        jumpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpTitle.TextSize = 16
        jumpTitle.Font = Enum.Font.GothamBold
        jumpTitle.TextXAlignment = Enum.TextXAlignment.Left
        jumpTitle.Parent = TabFrame
        
        local infiniteJumpToggle = CreateToggle("Infinite Jump", TabFrame, function(state)
            LocalPlayerSettings.InfiniteJump.Enabled = state
            if state then
                StartInfiniteJump()
            end
        end)
        infiniteJumpToggle.Parent = TabFrame
        
    elseif tab.Name == "Visuals" then
        -- Добавляем систему позиционирования кнопки
        local positionInput = CreatePositionInput(TabFrame)
        positionInput.Parent = TabFrame
        
        -- Основные переключатели
        local espToggle = CreateToggle("ESP Players", TabFrame, function(state)
            ESPEnabled = state
            if state then
                CreateESP()
            else
                RemoveESP()
            end
        end)
        espToggle.Parent = TabFrame
        
        local chamsToggle = CreateToggle("Chams", TabFrame, function(state)
            ChamsEnabled = state
            if state then
                CreateChams()
            else
                RemoveChams()
            end
        end)
        chamsToggle.Parent = TabFrame
        
        local tracersToggle = CreateToggle("Tracers", TabFrame, function(state)
            TracersEnabled = state
            if state then
                CreateTracers()
            else
                RemoveTracers()
            end
        end)
        tracersToggle.Parent = TabFrame
        
        -- Настройки ESP
        local espSettingsTitle = Instance.new("TextLabel")
        espSettingsTitle.Size = UDim2.new(1, 0, 0, 20)
        espSettingsTitle.BackgroundTransparency = 1
        espSettingsTitle.Text = "ESP Settings"
        espSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        espSettingsTitle.TextSize = 16
        espSettingsTitle.Font = Enum.Font.GothamBold
        espSettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
        espSettingsTitle.Parent = TabFrame
        
        local showNameToggle = CreateToggle("Show Name", TabFrame, function(state)
            VisualsSettings.ESP.ShowName = state
            if ESPEnabled then UpdateESP() end
        end)
        showNameToggle.Parent = TabFrame
        
        local showDistanceToggle = CreateToggle("Show Distance", TabFrame, function(state)
            VisualsSettings.ESP.ShowDistance = state
            if ESPEnabled then UpdateESP() end
        end)
        showDistanceToggle.Parent = TabFrame
        
        local espColorPicker = CreateColorPicker("ESP Color", TabFrame, VisualsSettings.ESP.TextColor, function(color)
            VisualsSettings.ESP.TextColor = color
            if ESPEnabled then UpdateESP() end
        end)
        espColorPicker.Parent = TabFrame
        
        local espTextSize = CreateNumberInput("Text Size", TabFrame, VisualsSettings.ESP.TextSize, function(value)
            VisualsSettings.ESP.TextSize = value
            if ESPEnabled then UpdateESP() end
        end)
        espTextSize.Parent = TabFrame
        
        local espMaxDistance = CreateNumberInput("Max Distance", TabFrame, VisualsSettings.ESP.MaxDistance, function(value)
            VisualsSettings.ESP.MaxDistance = value
            if ESPEnabled then UpdateESP() end
        end)
        espMaxDistance.Parent = TabFrame
        
    elseif tab.Name == "Utilities" then
        local utilitiesTitle = Instance.new("TextLabel")
        utilitiesTitle.Size = UDim2.new(1, 0, 0, 20)
        utilitiesTitle.BackgroundTransparency = 1
        utilitiesTitle.Text = "Utility Tools"
        utilitiesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        utilitiesTitle.TextSize = 16
        utilitiesTitle.Font = Enum.Font.GothamBold
        utilitiesTitle.TextXAlignment = Enum.TextXAlignment.Left
        utilitiesTitle.Parent = TabFrame
        
        -- Jump Booster
        local jumpBoosterToggle = CreateToggle("Show Jump Booster GUI", TabFrame, function(state)
            UtilitiesSettings.JumpBooster.Enabled = state
            if state then
                if not jumpBoosterGui then
                    jumpBoosterGui, jumpBoosterButton = CreateUtilityGUI("Jump Booster", "Jump Booster: OFF", ToggleJumpBooster)
                    jumpBoosterGui.Parent = playerGui
                else
                    jumpBoosterGui.Enabled = true
                end
            else
                if jumpBoosterGui then
                    jumpBoosterGui.Enabled = false
                end
                -- Выключаем Jump Booster при скрытии GUI
                UtilitiesSettings.JumpBooster.Enabled = false
                ToggleJumpBooster()
            end
        end)
        jumpBoosterToggle.Parent = TabFrame
        
        -- Platform
        local platformToggle = CreateToggle("Show Platform GUI", TabFrame, function(state)
            UtilitiesSettings.Platform.Enabled = state
            if state then
                if not platformGui then
                    platformGui, platformButton = CreateUtilityGUI("Platform", "Create Platform", CreatePlatform)
                    platformGui.Parent = playerGui
                else
                    platformGui.Enabled = true
                end
            else
                if platformGui then
                    platformGui.Enabled = false
                end
                RemovePlatform()
            end
        end)
        platformToggle.Parent = TabFrame
        
        -- Настройки Jump Booster
        local boosterSettingsTitle = Instance.new("TextLabel")
        boosterSettingsTitle.Size = UDim2.new(1, 0, 0, 20)
        boosterSettingsTitle.BackgroundTransparency = 1
        boosterSettingsTitle.Text = "Jump Booster Settings"
        boosterSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        boosterSettingsTitle.TextSize = 14
        boosterSettingsTitle.Font = Enum.Font.GothamBold
        boosterSettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
        boosterSettingsTitle.Parent = TabFrame
        
        local boosterMultiplier = CreateNumberInput("Jump Multiplier", TabFrame, UtilitiesSettings.JumpBooster.Multiplier, function(value)
            UtilitiesSettings.JumpBooster.Multiplier = value
            -- Обновляем Jump Booster если он включен
            if UtilitiesSettings.JumpBooster.Enabled then
                ToggleJumpBooster()
            end
        end)
        boosterMultiplier.Parent = TabFrame
    end
end

-- Активация первого таба
if Tabs[1] then
    local firstTabButton = TabButtons:FindFirstChildOfClass("TextButton")
    if firstTabButton then
        firstTabButton:Fire()
    end
end

-- Закрытие на ESC
UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Escape and isMenuVisible then
        isMenuVisible = false
        MainFrame.Visible = false
        ToggleButton.Rotation = 0
    end
end)

print("✅ PSF Hub loaded!")
print("📌 PSF - Open/Close Menu")
print("🚀 Added Fly and Infinite Jump features!")
print("🦘 Added Jump Booster with customizable multiplier!")
print("🛠️ Added Utilities tab with Jump Booster and Platform!")
print("🎯 Visuals features with full customization!")

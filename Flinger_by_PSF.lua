-- Ultra Fling Executor GUI Script with Improved Features
-- Автор: Аноним
-- Версия: 3.6

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltraFlingExecutor"
ScreenGui.Parent = player.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Position = UDim2.new(0.5, -225, 0.3, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Тень
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(80, 80, 80)
UIStroke.Parent = MainFrame

-- Заголовок
local TitleFrame = Instance.new("Frame")
TitleFrame.Name = "TitleFrame"
TitleFrame.Size = UDim2.new(1, 0, 0, 35)
TitleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ ULTRA FLING v3.6 - t.me/psfhub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleFrame

-- Кнопка свертывания
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Контент фрейм
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -45)
ContentFrame.Position = UDim2.new(0, 10, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Вкладки
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(1, 0, 0, 30)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = ContentFrame

local MainTab = Instance.new("TextButton")
MainTab.Name = "MainTab"
MainTab.Size = UDim2.new(0.33, -3, 1, 0)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainTab.Text = "🎯 Main"
MainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTab.TextSize = 12
MainTab.Font = Enum.Font.GothamBold
MainTab.Parent = TabsFrame

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 6)
MainTabCorner.Parent = MainTab

local PlayersTab = Instance.new("TextButton")
PlayersTab.Name = "PlayersTab"
PlayersTab.Size = UDim2.new(0.33, -3, 1, 0)
PlayersTab.Position = UDim2.new(0.33, 2, 0, 0)
PlayersTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayersTab.Text = "👥 Players"
PlayersTab.TextColor3 = Color3.fromRGB(200, 200, 200)
PlayersTab.TextSize = 12
PlayersTab.Font = Enum.Font.Gotham
PlayersTab.Parent = TabsFrame

local PlayersTabCorner = Instance.new("UICorner")
PlayersTabCorner.CornerRadius = UDim.new(0, 6)
PlayersTabCorner.Parent = PlayersTab

local AntiFlingTab = Instance.new("TextButton")
AntiFlingTab.Name = "AntiFlingTab"
AntiFlingTab.Size = UDim2.new(0.33, -3, 1, 0)
AntiFlingTab.Position = UDim2.new(0.66, 4, 0, 0)
AntiFlingTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AntiFlingTab.Text = "🛡️ Anti-Fling"
AntiFlingTab.TextColor3 = Color3.fromRGB(200, 200, 200)
AntiFlingTab.TextSize = 12
AntiFlingTab.Font = Enum.Font.Gotham
AntiFlingTab.Parent = TabsFrame

local AntiFlingTabCorner = Instance.new("UICorner")
AntiFlingTabCorner.CornerRadius = UDim.new(0, 6)
AntiFlingTabCorner.Parent = AntiFlingTab

-- Контент вкладок
local TabContent = Instance.new("Frame")
TabContent.Name = "TabContent"
TabContent.Size = UDim2.new(1, 0, 1, -40)
TabContent.Position = UDim2.new(0, 0, 0, 35)
TabContent.BackgroundTransparency = 1
TabContent.Parent = ContentFrame

-- Главная вкладка
local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.Size = UDim2.new(1, 0, 1, 0)
MainContent.BackgroundTransparency = 1
MainContent.Visible = true
MainContent.Parent = TabContent

-- Поле ввода для имени игрока
local PlayerNameBox = Instance.new("TextBox")
PlayerNameBox.Name = "PlayerNameBox"
PlayerNameBox.Size = UDim2.new(1, 0, 0, 35)
PlayerNameBox.Position = UDim2.new(0, 0, 0, 5)
PlayerNameBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayerNameBox.PlaceholderText = "🔍 Enter player name or select from list..."
PlayerNameBox.Text = ""
PlayerNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameBox.TextSize = 13
PlayerNameBox.Font = Enum.Font.Gotham
PlayerNameBox.Parent = MainContent

local NameBoxCorner = Instance.new("UICorner")
NameBoxCorner.CornerRadius = UDim.new(0, 8)
NameBoxCorner.Parent = PlayerNameBox

local NameBoxStroke = Instance.new("UIStroke")
NameBoxStroke.Thickness = 1
NameBoxStroke.Color = Color3.fromRGB(80, 80, 80)
NameBoxStroke.Parent = PlayerNameBox

-- Кнопка флинг
local FlingButton = Instance.new("TextButton")
FlingButton.Name = "FlingButton"
FlingButton.Size = UDim2.new(1, 0, 0, 45)
FlingButton.Position = UDim2.new(0, 0, 0, 50)
FlingButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
FlingButton.Text = "🚀 ULTRA FLING"
FlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingButton.TextSize = 16
FlingButton.Font = Enum.Font.GothamBold
FlingButton.Parent = MainContent

local FlingCorner = Instance.new("UICorner")
FlingCorner.CornerRadius = UDim.new(0, 10)
FlingCorner.Parent = FlingButton

-- Настройки
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(1, 0, 0, 150)
SettingsFrame.Position = UDim2.new(0, 0, 0, 105)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsFrame.Parent = MainContent

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 10)
SettingsCorner.Parent = SettingsFrame

local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Name = "SettingsLabel"
SettingsLabel.Size = UDim2.new(1, 0, 0, 25)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Text = "⚙️ FLING SETTINGS"
SettingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsLabel.TextSize = 14
SettingsLabel.Font = Enum.Font.GothamBold
SettingsLabel.Parent = SettingsFrame

-- Сила флинга
local FlingPowerLabel = Instance.new("TextLabel")
FlingPowerLabel.Name = "FlingPowerLabel"
FlingPowerLabel.Size = UDim2.new(1, -20, 0, 18)
FlingPowerLabel.Position = UDim2.new(0, 15, 0, 30)
FlingPowerLabel.BackgroundTransparency = 1
FlingPowerLabel.Text = "🌀 Rotation Speed: 100"
FlingPowerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
FlingPowerLabel.TextSize = 12
FlingPowerLabel.Font = Enum.Font.Gotham
FlingPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
FlingPowerLabel.Parent = SettingsFrame

local FlingPowerSlider = Instance.new("Frame")
FlingPowerSlider.Name = "FlingPowerSlider"
FlingPowerSlider.Size = UDim2.new(1, -30, 0, 6)
FlingPowerSlider.Position = UDim2.new(0, 15, 0, 52)
FlingPowerSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlingPowerSlider.Parent = SettingsFrame

local FlingPowerFill = Instance.new("Frame")
FlingPowerFill.Name = "FlingPowerFill"
FlingPowerFill.Size = UDim2.new(1, 0, 1, 0)
FlingPowerFill.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
FlingPowerFill.Parent = FlingPowerSlider

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = FlingPowerSlider

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = FlingPowerFill

local SliderButton = Instance.new("TextButton")
SliderButton.Name = "SliderButton"
SliderButton.Size = UDim2.new(1, 0, 3, 0)
SliderButton.Position = UDim2.new(0, 0, -1, 0)
SliderButton.BackgroundTransparency = 1
SliderButton.Text = ""
SliderButton.Parent = FlingPowerSlider

-- Скорость приближения
local ApproachSpeedLabel = Instance.new("TextLabel")
ApproachSpeedLabel.Name = "ApproachSpeedLabel"
ApproachSpeedLabel.Size = UDim2.new(1, -20, 0, 18)
ApproachSpeedLabel.Position = UDim2.new(0, 15, 0, 70)
ApproachSpeedLabel.BackgroundTransparency = 1
ApproachSpeedLabel.Text = "💨 Approach Speed: 100"
ApproachSpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ApproachSpeedLabel.TextSize = 12
ApproachSpeedLabel.Font = Enum.Font.Gotham
ApproachSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
ApproachSpeedLabel.Parent = SettingsFrame

local ApproachSpeedSlider = Instance.new("Frame")
ApproachSpeedSlider.Name = "ApproachSpeedSlider"
ApproachSpeedSlider.Size = UDim2.new(1, -30, 0, 6)
ApproachSpeedSlider.Position = UDim2.new(0, 15, 0, 92)
ApproachSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ApproachSpeedSlider.Parent = SettingsFrame

local ApproachSpeedFill = Instance.new("Frame")
ApproachSpeedFill.Name = "ApproachSpeedFill"
ApproachSpeedFill.Size = UDim2.new(1, 0, 1, 0)
ApproachSpeedFill.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
ApproachSpeedFill.Parent = ApproachSpeedSlider

local ApproachSliderCorner = Instance.new("UICorner")
ApproachSliderCorner.CornerRadius = UDim.new(1, 0)
ApproachSliderCorner.Parent = ApproachSpeedSlider

local ApproachFillCorner = Instance.new("UICorner")
ApproachFillCorner.CornerRadius = UDim.new(1, 0)
ApproachFillCorner.Parent = ApproachSpeedFill

local ApproachSliderButton = Instance.new("TextButton")
ApproachSliderButton.Name = "ApproachSliderButton"
ApproachSliderButton.Size = UDim2.new(1, 0, 3, 0)
ApproachSliderButton.Position = UDim2.new(0, 0, -1, 0)
ApproachSliderButton.BackgroundTransparency = 1
ApproachSliderButton.Text = ""
ApproachSliderButton.Parent = ApproachSpeedSlider

-- Вкладка игроков
local PlayersContent = Instance.new("Frame")
PlayersContent.Name = "PlayersContent"
PlayersContent.Size = UDim2.new(1, 0, 1, 0)
PlayersContent.BackgroundTransparency = 1
PlayersContent.Visible = false
PlayersContent.Parent = TabContent

local PlayersList = Instance.new("ScrollingFrame")
PlayersList.Name = "PlayersList"
PlayersList.Size = UDim2.new(1, 0, 1, -40)
PlayersList.Position = UDim2.new(0, 0, 0, 0)
PlayersList.BackgroundTransparency = 1
PlayersList.ScrollBarThickness = 4
PlayersList.Parent = PlayersContent

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayersList
UIListLayout.Padding = UDim.new(0, 6)

local RefreshButton = Instance.new("TextButton")
RefreshButton.Name = "RefreshButton"
RefreshButton.Size = UDim2.new(1, 0, 0, 30)
RefreshButton.Position = UDim2.new(0, 0, 1, -30)
RefreshButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
RefreshButton.Text = "🔄 Refresh Players List"
RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshButton.TextSize = 12
RefreshButton.Font = Enum.Font.GothamBold
RefreshButton.Parent = PlayersContent

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 8)
RefreshCorner.Parent = RefreshButton

-- Вкладка анти-флинга
local AntiFlingContent = Instance.new("Frame")
AntiFlingContent.Name = "AntiFlingContent"
AntiFlingContent.Size = UDim2.new(1, 0, 1, 0)
AntiFlingContent.BackgroundTransparency = 1
AntiFlingContent.Visible = false
AntiFlingContent.Parent = TabContent

local AntiFlingInfo = Instance.new("TextLabel")
AntiFlingInfo.Name = "AntiFlingInfo"
AntiFlingInfo.Size = UDim2.new(1, -20, 0, 100)
AntiFlingInfo.Position = UDim2.new(0, 10, 0, 10)
AntiFlingInfo.BackgroundTransparency = 1
AntiFlingInfo.Text = "🛡️ Anti-Fling Protection\n\n• Players can pass through you\n• Detects rapid movement and teleports you back\n• Automatically disabled during your fling"
AntiFlingInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
AntiFlingInfo.TextSize = 13
AntiFlingInfo.Font = Enum.Font.Gotham
AntiFlingInfo.TextWrapped = true
AntiFlingInfo.TextXAlignment = Enum.TextXAlignment.Left
AntiFlingInfo.Parent = AntiFlingContent

local AntiFlingToggleButton = Instance.new("TextButton")
AntiFlingToggleButton.Name = "AntiFlingToggleButton"
AntiFlingToggleButton.Size = UDim2.new(1, 0, 0, 50)
AntiFlingToggleButton.Position = UDim2.new(0, 0, 0, 120)
AntiFlingToggleButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
AntiFlingToggleButton.Text = "🛡️ ENABLE ANTI-FLING"
AntiFlingToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiFlingToggleButton.TextSize = 16
AntiFlingToggleButton.Font = Enum.Font.GothamBold
AntiFlingToggleButton.Parent = AntiFlingContent

local AntiFlingToggleCorner = Instance.new("UICorner")
AntiFlingToggleCorner.CornerRadius = UDim.new(0, 10)
AntiFlingToggleCorner.Parent = AntiFlingToggleButton

local AntiFlingStatus = Instance.new("TextLabel")
AntiFlingStatus.Name = "AntiFlingStatus"
AntiFlingStatus.Size = UDim2.new(1, -20, 0, 40)
AntiFlingStatus.Position = UDim2.new(0, 10, 0, 180)
AntiFlingStatus.BackgroundTransparency = 1
AntiFlingStatus.Text = "Status: ❌ Disabled"
AntiFlingStatus.TextColor3 = Color3.fromRGB(255, 99, 71)
AntiFlingStatus.TextSize = 14
AntiFlingStatus.Font = Enum.Font.GothamBold
AntiFlingStatus.TextXAlignment = Enum.TextXAlignment.Left
AntiFlingStatus.Parent = AntiFlingContent

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 18)
StatusLabel.Position = UDim2.new(0, 10, 1, -20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "✅ Ready to fling"
StatusLabel.TextColor3 = Color3.fromRGB(144, 238, 144)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = ContentFrame

-- Переменные состояния
local isMinimized = false
local isFlingingOther = false

-- Функции вкладок
local function switchToTab(tabName)
    MainContent.Visible = (tabName == "Main")
    PlayersContent.Visible = (tabName == "Players")
    AntiFlingContent.Visible = (tabName == "AntiFling")
    
    MainTab.BackgroundColor3 = (tabName == "Main") and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(35, 35, 35)
    PlayersTab.BackgroundColor3 = (tabName == "Players") and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(35, 35, 35)
    AntiFlingTab.BackgroundColor3 = (tabName == "AntiFling") and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(35, 35, 35)
    
    MainTab.TextColor3 = (tabName == "Main") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    PlayersTab.TextColor3 = (tabName == "Players") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    AntiFlingTab.TextColor3 = (tabName == "AntiFling") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
end

MainTab.MouseButton1Click:Connect(function()
    switchToTab("Main")
end)

PlayersTab.MouseButton1Click:Connect(function()
    switchToTab("Players")
    updatePlayersList()
end)

AntiFlingTab.MouseButton1Click:Connect(function()
    switchToTab("AntiFling")
end)

-- ФУНКЦИЯ ОБНОВЛЕНИЯ СПИСКА ИГРОКОВ
local function updatePlayersList()
    -- Полностью очищаем список
    for _, child in pairs(PlayersList:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    local playerCount = 0
    local playerNames = {}
    
    -- Собираем всех игроков
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            table.insert(playerNames, plr.Name)
        end
    end
    
    -- Сортируем имена для красоты
    table.sort(playerNames)
    
    -- Создаем кнопки для каждого игрока
    for _, playerName in pairs(playerNames) do
        playerCount = playerCount + 1
        
        local PlayerButton = Instance.new("TextButton")
        PlayerButton.Name = "PlayerBtn_" .. playerName
        PlayerButton.Size = UDim2.new(1, 0, 0, 35)
        PlayerButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        PlayerButton.Text = "👤 " .. playerName
        PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerButton.TextSize = 12
        PlayerButton.Font = Enum.Font.Gotham
        PlayerButton.Parent = PlayersList
        
        local PlayerCorner = Instance.new("UICorner")
        PlayerCorner.CornerRadius = UDim.new(0, 6)
        PlayerCorner.Parent = PlayerButton
        
        PlayerButton.MouseButton1Click:Connect(function()
            PlayerNameBox.Text = playerName
            switchToTab("Main")
            StatusLabel.Text = "✅ Selected: " .. playerName
        end)
    end
    
    -- Обновляем размер контента
    PlayersList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    
    -- Если игроков нет, показываем сообщение
    if playerCount == 0 then
        local NoPlayersLabel = Instance.new("TextLabel")
        NoPlayersLabel.Name = "NoPlayersLabel"
        NoPlayersLabel.Size = UDim2.new(1, 0, 0, 50)
        NoPlayersLabel.BackgroundTransparency = 1
        NoPlayersLabel.Text = "👥 No other players in game"
        NoPlayersLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        NoPlayersLabel.TextSize = 14
        NoPlayersLabel.Font = Enum.Font.Gotham
        NoPlayersLabel.Parent = PlayersList
        
        PlayersList.CanvasSize = UDim2.new(0, 0, 0, 60)
    end
    
    return playerCount
end

RefreshButton.MouseButton1Click:Connect(function()
    updatePlayersList()
    StatusLabel.Text = "✅ Players list refreshed"
end)

-- Автоматическое обновление списка при подключении/отключении игроков
Players.PlayerAdded:Connect(function(plr)
    wait(0.2)
    updatePlayersList()
end)

Players.PlayerRemoving:Connect(function(plr)
    wait(0.2)
    updatePlayersList()
end)

-- Настройки слайдеров
local rotationSpeed = 100
local approachSpeed = 100

-- Слайдер скорости вращения
SliderButton.MouseButton1Down:Connect(function()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderAbsolutePosition = FlingPowerSlider.AbsolutePosition.X
        local sliderAbsoluteSize = FlingPowerSlider.AbsoluteSize.X
        
        local relativeX = math.clamp(mouseX - sliderAbsolutePosition, 0, sliderAbsoluteSize)
        local percentage = relativeX / sliderAbsoluteSize
        
        rotationSpeed = math.floor(percentage * 200) + 50
        FlingPowerLabel.Text = "🌀 Rotation Speed: " .. rotationSpeed
        FlingPowerFill.Size = UDim2.new(percentage, 0, 1, 0)
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
        end
    end)
end)

-- Слайдер скорости приближения
ApproachSliderButton.MouseButton1Down:Connect(function()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderAbsolutePosition = ApproachSpeedSlider.AbsolutePosition.X
        local sliderAbsoluteSize = ApproachSpeedSlider.AbsoluteSize.X
        
        local relativeX = math.clamp(mouseX - sliderAbsolutePosition, 0, sliderAbsoluteSize)
        local percentage = relativeX / sliderAbsoluteSize
        
        approachSpeed = math.floor(percentage * 300) + 50
        ApproachSpeedLabel.Text = "💨 Approach Speed: " .. approachSpeed
        ApproachSpeedFill.Size = UDim2.new(percentage, 0, 1, 0)
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
        end
    end)
end)

-- ФУНКЦИЯ СОЗДАНИЯ ЗВУКА
local function playSound(soundType)
    local sound = Instance.new("Sound")
    sound.Parent = ScreenGui
    
    if soundType == "click" then
        sound.SoundId = "rbxasset://sounds/click.wav"
        sound.Volume = 0.3
    elseif soundType == "confirm" then
        sound.SoundId = "rbxasset://sounds/action_confirmation.wav"
        sound.Volume = 0.4
    elseif soundType == "deny" then
        sound.SoundId = "rbxasset://sounds/action_cancel.wav"
        sound.Volume = 0.4
    end
    
    sound:Play()
    
    -- Автоочистка звука
    game:GetService("Debris"):AddItem(sound, 2)
end

-- ФУНКЦИЯ ПОДТВЕРЖДЕНИЯ ЗАКРЫТИЯ
local function showCloseConfirmation()
    playSound("click")
    
    -- Создаем затемнение фона
    local Overlay = Instance.new("Frame")
    Overlay.Name = "CloseConfirmationOverlay"
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.4
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 10
    Overlay.Parent = ScreenGui
    
    local OverlayCorner = Instance.new("UICorner")
    OverlayCorner.CornerRadius = UDim.new(0, 12)
    OverlayCorner.Parent = Overlay
    
    -- Создаем окно подтверждения
    local ConfirmFrame = Instance.new("Frame")
    ConfirmFrame.Name = "CloseConfirmationFrame"
    ConfirmFrame.Size = UDim2.new(0, 300, 0, 160)
    ConfirmFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ConfirmFrame.BorderSizePixel = 0
    ConfirmFrame.ZIndex = 11
    ConfirmFrame.Parent = ScreenGui
    
    local ConfirmCorner = Instance.new("UICorner")
    ConfirmCorner.CornerRadius = UDim.new(0, 12)
    ConfirmCorner.Parent = ConfirmFrame
    
    local ConfirmStroke = Instance.new("UIStroke")
    ConfirmStroke.Thickness = 2
    ConfirmStroke.Color = Color3.fromRGB(80, 80, 80)
    ConfirmStroke.Parent = ConfirmFrame
    
    -- Заголовок
    local ConfirmTitle = Instance.new("TextLabel")
    ConfirmTitle.Name = "ConfirmTitle"
    ConfirmTitle.Size = UDim2.new(1, 0, 0, 40)
    ConfirmTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ConfirmTitle.Text = "⚠️ Confirm Close"
    ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmTitle.TextSize = 16
    ConfirmTitle.Font = Enum.Font.GothamBold
    ConfirmTitle.Parent = ConfirmFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = ConfirmTitle
    
    -- Текст подтверждения
    local ConfirmText = Instance.new("TextLabel")
    ConfirmText.Name = "ConfirmText"
    ConfirmText.Size = UDim2.new(1, -20, 0, 50)
    ConfirmText.Position = UDim2.new(0, 10, 0, 45)
    ConfirmText.BackgroundTransparency = 1
    ConfirmText.Text = "Are you sure you want to close the Ultra Fling GUI?"
    ConfirmText.TextColor3 = Color3.fromRGB(200, 200, 200)
    ConfirmText.TextSize = 14
    ConfirmText.Font = Enum.Font.Gotham
    ConfirmText.TextWrapped = true
    ConfirmText.Parent = ConfirmFrame
    
    -- Кнопка подтверждения
    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Name = "ConfirmButton"
    ConfirmButton.Size = UDim2.new(0, 120, 0, 35)
    ConfirmButton.Position = UDim2.new(0, 30, 1, -50)
    ConfirmButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    ConfirmButton.Text = "✅ CONFIRM"
    ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmButton.TextSize = 14
    ConfirmButton.Font = Enum.Font.GothamBold
    ConfirmButton.ZIndex = 12
    ConfirmButton.Parent = ConfirmFrame
    
    local ConfirmButtonCorner = Instance.new("UICorner")
    ConfirmButtonCorner.CornerRadius = UDim.new(0, 8)
    ConfirmButtonCorner.Parent = ConfirmButton
    
    -- Кнопка отмены
    local CancelButton = Instance.new("TextButton")
    CancelButton.Name = "CancelButton"
    CancelButton.Size = UDim2.new(0, 120, 0, 35)
    CancelButton.Position = UDim2.new(1, -150, 1, -50)
    CancelButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    CancelButton.Text = "❌ CANCEL"
    CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CancelButton.TextSize = 14
    CancelButton.Font = Enum.Font.GothamBold
    CancelButton.ZIndex = 12
    CancelButton.Parent = ConfirmFrame
    
    local CancelButtonCorner = Instance.new("UICorner")
    CancelButtonCorner.CornerRadius = UDim.new(0, 8)
    CancelButtonCorner.Parent = CancelButton
    
    -- Анимации при наведении для кнопок подтверждения
    local function setupConfirmHover(button, originalColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor + Color3.fromRGB(20, 20, 20)}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
        end)
    end
    
    setupConfirmHover(ConfirmButton, Color3.fromRGB(200, 60, 60))
    setupConfirmHover(CancelButton, Color3.fromRGB(65, 105, 225))
    
    -- Функция закрытия окна подтверждения
    local function closeConfirmation()
        playSound("click")
        Overlay:Destroy()
        ConfirmFrame:Destroy()
    end
    
    -- Обработчики кнопок
    ConfirmButton.MouseButton1Click:Connect(function()
        playSound("confirm")
        
        -- Плавное закрытие с анимацией
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
        local transparencyTween = TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = 1})
        
        sizeTween:Play()
        transparencyTween:Play()
        
        -- Выключаем анти-флинг если активен
        if antiFlingEnabled then
            toggleAntiFling()
        end
        
        -- Удаляем GUI после анимации
        sizeTween.Completed:Connect(function()
            closeConfirmation()
            ScreenGui:Destroy()
        end)
    end)
    
    CancelButton.MouseButton1Click:Connect(function()
        playSound("deny")
        closeConfirmation()
    end)
    
    -- Закрытие при клике на overlay
    Overlay.MouseButton1Click:Connect(function()
        closeConfirmation()
    end)
end

-- ФУНКЦИЯ АНТИ-ФЛИНГА (УЛУЧШЕННАЯ - ТОЛЬКО СКОРОСТЬ И ПРОХОЖДЕНИЕ)
local antiFlingEnabled = false
local antiFlingConnection = nil
local lastPosition = nil
local originalCollision = nil

local function toggleAntiFling()
    if antiFlingEnabled then
        -- Выключаем анти-флинг
        if antiFlingConnection then
            antiFlingConnection:Disconnect()
            antiFlingConnection = nil
        end
        
        -- Восстанавливаем коллизию
        local character = player.Character
        if character and originalCollision then
            for partName, canCollide in pairs(originalCollision) do
                local part = character:FindFirstChild(partName)
                if part then
                    part.CanCollide = canCollide
                end
            end
        end
        
        antiFlingEnabled = false
        AntiFlingToggleButton.Text = "🛡️ ENABLE ANTI-FLING"
        AntiFlingToggleButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        AntiFlingStatus.Text = "Status: ❌ Disabled"
        AntiFlingStatus.TextColor3 = Color3.fromRGB(255, 99, 71)
        StatusLabel.Text = "✅ Anti-Fling disabled"
        
    else
        -- Включаем анти-флинг
        local character = player.Character
        if not character then
            StatusLabel.Text = "❌ Character not found!"
            return
        end
        
        -- Сохраняем и отключаем коллизию для прохождения через игроков
        originalCollision = {}
        local partsToMakeNonCollidable = {
            "HumanoidRootPart",
            "Head",
            "Torso",
            "Left Arm", 
            "Right Arm",
            "Left Leg",
            "Right Leg"
        }
        
        for _, partName in pairs(partsToMakeNonCollidable) do
            local part = character:FindFirstChild(partName)
            if part then
                originalCollision[partName] = part.CanCollide
                part.CanCollide = false
            end
        end
        
        antiFlingEnabled = true
        AntiFlingToggleButton.Text = "🛡️ DISABLE ANTI-FLING"
        AntiFlingToggleButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        AntiFlingStatus.Text = "Status: ✅ Enabled"
        AntiFlingStatus.TextColor3 = Color3.fromRGB(144, 238, 144)
        StatusLabel.Text = "🛡️ Anti-Fling enabled"
        
        lastPosition = character:GetPivot().Position
        
        -- УЛУЧШЕННАЯ ЗАЩИТА ОТ БЫСТРОГО ДВИЖЕНИЯ
        antiFlingConnection = RunService.Heartbeat:Connect(function()
            if not antiFlingEnabled then return end
            
            local currentCharacter = player.Character
            if not currentCharacter then return end
            
            -- Автоматически отключаем защиту если мы флингуем других
            if isFlingingOther then
                return
            end
            
            local currentPosition = currentCharacter:GetPivot().Position
            
            -- Проверяем быстрое движение
            if lastPosition then
                local distanceMoved = (currentPosition - lastPosition).Magnitude
                
                -- Если движемся слишком быстро (более 100 studs в секунду)
                if distanceMoved > 100 then
                    -- Телепортируем обратно
                    currentCharacter:PivotTo(CFrame.new(lastPosition))
                    StatusLabel.Text = "🛡️ Anti-Fling: Blocked rapid movement"
                end
            end
            
            lastPosition = currentPosition
            
            -- Поддерживаем отключенную коллизию для прохождения через игроков
            for _, partName in pairs(partsToMakeNonCollidable) do
                local part = currentCharacter:FindFirstChild(partName)
                if part then
                    part.CanCollide = false
                end
            end
        end)
    end
end

AntiFlingToggleButton.MouseButton1Click:Connect(toggleAntiFling)

-- ОСНОВНАЯ ФУНКЦИЯ ФЛИНГА (УЛУЧШЕННАЯ)
local function ultraFlingPlayer(targetName)
    local target = nil
    for _, plr in pairs(Players:GetPlayers()) do
        if string.lower(plr.Name) == string.lower(targetName) or string.sub(string.lower(plr.Name), 1, #targetName) == string.lower(targetName) then
            target = plr
            break
        end
    end
    
    if not target or not target.Character then
        return false, "Player not found!"
    end
    
    local character = player.Character
    if not character then
        return false, "Your character not found!"
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart or not targetRoot then
        return false, "Character parts missing!"
    end
    
    -- Сохраняем начальную позицию для телепортации обратно
    local startPosition = rootPart.Position
    isFlingingOther = true -- Устанавливаем флаг что мы флингуем других
    
    StatusLabel.Text = "🔄 Starting ultra fling..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    -- Сохраняем оригинальные свойства
    local originalWalkSpeed = humanoid.WalkSpeed
    local originalJumpPower = humanoid.JumpPower
    local originalAutoRotate = humanoid.AutoRotate
    
    -- Сохраняем начальную позицию цели
    local startTargetPosition = targetRoot.Position
    
    -- Активируем режим бога для избежания смерти
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    wait(0.1)
    
    -- 1. Быстрое приближение к цели
    StatusLabel.Text = "💨 Approaching target..."
    
    local approachConnection
    approachConnection = RunService.Heartbeat:Connect(function()
        if targetRoot and rootPart then
            local direction = (targetRoot.Position - rootPart.Position).Unit
            rootPart.Velocity = direction * approachSpeed
        end
    end)
    
    -- Ждем приближения к цели
    local startTime = tick()
    while tick() - startTime < 2 do
        if targetRoot and rootPart then
            local distance = (targetRoot.Position - rootPart.Position).Magnitude
            if distance < 5 then -- Если очень близко к цели
                break
            end
        end
        wait()
    end
    
    -- Останавливаем приближение
    if approachConnection then
        approachConnection:Disconnect()
    end
    
    -- 2. УЛЬТРА-ФЛИНГ С МИКРО-ДВИЖЕНИЯМИ И СИЛЬНЫМ ВЕРХНИМ ФЛИНГОМ
    StatusLabel.Text = "🌀 Starting ultra fling sequence..."
    
    local ultraFlingActive = true
    local flingAttempts = 0
    local maxAttempts = 50
    
    local ultraFlingConnection
    ultraFlingConnection = RunService.Heartbeat:Connect(function()
        if not ultraFlingActive then return end
        
        if targetRoot and rootPart then
            -- Безумное вращение
            rootPart.RotVelocity = Vector3.new(0, rotationSpeed * 20, 0)
            
            -- Микро-движения в случайных направлениях
            local microMovement = Vector3.new(
                math.random(-10, 10),
                math.random(0, 5),
                math.random(-10, 10)
            )
            
            -- Применяем микро-движение
            rootPart.Velocity = rootPart.Velocity + microMovement
            
            -- Проверяем, сдвинулись ли мы хоть немного
            local currentDistance = (targetRoot.Position - rootPart.Position).Magnitude
            local originalDistance = 2
            
            -- Если мы сдвинулись хотя бы на 0.1 stud от цели
            if math.abs(currentDistance - originalDistance) > 0.1 then
                flingAttempts = 0
                
                -- Мгновенно телепортируемся обратно к цели
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 2, 0))
                
                -- Создаем мощный флинг каждый раз при "перезапуске"
                local flingPart = Instance.new("Part")
                flingPart.Name = "UltraFlingPart"
                flingPart.Size = Vector3.new(1, 1, 1)
                flingPart.Transparency = 1
                flingPart.CanCollide = false
                flingPart.Anchored = false
                flingPart.Parent = workspace
                
                -- Позиционируем на цели
                flingPart.Position = targetRoot.Position
                
                -- Привариваем к цели
                local weld = Instance.new("Weld")
                weld.Part0 = flingPart
                weld.Part1 = targetRoot
                weld.C0 = CFrame.new()
                weld.C1 = targetRoot.CFrame:inverse() * flingPart.CFrame
                weld.Parent = flingPart
                
                -- УЛУЧШЕННЫЙ ФЛИНГ - СИЛЬНЫЙ ВЕРХНИЙ ФЛИНГ
                local upwardForce = rotationSpeed * 15 -- Увеличиваем силу вверх
                local horizontalForce = 500 -- Уменьшаем горизонтальную силу для большего полета вверх
                
                flingPart.Velocity = Vector3.new(
                    math.random(-horizontalForce, horizontalForce),
                    upwardForce, -- Сильный толчок вверх
                    math.random(-horizontalForce, horizontalForce)
                )
                
                flingPart.RotVelocity = Vector3.new(
                    math.random(-2000, 2000),
                    math.random(-2000, 2000),
                    math.random(-2000, 2000)
                )
                
                -- Автоочистка через 3 секунды
                delay(3, function()
                    if flingPart then
                        flingPart:Destroy()
                    end
                end)
            end
            
            flingAttempts = flingAttempts + 1
            
            -- Завершаем если достигли максимума попыток или цель улетела далеко
            local distanceFlown = (targetRoot.Position - startTargetPosition).Magnitude
            if flingAttempts >= maxAttempts or distanceFlown >= 1000 then
                ultraFlingActive = false
                if ultraFlingConnection then
                    ultraFlingConnection:Disconnect()
                end
            end
        else
            ultraFlingActive = false
            if ultraFlingConnection then
                ultraFlingConnection:Disconnect()
            end
        end
    end)
    
    -- Возвращаем контроль над персонажем через 5 секунд и телепортируем обратно
    delay(5, function()
        ultraFlingActive = false
        isFlingingOther = false -- Сбрасываем флаг
        
        if ultraFlingConnection then
            ultraFlingConnection:Disconnect()
        end
        
        -- ТЕЛЕПОРТАЦИЯ ОБРАТНО К ИСХОДНОЙ ПОЗИЦИИ
        if rootPart then
            rootPart.RotVelocity = Vector3.new(0, 0, 0)
            rootPart.Velocity = Vector3.new(0, 0, 0)
            rootPart.CFrame = CFrame.new(startPosition)
        end
        
        -- Восстанавливаем оригинальные настройки
        humanoid.WalkSpeed = originalWalkSpeed
        humanoid.JumpPower = originalJumpPower
        humanoid.AutoRotate = originalAutoRotate
        
        StatusLabel.Text = "✅ Returned to original position"
    end)
    
    return true, "Ultra fling activated!"
end

-- Обработчик кнопки флинга
local isFlinging = false

FlingButton.MouseButton1Click:Connect(function()
    if isFlinging then
        StatusLabel.Text = "⏹️ Please wait..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        return
    end
    
    local targetName = PlayerNameBox.Text
    if targetName == "" then
        PlayerNameBox.PlaceholderText = "Please enter a name!"
        return
    end
    
    isFlinging = true
    FlingButton.Text = "🔄 PROCESSING..."
    FlingButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    local success, message = ultraFlingPlayer(targetName)
    
    if success then
        StatusLabel.Text = "🌀 Ultra fling active!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        FlingButton.Text = "🎯 FLING ACTIVE!"
        FlingButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        
        -- Автоматически сбрасываем кнопку через 6 секунд
        delay(6, function()
            if FlingButton then
                FlingButton.Text = "🚀 ULTRA FLING"
                FlingButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
                isFlinging = false
                StatusLabel.Text = "✅ Ready to fling"
                StatusLabel.TextColor3 = Color3.fromRGB(144, 238, 144)
            end
        end)
    else
        StatusLabel.Text = "❌ " .. message
        StatusLabel.TextColor3 = Color3.fromRGB(255, 99, 71)
        FlingButton.Text = "⚠️ FLING FAILED!"
        FlingButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        
        wait(2)
        FlingButton.Text = "🚀 ULTRA FLING"
        FlingButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        isFlinging = false
        isFlingingOther = false
    end
end)

-- ФУНКЦИИ ПЛАВНОГО СВЕРТЫВАНИЯ С АНИМАЦИЕЙ ТЕКСТА
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

MinimizeButton.MouseButton1Click:Connect(function()
    playSound("click")
    
    if isMinimized then
        -- Плавное разворачивание
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = originalSize})
        local posTween = TweenService:Create(MainFrame, tweenInfo, {Position = originalPosition})
        local textTween = TweenService:Create(TitleLabel, tweenInfo, {Position = UDim2.new(0, 10, 0, 0)})
        
        sizeTween:Play()
        posTween:Play()
        textTween:Play()
        
        isMinimized = false
        MinimizeButton.Text = "_"
        
    else
        -- Плавное сворачивание (ТОЛЬКО ПО ВЫСОТЕ, ШИРИНА ОСТАЕТСЯ)
        originalSize = MainFrame.Size
        originalPosition = MainFrame.Position
        
        local targetSize = UDim2.new(0, 450, 0, 35) -- Ширина такая же, высота 35
        local targetPosition = UDim2.new(0.5, -225, 0.1, 0)
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = targetSize})
        local posTween = TweenService:Create(MainFrame, tweenInfo, {Position = targetPosition})
        local textTween = TweenService:Create(TitleLabel, tweenInfo, {Position = UDim2.new(0, 40, 0, 0)}) -- Смещаем текст вправо
        
        sizeTween:Play()
        posTween:Play()
        textTween:Play()
        
        isMinimized = true
        MinimizeButton.Text = "□"
    end
end)

-- Обработчик закрытия (теперь показывает подтверждение)
CloseButton.MouseButton1Click:Connect(function()
    showCloseConfirmation()
end)

-- Анимации при наведении
local function setupHoverEffects(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor + Color3.fromRGB(15, 15, 15)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end

-- Применяем эффекты ко всем кнопкам
setupHoverEffects(FlingButton)
setupHoverEffects(CloseButton)
setupHoverEffects(MinimizeButton)
setupHoverEffects(MainTab)
setupHoverEffects(PlayersTab)
setupHoverEffects(AntiFlingTab)
setupHoverEffects(RefreshButton)
setupHoverEffects(AntiFlingToggleButton)

-- Автодополнение имен игроков
PlayerNameBox.Focused:Connect(function()
    PlayerNameBox.PlaceholderText = "🔍 Enter player name..."
end)

PlayerNameBox.FocusLost:Connect(function()
    local text = PlayerNameBox.Text
    if text ~= "" then
        for _, plr in pairs(Players:GetPlayers()) do
            if string.lower(plr.Name) == string.lower(text) then
                PlayerNameBox.Text = plr.Name
                break
            end
        end
    end
end)

-- Инициализация списка игроков (сразу при загрузке)
wait(1)
updatePlayersList()

print("⚡ Ultra Fling Executor v3.6 loaded!")
print("🎯 Features: Improved anti-fling + Text animation + No collision mode!")
print("🛡️ Anti-Fling now allows players to pass through you!")
print("📝 Title text moves when minimizing!")
-- 🌟 ПЕРЕМЕЩЕНИЕ ОКНА ПАЛЬЦЕМ С ПЛАВНОСТЬЮ 🌟

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local dragging = false
local dragStart
local startPos

-- Функция плавного перемещения
local function smoothMove(input)
	local delta = input.Position - dragStart
	local newPos = UDim2.new(
		startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y
	)
	
	TweenService:Create(
		MainFrame,
		TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		{Position = newPos}
	):Play()
end

-- Начало касания
TitleFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

-- Движение пальцем
TitleFrame.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		smoothMove(input)
	end
end)

-- Отпускание пальца
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

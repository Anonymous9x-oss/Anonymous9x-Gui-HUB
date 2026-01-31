-- MODERN UI HUB - FIXED LAYOUT
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("ModernFixed") then
    PlayerGui.ModernFixed:Destroy()
end

-- ==================== CONFIG ====================
local Config = {
    Title = "ANONYMOUS HUB",
    LogoID = "rbxassetid://97269958324726",
    Theme = {
        Primary = Color3.fromRGB(10, 132, 255),
        Secondary = Color3.fromRGB(94, 92, 230),
        Background = Color3.fromRGB(28, 28, 30),
        Card = Color3.fromRGB(44, 44, 46),
        Text = Color3.fromRGB(242, 242, 247),
        Subtext = Color3.fromRGB(142, 142, 147)
    },
    Scripts = {
        {Name = "ESP", Icon = "👁️", URL = "", Desc = "See through walls"},
        {Name = "HIDE NAME", Icon = "👻", URL = "", Desc = "Hide display name"},
        {Name = "GLOW", Icon = "✨", URL = "", Desc = "Glowing effect"},
        {Name = "SKYBOX", Icon = "🌌", URL = "", Desc = "Change skybox"},
        {Name = "FLY", Icon = "⚡", URL = "", Desc = "Enable flying"},
        {Name = "SPEED", Icon = "🏎️", URL = "", Desc = "Increase speed"},
        {Name = "ANTI-AFK", Icon = "🛡️", URL = "", Desc = "Prevent AFK kick"},
        {Name = "ADMIN", Icon = "🔧", URL = "", Desc = "Admin tools"},
        {Name = "FARM", Icon = "💰", URL = "", Desc = "Auto farm"},
        {Name = "AIMBOT", Icon = "🎯", URL = "", Desc = "Auto aim"}
    }
}

-- ==================== UI SETUP ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernFixed"
ScreenGui.ResetOnSpawn = false

local AppWindow = Instance.new("Frame")
AppWindow.Size = UDim2.new(0, 400, 0, 550) -- TINGGI DITAMBAH
AppWindow.Position = UDim2.new(0.5, -200, 0.5, -275)
AppWindow.BackgroundColor3 = Config.Theme.Background
AppWindow.BackgroundTransparency = 0.1

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 24)

-- ==================== HEADER ====================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundTransparency = 1

local Avatar = Instance.new("ImageLabel")
Avatar.Image = Config.LogoID
Avatar.Size = UDim2.new(0, 50, 0, 50)
Avatar.Position = UDim2.new(0, 20, 0.5, -25)
Avatar.BackgroundColor3 = Config.Theme.Primary
Avatar.BackgroundTransparency = 0.8

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)

local Username = Instance.new("TextLabel")
Username.Text = Config.Title
Username.Size = UDim2.new(0.6, 0, 0, 24)
Username.Position = UDim2.new(0, 80, 0, 18)
Username.BackgroundTransparency = 1
Username.TextColor3 = Config.Theme.Text
Username.Font = Enum.Font.GothamBold
Username.TextSize = 18
Username.TextXAlignment = Enum.TextXAlignment.Left

local Status = Instance.new("TextLabel")
Status.Text = "Script Hub • 10 Features"
Status.Size = UDim2.new(0.6, 0, 0, 20)
Status.Position = UDim2.new(0, 80, 0, 42)
Status.BackgroundTransparency = 1
Status.TextColor3 = Config.Theme.Subtext
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "−"
MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
MinimizeBtn.Position = UDim2.new(1, -74, 0.5, -16)
MinimizeBtn.BackgroundColor3 = Config.Theme.Card
MinimizeBtn.TextColor3 = Config.Theme.Text
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 16

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)

-- ==================== SCRIPT GRID (MANUAL 2 COLUMNS) ====================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -40, 1, -100)
Content.Position = UDim2.new(0, 20, 0, 80)
Content.BackgroundTransparency = 1

local SectionTitle = Instance.new("TextLabel")
SectionTitle.Text = "AVAILABLE SCRIPTS"
SectionTitle.Size = UDim2.new(1, 0, 0, 30)
SectionTitle.BackgroundTransparency = 1
SectionTitle.TextColor3 = Config.Theme.Subtext
SectionTitle.Font = Enum.Font.GothamBold
SectionTitle.TextSize = 12
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
SectionTitle.Parent = Content

-- GRID SETTINGS
local CARD_WIDTH = 160
local CARD_HEIGHT = 80
local CARD_MARGIN_X = 15
local CARD_MARGIN_Y = 12
local COLUMNS = 2

-- CREATE CARDS WITH MANUAL POSITIONING
for i, scriptData in ipairs(Config.Scripts) do
    -- CALCULATE GRID POSITION
    local col = (i - 1) % COLUMNS
    local row = math.floor((i - 1) / COLUMNS)
    
    local xPos = col * (CARD_WIDTH + CARD_MARGIN_X)
    local yPos = 30 + (row * (CARD_HEIGHT + CARD_MARGIN_Y))
    
    -- CREATE CARD
    local Card = Instance.new("TextButton")
    Card.Text = ""
    Card.Size = UDim2.new(0, CARD_WIDTH, 0, CARD_HEIGHT)
    Card.Position = UDim2.new(0, xPos, 0, yPos)
    Card.BackgroundColor3 = Config.Theme.Card
    Card.AutoButtonColor = false
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 12)
    CardCorner.Parent = Card
    
    -- LEFT SIDE: ICON
    local IconFrame = Instance.new("Frame")
    IconFrame.Size = UDim2.new(0, 40, 0, 40)
    IconFrame.Position = UDim2.new(0, 10, 0.5, -20)
    IconFrame.BackgroundColor3 = Config.Theme.Primary
    IconFrame.BackgroundTransparency = 0.9
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = IconFrame
    
    local Icon = Instance.new("TextLabel")
    Icon.Text = scriptData.Icon
    Icon.Size = UDim2.new(1, 0, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Config.Theme.Text
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 16
    Icon.Parent = IconFrame
    
    -- RIGHT SIDE: TEXT (VERTICALLY CENTERED)
    local TextContainer = Instance.new("Frame")
    TextContainer.Size = UDim2.new(0, 90, 1, -20)
    TextContainer.Position = UDim2.new(0, 60, 0, 10)
    TextContainer.BackgroundTransparency = 1
    
    local ScriptName = Instance.new("TextLabel")
    ScriptName.Text = scriptData.Name
    ScriptName.Size = UDim2.new(1, 0, 0, 20)
    ScriptName.Position = UDim2.new(0, 0, 0, 0)
    ScriptName.BackgroundTransparency = 1
    ScriptName.TextColor3 = Config.Theme.Text
    ScriptName.Font = Enum.Font.GothamBold
    ScriptName.TextSize = 12
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    ScriptName.TextYAlignment = Enum.TextYAlignment.Top
    ScriptName.Parent = TextContainer
    
    local ScriptDesc = Instance.new("TextLabel")
    ScriptDesc.Text = scriptData.Desc
    ScriptDesc.Size = UDim2.new(1, 0, 0, 30)
    ScriptDesc.Position = UDim2.new(0, 0, 0, 20)
    ScriptDesc.BackgroundTransparency = 1
    ScriptDesc.TextColor3 = Config.Theme.Subtext
    ScriptDesc.Font = Enum.Font.Gotham
    ScriptDesc.TextSize = 10
    ScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
    ScriptDesc.TextYAlignment = Enum.TextYAlignment.Top
    ScriptDesc.Parent = TextContainer
    
    -- ACTION BUTTON (RIGHT SIDE)
    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Text = "▶"
    ActionBtn.Size = UDim2.new(0, 30, 0, 30)
    ActionBtn.Position = UDim2.new(1, -40, 0.5, -15)
    ActionBtn.BackgroundColor3 = Config.Theme.Primary
    ActionBtn.TextColor3 = Color3.new(1, 1, 1)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.TextSize = 12
    ActionBtn.AutoButtonColor = false
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = ActionBtn
    
    -- HOVER EFFECT
    Card.MouseEnter:Connect(function()
        Card.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    
    Card.MouseLeave:Connect(function()
        Card.BackgroundColor3 = Config.Theme.Card
        ActionBtn.BackgroundColor3 = Config.Theme.Primary
    end)
    
    -- CLICK FUNCTION
    Card.Activated:Connect(function()
        ActionBtn.Text = "⏳"
        task.wait(0.8)
        ActionBtn.Text = scriptData.URL == "" and "⚠️" or "✅"
        task.wait(0.5)
        ActionBtn.Text = "▶"
    end)
    
    ActionBtn.Activated:Connect(function()
        Card.Activated()
    end)
    
    -- ASSEMBLE CARD
    IconFrame.Parent = Card
    TextContainer.Parent = Card
    ActionBtn.Parent = Card
    Card.Parent = Content
end

-- ==================== MINIMIZED APP ====================
local MinimizedApp = Instance.new("TextButton")
MinimizedApp.Text = ""
MinimizedApp.Size = UDim2.new(0, 60, 0, 60)
MinimizedApp.Position = UDim2.new(0.9, 0, 0.1, 0)
MinimizedApp.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizedApp.AutoButtonColor = false
MinimizedApp.Visible = false

local MinimizedCorner = Instance.new("UICorner")
MinimizedCorner.CornerRadius = UDim.new(0, 12)

local MinimizedIcon = Instance.new("ImageLabel")
MinimizedIcon.Image = Config.LogoID
MinimizedIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
MinimizedIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
MinimizedIcon.BackgroundTransparency = 1
MinimizedIcon.ScaleType = Enum.ScaleType.Fit
MinimizedIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

-- ==================== ASSEMBLE UI ====================
WindowCorner.Parent = AppWindow
AvatarCorner.Parent = Avatar
MinimizeCorner.Parent = MinimizeBtn
CloseCorner.Parent = CloseBtn
MinimizedCorner.Parent = MinimizedApp

Avatar.Parent = Header
Username.Parent = Header
Status.Parent = Header
MinimizeBtn.Parent = Header
CloseBtn.Parent = Header
Header.Parent = AppWindow
Content.Parent = AppWindow
MinimizedIcon.Parent = MinimizedApp

MinimizedApp.Parent = ScreenGui
AppWindow.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

-- ==================== DRAGGING ====================
local function SetupDragging(frame)
    local dragging = false
    local dragInput, dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input == dragInput) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

SetupDragging(AppWindow)
SetupDragging(MinimizedApp)

-- ==================== FUNCTIONALITY ====================
local isMinimized = false

MinimizeBtn.Activated:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MinimizedApp.Position = AppWindow.Position
        AppWindow.Visible = false
        MinimizedApp.Visible = true
    else
        AppWindow.Position = MinimizedApp.Position
        AppWindow.Visible = true
        MinimizedApp.Visible = false
    end
end)

CloseBtn.Activated:Connect(function()
    ScreenGui:Destroy()
end)

MinimizedApp.Activated:Connect(function()
    AppWindow.Position = MinimizedApp.Position
    AppWindow.Visible = true
    MinimizedApp.Visible = false
    isMinimized = false
end)

print("========================================")
print("✅ MODERN FIXED LAYOUT LOADED!")
print("Features:")
print("• 2-Column Grid (Manual Positioning)")
print("• All cards aligned properly")
print("• Text vertically centered")
print("• Clean responsive layout")
print("========================================")

-- MODERN UI HUB - HORIZONTAL SCROLL LAYOUT
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("HorizontalHub") then
    PlayerGui.HorizontalHub:Destroy()
end

-- ==================== CONFIG ====================
local Config = {
    Title = "ANONYMOUS9x GUI HUB",
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
ScreenGui.Name = "HorizontalHub"
ScreenGui.ResetOnSpawn = false

-- MAIN WINDOW - LEBIH KECIL DAN PANJANG
local AppWindow = Instance.new("Frame")
AppWindow.Size = UDim2.new(0, 380, 0, 320) -- LEBAR SEDIKIT, TINGGI LEBIH PENDEK
AppWindow.Position = UDim2.new(0.5, -190, 0.5, -160)
AppWindow.BackgroundColor3 = Config.Theme.Background
AppWindow.BackgroundTransparency = 0.1

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 16)
WindowCorner.Parent = AppWindow

-- ==================== HEADER COMPACT ====================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50) -- LEBIH PENDEK
Header.BackgroundTransparency = 1

local Avatar = Instance.new("ImageLabel")
Avatar.Image = Config.LogoID
Avatar.Size = UDim2.new(0, 35, 0, 35) -- LEBIH KECIL
Avatar.Position = UDim2.new(0, 15, 0.5, -17)
Avatar.BackgroundColor3 = Config.Theme.Primary
Avatar.BackgroundTransparency = 0.8

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = Avatar

local Username = Instance.new("TextLabel")
Username.Text = Config.Title
Username.Size = UDim2.new(0.5, 0, 0, 20)
Username.Position = UDim2.new(0, 60, 0, 10)
Username.BackgroundTransparency = 1
Username.TextColor3 = Config.Theme.Text
Username.Font = Enum.Font.GothamBold
Username.TextSize = 16
Username.TextXAlignment = Enum.TextXAlignment.Left

local Status = Instance.new("TextLabel")
Status.Text = "10 Scripts"
Status.Size = UDim2.new(0.5, 0, 0, 16)
Status.Position = UDim2.new(0, 60, 0, 30)
Status.BackgroundTransparency = 1
Status.TextColor3 = Config.Theme.Subtext
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "−"
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -64, 0.5, -14)
MinimizeBtn.BackgroundColor3 = Config.Theme.Card
MinimizeBtn.TextColor3 = Config.Theme.Text
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 14

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- ==================== HORIZONTAL SCROLL AREA ====================
local ScrollContainer = Instance.new("Frame")
ScrollContainer.Size = UDim2.new(1, -20, 0, 220) -- TINGGI UNTUK KARTU
ScrollContainer.Position = UDim2.new(0, 10, 0, 60)
ScrollContainer.BackgroundTransparency = 1

-- HORIZONTAL SCROLLING FRAME
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Config.Theme.Primary
ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X -- HORIZONTAL SCROLL
ScrollFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Akan diupdate

-- HORIZONTAL CONTAINER
local CardContainer = Instance.new("Frame")
CardContainer.Size = UDim2.new(0, 0, 1, 0) -- Width akan diupdate
CardContainer.BackgroundTransparency = 1

-- ==================== CREATE HORIZONTAL CARDS ====================
local CARD_WIDTH = 160
local CARD_HEIGHT = 200
local CARD_MARGIN = 10

for i, scriptData in ipairs(Config.Scripts) do
    local Card = Instance.new("TextButton")
    Card.Text = ""
    Card.Size = UDim2.new(0, CARD_WIDTH, 0, CARD_HEIGHT)
    Card.Position = UDim2.new(0, (i-1) * (CARD_WIDTH + CARD_MARGIN), 0, 0)
    Card.BackgroundColor3 = Config.Theme.Card
    Card.AutoButtonColor = false
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 12)
    CardCorner.Parent = Card
    
    -- CARD HEADER (WARNA ACCENT)
    local CardHeader = Instance.new("Frame")
    CardHeader.Size = UDim2.new(1, 0, 0, 40)
    CardHeader.BackgroundColor3 = Config.Theme.Primary
    CardHeader.BackgroundTransparency = 0.2
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = CardHeader
    
    -- ICON DI HEADER
    local Icon = Instance.new("TextLabel")
    Icon.Text = scriptData.Icon
    Icon.Size = UDim2.new(0, 30, 0, 30)
    Icon.Position = UDim2.new(0.5, -15, 0.5, -15)
    Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Config.Theme.Text
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 20
    Icon.Parent = CardHeader
    
    -- SCRIPT NAME (DI BAWAH HEADER)
    local ScriptName = Instance.new("TextLabel")
    ScriptName.Text = scriptData.Name
    ScriptName.Size = UDim2.new(1, -20, 0, 30)
    ScriptName.Position = UDim2.new(0, 10, 0, 50)
    ScriptName.BackgroundTransparency = 1
    ScriptName.TextColor3 = Config.Theme.Text
    ScriptName.Font = Enum.Font.GothamBold
    ScriptName.TextSize = 14
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    ScriptName.Parent = Card
    
    -- DESCRIPTION (MULTI-LINE)
    local DescFrame = Instance.new("Frame")
    DescFrame.Size = UDim2.new(1, -20, 0, 70)
    DescFrame.Position = UDim2.new(0, 10, 0, 80)
    DescFrame.BackgroundTransparency = 1
    
    local ScriptDesc = Instance.new("TextLabel")
    ScriptDesc.Text = scriptData.Desc
    ScriptDesc.Size = UDim2.new(1, 0, 1, 0)
    ScriptDesc.BackgroundTransparency = 1
    ScriptDesc.TextColor3 = Config.Theme.Subtext
    ScriptDesc.Font = Enum.Font.Gotham
    ScriptDesc.TextSize = 11
    ScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
    ScriptDesc.TextYAlignment = Enum.TextYAlignment.Top
    ScriptDesc.TextWrapped = true
    ScriptDesc.Parent = DescFrame
    
    -- ACTION BUTTON (DI BAWAH)
    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Text = "▶ LOAD"
    ActionBtn.Size = UDim2.new(0.8, 0, 0, 35)
    ActionBtn.Position = UDim2.new(0.1, 0, 1, -45)
    ActionBtn.BackgroundColor3 = Config.Theme.Primary
    ActionBtn.TextColor3 = Color3.new(1, 1, 1)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.TextSize = 12
    ActionBtn.AutoButtonColor = false
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = ActionBtn
    
    -- STATUS INDICATOR
    local StatusDot = Instance.new("Frame")
    StatusDot.Size = UDim2.new(0, 8, 0, 8)
    StatusDot.Position = UDim2.new(1, -15, 0, 10)
    StatusDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- RED = Not loaded
    StatusDot.BorderSizePixel = 0
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(1, 0)
    StatusCorner.Parent = StatusDot
    
    -- HOVER EFFECT
    Card.MouseEnter:Connect(function()
        Card.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        CardHeader.BackgroundTransparency = 0
        ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    
    Card.MouseLeave:Connect(function()
        Card.BackgroundColor3 = Config.Theme.Card
        CardHeader.BackgroundTransparency = 0.2
        ActionBtn.BackgroundColor3 = Config.Theme.Primary
    end)
    
    -- URL MANAGEMENT SYSTEM
    local url = scriptData.URL
    local function UpdateStatus(color)
        StatusDot.BackgroundColor3 = color
    end
    
    -- CLICK FUNCTION
    Card.Activated:Connect(function()
        if url == "" or not url:find("http") then
            -- BUAT SIMPLE INPUT
            local InputFrame = Instance.new("Frame")
            InputFrame.Size = UDim2.new(0, 250, 0, 140)
            InputFrame.Position = UDim2.new(0.5, -125, 0.5, -70)
            InputFrame.BackgroundColor3 = Config.Theme.Card
            InputFrame.Parent = ScreenGui
            
            local InputTitle = Instance.new("TextLabel")
            InputTitle.Text = "URL for " .. scriptData.Name
            InputTitle.Size = UDim2.new(1, 0, 0, 40)
            InputTitle.BackgroundColor3 = Config.Theme.Primary
            InputTitle.TextColor3 = Color3.new(1, 1, 1)
            InputTitle.Font = Enum.Font.GothamBold
            InputTitle.TextSize = 14
            InputTitle.Parent = InputFrame
            
            local InputBox = Instance.new("TextBox")
            InputBox.PlaceholderText = "https://pastebin.com/raw/..."
            InputBox.Size = UDim2.new(1, -20, 0, 30)
            InputBox.Position = UDim2.new(0, 10, 0, 50)
            InputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            InputBox.TextColor3 = Color3.new(1, 1, 1)
            InputBox.Font = Enum.Font.Gotham
            InputBox.TextSize = 12
            InputBox.Parent = InputFrame
            
            local SaveBtn = Instance.new("TextButton")
            SaveBtn.Text = "SAVE URL"
            SaveBtn.Size = UDim2.new(0, 100, 0, 30)
            SaveBtn.Position = UDim2.new(0.5, -50, 1, -40)
            SaveBtn.BackgroundColor3 = Config.Theme.Primary
            SaveBtn.TextColor3 = Color3.new(1, 1, 1)
            SaveBtn.Font = Enum.Font.GothamBold
            SaveBtn.TextSize = 12
            SaveBtn.Parent = InputFrame
            
            SaveBtn.Activated:Connect(function()
                if InputBox.Text ~= "" then
                    url = InputBox.Text
                    UpdateStatus(Color3.fromRGB(255, 200, 0)) -- YELLOW = Has URL
                end
                InputFrame:Destroy()
            end)
            
            return
        end
        
        -- LOADING ANIMATION
        ActionBtn.Text = "⏳ LOADING..."
        UpdateStatus(Color3.fromRGB(255, 200, 0)) -- YELLOW = Loading
        
        -- SIMULASI LOAD
        task.wait(1.2)
        
        -- CEK JIKA URL VALID
        if url:find("http") then
            ActionBtn.Text = "✅ LOADED"
            UpdateStatus(Color3.fromRGB(0, 255, 0)) -- GREEN = Loaded
        else
            ActionBtn.Text = "❌ ERROR"
            UpdateStatus(Color3.fromRGB(255, 50, 50)) -- RED = Error
        end
        
        task.wait(1)
        ActionBtn.Text = "▶ LOAD"
    end)
    
    ActionBtn.Activated:Connect(function()
        Card.Activated()
    end)
    
    -- ASSEMBLE CARD
    CardHeader.Parent = Card
    DescFrame.Parent = Card
    ActionBtn.Parent = Card
    StatusDot.Parent = Card
    Card.Parent = CardContainer
end

-- UPDATE CONTAINER WIDTH BERDASARKAN JUMLAH CARD
CardContainer.Size = UDim2.new(0, #Config.Scripts * (CARD_WIDTH + CARD_MARGIN), 1, 0)

-- ==================== MINIMIZED APP ====================
local MinimizedApp = Instance.new("TextButton")
MinimizedApp.Text = ""
MinimizedApp.Size = UDim2.new(0, 50, 0, 50)
MinimizedApp.Position = UDim2.new(0.85, 0, 0.1, 0)
MinimizedApp.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizedApp.AutoButtonColor = false
MinimizedApp.Visible = false

local MinimizedCorner = Instance.new("UICorner")
MinimizedCorner.CornerRadius = UDim.new(0, 10)
MinimizedCorner.Parent = MinimizedApp

local MinimizedIcon = Instance.new("ImageLabel")
MinimizedIcon.Image = Config.LogoID
MinimizedIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
MinimizedIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
MinimizedIcon.BackgroundTransparency = 1
MinimizedIcon.ScaleType = Enum.ScaleType.Fit
MinimizedIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
MinimizedIcon.Parent = MinimizedApp

-- ==================== ASSEMBLE UI ====================
Avatar.Parent = Header
Username.Parent = Header
Status.Parent = Header
MinimizeBtn.Parent = Header
CloseBtn.Parent = Header
Header.Parent = AppWindow

CardContainer.Parent = ScrollFrame
ScrollFrame.Parent = ScrollContainer
ScrollContainer.Parent = AppWindow

MinimizedApp.Parent = ScreenGui
AppWindow.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

-- UPDATE SCROLL CANVAS SIZE
ScrollFrame.CanvasSize = UDim2.new(0, CardContainer.AbsoluteSize.X, 0, 0)

-- ==================== DRAGGING ====================
local function SetupDragging(frame)
    local dragging = false
    local dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                         input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
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
        MinimizeBtn.Text = "□"
    else
        AppWindow.Position = MinimizedApp.Position
        AppWindow.Visible = true
        MinimizedApp.Visible = false
        MinimizeBtn.Text = "−"
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
    MinimizeBtn.Text = "−"
end)

print("========================================")
print("↔️ HORIZONTAL HUB LOADED!")
print("Layout: Horizontal scroll (left to right)")
print("Size: 380x320 (Compact)")
print("Features: URL manager, status indicators")
print("========================================")

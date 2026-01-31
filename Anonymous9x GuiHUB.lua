-- ANONYMOUS9X HUB - PERFECT EDITION
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hapus GUI lama
if PlayerGui:FindFirstChild("PerfectHub") then
    PlayerGui.PerfectHub:Destroy()
end

-- ==================== CONFIG ====================
local Config = {
    Title = "ANONYMOUS HUB",
    LogoID = "rbxassetid://97269958324726",
    Scripts = {
        {Name = "👁️ ESP", URL = "", Desc = "See through walls"},
        {Name = "👻 HIDE NAME", URL = "", Desc = "Hide display name"},
        {Name = "✨ GLOW", URL = "", Desc = "Glowing effect"},
        {Name = "🌌 SKYBOX", URL = "", Desc = "Change skybox"},
        {Name = "⚡ FLY", URL = "", Desc = "Enable flying"},
        {Name = "🏎️ SPEED", URL = "", Desc = "Increase speed"},
        {Name = "🛡️ ANTI-AFK", URL = "", Desc = "Prevent AFK kick"},
        {Name = "🔧 ADMIN", URL = "", Desc = "Admin tools"},
        {Name = "💰 FARM", URL = "", Desc = "Auto farm"},
        {Name = "🎯 AIM", URL = "", Desc = "Auto aim"}
    }
}

-- ==================== GUI UTAMA ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PerfectHub"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Active = true

-- DRAGGING SYSTEM
local draggingMain = false
local dragStartMain = Vector2.new(0, 0)
local startPosMain = MainFrame.Position

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = true
        dragStartMain = Vector2.new(input.Position.X, input.Position.Y)
        startPosMain = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if draggingMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStartMain
        MainFrame.Position = UDim2.new(
            startPosMain.X.Scale,
            startPosMain.X.Offset + delta.X,
            startPosMain.Y.Scale,
            startPosMain.Y.Offset + delta.Y
        )
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = false
    end
end)

-- TITLE BAR
local TitleBar = Instance.new("TextButton")
TitleBar.Text = ""
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
TitleBar.AutoButtonColor = false
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "🧿 " .. Config.Title
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "_"
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -60, 0.5, -12)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TitleBar

-- SCROLL FRAME
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -45)
ScrollFrame.Position = UDim2.new(0, 5, 0, 40)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 100, 200)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)

-- ==================== KOTAK MINIMIZE ====================
local MinimizedFrame = Instance.new("TextButton")
MinimizedFrame.Text = ""
MinimizedFrame.Size = UDim2.new(0, 50, 0, 50)
MinimizedFrame.Position = UDim2.new(0.9, 0, 0.1, 0)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizedFrame.AutoButtonColor = false
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui

local MinimizedLogo = Instance.new("ImageLabel")
MinimizedLogo.Image = Config.LogoID
MinimizedLogo.Size = UDim2.new(0.7, 0, 0.7, 0)
MinimizedLogo.Position = UDim2.new(0.15, 0, 0.15, 0)
MinimizedLogo.BackgroundTransparency = 1
MinimizedLogo.ScaleType = Enum.ScaleType.Fit
MinimizedLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
MinimizedLogo.Parent = MinimizedFrame

-- ==================== LOADING SYSTEM (FIXED) ====================
local LoadStatus = {
    -- Status untuk tiap script
    ["👁️ ESP"] = {loaded = false, url = ""},
    ["👻 HIDE NAME"] = {loaded = false, url = ""},
    ["✨ GLOW"] = {loaded = false, url = ""},
    ["🌌 SKYBOX"] = {loaded = false, url = ""},
    ["⚡ FLY"] = {loaded = false, url = ""},
    ["🏎️ SPEED"] = {loaded = false, url = ""},
    ["🛡️ ANTI-AFK"] = {loaded = false, url = ""},
    ["🔧 ADMIN"] = {loaded = false, url = ""},
    ["💰 FARM"] = {loaded = false, url = ""},
    ["🎯 AIM"] = {loaded = false, url = ""}
}

local function LoadScript(scriptName, url, button)
    -- CEK JIKA URL MASIH KOSONG
    if url == "" then
        -- TAMPILKAN POPUP INPUT
        local popup = Instance.new("Frame")
        popup.Size = UDim2.new(0, 300, 0, 150)
        popup.Position = UDim2.new(0.5, -150, 0.5, -75)
        popup.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        popup.Parent = ScreenGui
        
        local title = Instance.new("TextLabel")
        title.Text = "⚠️ URL REQUIRED"
        title.Size = UDim2.new(1, 0, 0, 40)
        title.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        title.TextColor3 = Color3.new(1, 1, 1)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        title.Parent = popup
        
        local info = Instance.new("TextLabel")
        info.Text = "Script '" .. scriptName .. "' needs a URL\nPaste your loadstring URL below:"
        info.Size = UDim2.new(1, -20, 0, 50)
        info.Position = UDim2.new(0, 10, 0, 45)
        info.BackgroundTransparency = 1
        info.TextColor3 = Color3.new(1, 1, 1)
        info.Font = Enum.Font.Gotham
        info.TextSize = 12
        info.Parent = popup
        
        local inputBox = Instance.new("TextBox")
        inputBox.PlaceholderText = "https://pastebin.com/raw/..."
        inputBox.Size = UDim2.new(1, -20, 0, 30)
        inputBox.Position = UDim2.new(0, 10, 0, 100)
        inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        inputBox.TextColor3 = Color3.new(1, 1, 1)
        inputBox.Font = Enum.Font.Gotham
        inputBox.TextSize = 12
        inputBox.Parent = popup
        
        local saveBtn = Instance.new("TextButton")
        saveBtn.Text = "SAVE URL"
        saveBtn.Size = UDim2.new(0, 100, 0, 30)
        saveBtn.Position = UDim2.new(0.5, -50, 1, -40)
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        saveBtn.TextColor3 = Color3.new(1, 1, 1)
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.TextSize = 12
        saveBtn.Parent = popup
        
        saveBtn.MouseButton1Click:Connect(function()
            if inputBox.Text ~= "" then
                -- Simpan URL ke config
                LoadStatus[scriptName].url = inputBox.Text
                
                -- Update button state
                button.Text = "▶ READY"
                button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
                
                popup:Destroy()
            end
        end)
        
        return false
    end
    
    -- LOADING ANIMATION
    local originalText = button.Text
    local originalColor = button.BackgroundColor3
    
    button.Text = "⏳ LOADING..."
    button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    
    -- SIMULASI LOADING (karena URL masih kosong)
    local dots = 0
    local loadingAnim = task.spawn(function()
        while button.Text == "⏳ LOADING..." do
            dots = (dots + 1) % 4
            button.Text = "⏳ LOADING" .. string.rep(".", dots)
            task.wait(0.3)
        end
    end)
    
    -- TEST URL (simulasi)
    task.wait(1.5) -- Simulasi loading time
    
    -- HENTIKAN ANIMASI
    task.cancel(loadingAnim)
    
    -- CEK JIKA URL VALID
    if url:find("https://") and url:find(".com") then
        -- SUCCESS STATE
        LoadStatus[scriptName].loaded = true
        button.Text = "✅ LOADED"
        button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        
        -- TAMPILKAN NOTIFIKASI SUKSES
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 250, 0, 60)
        notif.Position = UDim2.new(0.5, -125, 0.8, 0)
        notif.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        notif.Parent = ScreenGui
        
        local notifText = Instance.new("TextLabel")
        notifText.Text = "✅ " .. scriptName .. " loaded!"
        notifText.Size = UDim2.new(1, 0, 1, 0)
        notifText.BackgroundTransparency = 1
        notifText.TextColor3 = Color3.new(1, 1, 1)
        notifText.Font = Enum.Font.GothamBold
        notifText.TextSize = 13
        notifText.Parent = notif
        
        task.wait(2)
        notif:Destroy()
        
        task.wait(0.5)
        button.Text = "▶ LOADED"
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    else
        -- ERROR STATE
        button.Text = "❌ INVALID URL"
        button.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        
        task.wait(2)
        button.Text = originalText
        button.BackgroundColor3 = originalColor
    end
    
    return true
end

-- ==================== CREATE SCRIPT BUTTONS ====================
for i, scriptData in ipairs(Config.Scripts) do
    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Name = "Btn_" .. scriptData.Name
    ButtonFrame.Text = ""
    ButtonFrame.Size = UDim2.new(1, 0, 0, 55)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ButtonFrame.AutoButtonColor = false
    
    -- STATUS INDICATOR (kiri)
    local StatusDot = Instance.new("Frame")
    StatusDot.Name = "StatusDot"
    StatusDot.Size = UDim2.new(0, 6, 0, 6)
    StatusDot.Position = UDim2.new(0, 3, 0.5, -3)
    StatusDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150) -- GREY = not loaded
    StatusDot.BorderSizePixel = 0
    StatusDot.Parent = ButtonFrame
    
    -- ICON
    local Icon = Instance.new("TextLabel")
    Icon.Text = string.sub(scriptData.Name, 1, 2)
    Icon.Size = UDim2.new(0, 30, 1, 0)
    Icon.Position = UDim2.new(0, 10, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Color3.new(1, 1, 1)
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 16
    Icon.Parent = ButtonFrame
    
    -- SCRIPT NAME
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Text = scriptData.Name
    NameLabel.Size = UDim2.new(0.6, -45, 0, 22)
    NameLabel.Position = UDim2.new(0, 45, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextColor3 = Color3.new(1, 1, 1)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 12
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = ButtonFrame
    
    -- DESCRIPTION
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Text = scriptData.Desc
    DescLabel.Size = UDim2.new(0.6, -45, 0, 18)
    DescLabel.Position = UDim2.new(0, 45, 0, 30)
    DescLabel.BackgroundTransparency = 1
    DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 10
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = ButtonFrame
    
    -- EXECUTE BUTTON
    local ExecuteBtn = Instance.new("TextButton")
    ExecuteBtn.Name = "ExecuteBtn"
    ExecuteBtn.Text = "▶ LOAD"
    ExecuteBtn.Size = UDim2.new(0, 70, 0, 35) -- LEBIH LEBAR
    ExecuteBtn.Position = UDim2.new(1, -75, 0.5, -17)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    ExecuteBtn.TextColor3 = Color3.new(1, 1, 1)
    ExecuteBtn.Font = Enum.Font.GothamBold
    ExecuteBtn.TextSize = 11
    ExecuteBtn.Parent = ButtonFrame
    
    -- HOVER EFFECTS
    ButtonFrame.MouseEnter:Connect(function()
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    end)
    
    ButtonFrame.MouseLeave:Connect(function()
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end)
    
    -- CLICK FUNCTION
    ButtonFrame.MouseButton1Click:Connect(function()
        LoadScript(scriptData.Name, LoadStatus[scriptData.Name].url, ExecuteBtn)
    end)
    
    ExecuteBtn.MouseButton1Click:Connect(function()
        LoadScript(scriptData.Name, LoadStatus[scriptData.Name].url, ExecuteBtn)
    end)
    
    ButtonFrame.Parent = ScrollFrame
end

-- ==================== FINAL SETUP ====================
UIListLayout.Parent = ScrollFrame
ScrollFrame.Parent = MainFrame
MainFrame.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- ==================== BUTTON FUNCTIONS ====================
local isMinimized = false

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MinimizedFrame.Position = MainFrame.Position
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
        MinimizeBtn.Text = "□"
    else
        MainFrame.Position = MinimizedFrame.Position
        MainFrame.Visible = true
        MinimizedFrame.Visible = false
        MinimizeBtn.Text = "_"
    end
end)

MinimizedFrame.MouseButton1Click:Connect(function()
    MainFrame.Position = MinimizedFrame.Position
    MainFrame.Visible = true
    MinimizedFrame.Visible = false
    isMinimized = false
    MinimizeBtn.Text = "_"
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- HOTKEYS
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == Enum.KeyCode.M then
            isMinimized = not isMinimized
            if isMinimized then
                MinimizedFrame.Position = MainFrame.Position
                MainFrame.Visible = false
                MinimizedFrame.Visible = true
                MinimizeBtn.Text = "□"
            else
                MainFrame.Position = MinimizedFrame.Position
                MainFrame.Visible = true
                MinimizedFrame.Visible = false
                MinimizeBtn.Text = "_"
            end
        end
    end
end)

print("========================================")
print("🎯 PERFECT HUB LOADED!")
print("Features:")
print("1. URL input popup when empty")
print("2. Loading animation")
print("3. Success/error notifications")
print("4. Status indicators")
print("========================================")

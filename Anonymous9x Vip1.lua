--[[ 
    ANONYMOUS9x VIP - LOGIN PANEL (PUBLIC VERSION)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clean up existing
if PlayerGui:FindFirstChild("HorizontalHub") then PlayerGui.HorizontalHub:Destroy() end

-- Configuration
local Config = {
    Title = "ANONYMOUS9x VIP",
    LogoID = "rbxassetid://97269958324726",
    Theme = {
        Background = Color3.fromRGB(8, 8, 8),
        Card = Color3.fromRGB(15, 15, 15),
        Border = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(255, 255, 255)
    }
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "HorizontalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Helper Function
local function AddStroke(obj, thickness, color)
    local s = Instance.new("UIStroke", obj)
    s.Color = color or Config.Theme.Border
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

-- ==================== LOGIN FRAME ====================
local LoginFrame = Instance.new("Frame", ScreenGui)
LoginFrame.Size = UDim2.new(0, 260, 0, 300)
LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
LoginFrame.BackgroundColor3 = Config.Theme.Background
LoginFrame.Active = false
LoginFrame.Draggable = false
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 10)
AddStroke(LoginFrame, 1.5)

-- Logo
local LogLogo = Instance.new("ImageLabel", LoginFrame)
LogLogo.Size = UDim2.new(0, 60, 0, 60)
LogLogo.Position = UDim2.new(0.5, -30, 0.1, 0)
LogLogo.Image = Config.LogoID
LogLogo.BackgroundTransparency = 1

-- Title
local LogTitle = Instance.new("TextLabel", LoginFrame)
LogTitle.Text = "ANONYMOUS9x VIP"
LogTitle.Size = UDim2.new(1, 0, 0, 25)
LogTitle.Position = UDim2.new(0, 0, 0.3, 0)
LogTitle.TextColor3 = Config.Theme.Text
LogTitle.Font = Enum.Font.GothamBlack
LogTitle.TextSize = 16
LogTitle.BackgroundTransparency = 1

-- Username Input
local UserBox = Instance.new("TextBox", LoginFrame)
UserBox.Size = UDim2.new(0.85, 0, 0, 35)
UserBox.Position = UDim2.new(0.075, 0, 0.5, 0)
UserBox.Text = ""
UserBox.PlaceholderText = "Input User"
UserBox.BackgroundColor3 = Config.Theme.Card
UserBox.TextColor3 = Color3.new(1,1,1)
UserBox.Font = Enum.Font.GothamBold
UserBox.TextSize = 12
Instance.new("UICorner", UserBox)
AddStroke(UserBox, 1)

-- Key Input
local KeyBox = Instance.new("TextBox", LoginFrame)
KeyBox.Size = UDim2.new(0.85, 0, 0, 35)
KeyBox.Position = UDim2.new(0.075, 0, 0.67, 0)
KeyBox.Text = ""
KeyBox.PlaceholderText = "Input Key"
KeyBox.BackgroundColor3 = Config.Theme.Card
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Font = Enum.Font.GothamBold
KeyBox.TextSize = 12
Instance.new("UICorner", KeyBox)
AddStroke(KeyBox, 1)

-- Login Button
local LogBtn = Instance.new("TextButton", LoginFrame)
LogBtn.Size = UDim2.new(0.85, 0, 0, 40)
LogBtn.Position = UDim2.new(0.075, 0, 0.84, 0)
LogBtn.BackgroundColor3 = Color3.new(1,1,1)
LogBtn.Text = "AUTHENTICATE"
LogBtn.TextColor3 = Color3.new(0,0,0)
LogBtn.Font = Enum.Font.GothamBlack
LogBtn.TextSize = 13
Instance.new("UICorner", LogBtn)

-- ==================== LOGIN LOGIC ====================
LogBtn.MouseButton1Click:Connect(function()
    local username = UserBox.Text
    local key = KeyBox.Text
    
    -- Simple validation
    if username == "" or key == "" then
        LogBtn.Text = "EMPTY FIELD"
        LogBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        task.wait(1)
        LogBtn.Text = "AUTHENTICATE"
        LogBtn.BackgroundColor3 = Color3.new(1,1,1)
        return
    end
    
    -- Show loading state
    LogBtn.Text = "VERIFYING..."
    
    -- Save credentials to be used by main script
    _G.VIP_CREDENTIALS = {
        Username = username,
        Key = key,
        Timestamp = os.time()
    }
    
    -- Load main GUI from external source
    task.spawn(function()
        task.wait(0.5) -- Simulate verification delay
        
        -- Remove login panel
        LoginFrame.Visible = false
        
        -- Load main GUI (This will be obfuscated and hosted separately)
        local success, err = pcall(function()
            -- This URL will be your Pastefy unlisted link
            loadstring(game:HttpGet("https://pastefy.ga/raw/ANONYMOUS9x_MAIN_GUI"))()
        end)
        
        if not success then
            -- Fallback if main GUI fails to load
            LogBtn.Text = "LOAD ERROR"
            LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            task.wait(2)
            LogBtn.Text = "AUTHENTICATE"
            LogBtn.BackgroundColor3 = Color3.new(1,1,1)
            LoginFrame.Visible = true
        end
    end)
end)

-- Enter key support
UserBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        KeyBox:CaptureFocus()
    end
end)

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        LogBtn:Fire()
    end
end)

print(">> [ANONYMOUS9x VIP Login Panel]: Loaded Successfully!")

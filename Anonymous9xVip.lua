--[[ 
    ANONYMOUS9x VIP - LOGIN PANEL (PUBLIC VERSION)
    GitHub: https://github.com/Anonymous9x/Anonymous9x-VIP-Login
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

-- VIP USERS & KEYS (50 SLOTS)
local VIP_ACCESS = {
    -- VIP 1-8
    ["VIP1"] = "3320",
    ["VIP2"] = "4201",
    ["VIP3"] = "0965",
    ["VIP4"] = "8801",
    ["VIP5"] = "7710",
    ["VIP6"] = "2210",
    ["VIP7"] = "1010",
    ["VIP8"] = "2001",
    -- VIP 9-15
    ["VIP9"] = "0039",
    ["VIP10"] = "2714",
    ["VIP11"] = "0634",
    ["VIP12"] = "9913",
    ["VIP13"] = "7767",
    ["VIP14"] = "5512",
    ["VIP15"] = "0004",
    -- VIP 16-30
    ["VIP16"] = "9991",
    ["VIP17"] = "5150",
    ["VIP18"] = "2018",
    ["VIP19"] = "2666",
    ["VIP20"] = "1199",
    ["VIP21"] = "3187",
    ["VIP22"] = "1321",
    ["VIP23"] = "6663",
    ["VIP24"] = "8080",
    ["VIP25"] = "0917",
    ["VIP26"] = "6105",
    ["VIP27"] = "1872",
    ["VIP28"] = "4142",
    ["VIP29"] = "1730",
    ["VIP30"] = "5729",
    -- VIP 31-50 (NEW)
    ["VIP31"] = "4827",
    ["VIP32"] = "6391",
    ["VIP33"] = "7254",
    ["VIP34"] = "1583",
    ["VIP35"] = "3946",
    ["VIP36"] = "8472",
    ["VIP37"] = "5069",
    ["VIP38"] = "2173",
    ["VIP39"] = "9641",
    ["VIP40"] = "3528",
    ["VIP41"] = "6895",
    ["VIP42"] = "1437",
    ["VIP43"] = "8702",
    ["VIP44"] = "4296",
    ["VIP45"] = "7934",
    ["VIP46"] = "2685",
    ["VIP47"] = "9150",
    ["VIP48"] = "5763",
    ["VIP49"] = "3412",
    ["VIP50"] = "7029"
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

-- Username Input (NORMAL - NO CLUE)
local UserBox = Instance.new("TextBox", LoginFrame)
UserBox.Size = UDim2.new(0.85, 0, 0, 35)
UserBox.Position = UDim2.new(0.075, 0, 0.5, 0)
UserBox.Text = ""
UserBox.PlaceholderText = "Input user" -- NORMAL TEXT
UserBox.BackgroundColor3 = Config.Theme.Card
UserBox.TextColor3 = Color3.new(1,1,1)
UserBox.Font = Enum.Font.GothamBold
UserBox.TextSize = 12
Instance.new("UICorner", UserBox)
AddStroke(UserBox, 1)

-- Key Input (NORMAL - NO CLUE)
local KeyBox = Instance.new("TextBox", LoginFrame)
KeyBox.Size = UDim2.new(0.85, 0, 0, 35)
KeyBox.Position = UDim2.new(0.075, 0, 0.67, 0)
KeyBox.Text = ""
KeyBox.PlaceholderText = "Input key" -- NORMAL TEXT
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
    
    -- Auto-uppercase username for VIP check
    local checkUsername = string.upper(username)
    
    -- Validate VIP access
    if not VIP_ACCESS[checkUsername] then
        LogBtn.Text = "INVALID LOGIN"
        LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        task.wait(1)
        LogBtn.Text = "AUTHENTICATE"
        LogBtn.BackgroundColor3 = Color3.new(1,1,1)
        UserBox.Text = ""
        KeyBox.Text = ""
        return
    end
    
    -- Check key
    if VIP_ACCESS[checkUsername] ~= key then
        LogBtn.Text = "INVALID LOGIN"
        LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        task.wait(1)
        LogBtn.Text = "AUTHENTICATE"
        LogBtn.BackgroundColor3 = Color3.new(1,1,1)
        KeyBox.Text = ""
        return
    end
    
    -- Extract VIP number
    local vipNumber = string.match(checkUsername, "%d+") or "0"
    
    -- Show loading state
    LogBtn.Text = "VERIFYING..."
    LogBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    task.wait(0.3)
    
    -- Save credentials to be used by main script
    _G.VIP_CREDENTIALS = {
        Username = checkUsername,
        Key = key,
        Slot = vipNumber,
        Timestamp = os.time()
    }
    
    -- Load main GUI from external source
    task.spawn(function()
        task.wait(0.5) -- Simulate verification delay
        
        -- Remove login panel
        LoginFrame.Visible = false
        
        -- Load main GUI from Pastebin URL (NEW URL)
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/NsSiLmtj"))()
        end)
        
        if not success then
            -- Fallback if main GUI fails to load
            warn(">> [ERROR] Failed to load main GUI:", err)
            LogBtn.Text = "LOAD ERROR"
            LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            task.wait(2)
            LogBtn.Text = "AUTHENTICATE"
            LogBtn.BackgroundColor3 = Color3.new(1,1,1)
            LoginFrame.Visible = true
        else
            print(">> [SUCCESS] VIP Access Granted")
            print(">> [INFO] VIP Slot:", vipNumber)
            print(">> [INFO] Loading main GUI V1")
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
print(">> ? VIP Slots Available")
print(">> keep upgrading")

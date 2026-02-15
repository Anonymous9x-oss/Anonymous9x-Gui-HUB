--[[ ANONYMOUS9x VIP - LOGIN PANEL (PREMIUM HACKER EDITION) 
Dengan Auto-Login via Firebase (Max 2 Devices)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Analytics = game:GetService("RbxAnalyticsService")

-- ==================== KONFIGURASI FIREBASE ====================
local FIREBASE_URL = "https://loginvipanonymous9x-default-rtdb.asia-southeast1.firebasedatabase.app/" -- PASTIKAN URL INI BENAR

-- ==================== FUNGSI BANTUAN FIREBASE ====================
local function FirebaseRequest(method, path, data)
    local url = FIREBASE_URL .. path .. ".json"
    local success, response = pcall(function()
        if method == "GET" then
            return HttpService:GetAsync(url)
        elseif method == "PUT" then
            return HttpService:PutAsync(url, data)
        end
    end)
    if success and response then
        return HttpService:JSONDecode(response)
    end
    return nil
end

-- ==================== FUNGSI MENDAPATKAN DEVICE ID YANG STABIL ====================
local function GetStableDeviceID()
    -- Cek apakah executor mendukung file (seperti Synapse, KRNL, dll)
    if isfile and writefile then
        local filePath = "vip_device.txt"
        if isfile(filePath) then
            return readfile(filePath)
        else
            local newID = HttpService:GenerateGUID(false)
            writefile(filePath, newID)
            return newID
        end
    end
    
    -- Fallback: gunakan syn.cookie jika tersedia (executor berbasis Synapse)
    if syn and syn.cookie then
        local cookie = syn.cookie.get("VIP_DeviceID")
        if cookie and cookie ~= "" then
            return cookie
        else
            local newID = HttpService:GenerateGUID(false)
            syn.cookie.set("VIP_DeviceID", newID)
            return newID
        end
    end
    
    -- Fallback: gunakan setclipboard + pengumuman manual (karena tidak ada penyimpanan)
    -- Ini akan meminta user menyimpan ID sendiri
    warn(">> [INFO] Executor tidak mendukung penyimpanan otomatis.")
    warn(">> [INFO] Device ID akan ditampilkan, simpan dan masukkan manual jika diperlukan.")
    
    -- Buat ID unik dari gabungan clientId dan waktu
    local clientId = Analytics:GetClientId()
    local timeStamp = tostring(os.time())
    local rawID = clientId .. timeStamp
    local deviceID = HttpService:MD5(rawID) -- Buat hash sederhana
    return deviceID
end

-- Panggil fungsi untuk mendapatkan device ID
local DEVICE_ID = GetStableDeviceID()
print(">> [DEBUG] Device ID: " .. DEVICE_ID)

-- ==================== FUNGSI CEK AUTO LOGIN ====================
local function GetAutoLoginUser()
    local data = FirebaseRequest("GET", "device_to_user/" .. DEVICE_ID)
    if type(data) == "string" then
        return data
    end
    return nil
end

-- ==================== FUNGSI DAFTARKAN DEVICE KE USER ====================
local function RegisterDevice(username)
    local userPath = "users/" .. username
    local userData = FirebaseRequest("GET", userPath) or { devices = {} }
    
    local deviceCount = 0
    for _ in pairs(userData.devices or {}) do
        deviceCount = deviceCount + 1
    end
    
    if deviceCount >= 2 then
        return false, "MAX_DEVICES"
    end
    
    userData.devices = userData.devices or {}
    userData.devices[DEVICE_ID] = os.time()
    
    -- Simpan data user
    local ok1 = FirebaseRequest("PUT", userPath, HttpService:JSONEncode(userData))
    -- Simpan mapping device -> username
    local ok2 = FirebaseRequest("PUT", "device_to_user/" .. DEVICE_ID, HttpService:JSONEncode(username))
    
    return ok1 ~= nil and ok2 ~= nil
end

-- ==================== CEK AUTO LOGIN ====================
local autoUser = GetAutoLoginUser()
if autoUser then
    print(">> [AUTO-LOGIN] Selamat datang kembali, " .. autoUser)
    _G.VIP_CREDENTIALS = { Username = autoUser, Auto = true }
    task.spawn(function()
        local success, err = pcall(function()
            -- GANTI URL INI DENGAN URL MAIN GUI ANDA YANG ASLI
            loadstring(game:HttpGet("https://pastebin.com/raw/NsSiLmtj"))()
        end)
        if not success then
            warn(">> [ERROR] Gagal load main GUI:", err)
        end
    end)
    return
end

-- ==================== KONFIGURASI TAMPILAN ====================
if PlayerGui:FindFirstChild("HorizontalHub") then
    PlayerGui.HorizontalHub:Destroy()
end

local Config = {
    Title = "ANONYMOUS9x VIP",
    LogoID = "rbxassetid://97269958324726",
    Theme = {
        Background = Color3.fromRGB(8, 8, 8),
        Card = Color3.fromRGB(15, 15, 15),
        Border = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(255, 255, 255),
        HackerGreen = Color3.fromRGB(0, 255, 100)
    }
}

-- ==================== DATA VIP (70 SLOT) ====================
local VIP_ACCESS = {
    ["VIP1"] = "3320", ["VIP2"] = "4201", ["VIP3"] = "0965", ["VIP4"] = "8801",
    ["VIP5"] = "7710", ["VIP6"] = "2210", ["VIP7"] = "1010", ["VIP8"] = "2001",
    ["VIP9"] = "0039", ["VIP10"] = "2714", ["VIP11"] = "0634", ["VIP12"] = "9913",
    ["VIP13"] = "7767", ["VIP14"] = "5512", ["VIP15"] = "0004", ["VIP16"] = "9991",
    ["VIP17"] = "5150", ["VIP18"] = "2018", ["VIP19"] = "2666", ["VIP20"] = "1199",
    ["VIP21"] = "3187", ["VIP22"] = "1321", ["VIP23"] = "6663", ["VIP24"] = "8080",
    ["VIP25"] = "0917", ["VIP26"] = "6105", ["VIP27"] = "1872", ["VIP28"] = "4142",
    ["VIP29"] = "1730", ["VIP30"] = "5729", ["VIP31"] = "4827", ["VIP32"] = "6391",
    ["VIP33"] = "7254", ["VIP34"] = "1583", ["VIP35"] = "3946", ["VIP36"] = "8472",
    ["VIP37"] = "5069", ["VIP38"] = "2173", ["VIP39"] = "9641", ["VIP40"] = "3528",
    ["VIP41"] = "6895", ["VIP42"] = "1437", ["VIP43"] = "8702", ["VIP44"] = "4296",
    ["VIP45"] = "7934", ["VIP46"] = "2685", ["VIP47"] = "9150", ["VIP48"] = "5763",
    ["VIP49"] = "3412", ["VIP50"] = "7029", ["VIP51"] = "3842", ["VIP52"] = "5719",
    ["VIP53"] = "2063", ["VIP54"] = "7954", ["VIP55"] = "1387", ["VIP56"] = "6490",
    ["VIP57"] = "4235", ["VIP58"] = "8162", ["VIP59"] = "3571", ["VIP60"] = "9028",
    ["VIP61"] = "6743", ["VIP62"] = "5196", ["VIP63"] = "2850", ["VIP64"] = "7364",
    ["VIP65"] = "4912", ["VIP66"] = "8675", ["VIP67"] = "1239", ["VIP68"] = "5487",
    ["VIP69"] = "6702", ["VIP70"] = "3941"
}

-- ==================== MEMBUAT GUI ====================
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "HorizontalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- SOUND EFFECTS
local SoundContainer = Instance.new("Folder", ScreenGui)
SoundContainer.Name = "Sounds"

local GlitchSound = Instance.new("Sound", SoundContainer)
GlitchSound.SoundId = "rbxassetid://9086208751"
GlitchSound.Volume = 0.35
GlitchSound.PlaybackSpeed = 1.1

local LoginSound = Instance.new("Sound", SoundContainer)
LoginSound.SoundId = "rbxassetid://9114397232"
LoginSound.Volume = 0.4
LoginSound.PlaybackSpeed = 1.05

local ErrorSound = Instance.new("Sound", SoundContainer)
ErrorSound.SoundId = "rbxassetid://9112879730"
ErrorSound.Volume = 0.35
ErrorSound.PlaybackSpeed = 0.95

local function AddStroke(obj, thickness, color)
    local s = Instance.new("UIStroke", obj)
    s.Color = color or Config.Theme.Border
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

local LoginFrame = Instance.new("Frame", ScreenGui)
LoginFrame.Size = UDim2.new(0, 260, 0, 300)
LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
LoginFrame.BackgroundColor3 = Config.Theme.Background
LoginFrame.Active = false
LoginFrame.Draggable = false
LoginFrame.BackgroundTransparency = 1
LoginFrame.ClipsDescendants = true
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = AddStroke(LoginFrame, 2)

local ScanLine = Instance.new("Frame", LoginFrame)
ScanLine.Size = UDim2.new(1, 0, 0, 2)
ScanLine.Position = UDim2.new(0, 0, 0, 0)
ScanLine.BackgroundColor3 = Config.Theme.HackerGreen
ScanLine.BackgroundTransparency = 0.3
ScanLine.BorderSizePixel = 0
ScanLine.ZIndex = 10

local GlitchOverlay = Instance.new("Frame", LoginFrame)
GlitchOverlay.Size = UDim2.new(1, 0, 1, 0)
GlitchOverlay.BackgroundColor3 = Config.Theme.HackerGreen
GlitchOverlay.BackgroundTransparency = 1
GlitchOverlay.BorderSizePixel = 0
GlitchOverlay.ZIndex = 9

local LogLogo = Instance.new("ImageLabel", LoginFrame)
LogLogo.Size = UDim2.new(0, 60, 0, 60)
LogLogo.Position = UDim2.new(0.5, -30, 0.1, 0)
LogLogo.Image = Config.LogoID
LogLogo.BackgroundTransparency = 1
LogLogo.ImageTransparency = 1

local TitleContainer = Instance.new("Frame", LoginFrame)
TitleContainer.Size = UDim2.new(1, 0, 0, 25)
TitleContainer.Position = UDim2.new(0, 0, 0.3, 0)
TitleContainer.BackgroundTransparency = 1

local LogTitle = Instance.new("TextLabel", TitleContainer)
LogTitle.Text = "ANONYMOUS9x VIP"
LogTitle.Size = UDim2.new(1, 0, 1, 0)
LogTitle.Position = UDim2.new(0, 0, 0, 0)
LogTitle.TextColor3 = Config.Theme.Text
LogTitle.Font = Enum.Font.GothamBlack
LogTitle.TextSize = 16
LogTitle.BackgroundTransparency = 1
LogTitle.TextTransparency = 1
LogTitle.ZIndex = 3

local GlitchR = LogTitle:Clone()
GlitchR.Parent = TitleContainer
GlitchR.TextColor3 = Color3.fromRGB(255, 0, 0)
GlitchR.TextTransparency = 0.7
GlitchR.ZIndex = 1

local GlitchG = LogTitle:Clone()
GlitchG.Parent = TitleContainer
GlitchG.TextColor3 = Config.Theme.HackerGreen
GlitchG.TextTransparency = 0.7
GlitchG.ZIndex = 2

local UserBox = Instance.new("TextBox", LoginFrame)
UserBox.Size = UDim2.new(0.85, 0, 0, 35)
UserBox.Position = UDim2.new(0.075, 0, 0.5, 0)
UserBox.Text = ""
UserBox.PlaceholderText = "Input user"
UserBox.BackgroundColor3 = Config.Theme.Card
UserBox.TextColor3 = Color3.new(1,1,1)
UserBox.Font = Enum.Font.GothamBold
UserBox.TextSize = 12
UserBox.BackgroundTransparency = 1
UserBox.TextTransparency = 1
Instance.new("UICorner", UserBox)
local UserStroke = AddStroke(UserBox, 1.5)
UserStroke.Transparency = 1

local KeyBox = Instance.new("TextBox", LoginFrame)
KeyBox.Size = UDim2.new(0.85, 0, 0, 35)
KeyBox.Position = UDim2.new(0.075, 0, 0.67, 0)
KeyBox.Text = ""
KeyBox.PlaceholderText = "Input key"
KeyBox.BackgroundColor3 = Config.Theme.Card
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Font = Enum.Font.GothamBold
KeyBox.TextSize = 12
KeyBox.BackgroundTransparency = 1
KeyBox.TextTransparency = 1
Instance.new("UICorner", KeyBox)
local KeyStroke = AddStroke(KeyBox, 1.5)
KeyStroke.Transparency = 1

local LogBtn = Instance.new("TextButton", LoginFrame)
LogBtn.Size = UDim2.new(0.85, 0, 0, 40)
LogBtn.Position = UDim2.new(0.075, 0, 0.84, 0)
LogBtn.BackgroundColor3 = Color3.new(1,1,1)
LogBtn.Text = "AUTHENTICATE"
LogBtn.TextColor3 = Color3.new(0,0,0)
LogBtn.Font = Enum.Font.GothamBlack
LogBtn.TextSize = 13
LogBtn.BackgroundTransparency = 1
LogBtn.TextTransparency = 1
Instance.new("UICorner", LogBtn)

-- ==================== ANIMASI ====================
task.spawn(function()
    while LoginFrame.Parent and LoginFrame.Visible do
        ScanLine.Position = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ScanLine, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Position = UDim2.new(0, 0, 1, 0)
        }):Play()
        task.wait(2)
    end
end)

task.spawn(function()
    while LoginFrame.Parent and LoginFrame.Visible do
        TweenService:Create(MainStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            Color = Config.Theme.HackerGreen,
            Thickness = 3
        }):Play()
        task.wait(0.8)
        TweenService:Create(MainStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            Color = Config.Theme.Border,
            Thickness = 2
        }):Play()
        task.wait(0.8)
    end
end)

task.spawn(function()
    local originalText = "ANONYMOUS9x VIP"
    local glitchChars = {"█", "▓", "▒", "░", "⌘", "◊", "◘", "●"}
    while LoginFrame.Parent and LoginFrame.Visible do
        if math.random() > 0.7 then
            local offsetX = math.random(-2, 2)
            local offsetY = math.random(-1, 1)
            GlitchR.Position = UDim2.new(0, offsetX, 0, offsetY)
            GlitchG.Position = UDim2.new(0, -offsetX, 0, -offsetY)
            task.wait(0.05)
            GlitchR.Position = UDim2.new(0, 0, 0, 0)
            GlitchG.Position = UDim2.new(0, 0, 0, 0)
        end
        if math.random() > 0.85 then
            local glitched = ""
            for j = 1, #originalText do
                if math.random() > 0.85 then
                    glitched = glitched .. glitchChars[math.random(1, #glitchChars)]
                else
                    glitched = glitched .. originalText:sub(j, j)
                end
            end
            LogTitle.Text = glitched
            GlitchR.Text = glitched
            GlitchG.Text = glitched
            LogTitle.TextColor3 = Config.Theme.HackerGreen
            task.wait(0.05)
            LogTitle.Text = originalText
            GlitchR.Text = originalText
            GlitchG.Text = originalText
            LogTitle.TextColor3 = Config.Theme.Text
        end
        local shift = math.sin(tick() * 3) * 0.3 + 0.7
        LogTitle.TextColor3 = Color3.new(shift, 1, shift)
        task.wait(0.1)
    end
end)

task.spawn(function()
    while LoginFrame.Parent and LoginFrame.Visible do
        if math.random() > 0.95 then
            GlitchOverlay.BackgroundTransparency = 0.9
            task.wait(0.03)
            GlitchOverlay.BackgroundTransparency = 1
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    GlitchSound:Play()
    for i = 1, 10 do
        LoginFrame.BackgroundTransparency = math.random(0, 100) / 100
        LoginFrame.Size = UDim2.new(0, math.random(200, 300), 0, math.random(250, 350))
        LoginFrame.Position = UDim2.new(0.5, math.random(-150, -110), 0.5, math.random(-175, -125))
        task.wait(0.03)
    end
    LoginFrame.BackgroundTransparency = 0
    LoginFrame.Size = UDim2.new(0, 260, 0, 300)
    LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
    task.wait(0.2)
    for i = 1, 0, -0.2 do
        LogLogo.ImageTransparency = i
        LogTitle.TextTransparency = i
        GlitchR.TextTransparency = 0.7
        GlitchG.TextTransparency = 0.7
        task.wait(0.05)
    end
    task.wait(0.1)
    for i = 1, 0, -0.25 do
        UserBox.BackgroundTransparency = i
        UserBox.TextTransparency = i
        UserStroke.Transparency = i
        task.wait(0.04)
    end
    for i = 1, 0, -0.25 do
        KeyBox.BackgroundTransparency = i
        KeyBox.TextTransparency = i
        KeyStroke.Transparency = i
        task.wait(0.04)
    end
    for i = 1, 0, -0.2 do
        LogBtn.BackgroundTransparency = i
        LogBtn.TextTransparency = i
        LogBtn.Size = UDim2.new(0.85 + (i * 0.1), 0, 0, 40 + (i * 10))
        task.wait(0.03)
    end
    LogBtn.Size = UDim2.new(0.85, 0, 0, 40)
end)

local function ExitAnimation()
    LoginSound:Play()
    for i = 1, 8 do
        GlitchOverlay.BackgroundTransparency = 0.8 + (i * 0.02)
        LoginFrame.Size = UDim2.new(0, 260 + math.random(-5, 5), 0, 300 + math.random(-5, 5))
        task.wait(0.04)
    end
    for i = 0, 1, 0.15 do
        LoginFrame.BackgroundTransparency = i
        LogLogo.ImageTransparency = i
        LogTitle.TextTransparency = i
        GlitchR.TextTransparency = 1
        GlitchG.TextTransparency = 1
        UserBox.BackgroundTransparency = i
        UserBox.TextTransparency = i
        KeyBox.BackgroundTransparency = i
        KeyBox.TextTransparency = i
        LogBtn.BackgroundTransparency = i
        LogBtn.TextTransparency = i
        UserStroke.Transparency = i
        KeyStroke.Transparency = i
        LoginFrame.Position = UDim2.new(0.5, -130 + math.random(-3, 3), 0.5, -150 + math.random(-3, 3))
        task.wait(0.05)
    end
    task.wait(0.2)
    LoginFrame.Visible = false
end

-- ==================== LOGIN LOGIC ====================
LogBtn.MouseButton1Click:Connect(function()
    local username = UserBox.Text
    local key = KeyBox.Text
    
    if username == "" or key == "" then
        ErrorSound:Play()
        LogBtn.Text = "EMPTY FIELD"
        LogBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        task.wait(1)
        LogBtn.Text = "AUTHENTICATE"
        LogBtn.BackgroundColor3 = Color3.new(1,1,1)
        return
    end
    
    local checkUsername = string.upper(username)
    
    if not VIP_ACCESS[checkUsername] then
        ErrorSound:Play()
        LogBtn.Text = "INVALID LOGIN"
        LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        task.wait(1)
        LogBtn.Text = "AUTHENTICATE"
        LogBtn.BackgroundColor3 = Color3.new(1,1,1)
        UserBox.Text = ""
        KeyBox.Text = ""
        return
    end
    
    if VIP_ACCESS[checkUsername] ~= key then
        ErrorSound:Play()
        LogBtn.Text = "INVALID LOGIN"
        LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        task.wait(1)
        LogBtn.Text = "AUTHENTICATE"
        LogBtn.BackgroundColor3 = Color3.new(1,1,1)
        KeyBox.Text = ""
        return
    end
    
    -- Validasi sukses
    local vipNumber = string.match(checkUsername, "%d+") or "0"
    
    -- Daftarkan device ke Firebase
    local regSuccess, regError = RegisterDevice(checkUsername)
    
    if not regSuccess then
        if regError == "MAX_DEVICES" then
            ErrorSound:Play()
            LogBtn.Text = "DEVICE LIMIT (2)"
            LogBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
            task.wait(2)
            LogBtn.Text = "AUTHENTICATE"
            LogBtn.BackgroundColor3 = Color3.new(1,1,1)
            return
        else
            warn(">> [ERROR] Gagal mendaftarkan device ke Firebase. Cek koneksi.")
            -- Tetap lanjutkan? Terserah, bisa lanjut atau tidak.
        end
    else
        print(">> [SUKSES] Device terdaftar untuk " .. checkUsername)
    end
    
    -- Tampilkan loading
    GlitchSound:Play()
    LogBtn.Text = "VERIFYING..."
    LogBtn.BackgroundColor3 = Config.Theme.HackerGreen
    LogBtn.TextColor3 = Color3.new(0,0,0)
    task.wait(0.3)
    
    _G.VIP_CREDENTIALS = {
        Username = checkUsername,
        Key = key,
        Slot = vipNumber,
        Timestamp = os.time()
    }
    
    -- Load main GUI
    task.spawn(function()
        task.wait(0.5)
        ExitAnimation()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/NsSiLmtj"))() -- GANTI DENGAN URL MAIN GUI ANDA
        end)
        if not success then
            warn(">> [ERROR] Failed to load main GUI:", err)
            ErrorSound:Play()
            LoginFrame.Visible = true
        end
    end)
end)

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

print(">> [ANONYMOUS9x VIP Login Panel] Loaded dengan Auto-Login via Firebase (max 2 devices)")
print(">> [INFO] Device ID: " .. DEVICE_ID)
print(">> [INFO] Jika pertama kali, silakan login. Jika sudah pernah, akan auto-login.")

--[[ ANONYMOUS9x VIP - LOGIN PANEL (PREMIUM HACKER EDITION)
GitHub: https://github.com/Anonymous9x/Anonymous9x-VIP-Login
INTEGRATED WITH GITHUB HWID SYSTEM
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RBXAnalytics = game:GetService("RbxAnalyticsService")

-- ==================== [ SISTEM GITHUB - JANGAN DIUBAH ] ====================
local GITHUB_CONFIG = {
    Token = "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",
    Owner = "Anonymous9x-oss",
    Repo = "DeviceVIP",
    Path = "device.json",
    SaveFile = "9x_vip_license.json"
}

local API_URL = string.format("https://api.github.com/repos/%s/%s/contents/%s", GITHUB_CONFIG.Owner, GITHUB_CONFIG.Repo, GITHUB_CONFIG.Path)
local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local function base64decode(data)
    data = string.gsub(data, '[^'..b64chars..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b64chars:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local function base64encode(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte() for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end local c=0 for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end return b64chars:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local function GetGitHubDB()
    local res = request({
        Url = API_URL .. "?t=" .. os.time(),
        Method = "GET",
        Headers = {["Authorization"] = "token " .. GITHUB_CONFIG.Token}
    })
    if res.Success then
        local data = HttpService:JSONDecode(res.Body)
        return data.sha, HttpService:JSONDecode(base64decode(data.content))
    end
    return nil, nil
end

local function UpdateGitHubDB(newTable, sha)
    request({
        Url = API_URL, Method = "PUT",
        Headers = {["Authorization"] = "token " .. GITHUB_CONFIG.Token, ["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            message = "Login: " .. LocalPlayer.Name,
            content = base64encode(HttpService:JSONEncode(newTable)),
            sha = sha
        })
    })
end

-- ==================== [ MULAI SCRIPT ASLI TUAN ] ====================

-- Clean up existing
if PlayerGui:FindFirstChild("HorizontalHub") then
    PlayerGui.HorizontalHub:Destroy()
end

-- Configuration
local Config = {
    Title = "ANONYMOUS9x VIP",
    LogoID = "rbxassetid://97269958324726",
    Theme = {
        Background = Color3.fromRGB(8, 8, 8),
        Card = Color3.fromRGB(15, 15, 15),
        Border = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(255, 255, 255),
        HackerGreen = Color3.fromRGB(0, 255, 100) -- Neon green hacker color
    }
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "HorizontalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- SOUND EFFECTS (Premium Unique Sounds)
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
LoginFrame.BackgroundTransparency = 1
LoginFrame.ClipsDescendants = true
LoginFrame.Visible = false -- Kita set false dulu untuk Entrance Anim
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = AddStroke(LoginFrame, 2)

-- SCAN LINE OVERLAY
local ScanLine = Instance.new("Frame", LoginFrame)
ScanLine.Size = UDim2.new(1, 0, 0, 2)
ScanLine.Position = UDim2.new(0, 0, 0, 0)
ScanLine.BackgroundColor3 = Config.Theme.HackerGreen
ScanLine.BackgroundTransparency = 0.3
ScanLine.BorderSizePixel = 0
ScanLine.ZIndex = 10

-- GLITCH OVERLAY
local GlitchOverlay = Instance.new("Frame", LoginFrame)
GlitchOverlay.Size = UDim2.new(1, 0, 1, 0)
GlitchOverlay.BackgroundColor3 = Config.Theme.HackerGreen
GlitchOverlay.BackgroundTransparency = 1
GlitchOverlay.BorderSizePixel = 0
GlitchOverlay.ZIndex = 9

-- Logo
local LogLogo = Instance.new("ImageLabel", LoginFrame)
LogLogo.Size = UDim2.new(0, 60, 0, 60)
LogLogo.Position = UDim2.new(0.5, -30, 0.1, 0)
LogLogo.Image = Config.LogoID
LogLogo.BackgroundTransparency = 1
LogLogo.ImageTransparency = 1

-- Title Container
local TitleContainer = Instance.new("Frame", LoginFrame)
TitleContainer.Size = UDim2.new(1, 0, 0, 25)
TitleContainer.Position = UDim2.new(0, 0, 0.3, 0)
TitleContainer.BackgroundTransparency = 1

-- Main Title
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

-- Glitch clone layers
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

-- Username Input
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

-- Key Input
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

-- Login Button
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

-- ==================== SEMUA ANIMASI ASLI TUAN ====================
task.spawn(function()
    while true do
        ScanLine.Position = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ScanLine, TweenInfo.new(2, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 0, 1, 0)}):Play()
        task.wait(2)
    end
end)

task.spawn(function()
    while true do
        TweenService:Create(MainStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Color = Config.Theme.HackerGreen, Thickness = 3}):Play()
        task.wait(0.8)
        TweenService:Create(MainStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Color = Config.Theme.Border, Thickness = 2}):Play()
        task.wait(0.8)
    end
end)

task.spawn(function()
    local originalText = "ANONYMOUS9x VIP"; local glitchChars = {"█", "▓", "▒", "░", "⌘", "◊", "◘", "●"}
    while true do
        if math.random() > 0.7 then
            local offsetX = math.random(-2, 2); local offsetY = math.random(-1, 1)
            GlitchR.Position = UDim2.new(0, offsetX, 0, offsetY); GlitchG.Position = UDim2.new(0, -offsetX, 0, -offsetY)
            task.wait(0.05); GlitchR.Position = UDim2.new(0, 0, 0, 0); GlitchG.Position = UDim2.new(0, 0, 0, 0)
        end
        if math.random() > 0.85 then
            local glitched = ""
            for j = 1, #originalText do glitched = glitched .. (math.random() > 0.85 and glitchChars[math.random(1, #glitchChars)] or originalText:sub(j, j)) end
            LogTitle.Text = glitched; GlitchR.Text = glitched; GlitchG.Text = glitched; LogTitle.TextColor3 = Config.Theme.HackerGreen
            task.wait(0.05); LogTitle.Text = originalText; GlitchR.Text = originalText; GlitchG.Text = originalText; LogTitle.TextColor3 = Config.Theme.Text
        end
        task.wait(0.1)
    end
end)

local function ShowEntrance()
    LoginFrame.Visible = true
    GlitchSound:Play()
    for i = 1, 10 do
        LoginFrame.BackgroundTransparency = math.random(0, 100) / 100
        LoginFrame.Size = UDim2.new(0, math.random(200, 300), 0, math.random(250, 350))
        LoginFrame.Position = UDim2.new(0.5, math.random(-150, -110), 0.5, math.random(-175, -125))
        task.wait(0.03)
    end
    LoginFrame.BackgroundTransparency = 0; LoginFrame.Size = UDim2.new(0, 260, 0, 300); LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
    task.wait(0.2)
    for i = 1, 0, -0.2 do LogLogo.ImageTransparency = i; LogTitle.TextTransparency = i; GlitchR.TextTransparency = 0.7; GlitchG.TextTransparency = 0.7; task.wait(0.05) end
    for i = 1, 0, -0.25 do UserBox.BackgroundTransparency = i; UserBox.TextTransparency = i; UserStroke.Transparency = i; task.wait(0.04) end
    for i = 1, 0, -0.25 do KeyBox.BackgroundTransparency = i; KeyBox.TextTransparency = i; KeyStroke.Transparency = i; task.wait(0.04) end
    for i = 1, 0, -0.2 do LogBtn.BackgroundTransparency = i; LogBtn.TextTransparency = i; task.wait(0.03) end
end

local function ExitAnimation()
    LoginSound:Play()
    for i = 1, 8 do
        GlitchOverlay.BackgroundTransparency = 0.8 + (i * 0.02)
        LoginFrame.Size = UDim2.new(0, 260 + math.random(-5, 5), 0, 300 + math.random(-5, 5))
        task.wait(0.04)
    end
    for i = 0, 1, 0.15 do
        LoginFrame.BackgroundTransparency = i; LogLogo.ImageTransparency = i; LogTitle.TextTransparency = i;
        UserBox.BackgroundTransparency = i; KeyBox.BackgroundTransparency = i; LogBtn.BackgroundTransparency = i
        task.wait(0.05)
    end
    LoginFrame.Visible = false
end

-- ==================== [ LOGIC PENDAFTARAN & LOGIN ] ====================

local function FinalGrantAccess(user, key)
    -- ISI CREDENTIALS BIAR SCRIPT UTAMA GAK ERROR
    _G.VIP_CREDENTIALS = {
        Username = user,
        Key = key,
        Slot = string.match(user, "%d+") or "0",
        Timestamp = os.time()
    }
    ExitAnimation()
    
    -- LINK GITHUB RAW UTAMA (FIXED ALAMATNYA)
    local ScriptUrl = "https://raw.githubusercontent.com/Anonymous9x-oss/Anonymous9xOwner/refs/heads/main/Anonymous9xOwner.lua"
    
    -- Ambil Script Utama dengan Anti-Cache agar update langsung masuk
    local success, content = pcall(function() return game:HttpGet(ScriptUrl .. "?t="..os.time()) end)
    
    if success and content ~= "" and content ~= "404: Not Found" then
        loadstring(content)()
    else
        warn(">> [ANONYMOUS9x ERROR]: Gagal memuat script utama! Cek koneksi atau link GitHub Raw Tuan.")
    end
end

LogBtn.MouseButton1Click:Connect(function()
    local user = string.upper(UserBox.Text)
    local key = KeyBox.Text
    local hwid = RBXAnalytics:GetClientId()

    if user == "" or key == "" then
        ErrorSound:Play(); LogBtn.Text = "EMPTY FIELD"; task.wait(1); LogBtn.Text = "AUTHENTICATE"; return
    end

    LogBtn.Text = "VERIFYING..."; LogBtn.BackgroundColor3 = Config.Theme.HackerGreen
    
    local sha, db = GetGitHubDB()
    if not db then LogBtn.Text = "DB ERROR"; task.wait(1); LogBtn.Text = "AUTHENTICATE"; return end

    local users = db["v1.0"].users
    if users[user] and users[user].key == key then
        local userData = users[user]
        local isReg = false
        for _, id in pairs(userData.hwids) do if id == hwid then isReg = true end end

        if isReg or #userData.hwids < db.metadata.maxDevices then
            if not isReg then 
                table.insert(userData.hwids, hwid)
                UpdateGitHubDB(db, sha)
            end
            writefile(GITHUB_CONFIG.SaveFile, HttpService:JSONEncode({user = user, key = key}))
            FinalGrantAccess(user, key)
        else
            ErrorSound:Play(); LogBtn.Text = "MAX DEVICES"; task.wait(1.5); LogBtn.Text = "AUTHENTICATE"
        end
    else
        ErrorSound:Play(); LogBtn.Text = "INVALID LOGIN"; task.wait(1.5); LogBtn.Text = "AUTHENTICATE"
    end
end)

-- AUTO LOGIN CHECK
task.spawn(function()
    if isfile(GITHUB_CONFIG.SaveFile) then
        local data = HttpService:JSONDecode(readfile(GITHUB_CONFIG.SaveFile))
        local sha, db = GetGitHubDB()
        if db and db["v1.0"].users[data.user] and db["v1.0"].users[data.user].key == data.key then
            local hwid = RBXAnalytics:GetClientId()
            for _, id in pairs(db["v1.0"].users[data.user].hwids) do
                if id == hwid then
                    FinalGrantAccess(data.user, data.key)
                    return
                end
            end
        end
    end
    ShowEntrance() -- Munculkan UI Hacker Asli Tuan
end)

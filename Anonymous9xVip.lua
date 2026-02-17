--[[ 
    ANONYMOUS9x VIP - LOGIN PANEL (FULL HACKER VERSION - FIXED)
    SEMUA ANIMASI & SOUND UTUH - LOGIC GITHUB FIXED
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RBXAnalytics = game:GetService("RbxAnalyticsService")

-- ==================== [ GITHUB CONFIGURATION ] ====================
local GITHUB_CONFIG = {
    Token = "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", -- Pastikan sudah "Allow Secret"
    Owner = "Anonymous9x-oss",
    Repo = "DeviceVIP",
    Path = "device.json",
    SaveFile = "9x_vip_license.json"
}

-- Link Script Utama Tuan (RAW)
local MAIN_GUI_URL = "https://raw.githubusercontent.com/Anonymous9x-oss/Anonymous9xOwner/refs/heads/main/Anonymous9xOwner.lua"

local API_URL = string.format("https://api.github.com/repos/%s/%s/contents/%s", GITHUB_CONFIG.Owner, GITHUB_CONFIG.Repo, GITHUB_CONFIG.Path)
local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- Logic GitHub Internal (Base64 & DB)
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
            message = "Access Log: " .. LocalPlayer.Name,
            content = base64encode(HttpService:JSONEncode(newTable)),
            sha = sha
        })
    })
end

-- ==================== [ UI INITIALIZATION ] ====================
if PlayerGui:FindFirstChild("HorizontalHub") then PlayerGui.HorizontalHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "HorizontalHub"
ScreenGui.ResetOnSpawn = false

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

-- Sound Effects
local SoundContainer = Instance.new("Folder", ScreenGui)
local GlitchSound = Instance.new("Sound", SoundContainer)
GlitchSound.SoundId = "rbxassetid://9086208751"; GlitchSound.Volume = 0.35
local LoginSound = Instance.new("Sound", SoundContainer)
LoginSound.SoundId = "rbxassetid://9114397232"; LoginSound.Volume = 0.4
local ErrorSound = Instance.new("Sound", SoundContainer)
ErrorSound.SoundId = "rbxassetid://9112879730"; ErrorSound.Volume = 0.35

-- Main Login Frame
local LoginFrame = Instance.new("Frame", ScreenGui)
LoginFrame.Size = UDim2.new(0, 260, 0, 300)
LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
LoginFrame.BackgroundColor3 = Config.Theme.Background
LoginFrame.ClipsDescendants = true
LoginFrame.Visible = false
Instance.new("UICorner", LoginFrame)
local MainStroke = Instance.new("UIStroke", LoginFrame)
MainStroke.Thickness = 2; MainStroke.Color = Config.Theme.Border

-- Scanline & Logo
local ScanLine = Instance.new("Frame", LoginFrame)
ScanLine.Size = UDim2.new(1, 0, 0, 2); ScanLine.BackgroundColor3 = Config.Theme.HackerGreen; ScanLine.ZIndex = 10
local LogLogo = Instance.new("ImageLabel", LoginFrame)
LogLogo.Size = UDim2.new(0, 60, 0, 60); LogLogo.Position = UDim2.new(0.5, -30, 0.1, 0); LogLogo.Image = Config.LogoID; LogLogo.BackgroundTransparency = 1

-- Title Hacker Glitch
local TitleContainer = Instance.new("Frame", LoginFrame)
TitleContainer.Size = UDim2.new(1, 0, 0, 25); TitleContainer.Position = UDim2.new(0, 0, 0.3, 0); TitleContainer.BackgroundTransparency = 1
local LogTitle = Instance.new("TextLabel", TitleContainer)
LogTitle.Text = Config.Title; LogTitle.Size = UDim2.new(1, 0, 1, 0); LogTitle.TextColor3 = Config.Theme.Text; LogTitle.Font = Enum.Font.GothamBlack; LogTitle.TextSize = 16; LogTitle.BackgroundTransparency = 1
local GlitchR = LogTitle:Clone(); GlitchR.Parent = TitleContainer; GlitchR.TextColor3 = Color3.fromRGB(255, 0, 0); GlitchR.TextTransparency = 0.7; GlitchR.ZIndex = 1
local GlitchG = LogTitle:Clone(); GlitchG.Parent = TitleContainer; GlitchG.TextColor3 = Config.Theme.HackerGreen; GlitchG.TextTransparency = 0.7; GlitchG.ZIndex = 2

-- Inputs
local UserBox = Instance.new("TextBox", LoginFrame)
UserBox.Size = UDim2.new(0.85, 0, 0, 35); UserBox.Position = UDim2.new(0.075, 0, 0.5, 0); UserBox.PlaceholderText = "Input user"; UserBox.BackgroundColor3 = Config.Theme.Card; UserBox.TextColor3 = Color3.new(1,1,1); UserBox.Font = Enum.Font.GothamBold; UserBox.TextSize = 12; Instance.new("UICorner", UserBox)
local KeyBox = Instance.new("TextBox", LoginFrame)
KeyBox.Size = UDim2.new(0.85, 0, 0, 35); KeyBox.Position = UDim2.new(0.075, 0, 0.67, 0); KeyBox.PlaceholderText = "Input key"; KeyBox.BackgroundColor3 = Config.Theme.Card; KeyBox.TextColor3 = Color3.new(1,1,1); KeyBox.Font = Enum.Font.GothamBold; KeyBox.TextSize = 12; Instance.new("UICorner", KeyBox)
local LogBtn = Instance.new("TextButton", LoginFrame)
LogBtn.Size = UDim2.new(0.85, 0, 0, 40); LogBtn.Position = UDim2.new(0.075, 0, 0.84, 0); LogBtn.BackgroundColor3 = Color3.new(1,1,1); LogBtn.Text = "AUTHENTICATE"; LogBtn.TextColor3 = Color3.new(0,0,0); LogBtn.Font = Enum.Font.GothamBlack; LogBtn.TextSize = 13; Instance.new("UICorner", LogBtn)

-- ==================== [ ANIMATIONS ] ====================
task.spawn(function()
    while true do
        ScanLine.Position = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ScanLine, TweenInfo.new(2, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 0, 1, 0)}):Play()
        task.wait(2)
    end
end)

task.spawn(function()
    local originalText = Config.Title; local glitchChars = {"█", "▓", "▒", "░", "⌘", "◘"}
    while true do
        if math.random() > 0.8 then
            local glitched = ""
            for j = 1, #originalText do glitched = glitched .. (math.random() > 0.9 and glitchChars[math.random(1, #glitchChars)] or originalText:sub(j, j)) end
            LogTitle.Text = glitched; GlitchR.Text = glitched; GlitchG.Text = glitched
            task.wait(0.1); LogTitle.Text = originalText; GlitchR.Text = originalText; GlitchG.Text = originalText
        end
        task.wait(0.2)
    end
end)

local function ShowEntrance()
    LoginFrame.Visible = true; GlitchSound:Play()
    for i = 1, 10 do
        LoginFrame.BackgroundTransparency = math.random(0, 50) / 100
        LoginFrame.Position = UDim2.new(0.5, -130 + math.random(-5, 5), 0.5, -150 + math.random(-5, 5))
        task.wait(0.05)
    end
    LoginFrame.BackgroundTransparency = 0; LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
end

-- ==================== [ LOGIC FINAL FIX ] ====================
local function FinalGrantAccess(user, key)
    _G.VIP_CREDENTIALS = { Username = user, Key = key, Timestamp = os.time() }
    LoginSound:Play()
    
    -- Ambil Script Utama dengan Loadstring (FIX LINE 328/360)
    local success, content = pcall(function() 
        return game:HttpGet(MAIN_GUI_URL .. "?t=" .. os.time()) 
    end)
    
    if success and content ~= "" and not content:find("404") then
        ScreenGui:Destroy()
        task.wait(0.5)
        -- EKSEKUSI SCRIPT UTAMA
        local exec = loadstring(content)
        if exec then exec() else warn("Script Utama Error Syntax!") end
    else
        ErrorSound:Play(); LogBtn.Text = "FETCH ERROR"; task.wait(1.5); LogBtn.Text = "AUTHENTICATE"
    end
end

LogBtn.MouseButton1Click:Connect(function()
    local user = string.upper(UserBox.Text)
    local key = KeyBox.Text
    local hwid = RBXAnalytics:GetClientId()

    if user == "" or key == "" then ErrorSound:Play(); return end
    
    LogBtn.Text = "VERIFYING..."
    local sha, db = GetGitHubDB()
    
    if db and db["v1.0"].users[user] and db["v1.0"].users[user].key == key then
        local userData = db["v1.0"].users[user]
        local registeredHWID = false
        for _, id in pairs(userData.hwids) do if id == hwid then registeredHWID = true end end

        if registeredHWID or #userData.hwids < db.metadata.maxDevices then
            if not registeredHWID then 
                table.insert(userData.hwids, hwid)
                UpdateGitHubDB(db, sha)
            end
            writefile(GITHUB_CONFIG.SaveFile, HttpService:JSONEncode({user = user, key = key}))
            FinalGrantAccess(user, key)
        else
            ErrorSound:Play(); LogBtn.Text = "MAX DEVICES"; task.wait(1.5); LogBtn.Text = "AUTHENTICATE"
        end
    else
        ErrorSound:Play(); LogBtn.Text = "INVALID KEY"; task.wait(1.5); LogBtn.Text = "AUTHENTICATE"
    end
end)

ShowEntrance()

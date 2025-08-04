--== Boost FPS - ThienGonYT ==--
local language = "vi" -- "vi" = Tiếng Việt | "en" = English

local text = {
    vi = {
        fog = "Xóa Sương Mù",
        graphics = "Đồ Họa Thấp",
        night = "Nhìn Ban Đêm",
        on = "✅",
        off = "❌",
        setting = "Cài Đặt",
        language = "Ngôn Ngữ",
        logo = "ThienGonYT"
    },
    en = {
        fog = "Remove Fog",
        graphics = "Low Graphics",
        night = "Night Vision",
        on = "✅",
        off = "❌",
        setting = "Settings",
        language = "Language",
        logo = "ThienGonYT"
    }
}

local state = {
    fog = false,
    graphics = false,
    night = false
}

--== GUI ==--
local CoreGui = game:GetService("CoreGui")
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ThienGonYT_FPS"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0.5, -110, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Function: Add Toggle Button
local function addButton(name, posY, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.Text = text[language][name] .. ": " .. text[language].off

    btn.MouseButton1Click:Connect(function()
        state[name] = not state[name]
        btn.Text = text[language][name] .. ": " .. (state[name] and text[language].on or text[language].off)
        callback(state[name])
    end)

    return btn
end

--== Chức năng ==
-- Xóa sương mù
addButton("fog", 10, function(on)
    local lighting = game:GetService("Lighting")
    if on then
        lighting.FogEnd = 1e10
    else
        lighting.FogEnd = 1000
    end
end)

-- Đồ họa thấp (ko xóa hiệu ứng, ko tắt âm thanh)
addButton("graphics", 50, function(on)
    local lighting = game:GetService("Lighting")
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if on then
        lighting.GlobalShadows = false
        lighting.Brightness = 1
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterTransparency = 1
        end
    else
        lighting.GlobalShadows = true
        lighting.Brightness = 2
        if terrain then
            terrain.WaterWaveSize = 0.1
            terrain.WaterTransparency = 0.5
        end
    end
end)

-- Nhìn ban đêm
addButton("night", 90, function(on)
    local lighting = game:GetService("Lighting")
    if on then
        lighting.ClockTime = 14
    else
        lighting.ClockTime = 1
    end
end)

--== Ngôn ngữ ==--
local langBtn = Instance.new("TextButton", frame)
langBtn.Size = UDim2.new(1, -20, 0, 30)
langBtn.Position = UDim2.new(0, 10, 0, 140)
langBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
langBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
langBtn.TextScaled = true
langBtn.Font = Enum.Font.Gotham
langBtn.Text = text[language].language .. ": " .. (language == "vi" and "Tiếng Việt" or "English")
Instance.new("UICorner", langBtn).CornerRadius = UDim.new(0, 6)

langBtn.MouseButton1Click:Connect(function()
    language = (language == "vi") and "en" or "vi"
    langBtn.Text = text[language].language .. ": " .. (language == "vi" and "Tiếng Việt" or "English")
    for name, enabled in pairs(state) do
        for _, child in pairs(frame:GetChildren()) do
            if child:IsA("TextButton") and child.Text:find(text[language == "vi" and "en" or "vi"][name]) then
                child.Text = text[language][name] .. ": " .. (enabled and text[language].on or text[language].off)
            end
        end
    end
end)

--== Nút đóng + logo bật lại ==--
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(1, -20, 0, 30)
closeBtn.Position = UDim2.new(0, 10, 0, 175)
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "❌"
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0, 90, 0, 30)
logo.Position = UDim2.new(0, 20, 0.5, -15)
logo.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold
logo.Text = text[language].logo
logo.Visible = false
logo.Draggable = true
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    logo.Visible = true
end)

logo.MouseButton1Click:Connect(function()
    frame.Visible = true
    logo.Visible = false
end)

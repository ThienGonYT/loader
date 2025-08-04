--== Boost FPS Script with Language Setting - by ThienGonYT ==--

local guiName = "ThienGonYTFPS_GUI"
pcall(function() game.CoreGui[guiName]:Destroy() end)

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--== Ngôn ngữ hỗ trợ ==--
local language = "vi" -- vi = Tiếng Việt, en = English
local texts = {
	vi = {
		title = "☰ Tăng FPS - ThienGonYT",
		boost = "Tăng FPS",
		settings = "Cài Đặt",
		language = "Ngôn Ngữ",
		vietnamese = "Tiếng Việt",
		english = "English",
	},
	en = {
		title = "☰ Boost FPS - ThienGonYT",
		boost = "Boost FPS",
		settings = "Settings",
		language = "Language",
		vietnamese = "Vietnamese",
		english = "English",
	}
}

--== Tạo ScreenGui ==--
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = guiName
gui.ResetOnSpawn = false

--== Khung chính ==--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 220, 0, 160)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local uiCorner = Instance.new("UICorner", main)
uiCorner.CornerRadius = UDim.new(0, 10)

--== Tiêu đề ==--
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = texts[language].title
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.BackgroundTransparency = 1

--== Nút Boost FPS ==--
local boostBtn = Instance.new("TextButton", main)
boostBtn.Size = UDim2.new(1, -20, 0, 30)
boostBtn.Position = UDim2.new(0, 10, 0, 40)
boostBtn.Text = "✅ " .. texts[language].boost
boostBtn.Font = Enum.Font.SourceSans
boostBtn.TextSize = 16
boostBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
boostBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local boostOn = true

local function applyBoostFPS()
	local lighting = game:GetService("Lighting")
	lighting.FogEnd = 1e10
	lighting.GlobalShadows = false
	lighting.Brightness = 0
	if lighting:FindFirstChildOfClass("ColorCorrectionEffect") then lighting:FindFirstChildOfClass("ColorCorrectionEffect"):Destroy() end
	if lighting:FindFirstChildOfClass("BloomEffect") then lighting:FindFirstChildOfClass("BloomEffect"):Destroy() end
	if lighting:FindFirstChildOfClass("SunRaysEffect") then lighting:FindFirstChildOfClass("SunRaysEffect"):Destroy() end

	local terrain = workspace:FindFirstChildOfClass("Terrain")
	if terrain then
		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		terrain.WaterTransparency = 1
	end
end

boostBtn.MouseButton1Click:Connect(function()
	boostOn = not boostOn
	boostBtn.Text = (boostOn and "✅ " or "❌ ") .. texts[language].boost
	if boostOn then applyBoostFPS() end
end)

--== Nút Cài Đặt ==--
local settingsBtn = Instance.new("TextButton", main)
settingsBtn.Size = UDim2.new(1, -20, 0, 30)
settingsBtn.Position = UDim2.new(0, 10, 0, 80)
settingsBtn.Text = "⚙️ " .. texts[language].settings
settingsBtn.Font = Enum.Font.SourceSans
settingsBtn.TextSize = 16
settingsBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
settingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

--== Khung Cài Đặt ==--
local settingsFrame = Instance.new("Frame", main)
settingsFrame.Size = UDim2.new(1, -20, 0, 40)
settingsFrame.Position = UDim2.new(0, 10, 0, 120)
settingsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
settingsFrame.Visible = false
local corner = Instance.new("UICorner", settingsFrame)
corner.CornerRadius = UDim.new(0, 6)

local langBtn = Instance.new("TextButton", settingsFrame)
langBtn.Size = UDim2.new(1, 0, 1, 0)
langBtn.Text = "🌐 " .. texts[language].language .. ": " .. texts[language].vietnamese
langBtn.Font = Enum.Font.SourceSans
langBtn.TextSize = 15
langBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
langBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

settingsBtn.MouseButton1Click:Connect(function()
	settingsFrame.Visible = not settingsFrame.Visible
end)

langBtn.Parent = settingsFrame
langBtn.MouseButton1Click:Connect(function()
	language = (language == "vi" and "en" or "vi")
	-- Cập nhật giao diện
	title.Text = texts[language].title
	boostBtn.Text = (boostOn and "✅ " or "❌ ") .. texts[language].boost
	settingsBtn.Text = "⚙️ " .. texts[language].settings
	langBtn.Text = "🌐 " .. texts[language].language .. ": " .. (language == "vi" and texts.vi.vietnamese or texts.en.english)
end)

--== Logo bật lại menu ==--
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0, 100, 0, 30)
logo.Position = UDim2.new(0, 10, 1, -40)
logo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
logo.Text = "🇻🇳ThienGonYT🇻🇳"
logo.TextColor3 = Color3.fromRGB(0, 255, 127)
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 14
logo.Active = true
logo.Draggable = true
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 8)

logo.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

--== Tự động áp dụng Boost nếu bật ==
if boostOn then applyBoostFPS() end

--== MENU BOOST FPS - THIENGONYT ==--

local uis = game:GetService("UserInputService")
local lp = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "ThienGonYT_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 250)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "⚙️ Boost FPS Menu"
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 2)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 0.5, 0.5)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20

local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0, 100, 0, 30)
logo.Position = UDim2.new(0, 10, 0.6, 0)
logo.Text = "📌 ThienGonYT"
logo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.SourceSansBold
logo.TextSize = 16
logo.Visible = false
logo.Draggable = true

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	logo.Visible = true
end)

logo.MouseButton1Click:Connect(function()
	frame.Visible = true
	logo.Visible = false
end)

-- Khung nút
local holder = Instance.new("Frame", frame)
holder.Position = UDim2.new(0, 10, 0, 40)
holder.Size = UDim2.new(1, -20, 1, -50)
holder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", holder)
layout.Padding = UDim.new(0, 6)

-- Tạo nút
local function createButton(text, parent, toggleVar, action)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.Text = text .. " ❌"
	btn.Parent = parent

	btn.MouseButton1Click:Connect(function()
		_G[toggleVar] = not _G[toggleVar]
		btn.Text = text .. " " .. (_G[toggleVar] and "✅" or "❌")
		action(_G[toggleVar])
	end)
end

-- Biến toggle
_G.BOOST = false
_G.FOG = false
_G.SOUND = false
_G.EFFECT = false

-- ⚡ Boost FPS
createButton("⚡ Boost FPS", holder, "BOOST", function(on)
	if on then
		local lighting = game:GetService("Lighting")
		lighting.FogEnd = 100000
		lighting.Brightness = 0
		lighting.GlobalShadows = false

		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 1
		end
	end
end)

-- 🌫️ Xóa Sương Mù
createButton("🌫️ Xóa Sương Mù", holder, "FOG", function(on)
	if on then
		local lighting = game:GetService("Lighting")
		lighting.FogStart = 0
		lighting.FogEnd = 999999
	end
end)

-- 🔇 Tắt Âm Thanh
createButton("🔇 Tắt Âm", holder, "SOUND", function(on)
	for _, s in pairs(workspace:GetDescendants()) do
		if s:IsA("Sound") then
			s.Playing = not on
		end
	end
end)

-- 💨 Xóa Hiệu Ứng
createButton("💨 Xóa Hiệu Ứng", holder, "EFFECT", function(on)
	if on then
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
				v.Enabled = false
			end
		end
	end
end)

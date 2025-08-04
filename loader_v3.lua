--== LOADER V3 - BOOST FPS CHO MÁY YẾU ✅❌ ==--

local player = game.Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ThienGonYT_BoostFPS"
gui.ResetOnSpawn = false

-- Frame menu
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Nút đóng
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18

-- Logo bật lại
local logoBtn = Instance.new("TextButton", gui)
logoBtn.Size = UDim2.new(0, 50, 0, 50)
logoBtn.Position = UDim2.new(0, 10, 0, 10)
logoBtn.Text = "ThienGonYT"
logoBtn.TextScaled = true
logoBtn.Visible = false
logoBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
logoBtn.TextColor3 = Color3.new(1, 1, 1)
logoBtn.Draggable = true

logoBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	logoBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	logoBtn.Visible = true
end)

-- Nút Boost FPS ✅❌
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1, -10, 0, 40)
btn.Position = UDim2.new(0, 5, 0, 40)
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18
btn.Text = "Chế Độ Nhanh ❌"

local state = false

btn.MouseButton1Click:Connect(function()
	state = not state
	btn.Text = "Chế Độ Nhanh " .. (state and "✅" or "❌")

	local lighting = game:GetService("Lighting")
	local terrain = workspace:FindFirstChildOfClass("Terrain")

	if state then
		-- Boost FPS: tắt hiệu ứng, làm nhẹ
		lighting.GlobalShadows = false
		lighting.FogEnd = 1e10
		lighting.Brightness = 1
		lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 1
			pcall(function() terrain.Decorations = false end)
		end

		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Material == Enum.Material.Grass then
				v.Material = Enum.Material.SmoothPlastic
			end
			if v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Enabled = false
			end
			if v:IsA("Decal") then
				v.Transparency = 1
			end
		end
	else
		-- Khôi phục mặc định (tạm thời)
		lighting.GlobalShadows = true
		lighting.FogEnd = 1000
		lighting.Brightness = 2
	end
end)

--== BOOST FPS CHO MÁY YẾU - GIAO DIỆN H4x ==--

local CoreGui = game:GetService("CoreGui")
pcall(function() CoreGui:FindFirstChild("BoostFPSUI"):Destroy() end)

-- GUI H4x đơn giản
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoostFPSUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0, 10, 0.5, -50)
Frame.Size = UDim2.new(0, 160, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 6)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🎮 BOOST FPS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

local Button = Instance.new("TextButton", Frame)
Button.Position = UDim2.new(0, 10, 0, 40)
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Text = "BẬT CHẾ ĐỘ NHẸ"
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSans
Button.TextSize = 18

local btnCorner = Instance.new("UICorner", Button)
btnCorner.CornerRadius = UDim.new(0, 4)

-- Boost FPS Function
local boosted = false
Button.MouseButton1Click:Connect(function()
	if boosted then return end
	boosted = true
	Button.Text = "ĐÃ BẬT ✅"

	-- Boost FPS
	pcall(function()
		sethiddenproperty(game.Lighting, "Technology", Enum.Technology.Compatibility)
	end)

	local lighting = game:GetService("Lighting")
	local terrain = workspace:FindFirstChildOfClass("Terrain")

	lighting.GlobalShadows = false
	lighting.FogEnd = 1e10
	lighting.Brightness = 0
	lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

	if terrain then
		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		terrain.WaterTransparency = 1
	end

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.SmoothPlastic
			obj.Reflectance = 0
		elseif obj:IsA("Decal") or obj:IsA("Texture") then
			obj.Transparency = 1
		end
	end

	-- Tắt hiệu ứng
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Enabled = false
		elseif v:IsA("Explosion") then
			v:Destroy()
		end
	end
end)

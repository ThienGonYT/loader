--== ThienGonYT - Tối Ưu FPS Cho Máy Yếu ==--

local CoreGui = game:GetService("CoreGui")

-- Xoá nếu có sẵn
for _, name in ipairs({"FPS_Optimizer_GUI", "ThienGonYT_Logo"}) do
	local gui = CoreGui:FindFirstChild(name)
	if gui then gui:Destroy() end
end

-- GUI chính
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "FPS_Optimizer_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 180)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Nút Tắt
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "❌"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14

-- Giao diện logo nhỏ gọn
local logoGui = Instance.new("ScreenGui", CoreGui)
logoGui.Name = "ThienGonYT_Logo"

local logoBtn = Instance.new("TextButton")
logoBtn.Name = "LogoButton"
logoBtn.Size = UDim2.new(0, 50, 0, 50)
logoBtn.Position = UDim2.new(0, 20, 1, -70)
logoBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
logoBtn.Text = "⚡"
logoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
logoBtn.Font = Enum.Font.GothamBlack
logoBtn.TextSize = 20
logoBtn.AutoButtonColor = true
logoBtn.Draggable = true
logoBtn.Active = true
logoBtn.Visible = false
logoBtn.Parent = logoGui

-- Tắt/mở GUI
closeBtn.MouseButton1Click:Connect(function()
	gui.Enabled = false
	logoBtn.Visible = true
end)

logoBtn.MouseButton1Click:Connect(function()
	gui.Enabled = true
	logoBtn.Visible = false
end)

-- Tạo các nút chức năng
local function createButton(text, yPos, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Text = text
	local toggled = false

	btn.MouseButton1Click:Connect(function()
		toggled = not toggled
		callback(toggled)
		btn.Text = (toggled and "✅ ") .. text or text
		btn.BackgroundColor3 = toggled and Color3.fromRGB(35, 100, 35) or Color3.fromRGB(50, 50, 50)
	end)
end

-- ☁️ Xóa Sương Mù
createButton("☁️ Xóa Sương Mù", 35, function(on)
	local lighting = game:GetService("Lighting")
	if on then
		lighting.FogStart = 1e10
		lighting.FogEnd = 1e10
		lighting.GlobalShadows = false
	else
		lighting.FogStart = 0
		lighting.FogEnd = 1000
		lighting.GlobalShadows = true
	end
end)

-- 🧊 Giảm Đồ Họa
createButton("🧊 Giảm Đồ Họa", 80, function(on)
	if on then
		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 1
		end
		for _, v in ipairs(game:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
				v.Enabled = false
			elseif v:IsA("Decal") then
				v.Transparency = 1
			elseif v:IsA("SurfaceAppearance") then
				v:Destroy()
			end
		end
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
			end
		end
	end
end)

-- 🎥 Tắt Hiệu Ứng Camera
createButton("🎥 Tắt Hiệu Ứng Camera", 125, function(on)
	local lighting = game:GetService("Lighting")
	for _, v in ipairs(lighting:GetChildren()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("BloomEffect") then
			if on then
				v:Destroy()
			end
		end
	end
end)

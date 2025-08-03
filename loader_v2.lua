--== MENU TIẾNG VIỆT - H4x ĐƠN GIẢN - 99 ĐÊM TRONG RỪNG ==--

local UIS = game:GetService("UserInputService")
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "H4xSimpleGui"
gui.ResetOnSpawn = false

local toggleKey = Enum.KeyCode.K
local visible = true

local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Size = UDim2.new(0, 400, 0, 420)
frame.Position = UDim2.new(0.5, -200, 0.5, -210)
frame.Active = true
frame.Draggable = true
frame.Visible = visible

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(0, 200, 200)

local title = Instance.new("TextLabel", frame)
title.Text = "📜 MENU 99 ĐÊM TRONG RỪNG"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local close = Instance.new("TextButton", frame)
close.Text = "X"
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -40, 0, 0)
close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)

local function createButton(name, callback)
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.Text = name
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	Instance.new("UIStroke", btn).Color = Color3.fromRGB(0, 200, 200)
	btn.MouseButton1Click:Connect(callback)
end

--== CHỨC NĂNG ==--

local autoChop = false
createButton("🌲 Auto chặt cây", function()
	autoChop = not autoChop
	if autoChop then
		task.spawn(function()
			while autoChop do
				for _, tree in pairs(workspace:GetDescendants()) do
					if tree.Name == "Tree" and tree:FindFirstChild("Hitbox") then
						firetouchinterest(hrp, tree.Hitbox, 0)
						task.wait(0.1)
						firetouchinterest(hrp, tree.Hitbox, 1)
					end
				end
				task.wait(1)
			end
		end)
	end
end)

local autoPlant = false
createButton("🌱 Auto trồng cây", function()
	autoPlant = not autoPlant
	if autoPlant then
		task.spawn(function()
			while autoPlant do
				if game.ReplicatedStorage:FindFirstChild("RemoteEvents") and game.ReplicatedStorage.RemoteEvents:FindFirstChild("Plant") then
					game.ReplicatedStorage.RemoteEvents.Plant:FireServer()
				end
				task.wait(3)
			end
		end)
	end
end)

local killAura = false
createButton("🗡️ Kill Aura", function()
	killAura = not killAura
	if killAura then
		task.spawn(function()
			while killAura do
				for _, player in pairs(game.Players:GetPlayers()) do
					if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						if (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude <= 20 then
							game.ReplicatedStorage.RemoteEvents.Attack:FireServer(player.Character)
						end
					end
				end
				task.wait(0.5)
			end
		end)
	end
end)

createButton("👶 Teleport đến Kid", function()
	for _, kid in pairs(workspace:GetDescendants()) do
		if kid.Name == "Kid" and kid:IsA("Model") and kid:FindFirstChild("HumanoidRootPart") then
			hrp.CFrame = kid.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
			break
		end
	end
end)

createButton("🧲 Bring Kid về", function()
	for _, kid in pairs(workspace:GetDescendants()) do
		if kid.Name == "Kid" and kid:IsA("Model") and kid:FindFirstChild("HumanoidRootPart") then
			kid.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
		end
	end
end)

-- Bring Item (các model có tên: Gear, Fuel, Food, Gun, Armor, Healing)
local bringList = {"Gear", "Fuel", "Healing", "Food", "Gun", "Armor"}
for _, name in pairs(bringList) do
	createButton("📦 Bring " .. name, function()
		for _, item in pairs(workspace:GetDescendants()) do
			if item.Name == name and item:IsA("Model") and item:FindFirstChild("PrimaryPart") then
				item:SetPrimaryPartCFrame(hrp.CFrame + Vector3.new(0, 3, 0))
			end
		end
	end)
end

-- Boost FPS
createButton("🚀 Boost FPS", function()
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		end
	end
	sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
end)

-- Toggle menu bằng phím K
UIS.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == toggleKey then
		frame.Visible = not frame.Visible
	end
end)

-- Auto update scroll
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

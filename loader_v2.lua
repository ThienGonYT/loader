--== MENU TIẾNG VIỆT - 99 ĐÊM ==--
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Tạo GUI
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "Menu99Dem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 420)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Text = "☾ MENU 99 ĐÊM ☽"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local y = 40
local function createBtn(text, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    y = y + 35
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

--=== CHỨC NĂNG ===--

-- Auto chặt cây
local autoChop = false
createBtn("🪓 Auto Chặt Cây", function()
    autoChop = not autoChop
    task.spawn(function()
        while autoChop and task.wait(1) do
            for _, t in pairs(workspace:GetDescendants()) do
                if t.Name == "Tree" and t:FindFirstChild("Hitbox") then
                    firetouchinterest(hrp, t.Hitbox, 0)
                    task.wait(0.1)
                    firetouchinterest(hrp, t.Hitbox, 1)
                end
            end
        end
    end)
end)

-- Auto trồng cây
local autoPlant = false
createBtn("🌱 Auto Trồng Cây", function()
    autoPlant = not autoPlant
    task.spawn(function()
        while autoPlant and task.wait(2) do
            local plantEvent = game.ReplicatedStorage:FindFirstChild("PlantTree")
            if plantEvent then
                plantEvent:FireServer()
            end
        end
    end)
end)

-- Kill Aura
local killAura = false
createBtn("⚔️ Kill Aura", function()
    killAura = not killAura
    task.spawn(function()
        while killAura and task.wait(0.2) do
            for _, e in pairs(workspace:GetDescendants()) do
                if e.Name == "Enemy" and e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") then
                    if (e.HumanoidRootPart.Position - hrp.Position).Magnitude < 20 then
                        local atk = game.ReplicatedStorage:FindFirstChild("AttackEvent")
                        if atk then atk:FireServer(e) end
                    end
                end
            end
        end
    end)
end)

-- TP đến vật → lấy → về
local function tpToGrab(namePart)
    local old = hrp.Position
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(namePart:lower()) and (obj:IsA("Tool") or obj:IsA("Model")) then
            local part = obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
            if part then
                hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                task.wait(1.5)
                hrp.CFrame = CFrame.new(old)
                break
            end
        end
    end
end

-- TP đến Kid rồi về
createBtn("👶 Đến Kid rồi quay về", function()
    local old = hrp.Position
    for _, kid in pairs(workspace:GetDescendants()) do
        if kid.Name == "Kid" and kid:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = kid.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
            task.wait(2)
            hrp.CFrame = CFrame.new(old)
            break
        end
    end
end)

createBtn("⚙️ Lấy Gear", function() tpToGrab("Gear") end)
createBtn("🔥 Lấy Fuel", function() tpToGrab("Fuel") end)
createBtn("💊 Lấy Healing", function() tpToGrab("Heal") end)
createBtn("🍗 Lấy Food", function() tpToGrab("Food") end)
createBtn("🔫 Lấy Súng", function() tpToGrab("Gun") end)
createBtn("🛡️ Lấy Giáp", function() tpToGrab("Armor") end)

-- ⚡ Chế Độ Nhanh (Tăng FPS)
createBtn("⚡ Chế Độ Nhanh", function()
	local lighting = game:GetService("Lighting")

	-- Xóa các hiệu ứng ánh sáng
	for _, v in pairs(lighting:GetChildren()) do
		if v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") then
			v:Destroy()
		end
	end

	-- Tắt sương mù, bóng đổ, ánh sáng
	lighting.FogEnd = 1e10
	lighting.GlobalShadows = false
	lighting.Brightness = 0

	-- Giảm chi tiết vật thể
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v:Destroy()
		end
	end

	-- Tắt hiệu ứng địa hình
	if workspace:FindFirstChildOfClass("Terrain") then
		local terrain = workspace.Terrain
		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		terrain.WaterTransparency = 1
	end

	-- Đặt thời gian ban ngày
	pcall(function() lighting.ClockTime = 14 end)

	-- Giảm chất lượng hiển thị
	pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)

	print("⚡ Đã bật chế độ nhanh!")
end)

-- Phím M để bật/tắt menu
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.M then
        frame.Visible = not frame.Visible
    end
end)

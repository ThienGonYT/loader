--== Chế Độ Nhanh - Boost FPS Cho Máy Yếu ==--

local lighting = game:GetService("Lighting")
local terrain = workspace:FindFirstChildOfClass("Terrain")
local players = game:GetService("Players")

-- Xóa mây, bóng, hiệu ứng ánh sáng
lighting.GlobalShadows = false
lighting.FogEnd = 1e10
lighting.Brightness = 0
lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
lighting.Ambient = Color3.fromRGB(127,127,127)
lighting.EnvironmentDiffuseScale = 0
lighting.EnvironmentSpecularScale = 0

-- Giảm chất lượng terrain
if terrain then
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 1
end

-- Tắt hiệu ứng & phụ kiện nhân vật (trừ bạn)
for _, plr in pairs(players:GetPlayers()) do
    if plr ~= players.LocalPlayer then
        if plr.Character then
            for _, v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.Transparency < 1 then
                    v.Transparency = 1
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
        end
    end
end

-- Giảm đồ vật xung quanh
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsDescendantOf(players.LocalPlayer.Character) then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
    elseif v:IsA("Decal") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Enabled = false
    end
end

-- Cố định FPS nếu cần
setfpscap = setfpscap or setfpscap2 or function() end
pcall(function() setfpscap(60) end)

print("✅ Chế Độ Nhanh đã được kích hoạt - Boost FPS thành công!")

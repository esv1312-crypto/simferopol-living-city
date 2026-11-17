-- Simferopol Railway Station: detailed stylized architectural pass.
-- Reference direction: pale stone Stalinist / neoclassical station,
-- long arcade, tall clock tower, courtyard fountain and cypress trees.
-- Front forecourt is toward -Z; platforms and tracks are toward +Z.

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local city = Workspace:WaitForChild("City")
local old = city:FindFirstChild("RailwayStation")
if old then old:Destroy() end

local station = Instance.new("Model")
station.Name = "RailwayStation"
station.Parent = city

local C = {
    stone = Color3.fromRGB(232, 224, 203),
    stoneLight = Color3.fromRGB(247, 240, 220),
    stoneShadow = Color3.fromRGB(190, 178, 151),
    roof = Color3.fromRGB(91, 105, 99),
    roofLight = Color3.fromRGB(119, 130, 119),
    glass = Color3.fromRGB(63, 100, 111),
    glassLight = Color3.fromRGB(119, 157, 164),
    metal = Color3.fromRGB(73, 79, 75),
    bronze = Color3.fromRGB(181, 145, 72),
    paving = Color3.fromRGB(157, 151, 136),
    pavingLight = Color3.fromRGB(190, 182, 163),
    water = Color3.fromRGB(71, 174, 196),
    green = Color3.fromRGB(37, 83, 55),
    hedge = Color3.fromRGB(48, 103, 61),
    wood = Color3.fromRGB(104, 68, 43),
}

local function part(name, size, pos, color, material, parent, shape)
    local p = Instance.new("Part")
    p.Name = name
    p.Anchored = true
    p.Size = size
    p.Position = pos
    p.Color = color
    p.Material = material or Enum.Material.SmoothPlastic
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    if shape then p.Shape = shape end
    p.Parent = parent or station
    return p
end

local function block(name, x, y, z, sx, sy, sz, color, material)
    return part(name, Vector3.new(sx, sy, sz), Vector3.new(x, y, z), color, material)
end

local function cylinder(name, x, y, z, diameter, height, color, material, parent)
    -- Roblox cylinder parts have their long axis along local X by default.
    -- Rotate them so columns, trunks and fountain elements stand vertically.
    local p = part(name, Vector3.new(diameter, height, diameter), Vector3.new(x, y, z),
        color, material, parent, Enum.PartType.Cylinder)
    p.Orientation = Vector3.new(0, 0, 90)
    return p
end

local function arch(name, cx, cy, z, radius, thickness, depth, color)
    -- A segmented semicircular arch: each short stone voussoir is tangent to the curve.
    for i = 0, 12 do
        local a = math.pi * i / 12
        local x = cx + math.cos(a) * radius
        local y = cy + math.sin(a) * radius
        local seg = part(name .. " voussoir",
            Vector3.new(thickness, math.max(1.5, radius * 0.28), depth),
            Vector3.new(x, y, z), color, Enum.Material.Sandstone)
        seg.Orientation = Vector3.new(0, 0, -math.deg(a))
    end
end

local function column(x, z, baseY, height, diameter)
    cylinder("Arcade column shaft", x, baseY + height/2, z, diameter, height, C.stoneLight, Enum.Material.Marble)
    cylinder("Column base", x, baseY + 0.65, z, diameter + 2.2, 1.3, C.stoneShadow, Enum.Material.Sandstone)
    cylinder("Column capital lower", x, baseY + height - 1.0, z, diameter + 2.5, 1.0, C.stoneLight, Enum.Material.Marble)
    cylinder("Column capital upper", x, baseY + height + 0.1, z, diameter + 3.1, 1.0, C.stoneLight, Enum.Material.Marble)
end

-- Broad paved forecourt and station/courtyard base.
block("Forecourt paving", 0, -0.55, -76, 270, 1, 115, C.paving, Enum.Material.Concrete)
block("Station base", 0, -0.05, 28, 190, 1.2, 95, C.stoneShadow, Enum.Material.Sandstone)
block("Courtyard paving", 8, 0.08, -27, 126, 0.35, 53, C.pavingLight, Enum.Material.Pavement)

-- Main station body: long, low, pale stone mass behind the arcade.
block("Main station body", 8, 16, 24, 164, 32, 48, C.stone, Enum.Material.Marble)
block("Main roof slab", 8, 32.7, 24, 170, 2.2, 53, C.roof, Enum.Material.Slate)
block("Roof cornice front", 8, 31, -1, 168, 2.0, 2.5, C.stoneLight, Enum.Material.Sandstone)
block("Roof cornice rear", 8, 31, 49, 168, 2.0, 2.5, C.stoneLight, Enum.Material.Sandstone)
block("Upper frieze", 8, 28.7, -0.4, 164, 2.0, 1.4, C.stoneLight, Enum.Material.Sandstone)
block("Lower plinth", 8, 2.2, -0.8, 164, 3.2, 2.2, C.stoneShadow, Enum.Material.Sandstone)

-- Side wings and their roof details.
for _, x in ipairs({-70, 86}) do
    block("Station side wing", x, 13, 23, 36, 26, 45, C.stone, Enum.Material.Marble)
    block("Side wing roof", x, 26.5, 23, 40, 1.8, 49, C.roof, Enum.Material.Slate)
    block("Side wing cornice", x, 25, -0.5, 38, 1.5, 2, C.stoneLight, Enum.Material.Sandstone)
end

-- Tall signature clock tower, placed at the left end of the arcade.
local tx, tz = -52, 5
block("Clock tower lower shaft", tx, 25, tz, 25, 50, 27, C.stoneLight, Enum.Material.Marble)
block("Tower base course", tx, 3, tz - 14, 29, 3, 2, C.stoneShadow, Enum.Material.Sandstone)
block("Tower crown cornice", tx, 49.5, tz, 31, 2.4, 32, C.stoneLight, Enum.Material.Sandstone)
block("Tower clock chamber", tx, 57, tz, 28, 13, 29, C.stoneLight, Enum.Material.Marble)
block("Tower upper ledge", tx, 64, tz, 32, 1.8, 33, C.stoneShadow, Enum.Material.Sandstone)
block("Tower lantern base", tx, 68, tz, 17, 7, 18, C.stoneLight, Enum.Material.Marble)
for _, dx in ipairs({-6, -2, 2, 6}) do
    block("Lantern opening", tx + dx, 68, tz - 9.3, 1.1, 4.5, 0.4, C.glass, Enum.Material.Glass)
end
block("Lantern roof", tx, 72, tz, 21, 1.4, 22, C.roof, Enum.Material.Slate)
local spire = part("Clock tower spire", Vector3.new(3, 11, 3), Vector3.new(tx, 78, tz), C.bronze, Enum.Material.Metal)
spire.Shape = Enum.PartType.Cylinder
spire.Orientation = Vector3.new(0, 0, 90)
block("Spire finial", tx, 84, tz, 1.2, 2, 1.2, C.bronze, Enum.Material.Metal)

-- Four visible clock faces with raised bezels and hands.
for _, side in ipairs({-1, 1}) do
    local z = tz + side * 14.85
    local face = cylinder("Clock dial", tx, 57, z, 10.5, 0.7, C.stoneLight, Enum.Material.Marble)
    face.Orientation = Vector3.new(90, 0, 0)
    local rim = cylinder("Clock dial bronze rim", tx, 57, z + side * 0.42, 12, 0.8, C.bronze, Enum.Material.Metal)
    rim.Orientation = Vector3.new(90, 0, 0)
    block("Clock hand vertical", tx, 58.3, z + side * 0.9, 0.35, 3.0, 0.25, C.metal, Enum.Material.Metal)
    block("Clock hand horizontal", tx + 1.0, 57, z + side * 0.9, 2.4, 0.35, 0.25, C.metal, Enum.Material.Metal)
end

-- Grand front arcade: columns, capitals and individually shaped stone arches.
local arcadeZ = -8
local firstX, bayWidth, bayCount = -28, 17, 7
for i = 0, bayCount do
    local x = firstX + i * bayWidth
    column(x, arcadeZ, 0.3, 17, 2.6)
end
for i = 0, bayCount - 1 do
    local cx = firstX + bayWidth * (i + 0.5)
    arch("Grand arcade arch", cx, 17.2, arcadeZ, bayWidth * 0.48, 2.0, 3.2, C.stoneLight)
end
block("Arcade roof beam", 31.5, 19.2, arcadeZ, 123, 2.8, 5.2, C.stoneLight, Enum.Material.Sandstone)
block("Arcade upper balustrade", 31.5, 22.5, arcadeZ, 123, 2.2, 3.2, C.stone, Enum.Material.Marble)
for x = -27, 90, 4 do
    block("Balustrade baluster", x, 22.5, arcadeZ - 1.8, 0.8, 2.0, 0.8, C.stoneLight, Enum.Material.Marble)
end
block("Arcade top cornice", 31.5, 24.2, arcadeZ, 128, 1.5, 6, C.stoneLight, Enum.Material.Sandstone)

-- Recessed windows and entrance doors on the wall behind the arcade.
for x = -60, 76, 14 do
    block("Tall recessed window", x, 12, -0.9, 6.2, 12, 0.65, C.glass, Enum.Material.Glass)
    block("Window left stone jamb", x - 3.5, 12, -1.35, 0.8, 14, 1.0, C.stoneLight, Enum.Material.Sandstone)
    block("Window right stone jamb", x + 3.5, 12, -1.35, 0.8, 14, 1.0, C.stoneLight, Enum.Material.Sandstone)
    block("Window lintel", x, 19.2, -1.35, 7.8, 1.0, 1.0, C.stoneLight, Enum.Material.Sandstone)
end
block("Main entrance dark recess", 27, 9, -1.5, 15, 18, 1.1, C.metal, Enum.Material.Slate)
block("Main entrance glass", 27, 9, -2.2, 10, 14, 0.5, C.glassLight, Enum.Material.Glass)
block("Entrance wooden double doors", 27, 6.5, -2.55, 7.5, 10, 0.35, C.wood, Enum.Material.Wood)
block("Entrance sign panel", 27, 21.5, -2.4, 20, 2.4, 0.8, C.bronze, Enum.Material.Metal)

-- Courtyard fountain: circular blue basin, central pedestal and four stylized birds.
cylinder("Fountain outer stone rim", 9, 0.7, -34, 24, 1.4, C.stoneLight, Enum.Material.Marble)
cylinder("Fountain blue basin", 9, 1.35, -34, 21, 0.35, C.water, Enum.Material.Glass)
cylinder("Fountain central pedestal base", 9, 2.2, -34, 5.5, 1.6, C.stoneShadow, Enum.Material.Sandstone)
cylinder("Fountain pedestal", 9, 4.3, -34, 2.8, 3.2, C.stoneLight, Enum.Material.Marble)
cylinder("Fountain upper bowl", 9, 6.2, -34, 8, 1.1, C.stoneLight, Enum.Material.Marble)
for i = 0, 3 do
    local a = math.pi * 2 * i / 4
    local bird = block("Fountain dove sculpture", 9 + math.cos(a) * 3.2, 7.4, -34 + math.sin(a) * 3.2,
        1.5, 2.2, 3.0, C.stoneLight, Enum.Material.Marble)
    bird.Orientation = Vector3.new(0, -math.deg(a), -18)
end

-- Formal flower beds, low hedges and cypress trees around the courtyard.
for _, x in ipairs({-42, -18, 36, 60}) do
    block("Raised flower bed", x, 0.8, -34, 12, 1.2, 5, C.stoneShadow, Enum.Material.Sandstone)
    block("Flower bed greenery", x, 1.6, -34, 10.5, 0.8, 3.8, C.hedge, Enum.Material.Grass)
end
local function cypress(x, z, h)
    cylinder("Cypress trunk", x, h/2, z, 1.1, h, C.wood, Enum.Material.Wood)
    for level = 1, 4 do
        local y = h * (level/5)
        local diameter = 8 - level * 1.25
        local crown = part("Cypress foliage", Vector3.new(diameter, h*0.34, diameter),
            Vector3.new(x, y, z), C.green, Enum.Material.Grass, station, Enum.PartType.Ball)
    end
end
for _, pos in ipairs({{-57,-38},{-48,-52},{75,-37},{84,-52},{-84,12},{101,12}}) do
    cypress(pos[1], pos[2], 27)
end

-- Platform roofs and tracks behind the station.
for _, z in ipairs({77, 105}) do
    block("Railway platform", 8, 0.15, z, 190, 0.5, 13, C.pavingLight, Enum.Material.Concrete)
    block("Platform canopy roof", 8, 13, z, 190, 1.2, 12, C.roof, Enum.Material.Metal)
    for x = -82, 98, 18 do
        column(x, z, 0.5, 12, 0.8)
    end
end
for _, x in ipairs({-18, -15, 15, 18}) do
    block("Track ballast", x, -0.1, 137, 1.6, 0.25, 53, C.metal, Enum.Material.Concrete)
    for z = 112, 162, 3.5 do
        block("Railway sleeper", x, 0.05, z, 8, 0.35, 1.0, C.wood, Enum.Material.Wood)
    end
end
for _, x in ipairs({-19, -17, -16, -14, 14, 16, 17, 19}) do
    block("Steel rail", x, 0.35, 137, 0.28, 0.55, 53, Color3.fromRGB(143, 149, 151), Enum.Material.Metal)
end

-- Forecourt lamps and subtle warm lighting.
for _, x in ipairs({-105, -75, 105, 135}) do
    cylinder("Square lamp post", x, 7, -77, 0.55, 14, C.metal, Enum.Material.Metal)
    block("Lamp lantern", x, 14.5, -77, 2.2, 2.4, 2.2, C.stoneLight, Enum.Material.Glass)
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 225, 170)
    light.Brightness = 0.7
    light.Range = 16
    light.Parent = station:FindFirstChild("Lamp lantern")
end

station:SetAttribute("BuildStage", "Architectural_Pass_02")
station:SetAttribute("Note", "Stylized architectural reconstruction guided by photo references; proportions and details remain subject to in-game review.")
print("[Simferopol] Detailed railway station generated.")

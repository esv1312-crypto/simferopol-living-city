-- Simferopol Railway Station: first procedural 3D blockout.
-- Generated entirely from Parts so the layout can be refined in code.
-- Coordinates: station entrance faces the negative Z direction; tracks are behind (+Z).

local Workspace = game:GetService("Workspace")

local city = Workspace:WaitForChild("City")
local old = city:FindFirstChild("RailwayStation")
if old then
	old:Destroy()
end

local station = Instance.new("Model")
station.Name = "RailwayStation"
station.Parent = city

local function part(name, size, position, color, material, parent, shape)
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.Position = position
	p.Anchored = true
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Color = color
	p.Material = material or Enum.Material.SmoothPlastic
	if shape then p.Shape = shape end
	p.Parent = parent or station
	return p
end

local function block(name, x, y, z, sx, sy, sz, color, material)
	return part(name, Vector3.new(sx, sy, sz), Vector3.new(x, y, z), color, material)
end

local cream = Color3.fromRGB(224, 207, 169)
local lightCream = Color3.fromRGB(239, 226, 196)
local roofColor = Color3.fromRGB(103, 119, 111)
local stone = Color3.fromRGB(190, 177, 150)
local dark = Color3.fromRGB(65, 73, 73)
local glass = Color3.fromRGB(91, 139, 153)
local gold = Color3.fromRGB(190, 157, 83)

-- Ground pad and forecourt.
block("Station forecourt", 0, -0.7, -62, 250, 1, 120, Color3.fromRGB(126, 126, 119), Enum.Material.Concrete)
block("Station footprint", 0, 0, 42, 174, 1, 92, stone, Enum.Material.Concrete)

-- Main central hall.
block("Main hall walls", 0, 17, 25, 94, 34, 42, cream, Enum.Material.Plaster)
block("Main hall roof", 0, 35, 25, 100, 2, 48, roofColor, Enum.Material.Slate)
block("Main hall front cornice", 0, 32.5, 3.5, 98, 2, 3, lightCream, Enum.Material.Sandstone)

-- Symmetrical side wings.
for _, side in ipairs({-1, 1}) do
	local x = side * 66
	block("Side wing", x, 11, 29, 42, 22, 50, cream, Enum.Material.Plaster)
	block("Side wing roof", x, 22.5, 29, 46, 1.5, 54, roofColor, Enum.Material.Slate)
	block("Wing cornice", x, 21, 3.5, 44, 1.5, 3, lightCream, Enum.Material.Sandstone)
end

-- Tall clock tower above the central section.
block("Clock tower base", 0, 48, 14, 28, 26, 27, lightCream, Enum.Material.Sandstone)
block("Clock tower upper", 0, 68, 14, 20, 16, 20, cream, Enum.Material.Plaster)
block("Clock tower roof", 0, 78, 14, 24, 4, 24, roofColor, Enum.Material.Slate)
block("Tower spire", 0, 84, 14, 5, 9, 5, gold, Enum.Material.Metal)

-- Clock faces on front and rear sides.
for _, z in ipairs({0.25, 27.75}) do
	local face = part("Clock face", Vector3.new(10, 10, 0.5), Vector3.new(0, 69, z), Color3.fromRGB(244, 238, 218), Enum.Material.SmoothPlastic, station, Enum.PartType.Cylinder)
	face.Orientation = Vector3.new(90, 0, 0)
	local rim = part("Clock rim", Vector3.new(11, 11, 0.7), Vector3.new(0, 69, z - 0.15), gold, Enum.Material.Metal, station, Enum.PartType.Cylinder)
	rim.Orientation = Vector3.new(90, 0, 0)
end

-- Front entrance: broad central portal and repeated arched-looking bays.
block("Entrance upper facade", 0, 24, 2, 38, 15, 3, lightCream, Enum.Material.Sandstone)
for _, x in ipairs({-38, -25, -12, 12, 25, 38}) do
	block("Facade pier", x, 12, 1.8, 2.4, 24, 3.2, lightCream, Enum.Material.Sandstone)
	block("Window glass", x, 12, 0.05, 5.5, 11, 0.5, glass, Enum.Material.Glass)
	block("Window top", x, 18, -0.2, 6.5, 1.2, 1.2, lightCream, Enum.Material.Sandstone)
	block("Window sill", x, 6, -0.2, 6.5, 1, 1.2, lightCream, Enum.Material.Sandstone)
end

-- Main entrance doors and sign.
block("Entrance shadow", 0, 9, 0.2, 17, 18, 1, dark, Enum.Material.Slate)
block("Entrance glazing", 0, 9, -0.45, 13, 15, 0.5, glass, Enum.Material.Glass)
block("Entrance doors", 0, 6, -0.8, 5, 10, 0.4, dark, Enum.Material.Glass)
block("Station name plaque", 0, 27, -0.3, 29, 3, 0.8, gold, Enum.Material.Metal)

-- Pilasters and decorative horizontal bands.
for _, x in ipairs({-45, -31, -17, 17, 31, 45}) do
	block("Facade pilaster", x, 18, 0.4, 1.4, 29, 1.4, lightCream, Enum.Material.Sandstone)
end
block("Facade lower band", 0, 4, 0.2, 96, 1.2, 2, lightCream, Enum.Material.Sandstone)

-- Platform-side canopy and two platform strips behind the building.
for _, z in ipairs({92, 122}) do
	block("Platform", 0, 0.2, z, 190, 0.5, 14, Color3.fromRGB(145, 143, 132), Enum.Material.Concrete)
	block("Platform canopy", 0, 13, z, 190, 1, 12, roofColor, Enum.Material.Metal)
	for x = -88, 88, 22 do
		block("Canopy support", x, 6.5, z, 1.2, 13, 1.2, dark, Enum.Material.Metal)
	end
end

-- Simplified railway tracks behind the platforms.
for _, x in ipairs({-12, 12}) do
	block("Rail bed", x, -0.15, 151, 2, 0.25, 46, dark, Enum.Material.Concrete)
	for z = 130, 172, 4 do
		block("Sleeper", x, 0, z, 7, 0.35, 1.1, Color3.fromRGB(91, 76, 61), Enum.Material.Wood)
	end
end
for _, x in ipairs({-13, -11, 11, 13}) do
	block("Rail", x, 0.25, 151, 0.35, 0.5, 46, Color3.fromRGB(135, 139, 140), Enum.Material.Metal)
end

-- Courtyard-side detail: a small open paved court between station volumes.
block("Inner court paving", 0, 0.1, 68, 72, 0.25, 18, Color3.fromRGB(177, 169, 150), Enum.Material.Pavement)

-- Simple scale references around the forecourt.
for _, x in ipairs({-92, -62, 62, 92}) do
	block("Forecourt lamp post", x, 8, -42, 0.7, 16, 0.7, dark, Enum.Material.Metal)
	block("Lamp head", x, 16.5, -42, 3, 1, 1.5, gold, Enum.Material.Metal)
end

station:SetAttribute("BuildStage", "Blockout_01")
station:SetAttribute("Note", "Initial proportions only; refine against reference photos and map data.")
print("[Simferopol] Railway station blockout generated.")

-- Simferopol — Living City
-- Server-side bootstrap. This creates the runtime folders used by later systems.

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local function getOrCreateFolder(parent: Instance, name: string): Folder
    local existing = parent:FindFirstChild(name)
    if existing and existing:IsA("Folder") then
        return existing
    end

    if existing then
        existing:Destroy()
    end

    local folder = Instance.new("Folder")
    folder.Name = name
    folder.Parent = parent
    return folder
end

local city = getOrCreateFolder(Workspace, "City")

for _, folderName in ipairs({
    "Buildings",
    "Roads",
    "Vegetation",
    "StreetObjects",
    "Traffic",
    "NPC",
    "Factions",
    "Police",
    "Events",
}) do
    getOrCreateFolder(city, folderName)
end

-- Initial visual baseline; detailed lighting will be tuned with the first district.
Lighting.ClockTime = 15
Lighting.Brightness = 2
Lighting.EnvironmentDiffuseScale = 0.35
Lighting.EnvironmentSpecularScale = 0.5

print("[Simferopol] City runtime structure initialized.")

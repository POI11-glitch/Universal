local RunService = game:GetService("RunService")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Universal Script Bypass 100%",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading Script",
   LoadingSubtitle = "by BeerParkdums",
   Theme = "Serenity", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = true,
   DisableBuildWarnings = true, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Flaxk Premium"
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key Premium",
      Subtitle = "Key Premium",
      Note = "", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"WADFUN"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Tab", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Player")
local Divider = Tab:CreateDivider()

local Button = Tab:CreateButton({
   Name = "Reset Character",
   Callback = function()
		game.Workspace.dobogg_12.Humanoid.Health = 0
   end,
})

local tpwalking = false
local tpWalkSpeed = 16

local Toggle = Tab:CreateToggle({
    Name = "TPW",
    CurrentValue = false,
    Flag = "TPWalkToggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        tpwalking = Value
        if not Value then return end
        local hb = RunService.Heartbeat
        local chr = game.Players.LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and chr and hum and hum.Parent do
            local delta = hb:Wait()
            if hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection * delta * tpWalkSpeed)
            end
        end
    end
 })

 Tab:CreateSlider({
    Name = "SpeedWalk",
    Range = {1, 1000},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "TPWalkSpeedSlide",
    Callback = function(Value)
        tpWalkSpeed = Value
    end
 })

 local Button = Tab:CreateButton({
   Name = "ESP",
   Callback = function()
		local FillColor = Color3.fromRGB(175,25,255)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255,255,255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage

    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

Players.PlayerAdded:Connect(Highlight)
for i,v in next, Players:GetPlayers() do
    Highlight(v)
end

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage[plrname] then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)
   end,
})

Keybind:Set("LeftControl") -- Keybind (string)

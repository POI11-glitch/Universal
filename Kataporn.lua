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

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key Premium",
      Subtitle = "Key Premium",
      Note = "", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"WADFUN"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Player Manager", 4483362458) -- Title, Image
local Visual = Window:CreateTab("Visual Manager", 4483362458) -- Title, Image
local Misc = Window:CreateTab("Misc Manager", 4483362458) -- Title, Image
local Edit = Window:CreateTab("UI Manager", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Manager")
local Section = Edit:CreateSection("Manager")
local Section = Misc:CreateSection("Manager")
local Section = Visual:CreateSection("Manager")
local Divider = Tab:CreateDivider()

local Button = Misc:CreateButton({
   Name = "Reset Character",
   Callback = function()
		game.Workspace.dobogg_12.Humanoid.Health = 0
   end,
})

local Button = Edit:CreateButton({
    Name = "Destroy UI For Reset Script",
    Callback = function()
         Rayfield:Destroy()
    end,
 })

 local Slider = Visual:CreateSlider({
    Name = "Hitbox Size",
    Range = {0, 100},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 10,
    Flag = "HitboxSlider", -- A flag to identify this setting
    Callback = function(Value)
        -- Update the global hitbox size when the slider changes
        getgenv().hitboxsize = Value
        -- Update the hitbox size for all players based on the new slider value
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= lp then
                hitbox(player) -- Call the function to update the hitbox size for the player
            end
        end
    end,
})

-- Existing hitbox function with the slider's value controlling the hitbox size
local function hitbox(plr)
    local plrname = plr.Name
    local size = getgenv().hitboxsize
    if not connections[plr] or not connections["SteppedLoop_"..plrname] then
        connections[plr] = plr.CharacterAdded:Connect(function(char)
            repeat task.wait() until char:FindFirstChildWhichIsA("Humanoid") and char:FindFirstChildWhichIsA("Humanoid").RootPart
            hitbox(plr)
        end)
        connections["SteppedLoop_"..plrname] = rs.Stepped:Connect(function()
            if plr.Character then
                for i,v in next, plr.Character:GetDescendants() do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
    repeat task.wait() until plr.Character and plr.Character:FindFirstChildWhichIsA("Humanoid") and plr.Character:FindFirstChildWhichIsA("Humanoid").RootPart
    plr.Character:FindFirstChildWhichIsA("Humanoid").RootPart.Size = Vector3.new(size, size, size)
end

for i, v in next, Players:GetPlayers() do
    if v ~= lp then
        hitbox(v)
    end
end

Players.PlayerAdded:Connect(function(player)
    hitbox(player)
end)

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if connections[plr] then
        connections[plr]:Disconnect()
    end
    if connections["SteppedLoop_"..plrname] then
        connections["SteppedLoop_"..plrname]:Disconnect()
    end
end)


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

Keybind:Set("LeftControl") -- Keybind (string)

-- ZiaanHub Loader Animation - Loadstring Version
-- Enhanced by @ziaandev

(function()
    -- Services
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    
    if not RunService:IsClient() then return end
    
    local LocalPlayer = Players.LocalPlayer
    while not LocalPlayer do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
    end
    
    -- Main loader function
    local function ZiaanLoader(config)
        config = config or {}
        local text = config.text or "ZIAANHUB"
        local textColor = config.textColor or Color3.fromRGB(38, 0, 135)
        local backgroundColor = config.backgroundColor or Color3.fromRGB(10, 10, 20)
        local blurSize = config.blurSize or 24
        local letterSpacing = config.letterSpacing or 65
        local letterSize = config.letterSize or 60
        local duration = config.duration or 2
        local onComplete = config.onComplete or function() end
        
        -- Create blur effect
        local blur = Instance.new("BlurEffect")
        blur.Size = 0
        blur.Parent = Lighting
        
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = blurSize}):Play()

        -- Create screen GUI
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ZiaanLoader_" .. tick()
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        -- Main frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = screenGui

        -- Background
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = backgroundColor
        bg.BackgroundTransparency = 1
        bg.ZIndex = 0
        bg.Parent = frame

        TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

        local letters = {}
        
        -- Function to animate letters sequentially
        local function animateLetter(index)
            if index > #text then
                -- All letters animated, wait and then fade out
                wait(duration)
                
                -- Fade out letters
                for _, label in ipairs(letters) do
                    TweenService:Create(label, TweenInfo.new(0.3), {
                        TextTransparency = 1,
                        TextSize = letterSize * 0.5
                    }):Play()
                end
                
                -- Fade out background and blur
                TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
                
                -- Cleanup
                delay(0.6, function()
                    if screenGui then screenGui:Destroy() end
                    if blur then blur:Destroy() end
                    onComplete()
                end)
                
                return
            end
            
            local char = text:sub(index, index)
            
            local label = Instance.new("TextLabel")
            label.Text = char
            label.Font = Enum.Font.GothamBlack
            label.TextColor3 = textColor
            label.TextStrokeTransparency = 1
            label.TextTransparency = 1
            label.TextScaled = false
            label.TextSize = letterSize
            label.Size = UDim2.new(0, letterSize + 20, 0, letterSize + 20)
            label.AnchorPoint = Vector2.new(0.5, 0.5)
            label.Position = UDim2.new(0.5, (index - (#text / 2 + 0.5)) * letterSpacing, 0.5, 0)
            label.BackgroundTransparency = 1
            label.ZIndex = 2
            label.Parent = frame
            
            -- Add text stroke
            local textStroke = Instance.new("UIStroke")
            textStroke.Color = Color3.fromRGB(255, 255, 255)
            textStroke.Thickness = 2
            textStroke.Transparency = 1
            textStroke.Parent = label
            
            -- Animate letter in
            TweenService:Create(label, TweenInfo.new(0.3), {
                TextTransparency = 0,
                TextSize = letterSize
            }):Play()
            
            TweenService:Create(textStroke, TweenInfo.new(0.3), {Transparency = 0.7}):Play()
            
            table.insert(letters, label)
            
            -- Animate next letter after delay
            delay(0.25, function()
                animateLetter(index + 1)
            end)
        end
        
        -- Start animation
        animateLetter(1)
        
        return screenGui
    end
    
    -- Quick loader function
    ZiaanLoader.Quick = function()
        return ZiaanLoader()
    end
    
    -- Make it global
    getgenv().ZiaanLoader = ZiaanLoader
    
    print("✅ ZiaanLoader loaded successfully!")
    print("Usage: ZiaanLoader() or ZiaanLoader.Quick()")
end)()

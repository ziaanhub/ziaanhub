--[[
    ZiaanHub Loader Animation
    Enhanced by @ziaandev
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Queue Loader Animation
local function showQueueLoader()
    -- Create blur effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = Lighting
    
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

    -- Create screen GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ZiaanLoader"
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
    bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    bg.BackgroundTransparency = 1
    bg.ZIndex = 0
    bg.Parent = frame

    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

    local word = "ZIAANHUB"
    local letters = {}

    local function tweenOutAndDestroy()
        -- Tween out all letters
        for _, label in ipairs(letters) do
            TweenService:Create(label, TweenInfo.new(0.3), {
                TextTransparency = 1,
                TextSize = 30
            }):Play()
        end
        
        -- Tween out background and blur
        TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
        
        -- Wait for animations to complete then destroy
        wait(0.6)
        screenGui:Destroy()
        blur:Destroy()
    end

    -- Create and animate each letter
    for i = 1, #word do
        local char = word:sub(i, i)

        local label = Instance.new("TextLabel")
        label.Text = char
        label.Font = Enum.Font.GothamBlack
        label.TextColor3 = Color3.fromRGB(38, 0, 135)
        label.TextStrokeTransparency = 1 
        label.TextTransparency = 1
        label.TextScaled = false
        label.TextSize = 30 
        label.Size = UDim2.new(0, 60, 0, 60)
        label.AnchorPoint = Vector2.new(0.5, 0.5)
        label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 65, 0.5, 0)
        label.BackgroundTransparency = 1
        label.ZIndex = 2
        label.Parent = frame

        -- Animate letter in
        local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {
            TextTransparency = 0,
            TextSize = 60
        })
        tweenIn:Play()

        table.insert(letters, label)
        wait(0.25) -- Delay between each letter
    end

    -- Wait then animate out
    wait(2)
    tweenOutAndDestroy()
end

-- Enhanced loader with callback support
local function createAdvancedLoader(options)
    local config = {
        text = options.text or "ZIAANHUB",
        textColor = options.textColor or Color3.fromRGB(38, 0, 135),
        backgroundColor = options.backgroundColor or Color3.fromRGB(10, 10, 20),
        blurSize = options.blurSize or 24,
        letterSpacing = options.letterSpacing or 65,
        letterSize = options.letterSize or 60,
        duration = options.duration or 2,
        onComplete = options.onComplete or function() end
    }

    -- Create blur effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = Lighting
    
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = config.blurSize}):Play()

    -- Create screen GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdvancedLoader"
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
    bg.BackgroundColor3 = config.backgroundColor
    bg.BackgroundTransparency = 1
    bg.ZIndex = 0
    bg.Parent = frame

    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

    local letters = {}

    local function tweenOutAndDestroy()
        -- Tween out all letters
        for _, label in ipairs(letters) do
            TweenService:Create(label, TweenInfo.new(0.3), {
                TextTransparency = 1,
                TextSize = config.letterSize * 0.5
            }):Play()
        end
        
        -- Tween out background and blur
        TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
        
        -- Wait for animations to complete then destroy
        wait(0.6)
        screenGui:Destroy()
        blur:Destroy()
        
        -- Call completion callback
        config.onComplete()
    end

    -- Create and animate each letter
    for i = 1, #config.text do
        local char = config.text:sub(i, i)

        local label = Instance.new("TextLabel")
        label.Text = char
        label.Font = Enum.Font.GothamBlack
        label.TextColor3 = config.textColor
        label.TextStrokeTransparency = 1 
        label.TextTransparency = 1
        label.TextScaled = false
        label.TextSize = config.letterSize
        label.Size = UDim2.new(0, config.letterSize + 20, 0, config.letterSize + 20)
        label.AnchorPoint = Vector2.new(0.5, 0.5)
        label.Position = UDim2.new(0.5, (i - (#config.text / 2 + 0.5)) * config.letterSpacing, 0.5, 0)
        label.BackgroundTransparency = 1
        label.ZIndex = 2
        label.Parent = frame

        -- Add text stroke for better visibility
        local textStroke = Instance.new("UIStroke")
        textStroke.Color = Color3.fromRGB(255, 255, 255)
        textStroke.Thickness = 2
        textStroke.Transparency = 1
        textStroke.Parent = label

        -- Animate letter in
        local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {
            TextTransparency = 0,
            TextSize = config.letterSize
        })
        tweenIn:Play()

        -- Animate text stroke
        TweenService:Create(textStroke, TweenInfo.new(0.3), {Transparency = 0.7}):Play()

        table.insert(letters, label)
        wait(0.25) -- Delay between each letter
    end

    -- Wait then animate out
    wait(config.duration)
    tweenOutAndDestroy()
    
    return screenGui
end

-- Simple one-line loader
local function quickLoader()
    showQueueLoader()
end

-- Export functions
return {
    showQueueLoader = showQueueLoader,
    createAdvancedLoader = createAdvancedLoader,
    quickLoader = quickLoader
}

-- Example usage:
-- showQueueLoader() -- Basic loader
-- createAdvancedLoader({text = "LOADING", duration = 3}) -- Custom loader
-- quickLoader() -- Quick basic loader

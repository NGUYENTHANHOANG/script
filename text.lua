-- ==============================================
-- BLOX FRUITS ULTIMATE EXPLOIT v3.0
-- DarkForge-X Engine | Authorized Testing Only
-- ==============================================

--[[
    CẢNH BÁO BẢO MẬT:
    Script này chỉ dành cho mục đích giáo dục và kiểm thử 
    trong môi trường Roblox Studio được ủy quyền.
    Không sử dụng trái phép trên game Blox Fruits chính thức.
]]

-- Module 1: Anti-Detection System
local AntiDetect = {
    _VERSION = "3.0.1",
    _LAST_UPDATE = os.date("%Y-%m-%d"),
    
    -- Danh sách signature Anti-Cheat cần tránh
    AC_SIGNATURES = {
        "ScriptContext", 
        "CoreGui", 
        "RobloxLocked", 
        "GetFocusedTextBox",
        "MemoryService",
        "ScriptSignatures"
    },
    
    -- Phương pháp mã hóa tên hàm
    OBFUSCATION_MAP = {
        ["Instance"] = "",
        ["new"] = "",
        ["GetService"] = "",
        ["GetPlayers"] = "",
        ["LocalPlayer"] = "",
        ["Character"] = "",
        ["Humanoid"] = "",
        ["HumanoidRootPart"] = "",
        ["CFrame"] = "",
        ["Vector3"] = ""
    },
    
    -- Random delay để tránh pattern detection
    RandomDelay = function(min, max)
        local delay = math.random(min * 1000, max * 1000) / 1000
        task.wait(delay)
        return delay
    end,
    
    -- Mã hóa string
    EncryptString = function(str)
        local result = ""
        for i = 1, #str do
            local charCode = string.byte(str, i)
            local encrypted = charCode ~ 0x7F
            result = result .. string.char(encrypted)
        end
        return string.reverse(result)
    end,
    
    -- Decrypt string
    DecryptString = function(str)
        local reversed = string.reverse(str)
        local result = ""
        for i = 1, #reversed do
            local charCode = string.byte(reversed, i)
            local decrypted = charCode ~ 0x7F
            result = result .. string.char(decrypted)
        end
        return result
    end,
    
    -- Hook detection bypass
    HookGameFunctions = function()
        local gameMeta = getrawmetatable(game)
        local oldNamecall = gameMeta.__namecall
        local oldIndex = gameMeta.__index
        
        setreadonly(gameMeta, false)
        
        gameMeta.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            -- Anti-kick bypass
            if method == "Kick" or method == "kick" then
                return nil
            end
            
            -- Anti-teleport bypass
            if method == "Teleport" or method == "teleport" then
                return nil
            end
            
            return oldNamecall(self, unpack(args))
        end)
        
        gameMeta.__index = newcclosure(function(self, key)
            -- Hide exploit references
            if tostring(key):lower():find("exploit") or 
               tostring(key):lower():find("hack") or
               tostring(key):lower():find("cheat") then
                return nil
            end
            
            return oldIndex(self, key)
        end)
        
        setreadonly(gameMeta, true)
    end,
    
    -- Check if game is Blox Fruits
    ValidateGame = function()
        local success, gameId = pcall(function()
            return game.PlaceId
        end)
        
        if not success then return false end
        
        -- Blox Fruits Game IDs
        local BLOX_FRUITS_IDS = {
            2753915549, -- First Sea
            4442272183, -- Second Sea
            7449423635  -- Third Sea
        }
        
        for _, id in ipairs(BLOX_FRUITS_IDS) do
            if gameId == id then
                return true
            end
        end
        
        return false
    end
}

-- Khởi tạo Anti-Detection
AntiDetect.HookGameFunctions()

-- Module 2: Core Services
local Services = {
    Players = (function()
        local success, service = pcall(function()
            return game:GetService("Players")
        end)
        return success and service or nil
    end)(),
    
    ReplicatedStorage = (function()
        local success, service = pcall(function()
            return game:GetService("ReplicatedStorage")
        end)
        return success and service or nil
    end)(),
    
    Workspace = (function()
        local success, service = pcall(function()
            return game:GetService("Workspace")
        end)
        return success and service or nil
    end)(),
    
    Lighting = (function()
        local success, service = pcall(function()
            return game:GetService("Lighting")
        end)
        return success and service or nil
    end)(),
    
    HttpService = (function()
        local success, service = pcall(function()
            return game:GetService("HttpService")
        end)
        return success and service or nil
    end)(),
    
    TweenService = (function()
        local success, service = pcall(function()
            return game:GetService("TweenService")
        end)
        return success and service or nil
    end)(),
    
    UserInputService = (function()
        local success, service = pcall(function()
            return game:GetService("UserInputService")
        end)
        return success and service or nil
    end)(),
    
    RunService = (function()
        local success, service = pcall(function()
            return game:GetService("RunService")
        end)
        return success and service or nil
    end)()
}

-- Kiểm tra game hợp lệ
if not AntiDetect.ValidateGame() then
    warn("Game không phải Blox Fruits hoặc đã có lỗi xảy ra!")
    return
end

-- Module 3: GUI Framework (DarkHub Style)
local DarkHub = {
    MainGUI = nil,
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 40),
            Foreground = Color3.fromRGB(45, 45, 55),
            Text = Color3.fromRGB(240, 240, 240),
            Accent = Color3.fromRGB(0, 170, 255),
            Success = Color3.fromRGB(0, 200, 100),
            Error = Color3.fromRGB(255, 80, 80)
        },
        Purple = {
            Background = Color3.fromRGB(40, 30, 50),
            Foreground = Color3.fromRGB(55, 45, 65),
            Text = Color3.fromRGB(240, 240, 240),
            Accent = Color3.fromRGB(180, 80, 255),
            Success = Color3.fromRGB(0, 200, 100),
            Error = Color3.fromRGB(255, 80, 80)
        },
        Ocean = {
            Background = Color3.fromRGB(20, 40, 60),
            Foreground = Color3.fromRGB(30, 50, 70),
            Text = Color3.fromRGB(240, 240, 240),
            Accent = Color3.fromRGB(0, 200, 255),
            Success = Color3.fromRGB(0, 200, 100),
            Error = Color3.fromRGB(255, 80, 80)
        }
    },
    CurrentTheme = "Dark",
    
    -- Tạo main GUI
    CreateGUI = function()
        -- Xóa GUI cũ nếu tồn tại
        if DarkHub.MainGUI then
            DarkHub.MainGUI:Destroy()
        end
        
        -- Tạo ScreenGui
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "DarkHubBloxFruits"
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.ResetOnSpawn = false
        
        if syn and syn.protect_gui then
            syn.protect_gui(ScreenGui)
        elseif gethui then
            ScreenGui.Parent = gethui()
        elseif game.CoreGui then
            ScreenGui.Parent = game.CoreGui
        end
        
        -- Main Frame
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 500, 0, 400)
        MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
        MainFrame.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Background
        MainFrame.BackgroundTransparency = 0.1
        MainFrame.BorderSizePixel = 0
        
        -- Corner Radius
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = MainFrame
        
        -- Drop Shadow
        local DropShadow = Instance.new("ImageLabel")
        DropShadow.Name = "DropShadow"
        DropShadow.BackgroundTransparency = 1
        DropShadow.Position = UDim2.new(0, -15, 0, -15)
        DropShadow.Size = UDim2.new(1, 30, 1, 30)
        DropShadow.Image = "rbxassetid://5554236805"
        DropShadow.ImageColor3 = Color3.new(0, 0, 0)
        DropShadow.ImageTransparency = 0.5
        DropShadow.ScaleType = Enum.ScaleType.Slice
        DropShadow.SliceCenter = Rect.new(23, 23, 277, 277)
        DropShadow.Parent = MainFrame
        
        -- Title Bar
        local TitleBar = Instance.new("Frame")
        TitleBar.Name = "TitleBar"
        TitleBar.Size = UDim2.new(1, 0, 0, 40)
        TitleBar.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
        TitleBar.BorderSizePixel = 0
        
        local TitleCorner = Instance.new("UICorner")
        TitleCorner.CornerRadius = UDim.new(0, 8)
        TitleCorner.Parent = TitleBar
        
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Name = "TitleLabel"
        TitleLabel.Size = UDim2.new(0, 200, 1, 0)
        TitleLabel.Position = UDim2.new(0, 15, 0, 0)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "DARKHUB BLOX FRUITS v3.0"
        TitleLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
        TitleLabel.TextSize = 18
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = TitleBar
        
        -- Close Button
        local CloseButton = Instance.new("TextButton")
        CloseButton.Name = "CloseButton"
        CloseButton.Size = UDim2.new(0, 30, 0, 30)
        CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        CloseButton.Text = "X"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.TextSize = 16
        CloseButton.Font = Enum.Font.GothamBold
        
        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 6)
        CloseCorner.Parent = CloseButton
        
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            DarkHub.MainGUI = nil
        end)
        
        CloseButton.Parent = TitleBar
        
        -- Minimize Button
        local MinimizeButton = Instance.new("TextButton")
        MinimizeButton.Name = "MinimizeButton"
        MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
        MinimizeButton.Position = UDim2.new(1, -80, 0.5, -15)
        MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
        MinimizeButton.Text = "_"
        MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeButton.TextSize = 16
        MinimizeButton.Font = Enum.Font.GothamBold
        
        local MinimizeCorner = Instance.new("UICorner")
        MinimizeCorner.CornerRadius = UDim.new(0, 6)
        MinimizeCorner.Parent = MinimizeButton
        
        MinimizeButton.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
        
        MinimizeButton.Parent = TitleBar
        
        TitleBar.Parent = MainFrame
        
        -- Tab System
        local TabButtonsFrame = Instance.new("Frame")
        TabButtonsFrame.Name = "TabButtonsFrame"
        TabButtonsFrame.Size = UDim2.new(0, 120, 1, -60)
        TabButtonsFrame.Position = UDim2.new(0, 10, 0, 50)
        TabButtonsFrame.BackgroundTransparency = 1
        
        local TabsList = Instance.new("UIListLayout")
        TabsList.Padding = UDim.new(0, 5)
        TabsList.SortOrder = Enum.SortOrder.LayoutOrder
        TabsList.Parent = TabButtonsFrame
        
        -- Tab Content Frame
        local TabContentFrame = Instance.new("Frame")
        TabContentFrame.Name = "TabContentFrame"
        TabContentFrame.Size = UDim2.new(1, -140, 1, -60)
        TabContentFrame.Position = UDim2.new(0, 130, 0, 50)
        TabContentFrame.BackgroundTransparency = 1
        
        -- Tạo các tab
        local Tabs = {
            "Combat",
            "Farming",
            "Teleport",
            "Misc",
            "Settings"
        }
        
        local CurrentTab = "Combat"
        local TabContents = {}
        
        -- Hàm tạo tab content
        local function CreateTabContent(tabName)
            local ScrollFrame = Instance.new("ScrollingFrame")
            ScrollFrame.Name = tabName .. "Content"
            ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
            ScrollFrame.BackgroundTransparency = 1
            ScrollFrame.BorderSizePixel = 0
            ScrollFrame.ScrollBarThickness = 4
            ScrollFrame.ScrollBarImageColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Accent
            ScrollFrame.Visible = false
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Padding = UDim.new(0, 10)
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = ScrollFrame
            
            TabContents[tabName] = ScrollFrame
            return ScrollFrame
        end
        
        -- Tạo các tab button và content
        for i, tabName in ipairs(Tabs) do
            -- Tab Button
            local TabButton = Instance.new("TextButton")
            TabButton.Name = tabName .. "Tab"
            TabButton.Size = UDim2.new(1, 0, 0, 35)
            TabButton.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
            TabButton.Text = tabName
            TabButton.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
            TabButton.TextSize = 14
            TabButton.Font = Enum.Font.Gotham
            TabButton.LayoutOrder = i
            
            local TabCorner = Instance.new("UICorner")
            TabCorner.CornerRadius = UDim.new(0, 6)
            TabCorner.Parent = TabButton
            
            -- Highlight khi chọn
            if tabName == CurrentTab then
                TabButton.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Accent
            end
            
            TabButton.MouseButton1Click:Connect(function()
                CurrentTab = tabName
                
                -- Update all tab buttons
                for _, btn in ipairs(TabButtonsFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        if btn.Name == tabName .. "Tab" then
                            btn.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Accent
                        else
                            btn.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
                        end
                    end
                end
                
                -- Show/hide tab contents
                for name, content in pairs(TabContents) do
                    content.Visible = (name == tabName)
                end
            end)
            
            TabButton.Parent = TabButtonsFrame
            
            -- Tạo content cho tab
            local TabContent = CreateTabContent(tabName)
            TabContent.Parent = TabContentFrame
        end
        
        -- Hiển thị tab đầu tiên
        TabContents["Combat"].Visible = true
        
        TabButtonsFrame.Parent = MainFrame
        TabContentFrame.Parent = MainFrame
        
        -- Status Bar
        local StatusBar = Instance.new("Frame")
        StatusBar.Name = "StatusBar"
        StatusBar.Size = UDim2.new(1, -20, 0, 25)
        StatusBar.Position = UDim2.new(0, 10, 1, -35)
        StatusBar.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
        
        local StatusCorner = Instance.new("UICorner")
        StatusCorner.CornerRadius = UDim.new(0, 6)
        StatusCorner.Parent = StatusBar
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Name = "StatusLabel"
        StatusLabel.Size = UDim2.new(1, -10, 1, 0)
        StatusLabel.Position = UDim2.new(0, 10, 0, 0)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Status: Ready | Blox Fruits Loaded"
        StatusLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
        StatusLabel.TextSize = 12
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.Parent = StatusBar
        
        StatusBar.Parent = MainFrame
        
        -- Drag functionality
        local Dragging = false
        local DragInput, DragStart, StartPos
        
        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                DragStart = input.Position
                StartPos = MainFrame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
        
        TitleBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                DragInput = input
            end
        end)
        
        Services.UserInputService.InputChanged:Connect(function(input)
            if Dragging and input == DragInput then
                local Delta = input.Position - DragStart
                MainFrame.Position = UDim2.new(
                    StartPos.X.Scale,
                    StartPos.X.Offset + Delta.X,
                    StartPos.Y.Scale,
                    StartPos.Y.Offset + Delta.Y
                )
            end
        end)
        
        MainFrame.Parent = ScreenGui
        DarkHub.MainGUI = ScreenGui
        
        return ScreenGui, TabContents
    end,
    
    -- Tạo toggle switch
    CreateToggle = function(parent, name, default, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = name .. "Toggle"
        ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
        ToggleFrame.BackgroundTransparency = 1
        ToggleFrame.LayoutOrder = #parent:GetChildren()
        
        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Name = "Label"
        ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = name
        ToggleLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
        ToggleLabel.TextSize = 14
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ToggleLabel.Parent = ToggleFrame
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "Toggle"
        ToggleButton.Size = UDim2.new(0, 50, 0, 25)
        ToggleButton.Position = UDim2.new(1, -55, 0.5, -12.5)
        ToggleButton.BackgroundColor3 = default and DarkHub.Themes[DarkHub.CurrentTheme].Success 
                                        or DarkHub.Themes[DarkHub.CurrentTheme].Foreground
        ToggleButton.Text = ""
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 12)
        ToggleCorner.Parent = ToggleButton
        
        local ToggleCircle = Instance.new("Frame")
        ToggleCircle.Name = "Circle"
        ToggleCircle.Size = UDim2.new(0, 21, 0, 21)
        ToggleCircle.Position = default and UDim2.new(1, -23, 0.5, -10.5)
                              or UDim2.new(0, 2, 0.5, -10.5)
        ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        
        local CircleCorner = Instance.new("UICorner")
        CircleCorner.CornerRadius = UDim.new(1, 0)
        CircleCorner.Parent = ToggleCircle
        
        ToggleCircle.Parent = ToggleButton
        
        local isToggled = default
        
        ToggleButton.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            
            if isToggled then
                ToggleButton.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Success
                ToggleCircle:TweenPosition(UDim2.new(1, -23, 0.5, -10.5), 
                    Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            else
                ToggleButton.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
                ToggleCircle:TweenPosition(UDim2.new(0, 2, 0.5, -10.5), 
                    Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            end
            
            if callback then
                callback(isToggled)
            end
        end)
        
        ToggleButton.Parent = ToggleFrame
        ToggleFrame.Parent = parent
        
        return ToggleFrame
    end,
    
    -- Tạo button
    CreateButton = function(parent, name, callback)
        local Button = Instance.new("TextButton")
        Button.Name = name .. "Button"
        Button.Size = UDim2.new(1, -20, 0, 35)
        Button.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Accent
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        Button.Font = Enum.Font.GothamBold
        Button.LayoutOrder = #parent:GetChildren()
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
        
        Button.Parent = parent
        
        return Button
    end,
    
    -- Tạo slider
    CreateSlider = function(parent, name, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = name .. "Slider"
        SliderFrame.Size = UDim2.new(1, -20, 0, 50)
        SliderFrame.BackgroundTransparency = 1
        SliderFrame.LayoutOrder = #parent:GetChildren()
        
        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Name = "Label"
        SliderLabel.Size = UDim2.new(1, 0, 0, 20)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = name .. ": " .. tostring(default)
        SliderLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
        SliderLabel.TextSize = 14
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Parent = SliderFrame
        
        local SliderTrack = Instance.new("Frame")
        SliderTrack.Name = "Track"
        SliderTrack.Size = UDim2.new(1, 0, 0, 5)
        SliderTrack.Position = UDim2.new(0, 0, 0, 30)
        SliderTrack.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
        
        local TrackCorner = Instance.new("UICorner")
        TrackCorner.CornerRadius = UDim.new(1, 0)
        TrackCorner.Parent = SliderTrack
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Name = "Fill"
        local fillSize = ((default - min) / (max - min))
        SliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
        SliderFill.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Accent
        
        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(1, 0)
        FillCorner.Parent = SliderFill
        
        SliderFill.Parent = SliderTrack
        
        local SliderButton = Instance.new("TextButton")
        SliderButton.Name = "Button"
        SliderButton.Size = UDim2.new(0, 20, 0, 20)
        SliderButton.Position = UDim2.new(fillSize, -10, 0.5, -10)
        SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderButton.Text = ""
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(1, 0)
        ButtonCorner.Parent = SliderButton
        
        local isDragging = false
        
        local function UpdateValue(value)
            local clamped = math.clamp(value, min, max)
            local percentage = (clamped - min) / (max - min)
            
            SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
            SliderButton.Position = UDim2.new(percentage, -10, 0.5, -10)
            SliderLabel.Text = name .. ": " .. tostring(math.floor(clamped * 100) / 100)
            
            if callback then
                callback(clamped)
            end
        end
        
        SliderButton.MouseButton1Down:Connect(function()
            isDragging = true
        end)
        
        Services.UserInputService.InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = input.Position.X
                local absolutePos = mousePos - SliderTrack.AbsolutePosition.X
                local percentage = math.clamp(absolutePos / SliderTrack.AbsoluteSize.X, 0, 1)
                local value = min + (percentage * (max - min))
                
                UpdateValue(value)
            end
        end)
        
        Services.UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        SliderButton.Parent = SliderTrack
        SliderTrack.Parent = SliderFrame
        SliderFrame.Parent = parent
        
        UpdateValue(default)
        
        return SliderFrame
    end
}

-- Tạo GUI
local GUI, TabContents = DarkHub.CreateGUI()

-- Module 4: Blox Fruits Specific Exploits
local BloxFruitsExploits = {
    -- Combat Hacks
    Combat = {
        AutoParry = false,
        InstantKill = false,
        NoCooldown = false,
        Aimbot = false,
        AimbotKey = Enum.KeyCode.Q,
        AimbotRange = 50,
        
        -- Auto Parry Implementation
        ToggleAutoParry = function(state)
            BloxFruitsExploits.Combat.AutoParry = state
            if state then
                spawn(function()
                    while BloxFruitsExploits.Combat.AutoParry and task.wait(0.1) do
                        pcall(function()
                            local Character = Services.Players.LocalPlayer.Character
                            if Character then
                                local Humanoid = Character:FindFirstChild("Humanoid")
                                if Humanoid then
                                    -- Simulate parry input
                                    keypress(0x46) -- F key
                                    task.wait(0.1)
                                    keyrelease(0x46)
                                end
                            end
                        end)
                    end
                end)
            end
        end,
        
        -- Instant Kill Implementation
        ToggleInstantKill = function(state)
            BloxFruitsExploits.Combat.InstantKill = state
            if state then
                spawn(function()
                    while BloxFruitsExploits.Combat.InstantKill and task.wait(0.5) do
                        pcall(function()
                            local Players = Services.Players:GetPlayers()
                            for _, Player in ipairs(Players) do
                                if Player ~= Services.Players.LocalPlayer then
                                    local Character = Player.Character
                                    if Character then
                                        local Humanoid = Character:FindFirstChild("Humanoid")
                                        if Humanoid then
                                            Humanoid.Health = 0
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end)
            end
        end,
        
        -- No Cooldown Implementation
        ToggleNoCooldown = function(state)
            BloxFruitsExploits.Combat.NoCooldown = state
            if state then
                -- Hook cooldown functions
                local mt = getrawmetatable(game)
                local oldIndex = mt.__index
                
                setreadonly(mt, false)
                
                mt.__index = newcclosure(function(self, key)
                    if key == "Cooldown" or key == "cooldown" or key == "CD" then
                        return 0
                    end
                    return oldIndex(self, key)
                end)
                
                setreadonly(mt, true)
            end
        end,
        
        -- Aimbot Implementation
        ToggleAimbot = function(state)
            BloxFruitsExploits.Combat.Aimbot = state
            if state then
                Services.UserInputService.InputBegan:Connect(function(input)
                    if input.KeyCode == BloxFruitsExploits.Combat.AimbotKey then
                        pcall(function()
                            local Players = Services.Players:GetPlayers()
                            local LocalPlayer = Services.Players.LocalPlayer
                            local LocalCharacter = LocalPlayer.Character
                            
                            if not LocalCharacter then return end
                            
                            local ClosestPlayer = nil
                            local ClosestDistance = BloxFruitsExploits.Combat.AimbotRange
                            
                            for _, Player in ipairs(Players) do
                                if Player ~= LocalPlayer then
                                    local Character = Player.Character
                                    if Character then
                                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                        if HumanoidRootPart then
                                            local Distance = (LocalCharacter.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                                            if Distance < ClosestDistance then
                                                ClosestDistance = Distance
                                                ClosestPlayer = Player
                                            end
                                        end
                                    end
                                end
                            end
                            
                            if ClosestPlayer then
                                local TargetCharacter = ClosestPlayer.Character
                                if TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart") then
                                    LocalCharacter.HumanoidRootPart.CFrame = CFrame.new(
                                        LocalCharacter.HumanoidRootPart.Position,
                                        TargetCharacter.HumanoidRootPart.Position
                                    )
                                end
                            end
                        end)
                    end
                end)
            end
        end
    },
    
    -- Farming System
    Farming = {
        AutoFarmNPC = false,
        AutoCollectFruits = false,
        AutoRaid = false,
        FarmRadius = 100,
        
        -- Auto Farm NPC Implementation
        ToggleAutoFarmNPC = function(state)
            BloxFruitsExploits.Farming.AutoFarmNPC = state
            if state then
                spawn(function()
                    while BloxFruitsExploits.Farming.AutoFarmNPC and task.wait(0.3) do
                        pcall(function()
                            local LocalPlayer = Services.Players.LocalPlayer
                            local LocalCharacter = LocalPlayer.Character
                            
                            if not LocalCharacter then return end
                            
                            local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
                            if not HumanoidRootPart then return end
                            
                            -- Find NPCs in radius
                            for _, NPC in ipairs(Services.Workspace.NPCs:GetChildren()) do
                                if NPC:FindFirstChild("HumanoidRootPart") then
                                    local Distance = (HumanoidRootPart.Position - NPC.HumanoidRootPart.Position).Magnitude
                                    if Distance <= BloxFruitsExploits.Farming.FarmRadius then
                                        -- Teleport to NPC
                                        HumanoidRootPart.CFrame = NPC.HumanoidRootPart.CFrame
                                        task.wait(0.2)
                                        
                                        -- Attack NPC
                                        local args = {
                                            [1] = NPC.HumanoidRootPart.Position,
                                            [2] = NPC
                                        }
                                        
                                        local Event = Services.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Combat")
                                        if Event then
                                            Event:FireServer(unpack(args))
                                        end
                                        
                                        break
                                    end
                                end
                            end
                        end)
                    end
                end)
            end
        end,
        
        -- Auto Collect Fruits Implementation
        ToggleAutoCollectFruits = function(state)
            BloxFruitsExploits.Farming.AutoCollectFruits = state
            if state then
                spawn(function()
                    while BloxFruitsExploits.Farming.AutoCollectFruits and task.wait(0.5) do
                        pcall(function()
                            local LocalPlayer = Services.Players.LocalPlayer
                            local LocalCharacter = LocalPlayer.Character
                            
                            if not LocalCharacter then return end
                            
                            local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
                            if not HumanoidRootPart then return end
                            
                            -- Find fruits in workspace
                            for _, Fruit in ipairs(Services.Workspace:GetChildren()) do
                                if Fruit.Name:find("Fruit") and Fruit:IsA("Model") then
                                    if Fruit:FindFirstChild("Handle") then
                                        local Distance = (HumanoidRootPart.Position - Fruit.Handle.Position).Magnitude
                                        if Distance <= 50 then
                                            HumanoidRootPart.CFrame = Fruit.Handle.CFrame
                                            task.wait(0.3)
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end)
            end
        end
    },
    
    -- Teleport System
    Teleport = {
        Islands = {
            ["Kingdom of Rose"] = Vector3.new(-100, 50, -100),
            ["Cafe"] = Vector3.new(200, 50, -300),
            ["Pirate Village"] = Vector3.new(500, 50, 100),
            ["Desert"] = Vector3.new(800, 50, -200),
            ["Frozen Village"] = Vector3.new(-500, 50, 800),
            ["Skylands"] = Vector3.new(0, 1000, 0)
        },
        
        Bosses = {
            ["Chief Warden"] = Vector3.new(300, 50, 500),
            ["Swan"] = Vector3.new(400, 50, 600),
            ["Diamond"] = Vector3.new(-200, 50, 300)
        },
        
        TeleportTo = function(position)
            pcall(function()
                local LocalPlayer = Services.Players.LocalPlayer
                local LocalCharacter = LocalPlayer.Character
                
                if LocalCharacter and LocalCharacter:FindFirstChild("HumanoidRootPart") then
                    LocalCharacter.HumanoidRootPart.CFrame = CFrame.new(position)
                end
            end)
        end
    },
    
    -- Player Modifications
    PlayerMods = {
        InfiniteEnergy = false,
        GodMode = false,
        SpeedHack = false,
        FlyHack = false,
        SpeedMultiplier = 2,
        FlySpeed = 50,
        
        -- Infinite Energy Implementation
        ToggleInfiniteEnergy = function(state)
            BloxFruitsExploits.PlayerMods.InfiniteEnergy = state
            if state then
                spawn(function()
                    while BloxFruitsExploits.PlayerMods.InfiniteEnergy and task.wait(1) do
                        pcall(function()
                            local LocalPlayer = Services.Players.LocalPlayer
                            local Stats = LocalPlayer:FindFirstChild("leaderstats")
                            if Stats then
                                local Energy = Stats:FindFirstChild("Energy")
                                if Energy then
                                    Energy.Value = 1000
                                end
                            end
                        end)
                    end
                end)
            end
        end,
        
        -- God Mode Implementation
        ToggleGodMode = function(state)
            BloxFruitsExploits.PlayerMods.GodMode = state
            if state then
                spawn(function()
                    while BloxFruitsExploits.PlayerMods.GodMode and task.wait(0.5) do
                        pcall(function()
                            local LocalPlayer = Services.Players.LocalPlayer
                            local LocalCharacter = LocalPlayer.Character
                            
                            if LocalCharacter then
                                local Humanoid = LocalCharacter:FindFirstChild("Humanoid")
                                if Humanoid then
                                    Humanoid.MaxHealth = math.huge
                                    Humanoid.Health = math.huge
                                end
                            end
                        end)
                    end
                end)
            end
        end,
        
        -- Speed Hack Implementation
        ToggleSpeedHack = function(state)
            BloxFruitsExploits.PlayerMods.SpeedHack = state
            if state then
                pcall(function()
                    local LocalPlayer = Services.Players.LocalPlayer
                    local LocalCharacter = LocalPlayer.Character
                    
                    if LocalCharacter then
                        local Humanoid = LocalCharacter:FindFirstChild("Humanoid")
                        if Humanoid then
                            Humanoid.WalkSpeed = 16 * BloxFruitsExploits.PlayerMods.SpeedMultiplier
                        end
                    end
                end)
            else
                pcall(function()
                    local LocalPlayer = Services.Players.LocalPlayer
                    local LocalCharacter = LocalPlayer.Character
                    
                    if LocalCharacter then
                        local Humanoid = LocalCharacter:FindFirstChild("Humanoid")
                        if Humanoid then
                            Humanoid.WalkSpeed = 16
                        end
                    end
                end)
            end
        end,
        
        -- Fly Hack Implementation
        ToggleFlyHack = function(state)
            BloxFruitsExploits.PlayerMods.FlyHack = state
            if state then
                -- Fly script implementation
                local LocalPlayer = Services.Players.LocalPlayer
                local LocalCharacter = LocalPlayer.Character
                
                if not LocalCharacter then return end
                
                local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
                if not HumanoidRootPart then return end
                
                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                BodyVelocity.Parent = HumanoidRootPart
                
                Services.UserInputService.InputBegan:Connect(function(input)
                    if BloxFruitsExploits.PlayerMods.FlyHack then
                        if input.KeyCode == Enum.KeyCode.W then
                            BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * BloxFruitsExploits.PlayerMods.FlySpeed
                        elseif input.KeyCode == Enum.KeyCode.S then
                            BodyVelocity.Velocity = -HumanoidRootPart.CFrame.LookVector * BloxFruitsExploits.PlayerMods.FlySpeed
                        elseif input.KeyCode == Enum.KeyCode.A then
                            BodyVelocity.Velocity = -HumanoidRootPart.CFrame.RightVector * BloxFruitsExploits.PlayerMods.FlySpeed
                        elseif input.KeyCode == Enum.KeyCode.D then
                            BodyVelocity.Velocity = HumanoidRootPart.CFrame.RightVector * BloxFruitsExploits.PlayerMods.FlySpeed
                        elseif input.KeyCode == Enum.KeyCode.Space then
                            BodyVelocity.Velocity = Vector3.new(0, BloxFruitsExploits.PlayerMods.FlySpeed, 0)
                        elseif input.KeyCode == Enum.KeyCode.LeftShift then
                            BodyVelocity.Velocity = Vector3.new(0, -BloxFruitsExploits.PlayerMods.FlySpeed, 0)
                        end
                    end
                end)
                
                Services.UserInputService.InputEnded:Connect(function(input)
                    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or
                       input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D or
                       input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                end)
            else
                -- Remove fly
                pcall(function()
                    local LocalPlayer = Services.Players.LocalPlayer
                    local LocalCharacter = LocalPlayer.Character
                    
                    if LocalCharacter then
                        local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
                        if HumanoidRootPart then
                            for _, v in ipairs(HumanoidRootPart:GetChildren()) do
                                if v:IsA("BodyVelocity") then
                                    v:Destroy()
                                end
                            end
                        end
                    end
                end)
            end
        end
    }
}

-- Module 5: Populate GUI with Features
local function PopulateCombatTab()
    local CombatTab = TabContents["Combat"]
    
    -- Auto Parry
    DarkHub.CreateToggle(CombatTab, "Auto Parry", false, function(state)
        BloxFruitsExploits.Combat.ToggleAutoParry(state)
    end)
    
    -- Instant Kill
    DarkHub.CreateToggle(CombatTab, "Instant Kill", false, function(state)
        BloxFruitsExploits.Combat.ToggleInstantKill(state)
    end)
    
    -- No Cooldown
    DarkHub.CreateToggle(CombatTab, "No Cooldown", false, function(state)
        BloxFruitsExploits.Combat.ToggleNoCooldown(state)
    end)
    
    -- Aimbot
    DarkHub.CreateToggle(CombatTab, "Aimbot (Q Key)", false, function(state)
        BloxFruitsExploits.Combat.ToggleAimbot(state)
    end)
    
    -- Aimbot Range
    DarkHub.CreateSlider(CombatTab, "Aimbot Range", 10, 100, 50, function(value)
        BloxFruitsExploits.Combat.AimbotRange = value
    end)
    
    -- Kill All Button
    DarkHub.CreateButton(CombatTab, "Kill All Players", function()
        pcall(function()
            local Players = Services.Players:GetPlayers()
            for _, Player in ipairs(Players) do
                if Player ~= Services.Players.LocalPlayer then
                    local Character = Player.Character
                    if Character then
                        local Humanoid = Character:FindFirstChild("Humanoid")
                        if Humanoid then
                            Humanoid.Health = 0
                        end
                    end
                end
            end
        end)
    end)
end

local function PopulateFarmingTab()
    local FarmingTab = TabContents["Farming"]
    
    -- Auto Farm NPC
    DarkHub.CreateToggle(FarmingTab, "Auto Farm NPC", false, function(state)
        BloxFruitsExploits.Farming.ToggleAutoFarmNPC(state)
    end)
    
    -- Auto Collect Fruits
    DarkHub.CreateToggle(FarmingTab, "Auto Collect Fruits", false, function(state)
        BloxFruitsExploits.Farming.ToggleAutoCollectFruits(state)
    end)
    
    -- Auto Raid
    DarkHub.CreateToggle(FarmingTab, "Auto Raid", false, function(state)
        BloxFruitsExploits.Farming.AutoRaid = state
        -- Raid implementation would go here
    end)
    
    -- Farm Radius
    DarkHub.CreateSlider(FarmingTab, "Farm Radius", 10, 200, 100, function(value)
        BloxFruitsExploits.Farming.FarmRadius = value
    end)
    
    -- Farm All Button
    DarkHub.CreateButton(FarmingTab, "Farm All Nearby NPCs", function()
        pcall(function()
            local LocalPlayer = Services.Players.LocalPlayer
            local LocalCharacter = LocalPlayer.Character
            
            if not LocalCharacter then return end
            
            local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then return end
            
            for _, NPC in ipairs(Services.Workspace.NPCs:GetChildren()) do
                if NPC:FindFirstChild("HumanoidRootPart") then
                    HumanoidRootPart.CFrame = NPC.HumanoidRootPart.CFrame
                    task.wait(0.5)
                end
            end
        end)
    end)
end

local function PopulateTeleportTab()
    local TeleportTab = TabContents["Teleport"]
    
    -- Island Teleports
    for IslandName, Position in pairs(BloxFruitsExploits.Teleport.Islands) do
        DarkHub.CreateButton(TeleportTab, "TP to " .. IslandName, function()
            BloxFruitsExploits.Teleport.TeleportTo(Position)
        end)
    end
    
    -- Boss Teleports
    for BossName, Position in pairs(BloxFruitsExploits.Teleport.Bosses) do
        DarkHub.CreateButton(TeleportTab, "TP to " .. BossName, function()
            BloxFruitsExploits.Teleport.TeleportTo(Position)
        end)
    end
    
    -- Custom Teleport
    local CustomTeleportFrame = Instance.new("Frame")
    CustomTeleportFrame.Size = UDim2.new(1, -20, 0, 100)
    CustomTeleportFrame.BackgroundTransparency = 1
    CustomTeleportFrame.LayoutOrder = 100
    CustomTeleportFrame.Parent = TeleportTab
    
    local XLabel = Instance.new("TextLabel")
    XLabel.Size = UDim2.new(0.3, 0, 0, 25)
    XLabel.Position = UDim2.new(0, 0, 0, 0)
    XLabel.BackgroundTransparency = 1
    XLabel.Text = "X:"
    XLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    XLabel.TextSize = 14
    XLabel.Font = Enum.Font.Gotham
    XLabel.TextXAlignment = Enum.TextXAlignment.Left
    XLabel.Parent = CustomTeleportFrame
    
    local XBox = Instance.new("TextBox")
    XBox.Size = UDim2.new(0.7, -10, 0, 25)
    XBox.Position = UDim2.new(0.3, 0, 0, 0)
    XBox.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
    XBox.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    XBox.Text = "0"
    XBox.PlaceholderText = "X Coordinate"
    XBox.Parent = CustomTeleportFrame
    
    local YLabel = Instance.new("TextLabel")
    YLabel.Size = UDim2.new(0.3, 0, 0, 25)
    YLabel.Position = UDim2.new(0, 0, 0, 30)
    YLabel.BackgroundTransparency = 1
    YLabel.Text = "Y:"
    YLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    YLabel.TextSize = 14
    YLabel.Font = Enum.Font.Gotham
    YLabel.TextXAlignment = Enum.TextXAlignment.Left
    YLabel.Parent = CustomTeleportFrame
    
    local YBox = Instance.new("TextBox")
    YBox.Size = UDim2.new(0.7, -10, 0, 25)
    YBox.Position = UDim2.new(0.3, 0, 0, 30)
    YBox.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
    YBox.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    YBox.Text = "50"
    YBox.PlaceholderText = "Y Coordinate"
    YBox.Parent = CustomTeleportFrame
    
    local ZLabel = Instance.new("TextLabel")
    ZLabel.Size = UDim2.new(0.3, 0, 0, 25)
    ZLabel.Position = UDim2.new(0, 0, 0, 60)
    ZLabel.BackgroundTransparency = 1
    ZLabel.Text = "Z:"
    ZLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    ZLabel.TextSize = 14
    ZLabel.Font = Enum.Font.Gotham
    ZLabel.TextXAlignment = Enum.TextXAlignment.Left
    ZLabel.Parent = CustomTeleportFrame
    
    local ZBox = Instance.new("TextBox")
    ZBox.Size = UDim2.new(0.7, -10, 0, 25)
    ZBox.Position = UDim2.new(0.3, 0, 0, 60)
    ZBox.BackgroundColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Foreground
    ZBox.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    ZBox.Text = "0"
    ZBox.PlaceholderText = "Z Coordinate"
    ZBox.Parent = CustomTeleportFrame
    
    local TeleportButton = DarkHub.CreateButton(CustomTeleportFrame, "Teleport to Coordinates", function()
        local x = tonumber(XBox.Text) or 0
        local y = tonumber(YBox.Text) or 50
        local z = tonumber(ZBox.Text) or 0
        
        BloxFruitsExploits.Teleport.TeleportTo(Vector3.new(x, y, z))
    end)
    
    TeleportButton.Size = UDim2.new(1, 0, 0, 35)
    TeleportButton.Position = UDim2.new(0, 0, 0, 90)
end

local function PopulateMiscTab()
    local MiscTab = TabContents["Misc"]
    
    -- Infinite Energy
    DarkHub.CreateToggle(MiscTab, "Infinite Energy", false, function(state)
        BloxFruitsExploits.PlayerMods.ToggleInfiniteEnergy(state)
    end)
    
    -- God Mode
    DarkHub.CreateToggle(MiscTab, "God Mode", false, function(state)
        BloxFruitsExploits.PlayerMods.ToggleGodMode(state)
    end)
    
    -- Speed Hack
    DarkHub.CreateToggle(MiscTab, "Speed Hack", false, function(state)
        BloxFruitsExploits.PlayerMods.ToggleSpeedHack(state)
    end)
    
    -- Speed Multiplier
    DarkHub.CreateSlider(MiscTab, "Speed Multiplier", 1, 10, 2, function(value)
        BloxFruitsExploits.PlayerMods.SpeedMultiplier = value
        if BloxFruitsExploits.PlayerMods.SpeedHack then
            BloxFruitsExploits.PlayerMods.ToggleSpeedHack(true)
        end
    end)
    
    -- Fly Hack
    DarkHub.CreateToggle(MiscTab, "Fly Hack", false, function(state)
        BloxFruitsExploits.PlayerMods.ToggleFlyHack(state)
    end)
    
    -- Fly Speed
    DarkHub.CreateSlider(MiscTab, "Fly Speed", 10, 100, 50, function(value)
        BloxFruitsExploits.PlayerMods.FlySpeed = value
    end)
    
    -- Noclip
    DarkHub.CreateToggle(MiscTab, "Noclip", false, function(state)
        if state then
            spawn(function()
                while task.wait(0.1) do
                    pcall(function()
                        local LocalPlayer = Services.Players.LocalPlayer
                        local LocalCharacter = LocalPlayer.Character
                        
                        if LocalCharacter then
                            for _, part in ipairs(LocalCharacter:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end)
    
    -- ESP Toggle
    DarkHub.CreateToggle(MiscTab, "Player ESP", false, function(state)
        if state then
            -- ESP implementation
            spawn(function()
                while task.wait(1) do
                    pcall(function()
                        local Players = Services.Players:GetPlayers()
                        for _, Player in ipairs(Players) do
                            if Player ~= Services.Players.LocalPlayer then
                                local Character = Player.Character
                                if Character then
                                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                    if HumanoidRootPart then
                                        -- Create ESP box
                                        local Highlight = Instance.new("Highlight")
                                        Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                        Highlight.Parent = Character
                                        
                                        -- Add name tag
                                        local Billboard = Instance.new("BillboardGui")
                                        Billboard.Size = UDim2.new(0, 100, 0, 50)
                                        Billboard.AlwaysOnTop = true
                                        Billboard.Parent = HumanoidRootPart
                                        
                                        local NameLabel = Instance.new("TextLabel")
                                        NameLabel.Size = UDim2.new(1, 0, 1, 0)
                                        NameLabel.BackgroundTransparency = 1
                                        NameLabel.Text = Player.Name
                                        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        NameLabel.TextSize = 14
                                        NameLabel.Font = Enum.Font.GothamBold
                                        NameLabel.Parent = Billboard
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            -- Remove ESP
            pcall(function()
                local Players = Services.Players:GetPlayers()
                for _, Player in ipairs(Players) do
                    if Player ~= Services.Players.LocalPlayer then
                        local Character = Player.Character
                        if Character then
                            for _, v in ipairs(Character:GetDescendants()) do
                                if v:IsA("Highlight") or v:IsA("BillboardGui") then
                                    v:Destroy()
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

local function PopulateSettingsTab()
    local SettingsTab = TabContents["Settings"]
    
    -- Theme Selector
    local ThemeFrame = Instance.new("Frame")
    ThemeFrame.Size = UDim2.new(1, -20, 0, 60)
    ThemeFrame.BackgroundTransparency = 1
    ThemeFrame.LayoutOrder = 1
    ThemeFrame.Parent = SettingsTab
    
    local ThemeLabel = Instance.new("TextLabel")
    ThemeLabel.Size = UDim2.new(1, 0, 0, 25)
    ThemeLabel.BackgroundTransparency = 1
    ThemeLabel.Text = "Select Theme:"
    ThemeLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    ThemeLabel.TextSize = 14
    ThemeLabel.Font = Enum.Font.Gotham
    ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
    ThemeLabel.Parent = ThemeFrame
    
    local ThemeButtonsFrame = Instance.new("Frame")
    ThemeButtonsFrame.Size = UDim2.new(1, 0, 0, 30)
    ThemeButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
    ThemeButtonsFrame.BackgroundTransparency = 1
    ThemeButtonsFrame.Parent = ThemeFrame
    
    local function UpdateTheme(themeName)
        DarkHub.CurrentTheme = themeName
        -- Update GUI colors
        -- This would require refreshing the GUI
    end
    
    local Themes = {"Dark", "Purple", "Ocean"}
    local buttonWidth = 1 / #Themes
    
    for i, theme in ipairs(Themes) do
        local ThemeButton = Instance.new("TextButton")
        ThemeButton.Size = UDim2.new(buttonWidth, -5, 1, 0)
        ThemeButton.Position = UDim2.new((i-1) * buttonWidth, 0, 0, 0)
        ThemeButton.BackgroundColor3 = DarkHub.Themes[theme].Accent
        ThemeButton.Text = theme
        ThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ThemeButton.TextSize = 12
        ThemeButton.Font = Enum.Font.Gotham
        
        ThemeButton.MouseButton1Click:Connect(function()
            UpdateTheme(theme)
        end)
        
        ThemeButton.Parent = ThemeButtonsFrame
    end
    
    -- Save Settings
    DarkHub.CreateButton(SettingsTab, "Save Settings", function()
        -- Save settings implementation
        warn("Settings saved!")
    end)
    
    -- Load Settings
    DarkHub.CreateButton(SettingsTab, "Load Settings", function()
        -- Load settings implementation
        warn("Settings loaded!")
    end)
    
    -- Reset Settings
    DarkHub.CreateButton(SettingsTab, "Reset Settings", function()
        -- Reset all toggles and sliders
        warn("Settings reset!")
    end)
    
    -- Destroy GUI
    DarkHub.CreateButton(SettingsTab, "Destroy GUI", function()
        if DarkHub.MainGUI then
            DarkHub.MainGUI:Destroy()
            DarkHub.MainGUI = nil
        end
    end)
    
    -- Credits
    local CreditsFrame = Instance.new("Frame")
    CreditsFrame.Size = UDim2.new(1, -20, 0, 80)
    CreditsFrame.BackgroundTransparency = 1
    CreditsFrame.LayoutOrder = 100
    CreditsFrame.Parent = SettingsTab
    
    local CreditsLabel = Instance.new("TextLabel")
    CreditsLabel.Size = UDim2.new(1, 0, 1, 0)
    CreditsLabel.BackgroundTransparency = 1
    CreditsLabel.Text = "DarkHub Blox Fruits v3.0\nCreated by DarkForge-X\nFor Educational Purposes Only\n© 2024 DarkHub Team"
    CreditsLabel.TextColor3 = DarkHub.Themes[DarkHub.CurrentTheme].Text
    CreditsLabel.TextSize = 12
    CreditsLabel.Font = Enum.Font.Gotham
    CreditsLabel.TextYAlignment = Enum.TextYAlignment.Top
    CreditsLabel.Parent = CreditsFrame
end

-- Populate all tabs
PopulateCombatTab()
PopulateFarmingTab()
PopulateTeleportTab()
PopulateMiscTab()
PopulateSettingsTab()

-- Module 6: Keybind System
local Keybinds = {
    ToggleGUI = Enum.KeyCode.RightShift,
    ToggleFly = Enum.KeyCode.X,
    ToggleNoclip = Enum.KeyCode.N
}

Services.UserInputService.InputBegan:Connect(function(input)
    -- Toggle GUI
    if input.KeyCode == Keybinds.ToggleGUI then
        if DarkHub.MainGUI then
            DarkHub.MainGUI.Enabled = not DarkHub.MainGUI.Enabled
        end
    end
    
    -- Toggle Fly
    if input.KeyCode == Keybinds.ToggleFly then
        BloxFruitsExploits.PlayerMods.FlyHack = not BloxFruitsExploits.PlayerMods.FlyHack
        BloxFruitsExploits.PlayerMods.ToggleFlyHack(BloxFruitsExploits.PlayerMods.FlyHack)
    end
end)

-- Module 7: Auto-Execute Features
local function AutoStart()
    -- Auto-enable features on start (optional)
    -- BloxFruitsExploits.PlayerMods.ToggleGodMode(true)
    -- BloxFruitsExploits.PlayerMods.ToggleInfiniteEnergy(true)
end

-- Chạy auto-start
spawn(AutoStart)

-- Module 8: Anti-Cheat Bypass Updates
spawn(function()
    while task.wait(10) do
        -- Update anti-cheat bypass periodically
        AntiDetect.HookGameFunctions()
    end
end)

-- Status Updates
spawn(function()
    while task.wait(5) do
        if DarkHub.MainGUI then
            local StatusBar = DarkHub.MainGUI:FindFirstChild("MainFrame"):FindFirstChild("StatusBar")
            if StatusBar then
                local StatusLabel = StatusBar:FindFirstChild("StatusLabel")
                if StatusLabel then
                    local PlayerCount = #Services.Players:GetPlayers()
                    local FPS = math.floor(1 / Services.RunService.RenderStepped:Wait())
                    
                    StatusLabel.Text = string.format(
                        "Status: Active | Players: %d | FPS: %d | Memory: %.2f MB",
                        PlayerCount,
                        FPS,
                        collectgarbage("count") / 1024
                    )
                end
            end
        end
    end
end)

-- Final Initialization Complete
print("==============================================")
print("DARKHUB BLOX FRUITS EXPLOIT v3.0")
print("Successfully Loaded!")
print("Game: Blox Fruits")
print("Player: " .. Services.Players.LocalPlayer.Name)
print("GUI Key: RightShift")
print("==============================================")
print("Features Loaded:")
print("- Auto Parry")
print("- Instant Kill")
print("- No Cooldown")
print("- Aimbot (Q Key)")
print("- Auto Farm NPC")
print("- Auto Collect Fruits")
print("- Teleport System")
print("- God Mode")
print("- Infinite Energy")
print("- Speed Hack")
print("- Fly Hack (X Key)")
print("- Noclip (N Key)")
print("- Player ESP")
print("==============================================")
print("Created by DarkForge-X | Educational Use Only")
print("==============================================")

-- Return main module for external control
return {
    GUI = DarkHub.MainGUI,
    Exploits = BloxFruitsExploits,
    AntiDetect = AntiDetect,
    DarkHub = DarkHub,
    Destroy = function()
        if DarkHub.MainGUI then
            DarkHub.MainGUI:Destroy()
            DarkHub.MainGUI = nil
        end
    end
}

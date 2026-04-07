local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = ScreenGui
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LoadingFrame.ZIndex = 1000

local CornerLoad = Instance.new("UICorner")
CornerLoad.Parent = LoadingFrame
CornerLoad.CornerRadius = UDim.new(0, 6)

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 0.1, 0)
LoadingText.Position = UDim2.new(0, 0, 0.4, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading"
LoadingText.TextScaled = true
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.TextColor3 = Color3.fromRGB(255,255,255)
LoadingText.ZIndex = 1001

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Parent = LoadingFrame
LoadingBarBG.Size = UDim2.new(0.6, 0, 0.03, 0)
LoadingBarBG.Position = UDim2.new(0.2, 0, 0.55, 0)
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadingBarBG.ZIndex = 1001

local CornerBarBG = Instance.new("UICorner")
CornerBarBG.Parent = LoadingBarBG
CornerBarBG.CornerRadius = UDim.new(0, 6)

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBG
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(255,255,255)
LoadingBar.ZIndex = 1002

local CornerBar = Instance.new("UICorner")
CornerBar.Parent = LoadingBar
CornerBar.CornerRadius = UDim.new(0, 6)

local Gradient = Instance.new("UIGradient")
Gradient.Parent = LoadingBar
Gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 255))
})

task.spawn(function()
	local duration = 12
	local steps = 240
	local waitTime = duration / steps

	for i = 1, steps do
		LoadingBar.Size = UDim2.new(i/steps, 0, 1, 0)

		local dots = string.rep(".", (i % 3) + 1)
		LoadingText.Text = "Loading" .. dots

		LoadingBar.BackgroundTransparency = math.sin(i/10) * 0.2
		Gradient.Offset = Vector2.new(i/steps * 0.3, 0)

		task.wait(waitTime)
	end

	LoadingFrame:Destroy()
end)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0.92, 0, 0.92, 0)
MainFrame.Position = UDim2.new(0.04, 0, 0.04, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 100

local CornerMain = Instance.new("UICorner")
CornerMain.Parent = MainFrame
CornerMain.CornerRadius = UDim.new(0, 6)

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Parent = MainFrame
UIStrokeMain.Thickness = 3
UIStrokeMain.Color = Color3.fromRGB(170, 0, 255)
UIStrokeMain.Transparency = 0.3

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0, 260, 0, 70)
ToggleButton.Position = UDim2.new(0.5, -130, 0.5, -35)
ToggleButton.Text = "auto duel joiner"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.ZIndex = 200

local CornerBtn = Instance.new("UICorner")
CornerBtn.Parent = ToggleButton
CornerBtn.CornerRadius = UDim.new(0, 6)

local UIStrokeBtn = Instance.new("UIStroke")
UIStrokeBtn.Parent = ToggleButton
UIStrokeBtn.Thickness = 2
UIStrokeBtn.Color = Color3.fromRGB(255,255,255)
UIStrokeBtn.Transparency = 0.5

local CloseFake = Instance.new("TextButton")
CloseFake.Parent = MainFrame
CloseFake.Size = UDim2.new(0, 18, 0, 18)
CloseFake.Position = UDim2.new(1, -22, 0, 6)
CloseFake.Text = "×"
CloseFake.TextScaled = true
CloseFake.Font = Enum.Font.SourceSansBold
CloseFake.BackgroundTransparency = 1
CloseFake.TextColor3 = Color3.fromRGB(180, 180, 180)
CloseFake.ZIndex = 400

local ActivityText = Instance.new("TextLabel")
ActivityText.Parent = MainFrame
ActivityText.Size = UDim2.new(0, 320, 0, 20)
ActivityText.Position = UDim2.new(0.5, -160, 0.5, 45)
ActivityText.BackgroundTransparency = 1
ActivityText.TextSize = 14
ActivityText.Font = Enum.Font.Code
ActivityText.TextColor3 = Color3.fromRGB(200, 200, 200)
ActivityText.TextTransparency = 0.2
ActivityText.Text = ""
ActivityText.Visible = false
ActivityText.ZIndex = 300

local isOn = false

ToggleButton.MouseButton1Click:Connect(function()
	isOn = not isOn

	if isOn then
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 140, 40)
		ActivityText.Visible = true
	else
		ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
		ToggleButton.Text = "auto duel joiner"
		ActivityText.Visible = false
		ActivityText.Text = ""
	end
end)

local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

local function randomString(len)
	local result = table.create(len)
	for i = 1, len do
		local rand = math.random(1, #chars)
		result[i] = chars:sub(rand, rand)
	end
	return table.concat(result)
end

task.spawn(function()
	local dots = 0
	while true do
		if isOn then
			dots = (dots % 3) + 1
			ToggleButton.Text = "looking server" .. string.rep(".", dots)
			task.wait(0.5)
		else
			task.wait(0.2)
		end
	end
end)

task.spawn(function()
	while true do
		if isOn then
			ActivityText.Text = randomString(20)
			task.wait(math.random(10, 60) / 100)
		else
			task.wait(0.2)
		end
	end
end)

task.spawn(function()
	task.wait(120)

	MainFrame:ClearAllChildren()

	local Message = Instance.new("TextLabel")
	Message.Parent = MainFrame
	Message.Size = UDim2.new(1, 0, 1, 0)
	Message.BackgroundTransparency = 1
	Message.TextScaled = true
	Message.Font = Enum.Font.SourceSansBold
	Message.TextColor3 = Color3.fromRGB(255,255,255)
	Message.Text = "        not found!\n管理者にお問い合わせください。"
	Message.ZIndex = 500
end)

print("GUI Loaded")

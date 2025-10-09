local RunService = game:GetService("RunService")

local screenGUI = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local shutdownButton = Instance.new("TextButton")
local UIDragDetector = Instance.new("UIDragDetector")
local UIListLayout = Instance.new("UIListLayout")

local AMOUNTOFLABELS = 0
local SHUTDOWN = false

local Character = game.Players.LocalPlayer.Character
local hrp = Character:FindFirstChild("HumanoidRootPart")
local humanoid = Character:FindFirstChildOfClass("Humanoid")

local function createLabelAndWatchValue(parentInstance: Instance, valueToWatch: string)
	AMOUNTOFLABELS = AMOUNTOFLABELS + 1
	
	local newLabel = Instance.new("TextLabel")
	newLabel.BackgroundTransparency = 1
	newLabel.Size = UDim2.new(1, 0, 1 / AMOUNTOFLABELS, 0)
	newLabel.Parent = Frame
	newLabel.TextColor3 = Color3.new(1, 1, 1)
	newLabel.TextScaled = true
	
	local watch
	
	if valueToWatch == "STATES" then
		watch = RunService.Heartbeat:Connect(function(deltaTime: number)
			newLabel.Text = "Humanoid State: " .. tostring(parentInstance:GetState())
		end)
	else
		watch = RunService.Heartbeat:Connect(function(deltaTime: number)
			newLabel.Text = tostring(valueToWatch) .. ": " .. tostring(parentInstance[valueToWatch])
		end)
	end
	
	if SHUTDOWN then
		watch:Disconnect()
	end
end

-- edit screenGUI
screenGUI.Parent = game.Players.LocalPlayer.PlayerGui
screenGUI.Name = "AWESOME TAS DISPLAY!!!"

-- edit frame
Frame.Parent = screenGUI
Frame.Size = UDim2.new(0.2, 0, 0.3, 0)
Frame.Style = Enum.FrameStyle.DropShadow

-- edit drag detector
UIDragDetector.Parent = Frame

-- edit UI List Layout
UIListLayout.FillDirection = Enum.FillDirection.Vertical

-- edit shutdown button
shutdownButton.Parent = Frame
shutdownButton.BackgroundTransparency = 0.5
shutdownButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
shutdownButton.Size = Vector3.new(1, 0, 0.1, 0)
shutdownButton.TextScaled = true
shutdownButton.TextColor3 = Color3.new(1, 1, 1)

shutdownButton.MouseButton1Click:Once(function()
	SHUTDOWN = true
	screenGUI:Destroy()
end)

-- create labels
createLabelAndWatchValue(hrp, "Anchored")
createLabelAndWatchValue(hrp, "AssemblyLinearVelocity")
createLabelAndWatchValue(hrp, "AssemblyAngularVelocity")
createLabelAndWatchValue(humanoid, "STATES")

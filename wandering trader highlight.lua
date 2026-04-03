local WS = workspace
local Folder = WS:WaitForChild("DialogNPCs"):WaitForChild("Normal")
local cache = {}
local function add(m)
if not m:IsA("Model") then return end
local p = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart")
if not p then return end
local hl = Instance.new("Highlight")
hl.FillColor, hl.OutlineColor, hl.DepthMode = Color3.fromRGB(0,255,0), Color3.new(1), Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = m
local bg = Instance.new("BillboardGui")
bg.Size = UDim2.new(0,100,0,50)
bg.StudsOffset = Vector3.new(0,3,0)
bg.AlwaysOnTop = true
bg.Adornee = p
bg.Parent = m
local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.new(1)
txt.TextStrokeColor3 = Color3.new(0)
txt.TextStrokeTransparency = 0
txt.Font = Enum.Font.SourceSansBold
txt.TextSize = 14
txt.Text = "0 studs"
txt.Parent = bg
cache[m] = {hl, bg, txt, p}
end
local function remove(m)
if cache[m] then 
cache[m][1]:Destroy()
cache[m][2]:Destroy()
cache[m] = nil 
end
end
for _, m in Folder:GetChildren() do add(m) end
Folder.ChildAdded:Connect(add)
Folder.ChildRemoved:Connect(remove)
local plr = game.Players.LocalPlayer
while task.wait(0.1) do
local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
if root then
for m, c in cache do
if m.Parent and c[4].Parent then
c[3].Text = string.format("%.1f studs", (c[4].Position - root.Position).Magnitude)
else
remove(m)
end
end
end
end
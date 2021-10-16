local TweenService = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local ui = plr.PlayerGui:FindFirstChild("GameUI")
local scorelabel = ui.ScoreLabel
local real = ui.realGameUI
local NewUI = Instance.new("ScreenGui")
NewUI.Parent = plr.PlayerGui
local Frame = Instance.new("Frame")
Frame.Parent = NewUI
Frame.AnchorPoint = Vector2.new(0, 1)
Frame.Position = UDim2.new(0, 0, 1, -95)
Frame.BackgroundTransparency = 1
local Score_TextLabel = Instance.new("TextLabel")
local Score = Instance.new("TextLabel")
local Accuracy = Instance.new("TextLabel")
local Misses = Instance.new("TextLabel")
local Rating = Instance.new("TextLabel")
local RatingB = Instance.new("TextLabel")
local highestCombo = 0;

--local storage for the Tweening (v1A)
local sVal = Instance.new("NumberValue")
local colorP = Instance.new("Color3Value")
local colorS = Instance.new("Color3Value")
local colorA = Instance.new("Color3Value")
local colorB = Instance.new("Color3Value")
local colorC = Instance.new("Color3Value")
local colorD = Instance.new("Color3Value")

local hpBar = {}
hpBar.Image = real.HPBarBG;
hpBar.Missing = real.HPBarBG.RedBar;
hpBar.Health = real.HPBarBG.GreenBar;

function hpBar.SetHealthColor(color)
    hpBar.Health.BackgroundColor3 = color
end
function hpBar.SetMissingColor(color)
    hpBar.Missing.BackgroundColor3 = color
    hpBar.Image.ImageColor3 = color
end

do
    Score_TextLabel.Parent = Frame
    Score_TextLabel.Text = "Score"
    Score_TextLabel.Position = UDim2.new(0, 20, 0, 0)
    Score_TextLabel.BackgroundTransparency = 1
    Score_TextLabel.TextSize = 32
    Score_TextLabel.Font = Enum.Font.Ubuntu
    Score_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    Score_TextLabel.TextColor3 = Color3.new(1, 1, 1)
    Score_TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    Score_TextLabel.TextStrokeTransparency = 0
    Score_TextLabel.Size = UDim2.new(0, 200, 0, 32)
    --
    Score.Parent = Frame
    Score.Text = "---"
    Score.Position = UDim2.new(0, 20, 0, 38)
    Score.BackgroundTransparency = 1
    Score.TextSize = 42
    Score.Font = Enum.Font.Ubuntu
    Score.TextXAlignment = Enum.TextXAlignment.Left
    Score.TextColor3 = Color3.new(1, 1, 1)
    Score.TextStrokeColor3 = Color3.new(0, 0, 0)
    Score.TextStrokeTransparency = 0
    Score.Size = UDim2.new(0, 200, 0, 32)
    --
    Accuracy.Parent = Frame
    Accuracy.Text = "Accuracy : ---%"
    Accuracy.Position = UDim2.new(0, 80, 0, -30)
    Accuracy.BackgroundTransparency = 1
    Accuracy.TextSize = 24
    Accuracy.Font = Enum.Font.Ubuntu
    Accuracy.TextXAlignment = Enum.TextXAlignment.Left
    Accuracy.TextColor3 = Color3.new(1, 1, 1)
    Accuracy.TextStrokeColor3 = Color3.new(0, 0, 0)
    Accuracy.TextStrokeTransparency = 0.5
    Accuracy.Size = UDim2.new(0, 200, 0, 32)
    --
    Misses.Parent = Frame
    Misses.Text = "Combo Breaks : 0"
    Misses.Position = UDim2.new(0, 80, 0, -60)
    Misses.BackgroundTransparency = 1
    Misses.TextSize = 24
    Misses.Font = Enum.Font.Ubuntu
    Misses.TextXAlignment = Enum.TextXAlignment.Left
    Misses.TextColor3 = Color3.new(1, 1, 1)
    Misses.TextStrokeColor3 = Color3.new(0, 0, 0)
    Misses.TextStrokeTransparency = 0.5
    Misses.Size = UDim2.new(0, 200, 0, 32)
    --
    Rating.Parent = Frame
    Rating.Text = "-"
    Rating.Position = UDim2.new(0, 20, 0, -50)
    Rating.BackgroundTransparency = 1
    Rating.TextSize = 64
    Rating.Font = Enum.Font.GothamBlack
    Rating.TextColor3 = Color3.new(1, 1, 1)
    Rating.TextStrokeColor3 = Color3.new(0, 0, 0)
    Rating.TextStrokeTransparency = 0.3
    Rating.Size = UDim2.new(0, 50, 0, 50)
    Rating.TextYAlignment = Enum.TextYAlignment.Bottom
    --
    RatingB.Parent = Frame
    RatingB.Text = "(---)"
    RatingB.Position = UDim2.new(0, 20, 0, -19)
    RatingB.BackgroundTransparency = 1
    RatingB.TextSize = 16
    RatingB.Font = Enum.Font.GothamSemibold
    RatingB.TextColor3 = Color3.new(1, 1, 1)
    RatingB.TextStrokeColor3 = Color3.new(0, 0, 0)
    RatingB.TextStrokeTransparency = 0.3
    RatingB.Size = UDim2.new(0, 50, 0, 19)
    RatingB.TextYAlignment = Enum.TextYAlignment.Bottom
    --
    -- VERSION 1A STUFF
    sVal.Value = 0;
    colorP.Value = Color3.new(0,0.666667,1);
    colorS.Value = Color3.new(1,1,0.498039);
    colorA.Value = Color3.new(1,0.666667,0);
    colorB.Value = Color3.new(1,0.466667,0);
    colorC.Value = Color3.new(1,0.231373,0);
    colorD.Value = Color3.new(0.65098,0.65098,0.65098);
end

local function calculateRating(acc, miss)
    local acc = tonumber(string.sub(acc, 1, -2))
    local miss = tonumber(miss)

    --RatingB
    if miss == 0 then
        RatingB.Text = "(FC)"
    elseif miss < 10 then
        RatingB.Text = "(SDCB)"
    else
        RatingB.Text = "(Clear)"
    end

    if acc == 100 then
        Rating.Text = "P"
        Rating.TextColor3 = colorP.Value
    elseif acc > 95 then
        Rating.Text = "S"
        Rating.TextColor3 = colorS.Value
    elseif acc > 90 then
        Rating.Text = "A"
        Rating.TextColor3 = colorA.Value
    elseif acc > 85 then
        Rating.Text = "B"
        Rating.TextColor3 = colorB.Value
    elseif acc > 75 then
        Rating.Text = "C"
        Rating.TextColor3 = colorC.Value
    elseif acc == 0 and sVal.Value == 0 and miss == 0 then
        Rating.Text = "-"
        Rating.TextColor3 = Color3.new(1,1,1);
    else
        Rating.Text = "D"
        Rating.TextColor3 = colorD.Value
    end
end

local function clearHighestCombo()
    highestCombo = 0;
end

local function tweenScore(newscore)
    if newscore == 0 then
        clearHighestCombo()
        sVal.Value = 0
    else
        newscore = newscore/10
        TweenService:Create(sVal,TweenInfo.new(
            0.3, -- Time
            Enum.EasingStyle.Quad, -- EasingStyle
            Enum.EasingDirection.Out -- EasingDirection
        ),{Value = newscore}):Play()
    end
end

sVal:GetPropertyChangedSignal("Value"):Connect(
    function()
       Score.Text = tostring(math.round(sVal.Value)*10) 
    end
)

scorelabel:GetPropertyChangedSignal("Text"):Connect(
    function()
        -- "Score: 232130 | Combo: 128 | Misses: 9 | Accuracy: 97%"
        --	1	   2	  3 4	   5   6 7       8 9 10        11
        local st = string.split(scorelabel.Text, " ")
        tweenScore(tonumber(st[2]))
        Accuracy.Text = "Accuracy : " .. st[11]
        Misses.Text = "Combo Breaks : " .. st[8]
        calculateRating(st[11], st[8])
    end
)

scorelabel.Visible = false

local ret = {ui = NewUI, hp = hpBar}

function ret.SetRatingColor(rating,color)
    if not rating or not color then return end
    if rating == "P" then
        colorP.Value = color
    elseif rating == "S" then
        colorS.Value = color
    elseif rating == "A" then
        colorA.Value = color
    elseif rating == "B" then
        colorB.Value = color
    elseif rating == "C" then
        colorC.Value = color
    elseif rating == "D" then
        colorD.Value = color
    end
end

return ret

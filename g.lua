local Blacklib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jmesfo0/RobloxUI/main/blacktrap"))()
local Win = Blacklib:Window()

--// PSX Bypass
local lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local TeleportService = game:GetService("TeleportService")
local functions = Network.Fire, Network.Invoke
local old;
old = hookfunction(getupvalue(functions, 1) , function(...) return true end)

--// GUI Tabs
local Main_Home = Win:Tab("• Home", "rbxassetid://8825667942")
local Home = Main_Home:NewSection("Home")

local Main_PLayer = Win:Tab("• Player", "2795572803")

local Main_AutoFarm = Win:Tab("• AutoFarm", nil)



Time = Home:Label("Server Time")
Client = Home:Label("User")

local flags = {
    fruitsniper = false;
    diamondsniper = false;
    autofarm = false;
    autotripleegg = false;
    autooctoegg = false;
    removeegganimation = false;
}

local config = {
    area = nil;
    egg = nil;
    teleport = nil;
}


--// Home
Home:Label("Credits to itstermoh")
Home:Line()
Home:Button("Copy Discord Link",function()
	setclipboard("https://discord.gg/zDWMm7vUcT")
end)


--// Player
local Player = Main_PLayer:NewSection("Player")
Player:Slider("WalkSpeed", 0, 300, 1, function(v)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
Player:Slider("JumpBoost", 0, 300, 1, function(v)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)


--// AutoFarm
local AutoFarm = Main_AutoFarm:NewSection("AutoFarm")
AutoFarm:Label("This is the section dedicated to AutoFarms")
AutoFarm:Line()
local farmingareas = {
    'Town', 'Forest', 'Beach', 'Mine', 'Winter', 'Glacier', 'Desert',
        'Volcano', -- Spawn World
        'Enchanted Forest', 'Ancient Island', 'Samurai Island', 'Candy Island',
        'Haunted Island', 'Hell Island', 'Heaven Island', -- Fantasy World
        'Ice Tech', 'Tech City', 'Dark Tech', 'Steampunk', 'Alien Lab',
        'Alien Forest', 'Glitch', "Hacker Portal", -- Tech World
        'Axolotl Ocean', 'Axolotl Deep Ocean', 'Axolotl Cave', -- Axolotl World
        'Pixel Forest', 'Pixel Kyoto', 'Pixel Alps', 'Pixel Vault', -- Pixel World
        'Cat Paradise', 'Cat Backyard', 'Cat Taiga', 'Cat Kingdom', -- Cat World
        'Doodle Meadow', 'Doodle Peaks', 'Doodle Farm', 'Doodle Oasis', 'Doodle Woodlands', 'Doodle Safari', 'Doodle Fairyland', 'Doodle Cave', -- Doodle World
        'Kawai Village', 'Kawaii Candyland', 'Kawaii Temple' -- Kawaii World
}
AutoFarm:Dropdown("Select Area", "None", farmingareas, function(v)
    config.area = v
end)
AutoFarm:Toggle("AutoFarm", false, function(v)
    flags.autofarm = v
    if v then
        local area = config.area
        local function autofarm()
            function JoinCoin(Coinid, PetTable)
                if Coinid ~= nil and PetTable ~= nil then
                    lib.Network.Invoke("Join Coin", Coinid, PetTable)
                end
            end
            
            function FarmCoin(Coinid, PetTable)
                if Coinid ~= nil and PetTable ~= nil then
                    for i, v in pairs(PetTable) do
                        lib.Network.Fire("Farm Coin", Coinid, v)
                    end
                end
            end
            
            function GetPetsTable()
                local PetsEquipped = {}
                for i, v in pairs(lib.PetCmds.GetEquipped()) do
                    table.insert(PetsEquipped, v.uid)
                end
                return PetsEquipped
            end

            for i, v in pairs(lib.Network.Invoke("Get Coins")) do
                if v.a == area then
                    Coinid = i
                    if Coinid ~= nil then
                        JoinCoin(Coinid, GetPetsTable())
                        FarmCoin(Coinid, GetPetsTable())
                    end
                end
            end
        end
        while flags.autofarm == true do
            wait(0.35)
            autofarm()
        end
    end
end)
AutoFarm:NewSection("Snipers")
AutoFarm:Toggle("Fruits Sniper", false, function(v)
    flags.fruitsniper = v
        if v then
            function JoinCoin(Coinid, PetTable)
                if Coinid ~= nil and PetTable ~= nil then
                    lib.Network.Invoke("Join Coin", Coinid, PetTable)
                end
            end
            
            function FarmCoin(Coinid, PetTable)
                if Coinid ~= nil and PetTable ~= nil then
                    for i, v in pairs(PetTable) do
                        lib.Network.Fire("Farm Coin", Coinid, v)
                    end
                end
            end
            
            function GetPetsTable()
                local PetsEquipped = {}
                for i, v in pairs(lib.PetCmds.GetEquipped()) do
                    table.insert(PetsEquipped, v.uid)
                end
                return PetsEquipped
            end
            
            local function fruitsniper()
                for i, v in pairs(lib.Network.Invoke("Get Coins")) do
                    if v.n:match("Orange") or v.n:match("Pear") or v.n:match("Apple") or v.n:match("Ananas") or v.n:match("Banana") or v.n == "Rainbow Fruit" then
                        Coinid = i
                        if Coinid ~= nil then
                            JoinCoin(Coinid, GetPetsTable())
                            FarmCoin(Coinid, GetPetsTable())
                        end
                    end
                end
            end
            while flags.fruitsniper == true do
                wait(0.30)
                fruitsniper()
            end
        end
end)


--[[
--//Add Dropdown
Home:Dropdown("Select item", Config.Dropdown, Config.DropdownItems, function(Value)
	Config.Dropdown = Value
	print('Selected:', Value)
end)

--//Add Toggle
Home:Toggle("This is a toggle", Config.Toggle, function(Value)
	Config.Toggle = Value
	print('Toggle:', Value)
end)

--//Add Text Box
Home:Label("Type and press ENTER to set value")
Home:TextBox("This is a textbox", Config.TextBox, function(Value)
	Config.TextBox = Value
	print('Text Box Value:', Value)
end)

--//Destroy Gui Button
Home:Button("Destroy Gui", function()
	game:GetService("CoreGui"):FindFirstChild("BlackTrap"):Destroy()
end)

--//Add Slider
Home:Slider("This is a slider", 0, 10, Config.Slider, function(Value)
	Config.Slider = Value
	print('Slider Value:', Value)
end)

--//Keybind
Home:Bind("Set key to hide/show menu", Config.Bind, function()
	Minimize()
end)

--//Initialize TestTable
for i=1,100 do
	table.insert(Config.TestTable, "This is a test entry for a list.")
end


--//Add Paragraph
local Paragraph = Home:CreateParagraph({Title = "Paragraph", Content = "\n"})

--//Set SaveNumber
local SaveNumber = #Config.TestTable + 1

--//Set Paragraph
if #Config.TestTable > 1 then
    local TempTable = {}
    for i,v in pairs(Config.TestTable) do
        table.insert(TempTable, "["..i.."] "..v)
    end
	Paragraph:Set({Title = "Paragraph", Content = table.concat(TempTable, "\n")})
end

--// TextBox
Home:TextBox("Enter Text", Config.Entry, function(Value)
	Config.Entry = Value
end)

--// Button
Home:Button("Add Entry", function()
	Config.TestTable[SaveNumber] = Config.Entry
	local TempTable = {}
	for i,v in pairs(Config.TestTable) do
		table.insert(TempTable, "["..i.."] "..v)
	end
	Paragraph:Set({Title = "Paragraph", Content = table.concat(TempTable, "\n")})
	SaveNumber = #Config.TestTable + 1
end)

--// TextBox
Home:TextBox("Entry # to Delete", Config.DeleteNumber, function(Value)
	Config.DeleteNumber = Value
end)

--// Button
Home:Button("Delete Entry", function()
	local ListToReAdd = {}
	for i,v in pairs(Config.TestTable) do
		task.spawn(function()
			if i ~= tonumber(Config.DeleteNumber) then
				table.insert(ListToReAdd, v) 
			end
		end)
	end
	Config.TestTable = ListToReAdd
	local TempTable = {}
	for i,v in pairs(Config.TestTable) do
		table.insert(TempTable, "["..i.."] "..v)
	end
	Paragraph:Set({Title = "Paragraph", Content = table.concat(TempTable, "\n")})
	SaveNumber = #TempTable + 1
end)


--//Keybind Function
local menutoggle = false
function Minimize()
	if menutoggle == false then
		menutoggle = true
		game:GetService("CoreGui").BlackTrap.Points.WindowFrame.Visible = false
	else
		menutoggle = false
		game:GetService("CoreGui").BlackTrap.Points.WindowFrame.Visible = true
	end
end

--//Update Timer
function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime+0.5)
    local Hour = math.floor(GameTime/(60^2))%24
    local Minute = math.floor(GameTime/(60^1))%60
    local Second = math.floor(GameTime/(60^0))%60
    Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
end

task.spawn(function()
    while true do task.wait(.3)
        UpdateTime()
    end
end)

--//Update FPS and Ping
function UpdateClient()
    local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local Fps = workspace:GetRealPhysicsFPS()
    Client:Refresh("Fps : "..Fps.." Ping : "..Ping)
end

task.spawn(function()
    while true do task.wait(.3)
        UpdateClient()
    end
end)
]]

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
local Main_PLayer = Win:Tab("• Player", "rbxassetid://2795572803")
local Main_AutoFarm = Win:Tab("• AutoFarm", "")
local Main_Eggs = Win:Tab("• AutoEggs", "")
local Main_Pets = Win:Tab("• Pets", "")
local Main_Teleport = Win:Tab("• Teleport", "")
local Main_Misc = Win:Tab("• Miscs", "")
local Main_Settings = Win:Tab("• Settings",  "")


local Home = Main_Home:NewSection("Home")
Time = Home:Label("Server Time")
function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime+0.5)
    local Hour = math.floor(GameTime/(60^2))%24
    local Minute = math.floor(GameTime/(60^1))%60
    local Second = math.floor(GameTime/(60^0))%60
    Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
end

Client = Home:Label("User")
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

local flags = {
    autoenchant = false;
    pinatasniper = false;
    fruitsniper = false;
    diamondsniper = false;
    autofarm = false;
    farmnearest = false;
    farmmultitarget = false;
    autotripleegg = false;
    autooctoegg = false;
    removeegganimation = false;
}

local config = {
    area = nil;
    egg = nil;
    teleport = nil;
    enchant = nil;
    enchantlevel = nil;
}


--// Home
Home:Button("Credits", function()
    Blacklib:Notification("ezPSX", "This gui was made by itstermoh using blacklib modified library")
end)
Home:Button("Copy Discord Link",function()
	setclipboard("https://discord.gg/zDWMm7vUcT")
end)
Home:Button("Destroy Gui", function()
	game:GetService("CoreGui"):FindFirstChild("BlackTrap"):Destroy()
end)


--// Player
local Player = Main_PLayer:NewSection("Player")
Player:Line()
Player:Slider("WalkSpeed", 0, 300, 1, function(v)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
Player:Slider("JumpBoost", 0, 300, 1, function(v)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)


--// AutoFarm
local AutoFarm = Main_AutoFarm:NewSection("AutoFarm")
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
AutoFarm:Toggle("SuperFarm", false, function(v)
    flags.autofarm = v
    if v and config.area ~= nil or "None" then
        local area = config.area
        function JoinCoin(Coinid, PetTable)if Coinid ~= nil and PetTable ~= nil then
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
        function autofarm()
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
            wait(0.15)
            autofarm()
        end
    end
end)
AutoFarm:Toggle("Farm Nearest", false, function(v)
    flags.farmnearest = v
    area = config.area
    if v and config.area ~= nil or "None" then
        function JoinCoin(Coinid, PetTable)if Coinid ~= nil and PetTable ~= nil then
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
        function farmnearest(nearestcoins)
            for i, v in pairs(lib.Network.Invoke("Get Coins")) do
                if v.a == area then
                    Coinid = nearestcoins
                    if Coinid ~= nil then
                        JoinCoin(Coinid, GetPetsTable())
                        FarmCoin(Coinid, GetPetsTable())
                    end
                end
            end
        end
        local nearest
              local NearestOne = 500
              for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
                       if (v.POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= NearestOne then
                           nearest = v
                           NearestOne = (v.POS.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        end
                    end
                    local nearestcoin = nearest.Name
                    while flags.farmnearest == true do
                        wait(0.35)
                        farmnearest(nearestcoin)
                    end
                end
            end)
AutoFarm:Toggle("Multi Target", false, function(v)
    flags.farmmultitarget = v
    if v then
        
    end
end)
local Snipers = Main_AutoFarm:NewSection("Snipers")
Snipers:Toggle("Fruits Sniper", false, function(v)
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
Snipers:Toggle("Pinata Sniper", false, function(v)
    flags.pinatasniper = v
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
        
        local function pinatasniper()
            for i, v in pairs(lib.Network.Invoke("Get Coins")) do
                if v.n == "Pinata" then
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
            pinatasniper()
        end
    end
end)
Snipers:Toggle("Diamond Sniper", false, function(v)
    flags.diamondsniper = v
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
        
        local function diamondsniper()
            for i, v in pairs(lib.Network.Invoke("Get Coins")) do
                if v.n:match("Diamond") then
                    Coinid = i
                    if Coinid ~= nil then
                        JoinCoin(Coinid, GetPetsTable())
                        FarmCoin(Coinid, GetPetsTable())
                    end
                end
            end
        end
        while flags.diamondsniper == true do
            wait(0.3)
            diamondsniper()
        end
    end
end)


--// Eggs
local Eggs = Main_Eggs:NewSection("Auto Eggs")
Eggs:Line()
local eggs = {}
for i,v in pairs(lib.Directory.Eggs) do
    if v.hatchable == true then
        table.insert(eggs, i)
    end
end
Eggs:Dropdown("Select Egg", "None", eggs, function(v)
    config.egg = v
end)
Eggs:Toggle("Auto Egg", false, function(v)
    flags.autoegg = v
        if v then
            local egg = config.egg
            while flags.autotripleegg == true do
                lib.Network.Invoke("Buy Egg", egg, false, false)
        end
    end
end)
Eggs:Toggle("Auto Triple Eggs (Need Gamepass)", false, function(v)
    flags.autoegg = v
        if v then
            local egg = config.egg
            while flags.autotripleegg == true do
                lib.Network.Invoke("Buy Egg", egg, true, false)
        end
    end
end)
Eggs:Toggle("Auto Octo Eggs (Need Gamepass)", false, function(v)
    flags.autoegg = v
        if v then
            local egg = config.egg
            while flags.autotripleegg == true do
                lib.Network.Invoke("Buy Egg", egg, false, true)
        end
    end
end)
Eggs:Toggle("Remove Eggs Animation", false, function(v)
    flags.removeegganimation = v
    if v then
        for i,v in pairs(getgc(true)) do
            if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
                v.OpenEgg = function()
                    return
                end
            end
        end
    end
end)


--// Pets
local Pets = Main_Pets:NewSection("Pets")
Pets:Line()
local enchants = {}
local enchantlevels = {1,2,3,4,5}
for i,v in pairs(lib.Directory.Powers) do
    table.insert(enchants, i)
end
Pets:Dropdown("Choose a Enchant", "None", enchants, function(v)
    config.enchant = v
end)
Pets:Dropdown("Choose a Level", "None", enchantlevels, function(v)
    config.enchantlevel = v
end)
Pets:Toggle("AutoEnchant Equipped Pets", false, function(v)
    flags.autoenchant  = v
    if v then
        local enchant = "Teamwork"
local enchantvalue = 2 -- This is super teamwork
local petid = "id488d020385b1443680f004c3775e990e"

function hasValue(tbl, value)
   for i,v in pairs(tbl) do
       if (v == value) then
           return true;
       end
   end
   return false;
end
function hasInput(tbl, value)
   for i,v in pairs(tbl) do
       if (i == value) then
           return true;
       end
   end
   return false;
end

while flags.autoenchant == true do
for i,v in pairs(lib.Save.Get().Pets) do
   if (hasValue(v, petid)) then
       if (hasInput(v, "powers")) then
           for i,v in pairs(v.powers) do
               if (hasValue(v, config.enchant) and hasValue(v, config.enchantlevel)) then
                   print("Found the enchant: ", unpack(v))
                   flags.autoenchant  = false
               else
                   print("Not yet ", unpack(v))
                   for i,k in pairs(lib.Save.Get().Pets) do
                   local id = {
                    [1] = lib.Directory.Pets[k.id]
                   }
                   lib.Network.Invoke("Enchant Pet", id)
               end
           end
        end
       else
        for i,k in pairs(lib.Directory.Pets) do
           local id = {
               [1] = lib.Directory.Pets[k.id]
           }
           lib.Network.Invoke("Enchant Pet", id)
       end
   end
end
end
wait(0.01)
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

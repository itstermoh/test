-- Check if script2 was loaded through the key system

if not _G.keydone then

  -- Take appropriate action (in this case, print a warning message)

  game.Players.LocalPlayer:Kick("Use the main link")

else
-- Insert the code for script2.lua here

print("Hello from script2.lua")
  end

-- Get the key from the URL query string

local key = game:GetService("HttpService"):UrlDecode(game:GetService("HttpService"):UrlEncode(game.Players.LocalPlayer.Name))

-- Check if the key is valid

if key == "hello" then

  print("Valid key")

  _G.keydone = true -- Set a global variable to indicate that the key has been validated

else

  print("Invalid key")

end

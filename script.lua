-- Check if script2 was loaded through the key system

if not _G.keydone then

  -- Take appropriate action (in this case, print a warning message)

  game.Players.LocalPlayer:Kick("Use the main link")

end

-- Insert the code for script2.lua here

print("Hello from script2.lua")


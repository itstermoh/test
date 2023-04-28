-- Define a function to load script2

function load_script2()

  -- Set a flag indicating that script2 was loaded through the key system

  _G.keydone = true

  

  -- Load script2

  local script2 = loadstring(game:HttpGet(""))()

  if script2 then

    -- Run script2

    script2()

  else

    -- Handle the case where script2 could not be loaded

    print("Error: script2.lua could not be loaded.")

  end

end

-- Call load_script2 to load script2

load_script2()


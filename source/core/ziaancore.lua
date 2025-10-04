
local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/ziaandev/ZiaanHub/refs/heads/main/Source/Core/ZiaanHub2.lua"))()

local URL = Games[game.PlaceId]

if URL then
    loadstring(game:HttpGet(URL))()
else
    warn("Error Bro")
end

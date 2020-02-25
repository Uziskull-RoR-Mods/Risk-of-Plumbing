-- Made by Uziskull

local titleSprites = {
    {
        "Titlescreen",
        Sprite.find("Titlescreen", "vanilla"),
        Sprite.load("Mario_Title_Titlescreen", "sprites/title/fancy_stars", 4, 0, 0)
    },
    {
        "sprTitle", 
        Sprite.find("sprTitle", "vanilla"), 
        Sprite.load("Mario_Title_Title", "sprites/title/logo", 1, 205, 37)
    },
    {
        "Groundstrip",
        Sprite.find("Groundstrip", "vanilla"), 
        Sprite.load("Mario_Title_Groundstrip", "sprites/title/ground", 1, 0, 1)
    }
}

local function swapTitle(normalToMario)
    for i = 1, #titleSprites do
        Sprite.find(titleSprites[i][1]):replace(titleSprites[i][normalToMario and 3 or 2])
    end
end

registercallback("onGameStart", function()
    swapTitle(false)
end)
registercallback("onGameEnd", function()
    swapTitle(true)
end)

swapTitle(true) -- run it once
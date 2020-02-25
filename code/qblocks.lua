-- Made by Uziskull

local objFloor = Object.find("B")
local objNoSpawn = Object.find("BNoSpawn")
local objPlayer = Object.find("P")
local objRope = Object.find("Rope")

function shuffle(tbl)
  size = #tbl
  for i = size, 1, -1 do
    local rand = math.random(i)
    tbl[i], tbl[rand] = tbl[rand], tbl[i]
  end
  return tbl
end

-- Question Block

local qblockToCollisionMap = {}

local sprites = {
    active = Sprite.load("qblock_active", "sprites/qblock", 4, 0, 0),
    used = Sprite.load("qblock_used", "sprites/qblock_used", 1, 0, 0)
}

qblock = Object.new("Question Block")

qblock.sprite = sprites.active

function hitQBlock(qb)
    qb.sprite = sprites.used
    qb:set("animCount", -5)
end

qblock:addCallback("create", function(self)
    self.spriteSpeed = 0.0666
    self:set("used", 0)
end)

qblock:addCallback("step", function(self)
    local stillExists = true

    -- check if mario exists
    if self:get("marioID") == nil then
        for _, p in ipairs(misc.players) do
            if p:getSurvivor().displayName == "Mario" then
                self:set("marioID", p.id)
                break
            end
        end
        if self:get("marioID") == nil then
            local collision = Object.findInstance(qblockToCollisionMap[self.id])
            if collision ~= nil then
                if collision:isValid() then
                    collision:destroy()
                end
            end
            self:destroy()
            stillExists = false
        end
    end
    
    if stillExists then
        -- hitting
        local hit = objPlayer:findLine(self.x, self.y + self.sprite.height + 1, self.x + self.sprite.width - 1, self.y + self.sprite.height + 1)
        if hit ~= nil then
            if hit:isValid() then
                if hit:getSurvivor().displayName == "Mario" and self:get("animCount") == nil then
                    hitQBlock(self)
                end
            end
        end
        
        -- animation
        local anim = self:get("animCount")
        if anim ~= nil then
            local multiplier = 0
            if anim ~= 0 then
                multiplier = anim / math.abs(anim)
            end
            self.y = self.y + multiplier * 1
            local collision = Object.findInstance(qblockToCollisionMap[self.id])
            if collision ~= nil then
                collision.y = collision.y + multiplier * 1
            end
            self:set("animCount", anim + 1)
            
            if self:get("animCount") > 5 then
                self:set("animCount", nil)
                if self:get("used") == 0 then
                    local power = powerup:create(self.x, self.y)
                    power.depth = self.depth + 1
                    power:set("power", getPowerup(Object.findInstance(self:get("marioID")):get("powerupState")))
                    self:set("used", 1)
                end
            end
        end
    end
end)

-- Spawning Blocks

registercallback("onStageEntry", function()
    qblockToCollisionMap = {}
    local floorList = objFloor:findAll()
    local blockNumber, _ = Stage.getDimensions()
    blockNumber = math.floor(blockNumber / 200)
    local blockList = {}
    for i = 1, blockNumber do
        if i <= math.floor(blockNumber / 2) or math.random(3) == 1 then
            blockList[#blockList + 1] = 1
        end
    end
    for i = #blockList, #floorList do
        blockList[i] = 0
    end
    blockList = shuffle(blockList)
    
    for i = 1, #blockList do
        if blockList[i] == 1 then
            local x = floorList[i].x
            local y = floorList[i].y - 48 - 16
            
            local block = qblock:create(x, y)
            if block:collidesMap(x, y) or block:collidesWith(objRope, x, y) then
                block:destroy()
            else
                local collision = objNoSpawn:create(x, y)
                qblockToCollisionMap[block.id] = collision.id
            end
        end
    end
end, 1000)
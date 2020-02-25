-- Made by Uziskull

local objPlayer = Object.find("P")
local objGeyser = Object.find("Geyser")

powerupSprites = {
    Sprite.load("powerup_shroom", "sprites/powerups/shroom", 1, 0, 0),
    Sprite.load("powerup_fire", "sprites/powerups/fire", 1, 0, 0),
    Sprite.load("powerup_cape", "sprites/powerups/cape", 1, 0, 0)
}

--

function dropPowerup(handler, frame)
    local player = Object.findInstance(handler:get("player"))
    if frame == 0 then
        handler.x = player.x
        local _, cameraHeight = graphics.getGameResolution()
        local _, stageHeight = Stage.getDimensions()
        handler.y = 0
        if player.y > cameraHeight / 2 then
            handler.y = player.y - cameraHeight / 2
            if handler.y + cameraHeight > stageHeight then
                handler.y = stageHeight - cameraHeight
            end
        end
        handler.alpha = 0.5
        
        handler:set("sprite", handler:get("powerState") - 1 + handler:get("powerEffect") - 1)
        handler.sprite = powerupSprites[handler:get("sprite")]
    end
    
    if player:collidesWith(handler, player.x, player.y) then
        player:set("powerupStateNew", handler:get("powerState"))
        player:set("powerupEffectNew", handler:get("powerEffect"))
        handler:destroy()
    else
        if frame % 20 == 10 then
            handler.alpha = 0
        elseif frame % 20 == 0 then
            handler.alpha = 0.5
        end
        -- for some reason the handler can't display the sprite, so we drawing it boys
        graphics.drawImage{
            image = powerupSprites[handler:get("sprite")],
            x = handler.x,
            y = handler.y,
            alpha = handler.alpha
        }
        handler.y = handler.y + 1
    end
end

function getPowerup(powerupState)
    if powerupState == 1 then -- small mario
        return 1 -- shroom
    else -- anything else
        return math.random(2, 3)
    end
end

powerup = Object.new("Powerup")

powerup:addCallback("create", function(self)
    self:set("setup", 16):set("speedY", 0):set("geyserCooldown", 0)
    
    -- backup in case it's not set for some reason
    self:set("power", 1)
end)

powerup:addCallback("step", function(self)
    if self.sprite == nil then self.sprite = powerupSprites[self:get("power")] end
    local power = self:get("power")
    if self:get("setup") ~= nil then
        if self:get("setup") == 0 then
        
            -- immediately after the 16 frames wear out
            if power == 1 then
                -- shroom
                local dir = objPlayer:findNearest(self.x, self.y)
                if dir == nil then
                    dir = 1
                else
                    dir = dir:getFacingDirection()
                    if dir == 0 then dir = -1 else dir = 1 end
                end
                self:set("goingTowards", dir)
            elseif power == 2 then
                -- fire
                self:set("goingTowards", 0)
            elseif power == 3 then
                -- cape
                self:set("goingTowards", 16)
            end
            
            self:set("setup", nil)
        else
        
            -- during 16 frames after getting out of block
            if power == 1 or power == 2 then
                -- shroom, fire
                self.y = self.y - 1
            elseif power == 3 then
                -- cape
                self.y = self.y - 5
            end
            
            self:set("setup", self:get("setup") - 1)
        end
    else
        
        local stageW, stageH = Stage.getDimensions()
        
        -- after getting out
        if power == 1 then
            -- shroom
            local grav = 0.26
            local speedX = 5 * 16 / 60    -- 5 blocks per sec
            local maxSpeedY = 15 * 16 / 60 -- 15 blocks per sec
            
            self.x = self.x + self:get("goingTowards") * speedX
            local hitWall = false
            while self:collidesMap(self.x, self.y) do 
                self.x = self.x - self:get("goingTowards") * speedX
                hitWall = true
            end
            if hitWall then
                self:set("goingTowards", self:get("goingTowards") * -1)
            end
            
            if not self:collidesMap(self.x, self.y + 1) then
                self:set("speedY", math.min(self:get("speedY") + grav, maxSpeedY))
            end
            self.y = self.y + self:get("speedY")
            while self:collidesMap(self.x, self.y) do
                self.y = self.y - 1
                self:set("speedY", 0)
            end
            
            if self:get("geyserCooldown") > 0 then self:set("geyserCooldown", self:get("geyserCooldown") - 1) end            
            if self:get("geyserCooldown") == 0 and self:collidesWith(objGeyser, self.x, self.y) then
                self:set("speedY", -12)
                self:set("geyserCooldown", 5)
            end
        elseif power == 2 then
            -- fire
            local grav = 0.26
            local maxSpeedY = 15 * 16 / 60 -- 15 blocks per sec
            
            self:set("goingTowards", self:get("goingTowards") + 1)
            if self:get("goingTowards") == 15 then
                self:set("goingTowards", 0)
                self.xscale = self.xscale * -1
                self.x = self.x - 16 * self.xscale
            end
            
            if not self:collidesMap(self.x, self.y + 1) then
                self:set("speedY", math.min(self:get("speedY") + grav, maxSpeedY))
            end
            self.y = self.y + self:get("speedY")
            while self:collidesMap(self.x, self.y) do
                self.y = self.y - 1
                self:set("speedY", 0)
            end
        elseif power == 3 then
            -- cape
            local grav = 0.26
            
            if self:get("speedY") == 0 then
                local multiplierX = self:get("goingTowards") / 8
                if self:get("goingTowards") == 32 then
                    multiplierX = 1
                end
                local multiplierY = (33 - self:get("goingTowards")) / 32
                if self:get("goingTowards") == 32 then
                    multiplierY = 0
                end
                self.x = self.x + self.xscale * multiplierX
                self.y = self.y + multiplierY
                self:set("goingTowards", self:get("goingTowards") + 1)
                if self:get("goingTowards") == 33 then
                    self:set("goingTowards", 1)
                    self.xscale = self.xscale * -1
                end
            else
                self:set("speedY", math.min(self:get("speedY") + grav, 0))
                self.y = self.y + self:get("speedY")
            end
        end
        
        -- player touches it
        local player = objPlayer:findNearest(self.x, self.y)
        if player ~= nil then
            if player:isValid() then
                if player:getSurvivor().displayName == "Mario" and player:collidesWith(self, player.x, player.y) then
                    local nextState = self:get("power")
                    if nextState == 1 then
                        -- mushroom -> state 2, effect 1 (grown up mario)
                        player:set("powerupStateNew", 2)
                        player:set("powerupEffectNew", 1)
                    elseif nextState == 2 then
                        -- fire -> state 3, effect 1 (fire)
                        player:set("powerupStateNew", 3)
                        player:set("powerupEffectNew", 1)
                    elseif nextState == 3 then
                        -- cape -> state 3, effect 2 (cape)
                        player:set("powerupStateNew", 3)
                        player:set("powerupEffectNew", 2)
                    end
                    self:destroy()
                end
            end
        end
        
        -- out of stage
        if self:isValid() then
            if self.x < 0 - self.sprite.width or self.x > stageW or self.y < 0 - self.sprite.height or self.y > stageH then
                self:destroy()
            end
        end
    end
end)
-- Made by Uziskull

local mario = Survivor.new("Mario")

local baseJumpHeight = 3

local pSpeedAccel = 0.025 -- 0.05
local pSpeedDecel = 0.05
local pSpeedDriftDecel = 0.1

local maxHSpeed = 3 -- 5
local minHSpeed = 1.30

local stompDamage = 5

local fireballDamage = 7.5

local flightBeginBounceSpeed = 5
local flightQuakeSpeed = 3
local floatSpeed = 2
local capeQuakeDamage = 15
local capeSpinDamage = 7.5

------------------------------
-- Sprites, Objects, Sounds --
------------------------------

local sprites = {
    { -- stage 1
        {
            idle = Sprite.load("mario_stage1_idle", "sprites/mario/stage1/idle", 1, 7, 18),
            walk = Sprite.load("mario_stage1_walk", "sprites/mario/stage1/walk", 8, 7, 18),
            run = Sprite.load("mario_stage1_run", "sprites/mario/stage1/run", 8, 7, 18),
            jumpUp = Sprite.load("mario_stage1_jump_up", "sprites/mario/stage1/jump", 1, 7, 18),
            jumpDown = Sprite.load("mario_stage1_jump_down", "sprites/mario/stage1/fall", 1, 7, 18),
            jumpRun = Sprite.load("mario_stage1_jump_run", "sprites/mario/stage1/jump_run", 1, 7, 18),
            climb = Sprite.load("mario_stage1_climb", "sprites/mario/stage1/climb", 2, 7, 18),
            drift = Sprite.load("mario_stage1_drift", "sprites/mario/stage1/drift", 1, 7, 18),
            mask = Sprite.load("mario_stage1_mask", "sprites/mario/stage1/mask", 1, 7, 18)
        }
    },
    { -- stage 2
        {
            idle = Sprite.load("mario_stage2_idle", "sprites/mario/stage2/idle", 1, 7, 26),
            walk = Sprite.load("mario_stage2_walk", "sprites/mario/stage2/walk", 8, 7, 26),
            run = Sprite.load("mario_stage2_run", "sprites/mario/stage2/run", 8, 9, 26),
            jumpUp = Sprite.load("mario_stage2_jump_up", "sprites/mario/stage2/jump", 1, 7, 26),
            jumpDown = Sprite.load("mario_stage2_jump_down", "sprites/mario/stage2/fall", 1, 7, 26),
            jumpRun = Sprite.load("mario_stage2_jump_run", "sprites/mario/stage2/jump_run", 1, 9, 26),
            climb = Sprite.load("mario_stage2_climb", "sprites/mario/stage2/climb", 2, 7, 26),
            drift = Sprite.load("mario_stage2_drift", "sprites/mario/stage2/drift", 1, 7, 26),
            mask = Sprite.load("mario_stage2_mask", "sprites/mario/stage2/mask", 1, 7, 26)
        }
    },
    { -- stage 3
        { -- fire
            idle = Sprite.load("mario_fire_idle", "sprites/mario/stage3/fire/idle", 1, 7, 26),
            walk = Sprite.load("mario_fire_walk", "sprites/mario/stage3/fire/walk", 8, 7, 26),
            run = Sprite.load("mario_fire_run", "sprites/mario/stage3/fire/run", 8, 9, 26),
            jumpUp = Sprite.load("mario_fire_jump_up", "sprites/mario/stage3/fire/jump", 1, 7, 26),
            jumpDown = Sprite.load("mario_fire_jump_down", "sprites/mario/stage3/fire/fall", 1, 7, 26),
            jumpRun = Sprite.load("mario_fire_jump_run", "sprites/mario/stage3/fire/jump_run", 1, 9, 26),
            climb = Sprite.load("mario_fire_climb", "sprites/mario/stage3/fire/climb", 2, 7, 26),
            drift = Sprite.load("mario_fire_drift", "sprites/mario/stage3/fire/drift", 1, 7, 26),
            mask = Sprite.load("mario_fire_mask", "sprites/mario/stage3/fire/mask", 1, 7, 26),
            
            shoot = Sprite.load("mario_fire_shoot", "sprites/mario/stage3/fire/shoot", 2, 7, 26),
            fireball = Sprite.load("mario_fire_fireball", "sprites/mario/stage3/fire/fireball", 4, 3, 3),
            fireballPoof = Sprite.load("mario_fire_fireball_poof", "sprites/mario/stage3/fire/fireball_poof", 4, 0, 0)
        },
        { -- cape
            idle = Sprite.load("mario_cape_idle", "sprites/mario/stage3/cape/idle", 1, 9, 26),
            walk = Sprite.load("mario_cape_walk", "sprites/mario/stage3/cape/walk", 8, 17, 26),
            run = Sprite.load("mario_cape_run", "sprites/mario/stage3/cape/run", 8, 17, 26),
            jumpUp = Sprite.load("mario_cape_jump_up", "sprites/mario/stage3/cape/jump", 1, 17, 26),
            jumpDown = Sprite.load("mario_cape_jump_down", "sprites/mario/stage3/cape/fall", 4, 15, 28),
            jumpRun = Sprite.load("mario_cape_jump_run", "sprites/mario/stage3/cape/jump_run", 4, 16, 26),
            climb = Sprite.load("mario_cape_climb", "sprites/mario/stage3/cape/climb", 2, 7, 26),
            drift = Sprite.load("mario_cape_drift", "sprites/mario/stage3/cape/drift", 1, 17, 26),
            mask = Sprite.load("mario_cape_mask", "sprites/mario/stage3/cape/mask", 1, 7, 26),
            twirl = Sprite.load("mario_cape_twirl", "sprites/mario/stage3/cape/twirl", 8, 17, 26),
            
            -- idleStart = Sprite.load("mario_cape_idleStart", "sprites/mario/stage3/cape/idleStart", 1, 7, 26),
            -- idleEnd = Sprite.load("mario_cape_idleEnd", "sprites/mario/stage3/cape/idleEnd", 1, 7, 26),
            flightUp = Sprite.load("mario_cape_flightUp", "sprites/mario/stage3/cape/flightUp", 1, 16, 26),
            flightStay = Sprite.load("mario_cape_flightStay", "sprites/mario/stage3/cape/flightStay", 1, 16, 26),
            flightDown = Sprite.load("mario_cape_flightDown", "sprites/mario/stage3/cape/flightDown", 4, 11, 38),
        }
    }
}

local sprSkills = Sprite.load("mario_skills", "sprites/mario/skills", 5, 0, 0)
local sprDeath = Sprite.load("mario_death", "sprites/mario/death", 8, 7, 26)
local sprDecoy = Sprite.load("mario_decoy", "sprites/mario/decoy", 1, 7, 23)

local pMeter = {
    sprOut = Sprite.load("mario_p_meter_out", "sprites/p-meter-out", 1, 0, 0),
    sprIn = Sprite.load("mario_p_meter_in", "sprites/p-meter-in", 1, 0, 0)
}
-----------
-- Buffs --
-----------

local saveStats = {}

local powerupTransition = Buff.new("Power Up / Down")
powerupTransition.sprite = sprSkills
powerupTransition.subimage = 2
powerupTransition.frameSpeed = 0

powerupTransition:addCallback("start", function(actor)
    saveStats[actor.id] = {
        pHmax = actor:get("pHmax"),
        pVmax = actor:get("pVmax"),
        pVspeed = actor:get("pVspeed"),
        pGravity1 = actor:get("pGravity1"),
        pGravity2 = actor:get("pGravity2"),
        
        powerupStateOld = actor:get("powerupState"),
        powerupStateNew = actor:get("powerupStateNew"),
        
        powerupEffectOld = actor:get("powerupEffect"),
        powerupEffectNew = actor:get("powerupEffectNew"),
        
        activity = actor:get("activity")
    }
    actor:set("pHmax", 0)
    actor:set("pVmax", 0)
    actor:set("pVspeed", 0)
    actor:set("pGravity1", 0)
    actor:set("pGravity2", 0)
    
    actor:set("canrope", 0)
    actor:set("activity", 69)
end)

powerupTransition:addCallback("step", function(actor, remainingTime)
    if remainingTime > 60 then
        actor:set("pHmax", 0)
        actor:set("pVmax", 0)
        actor:set("pVspeed", 0)
        actor:set("pGravity1", 0)
        actor:set("pGravity2", 0)
        actor:set("canrope", 0)
        actor:set("activity", 69)
        if remainingTime % 15 == 0 then
            actor:set("powerupState", saveStats[actor.id].powerupStateNew)
            actor:set("powerupEffect", saveStats[actor.id].powerupEffectNew)
        elseif remainingTime % 15 == 7 then
            actor:set("powerupState", saveStats[actor.id].powerupStateOld)
            actor:set("powerupEffect", saveStats[actor.id].powerupEffectOld)
        end
    elseif remainingTime == 60 then
        actor:set("powerupState", saveStats[actor.id].powerupStateNew)
        actor:set("powerupEffect", saveStats[actor.id].powerupEffectNew)
        actor:set("pHmax", saveStats[actor.id].pHmax)
        actor:set("pVmax", saveStats[actor.id].pVmax)
        actor:set("pVspeed", saveStats[actor.id].pVspeed)
        actor:set("pGravity1", saveStats[actor.id].pGravity1)
        actor:set("pGravity2", saveStats[actor.id].pGravity2)
        actor:set("canrope", 1)
        actor:set("activity", saveStats[actor.id].activity)
        
        if saveStats[actor.id].powerupStateNew >= saveStats[actor.id].powerupStateOld then
            actor:removeBuff(powerupTransition)
        end
    else -- remainingTime < 60
        if remainingTime % 12 == 0 then
            actor.alpha = 1
        elseif remainingTime % 12 == 4 then
            actor.alpha = 0.5
        elseif remainingTime % 12 == 8 then
            actor.alpha = 0
        end
    end
end)

powerupTransition:addCallback("end", function(actor)
    saveStats[actor.id] = {}
    actor.alpha = 1
end)

-------------
-- Physics --
-------------

local hitEnemiesOnJump = {}

registercallback("onPlayerStep", function(player)
    if player:isValid() and player:getSurvivor().displayName == "Mario" then
        if player:get("hitEnemy") ~= 0 then player:set("hitEnemy", 0) end
    
        -- everything stops if the man's powering up / down
        if not player:hasBuff(powerupTransition) then
        
            -- debug
            if input.checkKeyboard("numpad4") == input.PRESSED then
                player:set("powerupStateNew", 2):set("powerupEffectNew", 1)
            elseif input.checkKeyboard("numpad5") == input.PRESSED then
                player:set("powerupStateNew", 3):set("powerupEffectNew", 1)
            elseif input.checkKeyboard("numpad6") == input.PRESSED then
                player:set("powerupStateNew", 3):set("powerupEffectNew", 2)
            end
        
            -- power up / down
            if player:get("powerupStateNew") ~= 0 then
                if player:get("powerupStateNew") == 1 then
                    -- hurt, changes player
                    player:applyBuff(powerupTransition, 120)
                elseif player:get("powerupStateNew") > player:get("powerupState") or (player:get("powerupStateNew") == player:get("powerupState") and player:get("powerupEffectNew") ~= player:get("powerupEffect")) then
                    -- change the held powerup if player had any
                    if player:get("powerupState") > 1 then
                        player:set("holdingPowerupState", player:get("powerupState"))
                        player:set("holdingPowerupEffect", player:get("powerupEffect"))
                    end
                    -- powerup changes player
                    player:applyBuff(powerupTransition, 120)
                else
                    -- powerup does not change player
                    -- change the held powerup
                    player:set("holdingPowerupState", player:get("powerupStateNew"))
                    player:set("holdingPowerupEffect", player:get("powerupEffectNew"))
                end
                player:set("powerupStateNew", 0)
                player:set("powerupEffectNew", 0)
            end
        
            -- P-speed
            if player:get("pHspeed") ~= 0 and ((player:getFacingDirection() == 0 and player:control("left") == input.PRESSED)
              or (player:getFacingDirection() == 180 and player:control("right") == input.PRESSED)) then
                if player:control("left") == input.PRESSED then
                    player:set("drifting", 1)
                else
                    player:set("drifting", -1)
                end
            end
            
            -- If Mario stops while on the floor, his P-speed goes to 0
            if player:collidesMap(player.x, player.y + 1) and player:control("right") == input.NEUTRAL and player:control("left") == input.NEUTRAL then
                player:set("pHmax", minHSpeed)
                player:set("drifting", 0)
            end
            
            -- Drifting
            if player:get("drifting") ~= 0 then
                if player:get("pHmax") > minHSpeed then
                    player:set("pHmax", player:get("pHmax") - pSpeedDriftDecel)
                    if player:get("pHmax") < minHSpeed then
                        player:set("pHmax", minHSpeed)
                    end
                    player.x = player.x + player:get("pHmax") * player:get("drifting") * 1.5 -- 1x counters the movement in that direction
                    while player:collidesMap(player.x, player.y) do
                        player.x = player.x - player:get("drifting")
                    end
                else
                    player:set("drifting", 0)
                end
            else
                -- running with P-speed
                if player:control("ability1") == input.HELD and player:get("pHspeed") ~= 0 then
                    if player:get("pHmax") < maxHSpeed then
                        player:set("pHmax", player:get("pHmax") + pSpeedAccel)
                        if player:get("pHmax") > maxHSpeed then
                            player:set("pHmax", maxHSpeed)
                        end
                    end
                else
                    if player:get("pHmax") > minHSpeed then
                        player:set("pHmax", player:get("pHmax") - pSpeedDecel)
                        if player:get("pHmax") < minHSpeed then
                            player:set("pHmax", minHSpeed)
                        end
                    end
                end
            end
            
            -- P-speed effect on jump
            -- player:set("pVmax", 3 + player:get("pHmax") / 2)
            player:set("pVmax", baseJumpHeight + ((baseJumpHeight - baseJumpHeight * 1.75) / (minHSpeed - maxHSpeed)) * (player:get("pHmax") - minHSpeed))
            
            -- stomping
            if player:get("pVspeed") > 0 then
                for _, enemy in ipairs(ObjectGroup.find("enemies"):findAll()) do
                    if enemy ~= nil then
                        if enemy:isValid() then
                            if player:collidesWith(enemy, player.x, player.y) then
                                player:set("hitEnemy", 1)
                                --player:fireBullet(player.x, player.y, 270, player.sprite.height - player.sprite.xorigin, 10)
                                player:fireExplosion(player.x - player.sprite.xorigin + player.sprite.width, 
                                                    player.y - player.sprite.yorigin + player.sprite.height,
                                                    player.sprite.width / 19,
                                                    5 / 4,
                                                    stompDamage)
                                if player:control("jump") == input.HELD then
                                    -- player:set("pVspeed", (6 + player:get("pHmax") / 2) * -1)
                                    player:set("pVspeed", -1 * (baseJumpHeight + ((baseJumpHeight - baseJumpHeight * 2.25) / (minHSpeed - maxHSpeed)) * (player:get("pHmax") - minHSpeed)))
                                else
                                    -- player:set("pVspeed", -3.5)
                                    player:set("pVspeed", -1 * baseJumpHeight)
                                end
                                
                                break
                            end
                        end
                    end
                end
            else
                if #hitEnemiesOnJump[player.id] ~= 0 then
                    hitEnemiesOnJump[player.id] = {}
                end
            end
            
        end
    end
end)

registercallback("onHit", function(damager, actorHit, x, y)
    if isa(actorHit, "PlayerInstance") then
        if actorHit:getSurvivor().displayName == "Mario" then
            if not actorHit:hasBuff(powerupTransition) then
                if actorHit:get("powerupState") == 1 then
                    actorHit:kill()
                else
                    actorHit:set("powerupStateNew", 1)
                    actorHit:set("powerupEffectNew", 1)
                    actorHit:set("forceDrop", 1)
                end
            end
        end
    end
    if damager:get("capeSpin") ~= nil then
        if actorHit:get("hitByCape") == nil then
            actorHit:set("hitByCape", damager:get("capeSpin"))
        else
            damager:set("damage", 0)
        end
    end
end)

registercallback("onStep", function()
    -- saturn's code is potat, so this doesn't work actually
    -- for _, enemy in ipairs(ParentObject.find("enemies"):findMatchingOp("hitByCape", "~=", nil)) do
    for _, enemy in ipairs(ParentObject.find("enemies"):findAll()) do
        if enemy:isValid() and enemy:get("hitByCape") ~= nil then
            if enemy:get("hitByCape") == 0 then enemy:set("hitByCape", nil) else enemy:set("hitByCape", enemy:get("hitByCape") - 1) end
        end
    end
end)

registercallback("onPlayerDrawBelow", function(player)
    --graphics.print("grav1: " .. player:get("pGravity1"), player.x, player.y - 24)
    if player:isValid() and player:getSurvivor().displayName == "Mario" then
        -- set default speed, change it if needed
        player.spriteSpeed = 15/60 --60 / 60
        if player:get("activity") == 30 then --climbing
            player.spriteSpeed = 8/60 
        end
        -- powerups
        player.mask = sprites[player:get("powerupState")][player:get("powerupEffect")].mask
        if player:getAnimation("idle") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].idle then
            player:setAnimations{
                idle = sprites[player:get("powerupState")][player:get("powerupEffect")].idle,
                walk = sprites[player:get("powerupState")][player:get("powerupEffect")].walk,
                jump = sprites[player:get("powerupState")][player:get("powerupEffect")].jumpUp,
                climb = sprites[player:get("powerupState")][player:get("powerupEffect")].climb
            }
        end
        
        if player:get("takeoffMeter") == -1 or player:get("takeoffMeter") > 0 then
            -- P-speed
            if player:get("pHmax") < maxHSpeed then
                -- jumping
                if player:get("pVspeed") >= 0 then
                    if player:getAnimation("jump") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].jumpDown then
                        player:setAnimation("jump", sprites[player:get("powerupState")][player:get("powerupEffect")].jumpDown)
                    end
                else
                    if player:getAnimation("jump") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].jumpUp then
                        player:setAnimation("jump", sprites[player:get("powerupState")][player:get("powerupEffect")].jumpUp)
                    end
                end
                
                -- walking
                if player:getAnimation("walk") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].walk then
                    player:setAnimation("walk", sprites[player:get("powerupState")][player:get("powerupEffect")].walk)
                end
            else
                -- run jumping
                if player:getAnimation("jump") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].jumpRun then
                    player:setAnimation("jump", sprites[player:get("powerupState")][player:get("powerupEffect")].jumpRun)
                end
                
                -- running
                if player:getAnimation("walk") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].run then
                    player:setAnimation("walk", sprites[player:get("powerupState")][player:get("powerupEffect")].run)
                end
            end
            
        elseif player:get("takeoffMeter") == 0 then -- flying
        
            -- cape pumping
            --if player:get("pGravity1") < player:get("backup_grav1")
            if player:get("pGravity1") < 0 then
                if player:getAnimation("jump") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].flightUp then
                    player:setAnimation("jump", sprites[player:get("powerupState")][player:get("powerupEffect")].flightUp)
                end
            
            -- divebombing
            elseif player:get("pGravity1") > player:get("backup_grav1") then
            
                player:setAnimation("jump", sprites[player:get("powerupState")][player:get("powerupEffect")].flightDown)
                
                -- max speed
                if player:get("pGravity1") == player:get("backup_grav1") * 1.5 then
                    player.subimage = 4
                -- medium-high speed
                elseif player:get("pGravity1") >= player:get("backup_grav1") * 1.3333 then
                    player.subimage = 3
                -- medium-low speed
                elseif player:get("pGravity1") >= player:get("backup_grav1") * 1.1666 then
                    player.subimage = 2
                -- low speed
                else
                    player.subimage = 1
                end
                
            -- general floating
            elseif player:getAnimation("jump") ~= sprites[player:get("powerupState")][player:get("powerupEffect")].flightStay then
                player:setAnimation("jump", sprites[player:get("powerupState")][player:get("powerupEffect")].flightStay)
            end
            
        else -- takeoffMeter < -1: sliding on floor
            player:setAnimation("walk", sprites[player:get("powerupState")][player:get("powerupEffect")].flightStay)
            player:setAnimation("idle", sprites[player:get("powerupState")][player:get("powerupEffect")].flightStay)
        end
        
        -- drifting
        if player:collidesMap(player.x, player.y + 1) and player:get("drifting") ~= 0 and player:getAnimation("walk")~= sprites[player:get("powerupState")][player:get("powerupEffect")].drift then
            player:setAnimation("walk", sprites[player:get("powerupState")][player:get("powerupEffect")].drift)
        end
        
    end
end)

-------------
-- P-Meter --
-------------

registercallback("onPlayerHUDDraw", function(player, x, y)
    if player:getSurvivor().displayName == "Mario" then
    
        -- skill cover-up
        graphics.color(Color.fromRGB(64, 65, 87))
        graphics.rectangle(x + 22, y - 1, x + 22 + 66, y - 1 + 20)
        
        -- hp cover-up
        graphics.rectangle(x - 34, y + 29, x - 34 + 160, y + 29 + 7)
        
        -- black bar behind P-speed
        graphics.color(Color.fromRGB(0, 0, 0))
        graphics.rectangle(x + 12, y + 29, x + 12 + 63, y + 29 + 6)
        
        -- blue P-speed bar
        graphics.color(Color.fromRGB(38, 98, 234))
        graphics.rectangle(x + 12, y + 29, x + 12 + (math.max(player:get("pHmax") - minHSpeed, 0) / (maxHSpeed - minHSpeed)) * 63, y + 29 + 6)
        
        graphics.drawImage{
            image = pMeter.sprOut,
            x = x + 12,
            y = y + 29
        }
        
    end
end)

----------------------
-- Holding Powerups --
----------------------

registercallback("onPlayerHUDDraw", function(player, x, y)
    if player:getSurvivor().displayName == "Mario" then
        
        if player:get("holdingPowerupState") ~= 0 then
            local holdSprite = powerupSprites[player:get("holdingPowerupState") - 1 + player:get("holdingPowerupEffect") - 1]
            graphics.drawImage{
                image = holdSprite,
                x = x + 96 + 3,
                y = y - 5 + 3 + 1,
                -- xscale = 23 / holdSprite.width,
                -- yscale = 23 / holdSprite.height
            }
        end
        
    end
end)

registercallback("onPlayerStep", function(player)
    if player:getSurvivor().displayName == "Mario" then
        local hold = player:get("holdingPowerupState")
        if hold ~= 0 and (player:control("use") == input.PRESSED or player:get("forceDrop") == 1) then
            local handler = graphics.bindDepth(player.depth - 1, dropPowerup)
            handler:set("powerState", player:get("holdingPowerupState"))
            handler:set("powerEffect", player:get("holdingPowerupEffect"))
            handler:set("player", player.id)
            
            player:set("holdingPowerupState", 0):set("holdingPowerupEffect", 0)
        end
        player:set("forceDrop", 0)
    end
end)

----------------------
-- Picking up Items --
----------------------

registercallback("onPlayerStep", function(player)
    if player:getSurvivor().displayName == "Mario" then
        for _, item in ipairs(ParentObject.find("items"):findAllEllipse(player.x - 10, player.y - 10, player.x + 10, player.y + 10)) do
            if item:getAlarm(0) <= 1 then item:setAlarm(0, 1) end
        end
    end
end)

----------------------------------------------------
--------------------- POWERUPS ---------------------
----------------------------------------------------

-----------------
-- Fire Flower --
-----------------

local function fireballPoof(handler, frame)
    if math.floor(frame / 4) + 1 > 4 then
        handler:destroy()
    else
        graphics.drawImage{
            image = sprites[3][1].fireballPoof,
            x = handler.x,
            y = handler.y,
            subimage = math.floor(frame / 4) + 1
        }
    end
end

local fireball = Object.new("Fireball")
fireball.sprite = sprites[3][1].fireball
fireball:addCallback("create", function(self)
    self:set("maxSpeed", 10 * 16 / 60) -- 10 blocks per sec
    self:set("accelY", self:get("maxSpeed") * 2 / 15)
    self:set("speedY", self:get("maxSpeed"))
    self:set("direction", 0)
    self.spriteSpeed = 15 / 60
end)
fireball:addCallback("step", function(self)
    self.y = self.y + self:get("speedY")
    self:set("speedY", math.min(self:get("speedY") + self:get("accelY"), self:get("maxSpeed")))
    if self:collidesMap(self.x, self.y) then
        if self:get("speedY") < 0 then
            -- hit ceiling, destroy
            self:destroy()
        else
            -- hit floor, bounce
            while self:collidesMap(self.x, self.y) do
                self.y = self.y - 1
            end
            self:set("speedY", self:get("maxSpeed") * -1)
        end
    end
    
    if self:isValid() then
        local xmult = 1
        if self:get("direction") == 180 then
            xmult = -1
        end
        self.x = self.x + self:get("maxSpeed") * xmult
        if self:collidesMap(self.x, self.y) then
            -- hit wall, destroy
            self:destroy()
        end
    end
    
    if self:isValid() then
        for _, enemy in ipairs(ParentObject.find("enemies"):findAll()) do
            if enemy:isValid() then
                if self:collidesWith(enemy, self.x, self.y) then
                    local player = Object.findInstance(self:get("player"))
                    local ball = player:fireBullet(
                        enemy.x - enemy.sprite.xorigin + enemy.sprite.width / 2 - 1,
                        enemy.y - enemy.sprite.yorigin + enemy.sprite.height / 2,
                        0, 2, fireballDamage
                    )
                    --ball:set("blaze", 1)
                    ball:set("specific_target", enemy.id)
                    self:destroy()
                    break
                end
            end
        end
    end
end)
fireball:addCallback("destroy", function(self)
    local handler = graphics.bindDepth(self.depth - 1, fireballPoof)
    handler.x = self.x
    handler.y = self.y
end)

----------
-- Cape --
----------


registercallback("onPlayerStep", function(player)
    if player:getSurvivor().displayName == "Mario" then
        if player:get("powerupState") == 3 and player:get("powerupEffect") == 2 then
            if player:get("takeoffMeter") == -1 then
                -- if not flying, but in air, and holding jump, float down
                if player:get("free") == 1 and player:get("moveUpHold") == 1 and player:get("pVspeed") > floatSpeed then
                    player:set("pVspeed", floatSpeed)
                end
                if player:get("pHmax") == maxHSpeed and player:control("ability1") == input.HELD
                  and player:get("free") == 0 and player:get("moveUp") == 1 then
                    -- begin takeoff
                    player:set("takeoffMeter", 120)
                end
            elseif player:get("takeoffMeter") > -1 then
                -- during takeoff / flight, speed is always max (TODO: should it?)
                player:set("pHmax", maxHSpeed)
                -- movement is auto-applied during flight (because RoR physics:tm:)
                local xoffset
                local xdir = player:getFacingDirection()
                if player:get("takeoffMeter") == 0 then xdir = player:get("flyingDirection") end
                if xdir == 0 then
                    if player:control("right") == input.HELD then
                        xoffset = 0
                    elseif player:control("left") == input.HELD then
                        xoffset = player:get("pHmax") * 2
                    else
                        xoffset = player:get("pHmax")
                    end
                else
                    if player:control("left") == input.HELD then
                        xoffset = 0
                    elseif player:control("right") == input.HELD then
                        xoffset = player:get("pHmax") * -1 * 2
                    else
                        xoffset = player:get("pHmax") * -1
                    end
                end
                player.x = player.x + xoffset
                if xoffset ~= 0 then
                    local dir = xoffset / math.abs(xoffset)
                    while player:collidesMap(player.x, player.y) do
                        player.x = player.x - dir
                    end
                end
                if player:control("ability1") ~= input.HELD then
                    -- if at any point the player stops running,
                    -- the takeoff and/or flight immediately ends
                    player:set("takeoffMeter", -1)
                    player:set("flyingDirection", -1)
                    player:set("pGravity1", player:get("backup_grav1"))
                    player:set("pGravity2", player:get("backup_grav2"))
                elseif player:get("takeoffMeter") > 0 then
                    -- taking off
                    player:set("takeoffMeter", player:get("takeoffMeter") - 1)
                    --player:set("pGravity1", 0):set("pGravity2", 0)
                    player:set("pVspeed", -5 - player:get("pGravity2")) -- 600 pixels / 37.5 blocks risen at max
                    if player:get("moveUpHold") ~= 1 then
                        -- stopped holding jump, but still holding run == takeoff ends normally
                        player:set("takeoffMeter", 0)
                    end
                else -- takeoff ended either by hitting two seconds, or stopped holding jump; time to fly
                    -- initial flight setup
                    if player:get("flyingDirection") == -1 then
                        --player:set("pGravity1", player:get("backup_grav1")):set("pGravity2", player:get("backup_grav2"))
                        player:set("flyingDirection", player:getFacingDirection())
                    end
                    -- "reverse" the player if its facing the wrong way
                    if player:get("flyingDirection") == 0 then player.xscale = 1 else player.xscale = -1 end
                    -- if the opposite direction is tapped when velocity is above a certain threshold,
                    -- get boosted upwards (same happens if he hits an enemy mid-flight)
                    if player:get("hitEnemy") == 1 or (player:get("pVspeed") > flightBeginBounceSpeed and
                      (player:get("flyingDirection") == 0 and player:control("left") == input.PRESSED or
                      player:get("flyingDirection") == 180 and player:control("right") == input.PRESSED)) then
                        player:set("pGravity1", -877/1550):set("pGravity2", -877/1550)
                        player:set("pVspeed", 0)
                    end
                    if player:get("pGravity1") < player:get("backup_grav1") then
                        player:set("pGravity1", math.min(player:get("pGravity1") + (877/1550 + player:get("backup_grav1")) / 30, player:get("backup_grav1")))
                        player:set("pGravity2", math.min(player:get("pGravity2") + (877/1550 + player:get("backup_grav2")) / 30, player:get("backup_grav1")))
                    end
                    -- if player is holding forward button and has enough speed, gravity intensifies (falls down faster)
                    if (player:get("flyingDirection") == 0 and player:control("right") == input.HELD or
                      player:get("flyingDirection") == 180 and player:control("left") == input.HELD)
                      and player:get("pVspeed") > flightQuakeSpeed then
                        -- if player:get("pGravity1") < player:get("backup_grav1") then player:set("pGravity1", player:get("backup_grav1")) end
                        -- if player:get("pGravity2") < player:get("backup_grav2") then player:set("pGravity2", player:get("backup_grav2")) end
                        player:set("pGravity1", math.min(player:get("pGravity1") + 0.0333 * player:get("backup_grav1"), player:get("backup_grav1") * 1.5))
                        player:set("pGravity2", math.min(player:get("pGravity2") + 0.0333 * player:get("backup_grav2"), player:get("backup_grav2") * 1.5))
                    -- set the gravity back to normal if he stopped holding it
                    elseif player:get("pGravity1") > player:get("backup_grav1") and
                      (player:get("flyingDirection") == 0 and player:control("right") == input.RELEASED or
                      player:get("flyingDirection") == 180 and player:control("left") == input.RELEASED) then
                        player:set("pGravity1", player:get("backup_grav1"))
                        player:set("pGravity2", player:get("backup_grav2"))
                    end
                    
                    -- if player hits floor, reset everything
                    if player:get("free") == 0 then
                        -- if player has speed above a certain threshold, do a quake attack
                        if player:get("pGravity1") == player:get("backup_grav1") * 1.5 then
                            player:set("takeoffMeter", -1)
                            player:set("flyingDirection", -1)
                            misc.shakeScreen(15)
                            local stageWidth, stageHeight = Stage.getDimensions()
                            local cameraWidth, cameraHeight = graphics.getGameResolution()
                            for _, enemy in ipairs(ParentObject.find("classicEnemies"):findMatching("free", 0)) do
                                if enemy.x >= math.min(player.x - cameraWidth / 2, 0) and enemy.x <= math.min(player.x + cameraWidth / 2, stageWidth)
                                  and enemy.y >= math.min(player.y - cameraHeight / 2, 0) and enemy.y <= math.min(player.y + cameraHeight / 2, stageHeight) then
                                    local damager = player:fireBullet(
                                        enemy.x - enemy.sprite.xorigin + enemy.sprite.width / 2 - 1,
                                        enemy.y - enemy.sprite.yorigin + enemy.sprite.height / 2,
                                        0, 2, capeQuakeDamage
                                    )
                                    damager:set("specific_target", enemy.id)
                                end
                            end
                        -- otherwise, just drift off for a few frames
                        else
                            player:set("takeoffMeter", -30 + -1)
                        end
                        player:set("pGravity1", player:get("backup_grav1"))
                        player:set("pGravity2", player:get("backup_grav2"))
                    end
                end
            else -- takeoffMeter < -1
                if player:get("moveUp") == 1 or player:getFacingDirection() ~= player:get("flyingDirection") then
                    player:set("takeoffMeter", -1):set("flyingDirection", -1)
                else
                    local mult = 1
                    if player:get("flyingDirection") == 180 then mult = -1 end
                    local xoffset = 0
                    if mult == 1 and player:control("right") == input.HELD then
                        xoffset = player:get("pHmax") * -1
                    elseif mult == -1 and player:control("left") == input.HELD then
                        xoffset = player:get("pHmax")
                    end
                    player.x = player.x + 1 * mult + xoffset
                    while player:collidesMap(player.x, player.y) do
                        player.x = player.x - 1 * mult
                    end
                    if math.random(3) == 1 then ParticleType.find("Smoke"):burst("above", player.x, player.y + 1, math.random(2)) end
                    player:set("takeoffMeter", player:get("takeoffMeter") + 1)
                    if player:get("takeoffMeter") == -1 then
                        player:set("flyingDirection", -1)
                    end
                end
            end
        end
    end
end)

--------------
-- Survivor --
--------------

mario:setLoadoutInfo(
[[&r&Mario&!&, presumably playing Mario Galaxy, landed on a foreign planet.
Use your jumping skills to damage and kill enemies!]], sprSkills)

mario:setLoadoutSkill(1, "Run / Use Ability",
[[Hold to run. When you have a powerup, press to use its ability.]])

mario:setLoadoutSkill(2, "",
[[]])

mario:setLoadoutSkill(3, "",
[[]])

mario:setLoadoutSkill(4, "",
[[]])

mario.loadoutColor = Color(0xDE0014)

mario.loadoutSprite = Sprite.load("mario_select", "sprites/mario/select", 4, 2, 0)

mario.titleSprite = sprites[2][1].walk

mario.endingQuote = "..and so he left, since the princess was on another castle."

mario:addCallback("init", function(player)
    hitEnemiesOnJump[player.id] = {}
    player:set("powerupState", 1):set("powerupStateNew", 0)
    player:set("powerupEffect", 1):set("powerupEffectNew", 0)
    player:set("drifting", 0)
    player:set("holdingPowerupState", 0):set("holdingPowerupEffect", 0)
    player:set("forceDrop", 0)
    player:set("usedPower", 0)
    
    -- for cape control
    player:set("capeIsIdle", 1)
    player:set("takeoffMeter", -1)
    player:set("flyingDirection", -1)
    player:set("backup_grav1", player:get("pGravity1")):set("backup_grav2", player:get("pGravity2"))
    
    --
    
	player:setAnimations{
        idle = sprites[1][1].idle,
        walk = sprites[1][1].walk,
        jump = sprites[1][1].jumpUp,
        climb = sprites[1][1].climb,
        death = sprDeath,
        decoy = sprDecoy
    }
    
	player:survivorSetInitialStats(1000, 14, 1000) -- TODO: consider using "true_invincible"
    
	player:setSkill(1,
		"Run / Use Ability",
		"Hold to run. When you have a powerup, press to use its ability.",
		sprSkills, 1,
		0
	)
	player:setSkill(2,
		"",
		"",
		sprSkills, 2,
		0
	)
	player:setSkill(3,
		"",
		"",
		sprSkills, 2,
		0
	)
    player:setSkill(4,
		"",
		"",
		sprSkills, 2,
		0
	)
end)

mario:addCallback("levelUp", function(player)
	player:survivorLevelUpStats(20, 4, 0, 1000)
end)

-- mario:addCallback("scepter", function(player)
	-- player:setSkill(4,
		-- "Spikes of Super Death",
		-- "Form spikes in both directions dealing up to 2x3x240% damage.",
		-- sprSkills, 5,
		-- 7 * 60
	-- )
-- end)

mario:addCallback("useSkill", function(player, skill)
	if player:get("activity") == 0 then
		
		if skill == 1 and player:control("ability1") == input.PRESSED then
            if player:get("powerupState") == 3 and player:get("powerupEffect") == 1 then
                player:survivorActivityState(1, sprites[3][1].shoot, 1, false, false)
            elseif player:get("powerupState") == 3 and player:get("powerupEffect") == 2
              and player:get("takeoffMeter") == -1 then
                player:survivorActivityState(1, sprites[3][2].twirl, 30/60, false, false)
            end
        end
		-- elseif skill == 2 then
			-- -- X skill
			-- player:survivorActivityState(2, sprShoot2, 0.25, true, true)
		-- elseif skill == 3 then
			-- -- C skill
			-- player:survivorActivityState(3, sprShoot3, 0.25, false, false)
		-- elseif skill == 4 then
			-- -- V skill
			-- player:survivorActivityState(4, sprShoot4, 0.25, true, true)
		-- end
		
		--player:activateSkillCooldown(skill)
	end
end)

mario:addCallback("onSkill", function(player, skill, relevantFrame)
	if skill == 1 then 
        -- fire
        if player:get("powerupState") == 3 and player:get("powerupEffect") == 1 then
            if relevantFrame == 1 then
                -- if less than two fireballs exist
                if #fireball:findAll() < 2 then
                    local xoffset = 8
                    if player:getFacingDirection() == 180 then
                        xoffset = xoffset * -1
                    end
                    local ball = fireball:create(player.x + xoffset, player.y - 11)
                    ball:set("direction", player:getFacingDirection())
                    ball:set("player", player.id)
                end
            end
        -- cape
        elseif player:get("powerupState") == 3 and player:get("powerupEffect") == 2 then
            -- on all frames of the animation, deal damage to anything that touches your cape
            local anim = relevantFrame % 4
            local y = player.y - player.sprite.yorigin
            local x = player.x - player.sprite.xorigin
            if anim >= 2 then
                x = x + player.sprite.width - 12
            end
            local damager = player:fireExplosion(x + 5, y + 16, (5 * 2) / 19, (4 * 2) / 4, capeSpinDamage)
            damager:set("capeSpin", 8 - relevantFrame)
            
            -- make qblocks trigger
            for _, qb in ipairs(qblock:findAllRectangle(x, y + 12, x + 10, y + 20)) do
                if qb:get("used") == 0 then
                    hitQBlock(qb)
                end
            end
            
            -- give powerups vertical speed
            for _, pup in ipairs(powerup:findAllRectangle(x, y + 12, x + 10, y + 20)) do
                pup:set("speedY", -5)
            end
        end
	end
end)
Audio.Stop()

FIGHT       = Encounter["fui_buttons"][1]
FIGHT.layer = "BelowPlayer"
local w, h = FIGHT.width, FIGHT.height
local halfW, halfH = w/2, h/2

-- button’s top-left corner:
local bx = FIGHT.absx - halfW
local by = FIGHT.absy - halfH

-- “True” (float) position of the button
fightPos    = { FIGHT.absx, FIGHT.absy }

-- initial speed (pixels per Update)
fightSpeed  = 10

-- how much to multiply speed by each frame (0 < decel < 1)
local decelFactor = 0.964

-- fixed target point
abstarget   = { 320, 95 + Arena.height/2 }

var = false

decayButton = true
amountFought = 0
fightSprite = "fakeui/buttons/fight_0"

function Update()
    -- Vector to target
    local dx = abstarget[1] - fightPos[1]
    local dy = abstarget[2] - fightPos[2]
    local dist = math.sqrt(dx*dx + dy*dy)

    if dist > 0 and var == false then
        -- 1) Normalize
        local nx, ny = dx/dist, dy/dist

        -- 2) Velocity = direction × current speed
        local vx, vy = nx * fightSpeed, ny * fightSpeed

        -- 3) Update float‐position
        fightPos[1] = fightPos[1] + vx
        fightPos[2] = fightPos[2] + vy

        -- 4) Compute integer move (round accumulator → actual)
        local moveX = math.floor(fightPos[1] + 0.5) - FIGHT.absx
        local moveY = math.floor(fightPos[2] + 0.5) - FIGHT.absy

        -- 5) Move the sprite
        FIGHT.Move(moveX, moveY)

        -- 6) Decelerate for next frame
        fightSpeed = fightSpeed * decelFactor

        -- Optional “snap” if you’re very close
        if dist < 1 and var == false then
            -- place exactly on target and zero speed
            FIGHT.Move(abstarget[1] - FIGHT.absx, abstarget[2] - FIGHT.absy)
            fightSpeed = 0
        end
    end

    local px, py = Player.absx, Player.absy

    -- Recompute button bounds each frame:
    local w, h     = FIGHT.width, FIGHT.height
    local halfW, halfH = w/2, h/2
    local bx       = FIGHT.absx - halfW
    local by       = FIGHT.absy - halfH

    -- Check if the player’s point lies inside that box:
    if px >= bx
    and px <= bx + w
    and py >= by
    and py <= by + h then
        playerOnFight = true
    else
        playerOnFight = false
    end
    
    FIGHT.Set(fightSprite)

    if playerOnFight then
        if amountFought == 0 then
            fightSprite = "fakeui/buttons/fight_1"
        end
        if Input.Confirm == 1 then
            Player.ForceAttack(1, math.random(1000000, 9999999))
            Encounter["randomHP"] = true
            FIGHT.Move(math.random(-5, 5), math.random(-5, 5))
            if decayButton then
                amountFought = amountFought + 1
                if amountFought == 5 then
                    fightSprite = "fakeui/buttons/fight_2"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 10 then
                    fightSprite = "fakeui/buttons/fight_3"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 15 then
                    fightSprite = "fakeui/buttons/fight_4"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 20 then
                    fightSprite = "fakeui/buttons/fight_5"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 25 then
                    fightSprite = "fakeui/buttons/fight_6"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 30 then
                    fightSprite = "fakeui/buttons/fight_7"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 35 then
                    fightSprite = "fakeui/buttons/fight_8"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 40 then
                    fightSprite = "fakeui/buttons/fight_9"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 45 then
                    fightSprite = "fakeui/buttons/fight_10"
                    Audio.PlaySound("heartbeatbreaker", 10)
                elseif amountFought == 50 then
                    fightSprite = "empty"
                    var = true
                    FIGHT.Move(1000,1000)
                    Audio.PlaySound("heartsplosion", 10)
                end
            end
        end
    else
        if amountFought == 0 then
            fightSprite = "fakeui/buttons/fight_0"
        end
    end
end

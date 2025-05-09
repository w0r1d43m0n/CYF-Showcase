--[[
                == INSTRUCTIONS ==
1. Define an `orangesoul` object in your Wave script.
    orangesoul = require('Libraries/orangesoul')
    orangesoul.Initialize()
2. In your wave's Update() function, put an `orangesoul.Update()`.
    function Update()
        orangesoul.Update()
3. Misc functions
    orangesoul.Stop() -- Reverts to original red soul behavior.
    orangesoul.SetSpeed(speed) -- Sets how fast the soul moves.
    orangesoul.SetDirection(direction) -- "right", "left", "up", "down": changes SOUL direction

]]

self = {}
local speed = 3
local dir = "down"
local active = false


function self.Initialize()
    Player.SetControlOverride(true)
    Player.sprite.color = {252/255, 166/255, 0/255}
    active = true
end

function self.SetSpeed(spd)
    speed = spd
end

function self.SetDirection(direction)
    dir = direction
end

function self.WaveEnding()
    Player.sprite.rotation = 0
end

function self.Stop()
    active = false
    Player.sprite.rotation = 0
    Player.sprite.color = {1, 0, 0}
    Player.SetControlOverride(false)
end

function self.Update()
    if active == true then
        if Input.Right == 1 then
            dir = "right"
            Player.sprite.rotation = 90
        elseif Input.Left == 1 then
            dir = "left"
            Player.sprite.rotation = 270
        elseif Input.Up == 1 then
            dir = "up"
            Player.sprite.rotation = 180
        elseif Input.Down == 1 then
            dir = "down"
            Player.sprite.rotation = 0
        end
        
        if dir == "right" then
            Player.Move(speed, 0)
        elseif dir == "left" then
            Player.Move(-speed, 0)
        elseif dir == "up" then
            Player.Move(0, speed)
        elseif dir == "down" then
            Player.Move(0, -speed)
        end
    end
end


return self


-- Library written by u/w0r1d_d43m0n
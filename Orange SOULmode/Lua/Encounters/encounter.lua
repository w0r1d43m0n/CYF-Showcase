-- A basic encounter script skeleton you can copy and modify for your own creations.

-- music = "shine_on_you_crazy_diamond" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "Check Libraries/orangesoul.lua for instructions" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"orange1"}
wavetimer = 4.0
arenasize = {155, 130}

orangesoul = require("Libraries/orangesoul")

enemies = {
"poseur"
}

enemypositions = {
{0, 0}
}


-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"orange1"}

function EncounterStarting()
    State("ENEMYDIALOGUE")
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
    orangesoul.WaveEnding()
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
    BattleDialog({"Selected item " .. ItemID .. "."})
end


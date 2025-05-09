-- A basic encounter script skeleton you can copy and modify for your own creations.
require "fakeui"
-- music = "shine_on_you_crazy_diamond" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "Poseur strikes a pose!" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"fighting"}
wavetimer = 100
arenasize = {155, 130}

enemies = {
"poseur"
}

enemypositions = {
{0, 0}
}

randomHP = false

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"fighting"}

function Update()
	fui_update()
    if randomHP then
        enemies[1]["hp"] = math.random(1, enemies[1]["maxhp"])
    end
end

function EnteringState(newstate, oldstate)
	if(newstate == "ACTIONSELECT") then
		fui_selectingButton = true
	else
		fui_selectingButton = false
	end
	if(newstate == "ENEMYDIALOGUE" or newstate == "DEFENDING") then
		fui_inMenu = false
	else
		fui_inMenu = true
	end
end

function EncounterStarting()
    fui_init()
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
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
    BattleDialog({"Selected item " .. ItemID .. "."})
end
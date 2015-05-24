Elm Wizardry: Part 2
====================

Congratulations on making it through [Part 1](https://github.com/rtfeldman/lambdaconf-2015-elm-workshop/tree/master/1_basic)! (Or, if you're still working on Part 1 and have come here in search of answers...welcome!)

There are a fresh set of TODOs in this module. Now that we're successfully selecting a spell, and rendering monsters, the next step is to actually cast the selected spell on the target monster when you click the monster.

Once that's done, here are some things to try next:

1. When a monster's health drops to zero or lower, remove it from the game.
2. If there are no monsters left, end the game and display "YOU WON!"
3. Track the player's health and mana levels. Subtract `spell.manaCost` each time a spell is cast.
4. Add a Recharge Mana button which resets the player's mana level to 100, but allows each monster to attack the player, reducing the player's health by `monster.damage`.
5. If the player's health drops to 0 or lower, end the game and display "GAME OVER!"
6. Show a status message describing the player's most recent action, or perhaps a helpful hint.
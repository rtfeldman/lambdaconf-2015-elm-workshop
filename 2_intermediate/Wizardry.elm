module Wizardry where
{-| An adventure game written in Elm, using plain HTML and CSS for rendering.

This application is broken up into four distinct parts:

  1. Model  - a full definition of the application's state
  2. Update - a way to step the application state forward
  3. View   - a way to visualize our application state with HTML
  4. Inputs - the signals necessary to manage events

This clean division of concerns is a core part of Elm. You can read more about
this in the Pong tutorial: http://elm-lang.org/blog/Pong.elm

This program is not particularly large, so definitely see the following
document for notes on structuring more complex GUIs with Elm:
http://elm-lang.org/learn/Architecture.elm
-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)
import Json.Decode as Json
import Signal exposing (Signal, Address)
import String
import Window
import Monsters exposing (Monster)
import Spells exposing (Spell)

---- MODEL ----

-- Our complete application state.

type GameStatus = Won | Lost | Playing

type alias Model = {
    monsters      : List Monster,

    selectedSpell : Maybe Spell,
    knownSpells   : List Spell,

    playerMana    : Int,
    playerHealth  : Int,

    gameStatus    : GameStatus,
    statusMessage : String
  }

initialModel : Model
initialModel = {
    monsters      = [
      Monsters.waterElemental,
      Monsters.fireElemental,
      Monsters.airElemental
    ],

    selectedSpell = Nothing,
    knownSpells   = [
      Spells.roast,
      Spells.freeze,
      Spells.zap
    ],

    playerMana    = 100,
    playerHealth  = 100,

    gameStatus    = Playing,
    statusMessage = "Choose a spell, then choose a monster to cast it on."
  }


---- UPDATE ----

-- A description of the kinds of actions that can be performed on the model of
-- our application. See the following post for more info on this pattern and
-- some alternatives: http://elm-lang.org/learn/Architecture.elm
type Action
    = NoOp
    | CastSpellOnMonster Int
    | SelectSpell Spell
    | Recharge

resolveSpellOnMonster spell monster =
  { monster | health <- monster.health - spell.damage }

displayInsufficientMana model spell =
  { model | statusMessage <- "You do not have enough mana to cast " ++ spell.name ++ "." }

-- Update our Model using a given Action
update : Action -> Model -> Model
update action model =
  resolveModel <| case action of
    NoOp -> model

    SelectSpell spell ->
      { model | selectedSpell <- Just spell }

    CastSpellOnMonster targetMonsterIndex ->
      case model.selectedSpell of
        Nothing ->
          { model | statusMessage <- "Choose a spell first!" }

        Just spell ->
          if spell.manaCost > model.playerMana
            then
              displayInsufficientMana model spell

            else
              let updateMonsterByIndex = \index monster ->
                if index == targetMonsterIndex
                  then resolveSpellOnMonster spell monster
                  else monster
              in
                { model |
                    monsters      <- List.indexedMap updateMonsterByIndex model.monsters,
                    playerMana    <- model.playerMana - spell.manaCost,
                    statusMessage <- "Pow! You cast " ++ spell.name ++ "."
                }

    Recharge ->
      let totalDamage = List.sum (List.map .damage model.monsters)
      in
        { model |
            playerMana    <- 100,
            playerHealth  <- model.playerHealth - totalDamage,
            statusMessage <- "You recharge, but lose " ++ (toString totalDamage) ++ " health!"
        }

-- Resolves invalid model fields as follows:

-- If the player has 0 health or less, the game is lost.
-- Any monsters with 0 health or less are removed.
-- If there are no monsters remaining, the game is won.
resolveModel : Model -> Model
resolveModel model =
  if model.playerHealth <= 0
    then
      { model | gameStatus <- Lost }

    else
      let survivingMonsters =
        List.filter (\monster -> monster.health > 0) model.monsters
      in
        if List.isEmpty survivingMonsters
          then
            { model | gameStatus <- Won }

          else
            { model | monsters <- survivingMonsters }

---- VIEW ----

view : Address Action -> Model -> Html
view actions model =
  div [id "page"] [
    h1 [] [text "Elm Wizardry!"],

    div [id "content"] <| case model.gameStatus of
      Won -> [
          div [id "you-won"] [],
          div [class "game-status-text"] [text "YOU WON!"]
        ]

      Lost -> [
          div [id "you-lost"] [],
          div [class "game-status-text"] [text "GAME OVER!"]
        ]

      Playing -> [
          div [id "stats"] [
            div [id "player-health"] [text ("Health: " ++ (toString model.playerHealth))],
            div [id "player-mana"] [text ("Mana: " ++ (toString model.playerMana))],
            viewRecharge actions
          ],

          div [id "status-message"] [text model.statusMessage],

          div [id "spells"]
            (List.map (viewSpell actions model.selectedSpell) model.knownSpells),

          div [id "monsters"]
            (List.indexedMap (viewMonster actions) model.monsters)
        ]
    ]

viewMonster : Address Action -> Int -> Monster -> Html
viewMonster actions index monster =
  div [class "monster", onClick actions (CastSpellOnMonster index)] [
    div [class "monster-name"] [text monster.name],
    img [src monster.imageUrl] [],
    div [class "monster-health"] [text ((toString monster.health) ++ " ♥")],
    div [class "monster-damage"] [text ((toString monster.damage) ++ " ⚔")]
  ]

viewSpell : Address Action -> Maybe Spell -> Spell -> Html
viewSpell actions selectedSpell spell =
  let spellClass = case selectedSpell of
    Nothing -> "spell"
    Just selection ->
      if selection == spell
        then "spell selected"
        else "spell"
  in
    div [class spellClass, onClick actions (SelectSpell spell)] [
      img [src spell.imageUrl] [],
      span [class "spell-name"] [text spell.name]
    ]

viewRecharge : Address Action -> Html
viewRecharge actions =
  div [id "recharge", onClick actions Recharge] [text "Recharge Mana"]


---- INPUTS ----

-- Wire the entire application together
main : Signal Html
main =
  Signal.map (view actionMailbox.address) model


-- Manage the model of our application over time
model : Signal Model
model =
  Signal.foldp update initialModel actionMailbox.signal


-- Actions from user input
actionMailbox : Signal.Mailbox Action
actionMailbox =
  Signal.mailbox NoOp

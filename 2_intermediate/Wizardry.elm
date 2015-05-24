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
    knownSpells   : List Spell
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
    ]
  }


---- UPDATE ----

-- A description of the kinds of actions that can be performed on the model of
-- our application. See the following post for more info on this pattern and
-- some alternatives: http://elm-lang.org/learn/Architecture.elm
type Action
    = NoOp
    | SelectSpell Spell
    -- TODO add an Action for casting the selected spell on a monster.

-- Update our Model using a given Action
update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model

    SelectSpell spell ->
      { model | selectedSpell <- Just spell }

    -- TODO handle the case where we got an Action for casting the selected spell on a monster.


---- VIEW ----

view : Address Action -> Model -> Html
view actions model =
  div [id "page"] [
    h1 [] [text "Elm Wizardry!"],

    div [id "content"] [
      div [id "spells"]
        (List.map (viewSpell actions model.selectedSpell) model.knownSpells),

      div [id "monsters"]
        -- TODO pass in actions so viewMonster can send an action to it onClick
        (List.map viewMonster model.monsters)
    ]
  ]

viewMonster : Monster -> Html
viewMonster monster =
  -- TODO add an onClick handler that casts the selected spell on this monster
  div [class "monster"] [
    div [class "monster-name"] [text monster.name],
    img [src monster.imageUrl] [],
    div [class "monster-health"] [text ((toString monster.health) ++ " ♥")],
    div [class "monster-damage"] [text ((toString monster.damage) ++ " ⚔")]
  ]

viewSpell : Address Action -> Maybe Spell -> Spell -> Html
viewSpell actions selectedSpell spell =
  let spellClass = case selectedSpell of
    Nothing ->
      "spell"

    Just selection ->
      if selection == spell
        then "spell selected"
        else "spell"
  in
    div [class spellClass, onClick actions (SelectSpell spell)] [
      img [src spell.imageUrl] [],
      span [class "spell-name"] [text spell.name]
    ]

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

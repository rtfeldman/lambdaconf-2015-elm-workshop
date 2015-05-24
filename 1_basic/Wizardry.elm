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

type alias Model = {
    monsters      : List Monster,

    selectedSpell : Maybe Spell,
    knownSpells   : List Spell
  }

initialModel : Model
initialModel = {
    monsters      = [], -- TODO we should populate this with some monsters from Monsters.elm

    selectedSpell = Nothing,
    knownSpells   = [] -- TODO we should populate this with some spells from Spells.elm
  }


---- UPDATE ----

-- A description of the kinds of actions that can be performed on the model of
-- our application. See the following post for more info on this pattern and
-- some alternatives: http://elm-lang.org/learn/Architecture.elm
type Action
    = NoOp

-- Update our Model using a given Action
update : Action -> Model -> Model
update action model =

  -- TODO this is where we should update the Model based on the given Action.
  model


---- VIEW ----

view : Address Action -> Model -> Html
view actions model =
  div [id "page"] [
    h1 [] [text "Elm Wizardry!"],

    -- TODO this is where we should render the spells using the viewSpell function below
    div [id "spells"] [],

    -- TODO this is where we should render the monsters using the viewMonster function below
    div [id "monsters"] []
  ]

-- Render a single monster
viewMonster : Monster -> Html
viewMonster monster =
  div [class "monster"] [
    div [class "monster-name"] [text monster.name],
    img [src monster.imageUrl] [],
    div [class "monster-health"] [text ((toString monster.health) ++ " ♥")],
    div [class "monster-damage"] [text ((toString monster.damage) ++ " ⚔")]
  ]

-- Render a single spell
viewSpell : Spell -> Html
viewSpell spell =
  div [class "spell"] [
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

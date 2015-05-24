module Spells where

type alias Spell = {
    name     : String,
    damage   : Int,
    manaCost : Int,
    imageUrl : String
  }

roast : Spell
roast = {
    name     = "Roast",
    damage   = 20,
    manaCost = 10,
    imageUrl = "http://uxrepo.com/static/icon-sets/elusive/svg/fire.svg"
  }

freeze : Spell
freeze = {
    name     = "Freeze",
    damage   = 15,
    manaCost = 7,
    imageUrl = "http://www.fullnerchristmastreefarm.com/Snowflake.jpg"
  }

zap : Spell
zap = {
    name     = "Zap",
    damage   = 25,
    manaCost = 15,
    imageUrl = "http://www.clipartbest.com/cliparts/biy/g78/biyg78AiL.svg"
  }
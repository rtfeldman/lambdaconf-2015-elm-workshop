Elm Wizardry: Part 1
====================

Welcome, fellow Elm traveler! Today we'll be delving into the arcane magicks of functional programming in the browser.

We'll be building towards a working Adventure Game, but don't sweat it if you don't get everything working inside two hours. The three most important things to do in this workshop are:

1. Have fun
2. Gain familiarity with building things in Elm
3. Have fun

Our primary goal in Part 1 of the workshop is simply to get comfortable writing some Elm code. All the HTML and CSS for this game has already been written, so you should be able to spend the whole workshop editing `Wizardry.elm`.

Some useful references to aid you in your journey:

* [The Elm Syntax Reference](http://elm-lang.org/learn/Syntax.elm)
* [Using Modules](http://elm-lang.org/learn/Syntax.elm#modules)
* [Union Types](http://elm-lang.org/learn/Union-Types.elm) (`Action` is an example of a union type)
* [Records](http://elm-lang.org/learn/Records.elm) (those things that look a lot like JavaScript objects)
* [The Elm Architecture](https://github.com/evancz/elm-architecture-tutorial#the-elm-architecture) (updating your Model via Actions)

---

The files in this directory set up a basic app skeleton with a healthy dose of `TODO` comments sprinkled throughout. There are three Elm modules:

`Wizardry.elm` - The main module, which specifies the bulk of the application logic
`Monsters.elm` - A listing of monsters to defeat in the game
`Spells.elm` - A listing of spells with which to defeat said monsters

The `Monsters` and `Spells` modules are separated out from the main `Wizardry` module mostly so you can see how Elm's module system works. You won't _need_ to edit those modules today, but of course if you want to add more Monsters or more Spells, or to modify the existing ones, by all means—have fun!

The accompanying presentation will work through implementing these TODOs, with explanations along the way. Please ask lots of questions! Be bold; if you have a question, there's a good chance someone else has the same question. Even better, the answer to your question might also trigger an "aha!" moment for someone else who hadn't thought to frame the question in that way.

Questions benefit everyone in a workshop, so please ask lots of them!
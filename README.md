Elm Wizardry!
=============

_LambdaConf 2015 Workshop: Writing an Adventure Game in Elm_

### Installing Elm

The Elm Platform (currently version 0.15) includes everything you'll need for the workshop.

---

* **OS X** users: [download the OS X Elm Installer](http://install.elm-lang.org/Elm-Platform-0.15.pkg)
* **Windows** users: [download the Windows Elm Installer](http://install.elm-lang.org/Elm-Platform-0.15.exe)
* **Other operating system** users: you will unfortunately need to [build from source](http://elm-lang.org/Install.elm#build-from-source). Sorry!

---

Once installation completes, you should be able to run the following:

* `elm-make --version` (This is the Elm compiler. It should be on version 0.1.2)
* `elm-package --version` (This is the Elm package manager. It should be on version 0.5)
* `elm-repl --version` (This is the Elm REPL. It should be on version 0.4)
* `elm-reactor --version` (This is the Elm Reactor, aka Time Traveling Debugger. It should be on version 0.3.1)

### Set Up Workshop Materials

1. Grab this repository with `git clone https://github.com/rtfeldman/lambdaconf-2015-elm-workshop.git`
2. Run `cd lambdaconf-2015-elm-workshop/1_basic`
3. You should now be in a directory called `1_basic`. Run `ls` to see the contents of this `1_basic` directory; make sure you see these 6 files: `Monsters.elm`, `Wizardry.elm`, `Spells.elm`, `index.html`, `elm-package.json`, and `style.css`.
4. Run `elm-package install` to download and install the project’s dependencies. Answer `y` when prompted `"Do you approve of this plan? (y/n)"`
5. Run `elm-reactor` and navigate to [localhost:8000](http://localhost:8000) in your browser. You should see this: ![elm-reactor screenshot](https://cloud.githubusercontent.com/assets/1094080/7787529/9cf9f198-01ce-11e5-9986-fc2da149f6d3.png)
6. Under the `Other Files` heading, click `index.html` to open the app! You should see this: ![1_basic](https://cloud.githubusercontent.com/assets/1094080/7787634/56420f74-01d3-11e5-83f4-6e6510b5104a.png)
7. From here, you can proceed directly to the [directions for Part 1 of the workshop](https://github.com/rtfeldman/lambdaconf-2015-elm-workshop/tree/master/1_basic), or continue reading below for some useful tips about your Elm development tools.


### Using elm-reactor, elm-make, and elm-repl

The workshop will use elm-reactor for the convenience of automatic recompilation, but as elm-reactor is a ways off from a stable 1.0 release (see the next section for workarounds to some known issues), you may prefer to use the much more stable Elm Compiler directly via `elm-make` or `elm-repl`.

The most direct way to do a build is simply to run `elm-make Wizardry.elm` from within the same directory as the `Wizardry.elm` file. This will generate an output file called `elm.js`, which `index.html` is already configured to load. The downside to this approach is that you need to re-run this command each time you want to recompile.

Alternatively, you can check whether your code compiles from within `elm-repl` before doing a build. To start up the REPL, simply run `elm-repl`. Once inside, enter `import Wizardry` to compile and load `Wizardry.elm` into the current REPL session. When you enter a term into `elm-repl`, it always prints both the value as well as the type; there is no need to separately query for type information. If you enter a function - for example, `List.map`, it will print `<function>` followed by the function's type.

An important caveat is that there is an [open bug](https://github.com/elm-lang/elm-repl/issues/48) where modules that depend directly on elm-html cannot have their terms successfully evaluated in elm-repl. (The error message you'll see is "ReferenceError: navigator is not defined".) So if you do `import Wizardry` and then enter `Wizardry.view`, you will get an error instead of what you want. However, if you do `import Spells` and then enter `Spells.freeze`, or something similar with `import Monsters`, it will work as normal because those modules do not depend on elm-html directly.

If you prefer to do most of your work inside a REPL, you can get a lot of mileage out of working around this by extracting your Model and Action logic into a separate module outside Wizardry.elm; those parts of the code base do not need to depend on elm-html like the view logic does.


### What do I do if elm-reactor crashes?

Although [elm-reactor](http://elm-lang.org/blog/Introducing-Elm-Reactor.elm) is very cool, it is also very pre-1.0!

Hot-swapping code doesn't always happen (but refreshing the page will, as usual, ensure you have the latest), and from time to time you may also encounter this: ![reactor crash](https://cloud.githubusercontent.com/assets/1094080/7787538/f4269a66-01ce-11e5-97ea-d9ab1d3bfd1f.png)

Usually this can be resolved by going back to [http://localhost:8000](http://localhost:8000), clicking the wrench icon next to Wizardry.elm, and then returning to [http://localhost:8000/index.html](http://localhost:8000/index.html) once more.

If this does not fix the issue, try stopping the reactor, deleting your `elm-stuff` directory, and re-running `elm-package install`. When you then run `elm-reactor` again, everything should be back to normal.

Finally, note that you are under no obligation to use `elm-reactor`; if you prefer, you can run `elm-make Wizardry.elm` each time you want to compile a fresh copy of `elm.js`, then simply open `index.html` in your browser to use it.

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


### What if elm-reactor crashes?

Although [elm-reactor](http://elm-lang.org/blog/Introducing-Elm-Reactor.elm) is very cool, it is also very pre-1.0!

Hot-swapping code doesn't always happen (but refreshing the page will, as usual, ensure you have the latest), and from time to time you may also encounter this: ![reactor crash](https://cloud.githubusercontent.com/assets/1094080/7787538/f4269a66-01ce-11e5-97ea-d9ab1d3bfd1f.png)

Usually this can be resolved by going back to [http://localhost:8000](http://localhost:8000), clicking the wrench icon next to Wizardry.elm, and then returning to [http://localhost:8000/index.html](http://localhost:8000/index.html) once more.

If this does not fix the issue, try stopping the reactor, deleting your `elm-stuff` directory, and re-running `elm-package install`. When you then run `elm-reactor` again, everything should be back to normal.

Finally, note that you are under no obligation to use `elm-reactor`; if you prefer, you can run `elm-make Wizardry.elm` each time you want to compile a fresh copy of `elm.js`, then simply open `index.html` in your browser to use it.

# KonamiCode for Godot
<p align="center">
    <img src="addons/konamicode/icon.svg" alt="Logo" width="200">
    <br />
    <i>Up, Up, Down, Down...</i>
</p>


A very simple addon that adds a new Node that listens for a string of key combinations.

I'm the type of person that loves putting random cryptic secrets in my projects, so I find myself using something like this often. I figured I'd share it with the community as someone might have a use for it.

## Using it
KonamiCode comes with a single new Node: KonamiCode. The exported variables all have pretty self-explanatory names, but just to cover my bases:

By default, the code will always be the keyboard variant of the classic Konami Code. You can override this with the exported `code_override_keyboard` variable. If you have `controller_mode` enabled, the Editor will instead show you `code_override_controller`. Only one can be used at a time. If no override is set in `controller_mode`, it defaults to the controller variant of the Konami Code.

You can also make use of `time_limit_mode`, which lets you connect a Timer to the KonamiCode. KonamiCode will always make your Timer a one-shot that doesn't autorun. You can set the `reset_mode` to however you want your TimeLimit to work.

The available TimeLimitModes are:

`NO_REFRESH`: The timer will start on the first successful press, and never refresh. It will simply reset the code combination when it has run out.
`REFRESH_ON_SUCCESS`: The timer will refresh itself on every successful input.


And finally, you can set up if it should be active by default with the `active` prop, and if it should only fire once with the `fire_only_once` prop.

And finally, just connect the `success` signal!

Now add your own secrets (or just use it for other key-combination related things)!

## Planned features:
- At the moment, nothing. Might change, though!

Just let me know if any other features are wanted or if existing ones should be extended.
Wandering Ants
==============

An implementation _and variant_ of [Langton's Ant], using [Lua] and [Love2D 0.6.2].

Tested against Windows & OSX. The OSX version seems to enjoy destroying my fan,
so there's that.

Started out doing marching left/right based on absolute black/white (as RGBA),
but it's kind of boring, so now it does so based on greyscale values. In theory,
pressing any number from 1-9 will reset the canvas and spawn the appropriate
number of ants, designated on the canvas in decadent red.

Unless I've gone to the effort of deleting it, the source should be available via
[git], hosted on [github].

[Langton's Ant]: http://en.wikipedia.org/wiki/Langton's_ant
[Lua]: http://www.lua.org/
[Love2D 0.6.2]: http://love2d.org/
[git]: git://github.com/kezabelle/wandering_ants.git
[github]: https://kezabelle@github.com/kezabelle/wandering_ants.git

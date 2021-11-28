# Easy Retroclash Nix

Derivations for easily downloading [retroclash](https://unsafePerform.IO/retroclash/) requirements.

## Trial

You can get an appropriate nix-shell with the binaries installed by first testing this with:

```
$ nix-shell
[nix-shell] clashi
Clashi, version 1.4.6 (using clash-lib, version 1.4.6)
```

Run example from the book:

```
$ git clone https://github.com/gergoerdi/retroclash-book-code; cd retroclash-book-code
$ cabal run -f verilator bounce-state
```

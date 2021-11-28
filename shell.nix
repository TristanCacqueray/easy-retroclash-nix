let easy-retroclash-nix = import ./default.nix;
in easy-retroclash-nix.pkgs.mkShell { buildInputs = [ easy-retroclash-nix.ghc ]; }

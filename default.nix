let
  # pin the upstream nixpkgs
  nixpkgsPath = fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/98747f27ecfee70c8c97b195cbb94df80a074dda.tar.gz";
    sha256 = "04ss525ns5qqlggrdhvc6y4hqmshylda9yd0y99ddliyn15wmf27";
  };
  nixpkgsSrc = (import nixpkgsPath);

  # update haskell dependencies
  compilerVersion = "8107";
  compiler = "ghc" + compilerVersion;
  overlays = [
    (final: prev: {
      haskellPackages = prev.haskell.packages.${compiler}.override {
        overrides = hpFinal: hpPrev: {
          # todo: check why this is broken in nixpkgs?
          clash-prelude = pkgs.haskell.lib.dontCheck
            (pkgs.haskell.lib.overrideCabal hpPrev.clash-prelude {
              broken = false;
            });

          clash-shake = pkgs.haskell.lib.overrideCabal hpPrev.clash-shake {
            patches = [
              # See https://github.com/gergoerdi/clash-shake/pull/4
              (pkgs.fetchpatch {
                url =
                  "https://github.com/gergoerdi/clash-shake/commit/7309a84ac8260562d35ec3aeb4e39f24a0f450bd.patch";
                sha256 = "sha256-tI+5/FQA1P7+h+Q4pCCGuVO61Lds0xANAoD8UXddd/I=";
              })
            ];
          };

          # retroclash-sim = hpPrev.callCabal2nix "retroclash-sim"
          #   (pkgs.fetchFromGitHub {
          #     owner = "gergoerdi";
          #     repo = "retroclash-sim";
          #     rev = "a1e11c73d2fa1a42e42d17b3793f9f77f2ec79ac";
          #     sha256 = "sha256-qHu3uZ/o9jBHiA3MEKHJ06k7w4heOhA+6HCSIvflRxo=";
          #   }) { };
        };
      };

    })
  ];

  pkgs = nixpkgsSrc {
    inherit overlays;
    system = "x86_64-linux";
  };
  ghc = pkgs.haskellPackages.ghcWithPackages
    (p: [ p.clash-ghc p.clashilator p.retroclash-sim p.clash-shake ]);

in {
  pkgs = pkgs;
  ghc = ghc;
  shell =
    pkgs.mkShell { buildInputs = [ pkgs.verilator pkgs.pkg-config ghc ]; };
}

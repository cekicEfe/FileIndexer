{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs.buildPackages;
    [
      (pkgs.haskellPackages.callPackage ./project.nix { })
      # pkgs.haskellPackages.ghc # Haskell compiler
      # pkgs.haskellPackages.cabal-install # Cabal build tool
      # pkgs.haskell-language-server
      # pkgs.cabal2nix
    ];

  shellHook = ''
    PS1="[\\u@\\h && HASKELL-DEV-ENV:\\w]\$ "
  '';
}

{
    description = "Simple blast pattern simulator";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let 
                pkgs = nixpkgs.legacyPackages.${system};
                hp = pkgs.haskellPackages;
                blast = hp.callCabal2nix "blast" ./backend { };
            in  {
                packages.default = blast; 
                
                apps.default = {
                    type = "app";
                    program = "${blast}/bin/blast";
                };
                
                devShells.default = hp.shellFor {
                    packages = _: [blast];
                    nativeBuildInputs = [
                        hp.cabal-install
                        hp.haskell-language-server
                        hp.ghcid
                    ];
                };
            });
}

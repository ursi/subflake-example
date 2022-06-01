{ inputs =
    { get-flake.url = "github:ursi/get-flake";
      purs-nix.url = "github:ursi/purs-nix/ps-0.15";
    };

  outputs = { get-flake, ... }@inputs:
    let
      system = "x86_64-linux";
      parent-inputs = (get-flake ../.).inputs;
      pkgs = parent-inputs.nixpkgs.legacyPackages.${system};
      purs-nix = inputs.purs-nix { inherit system; };

      ps =
        purs-nix.purs
          { dependencies =
              with purs-nix.ps-pkgs;
              [ console
                effect
                prelude
              ];

            srcs = [ ./src ];
          };
    in
    { apps.${system}.default =
        { type = "app";
          program = "${ps.modules.Main.app { name = "app"; }}/bin/app";
        };

      devShell.${system} =
        pkgs.mkShell
          { packages =
              with pkgs;
              [ nodejs
                (ps.command {})
                purs-nix.esbuild
                purs-nix.purescript
              ];
          };
    };
}

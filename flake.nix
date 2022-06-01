{ inputs =
    { make-shell.url = "github:ursi/nix-make-shell/1";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      get-flake.url = "github:ursi/get-flake";
    };

  outputs = { get-flake, ... }@inputs:
    let system = "x86_64-linux"; in
    { apps.${system} =
        { ps-14 = (get-flake ./ps-14).apps.${system}.default;
          ps-15 = (get-flake ./ps-15).apps.${system}.default;
        };
    };
}

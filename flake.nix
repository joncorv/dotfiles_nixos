{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    filera.url = "github:joncorv/filera/release";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      filera,
      neovim-nightly-overlay,
      ...
    }:
    {
      nixosConfigurations.giantvoidryzen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.joncorv = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit filera; };
            };

            nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ];
          }
          {
            environment.systemPackages = [
              filera.packages.x86_64-linux.default

            ];
          }
        ];
      };
    };
}

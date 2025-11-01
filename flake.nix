{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      user = {
        info = import ./user.nix;
        secrets = import ./secrets.nix;
      };

      hosts = {
        shittyLaptop = {
          hostname = "shittyLaptop";
          hardware = [ ./hosts/shittyLaptop/hardware-configuration.nix ];
          homenix = ./shared/home.nix;
          systemModules = {
            audio.enable = true;
            display = {
              enable = true;
              displayManager = "lightdm";
              manager = "xfce4";
            };
            gaming.steam.enable = true;
          };
          userModules = {
            git.enable = true;
            textEditor.neovim.enable = true;
            terminal = {
              shell = {
                fish.enable = true;
                extras.starship.enable = true;
              };
              ghostty = {
                enable = true;
                command = "fish --login --interactive";
              };
            };
            nightlight.enable = true;
            displayConfig.i3 = {
              enable = true;
              terminal = "ghostty";
            };
          };
        };
      };

      mkHost = name: host:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs user;
            inherit (host) systemModules;
          };
          modules = [ ./shared/configuration.nix ] ++ host.hardware ++ [
            home-manager.nixosModules.default
            {
              networking.hostName = host.hostname;

              home-manager = { # .
                extraSpecialArgs = {
                  inherit inputs user;
                  inherit (host) userModules;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users."${user.info.username}" = import host.homenix;
              };

            }
          ];
        };
    in { nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hosts; };
}

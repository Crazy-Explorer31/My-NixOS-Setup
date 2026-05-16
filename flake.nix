{
  description = "Stepan's NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra";

    # quickshell = {
    #   url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    poly-mult.url = "github:Crazy-Explorer31/poly-mult";
    freqs-vis.url = "github:Crazy-Explorer31/freqs-vis";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    alejandra,
    zapret-discord-youtube,
    poly-mult,
    freqs-vis,
    ...
  }: let
    system = "x86_64-linux";
    host = "excalibur";
    username = "stepan";
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [overlay-unstable];
    };
  in {
    nixosConfigurations.excalibur = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system;
        inherit inputs;
        inherit username;
        inherit host;
      };
      modules = [
        ./configuration.nix
        inputs.distro-grub-themes.nixosModules.${system}.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.stepan = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
        {
          environment.systemPackages = with pkgs; [
            poly-mult.packages.${system}.default
          ];
        }
        {
          environment.systemPackages = with pkgs; [
            freqs-vis.packages.${system}.default
          ];
        }
        ({
          config,
          pkgs,
          ...
        }: {
          nixpkgs.overlays = [overlay-unstable];
        })
        # zapret-discord-youtube.nixosModules.default
        # {
        #   services.zapret-discord-youtube = {
        #     enable = true;
        #     config = "general (FAKE_TLS_AUTO_ALT2)"; # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
        #   };
        # }
      ];
    };

    # Добавляем standalone home-manager конфигурации
    homeConfigurations."stepan" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
        {
          home = {
            username = "stepan";
            homeDirectory = "/home/stepan";
            stateVersion = "25.11";
          };
        }
      ];
    };
    formatter.x86_64-linux = alejandra.defaultPackage.x86_64-linux;
  };
}

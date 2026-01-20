{
  description = "Stepan's NixOS setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    alejandra.url = "github:kamadorueda/alejandra";

    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      ref = "v1";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ags,
    home-manager,
    alejandra,
    ...
  }: let
    system = "x86_64-linux";
    host = "excalibur";
    username = "stepan";

    pkgs = nixpkgs.legacyPackages.${system};
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

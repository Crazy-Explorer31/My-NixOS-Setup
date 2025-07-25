{
	description = "KooL's NixOS-Hyprland";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
		#nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		hyprland.url = "github:hyprwm/Hyprland"; # hyprland development
		distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
		ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
	};

	outputs = inputs @ {
		self,
		nixpkgs,
		ags,
		home-manager,
		...
	}: let
		system = "x86_64-linux";
		host = "excalibur";
		username = "stepan";

		pkgs =
			import nixpkgs {
				inherit system;
				config = {
					allowUnfree = true;
				};
			};
	in {
		nixosConfigurations = {
			"${host}" =
				nixpkgs.lib.nixosSystem rec {
					specialArgs = {
						inherit system;
						inherit inputs;
						inherit username;
						inherit host;
					};
					modules = [
						./hosts/${host}/config.nix
						inputs.distro-grub-themes.nixosModules.${system}.default
					];
				};
		};
		homeConfigurations.stepan =
			home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.${system};
				modules = [./home.nix];
			}; # maybe remove
	};
}

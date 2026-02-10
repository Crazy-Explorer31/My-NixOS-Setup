# Stepan's NixOS setup

## Structure

* `flake.nix` --- root of system's configuration. Have following as imports:

* * `configuration.nix` --- main system's statements. Includes folliwing:
* * * `modules/system/*.nix`.
* * * `modules/hardware/*.nix` --- hardware stuff.
* * `home.nix` --- home's statements. Includes:
* * * `modules/home/*nix`.

* `UserConfigs/*` --- configs, defining true configs by symlinks

* `UserScripts/*` --- stuff, that niri's `spawn-sh` cannot do.

## Tips to use

* Use commands:
* * `nrs` --- to rebuild system (alias for `sudo nixos-rebuild switch --flake .`)
* * `hs` --- to rebuild home via home-manager (alias for `home-manager switch --flake .#stepan`)
* * `nr` --- to validate niri config (alias for `niri validate`)
* * `ngc` --- to delete unused packages (alias for `sudo nix-store --gc`)

## Usage demonstation

![record](record.gif)

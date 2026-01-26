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
* * `nrs` --- to rebuild system
* * `hs` --- to rebuild home (home-manager)
* * `nr` --- to validate niri config

## Usage demonstation

![record](record.gif)

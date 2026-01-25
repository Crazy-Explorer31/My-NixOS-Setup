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

* v2ray bad? --> run `sudo systemctl stop v2ray.service`, run v2rayA. To revert, stop v2rayA and run `sudo systemctl start v2ray.service`.

## Usage demonstation

![record](record.mp4)

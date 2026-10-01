#!/bin/sh

cd my-NixOS; sudo nixos-rebuild switch --flake .#excalibur --option substituters "https://cache.nixos.org/" --option extra-substituters ""  && echo 'Press any key to continue...'; read -n 1 -s -r

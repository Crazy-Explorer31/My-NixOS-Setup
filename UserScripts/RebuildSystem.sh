#!/bin/sh

cd my-NixOS; sudo nixos-rebuild switch --flake . && echo 'Press any key to continue...'; read -n 1 -s -r

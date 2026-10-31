#!/bin/sh

cd my-NixOS; home-manager switch --flake .#stepan --option extra-substituters "" --option substituters "https://cache.nixos.org/" --option trusted-public-keys "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" && echo 'Press any key to continue...'; read -n 1 -s -r

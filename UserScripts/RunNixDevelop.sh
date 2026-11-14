#!/bin/bash

nix develop \
    --option extra-substituters "" \
    --option substituters "https://cache.nixos.org/" \
    --option trusted-public-keys "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" \
    --command code .

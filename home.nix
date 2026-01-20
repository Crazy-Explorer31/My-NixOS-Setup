{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/home/ghostty.nix
  ];
  home.username = "stepan";
  home.homeDirectory = "/home/stepan";
  home.stateVersion = "25.11";

  programs.git.enable = true;
  programs.swaylock.enable = true;
  programs.swaylock.package = pkgs.swaylock-effects;

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/my-NixOS/UserConfigs/config.kdl";
}

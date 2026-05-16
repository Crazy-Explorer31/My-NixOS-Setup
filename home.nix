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

  programs.git = {
    enable = true;
    settings = {
      user.name = "Sokolovsky Stepan";
      user.email = "stepan.soko@list.ru";
    };
  };

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/my-NixOS/UserConfigs/config.kdl";

  xdg.configFile."v2raya/config.json".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/my-NixOS/UserConfigs/v2ray_config.json";

  xdg.configFile."alacritty/alacritty.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/my-NixOS/UserConfigs/alacritty.toml";

  home.file.".proxy/youtube-proxy.pac" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/my-NixOS/UserConfigs/youtube-proxy.pac";
  };
  home.file."shell.nix" = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/my-NixOS/UserConfigs/shell_with_cuda.nix";
  };
}

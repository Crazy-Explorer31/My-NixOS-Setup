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
  home.stateVersion = "26.11";
  programs.git = {
    enable = true;
    settings = {
      user.name = "Sokolovsky Stepan";
      user.email = "stepan.soko@list.ru";
    };
  };
  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      smart-enter = smart-enter;
      chmod = chmod;
      mediainfo = mediainfo;
      duckdb = duckdb;
      lsar = lsar;
    };

    settings = {
      plugin = {
        prepend_previewers = [
          {
            mime = "video/*";
            run = "mediainfo";
          }
          {
            mime = "audio/*";
            run = "mediainfo";
          }
          {
            url = "*.csv";
            run = "duckdb";
          }
          {
            url = "*.tsv";
            run = "duckdb";
          }
          {
            mime = "application/zip";
            run = "lsar";
          }
          {
            mime = "application/x-tar";
            run = "lsar";
          }
          {
            mime = "application/x-bzip2";
            run = "lsar";
          }
          {
            mime = "application/x-rar";
            run = "lsar";
          }
        ];
      };
    };

    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = "<Enter>";
            run = "plugin smart-enter";
            desc = "Enter the directory or open the file";
          }

          {
            on = ["c" "m"];
            run = "plugin chmod";
            desc = "Change file permissions";
          }

          {
            on = ["T"];
            run = "shell 'zsh' --block";
            desc = "Open Bash in current directory";
          }
        ];
      };
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

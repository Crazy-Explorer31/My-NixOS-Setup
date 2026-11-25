{
  pkgs,
  inputs,
  ...
}: let
  python-packages = pkgs.python3.withPackages (ps:
    with ps; [
      requests
      pyquery
      numpy
      pandas
      jupyter
      scikit-learn
      fastapi
      regex
      uvicorn
      selenium
      beautifulsoup4
      redis
      rq
      aiobotocore
      aioboto3
      pyarrow
      pygobject3
      fastapi
      pytest
    ]);
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # Системные утилиты
      vim
      neovim
      wget
      git
      bc
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf
      findutils
      ffmpeg
      glib
      gsettings-qt
      killall
      libappindicator
      libnotify
      openssl
      pciutils
      xdg-user-dirs
      xdg-utils
      home-manager
      acpi
      ddcutil
      power-profiles-daemon
      gpu-screen-recorder

      # Niri и Wayland
      niri
      xwayland-satellite
      seatd
      swaybg
      wl-clipboard

      # Терминалы и оболочки
      btop
      tmux

      # Браузеры
      firefox
      brave

      # Мультимедиа
      (mpv.override {scripts = [mpvScripts.mpris mpvScripts.cutter mpvScripts.manga-reader];})
      mpvScripts.mpris
      mpvpaper
      brightnessctl
      cava
      pamixer
      pavucontrol
      playerctl
      yt-dlp
      # ffmpeg-full
      libva
      libvdpau
      libva-vdpau-driver
      libopus
      libvorbis
      libsndfile
      # vivaldi-ffmpeg-codecs
      openh264

      # Графика и скриншоты
      grim
      slurp
      swappy
      feh
      matugen

      # Уведомления
      swaynotificationcenter

      # Рабочий стол и UI
      rofi
      wlogout
      polkit_gnome
      networkmanagerapplet
      nwg-displays
      nwg-look
      evolution-data-server
      evolution
      gnome-calendar
      evolution-data-server-gtk4
      gnome-online-accounts
      gnome-online-accounts-gtk
      gobject-introspection
      libical
      jellyfin

      # Qt темы
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum

      # Файловые менеджеры и архиваторы
      thunar-archive-plugin
      file-roller
      (thunar.override {thunarPlugins = [thunar-archive-plugin];})
      # yazi
      xarchiver
      unzip
      zip
      unar
      mediainfo
      mdcat
      unrar
      _7zz
      poppler-utils
      fd
      zoxide
      resvg

      # Офис и документы
      evince
      libreoffice
      pandoc
      python3Packages.weasyprint
      dejavu_fonts
      # apostrophe
      pdfarranger
      stirling-pdf
      # Typst
      typst
      typst-live
      typstyle
      typstwriter
      tinymist
      typstPackages.zebraw
      typstPackages.itemize
      typstPackages.showybox
      typstPackages.glossarium
      typstPackages.fontawesome

      # Разработка
      vscode-fhs
      jdk21_headless
      nodejs_24
      ghc
      fourmolu
      ormolu
      haskell-language-server
      # R
      # rstudio
      gcc
      gdb
      cmake
      ninja
      meson
      pre-commit
      uv
      zed-editor
      obsidian
      llvmPackages_20.clang-tools
      fzf
      ripgrep
      ripgrep-all
      alacritty-graphics
      alacritty-theme

      # Системные утилиты
      inxi
      jq
      yad
      zenity
      tree
      cowsay
      bat
      fastfetch
      plocate
      parted
      gparted
      nvtopPackages.full
      direnv
      nix-direnv
      nix-search-tv
      bluez5
      exfat
      exfatprogs
      # heroic
      netcat
      bitwarden-cli
      bitwarden-desktop

      # Базы данных
      cassandra

      # Сеть
      telegram-desktop
      qbittorrent
      wireshark
      darkstat
      v2ray
      v2raya
      tor-browser
      sing-box
      gui-for-singbox
      webkitgtk_6_0
      virtiofsd

      # Виртуализация и контейнеры
      docker
      docker-compose
      distrobox

      # Графические приложения
      gimp
      davinci-resolve
      # kdePackages.kdenlive
      obs-studio
      peek
      upscayl
      losslesscut-bin
      drawing
      tauon
      scantailor-advanced
      gpu-screen-recorder

      # Игры
      steam
      # lutris
      endless-sky
      gamescope-wsi

      # Wine
      wine
      wineWow64Packages.stableFull
      winetricks
      # bottles
      protontricks

      # Другие утилиты
      zoom-us
      asciinema
      file
      pomodoro-gtk
      czkawka-full
      ollama
      yandex-disk
      rclone
      yandex-music
      spotify
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      noctalia-greeter
      wlsunset
      wallust
      cliphist
      loupe
      inotify-tools
      black
      ruff
      audacity
      # opencode
      # opencode-desktop
      claude-code
      codex
      syncthing
      flameshot
      cpu-x
      nsxiv
      localsend
      yandex-cloud
      fish
      numlockx

      # Библиотеки
      glibc
      wayland
      wayland-protocols
      libinput
      libdrm
      libxkbcommon
      pixman
      libdisplay-info
      libliftoff
      hwdata
      pcre2
      libgcc
      gmp
      gsl
      fuse
      gtk3
      gtk4
      fluent-gtk-theme
      flat-remix-icon-theme # Иконки
      bibata-cursors
      chromedriver
      vulkan-tools
      tectonic
      libqalculate
      daktilo
      # other
      alejandra
      astroterm
      python313Packages.conda
      evtest
      networkmanagerapplet
      imagemagick
      libxcb
      foliate
      # CUDA stuff
      # cudaPackages.cudatoolkit
      # cudaPackages.cudnn
      # cudaPackages.cuda_cudart

      # Rust stuff
      # cargo
      # rustc
      # rustup
      rustfmt
      rust-analyzer
      rustlings
    ])
    ++ [python-packages];

  # Шрифты
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome
    hackgen-nf-font
    ibm-plex
    inter
    jetbrains-mono
    material-icons
    maple-mono.NF
    minecraftia
    nerd-fonts.im-writing
    nerd-fonts.blex-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
    powerline-fonts
    roboto
    roboto-mono
    terminus_font
    victor-mono
    cascadia-code
    fira
    fira-math
    fira-go
    fira-mono
  ];

  programs = {
    niri.enable = true;
    firefox = {
      enable = true;
      preferences = {
        # Принудительное аппаратное декодирование (для актуальных версий Firefox 137+)
        "media.hardware-video-decoding.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;

        # Ускорение рендеринга и DMA-BUF
        "gfx.x11-egl.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        # Обязательно отключаем AV1, так как GTX 1650 не поддерживает его аппаратно
        "media.av1.enabled" = false;
      };
    };
    git.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    thunar.enable = true;
    thunar.plugins = with pkgs; [
      # exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

    # XWayland для совместимости
    xwayland.enable = true;

    # Системные утилиты
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    gamescope = {
      enable = true;
      args = ["--force-gfx-api" "vulkan"];
    };
    nix-ld.enable = true;
    kdeconnect.enable = true;
    solaar.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
    gamemode.enable = true;
    # yazi = {
    #   enable = true;
    #   # plugins = with pkgs.yaziPlugins; {
    #   #   # Plugins that don't call setup() can be configured in one line
    #   #   smart-enter = smart-enter;
    #   #   chmod = chmod;
    #   # };
    # };
  };

  # Portal Configuration для Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal
    ];
  };

  # Включаем seatd для управления сессиями
  services.seatd.enable = true;
  # services.happ.enable = true;

  services.syncthing = {
    enable = true;
    # user = "stepan"; # ваш логин
    # group = "stepan"; # или "stepan", но обычно users
    openDefaultPorts = true;
    # guiAddress = "0.0.0.0:8384";
  };

  # Дополнительные настройки для Niri
  environment.sessionVariables = {
    NIRI_SESSION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    EDS_PREFIX = "${pkgs.evolution-data-server}";
  };

  # Убедитесь, что драйверы видео работают
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}

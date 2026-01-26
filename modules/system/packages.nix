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
    ]);
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # Системные утилиты
      vim
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
      foot
      btop

      # Браузеры
      firefox

      # Мультимедиа
      (mpv.override {scripts = [mpvScripts.mpris];})
      brightnessctl
      cava
      pamixer
      pavucontrol
      playerctl
      yt-dlp
      ffmpeg-full
      libva
      libvdpau
      libva-vdpau-driver
      libopus
      libvorbis
      libsndfile
      vivaldi-ffmpeg-codecs
      openh264

      # Графика и скриншоты
      grim
      slurp
      swappy
      feh
      imagemagick
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
      gnome-calendar
      evolution-data-server-gtk4
      gnome-online-accounts
      gnome-online-accounts-gtk
      jellyfin

      # Qt темы
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum

      # Файловые менеджеры и архиваторы
      xfce.thunar-archive-plugin
      file-roller
      (xfce.thunar.override {thunarPlugins = [xfce.thunar-archive-plugin];})
      xarchiver
      unzip
      zip
      unrar

      # Офис и документы
      evince
      libreoffice
      apostrophe
      pdfarranger
      stirling-pdf
      typst
      typst-live

      # Разработка
      vscode
      vscodium
      jdk21_headless
      nodejs_24
      ghc
      fourmolu
      ormolu
      haskell-language-server
      R
      rstudio
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
      fzf-zsh
      ripgrep
      ripgrep-all

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

      # Сеть
      telegram-desktop
      qbittorrent
      wireshark
      darkstat
      v2ray
      v2raya

      # Виртуализация и контейнеры
      docker
      docker-compose

      # Графические приложения
      gimp
      davinci-resolve
      obs-studio
      peek
      upscayl
      losslesscut-bin
      drawing
      amberol

      # Игры
      steam
      endless-sky
      gamescope-wsi

      # Wine
      wine
      wineWow64Packages.stableFull
      wineWow64Packages.waylandFull
      winetricks
      wine64Packages.waylandFull
      bottles

      # Другие утилиты
      zoom-us
      asciinema
      pomodoro-gtk
      czkawka-full
      ollama
      yandex-disk
      yandex-music
      (inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default)
      wlsunset
      wallust
      cliphist
      loupe

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
      gtk-engine-murrine
      flat-remix-gtk # GTK тема
      flat-remix-icon-theme # Иконки
      # bibata-cursors       # Курсоры (раскомментировать если нужно)
      chromedriver
      vulkan-tools
      wineWowPackages.staging
      tectonic
      libqalculate
      daktilo
      # other
      alejandra
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
  ];

  programs = {
    niri.enable = true;
    firefox.enable = true;
    git.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
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
  };

  # Portal Configuration для Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = false;
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

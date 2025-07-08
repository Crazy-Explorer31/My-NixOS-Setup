# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config
{
  pkgs,
  inputs,
  ...
}: let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        numpy
        pandas
        jupyter
        scikit-learn
        fastapi
        regex
        uvicorn
        selenium
        beautifulsoup4
      ]
  );
in {
  nixpkgs.config.allowUnfree = true; # maybe remove
  environment.systemPackages =
    (with pkgs; [
      # System Packages
      bc
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf
      eza # maybe remove
      findutils
      ffmpeg
      glib #for gsettings to work
      gsettings-qt
      git
      killall
      libappindicator
      libnotify
      openssl #required by Rainbow borders
      pciutils
      vim
      wget
      xdg-user-dirs
      xdg-utils

      fastfetch
      (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      #ranger

      # Hyprland Stuff
      #ags # note: defined at flake.nix to download and install ags v1
      # Buuild AGS v1 from source
      inputs.ags.packages.${pkgs.system}.default
      btop
      brightnessctl # for brightness control
      cava
      eog
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine #for gtk themes
      hyprcursor
      hypridle
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum #kvantum
      networkmanagerapplet
      nwg-displays
      nwg-look
      nvtopPackages.full
      nvtopPackages.panthor # maybe remove
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      # pyprland # maybe remove
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum #kvantum
      rofi-wayland
      slurp
      swappy
      swaynotificationcenter
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp
      gradle
      home-manager
      #-------------------------------------MY PACKAGES--------------------------------------------------

      xfce.thunar-archive-plugin
      file-roller
      (pkgs.xfce.thunar.override {thunarPlugins = [pkgs.xfce.thunar-archive-plugin];})
      evince
      vscode
      jdk21_headless
      telegram-desktop
      nekoray
      gparted

      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      zoom-us
      asciinema
      drawing
      python312Packages.notebook
      python312Packages.jupyter-core
      python312Packages.pip
      wlsunset
      apostrophe
      emacs
      libgcc
      jetbrains.idea-community
      libreoffice
      tree
      cowsay
      qemu
      cmake
      gcc
      gdb
      nodejs_24
      obs-studio
      gmp
      chromedriver
      darktable
      amberol
      yandex-disk
      yandex-music
      zed-editor
      docker
      docker-compose
      parted
      qbittorrent
      zenity
      wine
      wineWow64Packages.stableFull
      wineWow64Packages.waylandFull
      winetricks
      bottles
      gsl
      ninja
      texliveFull
      texstudio
      pre-commit
      fuse
      jetbrains.pycharm-community
      unrar
      redis
      xdg-desktop-portal
      kdePackages.xdg-desktop-portal-kde
      libsForQt5.xdg-desktop-portal-kde
      v2ray
      v2raya
      bat
      elegant-sddm
      vscodium
      alejandra
      direnv
      numlockx
      #-------------------------------------MY PACKAGES--------------------------------------------------

      #waybar  # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];

  # FONTS
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
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
    powerline-fonts
    roboto
    roboto-mono
    symbola
    terminus_font
    victor-mono
    #(nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    # nerd-fonts.jetbrains-mono # unstable
    # nerd-fonts.fira-code # unstable
  ];
}

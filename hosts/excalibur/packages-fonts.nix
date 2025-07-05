# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config

{ pkgs, inputs, ...}: let

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
  environment.systemPackages = (with pkgs; [
  # System Packages
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
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
    ags # note: defined at flake.nix to download and install ags v1
    btop
    brightnessctl # for brightness control
    cava
    eog
    gnome-system-monitor
    grim
    gtk-engine-murrine #for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    imagemagick
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum #kvantum
    networkmanagerapplet
    nwg-look # requires unstable channel
    nvtopPackages.panthor
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
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
    cliphist
    gradle
    home-manager
    #-------------------------------------MY PACKAGES--------------------------------------------------

    #thunar-archive-plugin-0.3.1
    #file-roll
    #file-roller
    (pkgs.xfce.thunar.override { thunarPlugins = [pkgs.xfce.thunar-archive-plugin]; })
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
	nodejs_23
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
    #-------------------------------------MY PACKAGES--------------------------------------------------

    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	python-packages
  ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-emoji
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
	  terminus_font
    #(nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    nerd-fonts.jetbrains-mono # unstable
    nerd-fonts.fira-code # unstable
 	];
  }

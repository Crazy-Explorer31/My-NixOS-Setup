# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options
{
	pkgs,
	inputs,
	...
}: let
	python-packages =
		pkgs.python3.withPackages (
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
	nixpkgs.config.allowUnfree = true;

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
				# Buuild AGS v1 from source
				inputs.ags.packages.${pkgs.system}.default
				btop
				brightnessctl # for brightness control
				cava
				cliphist
				loupe
				gnome-system-monitor
				grim
				gtk-engine-murrine #for gtk themes
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
				pamixer
				pavucontrol
				playerctl
				polkit_gnome
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
				ags

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
				wine64
				wineWow64Packages.full
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
				krabby
				home-manager
				obsidian
				openshot-qt
				blender
				davinci-resolve
				collabora-online
				onlyoffice-desktopeditors
				libreoffice-qt6-fresh
				gephi
				xorg.xhost
				feh
				plymouth
				adi1090x-plymouth-themes
				cabextract
				protonup-qt
				steam
				vulkan-tools
    			wineWowPackages.staging
				tectonic
				# mlocate # longer...
				plocate
				pomodoro-gtk
				gamescope-wsi
				inputs.woomer.packages.${system}.default
				cage
				weston
				sway
				river
				zip

				#-------------------------------------ZEN-BROWSER----------------------------------------------------------

				# inputs.zen-browser.packages."${system}".default # beta
				# inputs.zen-browser.packages."${system}".beta
				# inputs.zen-browser.packages."${system}".twilight
				# # IMPORTANT: this package relies on the twilight release artifacts from the
				# # official zen repo and those artifacts are always replaced, causing hash mismatch
				# inputs.zen-browser.packages."${system}".twilight-official

				# you can even override the package policies
				# inputs.zen-browser.packages."${system}".default.override {
				# policies = {
				# 	DisableAppUpdate = true;
				# 	DisableTelemetry = true;
				# };
				# }
				#-------------------------------------ZEN-BROWSER----------------------------------------------------------

				#-------------------------------------FOR DAVINCI-RESOLVE--------------------------------------------------
				ffmpeg-full
				# Дополнительные библиотеки
				libva
				libvdpau
				vaapiVdpau
				# Аудио кодеки
				libopus
				libvorbis
				libsndfile
				vivaldi-ffmpeg-codecs
				openh264
				#-------------------------------------FOR HASKELL--------------------------------------------------
				ghc
				fourmolu
				haskell-language-server
				#-------------------------------------MY PACKAGES--------------------------------------------------

				#waybar  # if wanted experimental next line
				#(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
			])
		++ [
			python-packages
		];

	#FONTS
	fonts = {
		packages = with pkgs; [
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

			noto-fonts-emoji
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			noto-fonts-monochrome-emoji
			powerline-fonts
			roboto
			roboto-mono
			# symbola # failed to fetch from web archive
			terminus_font
			victor-mono
		];
	};

	programs = {
		hyprland = {
			enable = true;
			#package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
			#portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git

			portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
			xwayland.enable = true;
		};

		waybar.enable = true;
		hyprlock.enable = true;
		firefox.enable = true;
		git.enable = true;
		nm-applet.indicator = true;
		#neovim.enable = true;

		thunar.enable = true;
		thunar.plugins = with pkgs.xfce; [
			exo
			mousepad
			thunar-archive-plugin
			thunar-volman
			tumbler
		];

		virt-manager.enable = false;

		steam = {
		 enable = true;
		 gamescopeSession.enable = true;
		 remotePlay.openFirewall = true;
		 dedicatedServer.openFirewall = true;
		};

		xwayland.enable = true;

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
			args = [ "vulkan" ];
		};
	};

	# Extra Portal Configuration
	xdg.portal = {
		enable = true;
		wlr.enable = false;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
		configPackages = [
			pkgs.xdg-desktop-portal-gtk
			pkgs.xdg-desktop-portal
		];
	};
}

# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  host,
  username,
  options,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./modules/system/hardware-configuration.nix
    ./modules/system/users.nix
    ./modules/system/packages.nix
    ./modules/system/theme.nix
    ./modules/system/quickshell.nix
    ./modules/system/nh.nix
    ./modules/system/overlays.nix
    ./modules/system/vm.nix

    ./modules/hardware/amd-drivers.nix
    ./modules/hardware/nvidia-drivers.nix
    ./modules/hardware/nvidia-prime-drivers.nix
    ./modules/hardware/intel-drivers.nix
    ./modules/hardware/vm-guest-services.nix
    ./modules/hardware/local-hardware-clock.nix
  ];
  nixpkgs.config.allowUnfree = true;
  # Boot
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  # Use grub
  boot.loader.grub = {
    enable = true;
    devices = ["nodev"];
    efiSupport = true;
    gfxmodeBios = "auto";
    memtest86.enable = true;
    extraGrubInstallArgs = ["--bootloader-id=excalibur"];
    configurationName = "${host}";
    useOSProber = true;
  };
  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen; # zen Kernel
    #kernelPackages = pkgs.linuxPackages_latest; # Kernel

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];

    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    #  extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

    loader.timeout = 1;

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth.enable = true;
  };

  # Extra Module Options
  drivers = {
    amdgpu.enable = true;
    intel.enable = true;
    nvidia.enable = true;
    nvidia-prime = {
      enable = false;
      amdgpuBusID = "PCI:5:0:0";
      nvidiaBusID = "PCI:1:0:0";
    };
  };
  vm.guest-services.enable = true;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  };

  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services = {
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 25;
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "colormix";
        bigclock = true;
        # --- Color Settings (0xAARRGGBB) ---
        # Background color of dialog box (Black)
        bg = "0x00000000";
        # Foreground text color (Cyan: #00FFFF)
        fg = "0x0000FFFF";
        # Border color (Red: #FF0000)
        border_fg = "0x00FF0000";
        # Error message color (Red)
        error_fg = "0x00FF0000";
        # Clock color (Purple: #800080)
        clock_color = "#800080";
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    joycond.enable = true; # Для Nintendo Switch контроллеров

    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    acpid.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    rpcbind.enable = true;
    nfs.server.enable = true;

    flatpak.enable = true;

    blueman.enable = true;

    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    fwupd.enable = false;

    upower.enable = true;

    gnome.gnome-keyring.enable = true;

    locate = {
      enable = true;
      package = pkgs.plocate; # более быстрая версия
      interval = "hourly"; # обновлять ежечасно
    };

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};

    #ipp-usb.enable = true;

    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};

    v2ray = {
      enable = true;
      configFile = "/home/${username}/.config/v2raya/config.json"; # symlink configured in home.nix
    };
    v2raya = {
      enable = true;
    };
    gnome.evolution-data-server.enable = true;
    jellyfin.enable = true;
  };
  # environment.etc."v2raya/config.json".source = ./UserConfigs/v2ray_config.json;

  # security.sudo.wheelNeedsPassword = false;

  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware = {
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
  };

  services.pulseaudio.enable = false; # stable branch

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
       polkit.addRule(function(action, subject) {
         if (
           subject.isInGroup("users")
             && (
               action.id == "org.freedesktop.login1.reboot" ||
               action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
               action.id == "org.freedesktop.login1.power-off" ||
               action.id == "org.freedesktop.login1.power-off-multiple-sessions"
             )
           )
         {
           return polkit.Result.YES;
         }
      })
    '';
  };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  # virtualisation.libvirtd.enable = false;
  # virtualisation.podman = {
  #   enable = false;
  #   dockerCompat = false;
  #   defaultNetwork.settings.dns_enabled = false;
  # };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.steam-hardware.enable = true;
  hardware.xone.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
}

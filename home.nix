{
	config,
	pkgs,
	...
}: {
	home = {
		username = "stepan";
		homeDirectory = "/home/stepan";
		stateVersion = "25.05";
		packages = with pkgs; [
			htop
		];
	};

	systemd.user = {
	  services.weather-updater = {
		Unit.Description = "Weather Update Service";
		Service = {
		  Type = "oneshot";
		  ExecStart = "${pkgs.python3}/bin/python ${config.home.homeDirectory}/.config/hypr/UserScripts/WeatherNew.py";
		};
	  };

	  timers.weather-updater = {
		Unit.Description = "Run weather update every 15 minutes";
		Timer = {
		  OnCalendar = "*:0/15";
		  Persistent = true;
		};
		Install.WantedBy = ["timers.target"];
	  };
	};

	# ---------------------------------GTK-------------------------------------
	#gtk.enable = true;

	#gtk.cursorTheme.package = pkgs.bibata-cursors;
	#gtk.cursorTheme.name = "Bibata-Modern-Ice";

	# gtk.theme.package = pkgs.adw-gtk3;
	# gtk.theme.name = "adw-gtk3";

	# gtk.iconTheme.package = gruvboxPlus;
	# gtk.iconTheme.name = "GruvboxPlus";

	# ---------------------------------QT--------------------------------------
	# qt.enable = true;
	# qt.platformTheme = "gtk";
	# qt.style.name = "adwaita-dark";
	# qt.style.package = pkgs.adwaita-qt;

	# --------------------------------SDDM --------------------------------------
}

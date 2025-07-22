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

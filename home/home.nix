{
  config,
  pkgs,
  lib,
  # filera,
  ...
}:

{
  home.username = "joncorv";
  home.homeDirectory = "/home/joncorv";
  home.stateVersion = "25.05";
  programs.waybar.enable = false;
  programs.hyprpanel.enable = true;

  # home.packages = with pkgs; [
  #   filera.packages.${system}.default
  # ];

  imports = [
    ./config_symlinks.nix
    ./modules/cli.nix
    ./modules/gui_apps.nix
    ./modules/lsp.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Yaru-purple-dark"; # or just "Yaru-blue"
      package = pkgs.yaru-theme;
    };

    font = {
      name = "Inter";
      size = 11;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Yaru-purple-dark";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    templates = "${config.home.homeDirectory}/Templates";
  };

}

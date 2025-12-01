{ pkgs, ... }:

{
  home.packages = with pkgs; [
    slack
    chromium
    bitwarden-desktop
    wofi
    nautilus
    spotify
    loupe
    celluloid
    obsidian
    gnome-font-viewer
    font-manager
    resources
    gnome-calculator
    gnome-clocks
    gnome-disk-utility
    gnome-calendar
    blender
    # hyprlock
    # hypridle
    # hyprsysteminfo
    # hyprcursor
    # hyprutils
    # hyprgraphics
    waypaper
    pavucontrol
    mpvpaper
    rofi
    fuzzel
    swaylock
  ];
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # ./modules/sddm.nix
    ../../modules/boot.nix
  ];

  hardware.amdgpu.initrd.enable = true;

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.tailscale.enable = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.dbus.enable = true;
  services.udisks2.enable = true;
  services.gnome.sushi.enable = true;

  nix.settings = {
    trusted-users = [
      "root"
      "joncorv"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://filera.cachix.org"
      "https://neovim-nightly.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "filera.cachix.org-1:yx3+MmKusxFNI8/64NP0D4FZE9F1pXCGgyI7TPuAcEQ="
    ];
    auto-optimise-store = true;
  };

  time.timeZone = "America/Los_Angeles";

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
    xwayland.enable = true;
  };

  users.users.joncorv = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # gnome files stuff
  services.gvfs.enable = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    gh
    gvfs
    cacert
    dconf
    pipewire
    xdg-user-dirs
    xdg-user-dirs-gtk
    curl
    gsettings-desktop-schemas
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
    nerd-fonts.zed-mono
    nerd-fonts.victor-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.adwaita-mono
    nerd-fonts.iosevka
    cascadia-code
    fantasque-sans-mono
    inter
    source-sans-pro
    source-serif
    cantarell-fonts
    iosevka
    eb-garamond
    noto-fonts
    noto-fonts-color-emoji
    dejavu_fonts
    liberation_ttf

  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.05";

}

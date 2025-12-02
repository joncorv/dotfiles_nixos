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
    ../../modules/hyprland.nix
    # ../../modules/niri.nix
  ];

  hardware.amdgpu.initrd.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # hoping this makes my wifi card recognized
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "ath9k" ];

  services = {
    openssh.enable = true;
    openssh.settings.PermitRootLogin = "no";
    tailscale.enable = true;
    dbus.enable = true;
    udisks2.enable = true;
    gnome.sushi.enable = true;
    resolved.enable = true;
    # gnome files stuff
    gvfs.enable = true;
    blueman.enable = true;
  };

  nix.settings = {
    trusted-users = [
      "root"
      "joncorv"
    ];
    substituters = [
      "https://cache.nixos.org"
      # "https://filera.cachix.org"
      "https://neovim-nightly.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # "filera.cachix.org-1:yx3+MmKusxFNI8/64NP0D4FZE9F1pXCGgyI7TPuAcEQ="
    ];
    auto-optimise-store = true;
    download-buffer-size = 524288000; # 500 MiB
  };

  time.timeZone = "America/Los_Angeles";

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
    xwayland.enable = true;
  };

  users.users.joncorv = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
    ];
  };

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

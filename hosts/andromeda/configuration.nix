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
    # ../../modules/boot.nix
    # ../../modules/hyprland.nix
    # ../../modules/niri.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-a000f339-e27a-43cb-ae31-2608106d779f".device =
    "/dev/disk/by-uuid/a000f339-e27a-43cb-ae31-2608106d779f";

  networking = {
    hostName = "andromeda";
    networkmanager.enable = true;
  };

  hardware.enableRedistributableFirmware = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "astro";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services = {
    openssh.enable = true;
    openssh.settings.PermitRootLogin = "no";
    tailscale.enable = true;
    resolved.enable = true;
    printing.enable = true;
    rtkit.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  nix.settings = {
    trusted-users = [
      "root"
      "astro"
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

  users.users.astro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
    ];
    initialPassword = "temp";
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
    git
    cacert
    dconf
    # pipewire
    curl
    gsettings-desktop-schemas
    neovim
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}

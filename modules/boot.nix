{ pkgs, ... }:
{

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     initial_session = {
  #       command = "Hyprland";
  #       user = "joncorv";
  #     };
  #     default_session = {
  #       command = "Hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };

  boot = {
    # Early KMS for proper Plymouth resolution
    # initrd = {
    #   systemd.enable = true;
    #   kernelModules = [
    #     "amdgpu" # For AMD GPUs
    #   ];
    #   verbose = false;
    # };

    # graphical support for entering password
    initrd.systemd.enable = true;

    plymouth = {
      enable = true;
      # theme = "matrix";
      # theme = "catppuccin-macchiato";
      theme = "cuts";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "rings"
            "cuts"
          ];
        })
        catppuccin-plymouth
        plymouth-matrix-theme
      ];
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      timeout = 0;
    };

    # this is more verbose
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    # this is CLEAN
    # consoleLogLevel = 0;
    # kernelParams = [
    #   "quiet"
    #   "splash"
    #   "boot.shell_on_fail"
    # ];

  };
}

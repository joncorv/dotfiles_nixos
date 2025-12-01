{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprsysteminfo
    hyprcursor
    hyprutils
    hyprgraphics
  ];

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = "joncorv";
      };
      default_session = {
        command = "Hyprland";
        user = "greeter";
      };
    };
  };

}

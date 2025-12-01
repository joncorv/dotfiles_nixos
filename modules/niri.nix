{ pkgs, ... }:
{

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    alacritty
    waybar
  ];

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "joncorv";
      };
      default_session = {
        command = "niri-session";
        user = "greeter";
      };
    };
  };

}

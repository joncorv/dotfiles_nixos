{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # add special niri packages here
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

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

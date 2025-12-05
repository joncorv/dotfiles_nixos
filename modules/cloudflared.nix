{ pkgs, ... }:

{

  services.cloudflared = {
    enable = true;
    tunnels = {
      "38fe9df0-7f50-461a-8c51-767ca8e0bb4e" = {
        credentialsFile = "/home/astro/.cloudflared/38fe9df0-7f50-461a-8c51-767ca8e0bb4e.json";
        default = "http_status:404";
        ingress = {
          "jelly.joncorv.com" = "http://localhost:8096";
        };
      };
    };
  };

  environment.systemPackages = [
    pkgs.cloudflared
  ];

}

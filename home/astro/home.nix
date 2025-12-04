{
  config,
  pkgs,
  lib,
  # filera,
  ...
}:

{
  home.username = "astro";
  home.homeDirectory = "/home/astro";
  home.stateVersion = "25.05";

  imports = [
    ./config_symlinks.nix
    ./modules/cli.nix
    ./modules/gui_apps.nix
    ./modules/lsp.nix
  ];

}

{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/home/${config.home.username}";
in
{
  home.file = {
    # ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hypr";
    # ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hyprpanel";
    # ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hyprpanel";
    # ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hyprpanel";
    # ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hyprpanel";
    # ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hyprpanel";
    # ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/hyprpanel";
    ".config/test_symlink".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/test_symlink";
  };
}

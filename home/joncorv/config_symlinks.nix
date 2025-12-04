{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/home/${config.home.username}";
in
{
  home.file = {

    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/hypr";

    ".config/hyprpanel".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/hyprpanel";

    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/kitty";

    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/nvim";

    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/rofi";

    ".config/waybar_bak".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/waybar_bak";

    ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/wezterm";

    ".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.config/niri";
  };
}

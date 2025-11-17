{
  config,
  pkgs,
  lib,
  filera,

  ...
}:

{
  home.username = "joncorv";
  home.homeDirectory = "/home/joncorv";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings = {
      user.name = "joncorv";
      user.email = "joncorv@gmail.com";
      credential = {
        "https://github.com".helper = "!gh auth git-credential";
        "https://gist.github.com".helper = "!gh auth git-credential";
      };
    };
  };

  home.packages = [
    # filera.packages.${pkgs.system}.default
  ];

  programs.wezterm.enable = true;

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      pyright
      rust-analyzer
      stylua
      vue-language-server
      vtsls
      prettierd
      prettier
      tailwindcss-language-server
      shfmt
      basedpyright
      black
      isort
      ruff
      bash-language-server
      typescript-language-server
      hyprls
      pkgs.imagemagick
    ];
    extraLuaPackages = ps: [ ps.magick ];
  };

  programs.yazi = {
    enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Yaru-purple-dark"; # or just "Yaru-blue"
      package = pkgs.yaru-theme;
    };

    font = {
      name = "Inter";
      size = 11;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Yaru-purple-dark";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    templates = "${config.home.homeDirectory}/Templates";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#212337";
          foreground = "#ebfafa";
        };
        cursor = {
          text = "#212337";
          cursor = "#ebfafa";
        };
        normal = {
          black = "#212337";
          red = "#f16c75";
          green = "#37f499";
          yellow = "#f1fc79";
          blue = "#04d1f9";
          magenta = "#a48cf2";
          cyan = "#7081d0";
          white = "#ebfafa";
        };
        bright = {
          black = "#323449";
          red = "#f16c75";
          green = "#37f499";
          yellow = "#f1fc79";
          blue = "#04d1f9";
          magenta = "#a48cf2";
          cyan = "#7081d0";
          white = "#ebfafa";
        };
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;

  };

  programs.atuin = {
    enable = true;
  };

  programs.waybar.enable = false;
  programs.hyprpanel.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/joncorv/dotfiles#giantvoidryzen";
      update = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#giantvoidryzen";
      ls = "eza -la";
      sudovim = "sudo -E nvim .";
      dots = "stow -v -t ~ -d ~/dotfiles/home/joncorv .";
    };
    interactiveShellInit = ''
      # Clear greeting
      # set -g fish_greeting ""
      set -g fish_prompt_pwd_dir_length 0
      # Eldritch theme colors
      set -g fish_color_normal cdd6f4
      set -g fish_color_command 04d1f9
      set -g fish_color_keyword f16c75
      set -g fish_color_quote a1efe4
      set -g fish_color_redirection ebfafa
      set -g fish_color_end f16c75
      set -g fish_color_error f16c75
      set -g fish_color_param 37f499
      set -g fish_color_comment 6f7c9f
      set -g fish_color_selection --background=323449
      set -g fish_color_search_match --background=323449
      set -g fish_color_operator 04d1f9
      set -g fish_color_escape a1efe4
      set -g fish_color_autosuggestion 6f7c9f
      set -g fish_pager_color_progress 6f7c9f
      set -g fish_pager_color_prefix 04d1f9
      set -g fish_pager_color_completion cdd6f4
      set -g fish_color_completion cdd6f4
      set -g fish_pager_color_description 6f7c9f
    '';
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/joncorv/dotfiles#giantvoidryzen";
      update = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#giantvoidryzen";
      ls = "eza -la";
      sudovim = "sudo -E nvim .";
      dots = "stow -v -t ~ -d ~/dotfiles/home/joncorv .";
    };
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    stow
    fzf
    ripgrep
    fd
    lazydocker
    eza
    atuin
    socat # deleted to test waypaper
    kitty
    ghostty
    patchelf
    dpkg
    git-filter-repo
  ];

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

  programs.wezterm.enable = true;

  programs.yazi = {
    enable = true;
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

  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/astro/dotfiles#andromeda";
      update = "cd /home/astro/dotfiles && sudo nix flake update && sudo nixos-rebuild switch --flake .#andromeda";
      ls = "eza -la";
      sudovim = "sudo -E nvim .";
      dots = "stow -v -t ~ -d ~/dotfiles/home/astro .";
      y = "yazi";
      lucid = "/opt/lucidapp/resources/Lucid";
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
      update = "cd /home/joncorv/dotfiles && sudo nix flake update && sudo nixos-rebuild switch --flake .#giantvoidryzen";
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

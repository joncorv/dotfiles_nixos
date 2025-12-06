{ pkgs, ... }:

{
  home.packages = with pkgs; [
    basedpyright
    bash-language-server
    black
    cargo
    clippy
    gcc
    hyprls
    isort
    isort
    # lua-language-server
    # neovide
    nixd
    nixfmt-rfc-style
    nodejs
    prettier
    prettierd
    pyright
    python314
    ruff
    rust-analyzer
    rustc
    rustfmt
    shfmt
    shfmt
    stylua
    tailwindcss-language-server
    tree-sitter
    typescript-language-server
    uv
    vtsls
    vue-language-server
    yarn
  ];

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      pkgs.imagemagick
    ];
    extraLuaPackages = ps: [ ps.magick ];
  };

}

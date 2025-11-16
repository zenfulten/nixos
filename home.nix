{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    rofi = "rofi";
    foot = "foot";
    fastfetch = "fastfetch";
    nushell = "nushell";
    starship = "starship";
    bottom = "bottom";
    kitty = "kitty";
  };
in

{
  home.username = "rio";
  home.homeDirectory = "/home/rio";
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nisos, btw.";
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    git
    neovim
    ripgrep
    gcc
    rofi
    yazi
    fastfetch
    nushell
    unzip
    wl-clipboard
    cliphist
    luarocks
    lua51Packages.lua
    brightnessctl
    pipewire
    zoxide
    fzf
    bat
    starship
    bottom
    fd
    uv
    vscode
    kitty
  ];
}

{ inputs, config, pkgs, ... }:
{
  imports = [
    ../modules/home
    ../modules/home/git.nix
    ../modules/home/editor.nix
    ../modules/home/development.nix
  ];

  home.stateVersion = "24.05";
  home = {
    #   packages = [
    #     pkgs.thefuck
    #     #pkgs.fzf-zsh
    #     pkgs.fd
    #   ];
    #
    file = { };
  };

  programs = { };
}

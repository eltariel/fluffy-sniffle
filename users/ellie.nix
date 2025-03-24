{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/home/git.nix
    ../modules/home/editor.nix
    ../modules/home/development.nix
  ];

  home = {
    stateVersion = "24.05";
    file = {};
  };

  programs = {};
}

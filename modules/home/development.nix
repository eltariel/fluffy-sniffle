{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    gh
    cmake
    gnumake
    gcc-arm-embedded
    clang
    python313
    ripgrep
  ];

  programs = {
    jq.enable = true;
    pyenv.enable = true;

    vscode = {
      enable = lib.mkDefault false; # services.xserver.enable;
    };

    pyenv = {
      rootDirectory = "${config.home.homeDirectory}/.pyenv";
    };
  };
}

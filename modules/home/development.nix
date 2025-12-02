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
    #    gcc-arm-embedded # doesn't work on x86_64-darwin
    clang
    python313
    ripgrep
    git-lfs

    rustup

    nodejs

    dotnet-sdk
    tio
  ];

  programs = {
    jq.enable = true;
    pyenv.enable = true;

    vscode = {
      enable = lib.mkDefault true; # services.xserver.enable;
    };

    pyenv = {
      rootDirectory = "${config.home.homeDirectory}/.pyenv";
    };
  };
}

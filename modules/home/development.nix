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
    gcc-arm-embedded # doesn't work on x86_64-darwin
    clang
    python313
    ripgrep
    git-lfs
    
    nodejs

    rustup

    nixd
    alejandra
    statix
    deadnix

    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )

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

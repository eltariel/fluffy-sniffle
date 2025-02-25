{config, pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    cmake
    gnumake
    gcc-arm-embedded
    clang
    python313
  ];

  programs = {
    jq.enable = true;
    pyenv.enable = true;

    vscode = {
      enable = true;
    };

    pyenv = {
      rootDirectory = "${config.home.homeDirectory}/.pyenv";
    };
  };
}

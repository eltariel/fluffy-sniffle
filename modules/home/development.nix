{config, pkgs, ...}: {
  home.packages = with pkgs; [
    gh
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

{ config, ... }:
{
  programs = {
    jq.enable = true;
    pyenv.enable = true;

    pyenv = {
      rootDirectory = "${config.home.homeDirectory}/.pyenv";
    };
  };
}

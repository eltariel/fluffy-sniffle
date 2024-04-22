{ config, pkgs, lib, username, homeDirectory, ... }:

{
  home = {
    inherit username;
    homeDirectory = lib.mkForce homeDirectory;
    stateVersion = "24.05";

    shellAliases = {
      man = "batman";
    };

    #   packages = [
    #     pkgs.thefuck
    #     #pkgs.fzf-zsh
    #     pkgs.fd
    #   ];
    #
    file = { };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "thefuck"
          #  "fzf"
          #  "zoxide"
        ];
        theme = "agnoster";
      };
    };

    thefuck.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batpipe batwatch ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # git = {
    #   enable = true;
    #   userEmail = "ellie@eltariel.com";
    #   userName = "Ellie T";
    #   delta = {
    #     enable = true;
    #     # options = "";
    #   };
    # };

    eza = {
      enable = true;
      git = true;
      icons = true;
      # extraConfig = [""];
    };

    jq.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    fzf.enable = true;

    pyenv = {
      enable = true;
      rootDirectory = "${homeDirectory}/.pyenv";
    };

    zoxide.enable = true;

    home-manager.enable = true;
  };

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };
}

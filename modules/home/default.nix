{ inputs, config, pkgs, ... }:
{
  home = {
    shellAliases = {
      man = "batman";
    };
  };

  programs = {
    # enable programs
    home-manager.enable = true;
    zsh.enable = true;
    thefuck.enable = true;
    fzf.enable = true;
    bat.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    eza.enable = true;
    zoxide.enable = true;

    zsh = {
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

    bat = {
      config.theme = "Nord";
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batpipe batwatch ];
    };

    eza = {
      git = true;
      icons = true;
      # extraConfig = [""];
    };
  };

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };
}

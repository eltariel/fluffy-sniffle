{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [../.];

  home = {
    packages = with pkgs; [
      nerd-fonts.victor-mono

      inkscape
      #      gimp
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      #      settings = {
      #        font = {
      #          normal = {
      #            family = "VictorMono Nerd Font";
      #            style = "Regular";
      #          };
      #          size = 14;
      #        };
      #      };
    };

    kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        name = "VictorMono Nerd Font";
        size = 14;
      };
      themeFile = "Nord";
    };

    nix-index = {
      enable = true;
    };
  };

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };
}

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

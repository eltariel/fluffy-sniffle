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
      rpi-imager

      # DAWs etc
      reaper
      reaper-sws-extension
      reaper-reapack-extension
      lmms
      ardour
      renoise

      # Audio plugins
      x42-plugins
      tunefish
      distrho-ports
      lsp-plugins
      sorcer

      #yabridge

      # Audio routing
      helvum
      qpwgraph
      coppwr
      pw-viz
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

    vicinae = {
      enable = true;
      systemd = {
        enable = true;

      };
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

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
      tunefish
      distrho-ports
      lsp-plugins
      sorcer

      yabridge

      x42-plugins # VU Meter,etc
      lsp-plugins # IR Impulse,etc
      eq10q # Equalizer
      dragonfly-reverb # Reverb
      surge-XT # Synth
      yoshimi # Synth
      calf # Saturation,etc
      guitarix # Guitar Effect
      gxplugins-lv2 # Guitarix extra

      # Audio routing
      # helvum
      crosspipe
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
      themeFile = "Catppuccin-Macchiato";
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

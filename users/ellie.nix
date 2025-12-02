{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/home/git.nix
    ../modules/home/editor.nix
    ../modules/home/development.nix
  ];

  home = {
    stateVersion = "24.05";
    file = {};
  };

  programs.obs-studio = {
    enable = true;
    plugins = [
      # pkgs.obs-studio-plugins.advanced-scene-switcher
      # pkgs.obs-studio-plugins.distroav
      # pkgs.obs-studio-plugins.droidcam-obs
      # pkgs.obs-studio-plugins.input-overlay
      # pkgs.obs-studio-plugins.looking-glass-obs
      # pkgs.obs-studio-plugins.obs-advanced-masks
      # pkgs.obs-studio-plugins.obs-aitum-multistream
      pkgs.obs-studio-plugins.obs-backgroundremoval
      # pkgs.obs-studio-plugins.obs-browser-transition
      # pkgs.obs-studio-plugins.obs-color-monitor
      # pkgs.obs-studio-plugins.obs-command-source
      # pkgs.obs-studio-plugins.obs-composite-blur
      # pkgs.obs-studio-plugins.obs-dir-watch-media
      # pkgs.obs-studio-plugins.obs-dvd-screensaver
      # pkgs.obs-studio-plugins.obs-freeze-filter
      # pkgs.obs-studio-plugins.obs-gradient-source
      pkgs.obs-studio-plugins.obs-gstreamer
      # pkgs.obs-studio-plugins.obs-hyperion
      # pkgs.obs-studio-plugins.obs-livesplit-one
      pkgs.obs-studio-plugins.obs-markdown
      # pkgs.obs-studio-plugins.obs-media-controls
      # pkgs.obs-studio-plugins.obs-move-transition
      pkgs.obs-studio-plugins.obs-multi-rtmp
      # pkgs.obs-studio-plugins.obs-mute-filter
      # pkgs.obs-studio-plugins.obs-ndi
      # pkgs.obs-studio-plugins.obs-noise
      # pkgs.obs-studio-plugins.obs-nvfbc
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      # pkgs.obs-studio-plugins.obs-recursion-effect
      # pkgs.obs-studio-plugins.obs-replay-source
      # pkgs.obs-studio-plugins.obs-retro-effects
      # pkgs.obs-studio-plugins.obs-rgb-levels
      # pkgs.obs-studio-plugins.obs-scale-to-sound
      # pkgs.obs-studio-plugins.obs-scene-as-transition
      # pkgs.obs-studio-plugins.obs-shaderfilter
      # pkgs.obs-studio-plugins.obs-source-clone
      # pkgs.obs-studio-plugins.obs-source-record
      # pkgs.obs-studio-plugins.obs-source-switcher
      # pkgs.obs-studio-plugins.obs-stroke-glow-shadow
      # pkgs.obs-studio-plugins.obs-teleport
      # pkgs.obs-studio-plugins.obs-text-pthread
      # pkgs.obs-studio-plugins.obs-transition-table
      # pkgs.obs-studio-plugins.obs-tuna
      # pkgs.obs-studio-plugins.obs-urlsource
      pkgs.obs-studio-plugins.obs-vaapi
      # pkgs.obs-studio-plugins.obs-vertical-canvas
      # pkgs.obs-studio-plugins.obs-vintage-filter
      # pkgs.obs-studio-plugins.obs-vkcapture
      pkgs.obs-studio-plugins.obs-vnc
      pkgs.obs-studio-plugins.obs-websocket
      # pkgs.obs-studio-plugins.pixel-art
      # pkgs.obs-studio-plugins.waveform
      pkgs.obs-studio-plugins.wlrobs
    ];
  };
}

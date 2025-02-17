# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixos-hardware, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga
      nixos-hardware.nixosModules.common-gpu-intel-kaby-lake
      nixos-hardware.nixosModules.common-cpu-intel
      nixos-hardware.nixosModules.common-pc-laptop-ssd


      ../../../modules/nixos
      ../../../modules/nixos/ui/gnome.nix
      ../../../modules/nixos/ui/steam.nix
    ];

  
  networking.hostName = "flattery"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  system.stateVersion = "24.11";
}

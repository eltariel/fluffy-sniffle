{ config, ... }:
{
  imports =
    [
      ./hardware-configuration.nix

      ../../../modules/nixos/system.nix
      ../../../modules/nixos/services.nix
      ../../../modules/nixos/gnome.nix
      ../../../modules/nixos/default-users.nix
    ];

  networking.hostName = "snarf";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
    };
    podman = {
      enable = true;
      enableNvidia = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  users.users.ellie.extraGroups = ["docker"];

  system.stateVersion = "24.05";
}


{config, pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../../modules/nixos
    ../../../modules/nixos/ui/combined
    ../../../modules/nixos/containers.nix
    ../../../modules/nixos/build-host.nix
  ];

  networking.hostName = "snarf";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  services.btrfs.autoScrub.enable = true;
  swapDevices = [{
    device = "/.swap/swapfile";
    size = 64*1024;
  }];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
    nvidiaSettings = true;
    
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };
  hardware.nvidia-container-toolkit.enable = true;

  hardware.xone.enable = true;

  system.stateVersion = "24.05";
}

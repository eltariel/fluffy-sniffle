{config, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../../modules/nixos
    ../../../modules/nixos/ui/combined
  ];

  networking.hostName = "snarf";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  hardware.opengl = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

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

  system.stateVersion = "24.05";
}

{nixos-hardware, ...}: {
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.apple-t2

    ../../../modules/nixos
    ../../../modules/nixos/ui/gnome.nix
    ../../../modules/nixos/t2-mac.nix
  ];

  networking.hostName = "e1i1";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "24.05";
}

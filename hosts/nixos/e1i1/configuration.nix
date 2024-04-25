{ nixos-hardware, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      nixos-hardware.nixosModules.apple-t2

      ../../../modules/nixos/system.nix
      ../../../modules/nixos/services.nix
      ../../../modules/nixos/gnome.nix
      ../../../modules/nixos/default-users.nix
      ../../../modules/nixos/t2-mac.nix
    ];

  networking.hostName = "e1i1";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "24.05";
}

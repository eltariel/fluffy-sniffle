{ config, lib, pkgs, nixos-hardware, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../common/system.nix
      ../common/services.nix
      ../common/gnome.nix
      ../common/default-users.nix
      ../common/t2-mac.nix
      nixos-hardware.nixosModules.apple-t2
    ];

  networking.hostName = "e1i1";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "24.05";
}

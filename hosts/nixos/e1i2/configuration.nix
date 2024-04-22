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

  networking.hostName = "e1i2";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  system.stateVersion = "24.05";
}


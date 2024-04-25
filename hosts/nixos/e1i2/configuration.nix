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


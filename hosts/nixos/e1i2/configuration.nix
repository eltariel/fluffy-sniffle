{ nixos-hardware, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      nixos-hardware.nixosModules.apple-t2

      ../../../modules/nixos
      ../../../modules/nixos/ui/gnome.nix
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


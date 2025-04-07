{lib, ...}: {
  imports = [
    ../.
    ./common.nix
    ./plasma.nix
    ./gnome.nix

    ./steam.nix
  ];

  services.xserver.displayManager.gdm.enable = lib.mkForce false;
  programs.ssh.askPassword = lib.mkForce "";
}

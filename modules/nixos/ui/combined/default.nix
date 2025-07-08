{lib, ...}: {
  imports = [
    ../.
    ../plasma.nix
    ../gnome.nix

    ../steam.nix
  ];

  services.displayManager.gdm.enable = lib.mkForce false;
  programs.ssh.askPassword = lib.mkForce "";
}

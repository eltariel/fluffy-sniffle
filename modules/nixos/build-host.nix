{pkgs, ...}: {
  users.groups.nixremote = {};
  users.users.nixremote = {
    isSystemUser = true;
    group = "nixremote";
    extraGroups = [];
    createHome = true;
    home = "/home/nixremote";
    useDefaultShell = true;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINAaxOlivMLUsh6f/fwVe8zQeUGxP/MEm7G8I0KIDffw root@pb2-2"
    ];
  };
  nix.settings.trusted-users = ["nixremote"];
}

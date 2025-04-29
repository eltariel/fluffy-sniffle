{...}: {
  imports = [
    ../common
    ./system.nix
    ./default-users.nix
    ./services.nix
  ];

  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;
}

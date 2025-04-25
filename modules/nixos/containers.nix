{pkgs, ...}: {
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings.features.cdi = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

}

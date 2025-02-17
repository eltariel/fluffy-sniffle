{ ... }:
{
  programs.nix-ld = {
    enable = true;
    # libraries = ... ;
  };

  services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
  };
}

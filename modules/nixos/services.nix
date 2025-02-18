{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = (pkgs.appimageTools.defaultFhsEnvArgs.targetPkgs pkgs) ++ (pkgs.appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ (with pkgs; []);
    # libraries = ... ;
  };

  services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
  };
}

{pkgs, ...}: {
  programs.nh = {
    enable = true;
    # clean.enable = true;
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];
}

{pkgs, ...}: {
  services = {
    xserver.enable = true;

    flatpak = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    # config = { ... };
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];
}

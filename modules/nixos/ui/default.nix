{pkgs, ...}: {
  services = {
    xserver.enable = true;

    flatpak = {
      enable = true;
    };

    protonmail-bridge = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    # config = { ... };
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };

    thunderbird = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    librewolf
    ungoogled-chromium
  ];
}

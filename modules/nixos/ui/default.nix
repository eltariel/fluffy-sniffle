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

  programs = {
    thunderbird = {
      enable = true;
      
    };
  };
  
  services = {
    protonmail-bridge = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];
}

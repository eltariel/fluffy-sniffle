{ pkgs, ... }:
{
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.flatpak = {
    enable = true;
  };
  xdg.portal = {
    enable = true;
    # config = { ... };
  };

  programs.appimage.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
  ];
}

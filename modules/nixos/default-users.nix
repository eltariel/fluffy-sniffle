{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ellie = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker" "libvirtd"];
    packages = with pkgs; [
      firefox
      # tree
    ];
  };
}

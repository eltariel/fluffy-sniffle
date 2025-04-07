{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.ellie = {};
  users.users.ellie = {
    isNormalUser = true;
    group = "ellie";
    extraGroups = ["wheel" "networkmanager" "docker" "libvirtd"];
    packages = with pkgs; [
      firefox
      # tree
    ];
  };
}

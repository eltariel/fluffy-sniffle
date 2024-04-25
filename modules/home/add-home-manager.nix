{ pkgs, system, ... }@args: usernames:
let
  inherit (builtins) listToAttrs map;
  inherit (pkgs.stdenv) isDarwin;
#  inherit (args) system;

  homeDir = user:
    # nixos sets the home directory for us
    if isDarwin
    then { homeDirectory = /Users/${user}; }
    else {};
    
  homeFor = user: {
    home.username = user;

    imports = [
      ../../users/${user}.nix
    ];
  } // (homeDir user);

  homesFor = usernames: listToAttrs (
    map (u: {
      name = u;
      value = homeFor u;
    }) usernames
  );
in [{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = args;
    users = homesFor usernames;
  };
}]

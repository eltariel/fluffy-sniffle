pkgs: home-manager: let
  inherit (builtins) listToAttrs map;
  inherit (pkgs.lib.attrsets) genAttrs;
in {
  nixos = usernames: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users = genAttrs usernames (u: {
        home.username = u;

        imports = [
          ../../users/common/ui
          ../../users/${u}.nix
        ];
      });
    };
  };
  standalone = host: usernames:
    listToAttrs (map (u: {
        name = "${u}@${host}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ../../hosts/home-manager/${host}
            ../../users/common
            ../../users/${u}.nix
            {
              home.username = u;
              home.homeDirectory = /home/${u};
            }
          ];
        };
      })
      usernames);
}

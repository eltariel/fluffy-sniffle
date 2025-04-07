{
  nixpkgs,
  nixos-hardware,
  home-manager,
  ...
} @ inputs: let
  inherit (builtins) listToAttrs map;
  inherit (nixpkgs.lib) genAttrs concatMapAttrs;

  x86_64-linux = "x86_64-linux";
  aarch64-linux = "aarch64-linux";
  aarch64-darwin = "aarch64-darwin";
  allSystems = [x86_64-linux aarch64-linux];

  systemPkgs = genAttrs allSystems (
    system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
  );
in {
  nixosFor = hostMap: users:
    concatMapAttrs
    (host: system: {
      "${host}" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs nixpkgs nixos-hardware home-manager system;
        };

        modules = [
          ../../hosts/nixos/${host}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = genAttrs users (u: {
                home.username = u;

                imports = [
                  ../../users/common/ui
                  ../../users/${u}.nix
                ];
              });
            };
          }
        ];
      };
    })
    hostMap;
}

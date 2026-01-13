{
  description = "Ellie's Nix configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-06cb-009a-fingerprint-sensor = {
    #   url = "github:elvetemedve/nixos-06cb-009a-fingerprint-sensor?ref=make-compatible-with-nixos-unstable-and-upgrade";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: let
    inherit (nixpkgs.lib) genAttrs;

    x86_64-linux = "x86_64-linux";
    aarch64-linux = "aarch64-linux";
    x86_64-darwin = "x86_64-darwin";
    aarch64-darwin = "aarch64-darwin";
    allSystems = [x86_64-linux aarch64-linux x86_64-darwin aarch64-darwin];

    systemPkgs = genAttrs allSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );

    defaultUsers = ["ellie"];
    hosts = {
      nixos = {
        snarf = x86_64-linux;
        flattery = x86_64-linux;
        surf = x86_64-linux;
        e1i1 = x86_64-linux;
        e1i2 = x86_64-linux;
      };
      darwin = {
        e1m1 = aarch64-darwin;
        e1i2 = x86_64-darwin;
      };
      homeManager = {
        pb2-2 = aarch64-linux;
        work-client-wsl = x86_64-linux;
      };
    };

    hostBuilder = import ./modules/home inputs;

    nixLinux = system: let
      pkgs = systemPkgs.${system};
      homeManager = (import ./modules/home/add-home-manager.nix) pkgs home-manager;
    in
      host: users: homeManager.standalone host users;
  in {
    formatter = genAttrs allSystems (s: nixpkgs.legacyPackages.${s}.alejandra);

    nixosConfigurations = hostBuilder.nixosFor hosts.nixos defaultUsers;
    darwinConfigurations = {
      e1i2 = nix-darwin.lib.darwinSystem {
        system = x86_64-darwin;
        pkgs = systemPkgs."x86_64-darwin";
        modules = [
          ./hosts/darwin/e1i2
          ./modules/darwin/ui

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ellie = {
                imports = [
                  ./users/common/ui
                  ./users/ellie.nix
                ];
              };
            };
          }
        ];
      };
    };

    homeConfigurations =
      nixLinux aarch64-linux "pb2-2" ["ellie"]
      // nixLinux x86_64-linux "work-client-wsl" ["ellie"];
  };
}

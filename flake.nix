{
  description = "Ellie's Nix configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    inherit (builtins) listToAttrs map;
    x86_64-linux = "x86_64-linux";
    aarch64-linux = "aarch64-linux";
    allSystems = [x86_64-linux aarch64-linux];
    pkgsForSystem = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    nixosHost = system: let
      pkgs = pkgsForSystem system;
      homeManager = (import ./modules/home/add-home-manager.nix) pkgs home-manager;
    in
      host: users: {
        "${host}" = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs nixpkgs nixos-hardware home-manager system;
          };

          modules = [
            ./hosts/nixos/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            (homeManager.nixos users)
          ];
        };
      };
    nixLinux = system: let
      pkgs = pkgsForSystem system;
      homeManager = (import ./modules/home/add-home-manager.nix) pkgs home-manager;
    in
      host: users: homeManager.standalone host users;
  in {
    formatter = nixpkgs.lib.genAttrs allSystems (s: nixpkgs.legacyPackages.${s}.alejandra);
    #    formatter.${x86_64-linux} = nixpkgs.legacyPackages.${x86_64-linux}.alejandra; # todo: enable for all systems

    nixosConfigurations =
      nixosHost x86_64-linux "flattery" ["ellie"]
      // nixosHost x86_64-linux "surf" ["ellie"]
      // nixosHost x86_64-linux "e1i1" ["ellie"]
      // nixosHost x86_64-linux "e1i2" ["ellie"];

    homeConfigurations = 
      nixLinux aarch64-linux "pb2-2" ["ellie"]
      // nixLinux x86_64-linux "work-client-wsl" ["ellie"];
  };
}

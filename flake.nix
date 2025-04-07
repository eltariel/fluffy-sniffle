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
    inherit (nixpkgs.lib) genAttrs concatMapAttrs;

    x86_64-linux = "x86_64-linux";
    aarch64-linux = "aarch64-linux";
    aarch64-darwin = "aarch64-darwin";
    allSystems = [x86_64-linux aarch64-linux];

    pkgsForSystem = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    systemPkgs = genAttrs
      allSystems
      (system:
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
      };
      homeManager = {
        pb2-2 = aarch64-linux;
        work-client-wsl = x86_64-linux;
      };
    };

    nixosHost = system: let
      homeManager = (import ./modules/home/add-home-manager.nix) systemPkgs.${system} home-manager;
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
    nixosFor = hostMap: concatMapAttrs (h: s: nixosHost s "${h}" defaultUsers) hostMap;

    nixLinux = system: let
      pkgs = pkgsForSystem system;
      homeManager = (import ./modules/home/add-home-manager.nix) pkgs home-manager;
    in
      host: users: homeManager.standalone host users;
  in {
    formatter = genAttrs allSystems (s: nixpkgs.legacyPackages.${s}.alejandra);

    nixosConfigurations = nixosFor hosts.nixos;

    homeConfigurations = 
      nixLinux aarch64-linux "pb2-2" ["ellie"]
      // nixLinux x86_64-linux "work-client-wsl" ["ellie"];
  };
}

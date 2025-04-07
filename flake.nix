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
    inherit (nixpkgs.lib) genAttrs;

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

    hostBuilder = import ./modules/home inputs;

    nixLinux = system: let
      pkgs = systemPkgs.${system};
      homeManager = (import ./modules/home/add-home-manager.nix) pkgs home-manager;
    in
      host: users: homeManager.standalone host users;
  in {
    formatter = genAttrs allSystems (s: nixpkgs.legacyPackages.${s}.alejandra);

    nixosConfigurations = hostBuilder.nixosFor hosts.nixos defaultUsers;

    homeConfigurations =
      nixLinux aarch64-linux "pb2-2" ["ellie"]
      // nixLinux x86_64-linux "work-client-wsl" ["ellie"];
  };
}

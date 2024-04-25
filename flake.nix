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

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
  let
    x86_64-linux = "x86_64-linux";

    nixosHost = system:
    let
      specialArgs = {
        inherit inputs nixpkgs nixos-hardware home-manager system;
        pkgs = nixpkgs.legacyPackages.${system};
      };

      hm = import ./modules/home/add-home-manager.nix specialArgs;
    in
    host: users:
    {
      "${host}" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/nixos/${host}/configuration.nix
          home-manager.nixosModules.home-manager
        ] ++ (hm users);
      };
    };
  in {
    nixosConfigurations =
      nixosHost x86_64-linux "e1i2" ["ellie"] //
      nixosHost x86_64-linux "e1i2" ["ellie"];
  };
}

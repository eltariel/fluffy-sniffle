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
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
      
      homeManager = import ./modules/home/add-home-manager.nix;
    in
    host: users:
    {
      "${host}" = nixpkgs.lib.nixosSystem {
        inherit system;
        
	specialArgs = {
          inherit inputs nixpkgs nixos-hardware home-manager system;
        };

        modules = [
          ./hosts/nixos/${host}/configuration.nix
          home-manager.nixosModules.home-manager
        ] ++ (homeManager pkgs users);
      };
    };
  in {
    nixosConfigurations =
      nixosHost x86_64-linux "flattery" ["ellie"] //
      nixosHost x86_64-linux "e1i2" ["ellie"] //
      nixosHost x86_64-linux "e1i2" ["ellie"];
  };
}

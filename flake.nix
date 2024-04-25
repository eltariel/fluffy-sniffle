{
  description = "Ellie's Nix configs";

  inputs = {
# NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
  let
    x86_64-linux = "x86_64-linux";

    nixosHost = host: username: system:
    {
      "${host}" = nixpkgs.lib.nixosSystem {
	      inherit system;
	      specialArgs = {
	        inherit inputs username nixpkgs nixos-hardware home-manager;
	      };
	      modules = [
	        ./hosts/nixos/${host}/configuration.nix

		      home-manager.nixosModules.home-manager
		      {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
		        home-manager.extraSpecialArgs = {
				      inherit inputs self username;
				      homeDirectory = "/home/${username}";
			      };
		        home-manager.users.ellie = import ./users/${username}.nix;
		      }
	      ];
	    };
    };
    
  in {
    nixosConfigurations =
      nixosHost "e1i2" "ellie" x86_64-linux;
  };
}

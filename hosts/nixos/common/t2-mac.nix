{ pkgs, inputs, lib, ... }:
{
  # imports = [
    # inputs.nixos-hardware.nixosModules.apple-t2
  # ];

	hardware.firmware = [
		(pkgs.stdenvNoCC.mkDerivation {
			name = "brcm-firmware";

			archive = builtins.fetchTree {
				type = "file";
				url = "file:///boot/firmware.tar.gz";
			};
			dontUnpack = true;

			# buildCommand = ''
			# 	dir="$out/lib/firmware"
			# 	mkdir -p "$dir"
			# 	cp -r ${../../../firmware}/* "$dir"
			# '';
			builder = ./t2-mac-extract-firmware.sh;

			nativeBuildInputs = with pkgs; [ python3 ];
		})
	];

	system.activationScripts.appleSetOsLoader =	let
  	apple-set-os-loader-installer = pkgs.stdenv.mkDerivation {
    	name = "apple-set-os-loader-installer-1.0";
    	src = pkgs.fetchFromGitHub {
      	owner = "Redecorating";
      	repo = "apple_set_os-loader";
      	rev = "r33.9856dc4";
      	sha256 = "hvwqfoF989PfDRrwU0BMi69nFjPeOmSaD6vR6jIRK2Y=";
    	};
    	buildInputs = [ pkgs.gnu-efi ];
    	buildPhase = ''
      	substituteInPlace Makefile --replace "/usr" '$(GNU_EFI)'
      	export GNU_EFI=${pkgs.gnu-efi}
      	make
    	'';
    	installPhase = ''
      	install -D bootx64_silent.efi $out/bootx64.efi
    	'';
  	};
	in
		lib.mkForce ''
		if [[ -e /boot/efi/boot/bootx64_original.efi ]]; then
        true # It's already installed, no action required
      elif [[ -e /boot/efi/boot/bootx64.efi ]]; then
        # Copy the new bootloader to a temporary location
        cp ${apple-set-os-loader-installer}/bootx64.efi /boot/efi/boot/bootx64_temp.efi

        # Rename the original bootloader
        mv /boot/efi/boot/bootx64.efi /boot/efi/boot/bootx64_original.efi

        # Move the new bootloader to the final destination
        mv /boot/efi/boot/bootx64_temp.efi /boot/efi/boot/bootx64.efi
      else
        echo "Error: /boot/efi/boot/bootx64.efi is missing" >&2
      fi
	'';
}

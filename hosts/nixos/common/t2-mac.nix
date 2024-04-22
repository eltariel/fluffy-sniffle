{ pkgs, inputs, ... }:
{
  # imports = [
    # inputs.nixos-hardware.nixosModules.apple-t2
  # ];

	hardware.firmware = [
		(pkgs.stdenvNoCC.mkDerivation {
			name = "brcm-firmware";

			buildCommand = ''
				dir="$out/lib/firmware"
				mkdir -p "$dir"
				cp -r ${../../../firmware}/* "$dir"
			'';
		})
	];

	hardware.apple-t2.enableAppleSetOsLoader = true;
}

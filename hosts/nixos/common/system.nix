{ pkgs, ... }:
{
  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_AU.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
		zsh
  ];

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config = {
	  allowUnfree = true;
	  allowUnfreePredicate = (pkg: true);
	};
}

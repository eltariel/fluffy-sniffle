{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs = {
    git = {
      enable = true;
      userEmail = "ellie@eltariel.com";
      userName = "Ellie T";
      delta = {
        enable = true;
        # options = "";
      };
    };
  };
}

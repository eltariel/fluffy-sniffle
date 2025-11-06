{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "ellie@eltariel.com";
          name = "Ellie T";
        };
      };
      delta = {
        enable = true;
        # options = "";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}

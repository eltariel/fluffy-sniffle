{...}: {
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    neovim.enable = true;

    neovim = {
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}

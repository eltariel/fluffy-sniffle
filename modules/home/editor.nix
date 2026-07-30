{...}: {
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    neovim = {
      enable = true;

      vimAlias = true;
      vimdiffAlias = true;

      sideloadInitLua = true; # don't manage/overwrite init.lua

      withPython3 = true;
      withRuby = false;
    };
  };
}

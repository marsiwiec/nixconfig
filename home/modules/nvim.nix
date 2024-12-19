{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
  };
}

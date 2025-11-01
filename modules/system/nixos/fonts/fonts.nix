{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sysfonts.enable = lib.mkEnableOption "fonts";
  };

  config = lib.mkIf config.sysfonts.enable {
    fonts = {
      fontconfig.enable = true;
      enableDefaultPackages = true;
      packages = with pkgs; [
        corefonts
        nerd-fonts.intone-mono
        nerd-fonts.symbols-only
        alegreya
      ];
    };
  };
}

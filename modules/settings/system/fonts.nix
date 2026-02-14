{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
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
  flake.modules.darwin.fonts = {

  };
}

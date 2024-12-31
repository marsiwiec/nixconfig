{lib, ...}: {
  options = {
    direnv.enable = lib.mkEnableOption "enable nix-direnv";
  };
  config = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

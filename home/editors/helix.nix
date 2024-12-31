{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    helix.enable = lib.mkEnableOption "enable helix editor";
  };
  config = lib.mkIf config.helix.enable {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
      ];
    };
  };
}

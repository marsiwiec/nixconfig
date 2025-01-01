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
          scrolloff = 5;
          bufferline = "multiple";
          popup-border = "all";
          shell = [
            "zsh"
            "-c"
          ];
          file-picker.hidden = false;
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
        {
          name = "python";
          auto-format = true;
          formatter.command = lib.getExe pkgs.pyright;
        }
      ];
    };
  };
}

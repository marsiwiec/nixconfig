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
      defaultEditor = true;
      settings = {
        editor = {
          line-number = "relative";
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
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
          name = "r";
          auto-format = true;
          formatter.command = "air format";
        }
        {
          name = "python";
          auto-format = true;
          formatter.command = lib.getExe pkgs.black;
        }
        {
          name = "typst";
          auto-format = true;
          formatter.command = lib.getExe pkgs.typstyle;
        }
        {
          name = "markdown";
          auto-format = true;
          file-types = [
            "md"
            "markdown"
            "qmd"
            "PULLREQ_EDITMSG"
          ];
          language-servers = [ pkgs.marksman ];
        }
      ];
    };
  };
}

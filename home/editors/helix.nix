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
          soft-wrap.enable = true;
          line-number = "relative";
          end-of-line-diagnostics = "hint";
          inline-diagnostics.cursor-line = "error";
          cursorline = true;
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
      languages = {
        language-server = {
          tinymist = {
            command = lib.getExe pkgs.tinymist;
            config = {
              formatterMode = "typstyle";
              exportPdf = "onSave";
              outputPath = "$root/target/$dir/$name";
              preview.browsing.args = [
                "--data-plane-host=127.0.0.1:0"
                "--invert-colors=never"
                "--open"
              ];
            };
          };
          harper = {
            command = lib.getExe pkgs.harper;
            args = [ "--stdio" ];
            config = {
              harper-ls = {
                dialect = "American";
                linters = {
                  SentenceCapitalization = false;
                };
                diagnosticSeverity = "error";
              };
            };
          };
          mpls = {
            command = lib.getExe pkgs.mpls;
            args = [
              "--no-auto"
              "--code-style"
              "--enable-footnotes"
            ];
          };
          air = {
            command = lib.getExe pkgs.air-formatter;
            args = [
              "language-server"
            ];
          };
        };
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
          }
          {
            name = "r";
            auto-format = true;
            language-servers = [
              "air"
              "r"
            ];
          }
          {
            name = "python";
            auto-format = true;
            formatter.command = lib.getExe pkgs.black;
          }
          {
            name = "typst";
            rulers = [ 80 ];
            auto-format = true;
            language-servers = [ "tinymist" ];
          }
          {
            name = "markdown";
            language-servers = [
              "marksman"
              "markdown-oxide"
              "harper-ls"
              "mpls"
            ];
            auto-format = true;
            file-types = [
              "md"
              "markdown"
              "qmd"
              "PULLREQ_EDITMSG"
            ];
          }
        ];
      };
    };
  };
}

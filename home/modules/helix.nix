{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        cursor-shape = {
          insert = "bar";
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
}

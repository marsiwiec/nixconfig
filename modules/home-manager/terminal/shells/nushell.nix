{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    nushell.enable = lib.mkEnableOption "nushell config";
  };
  config = lib.mkIf config.nushell.enable {
    programs.nushell = {
      enable = true;
      settings = {
        buffer_editor = "hx";
        show_banner = false;
      };
      extraConfig = ''
        def start_zellij [] {
          if 'ZELLIJ' not-in ($env | columns) {
            if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
              zellij attach -c
            } else {
              zellij
            }

            if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
              exit
            }
          }
        }
        start_zellij
        }'';
    };
  };
}

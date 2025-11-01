{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    greetd.enable = lib.mkEnableOption "config for greetd and tuigreet";
  };
  config = lib.mkIf config.greetd.enable {
    environment.systemPackages = with pkgs; [
      greetd.greetd
      greetd.tuigreet
    ];
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "tuigreet --time --remember --remember-session";
          user = "greeter";
        };
      };
    };
  };
}

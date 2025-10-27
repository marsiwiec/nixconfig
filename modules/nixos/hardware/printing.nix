{
  lib,
  config,
  ...
}:
{
  options = {
    printing.enable = lib.mkEnableOption "printing config with CUPS";
  };
  config = lib.mkIf config.printing.enable {
    # Enable CUPS to print documents.
    services = {
      printing = {
        enable = true;
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}

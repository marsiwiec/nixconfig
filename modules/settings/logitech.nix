{
  flake.modules.nixos.logitech =
    { pkgs, ... }:
    {
      services.ratbagd.enable = true;

      environment.systemPackages = with pkgs; [
        piper
      ];
    };
}

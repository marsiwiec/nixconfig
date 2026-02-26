{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs = {
        steam.enable = true;
        gamescope.enable = true;
        gamemode.enable = true;
      };

      environment.systemPackages = with pkgs; [
        heroic
        mangohud
        protonup-qt
        bottles
      ];
    };
}

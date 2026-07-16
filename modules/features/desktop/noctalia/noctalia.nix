{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos.noctalia =
    { config, pkgs, ... }:
    {

      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

      imports = [
        inputs.noctalia.nixosModules.default
        inputs.noctalia-greeter.nixosModules.default
      ];

      environment.systemPackages = with pkgs; [
        hyprpicker
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
        recommendedServices.enable = true;
      };

      programs.noctalia-greeter = {
        enable = true;
        settings = {
          cursor = {
            theme = config.stylix.cursor.name;
            size = config.stylix.cursor.size;
            path = "${config.stylix.cursor.package}/share/icons";
          };
          keyboard = {
            layout = "pl";
          };
        };
      };
    };
}

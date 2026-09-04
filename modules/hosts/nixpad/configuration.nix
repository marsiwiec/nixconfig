{
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.nixpad =
      {
        config,
        pkgs,
        ...
      }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.niri-outputs-nixpad
          inputs.self.modules.homeManager.niri-keybinds-noctalia
          inputs.self.modules.homeManager.nixpad-audio
        ];
        imports = with inputs.self.modules.nixos; [
          host-common
          default-settings
          gaming
          msiwiec
          noctalia
          nixpad-filesystem
          nixpad-laptop
          nixpad-secureboot
        ];

        networking.hostName = "nixpad";
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/space.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
        };
      };
  };
}

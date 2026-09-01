{
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.labnix =
      {
        config,
        pkgs,
        ...
      }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.niri-outputs-labnix
          inputs.self.modules.homeManager.niri-keybinds-dms
        ];
        imports = with inputs.self.modules.nixos; [
          host-common
          default-settings
          labnix-filesystem
          msiwiec
          dank-material-shell
        ];
        networking.hostName = "labnix";
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/star_wars.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
        };
      };
  };
}

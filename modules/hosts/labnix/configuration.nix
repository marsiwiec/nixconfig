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
        ];
        imports = with inputs.self.modules.nixos; [
          host-common
          default-settings
          labnix-filesystem
          msiwiec
        ];
        networking.hostName = "labnix";
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/star_wars.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
        };
      };
  };
}

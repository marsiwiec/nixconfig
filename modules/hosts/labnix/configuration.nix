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
        imports =
          with inputs.self.modules.nixos;
          [
            host-common
            default-settings
            labnix-filesystem
            msiwiec
          ]
          ++ [
            (inputs.self.factory.desktopShell "dms")
            (inputs.self.factory.llamaCpp "rocm")
          ];
        networking.hostName = "labnix";
        # Force deep (S3) sleep instead of s2idle.  AMD Phoenix APUs fail to
        # reinitialise the display panel on resume from s2idle.
        systemd.sleep.settings.Sleep = {
          "SuspendState" = "deep";
        };
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/star_wars.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
        };
      };
  };
}

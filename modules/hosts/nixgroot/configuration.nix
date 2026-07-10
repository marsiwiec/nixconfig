{
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.nixgroot =
      {
        config,
        pkgs,
        ...
      }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.niri-outputs-nixgroot
          inputs.self.modules.homeManager.nixgroot-protonvpn-settings
        ];
        imports = with inputs.self.modules.nixos; [
          host-common
          default-settings
          gaming
          msiwiec
          nixgroot-filesystem
          nixgroot-cooling
          nvidia
          nvidia-passthrough
          protonvpn
          protonvpn-tailscale
        ];

        ### Fix for Lexar nvme SSDs ###
        boot = {
          kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];
        };

        networking.hostName = "nixgroot";
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/flowers.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
        };
      };
  };
}

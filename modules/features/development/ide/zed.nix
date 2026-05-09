{
  inputs,
  ...
}:
{
  # flake-file.inputs = {
  #   zed.url = "github:zed-industries/zed";
  # };

  # flake.modules.nixos.overlays = {
  #   nixpkgs.overlays = [
  #     (final: prev: {
  #       zed-editor = inputs.zed.packages.${final.stdenv.hostPlatform.system}.default;
  #     })
  #   ];
  # };

  flake.modules.homeManager.zed =
    { pkgs, ... }:
    let
      # Wrap zeditor to force the Vulkan loader to select RADV, avoiding slow GPU probing on startup.
      zed-editor-wrapped = pkgs.symlinkJoin {
        name = "zed-editor-wrapped";
        paths = [ pkgs.unstable.zed-editor ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          rm $out/bin/zeditor
          makeWrapper ${pkgs.unstable.zed-editor}/bin/zeditor $out/bin/zeditor \
            --set VK_LOADER_DRIVERS_SELECT "*radv*"
        '';
      };
    in
    {
      home.packages = [
        zed-editor-wrapped
      ];
    };
}

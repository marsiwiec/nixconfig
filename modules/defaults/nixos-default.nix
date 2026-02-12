{
  inputs,
  ...
}:
{
  flake.modules.nixos.default-settings =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      lib.generators.withRecursion = {
        depthLimit = 10;
        throwOnDepthLimit = false;
      };
      imports =
        with inputs.self.modules.nixos;
        [
          audio
          bluetooth
          boot
          fonts
          graphics
          home-manager
          keyboard
          locale
          logitech
          networking
          nh
          power
          printing
          screen
          security-defaults
          shell
          ssh
          sops
          stylix
          tailscale
          time
          utils
          virtualisation
        ]
        ++ [ "${modulesPath}/installer/scan/not-detected.nix" ];

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc
          fuse3
          cmake
          gnumake
          glib
          glibc
          zlib
        ];
      };

      fileSystems = lib.mkDefault {
        "/".options = [ "compress=zstd" ];
        "/home".options = [ "compress=zstd" ];
        "/nix".options = [
          "compress=zstd"
          "noatime"
        ];
      };
      services.btrfs.autoScrub.enable = true;
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}

{ pkgs, ... }:
# Temporary pin to older version to avoid broken amdgpu stuff

{
  nixpkgs.overlays = [
    (self: super: {
      linux-firmware = super.linux-firmware.overrideAttrs (
        finalAttrs: previousAttrs: {
          version = "20250509";
          src = pkgs.fetchzip {
            url = "https://cdn.kernel.org/pub/linux/kernel/firmware/linux-firmware-20250509.tar.xz";
            hash = "sha256-0FrhgJQyCeRCa3s0vu8UOoN0ZgVCahTQsSH0o6G6hhY=";
          };
        }
      );
    })
  ];
}

{
  flake.modules.nixos.graphics =
    { pkgs, ... }:
    {
      services = {
        xserver.enable = true;
        lact.enable = true;
      };

      hardware = {
        amdgpu = {
          overdrive.enable = true;
          # Default nixpkgs ppfeaturemask (0xfffd7fff) clears bit 15 (PSR) and
          # bit 17 (ABM). With PSR off, the eDP panel stays powered during
          # s2idle suspend — screen stays lit, battery drains. Re-enable PSR by
          # setting bit 15 back: 0xfffd7fff | 0x8000 = 0xfffdffff. Keep ABM off
          # (bit 17) since it can cause flicker; overdrive (bit 14) stays on
          # for LACT.
          overdrive.ppfeaturemask = "0xfffdffff";
          initrd.enable = true;
        };
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            vulkan-loader
            vulkan-validation-layers
            vulkan-extension-layer
            libva
            libva-vdpau-driver
            libvdpau-va-gl
          ];
          extraPackages32 = with pkgs.pkgsi686Linux; [
            libva-vdpau-driver
            libvdpau-va-gl
          ];
        };
      };
      environment.systemPackages = with pkgs; [
        vulkan-tools
      ];
    };
}

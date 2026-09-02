{
  inputs,
  ...
}:
{
  # Secure Boot via lanzaboote — nixpad only. Replaces systemd-boot with
  # lanzaboote's stub+loader, which signs every boot artifact with the keys in
  # /var/lib/sbctl at build time. Other hosts (labnix/nixgroot) keep plain
  # systemd-boot from the shared `boot` module.
  #
  # Workflow (manual, per our decision — no auto-enroll surprises):
  #   1. sudo sbctl create-keys            # → /var/lib/sbctl
  #   2. update  (rebuild; signs /boot/EFI/Linux/...)
  #      sudo sbctl verify                 # all ✓ except kernel-*.efi (normal)
  #   3. BIOS: Security → Secure Boot → Enable → Reset to Setup Mode → F10
  #   4. sudo sbctl enroll-keys --microsoft
  #   5. reboot; bootctl status → "Secure Boot: enabled (user)"
  flake.modules.nixos.nixpad-secureboot =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

      # Lanzaboote replaces systemd-boot; the shared `boot` module enables it,
      # so force it off here to avoid a conflict.
      boot.loader.systemd-boot.enable = lib.mkForce false;

      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      # For debugging / verifying signatures.
      environment.systemPackages = [ pkgs.sbctl ];
    };
}

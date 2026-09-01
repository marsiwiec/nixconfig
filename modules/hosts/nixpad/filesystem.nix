let
  luksMapped = "/dev/mapper/luksroot";
in
{
  # LUKS-ENCRYPTED BTRFS LAYOUT FOR nixpad
  #
  # Suggested partition table (create with disko or parted in the installer):
  #   /dev/nvme0n1p1  1GiB   EFI (vfat)  -> /boot   (unencrypted, needed for systemd-boot)
  #   /dev/nvme0n1p2  rest   LUKS2       -> btrfs with subvolumes (root, nix, home)
  #
  # Formatting (adjust device as needed):
  #   cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
  #   cryptsetup open /dev/nvme0n1p2 luksroot
  #   mkfs.btrfs /dev/mapper/luksroot
  #   mount /dev/mapper/luksroot /mnt
  #   btrfs subvolume create /mnt/nix
  #   btrfs subvolume create /mnt/home
  #   umount /mnt
  # Get UUIDs for this file:
  #   lsblk -o NAME,UUID,FSTYPE
  flake.modules.nixos.nixpad-filesystem = {

    # Modern systemd stage-1 with TPM2-based unlock (recommended — enroll after
    # first boot with: sudo systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p2).
    # Keeps passphrase unlock as fallback, no unencrypted /boot needed.
    boot.initrd.systemd.enable = true;

    boot.initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-uuid/8b0d8b88-c447-45c6-978c-4bcd7c8fb2da";
      # NVMe TRIM support while encrypted
      allowDiscards = true;
    };

    fileSystems."/" = {
      device = luksMapped;
      fsType = "btrfs";
    };

    fileSystems."/nix" = {
      device = luksMapped;
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    fileSystems."/home" = {
      device = luksMapped;
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/FCC5-B5BB";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    # The default swapfile (64G, from `default-settings`) now also
    # lives inside the LUKS volume, which makes hibernate safe.
    swapDevices = [ ];
  };
}

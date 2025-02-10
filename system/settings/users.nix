{
  lib,
  config,
  ...
}:
{
  options = {
    users.enable = lib.mkEnableOption "user config";
  };
  config = lib.mkIf config.users.enable {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.msiwiec = {
      isNormalUser = true;
      description = "msiwiec";
      extraGroups = [
        "wheel"
        "kvm"
        "qemu"
        "libvirtd"
        "networkmanager"
        "i2c"
      ];
    };
  };
}

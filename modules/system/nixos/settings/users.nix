{
  lib,
  config,
  vars,
  ...
}:
{
  options = {
    users.enable = lib.mkEnableOption "user config";
  };
  config = lib.mkIf config.users.enable {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${vars.userName} = {
      isNormalUser = true;
      description = "${vars.userName}";
      # shell = pkgs.nushell;
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

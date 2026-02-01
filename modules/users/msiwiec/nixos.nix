{
  inputs,
  ...
}:
{
  # Extra NixOS configuration for any system msiwiec is a user on
  flake.modules.nixos.msiwiec =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        home-manager
      ];

      # Decrypt the password hash at activation time before user creation
      #  sops.secrets."msiwiec-password".neededForUsers = true;

      users.users.msiwiec = {
        isNormalUser = true;
        description = "Marcin Siwiec";
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "input"
          "networkmanager"
          "kvm"
          "qemu"
          "libvirtd"
          "i2c"
        ];
      };
    };
}

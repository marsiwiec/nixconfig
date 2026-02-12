{
  inputs,
  lib,
  ...
}:
let
  name = "Marcin Siwiec";
  email = "marsiwiec@users.noreply.github.com";
in
{
  # Extra NixOS configuration for any system msiwiec is a user on
  flake.modules.nixos.msiwiec = {
    home-manager.users.msiwiec = {
      imports = [ inputs.self.modules.homeManager.msiwiec ];
    };
    imports = with inputs.self.modules.nixos; [
      bottles
      dank-material-shell
      distrobox
      localsend
      nh
      niri
      R
      rclone
      shell
      sunshine
      thunar
      utils
    ];

    # Decrypt the password hash at activation time before user creation
    #  sops.secrets."msiwiec-password".neededForUsers = true;
    users.users.msiwiec = {
      isNormalUser = true;
      description = name;
      extraGroups = [
        "wheel"
        "networkmanager"
        "kvm"
        "qemu"
        "libvirtd"
        "i2c"
      ];
    };
  };
  flake.modules.homeManager.msiwiec = {
    imports = with inputs.self.modules.homeManager; [
      ai
      chromium
      devenv
      firefox
      git
      helix
      image-editors
      lsp
      media
      nh
      office
      positron
      python
      R
      shell
      shell-utils
      spicetify
      wezterm
    ];

    home = {
      username = lib.mkDefault "msiwiec";
      homeDirectory = lib.mkDefault "/home/msiwiec";
      stateVersion = "24.11";
    };
    programs.zsh.enable = true;

    # Git configuration with user info
    programs.git.settings.user = {
      inherit name email;
    };
  };
  flake.modules.darwin.msiwiec = {
    imports = with inputs.self.modules.darwin; [
      home-manager
    ];
  };
}

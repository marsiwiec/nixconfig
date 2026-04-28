{
  inputs,
  lib,
  ...
}:
let
  name = "Marcin Siwiec";
  git-username = "marsiwiec";
  git-email = "marsiwiec@users.noreply.github.com";
in
{
  flake.modules.nixos.msiwiec = {
    home-manager.users.msiwiec = {
      imports = [ inputs.self.modules.homeManager.msiwiec ];
    };
    imports = with inputs.self.modules.nixos; [
      bitwarden
      bottles
      dank-material-shell
      containers
      flatpak
      localsend
      nh
      niri
      R
      rclone
      shell
      # sunshine
      thunar
      utils
    ];

    sops.secrets.github-token-nix-config = {
      owner = "msiwiec";
      group = "users";
      mode = "0400";
    };
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
      devenv
      firefox
      git
      ghostty
      graphics-software
      helix
      lsp
      media
      nh
      office
      positron
      print3d
      python
      shell
      spicetify
      syncthing
      wezterm
    ];

    home = {
      username = lib.mkDefault "msiwiec";
      homeDirectory = lib.mkDefault "/home/msiwiec";
      stateVersion = "26.05";
    };

    nix.extraOptions = ''
      !include /run/secrets/github-token-nix-config
    '';

    programs.git.settings.user = {
      name = git-username;
      email = git-email;
    };
  };
  flake.modules.darwin.msiwiec = {
    imports = with inputs.self.modules.darwin; [
      home-manager
    ];
  };
}

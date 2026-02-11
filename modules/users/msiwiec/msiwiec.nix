{
  inputs,
  ...
}:
let
  name = "Marcin Siwiec";
  email = "marsiwiec@users.noreply.github.com";
in
{
  # Extra NixOS configuration for any system msiwiec is a user on
  flake.modules = {
    nixos.msiwiec = {
      imports = with inputs.self.modules.nixos; [
        dank-material-shell
        home-manager
        localsend
        nh
        niri
        R
        shell
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
    homeManager.msiwiec =
      { lib, ... }:
      {
        imports = with inputs.self.modules.homeManager; [
          ai
          cli
          dank-material-shell
          devenv
          firefox
          git
          helix
          lsp
          nh
          niri
          niri-keybinds
          niri-window-rules
          office
          python
          R
          shell
          wezterm
        ];

        home-manager.users.msiwiec = {
          imports = [ inputs.self.modules.homeManager.msiwiec ];
        };
        home = {
          username = lib.mkDefault "msiwiec";
          homeDirectory = lib.mkDefault "/home/msiwiec";
        };
        programs.zsh.enable = true;

        # Git configuration with user info
        programs.git.settings.user = {
          inherit name email;
        };
      };
    darwin.msiwiec = {
      imports = with inputs.self.modules.darwin; [
        home-manager
        zsh-shell
      ];

    };
  };
}

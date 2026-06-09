{ inputs, ... }:
{
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];
      environment.systemPackages = with pkgs; [
        sops
        age
      ];
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
        # Use systemd service instead of activation script to ensure secrets are
        # installed after all filesystems are mounted (including /home where the
        # age key is stored). This fixes the issue where /run/secrets directories
        # were only created on nixos-rebuild switch but not on boot.
        useSystemdActivation = true;
        age = {
          keyFile = "/home/msiwiec/.config/sops/age/keys.txt";
        };
      };
    };
}

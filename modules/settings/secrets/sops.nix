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
        age = {
          keyFile = "/home/msiwiec/.config/sops/age/keys.txt";
        };
      };
    };
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/msiwiec/.config/sops/age/keys.txt";
    };
  };
}

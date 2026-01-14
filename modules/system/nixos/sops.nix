{ pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${vars.userName}/.config/sops/age/keys.txt";
    };
  };
}

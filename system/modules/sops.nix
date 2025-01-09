{ ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/.syncthing-secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/msiwiec/.config/sops/age/keys.txt";
    };
  };
}

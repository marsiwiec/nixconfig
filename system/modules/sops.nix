{ ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/.syncthing-secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };
}

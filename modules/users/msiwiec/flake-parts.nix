{
  inputs,
  ...
}:
{
  # Standalone Home-Manager configuration for msiwiec
  # This allows using home-manager independently of NixOS/Darwin

  flake.homeConfigurations = {
    "msiwiec@nixgroot" = inputs.self.lib.mkHomeManager "x86_64-linux" "msiwiec@nixgroot";
    "msiwiec@labnix" = inputs.self.lib.mkHomeManager "x86_64-linux" "msiwiec@labnix";
    "msiwiec@mac" = inputs.self.lib.mkHomeManager "aarch64-darwin" "msiwiec@mac";
  };
}

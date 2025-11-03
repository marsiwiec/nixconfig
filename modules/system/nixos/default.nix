{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.niri.nixosModules.niri
    ../common
    ./apps
    ./desktop
    ./fonts
    ./hardware
    ./settings
    ./sops.nix
    ./gaming.nix
  ];
}

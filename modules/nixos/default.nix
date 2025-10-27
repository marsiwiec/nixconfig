{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.niri.nixosModules.niri

    ./apps
    ./desktop
    ./fonts
    ./hardware
    ./settings
    ./sops.nix
    ./gaming.nix
  ];
}

{
  flake.modules.nixos.keyboard =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        keymapp
      ];
      hardware.keyboard.zsa.enable = true;
    };
}

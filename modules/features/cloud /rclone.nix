{
  flake.modules.nixos.rclone =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ rclone ];
    };
}

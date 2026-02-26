{
  flake.modules.nixos.time = {
    time.timeZone = "Europe/Warsaw";
    services.timesyncd.enable = true;
  };
}

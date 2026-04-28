{
  flake.modules.nixos.nh =
    { config, ... }:
    {
      programs.nh = {
        enable = true;
        flake = "/home/${config.systemConstants.username}/nixconfig";
      };
      environment.shellAliases = {
        update = "nh os switch --ask";
      };
    };
}

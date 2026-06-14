{
  flake.modules.nixos.nh =
    { config, ... }:
    {
      programs.nh = {
        enable = true;
        flake = "/home/${config.systemConstants.username}/nixconfig";
      };
      environment.shellAliases = {
        update = "NH_SHOW_ACTIVATION_LOGS=1 nh os switch --ask";
      };
    };
}
